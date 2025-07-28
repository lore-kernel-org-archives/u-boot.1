Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA4FC83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 08:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DCA083111;
	Mon, 28 Jul 2025 10:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pDBWNEs9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD991830C8; Mon, 28 Jul 2025 08:56:39 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C935582F00
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 08:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxfYxRfIqgUvWP1m4Ts7CMiTF1SW7Xk3P1JoSxhcLwTeKAr+I3aem+Ct0eMmqaY9rgwm5afQCiwT61v6zNxclJJPp005Q+qvAaduwUlkqqyflsWG5EL4BZMtLvo0c+yhhRgdDIy/4wDVy6m8RqoXfmMy/436hhNzboJQJj0aYToNRKYJQBOts0v0WNlxzKwiYPzW+aKdh4FRkVeaygj0tC0TFSAysFyZy/2Vsq22MAtboAKNcwP+Kp40eb5O4Zuwxu9W6VY3/uWKZKbY5OK2KjW4bsSzxtCXaKoZJN0Qi64APZE5PA/BimCuhuwDSp4V/g5+dWD9O2Pyp7rH0CsdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pycb0149pvnjEeA3lg7JREnRc/Vexp8Sx5jbURhzWsI=;
 b=FTAVllvcQYOCslUsCKV5GOhlL3ORhhVM97Xqg25JMzNavMDoiYkjDTrJaI0eE5cL2qTMf6kf11kaImYhoIUEi1vO63UKj+lUX4S5u96Rv3msrlHFCmVmEh6vaWSnNDUoi0FOR7QpHaTNJdTmhxVZx5tRNRJ2lkoHwB41IPOj/srNp0J6jLjJLawG1p0yEHdfYMYf+a+fUN9fDPV0E4shQU02gSNN8HKl9TDfeROx2q+LVQ+A26fW9f2qPdd2Sjk5RswoL6OuQ4lA/O4PtYTQ8d5rp1pXZ6DIs11Hz5HmVgENo97mUe1GeMlQbnsWPfwCXE7SkIsesEmivoM572jZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pycb0149pvnjEeA3lg7JREnRc/Vexp8Sx5jbURhzWsI=;
 b=pDBWNEs9k41w6nxwWhBpv3CljmBvG+FZ4PTITo9TvBtbGYQFGvg5Uigk96V6idTXn9mneDs0nwrBM3jQcHO4K64363Fk+2HRgZkq1evPut2YzclT3bGA//4rx4YxG1uj3ebMZ9tq+bN1Tvsfz1NqVE4PG5emu3/t9HrynjOjTqP6KhXFIMd7uqNwcauugqD6gjAyyHagE/d+44SDSymybGUIOCKN8MniWcIFQQ6veDsxSesraxLxaGpl/DQ74YPgX14S7cE+bIJQYbpbviVvGZ0sAOr3GSBpo4IHGYPHIK/x8dnl2J+hI7Hc3JfA9r3P5hFWICCj+O6GmIjI61H5UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6128.namprd03.prod.outlook.com (2603:10b6:5:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:56:35 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:56:35 +0000
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
Subject: [PATCH v7 01/12] drivers: i3c: Add new i3c uclass id
Date: Mon, 28 Jul 2025 14:56:01 +0800
Message-Id: <20250728065612.6039-2-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250728065612.6039-1-dinesh.maniyam@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM4PR03MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: f222799d-0b2d-490c-2961-08ddcda3e483
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mAUSW5esrTPOXs4HQ9SRKU/oQd4Q+03Bnc/+bh3v+QfrlS9gyBpaU0P+pdew?=
 =?us-ascii?Q?9rASOrnQkUs8Bgr9bBsrpXdGw3Nv5w0bDm3WBzBRrTchE/lYXVXoIC5jos5n?=
 =?us-ascii?Q?ru2Zt/u17UQMXwknfoAXy8ph+Roi3gCTTaUaByjuDZq4RRCSq7igAy5bvd9g?=
 =?us-ascii?Q?6Q7BMizAQshYjbYfCQ6D42mIXTrLtPWLpM6vIvKWg1A3kTcWrnM+lRI6Xcwe?=
 =?us-ascii?Q?PcBxdNrxEbP/nRekV3RsIZsLIytnDdyF4jun5FIN/yv6hGl6Cf7ucn3F/A6f?=
 =?us-ascii?Q?E4k1rbpbectvQH9abQpaiEepJNkyFhafBCnktADc+pmDu83SVmRKVtAEEWqL?=
 =?us-ascii?Q?vMz//7+zBRpARw/+OslXAYrXWLKooolKrkHxgpoLs3RCO41ZMBi2EBZfFLeS?=
 =?us-ascii?Q?CN5Ss3TzrJ4+6qKjW+qRkbBjqqHVPqM9MGquxwrNZnqlRFrlUZI5oMlUX1aS?=
 =?us-ascii?Q?UTPexY8l8wzFHK23VFWTF9JWAXOTCQsEqZ5QNEzHJesj0bz4kHN9mKHRgpI3?=
 =?us-ascii?Q?i5zvKkfVhccM0Tsmt5gOoogeUP+2d4+KHRhNo2eSp+TKfbJ6aICIJtszTAfI?=
 =?us-ascii?Q?O6noPAtoOGh9Oic7aDjs9P2s+y7hRYzKWS2ay5YdVfwTo1fj+iN1Llg4PIcX?=
 =?us-ascii?Q?tqt7kB1NB4WnbhKVVwnzU2/GaE/fq3n4GxwfEEvcZIJ5cR3FsnoYRPGbD3QN?=
 =?us-ascii?Q?PXucsKL5rjNMNCAB6rnQT8utoIbtGb5w52EW5meeoSO1P32J288BYEc0LVK1?=
 =?us-ascii?Q?Ckl/q8+aIYt/4s/jhtcplcpLvZeyL6MY625XWrvIUfDVTHEbTMzHIJh+R91E?=
 =?us-ascii?Q?JfPAosvwgvKyHZ/8kAHelzai19MFGHQVrksS5fXcYpn+coZF8vslKm0nVvjz?=
 =?us-ascii?Q?zitmMW3Lsu0f8VKau9hnKL5kJD+vN0YjXXP675ZuiPmjWcWjiV3EawIqZPBz?=
 =?us-ascii?Q?81FPbi0ige7uI7uyx7JTmqfNox9WbPA1OaKlcdCvO49ozbGc1KQvrrAPdJp9?=
 =?us-ascii?Q?Bais/LH9OUdISbuT4+XRbXJnhWOaaGbTy66UWvjDwXi+U1dXOLfZYXx5iTyr?=
 =?us-ascii?Q?Evu72teruPaJvRDeryLusAgO2eqK6EdB1jDytdvXMT4haEGu4lSQe0KLOzHF?=
 =?us-ascii?Q?O9uitvz5RWDza7tZqO5Rj1HB+kOlb7QDvTfraxKWJAG4iVLAQ/5IWySYtOyc?=
 =?us-ascii?Q?P42PVmK9cFdhe6kG1oFZbSZTPMycPbsDvKySrmGHCxJyOdITIL2EvWv9F2pl?=
 =?us-ascii?Q?mAVDKLlXNKCZ/Tz+53UNCMB+Cy10iIZptE/wGDHZzXbhweYrlD5Fa6Etk6Ob?=
 =?us-ascii?Q?6gVLpgef8KhOQmFO1Iy7izCiH6U7D2ilPVNRuhyXYPzzP+SnQHKjYejlllsr?=
 =?us-ascii?Q?oU92nNrTz4BHw43BUtTP66WfDLfzw8zi4sHeABtGxTTWP3mYZOnx8j84u8+t?=
 =?us-ascii?Q?Ch4DpEreppE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W5ARLUtDt+qfyJWhGeqNRu9xh0sg4wgHzp09XbBZ5ykDm+HgOWKUVCGj1sVb?=
 =?us-ascii?Q?ombtyLaNizgu5qlATZ/mZrk0X7T1/VcSeA71aR3RA1FojU7VoiKMQFO3WUhy?=
 =?us-ascii?Q?FtyxkWodv5oZPGwn8+X3GzPpgAKWwmddkABzvRJxW8f8f1SG9mJ5fKhBi7kI?=
 =?us-ascii?Q?SekqjznA+VhMZvNT+W/ro86iExEFwztOY7Bt52x3oxN2HnxJvLJuQ/qfojgE?=
 =?us-ascii?Q?cQaX5aej5h+jLykuk5x/orpEnEaWznaNLnxmam3vN2mrXwrZ2aKRYxpBszb2?=
 =?us-ascii?Q?erTQOAXYgzscou8fkOYEbkAutjle+0OJ5McjWzkQxw3DwV1WPuWgWWSZPeUv?=
 =?us-ascii?Q?oruIYWZHh8ZhHldllK7k009WBHKIpiJHBFHvbLjnc1By+9+qUpLdRp2wcbrx?=
 =?us-ascii?Q?YP6dODfClZMU9OewJZ9OVmI+pe6si1zt2DOKGN3Y027IBtYE/yre8ow4HPOW?=
 =?us-ascii?Q?dJN2fcjcSrAb+fCDdSQyOACnkCtao+q9IH8x4qsGiMdHbIL1QhWzU862wfuf?=
 =?us-ascii?Q?i/Dzne8gvm8KZDoWjq2FVBEBIfzTriVze92ZRtB4gLxXjbTFff7t+h81RiSi?=
 =?us-ascii?Q?mgiuNPC5DqD0fx34ElNrqp30CNFg2Kz4h3/LV9poIpcmCqWvGnve8vj5fNNc?=
 =?us-ascii?Q?VU9GBwB7GCqi0AglkZD/MwKoNcLz1kC7rMdoPeJLoDh+NgxPTx6aIGKMh9+J?=
 =?us-ascii?Q?97wVSPi6CQCDfb+UvfFTI5XwArb8OFaTW510FJ1qU6WUhRzYt/3eKOHqbX6r?=
 =?us-ascii?Q?+3wlXJFjH7d4BbDrDWtJasRA80V63IlQBQqeZvv3ASLhruMKb3JJa4qGxhqN?=
 =?us-ascii?Q?QPEk5S4YKhLxieaEgY967EDunogrEUBHh9ec30tUWdTsaH61+ZGWK+0jCVnn?=
 =?us-ascii?Q?K5NGlrS4zFGmHdyszj/zO6NkxoRWH3VsVg3z1KJDMp5wnkZ9B9IDFg4NM1o7?=
 =?us-ascii?Q?RIHHhz3esTW7J54zeX0wjoVhKdYYaPGEEkKahRVhd6JOMFwWd5gtbLn/UicN?=
 =?us-ascii?Q?DiB++NhD+hjl2c+W1Ya6iJsxJ0FPpjA+KnjdKfdKE9+TPyvoYiNxY3nOg3A+?=
 =?us-ascii?Q?lNgZoOkVKmr0Z0fDPpD4YyvLc/BohRh6EtU8st+cJYJutzJyIOGKKJbxB3c0?=
 =?us-ascii?Q?xStHDhfK/8S0ZOr9+5mGk9437Y91DmIZLLdUutsA5FT1jDyAjmkrHURLrZEW?=
 =?us-ascii?Q?0etNsFMXnlYSr8MFyXlSrK4CKJLZ9vvwlb8rBrzvMGCzrsweYO34Tk+VfRer?=
 =?us-ascii?Q?K0rYEU05z2k9MbDGMfpNZo+5Igi3BoeIQrXd4OF2tQsL1GviAW9AWml1xL88?=
 =?us-ascii?Q?7CDEtm4R6coseVpiFADZ4RSliMft4878Nsf9RbvZpP8YUwvwbV/slC/VBBjG?=
 =?us-ascii?Q?rW5k6ZqLQC0+wdzcBuML7iMSKma4DNTr9dwOjIrC/oP8B98Vm8T5Nj6EeKMq?=
 =?us-ascii?Q?iS+NG9wGccxFOOyu5vVdOBMufcuyAqEV0tUncJnwz+OR+IXtL4U1ah+frlVw?=
 =?us-ascii?Q?ozYQjPvFfKEtt9+ZH1OfWYcW/HaRiCqfsKOs0IJlsryUruCutGUkENtCmHHb?=
 =?us-ascii?Q?CYR1eU4nIZgti1Cfor/euV4Wypjc9gzR3A2FwU+gpjctqfvJcYK4gktyCGfX?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f222799d-0b2d-490c-2961-08ddcda3e483
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 06:56:35.6961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZKRnD3igGYSHxnNDPeUKwaavo+JB5UERH06pZb/HI/V45IAsUm7d8RcyNPH1fwU0pg9o0jeMwRXatZCZ6G3dNWNth+YLlSBAtrNOL2iC+Xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6128
X-Mailman-Approved-At: Mon, 28 Jul 2025 10:46:50 +0200
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

Add i3c general uclass id.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 include/dm/uclass-id.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 270088ad94f..1d259b439ff 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -78,6 +78,7 @@ enum uclass_id {
 	UCLASS_I2C_GENERIC,	/* Generic I2C device */
 	UCLASS_I2C_MUX,		/* I2C multiplexer */
 	UCLASS_I2S,		/* I2S bus */
+	UCLASS_I3C,		/* I3C bus */
 	UCLASS_IDE,		/* IDE device */
 	UCLASS_IOMMU,		/* IOMMU */
 	UCLASS_IRQ,		/* Interrupt controller */
-- 
2.35.3

