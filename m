Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7E6CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 12:33:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92907607D8;
	Tue,  6 Oct 2026 12:33:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vsOjEBu25D_g; Tue,  6 Oct 2026 12:33:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DCA0A607D1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791290031;
	b=cklalYkQg/IdqJA0emrvY/UuASotZ2cqwCxWJrnalIytqIt4u6Iilyhsb3szsDd0rvmT
	 LNFI0cT6RqM3Gb4GTSB+X8Vjn/sPJJkDTnQYYkf8FKiMwvtlwBFMnET7BTWVFGquzCaI/
	 6RjRDkE9duw2/PA7/S7V+wVjsfznhEt2OMPMZi1qvZT870KC6+nDJjjL5J8bE143zh1ft
	 Q1+o+PHefVJn4QEhyruKf/AyIkmHvLkYM1Fz5FZYoIYVXJzrA7qBqTmNyUrNMGKZX9oF7
	 /BKdWA1jevcI/fMhxWDfGCKr5Sgd7JuMtLuqwjwnyVt78QgCvBl3dn56gJADM9bA0Mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791290031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6IjpGDHkDH+NXj5YJibj7KErEhTHKV/FQevHWlIllbM=;
	b=YAfQvT64qyzfYUGbALvfC1BpLDQLj+7ISgzzuK0eeY+6SqyfaIxsEAzg+qVfjDuzgues
	 ZLkqqhlF427p8fOJt0i5YYSjcDHEvtvcB2PTC8Eckt2IhdfhTUQ4e8bDM1HuR79zP9Z0G
	 CoGAFMNaoWW9cUyOLT3jsy6W98qkvp1EGKgEFOacrKLr1OKXX8aCsuFXkjymRFWlMXkNs
	 EHsGJy1x/zv2ILTUMyYd/Ya5T/uf0/tLJiYDdymRZZK2yIZBKFCncH8OeksxZhvVDCwRT
	 2WBn0sW7xyA3rWz/v/uN/sEScMHBWy9KDmObd9yI6dZ4SzKlu9AIcSebR5yykM/5mTg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791290031;
	bh=6IjpGDHkDH+NXj5YJibj7KErEhTHKV/FQevHWlIllbM=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cOeF1LJ6wFEH8r9NGBPuT+uwQG9xu5C/g1jIIX73qnnm1Ob/4D6o6JSgOuWKFpZVw
	 r8fXv2RIwNWymv5W7Ax6dL4Z8QN8AzFk3PmSHyYT7bo5EoGPuJ9D7jtSDGaWB/EVXl
	 mnNW3lcivT71u/mj85cE2tTzVPrtcJhPEyVN6/YKukaaZRLsKtzFNZdXVtUURJHmsV
	 JMokMCAPCwcQK6H9yv23QBababEypYIJGnqu8EQm4QHLfOzzQycDAfHfAYtFNjd3De
	 +2E2YkFVf7M9cxCJuvNWJEbwDMBMIz+V3UZAOuTmoy2AwNXwzrMN+0GR1t7kkBFekH
	 Isx7wA2iklR/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DCA0A607D1;
	Tue,  6 Oct 2026 12:33:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DF34282
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 12:32:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42DDB80965
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 12:32:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JCF04vBU02jJ for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 12:32:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 82878808A6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791289946;
 b=k/AfP6fZFUW9KHfW2Ew3+NEuHCVs/JRkCRtYiwAuHFhPTNI+k2GggGTcYk6yvDsqVGsf
 8OFCkPZihymnkV7d9PiuCNFiR4VO69NIoFdYu65E1F9IgCigRPjA+HLI6U2RMUMU7ryc0
 PN1Sbx5gMNYzjUh5qhHHN0ivJ/c3lvVedst80/RExRpJmtSrxS8IBHIkgdn9NXHP/SS2y
 fRCrGR2/XRJ4rHSxlQnvokbzjVujkqX1uoWPJH/6HyWz5kfWC1eHbj3myEFayImWLWutm
 TvWferN8W5cZgdSJ/nLCzmKwrqO41aXakjAH5g3z0SXKvf5sdIwIUlNM2c8DgB3Y0MQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791289946;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=6IjpGDHkDH+NXj5YJibj7KErEhTHKV/FQevHWlIllbM=;
 b=NEFiCS+oEeZo2R2YX/Xmw5nmqBmB51IcYJw31YTlNElENdDpph5aUJbSNmxu9KBT4gYl
 pA0vvBodEQvmKgdKwTcp+3yz2OloYefZedG9J6okZi69sJ2YUPWdvoXlqfxiNBXP+bn7d
 XNDmoNCD6CTI8y8Ii0IbJ4nluWGbp+qAhvjn+vq94lJ4kPlhmgps2Rh1nTKZ03P4adYGs
 Nyisgbx0xMAbTcYI7EDiQmplM3353FS7BiloZMOikNA78KFHkkG9CYJV8SUquPUD5RJUN
 AB5PIrd5+ngDNAI0di9EmJHwC9Mv46yMgAx6oTZGIx/HU8ZSCaXY1I/bAg+MEDL6UPA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=rfplUzI8; 
 arc=none smtp.remote-ip=109.224.244.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.18;
 helo=mail-24418.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=rfplUzI8
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 82878808A6
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791289944; x=1791549144;
 bh=6IjpGDHkDH+NXj5YJibj7KErEhTHKV/FQevHWlIllbM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=rfplUzI8OovHl5iDyUCy2rYp2OS31C5eg5Y2z3bdI/C2V4CUOVxvQApWM/zSDjJgQ
 5Ar7k231n3IvZ+7oKXDAorMOv9ytLPCwjQb9+8LdzuFz2CbYm56LX//4tytwhAAo9V
 E0t2UfUVFpq5rqhFD1U/RTfZYU/TRiN22vgnP1fl/W7dR/Cwdn/VZJLq3i9CeZWA3K
 EIuVRi8yzfD7ohf4mnGPE2+YomIPuqLV+p0Rn6NTvbt8tWEpg1ZXw2Zzp++1woZMe1
 cdYpg/cpelOyYssAvnrUn+/3r1w/Q+rxjltwC/z12UkaaOOPegyPQau+HhVVq1xHC7
 33ORjzRk4mmXQ==
Date: Tue, 06 Oct 2026 12:32:17 +0000
To: Yixun Lan <dlan@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH v2 2/2] usb: dwc3: generic: add SpacemiT K1 support
Message-ID: <20261006T020608-0400.uboot-k1-usb-v2-0002.DaveWK225@protonmail.com>
In-Reply-To: <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
References: <20261006T002406-0400.uboot-k1-usb-cover.DaveWK225@protonmail.com>
 <20261006T020608-0400.uboot-k1-usb-v2-cover.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 16b5a68c4a63eada8f11e3a7b3a9a646a235b5b0
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

Use the existing flat-node callback through rk_ops so that the generic
wrapper binds its host or peripheral child to the same node.

The generic glue handles the K1 controller clocks, resets and USB 3 PHY,
while the child uses the existing generic DWC3 host/peripheral path.

Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generi=
c.c
index 2356b3bc0a..cae627b587 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -724,6 +724,7 @@ static const struct udevice_id dwc3_glue_ids[] =3D {
 =09{ .compatible =3D "rockchip,rk3568-dwc3", .data =3D (ulong)&rk_ops },
 =09{ .compatible =3D "rockchip,rk3576-dwc3", .data =3D (ulong)&rk_ops },
 =09{ .compatible =3D "rockchip,rk3588-dwc3", .data =3D (ulong)&rk_ops },
+=09{ .compatible =3D "spacemit,k1-dwc3", .data =3D (ulong)&rk_ops },
 =09{ .compatible =3D "qcom,dwc3", .data =3D (ulong)&qcom_ops },
 =09{ .compatible =3D "qcom,snps-dwc3", .data =3D (ulong)&qcom_flat_dt_ops =
},
 =09{ .compatible =3D "fsl,imx8mp-dwc3", .data =3D (ulong)&imx8mp_ops },

