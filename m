Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83769C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F5288335;
	Thu,  6 Jun 2024 16:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZKoKnJGV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11E2A88335; Thu,  6 Jun 2024 16:59:55 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81C9881DB
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYSSDDtZEyg0xGpzSWiryKe1qhZm3XcfU2VoZulSKOM3N7tFHrYhTYnoqP/pPDTkuhKOX9OW76+joR+dWcX1JBElNIEn+N5tlwlziLKNWNWRF85S0+ARvaOAQJf0yLV/m5dUGJp76A5H9mhYl2XFL4JdMNUDpzI/I/eUd5r5Wy3lFPALMLQK2pPGGkNsk+tmuZJ6asYwaUQBeQxGtpVFhX11lKXtPB9hoe5bZjSB/w7uQwXG/05SgeyH1r48n7yKcpF9QgB2wl7ABE/9zb9JdIWSlSPYkecX96l7EcQEv8K6CvRWLbLezSgep9VEm8maoaKR2gxu4Yv5FZiFK6GgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EQaXpWJZHlUFVKBtVdVKtyuCmYKX8849yKsrx7xhhs=;
 b=UHZ0tZm1Al9qhXuiOgW4j56n3DnPemDpuX8H9LAbCTxFupgrYVnaRMBxQTiUbiyqqrqMsM9kAu0Xjdac+Irf2i7kxzjkIo+8Q33CCYXqTgMS1QyK5G6abBR8rc3jfh07ZKuPY/7Ng0e8MpaClsiwNdvEusT+KD7KafMZt6F6TUzh97+ENFkVYkPEfJUQADGNkHrrQGN64TGYhQn7Kdvx7wLDu+rhhp+CiF8xfGrAaOa4YaeRW3Y5YdCksq/mnWdku3BkKD5tqbnCjXJE4uR3l1qbP3i9F3wjf7QxoxeCNxUJLTAFItDFOLRzeGvz62wDBX04g9MTtW8qlcZw5SbvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EQaXpWJZHlUFVKBtVdVKtyuCmYKX8849yKsrx7xhhs=;
 b=ZKoKnJGVKOsGZjhUKuUt8aUp2GLzqeuyZr3+Tr1RqfbAvBAOM3ATWLZA2FKrqhgjj+MW2btMhSuZfLLrkmzlZddBfxAlPcer7oesP53DOWJMx8gg5ASnoQi7Ns5RdaVuKqT84Trtu1t/wmkHnwnxDdz72c5bdooR335AulaPvWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PAXPR04MB8688.eurprd04.prod.outlook.com (2603:10a6:102:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 14:59:51 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 14:59:51 +0000
Message-ID: <4240b625-8925-4ea1-ae8c-b1b3c35b87e0@cherry.de>
Date: Thu, 6 Jun 2024 16:59:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Cleanup fit documentation
To: Simon Glass <sjg@chromium.org>, Sam Povilus <sam.povilus@amd.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com
References: <20240604195256.1820285-1-sam.povilus@amd.com>
 <CAFLszTgRAwRrhMQfoUDHg9tGaTf4zLBtHR_QWFQRodh4JyoNJg@mail.gmail.com>
 <CAFLszTgb7ihDDqFOhruwFo9zRN_3ZhQu+PQB+Hn6NGLvoBewiw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgb7ihDDqFOhruwFo9zRN_3ZhQu+PQB+Hn6NGLvoBewiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0125.eurprd09.prod.outlook.com
 (2603:10a6:803:78::48) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PAXPR04MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: c85fe980-b4e6-4f99-48d9-08dc863950e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTVHWUFUYjd2WnVSejNOODhlTS9VZm9mdnZUQnhORFl2MkFTOEkzeHdnMlBC?=
 =?utf-8?B?cXpaUWdlMXZmY3BIdnNSVVEyWGxaak5aS2pubzNmOC9TcisvczVsbzVCOG0w?=
 =?utf-8?B?WTV1SmpScjFBczZGVzhXUllBRkhiWG1mZ2xPOEF0ZVRvYThKTUtxODJ4b0x1?=
 =?utf-8?B?a3ZOOUpHRHVWMCtVWW9sTXdmeGdIZ2RvakxvZEZOUW4zOFlONStZeHR2QXk4?=
 =?utf-8?B?ekFPcVlId044STMvMkpBL29iRHpiOUs4aldLc08yTGVPcDVDeFBuK3BRL3Qw?=
 =?utf-8?B?ZDhuaVI5V2dnQ2JmZkY3T2IxNWk1S2U0S0JpUHp4YVV5RXpxVWZZVHNYQy94?=
 =?utf-8?B?RUFUYzVuRjJmTHZoTEZxWU8yVHBubkVuNDRsN1V3MkF4WC9QQm95QitvNlhn?=
 =?utf-8?B?K2diOUJ3SlMxYjhlSGxPL2xaUmtLUkI1dkVWRGxTQXhiNXByekpiUExyZ3A3?=
 =?utf-8?B?WnhLVjRpdmpmYWUwQXp0U2hLOC9Rc0Zoczl0ekhSRTNyZEVIa2tMYXphUXQ0?=
 =?utf-8?B?Z3JwSWdRaXkxN0ZFWVdGd0N5YVZtbEhDYTJzbE8xNkJpZlA2TTM0dHdFOVE2?=
 =?utf-8?B?K3FETC9yQ0ppVUZ5TTc0bEVkcTVYa2ovVmxMUGNxNENaOVNNVWRmelI1c2Rr?=
 =?utf-8?B?Nmp5U1BiS3UyekFONWM4cTJEZWlXaVRuWnp5YzQraDh5bklPcUNFcVJla3pj?=
 =?utf-8?B?WHVJNmhTRnRwL2pldzNFY084V0ZQQy9BR3JYYXg2a2tCSlppSDkzZVRYaEpJ?=
 =?utf-8?B?SVZCNUthaGVJVFRZZW5laHhmM05LRHBJQ1FjakQrb3hiVkhiSVkxeVdROXZU?=
 =?utf-8?B?VWhodEdmTTBPK2VteDlJQ0gzS0hucC9wQzZHeDZGc3hia0lySnQ0T1ROazl0?=
 =?utf-8?B?aithSDFybjgvbDJqUFhsUTNEUVp1U0tFQkJoWWlINGxLeWg1UVFxeFpZS0pv?=
 =?utf-8?B?VVRBMXZ0LzJhalJGR0dOMkVuZG9EQnJaTll4ckdrK1ZyWG5ncW1iek1ucEdK?=
 =?utf-8?B?U0svUFp6QUVsQ1pIZjFndHFFWW4zTjR2VXE3RFI0dXNNZjFPZHNJalFxQWpQ?=
 =?utf-8?B?cWFXdEcwTWlyaFBqdzc4M0JTT2dJKzg3ZjJ5dlBjODRVcXExRWU1LyttZFFT?=
 =?utf-8?B?Y08xdkJlWGwzYTJ0M0M1d3AwaHdCeFp2VmZuSDZDV1VnZWtCMnhWaXRGSVpD?=
 =?utf-8?B?WFlEUkI4ZGtLV3F3ZW0xblZDdUJUWElha20wUldUUWw1OG90TERDaDc2UHZN?=
 =?utf-8?B?OHB5ZHhldFY0YjIxSGtOcXZKcEdOc0ZobEFxNitqa0E5dDBhN2doSTJoYXNq?=
 =?utf-8?B?N3J0bFlyeE0xblBPU25pUVIvRGxZbHFXRTROUjVsc2lPNlJDT0VoNHgrTjhO?=
 =?utf-8?B?OXRuQWpDbVY0NXlPZENhek9lNTVrRUlweVA2ZjN4RVhmZG03eGZTZDE3Wngw?=
 =?utf-8?B?VWZiQm9UaFdySXFiTnlQQVlWd3g3Tjg5ZXFYQUcvSHhPb3dFSGlnSUF6Ymhk?=
 =?utf-8?B?Z0FXZEwxVXZVTk1FcGVvcFpBdndhenJMb0pCYzFaWG0wazI3djBWallIcmFk?=
 =?utf-8?B?Q1djOE4yU0NTTmFnVnIrKzlzMms2RGloei9VSGo1SUJLTTBDdXA3L1N6R3lB?=
 =?utf-8?B?dmdQYzljNnNQMkthbFlwR2N3NG9GV2VHaTNXRnUvWE01RXp5N3U5bWduZzlx?=
 =?utf-8?Q?lmjwU747BTsrnL9fft5o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVViNmlubnQvYU1mSmxGL1djKzVuVnNiQ2NkM2toQkdvbmxnbDFtLzdyb05O?=
 =?utf-8?B?Rjh2dU1GVFRPY3Y1dm0yVTFsQUxvc0hDMy9UTUdtYzd1NWhGVk5GbXdBNVBD?=
 =?utf-8?B?bkpwZkdlK2JuSSt0YmJtanpZOGZPNXJFdkFYNm1Yek5uYWdJeGRxUUNmU2cr?=
 =?utf-8?B?YUFZbkRDb2h0eGtqNjA0bUZ5Zm1hSzk2bE55Q2djRWtGY0RuS1BjSEx6N1p6?=
 =?utf-8?B?RU5UT0JNRFVHTWN4OVJFcndYTjUxTnhQMWQ3ZjJTV2NyMytJUEJVYUVab3gz?=
 =?utf-8?B?OXdWQ0N1b21waHBUdCthNDNGNmhkOHY0aHhPUHk3d2tacDk5ckthSGFWMzVj?=
 =?utf-8?B?WkVpdERwMGV1bnhRKytnSjNDSjRSN0NqNkFDRFhzcEZtVUk5dVVZdC9iY3NU?=
 =?utf-8?B?R29Kc0VraWF6V1dpbXNUWU5oM2pwTlNuUkhWQjUxN2dzVWpWNktwMHl4Ukc5?=
 =?utf-8?B?d1F6cE5XQW9IdGg0UzRIRlBkYkdqbm52TXoxclQvTEZiVDYxYU1MMTVlN1pQ?=
 =?utf-8?B?Mi90SkpqUlpwYUtSWWZFMy9jbVBZemJ5NE1lVXVDSEM2ZGNBbXZVOTZ4SkxS?=
 =?utf-8?B?OW9IdTlPVC9xeVpNNTkrWkxqbHc5VmtVYzNvaEd6Ukw0QmQ0Q2ZRL1ZMZXYz?=
 =?utf-8?B?UU5XekVRd3JqbjEyVFE5MldxOE1tcGNCVEJSMndzK2kzM0tncDlDeUUrOVha?=
 =?utf-8?B?QXR6bW1zNmdmdUJZOExKKzRPYXBBbXArTDRmT0JONzVUTlFCQUYvRkVjSVlR?=
 =?utf-8?B?alBlSGJiUEN5bWRUWkhERXRLdm5hYjdQQmlMNFFRcE43dnExKzBrQ05PaGxj?=
 =?utf-8?B?WWFqYjI5a201b2V3K2JZUTRDQkhFUmtsN3dyN08xclJXcXV0RXlnWGxCdkdZ?=
 =?utf-8?B?RnZFZElqamswY2JqcEhtMW9lNDl4MDhyd3RseHNCekJWQ1BBT0UxT2xOeWlM?=
 =?utf-8?B?Sm5LUzRzZGdmVFp5NURFZTRucC95N0VwVmxDdTdUOTdEMEsxSkgxNDVwRVpl?=
 =?utf-8?B?UGtJUW5kbG4wSTROa2tMcDZZcFBCeEYvdVNpNlZOaUNMWWtEQ1Y0bGd2V0o1?=
 =?utf-8?B?OUhuRHYwYmJJMENWcE4wUHNXQ3psaXpxejNnaUIyM2JnbVEyTzVPUzh3MjRH?=
 =?utf-8?B?OEI5VlhrQWM1Wm9xZ0pZSUNvV1BFTmVjSHRXOUR5UURJTTRoWXhBWHExU251?=
 =?utf-8?B?VFo0NTNocVVhcXBIL3hXN2w4eFBEOGk5ZC9oN2dVazlXK3VXV2duOWJqanZa?=
 =?utf-8?B?dGVQL0t0ZlIyN2U3VmJMVk1rNnRveXdKQ2M0cDl0UGliUU52MmhBVTZTRUw3?=
 =?utf-8?B?TkV4VWFNakdqYUFacnJoNXBueStHRS9ZMlFRczFXUmdaK01LRGZ2YXFTTm8z?=
 =?utf-8?B?VzI4R0l3RWY5MnVmWm9KUURBR2RPV1REYkFWTTF1V2kwNU9UUmYrYU9kRm1H?=
 =?utf-8?B?Mk5kYzNTYmxYVkg3RGMwOEt1T2FXbDVJMnJrQThkLy9RVEwvS3ZUalhIQVFv?=
 =?utf-8?B?SmN5Y0hnMm1FTXJ5Yko5eGZKaWtNM0RFUEN2ZWpCZEkvM3I1WWR3VDdweVpr?=
 =?utf-8?B?d2tSQmxFcklwbEVlKyt1VDA1czRaM2FEejQ4TE1RU1VIeFhVQTdiS2tkU3RR?=
 =?utf-8?B?ZFF4SXNTeTJMSDlaaS9SQXo5RWtDdXZFSE9PdHFXOEhkU3NxYmc2VDZvd1NT?=
 =?utf-8?B?YWVwNldkUktFWFhycERmMVM0MXRpd0dwd20yYkVGUDB3UlNiWWhQaitJTXZn?=
 =?utf-8?B?VWhTMnRIZjRURjgzcjZqSGNHLzJLVWZaYm4veWNYNUxlMmN2emt1Q3BrZXRM?=
 =?utf-8?B?a0hidEtuUEFIMVgyMlk4WUdpQUMyVnRmbkhyS0MyOXNidk5rWnpLanNIc0I3?=
 =?utf-8?B?NHl6NFdmYS85UVpzVUxOQnh1MTk1dXVzTUF1L0xvNG9ZNjRmUml5MUxENC9X?=
 =?utf-8?B?a2x0bFlUbTh4NVlwM1EraFRsSUszK2NYbHM5TkVmck1hTWFFOU0yR2RSTVdw?=
 =?utf-8?B?WVFZZ2x3dHlnUkh6SFlLWlFVMEdQZ1Y3NnhQMmVzdU51ZFBwNFZrSzFYQmJG?=
 =?utf-8?B?OXltYzd0eUZjY2FzcnBZS2dIMkhMQmlwT0hHOXh6ZWJFeE1DdC9hbmg1NWFL?=
 =?utf-8?B?SzFrdzZUQnUvSTVXUC81SlV1cTZNZzJXM1c5MWp6MEZLb01EWkVUaS9TSUxJ?=
 =?utf-8?Q?Kc+X8ozfe5xV+zZB0Yu8tdo=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c85fe980-b4e6-4f99-48d9-08dc863950e4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:59:50.9528 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrBP0Sd0igzeHr4sxZ2EEqvFvmyjptV9vT5JfjVMeup5Vql7RIc0qb4rOLLOJNnqoAcwpqm57D2qyxlQHYK29pNXZdX9w7S8TDLXZ3xwdm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8688
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

On 6/5/24 5:52 PM, Simon Glass wrote:
> Hi Sam,
> 
> On Tue, 4 Jun 2024 at 20:13, Simon Glass <sjg@chromium.org> wrote:
>>
>> Hi Sam,
>>
>> On Tue, 4 Jun 2024 at 13:53, Sam Povilus <sam.povilus@amd.com> wrote:
>>>
>>> Sam Povilus (2):
>>>    doc: Remove extraneous curly braces
>>>    doc: add clarity to what a "fpga" image is
>>>
>>>   doc/usage/fit/source_file_format.rst | 28 ++++++++++++++--------------
>>>   1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> This is now at [1]. Could you please instead do a PR for that?
>>
>> I am not sure yet the best way to incorporate or link the FIT spec
>> from the U-Boot documentation. I suppose we could employ a script to
>> sync it?
> 

One can reference links from another Sphinx project thanks to 
intersphinx_mapping, c.f. 
https://git.yoctoproject.org/yocto-docs/tree/documentation/conf.py#n114 
and 
https://git.yoctoproject.org/yocto-docs/tree/documentation/migration-guides/release-notes-5.0.rst#n196.

It requires the objects.inv file to be available, which seems to be the 
case.

Hope this helps,
Cheers,
Quentin
