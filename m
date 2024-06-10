Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B8EC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 14:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3217F8841D;
	Mon, 10 Jun 2024 16:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BE6BskLN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4494E88546; Mon, 10 Jun 2024 16:16:46 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0023883DA
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJFmeLzjeXDfVt4RKDM6+vqtYko82TiFT4u+LbI7tPasOx84XavfSc5/QB76zrs9KdOw0hze8SpmjXxP6AQ4JEFTcx4pdPIpkiKQNBMwmvytT6AgXZhO35Wf8CHikJAuwKx3jG2V/Js6orbjeZ/EJkKhR2pKVqEfLqv4imPNGtm7f26HglVZqJyeMV4QUc3TYQGvXZnvhqNf/UdrQZHi2gFX4/IU/cN76Zj6l1YoPJAW9DcvTSCX+uDU29gaxgOvAdbpXhoNLibg8RmnR2n6iFVLg2opdkt9YEg7ks2AB7P5CzmJZesX0QQLslZdVGDE/JM+2/Ca8W0Ram1hz3XLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+JkHGZ5DgK4dmCTG6iq4jqKzgiWnmk7JKkwGBzMXxc=;
 b=TrX5PYFvE7SHdJ+dNpw++e2cG7WvdJNsIGejS6stPXMhwPkLaC5Pag47R1fOjKOHuYq39QcIJUWgfd9yiDiN9T31cavP1yEvxVAf5W6ATOORe3hltieqkvXYsO5DxVmbCcj9NNKfU1yAPAxLynm41yS7p5ab6fQnLNMquP2Jnugbd6IUJzBQ40RcccJEl7Yt4fEYaXl2lHxsNGQEgIVkIGRIecWMLe8eyJ9/yJ3475AJlYTeD8m6oEJcla2rvKZapdd+zoQ4kI+3AFkmNZqK3cueBzZC4+JocB59/MMdrusXHdgo+BgcufTovUBawuZ6UpIhCbfDtyeMWhWx3jaxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+JkHGZ5DgK4dmCTG6iq4jqKzgiWnmk7JKkwGBzMXxc=;
 b=BE6BskLNQjhq9ibc2oJApa5RALckAi29HeXsKCQ+ZIWkADdGvKOze/L0Gr8aMAdodp8ugqTXBVsvpZIN5N+6v4ZuGIXh/UBbg6ExJnYRb1UfcaPMlSAm4NlS7CVWd8Me44VPI0/Z7/6sRJf1UmjE3H9C4zxKgy8j2BOsaONP4s8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS8PR04MB8293.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 14:16:40 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 14:16:39 +0000
Message-ID: <b878a6df-e095-416d-9874-c1deaffe4a58@cherry.de>
Date: Mon, 10 Jun 2024 16:16:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/14] firmware: scmi: use a protocol's own channel if
 assigned
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, trini@konsulko.com,
 sjg@chromium.org
Cc: etienne.carriere@st.com, u-boot@lists.denx.de,
 Etienne Carriere <etienne.carriere@foss.st.com>
References: <20231011100707.1007417-1-takahiro.akashi@linaro.org>
 <20231011100707.1007417-3-takahiro.akashi@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20231011100707.1007417-3-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::27) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS8PR04MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d97d7c-59f6-4603-b7f8-08dc8957f209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHhvZkd0QkFrbCtxRUUra08vbEZOQzRVRDY4OEZGR1NMa2xiWmgrbHNyYTBM?=
 =?utf-8?B?b0tkZXpEeWk4bEhibm9jbDlZT1pLZkwxakIyRWYxUWNNaDg3R3c2Q2NQWEZL?=
 =?utf-8?B?OEtwOVVkL3FLNk8vQXZkZGgvZWhoZkpBVHowVHBSMTF2NTVMTnVqMU01ei9O?=
 =?utf-8?B?U1N5ZmFtSTJrREdXTnk1QkVLaVZoMVpEQ1VmeU9ETXRMSWR3clNpMTUvU1Mz?=
 =?utf-8?B?ZkYxMERIM3hjVWpzcHpOc0hyZHVvWTRZOG9wODlhNkQrWER4Ny9aNnZNY1Vu?=
 =?utf-8?B?TnJuQmdobEhEUzIveEptamlRdHY5Q214cWVvc0p6NHppenJZdFpKRUlhL1FO?=
 =?utf-8?B?T29LMm9hME5jVS9xL1NPbE5SM0lXZ3lFM3gzUW05TnNyZllYcHdRTjVkaytK?=
 =?utf-8?B?WExrUy81SUlScnJsMTg2UWJJTjFiWHFaaktEbEFJNFNUMFdEQ0I5VThVbU1S?=
 =?utf-8?B?bEsvdzI1eW8xSXNCTXExVGlzUVc3eVlYa1phM0hsZXZmYjlDN041NzZ2blNk?=
 =?utf-8?B?NlZ0bHlnTHVISC9sNUVDR0g1L0tTOGVpOVN5ZklKc3B1ZWIxdWpOU1FzOFlr?=
 =?utf-8?B?UFV4V0V1Z0xVb1FYRkpxT3BkbnFyV0dIVmpwYjk5QytYNzBsOWpyb3VySStr?=
 =?utf-8?B?cnp4cTJETGptRWNsakI0NWdqMWwwTUNjdmxFREhQZzU0czBrTFJJZERXbXpD?=
 =?utf-8?B?azMxcEVPWndGOGhlRkJldkIzUUJ3bGdRZHVsRmpzUlFuVm95K0dVWCtnVHRB?=
 =?utf-8?B?aVVtdEVZOTYxZ2w1WlVNazJBWEp0eml1aEp2bDYvYkNiQ28zalBGaHJNUUtv?=
 =?utf-8?B?bXV1dUFoWk51a1hZcWlkMXVNZkFxQk9BcmNoM01GeHVWRmxkcGFiLzVqQjRI?=
 =?utf-8?B?WWs5WW92aHQ3WXliWUE4aEpjQXFXS1BrejJ5ZTlheHBYaHZiOFRGcGxPYkVO?=
 =?utf-8?B?Mmp6ZlRpN2tHOFRZNHNxTFkzdTN3MGJhRTk4OFo1eEIwMEJMdzJmUkpKNUJo?=
 =?utf-8?B?WWV1TytRU3g0bGpwdXQyb0NCdStDWlVXVkpzSk5kNEo1b3luTmR6bVNCNU5D?=
 =?utf-8?B?NzBtM3pFYldMN08yaVNnT1ZteU5oVjFvYVdBakc3LzFyQXFMenlCQTlDMjdJ?=
 =?utf-8?B?YmZLWXhNWjdPKzZnb1ZJYWJBLytGTE5oVDJOL0xGOHl4ZGl0OGZSZDJWdW05?=
 =?utf-8?B?WG9JT3dmaGwwTk4xU1Y4Y1d6eFBzcDB1VkZGbGp0NkI4OFR0Q1h6Y2NwblEw?=
 =?utf-8?B?Wk91ckxRcGk0Lzh6LzhKbk1JSGpZbzV0YlZRaW1ZcFdDYXVUUU5HVUJnZ3k4?=
 =?utf-8?B?azJKbGt4Uno5cC82VEE2bWM4bkt3MlowUllqQ1hUVWtXSm0xR0NzT0Z6QkpY?=
 =?utf-8?B?TThmbXN1MjNQYy9DVi9BUTBEUlN0VldPVmhqRTQ5RFd4YXhReFo4bThMQzZh?=
 =?utf-8?B?b2N4TWNxMkF1VTFhL0g3QlN3QnJhaUZiZ3FDbHN0aFhRMzVSR0hHeVJqSHZq?=
 =?utf-8?B?NmZrSUN3SDNraEtpN0tkeDg1ZS82ZGFWdGgwTHQ2SUp1ZURzT1pyTFdrVVNN?=
 =?utf-8?B?eVl2MjZuVTdjMjVwWDMxNWVqdWs0L2lSdU9pRGhhY2VRWjdKOTRlWVg2Zk5X?=
 =?utf-8?B?S2d3QUlIWURENDBxRVFJNmdaOUlyb1JMR2prU2p1QWd3TjlyZEU4QmppMHU2?=
 =?utf-8?Q?habJOVCu3aqmnlxWNlVO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGRZSHlWcmNrWmV5Z0pZMWYxRWJtbExwZkMzNDdBRDlPeFBxb1NYVStXYzAw?=
 =?utf-8?B?ZFNtNDZBTEQ0c1Y4NXk0OGp6eXlkTi9wd1JJL1FPcXA1VjRWNG0yVEE5aTNI?=
 =?utf-8?B?SFlKMVJSemFFVnluRFdVTTRTa0k1MldNOVNqZ1p1S0xsN09CS0t4TWlwMTU2?=
 =?utf-8?B?YmxrWG4xUkVhZ04vTG9rUmx5R0J0NGE5VlUzUXcyenZXM3dkd3orbnR4eHFB?=
 =?utf-8?B?YTFyRzZ0WkM5Z3lnaDluTENpZHJqT1dKcVBNaXZNUjFpSWdYZnpPRHNySGdF?=
 =?utf-8?B?SnRwYkN3VDljSFdiV1VKc0F0ZUR4REdybTdRSGJCWlp0RFJXa3ROZnRJTHZo?=
 =?utf-8?B?TEVDa0VMdGtGV1gra05CbVdGNmI4QkIvMEJjRFdoTUlBdE5idm9YL2VjR0xa?=
 =?utf-8?B?d05oRGw4TzI4c2ZxMEx0WFQ1cnM4aGxncCtXMDVkUi9oaGNWTFBiVUVmWDNK?=
 =?utf-8?B?ZmU3UlZmeHczT1hIK2dldkJMaFlocjZud2ViUDhtTjVNNzR5WkZKeXhFMk45?=
 =?utf-8?B?WlFjSmQ5UC9BdWlZd25CK3BWL0FmT2g0SHF2dDRSRXVxWG1KLytNNzI1VkxN?=
 =?utf-8?B?MmUyaHJkWDVnZ01DSTRxUFFHNnVrMms2bEVqMzJxVjlVSEVDWnA0L3RHei9C?=
 =?utf-8?B?ZjBwaUZxWko4QldmMUg2Y0VLRjc5Wm5Iczg3a21tVEY1SlBGbWtUNk85Y0Fo?=
 =?utf-8?B?VkZ4dW1CbHRScHk1RlhTc1VJRDJvVFUwWVU2MCtCTGtYS2dOVmR1SzE3clZq?=
 =?utf-8?B?ekRBMDJ1VmRNekkvckRsSmxpRHg3czYxcG5XS3JRZFZCdVZydGFCSE1oV21u?=
 =?utf-8?B?eG9tRTIwTE9LUWdpOHNZL3NzUjFLY29KekZmTTFrYW50dm9VSFYraFJ4U1hu?=
 =?utf-8?B?RHhYbWR5amlBNXV0ZjdndXFVSnM5dTN5S3J2T2p0MUhhV3Q1MWs2QmVnQWgv?=
 =?utf-8?B?YXB5Q0N0VklUVDhZSmNsTGd1NE1ZWk1JaFcvLzN3UUpIQ0JZeERWZ1dxc0hk?=
 =?utf-8?B?QmlOc3MxMzI2akZXbEYwcXNkd3QzckEvd0xrOFNWdk00OERkNHVBK3NNSWY5?=
 =?utf-8?B?NFRjZmI3c3pibmtyamVpWXZSajhCcFcvUHZ4eTNJaDdrUUNoZ1VpOXIzanpR?=
 =?utf-8?B?Si9Od0FXRmI1d2t5VStLd0NhR3ArbDhwYjFWT2VEVVpEbngwQytlNlJiakll?=
 =?utf-8?B?MkFyYjl6TS9BTG9ZZmNYRVBtbnBkMjhoczJzT2dYZXpzNkg1a2JCempJeUxT?=
 =?utf-8?B?VjU4bVlacHozU2xoZDFoR1FZSlhTWUVJSWlic3YvYTRSRVJaQ1JhM3FrWmhw?=
 =?utf-8?B?cXJKUkJUS3lwd0VaMzNBZ1g3WWI0SFhwWUpCYnNLbU5LanZhZW1ac3BxMnVi?=
 =?utf-8?B?QUFpZ1VkSnlibldMRzRZdnZ0aE9ybXNnVStmdHlpcy9oSDBrQzhVTEVTMllL?=
 =?utf-8?B?RXlVVy9uYTlEWlhBZWl2eG9ZLzhzMWZPWFZUallnWThTeVQzMys5dkxXdGZq?=
 =?utf-8?B?VGtta3VOeWR0RitVMFgrM2kxYXFZU3dyTVMzQStwei9ONDRxdVdXdkpnb0Fx?=
 =?utf-8?B?Q1d4UXJTVHZ0OUFtWXZPb0lsSzRoNSt2NVVWZU03OHZValVuOTV0Tm1JMGxG?=
 =?utf-8?B?cUI0ZVBqOHN0VUpiaWVMMHJ2a3hyaGcrVE5kbzJvRW9nV2h3NU1laUpjQmcz?=
 =?utf-8?B?OXZHSW1tYUVzY2RKWkpiSEVQV2RFYnVqMjlVbkp0QmFRQ3RvMHlEMms1OE0v?=
 =?utf-8?B?ckFYU3ptb29JUWozWWQ0bkp1MkxCcGJRU0tkbkwrV08rZmR6OXVJVnJoenJQ?=
 =?utf-8?B?MmtaZ2JRNHRkTWE3RDlNY1B5anFWOFVrOUxiOEhhL1h6TzdnYWFHOHhLSjhl?=
 =?utf-8?B?R1EzMmdMRWlDdXZLK1l3Z2RITnBLZkNrOHZiOGpvTHJIZng3NXlDOEcrSWdN?=
 =?utf-8?B?MnhMUGRWVlpUYVhQdmNLRi9GQmxVb2FNdzhITlArelYrSFg0NkJOd3JjeWgv?=
 =?utf-8?B?K25HV04wMnY0UHZqMjhGRmdsbEx0V2FDTG81S3RYRmlXbDlJS3g2Mng3elo1?=
 =?utf-8?B?Qy9iVjlwNDlIWUplRmw4bWF4NmxGYTI3cUhiZ2hoTXpYRllsWkpIL014bG03?=
 =?utf-8?B?aTI3dnVaUTYyRnd5V3c5cTBLZkxCTXpwUDRlaG9PNVpHakl3YWpEUkJUSUdu?=
 =?utf-8?Q?oC/fNhuae60EAoeq9W4SH3g=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d97d7c-59f6-4603-b7f8-08dc8957f209
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 14:16:39.7499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vq3Q/QKIT6JcokUAWLb2lQZOiWwjOHbWBIwYFTYilDaG1phN2qIurwZ8vQ3r1IKHgB02VW2S5IRu1BytpcjHol/+UoQGLT1/tats1N/5xSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8293
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 10/11/23 12:06 PM, AKASHI Takahiro wrote:
> SCMI specification allows any protocol to have its own channel for
> the transport. While the current SCMI driver may assign its channel
> from a device tree, the core function, devm_scmi_process_msg(), doesn't
> use a protocol's channel, but always use an agent's channel.
> 
> With this commit, devm_scmi_process_msg() tries to find and use
> a protocol's channel. If it doesn't exist, use an agent's.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
> v5
> * new commit (fixing a potential bug)
> ---
>   drivers/firmware/scmi/mailbox_agent.c     | 5 +++--
>   drivers/firmware/scmi/optee_agent.c       | 5 +++--
>   drivers/firmware/scmi/scmi_agent-uclass.c | 7 ++++---
>   drivers/firmware/scmi/smccc_agent.c       | 5 +++--
>   include/scmi_agent-uclass.h               | 8 +++++---
>   5 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/firmware/scmi/mailbox_agent.c b/drivers/firmware/scmi/mailbox_agent.c
> index 8277c1860606..7ad3e8da9f08 100644
> --- a/drivers/firmware/scmi/mailbox_agent.c
> +++ b/drivers/firmware/scmi/mailbox_agent.c
> @@ -94,13 +94,14 @@ static int setup_channel(struct udevice *dev, struct scmi_mbox_channel *chan)
>   }
>   
>   static int scmi_mbox_get_channel(struct udevice *dev,
> +				 struct udevice *protocol,
>   				 struct scmi_channel **channel)
>   {
>   	struct scmi_mbox_channel *base_chan = dev_get_plat(dev);
>   	struct scmi_mbox_channel *chan;
>   	int ret;
>   
> -	if (!dev_read_prop(dev, "shmem", NULL)) {
> +	if (!dev_read_prop(protocol, "shmem", NULL)) {
>   		/* Uses agent base channel */
>   		*channel = container_of(base_chan, struct scmi_channel, ref);
>   
> @@ -112,7 +113,7 @@ static int scmi_mbox_get_channel(struct udevice *dev,
>   		return -ENOMEM;
>   
>   	/* Setup a dedicated channel for the protocol */
> -	ret = setup_channel(dev, chan);
> +	ret = setup_channel(protocol, chan);
>   	if (ret) {
>   		free(chan);
>   		return ret;
> diff --git a/drivers/firmware/scmi/optee_agent.c b/drivers/firmware/scmi/optee_agent.c
> index db927fb21405..e3e462774045 100644
> --- a/drivers/firmware/scmi/optee_agent.c
> +++ b/drivers/firmware/scmi/optee_agent.c
> @@ -324,6 +324,7 @@ static int setup_channel(struct udevice *dev, struct scmi_optee_channel *chan)
>   }
>   
>   static int scmi_optee_get_channel(struct udevice *dev,
> +				  struct udevice *protocol,
>   				  struct scmi_channel **channel)
>   {
>   	struct scmi_optee_channel *base_chan = dev_get_plat(dev);
> @@ -331,7 +332,7 @@ static int scmi_optee_get_channel(struct udevice *dev,
>   	u32 channel_id;
>   	int ret;
>   
> -	if (dev_read_u32(dev, "linaro,optee-channel-id", &channel_id)) {
> +	if (dev_read_u32(protocol, "linaro,optee-channel-id", &channel_id)) {
>   		/* Uses agent base channel */
>   		*channel = container_of(base_chan, struct scmi_channel, ref);
>   
> @@ -343,7 +344,7 @@ static int scmi_optee_get_channel(struct udevice *dev,
>   	if (!chan)
>   		return -ENOMEM;
>   
> -	ret = setup_channel(dev, chan);
> +	ret = setup_channel(protocol, chan);
>   	if (ret) {
>   		free(chan);
>   		return ret;
> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
> index ec58ccd2bc5d..a28692f39f4d 100644
> --- a/drivers/firmware/scmi/scmi_agent-uclass.c
> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
> @@ -144,13 +144,14 @@ static const struct scmi_agent_ops *transport_dev_ops(struct udevice *dev)
>    * On return, @channel will be set.
>    * Return	0 on success and a negative errno on failure
>    */
> -static int scmi_of_get_channel(struct udevice *dev, struct scmi_channel **channel)
> +static int scmi_of_get_channel(struct udevice *dev, struct udevice *protocol,
> +			       struct scmi_channel **channel)
>   {
>   	const struct scmi_agent_ops *ops;
>   
>   	ops = transport_dev_ops(dev);
>   	if (ops->of_get_channel)
> -		return ops->of_get_channel(dev, channel);
> +		return ops->of_get_channel(dev, protocol, channel);
>   	else
>   		return -EPROTONOSUPPORT;
>   }
> @@ -166,7 +167,7 @@ int devm_scmi_of_get_channel(struct udevice *dev)
>   		return -ENODEV;
>   
>   	priv = dev_get_parent_priv(protocol);
> -	ret = scmi_of_get_channel(protocol->parent, &priv->channel);
> +	ret = scmi_of_get_channel(protocol->parent, protocol, &priv->channel);
>   	if (ret == -EPROTONOSUPPORT) {
>   		/* Drivers without a get_channel operator don't need a channel ref */
>   		priv->channel = NULL;
> diff --git a/drivers/firmware/scmi/smccc_agent.c b/drivers/firmware/scmi/smccc_agent.c
> index 6a52cd75d67b..972c6addde21 100644
> --- a/drivers/firmware/scmi/smccc_agent.c
> +++ b/drivers/firmware/scmi/smccc_agent.c
> @@ -81,6 +81,7 @@ static int setup_channel(struct udevice *dev, struct scmi_smccc_channel *chan)
>   }
>   
>   static int scmi_smccc_get_channel(struct udevice *dev,
> +				  struct udevice *protocol,
>   				  struct scmi_channel **channel)
>   {
>   	struct scmi_smccc_channel *base_chan = dev_get_plat(dev);
> @@ -88,7 +89,7 @@ static int scmi_smccc_get_channel(struct udevice *dev,
>   	u32 func_id;
>   	int ret;
>   
> -	if (dev_read_u32(dev, "arm,smc-id", &func_id)) {
> +	if (dev_read_u32(protocol, "arm,smc-id", &func_id)) {

This seems to trigger the assert in 
https://elixir.bootlin.com/u-boot/latest/source/drivers/core/ofnode.c#L393 
when building with DM_DEBUG=y on my RK3588 board, making it fail to boot 
into U-Boot CLI:

"""
    - found match at driver 'scmi-over-smccc' for 'arm,scmi-smc'
ofnode_read_u32_index: arm,smc-id: 0x82000010 (2181038096)
drivers/core/ofnode.c:393: ofnode_read_u32_index: Assertion 
`ofnode_valid(node)' failed.
resetting ...
"""

Not sure what we should be doing here?

Cheers,
Quentin
