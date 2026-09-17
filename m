Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBCBC982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F8044080D;
	Thu, 17 Sep 2026 14:03:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q_g9SKcq2nq8; Thu, 17 Sep 2026 14:03:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A219F4079A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789653781;
	b=YcaVQUBR2n9lvteJnDN+hIcSIAoM6P7JGVDKXPuAfBbPGcfR38qqSYXo97kquq1KCxdn
	 4brTpFKWpb2+yYxowc5tOc2FGXcZZsqXOZEVMpQSOnCyaZJdhqEmKOFam2EfNNbzHGoC6
	 VTr7cVRTbxOCHjujSZhGi3XoJGJ+0+eck6kVNJFdjKurlvRPsJCi+YKa1AwgKZI4rxCF+
	 YS3Pl790bbQqdloqvylPvpN5WMkyturZhYGxkK5Gz7lcQZbULNQfj4yaIDVLXmoR84/eT
	 ZUpJEYBVMxekKjrVLlxsmQcF+Hu/EJU8NJIJZd5eLZUJppWVPSRmbEP2mesVCYReKIA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789653781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=l8shY28xKPWa3P++K4vLelu5wD/jXwhYv7lpxFThVPE=;
	b=nA42iIMe6z4EEYWplU51+1KqEpPJA4rRo4puuVJucmvGMvHXPksBghMCe8OWVmyYEarM
	 vr8qi7iFXr1rvWuvYUlXU92JXWJAuxaY0Eou3lVmGMzCS9GWUs5w0DSoQyFm+KQYaA0ts
	 f/iWt8BIlt26KRWZzS9+cOrqPh65Dr7T6xSFGGy+HJNPYSoUHxQLGrkH0GgFYegr0LMj1
	 GL8HLwO12kDLNG6fZanu0fHKY2LI/8uBSaudBDxsVnkZHsC3Nh4VFiI5XMC4ndQtHxPdQ
	 28f3Schn6TqJ30TA+ODOJARanXIVcBcL8uspKUWSo4KGWWd+JL0LhlSK2/543faVyhg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789653781;
	bh=l8shY28xKPWa3P++K4vLelu5wD/jXwhYv7lpxFThVPE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qxpD3FM0XzvidU1RfSHu4lM8GftOH+ufPcuWUwlqRQYzLCGQZGmT+cJADeEaWQPML
	 HtUEUrgIH8eYt2SCiaDTbXjeWdaNG4PmUBAFiBftWf3XKayH/q41oazSDR/3/s+DZp
	 SO9wmB35Zsv4T2+8XU1Dt8ZtZbnqf4d6nzXdIGRYDx9mMxloNz4OAII+nGrjG+ybpH
	 TUqqBcpSqXwmDpaCjde5A7oxYHBOh+u3tRUugUPMAf4ayUPhGhfQlNjBf4ZDdX15Vb
	 XKKHot/S/7GW8i+6HZDAYuGB9crxZpM8NSo/NThHHGWodMPc8DPp6eLAN5Ra629f0G
	 MrOJk9CWOj9Sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A219F4079A;
	Thu, 17 Sep 2026 14:03:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DDC62362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C1FDB60B25
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bWSBU6ANyhci for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:02:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ABDF360B31
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653779;
 b=r9BrtdFPRoA3PzWHQeHgFAWeB4eHRJNO6QznHXGM2IAcQk4dUOnBSABKevE+eUiw9i3e
 MFCyfHFQPv0rYhijI6D0UlwWvzINFIBi+QOTkyhkj637brZfUls6MCMEiqkKO2yg3GTlf
 hhIkv/AXQotQ9MNO51NgeMJsUmN0Sm/XzC7nZUEmH4vEoP0HIZZ20yUi67l4OZMCxJlyA
 RBCR5idI/LypDo5M63imQ97JOOZWFND+DpxIUX1kFUSvnxVC3C15xhenQS+FHC/BG5vCV
 0396UMTJ7e6/wOEekCDauRNV7tqdABiqBR6ul2uWnr7Psf23185b98i1xFsclRylyfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653779;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=l8shY28xKPWa3P++K4vLelu5wD/jXwhYv7lpxFThVPE=;
 b=RSZ29vCEag0k3ZUeN+ADmKiPuYQviWJPs/V7qWJLLwp08W9AmtB2DIsj0ndUSRmM0PAx
 OM7p6aKXUm4TVjT5qin0KoJC7fSrtrWtpYRUG6HnGGG0I4JfAww0R2mB0GDA1ErGqxrec
 lgFJ7Ekk8nnGHQQ+DRPEKx9g2Rr/vSGK6FBu3pIKel4zadsJPoWaxud0UOKw9c/yYR70G
 VDe1qnJ3f4CSGK9u5gkLYYkii/cXoZ1aU2lkilBP+GqaqDcTpjfGhm1iCjCgfKqN0d+ug
 9GVMAxGkk8MAuqjHg5FMTOC5SDuhDJLiiHp0/cCjyxZbl5ynmVfShsuH0do9FG76HYg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=4nYLUjsH; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=4nYLUjsH
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ABDF360B31
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:58 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f62ccdb1so309833f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789653776; x=1790258576;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l8shY28xKPWa3P++K4vLelu5wD/jXwhYv7lpxFThVPE=;
 b=4nYLUjsHwt2wSUpk/ZJ2kpT1QNexpaJdYWdWt4ng94XFpP0xhIJEFrJH1tGsf9oL1o
 gwtLSL84ZeoHkjR5r0KFbRMbohiG+DNTT4XlaDWGQRl9EARKm3XcM3HW8YQya3R8RMpV
 XyCYIM4E7n/7jMiPXXBOFzIqE+vAN/dsvWBiSvlweiPC4w0JshniwkUDWl17Eat9PF3t
 UYzXIVnSzExSg0uZbIv9dEJdLV1QYPBghNQh9PlppRgEAa6ARsWbToL3os+EaQmXh1en
 GZtSTLWF3YEI3hvaVD22t/G/yT9iE13gnB0j6vZiyIVvFwoN+q8xJD4nceYuuKipHIzv
 Hmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653776; x=1790258576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l8shY28xKPWa3P++K4vLelu5wD/jXwhYv7lpxFThVPE=;
 b=AaFmihaBjUkf7M4nBDb0LBFxXFUK+evwMHxqxv855Su8MyGl4lafJgNlnOJ3+en3sO
 CalF++d3fTm44Wv213Jn558nYiiUJW/oXAmNi21VP1Rt4IrCCSDA9J8AFiz62nCsddJQ
 s9N7yOTT15FqyL43WMNvo2uJ0HcSCHXkRzlos9Yl39OEXIXVA3sl/zvK3Q83NRPmwBb/
 w+tyyBrbpt64x7NprVjgFJyiAttvrc1gZUnktU5WGhhcjU+Nr410l3kKbiFKjtUDv5Ny
 om7yOOLQDC9eLTQKCtQSieRxurQqBUGklyQ1zEzFfUEC5fHtkcnTaxw6yIPERNT/srzu
 7KRQ==
X-Gm-Message-State: AFuF++k+DpBAk/gaXCjXhqCCHrs65ZgFvHDh3xVcH2DfLVVcBWC5jj4x
 6ZvDs6zS+z8t6BSp8S3QLCVe7ZNNpNv8Iu4PaZNtnmyNRDbld5xW5OqSbJ50nzxJwdY=
X-Gm-Gg: AYBFou0YTZZZf5kQcolcRmxYBs9zLw9yyWfeGh7X4vrzg+MQ5CWsb67Wi25SS4gcSNn
 /EP/tHgcMT2o88QKjskuiFtUkqQKAfG+eklBDkcbu7FTbah+oNxaRLGjKSQHaUUyH6cd9WmDZAG
 ykXpMfDbPMguwzNAHeoypiC4UDic/ng8CLYPgvTuAAc9PPLs/KSUKK+LwMEARqmz1rcLglRKGx8
 T793Y8eZRU4+fwoU7WjG6VBReM6Bo+07rq1keuGLSamh2mKz6BVSYbq936gWmmPYsKD8xOZN7TZ
 N4r3+de8tKR4PZMp5Pf/KSjDzVR0cdXDxQe6QRMntg20HuDyPRVomrrIXQLgniN+6t9JVLLqivt
 iqzeh0cvN9pY/J+uGelEkWy1haktCi456AFfHG2YWyOKChOzwfZkr6pkDr6HpDGdrc1GDpaLGyD
 F2FBdZ1NxXcd5bYCtQ9K/+ov/Fqu9nM4A8gx1dd/+/qzS4MLjBz+bqQ+uoZT6hjSRpB9sywfHmV
 TPph35wYDhOG/AvI7NlHmK28gkCrBd+RDCKCqU7/wK6W2+tx+LVuw==
X-Received: by 2002:a05:6000:41c3:b0:487:11:d053 with SMTP id
 ffacd0b85a97d-48713a8f567mr5478159f8f.0.1789653776212; 
 Thu, 17 Sep 2026 07:02:56 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16893905f8f.26.2026.09.17.07.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:02:55 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 17 Sep 2026 18:02:25 +0400
Subject: [PATCH 04/11] lib: Track whether a phase has a decompressor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-fit-compression-v1-4-7985ac56ee9e@flipper.net>
References: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
In-Reply-To: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
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
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4717; i=alchark@flipper.net;
 h=from:subject:message-id; bh=GrQXwumYOgFIDZfH8ReKY4rudRQ8har3XAvWHEgbNOI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt/vSrYaKpz7qJj2/8yJLYdTq8fmL/pqI/LDuzL7zI+
 WiwjGnGpo6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BIx1jHiIGLUwCmmuMaI8PPaRbW998XWO+9oNC+7EHboWnTbnLuTargu2S8eH00+8p2RoZPUza
 3bZ2RZdbnLHtGWeCg7ZMD1x5uWMqZZ/j50gJH5hQuAA==
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
 include/spl.h |  6 +++---
 lib/Kconfig   | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/spl.h b/include/spl.h
index 8a9f799f192a..50b41a3a3908 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -1204,13 +1204,13 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 		       const struct legacy_img_hdr *header);
 
 /*
- * spl_decompression_enabled() - check decompression support is enabled for SPL build
+ * spl_decompression_enabled() - check decompression support is enabled for this phase
  *
- * Returns  true  if decompression support is enabled, else False
+ * Returns  true  if any decompression algorithm is enabled, else False
  */
 static inline bool spl_decompression_enabled(void)
 {
-	return IS_ENABLED(CONFIG_SPL_GZIP) || IS_ENABLED(CONFIG_SPL_LZMA);
+	return CONFIG_IS_ENABLED(DECOMPRESSION);
 }
 
 /**
diff --git a/lib/Kconfig b/lib/Kconfig
index 87b5f3f4864d..ea62af7da427 100644
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

