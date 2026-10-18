Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80340CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 09:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D841606EC;
	Sun, 18 Oct 2026 09:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K4LcBYPc5UxC; Sun, 18 Oct 2026 09:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7912B606AA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792317502;
	b=T1jBVaxnMpAGoz4W0gmAoQNY3421lB3l7Rd8ZwBRhpeK2RWBLnIHmhJQUCJit3QZ+9wn
	 QLqEThn7kW0BqMZjuV1sK3mTr9NnoAodpMxHg/U80c4oZuCEGInqppwkrTzyltRxXIlbJ
	 MjmSvcfDrXcJa/KqEWmazElXpN/JslOqSLiHIuK7+9rwgQnIugwM6J7C30ZQ8NVRBdwjt
	 7TnjzqRmnKwdvkRVFqGCGKSslvQFe4fyb75OSteg1wXry4t8hcBlmm6XT2YHdLFPIrDDv
	 OXoiw/7Sbn9sMIGGtcrchkK7d3tislKSX5RfbrJio0k8tniCWlMJ8EDWPsLc6Q670hA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792317502;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CDDfrsuKbaxhCOGpC7OcSp18qKUZesNmx+PJsw4ar8o=;
	b=iE03E3aSqxDhIMf4pKuB/vfMrN91rYG6oe4z6r+oa22NevxAItwpkBxS0BMnUsCNhPpQ
	 vE43qFeyWXEIPeBhKZS4WFtL264+N37gxJdQg0O9j6seXbrfuGup9EQeri4l6dgjjavEU
	 UxNS5nLd87VP1ntrX37IgFWIBE7Tu67Rq8oDMZ1EdwWvmYot0VHHYdP9ieKHP8EBw25qU
	 S/3nPqsIbWyM/wM+i1MvLlFOGsVRureJgrB82rnTZC8naqWasuFu8KasK3cPo4Wybqahs
	 fr8sm/v/4WWZIh1/cMh66kDdYHnZNlh95IkBhz0sqsS5Ad01tGp0VOvo5k/yM4p0ToQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zkh+wHcR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792317502;
	bh=CDDfrsuKbaxhCOGpC7OcSp18qKUZesNmx+PJsw4ar8o=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cRgjvxk0TcpEVYRQTuZFyIzdpFlkWomRPhq7IqEey4CZsnV46yt1QP7d3vZF5laYk
	 zUHCAcwghQ/pRCptxsKJo5lMMu0c2l+zyVvI4EM8Nj/u8BwY8+d0W0YGZORtQXfV9o
	 /5baAyO/x+WjDjoRWQhCLhRu5G/F0/bQXnJWJmvpv7R7H7+CTvA2wqRArWHK2f9lwS
	 3vTPYbd4Bl2Wuj2Uv/D0fkU7cSzT9enKtNre9w7Xo1zppLfy0ZHJIYYNoW1/+TC+Rt
	 udCZavZ5Vej0pIhFDWipyz93fj7Swz2JwPtLZ/0woQoqbbpifJZpsSEL7fnus8NoIb
	 T34fXECKORppg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7912B606AA;
	Sun, 18 Oct 2026 09:58:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D5B1723F
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 09:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7500606AA
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 09:58:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fqy_pD8lgGZH for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 09:58:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7BC83606A7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792317500;
 b=hd97R29eRUoDHg2akeFT7bIz9vRW4NBt32k9B/4az+md1oq8QBWamWvk3A0s7Ko8jJsU
 k+Eh5gf6GCYw72frvf0EYe1C984/B9d8zmsVDQPcNqOIjlMqCv1qpj8M35rWWBfQw6vSX
 Q9sAptw5HSe2MsX+nL/U2QYwrNPoNCBNY710SEUjbGNUQgxrgllSwK+po7mxA+cNUTaLz
 obS/AE4AJsuQoXtsCOCxg3WgVpg+TMLubR7Myd/h9Gr65uP2S4c3ii2Ouy1m+TewGGsEM
 W4y2y4ayWZf/PsIFJpTOzDPD9OEso11pUKHeWpnCTcdbKdC9QHYsb3iotEfbM1TBYtA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792317500;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=CDDfrsuKbaxhCOGpC7OcSp18qKUZesNmx+PJsw4ar8o=;
 b=hBOQyoBifhWC70W/6PL5fcDx/raCRHM/GYJ61vr+ImObFGnbbq1QUTjD+jkBNXK9RvFB
 xUqCtTF+5yX/7YHqDwsHpaWJmK46JDUVVUqjCMBwlUOEDp1lIz+mKZ7NXyWe6j0sVJCjy
 Ig5OKVxHQhVkxdkmfQqRTU9JzP7rOCdxg7L4FmKX09LGcfg3capY9YM9YoE5Ow9N1mNmH
 Lc2hjH+vdCnHMlCIVhTf6Bu2+4EtDV9yW0Vk4IhQvfso1q+kuwFm/R0FWQaQOrA/mWCXV
 7h5IOI6F/IdsMgAyjkAo3uD5OFU8IplnAlj3oBJwLTKopjzVfhOdTdaikvfhxKGI+vQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Zkh+wHcR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Zkh+wHcR
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BC83606A7
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 09:58:18 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1d293b293so6549225e9.2
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792317497; x=1792922297;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CDDfrsuKbaxhCOGpC7OcSp18qKUZesNmx+PJsw4ar8o=;
 b=Zkh+wHcRR+EAmwDmz82pirPGyq2G/8AwY5gxBf5LxKvZK8VlPtJ3Ls4cCD9SBU0zeG
 hxh1SjFMrFdpx+KR0TZZ8ngxjXjwNCd2LpsmM34xLYVL40OUORaO20nVER68bfiIoROQ
 Qihf0sSwpijgAXA0/i3dwwb6WvW/m2nTWtysLovfEZ/39CM5jc9OkYNBQyIOQnG3d2fp
 QVXPJAg99AxnIEYDzky2OofRLhFieNNQ0ihlWL9NxhAZOt2K1Ahe2P4QdzR0yEztnXOg
 uBqKsVGtjVBvw6/65zP17qIroniaY15vZ8pxC4Y2daXWJxdTlSK+w0tscokcdvrqQRtn
 Qnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792317497; x=1792922297;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:sender:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CDDfrsuKbaxhCOGpC7OcSp18qKUZesNmx+PJsw4ar8o=;
 b=hvCoao6V+Gz5oVXZoh/f29PQqHuHcM3V8r/ypax5TNa6qKfAmppG/ufx48dAYGvfRs
 AKsuPmOiMAUqhp798VUDR8nZ8D589U0kYfR7pQYjAtGtpBf8QF5ywJY4ps5XoGS8z+hX
 HeuuGwzQucAlJSuvW01bwFMfE/y85Y5CUZ27aWAv1nWgX7xV29LcjlJijvNh6rHbDvEX
 EHomzKfMp6yC7QtMJAfz1W51OfsnrLIg21wje9faxRDe2p5Vrq/2CqH5uyXGlFIxBWP1
 igH83ijgv2DBQRvTF27cfqH0s9xHux3la75c8AEUjNU+6Qa1sBvTcXCRD2IWm6PrXAYu
 SmTw==
X-Gm-Message-State: AFq9FYLgLyN3+qSB+MyqS7AM2qYajqsos1HEHeBsxzxRGaE3GzIym4hX
 Cp/XdE1qtWG+jl7wA6bsk3lqp7E1aNB4EeJbxeSXhZLC/JnfOFWB5M5T
X-Gm-Gg: AYBFou2uZZ0QDFX19MjkcmJh/GXjUGEHHqB052VDsUMAACXNf2tiruhRtYtHFBpOf2k
 FAqmKlhyd+lrJ9O3YpBlJcLlMXinWGIG8iPfYbs9LKUJ3Obww/QV/wDGHBB7oB3T2pFtr07v6Ts
 ivCHPlexZzgPSqff7NAqjUfHh5gleCoPgKn+O1uG60keD2/TP2nh3WNMTDV/halPgk3v+PlY+wR
 QsyN4nWayDonptHxGyRjE6Re+fZIIUsh2Vi4f/tzAXr4SCcS1X3M5jB7lQ/7A3yO+4WNtZu4thn
 8zBuTI37K4zuQo+zTpZjsCtLTlyvNdQxC0kDsM6rdezF4BH9QdihdKyXufbCZ8T2eVkDbWTkpxs
 e01UX4nF/ZvWlGVNGF4/RglVENejEqI/p0vCs/hZooLhRUdUfsznD6FbAi+cARHhsZXxkwJhUak
 lJe0EYYwfMi28y43+PtVFA01RZSnaBIFZiIoy8plvncka8EVPj7T2YrQE7xoN1Vmzqz4zbnKrCx
 Hi4Q96i
X-Received: by 2002:a05:600c:4e11:b0:49f:bc43:9e96 with SMTP id
 5b1f17b1804b1-4a1d75f2396mr90020635e9.8.1792317496825; 
 Sun, 18 Oct 2026 02:58:16 -0700 (PDT)
Received: from [127.0.1.1] ([151.71.143.36]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d0e2bb8dsm159707185e9.2.2026.10.18.02.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 02:58:16 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 18 Oct 2026 11:58:12 +0200
Subject: [PATCH v3] qconfig: Improve the documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-qconfigdoc-v3-1-196dfc8ff05c@gmail.com>
X-B4-Tracking: v=1; b=H4sIADOY1GoC/3WNyw7CIBQFf6VhLaY8VHTlfxgX9ALtNbYoVKJp+
 u9CXZnocpIzcyYSbUAbyaGaSLAJI/ohg1hVBDo9tJaiyUx4zbesrgW9gx8ctsYDdVZJCdJxyRz
 Jwi1Yh88ldjp/OD6ai4WxFMqiwzj68FreEiu7n+HEKKN7o0HJRli32xzbXuN1Db4nJZz4f5Vnt
 eFCKDBGafGlzvP8BlI/PkPxAAAA
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
Changes in v3:
- Fix description of updated example (PCIE1 ~PCIE2)
- Add info and example about whole value matching requirement
- Slightly change string value examples to more effective ones
- Link to v2: https://patch.msgid.link/20261003-qconfigdoc-v2-1-b2338cdd8a35@gmail.com

Changes in v2:
- Reword and add details.
- Update examples about -f options, or their output.
- Link to v1: https://patch.msgid.link/20261003-qconfigdoc-v1-1-9dac84b3ef75@gmail.com

To: u-boot@lists.u-boot-project.org
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 doc/develop/qconfig.rst | 59 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index a18f32470ca..f05ef36c43f 100644
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
@@ -79,24 +82,60 @@ which do not. To use it, first build a database::
 Then you can run queries using the `-f` flag followed by a list of CONFIG terms.
 Each term is CONFIG name, with or without a tilde (~) prefix. The tool searches
 for boards which match the CONFIG name, or do not match if tilde is used. For
-example, to find boards which enabled CONFIG_SCSI but not CONFIG_BLK::
+example, to find boards which enabled CONFIG_PCIE1 but not CONFIG_PCIE2::
 
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
+taking care of needed quoting and escaping. Since the values are stored in the
+database with their double quotes, the quotes must be part of the pattern
+itself. Enclosing the pattern with single quotes makes the shell pass the double
+quotes and backslashes through unchanged.
+
+    ./tools/qconfig.py -f SPL_LDSCRIPT=arch/arm/cpu/armv8/u-boot-spl.lds
+    0 matches
+
+    ./tools/qconfig.py -f SPL_LDSCRIPT="arch/arm/cpu/armv8/u-boot-spl.lds"
+    0 matches
+
+    ./tools/qconfig.py -f SPL_LDSCRIPT='"arch/arm/cpu/armv8/u-boot-spl.lds"'
+    326 matches
+    ...
+
+    ./tools/qconfig.py -f SPL_LDSCRIPT='"arch/arm/cpu/.*/u-boot-spl.lds"'
+    462 matches
+    ...
+
+The pattern must match the whole value stored in the database, therefore::
+
+    ./tools/qconfig.py -f SPL_LDSCRIPT='"arch/arm/cpu/.*/'
+    0 matches
+
+The values stored are the ones from the Kconfig files before expansion, thus::
+
+    ./tools/qconfig.py -f SPL_LDSCRIPT='"arch/arm/cpu/u-boot-spl.lds"'
+    0 matches
+
+    ./tools/qconfig.py -f SPL_LDSCRIPT='"arch/\$\(ARCH\)/cpu/u-boot-spl.lds"' \
+        SYS_ARCH='"arm"'
+    158 matches
     ...
 
 
@@ -245,4 +284,4 @@ Available options
 
 To see the complete list of supported options, run::
 
-  tools/qconfig.py -h
+    ./tools/qconfig.py -h

---
base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
change-id: 20261003-qconfigdoc-fe844c4f241f

Best regards,
--  
Massimo Pegorer <massimo.pegorer+oss@gmail.com>

