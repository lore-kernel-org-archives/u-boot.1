Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A6DC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D06583595;
	Sat, 24 May 2025 06:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lSQgp6a3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C17883409; Sat, 24 May 2025 06:25:53 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D89C83303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad56829fabdso58541066b.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060751; x=1748665551; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pbaLLdSKjNz219OLcjvPstVJvrdDstbuWpl6p5qf4qw=;
 b=lSQgp6a38xLgHbSiJhwSO9oIi2WqOnkwWLKavN3hNghvcqnI5mYV8E4ABr9sk+3aMX
 C1dRqkgxHzxWMMEuvQkGeirrnBiw6LdY27NexBdTp0po+Zt4iOdWIz8n0YWymclTrW2L
 SukVW+qH/LLSbF0LaAbxN8mb+i8zMhdfi/XgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060751; x=1748665551;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pbaLLdSKjNz219OLcjvPstVJvrdDstbuWpl6p5qf4qw=;
 b=sZJqjJELBypzMTX5oYzIAqzLnGsXNI9CJc5taJPv/qlaugZFD7AXaN17g3WAid04O4
 ULHcqzXsP+waDTk0q9grAPxUPm965mdAkdqQGYK60ciMqt4QMGkjhmlw1E5dgIujo3+2
 ML+MJG7RnhKqnajMLjlmZrK0O9GKxxrmJp128bnkTCR4p4wc2lU1x85/5qdU3+Bh6a2Q
 ebd5+fyZ6P+Wbf27Bbm+mzULtFiIbntrKKFdbPaL6q/ih+YgE2LSN2ta3/CTgVje99B9
 GW0eAaD1ybKha3MUBEB3T0a3hp6bldFbajKjZ65cyVvYfFzlqfxI3SM9hMVUjD2vvY1d
 mfJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3E8PzeeyR4k65V2lsZdRGcJo5DhVTaGx5iWpFdYJhPzYA3juSkEEMO2sN+bRGEFegVQeSUKc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7pxoPaqkXDHtEVV8jzzyo2ebbe/hTLAV7bhE1bdcsRNJQB/KE
 +Tbj85COSXjcqWCHEIQZ2qV36AXCMAWtFpyn7o6b8R1g/9u25o3fT//pgABtzrZ1T3VFxjL3bl+
 lhXBvbPkN/vy75dwBSW/MBcegfVRJrSTnpDK2df4y
X-Gm-Gg: ASbGncu7TZ6G+p+y/tQ6QW6vj7wJ5uZ5KZaE0JyvCp/+IOTYZdtBcM+S6miqdVl8p7K
 bUHtLz4mTLD56NhV8aKYb1jrciPSO9j1yDpj2zdWv2OXsshn20p8DjcLczYsCRvcg9CnJ3VxD/F
 jBx4xbqAYJQ6cpPOhLg4VZi45f4kXwHRo=
X-Google-Smtp-Source: AGHT+IF0yQ+MPr+5mh1VNNTLuCogx1Apkm/mvaz4Lh+8GnXjBAr3Bhb6s20iulrBORpw3d7JWWTr+ndF0VsTr87iCO4=
X-Received: by 2002:a17:907:8686:b0:ad5:2719:f6ae with SMTP id
 a640c23a62f3a-ad85b1708acmr132509166b.20.1748060750924; Fri, 23 May 2025
 21:25:50 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 21:25:49 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 21:25:49 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-4-sjg@chromium.org>
References: <20250508072907.207175-4-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 21:25:49 -0700
X-Google-Sender-Auth: O1nohxsnccbHS2KG1RYH9K3oMzI
X-Gm-Features: AX0GCFtvp2rAkjVvxqGoQsMteQsrhBF4_HH1QeU4ivqNkWOIwmaadhh_iSgcOLc
Message-ID: <CAFLszTirpK3agLBP1RQUx=TdqXnUUMcrn_x23vdnkAos9-zORA@mail.gmail.com>
Subject: Re: [PATCH 03/20] u_boot_pylib: Speed up determining the upstream
 branch
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

Use --decorate to quickly detect the upstream branch, since this is much
faster than using 'git name-rev' on every possible commit.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/gitutil.py | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

Applied to sjg/master, thanks!
