Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20050C83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D65B983238;
	Wed, 16 Jul 2025 09:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="fy4R8/q8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A2C98319C; Wed, 16 Jul 2025 09:09:11 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C037B82E37
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:09:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o19ZEWt9Zej++M/NCZucm/hN+JaFj/hJ0czAq449eouY24DX7VtRqjty/1LovYoad+fiFqEooCTUbfsuhM53l/UYe2as0r71zkAN+nk9IF29Tf4KclSJlLwwxfMnKhGCsOTYt1OteqAkNYETYuuAs6c8U4KZMcviuf1IMyS3B3AtHOsk87ex/hrlTPBJCA0iJNVTM0DIQwnVIu4XwN0vcWToI+5lyIchT/fJgN7XSHNb4OPUTnRdKJjJ9FMNVdCaNVbhpn22RXf8KK8DzGymYt4bNHVwpzI1eNUTZniBitvV2z0Ul0hqs8+5a5S0eo4pK3q3aScoU2Z4puQLKxlOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilg6TIemBzl+9AehP2WHb+ln1UJdsUovmaUCMuBW38M=;
 b=K66F/L2ITpNFWqDTsMvt4hflRel76v6c/jBpynrwIe6Z9Cg8JCVQ9npngKHXQTA6oOX7dzY/aSeo9wn6MBUCoqq7LD1lTS4xhEjRrXXRdvIL4Wg1hma6b9K9ZTObDNepT0vjNFQE0snYf3Un58LLLE+4U+Yl6YGFh/sYb4MoXUKsDcX/KNkCaoQNezdecoyFjgO71dViDzPMUohQdKDrNZBOweYRv2TBgJ5wrdKOuH769Ls0zEpWTDE0ECVrPNW1mfEVu16RhoSE6NfuTbXBLkYe2RJ6WhQo/BrpaXQRfpG+/hsAzqxBX9ZypJgqk9tkoAlE39y5ig3XwvcSg58j8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilg6TIemBzl+9AehP2WHb+ln1UJdsUovmaUCMuBW38M=;
 b=fy4R8/q8LvkdYtNGgaZkbelq2Tu5TFgvLWkA1HoM7y/P8ldib9F3qENIXs8yPTLdcBmAmNMc0YEC+K48zfHSh46iXvcIr920ezjNHh0MCiiBkR5SImk8+aTIqjnUqsOG8LVP302qW+I70rXZSRO4Q0l/mbvvw5pEIa3n7c6QSepimsns0GiiY5s2bpgh99ci7ebwCIDKQ3jUzCbEy2hYR8iQbvjd2jR8jIPnbvkZHaeUxSGnGtaRCXRYZTlD1GvhYTrgZsYk1TA9pZq/LS3xacKAyUyUWTMo+8LIwmw08sqZY0eAk313o3lpWu5fWNQfaBSC4OK0StPGgmAwyRcgEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH7PR03MB7170.namprd03.prod.outlook.com (2603:10b6:510:241::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:09:04 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:09:04 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v6 06/12] drivers: i3c: Add i3c sandbox simple test.
Date: Wed, 16 Jul 2025 15:08:04 +0800
Message-Id: <20250716070810.8030-7-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250716070810.8030-1-dinesh.maniyam@altera.com>
References: <20250716070810.8030-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH7PR03MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: 81aa5847-7a3e-4118-7122-08ddc437a5e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dhf/W56apWsKst+QSafcPlDCtWR/1mBcRk193huzJhJ5H7lno1FwcuNXF+2Z?=
 =?us-ascii?Q?gsHojU/eCkah2R3/L4XNlZzM7mgruUx7dHSk27m1DIZwl+5c+30kwNRjM+Kj?=
 =?us-ascii?Q?G7qpa498A8icIBa2fK7NKfMXhuXwhHfBDz54mHuF01kGMT0QJvWNTxUzaw/q?=
 =?us-ascii?Q?AHyZ5Q2AW/B7pR8pvgbi3+p+5FeITBpu32d/1ptJlsnQVae45uT2k7KlNGY8?=
 =?us-ascii?Q?+YKcy3jyFbIRuv5swvRoHPmGVsdQA/QqR8MXIW5gzmKrOT516+3nCq3lBy1U?=
 =?us-ascii?Q?cxHiphQQFCxuoqRzSUyk/0vv/L2E4cS0dbubAtdGX2q7kU6Hox64Qn39lwbh?=
 =?us-ascii?Q?coGNA3EotZM9vwSVANRtYBBIg6F2vn2calO1aPCftrjuhb5O0jwOzwlL2Nch?=
 =?us-ascii?Q?8wTCTfcMEhPkKTDsSKI/+yZYS106lWW7raO8K4TvXNHVmqIJX7tUsb5KuRCe?=
 =?us-ascii?Q?EG7HEg5qlI0/vzXbjgkt48hx20+sT6OOmp89FAwhMQDzNw3xirly7H+SR8EX?=
 =?us-ascii?Q?+47791avto+OOFDZMI6/CH9X6XCx1HuJbioVzmYDiF1Qis6fwZgJY/copRdL?=
 =?us-ascii?Q?keQvQWfiNfJlWt2u7Xrek7leLDeFkY0oBsmRhlyuHzTslYFaYmrSDvKnIh6z?=
 =?us-ascii?Q?ZxTopO0ctabRNHFbEKg3pptOROz7I2bedTVBwHUaE+vU1FRMFIp5bAnmPpGC?=
 =?us-ascii?Q?uFBYfGqwC0BiKRaJwLEDlTnLEu7YX0O8sePc17oA6JoHPo+RbxJ0PuFnCCjl?=
 =?us-ascii?Q?M12QxRirU+H3nJ6EBJKfHuLfRNtDEWFbQdoX3Z0PK3fjTLLYd3iiugkbpQpp?=
 =?us-ascii?Q?YhojmFJbaoTqWEJ2d9rrNzlkrOuZij0QYndRij1ognmQYUG1J3QYQvKj7qHv?=
 =?us-ascii?Q?oLp8eONJa0nY+eQB48kZQsvGQsrFv2CnfYWon8e2dDfR87Oc0drL8JVBrOPR?=
 =?us-ascii?Q?aZx3JpEubyiE6MoD/Vx65k5dyYv0O0unUtyFpmgMQBUMaR+KAEYKSYLC4W8L?=
 =?us-ascii?Q?2jy03vTV0Z8G+w6OzQkeKwVS4iu4wWDo8nU+7yNVA6SgifXpvllko66lmlHb?=
 =?us-ascii?Q?Bn8NKkAJa4zqh+srYuQQ5m+cRD2/QZJG+oASC/DlyGqaFtyjYl8UYQlLd/QR?=
 =?us-ascii?Q?49lqhLB49RDfbFtyTN3EupxGqosS+Ohvkg/qzdixAD8bcc78jIkmzu7oW+EX?=
 =?us-ascii?Q?oxFJIMyCW0ksx37H/qxBw6aYpgrlHeASEcKaFrXGIpwDEi9uthVBsHRM3aLd?=
 =?us-ascii?Q?r2cOBpXZHFOrSrkH7n8GHNrmMFWL9gNKEb8uXxEjwHfb3C8nAI+lkBNwMyY6?=
 =?us-ascii?Q?qay8wHcIBqnoPEa9SQA2J347caZmewtZGnuLqdy/FQVBXszmeB4hQ8MvpAEo?=
 =?us-ascii?Q?GK1mXHU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Px14lTd5t8PWal5ypDC/yctGbCtp21I322JmJrzol2m+cihVLNJg4R3Wej/6?=
 =?us-ascii?Q?CqBp9f0RavFxGBNgylRL1lE9kCXi+m7zFzUBkaXlNyt0nORiKCAnYvQPachV?=
 =?us-ascii?Q?G0AtREsXjnBhyhnQobEdVdh2l/AO+HItgksER+yHeLaPpavixnkGEMhDNahS?=
 =?us-ascii?Q?dz5GwV0iIoYaEc6ihRdsTgJw4voRoE+1EXx1SIbeWwMu5rHfwAdfELlElfWr?=
 =?us-ascii?Q?2bJGv7jcYXxwDKNpYg0Zma4Gy+e+JO1HUsnrBo7NF8Iqa+fuUU6TVMpW/kD3?=
 =?us-ascii?Q?m37aBo2NVvG4c9O9W1D6PtrrXhKx8UzesMQyEgpFRB+dUGKR7nLiDjkyt2DL?=
 =?us-ascii?Q?YG6eFo8aM5KFU08haDrKOL2dukFMKoqfvo2FNTkVZLBa0NMo+YaZHtB5oNUJ?=
 =?us-ascii?Q?WRelR+gSKF2EioHGkeNJOFdjP3qZMObRkBmZvb4XkQpwLDxYX4q9psbh4dV7?=
 =?us-ascii?Q?xs5HLOxM/5mCpCYP34oq7LvRteBEdt8fcHr3No38/tsjC8HIwUcY1GkhhBPc?=
 =?us-ascii?Q?Y3PYALfPxOtE+CS8l3yMmYL0b5HhBTElTLeE+idIKf02AW7Ys1oHb1ogAn0J?=
 =?us-ascii?Q?7b2ryUtskIX8G6ku43SPOcAzMMlF/QjXlYtzryAkeGDlqYkh/NFNNlsSBnPW?=
 =?us-ascii?Q?cuEK8MeydVFIi7AiZ3uk8ptlUsBAJVCVVPa42OTV08tVfcTWuaISVwFf4hte?=
 =?us-ascii?Q?XaZPyoH5TdfAGZo2XGvb8kU1lqRcUzimW6vIFFh6NqZLAkfBxDcvnvr9TJsn?=
 =?us-ascii?Q?64/GzQgc+kQJV+3sS2fWt/bfHaGnolCELosBF6/UsMuCAKjwyCLCDrZOLWfL?=
 =?us-ascii?Q?N0MavI5YbJZBdhdCzHDDSBT/MWaCEgbDOBDP7X+3TKc4D88AjjYWWHw7Ty31?=
 =?us-ascii?Q?cPWISY3xv8+vOkfUZ9zOPFN75ngAwJFUpVqin9O7+VXAt6Agv2wWXdUKZo5u?=
 =?us-ascii?Q?1+qVIXpIYZxvSwqXXwF8DDDgo+0WP1aP1vzHmQzpACzisAvj/itFt298EMjY?=
 =?us-ascii?Q?nqJlp3UFp7KxYqFHPBw3/HqfwvTmneIi0RkBIjfrirdrlF57JeCKZOR8H8K3?=
 =?us-ascii?Q?3I0OBC8A6QVUIS0JcRthfe6qUKWAA/MTjbpuHaKKkAaKK+irIMHoLN27KabR?=
 =?us-ascii?Q?jNApgXvd6ZghfhsarBhxxT3haE1/j7gpH14Qr8/H/tn835s5cBKdfVTMVVO6?=
 =?us-ascii?Q?Ac0VNmihhPCM3oi7Ywwdd/ZPlCquFkQ60PONwj6uvjBA67uPhqTkeIqppx4S?=
 =?us-ascii?Q?rQB0zdqaLYVKF7S92ByhCUUcVYsMHjpReEj+fBpoKmAdjvoFPzbsf4V3fhXl?=
 =?us-ascii?Q?pcB+5L7gQS9lBJVsVG2EOqnNR89X2qLK7zS1sB9t+6CafGlMBKfs+BGYu+jo?=
 =?us-ascii?Q?ZtWrUMaF82pntPnlwZSEU2CN4ussEufp85UJTmgWzh1y/PsZVX/JJuYyOzgB?=
 =?us-ascii?Q?AVK/gJssYljxjvTdM11UWPIfTRoDsowR5YcnoBvjyA7UI6pgI324krCGN+dD?=
 =?us-ascii?Q?CwWq3MQsV3plbWEuqYSbQ0pfZ1co7CD7X3KgWSJ3XCfyCvKBNongsPUG04ww?=
 =?us-ascii?Q?PVBFp8+Y3kR52ZK6FX6GdrBVlebiWFAtUkPqag4h6ocAeg9/1j4Q/DBDQ+P1?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81aa5847-7a3e-4118-7122-08ddc437a5e9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:09:04.5472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVbHoVU6QVSupAjpqrGvAwrTfTBcyoWpYd6vDZow7zTXrA/VmyRINzWDQLWTXe4W4yaXzCMyEQCHJ7ki6FA/1hcmB2Ro2j6R/KIBA5+5pt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7170
X-Mailman-Approved-At: Wed, 16 Jul 2025 09:18:59 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add s simple test for the I3C uclass in sandbox.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/sandbox/dts/test.dts |  8 ++++++
 drivers/i3c/Kconfig       |  6 +++++
 drivers/i3c/Makefile      |  1 +
 drivers/i3c/sandbox_i3c.c | 56 +++++++++++++++++++++++++++++++++++++++
 test/dm/Makefile          |  1 +
 test/dm/i3c.c             | 34 ++++++++++++++++++++++++
 6 files changed, 106 insertions(+)
 create mode 100644 drivers/i3c/sandbox_i3c.c
 create mode 100644 test/dm/i3c.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b8f3012873e..491c7dd56b1 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -935,6 +935,14 @@
 		};
 	};
 
+	i3c0 {
+		compatible = "sandbox,i3c";
+	};
+
+	i3c1 {
+		compatible = "sandbox,i3c";
+	};
+
 	bootcount@0 {
 		compatible = "u-boot,bootcount-rtc";
 		rtc = <&rtc_1>;
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index d4451057de0..d877a744353 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -14,6 +14,12 @@ menuconfig I3C
 	  If you want I3C support, you should say Y here and also to the
 	  specific driver for your bus adapter(s) below.
 
+config I3C_SANDBOX
+	bool "Enable support for the sandbox I3C"
+	help
+	  This is a sandbox I3C used for testing. It provides 2 interfaces and
+	  records the settings passed into it.
+
 if I3C
 
 source "drivers/i3c/master/Kconfig"
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
index 5ddc4743c86..d38d2350c9a 100644
--- a/drivers/i3c/Makefile
+++ b/drivers/i3c/Makefile
@@ -2,3 +2,4 @@
 
 obj-y				:= i3c-uclass.o device.o master.o
 obj-y				+= master/
+obj-$(CONFIG_I3C_SANDBOX) 	+= sandbox_i3c.o
diff --git a/drivers/i3c/sandbox_i3c.c b/drivers/i3c/sandbox_i3c.c
new file mode 100644
index 00000000000..e452e982566
--- /dev/null
+++ b/drivers/i3c/sandbox_i3c.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <i3c.h>
+#include <linux/i3c/master.h>
+
+struct sandbox_i3c_priv {
+	struct i3c_priv_xfer i3c_xfers;
+};
+
+static int sandbox_i3c_priv_read(struct udevice *dev, u32 dev_number,
+				 u8 *buf, u32 buf_size)
+{
+	struct sandbox_i3c_priv *priv = dev_get_priv(dev);
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers = priv->i3c_xfers;
+	i3c_xfers.data.in = buf;
+	i3c_xfers.len = buf_size;
+
+	return 0;
+}
+
+static int sandbox_i3c_priv_write(struct udevice *dev, u32 dev_number,
+				  u8 *buf, u32 buf_size)
+{
+	struct sandbox_i3c_priv *priv = dev_get_priv(dev);
+	struct i3c_priv_xfer i3c_xfers;
+
+	i3c_xfers = priv->i3c_xfers;
+	i3c_xfers.data.out = buf;
+	i3c_xfers.len = buf_size;
+
+	return 0;
+}
+
+static const struct dm_i3c_ops sandbox_i3c_ops = {
+	.read = sandbox_i3c_priv_read,
+	.write = sandbox_i3c_priv_write,
+};
+
+static const struct udevice_id sandbox_i3c_ids[] = {
+	{ .compatible = "sandbox,i3c" },
+	{ }
+};
+
+U_BOOT_DRIVER(i3c_sandbox) = {
+	.name = "i3c_sandbox",
+	.id = UCLASS_I3C,
+	.of_match = sandbox_i3c_ids,
+	.ops    = &sandbox_i3c_ops,
+};
diff --git a/test/dm/Makefile b/test/dm/Makefile
index e44f3d89e77..c6c12713d7f 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_FWU_MDATA_GPT_BLK) += fwu_mdata.o
 obj-$(CONFIG_SANDBOX) += host.o
 obj-$(CONFIG_DM_HWSPINLOCK) += hwspinlock.o
 obj-$(CONFIG_DM_I2C) += i2c.o
+obj-$(CONFIG_I3C) += i3c.o
 obj-$(CONFIG_SOUND) += i2s.o
 obj-$(CONFIG_CLK_K210_SET_RATE) += k210_pll.o
 obj-$(CONFIG_IOMMU) += iommu.o
diff --git a/test/dm/i3c.c b/test/dm/i3c.c
new file mode 100644
index 00000000000..81336e67555
--- /dev/null
+++ b/test/dm/i3c.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <i3c.h>
+#include <dm/test.h>
+#include <test/ut.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* Basic test of the i3c uclass */
+static int dm_test_i3c_base(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+
+	ut_assertok(uclass_get_device(UCLASS_I3C, 0, &dev));
+	ut_assertok(dm_i3c_read(dev, 0, NULL, 1));
+	ut_assertok(dm_i3c_read(dev, 0, NULL, 4));
+	ut_assertok(dm_i3c_write(dev, 0, "AABB", 2));
+	ut_assertok(dm_i3c_write(dev, 0, "AABBCCDD", 4));
+
+	ut_assertok(uclass_get_device(UCLASS_I3C, 1, &dev));
+	ut_assertok(dm_i3c_read(dev, 1, NULL, 1));
+	ut_assertok(dm_i3c_read(dev, 1, NULL, 4));
+	ut_assertok(dm_i3c_write(dev, 1, "AABB", 2));
+	ut_assertok(dm_i3c_write(dev, 1, "AABBCCDD", 4));
+
+	ut_asserteq(-ENODEV, uclass_get_device(UCLASS_I3C, 2, &dev));
+
+	return 0;
+}
+DM_TEST(dm_test_i3c_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.35.3

