Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF106C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 19:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51E7580EB0;
	Tue, 22 Sep 2026 19:30:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1yoKrUL2DpSd; Tue, 22 Sep 2026 19:30:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3430680EA8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790105443;
	b=k/876E47YswM0I7lWRcY2N8wQhXGsel2sptpD3/FbvDLF0mFS+RDibYJnZFYR2lDxMbf
	 k9fgiewHBHSAEr4lTIvgd1EVZfThVA8aDYvOSlxQCyVLgFAn8bs1qTkaRUf48wMOLHowr
	 kk+3huvL+eT9wBeqMrk33EsqJ1wzvaIY/BKQc93RHssW3aHtDmob94v0x9kzRHW+x4v9V
	 prFHaK/8m/M+sTwIbXtdIM3FI2BB0tdTB10kWrQMjpuwJrxCB2zsVXGNhEcWaEY9cRhH0
	 xuPcu/MTkrCCpiTj49QccfDWK8SDrHuyUS4IJW9sWCRg2+Hd/fEPdd8+vvYRvr2O3TQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790105443;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=69ztaS9yoaxdy6E6OV+o/MmcG/OkUIF3ialLMrqrspI=;
	b=gouAEKNWqEV+ESMyAjxRolWxTg9gdj5fQEn32rPtvuU9K6MdzXU2i2J998MZh42Dacnc
	 EO3yIYKevVsUeGYWtJwJSb7xV4Z3kIV2cEQ8UMVAR/uZ2CbGbaZDToY5MfeUInyLGQYiS
	 mLBesJvN8cW3Ayl8dTYMti3uGjvOpyh7Z3hKGIAihyhP0/2adnolMPlgPRNY5bNC6d5mj
	 s+fVNw4kD7oB+Hd3jLmcTjCiGTDCzunng0iWmRtx2ih+mFGOhWKwiYepD0KmafCiVH7Dy
	 i9VX86UtLZ8FKYmyW0YKeeMKR99l00Lv/YccEheeCEKbV8xt4TrimwjURZr16sfu3EQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790105443;
	bh=69ztaS9yoaxdy6E6OV+o/MmcG/OkUIF3ialLMrqrspI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tOfkDV3f5i1x9LZ3Um90Qo4WvZmvXSlF6UlGYSMoK5qKrkPk/KzeTwEi7Dk03PtGR
	 YAaLIevp1UXZzANcB7MB+lz6Hcpp9kZVfo58oC+v+eVsplIAI0C1k+K7rEegtsOEh1
	 O6rZQdgiKSHVqEuZNa5xU1QkKmRuKmBUaZpL9OBVOgkC6npiY/Hph/Cx/ymORdHanX
	 pQQUu0T/UT1eAKPZCNNWg4LnsGiV06QDncl5dH2i4yjTS1UNkbQuVqDsgIPdKgt1ju
	 UamX54Dm2z8hOIndhakCmro5ITNtl+dkvMfhdbXZDdmeapPe5anceiSuIavP3X2A4m
	 zCbrjZ1vvBeLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3430680EA8;
	Tue, 22 Sep 2026 19:30:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80CD612C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 19:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7303A407CA
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 19:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mBqJ0Gj7w5Jc for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 19:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 043F5407C9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790105440;
 b=N571+RMsias+MT0QGHtwruoY7X52x/4UE2AYrQregaz+d4iH+L+oG7cqS6cxmryp3YXy
 HI3Ok6d2lTahlQYyaMHUIK2xO2uu4fi5bxmbcr3RUMixolpV9/aW33Tl/aIWiZIe0XOpM
 0S5vAbMLPO0sVHZlCir0w8B+qWCXz5Mxe9ecu3eIAGMm10i6g7Ao+xUfTnJQ7BDT3XUb3
 rtD6C0BGgRIG9enC6+4LYiZ9T7D9VwBsrgBehxVf9LQo3+phCajvt/bcgViHbTG22IvaC
 uX/UHjvhPYivS+JojBVL4LuNPoho9MIURiaEFPVUAa8zxKcRF0f5ySuypCoqvlklQiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790105440;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=69ztaS9yoaxdy6E6OV+o/MmcG/OkUIF3ialLMrqrspI=;
 b=ps0D0pvw406q8wVGiJcImyT5zaJtWk1zzc2cv92SBw6JuxMvhlAjnvKfD1/mYqyT+2i4
 yD5Q2VYIxiXBFLL0FNTKC7H9nszXACIbkU9qftCmcmFRXS7XcF0PVsJUEyGiWrAXlv5FR
 2umM4//XQAKAh0lIB2wbtmP0eZo8yOGm6EfDYeXXYKDl8f+HIXF4TKvOLAUmfZXTCXqrB
 lzu1gxWpNqZq8ZO7vTpzHn3yEMdJ/sA9ebkOCgbkB2uUjcVM7kP+YssVyLZhI6izQYiCs
 K2TKnpgzpeAz38egK+hq0dnZ0zIf51D2mk+QIlH6QPOyn8SxYCLis6OQWToSfOCYWWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=lex.la; 
 dkim=pass header.d=lex.la header.i=@lex.la header.a=rsa-sha256 header.s=google
 header.b=ZNxCd4cR; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=f@lex.la; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=lex.la header.i=@lex.la header.a=rsa-sha256
 header.s=google header.b=ZNxCd4cR
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 043F5407C9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 19:30:39 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b24c3so221517f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lex.la; s=google; t=1790105437; x=1790710237; darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=69ztaS9yoaxdy6E6OV+o/MmcG/OkUIF3ialLMrqrspI=;
 b=ZNxCd4cR4dLX7UEMZ1i3PRovysjETtgiEe01jGs/5xfqJyXSKmHM/QO2aZaYloHMtM
 nwm50vBLMgZ5ugSQIq3FLHlqW4IdPKeT6esCD+0XR0pmdNdgySGkFQyVdmQzhf9y5/Uq
 fLlnELasb2uzUcaU/lP6RQ7IuGqOpnBtgcn3wHCTQEUwNgepYD1gSFQJ05a17vk4Odge
 cG+qfH35GXUC1TF8e0/ZFhDPrhqzLx2iG+hzGVBSol7swpq43VIRFeOgDjhddINSix08
 2tQy0rLP14oVTRAGZjymYfFo0dpVRUtc5sbdISTaZbosmsUKecpBl2sbKgKOzIw414hO
 muHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790105437; x=1790710237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=69ztaS9yoaxdy6E6OV+o/MmcG/OkUIF3ialLMrqrspI=;
 b=UWVx0YoRGc7gx3VNZz+/AhmNgu0F+0jzwRbSg1w4C45KUQ4MOEpi5A+j8htrx2ISSk
 J1vrhO7674i9tFMJzMfI1pGi7XumoQ/ykBzcA6tJuiBVoTVzXO3w+2Gy7iQOIzE+ts4d
 DkWlquCKKdgCcKtWlpviB7fA14waV2+ANdjYt6zCBzQXzEX4u4PQ57BaKM4KqYcbuDC4
 9++8aiNU0J63TeOpDUZ3GXfbtvP3tyjyvJhvLchF4DNuA6EhfoYbikfWYXSrHLLSFR/o
 NZVHCPPi2xzGZo1zbUcwuLH2t/h/L/vXc1f9Tk2/cPfSL+1sZ9Dy3SuKarHpX0FSQ151
 64eg==
X-Gm-Message-State: AFuF++mvjR9FKXxb7SF0shQkO7wavfIwCXKVyZd0gZb+3vncTyqQiZ7A
 3Ps9pUnORUJzQm0Ei6kyi4b5PWb6X5EdO2baFarQODuQtXhCcJOhFg/Nt6TPBh7gxgjt1KIu9id
 tbjNpCN3wog==
X-Gm-Gg: AYBFou0EsNuzFwGN3xP71BCcKMVsUUlexomfag9Z2vPhEWCjLoeehdwEMqHFu3xBeVU
 5f3WIWHw0InmtQRnAu+FRyUbFascg5QcJAL0Iw/as2MQ9vkNS+/IZ/a0XzyjSCTha1qSwXG6sri
 8uHgNV4dV91GGlNppf9CJd421L2P/LDob2rrj4tvkyZ5fJ7P/08rT43scQoJCl0wxefGIhSwHLQ
 k5wjmGGxkPTKFefJff/b/8I1uxyZ8kw9SVbA8Osl++ds7bgwZHQGh874AEuRvGFGYkKj1FXp1GO
 CW0GiWRY+8MV1+5jyDyEOskBRv06r4aCI3lJ9QcXXGVzfpb9s2DbmTFVGHGH0a48dPZr5eAz/iy
 EUYZzyJtymQ7H6yj1I4q20NmyET9I+xCBhvBOIvadzUNdd6w+OBPmVHERuVZR0ycfL7j7PkA9Ii
 CW4G/MHQTSRtPhCQ5+N2p/x1yXWsKJEuEHRvbp6JKzVk0DSbaZalQ=
X-Received: by 2002:a5d:64e4:0:b0:487:233d:beff with SMTP id
 ffacd0b85a97d-488670896a5mr946071f8f.16.1790105436539; 
 Tue, 22 Sep 2026 12:30:36 -0700 (PDT)
Received: from remote-01 ([84.17.55.230]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488688856f0sm538783f8f.30.2026.09.22.12.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:30:36 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Aleksei Sviridkin <f@lex.la>
Subject: [PATCH v2] arm: mediatek: allow a board to carry the arm64 kernel
 image header
Date: Tue, 22 Sep 2026 22:30:31 +0300
Message-ID: <20260922193031.785941-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When I brought U-Boot up on a Keenetic KN-1012, an MT7981 consumer
router, its stock loader started nothing I offered it but an arm64
kernel image, so U-Boot has to be chainloaded as one and needs that
image header in front of it. U-Boot links at 0x41e00000 there and the
header carries a text_offset of 0x80000, the value the board was brought
up with, which puts the base that offset is measured from at 0x41d80000;
an offset base equal to TEXT_BASE gives a zero offset.

Neither LINUX_KERNEL_IMAGE_HEADER nor LNX_KRNL_IMG_TEXT_OFFSET_BASE has
a prompt, so no defconfig reaches either. Prompting one of them in
arch/arm/Kconfig would change a symbol every arm64 platform shares for
the sake of one board, and giving the offset base a default of TEXT_BASE
there would hand every platform that selects the header and forgets its
own value a silent zero offset. A board that needs the header is
expected to select it and supply the value itself, so both the prompt
and the value stay inside the platform that wants them.

MediaTek has nowhere else to put them. Three of the eight platforms
carrying the offset base today do it from a board Kconfig; MediaTek has
no board Kconfig at all, and a SoC target is no substitute:
TARGET_MT7981, MT7986 and MT7987 carry three defconfigs each and
TARGET_MT7988 two, so a value written under one of them is one value for
every board on that SoC, with nowhere left to override it. The defconfig
is the only per-board file Kconfig reads on MediaTek, so that is where
the value has to be reachable from: a platform bool that selects the
header, and the offset base redeclared under it with a prompt and
default TEXT_BASE, a default only a board that turns the bool on can
reach and whose help text says it gives a zero offset. No board here
sets them: the one this comes from is supported out of tree and is not
on its way in.

Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
The obvious shape, a prompt on the generic symbols across the arch, was
v1's 1/2. Tom Rini declined it:

  "This isn't a prompted option as boards that need it are expected to
  select it and provide the correct value."
  https://lore.kernel.org/u-boot/20260921155055.GZ858934@bill-the-cat/

After I described the board, he replied:

  "Then yes, a v2 where you just enable this for the platform that needs
  it should be fine, and please make sure to CC all of the mediatek
  maintainers, thanks."
  https://lore.kernel.org/u-boot/20260922151920.GH858934@bill-the-cat/

No MediaTek board in the tree uses the header, so there is nothing here to
just enable it for: the one that does is out of tree, and MediaTek has no
board Kconfig a select could live in. What this v2 adds instead is a
prompted bool inside mach-mediatek, with the offset base prompt only
visible while that bool is on. Tom, is a prompted bool local to MediaTek
acceptable for this, or would you rather it did not go in?

How it was checked. Built on mt7981_rfb_defconfig, which carries the same
TEXT_BASE of 0x41e00000 as the board, reading magic at 0x38 and
text_offset at 0x08 back out of u-boot.bin:

  header on, offset base 0x41d80000  magic ARM\x64, text_offset 0x80000
  header on, offset base default     magic ARM\x64, text_offset 0x0
  stock mt7981_rfb_defconfig         no magic, no header

Left off, the knob changes nothing a board would notice:
mt7981_rfb_defconfig configured on 9e002445cd and on this patch differ by
one line, the comment Kconfig writes for an unset bool that has a prompt,
and by no CONFIG_ value at all. The prompt does not reach past MediaTek
either: apple_m1_defconfig, rock5b-rk3588_defconfig and
p3450-0000_defconfig configure to byte-identical .config files on both
trees, keeping their offset base values of 0x0, 0x800000 and 0x80000000.

savedefconfig on the 0x41d80000 build returns
CONFIG_MTK_KERNEL_IMAGE_HEADER=y and
CONFIG_LNX_KRNL_IMG_TEXT_OFFSET_BASE=0x41d80000, so the defconfig carries
the tree's own name for the value rather than a MediaTek alias. Dropping
the redeclaration and turning the header on anyway reproduces what it is
there to avoid: u-boot.lds:66: undefined symbol
`CONFIG_LNX_KRNL_IMG_TEXT_OFFSET_BASE'.

The offset base is a subtrahend, not a load address: it only sets the
header's text_offset field. Both this board and the mt7981_rfb_defconfig
measured above set CONFIG_POSITION_INDEPENDENT, so U-Boot runs wherever
the loader places it. Not tried: booting the board with text_offset 0. The
board was brought up with 0x80000 and boots with it. My earlier mail said
0x80000 is where the stock loader expects the image; I had not verified
that, and the value is only the one the board was brought up with:
https://lore.kernel.org/u-boot/20260922102812.3981001-1-f@lex.la/

Changes in v2:
- Dropped 1/2, which prompted the generic LINUX_KERNEL_IMAGE_HEADER and
  LNX_KRNL_IMG_TEXT_OFFSET_BASE across the arch. Nothing outside
  mach-mediatek changes any more.
- 2/2 grew a platform bool that selects the header, and redeclares
  LNX_KRNL_IMG_TEXT_OFFSET_BASE under it with default TEXT_BASE and a
  prompt, so the value reaches it from a defconfig. Eight platforms
  already redeclare that symbol, five of them with default TEXT_BASE
  (mmp, rockchip, apple, exynos-mobile, vexpress64); none of the eight
  prompts it, and the prompt here is gated on the platform bool.
- Cc: the three ARM MEDIATEK maintainers v1 missed, plus Macpaul Lin.

v1: https://lore.kernel.org/u-boot/20260920151512.401899-1-f@lex.la/

 arch/arm/mach-mediatek/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index e572cfe857..e48fe88529 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -173,6 +173,23 @@ config MTK_MEM_MAP_MMIO_SIZE
 	help
 	  Target-specific MMIO region size in mem_map.
 
+config MTK_KERNEL_IMAGE_HEADER
+	bool "Prepend an arm64 Linux kernel image header"
+	select LINUX_KERNEL_IMAGE_HEADER
+	help
+	  Build U-Boot with the arm64 Linux kernel image header in front of
+	  it, so that a vendor bootloader that only starts a Linux kernel
+	  image starts U-Boot as its payload.
+
+config LNX_KRNL_IMG_TEXT_OFFSET_BASE
+	hex "Address the image header's text offset is measured from"
+	depends on MTK_KERNEL_IMAGE_HEADER
+	default TEXT_BASE
+	help
+	  The header's text_offset field is CONFIG_TEXT_BASE minus this value.
+	  Set it so that the difference is the text offset the vendor
+	  bootloader expects; the default gives a zero offset.
+
 endif
 
 config SYS_BOARD

base-commit: 9e002445cd0d47d3965312f12e97a18e1ed8bd53
-- 
2.53.0

