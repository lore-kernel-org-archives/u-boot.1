Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82930C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB3D381100;
	Wed, 19 Feb 2025 14:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dfrZ7Xwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1316C809A4; Wed, 19 Feb 2025 08:27:41 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9DEE800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrQpICoHFaL6+gFIWA6XCFFvxy2OGHScTjYaDmnS6ASZgVQe6F3S2w+dl0P3X+EBH0H/yJKvLivXmK5FEPNqXSBQD5E6ojpS5EGLYyLP4fuzXMoWS6YbAX/G1OeBoUb4yXRVOOhRoAyvZPZiSNkz+5EnQ+14mS8h+iCl9zxZE5Tx3fS36++scIWYcDx5XPuLJN5KjnoN2tLwi70O8+MVSKc/qlrqxxs6a4/8ObrH+QKTuvmP6A7N6ATuH3IWHP9VQxNUXzTSAn+jRokQAUveIDTJ+ZdsZouDUiHuN04eoHdX61qASacY1hUx/DtB3xoa9pePABwuWtG7EWZqC8TKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MWUxfz5JoQJ8B2/LpxHtggNpHG1YcCo4WWwi2Gf60Q=;
 b=rWpdmHx+h527U3G5No7mkXmSOKaqJHF5xXXitm6auzOBSI65uaQhA0YH2VOGh274dVMGnMBxdAmjxvU+x6BZMJ/86eQnQ0CYek2SWNsKkxtTvINgXIzBC3SOwfJBKMAibWsI8GdIkeOH7gY1TW7szlWdnRnLeUUY6tsvRWNSn3gZRKMIvsz+cm81I/uyTgcl3VbKHLjca3RliljJs1l7tFQNM+jI7OFQGX0pNLY43yCFYGYGzgkx2oFISs21MEFAVzjT0bzn3XP7y72LHWTxqDZ6ybV9ix+5p9JMduwOoqmFtqffZcJ5YMMxy8WFntLGu3eLMXa5sn/Wm2AT26juyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MWUxfz5JoQJ8B2/LpxHtggNpHG1YcCo4WWwi2Gf60Q=;
 b=dfrZ7XwasrAOLr8rwz/FUAzWDT7QBsIGglbRBHe3UKPQ+svpC0rkdctCFpyzgInDdNmrUU+mTqfuRwumCixY+T8HRZLp8ltNYZ321kRoUV7tdFXBSua2gYkK8CQp84RK6LiQAuxndeLi667S8c6czKDfbKGKrdjz8We8HeIbmO79SpP2siJ3Sujz+1Yl+1HGHJ19eFoz6QiQqom4vIZVsnpa9lrZkKr0Od08JX+qCzuBlDWbwRJi52+FBst1UF4NITaglj3vJmQwCaxGVd7s5eCSH+k7gQj+rancSM12Jv5pTa91b73u8o2jPNgvCc1ipFoOrltkirwFJBHbG7lyDw==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by SA3PR03MB7253.namprd03.prod.outlook.com (2603:10b6:806:2fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:27:36 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:27:36 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v2 26/26] configs: agilex5: Enable watchdog autostart
Thread-Topic: [PATCH v2 26/26] configs: agilex5: Enable watchdog autostart
Thread-Index: AQHbgeAzT9aqm6cr90urgTg58U4YoLNOO7fw
Date: Wed, 19 Feb 2025 07:27:36 +0000
Message-ID: <SN6PR03MB3583B1F98E82A3830CF35CDFA7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-27-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-27-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|SA3PR03MB7253:EE_
x-ms-office365-filtering-correlation-id: 54f23cfb-c586-4bd3-1eec-08dd50b6e216
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?iysxlwX5R5mW9SuNNFernoin7J/fMqinPclU+a2noNbsugXabeB3h1x3Z05Z?=
 =?us-ascii?Q?rU0miLAdf+8ywX8imlADhu08pJ+WDVJ8mIsAbKa7BzJb6TnvWqzt9ZcA184A?=
 =?us-ascii?Q?3mv5lSIQ3E1CnEi52bvvWAqgIoeFeL90aZiJh9HWCj/o2ozg1FjA1itz8cQZ?=
 =?us-ascii?Q?AoxBOXUn0F2Q+mVpPfaMpoBe7vEYVmDSYsNS4dKD9OV1xPaKrSdJaNRs2X7R?=
 =?us-ascii?Q?P0LB7O97wKuNgtoT7M/ZEQhuwcj5De3ozDYifkA5EGi1Beuaq8U4ScXNDLyo?=
 =?us-ascii?Q?6jo+oPRzIBMaNdMzWIsyV/mwXN+JT4XBuU2slsk9o6iR4PTizpUYMtIljKy0?=
 =?us-ascii?Q?DLd+Ioo0jY1khz7HkUH4jjQtfbCpN3DWiL6Gq4Atgz+nqW5SMTlOYm+/PHr3?=
 =?us-ascii?Q?NnwfrUtroYn9RX9nZ+C0w/0ZbCLqCQ3guAAu8xxZeZ+hYYtd1GsKrlE3M4oR?=
 =?us-ascii?Q?r3DgWJkSOx+X4LUO0FIKaO+nYZvRxAW7DrpOLyuFTWi3KbPkT0BLaUNbWPMW?=
 =?us-ascii?Q?EUcg1lgiw3QmEDiF1gxjqmdfXggX+6dY8XO8rB2OEjzVkVyWOnGVOKrUgBYR?=
 =?us-ascii?Q?HrjQUH0e89jNwk2+KsyxJc+KHU0FmYddCy/lcj96WUP1yAUwnzUUOMduQOSz?=
 =?us-ascii?Q?URKzAF6Dn4PFUPJI4g7Bz6/hD3HVZW7nZfdbMheFvEnO85iX/wuhu3cZdWmE?=
 =?us-ascii?Q?0LQZ67j1j81YoPnA1GHw9MOXCSA4PsNiKFHD7J9KpS3naondtWTaM7rr3S7/?=
 =?us-ascii?Q?07PyjxRyTmoZOSpMLxs2FCPOlfMqtV11aO89HofP9JtyfsBalklXa8QCXPYK?=
 =?us-ascii?Q?/3G5XPW8ChPxnPDvx2UMNyWKevu4wjlRMpjOjF+f0hIjNHUexQ4UZXn39EJw?=
 =?us-ascii?Q?/14KDVY0hodf9+mzYzxrbsIhDnCgz53zBtFRXvQ/B9jx8Ji/A7kTAwF2HzLj?=
 =?us-ascii?Q?Pyp+xPBNWVc72yf3hl6HiLVNXfaotJ86UIBQri9g4jHF7jKaEFC9ZknsWU5Y?=
 =?us-ascii?Q?XSgdaOOI89T20+NQEBuC4cSuJvggZs7F1FA2LtLjMO5BYhQJxbKV8xls9C16?=
 =?us-ascii?Q?lNyKQu81yz/LSuFLxEE+v92HWCEhVpo1n6xF6/umSFa1qPSnDSr0HD/EWZTT?=
 =?us-ascii?Q?1+H8iX8A0ek4c5UHxxladvy7gqG9AtjB2VGvTtfLFo6+STDDAM9EaZy1+aYN?=
 =?us-ascii?Q?noxK61fNJCrKd31wDORrEIjIHNlaZrQjPA0xVqIS4EgJO9BRvM/Ov5izm1Np?=
 =?us-ascii?Q?6dj6SMq24B31vNA37jQhwiUOiXVknOnzLKG7SVNN4WgPK5sU+VXtSFuE2Bej?=
 =?us-ascii?Q?1/DLp8LfuvggBlq8ViU/modqWZ8VYr6649KZKRSMHhssjnJYUaGQm/8mv0BO?=
 =?us-ascii?Q?KaGPb6Cm5wpB0F9c6mB2MHzN/GTNV5MT1qb68inPRIHXdFveOojhCqvz3G1N?=
 =?us-ascii?Q?VvGV3O7so7IlwJXDhOkwJ9ziy5aJvxav?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QkiamnXzbnmiX0pOQpFxgab8x0od/7jG3CFsvZX37m9EW6r08KHs+5H73wnK?=
 =?us-ascii?Q?fcyaA66yzRaP/ZiTGsao4/cybPiWtfYyiSqXlh8yCb1loiyKs8KxOTEsGaf5?=
 =?us-ascii?Q?77+/dWcF8ddEf4b/mEWSiotnloi2vM/pd8dKE2ms26/Nc8Z6Fb9TEAh8KXQA?=
 =?us-ascii?Q?hp3YXxiVlyfLymENKRKCihvZle0C1GPqqDdSZjWPpKZdiyNbxh7kmi6r0KiM?=
 =?us-ascii?Q?A+V9BDwkQ0iJuP1B+EXWKssAgT9Jpb3xJjroENBR3Q7qCB+eqdNldSs/DrPm?=
 =?us-ascii?Q?06m/l6lNdbCVsd0AUPG1hB6lfcJLIHSQIeU2aFCf0TFbUd7hJMHvsPdY4g2c?=
 =?us-ascii?Q?1vcBr6fFfH7o0aqB6El+oy2PdaW9jKbOzvdLqfuPssLUpw6BLJSk7bXkfTad?=
 =?us-ascii?Q?Qz8U5WZzoVxKelkQlwaNIOaZ7j5nVhiwRAxOU/kNznLa6e5RL6iUVVY66neR?=
 =?us-ascii?Q?LcfJD+bpvqODqfU45YVYRC65880HE30sAAH7b6+Pw+lRX3GDnLpTRrbL6aus?=
 =?us-ascii?Q?ypcpK1U4RYZBpDQPg9Hqo5+ixAsMtNCufYwdlme8jGvbk17aR9uxjhdDEOpA?=
 =?us-ascii?Q?KoNgBZFr5c04PHbARIEJ9VTPp9E4AX2dtWurdbEK+1of67aZ+J9fzIx+lN7u?=
 =?us-ascii?Q?P01/CzuEj0299PmcoJhaL+0Q2gvyVdU1PjVG9TH5DlA26Ieym399eFNbyh3s?=
 =?us-ascii?Q?iJnRGUsRQuCCNpUTthaiybU1/WX3Qpw8F5f/rvMIUIw6/MpztxauMuQi9FZW?=
 =?us-ascii?Q?KsuBId9NHhjVhPQ0s5CPy198SfrgZFpOc14ml0YBRdSYaON8YFevJSTovsif?=
 =?us-ascii?Q?cKYqBEt9EFKjg48pyHStZEMN+omoOMJ9MrSMIsaPcfBq7d7zytslRElmC5ln?=
 =?us-ascii?Q?OfjHz5pzfr5TrDLVAch7y/zZ6EHEjoLwiJlLzP+xUsgRtqVWCI9zSEppow5E?=
 =?us-ascii?Q?zJhNGN1l1HS45U0g+WrTeKc55jYdGshJMEYmEH5N1ldyu2dYeVjo2/YHm7TR?=
 =?us-ascii?Q?srCJ2FsgL8phENGQMlQ+fpRLTNR7WIOKyxX+hWXJ16ExAyyOss1zt+CMWjCq?=
 =?us-ascii?Q?jLnKwLgbbzZj9wTy3hZX3eBKGlu5SYtQ305WnfG4ye7lj/lqyC3iUaKfyjSU?=
 =?us-ascii?Q?nSFHnSi8Ufa0V/PvtSoFMjymh9My6iICnjluJr3Zjw6uvYG/VI2JVwV+Bfzf?=
 =?us-ascii?Q?rGRUgbQa3T3Y8Ng3HLEVcMICKAWux7fsgL2Hg+iF8SfnF3uJ5xxpNIB49+G5?=
 =?us-ascii?Q?TIDTHwbmROuL103bjfusNZqdxgI0JfSTK60tQNAJZDfdWYJtBQpIx7ovJjPR?=
 =?us-ascii?Q?4sBXkqrvtKa2paOwN7byc7calZG/sZyhIKQvcVusAeE1xYhxMmrOpIPJow6O?=
 =?us-ascii?Q?NoMDkVGbuQBo8lhh8IHRlz4scwOyvTG8ed2iV+T9W4lpoOL60eKwA2pqk9wa?=
 =?us-ascii?Q?wWdVpJCL01Pp4q/KBRMD3Xs4VHM1SEyf1IZPp5BcHHprARCFyJm7EUl1aPaE?=
 =?us-ascii?Q?eMZv4MJMj0LxIZilCbCEhycNN4ayGWH/Nw/Gi4Q4f48tGR3bA94bCd52wrGb?=
 =?us-ascii?Q?ImxRbzqJv0/WmgDFj0OiJNCeFRl3cMP3ViBNSWq5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f23cfb-c586-4bd3-1eec-08dd50b6e216
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:27:36.3309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y3R8AZvBgINwy/8eWJRHw3Ce12WVBlOrfu7YJPQQDfqbFXrSckZ5ZcgpInawX14OLaFXNyFBn1m7w5UFprXlUIoPMJLd2Ly//nFgZ5j/eb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7253
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Yuslaimi, Alif Zaku=
an <alif.zakuan.yuslaimi@altera.com>; Meng, Tingting <tingting.meng@altera.=
com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea, Kok Kiang <kok.kiang.he=
a@altera.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 26/26] configs: agilex5: Enable watchdog autostart

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

Automatically start watchdog timer for Agilex5. This configuration is enabl=
ed by default in the Kconfig, hence removing this configuration from Agilex=
5 defconfig.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_agilex5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_de=
fconfig
index 5b3e8125aa2..ca3ec23acfe 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -86,7 +86,6 @@ CONFIG_DESIGNWARE_APB_TIMER=3Dy  CONFIG_USB=3Dy  CONFIG_U=
SB_XHCI_HCD=3Dy  CONFIG_USB_DWC2=3Dy -# CONFIG_WATCHDOG_AUTOSTART is not se=
t  CONFIG_DESIGNWARE_WATCHDOG=3Dy  CONFIG_WDT=3Dy  # CONFIG_SPL_USE_TINY_PR=
INTF is not set
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
