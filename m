Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56810C982D9
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 10:53:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C39A60D68;
	Fri, 18 Sep 2026 10:53:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 82K_mRkUdHyM; Fri, 18 Sep 2026 10:53:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2195D60D5F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728789;
	b=OoV17V1ZwxGInFI/ZS9BX12keje9SWpoVtgdoKx9TnBsSrA20E1tdaiNZVgx2FOwvpBQ
	 hVbZ6oTZRtbvFSEwy5Vc0nadIgZhiVKyeLcgvpt9HdcXTNrI+k6THQ6tRF5vKaj4ICh7n
	 8k0Ok63elKag37a/910AfmV60jT2GckNMHGOpEE0E8dbDqEACQXAjvCR/HWQUHFsBYWuI
	 35v0Oe226ef2rS6sjA5iezNWcKeJc9qrQ9vbiPcPW0JcYvh8MLj2Oq75XRJ1eh39LF2Z6
	 uluYl8B88eATkHWENIT+mJkPGHiu6X3QKfvc8DpYlL9i9Yi8dbEgp1fynn7VyuiOQfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728789;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u4P/lFdYVTaFV1DGW/5mS/zKANGHL327hzr6ITXi0hU=;
	b=UF1f1cFmwb9ip5bQuEZG0QS8KoLuXmzMGVLp5XTvTn3hvvN2roUVkcKKQEW8OBuDNnbZ
	 9kQfsmG6cIymVTxSfjizDtgjF4oY4/svXMHESTfahApZFPOaR+PD5RRe8qPa7xz7orpjw
	 ktCRS1Y1iA5MMigxLI1s5hnKP6gu46LYAonZ7y7pAw3RLU98UEr893CQQqj8NY4us5m9J
	 ILNzykNik2U+Axssdp3m481BpMENelzqP+tkDb9I8lw7/+U/dVYYZp02YgpLK3mJcNcCV
	 VTKgmFc8JTLMKrlC9/CxYDJdQrzAJ3nw4ktz3ngnvP5K70YRYjh3NzBUihNuhl+969g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789728789;
	bh=u4P/lFdYVTaFV1DGW/5mS/zKANGHL327hzr6ITXi0hU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T5AmZZ2wZqeejSktU4cFljtqlB/exzQ7Hq/V+BIhl9yTtUPSM6soyMHgfgY/g3d6g
	 7FR+pfO86r0p1NbWMUMXi7HLVndqCAuOMIS5+s8W3egE6aqIpXfS/5pu0OdB/loQnW
	 On51iAJ/ADGrb6LqGIDpivNQdhV4nQodq9k9waUfkgU+DX7IXp2iHD0ffGDAyXQaU9
	 NuBx9Jtr0URaMQsZrKTH4KlH/sNewP3ur1ogq0fLbIQ9Kf6g1wUoODka/OdxehoyGX
	 xMWEpynDh2ODhOALhibEHZ5l/e9Voh+5o985Ucrsm0A51WCW3KUcL7Js+axOdinWsO
	 iW7UlXndB3F1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2195D60D5F;
	Fri, 18 Sep 2026 10:53:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DCD924D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F41A640B77
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GxBpyAp5RF_L for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:53:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8476740B6F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728786;
 b=pfloKDEuYwIU8FRpdp0g30Yp2MZ35mx077iqNN/9lZmAGN2GTvwU+wUjK4xw2Ywbl7VR
 S289R2AIr+QCFT//jWAAjglzZ97YJzRt7Gbph9JC2eUVEDpbp8Y0RAaTDZenEXSJTuSVw
 RQA0qp803ULlm0/VCKaUO1DvHKOarKVouL5v4AMjc13T3ZhPu7XV8+M3klqv0y5+Ok11A
 5P4dz8auKbdDzVqo3GFEQBe+3wiZipFdfz86Vkei6ZoiTxu7Aw1qm017/MjayOPkMiM6E
 rZR5y0OlLmuZBCw6UrpayuUQWyQJkXkxwmevKVSqWx0TJ1EAH5MEK0Wnuiuyhos1YVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728786;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=u4P/lFdYVTaFV1DGW/5mS/zKANGHL327hzr6ITXi0hU=;
 b=aBmHQTW0OSEy6MIfVlYYiqLscD9K1FyFe5x3CrbXmYoxt2r2jYsTzyPs4VoWEp5S+Nys
 6NGMZ8tTkLQoPlfsf5j2K1EZrrbrcvtscRswyrjftF9OQxDFkmVrhBR4GJGWQVpVAiKf/
 XX2fmypK/prDH8Ab20rAIOsRHTK7HRuwKFkrD+tDhqwE1W/6H3I5NajVBAKuUQYJCbJ3f
 Sks4PVaYeNOnRz+6B6KFM3wOz5nfzf7iruIRL3wKPFxJYXzdP7Mgbiy1OPvSRmQ0+dXlf
 XDRLSr3Sqcee96ZcBvMRyFqfNuErMsIepOu4SxXYWFoe2dwaICceCt6Xm1a4zEJpUMQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=7EUxl7b5; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=7EUxl7b5
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8476740B6F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:06 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48442ea8f59so715920f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789728784; x=1790333584;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u4P/lFdYVTaFV1DGW/5mS/zKANGHL327hzr6ITXi0hU=;
 b=7EUxl7b5ST6YVolxI4suxQ74t1BUD2X1z2mblBadfP8zKFZU4kwXfYJkxU/xZhum03
 Ft7PGbo9edUlSYfDRWLGxRKcPmPmi9Gy6eVlOQVDEoS4OYJ4lHOpGzEwYpLfkH9qAy/G
 Lj2TZuRTv5TbTwjvNxSJVYD8ECIgkfcOJdFOT12MkI4R35nzIdvxpSiOpFMcxccto/B6
 8GqCCg/bMHKg4dGLiGj/z3Xj9Ya7TcZAF4tgzdnHC0fHQC4OcwMMEEBqW1fqwqBxdCaF
 nIwHIYiiKMBIY+cO4yV/gk9HuE+dbiWIsBAv/TYbwDCwu+3hh1cj1CmxnUTfOD/puzqQ
 bPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728784; x=1790333584;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u4P/lFdYVTaFV1DGW/5mS/zKANGHL327hzr6ITXi0hU=;
 b=LZN1eeUtlbbsOkTKmb4TSX65FFM6Wa7Ons6j5ROCiE8iH3DImAocjJ2V6kHvigL/Fd
 rBTBHZmvFzKEujQtrVj5ACMIzolDgW8KD/PTxEWhxPKhvnb5hfXWsEz5707PlflknFdW
 PsuJOi9Win46hQB36276o9coladk5jqLkrRmrhMZlk8QR13E0evWWSFSMputJZp0PmU7
 76KOu6TPEM1OPRrJ2gtXiTJrlI1D6qz7quj8dk3b6+f1Mp2IRA6S9pj/Fv+rNDpDcZTg
 uS9+ARcygBy5e3cZqGFErFDK09Hc6r45nu52bwWgd+tTVOKz1XKMJFlU+TfSi7sQfeqc
 UNYQ==
X-Gm-Message-State: AFuF++nwhLKHBLQwFpvxwD3PYnOkAyMGK85U4FV+H8i/oC0tgaVXpP48
 C0sFPmwgnQOOHjcLtomHMpU5q54zW7qbjRY4ZMjDxQIlNGmP3MnnEOOUh/aKS/sWPfE=
X-Gm-Gg: AYBFou1DblIIJNKZkK4q54vEmHvHo3zGxgiQ520WuvH9BpBkiSrbtWgKLpOurAjfD+J
 RxphgeVfLF7oOcIN0Vt+NIheYiPkPWcx9Ma/vfe3hbxF9anDXQbuC6LtOhWAX2xNd75VQjBCuT8
 cO/syT8l+EhMLKw/q6mpS2nbBZGtfiHS9+eAcbzh97BcS40f+4rxKJKWQVQRvy1Hr47euiw/23P
 DEe0xEG0Gdz1JGiWO3hNO5WvYRRm7pPAbpJhjWE4TYWgv4LK7gHPO28411hu2fjnJQ2cWUkFdSn
 B7qyy7MI1Cxd8623onbYoywkeXF0fkD/sWJERokocpXFOwk18GTY6EO++sFXkf6ATTKiUVUj4NF
 +GFkfm7oKEoJRem6Ro4FHK0mpBCw4lsvzTgFcy6cshZwgvQ4pMx9hvP0ycIec7yNZmXTTAdujZW
 +7vQYVRArp921Ji2yvmBbEFJlsBr26RfgsUKddMmRE14ShggsW+ApuyBcfHY/ktQWIB4WLi+W4P
 Vb6klr1n9wQdVz9c4V1ymTSf9O+Ppz17pjbFhfCGIyakVSSCvvx
X-Received: by 2002:a05:600c:ad4:b0:49f:bb49:9cca with SMTP id
 5b1f17b1804b1-49fbd1b9d98mr73171555e9.5.1789728784327; 
 Fri, 18 Sep 2026 03:53:04 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm3673449f8f.32.2026.09.18.03.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:53:04 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 14:52:31 +0400
Subject: [PATCH v2 04/11] lib: Track whether a phase has a decompressor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spl-fit-compression-v2-4-28e946f57357@flipper.net>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
In-Reply-To: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5501; i=alchark@flipper.net;
 h=from:subject:message-id; bh=pbP5/WCyO3MGyzkjpjgOYG8nKNYIrvhOhKJj2tr7Aks=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStFf+7b9uRR/MF3gkITpy1qe+PU63f0xWzlrIlHKn+8
 k5/teKDYx0TWRjEuBgsxRRZ5n5bYjvViG/WLg+PrzBzWJlAhkiLNDAAAQsDX25iXqmRjpGeqbah
 nqGRjrGOEQMXpwBM9eRKhv+eN+/wcO3ccWTXzD31c6aoSmtsVZZa2/3+mqGscGzl07CnjAy30wu
 3Rfys0Vp5g11OKYfB1fRUaf31eXenNwbNDnlwJZ8TAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

spl_decompression_enabled() names the two algorithms SPL happened to
support, so every algorithm added to image_decomp() requires editing the
header. It also asks about CONFIG_SPL_* from a header included in every
phase, so a VPL build with VPL_LZMA reads SPL_LZMA and answers about the
wrong phase.

Add a hidden per-phase symbol selected by any of the compression
algorithms and ask about that instead, which also matches how
image_decomp() gates its own cases.

SPL_BZIP2 is out of scope: lib/bzip2 has no phase-aware build rule.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/spl_fit.c |  6 +++---
 include/spl.h        | 10 ----------
 lib/Kconfig          | 30 ++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 1a0066c92a05..e02c746af5d3 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -284,15 +284,15 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_SPL_FPGA) ||
-	    (IS_ENABLED(CONFIG_SPL_OS_BOOT) && spl_decompression_enabled())) {
+	if (CONFIG_IS_ENABLED(FPGA) ||
+	    (CONFIG_IS_ENABLED(OS_BOOT) && CONFIG_IS_ENABLED(DECOMPRESSION))) {
 		if (fit_image_get_type(fit, node, &type))
 			puts("Cannot get image type.\n");
 		else
 			debug("%s ", genimg_get_type_name(type));
 	}
 
-	if (spl_decompression_enabled()) {
+	if (CONFIG_IS_ENABLED(DECOMPRESSION)) {
 		fit_image_get_comp(fit, node, &image_comp);
 		debug("%s ", genimg_get_comp_name(image_comp));
 	}
diff --git a/include/spl.h b/include/spl.h
index 8a9f799f192a..32a9d7eb5230 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -1203,16 +1203,6 @@ void spl_save_restore_data(void);
 int spl_load_fit_image(struct spl_image_info *spl_image,
 		       const struct legacy_img_hdr *header);
 
-/*
- * spl_decompression_enabled() - check decompression support is enabled for SPL build
- *
- * Returns  true  if decompression support is enabled, else False
- */
-static inline bool spl_decompression_enabled(void)
-{
-	return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZMA);
-}
-
 /**
  * spl_write_upl_handoff() - Write a Universal Payload hand-off structure
  *
diff --git a/lib/Kconfig b/lib/Kconfig
index 1292185e03f8..b42856ee6a92 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -934,6 +934,7 @@ config SPL_BZIP2
 config SPL_LZ4
 	bool "Enable LZ4 decompression support in SPL"
 	depends on SPL
+	select SPL_DECOMPRESSION
 	help
 	  This enables support for the LZ4 decompression algorithm in SPL. LZ4
 	  is a lossless data compression algorithm that is focused on
@@ -943,6 +944,7 @@ config SPL_LZ4
 config TPL_LZ4
 	bool "Enable LZ4 decompression support in TPL"
 	depends on TPL
+	select TPL_DECOMPRESSION
 	help
 	  This enables support for the LZ4 decompression algorithm in TPL. LZ4
 	  is a lossless data compression algorithm that is focused on
@@ -952,6 +954,7 @@ config TPL_LZ4
 config VPL_LZ4
 	bool "Enable LZ4 decompression support in VPL"
 	depends on VPL
+	select VPL_DECOMPRESSION
 	help
 	  This enables support for the LZ4 decompression algorithm in VPL. LZ4
 	  is a lossless data compression algorithm that is focused on
@@ -961,6 +964,7 @@ config VPL_LZ4
 config SPL_LZMA
 	bool "Enable LZMA decompression support for SPL build"
 	depends on SPL
+	select SPL_DECOMPRESSION
 	help
 	  This enables support for LZMA compression algorithm for SPL boot.
 
@@ -974,30 +978,35 @@ config SPL_LZMA_SIZE_OPTIMIZATION
 config TPL_LZMA
 	bool "Enable LZMA decompression support for TPL build"
 	depends on TPL
+	select TPL_DECOMPRESSION
 	help
 	  This enables support for LZMA compression algorithm for TPL boot.
 
 config VPL_LZMA
 	bool "Enable LZMA decompression support for VPL build"
 	default y if LZMA
+	select VPL_DECOMPRESSION
 	help
 	  This enables support for LZMA compression algorithm for VPL boot.
 
 config SPL_LZO
 	bool "Enable LZO decompression support in SPL"
 	depends on SPL
+	select SPL_DECOMPRESSION
 	help
 	  This enables support for LZO compression algorithm in the SPL.
 
 config SPL_GZIP
 	bool "Enable gzip decompression support for SPL build"
 	select SPL_ZLIB
+	select SPL_DECOMPRESSION
 	help
 	  This enables support for the GZIP compression algorithm for SPL boot.
 
 config TPL_GZIP
 	bool "Enable gzip decompression support for SPL build"
 	select TPL_ZLIB
+	select TPL_DECOMPRESSION
 	help
 	  This enables support for the GZIP compression algorithm for TPL
 
@@ -1011,10 +1020,31 @@ config TPL_ZLIB
 	help
 	  This enables compression lib for TPL
 
+config SPL_DECOMPRESSION
+	bool
+	help
+	  Selected by every decompression algorithm available to SPL. Code
+	  which hands a buffer to image_decomp() without caring which
+	  algorithm produced it should depend on this, rather than list each
+	  algorithm in turn.
+
+config TPL_DECOMPRESSION
+	bool
+	help
+	  Selected by every decompression algorithm available to TPL. See
+	  SPL_DECOMPRESSION.
+
+config VPL_DECOMPRESSION
+	bool
+	help
+	  Selected by every decompression algorithm available to VPL. See
+	  SPL_DECOMPRESSION.
+
 config SPL_ZSTD
 	bool "Enable Zstandard decompression support in SPL"
 	depends on SPL
 	select SPL_XXHASH
+	select SPL_DECOMPRESSION
 	help
 	  This enables Zstandard decompression library in the SPL.
 

-- 
2.55.0

