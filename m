Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5183BC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22231406AC;
	Mon, 24 Aug 2026 13:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AqJEwkeP_bp8; Mon, 24 Aug 2026 13:13:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787577208;
	bh=JCDc3wtruiVdcrfGDQ+hi3qnpe3cbn6Y3hGHuqEDFN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=grtC6uLwA3Q/a5GeBBs7yqTd+oYOs/oDzLXkSb5QX8qMsFR+l88raSuGXmw/Ww3aH
	 ++SVt6U3O6FnARUClbbRmc42Gsn3qSFsasKb2bDquUsIHYorOsoPuqHF3izkQ6Y4jA
	 ztaaSanhArzAjyXMIpLm4cIwBg+75ur9ZPJ5IrrUd3WQMzMUKQUePcMnwAJNns2rJF
	 j3v3xFKC36hIV1xI/xz2NcD+kzvdMew24aPsG0A1vD760r+dDYh2D2cLnr8+y2RbQx
	 c5oFtKSlh5qLDskptpg1Z/KIeHd2fm7GEQmOPywS33T4ChjYkYtWxomod5dUyO/8ci
	 gGXjtGsPdWdwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F328640695;
	Mon, 24 Aug 2026 13:13:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C97ED386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC10140050
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52iHO21HMM3V for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:13:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=qB6n/TIH
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE15940029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:13:24 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso1269351f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787577202; x=1788182002;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JCDc3wtruiVdcrfGDQ+hi3qnpe3cbn6Y3hGHuqEDFN8=;
 b=qB6n/TIH6CUMXQtukiNOmupCxbkbYgRZWff4ifLkQ3QKmncnMzXdLmGh/zCCS9cr+o
 w6OyzZDhBAkzNdNBzpwwzjDOxiInvmY/iN87S28/+rZ6VEQR0rGOoZnaGfJ4WEAdMLsN
 3SyuhdrY7CAz/xYE3V9F99MsABmhEr4bSz5XvYIQYFvfW7Vrtb2iApw2RdcswCdilGWl
 3TTGAVrU0tbGnkM0c2Q1kdbME9obFRjqS57lmEL3tZVAqoZ3RrjKPTj/II7LaNZFz38/
 x3QkTJ5D+xx6rQ6TDA9hSThlJtel5Qp5MxKnwUY+ELmCrfka7iRrgq4VVQRff7btRst6
 /4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577202; x=1788182002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JCDc3wtruiVdcrfGDQ+hi3qnpe3cbn6Y3hGHuqEDFN8=;
 b=q/Lly2GIRimDTnifcQEyYjP0Mh2OdDbaGtAchJtslA69Ty2byiVJ00ZPys/IICs6mz
 coqsNsFvM14AirCsfcJZo9sbMqLzvUak6Y0TeiZ4Q0Jzx8Kt9LWQ1+a11208VlLyTuiq
 8+kqwsQ9SUJcmix7f/+7NK3vL0KfJUCNUKjF34PkfgqIy3MihpTzzLFe9h6hXDdO6wp4
 Ijq1DHcvmQA/BHoQ3E7x59cwWigx18rNVhwJH5owkx3FhBbwVGvd8p8N8tf6mG3nxNm8
 /oy5p/8MndAiCO44oz4/617D78i1Pm7+zn2W6+arfSc/5F1AZw/UFZCJbW34utpIGkqi
 Km3Q==
X-Gm-Message-State: AFuF++knlZ4yYtlVsmaSLHcmmNZh94y1vwPjvYuxWjE/asQRjaTSFCgt
 x25hQLMPEcZvoE7hsVI+u1SZOd7bh40sTUvWJRSwF/MZW20GN8r35GKSeUkxGtytrSE=
X-Gm-Gg: AR+sD13M5RKEoAoaPixjXvByh4KzOIiso3qlQUsyoOmQ05PQSFdNiKviF+R0umO3DCg
 VNwswsEEzz+1YpgzHTH8I+wmmg8xD9RKTc7pA8xef/XyAuuvalkQLp7CdmAmiogzqeg+J9xcUPC
 zJHHTTbvfRltipK7nkmRyT7+/ZHAaNfqhwHTxXcw2/wPMjOOjY+M/+i94W7Ef9MR1soS2JIc0XU
 /N4Aa4EYgQ5CSkwLyV8RQjM0sjzPxfrEbMigusyTmNEuWUwm9hUWE6XNSwndcWgt6uQsVuihvob
 gcB5Hxh0P1BeBxRC7ePeJuz7ghOB6ehmrnqbdBAvdX45+ic55Oq6M0Ft6DyLIFjwyj/wYyvIxm5
 hJrWHjyr2SUlQtDtvjfeAHdLQdFCDJzyBkqDft7csRRYW5BIVkmJU1/5XSlYPHxaV7+Lby+2WrB
 kEMDhbHoddHE+euqyPc1AqugYDN532ZT2JEBVMXMOCdIuTeV+STPHmGTROTcfvFLY83CnzjD0f4
 pt6lkZyP6FZeusJ5KGjWkXJRDJOUrxCURWutd6Lvw==
X-Received: by 2002:a05:6000:4608:b0:47d:ee9d:90c8 with SMTP id
 ffacd0b85a97d-482c0b44af7mr35971131f8f.3.1787577202313; 
 Mon, 24 Aug 2026 06:13:22 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b85412sm8144059f8f.14.2026.08.24.06.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:13:22 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 24 Aug 2026 17:13:00 +0400
Subject: [PATCH 03/17] pylibfdt: Fix Python crash on getprop deallocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-pylibfdt-sync-v1-3-a42be6fa4872@flipper.net>
References: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
In-Reply-To: <20260824-pylibfdt-sync-v1-0-a42be6fa4872@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Luca Weiss <luca@z3ntu.xyz>, 
 Brandon Maier <brandon.maier@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Simon Glass <sjg@chromium.org>, 
 Rob Herring <robh@kernel.org>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Jz7KTXKQB9AdLkJvaraOMzd99dmNDzz8W3kO5Ej0GKs=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1OGea7znL4JzI9MCAm3eO69e9cyodGOpN7e1EeRdJn
 L+6KkOtYyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKlO4mZkaJRf+67wQPP12zm5e3d+dj4xT3Rm6u1Hoe/Lt4VPlWAuPcLwz2yGscO
 kRTrqMlacR59+W3mYfU5VTUpZ/oW8i93Ln2pNZwEA
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

From: Luca Weiss <luca@z3ntu.xyz>

Fatal Python error: none_dealloc: deallocating None
Python runtime state: finalizing (tstate=0x000055c9bac70920)

Current thread 0x00007fbe34e47740 (most recent call first):
  <no Python frame>
Aborted (core dumped)

This is caused by a missing Py_INCREF on the returned Py_None, as
demonstrated e.g. in https://github.com/mythosil/swig-python-incref or
described at https://edcjones.tripod.com/refcount.html ("Remember to
INCREF Py_None!")

A PoC for triggering this crash is uploaded to
https://github.com/z3ntu/pylibfdt-crash .
With this patch applied to pylibfdt the crash does not happen.

This is a backport of dtc commit d152126bb029 ("Fix Python crash on
getprop deallocation").

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[adapted to U-Boot]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 scripts/dtc/pylibfdt/libfdt.i_shipped | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/dtc/pylibfdt/libfdt.i_shipped b/scripts/dtc/pylibfdt/libfdt.i_shipped
index 55170431357b..5025893b1e95 100644
--- a/scripts/dtc/pylibfdt/libfdt.i_shipped
+++ b/scripts/dtc/pylibfdt/libfdt.i_shipped
@@ -1045,14 +1045,16 @@ typedef uint32_t fdt32_t;
 
 /* typemap used for fdt_getprop() */
 %typemap(out) (const void *) {
-	if (!$1)
+	if (!$1) {
 		$result = Py_None;
-	else
+		Py_INCREF($result);
+	} else {
         %#if PY_VERSION_HEX >= 0x03000000
             $result = Py_BuildValue("y#", $1, (Py_ssize_t)*arg4);
         %#else
             $result = Py_BuildValue("s#", $1, (Py_ssize_t)*arg4);
         %#endif
+    }
 }
 
 /* typemap used for fdt_setprop() */

-- 
2.54.0

