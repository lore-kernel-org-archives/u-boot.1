Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A21C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3C3482D57;
	Tue,  3 Jun 2025 16:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="muVD6i0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A47CB80F9C; Tue,  3 Jun 2025 15:40:50 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7374480F9C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puvWP/L3z+9uM4ynYxjXLyeux6lRyE8ng8zvL/wp1HxwPZc89DuOy4gcgPIbISOF5QBdGTv6FMUyMT+3r3p/JabJYNi+dqnZ+ZnJl1piCIdxUL+ppmJNDNms1fVtzFxpAJiS9dSRms89VvnWJ1huD8mJCmU6CcN+nkPbuEnULHqpvSsGuXyVEFcTJxO2E/XjBljuHHCSXuVAFsciLCEI2Wiy5XNa9eovwQR3BNLsF47aYr8hj0rQzKnc+dBSiyK5cSEsubM/gZVtM5s+3UNEWaTvCU1xKawrgz8fc1IsmW/laD68hIpjUDDGXBP17GS37t7tGfGf4RlV2JJ7z/1bTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jgx1kR7CGFKYHnpdcfKGFbuLW27PNO6HbXFUy1LVTGw=;
 b=TWEXDBSWVROPEKgFBbava9YRjOXTBPovpiHCZ0ZeFggErdhSzw3diaqDQbUrP1uCUjxagGQBPI8zKcRbkCAjHX6LkrXzzh3oj1bMrG8WMndEit/A50HryE6w2+prbDSkxp4DlTx4hdSB3A5tE/Fgm2vNoDbOmq4L35F0w2aEXuEMA8adHy4DLELociAGtWqi0JjcyZO9H8m8/R+yd5s0lL1oSNKUgiTk9EJ8ASuXRQQCWv0KTwhIoXTNDpUaNfvvnE3TeTPZd6kU0V8mC/NtVitGdHcTqjw4yM1DXGzHvxJK+G+CO3CeEyB2NtRxdD4LwqY4NM14DJDcg6DJaW5cIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jgx1kR7CGFKYHnpdcfKGFbuLW27PNO6HbXFUy1LVTGw=;
 b=muVD6i0LC/ApUDgcT5uH/PMETbWJBpy9X8T4Hvsch284Lk4wMscfx05VlvB3iD1WlYCSIw9lCxuAB8jPOAjQrF97JYxlMnTT5L52w8g+rmq3MkpiC1c2RSPlo3xu1Qx6TDnekiccLqs1ZcYTKxM5htSRYWFZ0DSoL2tPwpCg6x+TCQpoB+lo/HHE9eFrGHsEI4ZLXnptqFeB5w64LCl4FX5Vtbn/RFfijLlNVAPO9EuSsKihD2SLfOMM/54jvfX4HfXYGlg5ZT6xVdPSnGXoLd8GlkBcTe3YhPMGiXnfpbj8W8wZCNULZuEYvNaosYzBI2Pxd/ZZnw1elI8+6jMynQ==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI2PR09MB7303.eurprd09.prod.outlook.com (2603:10a6:800:223::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 13:40:44 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 13:40:44 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH 09/11] riscv: boston: Add support for LED character display
 command
Thread-Topic: [PATCH 09/11] riscv: boston: Add support for LED character
 display command
Thread-Index: AQHb1I0acxy4Z3L7OUq/bxWqkxITkg==
Date: Tue, 3 Jun 2025 13:40:44 +0000
Message-ID: <20250603133744.278790-10-uros.stajic@htecgroup.com>
References: <20250603133744.278790-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250603133744.278790-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI2PR09MB7303:EE_
x-ms-office365-filtering-correlation-id: d8af80f3-9700-47c4-4c2b-08dda2a43d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?umT6/8hjZUJnmARgAuxCkmF9/P9V3dqNPvnIOEqvwrdngxicDLNnNqi1pk?=
 =?iso-8859-1?Q?HtFHiXt+F7WTdGbmtkJwxdKBWK83l9HATRWSIoWIMkKCOSuLzqbBhSXh3Z?=
 =?iso-8859-1?Q?zQCShslUCDXbT26SoVIYUFXDt7K4nfarYbHiZKLu6w/3T8LxYSeuDlX2GH?=
 =?iso-8859-1?Q?WM3XWsT7ba/ZXW7DeqUZ6uLsYNkZH8C1i+AnWU7nwYInqpKceO3J/zQrcQ?=
 =?iso-8859-1?Q?lIdaSoxJbYu58s7NlH96inpGy8LwaGwqNsJjAhTlrhNI9uqN6JXlaZARO6?=
 =?iso-8859-1?Q?1ooYUF1zCOvO3gb3x9bFt9JrTWNFqIUXsVIjgFRQNWJhH9VBIoOk2GkJN1?=
 =?iso-8859-1?Q?+x1Bua/z4aWKrfgTu1F1bKp2GuzY5L4sb9CIZu5FKP9es/mProLxg5yvci?=
 =?iso-8859-1?Q?0/l7lwwjtd9TMGN7A/fyQkgVllVuq8iJtvXlp4yaQkciOHsNZPLMqGChPm?=
 =?iso-8859-1?Q?fRAMH+4PUwBrDxmdUg8SXPNGz4jg/L5cfK1tRlVAcfFFBT3Du3xm2ETTc3?=
 =?iso-8859-1?Q?BqBTW1fa3l99aIGsZfBO54jxMyT/oi63oMNOW2vsxCHfD39PD9gAoqpLkn?=
 =?iso-8859-1?Q?NmUF0OBZFxejr6Ct7YbWSKMtWvdTZumA6iSqjKStEqj5bguE+4g4bZxFg+?=
 =?iso-8859-1?Q?Lv4/GnXgXvtNMMsHbeN3nTijK8TGd92SgVKDFpOc66R//t59YFCeXAwQY0?=
 =?iso-8859-1?Q?iXbmzQFxnZf1mFFRAJmWCjHQ80odh8cM3WEoO2f7m1IOTcegLEezB72BXx?=
 =?iso-8859-1?Q?G2gbVzp2413FCUfl9O13KWXCR3Cf4K2Nj0bZccK2M58qjXhL2mBCvHlH16?=
 =?iso-8859-1?Q?NzE+dYEH5MEhD3QF5MxUsCYuzJ77nP2sJiatObRusWtFYYMUfua6tJEn47?=
 =?iso-8859-1?Q?hgju+PZkHxwjrx+1B0yxg38pMi9NZArhwdRcNOi7LxV8jY6S612+0LF4OA?=
 =?iso-8859-1?Q?pOBBazkTi7rp6hZ7zApRBmWmKIrL5QvUb+VViBYlxanourVgnvoLerI3zB?=
 =?iso-8859-1?Q?GS1s9Fap9r9mqixxj+sYbR8MUMfQkBR6/1oogm5ZJCoEfcQWNvNmkfZFxa?=
 =?iso-8859-1?Q?ExUFaGgNsBw9sYFeV+p8kk8vOIpATV0UychiJHI3lnACghYhZYWI+IKkEd?=
 =?iso-8859-1?Q?HTwTNKCOyXwTo/hvjvYFC4jwXDu/EDhPm5KhXN0sESHk66oetRatVdu9oo?=
 =?iso-8859-1?Q?cDUoG9EhOTWVCKqPfTu1cK5xfFuwizwmPEVlyCO7SS0o8zFZryXTGVHaam?=
 =?iso-8859-1?Q?JIlfacYK9vZJUXGjNCR3OzvQVYMet6u8+ud+uwg333cNC4DaYeTvVnmp6y?=
 =?iso-8859-1?Q?/sg68BwX8O7/dmSZ99dRaHhDk1Q0OJ8NuuF44g/TJ+ATCg7q2E02oAqyov?=
 =?iso-8859-1?Q?oDDggnceAxp/8tHKB+entcFfPhhSEB+St2TOFQH66J5ZxQ3KukC8AwEUTq?=
 =?iso-8859-1?Q?ZN3rqCJoax6NWhHWshX72ujkTp+Txm6vr+fm7QeKUAtuCGh5cfofdE/TrF?=
 =?iso-8859-1?Q?yQHiCDuL6gTZZECdXx+kjneDxw+rql2+Ji6nD6lgXtMbHYmuNlXUI1a8S1?=
 =?iso-8859-1?Q?lhHA5dQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DHzsSeL2ccpscXG617D0q11AGyREez528oDkdU0gM+VrOohTXw9fjley+h?=
 =?iso-8859-1?Q?0EKcr3B4shjDMGIUsmdEhAmswRo9go+03p8JfCFoHyoM0CgD6JzfrLi13T?=
 =?iso-8859-1?Q?kXCR7wiaENIXifzAyugQJsliYpx9FdymNJ5KhS59fsnqmLwtzCOYik+TLg?=
 =?iso-8859-1?Q?pCzoI0mmDr8GhYjDyamw6Ay/wB82yGQj0QoLHu/tWG9JxiUqiw6OxZa0Sp?=
 =?iso-8859-1?Q?tKsK/BomgBL2vbhfOrQMH2g1B/cxkqY3tIobh9RKgPoMEPDVs036rqTxp0?=
 =?iso-8859-1?Q?7UPZIjc9x4YDZTI4dBhTK14LJNeaDqzKX9vjk2V9go6MvwXcsrN2a2DKXd?=
 =?iso-8859-1?Q?588M6KR8hPkk0FxCfAFyxJNh+ZBgAGLYojMUVgZuRYYNVB18594j147rMn?=
 =?iso-8859-1?Q?+SfjMeUwAiph3SGRa3Vu91qXtVfk/4XWSHDV4g3bbtXhk0pI4EE1wKDPw1?=
 =?iso-8859-1?Q?naFe19IIsxLiZY5rv4wGVwnOhPkeU7rmr6r9A5zigZPH5ia1ohsebYwCgf?=
 =?iso-8859-1?Q?iu16kiBstBlSvuvgei8zzHQAPvgkKxVejO0IPyn5z9zn9m91dcdGdxjsQF?=
 =?iso-8859-1?Q?8bc20mmzJMNov0BOzqBehzHQQ/rLOcLrOGcWNtF8gVv6HQ/i9HL6GHD9AK?=
 =?iso-8859-1?Q?zz0x2ISsoTAoHcGFapCh5r7mNUrswXloKpe+OgG9TJfHUNBYyPhyJBYZnj?=
 =?iso-8859-1?Q?gxyGfdjiHOUqVjyK7FXbV63fcJJpPKOTqUq1KIhoWIyyQKKYP3AHBmewku?=
 =?iso-8859-1?Q?MmObcTQVjDlguIggRmErsC+U8AZjS5u0OQmVosIDnVWCv2SYusMvo9JIzo?=
 =?iso-8859-1?Q?GQUgJap9TZJZi8jzCLJBRm38bKe4MNumoRET3GlTrs3KAclg5JuKtq95u8?=
 =?iso-8859-1?Q?nImYX4+kAB5HHmX8NZYOevPVUagMfq9Zy8LZsOcRAot9qQH9Q38c+05vJu?=
 =?iso-8859-1?Q?zG7z+wwm+3XRwTYr6Lhvcr+lprjLagrvWJmgUSqzk9gTEW02tSeiqBccYJ?=
 =?iso-8859-1?Q?gPBAAKWnDxEzVsjSbD39E3cS8+Etbjf+rstr/QmSwgjyAH5XZGherIScta?=
 =?iso-8859-1?Q?H1124V4+wFyB368LwKBg4Y31NOQrn2dD2ua8O20mjabPmK3yPBCK61Y3F5?=
 =?iso-8859-1?Q?munrrAko7JIsvZhAtfrV/GcVLiccWRABZevb+BMVsJa8rU9twGSs0mw9/8?=
 =?iso-8859-1?Q?s1wjWjijTe8JYxqMgIWDBCaETW79hk8BOepfc29uh2wq1pHm9gXNLta0jN?=
 =?iso-8859-1?Q?2tDHI+ioXpBR5rwm2VB69YgP0LSsF43RpqQ9zfmj/G8+rTYkmw//RBVYSO?=
 =?iso-8859-1?Q?KyR6oaA+w+iafrvx0lCW2VoT+ROng4inzxQZ/PIBfF+Cj2QEKQDMwgw28U?=
 =?iso-8859-1?Q?UZoGhJEypafdIiOpXXV5NJO0xGkxR+ka1DxJPRpdaOdoWz2RfOgqyDjuUe?=
 =?iso-8859-1?Q?Gq3EQA8xaKEKbjx0KVuaOmObhwltywmpu0g7D/g+H7vufRN4zdvp4hH76a?=
 =?iso-8859-1?Q?RXZSx/mDWq6D0Dqg43Bp+KyZ3cW0Mj+miyNtBHHXrjDeA9HGAiLOtbNdHG?=
 =?iso-8859-1?Q?KcRvU6QMij8/B//D3WNoNDXdJoF8/iY+V5ks0AzVVBbV4maJz0r7K7Zsvq?=
 =?iso-8859-1?Q?wRZG6ahvbKRi1myB60vlZaWoBoA3/y7nwg09q85tJYY2DulrBehYrtLQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8af80f3-9700-47c4-4c2b-08dda2a43d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:40:44.1177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G5oQWso4rnU5AiF9Dw5CEIdb8fmlcbpkE5KAI+0posBVEB2PFYeuW9kjjz2HaKqtmIoCkcunLREYGFKUf/Awp9Fc0nDNeOTaL7GQJXvvLHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7303
X-Mailman-Approved-At: Tue, 03 Jun 2025 16:44:26 +0200
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

From: Chao-ying Fu <cfu@mips.com>

Add basic support for the 8-char LED display on P8700-based Boston
Board using display_set() and display_putc(), enabling the generic
'display' command with clear and home support.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 board/mips/boston-riscv/Kconfig         |  4 ++
 board/mips/boston-riscv/MAINTAINERS     |  3 ++
 board/mips/boston-riscv/Makefile        |  1 +
 board/mips/boston-riscv/display.c       | 33 ++++++++++++++++
 board/mips/boston-riscv/lowlevel_init.S |  2 +
 cmd/Kconfig                             |  8 ++++
 cmd/Makefile                            |  1 +
 cmd/display.c                           | 51 +++++++++++++++++++++++++
 doc/README.LED_display                  | 26 +++++++++++++
 include/led-display.h                   | 33 ++++++++++++++++
 10 files changed, 162 insertions(+)
 create mode 100644 board/mips/boston-riscv/display.c
 create mode 100644 cmd/display.c
 create mode 100644 doc/README.LED_display
 create mode 100644 include/led-display.h

diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kcon=
fig
index 4d55d96603e..5ab89cb5a69 100644
--- a/board/mips/boston-riscv/Kconfig
+++ b/board/mips/boston-riscv/Kconfig
@@ -44,4 +44,8 @@ config TFTP_FILE_NAME_MAX_LEN
     int "Maximum length of TFTP file name"
     default 256
=20
+config CMD_DISPLAY
+	bool "Enable display command"
+	default y
+
 endif
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index 0d9a951441f..b04dcde943a 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -9,3 +9,6 @@ F:  configs/boston-p8700_defconfig
 F:  arch/riscv/dts/boston-p8700.dts
 F:  drivers/gpio/eg20t-gpio.c
 F:  arch/riscv/lib/mips_gic.c
+F:  cmd/display.c
+F:  include/led-display.h
+F:  doc/README.LED_display
diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Mak=
efile
index 007f68287bd..8ca0967b09e 100644
--- a/board/mips/boston-riscv/Makefile
+++ b/board/mips/boston-riscv/Makefile
@@ -7,3 +7,4 @@ obj-y +=3D lowlevel_init.o
 obj-y +=3D boston-riscv.o
 obj-y +=3D iocu.o
 obj-y +=3D reset.o
+obj-y +=3D display.o
diff --git a/board/mips/boston-riscv/display.c b/board/mips/boston-riscv/di=
splay.c
new file mode 100644
index 00000000000..cd222cb6648
--- /dev/null
+++ b/board/mips/boston-riscv/display.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Imagination Technologies
+ *
+ */
+#include <led-display.h>
+#include <asm/io.h>
+#include "boston-lcd.h"
+#include <string.h>
+
+static char buf[8];
+static int pos;
+
+void display_set(int cmd)
+{
+	if (cmd & DISPLAY_CLEAR)
+		memset(buf, ' ', sizeof(buf));
+
+	if (cmd & DISPLAY_HOME)
+		pos =3D 0;
+
+	lowlevel_display(buf);
+}
+
+int display_putc(char c)
+{
+	if (pos >=3D 8)
+		return -1;
+
+	buf[pos++] =3D c;
+	lowlevel_display(buf);
+	return c;
+}
diff --git a/board/mips/boston-riscv/lowlevel_init.S b/board/mips/boston-ri=
scv/lowlevel_init.S
index 8fa85749e40..f65021a0974 100644
--- a/board/mips/boston-riscv/lowlevel_init.S
+++ b/board/mips/boston-riscv/lowlevel_init.S
@@ -15,4 +15,6 @@ msg_ddr_ok:	.ascii "DDR OK  "
 	.globl lowlevel_display
 lowlevel_display:
 	li	t0, BOSTON_LCD_BASE
+	ld	t1, 0(a0)
+	sd	t1, 0(t0)
 	jr	ra
diff --git a/cmd/Kconfig b/cmd/Kconfig
index f21d27cb27f..e40fbded3e3 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2313,6 +2313,14 @@ config CMD_CLS
 	  Enable the 'cls' command which clears the screen contents
 	  on video frame buffer.
=20
+config CMD_DISPLAY
+	bool "Enable the 'display' command, for character displays"
+	help
+	  (this needs porting to driver model)
+	  This enables the 'display' command which allows a string to be
+	  displayed on a simple board-specific display. Implement
+	  display_putc() to use it.
+
 config CMD_EFIDEBUG
 	bool "efidebug - display/configure UEFI environment"
 	depends on EFI_LOADER
diff --git a/cmd/Makefile b/cmd/Makefile
index 80cf70b7fe8..e1ce7bbaff9 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_CMD_SOUND) +=3D sound.o
 ifdef CONFIG_POST
 obj-$(CONFIG_CMD_DIAG) +=3D diag.o
 endif
+obj-$(CONFIG_CMD_DISPLAY) +=3D display.o
 obj-$(CONFIG_CMD_ADTIMG) +=3D adtimg.o
 obj-$(CONFIG_CMD_ABOOTIMG) +=3D abootimg.o
 obj-$(CONFIG_CMD_CYCLIC) +=3D cyclic.o
diff --git a/cmd/display.c b/cmd/display.c
new file mode 100644
index 00000000000..0602345e6c9
--- /dev/null
+++ b/cmd/display.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2005
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ */
+
+#include <command.h>
+#include <led-display.h>
+
+#undef DEBUG_DISP
+
+int do_display(struct cmd_tbl *cmdtp, int flag, int argc, char * const arg=
v[])
+{
+	int i;
+
+	/* Clear display */
+	display_set(DISPLAY_CLEAR | DISPLAY_HOME);
+
+	if (argc < 2)
+		return (0);
+
+	for (i =3D 1; i < argc; i++) {
+		char *p =3D argv[i];
+
+		if (i > 1) { /* Insert a space between strings */
+			display_putc(' ');
+		}
+
+		while ((*p)) {
+#ifdef DEBUG_DISP
+			putc(*p);
+#endif
+			display_putc(*p++);
+		}
+	}
+
+#ifdef DEBUG_DISP
+	putc('\n');
+#endif
+
+	return (0);
+}
+
+/***************************************************/
+
+U_BOOT_CMD(display,	CONFIG_SYS_MAXARGS,	1,	do_display,
+	   "display string on dot matrix display",
+	   "[<string>]\n"
+	   "    - with <string> argument: display <string> on dot matrix display\=
n"
+	   "    - without arguments: clear dot matrix display"
+);
diff --git a/doc/README.LED_display b/doc/README.LED_display
new file mode 100644
index 00000000000..19977ea7e0d
--- /dev/null
+++ b/doc/README.LED_display
@@ -0,0 +1,26 @@
+LED display internal API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This README describes the LED display API.
+
+The API is defined by the include file include/led-display.h
+
+The first step in to define CONFIG_CMD_DISPLAY in the board config file.
+Then you need to provide the following functions to access LED display:
+
+void display_set(int cmd);
+
+This function should control the state of the LED display. Argument is
+an ORed combination of the following values:
+ DISPLAY_CLEAR	-- clear the display
+ DISPLAY_HOME	-- set the position to the beginning of display
+
+int display_putc(char c);
+
+This function should display it's parameter on the LED display in the
+current position. Returns the displayed character on success or -1 in
+case of failure.
+
+With this functions defined 'display' command will display it's
+arguments on the LED display (or clear the display if called without
+arguments).
diff --git a/include/led-display.h b/include/led-display.h
new file mode 100644
index 00000000000..50830903b0d
--- /dev/null
+++ b/include/led-display.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2005-2010
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ *
+ * (C) Copyright 2010
+ * Sergei Poselenov, Emcraft Systems, sposelenov@emcraft.com.
+ */
+
+#ifndef _led_display_h_
+#define _led_display_h_
+
+/* Display Commands */
+#define DISPLAY_CLEAR	0x1 /* Clear the display */
+#define DISPLAY_HOME	0x2 /* Set cursor at home position */
+#define DISPLAY_LINE2	0x4 /* Move to line 2 */
+
+void display_set(int cmd);
+int display_putc(char c);
+
+static inline void display_puts(const char *str)
+{
+	while (str[0])
+		display_putc(*str++);
+}
+
+static inline void display_sets(const char *str)
+{
+	display_set(DISPLAY_CLEAR | DISPLAY_HOME);
+	display_puts(str);
+}
+
+#endif
--=20
2.34.1
