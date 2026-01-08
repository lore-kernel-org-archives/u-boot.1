Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBCDD185F1
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8068A841E2;
	Thu,  8 Jan 2026 14:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DfgkTX6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5425F83A26; Thu,  8 Jan 2026 10:53:10 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C9FF83B8A
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rk3gQXxeUgRSNpml34tPQSbSr2/GlDuNw6ALTQfmrEfHIifddmtGfSiPkDMBAV7nFy6L9fJp3+Nu8/H9KpjtwNh0GDwX2vTvot12kDNcUkTPMzn9tj4fzr0tT+X0boiVgyXuYAS6qZ2V+tJyAUStR+KmnIFiW04eTaIt4t1o/okQQTzRdeJBLb8QL8Xcj2kVJotMn4puXbgl1SWnQlo1EyeEF4y7+kbYNh4Ga/pBO70iYPxT+DWu8G2uX/xZ8H0NtZynkTAskfObZZpvg5/GTyQKL5ioqkUjsXGqHW1FsTwo/s1wKeOiOO9gSiiBZBDjg7l0bMdI6bcYevBcJmYkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MZN3d6cyl2kqb1EHJ2dTzL+IR35e+SXJMN7stODALg=;
 b=e3FxyZQjZ81VhzG2Op9QBqdZSIXFBfM/56xLpaXnnE2oFb0rEOo0S2Fma8kVCK3QbhiTC+OxF2+kLk9BOeD2kHlNFk3Dt15cVsnjzvL7Aqb0lmKml1beIFY1pQIqXnhlI+ZTHx9U8Hc+iFGU0sW4fKwsKE0riHNxk9Nlx8pF1X3QUga1ldl1t4oHlqOX8JUoCl4KEq8qOAq/xKARJDz+w+yjshCFzte2M0ZVRG+2zrX4qf/5Wx8WUD4HERr+rwlcgupTKKRBW/Bru7UFP1J0mdkqUQ7uBoZ+S+qBrZg/VKT4pXygdQfTa/Z2x1CjXUqDu3YeScISZHIEY/0+siR6Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MZN3d6cyl2kqb1EHJ2dTzL+IR35e+SXJMN7stODALg=;
 b=DfgkTX6S7synhIUG1wSuWK0Y1LBCQn0mMR28wRuowzBZT9BucqWk9oQPqH33VE8sUyJAmbbJmfSoe7Ko87WrdCPQiWLDfIgKQrgLTnySZmPm/M0fPevNLYnfp1m3qVTdKBPJ/8UT2/ElAjgXB97yoYuPYYGFssIwoSvDBPgJHIi4xKUcfTKN2ygdOY8mMddI8jSVtfAcATsvXCzLktGR8o5BNUDxVAulIPle5TpXnllQzTealBJ4SkuI/yOBckcPdrtOwYzBLIfENL39FcC+nsZGPESGHGRDDJ3RRUNyCp9v1mU+UWRAhUYdJtUu/EcmoubYXyZ/bBcix2bX+NCCKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV2PR04MB11681.eurprd04.prod.outlook.com (2603:10a6:150:2a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:53:00 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:53:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:50 +0800
Subject: [PATCH 05/13] imx93_evk: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-5-0d5921c575bb@nxp.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
In-Reply-To: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GV2PR04MB11681:EE_
X-MS-Office365-Filtering-Correlation-Id: 691f1465-6b47-4824-1ade-08de4e9bb534
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3VxY2pYTnVzWHlzTktxNlNlNTN4TGNpMnFuRkRIbXFvdjJyb0MrTmR6M2RI?=
 =?utf-8?B?Z1JnV0ZTdGRkY3pnaVR4V3NBWTBUVjNhNnRoYTJITmE2SzVLbjA2dTBLbVVP?=
 =?utf-8?B?eWNvdHdHV3daWjR4a2VHbHlGTG9WN1Rkalptb3g4SFBwOXNyS0kyL0tTL2pO?=
 =?utf-8?B?c0RhaTZmeFhJZ2I2eTJSbWVINEZiMzYvS2E0cCtSWTZUSDRpenZHN1JITytj?=
 =?utf-8?B?SWxlRnMvQzhvYXFmWm55cG1ZY25YY0hlWW5uaHVLeldGcG9jTGpSTm84VHM1?=
 =?utf-8?B?WnBSbFNSTGpIcXpTekZIbWRnZkhRZUxTLzlnUW9WNlgyb1Q1TnpjRjNNQTFu?=
 =?utf-8?B?dzlJT1lsbGgxeXJoNVMvWnd2SUwvTHBrdXlIYkE1bTQwZzhCN1hhOUkrNE8y?=
 =?utf-8?B?UEdVRGNyS2hQUndlWW5ZcWcwbktNNVNpMGJnVW92YnV5MWM1RHd5Q1lGS2ov?=
 =?utf-8?B?U2dZT25NV0RpNGswTkxiWGZ0RDYrQW9QYWZEbkJtOVB3V2pJNUdRS1ZxbWNO?=
 =?utf-8?B?eDJDUVpBMXdtZWpScTI3UmxhUERGTEJ2Rnovam9tck9lQkhmMzZ4RktCeXcv?=
 =?utf-8?B?ditJOXlZYUVJb3B2RXZtWFRPamNFcWJGV2lBKy9FWEFqd21hNHE1Q0doMGVx?=
 =?utf-8?B?SThEU2dPbXprenpkYVJKVWFyclV4aUxNZEo5NnBlSFZQVklPcHAydkVIL3pO?=
 =?utf-8?B?dkJ2VWVmSTVuNUwxcXpEb1Yzc3FQZ3BNQlRNTm41L2l0V1Y5R0xFbERQWmMy?=
 =?utf-8?B?K1k1dGUya2VJWXhtZG5OMUx1c2hycnFJcFB0OVVkRzVoRFJYVHJJeEtpNWl0?=
 =?utf-8?B?L3VZTk9ibXVmdlhiTE1rdEFVRUFUM2RYcHo0V2IxV215MzBsR0dkakZzSE80?=
 =?utf-8?B?RUZoS1FGN2k3bkNrUU5XOFkybTdRV2wyZTJqakt2T3BJM090ZHlhOGVITFJo?=
 =?utf-8?B?WnNoUkI1VFI2ZGNzWStFMVRHcmdrZERaY1N3bGp1c3FxbGh6TGZwNnRQbG8y?=
 =?utf-8?B?em5OMUl2ZUtHNDEwcTZreVM1aXhobWZtWjdObEhLZlMrWi9ZTTlFT3NnY1dF?=
 =?utf-8?B?ZUUzdHFqYlV3UEhEbld5ODQ2MEtUVkVyeEs2a1FqOVAraXQ1NURaUkx1WmVV?=
 =?utf-8?B?cDJsaWUxd2dQem5XaWtPd200bFNBSHl1M3BRUTNXNFZYMVp2cTIzNnBKWHZI?=
 =?utf-8?B?N1l0S1g2NWY5TW13UGo3bXdGYnRGb2xTVzBWbGpXVmJ2dTdGZFhqcUhOZTZ1?=
 =?utf-8?B?SnpHc282Y3E3SDRwNDU1U2NtTEhjN05IWkYyUlEyQ2hvODZUSmFpYWQycWFh?=
 =?utf-8?B?SE9zZVVJaWJWN1RsQkNOMGdsb3hxSXhrU1g4NzRycDNVUE5VZEdkd2VjTng3?=
 =?utf-8?B?aHZrVUEwbDFkSGNwRVhFWDh2d29oRDhzRXBEdVFzc3VCeC9PRzlOZkFkeEVN?=
 =?utf-8?B?RjIyR3BZN0RldUVTT0pCbzF2QnNha1U0a3dWS3p3R3d1aHVQb0k0bFI3UFRp?=
 =?utf-8?B?WU1VWDF5WTZXS1d1bGVaMGo3NFYwZE1pNDdrN0dib3didzdycGlTQVlHY2dO?=
 =?utf-8?B?Ty8xVUV1QTVxVnBUUGxaY0x2NGsrQWwyTWZhRGFyTGk3N01kQUZLWDhiOEpG?=
 =?utf-8?B?MXhrZG95UTZaUklkbVljR2MrWnV5TDFuNGZyQmx4MXQ0UTI4bE0vTklXZXAz?=
 =?utf-8?B?Uy9YZE51NFpsaksxWm9iNm5yUzA2Y3lBclBiTTdwODdpZTdiMGxHb3FIOHlv?=
 =?utf-8?B?eTBKMEk1YVo4NUZVYWkyNUpKaFZnS1FydVNFOURwTEtFUXh5ZlhYdFNWalFP?=
 =?utf-8?B?aUdDR0JvOGEvVHNBVTVhUXFKUEc3aE1pdFVmbHpVemNUWmZiekRsZW1FSlk0?=
 =?utf-8?B?QndCUkhHZnh0bndnYmtpL0FSZmRQYWJKY2JCcUo0NEU5c01SUURaLzNxWVlI?=
 =?utf-8?B?S0ovam5ORnlvaCtwMDFLaHRoK3lzL1JLMENjdzJwSDBuanUyVENJZmF6dnhN?=
 =?utf-8?B?Nit1ZnVmMFdsSDJqWlAybi9aaExEMGNnOUMrR2RwR2FwL3VOMk9oVnhrWmxG?=
 =?utf-8?Q?OoQzhy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVFkQkg1ZDFOcGZLNEVkUithVWl6d2pnZ1RXY2poNnQ2YUZ5R0Ztd3NLcFcy?=
 =?utf-8?B?cWdkc01TVjNONFlKaHA3eU1aZlp3Q0NiakMzaWlvNG9xOGZQWWNEOHh6dUhF?=
 =?utf-8?B?NmF2aitaRVNlKzkxNmpGYzFXVlFmK25ReDZkeXgzd2JLbTZhRFY5MTJ3dURz?=
 =?utf-8?B?dUtNYms0K2ZLdkJKZnBkZWFWZHRwS1BRTnk1YnAwZkVaNy9Nc1B2RmRBd1JE?=
 =?utf-8?B?cnN0a2hoUDdWVnNQZVg1eng2RDhWQmhHNU5ZamhqZHlid0kxeUlCdDB6VjlM?=
 =?utf-8?B?YWhNR2N4WHFQcU5RM01UY0xRNHYwUFlKemw5TGRhSGJYRWRFb0ZKeDlBQmNm?=
 =?utf-8?B?S05xR2pHWG4rL0laaDZIN1dpTVdiU3JlcVMvaVdrR25lZ2I1aGhrSXlYaW1U?=
 =?utf-8?B?dGJvb1dyak9saG1sYnpIbVB5SVNQTUIzVDNBMnV2OWEzdHE4VmVSWGYxQXRJ?=
 =?utf-8?B?TkN6QzgxUkhIQ1luNTdTblVrQjRBL1hMQ0N6OWV5c2hjYWtzazE3VmZDVDNM?=
 =?utf-8?B?bjE0UUsxelhLR0xsVGYwdVBWVWdWN1cvR1p4bkV2Wlh4RjdQYXQ4QjZvUFpP?=
 =?utf-8?B?cktZVCs3V25EelRPUVhiTkdIRUtmN01vQXVyVVFRZjlOdVZUU0VOcms3RW5X?=
 =?utf-8?B?bVU2UTF5Y1A5TEVwSGZsdGNkZGQ5anNGTmRKUHQ0MFdHM3paZ25Ud0x2OE5o?=
 =?utf-8?B?Umo4enljdTJrN2JOK1FReUYzdEVwcW1CeVNwa1pPRjJicUgzU3owTU9wVUx3?=
 =?utf-8?B?dTVHVVFEZjI3bnV1MjVwZUgwc2tpQmRWT04yckNQMDN5bXQzUCtmZms2UFd3?=
 =?utf-8?B?QTA2T1B3QmhYUURZa3NzWXNndTFMRTRRTHlwYVJSREc2RGwyYmh3UklXb0Zx?=
 =?utf-8?B?dWU1YUR0em5hNGVKbS9PLzh4a2dmL0E0QytwSkVMS0F5TTRpNnNkMWlFeWpM?=
 =?utf-8?B?NHJ6dDBDd05hYWgvRDhjTUd1ZUhXOFlnVnhtTE1uZjVFNDZRUXFkOFdCVmdt?=
 =?utf-8?B?aVpsanVVajg4bVlURzA4Z1kwYkIrSmM5Y3dqMEF2Nzl6VjFsT0VIVzZGR3hp?=
 =?utf-8?B?aG5jMkptNDR6OGtBNlFKd29XL0NLTEthL1dweHkxTHhyQzViYlh4alFSSWxl?=
 =?utf-8?B?eldKQmN1SVlVVC9RWW5tU2xnb1R6Y1RyeHR3K1ZQZDFpdjhtUDgvaU8zaklv?=
 =?utf-8?B?Nm1zQnhFNS94MTJTQWlBcUZUZXRkSVF0amdsNUVBN0JjYWE0QStmZytCOGpp?=
 =?utf-8?B?U1RKbnZuZi9BNUdzSWhhbE5ISDFtTWpHN3dCSXFqVFQ4TnRjNVZFcTRweCtp?=
 =?utf-8?B?akxQQ3hJUEljaDdFazh2L3dmK1ppRWx1VTQ0KzZROHVna0Z0RTVNem1wYXN0?=
 =?utf-8?B?MFkzNnkwUUg0eEhHTzErSW9ENnFsMzJLNmM4VWRvZStrbGhkaURDTGRuQjE4?=
 =?utf-8?B?RkFiZytxbmZWRGRPeEd6THltQzRvMjRPbURuUDhkeU9lL091K2V3OWwwNHVv?=
 =?utf-8?B?dzlSRURvbitlL2xtRFpGOFRQeW91b3RKejNyZDBtQWRveExSRG5CNHNwajA2?=
 =?utf-8?B?Rm5sOS9qUnI3c2xXaERaMml0U1UvYmt3YjQ1d2QyYmFhd3N1MnZwR25Hdzh6?=
 =?utf-8?B?TXYyZDVibURBT1hkUDBjMkJKS2hTZUs2THorREQ3bTRvNWpyTk9CRVBiQ1lm?=
 =?utf-8?B?bDJqVjVTaXh6KzkwV2Q1cCtFeDR5c2QzOUQ5TkNBR09pMnVNR1Q4WmExWlZT?=
 =?utf-8?B?WUFwVEpYQUVIdlZDS3Y3RDEzeE01VGZGU3lnUDhHTStvczhGQ2dRN2lOdUJD?=
 =?utf-8?B?U0xvYUUrbSt0ajlzd2tPeU1wOHN1djgrWFUyUkVEQm1XSmY1UFFkTS9qMzhi?=
 =?utf-8?B?Uk94TlZlck9Ha2Z6dnNLYllkV3MzY0sydXdRSUN0TTZPeFpkckhBRjlhUGc3?=
 =?utf-8?B?cm45MVVWUFVKZ2k2eUQ2elgzeENHcHNZcUdaRklqZ2dBM2pnVUhXZ2VmRmRF?=
 =?utf-8?B?ZVpvdjYvZ0pvWEVsQVVpRnI4NDFQQ1BDVERxR1BCQzgwR29URS9ycjRiNjdU?=
 =?utf-8?B?RE0vb1REVWNyYWhHZW5NbjdaOHB1dmFwL2RmaHlBZ2tuNHhmblZQTXVnUFJ6?=
 =?utf-8?B?M0R3aTJvYzFRdVFaS2V6T1BUL21Mcm05TFovQnlRYlArOGNHcU9QOFZpdlQw?=
 =?utf-8?B?djgzUWpHQ1hkVFRTTVErQldxSDVKNDg2ZXRMcUx0MWxzUkZodExUbW8xeitI?=
 =?utf-8?B?VXdrbjZaZnN0U2xURW5SWkJNSHErUmFWZnZaNk04SlZQMFBvRHFkSDBxSklW?=
 =?utf-8?B?aTY2dm9qVnNwSWlncUdWVElKT21rNGJWVHMrMHA3aU01a1oybVNPZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691f1465-6b47-4824-1ade-08de4e9bb534
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:53:00.2190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 895aoc2dg8hzsJ1TqfLyrmPtcgJG5M3CZTLHaV7rYXrMcOlbBFjw5VATykmpooWA8PLj69b1R1R7K3D1ZYSSoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11681
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

From: Peng Fan <peng.fan@nxp.com>

Drop unused headers and sort them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_evk/imx93_evk.c |  2 --
 board/freescale/imx93_evk/spl.c       | 29 ++++++-----------------------
 2 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/freescale/imx93_evk/imx93_evk.c
index 0278ef9805f..70b07fa3c6f 100644
--- a/board/freescale/imx93_evk/imx93_evk.c
+++ b/board/freescale/imx93_evk/imx93_evk.c
@@ -7,8 +7,6 @@
 #include <efi_loader.h>
 #include <init.h>
 #include <asm/arch/sys_proto.h>
-#include <dm/device.h>
-#include <dm/uclass.h>
 
 #if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index cba8ccdc01e..2e4de10fdd5 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -3,36 +3,19 @@
  * Copyright 2022 NXP
  */
 
-#include <command.h>
-#include <cpu_func.h>
-#include <hang.h>
-#include <image.h>
 #include <init.h>
-#include <log.h>
+#include <power/pmic.h>
+#include <power/pca9450.h>
 #include <spl.h>
 #include <asm/global_data.h>
-#include <asm/io.h>
-#include <asm/arch/imx93_pins.h>
-#include <asm/arch/mu.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/mxc_i2c.h>
-#include <asm/arch-mx7ulp/gpio.h>
-#include <asm/mach-imx/ele_api.h>
-#include <asm/mach-imx/syscounter.h>
 #include <asm/sections.h>
-#include <dm/uclass.h>
-#include <dm/device.h>
-#include <dm/uclass-internal.h>
-#include <dm/device-internal.h>
-#include <linux/delay.h>
 #include <asm/arch/clock.h>
-#include <asm/arch/ccm_regs.h>
 #include <asm/arch/ddr.h>
-#include <power/pmic.h>
-#include <power/pca9450.h>
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
 #include <asm/arch/trdc.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 

-- 
2.51.0

