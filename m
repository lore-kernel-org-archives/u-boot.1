Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14ABD3ABFF
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:21:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AEBA891EA;
	Tue, 12 Nov 2024 14:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="DXdTzmR4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CF21893C2; Tue, 12 Nov 2024 14:21:31 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F03891E4
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Manuel.Traut@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhZLAm+duq77+EyZ8xdZgxKwmFawwS17D6njUftiCAIkJVb5ybiAWxCcNgoz8WcPk4lDVh5Tx2ncNwQAbYYbxrQkTANwMcn5I5RfrZCdkmntV9W9ib01lWlG29n7YE4JIfU52uvBChpYtT8LIfQB9vueimB0vz5QlXJxQ8Mog7+k2Ah8s6cqIUapvrmCcDm2dBhfu8t7j3sH32I2mBlwp/chSbUkikipnRt4oWB04FaA7MVfS59OxMLefLl6OIomkJpe/oWRiFxdy7hMdu4/oz7cj+Xtb41lcnF7VZUiwyiO14xRCOwEEx6fm7HzzIPjkda60vwKNrQRD5ogbwu0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mqz+CcFKJkKLPizDy8Nd8d6l1EOLEEnrak/3EY8N2/c=;
 b=m827EtjkQmBiXzOPtt28P2zOx83kKsdTBIcYFcA2lriebubhCnqSFpt5BdagIGVUP6SZccY7dJBoGVeXCqosx8Bj55sdWoa9SQvDs9kS14I5B9FrIboFOTc9bQaIFTK52QMXPlc0PzHCZ1Q8fhYNbMQ8wWl97OWDk+nZocTCKSNxCQLY3gHJBNxMmtp2U0aH4gVM3COf4EGCCDI2qr2kjNQt9xKu8cSRbvpIofYyqaV/yebK1LOZrPGFe/RqUwbfqG/OubZWRwOhzJm3K4uz/Qklsy46/tjdDZ6+vPOlnWzScGv6yqm5xabxzmkjERbXuhI7r2n+1WkGbjcShQs0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqz+CcFKJkKLPizDy8Nd8d6l1EOLEEnrak/3EY8N2/c=;
 b=DXdTzmR4AaAuiKHhX7NRBr1ye3t1H6/Feyf5H7M9GQlFNCfjmTTJHqE9Q16anU1lIVdYSsEl8KelqExMmXteaZFber5WS1V+oY3pLNv9ay3ZpWqm56LEwjNuTZVLd+vOj8IfLW6BT+DsgkyU6zD7BNbIRpn42Zwoq0DnCwA6Ig/YCREfEcC2/rIu7sqsXDVjarcurD/DSbJQSbRGu4FirwTX008dwaR/vAcNFP7JXXmNJ9Mm5tzqv0TC/EiIyPRlFQb+54NVkHwLZcB5Icz35m1NBM/nj/EgPlr/QhV3ONcAnVa98NfC9dC2/rOrWTb+Gbnq6C21icFVzvxUnchPSw==
Received: from PA4PR03MB6784.eurprd03.prod.outlook.com (2603:10a6:102:f0::8)
 by VI0PR03MB10783.eurprd03.prod.outlook.com (2603:10a6:800:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Tue, 12 Nov
 2024 13:21:27 +0000
Received: from PA4PR03MB6784.eurprd03.prod.outlook.com
 ([fe80::c014:9ad7:3215:fd7b]) by PA4PR03MB6784.eurprd03.prod.outlook.com
 ([fe80::c014:9ad7:3215:fd7b%3]) with mapi id 15.20.8158.013; Tue, 12 Nov 2024
 13:21:27 +0000
From: Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Venzin Daniel LCPF-CH <Daniel.Venzin@mt.com>, Gujan Armin LCPF-CH
 <Armin.Gujan@mt.com>, Manuel Traut <manut@mecka.net>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Burak
 Gerz <burak@gerz.io>
Subject: EFI File renaming
Thread-Topic: EFI File renaming
Thread-Index: AQHbNQUDoanMxbukykaXpP50n7dlbA==
Date: Tue, 12 Nov 2024 13:21:26 +0000
Message-ID: <PA4PR03MB67848E8118A8AF7AC8AF3C1BFA592@PA4PR03MB6784.eurprd03.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: de-CH
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Enabled=True;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SiteId=fb4c0aee-6cd2-482f-a1a5-717e7c02496b;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SetDate=2024-11-12T13:21:26.962Z;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Name=Confidential;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ContentBits=0;
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR03MB6784:EE_|VI0PR03MB10783:EE_
x-ms-office365-filtering-correlation-id: 409a000a-f3a7-4869-cba7-08dd031ce99c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?DqNKHyyv8Qf2mBAyVJCf+ZyS6zfr3D5ei1aKO/lmegUakTY6Mgh7XTElPo?=
 =?iso-8859-1?Q?dloycG2aUT5QYJciH3m91XuE8B01YkcGCUAxHRcjqylwxxNCr96KTmfd/F?=
 =?iso-8859-1?Q?r9Tb2W82EE9bq4YR3uvZ+cbpUtrGLBe4svhrQ/ZBZ4uvDoeWmfK/EgkZWn?=
 =?iso-8859-1?Q?/nVjSDeMQk9mXWZlRyq2ZRkJUXzFjz7E87Dwpp4XvOdLk4dk+agjbJNem3?=
 =?iso-8859-1?Q?hSoddzrXacJMDxcY+m/h7QjklF21IXtrVkpNBhxHvYEpToVoCMuIfmWeQv?=
 =?iso-8859-1?Q?eOPfad+lB8vGk2qkmGkJmVYvGoE7bp70pfHxgBE6810khCYsNAZnZaTmmX?=
 =?iso-8859-1?Q?xLO1ueYty4MZkL/xwkzI7IriHlzn8+jgZLzRhXWyB/64Fv9GR1ubdlT9lB?=
 =?iso-8859-1?Q?L9Uugvikuqp27ao76BPn4j4/d91viqD0qpNaVFj7Wpn4Sg4hE6bnQKxoNY?=
 =?iso-8859-1?Q?hwYxqvFfSNZCrsnke1n1ftIvDn1BY3Hk/q4+R58G9L2wCwC8nPDUNGWa+H?=
 =?iso-8859-1?Q?dBvn3/R3q7e841uASHeOSPm360JqR9Sc0O/bUkb63SLAD1zCchcugmLZf1?=
 =?iso-8859-1?Q?Grv1b3+0YKWXojfx970Q+DkSL0CMGM4SJjwnRRqU6ruJ7YzULhgsG/iHBE?=
 =?iso-8859-1?Q?BLj7WOrF0kVahKIv1ZEul2zO1RLJopLFIhcpGxY3ivie+BOtUlHVLREhcN?=
 =?iso-8859-1?Q?qRjN7ynE9s9+hurkhwYzjpz2Dg6avFL2rmqcm61eMcbkgsoqHJPi0Ug3ij?=
 =?iso-8859-1?Q?bhak92MFd4JNnALPiKRVfGQLgrDYmLS6zMWiq0hvJ8x04o4iSkMcIsQ2zC?=
 =?iso-8859-1?Q?aCZ6xmGwUNBzEBoK/6Q+lgECN8KsKDVIYhAANCwRXjYTLbZs1VpP54lCBj?=
 =?iso-8859-1?Q?HEUZ0JMvMY48tNugv4++QJBDXS40k2DEhuHGlewecrUVRuwRj6PfiKxGrn?=
 =?iso-8859-1?Q?25JMaHH7Q6DNI9VAtAV7zrarv52cA1NLvwAiAPRUOxzYrVJMr3mygaZyCh?=
 =?iso-8859-1?Q?g+nILBliJAwqiFnKzJ8EIV0Qzv1cDomVByghZRfcXibZREBBmaCTYd9hwt?=
 =?iso-8859-1?Q?RG+C3NAdEixDpEB647UP3YdCS7mLwpYv6JtHjty2YxknFTgEIRLFvJIPcn?=
 =?iso-8859-1?Q?dp/KGxx1UTHdccEDfSGZJY7yZ9DuVnI23VDyoSL7ctFh3oxGv24jluUV1i?=
 =?iso-8859-1?Q?SLmnRZtABzYEaPnIIi2zeY8C4CoSI6Ncf2C7Es3wEu++jAWqnEaO82bgiF?=
 =?iso-8859-1?Q?b5IbGMQiR8sPB6SUT/6ArpFst78rf+FcpvtH86Z+A4/cIOrfIZO9gu/llk?=
 =?iso-8859-1?Q?cD5wUdkMEzPw0Vp4V0YEX3YnOwo1+upTzvIvPZCs6TDkVv33OI8lInqp5l?=
 =?iso-8859-1?Q?ix7+c/bodl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR03MB6784.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZGtHx2AnVNQ9DMKbYWrTOifbUS6eF2fZPCAT82Y9NqKEzSwoILRATedtJO?=
 =?iso-8859-1?Q?xHiWcUSNZPei9IXd4BJc1wDSCkAfyphBrSzDWGRDJkFvNEreQ1rrm9URtp?=
 =?iso-8859-1?Q?a/lY0Jz8vQu3NvnpsRQiHYiev4BatycWek5EdqY88iBAAStap3k5C/4xKs?=
 =?iso-8859-1?Q?tA1ywwZYZrKph3D9KWFQaHqmDnkyduU9ER16x7X5IeWfnOGEMiiTC2fRbj?=
 =?iso-8859-1?Q?Aw0WA95jPVyrUXj7CqxQU5ilKVo1pcIbhFIDbNqamtF95SStYybdXEveoF?=
 =?iso-8859-1?Q?iCHIVEKGsW+Lngm+oOUvr9dxkLY/8TIIQpI1f+jloWxDWpFj9S+8Zqgk/t?=
 =?iso-8859-1?Q?zx1epnAOxaj6rBsAynL098KtoiU8AhwxMKPXgz+7b8uLQnIfP1dIxp524Y?=
 =?iso-8859-1?Q?N78Cowdl6Byren8uVAxZ3VAQ7kfDTeEbqKu4ybz+NoBWREK4NFvq15abWB?=
 =?iso-8859-1?Q?bYroFeaY/EjOgDlDGv+BRUDCgne+ClV7iilm4xyBktmeIVCqWekcuSIOb1?=
 =?iso-8859-1?Q?pBBM7UR0/2CAm4txbxUOie4TFx62vOvjGHZ7dHN+oC2Xs0P1ftA66dWcKo?=
 =?iso-8859-1?Q?W1cSbSwDxMVZ27rnV1C3qEXsn4+zuwidHtaFdzJ0vd2OuJl9w6cr93UCUn?=
 =?iso-8859-1?Q?j5dh/SncHQVMIP/ZPL6wW5yvqUuK92csXLTnBWMF70zk6lpSv6ZMIn77hP?=
 =?iso-8859-1?Q?6zU7zQE7n6bJwlNoS9Ev9AQNN4sNAF84fg7MMwzvdM7NvmUR2k0P5ZcUfb?=
 =?iso-8859-1?Q?xxML6EzCwdfhHxv6wWW4YFo3TxHqCLyMqXj/V8tOw9PX+ESLKA3Z6Dn63m?=
 =?iso-8859-1?Q?pHkn2YPO9cDk3gZ1LHsTsxzQhwWUDA7n0FG9coHtX2kgEhAtJDvVlC8MBg?=
 =?iso-8859-1?Q?iTZU8EPENAQ12s+uBdfOYwR+TGB1pPOnvkz1yIYoNhCiNvaXjcBU5mKFbS?=
 =?iso-8859-1?Q?z7nJqRsnDEh/PPJjY5Mi687nmRORee3EeLUuWd7QwrCAPxWM0uTr/opQ8+?=
 =?iso-8859-1?Q?+QCO+PNEUDJNEUhwTzMZbwnKmVtZ0dAAG9pzdnotZAqi7HZDuTIr7UbZ75?=
 =?iso-8859-1?Q?R1epwgsn+8gCQI1rJSfJ0gzchYthq2xgNvwnlVRB8G2sKMA1mtRWNfn+XE?=
 =?iso-8859-1?Q?AzhSY/1+35bxhylcTK+/cPxqlKkWYSBAStCFcYeSHjgfDUe35AZkHSf42U?=
 =?iso-8859-1?Q?/j+IjDy8PwCIi8hf6yGno3gVc8utuSW0OK/qG5OAeyPAt5t6slV2ln79W6?=
 =?iso-8859-1?Q?aTdPQlbZvr+BxanlAyoaDHaLm/BAUIGoqSVAv2PdXAmwfb2AnXqmG1JgY9?=
 =?iso-8859-1?Q?RaebnCPbBn2ICZ4c0bvJeIrHoAKYSfFGSKUc27A4omLzE6x/ESK5aBYN+q?=
 =?iso-8859-1?Q?AWS2S8Ekcn7B9zP+SmaZdAAcxvTm48Z+x0SyAUlSvQNpkQe4WB08kUXZf9?=
 =?iso-8859-1?Q?RuCV5k8xH24J7XUvGcWVJTSXz08AR++lwsyH/Bfg9yxwwWTPoYZN5IM9O2?=
 =?iso-8859-1?Q?Q15gBCjxY0yo8jnCiWHgEcrwNA2lvttOQvb1zeIiGb5moFxyxCZ2RpsvZj?=
 =?iso-8859-1?Q?1VGHdRzzD2QPs2qZFisZA/NZ35Ans8r8CC73HCxktgJIufecWj3MwaWlrB?=
 =?iso-8859-1?Q?KKfAjqOXtkzfOe1tqvGsk9Xc0Lyb/33qxP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB6784.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409a000a-f3a7-4869-cba7-08dd031ce99c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 13:21:26.9492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCKTxx1mmeWOLMgAIvWIFFdcXEffHRgN7aC2d1o7cdIe9dXd95xme6jWpd5Tg2VKEWwt2bsRdqCMJoJaORQmXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10783
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

Hi,=0A=
=0A=
systemd-boot counting logic requires [0] to be implemented.=0A=
=0A=
Is anybody already working on this?=0A=
=0A=
If not we plan to add the functionality in fs/fs.c and fs/fat - correct?=0A=
=0A=
Cheers=0A=
Manuel=0A=
=0A=
[0] https://elixir.bootlin.com/u-boot/v2025.01-rc1/source/lib/efi_loader/ef=
i_file.c#L971=
