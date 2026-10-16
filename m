Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DD6CCA48B
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 08:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4008540A0B;
	Fri, 16 Oct 2026 08:37:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wu3YUrOJFbMI; Fri, 16 Oct 2026 08:37:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A35340A0C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792139846;
	b=oP9/6rOTz5DkLo4WxQIj0ZpcbYK3g8K2akQxw3lKzgaaNdNDSJUduGkssOeWLRYL4gk2
	 8EG9TbPUiVesdqK63qSpoydiKt+hlx/VQG8XAjokmeiyyGOWcMJvfhWbCzN+Nk4k6ksOm
	 FcILWzVfyw6QGOn7b1hVMYuiOKDvqv+np6RVxmt/w0WzNL1Q+cVUj1cv/L7Nij7Gg6GDF
	 z8/M2CnEulF4U0ZV4t2soax7Oh9fSWk8UzOkA/l+yPlYFnO+lJzYxu7Tr3+q+eO8NQMix
	 w58FuvO07PjcTUsXJEyt5lzrk3fhfXu3mSq+Pzgb8KwBXrluOKNEw6cP6owsP0SYJFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792139846;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=PfKGsiUHOEPjBGW76urbQ36WCRblW9/57RWPg0hEXCk=;
	b=ASie83f8ELmnosQ4EkaOWcm1EQg6XkCIjcn543i8y/OSQ5BcpyQJuIWYoWlhxfA8X5CA
	 asbe+jZOq4AspJTdo0uVUpl9B4TkhIFLvqEGbNP8k9hy/Kh2ZVM1hsGKSXcUuCZyx4+6D
	 487tlA1cjEOMupuhGVPLnJbKKHt5oTkgx4hvqWUbWhLRj3XhTTvd6ZEm3rVk40FYuO0Cg
	 wil0P2p9k0t4DH7RbLC6kLlB9fD+ur4y6ehMJKAN8P4tPsmhtzrTyd4mYqCwIy1i03lVB
	 8t1vvKU0qpV6vTqEsRjd7ihYacAVQRJMkrOu6i23hD8GK7+DZeBOsh3R12KEtPInL5w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792139846;
	bh=PfKGsiUHOEPjBGW76urbQ36WCRblW9/57RWPg0hEXCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L0Vnre6mA6/63E8Ru6Y+S52RG59IETPT8p0cQLG4J2mOwV0/xXZ5PpmGKWQQHmshY
	 SUgXVcoMWV9oyNWZvh84SL8ZHHVVwS7/brBVnJ88D71nIebhR0NUcfj2BFEfzTFrUt
	 bIHhVSKfHmQv4cNZ23ndR8IEDcTP1QtFeBJi06jJd2XoIJY0CkS2UYQ8ZZqLLpYKGJ
	 SVvkhR+FatCCpBfwdZ1OvLzB83yJ7gciw3I2BJ3uOWjVdijeJbjdb+knMdT7EfPLI7
	 lOxi/1MNqs6qDqASNL0DmSdgN+6jPAYGro2GWlcq0eOXcpKfOHxybV2avns1UAZ65u
	 hfM3lKsz44WtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A35340A0C;
	Fri, 16 Oct 2026 08:37:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CEDD79D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3DF0A60A73
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fTtAWoFqxreN for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:37:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CA05060A72
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792139838;
 b=s9Y9xiXJuBe3h3OyjDW2HbJKQKOHNs0MJZgv12D3tF+qkGhmJ9cu1mk9TEJcyKc1Blxe
 FKi+V3Ti4LI2uzC070hPuChH4/3SmLDAiTFSEDusPiM6fp0jOU73g5tBshpKgNvfgAfYL
 mhfEyWatuKamKO9wjub/dwrctIJ1FnCGRVmXg7WubZnw5i+D3spC+deofJoUFH5Vh8I0E
 42NS+gEhb15fb156xBF3QyTtCLYwV0QtNz3OOmQgL+3PyegPcXn+idZZtocHLtRGNpMhn
 jZLhGmVl+Bd5oi2enhA2DSWjJHyjfbWp7o36XwmB5tu+yb5Qo24uk/UXpoc9LzMN05Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792139838;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=PfKGsiUHOEPjBGW76urbQ36WCRblW9/57RWPg0hEXCk=;
 b=cO7FYoh/S/Y6pFJbwH8OY6Ql10do7fvGddP0uRdKmcb0lPah6aOylySrtFmAs2kOAUCS
 TXD/EatmJ9mxgmhUzmdAWpQqbzhJqrqDL1NLRQD95j3DPnddLp+7qXc0XS0jry5fREgAQ
 AeoENTXhl+zByGUdoYikyORubbjcn5T4GWzpr9TX5MBZfuLRl7RnFYUKz/iySiDEGB42g
 ek1eGFBDJakuYyb3YP1udaUhFwoLy/MtWNONVkadG0oqlWWzJVgTIUCiTFNgZpWOfX4BS
 5cRdfQG1/ceDBvwHdtrMV9RBbm5Y6shhkY9blC+CwoNBZLY6FG9gR2yQDSUTt1JzI0w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JmAaTPqC; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JmAaTPqC
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA05060A72
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:37:17 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48c6955a7c3so1804227f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792139835; x=1792744635;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PfKGsiUHOEPjBGW76urbQ36WCRblW9/57RWPg0hEXCk=;
 b=JmAaTPqC9YRvoRhLLh6QyL55Njtvf0hXr+1VuO2KdGZ49PjvHHO82bps1MeGiUCO//
 r0l3WLsnJtY/Oor6IU1CDGnmIOR/A//anq7ikI/CmicOtltOtghdtVsQnul98bXjMiLR
 6DOO2duiTpeJp4M3FYO+IHZgfdXq2SC52KjNJuYsrR5HaLBsgjWTZFiAexvuegXimh2E
 lJB+yUQIDE5pJwScHgsFGkrxhmVOLDuSsPytPnkytYjqhxUTgl0mr6mxD35JBWer+VrJ
 MPn+YKMhcu2BhVj1R0Cjq6x0yKdm9Z5FjzPrHWUYb8GF5/rY3zHE/6S940FDauzOuTsj
 8Faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792139835; x=1792744635;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PfKGsiUHOEPjBGW76urbQ36WCRblW9/57RWPg0hEXCk=;
 b=qgJVFk5FZ7QwgRL5jEloueSWxdmDscWtT9BTHvD+NTT9yV/U+jwmYz4O95kLikMSfv
 OTeroK2UgoZnMJzG8xY2iGhd/n7J8zwMyZE/0RrxlJU+QV2X8DcisVizWLzZuPvZnKCa
 Efsov5YkXTjEJJ88I5Fas5tnGkTCDjdGC36dnXYBZB9/RRmSZKkmX4RtpIpeP+QzYKdl
 PWUOM/rAnA7qepSoR+YBS+XLT4kcCDujk601KUWciSJQYzoyCkSKRbxpteOq6KW5RWfG
 P7Ks6j/J0K1uh8kGx2u6SBdCpV+GOkOtoF4zebyPnJlyvgJ+w0dVZjD61nnvq7IiL3tz
 oqRA==
X-Gm-Message-State: AFq9FYJ+SIe4whjZQkuEBo+79lDrrYOy3Pw80HG9XtidRGw8i7VX1ubF
 tV+ylF3rbe6xnMBRXSDp0wt9cPirPCazM7MO+oouibANQflTumkr+k3DFWPFvk83uuA=
X-Gm-Gg: AYBFou0lLvicpPKRJg2O3SmXRUuHuj5FTjAhdlIvm/14gTIEURXKahFH3BBNAiYj8bz
 X9tsnoIT4ZfgC7qbJBRmHZCTyELAt5KdUuKwJsk6P0gFsbr3/Mp5Y9j9EjZlapEl2lLdPUNneIB
 JSbDpCw1sDAU8EEWvslb4Ummsq54M/YBf8xYGmBSsyf25YrhfuPEvwa0UH5qYpNQbLRkg5ofOC6
 qeutI2CyyQZ9upoa8Gg4VV2KITxI0w/Y2MsaoSaYKOqmqdMcAE8wk2aSekl6l1c3nwKVgFkFbPS
 6P3xFe0N7xeMEDsw50JUDdTcCE1/T8K5oYQ7W5Y+9ISy/helYDTGHRx50PgSG1A1l2a6BFzKoWR
 W0gpduB1tIUvM0joJKjjUZbqMYvw/F3H6TCQdd0Fwy19O5ljQbn0CpyfgJwXiu2QAr42nl9lpb3
 M7SUf6u4Vu3aDQJIjvv/e7QFBmqpcjcmml2l3u/Q7aZTwXTAfE11mKCJmVJFjVx96PZScxKSEmA
 qrumOWlWqIRQ8XQRzzmXNHFhapio/GlezihZ/IQg2zsJdJSpj4FcBHEssVCgB1o6xaN/9C3Ndy8
 afFsw0yTR2m3opQ=
X-Received: by 2002:a05:6000:3102:b0:48d:ca32:e90f with SMTP id
 ffacd0b85a97d-48dca32e9b5mr33753410f8f.55.1792139834974; 
 Fri, 16 Oct 2026 01:37:14 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a1fsm3100727f8f.3.2026.10.16.01.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:37:14 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 16 Oct 2026 10:37:03 +0200
Subject: [PATCH 5/5] test: py: cover fdt fit preparation and failure handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-ccaione-upstream-fdt-fit-v1-5-f6286ef82364@baylibre.com>
References: <20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com>
In-Reply-To: <20261016-ccaione-upstream-fdt-fit-v1-0-f6286ef82364@baylibre.com>
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
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>
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

Boot scripts rely on fdt fit either returning a complete, verified
devicetree or failing without touching the destination. Regressions
could otherwise leave a script with an incomplete tree or overwrite
memory before an error is reported.

Add sandbox coverage for successful preparation and failure cases,
including overlay order, compression and FIT load addresses. Check
that verify=no cannot bypass required signatures and that
individually signed configurations cannot be chained into a new
combination.

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

