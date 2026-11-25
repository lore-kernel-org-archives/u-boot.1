Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB02606A335
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wQAtJzAh;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=F4NzVHtC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 339ED4050C;
	Wed, 25 Nov 2026 16:49:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tf12L_VTvJaD; Wed, 25 Nov 2026 16:49:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7CF594047C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795625397;
	b=gps1c+MEWW3XtCpP/eKMVe50RPI1A4myolCRX0QeqH8c3izoCYib1IKOT2/QBTlJxC/q
	 u5v71W+GmWb7Ajq/IY/O4l2Pmmy4OVX80A2OhWKeUqfqI0nffy70pYcINSp4XKauarSjA
	 baUyHeVcSq0Sj4qgLW23wAITjz5ZW6ipxVajjcEohxcJz2HP+VWrDW3Tw7eKVl7fJmQDy
	 GFhZ+jKrjhpc7j76YDxAsJZbh5y/jYGBegMwXVyUbN5P1SwSYRqNQ5fnOyUWwhhanMXkS
	 UeYBR6UGsDhcZo4HgSfDYcfsICPk7XtXX/LQGk+4FJILUw3pN4cN0jYrk8y50JkhDkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795625397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LYmSFHAKGKNG50i/L70peWJkZlZYmJsHBMBobSGaVQM=;
	b=Vxpx+2HtS/8GsCTTFngCfsBcDHJKkmtc2tZhKuGADq3Kzk0nRWl7VQs+ixtVxXLnpWYY
	 3gLTX3CmctKRSzO5pll60bey63QzZhQOsEO4QKnlk+fPpLT36CWXaGqZ/Vbibch61RFSp
	 Hi4RAH9g7MBA+DtgGga4mnvZy0BHPe+1uAtbADfwCiEnzDJzPvbLBk6jMnNHc4DASJM2z
	 ptRBZfcMBnSlSVHwjphnzVsp9cZmwJHvM380m8zgAbCW3QdKGOtzGIFnZdD1pv7JX8xl7
	 ey1TNRU7Y4FVzC28SYh/h4hyCUHcdcDdpm4ozrQupV13QPXHPukdWxOvAjqtXrqzTZA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795625397;
	bh=LYmSFHAKGKNG50i/L70peWJkZlZYmJsHBMBobSGaVQM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wQAtJzAh+7hCJavlAY6+7+BuH4+cMa55xdTV1MMtJtwRCdRUVIZK65MrSvTFaYYBW
	 OzhZLdDkDtinPiZRYuB248EkBZ/vvFoVax7fvfGHRRRMAcVnlENBhVo5QCJ+/vZyVp
	 lFRxxQK4di07lB9eUcsF5isiu0sMikcpKwl6/eYBTNyGpJq+2dXg1er3HYjdxRJ/Ug
	 0MZBwUMUJ9m4r1GA8JJzoqm5QlHdw3M9+F9Ob+tYo8cSjePHmt01GIIaYxz+yXRHhR
	 bXev4DaOC/wsPqcyZay9Eu0JiQiz8bSEC9Ija7eqoYIEGzkSAU0tsV6eYS050LaV0P
	 FHjlnPoVoE87g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CF594047C;
	Wed, 25 Nov 2026 16:49:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E24826D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 346C4606CE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:49:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sL4nHxhd7Z8d for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 16:49:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3299C6064E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=b.hahn@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=F4NzVHtC
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3299C6064E
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYmSFHAKGKNG50i/L70peWJkZlZYmJsHBMBobSGaVQM=;
 b=F4NzVHtC2kv7E8AYCghf6h/VNtszO7YXTA7Kh0ktmGcaMGKF+khiWHRE1H8MKLhZ1u9x8XIHuCLoEkEqsJ+iGymOHj+K1ZAlyQqcRft7eYn05axHYMlyzQsCHS6pLVkbYlhd8b2yhyw+PaRKxWEcaxeU7M7vLG13/gOUHy3p4j9mOeXwTZiVqbrUcNDRVpH5u7aZjjjYNc3EMMYVhgYSmgEPrrMqsXdsGShOXwf8X9CWHejr4mNb2CSjRETU8gl11c5RIU2xM+HnChrakjjSZNdYvlGB42HHhqZwjricuqu3C5ws2EGXi1+H4p3IkyFrTGSmaeki+FuBurtj9W8hkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI1P195MB0623.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:159::10)
 by AS8P195MB2096.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:56d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:49:50 +0000
Received: from VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 ([fe80::2f8:67bc:a785:6894]) by VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 ([fe80::2f8:67bc:a785:6894%7]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:49:50 +0000
Message-ID: <9f74e2c0-28bd-418a-902b-4cdef3d1221b@phytec.de>
Date: Wed, 25 Nov 2026 17:49:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: dts: imx8mm-phyboard-polis-rdk-u-boot: Add usb
 entries for SPL
To: Thorsten Schmelzer <t.schmelzer@phytec.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peng Fan <peng.fan@nxp.com>, Benedikt Spranger <b.spranger@linutronix.de>,
 INgo Rah <ingo.rah@linutronix.de>
References: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
 <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-1-dd6db9e5edfd@phytec.de>
Content-Language: en-US
From: Benjamin Hahn <B.Hahn@phytec.de>
In-Reply-To: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-1-dd6db9e5edfd@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::9) To VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:159::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P195MB0623:EE_|AS8P195MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: 2868790b-7f29-4047-ac4e-08df4b141f11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006|261009223027099003|261102123227099003|261021121427099003|10067099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: YTVMpaMPd8V8RAAIyXw9zAYQyG/UwAxmwDmwJiuYSXRgn6LoICNR4MO1Wblax/VeJ3+ocoUSqLjIkBofn9qfVNTUrbvCWEmqMzZOz14hWMXe2hNxUJ/BKXHBJVcc6c1tnf+wiK2hzlsuHKgeYU+xiFWQ9sb5AmMVaen44wVKdCRy3K6Xym0P3QUvJ/T8/7DTLqPwfC0VgSEarLMYE4raUSiMOjbZFFEmDnonBLapibHeKvc1T5hWp1WRS1aEaoxrW0uFpWxYKhYkq5v43/8CMWooztp5CIUG0PDDLSRfTYa+QPiBpQm/5/+8oIH0ErAIMKVofDb3hC/cSBvYJAHvrLYi4XYFpvd7TXvIfzC6A5tj/1Qrq2i6OmYOXAxjs5VyYDzDoSCU0Zj28sr++6f4uO3hXeeMTsEvYT4sSh1OUnTzOmnPdqkuXGC8uak0go2arZvM7vjS8f5ByCN98hUmpVFUpcSXbG3TVjDOMDNLSxG8f96uFSKXGpp0sWjgFLGrw0hg7VdOva3M1I6vVEw6hockgP6ISo6Hkcifori8Gz1BfokQ0t5ad8b8acPc3ECl3h4a3w9pt9xrQSO9OZzs3FVLCTvmXPbkBkPenRwThVdYNeyzkqRDYlaCp5c38JCdHa/Af+pptFNi9IZwfIZc2JUMnXjmH7ET8ho6isXo6jM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1P195MB0623.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(261102123227099003)(261021121427099003)(10067099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGNSUmtWZGltMitYaXhvTEJJKzN0bW14NDF2bXhNdk9FamJPQm1rT016WjRF?=
 =?utf-8?B?Y1ZXSHRVUUh0dVlqMWsxWG9oV2RyczJOU2h0R3haZFE3dXFSLytROUFMUHE4?=
 =?utf-8?B?YnF4aHllckNBelpwUTgvNlZodysxQmg1RWluT2pBNGpZMmNxVkpqNERLeVVG?=
 =?utf-8?B?V3hKTUlBU2hBNS9JazZuS2Vhd2xqTGFwL0RRRzR4aklBL3Qzb0ZEbHljVlJt?=
 =?utf-8?B?b0NuYWhqd1R5M3NvMitPamw0U2xGMFFra2VDTVc1a0d0S0pnWStIVDY5M29R?=
 =?utf-8?B?cHh6Mk1WMkVhcGlycXZVYTFvWHVZUVhtSXk0SHBIL0JsVWlaS3d4KzFNUHM2?=
 =?utf-8?B?Q25nRkYrRmFFRDlRYjJMVnBCMG5hK0VleGQwSUU3OFpTb3dEV2cySFYreGNt?=
 =?utf-8?B?Rk0vRGZqRmZIZk85c21rSVNJbUUwN1JPOGFtdW9uaXE2bGZ0d0p1R3BmOWZL?=
 =?utf-8?B?T1hMaXN2NWlHOG1VKzlLVlRjTG5UMSs2Y0tiRWNURnVYQVdqeE5DWW5EVmNh?=
 =?utf-8?B?azU5TTkvSE5xZnNPbElYUUV3V0tXQStMeGsrZ1JGLzF5Z0RteTNHRlBIcW5Q?=
 =?utf-8?B?ejBMeEpJeXdLMVJFdVhqSFNnenQ2VzJoZS9sWTRIaFZTMnhRZEpPL044QmMy?=
 =?utf-8?B?TTNQSStnQnBKMDRLa2lkZmt5Z1IreUFQUHZsem9vUWhJelhBOGpNYU96UW1M?=
 =?utf-8?B?UUNVRGx1Qjd1T0tzaFF6cHJzejY0YU1yN2xoVWtnMUlRbVJnR2ZtSFRGZ2E1?=
 =?utf-8?B?aFUxYTZTUGZlMlNDVFJVdG53NVFSZjRtSGNZdHIwaTl4M3ZDR3dIUzlvdEdu?=
 =?utf-8?B?alp6a3AxNkpVRDUzVEFUbm1JR0xBQ2Y5MjdBd0IyeVk1SjVFdTRuZEhpd0RU?=
 =?utf-8?B?VHQ2TkNuMjc2OEQ1cHNTVFF4Y1hMTkNQUnBTbGU4VHRYYVNCcHNpMFkwdUph?=
 =?utf-8?B?VElzVjVZNVJZb0tPaHJqejl0ODVwVjRoWmgwV1RqWjdqVmlxcXIveDhlYzdH?=
 =?utf-8?B?bktyVkQ3YlE2cFhpR29VRWNaUjhTR2JJVnhJZFNZUjArN2poS0ZjaXVBMGxy?=
 =?utf-8?B?WUlCUWtpL1B0VlRaZUxrcmpCbWg3L3paSzFpaFYvVEFzblJHbGVDNmZWTDFi?=
 =?utf-8?B?T0YyZ0R6VE14ZnRMYWQ4U3lmTE1RUFNEKzdvTHNlZ0FoUHhsa2ROMGJnMStQ?=
 =?utf-8?B?YUJRQ2FtejZWeGEzeUg2bjh5eVBQV3FWY1hiSFpicHp2dHRyY3ErdXBpWEpN?=
 =?utf-8?B?ZmR3b21VZ1RSQ0F1NDAzUGExMGY4ajFoaUVpUnp5L082VERQdFZBd0R1cVpY?=
 =?utf-8?B?N0JHRFRVRk1rZld2MDNXeUovLzRhMDcwRjZ4cUJRY3M1bWthaTd3VE11Z2Vo?=
 =?utf-8?B?QXFBMkpZUzZ5NkhsMUsvSm9TSHFOemJsVS9ydVBudlYyMXVyN0liRnBreVFl?=
 =?utf-8?B?Tll0WW5vbUR1YTlKazU2dVJMbFF5WXZIUDJPVEdwak54ZDgzZ1JpQ2xkd3Bh?=
 =?utf-8?B?eTVMRUZrZUFoamIwTkZ0K2JBQStBdys0ZHFxMlZ5QmpvQVdabDRCUWYxMGZv?=
 =?utf-8?B?ckZ0eGZ0L0ozTDAxeEJlSGN4VG5oOE5jUG5KM21jclltemdEOExPS0hzSVFK?=
 =?utf-8?B?UXg5Rm5rUnJkNWlsRS9WaGh3MWJhUkFqWklLakRkTE5rQ3NVTS9rbmNRVzJ3?=
 =?utf-8?B?Ymt0WHNjWm1CTCsxeURzL1RsbE5UYmpuL1pQdXd0ZE96MlBCNzc0cW1Nd2dY?=
 =?utf-8?B?aFdHOHRWc1JsUm9Dc0RsMVh3RGJJdE0vZEIrUDlzUzhBVm0yQitaRVhKWUln?=
 =?utf-8?B?aytZYWdIQ2pyc2dBWmVrTVhEbVNlekIzSGYrZUhtMnpQVmEwQS9MNWo2SEtw?=
 =?utf-8?B?V093WkRLL090L2NSWEN6YTJmVk00SVZ2RXFrTmhTaVdBK1ZUaDR0UWpYdzJj?=
 =?utf-8?B?Zzd3SnVYbVMyQjkvRk44aHNZOEJIYXg5cGduWUNpc3hZbXRkL2lkRTlSR29r?=
 =?utf-8?B?U0tZQit3UjlzSlRxQVFwV1Y3NE5rN1c1dlBMK252TnMwaXlSdGRTVXZ0K0xU?=
 =?utf-8?B?NVhwUFVyTlZVMnpRbXF3dC83R1V4K0NRayt1dlJjWDlockk0aVdBVnlIbzJD?=
 =?utf-8?B?eUxXd21FK091aVFxVHI3emJFUTRiL015NU5BNjhzTlR4bTFRcVpIMDlYbnB6?=
 =?utf-8?B?Nzd1RTU2T1FVYXIrdzB1Sk5teXczbVZVcFZlRmJiL1FVaHBKaUQ3TW5nQktm?=
 =?utf-8?B?MFU4WHZzcnduckVvZ0VuMFQwVUFPcXp2dWR2eFN1VFZHUlJnWjAxbW5IeHIv?=
 =?utf-8?Q?uBIphPKeU2Qg50bh4R?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2868790b-7f29-4047-ac4e-08df4b141f11
X-MS-Exchange-CrossTenant-AuthSource: VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:49:50.3513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKp2d/1ewACWJMtDO+SHt0pcL4KHfiQLG3qXylhMKjMHy7p9Qk3l7YGDezqW+U7KeffWjN2/UxZnovUcSIKwLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2096
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 19.11.26 um 15:12 schrieb Thorsten Schmelzer:
> In order to support the USB serial download mode, SPL needs an activated
> usb controller to chainload u-boot proper. Add the necessary entries.
>
> Signed-off-by: Thorsten Schmelzer <t.schmelzer@phytec.de>
Reviewed-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
>   arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> index 143ce6a6d77c..1d2b456b623c 100644
> --- a/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-phyboard-polis-rdk-u-boot.dtsi
> @@ -82,6 +82,14 @@
>   	bootph-pre-ram;
>   };
>   
> +&usbotg1 {
> +	bootph-pre-ram;
> +};
> +
> +&usbphynop1 {
> +	bootph-pre-ram;
> +};
> +
>   &usdhc2 {
>   	bootph-pre-ram;
>   };
>
