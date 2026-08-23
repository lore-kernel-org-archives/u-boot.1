Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DC3C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 19:37:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A25D8808A8;
	Sun, 23 Aug 2026 19:37:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2xXlfRgx4aOu; Sun, 23 Aug 2026 19:37:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787513868;
	bh=EP6bt1Gnj7TeUd45Sx6wzvKqErRgCHJD73fExB9Icbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xFWD/BZa1BzJ9u1u58RAfIlMD7+bW+HRt2Osr8r/OtFO1rm9zEVdTo0Dwx8MTxoxn
	 xigawFK/Bf9NFhf2WwPBENmwj+MXr2rJ0iUgDMlLFodPfyYZwqWQcCtlByd6jNOHYn
	 CwMFFkQ/tfgzONyYARzfrotng/KTBKYlX8xK2pyj+KPaClVNAfv9uZP+drjYmGp5m5
	 wkG61Yx3slTGmQNw/p4K2W7tCAJKTCVgPDHNlVz38fAoup1sfgUy4fm0mV6EQj31Qz
	 JBT1GLtScVFcUWScH4UlJOX7QMH9Br9Nm0HsudfevViW8utkAzDz2LS6V53PlcH9Yr
	 cHvuIEMdvDlIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75DDF80994;
	Sun, 23 Aug 2026 19:37:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0AC62279
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F10E960639
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lAkq-fKJ4TGe for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 19:37:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=NooRBw4K
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61B086061B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 19:37:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgaOyAwRqc+odJfYVaQcQ2cE4xQRRtxYn8T9MTar5TySib7ljADaJ5tjgppu3VIqhwVF9M289bfanVzkmD8uIYnya2i9PMaBHAxsuVJQUx2+fewBwZlBGhUuZvjcRJ6mOTPK9eUMOquIvE/babgppX5TaIn0ubu8+mmxkD9xpLLVmsfpXKktlBnZwd+il2cMLresowc03Yvmkhp5EkRsuk076PDT8Rv7Exc/KFQhEBTxfbqPJRfmjCqv9dav4fOWGdE3cEE5INKptCy1z9xZTCwgcWSIdbtq30N/jTo0LslNFdB7pJgmuO/Q08+rlxSlk2+Ps8siQgQw5x1up1HMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EP6bt1Gnj7TeUd45Sx6wzvKqErRgCHJD73fExB9Icbk=;
 b=aNTsHdof27mS3ZZGrQCjPFPXpjezNbxCkDYK1ntiYYyxmqOSBwcuexSupAKUKBGjnuqLJ4U93vteUIHh9Feu9w9kY6zaKwoVzQPrvfKW5jHMzDLYo+H0Fky5W/+QgOj7D5Wx18ojHRaaYEum5scVHbBWwqnUyiNAGQWBlfvIbssd5HisPSlg24pB44/XeK4LH11x388iCp2bcwgNTXdoO65on0f1FPFZAw8l5/0xIjCGnbHytuyDZV/Ff9Z15IelGjuFA+2HHy0xfueY9s6RaNmdir3Jlghx3uY0nqsVt0DGjqH5qNw7i1haxgHB+x/UetKb/m+FBmkjKH8LiWrzSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EP6bt1Gnj7TeUd45Sx6wzvKqErRgCHJD73fExB9Icbk=;
 b=NooRBw4KKl5sG4ytvfNz7U3xe1qeGEyGX93C6UYfD2e2wc5Nt9IE2aprAiHYLUyUtJ+X77GB2xSrstV9My2wLHoc/CMYVNZyVJlTQpCcFp9VoJ+3Ebv93v1aIFXkCvUB+PnC52kWlHms9coWFky0lIrLg1EERAgJg9wy5wkCXIH6x2gytmI2oTjZoj6ncTOtJhs+kfql1cGkth3TYBbIS9TR6m80YDMdjC7ebRLI1GKka+J2yLbZTudHTS008xSY0pKrg8TyOj2SRX6NcQT4kq4d1baVvd3YUB+Wi/CZhbmpqAaHAeEu5t6CM0MEAIL1opaJmH9JmXE0weOMh7A4Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AMDPR10MB992196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:713::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sun, 23 Aug
 2026 19:37:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 19:37:39 +0000
Message-ID: <949b6981-94f9-49f6-92a4-64316c32681d@siemens.com>
Date: Sun, 23 Aug 2026 21:37:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tee: optee: Add support for enumerating services that
 only need RPMB
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <cover.1787304541.git.jan.kiszka@siemens.com>
 <bfd9927ca141783a9f73f82a10eca75699222e1d.1787304541.git.jan.kiszka@siemens.com>
 <495e9da4-cbcd-40ad-87aa-b8a156dc9022@altera.com>
 <75fed8fd-cd21-49f0-b539-14389aaed66e@siemens.com>
 <d0dcfd69-669d-4041-857b-b98fcecf559a@altera.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d0dcfd69-669d-4041-857b-b98fcecf559a@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AMDPR10MB992196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d689f4f-20ba-4358-27bc-08df014dfdb6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|55112099003|11063799006|5023799004|56012099006|4143699003|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 6rGsAiyYnadEZxDxRkBAfW7tAYAuNe3/vucoIgai50zsqyxtSIilhgYAiegRph0XLObVWeCMaNBEs96j3Nzul9hmrcrAJmOWjichsN0SrF1VVb4DdJiiXNmTFbXWJQlA+YGgPNhSgCxgGEf7ms5lBAKslu5DeuMV8Q3q4M8RQut01AT7a9NJX8h5mlFq+07hpVO77V6J9BeoELFrLRcskYn/UFclsZOBx2telheMohL8s/IZpOAM/AXHAenYY4G8J5/gVsY8ahmHqSKYl6mHn4Aix3to138pML4Pz37VMdAhVBlNBSIrhoagw+tvPpG911KKSiJefLTHd85kW+5XIXLKVwCEFz+GgmEtb/ia5KKW7+9zx66+dt/BY6cCmJ1+rVl+U450h0s9Nj/jAQDClIKJiZC32TtaRw/y4yyqbwsae4mX5JyxgSmflEEDWERmkYAMjcyNsKEQAN1qsTljqA4zJrVIkI/HcbxUYJyFzVCnzMUXrYKT8BRxsqLXzHOkJ+mH8QewV9VdXUB7oaIjtny/htZeDRYyDiXRkL8Q1VEV/PiflFLS4kaCdo3CtnH8GyCqNN4I3NKdrzX0/t4Ai/gHOuh163GDq5y3cFiPYG+xQmHNRkV/s3OCK8owbrzClJ0Z5IBkT229MotJH2kDfIyTtqVRHBh5EGOZxXOa+Vc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(55112099003)(11063799006)(5023799004)(56012099006)(4143699003)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkxsUUN4Uk5yNytXdGE4RmJFeWF6MnNWN2ZQS1dDYTIySmxTSHU2QjZXVjRW?=
 =?utf-8?B?WjZQemgveUppelI2QmVKbjNySGhFT3ZwWkFXNXYza2djeUp3U2pheGtYQVRK?=
 =?utf-8?B?bTltVnoxa21pcFkrcFFsazdTd2hZWkFBaisrRW1hRTJmUS85VXlMY1p1blBC?=
 =?utf-8?B?bkUyOWdNR2xjMUlUdHE0Zk9meFhJS0hQaENZMXJscFJqVHZ4WFNKNjFmR0gw?=
 =?utf-8?B?TDZQMEsrdDJSWWxoRVZQV1pKdjhwUGNWTE41Q1VZS3pSaUJwTlRJREZxMjFX?=
 =?utf-8?B?OEFUbDNnQUdwK1lqSkNHdVJLM2p5em41UkNaMEZTelN1Q2FEOFNweFl6WEsr?=
 =?utf-8?B?WVAvbzByMFZoV29aTXdJZ3VBdkFKSVVlNEE4aFM0NkY2MDIrU1FwbEFUUFB4?=
 =?utf-8?B?Q1Q3TGhRcmtFenV4Uk5RV0pVZ1RmMTlvVkpONUllZlM0WllFMW5XWDRjMEtP?=
 =?utf-8?B?OXJlUGV1d2J1WDR0TXNFc00vbUNEeUttckhSOXBreHFTbEVHK1gvQ1ErNXNC?=
 =?utf-8?B?OUE2dnpyZFZSckhVZmRZM0g0R2pzeDRzR3RoSGdQeEtlclpRTWdHdFpUWDly?=
 =?utf-8?B?TDV3Tit1VmtaV3FOekxLVm4wU2o2bVp0WEp3U0tHK2s4RzZJK3BNdzZtZTQr?=
 =?utf-8?B?N2ZyNnhDTnBRd3VRWjBmWDI3QzZib1RMd0xvYUVpa2lpc1B5QkZNbTZFTURF?=
 =?utf-8?B?WkhpeWVZalY0QjRsYWFtalBvemppd3h2MmsrZkVwQWlQYkVBQXRVRmxOdllD?=
 =?utf-8?B?RFMyNFJ1RU0yNnRyd1lKeVBGNlJOVy8rOURtOCtuWVo5VFlsTWUvdm1pTDA3?=
 =?utf-8?B?N3JqZTVFUmdlQS81QWhmZXhTVkhXUWhsNVN1N3ZFd0NrOVpjeUhaLzQ3Y2p6?=
 =?utf-8?B?SDBVTENHc0dlQllJMjlLc3p1UjdtSVJVbGlNaTRTTVdKVlRMYmpJRlNaVDNN?=
 =?utf-8?B?Lyt2VGZieWExMEh2VUIwL2xqRCsvT3JRWUFIaHoyRnRWeXdhQ1B3elJzSWox?=
 =?utf-8?B?UzNQaE1RNWpFd1NIMXhmOUY0ejMwVkM5YmZCY2I3MzRKT1grRlpiek5rTWtS?=
 =?utf-8?B?YVNZb0NsODBsU0NNWVlhREZlSkdsYStVdHl2WXRWeEFTZHNPN25mWHoyZXN2?=
 =?utf-8?B?R2tPU1NSSHVEalpCS0R5dmNlOWwrYnFHdDVwOHVIQjNQcmU2S1dPTjFQdlhN?=
 =?utf-8?B?TVVBNXNuRUhFOWs3TjNlTk5XeGFkNHVDanlLdE0veXdXN0hJVGVrVm5UTGpI?=
 =?utf-8?B?ZGVjWmFWeDRRUWNtVGN4U0FyRkxIOUJFaHpjR0ovN1liWmUxRXRGbXd6Mlp1?=
 =?utf-8?B?ZVZIR1MrZ3FWSWQvcXB5UlVyaVZNZEpCTTJGeDBrNFNVYllSUFFYaXB6eS91?=
 =?utf-8?B?MDdLSE04WVFTZ0JsZG9jbmZ0bmhPMkVLdGlFVG1nakYwWkk3TnNWNkdqM0Nn?=
 =?utf-8?B?MmlmYmdtNVVLV0Vpa1NuTkQxOW8xcm1GR1pvREU3OXl2RitJdENQeElMbUN0?=
 =?utf-8?B?QWZvM1NYb0JpeTVsNWljOGIwZzZoVFZQOGRhcUtxNS9kU2VMbmhibnBjRFJo?=
 =?utf-8?B?TEtBdGtWd0VuR3FjS2pvenRYc1FYeUxHQ25naUI0MVFkcWFvWVRrNW0xN2h3?=
 =?utf-8?B?ZGM2Q3prc0JyVDVNbVdmdzV5TkxaRG5NMzcvUEYyRzJiQ1p5aFVBdlpZMmM3?=
 =?utf-8?B?MEVmMjAvYTNKV0pzekQzVUtjT0ZBeEs3SGRUZHd2bjZ6aTh6NFBHUjRpRTd4?=
 =?utf-8?B?SktSOFAvRzNselhNWDNGTTdQcG5hSUsyWWYreE9RUlYzUDlWSG1FWmU4MERo?=
 =?utf-8?B?dlg4SWtWUUZyenB0TWgwRXV3RzRuZnBjWmY0b2xJTi9DbXdCRkFIQ094M084?=
 =?utf-8?B?MWt1VGRrbm11S0x4bm5DMnd3KzRBTlhUTXBUMWRPL0U1aE80dUVxdHEyazZu?=
 =?utf-8?B?Uit3dDFRODVPL1NPYzhneEJIdmtNd2s0VHhuekdueityZ1Y4cmVyVTVuMFV1?=
 =?utf-8?B?aFd6QldmRStSa3BJVnMzWXhuNW45ME1kYW1rRXp1Y003V3o5cFV0Ujl3MFdV?=
 =?utf-8?B?NHBwSU10RWhRM1ozNDRubStWYWZVczc2ZFRFaEl2SG1XK01iZEIxQmw2TGR3?=
 =?utf-8?B?K2V0aHJBckhteUhxVDRmWWRUL1RkQS9sUEV2eGpMKyt6cnpQV1V4UWVrSndJ?=
 =?utf-8?B?MHY2WWxCcElBRVZyc0JkaVBsK0Z6ZHFwdGt1em5Id3R4b3BGUitLTjB2bXBN?=
 =?utf-8?B?UGJxakY0a1dNSjlNdHJGUERqUVBxMXduc3hJNDN1S1pITG1ramdlTEUzTkdm?=
 =?utf-8?B?MmVDZWhBKzVrc29EUGJqYitDejB0a0RDTmMxL2tSQnlXYnpzLy9Xdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d689f4f-20ba-4358-27bc-08df014dfdb6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 19:37:39.2436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaHOCnWhWeuFOjZ2UYVE/OH++cq+rsOgv0G1dbV2/mgN0e8+oWYkCJLiXnG+9MMmVXzLnLcVP2O1FiGowIRISg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR10MB992196
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

On 23.08.26 21:09, Kathpalia, Tanmay wrote:
> 
> On 8/24/2026 12:02 AM, Jan Kiszka wrote:
>> On 23.08.26 16:31, Kathpalia, Tanmay wrote:
>>> Hi Jan,
>>>
>>> I am not an expert in TEE, but I went through this patch while reviewing
>>> the MMC side of the series and found a few issues.
>>>
>>> On 21-08-2026 14:58, Jan Kiszka wrote:
>>>> From: Jan Kiszka<jan.kiszka@siemens.com>
>>>>
>>>> Up to OP-TEE 4.4.0, all services that needed a supplicant where
>>>> returned
>>>> by PTA_CMD_GET_DEVICES_SUPP. Since then, services that only need a
>>>> supplicant for the purpose of accessing the RPMB are only enumerated by
>>>> the new, separate PTA_CMD_GET_DEVICES_RPMB. U-Boot so far lacks support
>>>> for that, thus no longer finds such services, e.g. fTPM.
>>>>
>>>> Perform the separate enumeration during probe but, as that may fail if
>>>> the MMC is not probed yet, also provide a callback to trigger a retry
>>>> when another MMC device becomes available.
>>>>
>>>> Signed-off-by: Jan Kiszka<jan.kiszka@siemens.com>
>>>> ---
>>>>    drivers/tee/optee/core.c          | 32 ++++++++++++++++++++++++++
>>>> +++++
>>>>    drivers/tee/optee/optee_private.h |  2 ++
>>>>    drivers/tee/optee/rpmb.c          | 11 +++++++++++
>>>>    include/tee/optee.h               |  2 ++
>>>>    4 files changed, 47 insertions(+)
>>>>
>>>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
>>>> index 4d67c948ec1..5600d5a4c7d 100644
>>>> --- a/drivers/tee/optee/core.c
>>>> +++ b/drivers/tee/optee/core.c
>>>> @@ -41,6 +41,13 @@
>>>>     */
>>>>    #define PTA_CMD_GET_DEVICES_SUPP    0x1
>>>>    +/*
>>>> + * PTA_CMD_GET_DEVICES_RPMB - List services only depending on RPMB
>>>> support
>>>> + *
>>>> + * [out]    memref[0]: List of the UUIDs of service enumerated by
>>>> OP-TEE
>>>> + */
>>>> +#define PTA_CMD_GET_DEVICES_RPMB    0x2
>>>> +
>>>>    typedef void (optee_invoke_fn)(unsigned long, unsigned long,
>>>> unsigned long,
>>>>                       unsigned long, unsigned long, unsigned long,
>>>>                       unsigned long, unsigned long,
>>>> @@ -210,6 +217,29 @@ static int bind_service_drivers(struct udevice
>>>> *dev)
>>>>        return ret2;
>>>>    }
>>>>    +#ifdef CONFIG_SUPPORT_EMMC_RPMB
>>>> +void optee_bind_service_drivers_rpmb(struct udevice *dev)
>>> This function is only compiled when SUPPORT_EMMC_RPMB is set, but
>>> optee_probe() calls it unconditionally after a successful
>>> bind_service_drivers(). optee_private.h stubs other functions for the
>>> !RPMB case, this new prototype has no such stub, so for
>>> SUPPORT_EMMC_RPMB=n should fail to link.
>>>
>> Yeah, thanks for reminding - I forgot again that the linker won't
>> resolve that. Will also refactor this to move the rpmb part into the
>> rpmb module.
>>
>>>> +{
>>>> +    struct tee_shm *service_list = NULL;
>>>> +    size_t service_count;
>>>> +    u32 tee_sess;
>>>> +    int ret;
>>>> +
>>>> +    ret = open_enum_session(dev, &tee_sess);
>>>> +    if (ret)
>>>> +        return;
>>>> +
>>>> +    ret = enum_services(dev, &service_list, &service_count, tee_sess,
>>>> +                PTA_CMD_GET_DEVICES_RPMB);
>>>> +    if (!ret && service_count)
>>>> +        ret = bind_service_list(dev, service_list, service_count);
>>> A dev_dbg print would help here.
>>>
>> Of what exactly?
>>
> 
> Sorry, that was unclear. I meant the early returns, not the successful
> bind.
> open_enum_session() and enum_services() can fail and the function
> just returns. Patch 3 will retry this from mmc_init(), so a dev_dbg()
> on those failures would make that retry easier to follow.
> 

That's what patch 2 is for. Other enumeration errors are printed
unconditionally by __enum_services.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
