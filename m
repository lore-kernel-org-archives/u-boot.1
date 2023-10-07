Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E456E95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C420E86DFA;
	Sat,  7 Oct 2023 22:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iaWV+mMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C933186DD8; Sat,  7 Oct 2023 22:38:03 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1B186DE6
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so609915166b.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711078; x=1697315878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JtyseJ0M+RDb4zSLjoOI539KE1i3khGjcQGeaW4yh5s=;
 b=iaWV+mMPtKuGnBx5FfFNO8fGYzBR2+/3vn8vljNSSro8GZRrfczYwFEpRk7u7Q0/eq
 ldwoW6qJ4CM+MGMD9s3Gv4rxhKmvVDYS2Zyykii3HeZ7ElPGMDMHqHj9LPjlYWfyLItp
 2HNwt7FaOa/N2aOZ9akKv8a4QArXwhQJznQFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711078; x=1697315878;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JtyseJ0M+RDb4zSLjoOI539KE1i3khGjcQGeaW4yh5s=;
 b=dowXrw9/xtCBMXrwatDb/AnKTcGwaWBEqoJ9O+MDOA3hDYxXOl0qn9Po2jpagxX0r7
 9+cUpYL3lnqVzJ96HC3dFSrbFmD5qyQ/xLgxXXE6eJX97m0fO6M/+X/LDnKwz5rs4HAh
 Rz3LgriV3bdo2eFebUKBzVoa3MYJxlReWsWNK0CpVPjn8YJjAbjjUXP5DueI5peFCFr2
 P5NaX74VyvaG+F5ze32P42tjK/VRoU11aIRX8tjDbzImfRCTtxVaY4/hbapOgjLFyrfF
 z/cY3qnDnwyGt4mHrx3nBspQ12duwqChn/Sb2/SDsons77F5rHviLQcxLD3024Gd3Npv
 mAgw==
X-Gm-Message-State: AOJu0YzYCGKIOUwaxHuJN9FygLmiuxHsKEgFL1nAcreA0Vu/7+9zQyIC
 vRssawsykYgqZ6Q9kQJsPbCuPQQzd8KUhsLSXADbnA==
X-Google-Smtp-Source: AGHT+IHkXT+jJ3FLyY5J1LMo6+vCUdUnZSeDxAFPAwKO2+Tnt+Bq+KUjDQm3w92dGY+4SQ8cRfVGJDiDyLVIsRIYBzw=
X-Received: by 2002:a17:906:5188:b0:9ad:e7d8:1e26 with SMTP id
 y8-20020a170906518800b009ade7d81e26mr10365360ejk.57.1696711077918; Sat, 07
 Oct 2023 13:37:57 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:57 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2JgwnqEWVagATPPnjE2fJ-e9NdhN=5pBeu_3D_ZzqLZQ@mail.gmail.com>
References: <CAPnjgZ2JgwnqEWVagATPPnjE2fJ-e9NdhN=5pBeu_3D_ZzqLZQ@mail.gmail.com>
 <20230923194424.1739224-12-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:57 -0700
X-Google-Sender-Auth: GKxMWiXzVeNuAVBF7cpgI1qniSM
Message-ID: <CAPnjgZ21WepC1wUKOkMFvaE1T6QjRTLZWXa3qi0TvMPR5WcBUQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/27] moveconfig: Correct unused variables
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Fix pylint warnings about unused variables.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
