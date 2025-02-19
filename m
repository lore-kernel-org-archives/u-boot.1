Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472EDC021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CED980F96;
	Wed, 19 Feb 2025 14:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HliN6JWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF368809A4; Wed, 19 Feb 2025 08:23:58 +0100 (CET)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A321C800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsBfWF+cYhGDYYa/Uqs91SK1PcRfxWv8o+ZBhWbATKyegL6mL6MnffmKHCUt+pDPBTR9r6Otw0YDifbcT/Gutelqe1ofuHNAZxZLCfOWah7zOlLK/qFCIWB1Jf3/J0/SGHvt9tKPiGj4GJbsKhVFqEQXuXGE2tYD28qAOKnYSU3CaDnmNxiFyvdPEzte6/17i600Y7uCG6rBrZVmaUESQBf7zW9eQTXknxl1zVyAFIEeqwZJYDmeE9NfCQonv6ECGwhXTG4d1rAOeLmaWlIVK84r02Y0/KXs66EngIXo3gnm7X87bXRcDb/ECGiysv+RteteRB+3Sxf5rj3/LBv2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmPreFza8NGUYWvRCo1wTU9A1B02Z9YfZW91hI9ao6s=;
 b=xCld2Mi5tisQEMGEx+fcvo0Igi2QiADPZMPeCkODbF1m7vgJKyKRtCx/ueiWMf+uDBXQie3TY+Oh3UBlIsxcTWBcRQ4s93QAXpRLhvfDb2VP5ev41vGHxW+8qhR8gpabQm7JAUIVC6En5UoyWivDXzG3Kp9vIHTiOkjhc1lEpoDVWu/cBQN8/Hp/fKjbZWkV5vKQ4nh5fzFWe9EtAMItbObzNYM+RIt3MMWKnP0dST6mY2eoXubEIHBZ59/vetVT24hkppz1AHD2tISSSEd8b/+e7KuavN7dPH9Ef/SwOlzHpayWHOaOFRX9acmxnfqpjPNBUjwMDNNfYdN9fGPx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmPreFza8NGUYWvRCo1wTU9A1B02Z9YfZW91hI9ao6s=;
 b=HliN6JWSu5QqkrcjZLU3T6fA9HEdT6kWhJqmzNFSqEifk7PgMj3LVfJoGw19mkDBemPu/cqFUJx6LZjQ5QulzXzlRLy7PoGFNFIL0ppXNY+6kK9pV9hiSp3qqZ04BijS9CXzO9Uj+C5ZaEpOKhd8549304TYjF7rulpE4VGtgds18YxjrWS/2SzT1BmVC2BN9fdWrD3Ok8dxPVfzQBdyIQdLcxPDaQ8TYtkGq5ttcDio/Z/vfVAyD/IJWCgd0kFNPm0zTgSlSC71RHgmaWjKppBQDWEW5TAt5rJO7ZxbHno4ZNu32EZYscKKnEtpvO6sNt7JhpKDPavMIY2w3XB90w==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:23:54 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:23:54 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>, Tien Fong Chee
 <tien.fong.chee@intel.com>
Subject: RE: [PATCH v2 17/26] configs: agilex5: Add configuration for malloc
 pool
Thread-Topic: [PATCH v2 17/26] configs: agilex5: Add configuration for malloc
 pool
Thread-Index: AQHbgeAmUNm/vFpfckCisfvMH83AebNOOq9A
Date: Wed, 19 Feb 2025 07:23:54 +0000
Message-ID: <SN6PR03MB35830CB360ED8226AACFA372A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-18-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-18-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: 26a9661e-39f1-4b70-84cf-08dd50b65dc3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KzT5RDy7hfUfOCGDxsXGiFnKeKffOFKs6TBFgwhHSh7wMrhMB90/qHkABWG+?=
 =?us-ascii?Q?ynh1LjN6SPNK2yvghQLJPEghKjJluxIy0ADgFGjr/fUaofEh8eBskZWz9bho?=
 =?us-ascii?Q?ITBnD7MWW6J/eQUMC9VFPuCUh7HBAJvqgLuK5r/fOyZTjbu02s3oapwuy4RA?=
 =?us-ascii?Q?NTl2NFll2sotdlYTZz6Rr/ayohSmhLySRHrgw8vDl97GZGQmnczyZALdO/v4?=
 =?us-ascii?Q?hlGfgIUFE1doIr4xcJFtj6sxO+HmQY0+0e4vmwWa+GQTotj63PEReRCxsePe?=
 =?us-ascii?Q?kFyYJhvfUq/2vIP7ol4WiNpLRi5juiIgY+h0hddhRky4yfDmB0oidSciCim5?=
 =?us-ascii?Q?mIdWqvyz3nzyWa44BwfubqFr9FKb3XwzLgWKXXObOImJf83gHTMH5/5nf+XV?=
 =?us-ascii?Q?BZ0rAgrDj7uXMPBZFIjCXSiUBzbJIqBLsXsKUIdkeYlttUs/iqd8oNZrhDxu?=
 =?us-ascii?Q?1lDwnwEM6YHXlxlaAzRZI1xZo2qbLxeay6SFHTnRFdvu30/Tql3A0Syz+svE?=
 =?us-ascii?Q?MDe7o44PE9U83rOvq3KsPj2r3t30Dh9S7qj8O5zjBAsFYuhXxIYodcc7NObs?=
 =?us-ascii?Q?pxplmxd46HmepqitMn9LnTksg7Yb7kmYjPlwJrUp9Id+iohPA94VWhDMgcch?=
 =?us-ascii?Q?+YQgQxFS4BLEWNPOeVoWe16cSEZs5gUuvHg0+/NkhhUP9eRKZE08TjrVNNIN?=
 =?us-ascii?Q?vXtnlRoE+DDsm5yH3k5a0vBVq11FmYiSk3WWW+Gj6gaGu7uI/Iq23EtNmMwy?=
 =?us-ascii?Q?I8WNhtxVYlIky5ApBCQPlG8uRFoSivcMgX9XJ072mdUdx5ksD98kKiBQAyUh?=
 =?us-ascii?Q?+k3OdtOropY9VAuiJmEPFuB1Om79gsmMoNUZV6UX4J1m71nL5P1+obidvsSp?=
 =?us-ascii?Q?XU4sKpDM+CvtVQwPlKXbNIuqmUR5jj+rweuaHhWrmX0neVngs2G8EbO9NfB0?=
 =?us-ascii?Q?F6u4SSP/Uluxh/SjvZ7tDNTRQkCHtujMJs2123tbaAEzkUGKYRj8N2gPAeE/?=
 =?us-ascii?Q?aiLj9PLb2QWEAMDVtC2djbMXAQBrHKtouF12zK/N4rNgMUibkujIuADYNoLm?=
 =?us-ascii?Q?v9cfigGcXx9j5nRwlXa4P26iwh4IDxTkmYP3GER38m7KWThTuVzbuwv6zq8p?=
 =?us-ascii?Q?foy8tYfGvLXVva3funLZ5n8CzeAdqy4yLsUSa8StzIBiGg43ziLi+cFQq3tj?=
 =?us-ascii?Q?x0qkr/9UsNWQg+vu2LVgzAGwwBWXFyJ2aBgkl3kUrvR2dk02jmaxGWRy9CZ0?=
 =?us-ascii?Q?TdzQcMgv1+FlQ9T81fZObIh/C3mq/6HtjLTl0OwzEQ0TLznG14Cf03tBnJbN?=
 =?us-ascii?Q?5bpov60aSRyrDadSiHdaganVa6pKlbSzyWZwwnukJJ9KFpblfGmhq0bYrb0w?=
 =?us-ascii?Q?wr5zLOkVQ0B90eVY5HY1e13X9WzIt4EkBfqeO6G4XcnT0Bu62DQ7Jp7f8mWZ?=
 =?us-ascii?Q?8rp8mDEZM/cu4zV3clml2Ze3ikBkHegc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gvPaWVKTu6pxZM+2eH44FXGFh9mZHu0cWMCbzR1ZDy4o6TAfye9NEMVzT7iA?=
 =?us-ascii?Q?9wj1yjfP4LKbirVv7F3X0FEWlO2t9Oeu5OsT6HL/jFCtwjttn+bjEceeIdeG?=
 =?us-ascii?Q?jpnEK1iOruwl7fprFB5wtkNq2do7WHN0kSMJ7qoPgR0ejlLH8ptBaxPnLL8e?=
 =?us-ascii?Q?XzrTQUxcZSfIduJTC5wLXyRe87YjyN/He92qS7tdtFzneXqkHIF6j5lEJtOv?=
 =?us-ascii?Q?8I2+fmwnfixO0GOZvWDCmBFQI1f++9d88mWz1XE/lzAk+HalWCHXyh+QzmFf?=
 =?us-ascii?Q?F2e3j3MS8xXvi/XdgzWI/1eY4wjvvYP15lmeEA+Z6REsoQoRD4odBgTSOw5u?=
 =?us-ascii?Q?LZeWXMBF4yCu95Xd9bmfy/4Jo3KUTI+pUrHi4EQRYVev086EPzSwtAMUQ4eB?=
 =?us-ascii?Q?22QIpS5V6FshZZiiBv7FIi4QGXBbhOx06L2yhrGu0ZTDyy0FziC2m2S+VYhf?=
 =?us-ascii?Q?D0ig+WhjCox404V1WDQoDdj9KbEWj3VP5IYeTQq9iIL5YfAtOVQjxZlm3Mrg?=
 =?us-ascii?Q?SREeO39T8QmBHC3Ws5nKxUad1R5Nkge5ZXqWrWqetb7Fhj7C16hxvKVl7W0Q?=
 =?us-ascii?Q?4dFzhOtDqk0/tYnctKSHVIaDTUokacFBh+Inys3Vt5Sv6aqcpNpu0VEvzhtD?=
 =?us-ascii?Q?LNOzrwC6cDgcjFKfVThW5cd4zVaWH0Xb2ApfQMToPnJGavtyK5raWBKGXVcj?=
 =?us-ascii?Q?CY/AmhS6TXhDlIJ5G6Z/KsW3W03fMD5/48ttKsDXpem7agwf7QklL10mXh3d?=
 =?us-ascii?Q?JzgawdPgeFO0pBuBdH5vXhK2S7rvYhDs8zJD7JNYJJ2bK9y9Aoc92kmzzFHu?=
 =?us-ascii?Q?Kjy0b8mSyZYDMmY85txaPvW+0LebO8CdGQ4w33m1g6bivqgCDJ9pXyhgExTQ?=
 =?us-ascii?Q?Khhhme1I4O/lO0IUrMOwIuCbHKcrh/7s4SCwRgvFMxMjQcRqm6LCNZJqBKbc?=
 =?us-ascii?Q?8v2XfQJWpfRED5R2KNM/eJUZntUAkyjEjDL4Smel0NzAWkVZkXafXGNxojW2?=
 =?us-ascii?Q?zsIPHoKZ35g1H/PYNoXMzl/KqUpJOSeB8llwKDWTDiR5QtsuVNOAZtiD9Rp2?=
 =?us-ascii?Q?q/Vdmd9X+83H+8cubtshtlL7ODnnW08XW6ji6/6O3wN1/SvgqwjlVXqkWgLf?=
 =?us-ascii?Q?kUjXt75nHfcx/BsmxUtjhBvW1HQU3fvx8roPnbB5MFql66eHh7DmqLIpxPpA?=
 =?us-ascii?Q?utO7cPXBIRM30+aRIuxrwcsWenL58+MWTJufvkMT1p0zI7jqLcXLv0ISYkv/?=
 =?us-ascii?Q?i27kZ+rnQwaMPva5YvXU3p+JMUD2+8GOCN5W8d+AkFxaSxNkq1g2GuD0Q2g8?=
 =?us-ascii?Q?K3fB6hC/1ay6zwjqVreigUIskD8dmcaP2xFHmbHA03S7VWWm9ggjfh2bv8et?=
 =?us-ascii?Q?vLkM/KrCL0bcgEXA9S6s0wqq89NJ3SDQk9EvKfMKJ4thfAlti9G+gFgQEGT8?=
 =?us-ascii?Q?4kPLtxaJGnV3CM3hNiNwavvXzm4T2tp9ShbjCw06woAjiXI7y1BUFPxh1Gs9?=
 =?us-ascii?Q?WmkkRBAoDDVF/UMHs8t4/c9Pz//jXJJiCs0Z/FVkvJWaSbhQ7kc5eYtcF8g6?=
 =?us-ascii?Q?8QUH5LaCHa6IUDYUWGpKJfi5BfWX5jVsEfQd1Je+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a9661e-39f1-4b70-84cf-08dd50b65dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:23:54.3279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6kVkojGKKcJNeVxQompLWU09795+ZSziiXasMHlonlvRaTjB9skQgAwvCKFiseo5926QCJLhcLsjg45R8kbghjuXAq4pzrdBTVqxF0nnFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6679
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
a@altera.com>; Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 17/26] configs: agilex5: Add configuration for malloc po=
ol

From: Tien Fong Chee <tien.fong.chee@intel.com>

Adding configuration for SPL malloc pool.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 configs/socfpga_agilex5_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_de=
fconfig
index 60e625ea805..2a2c76113cd 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -30,6 +30,10 @@ CONFIG_BOOTDELAY=3D5
 CONFIG_USE_BOOTARGS=3Dy
 CONFIG_BOOTARGS=3D"console=3DttyS0,115200 initrd=3D0x90000000 root=3D/dev/=
ram0 rw init=3D/sbin/init ramdisk_size=3D10000000 earlycon panic=3D-1 nosmp=
 kvm-arm.mode=3Dnvhe"
 CONFIG_SPL_MAX_SIZE=3D0x40000
+CONFIG_SPL_SYS_MALLOC=3Dy
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0xbfa00000
+CONFIG_SPL_SYS_MALLOC_SIZE=3D0x500000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set  # CONFIG_SPL_SHARES_INIT_SP_ADD=
R is not set  CONFIG_SPL_CACHE=3Dy
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
