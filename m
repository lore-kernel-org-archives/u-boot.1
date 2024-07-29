Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A694AC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95092888A3;
	Mon, 29 Jul 2024 18:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AMCAp1Is";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD95888A1; Mon, 29 Jul 2024 18:19:28 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96D1488874
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a1d42da3f7so224168385a.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269965; x=1722874765; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lBGP9aVs6KciwosnpOKrDVDdTa1EfAzGPE0U3Ls4TSQ=;
 b=AMCAp1IsKmiQ7SiRpk595LrsSg9TV3RuL+Y4eNoicyX2WGaBpd/t/THMaAW0bTSLT0
 cuL6hD0mWaPrBUqaCw7NCmJjaN4ptchw/75BzYK94ws8ZlQuQNypiRCyWmKVXvcPjqiC
 Snin1oEqucJF1SlgXZKSqZRnxne0kh/0QOxmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269965; x=1722874765;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lBGP9aVs6KciwosnpOKrDVDdTa1EfAzGPE0U3Ls4TSQ=;
 b=u8DGy3OqrHlQRLEArVhtwknz4Y3SHcfrq53ObmnsHQwUvC5v17MYJxWyTCNZCzh2lG
 3xUBPvd8ZXN0JveulRZTiMPl/G6tx29NiB0vcsBMi30w2rgSW98oQZHouiPDS1Qd4DHr
 7x5OFgt8rQByRv0z1wlvd7N7cxHAXSJNtdye4K4rkwOiAYSECztAZ/NO0tVIoen+ewH/
 OOsDqox0Wle5v6k89xdF9ErB84HD0MPEotPOJI84eVHuNhotJJ2o5zYWKbIkNfcO/zTS
 mGE3V2KfUuapJPRZdqeawxvsKQgCGqMRtc8c9ITF/nZxlDmI2TCuz9ZgA81DVkRtlTAF
 eBLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfIAs6uekKIjxgc62kzNLX93LeFU88yq/Lk/eDFU0bTlzMJpULN47lip0gD43pjq5uTb/5+oUiTX4NT/l7K292Bdnn/A==
X-Gm-Message-State: AOJu0YxnhU3ky0eQI7FmUiLlfe8fzUL57otfWgAivLEThUkBKV4CXZMF
 npoT4+C1z+kAt0qrtXF5FshR9/LWU9AcpVDhdhYNf9g/nIwcNNtbLj0M6hk6efnGnrlBu/xKgYD
 551vV1cD8JPYj6ajUPGKuOUthORHb99kce4CI
X-Google-Smtp-Source: AGHT+IHLsYzMKe+y2oCuSWxH48k3N4SnTU6DleHQNx2cBa8vDIzENi2HZT9Jy9S5ToSRe/uCrfpG49lzVT+vfmwClLY=
X-Received: by 2002:ad4:5ba4:0:b0:6b5:4865:948c with SMTP id
 6a1803df08f44-6bb55a41ce9mr102747366d6.27.1722269965474; Mon, 29 Jul 2024
 09:19:25 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:25 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-15-sjg@chromium.org>
References: <20240720104950.2730773-15-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:25 -0700
X-Google-Sender-Auth: T1DImT962CTGqvrXQF64hWVWJFQ
Message-ID: <CAFLszTjTE=uz-XdgHJVR5riNN5wpVbrhSV+jz588m=xaUk7A+Q@mail.gmail.com>
Subject: Re: [PATCH 14/20] binman: Allow entry types to override FDT contents
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

At present the contents of an FDT (for each phase) are fixed,
determined by the build and provided to Binman as input files.

Provide a means for entry types to provide their own FDT, so that it can
be processed, if needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entry.py          | 12 ++++++++++++
 tools/binman/etype/blob_dtb.py |  4 ++--
 tools/binman/image.py          |  4 ++++
 3 files changed, 18 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
