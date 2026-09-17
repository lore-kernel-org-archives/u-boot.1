Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B34C982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0627F60B0E;
	Thu, 17 Sep 2026 14:02:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X5RCpp1nE2JB; Thu, 17 Sep 2026 14:02:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3B520608B3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789653773;
	b=BXmkCTpt758qRX9yBc7MGOQ9Tsqt1lCT5tByD8c/gzFjc0m1tkvsa8bpzlMmSP9FYfz3
	 9gI+uxxE6yXCyYkHs3wr5LU+jIZWRxCkRme0k9eY9J0eb6K8wxrLN9PCRT4HwZ6qFq7NM
	 Q/y/D+uj5ie/kI+iE7i3la2eGzhzkpQ5Ncwrmkro+lhJgH7Tpm+CPSPiVpcmtTmP1bLeA
	 fy+o2xrLZ1I8kOM/jCk1Wm4xbSjirJvDwwI9mV1/s5Z5SCqn765ajpkalfhyldQeNIJxm
	 RdfEvxGsxXarNKPbVszT4kpVOG2FcR8hJS0rFc6dLTDInPY58kaWi16WRaYHuyuqRcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789653773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hNbp85aXmtGJ8uJLBV41pSUUOpE5+2SG9GFSl6Z8J+k=;
	b=B8tYU/Rh/pYMaBEssAZ3IdV2rtxsy6Twz2M7SuACqEPmvnOLrdEAO2zMFl8i15w9f9rb
	 Gbf5lUgYxd1cKc3PbufPMq6kiy3Vp5M9k8rJxQLSUjtORKoxd84/+hNNkKtB5TZOOEs5/
	 bYGQfrlEa0aOTm0QUmFJOgKHUI88Ci10ijL+48zqcgARlGEGg/bpVqu8O/W9z9R1GmMjA
	 HENlKNpnQin1IKBmYlcrcy+eq4H00DJrMLRsJKljtJ13zsr4zCEFuRuwGDXg0ViGUWRuf
	 dr+hk/0UPiQ31rns2ios+qI0lihMuiRVYTujsiAC9i7tTsXQwlYIwPwW9LVWd3aMZaQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789653773;
	bh=hNbp85aXmtGJ8uJLBV41pSUUOpE5+2SG9GFSl6Z8J+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vJm73QQhSIHU6AcbSRVlLAi5eVOdTLPApWE6gZawRpVRvII+j+pR84SZQbe9U1EDR
	 Pq7yRjnWULsVD6kECc1KVj7kxuNYyY9FGip5aOZsh3e4J0JDjT5Pf6Fs87Bxsni962
	 s1aUTb09I5FKKqSDnfi74dUjeVHPT9jpCdzswnyNcdHiB8Zx0GXHzOPEyyV2fcSfCs
	 MYpDYqsG1Ng9xItECOnpFHFurBhyMnpZLz7nr9Unc1Gth7NZcA/iz0ZtgjFObvurJ8
	 eOPYl/U+NqZ/nieRw/eSCVVCXWR6lKDTTVlxqZ+rzPeL6kuC/kxN8zdK3cRbpd5u2j
	 MeT5vmUVuNXLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3B520608B3;
	Thu, 17 Sep 2026 14:02:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A258F465
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 885C780A54
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KzLfNiPl0On4 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 94A5080F3F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653771;
 b=RyuTpZ1lI2ZJW8XTcxkw4Hlyf1PgqGx01aM26A+hJA8Y75pbygKrcCRG2EBJgcc/xU7K
 N+WWHzsZSv0qNhXgpAS+aSM3Y2IsG6lp44+RLdkw14UvGA4Ck0MwzpAUAfKhWr7Fucsw2
 +dVWeWnLRbE5Japq570DmpIy9hrHjiy+LUfvnd1TkdWuA3fEMByo71EZnBh4Haha9Lbc+
 A82XaH1+or8bo3G3iODORxi/9v8ylq53vV5bzHlM0uCnuP3tHnZxqMH8RpA/gvaOaPGt2
 68xFZfwp6DVfLvcz/70HjyFxwG+jiiP8g48d52b03yW/V5elXEfDnTyRwi66Aa9J5nQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653771;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=hNbp85aXmtGJ8uJLBV41pSUUOpE5+2SG9GFSl6Z8J+k=;
 b=hIb7R/7M5UEta8TPgF/68xMBO+gcOHZT4v4d7/Ar8KtcMtGiYqfv05mJ8ZM8t+iT++st
 2qb1ZmYpX5ogL/2Q+wgQAETufFx2MR2gvCY8vHXvnACjyKrnqbT+0SwcuwXp37eHMuB1K
 f/JgbGuaPsb6mJifeCs4FNi0w/bJgv8Mj8E/FwVxz9KnUdGKYTAnEQvW6FwtcXOB3FhMs
 1jcqiIwU6EwLlFjvUnvcEK5NsvyKxJzaGl9fDzRNJjROIp7/Os7Pzw7xODGXlJF9jCYel
 wSJKYImho1Ildb+CT3YHFTlBh93HCFO9sNwfhvohzVC8euET9A0GL+iSeeaKT1XfiRQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=p+cw9Zj2; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=p+cw9Zj2
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94A5080F3F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:50 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so527634f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789653768; x=1790258568;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hNbp85aXmtGJ8uJLBV41pSUUOpE5+2SG9GFSl6Z8J+k=;
 b=p+cw9Zj2K0806SdhFEtff8BtTlMpU4CvSOa+o0GI3kPmmdG2ARN836viLQKjafxu8Q
 CvI9kuexM6K89Rv0vZ0JbNwr9kEjWiqOfcczhLR2AFKwQfIIz1JSLIr9nC7r9U2ZShLK
 B5Vw39vNvrduy6ahv0C/B4GMOItQgg7vLz/9PsQJke/JTpqqNpYvIdvG6j0wnNOp75JQ
 g/aWl9KetruN54lFOI85P7rf319mbotlvC9ymcnQhDdgI74DZ8fyyoDi7Ig+EI2m867/
 KWHBZt/fM9ICKwVcBhgwNTIZU5LnHX1mIiucgfrUqF5SV2cEkc8G63uT8MJGszWxX5N+
 6WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653768; x=1790258568;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hNbp85aXmtGJ8uJLBV41pSUUOpE5+2SG9GFSl6Z8J+k=;
 b=cqy/ATC6R/tHIwWZLo8A04oxUV7luk1QUcwmhkf97pl8vHUtnSjudtiSdA9F3itL3P
 bS3UBYq58PyWad9kV29NbItvL1lisLr6VFLFT9CBogjN4RHsaC33nTsbPRcVvMY4kgTs
 XZeCqPHu6zUvHBGHuglAX1u4IaIZj7ZcL7iC/Bi0rYaPU5MSANETGhy/yYqaV8o1du6C
 8W0MMG3KKb6MEInNf8IeiYJaQZI+Pscr4ou/52WAb+3CqYQDbThcpwE9S1LuWK0O4W72
 UelyaPiGPStxb12QhUy7tJvEiks4UoL6f3MCmzbpdK2W6H89p1PICMa4KRWjZMc0Nrc1
 av+w==
X-Gm-Message-State: AFuF++nukDUuCc8bSxeF/ysCDxkl/xBDZzCd5f6ZHjs56hDhHDDF9Zwn
 u5i7Yej2wAzDs6ooaHCVWlZPNavbh9472rPvEHQSnm8vdistXDPcPpvOUyYTAuC/7IE=
X-Gm-Gg: AYBFou0wlcoQSDZWphNw6qOP2Bi6lB+NtPKFQPOt3E3FUHQDiYkQRUVFjQjCN8lZs81
 4RW247zNxAsiUhIwQNKQqBoKeyTb5+oK3zwdOkxasUS03dvB+MYBSMNQ266ClampavQBZdcTeIs
 ydLHv6kQbHpp/p4LN6cCael0vyU5H6Oa/e6zYnZzoQ40dOVNJMIR7tCpqpR8uAWHMiXYe5BIkFC
 ApspOIRpsLh/e/EXfJ/JGikrNf06ujvZls8nGDMQyx5Le7e1GGghAi2txqY7671BqlO/Bw/p7/f
 iE40cOB6+nNJTWXuVn6IxdrDM+7NxE3EowXaWRRi6G2c9dL/El4ODCK/gsp39EGbbr3Iv15dBIO
 s4YZE7UvDUpEBydKL50MwN0GlaKVcMdQwFDSpkluG+6+kOtZJLJfUWAqyZsisHwn+emNNV1pkqv
 pbMzeHhAxfqLdTezPQNtixSWKeSunIpqQOZk+DVUx+n9AFpcTlCwP+yh0DJ57MuoF5Q2mpf0wtQ
 J9qohjLO+TcFtvUaNq40k+haj3UgMPZAK9GAcuJnNTxMYO8saYM
X-Received: by 2002:a05:6000:2902:b0:487:1100:48d0 with SMTP id
 ffacd0b85a97d-487110049a3mr12006841f8f.7.1789653768149; 
 Thu, 17 Sep 2026 07:02:48 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16893905f8f.26.2026.09.17.07.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:02:47 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 17 Sep 2026 18:02:23 +0400
Subject: [PATCH 02/11] lib: Build xxhash in the SPL phase
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-fit-compression-v1-2-7985ac56ee9e@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369; i=alchark@flipper.net;
 h=from:subject:message-id; bh=5dMzzH/l/ZYKqIT+rShp/WTriy1BxNWpdLXWm0K5P0A=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt/vTrY8HtBOvNsUmcM37yPvjx/HB6aUl0baWYqLrMQ
 UXf2ZcZOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqpqMMf+Wtssv6A5InKS7b7Wm7Vc1YoMHmpGQQW9/SiWZNVgYLfjH8L/DwlA1
 8k/06aFpGyLGtW3Xa3kmen/Joq4prbe7v55/UmAE=
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
 lib/Kconfig  | 12 +++++++++++-
 lib/Makefile |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 6b6b90bc915c..6e6df5b3b191 100644
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
@@ -1011,10 +1014,17 @@ config TPL_ZLIB
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
+	  does not change what the SPL heap has to hold. With
+	  SPL_SYS_MALLOC_SIMPLE that memory is never returned, as free() does
+	  nothing there.
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

