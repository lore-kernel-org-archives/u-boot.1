Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0899D0E6D5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 09:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A83388606;
	Mon, 21 Oct 2024 11:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="QkWEyp4H";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YjHSjZcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD18892E8; Mon, 21 Oct 2024 11:18:17 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF12885F5
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 11:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 5eb38c9e8f8d11efbd192953cf12861f-20241021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=IqH+heir4yJXvLtYdYqq0SYtqTTdChtyu+jgl+GAxYw=; 
 b=QkWEyp4HdRObbWIKT8h085PVYPRDIfrjCTdxTQHBiQ+vmC8bxNO6W7Z5hpPw7SESrbpK/6bMw2jCHwSNFMdEAcNPArq2/A+rOgPuQyKwbwnrD6OppalXUPL6TbOdi4Nk5/JAxq8VCkdjDVk48czl92OXn25PMT1rBAYe+6OOFvc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42, REQID:d5a27b65-271f-45e2-98e4-9b974334da26, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0fcdc3, CLOUDID:2c989541-8751-41b2-98dd-475503d45150,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5eb38c9e8f8d11efbd192953cf12861f-20241021
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 106215556; Mon, 21 Oct 2024 17:18:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 21 Oct 2024 17:17:59 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 21 Oct 2024 17:17:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgU7kwzE5wczEH4n+DrXbn/8t9GFee6C3VEwqVBwSp3bT9XqRW/8u4deam71wAEcrW/J+tueks6ViXVrLBn5dNKn5mkAvfgEXX9WSVLbjTtFNhblPQNoDrY0IVXKmgeGGr6aTVRY5rPk/zJM27YHcreHky7d1Td2QrAPMckcwpQI8QIhzVu1Mda4U968Ktl8EnO9+fCFsmGDqp3Y5e2UwpY8dbg8p2C4UkAhzxgDziTWF4whymYVjVEaysmZQDqNhi5KLX7dgKvn3hnMymlbuQIevQ/91RVMAz2bgoIsRnNnzxhzoKRVErFFyzvg0r6Km6aJTh4F636QC9GvCdJeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKhGD5xoJ+Tj+C+mCuURy7hz2eNT4aKtmPiC10eJdWs=;
 b=i/iEX5lEaM5SmxrJMWAeIVQaaRsJf7KzyDqWqKwk0NYdKotNUuB9IGe5K/vbxCBfVTkU4IPqso1I3AJ4/7GfLgqdkicA/8k9ASjzZ/Do28jbAMCoCmpdCrR1LwKjahz6b/u6wlM+pRZtB0fYoymRkQct6JKHmRWZhsjx6k8q5l7VPcLZiHGX9U2GJIySw4SFchqi39K+AVWuB9srTzkDwUSt8TrjTafL7BDcvVj0Bjgw0Q/t+98F6/vqb+0rOBPTg4uNb7FGBSJFlvhAMBChzbfhNtL0wAEP+u4SsoulmlYjs5EXBZEwVGQ5NgvLnlds3WECEwC6CKipKZBgVEjZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKhGD5xoJ+Tj+C+mCuURy7hz2eNT4aKtmPiC10eJdWs=;
 b=YjHSjZcIx/Ph9X99ZxzYNYAkjbKXyJF1OC/TIPR9KKrQ+dLEs9EbfQlOca+kgoSmXXodW4coue9KM3CRNexeFPyyqi9gH+zkMxVkEuN+5Mm6sih2/f4UMdhMI7102gJq1sJxjSQh3ZiNchWbh+bufUJlMxYhWSZizxbtTN6+cJ8=
Received: from KL1PR03MB8218.apcprd03.prod.outlook.com (2603:1096:820:105::8)
 by TYSPR03MB8046.apcprd03.prod.outlook.com (2603:1096:400:472::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Mon, 21 Oct
 2024 09:17:56 +0000
Received: from KL1PR03MB8218.apcprd03.prod.outlook.com
 ([fe80::a65e:15c9:c41b:4a31]) by KL1PR03MB8218.apcprd03.prod.outlook.com
 ([fe80::a65e:15c9:c41b:4a31%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 09:17:56 +0000
From: =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>
To: "sjg@chromium.org" <sjg@chromium.org>, "lucent@gmail.com"
 <lucent@gmail.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "daniel@makrotopia.org"
 <daniel@makrotopia.org>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "john@phrozen.org" <john@phrozen.org>
Subject: Re: [PATCH] menu: fix the logic checking whether ESC key is pressed
Thread-Topic: [PATCH] menu: fix the logic checking whether ESC key is pressed
Thread-Index: AQHbITkZC5U38r57QECo1LSXGfGFX7KMmyYAgARTx4CAAALXgA==
Date: Mon, 21 Oct 2024 09:17:55 +0000
Message-ID: <685290928a355fa92e386841708d2d8d94b45691.camel@mediatek.com>
References: <20241018083806.30679-1-weijie.gao@mediatek.com>
 <CAFLszThr2dusigg9R_3ytoGXybzV6sjChDp+40L+K_Qeo=rNdw@mail.gmail.com>
 <CANV2PTM7t7SgmQaFz6KBwTpJG8_PEbXqfMu=BpTuS=2F5XqB9A@mail.gmail.com>
In-Reply-To: <CANV2PTM7t7SgmQaFz6KBwTpJG8_PEbXqfMu=BpTuS=2F5XqB9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB8218:EE_|TYSPR03MB8046:EE_
x-ms-office365-filtering-correlation-id: 6cc31e63-cc01-4d65-8da8-08dcf1b13fb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dHFQVkx0TWF3cGxnSUNZU2pwd2lzWWx2dUNqZzhJdU1mZUdQRFhXNXF6dVVT?=
 =?utf-8?B?VG1HSk1UY3hZK2tzUVNGMDN5Qm9WZWhsTG0vZXBTZERhYnVLU1hXaDVyUjhk?=
 =?utf-8?B?N0oySDRmTXVCbXhtOWRyRlQ1T25sSm9YclJnUTZSNTBUL0x6MFRqSkZNdkY1?=
 =?utf-8?B?S1ZwbE4rTlJRSkFDaUdITHZCNjYzNkt4cDA0SE5SbHh1bHRxYmowNk44UUpn?=
 =?utf-8?B?L0VOOEY0MDU0eVkyVTFlelQ1dmROMUc5TVBFOWdhN2xJVGVWVHVIa1VLMnRK?=
 =?utf-8?B?MHpGSTg0SWpjUEVUOStXb2tsOHl0RENyY0o1NHdTaUtSTFhsSEc3TGxkQi9q?=
 =?utf-8?B?c1lJdHU1M2tsTHExTU9HVkhnQXBrRlZIRVRYT2d5Y1RWUmpCNVZKd2VKdjBx?=
 =?utf-8?B?KzF6V25oZXVaQUt3clVDNUpJWm1nRTJsdkJHYkFoQ3c2ZUI2WDhaQkZ6dDJH?=
 =?utf-8?B?QjcveVp4VlpYNXlndGpTOS8xM3ZYa2NicnpVeWJ4U1JIeEF4ZWVLQWhINUhX?=
 =?utf-8?B?VXZ2T0hoaUVvaEkxTVpXWjJUZGttNU9MbThPeHphT2xkcGtUWnI1Y0NwVzFU?=
 =?utf-8?B?bk13R2xJTnh0dlA2ZHRhblRNZnFHRFJqekRPZW9LdVZHTlp0ajViMjBEZm5W?=
 =?utf-8?B?dXpIemZnRHlCc0t0YUx1MVVzaTd0VUhQZVhQc0hIL21pSVVvYmZrSUJxZVIv?=
 =?utf-8?B?M3VqZUlrNldoNkZGQURSQkh5SDZaMEFoaFFTTDI0YUVmdFl5MmlGMzc0bE9n?=
 =?utf-8?B?SEtYdGoxWTBSNlNxeWNCeVJYeGJaUkRwT3N2ZlhsYXpUdXZRUUVNVnhnbC9z?=
 =?utf-8?B?RTk1Ymd3VXVPc2t4QmoxVVFyLzdYWkFoN0lzWXNMaGh2SEIvWW5DcHNaQS9K?=
 =?utf-8?B?bXJ3bzlaK1lxb3dXaUhTRi9aajhSU2FPOG44MmpJN0JjYVZwbXlaVHNmOEVL?=
 =?utf-8?B?d3ZTS1VqOEhTN0UzdFlEeUI0cXBNWjhKb3hHRFI1WThQc2RpUVUxL2RpMElI?=
 =?utf-8?B?d0xrTFhMejVCSVlNUEdGNXFIUHZxZUJCMXlOdkdrRGtpaTBsdkZBcG5VMDBW?=
 =?utf-8?B?Z0x6TjBDK2x4Rng3a01ReUZucXlzZmtsbUdXdHF5K2dwUnhyUldPc2FCU0to?=
 =?utf-8?B?Tk9SRUhMbUVSUzJWSXNMRGlXM1V0VUpKYWlaUDlINzFiVXpTOENiYngxSzk3?=
 =?utf-8?B?L0FFRXZLM3crQXA0dTkwRUtHQmx0cGh4djY1Vm1LU2txamRublhVREVUcHJB?=
 =?utf-8?B?b29vRVM3TVFUMG1qYmZzQzg0MmIxb0lnWnExWW1FVjJvcnNKTEYreGNsMVhr?=
 =?utf-8?B?a2t6bUphWTJjeE5CNWg5aU1xNFIwVjFNRVJSM3hZYXRNcm53T2tJNG5CU3ZM?=
 =?utf-8?B?NVdQOURSYThoRmpJeWtNalpybFJoRCtSTzg0YlJnZ2dKaGtVbDhwamRtRjRu?=
 =?utf-8?B?cmJBM3RFRUpDRDlacHA5akZqNnB5K0VLT2tzVnh3akJDWHlUTCtBSnY1UUFT?=
 =?utf-8?B?MDZjVjhjUFRIaHRwZFRHbHpmY2N1RXhNQ1g5Y2tWVXdSQi9rVStLcVZLbmda?=
 =?utf-8?B?VllvOGtqNlFSZ1V3dUJxM2VsSFNnbThmZjZjcEVrYjlPdWZhUGlUb3hmTDhY?=
 =?utf-8?B?TVIwdEhDUWJnS1VwcXlSdWNKbHFyME9heENjT1pySk14RXNCUHhYazJUTWtZ?=
 =?utf-8?B?anI4WWZxSnVEVWJFcEhrUUVoeDZTV3gxSlFqd2hEN09waUNZdXBRc3o4VjlS?=
 =?utf-8?B?WWczejFNUGM0Yit2VmVsQmRGWG43KzVsa3BCQzlpVkhiYjFnR2lUMGk5NHpt?=
 =?utf-8?Q?t0KQ4UF6NPbqGcKTLUXeuDFvRF8mPMcn65zVo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR03MB8218.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm8yVzducGV1K0RLVUc2SWNvMExZbStjKzhteU5VdmU0dUVQQ29uTkNpZ1Ns?=
 =?utf-8?B?a1AxczhVc3JmQ0dkaUU3UWM2L2M0L3dGTEhBSDdLL1A1US9kSGFoU3NpTDR2?=
 =?utf-8?B?UXNGQUdLb2V2UThZUkNOUjd0bWFTeTh0dlNjNUlJWTQ0cFFFb1BUWVB3UGsz?=
 =?utf-8?B?cFdEMVloVVZaZFg4VXA1bTBSR3JWSzhjb3NZeUllQllOUytUUHlSeGljeFZm?=
 =?utf-8?B?SDYrZlk1dUVtdlVFRDhiL1NWcW5BeXdFVzZTVWRxUXl0TlYwS2pxTTFZcGE2?=
 =?utf-8?B?cGRQbFI5NjBybnlBT2l4YWFxZ0w1MnV0cnJvc1pSS1h5aUdzdDJpSXdwOUNh?=
 =?utf-8?B?QVhUcEFET0lORTU5V3prN0FDc05ScmdWQ0Z6dHpkUzlSamcrZGdHS2grdlBP?=
 =?utf-8?B?T2RsbHM4Mldwb2VSeERVUzcraEJPMHFkL1J4YjhhMkVmZ0ZETkhMR2dKY0tC?=
 =?utf-8?B?ZXNIbEQzaGdJRDBhYzRYWmtuVDVjMTlFWlpWR2YvbERna1RVVUJUak1hcnZp?=
 =?utf-8?B?emRoZWJnMnJmcWNZMUpQZSthOGVkNWxzdE5MODF6NHJPMktlMUxEZ1AzYmQ4?=
 =?utf-8?B?V2Y5VnY4YlFjLzdYY1VUQjlJbmVyeVk0KzhZeENXQ3UyMnJwdE1jR21pRnFh?=
 =?utf-8?B?WXlHSzhCV0NWK2Y2V3lWKy9UaXY3c0NPWkprVGtjRWNXM1ZEWGhkY0dIY25k?=
 =?utf-8?B?SFZXc0hocUVycGpPdGs3d0JLZ1hmaGZTb3BBRDJoT2tPSmdPVU5pbHc3dlFY?=
 =?utf-8?B?VkRobXBNcVFNeEJlaThFTExNZ3JSb0NqcDhvdkUySmx6VTZ6UDhxOWVRQzBa?=
 =?utf-8?B?UitOWk53cFI2eFFKUUNZYWh6cEJ5YWlyOVQvQ1YyZ2hieUtwTGxXOGVJTktw?=
 =?utf-8?B?eTVKK25IZk5PNk1tTDIxYnoxMXFGYStXazNUeU5YV2drdHVSbHBzTjNVSlZH?=
 =?utf-8?B?NVowZVhYcHhKcnZhdXloZW5TOFlPaVR1OUt3MnRuNVFFL0hXam9USXVYQUdj?=
 =?utf-8?B?RUl0VmE5RzBMR1RaSXdzUTV5cW1kMVNaWFNoUGxYQ2tHTGpFMnFMOTFEcUFV?=
 =?utf-8?B?WGhRZnh5M1c4OWpSTmlmR0IrWG5TYXhNbjU0VDQ1TDF0aGRpTzZvbG9rT0lZ?=
 =?utf-8?B?VTRFV1BtbnJqTkdmRFhsL1Q1aVFhVnd5TjRoODFIVWVjVEtoL0NOY3djbU9H?=
 =?utf-8?B?RDc4M3Y0Z3ErSnd2b3RUVFF1bk5IZUgwOVdvWHM2T0JIWkVQMEFtMFhUZlNE?=
 =?utf-8?B?aXN3UTQvUDNRZEQ5YUs1Y0xoQ29DbXRqZEN6UmFWV2IxdzRITjQ4U1ArNlVV?=
 =?utf-8?B?NGlGc1RJZFR0RStzVk9jVlpEQURtOUhNajVjb3M4QjlqLzd5RjFKdXYvc2FC?=
 =?utf-8?B?amVYeVR0ci83RllINngyWS9YanhpTDNja0RQNW9GcTdHWlpjZGdjWmRRUUNE?=
 =?utf-8?B?L25pN3BHK3VWS2RLTWp0bXdzcFhML0N0U0EycHh4U2JTQTludWNNRXFjQllQ?=
 =?utf-8?B?TXoyOTZKdE0rdUtZU0srdGNvaFZTYUp3enVoZ1YwbDNoaHVic0piUGJLZGl3?=
 =?utf-8?B?U0FrOFRFZXBEYWxpMGx5QUwyam1waUx1UzBCaWZoZ2RXTzZVWUpmcDBsZmU1?=
 =?utf-8?B?dHYwaFFLV2RKaEI2dTZIREhYWTBSZG5ZZzFRTHRoTnRRM0dGYkQwQ2JkR1Ja?=
 =?utf-8?B?Znhna3JFYzVvQU53Z2UzeC9UY1NLYjRuSHZqRkg0eHVHTUdLQTBMaXQzcUpX?=
 =?utf-8?B?UkMzZHN6NThPcjFRZ1ZaUmtkU2NJcm9mcHRXQjJhQUhGKytBN1BvQkM4RUtK?=
 =?utf-8?B?bkRUSlJsalhLTE1LUUdSaDBaek1jd1pKcW9ObXRuS1ZhUytrMDVsUmZ0dDFn?=
 =?utf-8?B?NUp4OFJLMjVjT28zM2VYdmIzdy9LQVZDVjIwblhHMVRPSmZDUjlZbHVDcGxF?=
 =?utf-8?B?N3pwUFdxaFI4RndyVTVhd2M3bStJZi9GOFVYdnFnN0QzU1Y2c3N3alcvdnhn?=
 =?utf-8?B?U1c3UUExS0pXTng4dDVyRW4zNmVVcW5xdzRQZW5rdUxUU2lPODdYT2o3NVIw?=
 =?utf-8?B?VlBQSlFNNHNKaHBTaTlld3NsVUpMejNEcUZQbWRiU3ZsSDIrMEUyUjFOUEVL?=
 =?utf-8?B?aEZlZEhNTk9iN0JnWnlHK0w2QTNoYXBJTFE0WGt5ZmZXR3RHNEh4emxuN2RL?=
 =?utf-8?B?Z1E9PQ==?=
Content-ID: <C3828BE9BDECA34095C1D10AE8E017C2@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB8218.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc31e63-cc01-4d65-8da8-08dcf1b13fb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 09:17:55.9282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgHwc3Jkrh60zICVOveri+N0uqSRGamLeoYmBVexYbs7dJq8xZynAN7GwQDPpbDXvCbWJAKJSc2M7o18Sx0x6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8046
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.469600-8.000000
X-TMASE-MatchedRID: 9M69yBZ2Ml7UL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4+qvcIF1TcLYCpm
 X5+L4Y11AQ3/AofIj6YQzi0udqzS8XcYMXxDjLZB9XSoj4i8LK0uhg66Itb65dr4gfya+A9U2ug
 QZCK503KlPlLmvavB0qZHT/uIElBcKdt5o9/T+2oXrP0cYcrA25hkkqJeFHot0SxMhOhuA0SeIx
 g3P0+UrNu0sjo7nrOc0IvbBkiPjgMgNXYDo2rRhkhwlOfYeSqxTJDl9FKHbrmAZpvTq6Jh4Q6Tn
 9wDc5HXYuOxvWQSKJjJbC7I5DbO12u2g5s6p8lPq1ZJZ2z+SbZdymZBcuGGRAZbeEWcL03VzrWt
 8TufKdvi8zVgXoAltj2Xsf5MVCB1jaPj0W1qn0TKayT/BQTiGgP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.469600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 9595D6DD78ECC171D00F9F80F0F24F69A5B44C2BFCD0E80AAF337279D7332C232000:8
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

T24gTW9uLCAyMDI0LTEwLTIxIGF0IDAyOjA3IC0wNzAwLCBFIFNoYXR0b3cgd3JvdGU6DQo+IA0K
PiAgSGksDQo+IA0KPiBPbiBGcmksIE9jdCAxOCwgMjAyNCBhdCA4OjAz4oCvQU0gU2ltb24gR2xh
c3MgPHNqZ0BjaHJvbWl1bS5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gSGkgV2VpamllLA0KPiA+DQo+
ID4gT24gRnJpLCAxOCBPY3QgMjAyNCBhdCAwMjozOCwgV2VpamllIEdhbyA8d2VpamllLmdhb0Bt
ZWRpYXRlay5jb20+DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEl0J3Mgb2JzZXJ2ZWQgdGhhdCB0
aGUgYm9vdG1lbnUgb24gYSBzZXJpYWwgY29uc29sZSBzb21ldGltZXMNCj4gPiA+IGluY29ycmVj
dGx5IHF1aXR0ZWQgd2l0aCBzdXBlcmZsdW91cyBjaGFyYWN0ZXJzIGZpbGxlZCB0byBjb21tYW5k
DQo+ID4gPiBsaW5lIGlucHV0Og0KPiA+ID4NCj4gPiA+ID4gICoqKiBVLUJvb3QgQm9vdCBNZW51
ICoqKg0KPiA+ID4gPg0KPiA+ID4gPiAgICAgIDEuIFN0YXJ0dXAgc3lzdGVtIChEZWZhdWx0KQ0K
PiA+ID4gPiAgICAgIDIuIFVwZ3JhZGUgZmlybXdhcmUNCj4gPiA+ID4gICAgICAzLiBVcGdyYWRl
IEFURiBCTDINCj4gPiA+ID4gICAgICA0LiBVcGdyYWRlIEFURiBGSVANCj4gPiA+ID4gICAgICA1
LiBMb2FkIGltYWdlDQo+ID4gPiA+ICAgICAgMC4gVS1Cb290IGNvbnNvbGUNCj4gPiA+ID4NCj4g
PiA+ID4NCj4gPiA+ID4gIFByZXNzIFVQL0RPV04gdG8gbW92ZSwgRU5URVIgdG8gc2VsZWN0LCBF
U0MgdG8gcXVpdA0KPiA+ID4gPk1UNzk4OD4gW0INCj4gPiA+DQo+ID4gPiBBbmFseXNpcyBzaG93
cyBpdCB3YXMgY2F1c2VkIGJ5IHRoZSB3cm9uZyBsb2dpYyBvZiBib290bWVudV9sb29wOg0KPiA+
ID4NCj4gPiA+IEF0IGZpcnN0IHRoZSBib290bWVudV9sb29wIHJlY2VpdmVkIHRoZSBmaXJzdCBF
U0MgY2hhciBjb3JyZWN0bHkuDQo+ID4gPg0KPiA+ID4gSG93ZXZlciwgZHVyaW5nIHRoZSBzZWNv
bmQgY2FsbCB0byBib290bWVudV9sb29wLCB0aGVyZSdzIG5vIGRhdGENCj4gPiA+IGluIHRoZSBV
QVJUIFJ4IEZJRk8uIER1ZSB0byB0aGUgbG93IGJhdWRyYXRlLCB0aGUgc2Vjb25kIGNoYXIgb2YN
Cj4gPiA+IHRoZSBkb3duIGFycmF5IGtleSBzZXF1ZW5jZSBoYXNuJ3QgYmUgZnVsbHkgcmVjZWl2
ZWQuDQo+ID4gPg0KPiA+ID4gQnV0IGJvb3RtZW51X2xvb3AganVzdCBkaWQgYSBtZGVsYXkoMTAp
LCBhbmQgdGhlbiB0cmVhdGVkIGl0IGFzIGENCj4gPiA+IHNpbmdsZSBFU0Mga2V5IHByZXNzIGV2
ZW50LiBJdCBkaWRuJ3QgZXZlbiB0cnkgdHN0YygpIGFnYWluIGFmdGVyDQo+ID4gPiB0aGUgMTBt
cyB0aW1lb3V0Lg0KPiA+ID4NCj4gPiA+IFRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBpc3N1ZSBieSBs
ZXR0aW5nIGJvb3RtZW51X2xvb3AgY2hlY2sgdHN0YygpDQo+ID4gPiB0d2ljZS4NCj4gPiA+DQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBXZWlqaWUgR2FvIDx3ZWlqaWUuZ2FvQG1lZGlhdGVrLmNvbT4N
Cj4gPiA+IC0tLQ0KPiA+ID4gIGNvbW1vbi9tZW51LmMgfCA1ICsrKy0tDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBk
aWZmIC0tZ2l0IGEvY29tbW9uL21lbnUuYyBiL2NvbW1vbi9tZW51LmMNCj4gPiA+IGluZGV4IDVm
ZDcwNTAzOWZjLi5iZDJhYzNlMGVkOSAxMDA2NDQNCj4gPiA+IC0tLSBhL2NvbW1vbi9tZW51LmMN
Cj4gPiA+ICsrKyBiL2NvbW1vbi9tZW51LmMNCj4gPiA+IEBAIC01NjYsNyArNTY2LDcgQEAgZW51
bSBib290bWVudV9rZXkgYm9vdG1lbnVfbG9vcChzdHJ1Y3QNCj4gYm9vdG1lbnVfZGF0YSAqbWVu
dSwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGNsaV9jaF9z
dGF0ZSAqY2NoKQ0KPiA+ID4gIHsNCj4gPiA+ICAgICAgICAgZW51bSBib290bWVudV9rZXkga2V5
Ow0KPiA+ID4gLSAgICAgICBpbnQgYzsNCj4gPiA+ICsgICAgICAgaW50IGMsIGVycmNoYXIgPSAw
Ow0KPiA+ID4gICAgICAgICBpbnQgY2hvaWNlOw0KPiA+ID4NCj4gPiA+ICAgICAgICAgYyA9IGNs
aV9jaF9wcm9jZXNzKGNjaCwgMCk7DQo+ID4gPiBAQCAtNTc0LDcgKzU3NCw4IEBAIGVudW0gYm9v
dG1lbnVfa2V5IGJvb3RtZW51X2xvb3Aoc3RydWN0DQo+IGJvb3RtZW51X2RhdGEgKm1lbnUsDQo+
ID4gPiAgICAgICAgICAgICAgICAgd2hpbGUgKCFjICYmICF0c3RjKCkpIHsNCj4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIHNjaGVkdWxlKCk7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICBtZGVsYXkoMTApOw0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgYyA9IGNsaV9j
aF9wcm9jZXNzKGNjaCwgLUVUSU1FRE9VVCk7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBjID0gY2xpX2NoX3Byb2Nlc3MoY2NoLCBlcnJjaGFyKTsNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGVycmNoYXIgPSAtRVRJTUVET1VUOw0KPiA+ID4gICAgICAgICAgICAgICAgIH0N
Cj4gPiA+ICAgICAgICAgICAgICAgICBpZiAoIWMpIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGMgPSBnZXRjaGFyKCk7DQo+ID4gPiAtLQ0KPiA+ID4gMi4zNC4xDQo+ID4gPg0KPiA+
DQo+ID4gVGhpcyBsb29rcyByZWFzb25hYmxlIGZyb20gYSBmaXJzdCBnbGFuY2UsIGJ1dCBwbGVh
c2UgY2FuIHlvdQ0KPiByZWJhc2UNCj4gPiBvbiAtbWFzdGVyID8NCj4gPg0KPiA+IFJlZ2FyZHMs
DQo+ID4gU2ltb24NCj4gDQo+IERvZXMgdGhpcyBhZmZlY3QgZWZpY29uZmlnIG1lbnUgPyBJIHdh
cyBoYXZpbmcgc29tZSBpbnRlcm1pdHRlbnQNCj4gdHJvdWJsZSBhYm91dCB0aGUgZWZpY29uZmln
IG1lbnUgcXVpdHRpbmcgc3VkZGVubHkgYmVmb3JlIHRoaXMgcGF0Y2guDQo+IFdpdGggdGhpcyBm
aXggYXBwbGllZCBpdCdzIG5vIHdvcnNlIGJ1dCBtYXliZSBiZXR0ZXIsIEkgdHJpZWQgZm9yDQo+
IHNvbWUNCj4gbWludXRlcyB0byByZXByb2R1Y2UgdGhlIHByZXZpb3VzIGJlaGF2aW91ciBhbmQg
d2FzIG5vdCBhYmxlIHRvIG1ha2UNCj4gdGhlIGdsaXRjaCBoYXBwZW4uDQoNCkkgZG9uJ3QgaGF2
ZSBlZmkgZW52aXJvbm1lbnQgdG8gdGVzdC4gQnV0IEkgZG8gc2VlIHRoaXMgZnVuY3Rpb24gYmUN
CmNhbGxlZCBpbiBlZmljb25maWcuYyAoZWZpY29uZmlnX2Nob2ljZV9jaGFuZ2VfYm9vdF9vcmRl
cikuIFNvIEkNCmJlbGlldmUgdGhpcyB3aWxsIGFmZmVjdCBlZmljb25maWcgbWVudS4NCg0KPiAN
Cj4gVGVzdGVkLUJ5OiBFIFNoYXR0b3cgPGx1Y2VudEBnbWFpbC5jb20+DQo=
