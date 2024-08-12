Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20103C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 09:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F20D88680;
	Mon, 12 Aug 2024 11:40:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Jcv+YfPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADD588700; Mon, 12 Aug 2024 11:40:04 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C692886BB
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 11:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSNhzf2gTkxfpi7z0MHIztaeiThL1mqyWZUehfapvv51N+9H3g64JPRQPSGKNn7KJzau2Ptr1jDDl9Ke/2D5Iabukly0EfRH4QJMriVv72SKx9Zss12IfLkVBgxnP8nOflb6B09H/FTZHrDmzZuLbh0fVsdZ4xqxCm08I4NE6+k9K9FZ5g6cR6bj7tZiTvZCruZhELTqVEXVs97KoZw4j+cKxMxHSxLJf0V9whWrxiWxvVIWNk7GTtCDwexKq2OaEyjskO9ImHjyRDL4deGJ046E6x05Yx8jyPWa2njUiF/IzTjD+/f+X3CIk6b2PeDEIwmlXESUA1ZUoh0m0+Opvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkXiKhzIcrILNaJ+/IKn38Hqa7JzdHJtuLNQbzuQaBQ=;
 b=T5u0hQCfWVWvUQXzuOkSkO3dgMJziNr808MgT/8sj3rRKnfTxdagR1MxQKfE6/t05tQB0ql0EUS7p8Kjo861ddU86fxi6R8X5GiQdU4Yie9YBTYZ8tIqzvmocA96ZRpPSjz1WqWpQKV8bQG/IPF0p6x1dnAZmh4rn6na0yqSWDad5vpVfeuJORx9a0va/vUu/x4Hs447q6QyHUD6Bu7RFD5wyLYKa3Rq2vXMM9drQOueAe5eLabVEJkQjWuCUnEyOcdiiUHx07Ifa5ZDq1VQ59NSTVDz6J0XdIm3WAfLDXjz84Tu+7QceQ3D4koLB64nHEboujnsAWpnpBB61Mhp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkXiKhzIcrILNaJ+/IKn38Hqa7JzdHJtuLNQbzuQaBQ=;
 b=Jcv+YfPdxmeNNj8wslYDLdG6qDN5b1Mw/Z1Qz3G8IVNN0YfkNAAJ4Okx+XnXfg8btG8Wm8p8rYlrQndBb7/L6hTJWbjaJlgAhS3tlKQKD3/hVnHd6V7AszUthCAjeFOW/uBjKl/b1VEs1MKdMVWagTJrKW4/dvDQU6vddORcPI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PAWPR04MB9815.eurprd04.prod.outlook.com (2603:10a6:102:381::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 09:40:00 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 09:40:00 +0000
Message-ID: <f23d8087-3452-4467-9fa4-3ec60058eb19@cherry.de>
Date: Mon, 12 Aug 2024 11:39:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/15] mmc: Use logging instead of pr_err()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20240811122924.4035982-1-sjg@chromium.org>
 <20240811122924.4035982-8-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240811122924.4035982-8-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::27) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PAWPR04MB9815:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbe6fcd-2dca-43f1-cb17-08dcbab2bbfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUlBUHNtc3ovN0l1Rzk5N1ZVc0Z5STNvdk9TNHRVVjFHcDdkUklYRmR5dWYy?=
 =?utf-8?B?b2NQYjQwdGZqU2xGeEtCZ0dUdUF1cEFNQWdyb1k3MGpBdnJLd213WTFuOS95?=
 =?utf-8?B?RlRvblNpUitwVC9ScGFsV0ZSNGVzd2hYejFuZ3J6aFFXQlhSTHdtY203QVFT?=
 =?utf-8?B?VmJsZmgra0NRbU1hMmZPVGJtRUo0bThCczdqWFdhM1c2WW1hNE05Yy90TTZ5?=
 =?utf-8?B?WXlpdFFIVC9vOFF0Y2d5UmVLdFZuYUEzOFRSNlYzczlkVW4rR0d3TTJmVm5o?=
 =?utf-8?B?a20ydW15RGhYY254SSszQ0J5Yjdac0hSYlhEaGQ5d09FSWMzaEtZWmZwcWQ4?=
 =?utf-8?B?aHBuNi9iNlZjdTNiTTRXaXMwR05oSVpGV0ZYMTN1STZRdGxUaW1qRzlkUXUy?=
 =?utf-8?B?cDZBSDFaeTBDdUlVc2VsUjhSZjFkTFpwTzJKeFpYdWpCYnZPQ0NGMmpEZnl3?=
 =?utf-8?B?aTBIU2c2UVFrWU9WTGxPVHEyQjNSaDZLK0JaWEdNQ0xOMXhtWjJrR29XakRV?=
 =?utf-8?B?N1Y4OFRiMUxIdEQ4YnlGaFdqOFcxUU1VZFhJRkpUTWZROWVpUlZrTy9NaFZv?=
 =?utf-8?B?SVJJM0JwSUw0a0t1dmw4cC9QWTNEV3pDLzl3d3hLMWtHeWdoSW9pRENPTU1w?=
 =?utf-8?B?WExWUGxJd1J1UlNSd2lGZjc5S2NqWFUwQlFETnF5TnpvUHBFbXFST0ZMODV6?=
 =?utf-8?B?L29QZ04rM0dIMFFXKzBSNm1RUnRSUEs2UlBRbVFwcHM2VFZFS0h0MjAvME1N?=
 =?utf-8?B?eGtBb0RybUNScEs3OUErc0tKcUpPa1lWN0h0MDNJN0FXOCtVUEpyU3VKWlYv?=
 =?utf-8?B?enA5NHV5NzNoeFlLMmVTQkdQT3dYQ01FWkZEZWp4Qlp3Uit5WS9sSUdDS3Bx?=
 =?utf-8?B?dkhqUmZmNUx4d0kyZWY5dXdrS1dQblB6VjBzcVl2eTZ3elF2RHYwQitjTE02?=
 =?utf-8?B?N3I2cGR4eFY3cGpWMk5VUFp0ZEZoWnM2V0NaNEdCRjdGZEFxdFJ5NmxqT3JT?=
 =?utf-8?B?dm83emd3amlYVWpuUWlWaWt6S1UyanlkS1diUEZRTkRKZlJYSXNOdStoM3Jt?=
 =?utf-8?B?bHFhdktzMks2aUZWVER0TjNGNDYvc3hWeXJUMTVjb1RUN2MyWkR1ekkvREhM?=
 =?utf-8?B?NS9mdlhLUTdDTmRwd205QVNSMnBLa1ZyRWUyU0hybllBMlgzSCsrcUROelBK?=
 =?utf-8?B?cTJoU1JXZTVlV0FJVDdTVlg5dmpCc0Z2Um94THcxamxOQlJobXNtSG5ZNWZy?=
 =?utf-8?B?bm9IbjFWdXE4clZKK1FZd3k4TUlXSW5uUGJVUFIzbFl5RHl1OXVkcmliMlNF?=
 =?utf-8?B?cVF2ZDd5L3BOOEY4UldRN25iNDNOLzdLampWM3BvQWxIMG9oL3pTTS8zOW9T?=
 =?utf-8?B?WlRZY1VMUXFRNzVUK1pDZ0J4SVN1NHpWclM4aFFBTlpLODJ2TytIVDlxZkFQ?=
 =?utf-8?B?cCtzVGtiM0NsSWJjNmMyVE5qdmpwK1FpNFRRRHFRK1RPcTBYZUlVcCtoL1lT?=
 =?utf-8?B?TUxjZlYyV2ZuZTRuVm1iWHB3RXZzY0hEZ2ZsckNDVEdsZVlzZlpvSWd0SVZw?=
 =?utf-8?B?NWpZMXNFQXlSaXlndExmMEcyeDhXZlBubFk0NkRtU3lpNmZzYmtDUHJEelpr?=
 =?utf-8?B?RDNZZ2M5L2tRWW52ajJOdW1BZjgrNWk4R0VuMWVHV2s2L2xoWkViZ25abnha?=
 =?utf-8?B?RkZMcDZFK3JzbEVkTE1IaXRsOHk5NEdaLzR5UEp0L0duOEdnZldhOVdxYllM?=
 =?utf-8?Q?CIBbqkv9wx+njzRd7XUX79pJJG+BOzK12IZryuJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWFGZkU2TnJNWCtGcUZiQnR6QThqREg3Q1ZNcHd1TVRoTmhKdDdzSE9pQ3lI?=
 =?utf-8?B?OVVTWEtCMDNDVXZIa2NoZ0RNUXFDc05yNWdWUXk1TEJmc0xaWTZmYVBCVVBy?=
 =?utf-8?B?dWFaUE45UFRpcVZMSVhvNWNVSXlFVTJWQkljUVJrNUtJazdJak1LM2xTeThC?=
 =?utf-8?B?eE1UcENkNDd2QjBSbmpybGdzMmtOUmsrMkpPUzJKdVVzdGFSVkNDbUxhTkhH?=
 =?utf-8?B?bEt2aVJ3dDl4U1hCZlg5bWxUaENHNzBSYnpUeCthZ0Z4b0crdWIrUmVzUFE4?=
 =?utf-8?B?NjNIN08rLzZVRUhWWVUyYTRQb2htUHBwVUVkYTN6YjZIamp0YU9MMGx3R2ts?=
 =?utf-8?B?Wnc3Wk1QWjQrdUw4SDdtQng2STFGL3pJWk5iaTJQWGlHM1VFSFRFT3pkakFr?=
 =?utf-8?B?eXMxaDBnNCtBdmhmeXFJVTRYaFdCNU5IVDF3TWdPeEpJdWI0M2dDRU1JVHN1?=
 =?utf-8?B?RG45UFRBYTNNN1luMGtnUzJncmRuem16NHQ5M0p4THRacGtjd0ZLOFp2aHEv?=
 =?utf-8?B?Z0xOOU0vazZ4SHNKdmwrbW5xdmllUkNkZHNDeER5N2xlMnZYTS9TZzFUb3ho?=
 =?utf-8?B?SkduKzFlMEJkRDUwdlpWTWRPeWFCYnpFS0REUnVSL1FteWZHZVJKbHNuRXV3?=
 =?utf-8?B?Smx4T1YxM1YzQUJ5MEFCbmZvK1ZvNjhyNkRmNHZDQnU5d3BEdTN6OFFQN1BD?=
 =?utf-8?B?OUJWNXhoMVg3eW1GY0xrczN6Z2tObFNqb0p6a2ZwWVpSVXlOa29wRWFGL0g5?=
 =?utf-8?B?UnNvNzJtanlJYUhJYWdhNS9SdFBCbElRR3E0OVJFaFBtTmZMWjRSR1QwQUdQ?=
 =?utf-8?B?ci8xOWJoYXR2RWVUaTJtOVFZaE1CSVBBRUcwUUJ2NG14dnAxeno5cFl0aG53?=
 =?utf-8?B?ZkJLd1RORkUzR0tpL0RmM05YeE5pY3d1L3JmMDZkUDZYM0JpS3VQcnYwT1Yr?=
 =?utf-8?B?UHVZdkdFMWtjV2grRGlQdGhrYVlyLzIvTHFhclNHU25qa1ZyWlNpL3hJTGNi?=
 =?utf-8?B?b2thMk9lMUNySlVhRk0zYi8zaVQvYVdCZXlpMW41aUFZajBMM3Rpd1lKa25U?=
 =?utf-8?B?T3NkdW1mcEZDc0dTbDBubUkrOHhIczFqN0kzZndHeFprMnRlc2UzcmV1TTFx?=
 =?utf-8?B?NjBtK0lramlZNEZzeXJrMStFTm16UjVjZlBleVJlM293aDdZSkNkV2JoYnA5?=
 =?utf-8?B?MW9OMFhza2wwbUtvOUNQT0Ntb0loSkxLVW5uNFE5Q2VlblhQMDFHakkyWm9Y?=
 =?utf-8?B?eUhoN3Y0bHFhRlN6cHZPcTU1RVNSQlo3QmJadWgrQ0VjQ1pCaHE3L3pZZXJ4?=
 =?utf-8?B?WHRCQ1dVMmYyaG5qYjFqbjhyZGwvaUFQZDlKT1hZeFJZc21kdis4NG9IeWNp?=
 =?utf-8?B?eWpGajg1N0dyZk1tVVNXY0htMm5KR2tIdkxtb2FpcE80M3NlQU9ka1IxcUdX?=
 =?utf-8?B?NlIzL0FxVU9RU3VmajBaSTJlZ1d5ZTdrakVXditRQW9FbGVRSjNtbGV3Z0hu?=
 =?utf-8?B?M1R1YW9pUnhrNDRFdzRQc2M4NEpmSDFxcm9mVHlXNllKdUoxbitHYTlGalYr?=
 =?utf-8?B?MUNZSkdLTmNCV0dHdVVmTitDT2plYU5ieHJoemJLRkxyajRNTmFJbGZGellz?=
 =?utf-8?B?ZHU2dVhVY2hvWVIwczZmT1RGSnUxbFl0MHZtY2V2Z0J3a3U5djNVZVRuZFZv?=
 =?utf-8?B?cmNpSVBYaHM4dHVvUHA3aHM2emRoeDNOVnZkd1VWV1Exajl2dTVBbk9rdWtN?=
 =?utf-8?B?YWQ3SlRkTjdjUndidVBjS3ltNFc5b2czYUEzNk1sWjR6N0E2UHg5QWdNcFZx?=
 =?utf-8?B?UGI2Q2pnRGxweE1EdWQrNmh4cWhaNllrenhWWE96NzJEWHhKZ0h0RG5hU2FN?=
 =?utf-8?B?NlU0RXAyVmhrNzhGWlZ4RzNqUkFyN3U3M3U2RFpjY1hkZisyalUvUE9ITW5h?=
 =?utf-8?B?R1Y0TVE2MFhKRjlMSWdxRTJrZFJoTGZaaGdSZDdrMlROYWZQYzNGQnEyV0kr?=
 =?utf-8?B?d0dHSFd5ZHZTZEU4emM3aHJIUlpnSUc5anFKbHh6N1gwRExPZWNib1pheWVy?=
 =?utf-8?B?bjdxVlZseXJpTGdncTUwZnJnVlBybUU4MERGNmc5U3ZsR1FkNUxrUDBKaElF?=
 =?utf-8?B?dGpacE9Iek8vRU1WWWJhVmNrMjZtK2FPYzJNK21lWXN6MUc1c0xZWlpCNWJX?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbe6fcd-2dca-43f1-cb17-08dcbab2bbfd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 09:40:00.1718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFHCzKKPXK9cnQOhr770oJbhoEQ1EIp9nw8ABO+TX8jylJiqsWl09sK4QwGeDHhb6tYzVzWlOSvI6UotZDct29y9oQJ5u0Bb0+/4aWlRHno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9815
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

Hi Simon,

On 8/11/24 2:29 PM, Simon Glass wrote:
> Use the log subsystem instead of dev, to avoid including function names
> in the code.
> 
> The CONFIG_LOGF_FUNC option can be used to enable the function name.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
> Changes in v3:
> - Fix 'enver' typo while we are here
> - Put enhanced size back to decimal

Did you? Isn't it still using hex base via %#x printf format?

Since the base is explicit and is what I requested in case we changed 
the printf format from decimal to hex base:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
