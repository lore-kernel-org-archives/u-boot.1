Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE41606A332
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LNUdzbJo;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MkNJ7n7p
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 221C981689;
	Fri, 20 Nov 2026 22:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YbiVD1YrZlyb; Fri, 20 Nov 2026 22:05:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6111981763
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212318;
	b=rG0BaFt69WlCL7omrjhJMyrmt4MdgNcwSrvf0kvG/4GDMX9tMqD1T6JXHK7PslDfUJyY
	 8B3bBs3tL0qaS2spQamZAohBeqYTmJ0/5OJHq63mF6CAyVHW5QF2nwa4vWI3M1xlzRv+0
	 DjmKndZVKsGBMRqV5QJsqCalEzIGQ10bm2QVyLBNZjJCMC0rzrdlPPNMadp4LGkUXjDwv
	 KIirEHHq7Izm6VG3qHO4IRijfJTHSptHopWIVWVkxWkJZNybIMIKuJqpWPgMtEVAKXNZE
	 P/bweP8Pt9KfR9Xgc5fbmY2lVngeZu4qULHsgbxjVe/dDmZb/e6yZCxsS0ZKR0f2RGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212318;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=55KU/ZZe280La1cvnosSTSIww1ZeeSGaZtSGTHiVVJU=;
	b=kj8dV0tbJaJOJRaDlhbDi8+gaQ6HPWrAoKhcLWj7GjnY0bOiuH0QPIBBCXnZrN7MURko
	 m1nTpbtq/go282ldcOTxYv0310FLtvPdAdNpdjC0achHgP57iJ2nJHRr8fTb8crGQD2ig
	 nA7EAJOE97/mUtsLQ6baJQZDZs8MzszVX1uAEfwZE2Sf6h3P4/qA3yAvmCOHdrbi0XW1G
	 FArXfjNCWsP9zZoxAELeOQRntqXgju8Kclup9o/Zw/4S+VmG6De0NeFoJPqE9SqVR7ojK
	 T1oMjFkHnA2FlOYlI0UU/iw/I2XCwf1o3FOjzBT/+xIzLuWgfzb6hRKLt3JjRjeS8sw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=MkNJ7n7p;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212318;
	bh=55KU/ZZe280La1cvnosSTSIww1ZeeSGaZtSGTHiVVJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LNUdzbJoWoWx+eemiKCfvuYiM+75BX4mtb/Hn47NMvmYMfy30fWBSDc9AmR3YqfPk
	 SB1GYy5eUT80N0K8YgfQMOVAHHqKHW+Lyk+B9blRPJqzDJO4OMR6umB2NFL+0SENj8
	 7IfyK3c8VumXoSMEwDRIA/PoP2Bgy0RwmpSF0M2vSd7Dp8oDpunXqB5s4/oaUUn8Pa
	 9342X/QXkKthWML5O5vvdgn3pC5/qW6MY6+ZVlRtYOb4Snb0d5NPWvXYlHyJPkoKx+
	 oX3FlQRNKFW2yTcqwbsFexlg7kkdtRxchI7YBUoUgWm8sarcPH8bJVOdRVK/dLNXZf
	 f4LUI8s0yBNiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6111981763;
	Fri, 20 Nov 2026 22:05:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 092179C1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E32EE81688
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dlTVDXa4aBRb for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 22:05:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 500CA8165F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=MkNJ7n7p
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 500CA8165F
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:05:12 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-43bf9548df4so1393789fac.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 14:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795212311; x=1795817111;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=55KU/ZZe280La1cvnosSTSIww1ZeeSGaZtSGTHiVVJU=;
 b=MkNJ7n7pKAKf+UjumAAp2oAorx7PLfVdr5paEj259ddkRRlmZtNbGdAkWc1MsFoyPD
 5nPPtdxxbbo0sdD4qqtENap/hNA/6sL9eaoYzKeAjxtZmIWa/qQUcOWsFyNv8Nz/P4/z
 HYfCDHOpwEkyl3DPElRp8O3up0WF6hxaOSze1OOk7CGDlFlh7z5u3cEIUar3eUb6FPVN
 3Wb1+7hqubaHXI85/lTdRYbjoWEvkvUxNgJnTuvv4ulKvqOe0mVg60UgQliQRbw3KAou
 TEz1wgTFouaCQ3tl+xmc1nGmQVgrDVWvRKfNX8gFgRGjueW2j4Gex7184XPp6CHfNBHJ
 NAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795212311; x=1795817111;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=55KU/ZZe280La1cvnosSTSIww1ZeeSGaZtSGTHiVVJU=;
 b=uYNUy11/iOBdlmYjGMxrpJQ0Kx6vTx0xNhr2Xr1GbZuZv8pX3Zie1lR2lxnaWiVTSa
 cyxnHJjrD9VpkVKkZgG99krguQh0Rhvk2Fr7OTaCCrPD8H0ZvPQzpBBp1tg9+iVkeqw7
 /JQclJPZNQB4GXscipnTfnmsRcqwt2TSuFGk/OQdnFKLz5ONcX7M/DZxYmHojGaWnff1
 gDSR6aYspcL3twNZeFkdbS297PiFEXw0KM+Cbzv5ypCVWT6OW3DehH8xv43Nr7cfg3Sr
 Grni5BoUQvbpvMsKPX6j03bScRq17PZOpSG0nvRNZfJt3GeJkcNIe+P4ZBHLWz0P80hF
 mhHw==
X-Gm-Message-State: APuU4Z9mVKJnsuqMwGx1HW3WtVSu7KnOXgIGO+LKAXCf0ppdYU4OcCwI
 X6IJH8wUhsmoBy6QvEpT2KE8v2tr0eY8wMHuQs19G3l2AHzK/GNy2mwVFvIDgUSU4qM=
X-Gm-Gg: AYBFou0Ut5AaOFd9a6Tj1NjWUKTUuquUtq2NBtqoBRlJRlK8g9vtHxiI50xOxjtykD6
 nxAPddyd2CDU23GS1z3tf2JonRdkCUVVDmu7gYk35WPK9uLfgSMEsrdnBdtbeW7uBXCx8cqtWs1
 mpRVWy1PN+kmhXRmeRUC9UMimUi26b46dz1ZxnJ+5kASbB1zN5zdqAaurAYEtFAORCMbxNCMxCJ
 RjSLPuL0lJxq0hCWiOvHcCAExFfy0jMMF2cd/Vnzf/HUru/5HVyrU27wkjO3hNPjv/O/d2629AZ
 iWjhRY7oLQR1UZlbMh7l6L4T8/zTj3DknPK2DqfVRgEfEuIhkvItLKSlq+LtgpzpCpMkOqWopys
 5ZN26Ocdgfml+ow3rBZTof3jh3veu7VSXXsyzQ0nFN8NkUjGXORKtdV3fxInBtbmBudhIE7KjkZ
 8ppYD5GI/SpaCpss+AUH/VoE3Lr5R2PhbsVSXFIPCp6FiBDWAMidsojrLgy/VXXolk5lwxaV8qr
 lHcabIW4XzQJan48FbrSb9lEgDXzNb3SEYDsF/i7tscORqLALckLM3iMTAleTw3uAzP+KYtwXU2
 KXukSAce2jkOK12Qvoe5ntqYSRsPkWuf
X-Received: by 2002:a05:6870:1764:b0:48f:e0e5:a1e3 with SMTP id
 586e51a60fabf-4bc84f1b624mr4376751fac.40.1795212311369; 
 Fri, 20 Nov 2026 14:05:11 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d4f:b590:5bb3:988b])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm3878346fac.12.2026.11.20.14.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:05:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 20 Nov 2026 16:03:42 -0600
Subject: [PATCH v2 01/10] binman: allow a control devicetree separate from
 the image description
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-mtk-genio-binman-dtb-v2-1-4fa1894b7e2f@baylibre.com>
References: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
In-Reply-To: <20261120-mtk-genio-binman-dtb-v2-0-4fa1894b7e2f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=21916;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=GzgHe+JXXIVwGXj75HDFc/49+1/gc2TrDALcjAzMMmc=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBrAMPP45rrUfUuPisGEFQZk8wqKRbNV/pmHs+r5
 d1pQZYkZZ2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCawDDzxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ao+4H/jQw/Z4+lNYe13WWFDbbjr14RsAfLUFvYYpTKxu
 CJi9QTeQ4MwzVyXGIdX/34rQDYjDUoDdyZns4NompX7XREfVugj9KpKIRvqhS1VsNznYVD5EBWp
 AvgMMX9VjNrjOYsn6jt9xMLfoQgUbFAvXvok7imcxKGJmhMh5qoFF2SLsHeeAmFGVSreoWyKpbU
 ujDLv7SQm2bX4D31oWgXKQGF8Tt/tASDYZQscy6jA4C42Y09FFSV0KRav0UVqvSLgAVNkOWAqPK
 sn6ilXeUqvxvwh9QNWIryj9mwJ8wz0Igi+KEM/EXirHf17h1qJW16xXyhOcm6jCT9uYnXCJNuzm
 TyGs=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

Entries in an image built this way can still be replaced. Binman leaves
the control devicetree out of the updates then, since it has no binman
node.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .gitignore                                         |  1 +
 Makefile                                           |  2 +-
 tools/binman/binman.rst                            | 13 +++-
 tools/binman/cmdline.py                            |  3 +
 tools/binman/control.py                            | 14 ++--
 tools/binman/etype/fdtmap.py                       |  3 +-
 tools/binman/ftest.py                              | 80 +++++++++++++++++++++-
 tools/binman/state.py                              | 50 +++++++++++---
 tools/binman/test/fdt/u_boot_dtb_separate.dts      | 13 ++++
 .../test/fdt/u_boot_dtb_separate_expanded.dts      | 13 ++++
 .../binman/test/fdt/u_boot_dtb_separate_fdtmap.dts | 15 ++++
 .../test/fdt/u_boot_dtb_separate_replace.dts       | 19 +++++
 12 files changed, 205 insertions(+), 21 deletions(-)

diff --git a/.gitignore b/.gitignore
index 5cb135fc58c..c67b6f19dee 100644
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
index a9cc6ec2bd3..120de108323 100644
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
index 567ffa96b2b..c69bd8af19a 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -386,7 +386,8 @@ class TestFunctional(unittest.TestCase):
                     use_expanded=False, verbosity=None, allow_missing=False,
                     allow_fake_blobs=False, extra_indirs=None, threads=None,
                     test_section_timeout=False, update_fdt_in_elf=None,
-                    force_missing_bintools='', ignore_missing=False, output_dir=None):
+                    force_missing_bintools='', ignore_missing=False, output_dir=None,
+                    u_boot_dtb=None):
         """Run binman with a given test file
 
         Args:
@@ -420,6 +421,7 @@ class TestFunctional(unittest.TestCase):
             ignore_missing (bool): True to return success even if there are
                 missing blobs or bintools
             output_dir: Specific output directory to use for image using -O
+            u_boot_dtb: U-Boot control DTB to use for u-boot-dtb entries
 
         Returns:
             int return code, 0 on success
@@ -468,6 +470,8 @@ class TestFunctional(unittest.TestCase):
                 args += ['-I', indir]
         if output_dir:
             args += ['-O', output_dir]
+        if u_boot_dtb:
+            args += ['--u-boot-dtb', u_boot_dtb]
         return self._DoBinman(*args)
 
     def _SetupDtb(self, fname, outfile='u-boot.dtb'):
@@ -519,7 +523,8 @@ class TestFunctional(unittest.TestCase):
     def _DoReadFileDtb(self, fname, use_real_dtb=False, use_expanded=False,
                        verbosity=None, allow_fake_blobs=True, map=False,
                        update_dtb=False, entry_args=None, reset_dtbs=True,
-                       extra_indirs=None, threads=None):
+                       extra_indirs=None, threads=None,
+                       u_boot_dtb=None):
         """Run binman and return the resulting image
 
         This runs binman with a given test file and then reads the resulting
@@ -550,6 +555,7 @@ class TestFunctional(unittest.TestCase):
             extra_indirs: Extra input directories to add using -I
             threads: Number of threads to use (None for default, 0 for
                 single-threaded)
+            u_boot_dtb: U-Boot control DTB to use for u-boot-dtb entries
 
         Returns:
             Tuple:
@@ -576,7 +582,7 @@ class TestFunctional(unittest.TestCase):
                     entry_args=entry_args, use_real_dtb=use_real_dtb,
                     use_expanded=use_expanded, verbosity=verbosity,
                     allow_fake_blobs=allow_fake_blobs, extra_indirs=extra_indirs,
-                    threads=threads)
+                    threads=threads, u_boot_dtb=u_boot_dtb)
             self.assertEqual(0, retcode)
             out_dtb_fname = tools.get_output_filename('u-boot.dtb.out')
 
@@ -8879,5 +8885,73 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
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
+    def testUBootDtbSeparateReplace(self):
+        """Test replacing an entry with a separate control DTB"""
+        self._SetupDtb('alt_dts/model1.dts', 'u-boot-proper.dtb')
+        self._DoReadFileDtb('fdt/u_boot_dtb_separate_replace.dts',
+                            use_real_dtb=True, update_dtb=True,
+                            u_boot_dtb='u-boot-proper.dtb')
+        image_fname = tools.get_output_filename('image.bin')
+        expected = b'x' * (len(U_BOOT_DATA) + 1)
+        control.WriteEntry(image_fname, 'u-boot', expected)
+
+        self.assertEqual(expected, control.ReadEntry(image_fname, 'u-boot'))
+        dtb = fdt.Fdt.FromData(control.ReadEntry(image_fname, 'u-boot-dtb'))
+        dtb.Scan()
+        self.assertEqual('Model One', dtb.GetRoot().props['model'].value)
+        self.assertIsNone(dtb.GetNode('/binman'))
+
+        # The fdtmap still describes the image after the resize
+        dtb = fdt.Fdt.FromData(control.ReadEntry(image_fname, 'fdtmap')[
+            fdtmap.FDTMAP_HDR_LEN:])
+        dtb.Scan()
+        self.assertEqual(len(expected), fdt_util.fdt32_to_cpu(
+            dtb.GetNode('/u-boot').props['size'].value))
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/state.py b/tools/binman/state.py
index f4d885c772a..b97b01f504b 100644
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
@@ -281,10 +307,13 @@ def PrepareFromLoadedData(image):
         tools.write_file(out_fname, data)
         dtb = fdt.Fdt(out_fname)
         dtb.Scan()
+        # A control DTB separate from the image description has no binman
+        # node, so the path prefix cannot come from it
         image_node = dtb.GetNode('/binman')
-        if 'multiple-images' in image_node.props:
-            image_node = dtb.GetNode('/binman/%s' % image.image_node)
-        fdt_path_prefix = image_node.path
+        if image_node:
+            if 'multiple-images' in image_node.props:
+                image_node = dtb.GetNode('/binman/%s' % image.image_node)
+            fdt_path_prefix = image_node.path
         output_fdt_info[etype] = [dtb, None]
     tout.info("   FDT path prefix '%s'" % fdt_path_prefix)
 
@@ -324,6 +353,9 @@ def GetUpdateNodes(node, for_repack=False):
         if dtb != node.GetFdt():
             if for_repack and entry_type != 'u-boot-dtb':
                 continue
+            # Leave out a control DTB separate from the image description
+            if not dtb.GetNode('/binman'):
+                continue
             other_node = dtb.GetNode(fdt_path_prefix + node.path)
             if other_node:
                 yield other_node
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
diff --git a/tools/binman/test/fdt/u_boot_dtb_separate_replace.dts b/tools/binman/test/fdt/u_boot_dtb_separate_replace.dts
new file mode 100644
index 00000000000..748b7c037db
--- /dev/null
+++ b/tools/binman/test/fdt/u_boot_dtb_separate_replace.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		allow-repack;
+
+		u-boot {
+		};
+		u-boot-dtb {
+		};
+		fdtmap {
+		};
+	};
+};

-- 
2.53.0

