Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F01CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1593186F04;
	Sun, 15 Oct 2023 08:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Jnf5a/6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C81C86F04; Sun, 15 Oct 2023 08:55:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03F1286801
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697352850; x=1697957650; i=xypron.glpk@gmx.de;
 bh=MObZNjQ+OlRPov5+dWvxJ5bYhjTTmWojytr7GLWoDL8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=Jnf5a/6spmltWuyizR2trjgHfl85G/cUnvmQzoHkFbPOzTRJz4NayIDhvouS6lIeQtvZHmG3AVM
 H2QiHzsAw+MoNi3cXxO9Q0a0GKETpsxOpa0V9oeY8FagMj6dHLr+6XafWES0xsDq4bzTJZniKIWIy
 lgeO9wdqyQCa1rzV2ZXU9+PO/aUdnYWkRyXHVLHkAfAiPFTd/DmIsrveNKssayumhNsv8Mz2zg2Fn
 RMacmxdN1RRnD0oZ2VxEZKIDcnSobt34GIt7VTAsn6+eDOm8O4hUXX1EZqrI70s9VgA+cNMlGnMCG
 oKfSkSXoR8ZXnLWSjOqHdWNXwIgSx5Vucd8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49hB-1rZjpR3ImH-0100uf; Sat, 14
 Oct 2023 23:22:40 +0200
Date: Sat, 14 Oct 2023 23:22:39 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
CC: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_17/29=5D_net=3A_bootp=3A_Fall_b?=
 =?US-ASCII?Q?ack_to_BOOTP_from_DHCP_when_unit_testing?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231014204805.439009-18-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
 <20231014204805.439009-18-seanga2@gmail.com>
Message-ID: <1365B46D-6CCA-4064-ABC1-97CF581564C7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cLKCXUvRnNaQGOaNUjLA+kugFxg/pkQZ4XT6qnx5WptjWqfFTLc
 M0TbqMmM//F5dhchN3EYnH6s6EG2ZFLF6prO0ci/E4rcvPkBW3uRpKVGIh76ZciJ6gVWUIk
 VwlqGANx4oYHKQH5WEksi1mfwMWsNl1+sagIGhObvLQklNfHsjUSI2NbdNnDlXu5HM2dTow
 VrifqIddDj9BLajOvF5Cw==
UI-OutboundReport: notjunk:1;M01:P0:ZH+A1Rg8Ij0=;rosyWi60RROaUj11BfeuGJI1CMn
 XYvfKlit4IyBc5w4YGZeU4o1/XDkPNnzOkgY2g9XPaRajo4mBvuS/PoUfy/Ugdo3c0XdZT9Fn
 v+yKDCwQnPxAsMC3rfMBUvmyI/IeKZZrHbtQCigYStATm+4REsiOZKnorlWtrE1gnaO+nxK5o
 ENwEts11w0bQQDRZk6GMYiveHbZXtqtIN1jTNQ9c/bf1P3AwYQ6Jk2KUJ+Wu0yoBlpS6cDpuo
 kePOQsgII1UqTZ1ibczwj6JC0ylTEw3HGpSnRu8CxbWhlD8U329xdtR/LXID7iMkL6a1OBnvu
 ILjPBJRBqUkvZo29fGUaDp4Ikdr0pcXl9rnG9PT3guSgRyEJtKpmD1UyRmjC+ObTIGkU6xMqm
 1HcI7D5uPRvBiYQLaop1JASF3z8hx6LvFt6Mq2XG2HE72yOGa6r+9N9LElHokDhiuvhuQ8xVI
 rd29+cO/+m4MRxkC5FQ8AAtSlS+IaLIFWp8u+nDu9fLu2IBAUVgBgj7ao03MRrKiy33V+UcUv
 dGe37IjWXxTRr9olP/dKviuPJFWuAeeUQDmniizzVglpiUP80xjxvGhKDVkGBRVl4hYXDtNBK
 9X2T7+ynVzFka04Zz0CbPKOySxXrMEBoO6iZutLIVttJSL1BoSbMsSf7U8sfBqmuCIdL+nrm0
 s0IH1S2dgPV3fAXzdx5Uil2Jci5MWky1tKWpOSDzOYaJQ0lkLlittiY62zluEdxHCTtaBLPKh
 LifU7r+yx8ckOE2HeMJAMPM4nTLFq1uAXd7WX+VXXr/IAsLlr+w++iFcI4DfUrGYxULI5plq7
 /ELQZWBmG0mjKcPo0PrgR9M6givKZk/nLE08tZleySX6zd+me/FMyhO4H5UvbGnM26ffDkYKi
 exfTBEj/pu1yzl4wv/eDIlGYX0wS+mE/qbNjJayHdVfoQBdGqESk08kXzoZA7/z4Z2NZsU5gq
 wHE3GTR/isW7gHrlOoRZaN3vNUw=
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



Am 14=2E Oktober 2023 22:47:53 MESZ schrieb Sean Anderson <seanga2@gmail=
=2Ecom>:
>If we sent a DHCP packet and get a BOOTP response from the server, we
>shouldn't try to send a DHCPREQUEST packet, since it won't be DHCPACKed=
=2E
>Transition straight to BIND=2E This is only enabled for UNIT_TEST to avoi=
d
>bloat, since I suspect the number of BOOTP servers in the wild is
>vanishingly small=2E
>
>Signed-off-by: Sean Anderson <seanga2@gmail=2Ecom>
>Reviewed-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
>(no changes since v1)
>
> net/bootp=2Ec | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/net/bootp=2Ec b/net/bootp=2Ec
>index 2053cce88c6=2E=2E7b0f45e18a9 100644
>--- a/net/bootp=2Ec
>+++ b/net/bootp=2Ec
>@@ -1073,6 +1073,11 @@ static void dhcp_handler(uchar *pkt, unsigned dest=
, struct in_addr sip,
> 			    CONFIG_SYS_BOOTFILE_PREFIX,
> 			    strlen(CONFIG_SYS_BOOTFILE_PREFIX)) =3D=3D 0) {
> #endif	/* CONFIG_SYS_BOOTFILE_PREFIX */
>+			if (CONFIG_IS_ENABLED(UNIT_TEST) &&
>+			    dhcp_message_type((u8 *)bp->bp_vend) =3D=3D -1) {

As written before, please, do not add unit test specific code paths=2E

Best regards

Heinrich

>+				debug("got BOOTP response; transitioning to BOUND\n");
>+				goto dhcp_got_bootp;
>+			}
> 			dhcp_packet_process_options(bp);
> 			if (CONFIG_IS_ENABLED(EFI_LOADER) &&
> 			    IS_ENABLED(CONFIG_NETDEVICES))
>@@ -1099,6 +1104,7 @@ static void dhcp_handler(uchar *pkt, unsigned dest,=
 struct in_addr sip,
> 		debug("DHCP State: REQUESTING\n");
>=20
> 		if (dhcp_message_type((u8 *)bp->bp_vend) =3D=3D DHCP_ACK) {
>+dhcp_got_bootp:
> 			dhcp_packet_process_options(bp);
> 			/* Store net params from reply */
> 			store_net_params(bp);
