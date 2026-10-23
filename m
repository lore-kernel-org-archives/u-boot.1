Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15575606A31D
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NKucOF0e;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PaFwF/7t
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E467260A81;
	Fri, 23 Oct 2026 19:01:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Murt63DiPyq; Fri, 23 Oct 2026 19:01:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CFA7C60A46
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792782066;
	b=RV5JSfFHMYpZTsO1JTz06S94nWpP+s0HDS0r+u01BP+Vwae8JKJ+YCVpBgQPyz59QEPj
	 MfP7JtcNbZopJOnwRzUEDSOFd3NNEdvtWaWbVQIpsyneH+Nf078n55h4MGZg8ABKTQFDb
	 qRfaEoEGscVk2k9KF4oDPCghTx8hHW5OHMK27v2jPCH8BA5epiIC5x8/MLOCkUsm2jA18
	 CEScqkJVg2nJw2wMPE7QGDytQQIKJuzDH6dnf4EMkF8vlm6y7YbpNuXTI0w2QqCLHNpuD
	 faWWb6WMezgKiz/4ikF4ZArlqt/x7BPKVKiLd38Ylgp5LthH2QseM9pKN/EvlAcTqMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792782066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fQM4OB70yHljkTQIXDFh09eJLZnlOPz1F/zPtXTuviQ=;
	b=pQtpUD0mjPvcJdEjGBcddvqVsM4vKwaNE7LivJYg8HlwfADl6rQ9F1xnzaPefkSd+yg2
	 /AqLwZe621E5BJTQX5tlSAxzgEKUdfoRaTzKAKJC1nvidOrx9bv/iLcYXxplBhozcen4q
	 F20ry70xve/9gWIkTHX6Bi2p5AdwNY5sN4ZVWJ5svYc7CJin5l/9N2QgMVSCOspnE6n+9
	 LqnkSkazzxKeH5F4yEEeqd2yRvjWLZLllS0gt4+vwj54yo0Xf+S9Bn1M3+oq0iAuCifvk
	 Okgqv5bbthO8RH45uFywwUuM6LGDdD9lz7PPTzXpfmsxY7uJLUn3usYCd4C8QZELsPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="PaFwF/7t";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792782066;
	bh=fQM4OB70yHljkTQIXDFh09eJLZnlOPz1F/zPtXTuviQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NKucOF0eDd7qmCzjOcuwmciepFXR/+Dlxwq7H1FfGYCfRk6B2ZW2TcEAPFEqfeM/F
	 PRB72Ekb0ak5mBoIzP5zV3EkG5Zea7y+qZ6dycwOuihUw0RqNtfwZY60OgTAHOh8RW
	 r07HHd6OkBt502m554flDflYt9mvJ4m1gq9FWxFcb5dRwsytNoVWdTJqqB+r2VP/0K
	 OsnC5GQyjT8V1tDUp7HZuJiu0A/AnSpnWvXcnw1EYe8bIWhQ3WoK/2D1lrs0JW8ukB
	 RNyuUkdbnBc7qwg0qieJVXMuTOt+J8+D0N/5Cgv1hrBpUgP8VFE6rW6rY/Z1LKHXEf
	 0YmXS8ocH+OFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFA7C60A46;
	Fri, 23 Oct 2026 19:01:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A700F3C4
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9660D60A41
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:01:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7evfLeFuQpoO for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 19:01:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4E2160A5C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792782059;
 b=EgEBVklXgmcZXywX7s2BGESkfWfDYnLXbRuIMSQrZFHpmSxJSwv6U7XhE0DJzOx1G4hP
 0N07zYDIqOrwC5sF5s3VQJDYOaB51baaGpmpt2Wpb/zAP3WzJ6lQO0gWttpsuINmK12o1
 QG1QJgADqIl8FB49TLyBHhfClvY6z+gfjvxOqgHq37cetCXoUWV4qjhL5vs7dQ7ifjYK8
 cJE8UgymEZuOsriy2WV+EaEHh78kKZbS+PZ+XUxT6mSoSC1i7MI/ekA/7F7kQfe7FIl8L
 Q5v7UKjPvpsXmQznv2zmrh+5hUNyOYhW7SmX3G8EMPoAYqOKWBILAFEjORXOQay14Ng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792782059;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=fQM4OB70yHljkTQIXDFh09eJLZnlOPz1F/zPtXTuviQ=;
 b=Fpok9iW7+N3lc17jlf5JISPOK3YBrHuis9OCkepZ0U1kVELwYXCGr6vSc7x1kxCj8+RN
 PevCgIkvansu1qU5zAwZdLqXGxITablMqx+2KNO5qnYCS1v3JaCBetO/3k8SlPmx2MdUm
 QzYirhEf2kyC2OkR4WFpMBKwUKqpj/XxmXZw9o3LJbmstStBSgsUuuafgR49tl5gH9kJu
 2hUk0Lvn0TZH2TANNDsZwIUkwXhnX8rlVSL4T3M255QqCiEnrKgR9JCRZ5QSKf7VyRGve
 qAwDw9VGDCIN+sW4HuKqevg6ck+BjGmsbWngZwyO6F2dz26NhvHkAayf+1XFkUgRMQA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="PaFwF/7t"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PaFwF/7t
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4E2160A5C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 19:00:58 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so1945515e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792782056; x=1793386856;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fQM4OB70yHljkTQIXDFh09eJLZnlOPz1F/zPtXTuviQ=;
 b=PaFwF/7trcQ9zwGANB7qNyc2RirRh96zh6vYQxM9wVlwxGB0gQRdf3ITjOiN/KfeE7
 JEhxzGSXUcEu2gNsan+Zr5a9yflUR/Z1D7vTDzHy5ycujDIdpcTcYEUdOu9W8whgiGtl
 7eOstGzdcEJvPMXt94N0gm6MyzmvME/yd3PvTzXBCueAMraQlgFv+NaaFng9OPPN6p2P
 I9rvbtVuVUNALnV3VzUUUEVHrWIye0PegGmb0cveZHMN+hj9QtJpV+Z0XALelA62mdT3
 gMUGi4te1onstycDh7PG3aVDKjsyuVQaZb+NrZXiKXzsKJFkoj2w1UJENMtcfZhcclWK
 m1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792782056; x=1793386856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fQM4OB70yHljkTQIXDFh09eJLZnlOPz1F/zPtXTuviQ=;
 b=hspSpDH5sT3msUDWocqyNBpHe4X2F32l5wTUX+gIcAG7UiPBdWySIoc/6bQtqSSSmd
 /93OHol4W9wKjrZHprYSUrIwhFOiwWNR+0xhWLR6V+9ciud725V1s7sYjXkcmcsPvgDj
 azt5BJ6o+cvCOXgZfxHtqFpHKT1EDjp/dUJOvarfO3LNgk2DMRAuiRlfRx70C8zyjIhg
 jM0hO0Lp3sAGz36H4wExbYe9B+4GvTIqfMkEGGBcn/+rEHdlIGITbw8JesoUiqkZZHRL
 TyA2dv/GnBBgau+6MDOcNeCpQdhD1dN6bl5Eekxsf/yQJTWx/SmK3cYqPq0SE2kA9zgx
 uyXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAWmIhsDlvxmZSuIG1s34laVX9RwuqRliDIxMask4X/qzk7NLYkUTdIKfDF1cKHLgK03hM1oc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJsLyqlIXaaCsrTu/7I40Dvz6hkC510kgDBydBeb7+AsqzZQ91Z
 XdRKKlJH/QqkUMuKh5FtEdWrhvAYlg6FvgbxJWr8pmRe9IOCtVYlLTUa
X-Gm-Gg: AYBFou2zkqdq+DEMUPF3rcT4iTmuIMZUMhNRKWyYAAaqVxORS8iVfxX9wihoa/tzhoO
 PEXVg6KzptlgfZ6FICXAuNnMZQJbWPQMjAgU8dPxGNhB0TzCtbMTLvXsihm5QN3ru5JJk9FPz/C
 IelEw6H326IEDuFH+V9GWDa+0a9tgsfzLKKQ6J4oxZysYFUr8+PG2Jtqh1nMlzB/F7f5aOm8rx/
 EfiHGse5Nqeb2rChRKxizAfeujYsGK87gYm5nEcq1yKwAeWBqkzOOp7AXEglmjuKUg8J3s7txDl
 2h0Ms6xr3RZReAVqxVOA/afFbFmfvRwJOsR6OAMHElXmWqs3+2j8ifnLJRJOAod/QuLWfwJtUBg
 fxpA6xBvdvfp2rdVCuGpauOkmiCcTlgP1eTosc+scrpVC+HssQZgzQz6DHyg1xODSf+RCHZeHQm
 YaOq2XjKBOHKMa7Cx/G3yZ5ibifTZorl5g/omyXOP728XB6HbCl6/xJjxO9wVfhZfelWyCE13aW
 gtVGAhjkGVuTcXySU1yy0sDxGRrBBVri2b/gybd2o/3+teQWuM5PDU9oNfLx84qsC8X9iylIm4r
 VDAfs5Prt/xIcjqObWn0NfeETVIdbRHY2CCqBBQmMtsqxpsC2+3vRRPZ3bTx
X-Received: by 2002:a05:600c:1f87:b0:4a2:17f0:ec8e with SMTP id
 5b1f17b1804b1-4a217f0ed0fmr36987925e9.17.1792782056048; 
 Fri, 23 Oct 2026 12:00:56 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0aa097sm2481275e9.3.2026.10.23.12.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 12:00:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Johan Jonker <jbx6244@gmail.com>, Neha Malcom Francis <n-francis@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v9 6/8] doc: dtbinding: Update documentation for Generic
 Firmware loader
Date: Fri, 23 Oct 2026 21:00:27 +0200
Message-ID: <20261023190034.911023-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023190034.911023-1-ansuelsmth@gmail.com>
References: <20261023190034.911023-1-ansuelsmth@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update documentation for Generic Firmware loader to YAML schema,
generalize it from FS specific and add new property and example
for FIP loader.

Also add details on the usage of 'phandlepart', 'mtdpart' and 'ubivol'
property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 doc/device-tree-bindings/misc/fs_loader.txt  |  48 --------
 doc/device-tree-bindings/misc/fw_loader.yaml | 112 +++++++++++++++++++
 2 files changed, 112 insertions(+), 48 deletions(-)
 delete mode 100644 doc/device-tree-bindings/misc/fs_loader.txt
 create mode 100644 doc/device-tree-bindings/misc/fw_loader.yaml

diff --git a/doc/device-tree-bindings/misc/fs_loader.txt b/doc/device-tree-bindings/misc/fs_loader.txt
deleted file mode 100644
index 542be4b25a0a..000000000000
--- a/doc/device-tree-bindings/misc/fs_loader.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* File system firmware loader
-
-Required properties:
---------------------
-
-- compatible: should contain "u-boot,fs-loader"
-- phandlepart: which block storage device and partition the image loading from,
-	       this property is required for mmc, usb and sata. This is unsigned
-	       32-bit array. For example phandlepart=<&mmc_0 1>, meaning use
-	       that MMC0 node pointer, partition 1.
-- mdtpart: which partition of ubi the image loading from, this property is
-	   required for ubi and mounting.
-- ubivol: which volume of ubi the image loading from, this property is required
-	  for ubi and mounting.
-
-Example of storage device and partition search set for mmc, usb, sata and
-ubi in device tree source as shown in below:
-
-	Example of storage type and device partition search set for mmc, usb,
-	sata and ubi as shown in below:
-	Example for mmc:
-	fs_loader0: fs-loader@0 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&mmc_0 1>;
-	};
-
-	Example for usb:
-	fs_loader1: fs-loader@1 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&usb0 1>;
-	};
-
-	Example for sata:
-	fs_loader2: fs-loader@2 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		phandlepart = <&sata0 1>;
-	};
-
-	Example for ubi:
-	fs_loader3: fs-loader@3 {
-		bootph-all;
-		compatible = "u-boot,fs-loader";
-		mtdpart = "UBI",
-		ubivol = "ubi0";
-	};
diff --git a/doc/device-tree-bindings/misc/fw_loader.yaml b/doc/device-tree-bindings/misc/fw_loader.yaml
new file mode 100644
index 000000000000..9a767ff57469
--- /dev/null
+++ b/doc/device-tree-bindings/misc/fw_loader.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/fw_loader.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: U-Boot Generic Firmware Loader
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Generic firmware loader for loading images from block storage devices
+  (MMC, USB, SATA) and UBI storage.
+
+  The fs-loader loads firmware images, while the fip-loader locates a
+  Firmware Image Package (FIP), optionally at a specified byte offset
+  within the selected partition.
+
+properties:
+  compatible:
+    enum:
+      - u-boot,fs-loader
+      - u-boot,fip-loader
+
+  phandlepart:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Specifies the block storage device and partition from which the
+      image is loaded. Required for MMC, USB, and SATA devices.
+
+      The first cell is a phandle to the storage device, and the second
+      cell is the partition number.
+
+  mtdpart:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Specifies the MTD partition from which the image is loaded.
+      Required for UBI devices.
+
+  ubivol:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Specifies the UBI volume from which the image is loaded.
+      Required when loading from a UBI device.
+
+  partoffset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Byte offset within the selected partition where the FIP header
+      is located.
+
+required:
+  - compatible
+
+oneOf:
+  - required:
+      - phandlepart
+
+    properties:
+      mtdpart: false
+      ubivol: false
+
+  - required:
+      - mtdpart
+      - ubivol
+
+    properties:
+      phandlepart: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: u-boot,fs-loader
+    then:
+      properties:
+        partoffset: false
+
+additionalProperties: false
+
+examples:
+  - |
+    fw_loader0: fs-loader@0 {
+        bootph-all;
+        compatible = "u-boot,fs-loader";
+        phandlepart = <&mmc_0 1>;
+    };
+
+  - |
+    fw_loader3: fs-loader@3 {
+        bootph-all;
+        compatible = "u-boot,fs-loader";
+        mtdpart = "UBI";
+        ubivol = "ubi0";
+    };
+
+  - |
+    fw_loader4: fip-loader@4 {
+        bootph-all;
+        compatible = "u-boot,fip-loader";
+        phandlepart = <&mmc0 0>;
+        partoffset = <0x100>;
+    };
+
+  - |
+    fw_loader5: fip-loader@5 {
+        bootph-all;
+        compatible = "u-boot,fip-loader";
+        mtdpart = "ubi";
+        ubivol = "bl31";
+    };
-- 
2.55.0

