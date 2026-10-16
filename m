Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F0ECC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7DE040952;
	Fri, 16 Oct 2026 06:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o2sDhJ2aDOzH; Fri, 16 Oct 2026 06:31:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B7284092A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792132287;
	b=A7FMxVEobFDtzozaMBMyKitf6z+PXsZDAs2FEG9U61QpxLFJHr0R0/lP0ThFEXdS4zBX
	 Rpx8Tg1PLbFlokBeBSWMfw1hm6ZahUfjmogiyYTJXN/FEiJYYbWNXLlTmfZ2tmllc7xtE
	 9t9Poh9BzjGkR14k6K87KrK20CsONno9UZY59o0RDL75ZyVFCRExEk1hVjNAyGo5IeD0R
	 1yz5HMquHWikGEBtCFCMJuzgkQ2+7dVyKhwCA6LcpYdYe57DfD5FvIeIpv0Rk/ptA7+HS
	 G8t0EgGd2vXvMdIf2lhk9uv9/7nxkrClvHE74OsH5PPIAXaGUaEBUeBHXzNT2To7IIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792132287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Rc+W73lTbahODgOogceftDxGGpq7Jo4OU0zm0qbwLJ8=;
	b=XRqw3KCva1eQxq9ezK21pWuZvPNBN/tWGE4FNNjjREyD6QmVdTgzW1lAml3ZznEfNrXH
	 mlPFMrHEyjUvQO5Kf65Cudi5AO6mHRwD4XAgyEwV/ooqnHkFhT2PwGTo600P5AMXYDOE4
	 bomsj/zOrigexqJEFcxYg28GFHvFOl2X3LN3d48HRPRdISZJzR82yTTqUWmKwBPP0qgdu
	 0iMJWkpk+JZp/qrS8Hj85s21VHeHhsP47YoncdLBeIsIYPpox3Is/ackXDgaX0z5VeNCy
	 6UUvVpdvc7C/Ha+5LRPwQO5yu9fDFY6UWyOhnv+lyT652WXqlw/D+bE4wF9Z+KeryRw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Fa+Qrk1L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792132287;
	bh=Rc+W73lTbahODgOogceftDxGGpq7Jo4OU0zm0qbwLJ8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FVYKEt6WIgnzpXhIxMKzIm/TkExAYBp32pST7/hXD007e4Ed4ZjqFP0CX1Fh6vilr
	 64JA4RuTOiw7i8N6KYWjQsi8PWyKun4uW5CKjFi39GT9dyy/mlE4uxXIgRoi229ui9
	 KE/2cLp52Pk8Ydza1sAILAl2J74bFlrdT5wIOJyowbfL1Re6y2PvXG0F/ib3QaATPh
	 rJMsQ3NPy6M6n5KGltwPLotji8L7R9zttH5ALB+A4zBSRIloQBV1B4oYA2sc7oKruq
	 4Iv4yhvMAA0ILfPrYFSWeId2FfjyahswtmcpclZ5+EqjQL6pbBtl2mSt6KslA/awEH
	 KmttivXX+bivw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B7284092A;
	Fri, 16 Oct 2026 06:31:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B568B263
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A680C4092A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:31:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QvCWqFJcozwV for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:31:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 665374091F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792132284;
 b=nd9QjJhZPoPSjcwBvmR/6E0WsDKYRK+WRfQHAJWym/+/DLYUOEr1ka1MKb4hnfCXOBsp
 vDwdpxUaWm6khN439784fPmfnz7O/6P8/3mKwCwVA4M6mt2/+rVwmTEaetU8SvAyMuh2u
 uhZ532QqzSbOSHIBRoA2r6iCI2OubiLzOpL9EdlclAbn6GMqLODW2nPjvhui1htZTER1e
 1w8kabHBhy1pV+n9FBTZ1yKKaJ2VRdDWKQNvNrDZar73h+RB6oySslcfqlAyqSms1pRTx
 9UMgLpS0sTwIV6f4M0jcZDXccPVErEATTwBawntK+QTD7qF/Up7E3R0Nn6K5PDAOUoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792132284;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=Rc+W73lTbahODgOogceftDxGGpq7Jo4OU0zm0qbwLJ8=;
 b=AJykTo1ltklOr4tHHYUYsq9zpd+M/JiW1MnIQzjQcJhU5FQnwiKx8IlnmWMUxhgntOkE
 zeimxrOD/MDTnk5FWcu81SoHvI4uQyGiigmwOGpKjXUI/M+Ovrq6JKK+8w3YplD7JgU49
 W27FMDOEqgbx8ZdJ28nOVGaAOwKQ6BIQgKTINiZQrJHEQCKBRI0f/am5NgiAAOyj0cKJF
 szbN29MKuDgklNyoVzEshV1iVW9JpGB8TFoxOZX2q9opogzNOvshERuCMqlsISa0J8ikv
 3JBat5O7jtTQTYd8xf71/cx9M+EuMXEp+65PeGUyAbdvTM5y8HVv+QAG1HVWBuT6KDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Fa+Qrk1L; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Fa+Qrk1L
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 665374091F
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:31:24 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8819033dbadso4051857b3a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 23:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792132283; x=1792737083;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rc+W73lTbahODgOogceftDxGGpq7Jo4OU0zm0qbwLJ8=;
 b=Fa+Qrk1LxXooD7C7hmybVQhFtohMPcrCdSWh817CQOFet7ktWSK+XhVC3xAhI/zBDv
 YKyXg1Qt1nwWkzSJ63UI7f64gIrqe+5A48fp8vV9ncKX0+3ItrxJEe1GH8q/nsP6vY9p
 nTL+F6YXZNjhZgb0W77Ndp+hG8Hzq3HVksTjleTVxyQcDfeZoVUbDlrqJ4tVlmULdURY
 Hd8rnrv7gZG7cDZc155VbDrRT+sxCFifRFsd0GdCUFxPnYGaCqz9+dFtWhQsmiUDuaCE
 6gaZYj9oo5xJI27hrPoNvsLIVsDljj2JrXcOIY+uFO+lMbt3AC7zgKVW6fKUBEfEIaW1
 Jbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792132283; x=1792737083;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Rc+W73lTbahODgOogceftDxGGpq7Jo4OU0zm0qbwLJ8=;
 b=2Hm4FyyFhHTTTNWd8c+B19Bgo16MAtZoMIWBmDv70qSagHuTrwufTy6cUHeJrc7LmG
 8RlO8rV+/nhs4BrweLtC114RpME3Fn2FFU5NVzsA8nS6a/yITOabr/pSQDL+JlXax7+D
 eHaaxJhASNB5T/v9qiGJc1s5GbZxAG0ioshYzk8cKAnB9+bzo3KvdudG/pq5t4fh5k2J
 MyivWrmPixEBcMm07LQ3nEIRSrYv89YHn9niV0KcUtP1mSNVn067CSpduLTiclLByKl+
 HV3aBMngIhH7fJR4tZSTatSK3y2i2pcCdBh73MNCO3l+lJmz0CftPGLVA+isztA+3lo6
 /xOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPS14S0r4voK7R0VVskP/bKO+66On3iZgsmNb66VfYsVqAWKkQALItQrnZYmlNNv3e1Pt+FSY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKRO8Pa3gAzQsln4jJJKBejcCTFQ/hTtSIWGI1dE6Pr6bVJt+Sd
 bzCyMcqAYX4M7kQrZyGsZ86tmdIl9P3C26NWJzlxIh5grd+UDEeGlGkO
X-Gm-Gg: AYBFou2/mmE1+ZqM5dD0Cw0Slsd1FyJn/iW4SEMZ8mUm1ZGETtE3b/TT9Cj+I7WHWlU
 RyctXIudo+OFy1lBiw84FN0qytzfVgBVTKCZCtqFTdOZY5fdDpx/RGegjkZGj23wAO4Oqtb0Fgq
 fxOucy6MaJzFkSgfVWYSV46QxbtlwDvucocRdKmhQYUBbHx1T3+MNbrNWoijW3HLzRu2VfTL75n
 lmOofJAToD6kfzJydrXy0C0iArUvu1t+aZ5S5tD9yOWrQ5E/IjWv+a9Ftmh6BT3sMdcefwabLUq
 zdBtWnx9uCzAdiFHewcYCgNuH+KbgNkXCAAZWNJk9OFHmBN+vCzn/kiOAmItbOEbJenYxzkB+57
 Z5xGXeY+l6zq2VGpz5QL805fu9WaxKuWIvr8Hm/zFD/+ZlUyy5hOezwk44qT1loncG8JOAlNGJE
 OcKTXB0nOs90JVUW0/HCfokj7zXMeVYrInqY5ZEbjU38yqHUykgCclN3h1cUHoB00=
X-Received: by 2002:a05:6a00:c591:20b0:89d:eb23:4e83 with SMTP id
 d2e1a72fcca58-89deb234f8amr4195039b3a.30.1792132283254; 
 Thu, 15 Oct 2026 23:31:23 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7618:4e1c:4ee1:1a8a:57cd:4423])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89febdc2209sm84691b3a.33.2026.10.15.23.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:31:22 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Fri, 16 Oct 2026 13:30:48 +0700
Subject: [PATCH v2] video: use bpp conversion helpers consistently
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-bpp-helpers-v2-1-ca1e6bba2820@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNQQ6CMBBFr0JmbU2nCCIr72FY0HaEMUCbFomGc
 HcB48LlS95/f4ZIgSlCmcwQaOLIblhBHRIwbT00JNiuDEqqHKXMhfZetNR5ClHYwuapRiVtUcO
 68IHu/Nprt+rL8akfZMYtsRktx9GF93434eb9ysVfeUKB4nTOLGqVYWou16avuTsa10O1LMsHY
 F4gyLgAAAA=
X-Change-ID: 20261006-bpp-helpers-d8d63b120d8a
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Eugen Hristev <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2
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

Many places open-code the conversion between log2 bits-per-pixel and
the actual number of bits or bytes per pixel, using expressions such as
"1 << bpix", "(1 << bpix) / 8" and "((1 << bpix) >> 3)". Meanwhile,
<video.h> already provides VNBITS() and VNBYTES() helpers for exactly
these conversions. Replace the open-coded expressions with the helpers.

Using the helpers makes the intent of the expression clear, removes
duplicated bit manipulation, and reduces the reliance on the specially
crafted VIDEO_BPP* enum values, since callers no longer need to know
that those values are log2 quantities which is also important for
future extensions.

Note that VNBYTES() is only correct for 8bpp and above, since it returns
a whole number of bytes per pixel and cannot represent sub-byte pixel
sizes. Every site converted to VNBYTES() here uses 16bpp or 32bpp, so
the result is identical to the original expression.

No functional change is made.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
Changes in v2:
- Convert uncaught conversion cases in the following files:
  - arch/sandbox/cpu/sdl.c
  - boot/fdt_simplefb.c
  - drivers/video/atmel_lcdfb.c
  - drivers/video/rockchip/rk_vop.c
  - drivers/video/sunxi/sunxi_de2.c
  - drivers/video/tegra/tegra124/display.c
- Updated commit message
- Link to v1: https://patch.msgid.link/20261008-bpp-helpers-v1-1-475d1b2513c9@gmail.com
---
 arch/sandbox/cpu/sdl.c                 | 4 ++--
 boot/fdt_simplefb.c                    | 2 +-
 cmd/bdinfo.c                           | 2 +-
 drivers/video/atmel_hlcdfb.c           | 2 +-
 drivers/video/atmel_lcdfb.c            | 4 ++--
 drivers/video/imx/mxc_ipuv3_fb.c       | 2 +-
 drivers/video/meson/meson_vpu.c        | 4 ++--
 drivers/video/mvebu_lcd.c              | 2 +-
 drivers/video/rockchip/rk_vop.c        | 4 ++--
 drivers/video/sunxi/sunxi_de2.c        | 8 ++++----
 drivers/video/tegra/dc.c               | 4 ++--
 drivers/video/tegra/tegra124/display.c | 4 ++--
 drivers/video/ti/tilcdc.c              | 4 ++--
 drivers/video/tidss/tidss_drv.c        | 4 ++--
 test/cmd/bdinfo.c                      | 2 +-
 15 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/sandbox/cpu/sdl.c b/arch/sandbox/cpu/sdl.c
index ed84646bd..ff823fb72 100644
--- a/arch/sandbox/cpu/sdl.c
+++ b/arch/sandbox/cpu/sdl.c
@@ -152,10 +152,10 @@ int sandbox_sdl_init_display(int width, int height, int log2_bpp,
 	if (!SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1"))
 		printf("Unable to init hinting: %s", SDL_GetError());
 
-	sdl.src_depth = 1 << log2_bpp;
+	sdl.src_depth = VNBITS(log2_bpp);
 	if (log2_bpp != 4 && log2_bpp != 5)
 		log2_bpp = 5;
-	sdl.depth = 1 << log2_bpp;
+	sdl.depth = VNBITS(log2_bpp);
 	sdl.pitch = sdl.width * sdl.depth / 8;
 	sdl.screen = SDL_CreateWindow("U-Boot", SDL_WINDOWPOS_UNDEFINED,
 				      SDL_WINDOWPOS_UNDEFINED, sdl.vis_width,
diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
index 69c7c2e24..9b7ffe9ff 100644
--- a/boot/fdt_simplefb.c
+++ b/boot/fdt_simplefb.c
@@ -59,7 +59,7 @@ static int fdt_simplefb_configure_node(void *blob, int off)
 	}
 
 	return fdt_setup_simplefb_node(blob, off, fb_base, xsize, ysize,
-				       xsize * (1 << bpix) / 8, name);
+				       xsize * VNBYTES(bpix), name);
 }
 
 int fdt_simplefb_add_node(void *blob)
diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index bf1eca759..37981764b 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -114,7 +114,7 @@ static void show_video_info(void)
 						   plat->copy_size);
 			}
 			printf("%-12s= %dx%dx%d\n", "FB size", upriv->xsize,
-			       upriv->ysize, 1 << upriv->bpix);
+			       upriv->ysize, VNBITS(upriv->bpix));
 		}
 	}
 }
diff --git a/drivers/video/atmel_hlcdfb.c b/drivers/video/atmel_hlcdfb.c
index 89bc0eeb6..8a0096cec 100644
--- a/drivers/video/atmel_hlcdfb.c
+++ b/drivers/video/atmel_hlcdfb.c
@@ -315,7 +315,7 @@ static int atmel_hlcdc_bind(struct udevice *dev)
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
 	uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-				(1 << LCD_MAX_LOG2_BPP) / 8;
+				VNBYTES(LCD_MAX_LOG2_BPP);
 
 	debug("%s: Frame buffer size %x\n", __func__, uc_plat->size);
 
diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 281c3a1d6..29a24b8cd 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -69,7 +69,7 @@ static void atmel_fb_init(ulong addr, struct display_timing *timing, int bpix,
 
 	/* ...set frame size and burst length = 8 words (?) */
 	value = (timing->hactive.typ * timing->vactive.typ *
-		 (1 << bpix)) / 32;
+		 VNBITS(bpix)) / 32;
 	value |= ((ATMEL_LCDC_DMA_BURST_LEN - 1) << ATMEL_LCDC_BLENGTH_OFFSET);
 	lcdc_writel(reg, ATMEL_LCDC_DMAFRMCFG, value);
 
@@ -187,7 +187,7 @@ static int atmel_fb_lcd_bind(struct udevice *dev)
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
 	uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-			(1 << VIDEO_BPP16) / 8;
+			VNBYTES(VIDEO_BPP16);
 	debug("%s: Frame buffer size %x\n", __func__, uc_plat->size);
 
 	return 0;
diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
index 3a327b9e9..447644f5b 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -654,7 +654,7 @@ static int ipuv3_video_bind(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
-	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT * (1 << VIDEO_BPP32) / 8;
+	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT * VNBYTES(VIDEO_BPP32);
 
 	return 0;
 }
diff --git a/drivers/video/meson/meson_vpu.c b/drivers/video/meson/meson_vpu.c
index a686faf9f..21ac60749 100644
--- a/drivers/video/meson/meson_vpu.c
+++ b/drivers/video/meson/meson_vpu.c
@@ -79,7 +79,7 @@ cvbs:
 
 	/* Move the framebuffer to the end of addressable ram */
 	meson_fb.fb_size = ALIGN(meson_fb.xsize * meson_fb.ysize *
-				 ((1 << VPU_MAX_LOG2_BPP) / 8) +
+				 VNBYTES(VPU_MAX_LOG2_BPP) +
 				 MESON_VPU_OVERSCAN, EFI_PAGE_SIZE);
 	meson_fb.base = gd->dram[0].start +
 			gd->dram[0].size - meson_fb.fb_size;
@@ -141,7 +141,7 @@ static int meson_vpu_bind(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->size = VPU_MAX_WIDTH * VPU_MAX_HEIGHT *
-		(1 << VPU_MAX_LOG2_BPP) / 8;
+		VNBYTES(VPU_MAX_LOG2_BPP);
 
 	return 0;
 }
diff --git a/drivers/video/mvebu_lcd.c b/drivers/video/mvebu_lcd.c
index 9f1ea9c35..234b27c90 100644
--- a/drivers/video/mvebu_lcd.c
+++ b/drivers/video/mvebu_lcd.c
@@ -576,7 +576,7 @@ static int mvebu_video_bind(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-		(1 << LCD_MAX_LOG2_BPP) / 8;
+		VNBYTES(LCD_MAX_LOG2_BPP);
 
 	return 0;
 }
diff --git a/drivers/video/rockchip/rk_vop.c b/drivers/video/rockchip/rk_vop.c
index 17dfe62c9..b8f56d94e 100644
--- a/drivers/video/rockchip/rk_vop.c
+++ b/drivers/video/rockchip/rk_vop.c
@@ -381,9 +381,9 @@ static int rk_display_init(struct udevice *dev, ulong fbbase, ofnode ep_node)
 		return ret;
 	}
 
-	rkvop_enable(dev, fbbase, 1 << l2bpp, &timing, &dclk_rst);
+	rkvop_enable(dev, fbbase, VNBITS(l2bpp), &timing, &dclk_rst);
 
-	ret = display_enable(disp, 1 << l2bpp, &timing);
+	ret = display_enable(disp, VNBITS(l2bpp), &timing);
 	if (ret)
 		return ret;
 
diff --git a/drivers/video/sunxi/sunxi_de2.c b/drivers/video/sunxi/sunxi_de2.c
index ab36ee159..2fec6a8ab 100644
--- a/drivers/video/sunxi/sunxi_de2.c
+++ b/drivers/video/sunxi/sunxi_de2.c
@@ -202,9 +202,9 @@ static int sunxi_de2_init(struct udevice *dev, ulong fbbase,
 	}
 
 	sunxi_de2_composer_init();
-	sunxi_de2_mode_set(mux, &timing, 1 << l2bpp, fbbase, is_composite);
+	sunxi_de2_mode_set(mux, &timing, VNBITS(l2bpp), fbbase, is_composite);
 
-	ret = display_enable(disp, 1 << l2bpp, &timing);
+	ret = display_enable(disp, VNBITS(l2bpp), &timing);
 	if (ret) {
 		debug("%s: Failed to enable display\n", __func__);
 		return ret;
@@ -218,7 +218,7 @@ static int sunxi_de2_init(struct udevice *dev, ulong fbbase,
 #ifdef CONFIG_EFI_LOADER
 	efi_add_memory_map(fbbase,
 			   timing.hactive.typ * timing.vactive.typ *
-			   (1 << l2bpp) / 8,
+			   VNBYTES(l2bpp),
 			   EFI_RESERVED_MEMORY_TYPE);
 #endif
 
@@ -279,7 +279,7 @@ static int sunxi_de2_bind(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-		(1 << LCD_MAX_LOG2_BPP) / 8;
+		VNBYTES(LCD_MAX_LOG2_BPP);
 
 	return 0;
 }
diff --git a/drivers/video/tegra/dc.c b/drivers/video/tegra/dc.c
index ced497188..6aca106f1 100644
--- a/drivers/video/tegra/dc.c
+++ b/drivers/video/tegra/dc.c
@@ -278,7 +278,7 @@ static int setup_window(struct tegra_lcd_priv *priv,
 	win->out_w = priv->width;
 	win->out_h = priv->height;
 	win->phys_addr = priv->frame_buffer;
-	win->stride = priv->width * (1 << priv->log2_bpp) / 8;
+	win->stride = priv->width * VNBYTES(priv->log2_bpp);
 
 	log_debug("%s: depth = %d\n", __func__, priv->log2_bpp);
 
@@ -646,7 +646,7 @@ static int tegra_lcd_bind(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 
 	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-		(1 << LCD_MAX_LOG2_BPP) / 8;
+		VNBYTES(LCD_MAX_LOG2_BPP);
 
 	return dm_scan_fdt_dev(dev);
 }
diff --git a/drivers/video/tegra/tegra124/display.c b/drivers/video/tegra/tegra124/display.c
index abe31e27d..6d485736e 100644
--- a/drivers/video/tegra/tegra124/display.c
+++ b/drivers/video/tegra/tegra124/display.c
@@ -448,7 +448,7 @@ static int tegra124_lcd_init(struct udevice *dev, void *lcdbase,
 	reset_set_enable(PERIPH_ID_DPAUX, 0);
 	reset_set_enable(PERIPH_ID_SOR0, 0);
 
-	ret = display_init(dev, lcdbase, 1 << l2bpp, &timing);
+	ret = display_init(dev, lcdbase, VNBITS(l2bpp), &timing);
 	if (ret)
 		return ret;
 
@@ -484,7 +484,7 @@ static int tegra124_lcd_bind(struct udevice *dev)
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
 	uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-			(1 << VIDEO_BPP16) / 8;
+			VNBYTES(VIDEO_BPP16);
 	debug("%s: Frame buffer size %x\n", __func__, uc_plat->size);
 
 	return 0;
diff --git a/drivers/video/ti/tilcdc.c b/drivers/video/ti/tilcdc.c
index b498e8186..6b2e591ce 100644
--- a/drivers/video/ti/tilcdc.c
+++ b/drivers/video/ti/tilcdc.c
@@ -430,8 +430,8 @@ static int tilcdc_bind(struct udevice *dev)
 {
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
-	uc_plat->size = ((LCDC_MAX_WIDTH * LCDC_MAX_HEIGHT *
-			  (1 << LCDC_MAX_LOG2_BPP)) >> 3) + 0x20;
+	uc_plat->size = LCDC_MAX_WIDTH * LCDC_MAX_HEIGHT *
+			VNBYTES(LCDC_MAX_LOG2_BPP) + 0x20;
 
 	dev_dbg(dev, "frame buffer size 0x%x\n", uc_plat->size);
 	return 0;
diff --git a/drivers/video/tidss/tidss_drv.c b/drivers/video/tidss/tidss_drv.c
index c231fd034..7c8bfe418 100644
--- a/drivers/video/tidss/tidss_drv.c
+++ b/drivers/video/tidss/tidss_drv.c
@@ -986,8 +986,8 @@ static int tidss_drv_bind(struct udevice *dev)
 {
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 
-	uc_plat->size = ((LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
-			  (1 << LCD_MAX_LOG2_BPP)) >> 3) + 0x20;
+	uc_plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
+			VNBYTES(LCD_MAX_LOG2_BPP) + 0x20;
 	return 0;
 }
 
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 7b7fb0894..f53665446 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -91,7 +91,7 @@ static int test_video_info(struct unit_test_state *uts)
 			}
 			ut_assert_nextline("%-12s= %dx%dx%d", "FB size",
 					   upriv->xsize, upriv->ysize,
-					   1 << upriv->bpix);
+					   VNBITS(upriv->bpix));
 		}
 	}
 

---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261006-bpp-helpers-d8d63b120d8a

Best regards,
--  
Reza Kurniawan <imkyufie@gmail.com>

