Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BF8C531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 10:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D01A40640;
	Thu, 23 Jul 2026 10:01:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 91Qb3Agss34P; Thu, 23 Jul 2026 10:01:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23CD8406C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784800875;
	bh=PR5cHOhtFGseekMNp1/PSit1kcnWnmhOqFzse1gZGzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MpO2CvZFmnyDFHXQHIugpT32VeBHzBix7d70dtVSt54FAcG8UyxG3RChYteC4aOTt
	 yzY86tRRNWSVavkpfHc0bQ0kHfUjQ027i7/dlgYns0YY8acwG71u2Y2bnyx3mI23kU
	 9J1RybzWyI9m/pKhSCqyYts/55xkj4ccQa6Se6WhB6Js7yA0HZMlc4pUk8DI++DbwE
	 4D4wB+v7dzQfZRDeRGfImhYWb2O3e+RFuPTjJeFxSU2A1e2ONTOSp7o1oomtC/VrU/
	 kcomz7Mm3H+oA1P45TVvQ4ihuDNnPkcVgqF2mH0ucGswq7vAJ+f3sNgXFYqc2mwQPp
	 zRdM1UbN4E3uQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23CD8406C0;
	Thu, 23 Jul 2026 10:01:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C4DB8347
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:01:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA981607CD
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:01:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZEvv8mowJ9lP for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 10:01:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5C1AE607B3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C1AE607B3
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C1AE607B3
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0UOFElgq48x6WX0YpAufaWQCqwv0iM50OrLEpEhFVh3GsLOhiQlfQQ6l41ZumYvOJishMH7r21LtL31DEBvcDmM/LZdi6HlGaQsmPMs2foN5lzqbPCU5aWHKNzpX4fuDpgoOgmtgAqerrPQo7OSl8eRZwiEDWmP2oVebpQUAo/6EpmE50ODHOSaVkUIvPVYDBp+bnY6CYHshNy81GS1PVllnHquCptIJ2dkIubQTuQZ+AQBxP2/MvEtBgF+x2HDoHZjRteWys3xqUFL8vfqROcaEhWX2y6d1iQvPGxaCvHqc8C53jph4fFmDRjpWg88dRMvI3J5dhozJyTjcZ/XFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PR5cHOhtFGseekMNp1/PSit1kcnWnmhOqFzse1gZGzk=;
 b=KXI3pkysTVREwPmcvs7LlE4H6pnlXLSqjdN92gcE7/plVprHy3QJndgk/9IR5K/i1GLZ1zYSiAC7m6i8JVIEpQkEfN+zVY5FSiHCDFpogJza0Rr8MZh8i4n/cW9qkgaKFv0d3+xX9KAMHERLt7WBY3R+DUGnt/C5IOwZTEoqWJ38w7nwVP07lX99JZ0dOBJUyQ9EXFEeJl/FtymIJfBxWxA+Q1of5D0bMuIOyYlYcI3I0dJgGalm+5vsyIOejaKvHvAgOqLxU2rJouN3TNliSWMiHrtwKjPwWcm2x3U/GUsAciBOURbAD8kbGCDnWHS7bbkmwWLpNw0lR88pFI+AHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GVXPR04MB10611.eurprd04.prod.outlook.com (2603:10a6:150:21c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:01:04 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 10:01:04 +0000
Message-ID: <e26ee0a6-5220-43b3-9846-7b594c4c4f85@cherry.de>
Date: Thu, 23 Jul 2026 12:01:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: rk3588s: Add support for ROC-PC-RK3588S
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
References: <20260722184024.1210447-1-festevam@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260722184024.1210447-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0018.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::11) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GVXPR04MB10611:EE_
X-MS-Office365-Filtering-Correlation-Id: 114b8e17-aa4e-4d73-db3f-08dee8a14ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|5023799004|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wAdTh4jiRWLD3R25MEccB1yZJfN9Q1yUgrcScDNUB/tTyjLO+1oWISmq7TkH79xBWhhzBXiJnD9b9keTCBks/7A+XJ4R5L627dJ22GQ7cfc8yDF06s7K3RPYj0BLcrtzg7952eohMseL0DUGAjkrOjsHEgf7QnCaxazeRNE+dWKl33axZytTDt8rjzlbs65xiCDfJym6VNmO3lO+EFAfzWJSeG9ycirFCO+g/PBVqO+DQYhAErZiKeu/LZFfb7v2SW9TyiRdEKZWz/EVwd7bZT22niIEqipkl1Gki/Be3AreuRHCmNnWdWLbI2JTTOYZ4O0gWjzewP6jYFfREh+qyDo9uNu5aUSX8Qa7pr+oNJAnfNBzH/Np6IpTF4BDhnUtuPKkk4OFcDAMyPvsKjMBR79Hfz412ON7k4rnglwQRdYvC7CcMnoWmCIMVN43/gnhnu7AnIGochPmJ9qEretsq8TL98VPMiClDENolg7taES2XGdQqlAK8aF/1SMPXmRuAZX22uHTTH9gPduoVCJWgQJ0sYj0SYvfQ0nSYjW6eWtzeY/aE5s+pk6C6Q4FVdyskeThhVyCVVMbTgB46gBM3dpRZsDrEVTNyoYLJD7z2ioSI/rGSfASr4xOLii3a4jWIMuK5SdeMJJHA1g4ivFxGSsJdRhlDzG5mWKAlMOA4j0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(5023799004)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N28vL0I4dzV3TjB2clRVZzdZOGtuU3J4R1hwZVNuSXREM0lEZ2E0OTk5Qkx2?=
 =?utf-8?B?UVJDeGtkcVhHWGJqZVdRWGpHV2dXN3M0elA5UVBsYnZxekxsNFVtalhsUUVw?=
 =?utf-8?B?ODcxVUdMY3kxNVRkWXM3dm1sVk5QWHhDQlByb2xEMFJlakdoV29IaEt3dGNn?=
 =?utf-8?B?eDNSV0MxSG5kTkdYalA4eGpXY09hMW4rU29kZW1LRlpUWnNQUG85Z29mZ2lN?=
 =?utf-8?B?TUhTeWYrRiszU3ljZk9TMXB6akx0bWRrdGhTdGxwdE5JeTdDSHlMTDNFbGxE?=
 =?utf-8?B?bW84RS9xQXpaYWRFQ2ZOQThaZTlDdlRzYjRzZnExb3o3UHZ0Yk5YTldQd2Ev?=
 =?utf-8?B?VlpLZVVrRmZjazErRXVvM3pSM3ZMSjJTWUxYOURmdG96RWhQZ2JIb0ZrSzhG?=
 =?utf-8?B?c0crYjdRK0oyTHJIN0FtdVVxVHZQWmgwVitpZ0JnQ3dsN05QdnNpQUZuRzA4?=
 =?utf-8?B?eDVOcnVBSUZYa2RhdTNnVHEwdFlOclVsanJiUHFGNzllc2dyWXNRQ2F0QVUr?=
 =?utf-8?B?UmFKR0JsbnNNR1E5TFR0dnFIa1ZlZkRvNDEvN2dvSFk4UXpwbnFPM0tEOVhk?=
 =?utf-8?B?SUM1UEVZUUc5L29zTk5jMjhwZmkrTmNWNzJsNXZaakt5NmpWbU83L0JYamp5?=
 =?utf-8?B?MFVXdnRsa0NQUk41QjZqMThjWmEvQmdmREY2SEp1S3RkYWd1Y3FpcklQRkw3?=
 =?utf-8?B?QkZ4N2t1ZkV4RklEUVY4MTlwM3NoM2NQc1plcmtoQ0o0Y3d3dVRiSm9EZkcv?=
 =?utf-8?B?cGhDMEtnQnY1VE1BVDRlRFVLeTNrVlkwSFdzUVYwUER2cklQMDlZb2ZDVUlO?=
 =?utf-8?B?WHNQbkszTXdQcndzdU0wMStIdTAvbjA3d0dIZEVSVFNCQU9CUGF5aHlBamM1?=
 =?utf-8?B?UEs0RnVnY091aEtYdlZFc2tNQy9TcEpMakZ6VGZZK05JclZYci9Uam43UjZ3?=
 =?utf-8?B?eXUwUTBkT3I2TmpsUVZqaUdPSEd4OWhoTUlkRXU5RnEzZ0JqazBXMERCRlBQ?=
 =?utf-8?B?enlFUmZ6eE5QR2pJZUtQR1NVMWZENFZKNDg1dTFQckY1SVJZa2R5TlZIYWlO?=
 =?utf-8?B?ODVvUDluTmdMNENrbzhMdGRvejVXR3MwR2ZHQ3BJbURiYklyZHcrTGdtRlZE?=
 =?utf-8?B?SEd6Ynl5WDJ6NCtDU1k4VThPcG1zeDlMbVVLYXVrbjRNSVZEdkRBNTlBSEV1?=
 =?utf-8?B?MTFIdE90bEdmUnNuSUZodHEybS94d1E1bFFVZG9xTm40VWF1MWRxRkxZbWdN?=
 =?utf-8?B?TEQ0RUhvMnZkaWVTT2FJbTFGQkRBK0JJZW5JWmVlUTJtMWdPd0VtQTJGRzFU?=
 =?utf-8?B?UGl2cFhUc0xsbTRVQ1FDa0twQXpOUVdxY1NkcWJZQnFRZkUrSVdUeUFvSit3?=
 =?utf-8?B?K2FJME5kNUtsS2sva1JCWHNUcWF4U1pGNk95YWNlNzNNSnMrWEdKN0ZFMmhO?=
 =?utf-8?B?dmwzY2NQY3htZTFrOEtxWGRnWmhwZHBBMURqaHlsbVNmbUE2eXhsN29jNmNx?=
 =?utf-8?B?Z0pKVmlIcGJHU3dSOS9PMG5ETm9MUk1ORCtZSWlKVDRLTEJLMzRpbU4wd2Nu?=
 =?utf-8?B?Sk9rV08yMGhaUTVQamdqelFWMlQ5Z2QwamdaY09LSjFFdm9RU2c2bVVxd3Q4?=
 =?utf-8?B?SU1ZR0pKd0R1bmYzYXlUWmdQb0k2NGhESzZvMVZEK1Z5ZUtRN1VsRm1MclI2?=
 =?utf-8?B?U3dvMXpHUW9UL25EWm9hdjg0Q2M1cWlIaFBhdlZqaFo0bm5xQkFWUnlFYm1L?=
 =?utf-8?B?WkUxOFh6T2NDOWdmYXhqaVRWZGJiV1h0OTZUN0J5dGZXMEt0YldJUHJuVHVv?=
 =?utf-8?B?ejg5aER3RUtUcEtCTy9Lem5yclJSRnV2QzV4RW1LV2FQZUJTblpNTEwrY3Bo?=
 =?utf-8?B?S0lrOHlpOXRDVkhSZHM4dkM2S0U0RTVGVGp1bVFsM01FWTUyNUY3bUhRVm9N?=
 =?utf-8?B?aWo2ZWdiNGRqa2dBaFpFWG5icWk3bzgwNklHNWlJaXd4QzhwNFBrOHJDZG1E?=
 =?utf-8?B?V0QvcGNrSVE2OGVQVFNZZWhhTmUwWkJlWW4wbnQ5VzVwcFQwOEZaYlRWKy91?=
 =?utf-8?B?MGRWd2ZJT3VCcFAvSWxsS044dHdHckRtWXZIelE5VUEwc3hwUlhDTThubUNh?=
 =?utf-8?B?djdTYlJKU3AwRTNZVVlIUW5iV2hLNWEwajhPTkNCUVFweDh6ZmI4SUYxRDg4?=
 =?utf-8?B?Snl0R3VMMnNkZG5tVjhxazFGSzhZUUd5RE43OWNOdjBRbkVKd1R2TGtzQjJ1?=
 =?utf-8?B?N0poOXg5UmRhd01OaWpTT3JhVTAydG5kTWo5QVJ4aHp4R3JkQ1hJZThhVFdm?=
 =?utf-8?B?RzRTUmFrZWxTeXRuVmxXQ2VHTWQ5S2t2Tmt2VEM2T013VVJtOXhCdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 114b8e17-aa4e-4d73-db3f-08dee8a14ecf
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:01:04.4213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84gfJyygtzoKcfBnC0xxuE156OGNz/UeX58+08gOxf+4JWWYAztSAdttDXl41MR3swDnnuw0nd/EaPPDGl0NNOjXojDk910Ktt0k3tub/1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10611
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PR5cHOhtFGseekMNp1/PSit1kcnWnmhOqFzse1gZGzk=;
 b=S/AQ3po04Y0xu/r2Fld5CasrCYoL98dDbIlNRGlzYCV88pb5jOLwWF4g/n4ScQvpvIC7gLAgL3xRYlHHRVrUktdyjoRJZV21SHbJq/FDRmfL+h7fiEDWR3S/urn7UuBKcUyjbR8apWLtWnw6kllW1rQNFm1OI+XNVLIydCzaOJw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=S/AQ3po0
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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

Hi Fabio,

On 7/22/26 8:40 PM, Fabio Estevam via U-Boot wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> The ROC-PC-RK3588S board is an SBC made by Firefly, based on the RK3588S
> SoC.
> 
> Add support for it.
> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v2:
> - Drop the USB device-mode DT changes until they are available through
>    devicetree-rebasing.
> - Drop the corresponding USBDP, DWC3, gadget and UMS options.

Just to be sure this isn't an oversight, DWC3 is used for 
usb_host0_xhci, which is enabled on ROC-PC-RK3588S. I see there are a 
USB-A port marked as USB3 on the product datasheet, and also USB OTG 
that is capable of doing USB3. I couldn't quickly find schematics to 
verify what's what, so does the full USB-A marked as being USB3 capable 
still working?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

[...]

> diff --git a/board/firefly/roc-pc-rk3588s/MAINTAINERS b/board/firefly/roc-pc-rk3588s/MAINTAINERS
> new file mode 100644
> index 000000000000..a0316cab1b92
> --- /dev/null
> +++ b/board/firefly/roc-pc-rk3588s/MAINTAINERS
> @@ -0,0 +1,6 @@
> +ROC-PC-RK3588S

It's actually ROC-RK3588S-PC (c.f. 
https://wiki.t-firefly.com/en/ROC-RK3588S-PC/), I can fix this up when 
applying if you want, if there's no need for a v4 based on feedback above.

The files are "fine" like that as all other Firefly ROC-* products also 
make the same "mistake" so better stay consistent :D

[...]

> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index b565aea311e9..d56d245dc114 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -155,6 +155,7 @@ List of mainline supported Rockchip boards:
>        - Rockchip EVB (evb-rk3588)
>        - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
>        - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
> +     - Firefly ROC-PC-RK3588S (roc-pc-rk3588s)

Ditto for typo (the defconfig part is fine).

Thanks!
Quentin
