Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10A7F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21D3D843FF;
	Fri, 17 Apr 2026 14:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="dPJPSHbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7878841C2; Fri, 17 Apr 2026 14:25:50 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B7B83EEF
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO+q4Z+e6AO8gGM+J0s57uljbtjoQikrNgA/PEQiaRKbNg8JxUvVAGdooDPfJmUiJKm1T+tnW0r7Rr485XJ2cXeSZ4bu1tcjodkYOTWE/eYWy+fK4d1hoQJ4IvgBD5hAWrZ8Ok6qt3ov0HcxGxj4XYf8y4z/vz/RRWYoO4dPXrVvZKT6AxeG91zgAhKoUeyabyjBd+Bu3vDoXcd6DMjUHhVwzOKh3ogN7m5GU0QmglDqzfiPxOopalX26AKQzrWSb5I90/BWbm2pxo5kLjt5qzwlGhpgcS/rgFYiFcWAW986I4S8oattAvgV68oOV/zLiwjVQ5lwwl9UOv8vnwALvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJkuNUK7c62Zz4f0E16cS5K6MLL+EQNLk5a85VTvfPs=;
 b=doJL1yExvdGmh6+K2k19BGoItOJQmWr/9Yp1SpNDrbXaIVkp7q3Y+KsntzweMl3pzQPFIWp7HoRsqSBvaqj8HOmlXc8jAnoQCeEZy3x9UfeSOpoGuf5Wro5NMmIcOgiZvLsWnHh37PQ5hanurfq4eB8NHQY5FFNVz7uK+X9pvCHNofgjJnwWzCefeaApMnAxKm612gjsy2OjlOlOgq2saLypiTaDQw0R6eOFp8mEUpajn1oMswK3QLrOgV3d/njCWyuqJ7wJP3PLh4fbPRFqQxHIH9UlW7eZLWfoUdCu50PEbhHIbig+EQik/3pX3tryXTkDpogdv6xb8+Y/QUglFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJkuNUK7c62Zz4f0E16cS5K6MLL+EQNLk5a85VTvfPs=;
 b=dPJPSHbqPDtM8bb6SfSfT15K8jkLPfc4qEN90V/JgbpzLBw3qeyeyHLztacXkybPpA4vGVg7YZHK1GJ5zJjf0kY2hTVAe4pOHNPf2o4RcKfU4XMHBXXTSfZX+DWSMWvzSBKpZzYq29G7zmtMUH+tJA6bIt8hrYW0Rv8TwdpSrBu3CcxzwcDiZoq+2mq44U9H9ypkLHJsJTri36jzvFcKk3TR7sT3E9YYuVgEUMg+aK2icFb4gEIZuakIFoJkkd62e2j7Gdm/pBN9HuN0VsI+D0oDSSSaRilKbM6KRkdFiAnJFk73nDAmUkmrLp4LWljzJUVVEwqNdx/4QD35HTJzVw==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by DB9PR09MB6861.eurprd09.prod.outlook.com (2603:10a6:10:4c9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:25:44 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%2]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:25:44 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v7 4/7] pci: xilinx: Avoid writing memory base/limit for root
 bridge
Thread-Topic: [PATCH v7 4/7] pci: xilinx: Avoid writing memory base/limit for
 root bridge
Thread-Index: AQHczmVQpZzQnybCnkyO0mzqHW0JbQ==
Date: Fri, 17 Apr 2026 12:25:44 +0000
Message-ID: <20260417122213.147529-5-uros.stajic@htecgroup.com>
References: <20260417122213.147529-1-uros.stajic@htecgroup.com>
In-Reply-To: <20260417122213.147529-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|DB9PR09MB6861:EE_
x-ms-office365-filtering-correlation-id: 64b1228e-ca28-4772-9e1b-08de9c7c7290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: NQM5xAsw0d3k6CRsdzx4Mcx28wVcPzt1QxIjPxxAqzHbmxU40/azWN7epw79oriq/czPJCns1HPRDmdzy6uO2EcNm8GK1QHMlA2R3jRr0Vu4Ncj772veFBs7BZYIJR1J3kN1VcnUlYI2Z+3kWiu/viInfD6df7PaB9neAxiBGMRBe/UW6ZMeMr/zq7dC1WSv4ZbILY93HjVZBnM1idGSdbkXCi3ozQoqw2yNEEUFRAWF4GyDtEZe14tabukxzxNfhGGMBg8/yy45kF14TGSSy8CsMa44nUuzaPHbUUjYHqiLzc+dLai9PEkexUBGt0brQRr2VZNC1U5wLBJFhUXTHhnkj7qy8lEtWsEaZwPcYdM5PLzdWGAhg1nBiyslO5Tyje9XnIbE19svlRZpm3o0rm2+IClqZf9snQGvZzDSgSpYC5xiTBwh5JHlwS4KEpo3ROQZaAS1fYUj5GoiTnn8RVVAEWQctXo6kMQJpEjz365m42jr3QrCC/tn+df2MYJeRjBi+0pMpxoxVGWXZmLwm+hyanQ1/ixUmSfhmssZFqPvpEfcAZDvfbaFiUlE65gk0YFdAYFwdeewPmynVmYM0tfN8yMVg7YETcNLT6xKTXDwTiv1nROkO/GCU0J4WXnFDg4ExRNOdoRSTffthrl3j9nfP5Xjgs1xexYm9jctX8rMzVFnL4LUz2ueZ0MKAaJDMRfWew555gapxvKdsHeySnTVU+MWTbzOcOgJpxcGhsz5OuJh+DdFUw8jFXyrM8c+dkRW5RvfJFDU8r4qjISkrn0gv6Xjo0U7Jq+JWIEzuTA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yHQD86hVbuzxlSNAdRdJJG3oNi4tdpfgl4niIZRBLS09j1uXv1YPXsxYDA?=
 =?iso-8859-1?Q?pu9Iwzq0ewjaN+RCktp2qyj2flK49PYM0OCcuSe9Ricqd091FDXyEFLz3J?=
 =?iso-8859-1?Q?sjUWJiXdXjFYTZjhf4JUqA/XHzxpDTx1eubZUgDcFy7Bx192lgj7JU0Lc4?=
 =?iso-8859-1?Q?A8aEeWC+Te98rKKKBqF+wrX5GzmuJUcso6WP77AaKSEB0YvRYckihRmt9a?=
 =?iso-8859-1?Q?RfNX/wqvhDI+QXTZXQKfk+CeYov8gGxaOEayWBg0P3xtsXYpuqD+wQo1zc?=
 =?iso-8859-1?Q?G3aFaq/RtB73QNv1Fa98QLWAL5IxCfqKDv4INL7sv19zuJO/HuCj4vAXLG?=
 =?iso-8859-1?Q?+AxGuG/fpQK10+7D882FpooRf+p06ZVz+cmWR3EgdBFw7uDbsDPOnwj0GD?=
 =?iso-8859-1?Q?dIZn1IteKXemDR3CcOHHGC6a/XfixKma2ImRuFFJI75dgk9hiMzzwLvW4/?=
 =?iso-8859-1?Q?77mOA9jtuGNQm0S7OyV8wS4GABt9usvVaR4Kh4K3eN4fKBZk2Dzzh2lekp?=
 =?iso-8859-1?Q?oDAFWs1ZMpphxXx76BULc6yMEPgeilc9950OBtqYK3Nn1uDhzOpSh3xIfd?=
 =?iso-8859-1?Q?9Qn+MLO5XV898k7FGsyGAfAZlBH+UmFB39E+sZPZyuSaTjj0es8bd1aqyK?=
 =?iso-8859-1?Q?24T4tUCMLSzQPFJz1FbKNQRFF3BI8txCCwTxEi7ZXTPYZ2PFldoB7AT69E?=
 =?iso-8859-1?Q?Gy5AhHQkRc42YIqdMMAPPgwFqAMwlRJCNdZPg0FjM9ckle8YtYUMgXx6MU?=
 =?iso-8859-1?Q?d4bZiItqPCQpts4uLKk5U1ZjxSawQhJaIxXd5FTPVtX5j7rIxhBq644i6G?=
 =?iso-8859-1?Q?sAIoBakNssfJa5r2FTW8s6LJEJS9JR2NEkrCFCv6hSmLgbarJhUxVIwaPA?=
 =?iso-8859-1?Q?/YV08zY7wIWhPpN5Fb8B3cB45bmR9YvDCeei+RT+LPLjzWXUNozLBqf5cg?=
 =?iso-8859-1?Q?jc1SwfqjRzrmUhnVhApBdkXt2lAuJIssNI9WcH/f6VzeEA2ddlTPzwzp6c?=
 =?iso-8859-1?Q?fvdubE4tWdYA5wNrHYcUXBTTybuXdKj8zwAtOnISgkDI3g1Dq3JVTVALdv?=
 =?iso-8859-1?Q?Sjb0NIBxuULFLOdlYQ3zScG34LMzoZgpV4dymXVTIxcMuqhJAaflrdzN4y?=
 =?iso-8859-1?Q?DCmtClu8MnNQoqPTYY6yRtwRRJwsIJMO+VFmMM8Qq0ABPEDi9pKtDcSajD?=
 =?iso-8859-1?Q?XlXocSn3hHd4pBuupqAcKks/FdUYNVqPOISun3AFzaAipFJmwsS4YCXLe7?=
 =?iso-8859-1?Q?dxUzOf2TuLQyOwhoiPHkrKGwMZTH7dlpvK5Vk5BB+rbckLTRfNGabXvd8k?=
 =?iso-8859-1?Q?aDzX7czVcRsE25bqj2kDYG7bAy2VhBPybw8ii23DEOJ/cTO2O/CDs0rDrq?=
 =?iso-8859-1?Q?ufRqi468VeSwX9WUfTsR+LLycYmf9EQVyEdzCnrFXyRxleDMWLmgUHHtfG?=
 =?iso-8859-1?Q?bPX5QLmzUPFzjouIvGL5iaJuVYwLDjxvsNrdvj3UM71qTDhN8vm/k0A96y?=
 =?iso-8859-1?Q?0+vZwjCW1szn2vhhec/hZBmHlKLGGfbaJGNlD7dv1OXX6VgPXCD7/bgmwP?=
 =?iso-8859-1?Q?vMGXp90Rs42DDlXYc9gbHn1Pkbhy4OhtT8NoT366uiFBnAYJchQrU/tC9L?=
 =?iso-8859-1?Q?E7b6CXi3qz8pez+NFaXbSGagsAk9xRq/esVhKsPasga0MUt8JXBx3Kz1sP?=
 =?iso-8859-1?Q?h5/Hl/ie+fbLCv/ctYJR+Hc4CsNOoBdAw4CalTtGdVYhDMJRdr4h04T1u9?=
 =?iso-8859-1?Q?+rf7AGybvFTYXh2HJAmO7xtK6Ra6EKnRM9lBvitAYtrMCtIPZu1etwFGrf?=
 =?iso-8859-1?Q?cGYtqOaNDDNtUU4Bpz27FeSDRcONyyA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b1228e-ca28-4772-9e1b-08de9c7c7290
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 12:25:44.4667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQfaAYkxPlAQeG8W1/85ks/mjYJmIo+/UsHzYs5EvK6QREh2vHxFJ7VIpgBGmn1PHkypcT1UEVE22Pk+iF/zPYCMKszrVEAcSikp3zRq+XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6861
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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
