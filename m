Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196D9C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 14:30:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E76F406E2;
	Tue,  4 Aug 2026 14:29:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ceXnEbYIUCJi; Tue,  4 Aug 2026 14:29:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1776840632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785853797;
	bh=Sow6gIAKgrc5xNfbY2ifs9EQx3r4RrUSsPkk0yaNumI=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oHwJ8leKFB82MFYf+KOec9xkMZcK6A20rIAGjK57Zay/YDcvVX/1MLE5CFrvSdlyN
	 yisGMdqjhNcYimj3qm80SDrXNiM7zPuBfAKMLiIgsnFi8UvTj3qHcPUHroEW4OiVV+
	 zQbHMkHml5wIAvGIYmF21aD1Hh4O0ZDcVBfbd3W1FKTpY4v9oQkZ8snbbx9Debd8cO
	 N4lDn728t7FP0bh/QzwyKeRUQ0fxbQheFnHLfC3aNVdHyUEwU62w6KePvSn/jWO7vL
	 cthudjrLnITB84JAlf+348OOXyta1cPXg3axKLK+2i+VT3UzH8sfzCYFWT2wkryKlM
	 WjRWCSjVA02WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1776840632;
	Tue,  4 Aug 2026 14:29:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30D15296
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:29:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 16CF240632
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:29:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbMYkxSADwW4 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 14:29:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c20a::;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 337C7405FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 337C7405FA
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 337C7405FA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 14:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFmt5DMabo1f3He1pLQFVNHa+0NR1KQM1gcqiLiONOGes6x2leJ0pqXHNlIzK0m9I53mSYGGtl3OsWhrysz3uO+/1iS42PUEF1mPxXeIvlHT1NGz7AMl/N+ZP1tUyMo0uSbQ0i5eS94XI+sA29JfPLodLNDd9HARXKaiBendCA5mESoVam1ka9rgMqUGmHINkebqgab6ossX0H7t6tBOAH23woHP9EZ6ZA6juPQuHVw5nTgmTMBR7awvNUwwZwGy7Bet2vJZEq0IaNqMLAx7Pf4jQBt2I7GvJ1EH7UYL0PH8DISVgkd2tNCOdMsKRJDM+HZynWq7djTIr0WWiVBeEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sow6gIAKgrc5xNfbY2ifs9EQx3r4RrUSsPkk0yaNumI=;
 b=WSRFrJXzefvrp1fXZNeb3IcDV8dkgKXOhr8HjhJPGuft4HQmqMNzxFAWVVLQLFHoveYo/WnWp9Qf3jbRtbhaP8JtG3GXe0bAnU46IkjUUWykTVXZXzl+pnqdutPSl7pXP+XHEHUWM7iL0drq5lcFI5wuAvZ6x7R0DjefptVs1mvPSzwwyPZYR+g99y9VKeYVyowoOLNWvKXgi+LQP6tWj0tSEGoWvPXoqNYakx8wbLqKjAL5/0HmKEjUHCAa4LSz+Z7fw9idd/hcnBO/RKal1+Aald1udqhxkDanX0Pm4u2W273pxPbjmi/u/UQmq3oHrEPmCeBpdnwQedAVynEi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PARP264MB5962.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 14:29:48 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6e14:438b:5c18:8557%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 14:29:48 +0000
Message-ID: <02ea1132-9adb-4f07-b14f-9648a61a8021@softathome.com>
Date: Tue, 4 Aug 2026 16:29:47 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.u-boot-project.org
From: Philippe Reynes <philippe.reynes@softathome.com>
Subject: merge software ecdsa support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0108.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::8) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PARP264MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: f1388065-0538-4b25-6f94-08def234d654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|23010399003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: wgQw86Ciib/ceG6Ls1srokC63YKyslD2du1JFcic6Qa6EOW6YvklpQ7LF27gn7zQPpCHB0vHDVmm9759QLpbVFjVJcXqEWgwm6SG8xNbGnbShLcHSuO8AKfWimW92SYYqttJWsb+0YLUODOUVNwe2tQkWpGzTW+kDj6CyXjkos+BeThxoWVwQk9h2U4Svem4a4TMBBo5tk7FnMZ34xBtWtr7BpBRqprwMvq0T27aeAzAfsNIP6aY2FQspSrHMtqUq8hquLZ6rAhhiBLPhihmW5FshoZSVdy4J6rEsyugX2f+7PyIOHtGcwLecS+ikWiPEf53r655GtSugIgR4vuyxZ17RjpQoftnXe8mKWJ0kvgXo+Xxo53McCMItPx8+Vv7iduDMFWdfzG55dIp4Y43ECKT4icyGm6sVj/A2F7o5sYWFjsDS5N5HXtbPanZtNTsc45YN1Cj2afSikOD//nsjjmqS6AMMBINEVCqqwdeeTrFOf7YrJWysGBb3XXRWyRPFAi5Uhx+auUutYLfjbaMPY2JhtSS45+8Qa3eH/jDxgmzL1wDHWNxR19anDf68dw8fzqvOUNpGsreDlekW4Lx4isalvDyun0HqKLL29y9ZQ/4VhUwe+3PscgweZCGTT0YHggEWw1nxIFSoQkaiyJAdi47xwgkVSLW//2SRRQxWxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(23010399003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFY0OEZyVkx5Q2VHbjc3cjFUR1A2bnBiWUlhbzRaR1lMeWpXVU96dFJUeGNG?=
 =?utf-8?B?QStLdnpvUXpObkxleERUSzZGelhCeVI2Y3MrTmRyVmNQZVEwOVAwdlpzcnNH?=
 =?utf-8?B?dEpIdkRzV0NiZ1lkTmRKWnpvaTdGSlB0dmR5R0tlY2tzWml4OXpkY2ZRQ0RO?=
 =?utf-8?B?MS9WcG8zdFFhdnNLMkZpeHpRTWx2dFFYbnVncG9rVXZsM0Z2TUx1VitUNEJs?=
 =?utf-8?B?V1BDWE9MNlFIUXpWL0RnQXFWb1NOakpBZnR4RHJBZFcvREU4dGo2RXhmR1lo?=
 =?utf-8?B?eWlXWHpudTc0MEk2MnRLYSswcDdBVzMyUCtKd2R0S1ozd3Y4K2pudXlqWmlV?=
 =?utf-8?B?S3lSK29MNjhEVEJVdUFFR0pZSy9ZeGZ5aFltMVV1REFuYkE0aFZWL0hobElT?=
 =?utf-8?B?akZNVEFqY01kZkZ6UnRwSEpGT0dIQnErTEtzSkIxTVB5T2RYTVA0TEVYUHZw?=
 =?utf-8?B?dWZKZnAwU2o0ay94aklsUmdqek5MWjNXS01DTDJab1AvdXFnYkZURElTMW13?=
 =?utf-8?B?TlRGUXlacTdhSzVhYy9JelpXdW9nOHBmbmdFazUyTkx6UkVzbGxQVEtoVWlM?=
 =?utf-8?B?WGNGR3BDL3c2b3lsd29VV2tjclYzZmtuRllBUVhCelNGUWVRc3hhWitGRmtx?=
 =?utf-8?B?OUJSb2V5NFE3czh5OXVOWGk3M05ZOHoyL0tOenprOWhkNlFXTTFQTFIzYTl0?=
 =?utf-8?B?VWVVbmQyNFdsdjFLelAzVUpXMkpDVENRRThaSXMweTY3T244d0hLYXdCdDUx?=
 =?utf-8?B?YzU3dnBsV0E1L2VwSXJrUGx4anorMVNia0RpajU1YU1aMW1DV0s2MmVWSWpP?=
 =?utf-8?B?VmxVM2hReWJXUnllYmZ6emliQ3NFRmxiU2Q2MC95VENrUXR5bVk2Z1ZnK0t0?=
 =?utf-8?B?QWJWQUQ4UjBES2R4MnQwNENxRGkzTHMzYlJ4eS95QXRVT3Ivc2tKaW9yaFpD?=
 =?utf-8?B?S01ta0FVY3FhMzRidTl0M21kdVFvR3VacWFjNmdyb2pYS0FzdUN5VFhkWmM1?=
 =?utf-8?B?cjJsZ2tRVHVDZWQyK2VvNGNYQkpXaWNZV1EweGJna1VjdVMwWUJZMmkzYlVa?=
 =?utf-8?B?aTcraXZEcy9JWHdGZzI5YTRKdmk3dW00cEJBUWp5RjlhZXBuVGVmaHNSc1M0?=
 =?utf-8?B?MWhERWxuTGxHUVJlV1k2c3NZVU41VjFhUzBDajk4d01mT0RhdXV4UXhzQUxU?=
 =?utf-8?B?VkJndkNGV3RmaG15TjQ0WUFYUVdKcDQyZWFZSDZ2WFYrWVNkV1NmcXIzU3lv?=
 =?utf-8?B?RVF6bk13eGpyRFdmUHp6ZVFja04ycTU5TXNGWVVDajkyRm16MnZldEluVWF6?=
 =?utf-8?B?eDcvZWJSMlZ6TGc3bllHRHN1YU9jVmtsZVN5Q2ZKb0s4VE11eDBJOThTSzRo?=
 =?utf-8?B?OEg1Q3BwcUpxb0FFQjdSTFJKT0o1blViUVZYZi9SQU9BanRuK2JkbFd2bC83?=
 =?utf-8?B?Y2FlcVUvbitPeDd5SW9ubURRdjlWZkNCa0ZhazFmdFRPbzl4LzZ3djc0ZGFP?=
 =?utf-8?B?NzJGWk8wKzJCV0pUWHVDM1JSck41c3llZVMzNXNMRDZVRG9IL1VLTzdodExK?=
 =?utf-8?B?bDZSWHpjZFltYnhZNzYwVVJCbkVEUnVsUVR4SU9la1BiSTZJbjB1djRiS08w?=
 =?utf-8?B?dDZ1ZC81ZHlRcXlzUU9HbndVVHZleVhQR0R6K2czMlV5L2VKNURsZTVGK2Jk?=
 =?utf-8?B?a05ibzAzL29lSUh5bzVIM2ZJQ0dBY280NG1Sb0hLWnVnd0ZERHFSeVo4ZXJB?=
 =?utf-8?B?dUhlUWpXNGx1RzFzNVdNcHJyc0dzY2ZHelNOcXZYTWQ5NXlFV2EzZUxLS2dS?=
 =?utf-8?B?NHZIcjZqNUFMdWFzdUxDVTdrNlYvcGY1N3pJRXRYaktUcXNKL1crY0tjWnFK?=
 =?utf-8?B?cjN1cnl0NVVlZnBDdWs2YVduMExIR1kxZFVZVkR5R1kvSDM5Wi9SVzFVdVpv?=
 =?utf-8?B?Sk05MmJ6ck5mSFlGQUd1L0pnNS9vcDdkdlJEQ29jbUxocDBRbCsxNEVrQnJR?=
 =?utf-8?B?cUY2Mm9LeVI1RkVyeWhwckdnRFYybThkNmt1WTF5bEpuRno4MjN3T0lJWTkv?=
 =?utf-8?B?VG1IV3Z0eEl6dHBSQ2x4aC9GT3pmU01HWTZGYktLcHNHa01tY09lajQ4UlVm?=
 =?utf-8?B?bUtTeGp3UVFkSTMva2ZjL0lweHRCMzVNK3BubVhkVU84UngvOEIzcGthdk1G?=
 =?utf-8?B?em5HT0t6RGxNSGV6WG5UcFdaYXV1Tzh3MGlmLzNnZ0crNzlhRUJUWU5rWU1K?=
 =?utf-8?B?OGU0UGZyVDVkdGJIeHRGTTJuWm5mTEYyaUJzekpIb01oQlIwcnQ0VEdzUldj?=
 =?utf-8?B?anNQWThmekJBUUpoVHRCU2NWeUJ5OHNiN0VDOEF5UklIWTR5OGpWZE1WSjVl?=
 =?utf-8?Q?vN6pV/nB+bLGnZfFs7IemAyGYyeIDYdxkT1aVSPu6rhGt?=
X-MS-Exchange-AntiSpam-MessageData-1: NXn4lDi6gb6nF3dhJ7kX0ueBrhdARVj8Wto=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1388065-0538-4b25-6f94-08def234d654
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:29:48.2733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsQZd53fmEe99RZ/JjB7nFfh0rI1KRk47qzoSh+pQVXy17jF+/8nmhvGMR99JtCO/lw5rhYANJ8tVUTEdcap9QbzLNc+aFtXqHX+JOhesCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5962
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sow6gIAKgrc5xNfbY2ifs9EQx3r4RrUSsPkk0yaNumI=;
 b=jdDiV7SZECB7MXY4LfIUQen7bvvIxL0AO8a1Bc97FUwAq2SN0E8y4KNaQpY5Ykh3MS3YMLyFMCaqgJrg5xnvkSNlBW7RzWfdeRnxQvIYpcrmyqEB5q/MYotjI/jUTdLhoEN5ZVG54sIJTMZeCYz0VNPYFOMJ0HHIHW6RQKBdPr1w36UvSM6xlgv45OvPvCvMdT3/xptir8njK4Vt+fAjVdzZHnQR8M4S/XewIru8+am2JmHNRmX0uvBONrbRImyp18kgr+SfjRrEsojIUXZbNpsNSOC8lhpmaouWVqDASwF0CoxdcvYiilcLsoS9DNvdA3z5yvA0DLIJd4U+UlFyqQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=softathome.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=jdDiV7SZ
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom, Simon and Raymond,

Do you think the support of software ecdsa may be integrated in the next 
release 2026.10 please ?
https://patchwork.ozlabs.org/project/uboot/cover/20260601134310.2452454-1-philippe.reynes@softathome.com/ 


Best regards,
Philippe


