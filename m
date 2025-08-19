Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FBCCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 14:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D072D809A5;
	Tue, 19 Aug 2025 16:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="wvS9wmYg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5A680FA1; Tue, 19 Aug 2025 16:34:02 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70328802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 16:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMSGA4l8MKn3Ze6cqTwiGJQoXh2MJbMmoeNmmvJISeoiFcuMhImQ1HhHQ9qlMzPSGACy0Ex/sxS7AOrwaWLkvVufY4MsO8w2Gu9pQeIassA46coqhTDgf9woNK9q7hNeWwZoki/1oDZirRszb7bHuQatkpQqFWeZJ2diEd8xa+4/q+8n4prVA8VcjPEUkUf2cBPLgkfYNiEEoulb8CFVdOt0vMiH8rH8+WEVPVURFPd9mNaeFNdUovx3REuIGmMhhsxlMsb5rxSeMTT30SxpNYtj2uv7ASOnGVpZoxXoxqrbsuSZ1hHzoRqSWujE3iEtJvv5eZ7NJipOXzMunJ5M2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ2tyOCkLWXsTd/MAXPGgd75cNi05VabpOZ1Ue/5rYg=;
 b=xzt1O7+xfraTPVIp3gX8ZxMgWcu7U/+U0xWZxAz2ovSUhDeIOiCf7gznrlFkEml4jMCu2HFMzMRxcI8Vvfpiy9jt0tPfPW8bkyHRKcKR0krughJeC5lkKgg+xCvG7XCUT562ubVW+P+/4DPUSeWk7OZUWKJ2MjNWxYwYkoTImcy98t2Bzt3ycWznFM2C+B9GaT4Yf/4kZe7t9tRZmNs70OJaz1PPX8JUlATHI0139dmdQ388IPso1b7CIJT2Q6tlzWxaOrAlqQ/D30ygZ/nUMt84lhhFa46tqeLaM9X+AAF2U1W6QUdIIpVbCyd8ySZ6vc/tXIgjRYNAF6WmGtJgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ2tyOCkLWXsTd/MAXPGgd75cNi05VabpOZ1Ue/5rYg=;
 b=wvS9wmYgFgYs7ef0P5GsxvR0eIps2EACX1xw6eBXgVJ/DSy2xAwiH7+m5VixgReC6QYHmaYKPFpq33pcyhy6fOK58DQJPkVdZfqU1IG+TmjkiGP9AldhoAjpkLerAYWR9+G+E7vivn4l0PU36+OkS1zOHqp+KdGkxhFpkXUiS2foKHB3AVfJ4pEWCJ9aOXafPTUcjqZk5ZIbJe8x04ULSmtdpMc/Q0vyY//4H5pNJ9PKZwtjO1rKfua7PNzV+7XohQK9Rx3dmGTtDC69et/cUOnkN8C0vaJ7lrY7T7FDIEGQyNnmB4/W7zz8hHalzu28FcyHOH+OmhXfZ4MNclTNjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 14:33:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 14:33:58 +0000
Message-ID: <fffc4713-4f89-4a04-acc6-8b295e453226@siemens.com>
Date: Tue, 19 Aug 2025 16:33:52 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] efi: Select also CMD_DHCP from EFI_HTTP_BOOT
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:610:60::40) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 2823f20f-e924-465d-0558-08dddf2d6f0a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2hFeTJ1OWpWYU10aU9tNEc0MSs3Y2RjYmZNY2hnVVRBOVpOeS9LWlExUHkr?=
 =?utf-8?B?cXJtZ04ybEhHZjBYT0hPbUFHeGpsZGt3UHE1Tk5Lb1lva1ZsR2NYT1ZDNDFE?=
 =?utf-8?B?NzFoK1A3QXpVeE0zcjRCTVNFaWhwZnMxUzFDd1FtOXA4VS9tTkdWSkxvd2NI?=
 =?utf-8?B?dXliWkNQaU1QaGxoWVM3dUVFODZUaFJqZTk4RDF6RW9XeDhyNEt5RHpGamdI?=
 =?utf-8?B?SDc0OC9aNnJ5NmEwaStEMG14eGRNSjQyanU2V3FZU2RFTml6aVNubUY3ME0x?=
 =?utf-8?B?cko1Tk1Rb3dERzJ1bXJZSjdUR1NkOEUxMGpSKy95cGUrRGd2a0kvS0FSQmZJ?=
 =?utf-8?B?L1NjMEdEZFNCSmhIdnllUk1EbjZ3RUQ0aEZxRUdNTCtQLzVpSjd5dTM0TDZm?=
 =?utf-8?B?aG1jNmlvQmtXYlZ5Sm1zN3R2bmRMVUFxeGpzTEdYRTVqeFVweG1qY0w2UGpp?=
 =?utf-8?B?UmQyRjZMV3NGRW8vR3FERXplMklTZEdOVWZ3M3I5dHQ2aEc1cUN1S2VnZWh5?=
 =?utf-8?B?YUNIWVpodGF1T3d3Z3ZYdU0zTDNoOENocDlNK2tTWHAzekNtb2VzOVpVRmZO?=
 =?utf-8?B?MVJSOUh6QlVNdHZkY05CbVFlbTdUaTFZWllLYzR4U01jRU1Melkxa2pBV3Rv?=
 =?utf-8?B?MEdWcEd6WWZ3Y0JMTjRYMjJiRkJMb1oyRDQ5TWs2U0ZkaDRmaEtUWG5jcHFx?=
 =?utf-8?B?M0ZUMjRCeC9xNmliZUFUUE1lbjlvTnJqeSsxcVh6QThuNUVMQ0VmTVZqMU5N?=
 =?utf-8?B?bkZ2WWJDOGtsR3FOMGNHbHdFKzZlNWM3V3lvZDQ2YVcvVlBqaTRHL05meW85?=
 =?utf-8?B?L3ZLaEdSRHN4b0NNUmJUMDhyTjJGL1A4VHRLbFFWUjh2eC9pVUNIcGh2U01M?=
 =?utf-8?B?ZGh4L1Nqdml0aUdpR0dtR25jNUN6Z2N6QVBtbVlWTHNjNGRDNUdRVVJMYTJ6?=
 =?utf-8?B?ZVk0bGN6dWloWmlvTEwyRXllRWtqZTdCTCtJNXE4SnFLVnNnNzNnTjRLeHQ5?=
 =?utf-8?B?VCtGdWhZYzl0YjVSdlZvc1JhZ0ZTamtobEdKQm1Vb0FuclREMG9BRzFtS2FV?=
 =?utf-8?B?emMxbjRidUVtbXU1c28yWjM3U1FCalpDNkdKWldHd0Y1OEtOdUJpSDJBTFkr?=
 =?utf-8?B?WEJuODZZZDJFZjZ4aUF5Y0lDYlVlL1FQNE4vR2trY1YyRFVvdDZQamZvTllr?=
 =?utf-8?B?ZEFqdUcrSjFyZjN6MWFncExTakx0eUdNUk9jckVFS09aTnE1ZFN2ci9Sbmh2?=
 =?utf-8?B?Wm1BY1hUcFVwWGVibGhrQ0I3bGdrcW5iclZ0L1g0VzlYeEN6a211U0E1dDdD?=
 =?utf-8?B?QXpuazBReHpKanMvM2owUEJoN09mdTc2d1diL0Z3azJGMFBvN1g4bXdhL0hX?=
 =?utf-8?B?Z05qY2djWWJzU0E1L1cxRm1PUUc4TnBEcDdtS3g4Sit0SGZQQ2srWE9NTFBE?=
 =?utf-8?B?UUExWEpBWjVHWk81YnAraXQwOVNmQS93WXcyeFhWY1ZXKzVJSUNWOTFEK0x6?=
 =?utf-8?B?b3NRZTdxcjlvbG4zbVEzL2FaelhFbE45TUxrVnhESmVReTFXWlk4TmNRUjJx?=
 =?utf-8?B?RVI5TFhLOTFCU0xab09uaDBpa056QnJ6V2Z5WW9XdUh5eUJxTkNodFgxS1hV?=
 =?utf-8?B?VjdhNGl4NVlsbFZFSFN2SmZ1WWNmeWpQTGxTR1V0dVNKY2RwWkdxeXF5ejM5?=
 =?utf-8?B?TzY3b1ZiY3FQeFdsWEJGVDY1Z0RRNlJUenU4V0NoNnVva0puVVFPVG90VzRE?=
 =?utf-8?B?U21PaHFXWUtUdTNhTXg1Q3pYQ2UwTk9DYytvMTQxRXh5aUdIVFV1c01qTUdl?=
 =?utf-8?B?cVZER3hycEd5QnFnemtiNkFsaDMrVk1rZmV4Vk9pS3V3dkEvWFc0RWdVNUFK?=
 =?utf-8?B?bUdOajRxVFNHVWRxdG84SjFiUXFtMDJHZUs3YVhBbkJqbjR3RXBLK0hCaDFr?=
 =?utf-8?Q?fyaLhJiyvDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXhvSzY1Ky9IWXdjOGM5Nm0yMndMMDNSRFplOWpyczZXK1pEVmVxTHlwcGRu?=
 =?utf-8?B?YTU3VnozaUdnbjYyRGZmWlc5aUtoeGZkU01RdzdNakVuc1BMbXdpL3MxWGR4?=
 =?utf-8?B?NWEzb3hBTWgwNnpzMlNZWHZYN2pYUmsremZuaXNiYmZhL24yamNBTHpUSzlJ?=
 =?utf-8?B?UGdVTTlEeERUZUUyT0N4QVJnZXlPZkxTYllkbEdMM0JhMTAzWjlXMXZ6WENy?=
 =?utf-8?B?L3RZamVadDZ5ZGhWbGRnV1BhUEdvekorTElCNFFwT3dIdks5UXdRYzNHZ2dR?=
 =?utf-8?B?dE5oODdXWEtUdi9ONXRnTXo1cnpRZWxJOEltUXRYWWo4TUpUaDZjYXZRS3Y1?=
 =?utf-8?B?NitHRnlNQ2Zod1laTnQyNXhpWTlTYUQyWFJ0dHNnM3QwRS9VTDZoK3E0aFhH?=
 =?utf-8?B?cHdrb0tVQTB1N0p1ZkF6N0gzR3ZrLzRvWVRGajVLaWZWNEgzRGJBek1wWWsw?=
 =?utf-8?B?U2pKdzFJc2VLVmV5dXJEQXJvU1BKTm5FMTNVa0VGYWRlY2FWdEI0ZGsxNUFY?=
 =?utf-8?B?L2lSWllKNkZiRzBmcldkYTUwRUc5Q3RNMTN3a1JWMk5PMkJRYTlMd25WRDk4?=
 =?utf-8?B?NFl5dWd3VGFzYWxoeFBRY2hoMW1TQld1UVAvQ0FXU0E0RTJhTDZleUl6bmtw?=
 =?utf-8?B?QTExZ3A4RGZoUWhsd3lxK241UWd3N0twM1gxVzZXOVZHd3RJdUJjSktHdFlR?=
 =?utf-8?B?ZVg5bklXNGxIMk9Eb2sxMUsyYWZSaCsyVnF6VmN5V2RGZElWeDVhdHhQSHk0?=
 =?utf-8?B?ZCtrRGo0dllsNXB0bU5kbnRHYUFxU3BKbG1xb1RoUzN1TStVRmR3bmZzTGFN?=
 =?utf-8?B?TmZxODlBSzI1eUtxTlUvVnd4SCswMzR4bEd5UzVCUTJ1UzBiZHZnblVsT25N?=
 =?utf-8?B?RFZtdm9SZ081ZUdLMmF1TkR4T1RCME1QWitTY2pGQXk3UFF3a2R6dVgwMWsv?=
 =?utf-8?B?eWZKYWpialpIOU5ubDkrU0hJdnFnK2ErZTI5MUs5TnJBMXgyUmUvWmdKVlJM?=
 =?utf-8?B?Q0hTdkY4RTBlTkFCdVF1ZEovUVllbnRjSVdJNThBRWF6NHR1a1MyWVR6ODFC?=
 =?utf-8?B?WDNXd2xGQnZOSytoSFpQbllNYjF0eWM5Y2d2TWxhY2VNN3NIUnJqdXdFNC9Y?=
 =?utf-8?B?SWRUeGYwS1dHb055M3c0SlZkV2wrekp2N2NRQlBLRFZLL1d3VXN5alBLZ01m?=
 =?utf-8?B?WkVIeTNqV1dCUHgvcWJaTTlTWFNxVE9NdTZ6S2lnNVdEM2dhT1NBVTQvWmsv?=
 =?utf-8?B?WDFCMzFqUWdGVW5qUWl4OC8yczFVV0dYcy9VZ3YzUXEyK0s2UjJBbWxJMFBa?=
 =?utf-8?B?UFgrbGdmTXVSU1hLeXlMVnYwVGZmSUlrcHpKS3BKeWZ2UXJGREtJTGxDWi94?=
 =?utf-8?B?d0RKdGVSRi9hbkthWmpqWXVGblJ0dVMzRUl4SXNkdy92RE1mYWdPS1d1dnZ0?=
 =?utf-8?B?U2ZLN0hwNnk4Z3pnYmZBcVRKY01uY0UvZnVCaUgxVS9JMERCbjF5Q05sT3RN?=
 =?utf-8?B?TEhEaU00RTNQa3BBS2ZYamQ1elFMOTFWdW9jbnVkWFRER0JMV1NTdlZHREVY?=
 =?utf-8?B?ekZ2cS8wZDJHY1c2UEgzQ25FQVF3clQwR3BpelJ1V3lJd2tLQkI0aElKOUd2?=
 =?utf-8?B?WjFkdWk1aWtEOUtNODZnVmhCSDEvNUloRHRMVW9xbVBEU0QydXdQVGcwWFZr?=
 =?utf-8?B?Z3NjQ3RXREwrcmErc09Qb1F2YVVJblV4eTBaSTFaRmVQTHpwNzBXZno1Tk13?=
 =?utf-8?B?WlJSYm00UDdCTlcweWF2RVo1ZDhoMHhnVXlUaENyNnkzL1dMNDBKYi9zb0du?=
 =?utf-8?B?Mm9vdFRCLzFXRXUvdTlRcnk1TTBUSk9mYm9wLzBDMDV3ODNwRXdrVTVOYUNa?=
 =?utf-8?B?MVdXQXF5dXdBRWNCZTRZV1dlWTYySVN4T2VNSXlEVmFYN1VSVzhBWm51Q3B1?=
 =?utf-8?B?NHVJa3Q5RmdFUDd3ajFObmZMdWNiZGtkUTFPejFDUW1KTEdnOW9jdlhFcVFh?=
 =?utf-8?B?WWhsb0gwZHNlT1RZc05Pd3FheG9tN0N5OFlBNDh0RTgwd2tBaEtWZk9XOVM5?=
 =?utf-8?B?aXU5OVI0L0pDQTZFSWgxczQxMDlWSXpocUpvazF4eUpFRmJJc1E5WDNYVHRG?=
 =?utf-8?B?OWJJd2lNbGl0TU8wSlBJMjZaMzZkK0JKa3JWUEduZHNPZUI0dEtIN1NaWTZQ?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2823f20f-e924-465d-0558-08dddf2d6f0a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:33:58.8606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lL04fDr6SKxO1+K/0fLjZ2x+XtaE2t5R0TjqKHoknJVAC+V7+8iARUBuFcoFpUQoo7BZXPO+Cr/KdiW6T6K4Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6096
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This is needed because distro_efi_read_bootflow_net will then need
dhcp_run which is not already enabled by CMD_NET.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/efi_loader/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index c2aa88f59fb..a4055e1cb43 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -564,6 +564,7 @@ config EFI_HTTP_BOOT
 	bool "EFI HTTP Boot support"
 	depends on NET || NET_LWIP
 	select CMD_NET
+	select CMD_DHCP
 	select CMD_DNS
 	select CMD_WGET
 	select BLKMAP
-- 
2.43.0
