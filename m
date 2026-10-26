Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC76606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RGDz/N2W;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=eJfy4Eol
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77FD74069B;
	Mon, 26 Oct 2026 12:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OqlvzrJ1sz3W; Mon, 26 Oct 2026 12:19:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E45AD40685
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793017149;
	b=mlQRUw17GNjnO/Emk85u6PmLlSBWwQJR7aO9oTSve7xwAb1pxZqY6P3M6H/ANbRP+p6o
	 l8l1RfS8PJ7ZOzSvI45HuSEE/scToKKlGZmxh/sDb4J6PzhYS1hei5ggOk0TYdeS//2hk
	 PTPUhLBHkghCfFYuUro340A9vZ6u+nEtXGjkF6a8gUXwHZivaoEWnuXAruSly2NM7eAXC
	 CEWR2C5y/6EPO0DWNml3iXx9f95VBS26ZRXNwk1mhwZ/0H5HrBrWgpibsnR1q/ej2BVvS
	 k4lsG5qqPMcX4bYP1imx1Da4HEsuuWqWR+fY35NrbO4+IFQm8ByR836JnYk6i7YbDEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793017149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=K2jFAEKWkENNtsCV3CcUqwGAw7ytDfhxgnsfKmwKD2M=;
	b=nC2xQIpNaLJ35AoT3/OwgmJTy3WU0CDo3doMFaFEGHLAMs047Yo8c7mhIX56jVG5cvuJ
	 2CSVvctGRcLPjPdoR11ScuhZZRTp6NfBnyTtzdwzwzHGhWVyODBR9HfHwElYFukRaHrRM
	 Bd/5FPfB0wLveM29p0TJbC4iTWVjLkyFDbNjaXx1Dlt3gHWS01rIMp3ev+dKL9Ge1RSOa
	 qhmvXueMVT+pZ+PbypMuzwoXz75mGZvMK27PPidsWqqRHB+4UwgoTCZHzjV7cnMVG3Z+N
	 iMTrQMNxcAJkevF+UmhH+l/OHMDceL0CNjt99Q91xYmlcMkidouHy4varcEFuKYE56A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793017149;
	bh=K2jFAEKWkENNtsCV3CcUqwGAw7ytDfhxgnsfKmwKD2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RGDz/N2W8qNxl3lbfFMHA6Qs98dfsnITpdmoJagDGcxvw/3VKtluOKlvt3Gas+Leo
	 7lWvQRNFebxU6loSP+odLUH4kQhBBGd/MrJVtTmBVJCvB7pH5DrInBqInfi/FUCaDj
	 Ko6QKeB3lYiSqmJvZK7lMWNqzP9c68y1+0t5ArY4WNTocntYPZqcaOmlwotpFQa4zQ
	 fXMvPtTWJ4/N6ZCKCN9rHItwf8FwD34VFR5abehbjDDY+oN9fZtOEE66bk6/qZXroM
	 GAl4fvw50Bti+hjzsf+LEZO9K6ky94q4SiQ4QsAFiGjCX/bYHvVdQaUeaLJuu+W/Zd
	 Ox50pT9L6oPRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E45AD40685;
	Mon, 26 Oct 2026 12:19:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FC5A356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35E3460604
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tv8JW5JUu745 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 12:19:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C5A01605D2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793017145;
 b=m9h8JxcEZukoueM5n0pDJjvWrEOPolvva50uQh9C9/rvlZz7LRfQ9DviuBtf+3SNmIKb
 D/9LxoHXi6TGegRvNVhwu7GPZAoFeA/O0w2jc0MLzGaefuxRqWo2eNVfa4aW13I2cJU2Y
 L5b99kx3AZ0KNb2b+GqHUqBWRIg+mHwrWYBNSzd+uQbqoTzn8LQYRKaZJGq73R9hgCWn6
 l+k5jxYRNER/N4ZdIHRgK3LhPQTgHUOtzW1txgLMPI7JN0+uS0Vrtu/A8NEi6oxOTiTR3
 J5foolWoPexGlk2oeIuYKRp21v5tR+x4YFhd/9JLLC+mdpjkF1x++08m/zhbu/54j1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793017145;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=K2jFAEKWkENNtsCV3CcUqwGAw7ytDfhxgnsfKmwKD2M=;
 b=jv4c57kuaoIkWCK3pVVpMUoNqDjCyjPHp5Ew/r5pi0bPA467foppdiaCHnqntmsZRNuv
 0Ta/mIHvpiLlebtxv6NBfs3fD9Uq0ckVa22KYz/VzuiKsD+6qEItb87Xf7jt/9kRM8se+
 SQnm18pPz5+w1ZoI4Q+hOInBvfENxIfLMFV3mzBYO+RAj+CZmutEM/hgUO62xL42p9gfa
 m7+dFvt5DjSFzec1pY79tPDRq3NsmGx9JB+qYXkAd13xX63JdgJUNiagPvqGLreTNPJ4H
 g06XCtgErsZBMKGjtE5Q5dG73ml5GOAki5AltrN1NLqozLsG6/Q6eAPorLBt2bFAjYA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eJfy4Eol; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=eJfy4Eol
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5A01605D2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:19:04 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6ac76a02368so3537603a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 05:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793017142; x=1793621942;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K2jFAEKWkENNtsCV3CcUqwGAw7ytDfhxgnsfKmwKD2M=;
 b=eJfy4Eoly+fCHfj1M2GfXt+Bgp5B9+hINMzvVwBKCzilSdtl7N/X1PHHqN0K5l2HB1
 1GadQvOy8fGbkpyX/9ABycySkotb0pTAVb8+mZQnwQV0FlbqrHwKSE2Rawb0PSxEC2t3
 N/0LAeXGcu7aTR+7jay3KDyjImquk28VJpSCt0hMzu5i282WnSNAYR/gfE09qXQ3LlTD
 sXozKPG27exPd1l4/nbQjRA2CRMGE14xH2jUL7cMxVCjEkg3qF2AWPPTVQ5sR/K4SuyA
 rktN6FLo9TLi0QKAPjt2fenMBuOUZaRL9s/WB1KglS8gZNU28s/+2g7PXuDLBm11SdXw
 J8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793017142; x=1793621942;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K2jFAEKWkENNtsCV3CcUqwGAw7ytDfhxgnsfKmwKD2M=;
 b=jDJnUoXRw7RmNIR/JnKpAvLyBJ6IDS9U5u5TUjRQs7cEG9F9Msdrgn5HhGxbp6TM+u
 oS69huArJsdW31xcj2sstym/glt0CfuYco/7XeTc706Ff86fvJ1Wvy3v7m8LzJzU55/i
 OQmL1W47Z7EbZ8qSu+h0a7IR/OlBosxtFUJMcWPBmR/cu2NXuHYmhDMPdZUPtnODdNkR
 3uZbFcNDSgO/XqKzeILITnqR/6YUsQDNMdFMUrZrDkvVtg0PZhJfWeD9QWzecZCx6GSx
 3Mi+u8AEvpiEf9LK7JP9ocUK1iOPBwSaveVKu72ANw413kxSlMP909lNaqklASQydd1F
 iLyQ==
X-Gm-Message-State: AFq9FYKswMHuubrF1dDA0or6lT+qRIt8HnZXTEYvp4Z7XBQM+IBhEzBL
 k/kZzjHzq+z7zQF7DQxhd8QEouXKDNGYYA9iYQ4ATKB5/FQ2QnoqDu0sgavIUwI3+/U=
X-Gm-Gg: AYBFou2N/PnDFCdPk7erTYtEn2kBch5iuV/cn8h5jR8kHyTBgnWguNGnOItxcKXDS82
 on/ESNNXQCSbO/eQbhXUMTeHYjH3SLkwE8q5SeSo9BhhfG8a3H7w1gkWVFh05sVXi/Mg6irpBK7
 HHM0uZ2m13NALi45sUOnc6vY2Bz3/f1gem5/iAtgjcbFFkNWwZrTQgqlpnjZbnCszZUt1rZHyps
 gmOgZvKiwIKgMEAN4oQTa/UkAsxd/wXaDC68WvRpsYfraJ6fptNFKvwTxUh0m0btPjBRf87X9+d
 PgDNfufKKRqi2rHJVxNi8/a6gi6ZD3Q5qDTrs2hLC7cIQ4QbAMfb4IYOxWpPrG+jUDZ6t6l7bnP
 xjE4KNLgyBdFLiSyageue8RMis1OyKIxyYXpnaKAcgpY2Jo7rsgANnbKD208leTVtwe+Tw9E0p4
 Lkvd3S/NdVgYJHBzztnfHOFNxO7VIuugFHabv+jnEtRqDsUBnJEamHdfXlh3JWJsYCIYURB8bTJ
 7EGp2Hq0y3xhrOlLMW3O5wYkdUYvvq26dvdK2BIh/4bjffvzUvxrCt50aCUY09cc2w1oWr4ScTK
 MkxZ3r47vssMZRD4jxOrkqXwvOXBjSSi19Vlpt/D5tVzTYqtgYNS7kkRQfZHeVuYzf3aAxcz09S
 AQFt7eoHeeR06ZdlziA==
X-Received: by 2002:a05:6402:1ed0:b0:6af:dccb:acbe with SMTP id
 4fb4d7f45d1cf-6b442a826aemr7654817a12.5.1793017142301; 
 Mon, 26 Oct 2026 05:19:02 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b467e42f75sm1452800a12.23.2026.10.26.05.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 05:19:01 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Mon, 26 Oct 2026 13:18:24 +0100
Subject: [PATCH v3 5/5] test: py: cover fdt fit preparation and failure
 handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-ccaione-upstream-fdt-fit-v3-5-6c5d86c3007f@baylibre.com>
References: <20261026-ccaione-upstream-fdt-fit-v3-0-6c5d86c3007f@baylibre.com>
In-Reply-To: <20261026-ccaione-upstream-fdt-fit-v3-0-6c5d86c3007f@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, David Lechner <dlechner@baylibre.com>, 
 Ahmad Fatoum <a.fatoum@barebox.org>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Boot scripts rely on fdt fit either returning a complete, verified
devicetree or failing without touching the destination. Regressions
could otherwise leave a script with an incomplete tree or overwrite
memory before an error is reported.

Add sandbox coverage for successful preparation and failure cases,
including overlay order, compression and FIT load addresses. Check
that verify=no cannot bypass required signatures and that
individually signed configurations cannot be chained into a new
combination.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/sandbox_defconfig     |   1 +
 test/py/tests/test_fdt_fit.py | 371 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 372 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f307972a762..cd44c42d954 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -65,6 +65,7 @@ CONFIG_CMD_BOOTZ=y
 CONFIG_BOOTM_OPENRTOS=y
 CONFIG_BOOTM_OSE=y
 CONFIG_CMD_BOOTMENU=y
+CONFIG_CMD_FDT_FIT=y
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_ERASEENV=y
diff --git a/test/py/tests/test_fdt_fit.py b/test/py/tests/test_fdt_fit.py
new file mode 100644
index 00000000000..3a039b32515
--- /dev/null
+++ b/test/py/tests/test_fdt_fit.py
@@ -0,0 +1,371 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2026 BayLibre SAS
+
+"""Test the 'fdt fit' command
+
+Build a FIT holding a base devicetree and two overlays, with configurations
+which combine them, then check the devicetree produced for each
+configuration and that images failing to load or verify are rejected.
+"""
+
+import gzip
+import os
+import shutil
+
+import pytest
+import fit_util
+import utils
+
+FIT_ADDR = 0x1000000
+DEST_ADDR = 0x2000000
+
+BASE_DTS = '''
+/dts-v1/;
+
+/ {
+	model = "fdt fit test";
+
+	test-node {
+		base-prop = "base-value";
+		order = "base";
+	};
+};
+'''
+
+OVERLAY_DTS = '''
+/dts-v1/;
+/plugin/;
+
+&{/test-node} {
+	%(name)s-prop = "%(name)s-value";
+	order = "%(name)s";
+};
+'''
+
+FDT_IMAGE = '''
+		%(name)s {
+			data = /incbin/("%(fname)s");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "%(compression)s";
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+'''
+
+CONFIG = '''
+		%(name)s {
+			fdt = %(fdt)s;
+			%(sig)s
+		};
+'''
+
+SIGNATURE = '''signature {
+				algo = "sha256,rsa2048";
+				key-name-hint = "dev";
+			};'''
+
+def make_test_fit(ubman, basename, sig, compress_base=False):
+    """Create a FIT with a base devicetree, two overlays and configurations
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        basename (str): Base name of the FIT to create
+        sig (str): Signature node to add to each configuration, or ''
+        compress_base (bool): Compress the base devicetree with gzip
+
+    Returns:
+        str: Filename of the FIT
+    """
+    images = {'base': fit_util.make_dtb(ubman, BASE_DTS, 'fdt-fit-base')}
+    if compress_base:
+        compressed = images['base'] + '.gz'
+        with open(images['base'], 'rb') as inf, gzip.open(compressed, 'wb') as outf:
+            shutil.copyfileobj(inf, outf)
+        images['base'] = compressed
+    for name in ('ov-a', 'ov-b'):
+        images[name] = fit_util.make_dtb(ubman, OVERLAY_DTS % {'name': name},
+                                         f'fdt-fit-{name}')
+
+    configs = {
+        'conf-base': '"base"',
+        'conf-a': '"base", "ov-a"',
+        'conf-ab': '"base", "ov-a", "ov-b"',
+        'conf-b': '"ov-b"',
+    }
+
+    its = '/dts-v1/;\n\n/ {\n\tdescription = "fdt fit test";\n'
+    its += '\t#address-cells = <1>;\n\n\timages {'
+    for name, fname in images.items():
+        compression = 'gzip' if name == 'base' and compress_base else 'none'
+        its += FDT_IMAGE % {'name': name, 'fname': fname,
+                           'compression': compression}
+    its += '\t};\n\n\tconfigurations {\n\t\tdefault = "conf-base";\n'
+    for name, fdt in configs.items():
+        its += CONFIG % {'name': name, 'fdt': fdt, 'sig': sig}
+    its += '\t};\n};\n'
+
+    its_fname = fit_util.make_its(ubman, its, {}, f'{basename}.its')
+    fit = fit_util.make_fname(ubman, f'{basename}.fit')
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    utils.run_and_log(ubman, [mkimage, '-f', its_fname, fit])
+
+    return fit
+
+def corrupt_overlay(ubman, fit, basename):
+    """Copy a FIT, changing the data of the ov-b image but not its hash
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        fit (str): Filename of the FIT to copy
+        basename (str): Base name of the copy
+
+    Returns:
+        str: Filename of the copy
+    """
+    with open(fit, 'rb') as inf:
+        data = inf.read()
+    assert data.count(b'ov-b-value') == 1
+    out = fit_util.make_fname(ubman, basename)
+    with open(out, 'wb') as outf:
+        outf.write(data.replace(b'ov-b-value', b'ov-b-evil!'))
+
+    return out
+
+def load_fit(ubman, fit):
+    """Load a file into memory at FIT_ADDR and clear the destination"""
+    output = ubman.run_command(f'host load hostfs - {FIT_ADDR:x} {fit}')
+    assert 'bytes read' in output
+    ubman.run_command(f'mw.l {DEST_ADDR:x} 0 400')
+
+def fdt_fit(ubman, args):
+    """Run 'fdt fit' and report whether it succeeded
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        args (str): Arguments for the command
+
+    Returns:
+        tuple:
+            bool: True if the command succeeded
+            str: Command output
+    """
+    output = ubman.run_command(f'fdt fit {args}; echo rc=$?')
+    return output.rstrip().endswith('rc=0'), output
+
+def get_test_node(ubman):
+    """Return the test node of the devicetree at DEST_ADDR"""
+    ubman.run_command(f'fdt addr {DEST_ADDR:x}')
+    return ubman.run_command('fdt print /test-node')
+
+def check_dest_untouched(ubman, addr=DEST_ADDR):
+    """Check that nothing was written to a cleared destination"""
+    output = ubman.run_command(f'md.l {addr:x} 4')
+    assert '00000000 00000000 00000000 00000000' in output
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_fdt_fit')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+def test_fdt_fit(ubman):
+    """Test loading the devicetree of a FIT configuration"""
+    fit = make_test_fit(ubman, 'fdt-fit', '')
+
+    with ubman.log.section('Default configuration'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x} {DEST_ADDR:x}')
+        assert ok, output
+        assert "Using 'conf-base' configuration" in output
+        node = get_test_node(ubman)
+        assert 'base-prop = "base-value"' in node
+        assert 'ov-a-prop' not in node
+
+    with ubman.log.section('Overlays applied in order'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+        assert ok, output
+        node = get_test_node(ubman)
+        assert 'base-prop = "base-value"' in node
+        assert 'ov-a-prop = "ov-a-value"' in node
+        assert 'ov-b-prop = "ov-b-value"' in node
+        assert 'order = "ov-b"' in node
+
+    with ubman.log.section('Chained configuration'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman,
+                             f'{FIT_ADDR:x}#conf-a#conf-b {DEST_ADDR:x}')
+        assert not ok
+        assert 'Chained configurations are not supported' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Length'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-a {DEST_ADDR:x} 4000')
+        assert ok, output
+        ubman.run_command(f'fdt addr {DEST_ADDR:x}')
+        output = ubman.run_command('fdt header get size totalsize; echo $size')
+        assert output.splitlines()[-1] == '4000'
+
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-a {DEST_ADDR:x} 10')
+        assert not ok
+        assert 'aborting' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Missing configuration'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-none {DEST_ADDR:x}')
+        assert not ok
+        assert "Could not find configuration node 'conf-none'" in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Corrupted overlay'):
+        bad_fit = corrupt_overlay(ubman, fit, 'fdt-fit-bad-overlay.fit')
+        load_fit(ubman, bad_fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+        assert not ok
+        assert 'Bad hash value' in output
+        assert 'load of ov-b failed' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Missing overlay'):
+        missing_fit = fit_util.make_fname(ubman, 'fdt-fit-missing.fit')
+        shutil.copyfile(fit, missing_fit)
+        utils.run_and_log(ubman, ['fdtput', '-t', 's', missing_fit,
+                                  '/configurations/conf-a', 'fdt', 'base',
+                                  'ov-missing'])
+        load_fit(ubman, missing_fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-a {DEST_ADDR:x}')
+        assert not ok
+        assert 'load of ov-missing failed' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Not a FIT'):
+        load_fit(ubman, fit_util.make_fname(ubman, 'fdt-fit-base.dtb'))
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x} {DEST_ADDR:x}')
+        assert not ok
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Usage'):
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}')
+        assert not ok
+        assert 'Usage:' in output
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_fdt_fit')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+@pytest.mark.parametrize('compress_base', [False, True])
+def test_fdt_fit_load_addr(ubman, compress_base):
+    """Ignore FIT load addresses, including before an overlay failure"""
+    if compress_base and not ubman.config.buildconfig.get('config_gzip'):
+        pytest.skip('gzip support not enabled')
+
+    fit = make_test_fit(ubman, 'fdt-fit-load', '', compress_base)
+    utils.run_and_log(ubman, ['fdtput', '-t', 'x', fit, '/images/base',
+                              'load', f'{DEST_ADDR:x}'])
+
+    with ubman.log.section('Load address equals destination, bad overlay'):
+        bad_fit = corrupt_overlay(ubman, fit, 'fdt-fit-load-bad.fit')
+        load_fit(ubman, bad_fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+        assert not ok
+        assert 'load of ov-b failed' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Load address equals destination, short length'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-base {DEST_ADDR:x} 10')
+        assert not ok
+        assert 'aborting' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Only the requested destination is written'):
+        load_addr = 0x3000000
+        utils.run_and_log(ubman, ['fdtput', '-t', 'x', fit, '/images/base',
+                                  'load', f'{load_addr:x}'])
+        for conf in ('conf-base', 'conf-ab'):
+            load_fit(ubman, fit)
+            ubman.run_command(f'mw.l {load_addr:x} 0 400')
+            ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#{conf} {DEST_ADDR:x}')
+            assert ok, output
+            node = get_test_node(ubman)
+            assert 'base-prop = "base-value"' in node
+            order = 'base' if conf == 'conf-base' else 'ov-b'
+            assert f'order = "{order}"' in node
+            check_dest_untouched(ubman, load_addr)
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_fdt_fit')
+@pytest.mark.buildconfigspec('fit_signature')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('openssl')
+def test_fdt_fit_signed(ubman):
+    """Test 'fdt fit' with a required configuration signature
+
+    This restarts U-Boot with a control devicetree holding the public key,
+    so it must run on sandbox.
+    """
+    keydir = fit_util.make_fname(ubman, 'fdt-fit-keys')
+    os.makedirs(keydir, exist_ok=True)
+    key = os.path.join(keydir, 'dev')
+    utils.run_and_log(ubman, f'openssl genpkey -algorithm RSA -out {key}.key '
+                      '-pkeyopt rsa_keygen_bits:2048 '
+                      '-pkeyopt rsa_keygen_pubexp:65537')
+    utils.run_and_log(ubman, f'openssl req -batch -new -x509 -key {key}.key '
+                      f'-out {key}.crt')
+
+    vboot_dts = os.path.join(ubman.config.source_dir,
+                             'test/py/tests/vboot/sandbox-u-boot.dts')
+    dtb = fit_util.make_fname(ubman, 'fdt-fit-u-boot.dtb')
+    utils.run_and_log(ubman, ['dtc', vboot_dts, '-O', 'dtb', '-o', dtb])
+
+    unsigned_fit = make_test_fit(ubman, 'fdt-fit-unsigned', '')
+    fit = make_test_fit(ubman, 'fdt-fit-signed', SIGNATURE)
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    utils.run_and_log(ubman, [mkimage, '-F', '-k', keydir, '-K', dtb, '-r',
+                              fit])
+    bad_fit = corrupt_overlay(ubman, fit, 'fdt-fit-signed-bad-overlay.fit')
+
+    old_dtb = ubman.config.dtb
+    try:
+        ubman.config.dtb = dtb
+        ubman.restart_uboot()
+        ubman.run_command('setenv verify no')
+
+        with ubman.log.section('Signed configuration'):
+            load_fit(ubman, fit)
+            ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+            assert ok, output
+            assert 'sha256,rsa2048:dev+' in output
+            node = get_test_node(ubman)
+            assert 'order = "ov-b"' in node
+
+        with ubman.log.section('Chained signed configurations'):
+            # Each is signed, but no configuration lists base plus only ov-b
+            for first in ('conf-a', 'conf-base'):
+                load_fit(ubman, fit)
+                ok, output = fdt_fit(ubman,
+                                     f'{FIT_ADDR:x}#{first}#conf-b {DEST_ADDR:x}')
+                assert not ok
+                assert 'Chained configurations are not supported' in output
+                assert 'dev+' not in output
+                check_dest_untouched(ubman)
+
+        with ubman.log.section('Unsigned configuration'):
+            load_fit(ubman, unsigned_fit)
+            ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+            assert not ok
+            check_dest_untouched(ubman)
+
+        with ubman.log.section('Signed configuration, corrupted overlay'):
+            load_fit(ubman, bad_fit)
+            ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+            assert not ok
+            assert 'sha256,rsa2048:dev+' in output
+            assert 'load of ov-b failed' in output
+            check_dest_untouched(ubman)
+    finally:
+        ubman.config.dtb = old_dtb
+        ubman.restart_uboot()

-- 
2.56.0

