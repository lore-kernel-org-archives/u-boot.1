Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72E606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wDDPBfCK;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=IlKsicLT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9170980FB4;
	Thu, 29 Oct 2026 16:17:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ltcQxrcNMQIg; Thu, 29 Oct 2026 16:17:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD19B80D58
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793290676;
	b=onsdR/FRx2GZejmI/m/fXwy0MdWfkag0s39YZi4qQlOhDErQ087rlDKIeRVLyaateBY6
	 8cfmny04FEWDS5xVUMgFcCVDPiiRN+NcKd7cgApMaDYcTSjvr0dUKpViZxCF4JdiH871f
	 +Zi3xnmfqIpQ6Wg3JBD3evF2GAniCaTLxrAR3jn/FgpHgwew1oxPwVnDxLXFopwPjvZ4w
	 Ik1DLxXvgEDRqyaMRjkPUITAWY/y60bMiHNNw0jmrF9YQEVu5JN3/V3Cmr9nZBAxTFGTD
	 e0Ctkq0cw4nBanE0AcU7CH76fnLaLLeBHrJKDuSNMBIx+jg86HNVPGBLnUqwgTSlLeQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793290676;
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
	bh=gWc/OZFPafWZlkAniJxr3k8j5xedUkxEjkPReOMJoOc=;
	b=KSBY6+aZ4rQgDHEKZcsgXrLDkZ/58+3fKgrEY1Uosk0Hazv7viIVZo3gRk3KdOVyTqdX
	 P+9E6E5JjltoCPLvZ5KLlRDC3YMVvYwI6SmATUaXG0Y5W4MwVgMrt6MQAnN7ChJuE2QrK
	 iv+eiwzSuu82xKBzE/WLG1yxGCsL9BWYFx3BJxa52ZNq4p9pLtT56J3PjhlG0XeEYDLRQ
	 G36i7lONo1ef0WffV4HiT7/8g0sFTkzSlM2nohnYN9y/dQp9gc1tgbS0YSTeW8vbLFsCl
	 f61aHZbBLejacXfC1k+pHOIi2oKewWodlPgFn4HGixvI6z9gMptsWdiOv8AzyP2jE9Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793290676;
	bh=gWc/OZFPafWZlkAniJxr3k8j5xedUkxEjkPReOMJoOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wDDPBfCKt0LoCYCk0eX2bWFHspvKvroBp4TkP67+TI1CWUgvWdIajdstWgjXKoMq6
	 OcCk3890GNz6d8pDfRF7J7Clp2nHo29WgOXridC3orJXnPhmMD0nbRnYc3kmLO1Ddd
	 c5vMchEdmLBdnuP34s8d7zYC5j4NuwaujxMmz3ZY14sDcgD66Y+Tfh5w20fQtoTT/M
	 vfkva0NotWlZo2S1Rrbgc5pDOTEsHnh8zlqffm5VLCamUO1nzGvSvSZCddJpA4kn1r
	 okzhwW5qdEBwYF7ctHLe0Yio/1+gAM+O7P5WQcl06OcJFlq7UVvZJiqQm4pY2iVJUq
	 AanqXE4sNvTrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD19B80D58;
	Thu, 29 Oct 2026 16:17:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E2E8362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 22F5940737
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:17:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dXLerhaztflc for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:17:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F09E40707
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793290674;
 b=opnTyaYw927uCdQ3BjSvbB/AjgUC6TKUKvwAMxeaeO6x9lltAA5khDJjPjBSGxKrJFcW
 fHKwuA8Q7BLvmaktoXoo95OvKYt0qnPk9teTjw1Oa9Xvmc+hrh+K50XUhZI5hrX0qH9+7
 HTHWEnsdFsl6/S9i71hj2sHC3VSjV6JP5XUilqzWqaeAVlF2dBog4CLPwC52rDD6g4WNz
 kY5P7d+d6IIs1OwlrAkR/f/6teMyhKVY0cJedRHH5AXFngAr11IikGNYsGpk9QXiG8k/t
 uAjfJXyqYNF6OA96v4rMKx6ssPvqyqbVYaVOk5f379B+bKjruTDwaYW6qgwB0yu5+Lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793290674;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=gWc/OZFPafWZlkAniJxr3k8j5xedUkxEjkPReOMJoOc=;
 b=Zy3WgUetlf2lIJmxjDrgHSXBT0zudZeZpbALpBJYkBFjPvVlpF1A+VYmxBJ9IbuEzn71
 ZFQaiAaQs0jJOWmAvdIvWwLmY2cHYdCnMOKzruH3sHLkIXtB9iXvIP0Cf7koGrP2RpdqJ
 39lCCsZy5k818m7rkOCaXTKyPFpK7sVREviPcMr7uAdt+grDJ6W18XTs8ymXFLE61jM15
 oRutPMMayJTT8yADoeusm5fwj6Yn52dT0qHNisJ/PdcZpsLISWLVvSuGKD6+Kn0M8CUur
 7MWvia2C6l3dAo0vDpUmDoztxEATjyqKJWfPm8Xv2+nK5Kg+DtvCgWQ77MmgecmtNaw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=none header.from=kontron.de;
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=IlKsicLT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=IlKsicLT
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F09E40707
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsZUv/hvXTe8UkZGD2XuMNfj5SofMshzjZ+0laN9aeyR0QVKT4qvaE2yHTTEgTErSRJ9SSBchkoPfDxGk9cPgPHCW+fcLSPLuHjobv+m650BBgitA+N4pwapLGyC4kqjQ85vwLQ3jg0hJh9SOAaAWHcUGFr1+UfRjn0aOd134XHeOwbRiGTSiq0v+c4/Fe4Kd8q88dyGOwsPQ7c9TKwdg+h4HUJFpMvI7Q8TSP7CqYcoXvnO21ZfESsWsyV0p6zJ61JmDVP4a8HESyRVB703xo1nsOwL7+Mg9GAzwZhzlABExlbCNB1XlMeRJ30E2HHnvV+nnRZ2sACrcpOXN2D9ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWc/OZFPafWZlkAniJxr3k8j5xedUkxEjkPReOMJoOc=;
 b=cmKH9kUiwwY/Ovq4GkQBLC3dHXmgpt28svUEAOiBI3CdLUzf02qi8wKzRRt2gBg3DJrsU+31YVyh74JDCtBkzUts3GrRgKtxbIcVRC9AzEcnO9diiLcRVxXriUNN1WSyUI/TIuv2GYL5xF9+4myuDHO1FmMVwNNa94cIVI2cd2VtymsIpp+hoZOXqlcKd5DdjWYvlSd7RkUb7XMcs21oLkxNWkRdwVEi+LwsEoNTMjX9oxVTj4G3kzT1IXBmXlYpb/vUGDwbmnzxxlExE6z4uQL+H8vUksnklsnoFCG8/tdakgt3LmlGR0FbNnudH9bEztHaqjY/D/XwdAELBFeKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWc/OZFPafWZlkAniJxr3k8j5xedUkxEjkPReOMJoOc=;
 b=IlKsicLToqFxWudePpEq/s53gOjokLbX07+0cJQGetU1dxHbApKlbKgSwoXlITJFTz1IOMmalZUr8Q/suP37uq6lUSIh7HfGqwGPty5zOrHwISlmY5UAqGjM6GG8Y8S7s7TEIPVEWOVWzNmBkZodKqmQZwzOTSt+tdK3cNluCUDoZ6V+g6tJTKfaqWlCrWwDdOS7NlGfz3rFj0Gf/pwe9/BYAWnPzInQ+Jf6VA0N/ENRvVRf1jqLTc94xQBkrD01WOsDA+1xvuPczkuhHUoykS/uVHiTiLCeG9MonhxxYOaHbl3NKGqPst/hlRBGxY0Wq020+fqG559P4CxcUz8T/A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GV1PR10MB8385.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 16:17:44 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 16:17:44 +0000
Message-ID: <cb7b6e01-8cad-40cb-92cb-bddde0b58eec@kontron.de>
Date: Thu, 29 Oct 2026 17:17:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ddr: imx: keep ddrmix_initialized out of .bss
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261029160513.666555-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20261029160513.666555-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::7) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GV1PR10MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a571c21-92ba-4de3-cdef-08df35d829f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|261009223027099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8mQE010A9tdZ0gMKqB2hFk/ktJXIGlxo9xMSF5ZqtZ5xf382YsANbUvY/p5wmR7gjmRmGDstNbde5Dl2HhgJQ9LwVsXkfQZbswYG5gZ7Ag4kCEpWSa8FZ9m+JIz/XMfkuBwPeb7o+U61YJOx4ARs7nw/ph/+DcatJ9prJy/jwetJDl8shVhyQUbkgb+Rug5lwAeZ/XsVxHpfBKOfSIyb5rodlLBKHhYXPAlvr5k/wBiMIgo4Vu6MvFXYq6b+lnVvotuPmq+cnjjftq9VY+kmi5MQOnDt6u9ESIGGtsE1yQ9IOP1gJA4pNpL19t89sb79NNi3fdzgbOudeDehwbqGegsVV7W5CNle2dj1xepj/5mOGeDqT3+Q/PrsVCpYW9ku9Adcr4ZumaBcyvFIko9GO9e/TWPSctA3flNxTZ1ur2CMlH0EVOtDz6w1uHcJHyDG8s3mGcPd5Ez9/qWEYlrByD6HqTa/UxQ3UrdMHKME8yHap2Q3cmwD/YozL0TedqAfIgdGQs6Om1KgjcIRd1zl9tZRteFsycLJ5e6vJON2BS+E05QEBnEjklE1jOW7fOXuVCDWIzmwqPxGqVBT4GGnXLeCZu5g8HQw3o9tXIpvArqCe6Me1SzM2GmKKTf+XXDTcRKnSFj4cV9MgfTRYZBBXX1pXZ7V6XqyEL3GD22/ahk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2ZaWWdKVGNKVUY0V3ZxclJGb0w3dHNubnRNYUVITlJZU2xtVzdVSWk5RVF2?=
 =?utf-8?B?T1BCYitSZFlrT2J1ZERWVDJxdHNnVzU0Qkl0bWpyNGNNR2hPZzB4cS9hWUNr?=
 =?utf-8?B?cnJubUhGSG0vV2s0VEdEbHNZOXNqWmFQRm8rdjIwa2oxNUhmd2N5S0NjYVd0?=
 =?utf-8?B?TTFyMllSYkVwc1V5RGluMXhkbFBTUUhodGVvUUhaeFhvdGdSUkZhM2pzVDRp?=
 =?utf-8?B?WWZ1cFpwS1l2Wmkya3o0RFI0ak5zSWhYQWFwY1FnVEVyVi9uQjZ0cERYUTlS?=
 =?utf-8?B?dVFSRHNOeE9DNVlBZTg4ZUpYVjQwbmNEK1c3ZFd3bmZNajFxaEd0NFV1cGx4?=
 =?utf-8?B?Ny8wSE1xS2srREVBMmtqSzdic1BML3dCUTBBTkJ4U0hxUnpXbVgwVHVCRk1C?=
 =?utf-8?B?dk51QlU5S2hEZ1ZrNU16QWQ2Ykx1STlZaE5tRlNmYWZrUitIdFhoZERHUEVW?=
 =?utf-8?B?SmVKYzJ4VVowTlJ1WVRaUTdQZk9GWmJFTHdJVG1FM2prRVFkcjdrUFA0VTgz?=
 =?utf-8?B?Tm45OXMrTlBSVlZiajVURzFJNGpXdkxwdHJnSWJ2a3pRLy9ScWhTeVNRdDIz?=
 =?utf-8?B?cjhYbE9yem5SekhJa3JQWkZNdTA5R3VaNDBNeG9HeWtmNXBTNVlLN0U3YnJ6?=
 =?utf-8?B?ZlRaYnVZdVgyMlYvbTBOSWtNUDg4WjdDSEd6U1Y4cXZ3N1VuOVNIcmhNTldV?=
 =?utf-8?B?Uyt2UGp4RVI5M3JncTBqZEtDTkdRYWZWeXpOTy9oWHBBdkxkdjRjYWQ0ZFU3?=
 =?utf-8?B?Yit0NVdzby82ZkpGQys3ZllmeHZDL0dHZXRBZy9DOVdZQ2V6bXdZemg5cWY0?=
 =?utf-8?B?VFgvNDJtTW9ldXRqU1RJNW1ydllzVmx6TGVnemxMVlE4M0FsaFlBSmhDcjdK?=
 =?utf-8?B?TUw0dmNCNXkwZ2pqdStWdVIxdGlwOXROblBYVlNya0RMZ3pjNmxzQmxSa1l0?=
 =?utf-8?B?Ry9UQ3NZV1FhQU55ZmJ5Rmk4dHdvUEc1YjVxRkgzNVdvdzM5NzZIckhaOUhV?=
 =?utf-8?B?S1Bjd01xVW54ZnJmaHFsck5wS01NNnVZVWIwK3lPd0czOEhkdmtGdHNONGxR?=
 =?utf-8?B?ejhMSlNzdy9CSDVsNEdMYkFBRzM1dDNqSmZCY3dReXZTRGtGOUJLcTBWWms1?=
 =?utf-8?B?NkZEWUN0UUFHNGx4M3g5dXZlYlFoUnExZ2pPQlpMWDcrZ0lOWDlrenNndGto?=
 =?utf-8?B?ZlpvWldleHRCZk9nSGllaTV0Y1h3VGtSSE9mNFJIeVlzUVg3dVN6SlBvWTRS?=
 =?utf-8?B?RkZWcmw1RDMzaUlrUFRSSEplSkxVZWp3VUJFZUxRN25xenJyUkVSTmV0NnQz?=
 =?utf-8?B?UEtoRmlXVzJjY00rU3BwTjBWWlNDa0w2WGR3K0xhNnFubzZ0M20rdGZIVW1z?=
 =?utf-8?B?YXBrNHBTWEF2NGxFM3dyZEVwdGlWd0dzZkoyT2VCNWxQcHZ0Q29Vd1A5cW1q?=
 =?utf-8?B?YkVJaC9QTlZUZVVTaTRYQXpDZXNac0MvMEtYTHVqUC84bGp2aEd0cXRFcU5N?=
 =?utf-8?B?YnVObzhnb3Z0ZW84bUltRDIxQXJuQXB1Q3JkeWZRN2x4UXp1VzJDakhhbFB2?=
 =?utf-8?B?WE5FdXZTNFQ1cWlqenFhNTR0a3BJajRJb29uQ0JRUHhFVFlWMEFxNXNFK1k3?=
 =?utf-8?B?eHRyZVE0ckw0eGpXWGVETFd3Mk9ac2tqVDRBZkhJN2Q5akFLdjkvSEdxa1dO?=
 =?utf-8?B?SDFZajFBdUF1ZkZvbDUzbThVTlVNM2U1d2x4b2w3RmZ1RWIzdlhHWFBUTGZF?=
 =?utf-8?B?RG9PTG1wV3VBM09YNWpHdnJZQWdGcFdlbnNMR0wwdjhzUFphejl6dEg5S3Zn?=
 =?utf-8?B?MDN4WmVzOHNpMjJzdkp4SlBmYXE2TjJVVDdLNVN6MlVCQy92a0lRdXZOTzZ1?=
 =?utf-8?B?VUJHZTFyQkRlaE9lZkZCRE1ZY1FVQ25INHlURGtxdXVvK0RTRE9vMDg4amNx?=
 =?utf-8?B?QjBudzRCaVJodjZvT3E0aWVjOExiRS9aWTU3S1dhSFNETVhoZDJUVGpYZkFr?=
 =?utf-8?B?U25HbXpGZ3EzTitPcGI1MGVmaFZ5RzRHK1NLMkdKQ2lLSTkxRWhGQ2ZCQUI4?=
 =?utf-8?B?RlJ4aklHUU4rY3BYK3V5cklvSmJsNmFkT1A4cUsxTXQzb0Y0UkRYWXJaMzBp?=
 =?utf-8?B?c0VDSlpDWTg5RUNmUThhbnZjZUxQcGxhSkdzVlpJTWk0UTBwSSt1K1dhbTRJ?=
 =?utf-8?B?aXIwYzdxQ2RWSmVOdUVCQTloNmhhVCtYZEtHd25DYmI2Nml5Y05sUURKSE9M?=
 =?utf-8?B?TzI4aG5EaXdxbEZZZkJIQ3h1WFFCUWdrdjF4YTRtUk5lTTJpQi9uMWdTc1NS?=
 =?utf-8?B?RTVRZFN6ZzhEOW5SS2JGYjRPeVoyL0VvaXE3K3lDWDVsRXNPNkpaWWJkNkF6?=
 =?utf-8?Q?ljQkRCuB6k4gKRno=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a571c21-92ba-4de3-cdef-08df35d829f8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 16:17:44.4839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAWqUj0yDlzT7ycwB5MNfQmQbUwYtArluVX6eF3kiXBFUBRSON6jvvcpd7bZgx3ubqJmfEGqWtGTCJ+vFB96E9CjBaFcbuXbderXACjlyHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8385
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dario,

On 29.10.26 17:05, Dario Binacchi wrote:
> ddr_init() is called from board_init_f(), before .bss is cleared, so
> ddrmix_initialized may already be non-zero on the first call. The DDRMIX
> cold reset is then run on a DDRMIX that has never been initialized and
> the SPL hangs (with DEBUG enabled in ddr_init.c):
> 
>   DDRINFO: start DRAM init
>   DDRINFO: cold reset the DDRMIX
> 
> Move ddrmix_initialized to .data, so that it is zero on the first call.
> 
> Fixes: ae03528affd3 ("ddr: imx: Recreate the power-on state before repeating ddr_init()")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

This issue didn't show up in my tests on i.MX8MM and i.MX8MP, but it
looks correct to me.

Thanks for fixing this!

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Best regards
Frieder

> 
> ---
> 
>  drivers/ddr/imx/imx8m/ddr_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ddr/imx/imx8m/ddr_init.c b/drivers/ddr/imx/imx8m/ddr_init.c
> index b2873ab439d7..154e9d887465 100644
> --- a/drivers/ddr/imx/imx8m/ddr_init.c
> +++ b/drivers/ddr/imx/imx8m/ddr_init.c
> @@ -48,7 +48,7 @@
>  #define CCGR_DDRMIX			CCGR_DDR1
>  #endif
>  
> -static bool ddrmix_initialized;
> +static bool ddrmix_initialized __section(".data");
>  
>  static unsigned int g_cdd_rr_max[4];
>  static unsigned int g_cdd_rw_max[4];
> ---
> base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
> branch: imx8m-ddrmix-initialized-data
> 

