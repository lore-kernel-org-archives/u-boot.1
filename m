Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276FCCDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 136788788B;
	Mon, 23 Oct 2023 09:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hhs7BlGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0DEC8788A; Mon, 23 Oct 2023 09:02:27 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E1D287874
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so2332069a12.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698044544; x=1698649344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uuT8XhVja0lPYy1bCqNEozEcDfFslmQBpqU8YUwghUI=;
 b=hhs7BlGLOhiuEDKO788awQBcTr+E/DJqAYeDpc/T9Xh35sBU7e9/OwKgTD3kBrS3cM
 t/1yDjVvGhbzFDi1fhHr7em5AX7KwLp27hjdK5l2gBSMCS0QeKw9Xv8KlvXwHc5jl5Wy
 MysG+mIjyi6j8BvoZDhdk1QMskIxuhwVj/wic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044544; x=1698649344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uuT8XhVja0lPYy1bCqNEozEcDfFslmQBpqU8YUwghUI=;
 b=EiqgRVvnH9WvA949I0AeFoc6uoQl/R0eNAXWuPJZvQ4ierwKDKkQ1cz/Dode2PcATy
 FN4uPyz1JOuqIvtKe+7AnxcI7LsLkG0aGCZRrTEwDZErDzL0A01YJxmTD2Hwo57RQgrg
 j4QI3QTswNCGIdli6RCs73Xv5RVLdhld9Ks+lKxCZY5rKs6ZpJ+G6hsUUF8XzAdTsUTF
 wRNa84jnwVqbpwO8JSZzrnya+lmyX2XZhMWFI5KWocmnbCGeelQkmda27w0UbrqdOE4b
 iy9thpXW2l8977wiz63hQtIfSAm/3UMOCDzDIhK/lndIQPMb2BWU3OEG8Fxm9v4cLsFU
 wtDw==
X-Gm-Message-State: AOJu0Yz69CUZWdgwPapT3Be8ZY87GZ1SRWaaAbiU9fwHsncZLNQpL9qn
 BP1lJQCJ0TuZxghOQS+OlqN9k1WD0nz/uKw/co9spQ==
X-Google-Smtp-Source: AGHT+IFlk0g/eL2rQ0GhyDqLby9TMKycf98I/T5M5PQd60YSLv0+eQSRpT2eUXFJNGao7KDaGmIpWA==
X-Received: by 2002:a05:6a20:258b:b0:12e:4d86:c017 with SMTP id
 k11-20020a056a20258b00b0012e4d86c017mr8328443pzd.10.1698044543680; 
 Mon, 23 Oct 2023 00:02:23 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 u187-20020a6279c4000000b006bde8e1f0adsm5910841pfc.98.2023.10.23.00.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 00:02:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Guillaume Gardet <Guillaume.Gardet@arm.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/4] bootstd: Test and boot_targets improvements
Date: Mon, 23 Oct 2023 00:02:09 -0700
Message-ID: <20231023070216.394709-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This series makes another attempt to support things like "mmc" in the
boot_targets variable. The previous attempt introduced a bug which made
iteration fail.

New test coverage is provided for some previously untested behaviour, to
prevent regressions.


Simon Glass (4):
  Revert "bootstd: Scan all bootdevs in a boot_targets entry"
  bootstd: Expand boot-ordering test to include USB
  bootstd: Correct logic for single uclass
  bootstd: Scan all bootdevs in a boot_targets entry (take 2)

 boot/bootflow.c     | 29 ++++++++++++++++++++----
 test/boot/bootdev.c | 54 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 73 insertions(+), 10 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

