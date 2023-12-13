Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355DCC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF3F87879;
	Wed, 13 Dec 2023 21:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FUN05Y7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77BDF87855; Wed, 13 Dec 2023 21:39:17 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C71D8786F
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a1c7b20f895so855939966b.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499952; x=1703104752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PaQp83k9T0ltnXmaJJglCBZuOyvVwxIaNUqUdUifmS8=;
 b=FUN05Y7E2h5rp6R3Jf+2NbGbfs4BHPbzD7feJIM2rqFg+ZEZJVJLgGdg4s3VoDzzCP
 aXFnMl9LwwLU7z72lZmFEEcv2FRcIZRjy5Q1TNXmN1gXdSaqa2J0XpeNyw+FsVVyfx65
 d4hMNiOaYc9xvojOlZ0HxMLRSsP6IfMeS1r44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499952; x=1703104752;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PaQp83k9T0ltnXmaJJglCBZuOyvVwxIaNUqUdUifmS8=;
 b=FLmyGk+gNLG7E/SA2bm2444LFKIBD4v3cBCizgdqbNeRQ71iGWAL6Se5XiD1N7Q6qv
 MtjkAW+Xjh4ARNXxWlat+QJeW/wzdjCQ1xj/EGjMLIvp3/Ar0u8Kz5f2RAGrKv253DtV
 sT1hmU4Hh7jNnux7lWVF9yCT32epz8QjJ4oBIqA6EryhU+FbdVsGHO+uGEedUcpgw88I
 /RqFR4NwCL9nEglUTSCVH0shKQE9MtGaBooV5ZKav2821a78qRO6I2HzH51DTv2VIyuT
 hGinoV87W2hn7y5JazF/OHu7RWyCVEZndGav1Hi0jimT09t7CYaKUWXNtYdGjx9hZJ3a
 fmGw==
X-Gm-Message-State: AOJu0YzqZHQS7VwgqoButKVz6iAohZoXYbC5hhKtkl6vlWhN2RVBzmzy
 dGpNqQyCh6iDKQL0/Lm6dSYYoBJZiv2ZXmShAPFNuNUZw8vAzguqlY4=
X-Google-Smtp-Source: AGHT+IHkOSwRZ9RyvN43hdAFJ12OX5amSvVFV1xyKDvNBW8NXQ/kU+a2FOSFF+yF5aRC0dZ+JD430wCNRnB7l9Dv3Ds=
X-Received: by 2002:a17:906:6b8c:b0:a1d:8160:6364 with SMTP id
 l12-20020a1709066b8c00b00a1d81606364mr4098277ejr.117.1702499952330; Wed, 13
 Dec 2023 12:39:12 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:10 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231119153611.639252-4-sjg@chromium.org>
References: <20231119153611.639252-4-sjg@chromium.org>
 <20231119153611.639252-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:10 -0800
X-Google-Sender-Auth: SgcbsqbBqLvBu3ozrT-DWjqLqUo
Message-ID: <CAPnjgZ0WaH-At=c6V3BA7L5afwQOA9rod2RGyDd-=AQOsEE7TQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] tools: Keep test_util and patman test files in the
 pip release
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

The test_util module is actually imported by some tools, e.g. binman so
include it in the pip release.

The patman tool uses its test code when starting up, so keep that too.

Show a list of deleted files so it is clear what is happening.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/make_pip.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
