Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A57C4167D
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E47C87467;
	Wed, 15 Nov 2023 14:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Za/dC6NW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8189D87447; Wed, 15 Nov 2023 14:17:09 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B034C8615A
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9d2e7726d5bso1004685166b.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700054227; x=1700659027; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yIHf3LOPE/U0KCr9qdfNlik8wP6h2R+FZwQa1OFtphQ=;
 b=Za/dC6NWcnm73PyuuywVH2nG3Gg8bDQvipym5zMA1B65puHjXHZfLZ8l5jrezIJVv/
 mkt7F2GhPiXQszhFc+1L/ko5f2fr7excn4A80EbUG6/eLv9JJ76MUmNmcOzrQx+51ZrQ
 OcBHI/k1SfTvN8DANawfD3C+U/0HzcrjWnF5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700054227; x=1700659027;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yIHf3LOPE/U0KCr9qdfNlik8wP6h2R+FZwQa1OFtphQ=;
 b=vFh0i2TgzElaE9wv2N24k+CJmEBuWK0+FtLcBtrxReOpgWqRk4hGvyiDEDLpDum6zm
 sWAAB+a4DYKiMR2wMcyDK8tA7awqTTe5Jz0b1UxkPP7VMqxk2p49mXQ2sDmPdvcs10xj
 NwMdC1sLIveTG4sVHktMzjU3ppj4QEk6WKcvxKOQitWPibS86teObn4AlBiVZY7H6hgF
 HoHvtZrWullpBo6lojuKp5pLUk+djPX8Cufdm5RXOBmVQrI5i2qwh+0UwxNk585fYvy5
 13tBBRN+NNfwuI5ZkaPm6lqWj3O3GJYlWo691jiqU7HIH+yaopHp1nkTNkkd+aTrGaJu
 RY5w==
X-Gm-Message-State: AOJu0YykTqZ7OlnXNCsdnQHtuHYz4Z7T3/kMOguMr2QTEyAA6U19ZEGt
 CaBog78CEZLgURFZ8JdcEOY14lkMK3YDOE94OlUKh9ypEMSx9dBz5so=
X-Google-Smtp-Source: AGHT+IGCUgSuDeC1FlGnrXWI99Ns/Is4I/uYZZ5Y96XU2Pu87cLxeZhZk62Fbc1lmuKDspFMLS1ber6TeoO3tVQKl1c=
X-Received: by 2002:a17:906:d9b:b0:9e5:d268:d750 with SMTP id
 m27-20020a1709060d9b00b009e5d268d750mr9080463eji.60.1700054227148; Wed, 15
 Nov 2023 05:17:07 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Nov 2023 05:17:06 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011450.462468-2-sjg@chromium.org>
References: <20231002011450.462468-2-sjg@chromium.org>
 <20231002011450.462468-1-sjg@chromium.org>
Date: Wed, 15 Nov 2023 05:17:06 -0800
X-Google-Sender-Auth: LlFgFwAxavI158K6_SvUFLxdpHs
Message-ID: <CAPnjgZ3-UbMT+vcNzb6Og3uOX11aKYz_rUjbhwUpeGT9Gga2ew@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] bootstd: Refactor mmc prep to allow a different
 scan
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

Adjust scan_mmc4_bootdev() and related function so that the caller can
do its own 'bootflow scan' command. This allows it to change the flags
if needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to refactor mmc prep to allow a different scan

 test/boot/bootflow.c | 49 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

Applied to u-boot-dm, thanks!
