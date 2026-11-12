Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A08B606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OjR14Xek;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=l/1sQg+b
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3508C409A3;
	Thu, 12 Nov 2026 21:16:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mu5XL4CVOl4f; Thu, 12 Nov 2026 21:16:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C41334098E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794518193;
	b=IE4I9NANgGVInnlWmE3UPSP7e3vfzPNXAhZLMjkG6CtAFMRH3RJ6z+rghTmLE6jg+gYH
	 rSCZCdfIpl8GuaVzeoM8fotvChby6HmfyQ06rU9gg/nWjKHyLXIU+N2Mf8Hr45WJDMVHj
	 s4riL05IS58zstTrUGAcEQxS+ezgc4nogaUo5Vhk8m/XgRiTGFtqgrUINbz2ZsmwNMvAp
	 5yj9Hr9LLpoFKBfrmEWNt7U+bD9FHxW4uAu1uyUw3FymuGtFfYBMHGDScnucXr8A6yXeP
	 b2fxsxGjzIvVQ5xKNZmyWE3CPA/KGYii8EnIbtIqqcfokCyM5aUNTLjUbaqRQujgAmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LStGKHXri9aITLhboDgSMw0zibRmhTR39FrPgHG1mG4=;
	b=AqVrv8C+POoMgqG68omEhf5V6ZeyceR+lkN/OqKmlYUk+CB0bwTyLhUmUuA6jpMwy/0L
	 co1qOOoL3rWD85RHOK1CSA8b+LvqQIPUqNbjuKUiE+U5ynEFo2M9hwXi7R28SI0xtZ4aI
	 sduThbxmt4DYYqxj9TbCe15nA8exkiDIo4bpQO/DU4sgJE2Q+1JCSEt/sXQ5kALf7o1nG
	 Jw5ER74fcAQshULQT9yuj7E0VRLjxDxXowz5HW8hDWKXWdXnBjcXTmG9wAsHkavp6cE4Y
	 bFxrTb+WweDiFcRniNrDHjm7pCiG4NDfbNYXrmvbrrymwkkcRqoVpYE0ZXRC5WQkMZg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794518192;
	bh=LStGKHXri9aITLhboDgSMw0zibRmhTR39FrPgHG1mG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OjR14XekI+WhPpfmeXJ+xL3e6MvdbpUZnyo3gH2+Mv/WKaQoyBnooYNW7nQcJdMbB
	 HLBhLAP26Yn86yiVd6sn85GRTs/98WlbbY5oJ/xNzypKFj3K76YkUutqJx5sqvE7rN
	 5SA6mEwgxSXXXzMp2J654pZMsmKO7U5MmTJAj9SiRX9wgHtkrMjU+T2B+9SDNg8a7i
	 vu5znQfwU+bjjNFszHBDZ4HbcAo1v4djgA6YlOhRhnbu6yGuuxiG8keHLMA+k0/OY7
	 HStJFN6u5zoxMIskE7JsBGeaUipqSNhNzCIOtq6+trNe/RNkJu5iKtHWxoVtdt+0K/
	 5dmQ4cEmXiyDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C41334098E;
	Thu, 12 Nov 2026 21:16:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40E781790
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26DDC606BA
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-CUlBIyS1mT for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7432A6063E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=l/1sQg+b
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7432A6063E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:28 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-844a8bf7e25so224570a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794518187; x=1795122987;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LStGKHXri9aITLhboDgSMw0zibRmhTR39FrPgHG1mG4=;
 b=l/1sQg+b5AuQ6w3/xmoR0d5Ck3msvCJhYid0CAByTufczTD3KCpEEUZxVnXs0oWE7e
 ANkRObI+COkZl5IC32sCwmIgEzsA4OL1ukclxeazuFFvd8FFalY6TtD3n726VH8M+6BS
 77ljdMmHjL0pM6SezGkLcVijBgyXbKCnmkTnLUShmm+45DRi5VZkfMZPsPufhUZiWCiI
 9K/aNO6drznapzAQPbu0GK0fJO4ql47g8AQA1osbwPofFWK7Imn/zUVzHyK8Ru0bUN8k
 vNzIZOk6/x9RU8ldtuy8bAqNxLUhPRjCjwaHQc+G8DY8ymIRzz3hOBXZBFHGpQmNX6ek
 bBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518187; x=1795122987;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LStGKHXri9aITLhboDgSMw0zibRmhTR39FrPgHG1mG4=;
 b=ntLl/B3z9ETzp2pdtC5tWuYYk4vXKy8cL2II0RmHa0n7aAMZMhpntWJDjWiSfJzqKD
 wAIyXCn5jpmh2B5fhnEDVICvAUrem5BT0lW2dpEFoKb1WgH0sM85VrELISBlffkpOqX5
 UM8B+sXGyIGpN1cczPT1ZrPYLvyWBE7aa5h5uNzuAImUElhKkUhJw2x+gbXC6aZCBjyp
 yplzS6tVMewDIiRiYNojiWXyd/bMZW+l6Fyj+SDJl4X3+NR3BXbzXmwJlbb6mTW3MovB
 thZjgO21kh1lgPD9MmRnqnuLdBIZ9ZW9B6AZ+l5RfYq+VisloG9hfuBZ2262m8itP5lW
 7prg==
X-Gm-Message-State: APuU4Z9uk03zevQu3bnzEqFCczyCQrKi4zsziyHHB+iFeksbx+33Blwc
 jo9EYorsN3tv7zDMtZYVs2XrZVuEQb7tV+nmE5RBaE23PfrXmYPczRUz8aIN89ZoWCs=
X-Gm-Gg: AYBFou09dS2TTRJ5d2i98oEgEta/YjJyr/VpB3OwqQtBu9BGOuNfs0+FgWYaXKSn1Dn
 6gtDFmlSKVOKQwj8nswFK6fLBXqJnWIk1t5GShG+Idw6sC5Qn2X8XMJqs8uXpQ7AAdcmwC61dM+
 phVX/9xp9MXHHT4SY74+8ETM0pOg+pqb3lVXr0NeT0teXwUnigQHRoc05BT+a6R2HBfMlZGEzsD
 hzKQs84zgk0VY5jIhQDJEsQ1mjBYnFPt6Uq6m7+TP3AejDU8oMR81cA25TAxcuqRe6/9kxLnAWS
 5j5To6i3JXxGJsMFkF8Wx+3DQBsCTK1wQXigP2E5LbppH0oclntVQNlnmgrljagPKOT7gswV8ts
 OUefFOEnwJSL1GsIXdlndpLfCW7/EMjy1q5v26GsJsaR1EEryOleZp5eokPHO5fZgj94J+eFZze
 CGbHwgiep7PNAlbK0rAos0ZRsle+DIvXiGfpJNuACIhQQ7+fjt3W6+x76l+YSqo8L6R4Y2Dpg2U
 uZ9FQvd1QkxG2cTAo4C4MvRAttKsDhbQmgy6fj2W2pIBBC/nzNjBJg/xa1YKlb2269F97PA71sv
 8wK1qGHeZFCMfYS/uwrBUhVaya85NJPxaQ==
X-Received: by 2002:a05:6808:bd4:b0:539:e1c7:c04b with SMTP id
 5614622812f47-56e6510fc2bmr417908b6e.51.1794518186933; 
 Thu, 12 Nov 2026 13:16:26 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1a61:46bf:438b:5fc0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70d6572csm263804b6e.15.2026.11.12.13.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:16:25 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Nov 2026 15:14:56 -0600
Subject: [PATCH 01/10] binman: allow a control devicetree separate from the
 image description
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mtk-genio-binman-dtb-v1-1-65cfc9329c50@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
In-Reply-To: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=18728;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=dECV2/LCmay3ObP6SEgvMtsEnbr/w9mPXrlXCFBJN5Q=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq9ixiFnESUAVlznOS5aCOHtaCpMgsDxLuGPWCQ
 EKgbrYvo2yJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavYsYhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A9DAH/A1QUKGEQ4Sr6hFBSzQ9V9jhljDjdNtAvbB3XRs
 sd/wWVM4RcVAuy4Ib62cyYBpyS6C5PpVBsapezlnBaVaZDSlilSDVUl0s6K0fY7+KUk+reAt/7J
 YnBaK0WMhCudJtL6mYQgaJ+wmTzCJvkjaRm3v7DR8CCNgBg1X6doTASVBmyB7BsPKZEG2Xj0Qr1
 coAkzJfUaBq83vm7RhSa4E+zKgVg4nlguFawMaVWfWa68zipfqI/94PYalYwmEk5MUi4QkZY9nA
 x0meAz35xIvEQownOJcmLDF5AfVp8Zip1nfquEzKLh3329Kpo+/3BiuRXpxeB8shIr1P55WHxus
 miLM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a --u-boot-dtb option to 'binman build' that gives the U-Boot
control devicetree to use for u-boot-dtb entries, including the ones in
expanded u-boot entries.

Binman takes the contents of these entries from the devicetree that
holds the binman image description (-d). In the usual build, that is the
U-Boot control devicetree. With CONFIG_BINMAN_DTB, the description is in
a separate devicetree, and the images silently get that one in place of
the control devicetree.

The fdtmap entry still reads the devicetree with the binman image
description, since it looks up the image's node there.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .gitignore                                         |  1 +
 Makefile                                           |  2 +-
 tools/binman/binman.rst                            | 13 ++++-
 tools/binman/cmdline.py                            |  3 ++
 tools/binman/control.py                            | 14 ++++--
 tools/binman/etype/fdtmap.py                       |  3 +-
 tools/binman/ftest.py                              | 57 ++++++++++++++++++++--
 tools/binman/state.py                              | 38 ++++++++++++---
 tools/binman/test/fdt/u_boot_dtb_separate.dts      | 13 +++++
 .../test/fdt/u_boot_dtb_separate_expanded.dts      | 13 +++++
 .../binman/test/fdt/u_boot_dtb_separate_fdtmap.dts | 15 ++++++
 11 files changed, 154 insertions(+), 18 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0e09715cc60..f65742d1b60 100644
--- a/.gitignore
+++ b/.gitignore
@@ -52,6 +52,7 @@ fit-dtb.blob*
 /MLO*
 /SPL*
 /System.map
+/binman.dtb.out
 /boards.cfg
 /mkimage*mkimage
 /mkimage-in-simple-bin*
diff --git a/Makefile b/Makefile
index 292d1e07356..e84ee904e0c 100644
--- a/Makefile
+++ b/Makefile
@@ -2564,7 +2564,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
 	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
 	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot \
-	       imx9image* m33-oei-ddrfw* tifalcon.bin
+	       imx9image* m33-oei-ddrfw* tifalcon.bin binman.dtb.out
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES  += include/config include/generated spl tpl vpl \
diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 3a860421a69..abff7e8a414 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1709,8 +1709,9 @@ This builds one or more images using the provided image description.
 
 Usage::
 
-    binman build [-h] [-a ENTRY_ARG] [-b BOARD] [-d DT] [--fake-dtb]
-        [--fake-ext-blobs] [--force-missing-bintools FORCE_MISSING_BINTOOLS]
+    binman build [-h] [-a ENTRY_ARG] [-b BOARD] [-d DT]
+        [--u-boot-dtb U_BOOT_DTB] [--fake-dtb] [--fake-ext-blobs]
+        [--force-missing-bintools FORCE_MISSING_BINTOOLS]
         [-i IMAGE] [-I INDIR] [-m] [-M] [-n] [-O OUTDIR] [-p] [-u]
         [--update-fdt-in-elf UPDATE_FDT_IN_ELF] [-W]
 
@@ -1731,6 +1732,14 @@ Options:
     Configuration file (.dtb) to use. This must have a top-level node called
     `binman`. See `Image description format`_.
 
+--u-boot-dtb U_BOOT_DTB
+    U-Boot control device tree (.dtb) to use for `u-boot-dtb` entries,
+    including the ones in expanded `u-boot` entries. By default, these use the
+    configuration file given with `-d`. Use this when the binman image
+    description is in a separate device tree, e.g. with `CONFIG_BINMAN_DTB`.
+    The output directory then has the control device tree in `u-boot.dtb.out`
+    and the updated binman image description in `binman.dtb.out`.
+
 -i IMAGE, --image IMAGE
     Image filename to build (if not specified, build all)
 
diff --git a/tools/binman/cmdline.py b/tools/binman/cmdline.py
index 9632ec115e5..a038722e5c8 100644
--- a/tools/binman/cmdline.py
+++ b/tools/binman/cmdline.py
@@ -118,6 +118,9 @@ controlled by a description in the board device tree.'''
             help='Board name to build')
     build_parser.add_argument('-d', '--dt', type=str,
             help='Configuration file (.dtb) to use')
+    build_parser.add_argument('--u-boot-dtb', type=str,
+            help='U-Boot control device tree (.dtb) for u-boot-dtb '
+                 'entries, if it is not the configuration file')
     build_parser.add_argument('--fake-dtb', action='store_true',
             help='Use fake device tree contents (for testing only)')
     build_parser.add_argument('--fake-ext-blobs', action='store_true',
diff --git a/tools/binman/control.py b/tools/binman/control.py
index 816f7c1eba2..b479fc8ae69 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -582,7 +582,8 @@ def scan_and_prop_bootph(node):
         changed |= scan_and_prop_bootph(subnode)
     return changed
 
-def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir):
+def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, indir,
+                         u_boot_dtb=None):
     """Prepare the images to be processed and select the device tree
 
     This function:
@@ -600,6 +601,8 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
             So if 'u-boot' is called for, we use 'u-boot-expanded' instead. This
             is needed if update_fdt is True (although tests may disable it)
         indir: List of directories where input files can be found
+        u_boot_dtb: Filename of the U-Boot control device tree, if it is
+            not the one given by dtb_fname
 
     Returns:
         OrderedDict of images:
@@ -618,7 +621,9 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
     if indir is None:
         indir = []
     dtb_fname = fdt_util.EnsureCompiled(dtb_fname, indir=indir)
-    fname = tools.get_output_filename('u-boot.dtb.out')
+    # Leave u-boot.dtb.out for the control devicetree when that is separate
+    fname = tools.get_output_filename('binman.dtb.out' if u_boot_dtb else
+                                      'u-boot.dtb.out')
     tools.write_file(fname, tools.read_file(dtb_fname))
     dtb = fdt.FdtScan(fname)
 
@@ -657,7 +662,7 @@ def PrepareImagesAndDtbs(dtb_fname, select_images, update_fdt, use_expanded, ind
         images = new_images
         tout.notice('Skipping images: %s' % ', '.join(skip))
 
-    state.Prepare(images, dtb)
+    state.Prepare(images, dtb, u_boot_dtb)
 
     # Prepare the device tree by making sure that any missing
     # properties are added (e.g. 'pos' and 'size'). The values of these
@@ -926,7 +931,8 @@ def Binman(args):
             state.SetThreads(args.threads)
 
             images = PrepareImagesAndDtbs(dtb_fname, args.image,
-                                          args.update_fdt, use_expanded, args.indir)
+                                          args.update_fdt, use_expanded, args.indir,
+                                          args.u_boot_dtb)
 
             if args.test_section_timeout:
                 # Set the first image to timeout, used in testThreadTimeout()
diff --git a/tools/binman/etype/fdtmap.py b/tools/binman/etype/fdtmap.py
index 2259404180c..85603f02e87 100644
--- a/tools/binman/etype/fdtmap.py
+++ b/tools/binman/etype/fdtmap.py
@@ -121,8 +121,7 @@ class Entry_fdtmap(Entry):
         # If we have an fdtmap it means that we are using this as the
         # fdtmap for this image.
         if data is None:
-            # Get the FDT data into an Fdt object
-            data = state.GetFdtContents()[1]
+            data = state.GetBinmanDtbContents()
             infdt = Fdt.FromData(data)
             infdt.Scan()
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a26a51fa210..7df55c21c0f 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -385,7 +385,8 @@ class TestFunctional(unittest.TestCase):
                     use_expanded=False, verbosity=None, allow_missing=False,
                     allow_fake_blobs=False, extra_indirs=None, threads=None,
                     test_section_timeout=False, update_fdt_in_elf=None,
-                    force_missing_bintools='', ignore_missing=False, output_dir=None):
+                    force_missing_bintools='', ignore_missing=False, output_dir=None,
+                    u_boot_dtb=None):
         """Run binman with a given test file
 
         Args:
@@ -419,6 +420,7 @@ class TestFunctional(unittest.TestCase):
             ignore_missing (bool): True to return success even if there are
                 missing blobs or bintools
             output_dir: Specific output directory to use for image using -O
+            u_boot_dtb: U-Boot control DTB to use for u-boot-dtb entries
 
         Returns:
             int return code, 0 on success
@@ -467,6 +469,8 @@ class TestFunctional(unittest.TestCase):
                 args += ['-I', indir]
         if output_dir:
             args += ['-O', output_dir]
+        if u_boot_dtb:
+            args += ['--u-boot-dtb', u_boot_dtb]
         return self._DoBinman(*args)
 
     def _SetupDtb(self, fname, outfile='u-boot.dtb'):
@@ -518,7 +522,8 @@ class TestFunctional(unittest.TestCase):
     def _DoReadFileDtb(self, fname, use_real_dtb=False, use_expanded=False,
                        verbosity=None, allow_fake_blobs=True, map=False,
                        update_dtb=False, entry_args=None, reset_dtbs=True,
-                       extra_indirs=None, threads=None):
+                       extra_indirs=None, threads=None,
+                       u_boot_dtb=None):
         """Run binman and return the resulting image
 
         This runs binman with a given test file and then reads the resulting
@@ -549,6 +554,7 @@ class TestFunctional(unittest.TestCase):
             extra_indirs: Extra input directories to add using -I
             threads: Number of threads to use (None for default, 0 for
                 single-threaded)
+            u_boot_dtb: U-Boot control DTB to use for u-boot-dtb entries
 
         Returns:
             Tuple:
@@ -575,7 +581,7 @@ class TestFunctional(unittest.TestCase):
                     entry_args=entry_args, use_real_dtb=use_real_dtb,
                     use_expanded=use_expanded, verbosity=verbosity,
                     allow_fake_blobs=allow_fake_blobs, extra_indirs=extra_indirs,
-                    threads=threads)
+                    threads=threads, u_boot_dtb=u_boot_dtb)
             self.assertEqual(0, retcode)
             out_dtb_fname = tools.get_output_filename('u-boot.dtb.out')
 
@@ -8776,5 +8782,50 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(parent, dtb.LookupPhandle(parent_phandle))
         self.assertEqual(child, dtb.LookupPhandle(child_phandle))
 
+    def testUBootDtbSeparate(self):
+        """Test a control DTB separate from the binman image description"""
+        self._SetupDtb('alt_dts/model1.dts', 'u-boot-proper.dtb')
+        data, _, _, out_dtb_fname = self._DoReadFileDtb(
+            'fdt/u_boot_dtb_separate.dts', use_real_dtb=True,
+            update_dtb=True, u_boot_dtb='u-boot-proper.dtb')
+        for dtb in (fdt.Fdt.FromData(data), fdt.Fdt(out_dtb_fname)):
+            dtb.Scan()
+            self.assertEqual('Model One',
+                             dtb.GetRoot().props['model'].value)
+            self.assertIsNone(dtb.GetNode('/binman'))
+
+        dtb = fdt.Fdt(tools.get_output_filename('binman.dtb.out'))
+        dtb.Scan()
+        self.assertIsNotNone(dtb.GetNode('/binman'))
+
+    def testUBootDtbSeparateFdtmap(self):
+        """Test an FDT map with a control DTB separate from the description"""
+        self._SetupDtb('alt_dts/model1.dts', 'u-boot-proper.dtb')
+        data, _, _, _ = self._DoReadFileDtb(
+            'fdt/u_boot_dtb_separate_fdtmap.dts', use_real_dtb=True,
+            update_dtb=True, u_boot_dtb='u-boot-proper.dtb')
+        fdtmap = control.images['image'].GetEntries()['fdtmap']
+        fdtmap_data = data[fdtmap.offset:]
+        self.assertEqual(b'_FDTMAP_', fdtmap_data[:8])
+        dtb = fdt.Fdt.FromData(fdtmap_data[16:])
+        dtb.Scan()
+        self.assertEqual(fdtmap.offset, fdt_util.fdt32_to_cpu(
+            dtb.GetNode('/fdtmap').props['offset'].value))
+
+    def testUBootDtbSeparateExpanded(self):
+        """Test an expanded u-boot entry with a separate control DTB"""
+        self._SetupDtb('alt_dts/model1.dts', 'u-boot-proper.dtb')
+        data, _, _, _ = self._DoReadFileDtb(
+            'fdt/u_boot_dtb_separate_expanded.dts', use_real_dtb=True,
+            use_expanded=True, update_dtb=True,
+            u_boot_dtb='u-boot-proper.dtb')
+        entry = control.images['image'].GetEntries()['u-boot']
+        self.assertEqual('u-boot-expanded', entry.etype)
+        self.assertEqual(U_BOOT_NODTB_DATA, data[:len(U_BOOT_NODTB_DATA)])
+        dtb = fdt.Fdt.FromData(data[len(U_BOOT_NODTB_DATA):])
+        dtb.Scan()
+        self.assertEqual('Model One', dtb.GetRoot().props['model'].value)
+        self.assertIsNone(dtb.GetNode('/binman'))
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/state.py b/tools/binman/state.py
index f4d885c772a..ced78decf73 100644
--- a/tools/binman/state.py
+++ b/tools/binman/state.py
@@ -48,6 +48,9 @@ use_fake_dtb = False
 # The DTB which contains the full image information
 main_dtb = None
 
+# True if the U-Boot control DTB is separate from main_dtb
+separate_u_boot_dtb = False
+
 # Allow entries to expand after they have been packed. This is detected and
 # forces a re-pack. If not allowed, any attempted expansion causes an error in
 # Entry.ProcessContentsUpdate()
@@ -143,6 +146,18 @@ def GetFdtContents(etype='u-boot-dtb'):
         data = tools.read_file(pathname)
     return pathname, data
 
+def GetBinmanDtbContents():
+    """Get the contents of the DTB with the binman node
+
+    This is the U-Boot DTB unless that is separate (see Prepare()).
+
+    Returns:
+        Fdt data (as bytes)
+    """
+    if separate_u_boot_dtb:
+        return main_dtb.GetContents()
+    return GetFdtContents()[1]
+
 def UpdateFdtContents(etype, data):
     """Update the contents of a particular device tree
 
@@ -206,7 +221,7 @@ def GetEntryArgBool(name):
     val = GetEntryArg(name)
     return val and val not in ['n', '0']
 
-def Prepare(images, dtb):
+def Prepare(images, dtb, u_boot_dtb=None):
     """Get device tree files ready for use
 
     This sets up a set of device tree files that can be retrieved by
@@ -214,9 +229,11 @@ def Prepare(images, dtb):
 
     Args:
         images: List of images being used
-        dtb: Main dtb
+        dtb: DTB with the binman node
+        u_boot_dtb: Filename of the U-Boot control DTB, if it is not the
+            DTB with the binman node
     """
-    global output_fdt_info, main_dtb, fdt_path_prefix
+    global output_fdt_info, main_dtb, fdt_path_prefix, separate_u_boot_dtb
     # Import these here in case libfdt.py is not available, in which case
     # the above help option still works.
     from dtoc import fdt
@@ -225,15 +242,23 @@ def Prepare(images, dtb):
     # If we are updating the DTBs we need to put these updated versions
     # where Entry_blob_dtb can find them. We can ignore 'u-boot.dtb'
     # since it is assumed to be the one passed in with options.dt, and
-    # was handled just above.
+    # was handled just above, unless u_boot_dtb names a separate one.
     main_dtb = dtb
+    separate_u_boot_dtb = bool(u_boot_dtb)
     output_fdt_info.clear()
     fdt_path_prefix = ''
-    output_fdt_info['u-boot-dtb'] = [dtb, 'u-boot.dtb']
+    output_fdt_info['u-boot-dtb'] = [dtb, u_boot_dtb or 'u-boot.dtb']
     if use_fake_dtb:
         for etype, fname in DTB_TYPE_FNAME.items():
             output_fdt_info[etype] = [dtb, fname]
     else:
+        if u_boot_dtb:
+            infile = tools.get_input_filename(u_boot_dtb)
+            fname_dtb = fdt_util.EnsureCompiled(infile)
+            out_fname = tools.get_output_filename('u-boot.dtb.out')
+            tools.write_file(out_fname, tools.read_file(fname_dtb))
+            output_fdt_info['u-boot-dtb'] = [fdt.FdtScan(out_fname),
+                                             out_fname]
         fdt_set = {}
         for etype, fname in DTB_TYPE_FNAME.items():
             infile = tools.get_input_filename(fname, allow_missing=True)
@@ -262,13 +287,14 @@ def PrepareFromLoadedData(image):
     Args:
         images: List of images being used
     """
-    global output_fdt_info, main_dtb, fdt_path_prefix
+    global output_fdt_info, main_dtb, fdt_path_prefix, separate_u_boot_dtb
 
     tout.info('Preparing device trees')
     output_fdt_info.clear()
     fdt_path_prefix = ''
     output_fdt_info['fdtmap'] = [image.fdtmap_dtb, 'u-boot.dtb']
     main_dtb = None
+    separate_u_boot_dtb = False
     tout.info("   Found device tree type 'fdtmap' '%s'" % image.fdtmap_dtb.name)
     for etype, value in image.GetFdts().items():
         entry, fname = value
diff --git a/tools/binman/test/fdt/u_boot_dtb_separate.dts b/tools/binman/test/fdt/u_boot_dtb_separate.dts
new file mode 100644
index 00000000000..01907124843
--- /dev/null
+++ b/tools/binman/test/fdt/u_boot_dtb_separate.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot-dtb {
+		};
+	};
+};
diff --git a/tools/binman/test/fdt/u_boot_dtb_separate_expanded.dts b/tools/binman/test/fdt/u_boot_dtb_separate_expanded.dts
new file mode 100644
index 00000000000..269b201428a
--- /dev/null
+++ b/tools/binman/test/fdt/u_boot_dtb_separate_expanded.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot {
+		};
+	};
+};
diff --git a/tools/binman/test/fdt/u_boot_dtb_separate_fdtmap.dts b/tools/binman/test/fdt/u_boot_dtb_separate_fdtmap.dts
new file mode 100644
index 00000000000..f962394bf3d
--- /dev/null
+++ b/tools/binman/test/fdt/u_boot_dtb_separate_fdtmap.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot-dtb {
+		};
+		fdtmap {
+		};
+	};
+};

-- 
2.53.0

