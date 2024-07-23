Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD3AC3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 16:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B788841E;
	Tue, 23 Jul 2024 18:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ogga.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ogga.onmicrosoft.com header.i=@ogga.onmicrosoft.com header.b="Txnt6cKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06348811C; Tue, 23 Jul 2024 16:12:02 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D9A088826
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 16:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ogga.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zli@ogga.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cbki+UXxpXBrToXBhjC4iaaK39mzDsSvvDm6XU7CRnFqiE3wqlNcKwc6vN9rIPs3KwnSGJHi4/w33mvcgvoQiabPNi2If6VouOk14qrta5bMCG+3a09ETNf8/6kQX9lyXz71521fy9Z+jyZdhaAomvweREwyHkadDQEjDdl1ThgUKG1LrUCAjldyxmekCAdZBwcdUzws09iSwJf1cYTY0ILbfR4z8XfiWoUTvD4yzeChxoeCyhfza6B9wH6PryCN/cysbzEfCfeAgH7uclAJLUhFE4KDZfQTw+nABZuEpfmFro1bk/bxcjQ2CseMrR3v/fk33ITpWh6zq7qjlnHbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvLjOuQy2GvTyKEXbtHHM6yGFVTQw0kf2GCEn3XjrNg=;
 b=lH58AogmaTBcZuupz/70tzPXa4e7aGKRjL86YP3biAH0jAz5XGeVkFs/zD+KlBvan7eWah2pNRF0ZAbt7+0Z1CDiYvTtIyugShxUCUCBbU7oRbXT/LyENt38ovbFhsv3MX3X+JtPOSZELoYQEV66g6JlXhIXIiwVC3CiiZwANpFzYV7YCXIkVUmYM9ROAdwZAXh2xx9NMpZiFImYD4eFxTMgTS3gOthQuQm5Tm5cMBXA3rjLY4hqsM8+ekJS6xnw/xMpo0L0mukcBpXXW+ikS5ZKm/6gWLGidWyCXpVMmdlPHK8Nb6Q3C+QZcfvlV8icUdSzvYRI90DCzsNpfcxUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ogga.fr; dmarc=pass action=none header.from=ogga.fr; dkim=pass
 header.d=ogga.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ogga.onmicrosoft.com; 
 s=selector1-ogga-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvLjOuQy2GvTyKEXbtHHM6yGFVTQw0kf2GCEn3XjrNg=;
 b=Txnt6cKS7dY2XFB/yjQNK0uVY3U3C8QrK6HwZmVskOfiZJadbR7TELeNny9gHbr7Kd9dfWHC7XqVp2d+RQQzfyw9VezutIoXaBAmY23QqjZI9Q1GiR+GsstKuVTm/KZUdeYWI2TwZjxm9m5WBf4yHjFJeRj7IqH9K1tyHWMnvxc=
Received: from PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::20)
 by PR0P264MB2503.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 14:11:56 +0000
Received: from PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ead1:fb5b:e337:d4ff]) by PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ead1:fb5b:e337:d4ff%6]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 14:11:56 +0000
From: Zixun Li <zli@ogga.fr>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, open list
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: RE: usb gadget driver initialization issue
Thread-Topic: usb gadget driver initialization issue
Thread-Index: AdraksYKvUdWMPd+RkiQx27iAfyB4AATkGCAAFhrjmAAMZ4LcA==
Date: Tue, 23 Jul 2024 14:11:37 +0000
Deferred-Delivery: Tue, 23 Jul 2024 14:11:02 +0000
Message-ID: <PAZP264MB29744B89E4BFCA068B4D1E82B1A92@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
References: <PAZP264MB2974BB43BCE300D4A9E2FC63B1AE2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
 <7cd7bc33-a9c3-4235-9861-65d50338be45@denx.de>
 <PAZP264MB2974A94AD300B6A8210CD418B1A82@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <PAZP264MB2974A94AD300B6A8210CD418B1A82@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ogga.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAZP264MB2974:EE_|PR0P264MB2503:EE_
x-ms-office365-filtering-correlation-id: 6a8374fb-042d-411b-8e04-08dcab2168c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ApMlbcarw2hSaNHJeZX2nd+Rm/gxZuoAb4R4VCFV/3PtzRAqdyq7+5xyHCa9?=
 =?us-ascii?Q?DviPUCL/gRX8j8qeqN0CNofByUYGG/I3xUT1Zuz+l5cyleD8RNJbSPiuUIuV?=
 =?us-ascii?Q?zIoI302ZGzwdFod6v+ECG5yPKM9LFGBLqH2SjCKZygzzzs5XJI0/WuSyCLno?=
 =?us-ascii?Q?nCmVju5Vvdm7RQSbo55AxoeAUqyxaufJy6syw1FxXmxRtX7+YC9ayLwJq2wa?=
 =?us-ascii?Q?Jf4WNp2GiXklW8V+7Eeuf7lPC6lNpto46ItA89tMTchxLmtsvoN/grLMILGZ?=
 =?us-ascii?Q?L4vQ9BE3A9vSt6LjuKbeAbdCRkuL7rTEATpXHSIe61NbO1Ub+ZQocyDQZ9jV?=
 =?us-ascii?Q?4FtxOfy9bE6lpnSLosIZJbjd6UVi7qbcq+rU8cUBv64bv62QufN0PALK8CI9?=
 =?us-ascii?Q?HqnrQXWSiG37PeJ7Jqp5fryHV9YX+7xj7GMtipBoRI3+0sBdt+Si1vj95egI?=
 =?us-ascii?Q?S1dUeGTCDQu6wRUVGzLjbsgIuslMrHdqPt0Nbe6DJwLMIbZbNzrp6LqQCoQm?=
 =?us-ascii?Q?P1UB5H337kfTc9FGQGS4XQBgRN5q5RELWD4HcEcm5BeFGDVwE2fzBgN9Hvfk?=
 =?us-ascii?Q?O8GgH5W3QI+ky1qWqq1tP2tWvYhg31CyZGEkUk9UPq/ZN6Tx1ZsQPOzjOop+?=
 =?us-ascii?Q?LuEf2xjsW46M1oVGC89bsSJZBB+DL+gcdK7AXZ2aYgThQ+b4cMyI+hxzMuCh?=
 =?us-ascii?Q?AIQTiQD7nQzlewPknHsGVwsC/+I8G3G5arF8351b2bylbXy3fB1stgtWI1wG?=
 =?us-ascii?Q?gDeQLe9h2eXaz5j4G83qN0mLY2t4JGp2aLFR+XF8I0tfcUBwKNXn22tNrt03?=
 =?us-ascii?Q?FNAQcEFQstEF7QWel0yDtNqZI4eqVTmkNchY856cuk+/cqOXs2C4UD/qB27t?=
 =?us-ascii?Q?7GckgaUMeyk9xC4/1/McEmxbsbJmOeD54KPTkge3JcN8et8psEQXX/vAtuU2?=
 =?us-ascii?Q?Q6J+sl0gty14uBtQPGvj9Nlr5JlKE8d1Jh9yhJNZspfCq26LoWRuwRq6SCAq?=
 =?us-ascii?Q?wItohQPJdayhNPipnWPOkNK6gYrZibZ2Y08FCHI4UYxyQIEMeR1+0E3E9nXf?=
 =?us-ascii?Q?xAzEfJGJ3Xx2jYYxTPQLxcMMptS3VtMRm2rTQ2PUKqDtPgeFaj+RhJ+M17B7?=
 =?us-ascii?Q?ZHDquvp1lnsJ1nsmw1zLf8E6LVd9VtIZSt54J2Ji2vh8kR3BPN3yDldfKMel?=
 =?us-ascii?Q?Zxfe08Ik3ihfi1nxJZfs6JjDj+QK2TpsKJ4ND2DJU/+akUTrD5tUcCLqJgw8?=
 =?us-ascii?Q?AM+o0pt/V8cbBBtuOUEKbQTARivtXyP57eHG/33QwotZ5y+5rCZcfq8O0U33?=
 =?us-ascii?Q?1cBXDMLNb4kt2W8C7bCfdIxqMRBnb04Du58eUt1fTvFkX+xOzyglMuQR7QKk?=
 =?us-ascii?Q?r5mmZI/YjPBp5Dglg3QAvclwlckZnbdyI+BRH/T/zPglUvfY1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rAfsw5WuOE5Yt3bQXOjb5WLCeuF5b/lgKoUl7mO7dYqVfJRR8SsEn5CL+3Lw?=
 =?us-ascii?Q?3bYyL5fCbJ5H22ptP66yJoH3KV2RbSM3uirCmF73qZf1P/8afKslik8XyAOM?=
 =?us-ascii?Q?VBYVY9rI4JsbgLlGMTV26kbDsu1J+D0/8FiFGPbeqgB4uISJwdJ7kE1YyoiB?=
 =?us-ascii?Q?Uyoy1Vf8o/0Z4q7ph8B6Ffi4y7M4PiScF5EuerqaD4QPJ1NNqGY59fpLbDlp?=
 =?us-ascii?Q?Nv4A9MWp0N16ceomJ02hfLuyi1BjYZ0F4PBsgOr6k/JlbvDaMqxpkfsZigE+?=
 =?us-ascii?Q?XKVWMZxk5Y/0x+6D9L1nAC3QzV3Cr72/zUMDDAzS4F+UFGNIGHX5A+5hgLuG?=
 =?us-ascii?Q?Ql+vHaRII81lY/ZqF0LPTdUOC+RKYccmB7bRGODIDhr0YnyhFVENtWAaGdU6?=
 =?us-ascii?Q?G2mJREwlOKDLHY1RXLMWz5tR0fyu18VUDtUTrC73KNzBjGn1aJRC4osj93zj?=
 =?us-ascii?Q?BHqtMTeJ7nYE0O7A4Cuy58kuHqWV7PPZva4kcRT7UmF4kZ9jIrpLXj8MbvO+?=
 =?us-ascii?Q?tjtPM54NadhI+4Xc2anmrjm2xxt+bYanEj6LSSMcJp53+wfk5T86Hg0aizgC?=
 =?us-ascii?Q?Shn1krFtccPTes0oYtR+pJ+wTG3FItHiNSJZXj9jTlPn8FOXrY4sQy+MzyjW?=
 =?us-ascii?Q?j7A55b3H0dfriPcPZk9Pxy3nZW8JhHn7bZLKV5G7HopcYr6fXmuMuSRLzS/B?=
 =?us-ascii?Q?5Wd0ByauNz6CEUpB402SwdScF0tUU7EEj2FtA7UfhAY+GzvwHgqByPFAR8ad?=
 =?us-ascii?Q?R/keJItqII/d3B2d0Dx0YEC/BZynF2uVvypQN1xOo5RChjKgcvnONhjseDFJ?=
 =?us-ascii?Q?tvA9DnzHnC5UPZiLNhQTwvOpVjrubvJnGcZivmUHHd3MKPVExEHV0GJSXPt/?=
 =?us-ascii?Q?VcQA80c54SW2DtO3U4WUaARwfZtwBE56SSe68/ZmpRh0iyTLz1xbC2dCpIRP?=
 =?us-ascii?Q?Mm5tt5bvDWhX6nK+d+33MD3irGmIOwJPVE0z8wryPWJno6RI5bdrvcsEaND7?=
 =?us-ascii?Q?kw7mfc/e8xyDo9y93VrSN+l3GQqfNYLCgHdEYtIzziNTCvfrxDrpvJnnRoLw?=
 =?us-ascii?Q?OeuL4EMvMtejyqx4vB9tjTrrL+PkiuA5bebzncD3zdvM1Q9Xd3UeMsOeDDG9?=
 =?us-ascii?Q?hgpJOoZT3wNx8NCg3fcy4QGj92MbUF9PicX4otz3StxdYKTzIpgw3eZd1g5O?=
 =?us-ascii?Q?IT30F0BLz8U5rguNKWvdf/6zFeI2PViJhxFYWNT/ghd2zLD9fGcybs2jQQ2e?=
 =?us-ascii?Q?e1Ny09L11blqSOZ8arHwWBQaL6my/JypsW2ovAMOK9GYfVK3vtVOzqyGarlL?=
 =?us-ascii?Q?oMK2AVB+LE7p/rJkyM1Xpot5mNI2Ym6Pwv8pBNK9dPiSpRh2KdGswSEmskVe?=
 =?us-ascii?Q?80bm3VPpItHh9vr1zJ51sh7g1HPgDLGMlzzzWNP9u96Tp/L3zj7X3+7/NS2+?=
 =?us-ascii?Q?amdyOUnN23b3D0Dczj2dhlwy+paaNBMqtFF7tLtTKa6t3eKazHBX+wyoN/rW?=
 =?us-ascii?Q?bHIkL3HqG6rkGw18Kyck0iMTX79uZ557CkmLaQZm7LuDFeFAdzfgLGhp5Q?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ogga.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8374fb-042d-411b-8e04-08dcab2168c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 14:11:55.9132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a737871-c9db-44dc-a24e-55df547c3098
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjX7fiwVvb4luqS26IILNYT7jK1GrP59HPdWxjg1t8SxJ0OlNJ8rrPRTrRLx7NNx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2503
X-Mailman-Approved-At: Tue, 23 Jul 2024 18:35:37 +0200
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

> -----Original Message-----
> From: Zixun Li
> Sent: Monday, July 22, 2024 17:53
> To: 'Marek Vasut' <marex@denx.de>; Lukasz Majewski <lukma@denx.de>;
> open list <u-boot@lists.denx.de>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>
> Subject: RE: usb gadget driver initialization issue
>=20
> Hi, this issue only affects usb_ether, as g_dnl will enter event loop rig=
ht after
> driver register so the host won't see an un responsive device.
>=20
> I think one solution is revert half of 718f1d41 to move
>  usb_gadget_register_driver()/usb_gadget_unregister_driver()
> back to usb_eth_start()/usb_eth_stop().
>=20
> It doesn't affect the ability of bind/unbind mentioned by the commit's
> description. In fact by reverting it usb_ether will behaves more like run=
ning
> 'ums' or 'dfu', since running a ethernet command like 'dhcp'
> will do register->event loop->unregister just like 'ums' does.

More precisely I'm thinking about the following patch:

Subject: [PATCH] usb: gadget: ether: Handle gadget driver registration in
 start and stop

Revert part of 718f1d41 to move
 usb_gadget_register_driver()/usb_gadget_unregister_driver()
back to usb_eth_start()/usb_eth_stop().

usb_gadget_register_driver() will initialize the USB controller and
enter ready to connect state.

From the host's point of view, a device is ready to be enumerated.
However, since dm_usb_gadget_handle_interrupts() is only called when
ethernet function is started, at this stage USB events are not managed,
host's enumeration attempts will fail and resulting error like:
    usb 1-1: new high-speed USB device number 50 using xhci_hcd
    usb 1-1: device descriptor read/64, error -110
    usb 1-1: device descriptor read/64, error -110
    usb usb1-port1: attempt power cycle

With this change the USB controller will only be initialized when ethernet
function is used so the host won't see an unresponsive device.

Signed-off-by: Zixun LI <zli@ogga.fr>
---
 drivers/usb/gadget/ether.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/ether.c b/drivers/usb/gadget/ether.c
index b7b7bacb00..ed55f12662 100644
--- a/drivers/usb/gadget/ether.c
+++ b/drivers/usb/gadget/ether.c
@@ -2277,6 +2277,9 @@ static int usb_eth_start(struct udevice *udev)
 	packet_received =3D 0;
 	packet_sent =3D 0;
=20
+	if (usb_gadget_register_driver(&priv->eth_driver) < 0)
+		goto fail;
+
 	gadget =3D dev->gadget;
 	usb_gadget_connect(gadget);
=20
@@ -2398,6 +2401,8 @@ static void usb_eth_stop(struct udevice *udev)
 		dm_usb_gadget_handle_interrupts(udev->parent);
 		dev->network_started =3D 0;
 	}
+
+	usb_gadget_unregister_driver(&priv->eth_driver);
 }
=20
 static int usb_eth_recv(struct udevice *dev, int flags, uchar **packetp)
@@ -2503,15 +2508,6 @@ static int usb_eth_probe(struct udevice *dev)
 	priv->eth_driver.disconnect	=3D eth_disconnect;
 	priv->eth_driver.suspend	=3D eth_suspend;
 	priv->eth_driver.resume		=3D eth_resume;
-	return usb_gadget_register_driver(&priv->eth_driver);
-}
-
-static int usb_eth_remove(struct udevice *dev)
-{
-	struct ether_priv *priv =3D dev_get_priv(dev);
-
-	usb_gadget_unregister_driver(&priv->eth_driver);
-
 	return 0;
 }
=20
@@ -2526,7 +2522,6 @@ U_BOOT_DRIVER(eth_usb) =3D {
 	.name	=3D "usb_ether",
 	.id	=3D UCLASS_ETH,
 	.probe	=3D usb_eth_probe,
-	.remove	=3D usb_eth_remove,
 	.unbind	=3D usb_eth_unbind,
 	.ops	=3D &usb_eth_ops,
 	.priv_auto	=3D sizeof(struct ether_priv),
--=20
2.45.2

