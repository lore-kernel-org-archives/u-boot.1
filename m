Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF5DCA5FED
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 17:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98DAB606C9;
	Sat,  3 Oct 2026 17:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bBsJXG7KjOSi; Sat,  3 Oct 2026 17:00:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7D7016069C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791046825;
	b=Xk6N3wf/mkkoNT1AoKpM6JoN74rLAy0FUnHg22rrC9e685pkB313j99ulA0uOd33ItNR
	 sIpITZFI0PZKJVxXVZipAuwAF+t+6udX3Bdif6rslihstYCWaAezLbRnfeiECbsPKwA1Y
	 nlNijnUvKc8ucn2IVhh9zoiwTvCXD55O8OH8teF35t/CVfLBh8x6DDiwULfqHvqziGD6L
	 Op0lExhbh326gGpMSok4SQRH96lAwRmVxq6/zk5agIo9hGIQQhp+TxFa/gGNiS6kj9zGv
	 rE0OeSYZJGWNvvYl7Jg6ardUI8gPOvG9OpQEsL4OvXF4AAQSsc8wR+WaQwzBZIScGLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791046825;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=36cR3Plq3U+RHZZQ5Rtdn8NJU/iXePjR8JZXxSoWJfI=;
	b=I/7bmGcOAZAnBlpIt8ECEhzyz1TcqNvO/rV+KMm8MAkqs4tsUKaO97qUHF/xbkkrbp0W
	 CfLLvn08jkTUa2vjwngAY9lIl0+4zyFD7ru/cY8wvKZ16O46qkjFy6SVK7ArDjPG2EwNf
	 IjnPiB2H0ZpOe5t4GBMm9Jfj+Uz+VWPSPsV6NBRfyiszGsDuXkOoTp9KjmmjST4fzJsUP
	 CLUpEdVl5n0PWtqNoVzCSQM2Srn5LE7S15J3aUfpdPWuLRGkNbpK034aFjqFqkJJrY+WF
	 V7SEBhalTadz2CWbK2rzcbrabi2EI3XIazd9i/YNk8aye7TFhm++tRFl+xWKCpcwSzQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791046825;
	bh=36cR3Plq3U+RHZZQ5Rtdn8NJU/iXePjR8JZXxSoWJfI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=T+6Xam7lYC2iq3IurkVsPe4H8+4cV+yZi2K4p2SmKNDGeHBViac5eVKQgSLsQr/+J
	 d0GGiQfMaofAAnhOT/MQx1VhLjEE1UnHTX01mUP6XDbE4MnnbWzZhuFsw27NAzSBHk
	 xAQ4q6OWXSWEoOpvj61K9Y66ov7lhuPPT2WXsPanppkbS5Mm757nMaRCujuw5oHsL+
	 mQXHWlUeDZfkrtkudaooMy06PV3D9V+kptUwE2zA3N7l2jAsLIQW3inAI4AMbixLq8
	 0joKEQc52HGR8t4YxBFlr+g+Sbdd4UMCSNm0EtnEY1k5OM3LAF9XHygcDBzZGyiCm1
	 jXTl6+kxgCaGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D7016069C;
	Sat,  3 Oct 2026 17:00:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CFC1435
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 17:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0308F40064
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 17:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FhN_vYeOTRoD for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 17:00:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A22D340024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791046823;
 b=bZw1X16qPdUEmoGMI9KNulw+1MlbRuPcf+ixlxs4s6k1vGifEjSLqL6e6wz9V8VKgq+R
 KiYJEGphh4tHSW21yGxgTL67bt19r8duMVoWkd//s+HBHyBEtQmOeT0r68mPl93ZrCBQB
 WOWRTi60E5dinci2OFNV6toIwBJy78d68kT5seTPFuaEK9rnqk7J0omJBHgd7rx9AKvJw
 psfPx2nHHLeJLFrJOScpetkHSsjShhXH9uhfrCOo7WZEF/rRqDw+f5lLLgUAVXJ6UzREM
 t7eDco/DNyQP5aVnMgfD9TnnVaPqIsJ7asHiA81Hmevx87z+h3JhJlFZ977szlPPtiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791046823;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=36cR3Plq3U+RHZZQ5Rtdn8NJU/iXePjR8JZXxSoWJfI=;
 b=BIb9bIuK+WoPcss7jK+2yAjvTxtsBKCLdMbRua8nppeGzw7VYZjN9mRa4TyRRwhOz1LE
 JEl6nUD0CY405jetlAtzgpXSnTOOLMuvani8ang3z/07d9wi1FZbzp/XO9O7MUnXIzGoy
 Nb+j0ND5qiC9nuRI8VMfJryvEid7z26IuDzC5uN1xd6SOiRPUY0OH+8y5+68qN0FV/X0a
 P1+Y13O8rmnb6TfYXaT3yhFgegzEpAhR5L9uyCp3sMt3TL4r9l4FLF6NsPtI5lFQbsjcA
 MjQxCYwpsXzYUvwajOMYux0G01uCvOCOUQC7Vc1F+0noDyR5lk7GWZZznuAi0nPoe9g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Pr1MMtDK; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Pr1MMtDK
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A22D340024
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 17:00:22 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49fff72474fso4552165e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791046820; x=1791651620;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=36cR3Plq3U+RHZZQ5Rtdn8NJU/iXePjR8JZXxSoWJfI=;
 b=Pr1MMtDK1CPnwEn0t4KDszhvYNv60i6n56nUg63SVjU5Wqg+WGBKylAPNZ3eN/Qr8w
 V5zUDV2PCukRSfphrp7UCtmlGlIlpIqyYakZRQehIFtfusuTxfHSUO9uUy37seu4KRg8
 p3gth11eRCfZFaddQwi/hA35upJYkTFaSy/aKJVnO43p7SDKnSeN57owQ87fmd7JreKU
 aEkrHeEdKMU7JXh/lyF+GemuKMxiyYfu1X15C2LkQFwJexjS2tz8jIkzO+6HVeh43rnB
 wm6mrdLskO59MsFqyX12428nAs4drhxP0JEwMWtH9cUyDE37ZQBcJpzUH81hS8eImov+
 EDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791046820; x=1791651620;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:sender:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=36cR3Plq3U+RHZZQ5Rtdn8NJU/iXePjR8JZXxSoWJfI=;
 b=yw1BqYRdavIvK7QZ7L3u4Iw2GMlBoVjz43XKMr7yfquQgLTXlqZlZFgLypogzA0H33
 c/G9h/RIscdIVHrJZBniFtR0cxPJrkh9cB+yXr/TqtUZ9roKhmuHWkyrhpga2N5NoeAi
 328fMqFQYTZVEbqBlq97alOd+/jAhAydKteqsrGAZJ8AYTttPRq4gppyJ+WJdKhk46f+
 6Wy0uKGkqs1h9ZH0+jbvYiZvvbLceCLHUyZikBOqlB9xLYSIPtIZKFnZJLuaQVuv5nkL
 yGWGZQGikGRNpf2qBer+teAf3q0wehzisLGTLGdcmJoaIAnuwvXJgnKwWGXd+bhTCrSl
 Z9NA==
X-Gm-Message-State: AFuF++lJaCkcwUgxaMD4tXsBqX4vQzr1ANntS0ozBMy5rouLuTdwoAj+
 r1cwtHt3KxBakXYO1H5JxNkQvTuPj+MtiyrSQN/AefsW6Zi+FvyrbFzh
X-Gm-Gg: AYBFou0Jw7YfRcHK/XEJpXQC8yElBI+ypTz5q+thTSfLBYCkkYM/h8RiCWI+O9sw/4d
 /ybdSRApXHIMa86aflHeuhxWDFbdUjIafPsxTDSpLNUy1MNXKo86k9N3gb/kZxNoPJGC4Up2txj
 MWAlIUXorE6FAXCDr7bmxX8tV6iydTlON4+25qzZ+icPGtBuCtFkr5FuI18l3MNjM2zPREMTvbD
 JlY0qJUo1PuyEk3MbDDE7noxfFa71w/B7cHOp2j9uRzvG0iIZfPlIdNN4+9mocl5NBAvTEd3p4D
 pEngk2byzasFFar1z8H8LOW7RZ02r2qvpqQi1vVcZhXOgXITB3+mzh20FKIa0tbqQOdjZK7POte
 jRUMj3e4lGRTLwnbKU1m/7MV5ZruA2QB1tdczvjhg2MfMqqNGrsOgOX0qR10c+J5u7c3xXZOxXK
 JhlYGho/7grmNdQ00D0numIEFd00t0U6svCGtCYAj3YiW5qaK/DZZbzhWfdARfQL1H+igxbxNgt
 LwMPWwF
X-Received: by 2002:a05:600c:6085:b0:49e:6c11:c4fc with SMTP id
 5b1f17b1804b1-4a027575983mr91583885e9.7.1791046820219; 
 Sat, 03 Oct 2026 10:00:20 -0700 (PDT)
Received: from [127.0.1.1] ([151.71.208.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0394ca0f0sm117083655e9.1.2026.10.03.10.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 10:00:19 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sat, 03 Oct 2026 19:00:18 +0200
Subject: [PATCH v2] qconfig: Improve the documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-qconfigdoc-v2-1-b2338cdd8a35@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKE0wWoC/22NQQ6CMBBFr0JmbQ0tVZGV9zAsYJjCGGm1RaIhv
 bsFty5f8v77CwTyTAGqbAFPMwd2NoHaZYBDY3sS3CUGlaujzPNCPNFZw33nUBgqtUZtlJYG0uD
 hyfB7i13rH4dXeyOc1sJqDBwm5z/b2yxX7294lkKKc9dgqduCzOlw6ceG73t0I9Qxxi9dIEsNt
 gAAAA==
X-Change-ID: 20261003-qconfigdoc-fe844c4f241f
To: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
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

Specify where the database is created and under what name. Add text
value lookup examples, including quoting, escaping and regular
expression cases. Update other examples, or just their output, in the
section documenting -f option usage. Trivial fixes.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
Changes in v2:
- Reword and add details.
- Update examples about -f options, or their output.
- Link to v1: https://patch.msgid.link/20261003-qconfigdoc-v1-1-9dac84b3ef75@gmail.com

To: u-boot@lists.u-boot-project.org
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 doc/develop/qconfig.rst | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index a18f32470ca..8a1827e2701 100644
--- a/doc/develop/qconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -24,11 +24,14 @@ You may need to install 'python3-asteval' for the 'asteval' module.
 How does it work?
 -----------------
 
+The tool must be run at the top of the source directory.
+
 When building a database (`-b`), this tool runs configuration and builds
 include/autoconf.mk for every defconfig.  The config options defined in Kconfig
-appear in the .config file (unless they are hidden because of unmet dependency.)
+appear in the .config file (unless they are hidden because of unmet dependency).
 On the other hand, the config options defined by board headers are seen
-in include/autoconf.mk.
+in include/autoconf.mk.  The tool stores the database in a file named qconfig.db
+at the top of the source directory.
 
 When resyncing defconfigs (`-s`) the .config is synced by "make savedefconfig"
 and the defconfig is updated with it.
@@ -81,22 +84,41 @@ Each term is CONFIG name, with or without a tilde (~) prefix. The tool searches
 for boards which match the CONFIG name, or do not match if tilde is used. For
 example, to find boards which enabled CONFIG_SCSI but not CONFIG_BLK::
 
-    tools/qconfig.py -f SCSI ~BLK
-    3 matches
-    pg_wcom_seli8_defconfig highbank_defconfig pg_wcom_expu1_defconfig
+    ./tools/qconfig.py -f PCIE1 ~PCIE2
+    10 matches
+    MPC8548CDS_36BIT MPC8548CDS MPC8548CDS_legacy kmcent2
+    ls1012afrwy_tfa_SECURE_BOOT ls1012afrwy_tfa ls1012aqds_tfa_SECURE_BOOT
+    ls1012aqds_tfa ls1012ardb_tfa_SECURE_BOOT ls1012ardb_tfa
 
 It is also possible to search for particular values. For example, this finds all
 boards with an empty string for `CONFIG_DEFAULT_FDT_FILE`::
 
     ./tools/qconfig.py -f DEFAULT_FDT_FILE=\"\"
-    1092 matches
+    1229 matches
     ...
 
 This finds boards which have a value for SYS_MAXARGS other than 64::
 
     ./tools/qconfig.py -f ~SYS_MAXARGS=64
-    cfg CONFIG_SYS_MAXARGS
-    281 matches
+    296 matches
+    ...
+
+String values can be searched for, too, including regular expressions, but
+taking care of needed quoting and escaping. The values stored in the database
+are the ones from the Kconfig files, before expansion. Moreover, since they are
+stored with their double quotes, the quotes must be part of the pattern.
+Enclosing the pattern with single quotes makes the shell pass the double quotes
+and backslashes through unchanged. For example::
+
+    ./tools/qconfig.py -f TPL_LDSCRIPT='"arch/arm/cpu/u-boot-spl.lds"'
+    0 matches
+
+    ./tools/qconfig.py -f TPL_LDSCRIPT='"arch/.*/cpu/u-boot-spl.lds"'
+    22 matches
+    ...
+
+    ./tools/qconfig.py -f TPL_LDSCRIPT='"arch/\$\(ARCH\)/cpu/u-boot-spl.lds"'
+    22 matches
     ...
 
 
@@ -245,4 +267,4 @@ Available options
 
 To see the complete list of supported options, run::
 
-  tools/qconfig.py -h
+    ./tools/qconfig.py -h

---
base-commit: bd2f5794b7e24c62042abb1921f9c2039b920e02
change-id: 20261003-qconfigdoc-fe844c4f241f

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

