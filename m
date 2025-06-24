Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D12FC77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D0A82E86;
	Tue, 24 Jun 2025 15:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="fXlann3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B0682D17; Tue, 24 Jun 2025 12:27:34 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1471182C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQrRSqEusBjOy/NygOuxMbEOeESUFGPG//GIkygFMYqglRrWjLWfzCJZgU9tOz3kXxl1KIs/FvtiKuuba3llJ3zI+32IxLx2/+rLSgYxoqVxu1elk7AYcjxARz4dGMctETcOx3ntKg0lngffZDp/ygIC7rH4sK0AYoFluZqOogggtoRlobkrlXGhcLYztAgcOyV5hJm3W1z8N5o6SWRCjFi2wQwHSJ2ILh5z9a1ZNxO5gi43Ep1g1hGkqihvRk9hOwiOBCLctRaLe5HWLdcUj+WbOb2YQXvrpm1nj9y+PR/RpwHIgDMqSzjUPD54bQqK9NCc9djuHg2U6Mp6A2GyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU9eBMxH0zDOQsbdqApf53Fhda6FPIuZQFLLtMYPpso=;
 b=TNuNAhGkkkCBCW2ICNcaeSFPKJ9MdPSz+F8EGaHVoU+yGMp0Gf1/NL9nbrpUdfSaKj+Pg9reSXSRXaHSysrmh+t04WCNnBcVf7G+8ib+mDK3kPICb2RwhkPT6VDMYGv/dMBYlQrmR31Mi5UWUHQTaaCXATLlcgYOlE/wtaaNfiVZAYgxZYu6y4h6+KLPkR5m3zDiVtsFO1Mx0GxZgI/Pdezeai5JymO6GfeVvVwUhihwVN8QxKPHIbzPpeXO9gzP+DK6H6wmpmnbUaEe6ovnHkcR7uc3cEPHIjC+qmJvcPhB+tuMDV/6KN/Rlf2XSbmg95rgyRSQuVGRL+ko/Ap9vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU9eBMxH0zDOQsbdqApf53Fhda6FPIuZQFLLtMYPpso=;
 b=fXlann3lq+bISgVdyyBHDl1GyYuBF6rXJTVtxftbAsa0891YH60EKGYTgFxYKUd/vLUEhMcYrWn4MXegcy/m5U3LIcl8aX4q65JVKhvSTfQJijblAVyQ9D2Kh70WuGOssycDAkyM5zjxg5WZ+nmZMr6f4LZp8nGPOg9lrQY139n3095AFugGJkbUPbSd3h0Q2edbTh8XlShdzndLKqoTrL8qExoKbueP/m4lEmxzF0HeeqiqVdYEvVLDQ0KFekyrk9YjEPnlLdGqcSickmM6SLFSVg5EgwMrZl3G6LbC0p7QItp1j+HRa2HL5JCrHES0i6ukN4owDNjE6vV2E77boA==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by PR3PR09MB5475.eurprd09.prod.outlook.com (2603:10a6:102:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 10:27:29 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 10:27:29 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v2 05/11] net: pch_gbe: Add PHY reset and MAC address fallback
 for RISC-V
Thread-Topic: [PATCH v2 05/11] net: pch_gbe: Add PHY reset and MAC address
 fallback for RISC-V
Thread-Index: AQHb5PKWr/ufdxNwZUuZSqJZe7luzg==
Date: Tue, 24 Jun 2025 10:27:29 +0000
Message-ID: <20250624102449.324410-6-uros.stajic@htecgroup.com>
References: <20250624102449.324410-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250624102449.324410-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|PR3PR09MB5475:EE_
x-ms-office365-filtering-correlation-id: 50a4c82f-0941-410c-d8b8-08ddb309b8ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?4m40r98OYHtnbKIihmKHSlrgBCTkCurstxLGo4cvXks4W0sXbuiIdir+Yf?=
 =?iso-8859-1?Q?DXrjbl57d5+DI8Fia/8U3abJVpjQOaK58OSZLT1p6szwcVxIo8hVLSZfsZ?=
 =?iso-8859-1?Q?O5JrUjnAAtwT+SYS9VrAdq/Tks/jEdnqan0qaT2lZRufZx6dMoOc+sXciv?=
 =?iso-8859-1?Q?a+E3rkme589TXGb8sholFNOoOP50IaEU5uODPaZznDZHPL03BI6oiF+9Wr?=
 =?iso-8859-1?Q?DZMet3CBVQmOiqvK+Ih9Vd3zbLSKqo0HQ8R9NPYkklDqDm0Urc3v1oQ6pZ?=
 =?iso-8859-1?Q?1Kr07mVQ4NuKrkhCJGwtI7YiKnOB2dC5wg8v5nRSnqmT5lEh95rR4+D5/2?=
 =?iso-8859-1?Q?U20iC+XK5hG84mUYRO45pQzSQtWWjS2D2NFRHo02q6wcxc67cfYzvBepw4?=
 =?iso-8859-1?Q?B8S8mkluEi5aU038YFX3dPeB0vFxr/7eAwI6Coojph67LWfDmHe9zSDj+K?=
 =?iso-8859-1?Q?AUGE3DV4g/lTEJTJX7UTHpyfvl6aOySLHFe/yXlb+l2KafaagolT2lG3Bq?=
 =?iso-8859-1?Q?C4/SVS6dzJI92IBlZfFv5tcXM+0I6hVOttg5ObdHtlGlYb2OdohBtWij0l?=
 =?iso-8859-1?Q?8h45aC0lzdfNlltd2qvfKj4jCIdy5g7+WQgW1kKZw1ZTciYby2m/QnVLf9?=
 =?iso-8859-1?Q?0tszdGM5dDxGk6TkW8NB4uhqB/i3RIuo/8amd0haqsrOAS7rEcXQePQ0AT?=
 =?iso-8859-1?Q?s7VhQ37csXlM63VItxu3nKr19MimC20CvjP3XUd/P+hoKfLAF256YAihC2?=
 =?iso-8859-1?Q?wiDAxmzz9Bf9pEtiSjUbpB+X78Q3FPLXCaMCp9fY34dbRQjaYNozRvyvTR?=
 =?iso-8859-1?Q?GcNMgg4HXcVlLZxVd8njS8YP++9HiSQsdQ2f8WaIu2WxcDrmnsUWxiRpgM?=
 =?iso-8859-1?Q?Z+qavw7ua0metuMF6mk/kLu/PJ0/iR86L989cbzQWk6LMbn4eIgmkVNn83?=
 =?iso-8859-1?Q?1kdZtCznEzQCTRrdovPqKMjgh99BYYnsARIEw8oFJ/4LCveiHS9nOtNJ4v?=
 =?iso-8859-1?Q?Y8qK5zllyhtWVJ0pr7NEyPMP46QP1szTYUj9gB3zCN4a+G8M6XMQ96rULT?=
 =?iso-8859-1?Q?sAhRsclXsCdrNE3SVxL1VpY5rknds+iWpovuuvx4hAUmA44kYzj68bq0dL?=
 =?iso-8859-1?Q?kQMa/HrnefMaoUM+nEfVrV1e0oPIoDJttD+ZuTOcchfCtaCZAoWSz27sO9?=
 =?iso-8859-1?Q?wL0OZk12EWrtmi/jJP38x4FyXka3oTCKnXBD/vUCq6pfa+to9wXzeMqW6+?=
 =?iso-8859-1?Q?PSY9AP0qnC0hx1MYaD6mMeMK2A3tK08ULzPtvR2cc6B2fqQIixND7pa4y6?=
 =?iso-8859-1?Q?+bNty9dTFinXCfFrIdId7/iPl7qNFYgMmpLAQvz+Ps8aesnHae9DlPCVA8?=
 =?iso-8859-1?Q?3Tt7TmP4awUDzvqgMNx9JdyLjD+6Fh15stCJx6Xr8Uh7+poT8PEe6Y+MA3?=
 =?iso-8859-1?Q?SN/0cYH5jAo+X9rWnR0awU9+CjRD83CQGinRMJcXeMf8KPuBCfmGKmaj6V?=
 =?iso-8859-1?Q?lRIo2ciSuBg3ixmQk0ryhWkqagHbLB50WT5bjNW8Jyjg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RA9SGq5bkAGyHtw2JeWA9G+9SqFB3QTUtYdrgHWfQNTMM5fTwhPyP1uS4S?=
 =?iso-8859-1?Q?MsKP4oC0FdyAebV9CHBUrg99b3XdqkyAI2kfV0xNojKfhqmSH1SXm/jimr?=
 =?iso-8859-1?Q?nGj6VIKr1ZD25qKGteQI0DQTLTJpYDYcLgzedCHSFyiivBZPE/kxtHJzUC?=
 =?iso-8859-1?Q?jhCanByHkPbBbcLs7u8OtNg571IVbRzH3LlJThpCbHPjEDnyTeeMw9/dhV?=
 =?iso-8859-1?Q?/4aIY+1omgGt4T+otP5zH/OoscaX6ywq0ZyxTuupKdtz9B7qgmccrhwW/i?=
 =?iso-8859-1?Q?ifFJ+JbeJNhhJzPPSkbFeBCoXmsros+2Dg/3I4AVWi/2Tf/EMI5xkdIDO9?=
 =?iso-8859-1?Q?KbL0QR3BKWmQ4wsJpOrsPD7tbc8BzXwmKpAD1cek6ErlPwzezxT2MNnd7G?=
 =?iso-8859-1?Q?liNOh3BsjWqISRsnnWrng9Jgef6pOX+cVxpPXPw0nqKdoJpOcTUTVD98cg?=
 =?iso-8859-1?Q?JOPS1p6dFREPwZz+kcUGK9p1B9imVCL/fliPCWTPo1DcFyYLTMfALJROfc?=
 =?iso-8859-1?Q?nd/cHUZMsfvMX+sJ8ov8WWtn/+ArcDZX6byZUVUPtEuW72iTCu5NTMH9cW?=
 =?iso-8859-1?Q?a6ekrtrmmSB4XnJ4USbjimOEARaY1w3TsVW4wjwQfPR3TQYYsr7w41f2b4?=
 =?iso-8859-1?Q?dOFNiE2k60ScEYapsU2/TBwZRTcIPNU9Boqflh2i1QAXP0UtbQGAV91a0v?=
 =?iso-8859-1?Q?hWjfNeHpmHTikXq+d7HsL0EGvnrXVEhaPteCBvBWdU2z3rXhzztl+BG5Np?=
 =?iso-8859-1?Q?aknfo3lFvi5B07VIZ9S5gKAjCQ3atF8p7yLkhlNLY+vYX35+0+BQ02DL4a?=
 =?iso-8859-1?Q?B2ckXIFo97JYqKVTiScSNUM8Tul9uxG4xAfoZ6y+g71E9SElXCwf8mNsnA?=
 =?iso-8859-1?Q?Cv0HCnDZnvOskRSuOblZtp4xmMEgqCzg/235kMQgskA7NKfKvi5E36To3J?=
 =?iso-8859-1?Q?s6DdDQZskyWTG4jRwtdxvz13repqOrbs5+bX9FiguTGAQCpE6vDqX1Tawg?=
 =?iso-8859-1?Q?WSxhEeZ2lqTtg2LRt1tCOSu7xGaLhLEyOMg8+F5Nbdgq/q07ghSaq59CP9?=
 =?iso-8859-1?Q?AuU2FGdWyuNpqQZSjR6447mE0Q+GyHP0YQBL3Gv1zUeAcbd2NlgmwwyPTG?=
 =?iso-8859-1?Q?iGUKm6YajvNTKkAkxcHEvjbISrmJ5mha7eERFReWibKLaKwGcx8+AgGEKF?=
 =?iso-8859-1?Q?FEHB4vkTPOYTDgAUodHqamzWVO6M81leu3/OuRciZwBel6Z9kpi1x4c9ob?=
 =?iso-8859-1?Q?UmZZqLIMgjulyRLlaVdF7I0JajLTd+N+fRrvoC1amT5YXYSkGy6/C/p4zX?=
 =?iso-8859-1?Q?faP3BbYbAwRQZSc+GGKjV/e5kp38ZJqvVUzXm6oVqyY7AopNOjiLspkDTY?=
 =?iso-8859-1?Q?U1rfAS729p91LjjP94/WAu1PK8prvhNnVa+FbXTIx0eQLF01ft2zhFBsbZ?=
 =?iso-8859-1?Q?aahoQmzX4zovVMO7041taPziyzUrzfs67C1errTaUNllAcZOP7qQoJ+GE5?=
 =?iso-8859-1?Q?Hct2r7aD4FERKOPDhuf3ZMCF4n8s+H48IW3ia3I3EaBnwZQIYF1izi/d2T?=
 =?iso-8859-1?Q?rWZeTfvmleAc43Oa7mM53uyIKj8pvHElRYCSoPgaeLNrFwz9Iie/05VuW0?=
 =?iso-8859-1?Q?8fOHVxM0W1bULg5cx7nUXakAGLx9EMLG38JY4SYgakOU/FTfrpIFO9Fg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a4c82f-0941-410c-d8b8-08ddb309b8ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:27:29.4965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJw4PeKUkIfV182VzoykV2Tk+SCGyicE/FsDS8VxisUo0fa0YrZsozEfJmU3/ZNdMms6FAbb+hkjxShMuYFZjQxny+K6+4kHuLvNnn5/PHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB5475
X-Mailman-Approved-At: Tue, 24 Jun 2025 15:12:20 +0200
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

Add optional PHY reset support via GPIO defined in the device tree.

Improve robustness by handling probe errors and falling back to the
environment-provided MAC address if no hardware MAC is found.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 board/mips/boston-riscv/Kconfig |  4 ++++
 drivers/net/pch_gbe.c           | 36 +++++++++++++++++++++++++++++++--
 drivers/net/pch_gbe.h           |  1 +
 net/eth-uclass.c                |  2 ++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kcon=
fig
index 68c5fc50489..4d55d96603e 100644
--- a/board/mips/boston-riscv/Kconfig
+++ b/board/mips/boston-riscv/Kconfig
@@ -40,4 +40,8 @@ config PHY_REALTEK
     bool
     default y
=20
+config TFTP_FILE_NAME_MAX_LEN
+    int "Maximum length of TFTP file name"
+    default 256
+
 endif
diff --git a/drivers/net/pch_gbe.c b/drivers/net/pch_gbe.c
index adeca3d040d..0970a2dd8ba 100644
--- a/drivers/net/pch_gbe.c
+++ b/drivers/net/pch_gbe.c
@@ -14,6 +14,7 @@
 #include <pci.h>
 #include <miiphy.h>
 #include <linux/delay.h>
+#include <asm/gpio.h>
 #include "pch_gbe.h"
=20
 #if !defined(CONFIG_PHYLIB)
@@ -33,6 +34,13 @@ static void pch_gbe_mac_read(struct pch_gbe_regs *mac_re=
gs, u8 *addr)
 	macid_lo =3D readl(&mac_regs->mac_adr[0].low) & 0xffff;
 	debug("pch_gbe: macid_hi %#x macid_lo %#x\n", macid_hi, macid_lo);
=20
+	if (!macid_lo && !macid_hi) {
+		if (eth_env_get_enetaddr("ethaddr", addr))
+			return;
+
+		printf("No MAC found in either EG20T H/W or environment");
+	}
+
 	addr[0] =3D (u8)(macid_hi & 0xff);
 	addr[1] =3D (u8)((macid_hi >> 8) & 0xff);
 	addr[2] =3D (u8)((macid_hi >> 16) & 0xff);
@@ -74,6 +82,14 @@ static int pch_gbe_reset(struct udevice *dev)
 	priv->rx_idx =3D 0;
 	priv->tx_idx =3D 0;
=20
+	if (dm_gpio_is_valid(&priv->gpio_phy_reset)) {
+		/* Reset the PHY */
+		dm_gpio_set_value(&priv->gpio_phy_reset, 1);
+		udelay(15000);
+		dm_gpio_set_value(&priv->gpio_phy_reset, 0);
+		udelay(5000);
+	}
+
 	writel(PCH_GBE_ALL_RST, &mac_regs->reset);
=20
 	/*
@@ -450,6 +466,11 @@ static int pch_gbe_probe(struct udevice *dev)
 	plat->iobase =3D (ulong)iobase;
 	priv->mac_regs =3D (struct pch_gbe_regs *)iobase;
=20
+	err =3D gpio_request_by_name(dev, "phy-reset-gpios", 0,
+				   &priv->gpio_phy_reset, GPIOD_IS_OUT);
+	if (err && (err !=3D -ENOENT))
+		return err;
+
 	/* Read MAC address from SROM and initialize dev->enetaddr with it */
 	pch_gbe_mac_read(priv->mac_regs, plat->enetaddr);
=20
@@ -459,9 +480,17 @@ static int pch_gbe_probe(struct udevice *dev)
=20
 	err =3D pch_gbe_reset(dev);
 	if (err)
-		return err;
+		goto out_err;
+
+	err =3D pch_gbe_phy_init(dev);
+	if (err)
+		goto out_err;
=20
-	return pch_gbe_phy_init(dev);
+	return 0;
+out_err:
+	if (dm_gpio_is_valid(&priv->gpio_phy_reset))
+		dm_gpio_free(dev, &priv->gpio_phy_reset);
+	return err;
 }
=20
 static int pch_gbe_remove(struct udevice *dev)
@@ -472,6 +501,9 @@ static int pch_gbe_remove(struct udevice *dev)
 	mdio_unregister(priv->bus);
 	mdio_free(priv->bus);
=20
+	if (dm_gpio_is_valid(&priv->gpio_phy_reset))
+		dm_gpio_free(dev, &priv->gpio_phy_reset);
+
 	return 0;
 }
=20
diff --git a/drivers/net/pch_gbe.h b/drivers/net/pch_gbe.h
index 7e0fdbfd5a3..dcbb94094bc 100644
--- a/drivers/net/pch_gbe.h
+++ b/drivers/net/pch_gbe.h
@@ -292,6 +292,7 @@ struct pch_gbe_priv {
 	struct udevice *dev;
 	int rx_idx;
 	int tx_idx;
+	struct gpio_desc gpio_phy_reset;
 };
=20
 #endif /* _PCH_GBE_H_ */
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 5555f82f23e..c82e8b0a523 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -461,6 +461,8 @@ int eth_rx(void)
 			eth_get_ops(current)->free_pkt(current, packet, ret);
 		if (ret <=3D 0)
 			break;
+		if (net_state =3D=3D NETLOOP_FAIL)
+			break;
 	}
 	if (ret =3D=3D -EAGAIN)
 		ret =3D 0;
--=20
2.34.1
