Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79E1C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C61A877C4;
	Mon, 27 Nov 2023 19:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Q7qtU5rm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA735875EB; Mon, 27 Nov 2023 19:42:07 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98C0B86F6D
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9yft3pR9rmE0LxlfFp3/yB74MdIT2h9A4Gf1sGDh8+og7/Ah4n6P4vm7mqkvzENwqUaSjuPQDIrgE1d6gy7KGYrzXwbOyXq/gzGkhBrdtzTIZ5zW6x1z5+BKGpPRuM+PWW2/bmtWxEvep1d90myxBdJp9f/C/Czo9v3ITptXiON2G7a/2i+U07/cY2WIUsRFHJoNYf8w3tnnIRtRXI0DKLrtnroAyjFvxwTVNJH8cITNAnq97ZWds9mQf0OJXkpa0MUWeWe4Xaj7xxY4NVz5nnrUzxb5lE4pz9DBR4udpVCLsrjm/r9dpTVojmWNBKHnRz6KMwS2IdXatnGzf1W7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qa63FbuoqB0HTbUAW6XkOx0f5PKKnstBOvUKARNOKQ=;
 b=CHg6rvYDssBAQLzwKKdI4hHEKOI9TFV3KT5TPfGZ72XfjU8oCuFSxwe9SAeqqrXhLal2v6/WtMNOA4BA6GAujHwOpnOpWXcmah3hgEXcKhAhH+mtQhA06sqOqBUerKpElaw21kCrE3wfSsTlxn4KuNA7Bv5v5z9QBYk7CPGbV1L74d69XBiJ7cMeGH6oqIOEYZEv7K+OmitD6H2OJDOKcxZzkIyZEgKh6h6mOeAGPfxOlf9kQP3KvT877LecI6LDgBoJe175G9HnCfIanyFOW6C95D9b4HlulP5TbP2aSfTRwAHVd6LdqMWbVDbkHm53PdFi6lFyx3boDBP5TQXMRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qa63FbuoqB0HTbUAW6XkOx0f5PKKnstBOvUKARNOKQ=;
 b=Q7qtU5rmzCMwhNYm50OCoUSjDw6Mymx+No8GSkO3pOolbNlvhjDyO0iR8E/yGqC8EMU4wquxCORUc1WN/voVFxcZbgS7rzKW9UxOf6eeagORhPhAikDSu3+5uW6pQALjJiv6bKVQfgojFCKHae8By0eAAsxe1e+0HqdI0zV/7qbMPeeWJfAJelxPlfETqpbLIgqzgj3P7AkrWCZ5Vkxhd8xkcengSXxdIjO3rIoXPccQoG5CwJPQHiWpYMPn+W4Zp3p9QlnNaoJ+q4qLznqYEc/Y5qVMmTnQTiJ++cG/k32wzuuD36FIuD+1I9tupd2dNIHGcBXrb5X5l8Wx4Sb1xw==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS5PR04MB9875.eurprd04.prod.outlook.com (2603:10a6:20b:652::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 18:42:00 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a%7]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 18:42:00 +0000
From: "Quentin  Schulz" <quentin.schulz@theobroma-systems.com>
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] rockchip: rk3328: Set efuse auto mode and timing control
Thread-Topic: [PATCH] rockchip: rk3328: Set efuse auto mode and timing control
Thread-Index: AQHaIKFaxg1W2zrWlkebqixrPa2Xl7COgSe1
Date: Mon, 27 Nov 2023 18:42:00 +0000
Message-ID: <DU2PR04MB85360F97227B1019F60BE231C2BDA@DU2PR04MB8536.eurprd04.prod.outlook.com>
References: <20231126194647.2238775-1-jonas@kwiboo.se>
In-Reply-To: <20231126194647.2238775-1-jonas@kwiboo.se>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8536:EE_|AS5PR04MB9875:EE_
x-ms-office365-filtering-correlation-id: 4ceade32-2866-4a9c-90e7-08dbef788a9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EyACT5GFG7KZrihnvvzuA4pPBIuwRAhxO4uf6HoAcJYWl1G9bT4LGrm+KN0EpAA5HkXVn1Y6QePdAKIuokMlPfibAe9XTzenynoraR1ae+DMioidyM5UK6ANIXMdmv0jYVAszqKNodGxCoaZRULRyVovlEjaiMTPar1amjZTpB5duNKHFDIKqsWPj0nYu4HxeyAIsfdOndElupv2Jtfv9bJ52gjIuwHXDgrl8TvdWt+xuBwf3txYQIHVh1EeT+DCY9G0eccq4aUGIxI2FDYF6yBl44q2AX5ub0iwnLsIPXGHEGCfgrFHIF/3t8VjMyfMSe5yViEvlOmBnT7fHZ53TPO58mOrrGsFElTOAth2zcjzr82+ZWn2qMVN18LEPv2hNvzIzBlvYbZhmJeOvIvQp9x737qc9U6CQl/4tjUXirQMXsa0T8cttLXiQmYwaApbntgIWf672pWyIGZV3hCyMGlunMpmxg5H7EkP1ss0KX3cCo/hORwXlVzYDuPfb0gj74TtdyTPACLXUBTujGfuSwHd+JaDuI0bspEhgun4/kIuoHwn0ZIiwqYkA7vYIVktaBSd/ezNOkO4HjSZ0U92Z88wo+oF9PPdMaOTlonqU7T9jLrIy9bepfzE+dHQGb7H
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(39850400004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(55016003)(41300700001)(2906002)(71200400001)(86362001)(38070700009)(5660300002)(83380400001)(52536014)(4326008)(76116006)(66476007)(66556008)(66946007)(316002)(66446008)(64756008)(91956017)(110136005)(33656002)(53546011)(6506007)(7696005)(478600001)(26005)(9686003)(122000001)(38100700002)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S246bgEMnEwhqpcuADjiHRpQsp/t5VdSiSDRRJ5DqnbYxV2kfhvgXZ8BgW?=
 =?iso-8859-1?Q?RhIkq6sN4O295tMdKWvXgeCkBGyz9CcfdFGNDNooLUotiMUBYxMxRx96Ma?=
 =?iso-8859-1?Q?mU/PaYnYqrcSUPjwl2v1tEdbVhVs++t6Ce4ZL1SZDIwTdYDw1YcY2PT4fJ?=
 =?iso-8859-1?Q?ImJv+wRRe4PcT7Cd0o2zW6SQJuDDKLjAa6HNT0TvAZD2Q9ilnu+8DFYWbi?=
 =?iso-8859-1?Q?Dh0DZUJ/XX/JiXSf/o4+6KMeWJ2D1qcuVzDsFl8PwhXSyar/zJkDmkDgIe?=
 =?iso-8859-1?Q?oPiKuropt1PdyDJpKdB3zpELDWPWLHUzNlXZEQYGMzWSjMwPV6yyRu+cxf?=
 =?iso-8859-1?Q?GOy2mUHICjM+K2P1Zkt8j44jN2qZv2sA2HqWD9lCsbDeXPZ+Hur+ZL/cQ7?=
 =?iso-8859-1?Q?rzWdjsdCeClZw9XRETTPlbiIt5z6PrJqP71Vh4flWtDmVOk/SRpq0CKL7d?=
 =?iso-8859-1?Q?ooMS1RGEQuM1Cm6wKhpabfWyJCt9+zXMN360+FTlIJvlUqYtyEwhaija1V?=
 =?iso-8859-1?Q?SpjdR5gXkTcuASinluFvezh2TsprRrAze/+21VBb5iqmLWXotHtkbBvjAk?=
 =?iso-8859-1?Q?xuKOKYa2qARp5DUFc/AISQx8TsYWSM0OLGfaAWfan8MZ0Uepb3ATuY8kT6?=
 =?iso-8859-1?Q?XZCS49uR2LrDFj2tpUYx8VgDahAeccQTJlaAYCELOQ8WnXuNMOV8QSgrcQ?=
 =?iso-8859-1?Q?W8j+lPKi7crHLOyzb3gxZZusZNK0ciLzyzypMkzEmEzpyIW9PivR9mbosk?=
 =?iso-8859-1?Q?UgD/ohRsm03ADOrHmXyBFDon4GyGWrVEU3NEeiQM3j9DatspYTVf7P6gUb?=
 =?iso-8859-1?Q?fskFhRv7fatdkeo6H7Uo4AgFomG6uGriNQI2FxSMsN7bvBuSZtAOg4Dp6h?=
 =?iso-8859-1?Q?FnAn0mGcHKPYREbO2qM0TVWtMlVcMyJK9JSn220ag+W92rXrOh1oXrlssh?=
 =?iso-8859-1?Q?FiZ/4B6OrHh6B6MRpK4zoDDNoaS4/hzj+acT3y1AqxJpvG6ch/LxNhk/GZ?=
 =?iso-8859-1?Q?Fa4naf55ax7qao/R9QacyaOUQa1YZzrrVNW1ZL0WydT3IBqLHYHKkqWKvz?=
 =?iso-8859-1?Q?g2f6KuZGtOD5ROqcuaQPDvhq0JpmbT4QqOMUUXUwDl/+9nUVGYzlhzm5dH?=
 =?iso-8859-1?Q?gTg6ZVkedKWAicruIeEQQRsQmxOUupzQbJVU5JzldILhvvZq0bziEy01ER?=
 =?iso-8859-1?Q?cljVQHjS8RjUqFzz0L2KuPA6Id2Cq12sF2+zbR5Z5cZD0cwBgm0ejQI6pR?=
 =?iso-8859-1?Q?8nUCHIQN8ucfAQkOn+oC4LYSwyarUtA8mBMwTmRLGrcs6L2SlWiYGiY7E/?=
 =?iso-8859-1?Q?prcrLAGhoAwBEglE5UdBX1i8aoO3cnI1yzMhQVXNf0YDJ+qJVp+f+L4Zhb?=
 =?iso-8859-1?Q?8gDI5GKxp494s6i2hYYaMizwYWdNoT1SvrGu7EQbcdvIHkAy8QCTJCxIP9?=
 =?iso-8859-1?Q?4NpUlDXyMVCrnVnlO1i2bQ0k+j6uY9T2ZREjGkrKMABP6IoRy97VZfGZ/C?=
 =?iso-8859-1?Q?JuvkyBHKCLtCp78HxbXMos+5GRYqGjdhV9IvY8efxrXu0Pr7MNoyuVBaWQ?=
 =?iso-8859-1?Q?fHOAuCmteaL9fb/cVqZMBfdyHHCBE39wPjHFabBwbL2ACXub3VVrLrlfGg?=
 =?iso-8859-1?Q?7iVuFro4JKwXOrtT8myOB88Uzf9MPp0hma/XjOEwMMtxHKISRucXjPNte9?=
 =?iso-8859-1?Q?YFejbt1QQJDi5o45cIo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ceade32-2866-4a9c-90e7-08dbef788a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 18:42:00.3203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S0AFA3uDNWr3ByhoC2f2MOAGftQFaBRetZx63nIwlAByvy9YSfAj4mnBS/IvSi8nrze/9Uw9qE3RX6Dyb7YBDMQKubYJQ7chAIHpJ8RvIolxSsqyrQJJaOIMaShtFUKe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9875
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

Hi Jonas,=0A=
=0A=
________________________________________=0A=
From: U-Boot <u-boot-bounces@lists.denx.de> on behalf of Jonas Karlman <jon=
as@kwiboo.se>=0A=
Sent: 26 November 2023 20:46=0A=
To: Kever Yang; Simon Glass; Philipp Tomsich=0A=
Cc: Jonas Karlman; u-boot@lists.denx.de=0A=
Subject: [PATCH] rockchip: rk3328: Set efuse auto mode and timing control=
=0A=
=0A=
Reading from efuse return zero when mainline TF-A is used.=0A=
=0A=
  =3D> dump_efuse=0A=
  00000000: 00 00 00 00  ....=0A=
  00000004: 00 00 00 00  ....=0A=
  00000008: 00 00 00 00  ....=0A=
  0000000c: 00 00 00 00  ....=0A=
  00000010: 00 00 00 00  ....=0A=
  00000014: 00 00 00 00  ....=0A=
  00000018: 00 00 00 00  ....=0A=
  0000001c: 00 00 00 00  ....=0A=
=0A=
However, when vendor TF-A blobs is used reading from efuse works.=0A=
=0A=
Change to use auto mode, enable finish and auto access err interrupts=0A=
and set timing control using same values that vendor TF-A blob use to=0A=
fix this.=0A=
=0A=
With this efuse can be read when either of mainline TF-A or vendor blob=0A=
is used.=0A=
=0A=
  =3D> dump_efuse=0A=
  00000000: 52 4b 33 82  RK3.=0A=
  00000004: 00 fe 21 55  ..!U=0A=
  00000008: 52 4b 57 34  RKW4=0A=
  0000000c: 35 30 32 39  5029=0A=
  00000010: 00 00 00 00  ....=0A=
  00000014: 08 25 0c 0f  .%..=0A=
  00000018: 02 0d 08 00  ....=0A=
  0000001c: 00 00 f0 00  ....=0A=
=0A=
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>=0A=
---=0A=
 arch/arm/mach-rockchip/rk3328/rk3328.c | 34 ++++++++++++++++++++++++++=0A=
 1 file changed, 34 insertions(+)=0A=
=0A=
diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-rockchi=
p/rk3328/rk3328.c=0A=
index de17b8868273..edb22a58fc67 100644=0A=
--- a/arch/arm/mach-rockchip/rk3328/rk3328.c=0A=
+++ b/arch/arm/mach-rockchip/rk3328/rk3328.c=0A=
@@ -19,6 +19,22 @@ DECLARE_GLOBAL_DATA_PTR;=0A=
 #define GRF_BASE               0xFF100000=0A=
 #define UART2_BASE             0xFF130000=0A=
 #define FW_DDR_CON_REG         0xFF7C0040=0A=
+#define EFUSE_NS_BASE          0xFF260000=0A=
+=0A=
+#define EFUSE_MOD              0x0000=0A=
+#define EFUSE_INT_CON          0x0014=0A=
+#define EFUSE_T_CSB_P          0x0028=0A=
+#define EFUSE_T_PGENB_P                0x002C=0A=
+#define EFUSE_T_LOAD_P         0x0030=0A=
+#define EFUSE_T_ADDR_P         0x0034=0A=
+#define EFUSE_T_STROBE_P       0x0038=0A=
+#define EFUSE_T_CSB_R          0x003C=0A=
+#define EFUSE_T_PGENB_R                0x0040=0A=
+#define EFUSE_T_LOAD_R         0x0044=0A=
+#define EFUSE_T_ADDR_R         0x0048=0A=
+#define EFUSE_T_STROBE_R       0x004C=0A=
+=0A=
+#define EFUSE_TIMING(s, l)     (((s) << 16) | (l))=0A=
=0A=
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] =3D {=0A=
        [BROM_BOOTSOURCE_EMMC] =3D "/mmc@ff520000",=0A=
@@ -54,6 +70,24 @@ int arch_cpu_init(void)=0A=
=0A=
        /* Disable the ddr secure region setting to make it non-secure */=
=0A=
        rk_setreg(FW_DDR_CON_REG, 0x200);=0A=
+=0A=
+       /* Use efuse auto mode */=0A=
+       writel(0x46, EFUSE_NS_BASE + EFUSE_MOD);=0A=
+=0A=
+       /* Enable efuse finish and auto access err interrupt */=0A=
+       writel(0x07, EFUSE_NS_BASE + EFUSE_INT_CON);=0A=
+=0A=
+       /* Set efuse timing control */=0A=
+       writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_CSB_P);=0A=
+       writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_PGENB_P);=0A=
+       writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_LOAD_P);=0A=
+       writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_ADDR_P);=0A=
+       writel(EFUSE_TIMING(2, 240), EFUSE_NS_BASE + EFUSE_T_STROBE_P);=0A=
+       writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_CSB_R);=0A=
+       writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_PGENB_R);=0A=
+       writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_LOAD_R);=0A=
+       writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_ADDR_R);=0A=
+       writel(EFUSE_TIMING(2, 3), EFUSE_NS_BASE + EFUSE_T_STROBE_R);=0A=
=0A=
Shouldn't this be done in the efuse driver instead?=0A=
=0A=
Cheers,=0A=
Quentin=
