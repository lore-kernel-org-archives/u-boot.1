Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63951E7C4EA
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48E7D87658;
	Wed,  4 Oct 2023 19:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gstMLydx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2721A8761F; Wed,  4 Oct 2023 19:58:43 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA158760F
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9b2cee55056so18595066b.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442320; x=1697047120; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m+SU6p5qOR1c5R4adRRqfjI7TygGNSyqn+Li/iLXif4=;
 b=gstMLydxRj86iRpjVVaY3+5UwtQbod6Q1D50zucbd7HkrC2Pf1Qe0w13PKWxTSNCBk
 Tyso5fFB32mkUhzGyUjfRequ2p7gEsKiPBrJMS9O5DWn1vTFlsj1W4Kk8OCDEFL+GQOe
 AdfQ6qkhLft96igL0gKN5xPb7bWM+zw/+sLMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442320; x=1697047120;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m+SU6p5qOR1c5R4adRRqfjI7TygGNSyqn+Li/iLXif4=;
 b=KJ0XH2XIYyevr4XKIySn93WtCy6R7dcZJ2PCxLEWDq6I8rW0xLFJR0W2sJY+YoAdpH
 qiczzoEPqW8a2r2UHw1qLt8sSGaLN/Q61i2P0h5mApZV2fSJO9lcBXpjq8ds4/BbD297
 Rdu04aMpRiQO7w7Yk5vcVZTrSq5LcrJ85Z1BuFWteWHpo9bbGCK5AxduBe/NtF5HWrWM
 KA8VtAOuE0PnQKNua4pL18nMZe4H4hEeNfzZz0uVwsrjLgT9dAu9eodOzzK846EC7Aiz
 etmz/FjIezUGLJH+4RZvnv5tQC8wDxw098WRYBtvfzB422zlAeu4NqKTSYKJgWe9+eaS
 L7iw==
X-Gm-Message-State: AOJu0YwSeulqftd+AKabmQnOKISDQG0kLf5fmWvZ2yL+BJdAdeC2oRUW
 MdTUQBgpLm68GmHlhsTAJmtcUe+trAbEesprOc8lrQ==
X-Google-Smtp-Source: AGHT+IEowd6p2rCllT/PlwvyPPIV5hefS+yxH9+swGOdIgKvSoJZEl0WvRUOxEY1SzdcnoCwCOyn4ANjpLawOQM5568=
X-Received: by 2002:a17:906:8a67:b0:9ae:6648:9b67 with SMTP id
 hy7-20020a1709068a6700b009ae66489b67mr2480039ejc.1.1696442320272; Wed, 04 Oct
 2023 10:58:40 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:38 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-11-sjg@chromium.org>
References: <20230923194424.1739224-11-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:38 -0700
X-Google-Sender-Auth: fEG4xNjJyP7Wrr8SLwpcO50zhAY
Message-ID: <CAPnjgZ2pJJRnsoHVknKUCRmOGuTsFKFh=NHU=3Nscku_gqrBJQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/27] moveconfig: Use f strings where possible
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

Avoid pylint warnings by using 'f' strings where possible.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 56 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

Applied to u-boot-dm, thanks!
