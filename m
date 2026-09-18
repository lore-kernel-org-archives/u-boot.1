Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB46C982D6
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 10:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA59181285;
	Fri, 18 Sep 2026 10:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ukWXJ0jjJsxa; Fri, 18 Sep 2026 10:53:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8F79081261
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728806;
	b=HLNKTb4h5qG+LBhLElQp/d2f0dxdH4Rp7q833FFAIbmTYIDakcKkGdAkvhgA9GwnSwKn
	 2SoJ6jdmnxHEGAapEikQdwr5WTieBmGmBg0wnEPnnaSHHTzOF/fXNtwzBkSuULveSeEuq
	 PaOj9Tmof6g7Lft2QDM4edAqxY7GXpYw0tpZMaxZJy4kWqinwp3JULe9jz/2x6VwtuubK
	 l7VtYQmTOAHzL7LKp37gJqhRgBHvEQJkJLpvpQL9b6B/YEcb9eMuQ5LEcd41/BdA0z27r
	 Cb/PUuGR8CyqdiOfUfEZTbtSA5/uQBThe5Hoo4d57knm2N8am7pTQkbACiEyxaixf4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728806;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=w+ONaJmsBdbKSlqfG2Db2VNG//Wj2GLHd0gKPk8C4Q8=;
	b=mnAL58d1aP8UGP2nvohHihrxO435S/cbn4TL7IrzvulzvBbCOAA4/ahex3ivi9D99i4y
	 60UxsWZY8GOe/mFF3unx7JxsYd7DMDs5gQO2zZ2wxNOHTI2zE1zArvj+yiGDeh4AmoEnC
	 9baycEFDOzxBqIQkgJa3fK2sSRL9X9MwKrVor7zkud+ur7F22oZx7b4/sAmXm0AaQw20j
	 /4tm6CG5BP3BR5nNslDJ0PaWygFYdHWyC71B18v46gK5PYmGy0lhCHpWgkc+WYp3URz0M
	 FRkasRRCdoNgun0ch5EL34sYeLzY5IP+ErgAI1w3opI1LLIsp6JnhrlZW5rfHY7zGnA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789728806;
	bh=w+ONaJmsBdbKSlqfG2Db2VNG//Wj2GLHd0gKPk8C4Q8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iVX5KaXoHVwAFNKYNTbaRBKf2EKeBKK4nvT+SfMGCXPYQ2wNnQXvbcm/yKjVMXAA8
	 CycpopQg79x71gyZjXgHHIQ4okREVGu4iuzPfTng27OQY8HS3hzyjpV4kNy7a75keP
	 bZE0WnWTmRpIVyx72k51IZYggu3Hg3xLvRpWKw4quWcL2i3jVxl25TnB8aw4J6WM31
	 D4mtlkkXN6hvrLtxVqQmpQAyrAyc/rJPTAzqfPBwh+X+EAaG7uS6HMq4cSF+J88AIN
	 ztVrwgE7nwAn0lF6L2cHwYwJVlCFhlPkziCBY4UonybTUoWldGCYBVuZxxDoc9vtJW
	 ccvAprf02zC0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F79081261;
	Fri, 18 Sep 2026 10:53:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 93E4E43A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85E5440B71
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J8vs9HMQ8zZT for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:53:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5616040B77
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728803;
 b=ayWNEcDAqBPg9p+v45D1maLW7oLACBlE5KrIBjA9UiRrC4OKaDz7DS4ghSaS6kFZlcIo
 g+ef5yGAVgiE7mLpQ9IT/tR0HF96mnCCGYgF+xMrWzdDZYNCanSnExCnFkrI8EOLreewy
 1tJNF/7oxID7nra4cCQ7PfulZAkrztUGpfuh2eF5b1kRVsqDZmHNondsCKP0z2Jl9jCsm
 FzT0ReBBI9gkVQ6PvLfsVOp6T5j633HDBfC+Uysw5Bs2+jWkTcxYc+IKcykdYNMaEYZ3J
 epL24eSj/RWvoUJ76tZcdRH8eO5I+CRy/V6Vg/JG6mOXUSVWuw9PmjAcPOVIfT5EdSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728803;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=w+ONaJmsBdbKSlqfG2Db2VNG//Wj2GLHd0gKPk8C4Q8=;
 b=o/eJJm2hpnWsQzMir5RpfZIbKowZqsKtbTqZ6VPviCeiICjojhn5Z/hLs0zHZPbX3/V/
 VlIjeu9BF6vVaXC+JqI7yBJtZ96h/Za3GKjnvSx7mB9Hit4/lwMdMtOmH0Q+w5liMVqbS
 ePGv6h1TQg4pczUesL9CWJvaXxg6/jMaEMV45SBI2F9sM4C+4vBjX2NV9z0RmXJpMYRF9
 WMLPdPJkJ+gn0jIhmZ0yA0aEsdqvgQQTyNYNjo4QeR5cd7tj4/Nq6QS+jqpEu5Fpu/odo
 xfRvX86CUSuA8x5ImztYlmEBlRIquWvDhDw4XokaZNl0uRXIkK/kJEr4jHzVioIbPPQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=jaPm3MAJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=jaPm3MAJ
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5616040B77
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:53:23 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f635552aso463079f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789728801; x=1790333601;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w+ONaJmsBdbKSlqfG2Db2VNG//Wj2GLHd0gKPk8C4Q8=;
 b=jaPm3MAJUaCi+4KtlHAETDrBlmnOmUt+NVfXg0lqCUDfqs9QrXopDw8sStaYc4x5i+
 GjJFpodDtGELbaBmrxV3+aJL7zZimevBqtfEM2T14OUG+lUCAellrEUHtA8gJax7nZGS
 ihvq1xrtcIUX+iTYksARIAMK+17augqNZiquptXW7GM9+J6/pM7U7UyvXt4cPAiSbBrw
 qDZYYB27ys+WCrzk6As/kpWfm9qTDeV5Xx+mHKnXIrdCOmn7V3TcAS/Xt2tG98kgjGw3
 2xkFLmTXuxNZvpqfxcSkIxSJlGi6wrf0nvKs9LhRCYqyg/C6PiRkDXgG5ZToaXqFzVNq
 XuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728801; x=1790333601;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w+ONaJmsBdbKSlqfG2Db2VNG//Wj2GLHd0gKPk8C4Q8=;
 b=LZ9uM1UJ9keWpWo2ZfyihOyjEgw7RiQG6Jt069f8zG/mxcX1ug4DBaURrbYdaZekkt
 sdchRRJoZYO6kopLEJZSBcF76ut+KzZlt/OwRHSMEXVUGgJDEZs0mxJYccVOzzdjmN3C
 SDGxLW5WgZCnl1AUaiVIr8sC4Ho0xBSBBURcvAqjteZGNAx4ZxW1NNSEH8s9VEWsTwNW
 luVKj++tSeliv/lZJnF4jLaJ8jdRhh8mE+u8J5R4wWHf9Xygph/0Fcij5i7pdrzmTKDx
 yBaIgtv07I9sglAiCZsvZpFti7xFx6SoRNCXlpfIEjEBSSdKWVpXXRmcPXhmzGaVV7av
 /oOQ==
X-Gm-Message-State: AFuF++l/ncnyVp5zjeCN8f/eQeft/bcMq3lNtQ/u96+ksxjwtLWsyU65
 LSHTQGZ3dZQI7qumQ/ITRwC23HOJvZsxxSQYJsrJZT149HJAXBD0Rs/K4cwWcDBw44w=
X-Gm-Gg: AYBFou39Mh7UOXdyco6ZaOZEUllg3p8sGQ9xKpaFd3LU2WTSZSpCgw+g7bsjdHTOtuj
 9k9iuMgJuXCMxOoCxV/JLwMewXpTtqzdM2fbqHYwtEVz5xYqhb+AMSOQAWO/eoxVdXAc7v/kiKm
 ivqgSVdBU8PoRy27WUA6BQaUnRq2AIehDdxEwQySHE/WzpNeeCKA232ZfmrlVB2wAEUMyG1LuH8
 IdqvK14PmxOfw+UI9xl8pNTtgxj8CbaXB1YmCFWVA+A+5H92AsLNV9NFNWrfIst3fsvukKtGjq4
 JijDcs4tTo9/bT3nmn85CGLVOQ2NGHNOhnerCghS1WceN/fK6bvMBjChpO7PEyNXLkkNoUJt1UY
 cYo7QE4e3S98u8AOndjRL4p+UCrprGB0sI8urdzHOjd8agWbUdDMdnNwx0Rxk0hRppcXrUNU9Vz
 wmKYScH+xhLA9gl1GArIv7i6Gyp5W1UMvGDDPpdWN/M3FL6zBZqaExQZqutdtn5fSA48b734QoM
 bBxsulD499QVCfBhRFyi5FyMcEhImwMrr9xZ94xwcBqlnl0Nmzz
X-Received: by 2002:a5d:5d03:0:b0:487:8ef:5303 with SMTP id
 ffacd0b85a97d-4871e394d18mr2930660f8f.34.1789728801158; 
 Fri, 18 Sep 2026 03:53:21 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm3673449f8f.32.2026.09.18.03.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:53:20 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 14:52:35 +0400
Subject: [PATCH v2 08/11] test: spl: Cover FIT image decompression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spl-fit-compression-v2-8-28e946f57357@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8430; i=alchark@flipper.net;
 h=from:subject:message-id; bh=TNWAms+aV+x4hefat2KVvrJXajz/Ybc6u4gYtoiHMXk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStFf/7KCHfdq3h6fNPtyjytBWVBlqe8rBjtVgRtuuE+
 2rtPr1fHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEy1EB8jQ3/Yqu6g25827Lusvz+xQ92hgmVFS/7B43/2Mvl0XF7z5wMjw+Hm9iM
 Tw1Yfeybm4VRjEjZTkFl0C2tIdphm1b7sGLnZXAA=
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

Nothing exercises the decompression in load_simple_fit(): create_fit()
only ever writes compression = "none", and the canned LZMA blob is only
used on the legacy uImage path.

Let create_fit() take a compression, and load a compressed FIT both ways:
with the data inside the FIT and beside it, since only the latter stages
it through CONFIG_SYS_LOAD_ADDR. Point that address at the same offset
sandbox_noinst uses, since otherwise the staging corrupts what's currently
at 0x0.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 configs/sandbox_spl_defconfig |  2 +-
 include/test/spl.h            |  8 +++++++
 test/image/spl_load.c         | 52 ++++++++++++++++++++++++++++++-------------
 test/image/spl_load_nor.c     |  2 ++
 4 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 11f16f5d6220..bec02ce7bb1b 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -6,7 +6,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SYS_LOAD_ADDR=0x0
+CONFIG_SYS_LOAD_ADDR=0x1000000
 CONFIG_SPL=y
 CONFIG_PCI=y
 CONFIG_SANDBOX_SPL=y
diff --git a/include/test/spl.h b/include/test/spl.h
index c5349b06e290..ce0e636d2537 100644
--- a/include/test/spl.h
+++ b/include/test/spl.h
@@ -30,14 +30,18 @@ void generate_data(char *data, size_t size, const char *test_name);
  * @LEGACY_LZMA: "Legacy" uImages, LZMA compressed
  * @IMX8: i.MX8 Container images
  * @FIT_INTERNAL: FITs with internal data
+ * @FIT_INTERNAL_LZMA: FITs with internal data, LZMA compressed
  * @FIT_EXTERNAL: FITs with external data
+ * @FIT_EXTERNAL_LZMA: FITs with external data, LZMA compressed
  */
 enum spl_test_image {
 	LEGACY,
 	LEGACY_LZMA,
 	IMX8,
 	FIT_INTERNAL,
+	FIT_INTERNAL_LZMA,
 	FIT_EXTERNAL,
+	FIT_EXTERNAL_LZMA,
 };
 
 /**
@@ -131,6 +135,10 @@ static inline bool image_supported(enum spl_test_image type)
 		return IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT);
 	case IMX8:
 		return IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER);
+	case FIT_INTERNAL_LZMA:
+	case FIT_EXTERNAL_LZMA:
+		if (!IS_ENABLED(CONFIG_SPL_LZMA))
+			return false;
 	case FIT_INTERNAL:
 	case FIT_EXTERNAL:
 		return IS_ENABLED(CONFIG_SPL_LOAD_FIT);
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 34ddc49d2463..1fc0b8e9552e 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -40,7 +40,25 @@ void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
 
 /* Local flags for spl_image; start from the "top" to avoid conflicts */
 #define SPL_IMX_CONTAINER	0x80000000
-#define SPL_COMP_LZMA		0x40000000
+#define SPL_COMPRESSED		0x40000000
+
+/**
+ * image_compression() - compression a test image carries its payload in
+ * @type: The type of image
+ *
+ * Return: the FIT "compression" name, or NULL for an uncompressed payload
+ */
+static const char *image_compression(enum spl_test_image type)
+{
+	switch (type) {
+	case LEGACY_LZMA:
+	case FIT_INTERNAL_LZMA:
+	case FIT_EXTERNAL_LZMA:
+		return "lzma";
+	default:
+		return NULL;
+	}
+}
 
 void generate_data(char *data, size_t size, const char *test_name)
 {
@@ -77,7 +95,7 @@ static size_t create_legacy(void *dst, struct spl_image_info *spl_image,
 	image_set_os(hdr, spl_image->os);
 	image_set_arch(hdr, IH_ARCH_DEFAULT);
 	image_set_type(hdr, IH_TYPE_FIRMWARE);
-	image_set_comp(hdr, spl_image->flags & SPL_COMP_LZMA ? IH_COMP_LZMA :
+	image_set_comp(hdr, spl_image->flags & SPL_COMPRESSED ? IH_COMP_LZMA :
 							       IH_COMP_NONE);
 	image_set_name(hdr, spl_image->name);
 	image_set_hcrc(hdr, crc32(0, (void *)hdr, sizeof(*hdr)));
@@ -161,7 +179,7 @@ static size_t start_fit(void *dst, size_t fit_size, size_t data_size,
 }
 
 static size_t create_fit(void *dst, struct spl_image_info *spl_image,
-			 size_t *data_offset, bool external)
+			 size_t *data_offset, bool external, const char *comp)
 {
 	/*
 	 * The name goes in twice, as the description of both the image and the
@@ -219,7 +237,7 @@ static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 		return 0;
 	if (fdt_property_string(dst, FIT_TYPE_PROP, "firmware"))
 		return 0;
-	if (fdt_property_string(dst, FIT_COMP_PROP, "none"))
+	if (fdt_property_string(dst, FIT_COMP_PROP, comp))
 		return 0;
 	if (fdt_property_u32(dst, FIT_DATA_SIZE_PROP, spl_image->size))
 		return 0;
@@ -271,22 +289,23 @@ out:
 size_t create_image(void *dst, enum spl_test_image type,
 		    struct spl_image_info *info, size_t *data_offset)
 {
+	const char *comp = image_compression(type);
 	bool external = false;
 
 	info->os = IH_OS_U_BOOT;
 	info->load_addr = CONFIG_TEXT_BASE;
 	info->entry_point = CONFIG_TEXT_BASE + 0x100;
-	info->flags = 0;
+	info->flags = comp ? SPL_COMPRESSED : 0;
 
 	switch (type) {
 	case LEGACY_LZMA:
-		info->flags = SPL_COMP_LZMA;
 	case LEGACY:
 		return create_legacy(dst, info, data_offset);
 	case IMX8:
 		info->flags = SPL_IMX_CONTAINER;
 		return create_imx8(dst, info, data_offset);
 	case FIT_EXTERNAL:
+	case FIT_EXTERNAL_LZMA:
 		/*
 		 * spl_fit_append_fdt will clobber external images with U-Boot's
 		 * FDT if the image doesn't have one. Just set the OS to
@@ -296,8 +315,10 @@ size_t create_image(void *dst, enum spl_test_image type,
 			info->os = IH_OS_TEE;
 		external = true;
 	case FIT_INTERNAL:
-		info->flags = SPL_FIT_FOUND;
-		return create_fit(dst, info, data_offset, external);
+	case FIT_INTERNAL_LZMA:
+		info->flags |= SPL_FIT_FOUND;
+		return create_fit(dst, info, data_offset, external,
+				  comp ?: "none");
 	}
 
 	return 0;
@@ -325,7 +346,7 @@ int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
 		ut_asserteq(info1->load_addr, info2->load_addr);
 		if (info1->flags & SPL_IMX_CONTAINER)
 			ut_asserteq(0, info2->size);
-		else if (!(info1->flags & SPL_COMP_LZMA))
+		else if (!(info1->flags & SPL_COMPRESSED))
 			ut_asserteq(info1->size, info2->size);
 	} else {
 		ut_asserteq(info1->load_addr - sizeof(struct legacy_img_hdr),
@@ -781,10 +802,10 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 		     int (*write_image)(struct unit_test_state *, void *, size_t))
 {
 	size_t img_size, img_data, plain_size = SPL_TEST_DATA_SIZE;
+	bool compressed = image_compression(type);
 	struct spl_image_info info_write = {
 		.name = test_name,
-		.size = type == LEGACY_LZMA ? sizeof(lzma_compressed) :
-					      plain_size,
+		.size = compressed ? lzma_compressed_size : plain_size,
 	}, info_read = { };
 	struct spl_boot_device bootdev = {
 		.boot_device = loader->boot_device,
@@ -798,11 +819,12 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 	ut_assertnonnull(img);
 
 	data = img + img_data;
-	if (type == LEGACY_LZMA) {
+	if (compressed) {
 		plain = malloc(plain_size);
 		ut_assertnonnull(plain);
+		/* The canned blob holds what this seed generates */
 		generate_data(plain, plain_size, "lzma");
-		memcpy(data, lzma_compressed, sizeof(lzma_compressed));
+		memcpy(data, lzma_compressed, lzma_compressed_size);
 	} else {
 		plain = data;
 		generate_data(plain, plain_size, test_name);
@@ -815,11 +837,11 @@ int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 	ut_assertok(loader->load_image(&info_read, &bootdev));
 	if (check_image_info(uts, &info_write, &info_read))
 		return CMD_RET_FAILURE;
-	if (type == LEGACY_LZMA)
+	if (compressed)
 		ut_asserteq(plain_size, info_read.size);
 	ut_asserteq_mem(plain, phys_to_virt(info_write.load_addr), plain_size);
 
-	if (type == LEGACY_LZMA)
+	if (compressed)
 		free(plain);
 	free(img);
 	return 0;
diff --git a/test/image/spl_load_nor.c b/test/image/spl_load_nor.c
index f53a6724e27f..32265f6346f4 100644
--- a/test/image/spl_load_nor.c
+++ b/test/image/spl_load_nor.c
@@ -35,6 +35,8 @@ SPL_IMG_TEST(spl_test_nor, LEGACY, 0);
 SPL_IMG_TEST(spl_test_nor, LEGACY_LZMA, 0);
 SPL_IMG_TEST(spl_test_nor, IMX8, 0);
 SPL_IMG_TEST(spl_test_nor, FIT_INTERNAL, 0);
+SPL_IMG_TEST(spl_test_nor, FIT_INTERNAL_LZMA, 0);
 #if !IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)
 SPL_IMG_TEST(spl_test_nor, FIT_EXTERNAL, 0);
+SPL_IMG_TEST(spl_test_nor, FIT_EXTERNAL_LZMA, 0);
 #endif

-- 
2.55.0

