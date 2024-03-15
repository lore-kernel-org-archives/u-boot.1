Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65890C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 08:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FBA687FA7;
	Fri, 15 Mar 2024 09:00:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ICsuRysQ";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kDq+rkpc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 567BA87FAA; Fri, 15 Mar 2024 09:00:05 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2596487B82
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 09:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 025ffc54e2a211eeb8927bc1f75efef4-20240315
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=nJno48uw+cZkpNW0KdefpnGB/MoHgg4F0QobVWb2BIg=; 
 b=ICsuRysQH3pHkHzXK2oYcJDduR1PWcIYnL4iHCCyeS1KjJADYOWIfUBNcV8qZH8qhGWlk8unx63ah+WCACJrRs7zjmnDyyR0X5ARgkTYBtKLDvvueBX741ilYAxUhqc0D6bkGGvbiUpgsELF9hOG2oQefPfUdJ/ERDPTvpwgOjE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37, REQID:426837e0-267f-497b-8e92-3a125d38f0da, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6f543d0, CLOUDID:27947090-e2c0-40b0-a8fe-7c7e47299109,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 025ffc54e2a211eeb8927bc1f75efef4-20240315
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1191625036; Fri, 15 Mar 2024 15:59:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Mar 2024 15:59:53 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP
 Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Mar 2024 15:59:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9qqOPQZqUqY8Rb7nAkKFy8j/pCWPjRdI7QGvpaxnOtx6htnpuwd8VScZ5NH+Xa8i0PKRCYNK/GevN2eXQo8FKSKQ3a/ni6t2NmWjw1Vf7pio1YUR+xowy+FCNUZ8d9SrgVBekLydT/+WAPi31wDvX9uTBTDCW4FAkU/tV17RrY8xwvFVewLOg1J/LYkqQK20HHJ6g468G4mJcZ0faRrdvQDy2aJMsrTIrh72MRY2lInoQlD21TG6FGxivpi1RX6HD+UgNntrTdixjxEubJedOMsob1kQ+vKS8e5nkiO89hq2DMV/+XgPLBMaa2JUCk3B4KqbOtC1au2HXXYtRa3HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O62bm5f8YRNhVaj1Q4jJYl5ISQhYyiMkGb05oLX36u0=;
 b=KO5eYd6J/lxayCaRW30COj+A1wse1puw7IHYsqdtpwR2aT9Y0ZRXTrtVANhERYeBwFdMTXU6by79IN0lTqfiat6ntuk3nah5EFuZVR/uR7suWjrLsSMeTmPBf8zZ6p+mTo0rL9RyX/WDn8IhduTEB0zkxukxo66jjjA447sfhgDlKNbGC93BAG/ySAZ1VohSiikFgNi4+g6pP+JAl5Tamy7UTyNVo9quGognWVOdGkkXoVZWuYHrirywTuGk1wm+khK1AulJwle/1E/6S0jzInwsQLEvQbdI14MqPaTEmi4m1CqCQ2o3ABxS5lAOA9kMtatR4XmhNM47nByW0YWRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O62bm5f8YRNhVaj1Q4jJYl5ISQhYyiMkGb05oLX36u0=;
 b=kDq+rkpc5dmRjzZSMzEl9Juq/kekLYOd7uCXWa/60qHFGzawykz/tYfLfogkBgndCzpIipUwhvY3T9GO1dM85XA07E3MpknOUGxDX/IhrCAwfklFE/aeGbtLKGmJ9SoTr09OaZTWLmrtFAmDTcylqLlz42t6l4e/RAkN6xwBYN8=
Received: from KL1PR03MB8218.apcprd03.prod.outlook.com (2603:1096:820:105::8)
 by TYZPR03MB7747.apcprd03.prod.outlook.com (2603:1096:400:423::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 07:59:51 +0000
Received: from KL1PR03MB8218.apcprd03.prod.outlook.com
 ([fe80::7164:7f9:2848:8a01]) by KL1PR03MB8218.apcprd03.prod.outlook.com
 ([fe80::7164:7f9:2848:8a01%7]) with mapi id 15.20.7362.031; Fri, 15 Mar 2024
 07:59:50 +0000
From: =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>
To: "michael@amarulasolutions.com" <michael@amarulasolutions.com>
CC: "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Subject: Re: [PATCH] mtd: nand: raw: mt7621-nand: allow writing ecc region in
 raw mode
Thread-Topic: [PATCH] mtd: nand: raw: mt7621-nand: allow writing ecc region in
 raw mode
Thread-Index: AQHadPfPy7HGgXVgh0il2aL9T4am+LE1OOwAgAM6pYA=
Date: Fri, 15 Mar 2024 07:59:50 +0000
Message-ID: <41b70c1295c62f46ba8cf0750e152e207df636dd.camel@mediatek.com>
References: <20240313033732.77733-1-weijie.gao@mediatek.com>
 <CAOf5uwnfVtcDyMqUAT2hY3MKGj98mxMaoJ9kbR=+2GG74qY0Tg@mail.gmail.com>
In-Reply-To: <CAOf5uwnfVtcDyMqUAT2hY3MKGj98mxMaoJ9kbR=+2GG74qY0Tg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB8218:EE_|TYZPR03MB7747:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iV3FlcEAhDsq9qwFEjCeExTPluRXxWCgvdW3mrKEsZ1qf9dWJAqANHNQ/HpXtn4H11s0lC8KDJwHIY9VqD2jhyXYTMR3hlhaR3iGzWu8+3ze76ymOZ8Iy+QgQwuVgdBVTniTd93w14ZHWmYJ11XOZMpwGnbon66ZmveeQ89NoXGOIsyfFV7+r3bHMa+QMkXrDj+ak9aRBfxv+cjJmLcxu1b2zMP28JRFpEXOOmFbPsxauzASCM5AuEm3+FnJjNNxiJe5StFFqyf0sfR1J371m1CHR6pWeIMQ8f2m6jwoOglmsOmW8+l2BwWJJKcOqj/xT3z0um+VQ+ct7HlGGv6K8qbS+M4mI7T1SV4F0qCGu378BDi5pMfTVvThAvRy4al7JcqDq6C2xSNniKq5hAAHG2ijexlmFuhZdm5heJ35TIZZdc8LK93wRa+rIC2mOijvhxid4m6O7Os+3b0g/z15RZif3E/26XEsEze3GfBCebgyOm0Oh/ZDqLcWnTnT/zcXkl5KcIFYwR6Im7l/fPyX3fioNG8J+vutV3Ma3ECD1LwPJI2iwZQm9sbHam7NMoD7XOnvTvmRv7bsL1SddIvvAPsatXcaLLGxQRHOrkTuWYLLKCtQ2hc4q3XrXHy69aEnJWhsqVqwb/f6safpfXwNQxTg1eDpK37Bl8iWo/g0R3E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR03MB8218.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzdiUUQ0blM3ZFJWVDhyZ01FN1VVYS9PUVFrdVVVZU1IQzFXWng2M2ljOWpW?=
 =?utf-8?B?SCtGMDJLVFBjMkQyNjVWdmFSZEVqYUpRUU9rb0YwRkovVyt1allzZkNCVHZy?=
 =?utf-8?B?WWkrTzNBcVZZRmFhZzBIRk96bXZ1MmhmY2Zxd1NaYWFQODhnWEVBM3dhMHZ5?=
 =?utf-8?B?YXBMd292UzQrWlpsU0dVdDJva2ExQzMydUFUNi80TFlxQXhTSm5aRitpT2N5?=
 =?utf-8?B?YjczTzZIR21RM2d3YU4xL3pXcUNkVEtXTWZiUmxvdDhXYWM1OGJKQ2dHUjl2?=
 =?utf-8?B?cTBFS0Vtcm5yejFxczJKK3pra294Z3FyNVVtK2o3YnJoMHNSaWU3Vi9XN2NJ?=
 =?utf-8?B?QmpqRTFGL3dYSjVMaTIzenBxSEE0UU9wVkJqR3d0Y1RiUzNJMFN2Tms3M2FO?=
 =?utf-8?B?TCtZUFJuYnZwUFhoL2VZc0w0bnZoVko4cytFdGNMcnNlTTdYeGk5eXMwaEFX?=
 =?utf-8?B?RlM0UmZlWGIwS2VJMWpRV0dBZDArem8yYlZRelBYcHJuN0hOaDBubzJFUkc4?=
 =?utf-8?B?WFJGZjZ2WU1BZnY2dy9EdUF3eFZkMy9IeHRCTlRXdm9aMTM5QXRSMWFuUzc5?=
 =?utf-8?B?RGlTeTIwVXY2b0JvK3FPR0N4aUdVczVEZEM0OFBHcE1WQ0UzbmZacTl0bHc5?=
 =?utf-8?B?Q0U4cWRDOS9uZEtWS3ZSdjltSEcwbHJ3enRLS0VCc3VFeCtBV3IvM2xtMHZ0?=
 =?utf-8?B?V04vbWR5MzdMMm1FNkF5QWFyVkUxQmg5U0VvMjJ4U2V1SXV1WkFicDBGUFl4?=
 =?utf-8?B?eHN0cHBwYUs3UGV6aUlOVnQzcUp4Y1lLajlVeXlObzZoZE8rRCtGVXkxTkhL?=
 =?utf-8?B?U3FFNEpqelV5MlpxeDZaUk85Y0llVHlqTUNpeFZJcUkwUUtQcWxwUTd6SnRL?=
 =?utf-8?B?YkxYTDBnV1p3cDI0ZkZGZjhWL1VWbW1LaHE3bHBOcFlsK09IczlzM3I0Vzc2?=
 =?utf-8?B?anc2ZERxNjlXQklyYkp0Z0o4YXVEYUZQRDBHVHpqNXZ5bUlFZnJlMnJCT0lR?=
 =?utf-8?B?T2MrdlovYTRqd0Y0QUJGdlpCZ1dpd2RLblk1QUxTZkM4d3RmVkNZR0thQXF4?=
 =?utf-8?B?b3pPZ2FXZTdvaXFZS3ZPQ2lwa2ROYnJhZi8xSjRwVUhCbXVXdjd4WElMa1hN?=
 =?utf-8?B?MDM0TDN3NUZDVU1LQjRrRlNBV0I1OC9PYmVwa1FyQW04T0lXeHdQeUU1eGJR?=
 =?utf-8?B?QkdOUC82U0hsQk1QZHpaRkl5TTl1dVhPMEYvZWw2U3dTZEdzMEhUVm1iSlhJ?=
 =?utf-8?B?QlhjRkpIVXpZY0p4MVlQUE85SmFhWjFWMjE4U1VGWFNpKzdocjE2VXJTSnQr?=
 =?utf-8?B?ZEQzQ1ZJazZkQk94cVB6ZDREUGl3aExCeHh0UUNlWFJHVUM5c1RFN0w5b2RN?=
 =?utf-8?B?OWMyZnJkbzluS0N5Z3IxUWNtVFlTQ1RVUTNJZVNJMENiL3FUYUdhdTRBTkhO?=
 =?utf-8?B?Q2Q3cCtTK2tSSU5KaE5taTNxdnBKajhUa0gzZU05UUxkc1VSZTBhYlBZWnU3?=
 =?utf-8?B?L0ZZK0pOODAzRzJzL2krSHRsckU0bDIrcGJVbXRISUxzMEJOSG9CMTU0ckVh?=
 =?utf-8?B?Zml1YUM0cnFiRk5CQVowVlEzeE1jaW5aMm5GYTJNbEJGU0ttdXNnRWZPc0wv?=
 =?utf-8?B?SGZoSGZXTWNiVXAyR0xyQlg0NGMxbGk4Ry9ta3hFYkxkcndpYktnbHZmd0pi?=
 =?utf-8?B?bGR4UTlqakNybWxNbEgzRlh0NW9GRytkaUp6Z29kTnlmU3JxcTdVbmJSV2ps?=
 =?utf-8?B?a2lKYjRMS0Z0c1FCOHVpRjhpRTFjOStwUHI4dFVTZnRCSWZFYVZtSitnOW8w?=
 =?utf-8?B?SWtwUnIvQlg0VXVZMkxKN1dTclpyN0RrY3JpRUhJWHBMWFkvc2Q5M3l4MkJq?=
 =?utf-8?B?Mm5mSWFQNWtLUEM1UGEwRkFqcjBzSGYrUkZRV0FYaE5zZG5OREdxaTdxMi9B?=
 =?utf-8?B?eFZUTEwzN0FwWU80WEZuak95Q2VhZEJrQTNwOE1DZUdQbGlrcDF6MkJCSFYx?=
 =?utf-8?B?RFl0anVFaEIyZjFFZ05sVTZ1MlE3OEVETWU0U3AzMkxJaHVNRnpIalZGdURG?=
 =?utf-8?B?SXlwNE1YNm5lUTlST0JCQUwzcUtNaGovMG9FeFBoam5QcS9zQ0J2ZmpvbW5o?=
 =?utf-8?B?Y2tDMGpnUytwUFVSZVo3L3FvU2ZNcGN4b0Qya1phc0ZmUjlxQnRhb3FXWkZB?=
 =?utf-8?B?NUE9PQ==?=
Content-ID: <ACD09DCE84BFBB43AA7807896BE3AEE6@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB8218.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8c1ccc-79c9-401f-ca34-08dc44c5e423
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 07:59:50.6442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETXJE7+ZxNB4YJ75WgyIB0D/FciRYo1NbPNhP96ywVCQh+S3kK12QbSaAPCmJNxM8NRZMioWhpnhiO8wKDVNIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7747
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--22.655500-8.000000
X-TMASE-MatchedRID: dc8Jy61QoRrUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
 CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2tjoyKzEmtrEdaNaxZBRbNWkUNHQAoZf5cGzj
 pHB/c7HkPb2ZDVpZiDkWCu8HRhTTyYlldA0POS1Lil2r2x2PwtVg3VqSTJ7SoFLXUWU5hGiFSpV
 joJ6YTjJKx9Mdfu4IkB78fW9ruAx6NE6O6CFKP4mNW0DAjL5p+gsuHb8lxzt45yqWxi+AoVR3L7
 Mpor0oLT9aaJBCPb+RXW6gM8Ys8CEL9tcyTZdAsgxsfzkNRlfL+VmoNXJ/8FNRnEQCUU+jzjocz
 muoPCq2UTGVAhB5EbQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--22.655500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 638C02BA010958E59B00CEA5798D6F0ABB5086977A7FD8E7A1CED6C30B00884B2000:8
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

T24gV2VkLCAyMDI0LTAzLTEzIGF0IDA3OjQxICswMTAwLCBNaWNoYWVsIE5henphcmVubyBUcmlt
YXJjaGkgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgSGkNCj4gDQo+IE9uIFdlZCwgTWFyIDEzLCAy
MDI0IGF0IDQ6MzjigK9BTSBXZWlqaWUgR2FvIDx3ZWlqaWUuZ2FvQG1lZGlhdGVrLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPiBBbGxvdyB3cml0aW5nIGVjYyBwYXJpdHkgcmVnaW9uIGluIHJhdyBt
b2RlLiBUaGlzIG1ha2VzIHN1cmUgdGhlDQo+ID4gbmFuZCB3cml0ZS5yYXcgY29tbWFuZCBjYW4g
d3JpdGUgdGhlIGZsYXNoIGRhdGEgYXMtaXMuDQo+ID4NCj4gPiBDaGFuZ2UtSWQ6IEliZWQzYmRm
MTNjOWNmODFlNTQwNDFjNWFjN2E3ODE5MmI5N2RjZWRjDQo+ID4gU2lnbmVkLW9mZi1ieTogV2Vp
amllIEdhbyA8d2VpamllLmdhb0BtZWRpYXRlay5jb20+DQo+ID4gQ1ItSWQ6IFdDTkNSMDAxODAw
OTINCj4gDQo+IEkgdGhpbmsgdGhpcyBpcyBmb3IgaW50ZXJuYWwgdHJhY2tpbmcNCj4gDQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvbXRkL25hbmQvcmF3L210NzYyMV9uYW5kLmMgfCA2ICsrKy0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L210NzYyMV9uYW5kLmMNCj4g
Yi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9tdDc2MjFfbmFuZC5jDQo+ID4gaW5kZXggZjZlZGRiODRh
OS4uMzQxZWYwYmYyZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9tdDc2
MjFfbmFuZC5jDQo+ID4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbXQ3NjIxX25hbmQuYw0K
PiA+IEBAIC0xMDAzLDkgKzEwMDMsOSBAQCBzdGF0aWMgaW50IG10NzYyMV9uZmNfd3JpdGVfcGFn
ZV9yYXcoc3RydWN0DQo+IG10ZF9pbmZvICptdGQsDQo+ID4gICAgICAgICAgICAgICAgIG10NzYy
MV9uZmNfd3JpdGVfZGF0YShuZmMsIG9vYl9mZG1fcHRyKG5hbmQsIGkpLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTkZJX0ZETV9TSVpFKTsNCj4gPg0KPiA+IC0g
ICAgICAgICAgICAgICAvKiBXcml0ZSBkdW1teSBFQ0MgcGFyaXR5IGRhdGEgKi8NCj4gPiAtICAg
ICAgICAgICAgICAgbXQ3NjIxX25mY193cml0ZV9kYXRhX2VtcHR5KG5mYywgbmZjLQ0KPiA+c3Bh
cmVfcGVyX3NlY3RvciAtDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBORklfRkRNX1NJWkUpOw0KPiA+ICsgICAgICAgICAgICAgICAvKiBXcml0ZSBFQ0Mg
cGFyaXR5IGRhdGEgKi8NCj4gPiArICAgICAgICAgICAgICAgbXQ3NjIxX25mY193cml0ZV9kYXRh
KG5mYywgb29iX2VjY19wdHIobmZjLCBpKSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIG5mYy0+c3BhcmVfcGVyX3NlY3RvciAtDQo+IE5GSV9GRE1fU0laRSk7DQo+
ID4gICAgICAgICB9DQo+ID4NCj4gDQo+IFBsZWFzZSBkZXNjcmliZSBiZXR0ZXIgd2hhdCByZWdy
ZXNzaW9uIHlvdSBhcmUgdHJ5aW5nIHRvIGZpeCBpbiB0aGUNCj4gY29tbWl0IG1lc3NhZ2UNCj4g
UmV2aWV3ZWQtYnk6IE1pY2hhZWwgVHJpbWFyY2hpIDxtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMu
Y29tPg0KDQpJbiBmYWN0IHRoaXMgcGF0Y2ggaXMgbm90IGZpeGluZyBhbnkgcmVncmVzc2lvbi4g
SXQganVzdCBwcm92aWRlIHRoZQ0KYWJpbGl0eSB0byByZWFkL3dyaXRlIHRoZSB3aG9sZSBOQU5E
IHBhZ2Ugd2l0aCBFQ0MgZGlzYWJsZWQuDQpVc2Vycy9kZXZlbG9wZXJzIGNhbiB0aGUgYmUgYWJs
ZSB0byBkZWJ1ZyBOQU5EIHJlbGF0ZWQgaXNzdWUgb3IgZG8NCmFueXRoaW5nIHRoZXkgd2FudC4N
Cg0KPiANCj4gTWljaGFlbA0KPiANCj4gPiAgICAgICAgIG10NzYyMV9uZmNfd2FpdF93cml0ZV9j
b21wbGV0aW9uKG5mYywgbmFuZCk7DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0KPiANCj4gDQo=
