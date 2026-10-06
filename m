Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230C0CA5FFE
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 05:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3F2840508;
	Tue,  6 Oct 2026 05:34:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t8yP8ksfUdBP; Tue,  6 Oct 2026 05:34:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E9D8040506
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791264865;
	b=FL4km8o4yRgNWki1G1C2TCyqVdZzMSy85yGeN5Fl1OHh1fvyRUJBZCOc7SNjuI+tGxJs
	 0LB5T7b7nNoiSZUuh/7ag5gwXnmmQWxiuFRZg9JaUD1L5jwoiwwZuHfaAvtQmH8WrvUTE
	 mYL2fbmM0I/QuoEq4q5tuziqWfGX5G9K+LRkFmST9inp4pIC7HHclJa9SqtxolyNzzROy
	 PvQ3HKaIBCOE3t9CEXwHfdxCkpPBJc3lDbXmOfDNCyla0R66PFKjrTMKS70WTmdVb30cp
	 Zx1jEDvs/FHeVwMFdIlzz2WcK4VazTkrHTXBxGOeuC67QyRC5EWtZplCaTy5skY8gqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791264865;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3h1jqAcA41xfjlnx/lTE3g65nZpOR6xIKNaeaxeaHmM=;
	b=oxzCrDbswIZ1SS3716Xv7FcgAq5dgG/zwuMYUYztU2cT3f2NbK8L4tsG5hC2spho0Jca
	 l0yCdJdykxfFAumdoJk/ZDxmqmPt/yZkzltW9NBkjVWAOLKSH2EpsKENLVRQxUTlp/ao/
	 3fsEDqRNMp8mrvL8vRxUKfx1l4jwLnsAOfaLUtDFIz95VTYBlDf+4p4WhD2z4z/Le9rUs
	 98DwSh7wiehIRb6Vo+rh0lQQa8WAiJ5bXroDg1hITB/VeC4v4NGdD6IJtoYSoc3sbenLC
	 QzrRauA0QRftXuAiEYZmxEgSL+njJLiWylgt06qz3iMC8fW/F7duvS4Qg2nepJc5bgA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=tFuJiqFn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791264865;
	bh=3h1jqAcA41xfjlnx/lTE3g65nZpOR6xIKNaeaxeaHmM=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OLHxGmltUsUVzGaXZkJmujU89/SDDzioPFtteB85JNHM6dsPBSvEMctx01X7CC4g7
	 d0sxE//kMzplCAZK8QVEGk3KvkVGZcL+puC1BEIjbXAWadA/YK9XZmtRJ6ui8SLc6E
	 ZVoZq+93eQSJlW5adRCg0+gIuiRh3l6Q4R+RzhagZLbmpvdF8of0MiTiE+0Q0QSP2j
	 Jqda7eMHaCETjqqSvJvm3+ghPPDwCrTHB4zJYMP/B1KR4fKI4m6dfxWIz77DG6EMak
	 unEPMCJCCylSbugu1tzj8d6GRQ1hYwLLpVKoIjSx9kZrNEuFoLPc7Fo67K7lx4f/Q5
	 hbZoFFcaIot2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9D8040506;
	Tue,  6 Oct 2026 05:34:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E88634E
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 04:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 54C884053C
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 04:29:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SA9iSLAWGdYk for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 04:29:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2CADA40538
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791260944;
 b=mySYDr96AYG7RjwvcVL0EQM4lBxHoyZSCjkoHUdJICA6vq3W0ZJjud0jwO3yFLQC4kT7
 JQagCfx+lXr1G6AAELDwyGczrU5H7BnFjiLD03I7pr41bF8n5Rbw6kBKoFsvRfKZ2LfZe
 +HLsIQ93jyMdAtg3aEEJ9pxRCYUVJ86Mheh7X9MOFzr0UR7Qchkaj0fdJmH9QWzf4oZIM
 ONZysoS7fED/0lmOlykG42pwHtVCtq0ouZyK+D5U9IGLVxuw0x3AohjcvSaxjDi/RMnTG
 4tOcqbQp8vOjK9fz67n07msT4g553vRxIUNGCc8L77poWvnaJNhZ9gHDEuoBTA9rZ4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791260944;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=3h1jqAcA41xfjlnx/lTE3g65nZpOR6xIKNaeaxeaHmM=;
 b=cSM/nCqTSoJh32XGJX3COheNkPFYS8FqJNVfK3VV6e3u6ss6Ox92CtcbCBqCvB0OQfaB
 MpBznx07UUY74zWmDDmXvZDSv97bL6rvweAaMrKnNLT6ZpVg6w7Q4HPPnBFNZkODVl0AG
 M3gqrjp3+qfdAlfEB9HXeQN5cxzHDPJ0o+CBW72g6v0blzly6VWVXZjYTnGwCVkX/UpGW
 D9IDsRxRrEqdwgGQuo8CWz66Kxr5pViI74LaKp3IZwyeFjhgewE4JNBzeXRxgKsosc51Q
 fGI2PJQjh06JEZsIZ/GY9r8D24MWR7Tf+N1MqAUI55uJ2H3s7fgzswtrK2I5e0V8qNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=tFuJiqFn; 
 arc=none smtp.remote-ip=185.70.43.22
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.22;
 helo=mail-4322.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=tFuJiqFn
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2CADA40538
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 04:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791260939; x=1791520139;
 bh=3h1jqAcA41xfjlnx/lTE3g65nZpOR6xIKNaeaxeaHmM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=tFuJiqFnxkKS0NhN/itL5Cm7atj4vKbd4RyAootEknxnygmUXCY0EBbdmv9f2WMEO
 WzmOpUzuP7LgdXFtMIczqnT2mQWd/lzmPHCWTr8/A5ZYLCfcQgcOz65iFA2dsxo6Mc
 1UwmchuK8CKDTPZF/DsWrcTZ2i99KQ3V6mDtAyEr6beOw+UKPa/nbY4GJP9ezoBR/t
 DNMFsl09gsf9LLPaFPABRcz/Ywm/itt5FlGfUL7J3vJtnqprrAjBnEgB69UsLP1nGP
 T8rzIW/W05C9XwYYM0foZQxfwflj3suprpNeaSXC7+JQqqejThTvZSIpa93+dz6O9A
 PvqR0ZUu+F4Gg==
Date: Tue, 06 Oct 2026 04:28:55 +0000
To: Yixun Lan <dlan@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH 2/2] usb: dwc3: generic: add SpacemiT K1 support
Message-ID: <20261006T002406-0400.uboot-k1-usb-0002.DaveWK225@protonmail.com>
In-Reply-To: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 63c98aa250942bab7d2ac552087aa7bab49d332c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The K1 describes its DWC3 controller as one flat device-tree node with
the controller registers, clocks, resets and PHYs. It has no separate
wrapper registers or controller subnode.

Use the existing flat-node callback so that the generic wrapper binds
its host or peripheral child to the same node. Rename the Rockchip
flat-node ops to reflect that the callback is shared; keep the existing
Rockchip matches on the same callback.

The generic glue handles the K1 controller clocks, resets and USB 3 PHY,
while the child uses the existing generic DWC3 host/peripheral path.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generi=
c.c
index 2356b3bc0a..489bc8347a 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -515,7 +515,7 @@ static const struct dwc3_glue_ops qcom_flat_dt_ops =3D =
{
 =09.glue_get_ctrl_dev =3D dwc3_flat_dt_get_ctrl_dev,
 };
=20
-static const struct dwc3_glue_ops rk_ops =3D {
+static const struct dwc3_glue_ops flat_dt_ops =3D {
 =09.glue_get_ctrl_dev =3D dwc3_flat_dt_get_ctrl_dev,
 };
=20
@@ -718,12 +718,13 @@ static const struct udevice_id dwc3_glue_ids[] =3D {
 =09{ .compatible =3D "ti,dwc3", .data =3D (ulong)&ti_ops },
 =09{ .compatible =3D "ti,am437x-dwc3", .data =3D (ulong)&ti_ops },
 =09{ .compatible =3D "ti,am654-dwc3" },
-=09{ .compatible =3D "rockchip,rk3328-dwc3", .data =3D (ulong)&rk_ops },
+=09{ .compatible =3D "rockchip,rk3328-dwc3", .data =3D (ulong)&flat_dt_ops=
 },
 =09{ .compatible =3D "rockchip,rk3399-dwc3" },
-=09{ .compatible =3D "rockchip,rk3528-dwc3", .data =3D (ulong)&rk_ops },
-=09{ .compatible =3D "rockchip,rk3568-dwc3", .data =3D (ulong)&rk_ops },
-=09{ .compatible =3D "rockchip,rk3576-dwc3", .data =3D (ulong)&rk_ops },
-=09{ .compatible =3D "rockchip,rk3588-dwc3", .data =3D (ulong)&rk_ops },
+=09{ .compatible =3D "rockchip,rk3528-dwc3", .data =3D (ulong)&flat_dt_ops=
 },
+=09{ .compatible =3D "rockchip,rk3568-dwc3", .data =3D (ulong)&flat_dt_ops=
 },
+=09{ .compatible =3D "rockchip,rk3576-dwc3", .data =3D (ulong)&flat_dt_ops=
 },
+=09{ .compatible =3D "rockchip,rk3588-dwc3", .data =3D (ulong)&flat_dt_ops=
 },
+=09{ .compatible =3D "spacemit,k1-dwc3", .data =3D (ulong)&flat_dt_ops },
 =09{ .compatible =3D "qcom,dwc3", .data =3D (ulong)&qcom_ops },
 =09{ .compatible =3D "qcom,snps-dwc3", .data =3D (ulong)&qcom_flat_dt_ops =
},
 =09{ .compatible =3D "fsl,imx8mp-dwc3", .data =3D (ulong)&imx8mp_ops },

