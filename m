Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD860A260A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tOJpZVJh;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IlnsWXLz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 102ED6078E;
	Tue, 27 Oct 2026 12:39:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kiaBgmV4anIs; Tue, 27 Oct 2026 12:39:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0641260788
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793104766;
	b=HNGwGAQML2CxUd4/vkUtnTgnzqOrT0mCdj1c2wldtvTOo5eFfxWVLDcYaLrPdPuD7lYZ
	 5Rv9KedM62l2D3oz8To5ElWbX1vlYD53PslkdwkC8FA5yPmLL1x0yd4y1iibbbNpfG2FT
	 TO2BzJ4Z/5u7+6erY3V5mMgspEeaudYlIj9HEk2KSy572btx7ZyDJUcxMH2YjIOVvtaHi
	 NVPTsozFgcDaIxkImmXviGvtkCmqtO/dmB/LtpNQjQb+BOikmYUgen2hKXoo/wwtO7QpX
	 wzvGGKp49B82ZvPFg+U4FqlFT0EqlEjVP8qVc5N5yARx2Abp/QR/Wbm37fKNZNUjEfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793104766;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tG5JoKrPZdkjzZIOC3DuTfsjQnGxMnI1LQtuwh3fwC4=;
	b=AwE0KiV4s/sbHnCzYgXvHuInY5ZslSvZnYE4NunY4nY/zXBlosg9zdtnG2nB0d52Ihje
	 S4tK6kDttfqRATnlp7beVQaYgXLMBGWKKLRRAokKa7+aFUENU4LxmYC5TvV7fSlmbfbdR
	 k77YA59j5I/DjvVrQ8hWIHl1qGPMqZcjFs8UYm4Xctaa5VkP+kYLagmCTCvnadAcnoukW
	 cJxh35IoPuFMJbFex3ONcdWyxF56XVkBUWGmxz2Xi6lqGBac25VMIrFY0ANSf/8JVsdT1
	 28fOs7OSbutOadVpeTMg8a22ouyZ/3Gxq35NpZ1gZAt1pZ2ats053h8O1Y9f5trwumw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793104766;
	bh=tG5JoKrPZdkjzZIOC3DuTfsjQnGxMnI1LQtuwh3fwC4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tOJpZVJhpZckR5DgoruFYvM7ZKdnDV3FrBEQ3vNa/1EoO/RLLYjKd2XQkhBHMB4EB
	 Q1GDVv9aOuoxBkQPpd4aLiDFwPn1yIKzxHAiBeAYrP7NipXLY8AV5LAUEXf6TdMCFz
	 uW7kEO8SS+Go2XOGUbhMH497qv96CevtBd+Ake+f9nlyfNrjPsapwueBQDMbVec1kk
	 L2TcfPrH5PMhlkGB3dw71NDaT45APqk8Ysupuy6bpQln5sYWlenzUDSPW/qfJeBab8
	 9buI5JaC3XfoF60paEfkkj2atXasPE7Po4Y736LGaNEFQekb40EgBkU60dHLFhed3K
	 hfBMKFI0UrkOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0641260788;
	Tue, 27 Oct 2026 12:39:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 590FC3D9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4AE7240635
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ebqdojWjEofJ for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:39:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0CEB64059B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793104761;
 b=NQQxnv8ofZ8BvRMCzasHB5+mcpBCaU/MybStOos+6sQGd6TLMj54UvK12OVLacPGGLoX
 t3635beBTIBy2KcJsh3dNlooKRhajW4kIqLdTyd75c3o8VzHxNVwBTMGApbYW1BnAJbh7
 RHU0H2WVemOlpGi/HhZhSX/P9i8MHuwK63PXvR+HwoqLWPXIhwXdrVMbquPDjpHuwfBhB
 myek7rUVKyxl9ODOvn3O4H/nN//g8IUWC0OFGnKvTJf2Kf6PpdcLuSY0EeItwbV324N8y
 /t9OBJE6FS7Mm/YPH4waDZi21K2RzfMq83sHWGxtCVxK2rUU76JoY3nA/nU+nWySQhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793104761;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=tG5JoKrPZdkjzZIOC3DuTfsjQnGxMnI1LQtuwh3fwC4=;
 b=N7NsS974IAOaF+J7NG3oM16ODX1IxuC6jOo6DRnHQ/WyiT8GwDCJ2pCdCktcl967E/kX
 XWutCxkB7xT/6s+hwjXoxc0zsytSPPEfJhUJRdfiXnd0omx1Lee1fCcjynO01fqBG9TSf
 UiXS/PXGkvQutw3+k+KxJ+Xfolfs7uDYcZJcWJmyUMmKuZ2bNDW6BC4m3YlVWPgRuVP5l
 duoCWyyD4Cq2Py4jjqIsflgBNqG1wGgIu4IMT1Qb3iVauRFY5cvpWxvLmEpfq/Wc7dKVQ
 xVwQB/XEah2cFG9UfwuqkQboLPKu65VKE1OpMkRTeTywDz3St6aCRYyizKVC+EjK6bw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IlnsWXLz; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=IlnsWXLz
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CEB64059B
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:20 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so3379032f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793104759; x=1793709559;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tG5JoKrPZdkjzZIOC3DuTfsjQnGxMnI1LQtuwh3fwC4=;
 b=IlnsWXLzWR8OtPuN9VvfFufwJ6OdI8pr/2H8pbQtrhDDnqcuxzmBJUMY3tHCg7LRtv
 VTA7YeiF5qsppvw5FjbprD+Nvsdb+C2bSO0v37DmHjUQOdc8ITzeKCcOce7kMNIK1gEI
 1VUXz8Yi0PBXdcDKrZRqmgJ39ixFq8+7N4vHIwBzuwVQTyr3o424MzxjVR7MduiRUjac
 bjsopLvXHGHoIdLi+Qtvs0yOCas26nfwvd1fs6xl3bdLz2ANxhgF8klp9Njg43ehvH4U
 UyqIotvvaenO/2gjl2OQGBhkvsKj6OhMQ/wryiDZt1ZyB3oeG317oOJYls6LQla1WPDn
 Ko7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104759; x=1793709559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tG5JoKrPZdkjzZIOC3DuTfsjQnGxMnI1LQtuwh3fwC4=;
 b=zzf1urcHHpL5MTfmBqDOT0lhtH8QffJzjmCDk2Vk+L5L0PHvKuLILJ5kxaqCVpMYxv
 D7+R7svhyDhjPV6/54eSpzJBsD+Ln5VdKQMwAle/BNlrS1qMYghxdt5OrmPi3J8xe078
 e20ysG2wVM2qunWPsSR7gT7PhLTktV20cIqiApZtMKJW82jgMo421cvTs5kW+BiKXG4W
 d7+G73hIdpjO0NkU+frQRtCY4IiAhoeetyMgxBdO4Gy8sr0e5wrq2vGDwTBpmaFKVQ8l
 5PrKdX+mzDtYeUttlJshrKNPAHY0zDKLPL/eyaJBesDWbRHgahdk0Nm0NTVnC78HhaNP
 rn4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOragpduGfPcK28TfqPBk0DDnoY2J/PxnNrNtSdMQpMuNbkRA0ahxqfJ1zzq/DLXbKpWpMAJI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIHCRrcoO83LLIcAPOIBN14l4bDtLQNxJxXHgk7PP5Z5RH5fitM
 mWTKVhr27h2wQ3Wc5SAJYjkX47mfcToSR+h0+eZ1D9t86qSpVTeU2jXG
X-Gm-Gg: AYBFou0+P4dksy8rt0Pvg18mY4ra530pg7soMPl6fSDrqR+DFBRRHlo14ZzdI8oS37r
 DVKIykeGCiCbdob4J8cVBf0qWObkCHqfRBaR7JhX+L65i1dzXmpTZGKX0g1q1/uQvFod2+t3Mc2
 lL2GuL+wBLYNIlQNx8d0AHCs7NHoioIJJ8RakE5eO3NHUFPYIX3NK2DITRYT4GV3k4vrpki7/ct
 Y/R11ER9USUKREG006bEdgMbC/CUX76MLPTiJNfrGUc85PoJOWEGWV7R51NRAnV+3aS9wbtLqv/
 dnhgSpnlB2Vg2bYg7RjtBsu7nnzGipunqxfkqaainNTOXgE/zpKywr82uOUdoIrFAGzGcrWHNOY
 gDlOp4/BHSKxYasuIlsrwSbiq5CTG8KmjFTyS1SX/z7JvKnc2r9EmaRVvvf3AlZhqjGbhqDmtrH
 cIdCk+fR2+vuKYf5LiMpJkRwQ8tDI1Wtxpndu5WGnMCNm8PRMTD2uGlmlScqVx+LNZ/THFPH8sU
 7nuKu7ed8zOM6S1hus3dL0+RBUKIoGNX46SiSX022PMIO8odFJskdKNL/PqhOj5CztTVdBFoZjg
 IOHkmYpoThQfDcMU1L4uwf0PQyR6UZUvMNGmn3EcypLWvBPznT7hfa3cOPWclw==
X-Received: by 2002:a05:600c:5246:b0:4a0:eae0:769a with SMTP id
 5b1f17b1804b1-4a35ace0486mr194078865e9.28.1793104758270; 
 Tue, 27 Oct 2026 05:39:18 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm29142078f8f.49.2026.10.27.05.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:39:17 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Rasmus Villemoes <ravi@prevas.dk>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neha Malcom Francis <n-francis@ti.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v11 2/8] misc: fs_loader: reorganize and split to FS loader
 and FW UCLASS
Date: Tue, 27 Oct 2026 13:38:57 +0100
Message-ID: <20261027123905.839-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027123905.839-1-ansuelsmth@gmail.com>
References: <20261027123905.839-1-ansuelsmth@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In preparation to the introduction of variant of the FS loader,
reorganize and split the driver to generic fw_loader UCLASS and
specific fs_loader function. Create a dedicated directory for the loader
and move the internal structs and functions to a dedicated header file.
While at it also drop some redundant check and rename some variables as we
are updating the code for the UCLASS rework.
Doc are renamed and updated to a more generic name and for the new UCLASS.

This will permit to reuse all the property and logic of FS loader
with container that are not exactly a readable filesystem.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 ...irmware_loader.rst => firmware_loader.rst} |   6 +-
 doc/develop/driver-model/index.rst            |   2 +-
 drivers/misc/Kconfig                          |   8 +
 drivers/misc/Makefile                         |   2 +-
 drivers/misc/fs_loader.c                      | 328 ------------------
 drivers/misc/fw_loader/Makefile               |   4 +
 drivers/misc/fw_loader/fs_loader.c            | 175 ++++++++++
 drivers/misc/fw_loader/fw_loader-uclass.c     | 188 ++++++++++
 drivers/misc/fw_loader/internal.h             |  91 +++++
 include/dm/uclass-id.h                        |   2 +-
 include/fs_loader.h                           |  47 +--
 include/fw_loader.h                           |  19 +
 12 files changed, 493 insertions(+), 379 deletions(-)
 rename doc/develop/driver-model/{fs_firmware_loader.rst => firmware_loader.rst} (95%)
 delete mode 100644 drivers/misc/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/Makefile
 create mode 100644 drivers/misc/fw_loader/fs_loader.c
 create mode 100644 drivers/misc/fw_loader/fw_loader-uclass.c
 create mode 100644 drivers/misc/fw_loader/internal.h

diff --git a/doc/develop/driver-model/fs_firmware_loader.rst b/doc/develop/driver-model/firmware_loader.rst
similarity index 95%
rename from doc/develop/driver-model/fs_firmware_loader.rst
rename to doc/develop/driver-model/firmware_loader.rst
index 630daf636f18..2d11a74d5e2f 100644
--- a/doc/develop/driver-model/fs_firmware_loader.rst
+++ b/doc/develop/driver-model/firmware_loader.rst
@@ -4,7 +4,7 @@
 File System Firmware Loader
 ===========================
 
-This is file system firmware loader for U-Boot framework, which has very close
+This is firmware loader for U-Boot framework, which has very close
 to some Linux Firmware API. For the details of Linux Firmware API, you can refer
 to https://docs.kernel.org/driver-api/firmware/index.html.
 
@@ -87,7 +87,7 @@ For example of getting DT phandle from /chosen and creating instance:
 	}
 
 	phandle = fdt32_to_cpu(*phandle_p);
-	ret = uclass_get_device_by_phandle_id(UCLASS_FS_FIRMWARE_LOADER,
+	ret = uclass_get_device_by_phandle_id(UCLASS_FIRMWARE_LOADER,
 					     phandle, &dev);
 	if (ret)
 		return ret;
@@ -145,7 +145,7 @@ instance:
 
 .. code-block:: c
 
-	ret = uclass_get_device_by_phandle_id(UCLASS_FS_FIRMWARE_LOADER,
+	ret = uclass_get_device_by_phandle_id(UCLASS_FIRMWARE_LOADER,
 					     phandle, &dev);
 	if (ret)
 		return ret;
diff --git a/doc/develop/driver-model/index.rst b/doc/develop/driver-model/index.rst
index 8e12bbd9366a..b2d46da4e239 100644
--- a/doc/develop/driver-model/index.rst
+++ b/doc/develop/driver-model/index.rst
@@ -15,7 +15,7 @@ subsystems
    design
    ethernet
    fdt-fixup
-   fs_firmware_loader
+   firmware_loader
    i2c-howto
    livetree
    migration
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5f22bcb330ee..1cab469a3434 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -621,8 +621,12 @@ config MPC83XX_SERDES
 	help
 	  Support for serdes found on MPC83xx SoCs.
 
+config FW_LOADER_UCLASS
+	bool
+
 config FS_LOADER
 	bool "Enable loader driver for file system"
+	select FW_LOADER_UCLASS
 	help
 	  This is file system generic loader which can be used to load
 	  the file image from the storage into target such as memory.
@@ -630,8 +634,12 @@ config FS_LOADER
 	  The consumer driver would then use this loader to program whatever,
 	  ie. the FPGA device.
 
+config SPL_FW_LOADER_UCLASS
+	bool
+
 config SPL_FS_LOADER
 	bool "Enable loader driver for file system in SPL"
+	select SPL_FW_LOADER_UCLASS
 	depends on SPL
 	help
 	  This is file system generic loader which can be used to load
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 9ddbe9cd1142..f138ff9126f1 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_FSL_DEVICE_DISABLE) += fsl_devdis.o
 obj-$(CONFIG_FSL_IFC) += fsl_ifc.o
 obj-$(CONFIG_FSL_IIM) += fsl_iim.o
 obj-$(CONFIG_FSL_SEC_MON) += fsl_sec_mon.o
-obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
+obj-$(CONFIG_$(PHASE_)FW_LOADER_UCLASS) += fw_loader/
 obj-$(CONFIG_GATEWORKS_SC) += gsc.o
 obj-$(CONFIG_GXP_EEPROM) += gxp_eeprom.o
 obj-$(CONFIG_GDSYS_IOEP) += gdsys_ioep.o
diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
deleted file mode 100644
index cd4695b08eea..000000000000
--- a/drivers/misc/fs_loader.c
+++ /dev/null
@@ -1,328 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
- /*
- * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
- *
- */
-
-#define LOG_CATEGORY UCLASS_FS_FIRMWARE_LOADER
-
-#include <dm.h>
-#include <env.h>
-#include <errno.h>
-#include <blk.h>
-#include <fs.h>
-#include <fs_loader.h>
-#include <log.h>
-#include <dm/device-internal.h>
-#include <dm/root.h>
-#include <linux/string.h>
-#include <mapmem.h>
-#include <malloc.h>
-#include <spl.h>
-
-#ifdef CONFIG_CMD_UBIFS
-#include <ubi_uboot.h>
-#endif
-
-/**
- * struct firmware - A place for storing firmware and its attribute data.
- *
- * This holds information about a firmware and its content.
- *
- * @size: Size of a file
- * @data: Buffer for file
- * @priv: Firmware loader private fields
- * @name: Filename
- * @offset: Offset of reading a file
- */
-struct firmware {
-	size_t size;
-	const u8 *data;
-	const char *name;
-	u32 offset;
-};
-
-#ifdef CONFIG_CMD_UBIFS
-static int mount_ubifs(char *mtdpart, char *ubivol)
-{
-	int ret = ubi_part(mtdpart, NULL);
-
-	if (ret) {
-		debug("Cannot find mtd partition %s\n", mtdpart);
-		return ret;
-	}
-
-	return cmd_ubifs_mount(ubivol);
-}
-
-static int umount_ubifs(void)
-{
-	return cmd_ubifs_umount();
-}
-#else
-static int mount_ubifs(char *mtdpart, char *ubivol)
-{
-	debug("Error: Cannot load image: no UBIFS support\n");
-	return -ENOSYS;
-}
-#endif
-
-static int select_fs_dev(struct device_plat *plat)
-{
-	int ret;
-
-	if (plat->phandlepart.phandle) {
-		ofnode node;
-
-		node = ofnode_get_by_phandle(plat->phandlepart.phandle);
-
-		struct udevice *dev;
-
-		ret = device_get_global_by_ofnode(node, &dev);
-		if (!ret) {
-			struct blk_desc *desc = blk_get_by_device(dev);
-			if (desc) {
-				ret = fs_set_blk_dev_with_part(desc,
-					plat->phandlepart.partition);
-			} else {
-				debug("%s: No device found\n", __func__);
-				return -ENODEV;
-			}
-		}
-	} else if (plat->mtdpart && plat->ubivol) {
-		ret = mount_ubifs(plat->mtdpart, plat->ubivol);
-		if (ret)
-			return ret;
-
-		ret = fs_set_blk_dev("ubi", NULL, FS_TYPE_UBIFS);
-	} else {
-		debug("Error: unsupported storage device.\n");
-		return -ENODEV;
-	}
-
-	if (ret)
-		debug("Error: could not access storage.\n");
-
-	return ret;
-}
-
-/**
- * _request_firmware_prepare - Prepare firmware struct.
- *
- * @dev: An instance of a driver.
- * @name: Name of firmware file.
- * @dbuf: Address of buffer to load firmware into.
- * @size: Size of buffer.
- * @offset: Offset of a file for start reading into buffer.
- *
- * Return: Negative value if fail, 0 for successful.
- */
-static int _request_firmware_prepare(struct udevice *dev,
-				    const char *name, void *dbuf,
-				    size_t size, u32 offset)
-{
-	if (!name || name[0] == '\0')
-		return -EINVAL;
-
-	struct firmware *firmwarep = dev_get_priv(dev);
-
-	if (!firmwarep)
-		return -ENOMEM;
-
-	firmwarep->name = name;
-	firmwarep->offset = offset;
-	firmwarep->data = dbuf;
-	firmwarep->size = size;
-
-	return 0;
-}
-
-/**
- * fw_get_filesystem_firmware - load firmware into an allocated buffer.
- * @dev: An instance of a driver.
- *
- * Return: Size of total read, negative value when error.
- */
-static int fw_get_filesystem_firmware(struct udevice *dev)
-{
-	loff_t actread = 0;
-	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
-	int ret;
-
-	storage_interface = env_get("storage_interface");
-	dev_part = env_get("fw_dev_part");
-	ubi_mtdpart = env_get("fw_ubi_mtdpart");
-	ubi_volume = env_get("fw_ubi_volume");
-
-	if (storage_interface && dev_part) {
-		ret = fs_set_blk_dev(storage_interface, dev_part, FS_TYPE_ANY);
-	} else if (storage_interface && ubi_mtdpart && ubi_volume) {
-		ret = mount_ubifs(ubi_mtdpart, ubi_volume);
-		if (ret)
-			return ret;
-
-		if (!strcmp("ubi", storage_interface))
-			ret = fs_set_blk_dev(storage_interface, NULL,
-				FS_TYPE_UBIFS);
-		else
-			ret = -ENODEV;
-	} else {
-		ret = select_fs_dev(dev_get_plat(dev));
-	}
-
-	if (ret)
-		goto out;
-
-	struct firmware *firmwarep = dev_get_priv(dev);
-
-	if (!firmwarep) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
-			firmwarep->offset, firmwarep->size, &actread);
-
-	if (ret) {
-		debug("Error: %d Failed to read %s from flash %lld != %zu.\n",
-		      ret, firmwarep->name, actread, firmwarep->size);
-	} else {
-		ret = actread;
-	}
-
-out:
-#ifdef CONFIG_CMD_UBIFS
-	umount_ubifs();
-#endif
-	return ret;
-}
-
-/**
- * request_firmware_into_buf - Load firmware into a previously allocated buffer.
- * @dev: An instance of a driver.
- * @name: Name of firmware file.
- * @buf: Address of buffer to load firmware into.
- * @size: Size of buffer.
- * @offset: Offset of a file for start reading into buffer.
- *
- * The firmware is loaded directly into the buffer pointed to by @buf.
- *
- * Return: Size of total read, negative value when error.
- */
-int request_firmware_into_buf(struct udevice *dev,
-			      const char *name,
-			      void *buf, size_t size, u32 offset)
-{
-	int ret;
-
-	if (!dev)
-		return -EINVAL;
-
-	ret = _request_firmware_prepare(dev, name, buf, size, offset);
-	if (ret < 0) /* error */
-		return ret;
-
-	ret = fw_get_filesystem_firmware(dev);
-
-	return ret;
-}
-
-static int fs_loader_of_to_plat(struct udevice *dev)
-{
-	u32 phandlepart[2];
-
-	ofnode fs_loader_node = dev_ofnode(dev);
-
-	if (ofnode_valid(fs_loader_node)) {
-		struct device_plat *plat;
-
-		plat = dev_get_plat(dev);
-		if (!ofnode_read_u32_array(fs_loader_node,
-					  "phandlepart",
-					  phandlepart, 2)) {
-			plat->phandlepart.phandle = phandlepart[0];
-			plat->phandlepart.partition = phandlepart[1];
-		}
-
-		plat->mtdpart = (char *)ofnode_read_string(
-				 fs_loader_node, "mtdpart");
-
-		plat->ubivol = (char *)ofnode_read_string(
-				 fs_loader_node, "ubivol");
-	}
-
-	return 0;
-}
-
-static int fs_loader_probe(struct udevice *dev)
-{
-#if CONFIG_IS_ENABLED(DM) && CONFIG_IS_ENABLED(BLK)
-	int ret;
-	struct device_plat *plat = dev_get_plat(dev);
-
-	if (plat->phandlepart.phandle) {
-		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
-		struct udevice *parent_dev = NULL;
-
-		ret = device_get_global_by_ofnode(node, &parent_dev);
-		if (!ret) {
-			struct udevice *dev;
-
-			ret = blk_get_from_parent(parent_dev, &dev);
-			if (ret) {
-				debug("fs_loader: No block device: %d\n",
-					ret);
-
-				return ret;
-			}
-		}
-	}
-#endif
-
-	return 0;
-};
-
-static const struct udevice_id fs_loader_ids[] = {
-	{ .compatible = "u-boot,fs-loader"},
-	{ }
-};
-
-U_BOOT_DRIVER(fs_loader) = {
-	.name			= "fs-loader",
-	.id			= UCLASS_FS_FIRMWARE_LOADER,
-	.of_match		= fs_loader_ids,
-	.probe			= fs_loader_probe,
-	.of_to_plat	= fs_loader_of_to_plat,
-	.plat_auto	= sizeof(struct device_plat),
-	.priv_auto	= sizeof(struct firmware),
-};
-
-static struct device_plat default_plat = { 0 };
-
-int get_fs_loader(struct udevice **dev)
-{
-	int ret;
-	ofnode node = ofnode_get_chosen_node("firmware-loader");
-
-	if (ofnode_valid(node))
-		return uclass_get_device_by_ofnode(UCLASS_FS_FIRMWARE_LOADER,
-						   node, dev);
-
-	/* Try the first device if none was chosen */
-	ret = uclass_first_device_err(UCLASS_FS_FIRMWARE_LOADER, dev);
-	if (ret != -ENODEV)
-		return ret;
-
-	/* Just create a new device */
-	ret = device_bind(dm_root(), DM_DRIVER_REF(fs_loader), "default-loader",
-			  &default_plat, ofnode_null(), dev);
-	if (ret)
-		return ret;
-
-	return device_probe(*dev);
-}
-
-UCLASS_DRIVER(fs_loader) = {
-	.id		= UCLASS_FS_FIRMWARE_LOADER,
-	.name		= "fs-loader",
-};
diff --git a/drivers/misc/fw_loader/Makefile b/drivers/misc/fw_loader/Makefile
new file mode 100644
index 000000000000..f5df0db61c22
--- /dev/null
+++ b/drivers/misc/fw_loader/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_$(PHASE_)FW_LOADER_UCLASS) += fw_loader-uclass.o
+obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
diff --git a/drivers/misc/fw_loader/fs_loader.c b/drivers/misc/fw_loader/fs_loader.c
new file mode 100644
index 000000000000..b1eb0311dd2b
--- /dev/null
+++ b/drivers/misc/fw_loader/fs_loader.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
+ *
+ */
+
+#define LOG_CATEGORY UCLASS_FIRMWARE_LOADER
+
+#include <dm.h>
+#include <errno.h>
+#include <blk.h>
+#include <fs.h>
+#include <fs_loader.h>
+#include <log.h>
+#include <dm/device-internal.h>
+#include <dm/root.h>
+#include <linux/string.h>
+#include <mapmem.h>
+#include <malloc.h>
+#include <spl.h>
+
+#ifdef CONFIG_CMD_UBIFS
+#include <ubi_uboot.h>
+#endif
+
+#include "internal.h"
+
+#ifdef CONFIG_CMD_UBIFS
+static int mount_ubifs(char *mtdpart, char *ubivol)
+{
+	int ret;
+
+	ret = generic_fw_loader_ubi_select(mtdpart);
+	if (ret)
+		return ret;
+
+	return cmd_ubifs_mount(ubivol);
+}
+
+static int umount_ubifs(void)
+{
+	return cmd_ubifs_umount();
+}
+#else
+static int mount_ubifs(char *mtdpart, char *ubivol)
+{
+	debug("Error: Cannot load image: no UBIFS support\n");
+	return -ENOSYS;
+}
+#endif
+
+static int select_fs_dev(struct fw_loader_plat *plat)
+{
+	int ret;
+
+	if (plat->phandlepart.phandle) {
+		struct blk_desc *desc;
+
+		ret = generic_fw_loader_get_phandle_desc(plat, &desc);
+		if (ret)
+			debug("%s: No device found\n", __func__);
+		else
+			ret = fs_set_blk_dev_with_part(desc,
+				plat->phandlepart.partition);
+	} else if (plat->mtdpart && plat->ubivol) {
+		ret = mount_ubifs(plat->mtdpart, plat->ubivol);
+		if (ret)
+			return ret;
+
+		ret = fs_set_blk_dev("ubi", NULL, FS_TYPE_UBIFS);
+	} else {
+		debug("Error: unsupported storage device.\n");
+		return -ENODEV;
+	}
+
+	if (ret)
+		debug("Error: could not access storage.\n");
+
+	return ret;
+}
+
+/**
+ * fw_get_filesystem_firmware - load firmware into an allocated buffer.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+static int fw_get_filesystem_firmware(struct udevice *dev)
+{
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
+	struct fw_loader_env_info info = { };
+	loff_t actread = 0;
+	int ret;
+
+	generic_fw_loader_env_info(&info);
+
+	if (info.storage_interface && info.dev_part) {
+		ret = fs_set_blk_dev(info.storage_interface,
+				     info.dev_part, FS_TYPE_ANY);
+	} else if (info.storage_interface && info.ubi_mtdpart &&
+		   info.ubi_volume) {
+		ret = mount_ubifs(info.ubi_mtdpart, info.ubi_volume);
+		if (ret)
+			return ret;
+
+		if (!strcmp("ubi", info.storage_interface))
+			ret = fs_set_blk_dev(info.storage_interface, NULL,
+					     FS_TYPE_UBIFS);
+		else
+			ret = -ENODEV;
+	} else {
+		ret = select_fs_dev(plat);
+	}
+
+	if (ret)
+		goto out;
+
+	ret = fs_read(upriv->name, (ulong)map_to_sysmem(upriv->data),
+		      upriv->offset, upriv->size, &actread);
+
+	if (ret) {
+		debug("Error: %d Failed to read %s from flash %lld != %zu.\n",
+		      ret, upriv->name, actread, upriv->size);
+	} else {
+		ret = actread;
+	}
+
+out:
+#ifdef CONFIG_CMD_UBIFS
+	umount_ubifs();
+#endif
+	return ret;
+}
+
+static const struct fw_loader_ops fs_loader_ops = {
+	.get_firmware = fw_get_filesystem_firmware,
+};
+
+static const struct udevice_id fs_loader_ids[] = {
+	{ .compatible = "u-boot,fs-loader"},
+	{ }
+};
+
+U_BOOT_DRIVER(fs_loader) = {
+	.name			= "fs-loader",
+	.id			= UCLASS_FIRMWARE_LOADER,
+	.of_match		= fs_loader_ids,
+	.ops			= &fs_loader_ops,
+};
+
+static struct fw_loader_plat default_plat = { 0 };
+
+int get_fs_loader(struct udevice **dev)
+{
+	int ret;
+	ofnode node = ofnode_get_chosen_node("firmware-loader");
+
+	if (ofnode_valid(node))
+		return uclass_get_device_by_ofnode(UCLASS_FIRMWARE_LOADER,
+						   node, dev);
+
+	/* Try the first device if none was chosen */
+	ret = uclass_first_device_err(UCLASS_FIRMWARE_LOADER, dev);
+	if (ret != -ENODEV)
+		return ret;
+
+	/* Just create a new device */
+	ret = device_bind(dm_root(), DM_DRIVER_REF(fs_loader), "default-loader",
+			  &default_plat, ofnode_null(), dev);
+	if (ret)
+		return ret;
+
+	return device_probe(*dev);
+}
diff --git a/drivers/misc/fw_loader/fw_loader-uclass.c b/drivers/misc/fw_loader/fw_loader-uclass.c
new file mode 100644
index 000000000000..0d95fac8f42b
--- /dev/null
+++ b/drivers/misc/fw_loader/fw_loader-uclass.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
+ *
+ */
+
+#include <blk.h>
+#include <dm.h>
+#include <dm/device.h>
+#include <env.h>
+#include <errno.h>
+#include <fw_loader.h>
+#include <linux/types.h>
+
+#if CONFIG_IS_ENABLED(CMD_UBIFS)
+#include <ubi_uboot.h>
+#endif
+
+#include "internal.h"
+
+#if CONFIG_IS_ENABLED(CMD_UBIFS)
+int generic_fw_loader_ubi_select(char *mtdpart)
+{
+	int ret;
+
+	ret = ubi_part(mtdpart, NULL);
+	if (ret)
+		debug("Cannot find mtd partition %s\n", mtdpart);
+
+	return ret;
+}
+#else
+int generic_fw_loader_ubi_select(char *mtdpart)
+{
+	debug("Error: Cannot select ubi partition: no UBIFS support\n");
+	return -ENOSYS;
+}
+#endif
+
+#if CONFIG_IS_ENABLED(BLK)
+static int fw_loader_get_blk_dev_from_node(ofnode node)
+{
+	struct udevice *parent_dev = NULL;
+	struct udevice *blk_dev;
+	int ret;
+
+	ret = device_get_global_by_ofnode(node, &parent_dev);
+	if (ret)
+		return ret;
+
+	ret = blk_get_from_parent(parent_dev, &blk_dev);
+	if (ret)
+		debug("fw_loader: No block device: %d\n", ret);
+
+	return ret;
+}
+#else
+static int fw_loader_get_blk_dev_from_node(ofnode node)
+{
+	debug("fw_loader: No block device support\n");
+	return 0;
+}
+#endif
+
+void generic_fw_loader_env_info(struct fw_loader_env_info *info)
+{
+	info->storage_interface = env_get("storage_interface");
+	info->dev_part = env_get("fw_dev_part");
+	info->ubi_mtdpart = env_get("fw_ubi_mtdpart");
+	info->ubi_volume = env_get("fw_ubi_volume");
+}
+
+int generic_fw_loader_get_phandle_desc(struct fw_loader_plat *plat,
+				       struct blk_desc **desc)
+{
+	struct blk_desc *disk_desc;
+	struct udevice *disk_dev;
+	ofnode node;
+	int ret;
+
+	node = ofnode_get_by_phandle(plat->phandlepart.phandle);
+
+	ret = device_get_global_by_ofnode(node, &disk_dev);
+	if (ret)
+		return ret;
+
+	disk_desc = blk_get_by_device(disk_dev);
+	if (!disk_desc)
+		return -ENODEV;
+
+	*desc = disk_desc;
+
+	return 0;
+}
+
+static int fw_loader_pre_probe(struct udevice *dev)
+{
+#if CONFIG_IS_ENABLED(DM)
+	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
+	ofnode fw_loader_node;
+
+	fw_loader_node = dev_ofnode(dev);
+	if (ofnode_valid(fw_loader_node)) {
+		u32 phandlepart[2];
+
+		if (!ofnode_read_u32_array(fw_loader_node, "phandlepart",
+					   phandlepart, 2)) {
+			plat->phandlepart.phandle = phandlepart[0];
+			plat->phandlepart.partition = phandlepart[1];
+		}
+
+		plat->mtdpart = (char *)ofnode_read_string(fw_loader_node,
+							   "mtdpart");
+
+		plat->ubivol = (char *)ofnode_read_string(fw_loader_node,
+							  "ubivol");
+	}
+
+	if (plat->phandlepart.phandle) {
+		ofnode node = ofnode_get_by_phandle(plat->phandlepart.phandle);
+		int ret;
+
+		ret = fw_loader_get_blk_dev_from_node(node);
+		if (ret)
+			return ret;
+	}
+#endif
+
+	return 0;
+}
+
+UCLASS_DRIVER(fw_loader) = {
+	.id		= UCLASS_FIRMWARE_LOADER,
+	.name		= "fw_loader",
+	.pre_probe	= fw_loader_pre_probe,
+	.per_device_plat_auto = sizeof(struct fw_loader_plat),
+	.per_device_auto = sizeof(struct firmware),
+};
+
+/**
+ * _request_firmware_prepare - Prepare firmware struct.
+ *
+ * @dev: An instance of a driver.
+ * @name: Name of firmware file.
+ * @dbuf: Address of buffer to load firmware into.
+ * @size: Size of buffer.
+ * @offset: Offset of a file for start reading into buffer.
+ *
+ * Return: Negative value if fail, 0 for successful.
+ */
+static int _request_firmware_prepare(struct udevice *dev,
+				     const char *name, void *dbuf,
+				     size_t size, u32 offset)
+{
+	struct firmware *upriv = dev_get_uclass_priv(dev);
+
+	if (!name || name[0] == '\0')
+		return -EINVAL;
+
+	upriv->name = name;
+	upriv->offset = offset;
+	upriv->data = dbuf;
+	upriv->size = size;
+
+	return 0;
+}
+
+int request_firmware_into_buf(struct udevice *dev,
+			      const char *name,
+			      void *buf, size_t size, u32 offset)
+{
+	const struct fw_loader_ops *ops;
+	int ret;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = _request_firmware_prepare(dev, name, buf, size, offset);
+	if (ret < 0) /* error */
+		return ret;
+
+	ops = fw_loader_get_ops(dev);
+
+	if (!ops->get_firmware)
+		return -EOPNOTSUPP;
+
+	return ops->get_firmware(dev);
+}
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
new file mode 100644
index 000000000000..9ff43e872554
--- /dev/null
+++ b/drivers/misc/fw_loader/internal.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
+ */
+#ifndef _FW_LOADER_INTERNAL_H_
+#define _FW_LOADER_INTERNAL_H_
+
+/**
+ * struct phandle_part - A place for storing phandle of node and its partition
+ *
+ * This holds information about a phandle of the block device, and its
+ * partition where the firmware would be loaded from.
+ *
+ * @phandle: Phandle of storage device node
+ * @partition: Partition of block device
+ */
+struct phandle_part {
+	u32 phandle;
+	u32 partition;
+};
+
+/**
+ * struct fw_loader_ops - driver operations for Firmware Loader uclass
+ *
+ * Drivers MUST support these operation. These operations are intended
+ * to be used by uclass code, not directly from other code.
+ */
+struct fw_loader_ops {
+	/**
+	 * get_firmware() - get firmware from Firmware Loader driver
+	 *
+	 * @dev:	Firmware Loader device to read firmware from
+	 */
+	int (*get_firmware)(struct udevice *dev);
+};
+
+#define fw_loader_get_ops(dev)	((const struct fw_loader_ops *)(dev)->driver->ops)
+
+/**
+ * struct fw_loader_plat - A place for storing all supported storage devices
+ *
+ * This holds information about all supported storage devices for driver use.
+ *
+ * @phandlepart: Attribute data for block device.
+ * @mtdpart: MTD partition for ubi partition.
+ * @ubivol: UBI volume-name for ubifsmount.
+ */
+struct fw_loader_plat {
+	struct phandle_part phandlepart;
+	char *mtdpart;
+	char *ubivol;
+};
+
+/**
+ * struct firmware - A place for storing firmware and its attribute data.
+ *
+ * This holds information about a firmware and its content.
+ *
+ * @size: Size of a file
+ * @data: Buffer for file
+ * @name: Filename
+ * @offset: Offset of reading a file
+ */
+struct firmware {
+	size_t size;
+	const u8 *data;
+	const char *name;
+	u32 offset;
+};
+
+/**
+ * struct fw_loader_env_info - struct for FW loader configuration from ENV
+ *
+ * @storage_interface: "storage_interface" ENV value
+ * @dev_part: "fw_dev_part" ENV value
+ * @ubi_mtdpart: "fw_ubi_mtdpart" ENV value
+ * @ubi_volume: "fw_ubi_volume" ENV value
+ */
+struct fw_loader_env_info {
+	char *storage_interface;
+	char *dev_part;
+	char *ubi_mtdpart;
+	char *ubi_volume;
+};
+
+int generic_fw_loader_ubi_select(char *mtdpart);
+void generic_fw_loader_env_info(struct fw_loader_env_info *info);
+int generic_fw_loader_get_phandle_desc(struct fw_loader_plat *plat,
+				       struct blk_desc **desc);
+
+#endif
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 7de9312cde7a..48f36e88fee9 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -69,7 +69,7 @@ enum uclass_id {
 	UCLASS_FIRMWARE,	/* Firmware */
 	UCLASS_FPGA,		/* FPGA device */
 	UCLASS_FUZZING_ENGINE,	/* Fuzzing engine */
-	UCLASS_FS_FIRMWARE_LOADER,		/* Generic loader */
+	UCLASS_FIRMWARE_LOADER,	/* Firmware loader */
 	UCLASS_FWU_MDATA,	/* FWU Metadata Access */
 	UCLASS_GPIO,		/* Bank of general-purpose I/O pins */
 	UCLASS_HASH,		/* Hash device */
diff --git a/include/fs_loader.h b/include/fs_loader.h
index 7e16e0f70309..3c64efe1b439 100644
--- a/include/fs_loader.h
+++ b/include/fs_loader.h
@@ -6,52 +6,9 @@
 #ifndef _FS_LOADER_H_
 #define _FS_LOADER_H_
 
-struct udevice;
-
-/**
- * struct phandle_part - A place for storing phandle of node and its partition
- *
- * This holds information about a phandle of the block device, and its
- * partition where the firmware would be loaded from.
- *
- * @phandle: Phandle of storage device node
- * @partition: Partition of block device
- */
-struct phandle_part {
-	u32 phandle;
-	u32 partition;
-};
-
-/**
- * struct phandle_part - A place for storing all supported storage devices
- *
- * This holds information about all supported storage devices for driver use.
- *
- * @phandlepart: Attribute data for block device.
- * @mtdpart: MTD partition for ubi partition.
- * @ubivol: UBI volume-name for ubifsmount.
- */
-struct device_plat {
-	struct phandle_part phandlepart;
-	char *mtdpart;
-	char *ubivol;
-};
+#include <fw_loader.h>
 
-/**
- * request_firmware_into_buf - Load firmware into a previously allocated buffer.
- * @dev: An instance of a driver.
- * @name: Name of firmware file.
- * @buf: Address of buffer to load firmware into.
- * @size: Size of buffer.
- * @offset: Offset of a file for start reading into buffer.
- *
- * The firmware is loaded directly into the buffer pointed to by @buf.
- *
- * Return: Size of total read, negative value when error.
- */
-int request_firmware_into_buf(struct udevice *dev,
-			      const char *name,
-			      void *buf, size_t size, u32 offset);
+struct udevice;
 
 /**
  * get_fs_loader() - Get the chosen filesystem loader
diff --git a/include/fw_loader.h b/include/fw_loader.h
index 35574482b2b9..56f5e3be6195 100644
--- a/include/fw_loader.h
+++ b/include/fw_loader.h
@@ -1,10 +1,29 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
+ * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
  * Copyright (C) 2025 Lucien Jheng <lucienzx159@gmail.com>
  */
 #ifndef _FW_LOADER_H_
 #define _FW_LOADER_H_
 
+struct udevice;
+
+/**
+ * request_firmware_into_buf - Load firmware into a previously allocated buffer.
+ * @dev: An instance of a driver.
+ * @name: Name of firmware file.
+ * @buf: Address of buffer to load firmware into.
+ * @size: Size of buffer.
+ * @offset: Offset of a file for start reading into buffer.
+ *
+ * The firmware is loaded directly into the buffer pointed to by @buf.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+int request_firmware_into_buf(struct udevice *dev,
+			      const char *name,
+			      void *buf, size_t size, u32 offset);
+
 /**
  * request_firmware_into_buf_via_script() -
  * Load firmware using a U-Boot script and copy to buffer
-- 
2.55.0

