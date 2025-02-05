Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0F3C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE1F80AE3;
	Wed,  5 Feb 2025 14:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="I3jrTw1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35885807E2; Wed,  5 Feb 2025 11:15:54 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63AB807A7
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZIxdKKPXsqLiMXvxilj4OQ5/XMhPjDoEsmel6xGrNKLWtnia1tnnbr4RTGS6TCSOKSoQ/3xAgnJkMfO/7f9JNSZUV7B+7o9n/a+Lu+UQ0jJz2uiuzlb+vhCbJaqR01w6FNaCuf/rwIFbZA+HST32LiNwzG1DFBkgw1/c4XL4sqeKl5El3+4a1SYoZ8WsyDvyMKZQkp8v0rKFHl5Mz5wdiK+htxsNVaD6LTlwE8AEyLvjT8SSvYMFoEiD5DQX/BBkGaH/6nF92A3vZ18fzm2/wlBj6kidbpveUf6Va+UdK+GKGm120QojpCMQj+ioZjQSM9HU6AmRkgFHEQh2piRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZODOimQBfNbNO+adMZLJsgrW4Z0xnefAwIolxgSSIzw=;
 b=zJw7HrwWE/ozpoX6gLudh36z8UIZ6RNYk94hNDmw/sfIZN5qva52BjEqIil+/M4Ngwyyp8xY9igkQdc0SFeGxG+g737RjC8QpEiFPcDlFHvAJVJmhzK7AkfC9XCjem8LibULO2QJr1RzgiPTB5y8tNkZweIndLBZvAU57Z7YiNi9R+BcOXi22PO7KJew4laCPitCZLiGzTiR3Xj1EOyIhPLCLh178ps4Av6e/h7R3MudDbKVdYoCyTpvwiUjmuZMwQAwzpnqfbJG/T+XzxTw8gGHY7pLwgQWbwCji0cKJ5urVmW0JfK/OBuYVU2gZ/u0fQCN2+VJ7uDY6oEOvOq7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZODOimQBfNbNO+adMZLJsgrW4Z0xnefAwIolxgSSIzw=;
 b=I3jrTw1vla7nXQPrrDg3fuLJO/3EOqbBpozqpqXUu3L87zQtp+NDi4wt++nFPXe3/ECNBxiJnHotEAU1M29mEDLCNc7pFeU9RaXxTKBTBE4izUmwwVrWUjw+qI05L1b9cuL7wdZ7YDIxwLcCz/xkOkGVP8tWdRSY7+RZS4XXMZGyUmSKHgWnKdV1E09ycQJz4U5NuB/IIEpf1drXwC01ARagO/vyd+kH9IdCRSe1EyxbVcTzR3Oatkrb4U2Sd/dJgdeZY4BV86PXVaGD7lJ/utvPSSKXy8YWspsjcbY3OVzH4JIV5KlyK/M+TIXf7+Bc5SCBH0aX6tAadkzMNlMU0w==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:46 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:45 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Tom Rini
 <trini@konsulko.com>, Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Subject: [RFC PATCH v1 06/20] drivers: pci: take into account that
 ofnode_read_pci_vendev can fail
Thread-Topic: [RFC PATCH v1 06/20] drivers: pci: take into account that
 ofnode_read_pci_vendev can fail
Thread-Index: AQHbd7bqyJo5gDYh10GiP53gpvkDEg==
Date: Wed, 5 Feb 2025 10:15:43 +0000
Message-ID: <653f6ddd2821a7e27cdca5b7489204829123beac.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DU0PR03MB9635:EE_
x-ms-office365-filtering-correlation-id: 7a132613-642d-49f2-f76c-08dd45ce0e28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AHrFxZYBuhKs7JlU9A5SIF51Qlu+BdkRWxmXLiMFuLbdkjGeXZKj/6xEqA?=
 =?iso-8859-1?Q?fehcJ69Oo3qwIKIlsM3RfkKNM4QXlWkR3t24sJCv6rXv3YCQ2Ci7eVn2dP?=
 =?iso-8859-1?Q?51Tuz70bEI8d0XSrYNaHbcXedQ6vM8cIcAjYRGtKF8KK2tEIUUwUBgfGHS?=
 =?iso-8859-1?Q?0ntFDvk1TsOMVnaP1fgackhm4qa8Dp9fZKrSqJBpmyf0t2S5xCpNX+aeDt?=
 =?iso-8859-1?Q?BmMN51Ck6dPFbvhMnKVT+X6XI9aMaYaynm2Xyz8j9QDKLfX+F2C3JWZt9Y?=
 =?iso-8859-1?Q?5nWBE1fhV2Gw4t5EMWRlSBxKec1HFP3g7LV+l6bea+gNSVrr3CqlfSSYDW?=
 =?iso-8859-1?Q?IirqrNA2rRvf0PRBFem4GNGzQ8iex8UkZt7hKHBUnPZxGOa4u58kzgYIT2?=
 =?iso-8859-1?Q?Z4f3xrW2e2VPb6ghzwHBjY7ajP0gytNvQ9wqKnFUSgBu1YDp2ssrs75qE9?=
 =?iso-8859-1?Q?9SbfTrkbGQ3+m/h2zMDwStunCm2sXWEwpPUOc5dwl6/6m4/7ynvsvPnABV?=
 =?iso-8859-1?Q?AGcHUkFh7KDAZV9QVmNv7gBJ9yP0BgTTQ7oE2l7XoXg95hJNlvhYRC9Ois?=
 =?iso-8859-1?Q?ip/Kr3QTa0q1YfbzcwVl7/GFW5pY4a4OYIO9yUueMM86Hkw4NB2OEBHrOR?=
 =?iso-8859-1?Q?M7xNP+xtw+gFpXRC5Cli05G2C81aUKYSJf79roSDRzH7xQdrsV2iYXALhM?=
 =?iso-8859-1?Q?HfP3EXVzL3TtPk4Len119k8boUY80zd9DnjITYkLNfow0cIw/sq+PJ//jI?=
 =?iso-8859-1?Q?Y9RJXoJ30OVRaZr+xXAlXuraHi0CFw/2XgiYCfNgmhuOy8bJT76bvZbRS5?=
 =?iso-8859-1?Q?tRzcJFmmePSykArOmsqxyp1cabtQWsm0SfHEXz+zPFGdjv2kUIEYmf/pGC?=
 =?iso-8859-1?Q?HCLKo8ruxEDcnlxFRWfMTuU/0CGeypH3nBRJsAs5Je3qRM/S7ZmbhQ1yFx?=
 =?iso-8859-1?Q?DESy6y8oaE9n+huos6beQtlDPdw5e4Lvz6wqGBCCYGsDxNQ/SAlYY5+XeE?=
 =?iso-8859-1?Q?L4DxAXnkwSKQcSbFHKyaYdSne9MbGdXWQULFeB/A7kMCtd9j5U8QCp6gu1?=
 =?iso-8859-1?Q?OwNp1RCj8UPODv6pd9nXT1kCHnZC+a63cQAiULr5LrMFVUHkPNmCnPmhX1?=
 =?iso-8859-1?Q?IJiBSjZ4lRXTjD40KiYFrtxPZ2cRqH2obqI50z9sEykx7iASfvF1/WH2BC?=
 =?iso-8859-1?Q?0ZWWq8Y2i7h/a1y/5iUgFwhVoQUVCFlZ2SqzGn7mX8kWvCvlxB/fo/qQOv?=
 =?iso-8859-1?Q?seC6f0MWHZKGaD3ZzSwVSjHu7Sz6qdnA9Zjtcy0zvP5CPCokdZOYN8NDF0?=
 =?iso-8859-1?Q?DXlHvjzXn8z1TOfW3uTDqek+d6BP9Ew7Zvf5f3lnXlOBsx5XmUm+PZroxv?=
 =?iso-8859-1?Q?JxJjKzUsIVHbiBmchPh7rlDEycAV4toNeXtFDlS3nwIbkathMaY/IYPMah?=
 =?iso-8859-1?Q?wr45g8o3eDvIvw3ykWaJXGjvpX+cQT1MZO/qNHGzF7gbf2Xrw/KKJ2Semi?=
 =?iso-8859-1?Q?E+nKb77ox4Ke3RAQEvjSUt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8WV9Inc3caQrkuvrz2m6ioB+DnLRN7yLqU+OeDKn9Yg11XuXD2oZl/BLZw?=
 =?iso-8859-1?Q?LqluFWi/2R87uMGo9ojqGG6DWw5VN7W5emQjwNrbgFqmEkG/QTKmY0+Tsg?=
 =?iso-8859-1?Q?BaoE5sHiijgYfw4m6LlsM4VtGWQP5Ps+am+mIQ6gObibNRnYyl9N6cr0QZ?=
 =?iso-8859-1?Q?Y76rPIFrA1nBM/U+t1Oawu+J3OounrsH4AbmU5AzG1PC8ESvlD3Aovejh8?=
 =?iso-8859-1?Q?yx477cCBygOZk0dOhD7jgS53p8vwtI3Adp2855fNVHJ5mvkUPRVa1IOJ6b?=
 =?iso-8859-1?Q?bAsbxpB4X59iRvsS9Lg1mZJIQJLiO1+Ka8v4ZOhOS5Zt1wOJ5iz/qO2J3n?=
 =?iso-8859-1?Q?BXht7RVbQiiBBqWD/LNnZ++sprv51Zvv4Rr0zHgk50x9w9YmPGrxFptwY2?=
 =?iso-8859-1?Q?p+e3dfC2NltuXG0BhezVO/6IsRDavJbc9jPYRN5vFBQhs/QGt0ZeIrBbS2?=
 =?iso-8859-1?Q?DLQNWC04fjyQH0ld/f5VTInEwo5FhM9LcxqP5QZs+/LOXPVpTFxiJOT6RB?=
 =?iso-8859-1?Q?9NGRlbszF/ZP2bW5o5QVDWaOFjHmJ8rwmj/rO+X6V7OEbLPOhCL0+kd+AJ?=
 =?iso-8859-1?Q?Nn6+7g9k79yxGG0t5n2swZqQSp9BFanjADVy/8EWb4z8Lsg9s+an/4O1q/?=
 =?iso-8859-1?Q?BfwZ9fWgz7fwOHA/MCC8JSfCkFg3bzRN8xuETl9IqeSTvUkfcAIy6VB2Pm?=
 =?iso-8859-1?Q?X3hMygqWwx83HeiGsrh2dkhFDV6uIokZL7QbEH6xc+tfLK2sIgUZGtUhUB?=
 =?iso-8859-1?Q?fKZc5xm79IeSJOG6maZNfKHsFT+7aAgjvHXs0A9Es3VxNyJZCZiVvMi7nr?=
 =?iso-8859-1?Q?m+jnQ/MlWvIHwaaaHFD/yuxLZCyEhyWfX3G8YUENCJje7/zOMJFWvo5ZJh?=
 =?iso-8859-1?Q?wq6SoMEcqrbNcS1ARwLwJhZp04baWFxxAH6cK6jYk3iDO0hsSLrBhNBw27?=
 =?iso-8859-1?Q?HkcgygPIkqJAJR2Hb37Gq2Xb91FhvCDqvR/Z0yqyjZhi2Rhov1V/xOpuAU?=
 =?iso-8859-1?Q?OvqeRC81fc3MBh5KPbBM8fiYng8olZLByaCl8rakbCZEmaLE4/zvnWftnj?=
 =?iso-8859-1?Q?bKFyqGXfTyjuKMGkeDwq2/cwWfHFazw+0b4lMYEqyg7tCAsoRP/5Zrx8pT?=
 =?iso-8859-1?Q?HO0p1/CoAOqYBst8fmw9reTA4bxC5+lvyDoW1mRLBQ6DWz8fpMoMdiStzj?=
 =?iso-8859-1?Q?CUw1/Odb5YNVGTWNou2LUdsdAKVFQs6V0oOXVAReDHwupTFHN/gScR/9Fw?=
 =?iso-8859-1?Q?9pglZt8+NG1JuKIG6iEn2H8e4Y6xum7wpBZZU5/cwjVN4qaSs5aBZJRw61?=
 =?iso-8859-1?Q?bMjC/yYX5BqTYoeY9UbaIcA31z59qQr2oPWFh4ZkZ+PFyen2+bDHcMvvZ5?=
 =?iso-8859-1?Q?a+W66T1AXMdFzzzghpETtdO3JwOxuVuTU4Vc/XiGDXGdhNbA16SWUg8tk4?=
 =?iso-8859-1?Q?aEynZgLYwDGpTMKPqGpOtj0fTeh+NXrQK94FVP51naIhfMwkT2oODePHXi?=
 =?iso-8859-1?Q?6ssiY+8l/hAkm9h3o5kB2TqKLW2UnAsMuXEeRh8EeR0njIkxd+u0wa/465?=
 =?iso-8859-1?Q?G3/HlaQW8leDNohJjVT2Uhw6EJbBAuztYrN2usNAhoK3zOwHNjP29gYT92?=
 =?iso-8859-1?Q?+/H49juZmXNEM/Dv0rYMWqAVVEsn3JyRdV/OxLKtGRpUJPjQ64vyYyZw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a132613-642d-49f2-f76c-08dd45ce0e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:43.7292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfB+KF/LTjHDWc0OENheuwv5j6+L5stLUjkbGf2H7xz/T+yJEkYCBOpfBYz9UbEutXx2AigAQ1NOhWBZ/vta1vTJY5IFH7yd0XLpki0u9mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9635
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

From: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

Prior to this fix devfn was set to 0, which lead to funny consequences
because PCI subsystem tried to use RP1 driver as a host bridge driver.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---

 drivers/pci/pci-uclass.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index 1a48256de0..18b94583b6 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -1187,6 +1187,7 @@ static int pci_uclass_post_probe(struct udevice *bus)
 static int pci_uclass_child_post_bind(struct udevice *dev)
 {
 	struct pci_child_plat *pplat;
+	int err;
=20
 	if (!dev_has_ofnode(dev))
 		return 0;
@@ -1194,7 +1195,13 @@ static int pci_uclass_child_post_bind(struct udevice=
 *dev)
 	pplat =3D dev_get_parent_plat(dev);
=20
 	/* Extract vendor id and device id if available */
-	ofnode_read_pci_vendev(dev_ofnode(dev), &pplat->vendor, &pplat->device);
+	err =3D ofnode_read_pci_vendev(dev_ofnode(dev), &pplat->vendor,
+				     &pplat->device);
+	if (err) {
+		/* Set invalid devfn if OF node describes not a PCI device */
+		pplat->devfn =3D -1;
+		return 0;
+	}
=20
 	/* Extract the devfn from fdt_pci_addr */
 	pplat->devfn =3D pci_get_devfn(dev);
--=20
2.34.1
