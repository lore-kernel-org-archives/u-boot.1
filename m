Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70971606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0cT3LzV5;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=mg+bnyYs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1280F60768;
	Wed,  4 Nov 2026 09:13:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dsdeKH-iL5Q1; Wed,  4 Nov 2026 09:13:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E82A6606DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793783632;
	b=tEyVfUlnKLdp++mvu2fn20eypAXceGGc4C9uSezjqYhm2fBRGE7JgXYDghDfRHVmsgAP
	 Ejq/piM+jSGrp52L7jH/j4IqhUwcn+wGBBflZ6hgn8g7zSHmkBd0qn4TkCUnIorPhEDCQ
	 f2w0coAiX7Wv5duxsjI+5PBYhfE61OWhhDIt69kQWKB8YvhX/m+PrIiK2s/+TcxHq66dE
	 tByEGFtH59OWbZtS2BMmyywImpp2a4Ejg/c2Mw84yI6vrNVislbN5Y3FWlzff/vsupb5/
	 34NWGT5OIg2jGY57dqENN/B67Eu9MrA+a/LKdAd6lnTZL8Y403U1IlHN4VqTOoT06Gw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793783632;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-Rspamd-Queue-Id:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NJCCSInZWsarf9WxT6gCAHwJyZm//jme/FDfWzvHjeQ=;
	b=XBoC1D9Ts+jygnl0p1ANmXMXY/2gMCXRCYBcm6MKGZ+Ghm51IKQzlh3/wzv8Y0FPAGsx
	 awGIPSXP1OsvzSGZwKTAhojlL0eaZq4w7V0Bbs0ytD/Rrm3y4E02qJA7hgWEfUSa13DyJ
	 9BD7MTnq5tdm3/iRgZU9ZejhDVRXA42cx5L3rGPu3xY/2Ug4rUzxjijkBwOghLZwV6LzO
	 MyjSAiJl2G5lZdF6cFNZ/YUMEAPQnaOuMNlm1gVs+oV25TSk+PfijossozCUXGwsMnqC8
	 oIAAFlDvvEzI1mJJxw9+RT46o2HjTeIs3cKysVkP09+K14W0nM4/ROlLHADZpGDI6tw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793783632;
	bh=NJCCSInZWsarf9WxT6gCAHwJyZm//jme/FDfWzvHjeQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0cT3LzV59B2ol96kUqi+j6CwGfRmM+JMrL3rtB6mzoDx+nKFUE88vQFVZ4bK2sd72
	 m4vNkz6jFtAxFA5pyGwtCvoxU30VN1HkWd5qkWY/2w+fly3CsdOHKu94W1/Mrp7OW7
	 F2Ybvkdkn3OcMxomGO84ctm8Hjy/btuycdZAXs1ZE9gXWDPsfKHKdZq9R5XNky8+2T
	 /A2JJ9PkDmc+hz6tO2YG9Oc0ahCzaljm75MeEaBuLKKNrs84CetMvfnO8qkjs2HzFO
	 g8wvqOjwIVIanbxCrhvSJ5k6hSVbxIvYWPGalLRPYgsARqsbzPYWY/F3oVGMKhszww
	 ohCYxWPcvmj/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E82A6606DE;
	Wed,  4 Nov 2026 09:13:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 38A6D932
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:13:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E2F840726
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 257hv8BzmlVa for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:13:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8DB68405F4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793783629;
 b=VhuqCIVa+AFlWSuTi5gFWsH2Ax6baL+he9PWJ+2TTJfoY9XURPmZ3y0OsiATbeh24NE2
 OYVd2lcKhfE7w4KydHLhu3kc4XSg295TtLX8zBj8s+8fqi3q/xQNy3GYtnfdZEECNQhWG
 OpkgfhYQXCO6FrNWGz8nNpdMOZILXGZyRzKZlh6w2jBA/crGdP1MPDa0G2R3Xq2B1AHlj
 kl0c/H5SToobnDrWbKVUO1/BGuNgRFuCu0XPusRslIKDI7KEH/bMxxTCfKr+YRg9DcRh6
 mPpvECrpxPWObq8ZGwku6/H65hqh7mV4HO+zI+gN5DJv3C8maft+Xi5x9fqn5dH4YiA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793783629;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 User-Agent:MIME-Version:X-Rspamd-Queue-Id;
 bh=NJCCSInZWsarf9WxT6gCAHwJyZm//jme/FDfWzvHjeQ=;
 b=GgQ9maqhnhp+seZtR5e4oD6jnMJG5+aX7Zo6t7OXPbpRZsxaetpf5AeepEBzTQSPAOGC
 xbpQkJLGfUyIPETAeApX2vfD8am28VR4KpqgoyxGSwEN/ZpTIHpaD0rQG5ndWEz64OtOK
 FHas+/uaPkx8yQNHvT7czzSbvuoIBzMz4TD4BJJmYVl7humfLI8D2AOj8qTcPZ7e9s8Tp
 IAzTUgXfhSvQbaT88GMCMz9a1/0jcmIwUTLp37zoe5Q1iiI6dHO61sAkViiAXZkAW5yX0
 T1CniWHl5nlw80QiAXZkX7BSvDpL39FvqlKvxx5AbYfySwl5zsb+o8Se2whRG7ArlCA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=steffen.cc;
 dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=mg+bnyYs; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=mg+bnyYs
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DB68405F4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:13:47 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jKKL54g3vzKsmn;
 Wed, 04 Nov 2026 10:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1793783165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NJCCSInZWsarf9WxT6gCAHwJyZm//jme/FDfWzvHjeQ=;
 b=mg+bnyYsaFULZtSTYdI1iWNyprKeBAS2Jo30x/RGUFQQI/VIO0A2N/CSWFGBahoDEnPba1
 kp9wjoYdVr3gbvahDXQR0vux+Pb85t5JjWh5lXPOFUT3/CUVp/M7DpGBrJZC7zUXkJaD7S
 x5nuuX3abSCQo3zXmpWVpR3t9etcpZLPcu5prpgxG8BsvcfsMV+zBznyypvi/p2YiMcyOO
 XY7cDL3/AZoz1bAcofzC09/qlFisLTa6HEe81gPUd+4URgdUjr6NFbe/a0BFWgaGrvc/Tu
 Psg7cyOvbHOULr6JLcN3oZUItDmdVucnY49iG7+0vwEtakXtZKf+86TCe5HuSg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=lists@steffen.cc
Message-ID: <fa976a04821fac42c0a937305e621c4da20fc04a.camel@dirkwinkel.cc>
Subject: Re: [PATCH 0/2] mediatek: mt8189: apply the DRAM description from
 the bloblist
From: Steffen Dirkwinkel <lists@steffen.cc>
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Macpaul Lin <macpaul.lin@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream	
 <GSS_MTK_Uboot_upstream@mediatek.com>, Julien Stephan
 <jstephan@baylibre.com>,  Carlo Caione <ccaione@baylibre.com>
Date: Wed, 04 Nov 2026 10:06:01 +0100
In-Reply-To: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jKKL54g3vzKsmn
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

On Fri, 2026-10-23 at 17:32 -0500, David Lechner wrote:
> On the Genio 520 and 720 EVKs (MT8189), the DRAM size and some memory
> reserved for the DRAM controller depend on the DRAM fitted to the board.
> The devicetree built into U-Boot can't describe them, but the boot stage
> which initializes the DRAM has this information.

I also looked into this a while ago and found some code in coreboot reading
EMI_CONA/EMI_CONH on mediatek socs [1]. I adapted it to mt8188 and tested w=
ith
some memory sizes (at least 2GB, 4GB and 8GB work).

If you're not set on passing it from TF-A I would send a patch for this (on=
ly
tested on mt8188 so far, see rough patch below).

[1]https://github.com/coreboot/coreboot/blob/main/src/vendorcode/mediatek/m=
t8195/dramc/emi.c#L670

+#define MT8188_EMI_BASE                        0x10219000
+#define MT8188_SUB_EMI_BASE            0x1021d000
+
+#define EMI_CONA                       0x000
+#define EMI_CONA_CHANNELS              GENMASK(9, 8)
+#define EMI_CONA_DUAL_RANK             GENMASK(17, 16)
+#define EMI_CONH                       0x038
+#define EMI_CONH_RANK_SIZE_SHIFT(ch, rank)     (16 + (ch) * 8 + (rank) * 4=
)
+#define EMI_CONH_RANK_SIZE_MASK                GENMASK(3, 0)
+#define EMI_RANK_SIZE_UNIT             SZ_256M
+
+static phys_size_t mt8188_emi_dram_size(void)
+{
+       u32 cona =3D readl(MT8188_EMI_BASE + EMI_CONA);
+       u32 conh =3D readl(MT8188_EMI_BASE + EMI_CONH);
+       int channels =3D 1 << FIELD_GET(EMI_CONA_CHANNELS, cona);
+       int ranks =3D (cona & EMI_CONA_DUAL_RANK) ? 2 : 1;
+       int quad_ch_ratio;
+       phys_size_t size =3D 0;
+       int ch, rank;
+
+       if (readl(MT8188_SUB_EMI_BASE + EMI_CONA))
+               channels *=3D 2;
+       quad_ch_ratio =3D channels =3D=3D 4 ? 2 : 1;
+
+       for (ch =3D 0; ch < min(channels, 2); ch++) {
+               for (rank =3D 0; rank < ranks; rank++) {
+                       u32 nibble =3D conh >> EMI_CONH_RANK_SIZE_SHIFT(ch,=
 rank);
+
+                       size +=3D (phys_size_t)(nibble & EMI_CONH_RANK_SIZE=
_MASK)
*
+                               quad_ch_ratio * EMI_RANK_SIZE_UNIT;
+               }
+       }
+
+       log_debug("DRAM: EMI_CONA %08x EMI_CONH %08x: %d channels, %d ranks=
,
%llu MiB\n",
+                 cona, conh, channels, ranks, (u64)size >> 20);
+
+       return size;
+}


Best regards,
Steffen Dirkwinkel



>=20
> That boot stage can describe them with a devicetree overlay in a
> Firmware Handoff transfer list: a memory node with the DRAM size and a
> no-map reserved-memory node for each reserved region. U-Boot already
> applies such overlays, but only when the transfer list also contains
> the devicetree of U-Boot itself.
>=20
> The first patch makes U-Boot apply the overlays to the devicetree it
> found by other means as well, so that the earlier boot stage only has to
> pass the DRAM information. The second patch enables bloblist support for
> MT8189.
>=20
> The first patch only changes behavior when a transfer list contains
> overlays but no devicetree. As far as I can tell, no board does that
> today.
>=20
> Tested with TF-A BL2 passing the overlay on a Genio 720 EVK (8 GiB).
> U-Boot reports the DRAM size from the overlay and its devicetree
> contains the reserved regions. Without a transfer list, U-Boot uses its
> devicetree as before.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (2):
>       fdtdec: apply bloblist DT overlays to the built-in devicetree
>       configs: mt8189: enable bloblist support
>=20
>  configs/mt8189.config              |  1 +
>  doc/develop/devicetree/control.rst |  5 ++++-
>  lib/fdtdec.c                       | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+), 1 deletion(-)
> ---
> base-commit: 283ed6f2477b02a74f1e39c1225bafa8332f8109
> base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-mediat=
ek.git mediatek-staging
> change-id: 20261013-mtk-mt8189-tfa-fdt-94283317c6c0
>=20
> Best regards,
> -- =20
> David Lechner <dlechner@baylibre.com>
