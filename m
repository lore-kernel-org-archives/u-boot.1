Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84238CD98CC
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 00:49:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E8EA8484C;
	Fri, 12 Jun 2026 02:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="d5qOQP6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCDCB84704; Fri, 12 Jun 2026 02:34:02 +0200 (CEST)
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBAC5838BB
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 02:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anoduck@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1781224440; x=1781483640;
 bh=z0d+YWgizzoW4NozsSpYtkNzyuzxBODVZqUOj48SPig=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=d5qOQP6dGVj52CEJDMbHOhSKBIbF6SVQ6EWxLVQ+y//7YgKN7qHNonp2d8oPiDqT2
 24EgVI4WWJ9fa5RkcxW6HGg4do4f0XVjg8KxBOr9VRR6ncdsQuPblZFHM2UrwNeJ7x
 xIQ8RYjAPJj/QCUb/caEk19vQ7IT/x5zLqNRKQ5spFsPWy0aeMdvvUoUjNTGYrznID
 6ggMvDqdjeM0eacdUk3jSJsIP7zAqKka9CLCYodHzJ2qzBc0I+kjYQVizoEGsUOb1B
 o2QxyvLK2PN2e6ks3Svi0TcAd5j9ms4SfBKL7SDpyJp7iIeaseJp/RTipPZR3YbdeO
 Mpjhy0xllQuPg==
Date: Fri, 12 Jun 2026 00:33:55 +0000
To: u-boot@lists.denx.de
From: anoduck@protonmail.com
Cc: anoduck <9925396+anoduck@users.noreply.github.com>
Subject: [PATCH 2/2] refactor: commented out changes to pinetab-v dts file
Message-ID: <20260612003330.220595-2-anoduck@protonmail.com>
In-Reply-To: <20260612003330.220595-1-anoduck@protonmail.com>
References: <20260612003330.220595-1-anoduck@protonmail.com>
Feedback-ID: 3493375:user:proton
X-Pm-Message-ID: 1b8fd9a75c73a724db39233c139c5102389a9a07
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 12 Jun 2026 02:48:57 +0200
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

From: anoduck <9925396+anoduck@users.noreply.github.com>

Commented out changes to pinetab-v dts file.
---
 .../jh7110-starfive-visionfive-2-pinetab-v.dts        | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-p=
inetab-v.dts b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2=
-pinetab-v.dts
index d7ef053a83a..bbf42aa5063 100644
--- a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-pinetab-=
v.dts
+++ b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-pinetab-=
v.dts
@@ -10,14 +10,3 @@
 =09model =3D "Pine64 Pinetab-V";
 =09compatible =3D "pine64,pinetab-v", "starfive,jh7110";
 };
-
-// &sd-vcc {
-//         compatible =3D "regulator-fixed";
-//         regulator-name =3D "sd_vcc";
-//         regulator-min-microvolt =3D <3300000>;
-//         regulator-max-microvolt =3D <3300000>;
-//         gpio =3D <&sysgpio 35 GPIO_ACTIVE_LOW>;
-//         enable-active-low;
-//         regulator-boot-on;
-//         regulator-always-on;
-// };
--=20
2.53.0


