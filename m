Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C1DC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 420E88310F;
	Fri, 23 May 2025 15:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kBDMItQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDBEF83108; Fri, 23 May 2025 15:18:30 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBC24832DA
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac34257295dso1523514466b.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006307; x=1748611107; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FTOz0sVvWO3IxSOP+gqRxDSsVGbxTvzKLx/TxjTjQlA=;
 b=kBDMItQw8b/b2eVfIB9Th/OPE0JgnqetcM+IxxmtGI+39plq/aJeGU0EFsv/QaDJ+k
 xkXihewwRBBGCPS8fLzUTYWltx/te7b2GVNHJ5CA665VqM4FX5MKOcrnAfFxId0UIb6U
 eurtu+om3c5xob6IbGc1ny8FZ1nIlXplfsH6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006307; x=1748611107;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FTOz0sVvWO3IxSOP+gqRxDSsVGbxTvzKLx/TxjTjQlA=;
 b=eZ4Hr0yrvN/sE2poUzlEVEjGxEM6OA1urGpnG7Gn9k0PLVuRc6UiEVM9r7ZunWRB9B
 zWIUEBt62V1t1G3ndFXVgNsKac7EFRQfTqCpywlRpBiB919U3G49y/1JcBrPyy10jOSz
 P3a56PLskIgtZ9jzkdmHOF5bC1ewp80txSZQoKw2jh6sMqjVJ6KqLbNdcrXlqAKzaGM1
 Pb+r4BmgegfBIHVvgX994gygU3rsH0CPYJBaWpJV+jn38gisY84yPrN9xXHjXUblCNCS
 ymdSXFVjiTsXYR4yelaMYxmPQ1iKKPTpP1UO7/DEEdia8g5zk9Thu/6EaKsHbH/CwqUy
 KqKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+7Hs4duHc/JO/ndtyHrS47JZd314py2ALppChb+RtSEDmFe7xdxTktX6zQr2oRQMt865XHgY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7fShtnTfpMmw+ZT+GWTIXyFOLDCuUCLs/KvNUFAUUCpHJNII2
 h3ZJCBM77JNW1H2I111sCjZTMql5h0AWGuIMsxdXBkhMfeX/m0LqH9DAzFt0Xif7sfyt6TAFhgp
 U4TDcPeeFu8gxdSOTJ3o9tWcKvDUSMfrkB/8wd09p
X-Gm-Gg: ASbGncsiKbZEitGuPiK0OIud9dLyuqhE+ZkqmkK+xvTC612EKsLJepr8RSuI3YAUASl
 Qsg9K/loK6DASnVJJbkNUjRc0By863qAJMKVluqZ0ZZK0YyAqH1rgUzjDzih/tm4mBe+pxf3Y6Y
 cFbMySXBlsgS2kuiziYBI1/YhW5bn+nxOctQ==
X-Google-Smtp-Source: AGHT+IHz84dQVbOVLneAqbGzdau/3lWhoYswLNXqTxSM9cPpI+MnZbtF7Dhjo3GTwlXY3Og7vJEYfKFzYjyyHQkO+T0=
X-Received: by 2002:a17:907:60d6:b0:ad5:6b8a:a0a6 with SMTP id
 a640c23a62f3a-ad70892ad61mr309696166b.58.1748006307265; Fri, 23 May 2025
 06:18:27 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:24 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:24 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-26-sjg@chromium.org>
References: <20250504132356.2317305-26-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:24 -0500
X-Google-Sender-Auth: EB1iSPeFzt-fQgrCv3Z25gKjgK4
X-Gm-Features: AX0GCFvu1iK0O7koixkjcET5q3iE98Lt2iIUrS-_ngMfa4HTK8XcjaTNHVhEoTs
Message-ID: <CAFLszThogec-3AjNj1QxDAZqzoHTf4fcdz4W+pXmHzU0iy+acA@mail.gmail.com>
Subject: Re: [PATCH v2 25/30] patman: Add more information to Patch
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

The cover letter has some information on each patch, so allow this to be
stored in the Patch object.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/patchwork.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Applied to sjg/master, thanks!
