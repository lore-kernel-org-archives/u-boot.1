Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0998606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wRCQisw3;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TM0w2TWt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DF6D40580;
	Mon, 26 Oct 2026 13:40:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EjJJINjnRzHS; Mon, 26 Oct 2026 13:40:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E40DE4053E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793022026;
	b=hQ4jXsfddaVsOJAfcZhOr6HlxJ93Fn+BLGgFp6fPAgURS3X7nDtpfHzC/BD//prSkmVF
	 nd2ac/zWrF2qEh68XFhPqJ+tsneCzUvwdTumYz+TG25DtxTQS8Ym4B7KSNHa4LJ+zTk5X
	 y6xj8jCxfTAlhCuWfwnBsEp+eYo5xPAu0+3hmYwdO7EXUMWTBjqjpbz2Q1/E8JC4XbS2Q
	 2vMk8OqL/UUdls9Pbb7gp67ENqRJpQB1OcD6dk3bYBr0j9/RoFcoIR/BZxxcsrw4EOVSr
	 g7r581ZGHrCTXhWldpjI2UH91wgBdahgZuV+PS+AJ7MFzgMLO4yZZHs0cyNkfLWMtGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793022026;
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
	b=lrEAoglBYb6ydtF5GkGknqsi9q1X3HFkBzvjkwdE3r/twvoPa9QXgsubpLfvcikWlRSB
	 wPnfFYLZwVVKbviBAg7ZzdRksgW7yrTCFcZp0FwOs2xM4B+e9bCRuu8mwKdGVfd5qVaUb
	 yZFKWJ4ONcidgFsPKnQxcIfhdKjAV4ani2N/2bq1Sjcbb9kd3ayiUtLF0xHraeUCyIBoW
	 8lPmXrCPqgYS5I5QU+VJEA0/a8x27I0EKZV6vvXM72sQOhOCggF2Ppo27LXlc3UNudr/5
	 XzNGL2QbfgXyF478Xguc8Ffyw+vADcsBiG3D5MRpvb8BEgKzBTH0TJwCGLduzHNS6Kg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793022026;
	bh=tG5JoKrPZdkjzZIOC3DuTfsjQnGxMnI1LQtuwh3fwC4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wRCQisw39gewYLI7Y0K24HY+EVbFzGrCwb+32agaOMaghOSmh7ZKtzKXGVo+04Ah8
	 5DN2iL46dT5NYSfpvf25i2jHpJBUOXkMSJEskvfFDIQYnwlN6+Wn4Snh0J6c1E2Vo3
	 KOkb8UXUJkLz65fhusfQK/WY1aYc1NXpDztHooXIEqG2PEX1un7JWB9DHC0GAbiSJn
	 LO8c28ryzAR/0ZOHEADHQArqdIX2AtTQSlc/qy99CvS2WoNcFKt+FVb0d9h33ldTIQ
	 CzxIH+9CBVsIs+tNiucWnRKrxbmKpzDt3PZ4QTGiwzbmiBriKLn0f+4gCwDalyHx3r
	 NC5zDNOJdhPsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E40DE4053E;
	Mon, 26 Oct 2026 13:40:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 84F11356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76E4B401AE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GeK3Dy0x5PLY for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 13:40:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1BAB840062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793022021;
 b=dM1e+NTCK359RqH+Lu6RKKKWhW06nni/GhG5HIexpVekQCwnejIUc87p5kgCvKy9iLTd
 37F5ZiIecfnJiu5LrgTkqrMIE/iLhDnqNSwDKxNt7RUVMFyB5r4KLodIEDIRijj2c11zP
 6+9c7ukDvunrNymeDg8K+Sogd4fLknv4PGBnh1NxXWTOoosvvJ8+RK7lIMBkzeBU3mh5M
 ayAaPTL2k9Z7nTwCImu+FkmJjJDkHjI/3GRAbxakPebzApSxYqiLPDRX0dhiDMPLAQqHJ
 x8lci+sKbTSFILwh+SveWG6G7EaR7gvZozNDhk6ATtqmUMmKbjFvD5LhuBPXtF5G4wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793022021;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=tG5JoKrPZdkjzZIOC3DuTfsjQnGxMnI1LQtuwh3fwC4=;
 b=f0KzhfbYC5E+oFIRjpVEwcdB6kUUhpTQvGjY5E+hpQ1xyV1KQPu9aqMpkZh3esNAPWEH
 JCqLCv8XTCn300IMZv6ctKfyKortHLtkszgPCHSI2IK+qMymEksiwpXnJN1teV85DXT1X
 Ojqs3Z5W4sf9XXUc+NySqlB6WeJ+SjSsHNm7Wzg21BpblCT4s2i8AFtJqT9ZGkzLZ0Gnu
 cXSyr7ze8eMRvNtzb8ZZKHyt0rauSvNbEQfsQqGoWayIjeP5cyiPyZDfyQQcdkEJXGnKl
 Zhw7SCtO9YWX30WmezqIm77RMGbaB7YhpGv/ZKW+ryhm6BprIC/rFLZu5mjb1uPvpGQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TM0w2TWt; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=TM0w2TWt
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BAB840062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 13:40:20 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so9814985e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 06:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793022019; x=1793626819;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tG5JoKrPZdkjzZIOC3DuTfsjQnGxMnI1LQtuwh3fwC4=;
 b=TM0w2TWtZx78/gRTSsPcKfj587uKR3H25SQFyokgJL2dsYLmPnGon5ZWp50SjXP1x5
 aEyICzsTa9JCWpfLeRBDuR2XJE/r1++zUpZ/buq2HH5VDQ52S22s0FLdRFiTm6HrHnOf
 zpTDbpIF/5N0xPKSQoxMuoN6Gm8TSHJgQ3uv9jJBIxnqDMtbQIhjjEA8iBQrwVFp/ndv
 5L1u2erqcVqQVgyt4dUZrtrKPVEOqz8rvmbTRO2Q2DIst0npl3RRqodjCz8pTf/3ZffJ
 B1JTQMiB+Nxeq/F9RJTjBy3fq34OFxPkQIAiyRAMERiDZg+6E+9s8f5BBh+Ee/JU6Yyx
 qvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793022019; x=1793626819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tG5JoKrPZdkjzZIOC3DuTfsjQnGxMnI1LQtuwh3fwC4=;
 b=DDDh4SBhrbEGKIw89NnwhDw9SOo3XUHMW7r8cVZFm5vg4x1cwcWz2zWTSkJpfsdqbP
 nnkXZ31xst/yYsqZ+whxxZe6pXOUkFh5cJ+UWYzXzu3tZeLelJVQuopw6HTTK1dB0mjP
 ufmjB1W7Is1sy1CgAvSVd2KpZSZJ7hxKVOQJOdakn6UuQZBOIPqY78OEWtGrKRoEsKJK
 LNQ2LPQ/epmzxdV7pXXmqAhCwuKacubHsGKvS65C0Vp8VgXwqa7XgOopP3Q5Hd4PeqoQ
 yN2i6MVPZr7t6dwjPv0YipidX0McI56GBek47OMJ5c5tIkKkzC4mZ1S7A+OQsQXVwS7K
 5tVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByz/sAPHJ13BD9sgHc6MB/ITbD2bYKC/NsjXV6I3jVmOGVE2IdyGUbplIYKCNV0odjIvQxA4/Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKXWVZrFxlK4xCqzvMEMP9jhjhA+pdvnp69NlcuKoIPPBgq5agG
 5t3b8QOFbmfR4XTpulxJidwyzSa3HZDXT0/DxstZPfD/Y5wYMl2+vQ6N
X-Gm-Gg: AYBFou3AvfWYyrY9+e045ODDDSJpK7RaJyGtPhCblhVsfBAfjm78yZyfexvGMdwtqQm
 ttHe3KZYcxKpZ6lx7Q95jsTDCWwjv4VzUe9nZZpkDogSI/GO1eop6QMs/HMvj0X8H0PMxNLwXw6
 NHeJMYfpbBCE8+j3qLyC4YOr/FpV+wJpzKaEsM3TFmR6xlzMQMzqZyqvV02zdWTQoUQ1/RhiSbq
 +OtHpxPep+vUy43ekXf8OC9jlGzVLHlGmkoLDW5n/vtR9di9Rctxu6pLYT3vgy5f9w9TLmq+QyD
 13sR9Duz0dvlWl2M+0nKao2pR3YG+m79wkmbpIpcaqLyFDo9BDf7Q3agGLdQRq91ndzWenwjBOJ
 mbBX9lCVM3Py1wAeSOuowxyXuoXIzkgRLigGEsxqy2+rLkHRQSBE229+Y0A+IBPjiurAuTI+suG
 3p1fvelnpedZRN3oDDFpxMD9FTpbegB5uIFG/QTJ70PYhIpsb54bLvHQ3A11xAgOMNL1HofK7Aa
 UtRNvz8VjEY1jr8Slkk5Q9OeTF7LbAWmsyjc848spXrQfu6zbRU6yI6qqt40KsRcBG/gIMhNe6H
 gP8Q3CZVuUR5VVdX/X473n4s7EStkObzZlBgevujlen7gRYlpUWobGz7g0Xy9g==
X-Received: by 2002:a05:600c:a00c:b0:4a1:f90d:6f4c with SMTP id
 5b1f17b1804b1-4a35ac7f09dmr109154855e9.7.1793022018471; 
 Mon, 26 Oct 2026 06:40:18 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2c0458sm194344375e9.11.2026.10.26.06.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 06:40:17 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Daniel Golle <daniel@makrotopia.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Randolph Sapp <rs@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v10 2/8] misc: fs_loader: reorganize and split to FS loader
 and FW UCLASS
Date: Mon, 26 Oct 2026 14:39:55 +0100
Message-ID: <20261026134002.109025-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026134002.109025-1-ansuelsmth@gmail.com>
References: <20261026134002.109025-1-ansuelsmth@gmail.com>
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

