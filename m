Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE20C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0887A82E34;
	Tue, 24 Jun 2025 15:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="GSwbA4J4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 623B382D17; Tue, 24 Jun 2025 12:26:19 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7959782C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPvrySqkhstLIKFUnwTvOH8kny2tYRZwOSWa/W8KSRYS3Gq3wiz7oaHcN+ugmprCG75hHa30Hmgil2q9CGBUl3d4fALHtfoj8qwqzRHWoqYSW4cG7U2B4YEbR9uBcHS7N95anQO8wbJ9GLET7lmiz3gsCJTghrLV6mVZycGkm30MPi5sxq2alacWjOaDepcn1XSKkG9LBBNv+L4RCg0+rL+qdy5cG5N6IwMP/NAnA/70/D5s2pri4Y+0anG8SHuoQ46i0Qxt9QsOufiT464o5N3cxRYC4ykFxGQ/nhwvJO/H/RL+fru+mUXuYSE+U33+KXS4PUEW2g/C3X+NgATqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJkuNUK7c62Zz4f0E16cS5K6MLL+EQNLk5a85VTvfPs=;
 b=IXCncewHr+WPG+3VJJR9RtC1DEjcCdAnJxHMpvfIFoUohW+GQOFNowEyZAdAlsHxyFjmX2TsH1gE1FFmKLdF1SXRIdvcJfCMDoOUHm2ytPeuYMoikWOtCJJTiR+N/5q9yJZcrj2VS/k6bpOS2U8Pu3rn4UjAhIQAgkJoMio9tRDjGnqIQX7Q7p6+gx0COrbiG+P2AnjVu4HQeo2voeB066VbbLd5dA/clhIRHuORDCcyAIPi0qpW4it3Yej7/+X6i3iX9/nlSxsgYaINtcAmT1F78AH83ufHkW8dKl65X1UdYs1zVffhRcF66kqCwTd/8hRz6k5GLs2OPucq6qqauQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJkuNUK7c62Zz4f0E16cS5K6MLL+EQNLk5a85VTvfPs=;
 b=GSwbA4J4sRtqXBoz+sb0H3HhR2Wdfu91DFn48Z7xINGdqR8o6XKnac81UzniLw6mg/qBUbGQwjvdLoDnUHMCCMWdi2oEuHdY/lT27J7HCbU6UQHFOUu5rhRrbGqEjgDKt3xAZ/l3YoCzYC8bc0E7o2e8dcJewT6P5QjyADJ6J/fvA9eJxTJKpIGMdZf+HzgHV2r25JaB5dtee7NGjoSCxjjK/g7fngm2LdlCtt/c/4iXaHvJO68tN4Nne7qrCp7Sak758INCeAaDwj2omiYN3J2IxkyejLDJhmt4T2oQyn9v53uySR48qOjXCtwWU4ko/sM+A0NLuwO9AYIcx7Wsdw==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by PR3PR09MB5475.eurprd09.prod.outlook.com (2603:10a6:102:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 10:26:13 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 10:26:12 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v2 03/11] pci: xilinx: Avoid writing memory base/limit for
 root bridge
Thread-Topic: [PATCH v2 03/11] pci: xilinx: Avoid writing memory base/limit
 for root bridge
Thread-Index: AQHb5PJoCYHgsxi2ukSrXMXU3a3o3w==
Date: Tue, 24 Jun 2025 10:26:12 +0000
Message-ID: <20250624102449.324410-4-uros.stajic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 955100f2-27eb-461b-cfdf-08ddb3098b40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?eC3ZsQ7olU8oE2MqpP2Bh4CTO9b3OPcjJ+yVDXRjuw8AtRggBtd9IK9HWx?=
 =?iso-8859-1?Q?zSTO57txMSQ9gWIcp7Lx//AMVgFWZWPenEgayYPHr4JZMxpZ3iK62d4VXJ?=
 =?iso-8859-1?Q?u9GWr/YVumamW9o4LYDSYM1JZe8e3JEuALm5wT3JJRl4DLN+TkbZub64a+?=
 =?iso-8859-1?Q?R6YBawRkCDNvorfnTc33MNoRqFhkOyX9sF9Nh7ZSbibj4RxOSY2nSfpiXR?=
 =?iso-8859-1?Q?1CRIiIkJa41f/x4hUz9F53QH6TRNceFAgaXmvAO0OW2qAhBNS1H/4erZay?=
 =?iso-8859-1?Q?hGCci/dtse3M2ocMljWi4BCi5IqyZKBkxV7vzmbK/oi7Xx0JiZoS4udMV+?=
 =?iso-8859-1?Q?b7fXAq+IDFlh0lFpDHvvlcQjuteOq8mH1Of0X5CS9FrkFU7wpM0uOYFHW4?=
 =?iso-8859-1?Q?07QvB2mvVNelMFMSNeHgU8pT1lgB3B2aGYh/BHZKpF5vDDuifxG4+JxPiX?=
 =?iso-8859-1?Q?WPbuEZcJP5gPq64XsGJOf/qJyMBM/QJ8sZUe1NKuWN7bHu3TdcKT5Nj0P5?=
 =?iso-8859-1?Q?qdLDd7bqTdowKPyujzq7OZsXXYY0xGBnn0sTWBBOaMt9lkQPYshG9xK1UU?=
 =?iso-8859-1?Q?G4I6FrL661M1tc9KmLA4S2RBIQnkz+Uj6sig8f6xq8bx86YfMK2IlgqzRK?=
 =?iso-8859-1?Q?+esZ3xwyIIzURVTB3Oymgwl3NW5YGoVEft0oCOIn+pMLoa1yqAD/WPAkzT?=
 =?iso-8859-1?Q?slrGgq2aN9aZA6QM9cpbl8I9/yAraNQzFCcgGkwB2rtG1O6EElApyYtAOj?=
 =?iso-8859-1?Q?Vwd4F13doBv2dw9+JSQOKl/FK2bx+W5L9hWoDYEAKJ1RyGD6wwbVo+GAzV?=
 =?iso-8859-1?Q?D1DQQC9ZNyIz3JWOF/LwmIL223DbUn85dPakDlr0gf07suFfgNyiA3SPQn?=
 =?iso-8859-1?Q?4CzLuP4/uae4l/S+1b4tWDKSlXyfG8vh5powFZR8KztAP/AAslyD9LMlAE?=
 =?iso-8859-1?Q?Q6SmFLa8mc5qs3i204cSv8ROeAE3lvwZyRrSKWeoYJ+5JgNRladQ9rIH7a?=
 =?iso-8859-1?Q?2Yc2tCs8geV2v8GGroy442qSah9pUXorcJmqfdVDoNe/8DhKBGBwIA5dFc?=
 =?iso-8859-1?Q?Xp2Sd168a3njrjgLoi5gaV6XfP2NH/1f4RRtRYcOdaj9b/Jd29b8rb2js0?=
 =?iso-8859-1?Q?MR6/vP/aheJsy9HHzV/4PWs1CYXQJThL51M7LZUaJN+ibDFsSXfhVOslp0?=
 =?iso-8859-1?Q?/0PNqfLRrSqUIW6ehfvh3sBWQVMauSI0rT6ceVr9+HVBW/+y7q4q7eR/Iv?=
 =?iso-8859-1?Q?7nvDFncZz0eUEZh6Ran/EirZPzwqBG8qtn24zSng4QXqGZboX87HeXXryW?=
 =?iso-8859-1?Q?SIk6zAEJSTkdWwFfzsTB/SW23bpgsU0vfQSISqP2J3UIMWhvcxE3jddiFt?=
 =?iso-8859-1?Q?KrBeSrfz80sb0Xp6CqqiHNxadrC7cQz/uDK0t3vtHWfYy9vkognnnAGtoz?=
 =?iso-8859-1?Q?1H8Y/s6dSx3kf8QTPyg8m2d+GJOPNPOsXk63b3rw1XUAx7JQLdz/DK/7PP?=
 =?iso-8859-1?Q?WL+lcTnVNJWqYYBVTLnZukE95rRUXz/cZBoQAG8NYJ4uJYAO36DMprsltQ?=
 =?iso-8859-1?Q?N2oBkbo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5qH1N/epu//raZd0SBWZkILnKedP09NKXD7faK0GIiPXt7TM8lwDvYGFOK?=
 =?iso-8859-1?Q?l3lfc1VkRTj1MwOZ7gJVhme3/jjPL06eNa6GHnWt1v5riQOz8ILR4fUp+6?=
 =?iso-8859-1?Q?bPTvEJo3K3FlQPtjGJf2Yy36/e1DQnrHh/tblbiSude2+9OXBNTfQLX6Je?=
 =?iso-8859-1?Q?Xf+tbk5oohGK6vxdNecAXmWV5D4I92eH/N1nanpf4hCz6IJr1xAi0IsExG?=
 =?iso-8859-1?Q?oeKjym+Yx/iqftQxls8GWnomq4Xztl5m4NqJGmL73E1gBFFsiyeyPvI3rv?=
 =?iso-8859-1?Q?IQG/s4H20VRzSKKp4RXqld9+Tyku0dyDRutN53TWv3Mec3XOFVwQ3qHfUU?=
 =?iso-8859-1?Q?NRrfmZAKV0S9dKj7yVvW+/Xrfbt9Vg6rInmyvDtJovE+AFI9aEBLkYKKx+?=
 =?iso-8859-1?Q?1iT6UqdT7H2fNNLRd6eqXnd6HvLjbUX8gk826mHzYGyXsTY0onXPFlqr/y?=
 =?iso-8859-1?Q?/F9mto9l2wLsda0xiHaTK8Xq4LsILL1IPhgsmqjoHGUucW+Y3c6htqI3IO?=
 =?iso-8859-1?Q?KKF4e6DRh4dCr+m8OmlKroEYCo5ype2BnkJ7lTdnRWCFy4awz/JQa3w+t/?=
 =?iso-8859-1?Q?w1SldN7Xy1o5/pXwx+PgUZjMGAxtXDLB3haV8GUsAjWHd9tF2eOyshKeII?=
 =?iso-8859-1?Q?kgmORokNvWceraQPU6rfrzSzCc0LnNUmiuZbUDoutoHrXVS5kwjsK+7H8k?=
 =?iso-8859-1?Q?s18RBSv8e7IaYQ7tUkCFaYaVfoitG47RUnL8zDobSJLMYuTo+KcLyijfEl?=
 =?iso-8859-1?Q?PUiUmJCymMwgF8o0c9c2+9cqrJF0ZcUlINP+9UCIB61ePmv/jd2cH4DGTR?=
 =?iso-8859-1?Q?eOjms6wbJ9k87z5VJT+aNqOmQPm1aIGa6VAnFxbs9XGoTUM4upPI6PZQpM?=
 =?iso-8859-1?Q?y3bfoakOL3u2E4TQ/RFtejMKwgAgYekx0WIiecCuXLw3eoJi0F1RnMKfK2?=
 =?iso-8859-1?Q?omOSWnwzZiT5kRHypl/aAykjP7HLcQr2Lv0sM8Iz1fiRUG4WWKmEuXlI8c?=
 =?iso-8859-1?Q?3NLLBHWWnX012n9cpcH5Bg0IN1UZMTuBHhw41d+VdYP0KuFgV1MgZTx/Gs?=
 =?iso-8859-1?Q?NF3QatKHZV4nc9l4p5RMbRvy+O6DlksFUh4BVaOe6paamSPSxVtjBb/e5A?=
 =?iso-8859-1?Q?E3aNQMM4zSM7BSspVEKKEaApbBnY9hooBXBIqPEqrfvJEMDet53sHRJm68?=
 =?iso-8859-1?Q?GhJwKnE06p9+gizM1HCNIJ8nL97yNXTy3NpToq0O3WTF6oQZprCk7/+Nga?=
 =?iso-8859-1?Q?NJA/yqkcE1yGIQYfE1G+CMhjayPT22wL/0T/Gtk7ggthFu9j/KRyPp0aPY?=
 =?iso-8859-1?Q?sngOF7xP2vn8L4sNg2jNXmx3Qw0DXzFluAbA7f3mqkOsI3cauS5YlyyOME?=
 =?iso-8859-1?Q?jRO/ES0UIoGxqUZiprkwj3gfV3Ux69SYOoQ2r/hflmzX6/tnUz8OOd7zRA?=
 =?iso-8859-1?Q?6JgXxuzWhT1Elrhe+0wkQiGMY/OoJ+S1lFZgHg2UUASCKly5iSpu3sLVW5?=
 =?iso-8859-1?Q?Nuxmy9p16JEdQbBIGlnFa9i26WKTXabSC2nXKuVo3fn0JqoGRWi5ifvZyv?=
 =?iso-8859-1?Q?lQ/MjRJR0DtLbA8XDvAUGqEwAccutgDf8+cjqpE633co5+iVU1DXa62Qie?=
 =?iso-8859-1?Q?ERg6E5jDI1h/lojsDeEpNMIt+kqv0NPDO+0olEdqXLiDW+YTCjyYcADw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955100f2-27eb-461b-cfdf-08ddb3098b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:26:12.8633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ppIN1KHKRPIQpyBlLNqdSDfHmSNCu8gckm9btMHmBwgTi3kevVMF+ITYztndkY1j7cMxG5W8fJlwhh/MzJEhm6gc2qZnIU+KbeopqSQ1n0=
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

Avoid writing to PCI_MEMORY_BASE and PCI_MEMORY_LIMIT registers for
bus 0, device 0 (the root bridge) in the Xilinx PCIe driver.

On platforms such as the MIPS Boston board, writing to these fields
results in incorrect values (e.g. base =3D 0x0, limit =3D 0x1600), which
causes Linux to fail PCIe memory space assignment.

As a result, Linux can boot successfully and probe the PCIe bus and
all connected devices on platforms like the MIPS Boston board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 drivers/pci/pcie_xilinx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
index 63058e8e7c5..4ef20474a0b 100644
--- a/drivers/pci/pcie_xilinx.c
+++ b/drivers/pci/pcie_xilinx.c
@@ -132,6 +132,15 @@ static int pcie_xilinx_write_config(struct udevice *bu=
s, pci_dev_t bdf,
 				    uint offset, ulong value,
 				    enum pci_size_t size)
 {
+	if (bdf =3D=3D PCI_BDF(bus->seq_, 0, 0)) {
+		switch (offset) {
+		case PCI_MEMORY_BASE:
+		case PCI_MEMORY_LIMIT:
+			/* Writing the memory base or limit causes problems */
+			return 0;
+		}
+	}
+
 	return pci_generic_mmap_write_config(bus, pcie_xilinx_config_address,
 					     bdf, offset, value, size);
 }
--=20
2.34.1
