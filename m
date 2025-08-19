Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3AFCA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 12:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D430B8304F;
	Tue, 19 Aug 2025 14:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="KkKgQWZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25CAE802C1; Tue, 19 Aug 2025 12:32:37 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42A3A81FEE
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E90/PUL0WsF+5WaatsZXMu0AJ6Xmw/Wdhg4SlMblW63D8x4GWLYeMDHcJHJsq05n9cLC21k68hUS1jg4FT3Z1xbSTxLwIkKp3eBgxyZR0WC4B2EYy/3T5939u+cj5gHWHSD7sS4hftNlJbKprU9dC1alq2Tz+Q5P9Ho5idkfz0i9P2N0A7+xGXKYLtLgGj9YXbduGsfdyEYufpPh9DV1ou0r5+bfRLU1mungRl7Xyu09tTuhz0OiY3I13/END12HbaWJDzmmBoP0sboFBn+EMQyvQMbNrN3fZxuUGfCQxapvEqURk2ej/2UoPaSPaiQZSFBcUCvv6hJa0PBXrEDKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJkuNUK7c62Zz4f0E16cS5K6MLL+EQNLk5a85VTvfPs=;
 b=DH6kKyUTCJLv/j1K6lakPGqavK2j8nB0Zn4aeHMdXMAgoqFNAgYylzo/bUfD6A7pjFmMLv6jeYGkMkVOsCgePdrIytqKUTkWfzqaeBOyeh6JZulgfORHjhpsiZoQUw+4LaqUfetMGhNYsbqOJLNCImKtejtcXH/WNMirPi+qJg+93+2fTvmysSC2KmF3NxY/Y9lnMtSjpF+UjxgsjX1+wOxvM25I5O7w/Cj9v53gUrykiDzC9rYoP9uKrSSAcTDA+vgWMA5XhTznqNcMYBiin8NXypGYNKdKBGHapYkHjWOnCBvBstlPEkbczUA9VMaVbJFyNnpQeMxSGZ76vvE5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJkuNUK7c62Zz4f0E16cS5K6MLL+EQNLk5a85VTvfPs=;
 b=KkKgQWZ8EtTq+dMmsH5VnrtJRL3uGqITthKAWwAhht5DKaeIJ9oPiTy64clYvxXdfnWjnV1uMo5epSOZ9Hq02eVWQ1n/Kk/RRhj4hMKj3e4IjBWsKCZXX2ZX38R38eZ+9K6tJJU5JVeWubfFEP+XC0hdVLZxVBOjuqUK1L1JQN6YO1Z6VdYaYaRAcGX+64A00JqenSfA6UnNUx6SkY6CMAa+vNgSd8EF3pjMA0AvafpBtSV6Jx3pt6h7iihI84zlpKqQrilkzRPlLb4lU2KARxyzAszQxnIubVW0lQSPyiAYTJPfVSrGK9r9xHBWrbhbXRAnvVOkawPkbhHJeyN6rA==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI0PR09MB7338.eurprd09.prod.outlook.com (2603:10a6:800:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:32:33 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 10:32:33 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v4 04/10] pci: xilinx: Avoid writing memory base/limit for
 root bridge
Thread-Topic: [PATCH v4 04/10] pci: xilinx: Avoid writing memory base/limit
 for root bridge
Thread-Index: AQHcEPSSOyI5j4ejp0SHTP24u9DA7g==
Date: Tue, 19 Aug 2025 10:32:33 +0000
Message-ID: <20250819103021.1518687-5-uros.stajic@htecgroup.com>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI0PR09MB7338:EE_
x-ms-office365-filtering-correlation-id: d03a5ea3-f72f-4e13-84fd-08dddf0bb560
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?fr4nQQ7069/QsC2Qq8nERXVeJ6iuuP+2Wy9ieI9aBsuR80tybZYzFeL7IR?=
 =?iso-8859-1?Q?M64YK0swKtqPkSDm4jfZlGXDjdlPHTc5MQnnGjCYARBFGiXW3WNoEROBj+?=
 =?iso-8859-1?Q?MkdwcfTpwvPtXtzOs/mXhKQ3us8V0889H1mE3UGDDAyo5ni20Rbu2LP7ij?=
 =?iso-8859-1?Q?K+/bvIKqnWa4Z7MAdFC7n69Qhk0DQohqpr3SjMs7z5hvVYX4LgGcSjJ2xg?=
 =?iso-8859-1?Q?ftJqcwJ829u9Bd/HdncJHwcg1uiWF5fthidQec/tWWqlgkOOu6Xw5JAP99?=
 =?iso-8859-1?Q?z5w7FSHfCC/HSB5ffteqjiDsQJcs6IOGbphCBRXIqzl4QKP0Z1xfdGf2Md?=
 =?iso-8859-1?Q?BBjf6imQ1SeoNhaWoAttU/fMuzFLI4wcv+3LNa9/r3O1iX09FB4bz9FIHs?=
 =?iso-8859-1?Q?a/IVLnRGiRctoFl4d3Ht37tZ2C1PkHCvBapOu5s9MtBIsKxG4z5wf5JxiJ?=
 =?iso-8859-1?Q?1nSZsIaWxROIJQuq5DMehiGx37xiiYErXVLQ+BeNxAZJy18uG9nU8NFlhW?=
 =?iso-8859-1?Q?HXatZvR+Fle9ck3+51B6sXo7XLSvZG/3JVfz5ARjnPL1R8KLTLjW9rkuIL?=
 =?iso-8859-1?Q?uLhuGeJxr4neLkCQLLRaDdGfNYlvnLzpUOd1WXL+OzbV5bOrjSWpYcTeIh?=
 =?iso-8859-1?Q?VCswjkMu2EXrqo8/kyBwMGhdbxI3kBsgg8AaFNrsrkYu+Vx3hBWFstJJRn?=
 =?iso-8859-1?Q?rqT2cm+wkWGgS0GAzMqFAysHXCNVzzl4BRtr8QJ+EEtGttJZKxJpgYMXWo?=
 =?iso-8859-1?Q?yHcH3oU5RqUdwCxSKFzSQ7RmLIlthIljTaJcKYZkC0RotuE6T2jaVDU75F?=
 =?iso-8859-1?Q?juDVsUGu41DrXTWed+sISGVoPFePWgBh+2ghcfy6eBs7hLMwtnqtnvrevW?=
 =?iso-8859-1?Q?678awEWyhL50Pzd+1/fyiyw08tM8a/wq/gq1dLYnwyWz2yGty6d8w/R3I3?=
 =?iso-8859-1?Q?LnFf5MRBoUw4JUl+gG8ZCNLR6+XIrtGiUFxprvH+kxTWWr2A+mbgYAfFw9?=
 =?iso-8859-1?Q?fqxoTLhvgpeZGvjmemw0y+Ac4zSkV3F7JLlIKS+9UWEfoyPxQusI4tKcOy?=
 =?iso-8859-1?Q?Bcw8BzXv+wMBCEf6cHiUGnQ8wbY9OFf3Is9Tc5PZlYtCXHsbLMoZYX8sXs?=
 =?iso-8859-1?Q?ZUtNuv6SGndjDFid5cLPRFsVmjKpDaXRS2reSHSt0xrTEFx6N08Ex5z+d1?=
 =?iso-8859-1?Q?5ZJXmHezKRPWg92g7x2TvEht7q5InsbLiNhpKN6QX/pCqnBp3KTaLErEWR?=
 =?iso-8859-1?Q?9zkny88YUUNbMVJs0RE+dMs1GDmq1gQfp3yXiYjzjwC2V4Lzn9c4FCO7iD?=
 =?iso-8859-1?Q?MN4gHhINOPn5d5+M/ZhUZkmHYkW4R02icfp2jf6tMOMIv6mEa8KaMRehf4?=
 =?iso-8859-1?Q?WCwASJBDMDcscszvASVbKOMBP2GVs4Xrm1crAqwn7OGR5Rjo2lTgvr1vm+?=
 =?iso-8859-1?Q?Fj8qh2fchLRjtz9iAjoygvC9KNQ6XG1t9GwMKMCUwpa5fnLgcjO6639tCd?=
 =?iso-8859-1?Q?QY4XZu7sp0f4wz4iR/9HIwIQ6A9ByuNZjL9zq8iBQId10ZmF6/PBAlapT2?=
 =?iso-8859-1?Q?KbExpZA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kzQXuQt/6nbVjZlRdy2wKouKG5o5pEIHS852q4fdTYREVRyJb4hHRKn9en?=
 =?iso-8859-1?Q?JSlgicVUBGAVSNb46H/m3Yv6phNSoIsE7p4xnsC7zY6rPMJhqYZYY2WbJV?=
 =?iso-8859-1?Q?1DbXtM1MCLNCpPeUK8LHAOruQ000TugZc1cmgxKHeiMt+Owg2SL21gHIYV?=
 =?iso-8859-1?Q?68/8mqnXh6tbJiYt44ntZSLT0kKXg4kYEfaLxwiWBjr1yjXFcUwGe5usFC?=
 =?iso-8859-1?Q?SuJF8fASdUBijupGjhsMO7jNMuzLTueOonTMZtiRxcGcTRqd43IGQisvG9?=
 =?iso-8859-1?Q?CYp/Eb5dhoJVdkrhKj825fZ4nZBrDUvyTbKdE2ehMKhHTftTKZuZSiYDuN?=
 =?iso-8859-1?Q?+fh0GvUTIYNPXVCXKDg4N10OJf29UvUciLtrivP81JA6XpjR5wn1iLqEW8?=
 =?iso-8859-1?Q?DJtAtGwg5AZy9dvrAtkygMWjFFO3IFarw49S1se7mx0eVJPJn6z1KR0Pwl?=
 =?iso-8859-1?Q?Lpo8jfFVAWU8XC4YlI5oJGZb3BBNuLjuiZhOFcZDhOJONezjGonMi3FNLt?=
 =?iso-8859-1?Q?jBeS8T9fy8IjFToM/YtzNduSbtJOnqwMo8vR19cO+Qwa6niVlJXoTds1wo?=
 =?iso-8859-1?Q?j3b42BOPuo4Skau4XXhx8fTo2kL69JFLTbUOhEL5jmP4KxnG7kwcxIM9f5?=
 =?iso-8859-1?Q?KiuP3cOeeuHGpEWzn9Nzu/eQOsIJowc6GncaYfrkiRO/g0rBJ0MHMc9HCY?=
 =?iso-8859-1?Q?mQmP+/SLJDtaNP7jbjnQjV8SwWFmZsu0HFbW6O3F8bb7Qk8vwhvEHOuKPf?=
 =?iso-8859-1?Q?gplxccDkpx7RSUWsLgdNIoaYed7mnYP5XxqoJSJFNekeaCTI77j9fTgFEE?=
 =?iso-8859-1?Q?HvS543ouhh2OCmEYOHCGKMIi+dS/1O/9T7SSDBlCcnMn6LUYh73QngOJaI?=
 =?iso-8859-1?Q?BbWzcoRAjtTEmWxu/vFJNzxBRiE8kysYcJbdXs4T/lOEyY2IfUgGTIc6xU?=
 =?iso-8859-1?Q?j5aGdS1N6K5VbskBKhb97FYJ6p7f6BPXTfHtC+zJxZeLzZ5n2i3ww3cSmU?=
 =?iso-8859-1?Q?t+WUSo/oPsUpJpWKTUxYGQ579DD1PblXr6pi0mz6SkyTvfCxi84bX8dpLL?=
 =?iso-8859-1?Q?k7KsrFD07JZQcpbpI6QvUhwmvZ2S1GVJRPgLqNp4OYlO/Up8Yw+oN9SG2z?=
 =?iso-8859-1?Q?JcKHZpKSTMVaw8r49Fp5Fwil9yWCODmLGORxQlPbkhRv+w3gxqruEhAM4P?=
 =?iso-8859-1?Q?fRLcW26YDfncghxuQo7ROhfuYeWiNkNpn0enygdquDouEge7khSFcXlfRa?=
 =?iso-8859-1?Q?JNegOs1qzgXE7dLL1lO5uuKFIdsh0CVTHc9xwVccbjNpQT3KMk0gvv8s3g?=
 =?iso-8859-1?Q?rELLGpCG1ZVSvz+bRUZElAvqDxXTvH5VlwztpESpsoSODQBANwVjv9vVVl?=
 =?iso-8859-1?Q?hRZkdbtYzwmWwqziXfpXIAeYzssPRNwgnk0wlqwRYTROXEEuPWWBlxzfYS?=
 =?iso-8859-1?Q?DChvHOcTaT1XaZPESfgTnP6kIcTe3k2Cc3kMT2TudzP0FgRZQiMVW7APyx?=
 =?iso-8859-1?Q?Uh+uY9NuPm680pioR7RRPIMMlXPBzqVpJPM59fP8GCYZyA8pw7koXxfr93?=
 =?iso-8859-1?Q?mS1kXAYB/aolx+2xqjGj2zTjsqzBLjvwErgBHMK6g+TU0xh21Ifrx6bUSY?=
 =?iso-8859-1?Q?/1zV9/KShy51jzUo3Dt1eavp+JFw02H0zfGh+0rRAB3Zec3I3JEDMsNQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03a5ea3-f72f-4e13-84fd-08dddf0bb560
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 10:32:33.6720 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4CFoIwJu7oXNMf11OQ2u9sqdH8Yct2IJVmKPV3tX9FSDtE91CMpT9Yu1LXtocb/g+5FnZN4Pa8HYdwGtjjxiIChi1C0GAelgXFffRfElktA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB7338
X-Mailman-Approved-At: Tue, 19 Aug 2025 14:58:37 +0200
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
