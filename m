Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF79C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DAB4406FE;
	Mon, 27 Jul 2026 09:09:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ObcCjw_k7Mdm; Mon, 27 Jul 2026 09:09:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 508F5406ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143388;
	bh=Y099vgMafmnerRQOvqRzmlTCY24HNS74/cib4vJBP5w=;
	h=To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zRNX3fIcM7eF59MLXwLnPSPzZw/MOyJCh2hzuqw2608T1Qd305kB9tK7uEDDECP/D
	 tJbfB/CVdsqFIQFJz9DSaGgVtI/RONhcGt7rEp6odB/7flsvGZZ+e7C6FGQtzqox5u
	 4rAq0ZtWrdskTJGz5JYh2T+CsOaWGCSxzLw6umFSRZYArK5pwNo94DKekTwvbJVnBy
	 0COjCfC00NX4XJWtc1IDas6foBX0bdbFRyHQnF5Y2bFaBupDkY0SAT/Y9jUyR1KvtX
	 J7MYbOn2qcStTKYyMx5EaQzqs3B3dUczW8ExkGZA2xjjGY/IK29qDMPhxWcyeBTxr0
	 jXo+i4bYa9Y9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 508F5406ED;
	Mon, 27 Jul 2026 09:09:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2055239E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 120D9400F3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nyeStMcRtY98 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:12:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=jamie.gibbons@microchip.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C18524005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C18524005F
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C18524005F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjQMNWSV2lg+dQFjAcPfoy+jI9YrWTwJUoVMfhyt7TsEqpvsPLDrfQOgMtyufGzIUvaHmZOHq2KKDTvfDIuW7wt79VEtI6OvZkmyHGAH7/SfpyBzmol1JYBp+j0teUeTyFLaB3HusAjetaoqc/85RYPLVLmyd5NSOYYcFaJ3MNI0kYitOAvBM3OhaoHSCy4QAy//EXvVv2u3O38YcF6G433Qu9K3nAdl7qIFqVNv3hpL1KPSpmHBm5owT0djmO+rGI5bw/wofNRaFafM92uNDtYYCuhsqNnUoR9qZePl4CgeVeVzCv3WEO2jG+RuRLk5y8gLf1U3nKg/eh0FheVwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y099vgMafmnerRQOvqRzmlTCY24HNS74/cib4vJBP5w=;
 b=EP37U48k9HI7FLT8RUJrT2y5DWTD/KjN461ghLq9bq6EITb/LnLgwO1wilvZmG0LepbfBAf/e6035CZWSLMj2rTAs5pprlmNdyixMm7dTwUMi+NhaoJa3FSU6amgWHE+L6oMthSywmOWQyQCKfJhS65af5BFVA0PlyQ0pl5lLsIj79dLjAEsVM6xbGh2/2Tb0tDNJt0ukCa+yl3PsJ+dg31tyy5FjHgtNy+VuPvcuCfu2aEkLWjMZnEZgeOlMXrzDmG65OBBddkc9Dy5RRhHGI44syL7Ao94oQYBDxNhpglqEx+vJE4Sny4c+wbzteXxw0/UbZ5QI4JSbWqviV/ZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 LVUPR11MB9859.namprd11.prod.outlook.com (2603:10b6:408:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 08:12:38 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::b76:913:9a3c:a4d1]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::b76:913:9a3c:a4d1%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 08:12:37 +0000
To: <leo.liang@sifive.com>
CC: <Valentina.FernandezAlanis@microchip.com>, <xypron.glpk@gmx.de>,
 <trini@konsulko.com>, <Conor.Dooley@microchip.com>, <sputnik@on-the-web.ch>,
 <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>,
 <u-boot@lists.denx.de>, <sughosh.ganu@arm.com>, <ycliang@andestech.com>
Subject: Re: [PATCH v2 3/6] rng: add Microchip PolarFire SoC hardware RNG
 driver
Thread-Topic: [PATCH v2 3/6] rng: add Microchip PolarFire SoC hardware RNG
 driver
Thread-Index: AQHdGfDNbwW0a3xIv0exREXgIxT/u7aA+yEAgAARX4A=
Date: Mon, 27 Jul 2026 08:12:37 +0000
Message-ID: <5012bf190ba74c8467798efe7fd26bc53df19707.camel@microchip.com>
References: <20260722154602.3373184-1-jamie.gibbons@microchip.com>
 <20260722154602.3373184-4-jamie.gibbons@microchip.com>
 <CAC7DN2CW0VU3MBycsLzKoB0LztjC-DuVj1AbDYFFDPK4sMYxMA@mail.gmail.com>
In-Reply-To: <CAC7DN2CW0VU3MBycsLzKoB0LztjC-DuVj1AbDYFFDPK4sMYxMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|LVUPR11MB9859:EE_
x-ms-office365-filtering-correlation-id: f28a1347-629c-46fd-d72a-08deebb6d21d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006|5023799004|38070700021;
x-microsoft-antispam-message-info: My6suRSwATdd8lVf2aXZhpkyM5us8fiQqEPhaku4WGXlsaSfLGNW7qmg9A/ckGztmYGABSd63gmSzlqOymfDQy7HWdBs/Km3V29IG+HhDsbPRSBcw/5krWyO2jWR2weyLryibYh1PUm885bxAT1ODWav/F6PAu21TP5z1UQH8Xdar1QZ0RYFDJyxBwhIR++xjPa2QefMrejAI8zuic31Ko3z8SqvVmumihbTn1QyBpakvu/8Tuhva92a4PMIon/D2yVHJtA8It3ASo6ngPjIngLszFKkiTunDOega8+nPFVniYWpqADI5P4WoVDJXCirNjkSNlFWoaBj0KiOI+iMlp7YvQr/Enf9lzQiHeV0/9e9GIklm9/Te350msMAnwzfz/2/wUDzNI5UgsMF+l3QZCjXShqBuZpJvaDrG+pHb6TjvZrVKdskyu3rRSNs11/Fn7Trnr5rYLSgvekTwr1Y1kP1t9KVY/behgUemeE71Mh7pAoHPYYQOoI9lqwXqKxe55UOhS07v/asxyHU6YgF4qIn6lrf9RvET9opm6g/V8MtFtygBiuuWV0k4o+g3IS/WC6X7eHC09Obhbnv9nFQm2jJkJgZNg8le6E8Z4/PSToLGSX6iZzYMjVXeFH4alGyjenA7iAxzMk4nEHnortDX0RnNPiZ7z/GRwuSa2+6AlSvwy6SOz8ltm8QuhLXGZyTE1lQphKSVr5r0L0xKzPkNmeWc6nWMMuL0ko/OhL7MM8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006)(5023799004)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWdpMmVXcFJuNm5ycDhqSWxldCs4VkxJQzQ1aTBBMDRneWdWWVVWb1hWNDZv?=
 =?utf-8?B?a1lKUnNXVmFIL2xaSEtkc29wZDJFVGk1RHdFZUhIeE1MVnpvaU5saktNTFFM?=
 =?utf-8?B?djdDOXc2MjhSYXlQczJBRUtENWNsTW90VlZ5WlEzUm1nMWhUZXpOdktOb0lv?=
 =?utf-8?B?TFRVR1NoelNqZXc1NU9LdXNQZmdyMzFQSXZ6eG5WWmhwb2gwZVRlVzkwMXBX?=
 =?utf-8?B?aVhkTDNuZURIaVhPdFRqaithUGZEd1p5cnNxcmRQU0s0L0xzNi9Nc0xTQ1pE?=
 =?utf-8?B?b0JENENYRzNDaU9VbkpyYXRTODY2QWVIY3IzQkdqaW1vU0VzTmdBWVBhUG0x?=
 =?utf-8?B?UFllWGNsbmtvNU9yVWpiQ2JGQVdsT2FVbnpVYlJ4SEVmaTNRVnQ4QW4rbXpj?=
 =?utf-8?B?Z1pFUk1DVjREZXRtd1g1VkZ3NkJyQWlCVS9DenVMRGphdVpZbjdsVy9iYjJD?=
 =?utf-8?B?MUJSZzlURWhUeU1UVUFidkNyeW1ETUc5bitoUlJObHlNWHR1aVpQakFQQXBj?=
 =?utf-8?B?RzRvbkVQZWl5Qzkzenh6akNieGFKNE5Hdy8xY2FQbG1XSVBiMVNieXFWaHli?=
 =?utf-8?B?cURmeVo5QytqR0sxd2ZOdE0wLzZlaGRxWGNKRGJXWGFLeHFoZlZZNU5yTmlo?=
 =?utf-8?B?T2o2eGRzMTkzRXVqQzZCUVB1VzdRWEY4NjVZdVh6WCtKNkpudkFQdmtmcnVz?=
 =?utf-8?B?WlpKc0xzcUlQMTgrbXVjWXFWYlJFSU0wVHBSZ2FsQU5BNWxQMUhtUENUeUVD?=
 =?utf-8?B?VEYxbCt6a2g0Q3l3VDhBZWEyT3lqby9JOS9GK2RBeFBDVll6aVFNRmRtdHkw?=
 =?utf-8?B?b0pzcm16cHJ5SWlraXhsTm9pdVhrT0F0UWw3WG9CUCtHL1llcHhuUWpZNzNu?=
 =?utf-8?B?bmJKeWFwS3lETFJlNXZqaWVCQ3pnZGtJMWhSSTZGVmUxeXhDUHVTTjExTm9h?=
 =?utf-8?B?NWZIUUxpY0twbGlHTFZwazNUNlEyN0FHNWZ1VlFlSW4xK2Z4a0k4K0g0U0RZ?=
 =?utf-8?B?WGlLRjVSa2xWdGNTS05aMkNGMkRxdXhRSzAyZWRGWGtEc2V0eC9IRDlpc3J1?=
 =?utf-8?B?SFRqQktEN2sxZjJ5cjRtRVR6L043YzhycVpxQnNsWURta1cxckpJdXRmM2hm?=
 =?utf-8?B?dzJrQndmQjRQQ2hiMHV4WmIrY1VXZjh6VzBpRUgwbjZwS1lEc1BOZVpmQjhl?=
 =?utf-8?B?UUp6SlB4R3BFOUwxaTB3a1FKY21PZVliUXRIUmRFKzB1L015RnI3WGRRTU9C?=
 =?utf-8?B?cXh3Ylc1WGRGWVc1MUdTaGxFU2Uveld3bXVlZ0x5dDJOb1IxSUtGNjNacGt3?=
 =?utf-8?B?bGdOblRRWklvcEl3d0wrcmlQTWRaZC93dUlqQUl0eWtLbFVuRFJRTFRHSlJB?=
 =?utf-8?B?d0gzeGhaSmQ1bEtESGxVOHF3NVdlRGdvZVdkZWdMNnlhaDhCZnhTcG5TMnc5?=
 =?utf-8?B?bUpHcURlYmRsQUFJOS9iSHovazU0WXY5Z3ZsT1JEb0lubzl5elUyWC94MGgw?=
 =?utf-8?B?d3BrU2ZjRUI3WHlhSm5RQWs4WVVXMWpwVFJiN1lIRXFSZm5NSkFERVBuYjZn?=
 =?utf-8?B?eElxRkV5aHlldmJZdXdTL0VNTExCVnNIWWhDSmRuS05sNzlkR2I2enhsbFVQ?=
 =?utf-8?B?dXMxaFVyVTV3M0dHdThxM1pIWTE3bE1XK0RwcFEyMUtPRitCU2h2OERQUFJz?=
 =?utf-8?B?SVZPbkNLellwTjJ3VTJCTm5tUFI5TFN2L1ZuaHBJYU8ybVl2RTRlWjY1Y3ZL?=
 =?utf-8?B?bHd6TEtkQ2dMSDFkbnRwN1dCMnRVMkFkREN3T0t2OGtuVGdya3pTeXVBclA1?=
 =?utf-8?B?U2hjd0xnMGtCZGZRdHhPa2RhUWpWRmowclowczNOTkNRYWMvTFVKMG83NENH?=
 =?utf-8?B?ZXhZUWk2d2U5SlA2eFZxMG9ZT3BLRTRDZFd6VFR1SVY1ZHcyMmoxdExZc3Nx?=
 =?utf-8?B?M2Zta3hvSVVaNFdrQmQ5U1FoM3o2VXBmdmVzTWpFcmRzV0hkOC96bGs5S0hX?=
 =?utf-8?B?Z0c2aW5MYWRtZzBzTTRrbmJ1Z1BMY1NTLzlaNTRRR1F4ZFVZZnVCc2h6OUxJ?=
 =?utf-8?B?N1lucnBGZDN5aEhLb1hRK29BUU1nMGplL2dhZ0dVNmdSRi8zTU81VDl2MmtH?=
 =?utf-8?B?RUFuYk1lUkpILzBQRzh3b3daeHBrMU93TEc4MEtvL0twR25kbnk0ci9ZeWk2?=
 =?utf-8?B?S3JnVWtZVWJUdVJJVTE3OXZiMzJCUFdGRlM2dW1aUTg4L1JGNXdvb21OZy95?=
 =?utf-8?B?ZGdXcnZ1b0xQendqQXp4eEQrVFd4dnFkb3M4c0xxdDRXTVB4alFEYUVWVVlS?=
 =?utf-8?B?aFBCc0tYd3lWVy9Hcjc5N0dwLzRXSWZhalJ5NEJZUll3bFc2eDZLSFBwNS9r?=
 =?utf-8?Q?GH1sVO9TMgNp9cz4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8C2C5DA1EA9B545ADE6353D4134A5C5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28a1347-629c-46fd-d72a-08deebb6d21d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 08:12:37.4593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jJJvNoMkFc6UwCvPwH9jWhCy54Jyln5/NhcDvpwOWxbJiNl7oIrJ4UeaybtnSJpM8oRwMPGRY9ixOaae79xUCr8HlfAD1KsMi/+Icpaz+FU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9859
X-Mailman-Approved-At: Mon, 27 Jul 2026 09:09:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchip.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y099vgMafmnerRQOvqRzmlTCY24HNS74/cib4vJBP5w=;
 b=VoZpbs3ZQs39Mnjte0pmgDRsBLwjhlhe6WS61j+6X1gWu0Dfl21W4uvUO467rC6rJkpdB30FTd4IC/EsB4r92ZRJJZheEqhF/boM9V8831p7IPP1VMetWm3pEnd90VeRfKsUQjYY1ppO7MoAYbVJleeHh2UX7qU8BTuHJNsFW+3AoH+35vFvgUdh1PKUQyt8tfyS4vapuRg7/tS1RCSdFBV6EySw+69uFkzOA3gkyH+E/IOtr9XfDLehmeo8hdcc7nG73rBS9zKZE5z1chGs1Uz5T4fKy+CkmjrY4ljBG/KsWxS6+B9bx6otp3nn1HCSe/Xeme3Q3eNDtfl7nEk/+Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=microchip.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=selector1 header.b=VoZpbs3Z
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
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
From: "Jamie.Gibbons--- via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: Jamie.Gibbons@microchip.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

SGkgTGVvLA0KDQpPbiBNb24sIDIwMjYtMDctMjcgYXQgMTU6MTQgKzA4MDAsIExlbyBMaWFuZyB3
cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBK
YW1pZSwNCj4gDQo+IE9uIFRodSwgSnVsIDIzLCAyMDI2IGF0IDg6NTLigK9BTSBKYW1pZSBHaWJi
b25zDQo+IDxqYW1pZS5naWJib25zQG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEFk
ZCBhIFUtQm9vdCBSTkcgZHJpdmVyIGZvciBNaWNyb2NoaXAncyBQb2xhckZpcmUgU29DIChNUEZT
KS4gVGhlDQo+ID4gaGFyZHdhcmUgUk5HIGlzIGFjY2Vzc2VkIGluZGlyZWN0bHkgdmlhIHRoZSBN
UEZTIHN5c3RlbSBjb250cm9sbGVyDQo+ID4gdXNpbmcNCj4gPiB0aGUgbWFpbGJveCBpbnRlcmZh
Y2UuDQo+ID4gDQo+ID4gVGhlIGRyaXZlciBpbXBsZW1lbnRzIHRoZSBVQ0xBU1NfUk5HIGludGVy
ZmFjZSwgcmVxdWVzdGluZyByYW5kb20NCj4gPiBkYXRhDQo+ID4gZnJvbSB0aGUgc3lzdGVtIGNv
bnRyb2xsZXIgYW5kIHJldHVybmluZyBpdCB0byB0aGUgY2FsbGVyLg0KPiA+IA0KPiA+IFRoaXMg
YWxsb3dzIHVzZSBvZiB0aGUgUG9sYXJGaXJlIFNvQyBoYXJkd2FyZSBSTkcgdmlhIHRoZQ0KPiA+
IHN0YW5kYXJkICdybmcnIGNvbW1hbmQgYW5kIERNIFJORyBBUEkuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogSmFtaWUgR2liYm9ucyA8amFtaWUuZ2liYm9uc0BtaWNyb2NoaXAuY29tPg0KPiA+
IC0tLQ0KPiA+IMKgZHJpdmVycy9ybmcvS2NvbmZpZ8KgwqDCoCB8wqDCoCA3ICsrKw0KPiA+IMKg
ZHJpdmVycy9ybmcvTWFrZWZpbGXCoMKgIHzCoMKgIDEgKw0KPiA+IMKgZHJpdmVycy9ybmcvbXBm
c19ybmcuYyB8IDEwMQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDEwOSBpbnNlcnRpb25zKCspDQo+ID4gwqBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ybmcvbXBmc19ybmcuYw0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3JuZy9LY29uZmlnIGIvZHJpdmVycy9ybmcvS2NvbmZpZw0KPiA+IGluZGV4
IDE5YjJiNzA3Njc3Li44NTZmZmRhMmY1ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3JuZy9L
Y29uZmlnDQo+ID4gKysrIGIvZHJpdmVycy9ybmcvS2NvbmZpZw0KPiA+IEBAIC0yMyw2ICsyMywx
MyBAQCBjb25maWcgUk5HX01FU09ODQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIEVuYWJsZSBzdXBw
b3J0IGZvciBoYXJkd2FyZSByYW5kb20gbnVtYmVyIGdlbmVyYXRvcg0KPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoCBvZiBBbWxvZ2ljIE1lc29uIFNvQ3MuDQo+ID4gDQo+ID4gK2NvbmZpZyBSTkdfTVBG
Uw0KPiA+ICvCoMKgwqDCoMKgwqAgdHJpc3RhdGUgIk1pY3JvY2hpcCBQb2xhckZpcmUgU29DIFJh
bmRvbSBOdW1iZXIgR2VuZXJhdG9yDQo+ID4gc3VwcG9ydCINCj4gDQo+IElzIHRoZXJlIGEgc3Bl
Y2lhbCByZWFzb24gdG8gdXNlICd0cmlzdGF0ZScgaW5zdGVhZCBvZiAnYm9vbCc/DQo+IElmIG5v
dCwgSSBjb3VsZCBjb252ZXJ0IGl0IHRvICdib29sJyB3aGVuIG1lcmdpbmcgdGhlIHBhdGNoLA0K
PiBzbyB5b3UgZG9uJ3QgaGF2ZSB0byByZXNwaW4gdGhlIHBhdGNoc2V0Lg0KDQpObywgSSBkb24n
dCBiZWxpZXZlIHRoZXJlIGlzIGEgcmVhc29uIC0gdGhpcyBpcyBhIG1pc3Rha2UuIElmIHlvdSBj
b3VsZA0KZml4IHRoaXMgb24gbWVyZ2UsIHRoYXQgd291bGQgYmUgZ3JlYXQuDQoNCk11Y2ggYXBw
cmVjaWF0ZWQsDQpKYW1pZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBMZW8gWXUtQ2hpIExpYW5nIDxs
ZW8ubGlhbmdAc2lmaXZlLmNvbT4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gTGVvDQo+IA0KPiA+
ICvCoMKgwqDCoMKgwqAgZGVwZW5kcyBvbiBETV9STkcgJiYgTVBGU19TWVNDT05UUk9MTEVSDQo+
ID4gK8KgwqDCoMKgwqDCoCBoZWxwDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqAgRW5hYmxlIHN1cHBv
cnQgZm9yIGhhcmR3YXJlIHJhbmRvbSBudW1iZXIgZ2VuZXJhdG9yDQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqAgb2YgTWljcm9jaGlwJ3MgUG9sYXJGaXJlIFNvQ3MuDQo+ID4gKw0KDQo=
