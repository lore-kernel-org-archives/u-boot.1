Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7E7C982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 10:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23638811C6;
	Fri, 18 Sep 2026 10:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30OtuwUOb-_U; Fri, 18 Sep 2026 10:53:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 592128125F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728781;
	b=tB+4blyGjXNZEFHJ9WIrRU4TPQ08PQjr0YBTeHkoz2e0DO8RYrUiMUxYIhHcWmCfamaZ
	 Y0WQ8ff0hONdI3FNB1wzvoIzDRfOXBaoQ+2S964uMZV38Pdip95UzOQaCBWCrDrmHhezJ
	 +vmFKirqLcvgQGSJPizKaF0RnM5femgMwl6TKhmjGE3IBdx3lHoZ1p2XFLc2idnTDgfv7
	 jBWogIZf5vAQNDu2aFbUAVLGLR+n4B3WqW26/UeWSSmC1jE/hUpBN9qTV0t8UQhAQW/7u
	 Fx3hk2/8OLS79Ts07jFPD0QlwECgX46RJ9vPPqryGvpwz3u8LwYKeeb7D9PPrXoBREQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JBLSVugp3Xz6Jyz4McRsXhkDl9IPI0V5niYrZHbTJ28=;
	b=cmV0Ag43zl8/7rtOWjIc48YCSF3vZmQD4YbZvDBnw9Z9nfVbTGmWIu2Vl0HAD8bTFk5z
	 sZjAHdhRegY+bHmFGeNTu0UlwgGhYtspPMe/Izi/yp79JwZBraQFLRCSGCDj7goELuvzb
	 t8j1JRqKI6Xd2nm/iMO8Gcueh5MDcxpu/iIj2LxPoOEgy28P+/cibDiYDpl64DAY5qxSc
	 YnlrGccteBaizTPRVwrl0wslQbKXeyaR76RX5AwaOoeA6B6xe/lB201pBmsDXNpuWqN5d
	 ZKdtf4vBeS7Vs+g0MLDqF9mlM9WZCihE3L1rbKT/xBZ2u/YhwLCDOeOOok5FhuJ3caA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=bWktTGfz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789728781;
	bh=JBLSVugp3Xz6Jyz4McRsXhkDl9IPI0V5niYrZHbTJ28=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sBqkLz6H6gYRl4Gzd0nq29RI747Z1I+G2LTE/teM5QuMgKxZzxBMYHWZcSrgonQgk
	 YMrZVDSy125KEu89iS6M3+SgmXO29KX7yXZU16l3FVgkmyf2C1/OdmeaPTvNoWI8CX
	 Cpy1LE72NdYJWk1UCDcAX5Eb7WxsidpjN8PTYKyJpAhzJCP/wy8bg/zxwSls+eKqnf
	 vZ8GPOeLE941eRakd+wZoQGXYKGcE847XTDTL11QCxNM3r+n8itZgMmBmECNXo9tA/
	 zuuMOT30rG8trwIagiFzNaLOKNefq+VwatwJvOoGQpK2j69zFTfMpL0NUu3BDHNhht
	 Q4/LiqiDixiRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 592128125F;
	Fri, 18 Sep 2026 10:53:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 87CDA23F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:52:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7979A8125F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:52:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id riMeQTqEF93y for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 10:52:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8EE25811C6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728779;
 b=WnZd1KRUcwm/Zw9FQ2xttCBlKHUhD+HIEMvRytpwgTIpbqhkf0tqZOVyLkIj7y5ei4cM
 jDHPm8XpagCbPgZfx9Ag6D9zlrn8EusNQ0raRc/3p3++oYQZbsAvb3xRqfpbJcCp8ClS8
 oqL7hsYIwK8MJjSi103NgvhKvR4glqpkiWXtLLA9jfUrRfl5TMFN2buBrmOHMLI/KVKp6
 hP9P9AOCn84ABksvQkRQ4/DYlqLGhkRZyT4pcMPGMkayon1EH2i1BF+g/BMjBCgBABoaH
 8bVVkOmcF+M6BbAL3JGgfdZc3ShbJKVowmIQ7nIUiaBpjDlB8awvIMT2vdfb+gd4b1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728779;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=JBLSVugp3Xz6Jyz4McRsXhkDl9IPI0V5niYrZHbTJ28=;
 b=LVUFDqqOItKQ9rhafAdYs0fTHNdVU/nH5RVriqwgDM8E66LIbfz/CBDq/f3ASvfKApgn
 8uNalYQEYVANYikmgfvKZYYK71a6oBj2E8m02harGT9BqpyVS+Wh0eK4no7FpD8pClTsJ
 BvVd0ouuokM1SKBHMc8xciKsppM3bhw/G/6HQ6Bpw40fAo9SrQLMTRyDkXyat2v1ZLS2u
 1Zre7hFCN2ZoWp+hRKfMH7T1jQl+XszvK3mkBArb5FMtzg4KYc0V1g2JEtuZ+Ay2rWX5b
 +VetdP1xTzIozkNwDHBvO9Eo4GBK8iQxM2VlOWY4iqn3TVT/pB0vZPd7yYRJPDU8uwA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=bWktTGfz; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=bWktTGfz
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8EE25811C6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 10:52:58 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48439feca17so454639f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789728776; x=1790333576;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JBLSVugp3Xz6Jyz4McRsXhkDl9IPI0V5niYrZHbTJ28=;
 b=bWktTGfz+LE88KzUmOJAO+1NkoXE+jlSiy0zirk/Ey/He/z3aGHJCcGXP3Voel3qOd
 LftNISqbNkR18+l250Zgu/qszybSGSff2YngDWAYX/KoWAEE2HKPCYD/HNeEuXKH9iN/
 EuniINEgdRXTQkSyWIrzpaa496Lm3kFgRPr67Hf/vvGbhN8fY3aHkJWm7Me0Bc/RVFLD
 injB6+0EbS6M2UciJgALMGgjIehpNfTGvr1XdVRm3zwhtFDp6HY2aEY+T711PIWtfiVu
 o5wuwsTDQlxiPHPLmxIB6tBceXzGCujlH2KV73L2gWWfrnUz3+5GNDdGjbE/qsBZGjHj
 9LuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789728776; x=1790333576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JBLSVugp3Xz6Jyz4McRsXhkDl9IPI0V5niYrZHbTJ28=;
 b=x4IQSkjhtzqLhYe0GmM9XXZlEIKS+LZswDO+xPkjZY0/kJwX7dU7PiYZSEYTA/EvDB
 n5WVTeFB3vrG5cElP9eyJMMWGx2HZ+W3+A/Flm+2kPaDFN86eyMezozKKkWqujF9IDY4
 p80OZqqiAstLwFzuprm/Oh5p6Eo5DUAmfeAeESqZNyrBzzdDJmr30auR4oCZ5LNIlEqg
 Hko0tMHFGjtjohI5KhyxluwS87sFAYvi9U7H+afKT0g/b9kqC4HFjXoQx0FQRhMaD3v3
 QCs/ZOWXOOMyzb/c7cjcYSSvo1vLJr7OHgT02xCoYdxm7Tx9C2diW7HMP+K2Xs6Mrm8R
 pgCA==
X-Gm-Message-State: AFuF++m/mshIL0VCf3AFT44MYj0zXygIRc/V8qD5Dwn+vHlO4kFV75cf
 R067KYt+F9K5DboX+BpS/zikwfwfUd+eXU4+mU6ZdKUsZS0gWMTaVUluRA0BoIZTA6Y=
X-Gm-Gg: AYBFou01oHv2tquLCSNKpQ3EVK69PkksVVvI2BCD4A0Mf8uAnwwWou7+IourgqkXx7s
 LUErFvO7/dSclPcYxHJpLGpg8ls1lo6EvU5FGWMbyrrPrgHGF0k8KTo0XUSMuj3oG5GTceKKXtV
 PIqwq7PHg2asavtTh1Vnnc08ibsD+cdSLOTsGSB+MMssaai59EyTzteYk1bGq/BZ5k+Yq5m5gde
 cRliJpSZZIkNESKNL6G8v+feTuPVr2A0YLJnPFBrkpv8DCdCE8wtG07sxLw7PgzUQOfRq+zUf4R
 1RDfPGD78gZ7qoetAH11pcEbgChOkfR59RHPCpOhv8xm9EcjprIrLctLzqS14GM9ojGwic9KIl4
 wsRAfrtMEiUd1/z0jZ8BhaMcyWIJkcdm70Aohjyix9123Z4vvE9HYh+bq+i2WvCBuiqvA6Uz5u2
 KMv5qYYe4v5gbZUd8MjHNkEYAzjlQJfQMuIodaGtFtP+QDK+9Ikm6q/PDmNeGASyB4PPtUDojJ8
 ghW81E9mbbDZWKdpSKhCWYnWZb49cXL4uijCfae7AEylb7M6MlC
X-Received: by 2002:a05:6000:41d9:b0:487:f6e:e766 with SMTP id
 ffacd0b85a97d-4871e38375amr2654178f8f.56.1789728776019; 
 Fri, 18 Sep 2026 03:52:56 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm3673449f8f.32.2026.09.18.03.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 03:52:55 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 14:52:29 +0400
Subject: [PATCH v2 02/11] lib: Build xxhash in the SPL phase
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-spl-fit-compression-v2-2-28e946f57357@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2269; i=alchark@flipper.net;
 h=from:subject:message-id; bh=3q5TIdz9E2QhVRsVvYMZ8pjlWOl4L2EJzVrAfzly624=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWStFf87z2J79STXEJOFVs+yKi4xnt9QFn4qZbboe49Z9
 Z9WXUx90jGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUW+YzMjwNOSv5Y4mfeJ3Ogo+2aiv57C2qS6746966axf0+90k8SZGhhl82uV
 H6/g3qhvP8M9Lmz335arXr1/MfuY5IWvuyoS7EtwA
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

SPL_ZSTD selects XXHASH, but xxhash.o is built from inside the
ifndef CONFIG_XPL_BUILD block, so it never reaches an SPL link. zstd's
decompressor calls xxh64_* from code that survives --gc-sections, so
today the option only builds because nothing in SPL calls
zstd_decompress() and the whole library is discarded. The first caller
would fail to link.

Give xxhash its own phase symbol and build rule, the way the other
compression libraries already have, and note in the SPL_ZSTD help how
much heap the decompressor wants, since that is the other thing which
may stop it from working.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 lib/Kconfig  | 10 +++++++++-
 lib/Makefile |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 6b6b90bc915c..ec6f162dfb57 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -833,6 +833,9 @@ config CRC32C
 config XXHASH
 	bool
 
+config SPL_XXHASH
+	bool
+
 endmenu
 
 menu "Compression Support"
@@ -1011,10 +1014,15 @@ config TPL_ZLIB
 config SPL_ZSTD
 	bool "Enable Zstandard decompression support in SPL"
 	depends on SPL
-	select XXHASH
+	select SPL_XXHASH
 	help
 	  This enables Zstandard decompression library in the SPL.
 
+	  Decompression allocates a 94KB context, and nothing else: the
+	  single-shot API it uses decompresses straight into the caller's
+	  buffer and takes its window from there, so the compression level
+	  does not change what the SPL heap has to hold.
+
 endmenu
 
 config ERRNO_STR
diff --git a/lib/Makefile b/lib/Makefile
index b7272c6f0cba..ca2b4f5530ef 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -45,7 +45,6 @@ endif
 obj-$(CONFIG_SMBIOS_PARSER) += smbios-parser.o
 obj-$(CONFIG_IMAGE_SPARSE) += image-sparse.o
 obj-y += ldiv.o
-obj-$(CONFIG_XXHASH) += xxhash.o
 obj-y += net_utils.o
 obj-$(CONFIG_PHYSMEM) += physmem.o
 obj-y += rc4.o
@@ -87,6 +86,8 @@ obj-$(CONFIG_$(PHASE_)SM3) += sm3.o
 obj-$(CONFIG_CRYPT_PW) += crypt/
 obj-$(CONFIG_$(PHASE_)ASN1_DECODER_LEGACY) += asn1_decoder.o
 
+obj-$(CONFIG_$(PHASE_)XXHASH) += xxhash.o
+
 obj-$(CONFIG_$(PHASE_)ZLIB) += zlib/
 obj-$(CONFIG_$(PHASE_)ZSTD) += zstd/
 obj-$(CONFIG_$(PHASE_)GZIP) += gunzip.o

-- 
2.55.0

