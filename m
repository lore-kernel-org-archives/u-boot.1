Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF2FCCA472
	for <u-boot@archiver.kernel.org>; Sun,  5 Oct 2025 22:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 869B7831D6;
	Mon,  6 Oct 2025 00:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GbKwD6qN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685E88323A; Mon,  6 Oct 2025 00:12:33 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C7A2800D7
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 00:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so23373905e9.2
 for <u-boot@lists.denx.de>; Sun, 05 Oct 2025 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759702351; x=1760307151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xh/mUemuB/oqU61RO1cphG9J4RAodMROZBm98xyHWlk=;
 b=GbKwD6qNpb+NyPKURFtAYTQD++5hDcHZwG4eXjiw1ygfHGHdgI2sCE/mqUmJ3u3xU+
 EbRruccC6/MLfDGi0czFn8tHTD9Ry+DcONl7MPP1qwqPY5EmOgBJCsQst6AFnBshsmOZ
 dvjluCpWXNKHliP1O3DEbVtmVc4KAL2wuNK7W1IBXNYE0GRgtBsAczW9DhG/oSMkHv2X
 yyTzyx+3GOe0sWIEdZi4Q6g2oz5m25gTp+Rs+Ten7j4gu+UacVrfIT3b83PRHmoByuw3
 D9wnrNQeisgS6nealPlMlExuqtQfsUno5kC0+5pC135gYk5LsHrBaTh4LVAhDMcvjAMu
 gbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759702351; x=1760307151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xh/mUemuB/oqU61RO1cphG9J4RAodMROZBm98xyHWlk=;
 b=VNaF1tu1jy7qpKRrHxOUcegSlLaAqODbEQNek2qZuYaeFrL+o1QeAxHCbwpZnMCtTG
 dsV5yaE1g9p5nnl0KIpfMoJkXumntNePWo0culz5/76c6+zBd3M5KynGmUYCUKNLzVTp
 Fd10swWlFqUCNw6KcmPDcClq2H7J+6hjEr7bPUkd1rF/PxOi9HTVpi6SHrQbnwuwj+ut
 BeRw8kF7JSat0yuKbYDsgJ3pmf1OjKfsi5EZz8VHCYRK+lV3lSCJrKTwZCI6l4XL3y74
 NANb0irjIEV651rOYgcJNgYnm1lYffAR6UNuzRS+79A8phEC9STCy62IVyY7WAlmcnll
 6R4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbj2KKMsp11oFRqC6fQAp8UJxIXN/GOpRc5/8q5vppxY7ftBUnhaEw6P1ibQXYRpPkeuDeooM=@lists.denx.de
X-Gm-Message-State: AOJu0YxIAuSosd4BXhLoXHvtEHD3c5gJ+pvGdt73M1L69o5jAkW5L7wy
 Bk5a6J5sM6GiyHzEDyVWXz/EqO8+xWSOvIvipmoc1FEOGgBTh63B/UGx
X-Gm-Gg: ASbGncvYAyzQSAehQR9qrIUP76/nv3EHAzrXW68fMlFj6lTYIM+zqwBeOZufNxYua1c
 j9vFubelGhkojI7R5ykMvC699+VO4onxMfIs9dEWgxdqi/Jz7jMLTS3CSSCfqnXM10x6ELPDlhs
 bDaQYHbiOAZ0GdooBlhAjBHXBlOYVRcxyo5sUQ5s+WLCqNR/VnIxlzXwaB1hNhg0DujfESDcouc
 MIlhH7MNKFELfnmjjv+0Uwm7n7Z++rIZhtXuqRdjfXlfeSLT27tTd8bh161IdddwLET63ZPyLFZ
 X+fzd224EN+HGmfWgasuwqvQdG/UFa86DE3SctEzJstK/ubziqKdDck1ohHa0cVTup49otSvDDK
 z7Rju9a30xEB/yoSfzL0EcmC4XpCj56ntFzKR2A7IE+Ffee3aAy1GJgMCWmuypXNr
X-Google-Smtp-Source: AGHT+IELaLcRsetcQ0ul4qkvDw4Al/+JE/vnGT8cvmmCXpi+V8qIGwBnAjqhgJwFmSF5VESIPVZmkg==
X-Received: by 2002:a05:600c:c4aa:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-46e71146819mr70008235e9.31.1759702350646; 
 Sun, 05 Oct 2025 15:12:30 -0700 (PDT)
Received: from N580G.. ([2001:8a0:ca4a:300:ec0a:68da:a550:d9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72375b31sm137370095e9.20.2025.10.05.15.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 15:12:30 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>,
 "GitAuthor: Adriano Carvalho" <adrianocarvalho.pt@gmail.com>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Dhruva Gole <d-gole@ti.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Garrett Giordano <ggiordano@phytec.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de (open list)
Subject: [PATCH v2 1/7] doc: make pdfdocs: Specify texlive-xetex as a
 prerequisite
Date: Sun,  5 Oct 2025 23:10:08 +0100
Message-ID: <20251005221057.255029-2-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
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

Dockerfile updated as well.

If I don't apt install texlive-xetex, this is what I get with
docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:

uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
  HOSTCC  scripts/basic/fixdep
doc/Makefile:89: The 'xelatex' command was not found. Make sure you have it installed and in PATH to produce PDF output.
  SKIP    Sphinx pdfdocs target.

NOTE: This won't completely fix the pdfdocs target. See next commit(s).

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 doc/build/documentation.rst | 2 ++
 tools/docker/Dockerfile     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/doc/build/documentation.rst b/doc/build/documentation.rst
index b55a4666643..81548390d78 100644
--- a/doc/build/documentation.rst
+++ b/doc/build/documentation.rst
@@ -16,6 +16,8 @@ the following dependencies are needed to build the documentation:
 
 * texinfo (if building the `Infodoc documentation`_)
 
+* texlive-xetex (if building the `PDF documentation`_ through the *pdfdocs* target)
+
 When submitting patches for documentation always build with KDOC_WERROR=1 to
 treat warnings as errors.
 
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 5b4c75f8400..8e166eda4bc 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -136,6 +136,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	sudo \
 	swig \
 	texinfo \
+	texlive-xetex \
 	util-linux \
 	uuid-dev \
 	vboot-kernel-utils \
-- 
2.34.1

