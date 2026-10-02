Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AB2CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 14:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 119C581317;
	Fri,  2 Oct 2026 14:01:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cqxls7UL7i0C; Fri,  2 Oct 2026 14:01:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8D0DD81303
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790949678;
	b=PNbG2TmWNYAKI/+7BJEhssm/qkcI3ndMyqQxbcQBmKZ+MzORJkejmvwUVtaTF//+uBxo
	 9nEuvYQWuSVwoMu23PTFh3mhB6HIFuyqsNwUg3L98hinsw1eNwDBiDwH5W4id73ViCogl
	 nfR99dUCVvn9uAh7i0g+rgQrx6Re7tpqnxzp1pZeP/REhjrde2L88UYrTiZerB+eJm7JD
	 XcfFGapglpM2L18sFoYDkgdZnVF9UVCazCBWn3kMrZIOtOOdEOSR+ZBI9+KM4TLuQ7mxk
	 P1Z72WobYcjbirZF30hwsq2iKZAqiBHA42JJgPikMM2/CsO7a0mE2DHBn2LawpFVviQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790949678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K6IquK68HlCusO6ZINh0VS2i3GbV4UymBUE9LxnySz0=;
	b=EiHV4owFfxT/VLzrBEMMf0YNfUHZmTX4cUQm/dtNUvmAu9wfQtyqUoWI10whH9D+ja/J
	 56hQpTDaaxa09/PfSqs90I0zQqSDHtewiqYIRPPFBbsFvYj81G/OB7uUs/mWb78hCnMgJ
	 nEIdNoAoE/hm9Nl4Hp3+d4+Bqc0QI+7Pqym+R+/2N5Z2fcpbdWOHA932svZV/QyN+peKF
	 hMmWobLmHkvusyCScslg/qV6f6NsJXddaSqjfGr0rg4ZrJmdneIBqZbXpGt/cpJH6xajP
	 OAi+8MWdduIBK14cmcSbKiIxQCnmjiE4UVKFqbgwE9RgCvK+bCsi/xCaXhm7JXi4gDg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790949678;
	bh=K6IquK68HlCusO6ZINh0VS2i3GbV4UymBUE9LxnySz0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QHwAk8xNw99AkfsmQjlCpyA2iC1eXqXs6bJHaGEIaYGDvvT9A65Wzm132IT8hzLA5
	 mlbQcU1xH+q3mqgnsh6S9uv+CsETZ2kq99Gn+1dI7bIdcXiyzvAyQlsPHP4/nooOSX
	 7axNpmjbdaTTqTrul7i4FcigKZXkUeJCFd2AxeI5Es1uIhIN+tfc3YWHkERMFAVOxY
	 FceDJa7y5ZkGoTRyWqRMzQfmdd88SIsg6ThTXSppME9gcuqBqL7KmhcEnjDVGbDXzY
	 EEooCHsxqKSlUrnZ1Own/ldEn46E1aNMDVUqs4kR5h8NFiCJIWr8TBCr7Z3BtVri2H
	 Iy5XVfix5gb+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D0DD81303;
	Fri,  2 Oct 2026 14:01:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 12FE234D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04B5E4055D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K4ArK2VUXtbT for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 14:01:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 996DF404F8
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790949674;
 b=n7ZFpGhaTXhjitTfroFAjJM+XiPALG9wSyqQG3sMvIu82G059ACmsytqmnsTH9s4SIP6
 aX+AuLvR5DWiD0hk1MbnzH+G+ySMm10c4IxVxkltQxi+FhBmzP1Mp2AYoipTOBgk4Yu6C
 Tx0m2hQkjC3UqtvGwggq7Usq2pC9Hz5csUVUUhmK6qi26J0CCer76dxZNH1xVMxyIRZD7
 lJ3ZGWwuXmoITxkgzFMraxj/azQyQU5kKi8XnR8xHqUvqrgw3eZWnFqyNgQlkH1Ai8bkR
 eR6bf8JMna3biVyI3KEPnHr+/s8sg6uO1Dc+wUMs0ycffO7qftpVixXbr/ogMKxQMWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790949674;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=K6IquK68HlCusO6ZINh0VS2i3GbV4UymBUE9LxnySz0=;
 b=WofgNiWL692TwQBco/T6jCFXZqdptQYPnFTpHcElLR/hRnYvQBJdYjuzcj89V8kzcIAX
 UbDC6O/mki2jl6JiMiwz5jej3V8hJJPZLzgqqzfqrcdvDlMe/yBX+AJwe+rp4xP9zUifE
 X80uYgtxi2P455RR2kbF4uaPf3vj918HXkUuR5ZIFiByxtX13E9DiVTH06uteXDMigzj+
 LqWteTmb8U6fenpDL9AgkQqko8RVLZIOCgQCYczN2zaxxJIieKimOnhJqqo6+XzZnP0+1
 jhQL7EEvVgiqaVB/JtGOrwOmIHHTcAZuhtNkGarGK+MBv+FzW0Wqgp7zBTI0ysq6lbQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XIO74+lN; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XIO74+lN
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 996DF404F8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 14:01:13 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b017a3be3so2560587f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790949671; x=1791554471;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K6IquK68HlCusO6ZINh0VS2i3GbV4UymBUE9LxnySz0=;
 b=XIO74+lNtGT8KAerYQLrbXhJSHJUJ7xCaoi1yEOO6RWzt9sYq0e6sPFsUDNdeniKDg
 a5i1UZM/1hXD5bls9VDn7AgvZ+LN8xx6SWJwsssxBx3aXUgfWa+ztnZ3ow+N8NkeD6q2
 3QFLC/cJQRM5P7Hspxs+bgEdcMDNJAlhOFDIRcsd8/xnFmxF75U9IDcBRiaz9dG+cCqn
 5r9NkmC/yix3HXMrL+lhJoy7Tuv10NImtBK31HPTQJsveHLohkWE0ddWH8gTiqn85s08
 8fssf+Jl4FJmTYY9Z5v0R1zdQ0Rp4Bajau3fTiB8UMtpxfqr7gpJ2vgxj770XKdi8CCG
 SmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790949671; x=1791554471;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K6IquK68HlCusO6ZINh0VS2i3GbV4UymBUE9LxnySz0=;
 b=gbUe0XIHPXnbdSUU9ub4RIjDbhRBqs2ukg9TBAcivUQ62kVpH618BBOGn/jASUX1DW
 xopeyt+72K6yumi6h36bvQU//N+JhfyI5Mq8LK06uU7wKfnSvU3GYhQtl1N+50ihosIV
 jMsKNskIJzz/9ks2T+rO8zGMnEgqrBcaIf4x3Z+eHLEy8Zt+llC1UC1bn22FatngY7O9
 Xyw6Fv3d1XIOdfcL2aWCZbpnvxvIkmm7ZiAwak7xDM/z1PaztDDcWa1S5jyfr5g7nWDp
 3W+KE5GVZ7dx0jP0XxnNFdjrLQNT1M9ei+g0+iD7e6T1Rq5W9Pj82A6VRNIimbXd348H
 LppQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByym6nwbv97yZXk/YeJRbGW57cIHPzGhj7OLei0fkbu2JQxW1gSA3Y8k7GBbAx5E7GCLQVy3IA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLZNYLb2uKprEzrHzPUNsFaZLtHF+JR8BTFj66qohoCZ00Tik67
 xdv9unNNhoTcsftQaNZF60AyyT3a69XckqaW3v8DOpblaOLMMSspzDp6LdS/GcGVuUk=
X-Gm-Gg: AYBFou03xCaFiHnsl+OKlvE4Bd0M92gr1zPwPw+lMoETrevuvgjCc1LO3ICV86z2QPH
 Xfh8IselaZdBU3rwDgzF9rRkiPI9oO4pegH2W/kmNlO4Lm+kSU2KTgLm1hOpsDJLY+ctguVztPi
 ilKs3MlxCTmN6DsM8Lr/x9OZDM1t/kDiTKQ5W7IEogRFMfEcVhyKQDfB1V571Kak93PbighS5L+
 87aiAYwzJYl4HxTMy54e0JVyAfQvSkxK9IDS2BdQmJXRyTtIMXpYBwy3LBZYd7ZZZP+PI9YL33b
 mfEJZIBF3P5TgDrrXhovd3Rmp7u+AmGouuRrkmTnd7QqJpttlsdSI2F2EmXuKD/XCFfsaVfQ032
 z8k71x1MVVvZPafOLpziV1Q8eZPX3QMrJYu93B5nPNE0URjJxLDcx6+ucjdTMBhsdBSKKSjQ4P1
 ctBgVGSHflYhGvfCJQaHqSTJlsB8BEFXC+YaAulDPTMNGmJoAeG0hrLj7fxbowCr9mJgOtomoXT
 RLSrDippj86Dg5GsLPrS8XwvaCtDtE/VlG9B+/r69U5gHBE8VYMZqsYc5XfRpYCEKSyJYj3azWm
 jLG+LJPXAM52MjVJtgBeyGpEhJkzpMCJxsPkwizvDcfmVn8buXiJJmd6
X-Received: by 2002:a05:6000:310a:b0:487:1ac0:32af with SMTP id
 ffacd0b85a97d-48b1275b416mr5204228f8f.51.1790949671312; 
 Fri, 02 Oct 2026 07:01:11 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm6138477f8f.37.2026.10.02.07.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:01:10 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 02 Oct 2026 16:03:53 +0200
Subject: [PATCH v2 02/13] video: mediatek: add ovl component
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-mt8365-mt8366-add-dsi-support-v2-2-9e435457b90c@baylibre.com>
References: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
In-Reply-To: <20261002-mt8365-mt8366-add-dsi-support-v2-0-9e435457b90c@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
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

The overlay (ovl) is the entry point of the video pipeline on some
MediaTek SoCs, such as the MT8365 and the MT8366: it reads the layers
from DRAM and blends them into the stream handed to the rest of the
pipeline.

U-Boot only ever shows one framebuffer, so the driver configures layer 0
with the XRGB8888 framebuffer of the video uclass, blended over an
opaque black background, and leaves the other layers off.

The overlay is also a DMA master, so it needs the SMI larb feeding it
and its port taken out of the IOMMU translated address space, U-Boot
having no IOMMU driver: extend the component larb lookup with that port
index.

The driver matches "mediatek,mt8192-disp-ovl", the generic fallback the
MT8365 ovl0 node carries behind "mediatek,mt8365-disp-ovl", and
"mediatek,mt8366-disp-ovl", which the MT8366 node carries on its own as
that SoC is not upstream yet. The MT8366 overlay is the only one of the
two able to drive the per layer bit depth of DISP_REG_OVL_CLRFMT_EXT,
which the per-compatible data selects.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/video/mediatek/mtk_disp_comp.c |   1 +
 drivers/video/mediatek/mtk_disp_comp.h |  13 +-
 drivers/video/mediatek/mtk_disp_ovl.c  | 253 +++++++++++++++++++++++++++++++++
 drivers/video/mediatek/mtk_disp_ovl.h  |  45 ++++++
 4 files changed, 307 insertions(+), 5 deletions(-)

diff --git a/drivers/video/mediatek/mtk_disp_comp.c b/drivers/video/mediatek/mtk_disp_comp.c
index f9eb9e00de6..3846a46f698 100644
--- a/drivers/video/mediatek/mtk_disp_comp.c
+++ b/drivers/video/mediatek/mtk_disp_comp.c
@@ -89,6 +89,7 @@ int mtk_disp_comp_get_larb(struct udevice *dev)
 	}
 	iommu = args.node;
 	larb_id = MTK_M4U_TO_LARB(args.args[0]);
+	priv->larb_port = MTK_M4U_TO_PORT(args.args[0]);
 
 	for (i = 0; ; i++) {
 		node = ofnode_parse_phandle(iommu, "mediatek,larbs", i);
diff --git a/drivers/video/mediatek/mtk_disp_comp.h b/drivers/video/mediatek/mtk_disp_comp.h
index 8214af38b27..fbc2174352e 100644
--- a/drivers/video/mediatek/mtk_disp_comp.h
+++ b/drivers/video/mediatek/mtk_disp_comp.h
@@ -18,13 +18,15 @@ struct udevice;
  * @base: register window of the component
  * @clk_bulk: clocks of the component
  * @larb: optional SMI larb device (UCLASS_MEMORY), enabled and disabled
- *	  together with the component. Only the RDMAs, which are the DMA
- *	  masters of this pipeline, have one.
+ *	  together with the component. Only the DMA masters of the pipelines,
+ *	  the overlays and the MDP RDMAs, have one.
+ * @larb_port: M4U port index of the component within @larb
  */
 struct mtk_disp_comp_priv {
 	void __iomem *base;
 	struct clk_bulk clk_bulk;
 	struct udevice *larb;
+	unsigned int larb_port;
 };
 
 /**
@@ -44,9 +46,10 @@ int mtk_disp_comp_probe(struct udevice *dev);
  *
  * A DMA master component reaches DRAM through an SMI larb, which must be
  * ungated for its accesses. The component points at its IOMMU (M4U) port
- * through "iommus", and MTK_M4U_TO_LARB() extracts the larb id from that
- * port. Resolve the matching larb in the IOMMU's "mediatek,larbs" list by
- * its "mediatek,larb-id", so that mtk_disp_comp_enable() and
+ * through "iommus": MTK_M4U_TO_LARB() extracts the larb id from that port
+ * and MTK_M4U_TO_PORT() the port index within it, kept in larb_port.
+ * Resolve the matching larb in the IOMMU's "mediatek,larbs" list by its
+ * "mediatek,larb-id", so that mtk_disp_comp_enable() and
  * mtk_disp_comp_disable() then enable and disable it together with the
  * component.
  *
diff --git a/drivers/video/mediatek/mtk_disp_ovl.c b/drivers/video/mediatek/mtk_disp_ovl.c
new file mode 100644
index 00000000000..865372a6263
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_ovl.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Video Overlay support
+ *
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <fdtdec.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <mtk_smi.h>
+#include <video.h>
+
+#include "mtk_disp_comp.h"
+#include "mtk_disp_ovl.h"
+
+#define DISP_REG_OVL_EN		0x00c
+#define OVL_EN				BIT(0)
+
+#define DISP_REG_OVL_RST	0x014
+
+#define DISP_REG_OVL_ROI_SIZE	0x020
+#define OVL_ROI_SIZE_WIDTH		GENMASK(15, 0)
+#define OVL_ROI_SIZE_HEIGHT		GENMASK(31, 16)
+
+#define DISP_REG_OVL_DATAPATH_CON 0x024
+#define OVL_LAYER_SMI_ID_EN		BIT(0)
+
+#define DISP_REG_OVL_ROI_BGCLR	0x028
+#define OVL_COLOR_ALPHA			GENMASK(31, 24)
+
+#define DISP_REG_OVL_SRC_CON	0x02c
+#define L0_EN				BIT(0)
+
+#define DISP_REG_OVL_CON	0x030
+#define OVL_CON_ALPHA			GENMASK(7, 0)
+#define OVL_CON_AEN			BIT(8)
+#define OVL_CON_CLRFMT			GENMASK(14, 12)
+#define OVL_CON_CLRFMT_ARGB8888		2
+
+#define DISP_REG_OVL_SRC_SIZE	0x038
+#define OVL_SRC_SIZE_WIDTH		GENMASK(15, 0)
+#define OVL_SRC_SIZE_HEIGHT		GENMASK(31, 16)
+
+#define DISP_REG_OVL_OFFSET	0x03c
+
+#define DISP_REG_OVL_PITCH	0x044
+#define OVL_PITCH_LSB			GENMASK(15, 0)
+#define OVL_CONST_BLEND			BIT(28)
+
+#define DISP_REG_OVL_RDMA0_CTRL	0x0c0
+#define RDMA0_EN			BIT(0)
+
+#define DISP_REG_OVL_RDMA_GMC	0x0c8
+#define GMC_THRESHOLD_BITS	16
+#define GMC_THRESHOLD_HIGH	((1 << GMC_THRESHOLD_BITS) / 4)
+#define GMC_THRESHOLD_LOW	((1 << GMC_THRESHOLD_BITS) / 8)
+
+#define DISP_REG_OVL_CLRFMT_EXT	0x2d0
+#define OVL_CON_CLRFMT_BIT_DEPTH_MASK(n)	(GENMASK(1, 0) << (4 * (n)))
+#define OVL_CON_CLRFMT_BIT_DEPTH(depth, n)	((depth) << (4 * (n)))
+#define OVL_CON_CLRFMT_8_BIT			0
+
+#define DISP_REG_OVL_ADDR	0xf40
+
+/**
+ * struct mtk_disp_ovl_data - per-SoC overlay data
+ * @smi_id_en: the overlay tags its DRAM requests with an SMI id
+ * @supports_clrfmt_ext: the overlay has the CLRFMT_EXT bit depth register
+ * @gmc_bits: width of the GMC thresholds, in bits
+ */
+struct mtk_disp_ovl_data {
+	bool smi_id_en;
+	bool supports_clrfmt_ext;
+	unsigned int gmc_bits;
+};
+
+/**
+ * struct mtk_disp_ovl_priv - private data of an overlay
+ * @comp: common component state, must be the first member
+ * @data: per-SoC overlay data
+ */
+struct mtk_disp_ovl_priv {
+	struct mtk_disp_comp_priv comp;
+	const struct mtk_disp_ovl_data *data;
+};
+
+void mtk_ovl_config(struct udevice *dev, const struct display_timing *timing)
+{
+	u32 width = timing->hactive.typ;
+	u32 height = timing->vactive.typ;
+
+	if (width != 0 && height != 0)
+		mtk_disp_comp_write(dev, DISP_REG_OVL_ROI_SIZE,
+				    FIELD_PREP(OVL_ROI_SIZE_WIDTH, width) |
+				    FIELD_PREP(OVL_ROI_SIZE_HEIGHT, height));
+
+	/* the background must be opaque black, or alpha blending has no effect */
+	mtk_disp_comp_write(dev, DISP_REG_OVL_ROI_BGCLR, OVL_COLOR_ALPHA);
+
+	mtk_disp_comp_write(dev, DISP_REG_OVL_RST, 1);
+	mtk_disp_comp_write(dev, DISP_REG_OVL_RST, 0);
+}
+
+/*
+ * Layer 0 is always fed our fixed 8-bit-per-channel XRGB8888 framebuffer, so
+ * the 10-bit format check Linux does here never applies to us.
+ */
+static void mtk_ovl_set_bit_depth(struct udevice *dev)
+{
+	struct mtk_disp_ovl_priv *ovl = dev_get_priv(dev);
+
+	if (!ovl->data->supports_clrfmt_ext)
+		return;
+
+	mtk_disp_comp_update(dev, DISP_REG_OVL_CLRFMT_EXT,
+			     OVL_CON_CLRFMT_BIT_DEPTH(OVL_CON_CLRFMT_8_BIT, 0),
+			     OVL_CON_CLRFMT_BIT_DEPTH_MASK(0));
+}
+
+static void mtk_ovl_layer_on(struct udevice *dev)
+{
+	struct mtk_disp_ovl_priv *ovl = dev_get_priv(dev);
+	u32 gmc_thrshd_l, gmc_thrshd_h, gmc;
+
+	mtk_disp_comp_write(dev, DISP_REG_OVL_RDMA0_CTRL, RDMA0_EN);
+
+	gmc_thrshd_l = GMC_THRESHOLD_LOW >> (GMC_THRESHOLD_BITS - ovl->data->gmc_bits);
+	gmc_thrshd_h = GMC_THRESHOLD_HIGH >> (GMC_THRESHOLD_BITS - ovl->data->gmc_bits);
+	if (ovl->data->gmc_bits == 10)
+		gmc = gmc_thrshd_h | gmc_thrshd_h << 16;
+	else
+		gmc = gmc_thrshd_l | gmc_thrshd_l << 8 |
+		      gmc_thrshd_h << 16 | gmc_thrshd_h << 24;
+	mtk_disp_comp_write(dev, DISP_REG_OVL_RDMA_GMC, gmc);
+
+	mtk_disp_comp_update(dev, DISP_REG_OVL_SRC_CON, L0_EN, L0_EN);
+}
+
+int mtk_ovl_layer(struct udevice *dev, const struct video_uc_plat *plat,
+		  const struct display_timing *timing)
+{
+	struct mtk_disp_ovl_priv *ovl = dev_get_priv(dev);
+	u32 width = timing->hactive.typ;
+	u32 height = timing->vactive.typ;
+	u32 pitch = width * VNBYTES(VIDEO_BPP32);
+
+	/* DISP_REG_OVL_ADDR is 32-bit, the framebuffer has to fit below 4GB */
+	if (upper_32_bits(plat->base)) {
+		dev_err(dev, "framebuffer at 0x%lx is above 4GB\n", plat->base);
+		return -ERANGE;
+	}
+
+	/* opaque layer with alpha blending on, as Linux sets it up */
+	mtk_disp_comp_write(dev, DISP_REG_OVL_CON,
+			    FIELD_PREP(OVL_CON_CLRFMT, OVL_CON_CLRFMT_ARGB8888) |
+			    FIELD_PREP(OVL_CON_ALPHA, 0xff) | OVL_CON_AEN);
+
+	/*
+	 * The framebuffer has no real per-pixel alpha channel, so without
+	 * OVL_CONST_BLEND the hardware reads the (zero) alpha byte from
+	 * memory and blends the whole layer as fully transparent.
+	 */
+	mtk_disp_comp_write(dev, DISP_REG_OVL_PITCH,
+			    FIELD_PREP(OVL_PITCH_LSB, pitch) | OVL_CONST_BLEND);
+
+	mtk_disp_comp_write(dev, DISP_REG_OVL_SRC_SIZE,
+			    FIELD_PREP(OVL_SRC_SIZE_WIDTH, width) |
+			    FIELD_PREP(OVL_SRC_SIZE_HEIGHT, height));
+
+	/* the layer covers the whole region of interest */
+	mtk_disp_comp_write(dev, DISP_REG_OVL_OFFSET, 0);
+
+	/*
+	 * Without an IOMMU driver the overlay reads the framebuffer with a
+	 * physical address, so take its larb port out of the translated
+	 * address space now that the larb is ungated.
+	 */
+	mtk_smi_larb_port_set_pa(ovl->comp.larb, ovl->comp.larb_port);
+
+	mtk_disp_comp_write(dev, DISP_REG_OVL_ADDR, plat->base);
+
+	mtk_ovl_set_bit_depth(dev);
+
+	mtk_ovl_layer_on(dev);
+
+	return 0;
+}
+
+void mtk_ovl_start(struct udevice *dev)
+{
+	struct mtk_disp_ovl_priv *ovl = dev_get_priv(dev);
+
+	if (ovl->data->smi_id_en)
+		mtk_disp_comp_update(dev, DISP_REG_OVL_DATAPATH_CON,
+				     OVL_LAYER_SMI_ID_EN, OVL_LAYER_SMI_ID_EN);
+
+	mtk_disp_comp_write(dev, DISP_REG_OVL_EN, OVL_EN);
+}
+
+static int mtk_disp_ovl_probe(struct udevice *dev)
+{
+	struct mtk_disp_ovl_priv *ovl = dev_get_priv(dev);
+	int ret;
+
+	ret = mtk_disp_comp_probe(dev);
+	if (ret)
+		return ret;
+
+	ovl->data = (const struct mtk_disp_ovl_data *)dev_get_driver_data(dev);
+	if (!ovl->data)
+		return -EINVAL;
+
+	/* the overlay is a DMA master: it feeds from an SMI larb */
+	return mtk_disp_comp_get_larb(dev);
+}
+
+static const struct mtk_disp_ovl_data mt8192_ovl_driver_data = {
+	.smi_id_en = true,
+	.gmc_bits = 10,
+};
+
+static const struct mtk_disp_ovl_data mt8366_ovl_driver_data = {
+	.smi_id_en = true,
+	.supports_clrfmt_ext = true,
+	.gmc_bits = 10,
+};
+
+static const struct udevice_id mtk_disp_ovl_ids[] = {
+	{
+		.compatible = "mediatek,mt8192-disp-ovl",
+		.data = (ulong)&mt8192_ovl_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8366-disp-ovl",
+		.data = (ulong)&mt8366_ovl_driver_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(mtk_disp_ovl) = {
+	.name	   = "mtk_disp_ovl",
+	.id	   = UCLASS_MISC,
+	.of_match  = mtk_disp_ovl_ids,
+	.probe	   = mtk_disp_ovl_probe,
+	.priv_auto = sizeof(struct mtk_disp_ovl_priv),
+};
diff --git a/drivers/video/mediatek/mtk_disp_ovl.h b/drivers/video/mediatek/mtk_disp_ovl.h
new file mode 100644
index 00000000000..1882309f6d8
--- /dev/null
+++ b/drivers/video/mediatek/mtk_disp_ovl.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2026 BayLibre, SAS.
+ * Author: Julien Masson <jmasson@baylibre.com>
+ *         Julien Stephan <jstephan@baylibre.com>
+ */
+
+#ifndef _MTK_DISP_OVL_H
+#define _MTK_DISP_OVL_H
+
+struct display_timing;
+struct udevice;
+struct video_uc_plat;
+
+/**
+ * mtk_ovl_config() - configure an overlay
+ * @dev: overlay device
+ * @timing: display timing, giving the frame size
+ *
+ * Set the region of interest over an opaque black background, and reset
+ * the overlay.
+ */
+void mtk_ovl_config(struct udevice *dev, const struct display_timing *timing);
+
+/**
+ * mtk_ovl_layer() - scan out the framebuffer on layer 0
+ * @dev: overlay device
+ * @plat: video uclass platform data, holding the framebuffer base address
+ * @timing: display timing, giving the frame size
+ *
+ * Point layer 0 at the XRGB8888 framebuffer, take its larb port out of the
+ * IOMMU, and enable the layer.
+ *
+ * Return: 0 on success, -ERANGE if the framebuffer is above 4 GiB
+ */
+int mtk_ovl_layer(struct udevice *dev, const struct video_uc_plat *plat,
+		  const struct display_timing *timing);
+
+/**
+ * mtk_ovl_start() - start an overlay
+ * @dev: overlay device
+ */
+void mtk_ovl_start(struct udevice *dev);
+
+#endif /* _MTK_DISP_OVL_H */

-- 
2.55.0

