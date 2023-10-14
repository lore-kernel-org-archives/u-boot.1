Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9285CCDB483
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2934886F11;
	Sun, 15 Oct 2023 08:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lZ8ZOau8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3BFD86F04; Sun, 15 Oct 2023 08:54:09 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D8B386FA9
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-57b64731334so2037375eaf.1
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697352728; x=1697957528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nm9LSYWHUHYnGRkp1ZZakx0RrSpGFFjehNg6RctkIX4=;
 b=lZ8ZOau80mRK7PGQ6GWObZkEnlZuVwbUs0uC7Z0LKm7I9h9ZYLTeoggUTaoQOaI1LI
 cfZwTCrRwvaPqJMXAXj95mn7ecNEtZ0WBWc7ILkDYJVh44u+zn3GeuF9GpnlIUJvYCsu
 3cxqxCY3uw/arwz4O07ta1aMgfGE21gv6+gzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697352728; x=1697957528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nm9LSYWHUHYnGRkp1ZZakx0RrSpGFFjehNg6RctkIX4=;
 b=fCF73jqelBEkcxhUjPGV3nNIhAzYZrh0KvMPL4dMFHO8kpHMoWS61CIpbT7UxeMXr4
 MuInwhnjJN23UsrAuDWy6CHFE5xXRaU7Tl0xUDOCbnArZ4xxoLwW6BBgFhjGqQkHvX/6
 bZ1O058rNUPVZ4QFuO44Z5Y3lnAaZxyNNoqRqMyquys+xus/dduPdbhG4bbhS2C1+rTW
 H++eqxMJBeQP2fQtR9eoVMQNesv2QeflRCnKnuGkMyq3U61P7LhtsOOfbM7o9VBJGC7R
 AYhGSsZEw7EDHsDa8lPI0NXt/H+2OfPyz2CjRWsU84gkRzDdJFxlXKxTxw0K323elf7U
 Bl7Q==
X-Gm-Message-State: AOJu0Yz4HaZZovbDGvONFawIJtDCOqmDKjesabQGvkYC65SOQRj99qRH
 O4OrKDlykG9Ze+eUQG4C/2OgrLqYuue7CJ3PZo0HsA==
X-Google-Smtp-Source: AGHT+IGn9ytwpRuZ/9/V1RH98ClVU+sLzFe9T2k4skXXMuVgkPUI5ojfKE9XFPZZBlYP3mpdLpWV6w==
X-Received: by 2002:a5e:a70c:0:b0:787:8cf:fd08 with SMTP id
 b12-20020a5ea70c000000b0078708cffd08mr35310343iod.17.1697316037692; 
 Sat, 14 Oct 2023 13:40:37 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 j27-20020a02cb1b000000b0042b14d9be7bsm5424649jap.22.2023.10.14.13.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 13:40:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 0/6] binman: Update CBFS implementation
Date: Sat, 14 Oct 2023 14:40:24 -0600
Message-ID: <20231014204033.3077052-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
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

There isn't really a solid spec for CBFS and it changes from time to
time. This series updates binman to deal with four changes in the
file format, with the earliest being in October 2020.

No changes are made to the CBFS-filesystem implementation. This has
fallen behind, but can still be used for simple files.

This series also fixes a coverage bug, where tests for missing tools
affect other tests, thus causing coverage to fall below 100%. This has
showed up with the bootgen tool.


Simon Glass (6):
  binman: Reset missing bintools after testing
  binman: Don't add compression attribute for uncompressed files
  binman: Ensure attributes always come last in the metadata
  binman: Replace FILENAME_ALIGN 16 with ATTRIBUTE_ALIGN 4
  binman: Rename TYPE_STAGE to TYPE_LEGACY_STAGE
  binman: Move stage header into a CBFS attribute

 cmd/cbfs.c                     |   2 +-
 include/cbfs.h                 |   2 +-
 tools/binman/cbfs_util.py      | 125 +++++++++++++++++++--------------
 tools/binman/cbfs_util_test.py |  23 +++---
 tools/binman/control.py        |   2 +
 tools/binman/ftest.py          |  10 +--
 6 files changed, 93 insertions(+), 71 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

