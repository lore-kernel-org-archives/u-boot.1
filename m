Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D20E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 10:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B88298007D;
	Fri, 20 Dec 2024 11:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="d9+seZ99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF5880087; Fri, 20 Dec 2024 11:42:07 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA3E880079
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 11:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNi6OVks5n7Vd/kiJUdzcO2JrEBkSq3W5+CbSalH8/pAvz5zzI4jXfuTopc/aucnjiTb23FQBWv2jskJt1ZsRLNS3H5Vhm5JHpRiySrthhIzOUyMarjFVs/AM7frGQXbDYvmSG6ZSHV1YPdqTC5ecAnTTEZlJ+VZE+SMwBrKSeyXYQAWGxXmD3Z/FLq1XtpFJv5eI9uQQCvDX7npSupXWHiWiXkDx5CeREjxhSG1SqOlcBGmO9hqobkCfIXaiHwsnNgYIgHJLSAktYZrbo67HItgv4VLcoHuUzuTD/Mm29hVjHYNTGS/VoUe1F1n4BoppfSDkMPI/rCK7Ks8AJYZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhCVlRzawsitRfCnKIRv5jj8EEZua2PBbqva8Zcjk3M=;
 b=i1zd891kBLUcLhSIROpmN38CkdKni7G7v5uSV4X1Ii7PvtmQTslovPDTcNDT4ZkUCq5NpEYfTFh9kWw8ACopMiLykSQXELBdSjqTmaYHVTcCS/ejR2milvlB3Cc0n/5pDD7QlC+wdq6yky7WasH4h82RSTIqGpgoGKft+/9aQRoz2Fc7A88GZmfFJHeDzYKgm4mT1h9BPgBPn37IwtcZoBmFdCd3sICsYLf2zmPKkvC/cQhkPs5pgDQDkXBS11Fe1jLr6+FsAemdT3DKcMhK3nfzA9alEBW7htFR3lVd8inaJT7lXsIvxUzGfSc0rZiqpQ5+ucTadylfgrNHSRuK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhCVlRzawsitRfCnKIRv5jj8EEZua2PBbqva8Zcjk3M=;
 b=d9+seZ99CvpKRWA6GO+L/rHsfWaJSLrUH6WbWhDFIFPU/5KbZDY8ORFTgpRbzd4YS8n8s7Kc4CVQ1Ro046jKLUEMs1MqaxBHuanV+h6OtJxsR0OSFobWHC32RcYdVVDnwFGtrUiqiSbxPzXsMV5J1Kp/Y+0fJv5J16eXSdPol/00sTYAUsFGoyae3NaWvnqtC1wYYjCsnDLj8jS5fVK8SSrzlfs2E+Gj8mU6sp1vEKPFGbZvCLjozGMG4zzfE4D+htfHEcnCATafQRiMNL9uFo77/RiG3E7GUgZlr7hMTqxNXbcPb8zsoqNVigi43kgglFwHs3h//hXblAxQngmYdA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 10:41:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 10:41:59 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Li, Meng" <meng.li@windriver.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>, "trini@konsulko.com"
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "jerome.forissier@linaro.org"
 <jerome.forissier@linaro.org>, "festevam@gmail.com" <festevam@gmail.com>
CC: "Li, Meng" <meng.li@windriver.com>
Subject: RE: [PATCH] net: fec_mxc: add DM_FLAG_ACTIVE_DMA flag for FEC network
 driver
Thread-Topic: [PATCH] net: fec_mxc: add DM_FLAG_ACTIVE_DMA flag for FEC
 network driver
Thread-Index: AQHbUr7wylO3/uBHnUGyX6AhLOuNO7Lu8eJw
Date: Fri, 20 Dec 2024 10:41:58 +0000
Message-ID: <PAXPR04MB84597BB4D33EDC414C518BA088072@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241220090919.2186070-1-Meng.Li@windriver.com>
In-Reply-To: <20241220090919.2186070-1-Meng.Li@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PR3PR04MB7340:EE_
x-ms-office365-filtering-correlation-id: a7bdc10b-e03b-4fc9-eeb4-08dd20e2ee58
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4lovyfIS14bgJwH416d5NLfdLN9A5bFzerlUb1QjRCF6dMfjEtFESqM/7dNn?=
 =?us-ascii?Q?6cAmf7REGptYeNdLO6XC9hqxZidGzqQSHNST3u7/8DF3qqvYGHmeEXVVjNEz?=
 =?us-ascii?Q?+VIrLhMQ2ZCR+0BBZmT8KZY7DIzbJRodrJojYBvF/gSDDt+oGULhqrsvB55w?=
 =?us-ascii?Q?0RD1ZS5fjbaoSbHEi87vx+QrqYb29NVuD3ZtObvksupyqiHT7iM4Fxhhc9oe?=
 =?us-ascii?Q?OgQcsit9y7VwBw5ZLfRJ1Mc/N+TxTrkqq2sSiUyz8HB1f3OiY0WJ7UvWbgCS?=
 =?us-ascii?Q?jbcRxIPLEA6Yy15YugeoiidD1gFtnZeM5pmGCV5F9ppi93NVqdpGtcS1GjXs?=
 =?us-ascii?Q?Tb4edWzAGa47JPk/MU5QZkrsgup0maIQP3wC1BzGVe0lOFEC8lqsfkcbXsfg?=
 =?us-ascii?Q?XwEUGuIH8AtWnWEnwSU56+4IqDi/9oLejeAHLGrXZsf/fGCaDEKTAbSB3QrL?=
 =?us-ascii?Q?PEpC0ETjiD/4eQkildb5hGHDYXBIX0x2VTH+Eob56kcPOuSBzQGCdf0/Jo8j?=
 =?us-ascii?Q?fY28aBX0XY6p9+P+Yh/PRiCED13NAqddseXceE9sLaVMg82nDKgFvvSCSj+Y?=
 =?us-ascii?Q?zQhD7T7sr6bvMAJ2pH9COqiSC9+os8YhBx7JVqdB2JYjJW2LdPzjedUwA9yR?=
 =?us-ascii?Q?zsOutn4iCT2dQRnWZxjh6nAiCHkskvWwdtHQXJTvP5s+3GXi3rl5TMBCDKoW?=
 =?us-ascii?Q?O0Axo8MkaB/U6UiFGOihbNij8hO5Bdw+CEuxc4ZbEt7IHxTJmEfd+VeiykKR?=
 =?us-ascii?Q?vQEr5gTuRtipACUzdgaUJMjvC4RtHjDT/1mTfw1hk0nNQRXaM7VXqiMwSmC2?=
 =?us-ascii?Q?YV19QVTb3TXzmaEW2C1bZ0yD6UB/TKj9HKqEQLtz9ITpdq9HxxmAakey8smR?=
 =?us-ascii?Q?CUOr7cMJ7rDw1THI/NJXMNXEjyYiqymNqlTgWf9TbWuMD70jiuWeo/FZ9F2Q?=
 =?us-ascii?Q?9YzFpBkKF04jL+JxN588oi6zCcepw7FQKaxnl9kbcZEPk8JHoHkeLcUCbWSN?=
 =?us-ascii?Q?n8WRKHUBnsi1PmHG6BBC/o8bkOh+Y/sj4A/9AROHW60NYbxzyf7DYFJU85EJ?=
 =?us-ascii?Q?aPLsM1ic5C1xqvKfm/NTy0bMYsYlg1aV2AujlutqCUI9gO/Qs9YwImlHN4c1?=
 =?us-ascii?Q?HnGy3pqBHVJtdxy/LfmNYuffooT2c450jd8JleVSEU1/AE/5LV5VtUJBWu3h?=
 =?us-ascii?Q?DtK/220W71f2A9A3uZCUIxFNFQ01NEAcPdyOjTw3oOv6/gQ0fji8IN3vkcD/?=
 =?us-ascii?Q?g+FcSNXwc8GA+fcuwhr8Y8mCo5SDTxTIj23J5usHOxnqipdwuWyr9fLOkOiB?=
 =?us-ascii?Q?a35f5VYBvA9PpqR92DQ2nAjNcrqBqtJo+sVhAy+A8Aks/PXG/H6HL2JvSLod?=
 =?us-ascii?Q?cErrTj/5StgIaj39oCa6/KF82qFDsD8Denxa/nxAoUZXMJeFARaK5VLd4PYu?=
 =?us-ascii?Q?wCfV/mSJO93ui2Sr3DV/qjsApODpd1iafTJ2JknHQPgORwCh3zboVw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fF5Spk2L/gUgIF8F5KieQqH6YEOHBk5KIlX07Bx8q+cQH8Yl2Hrp1q8fGeBL?=
 =?us-ascii?Q?JpVLRrdP2IZ0DZ9ZnIe0dWrDOOy+sSwRh3ekVVWoB+8FocsLj0m3LXHSjwPq?=
 =?us-ascii?Q?f5+fjJ9RtA8VtAUVYsuSnwaDhsyuAnd20SDh7i/gvHftILsqR/ANgJbSTuUZ?=
 =?us-ascii?Q?qAy4MPeHKwy6jSoPoQOmIeWWNMQ1jKUIRJLwZpL16rZLyOB4Twg5ZispsA4E?=
 =?us-ascii?Q?b1Vyrzxo+hsWs1IDh25TZYLM7nCXiWFJrTL5cMp0hpN977SrpZYvQYfDJPua?=
 =?us-ascii?Q?S2WF9poPkkCHht1FxGjL81xwq79ltnjL5Reb8AJ2x1WX28n708J2KT+0XL2d?=
 =?us-ascii?Q?0NtQ4wJXp8Wknx23mcm7yfE/5n6k7ai20BnifB32GxgbEIZUTe8oGSjZZPX8?=
 =?us-ascii?Q?NM7xptkEq403DtcyLAic62r6jSqsDR/QVpkqDuC3+pgbRXD9LmKZJ7NUoBSk?=
 =?us-ascii?Q?R65nLAa0jUZ1FT5f3P6AiMMUHR3rOIjOuhnCd5HFoDg3Zasft9G2AgPUy5O4?=
 =?us-ascii?Q?bjXMH7aJMuhjAOAkRxBwHtEoubSz7Sq42wju0IsdB71dAaiRAyXYmqRuoFtu?=
 =?us-ascii?Q?Owz/Acxsgf3bFejdCbA/7D2acoSC2jSglC6eJTpJOgvrwXRUjzq5mG71iJJo?=
 =?us-ascii?Q?wQSa1QzS1OsAhDdDC478vJFy91/sUff+m1skJNlNmExEFo1f1hl0xR+MvrUs?=
 =?us-ascii?Q?4sf7wIPIxq/7DFwaM6HPPnfPm2gOvLIqbIYI6Y5fuaS6O8X602qr2zfWf0fH?=
 =?us-ascii?Q?8FKbHu7b/dAOu3+QJ+Y5ALFgkXfJp8SVjCckaZ+3pUbcxLjohsJdBYDonljD?=
 =?us-ascii?Q?NnPJ3EueJ/C/3zyDEC49JlMT960/FiZBEMW8pvwhkOvjrk4tM8BTH1CWh2i7?=
 =?us-ascii?Q?jVhpzTcbPDtqIq/17RxCRk/C5CN/KVXbR26RVfbujsevDBeeh2RcasRqBKOH?=
 =?us-ascii?Q?RjmhfSN2KLoKI3KdWWWwfiBjYxw2S5ScG2oXuZmOr/0pCOIgrHKp7HGb1acV?=
 =?us-ascii?Q?SRmJKD6fDcjOIKI/2UTZMm5D0ZzXaw2VKA0bK3yoBAUqYgIVRvguYVkW5PZy?=
 =?us-ascii?Q?1QHqqMOZqyxiSQe6gRIrFj675byR4Dofdq0GMv5B2g3YAju88E/MSz+xYniG?=
 =?us-ascii?Q?mvmmGHG+dMP8ZN4w5AFUQ+DEvGQSLEXpptTFCrsAfbIlesq1Mx9GcSXS0RyM?=
 =?us-ascii?Q?3F6MGjhsoeu8582MYTPnHZnC4GUuS5x2IOnrb8Z25Rd4GJDZVlKCH2vsmkKE?=
 =?us-ascii?Q?i8Knob0cO31WqI6UF86RykenD5mDZsC8pGf2WGpdSRGGIyM0XZlwKYcJG7Yc?=
 =?us-ascii?Q?UrsRdU84Rb38LcxdhrI18mupAjLI1NkkCY2K07R2MTGvdO7NQa3I2UMut1MV?=
 =?us-ascii?Q?76V13gLuiglROQ41L7k+b4o52YWri/5f5G+gq5KU+uGvfzBRqweOcdj/b48f?=
 =?us-ascii?Q?PoO8xNzoajKA2iUmhbjZo9af/ye0BWfzKQkE66kZYwuZof5u+Ue7W2U8gWDj?=
 =?us-ascii?Q?/Sw02JxxMjhMVtizQ0vzYtnrQFah5iDa/ZD01aHz3k4D+v9YkT0GWiqFc+ER?=
 =?us-ascii?Q?Cx5VBZBOfZoWw7As1Hs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bdc10b-e03b-4fc9-eeb4-08dd20e2ee58
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2024 10:41:58.9589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDcO27dX5zPlPi2LbSJXp8s2scKnxe5qJwdLre8RwRi/EaeNobgQDiz+/SphG6E9hKPibSdn55WKjG3k9ywDcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7340
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

> Subject: [PATCH] net: fec_mxc: add DM_FLAG_ACTIVE_DMA flag for
> FEC network driver
>=20
> From: Meng Li <meng.li@windriver.com>
>=20
> When FEC network card works as the prime one in u-boot, and is in
> active status, kernel might crash during booting up stage, especially
> working with grub. Because the DMA of FEC is still in active status, and
> copy data into momey if there is network data received. In this case, if
> kernel allocated a part of memory that has overlay with the memory
> used by DMA, kernel memory may be destroyed and cause kernel
> crashes.
> Because before kernel boots up really, u-boot
> dm_remove_devices_flags() can call the remove callback of FEC driver
> with DM_FLAG_ACTIVE_DMA flag. In fecmxc_remove(), phy power is
> disabled, so there is no data received. In this way, it makes sure that
> there is no DMA action, so that avoid kernel crashing occurs.
>=20
> Signed-off-by: Meng Li <Meng.Li@windriver.com>

This looks good to me.

Reviewed-by: Peng Fan <peng.fan@nxp.com>

