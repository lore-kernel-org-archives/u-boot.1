Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3326ACD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CCC86C15;
	Thu, 21 Sep 2023 03:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EhiwuEsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6402786D05; Thu, 21 Sep 2023 03:05:06 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69CB8863D9
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59c26aa19b7so5199797b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258303; x=1695863103; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v0BCH4MAv8jSxIPb3WiT9oiezflJDRCNdN2ejVUPVFw=;
 b=EhiwuEsbEEJPJEP6KapbYI2F3O1HYTo2DhPVNp6SO11RYGwB08QvzKpUlbjwccQiet
 Yp2GylFA1wxVCvSsgRbAf3bUjYJf/4CHyWfWzmN1FxEBlgDpN+qcnwg5AIOmBIrx35HF
 ZvB2+2ffYThVrd4dt96DNXgYNVDuxPwWSfPn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258303; x=1695863103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v0BCH4MAv8jSxIPb3WiT9oiezflJDRCNdN2ejVUPVFw=;
 b=P38FNnycAZ9atW24Oa/dPO/7ajBjK/M6mPcyPZ+RRbeQ854lzAUjTKwzhYYd/JO5vS
 sxLuqJa126rAxQfxxelJwoFpg4vJ3d6FHZKYb8PgGUHC4dMPTboBQHIY3iWqs9eTjva2
 r0k+NpLszlbEfS2X8QQQORoaWPNH2IFw6KygX47+1RbYszNxHkSsSVsKm5dvbTlPaftD
 cXX+dRwHhskmJLzbvTcf8n3+t2vy/LAA5+dLitf/YcNoR41ViFxmqRCnBRZ2+v08geTp
 nUXreEx/0S/pDsUR0OODqKDo5UsYlCP75ovKVqC153LxWL39Gw5wjyz5GUJBFzqAPHFy
 YDVQ==
X-Gm-Message-State: AOJu0YyOZY5Iv+8Mwv1at2V6bLI3dio2ltWfwAuLwOG3CUYfltBJUsQd
 0cLOUBHv7nFf0bGEAqGQWK5V0LDTdGFv4LW5k+zPOU1XF4AnF02NiOA=
X-Google-Smtp-Source: AGHT+IGfhfA0kxdUGJqsJ4LP54LEhvBtzbaoBWRTyojKZeg1Oq0z/6mJqFooCGL9XSgt5iB3Zri72J0ZfKMCJgWWg1M=
X-Received: by 2002:a81:9341:0:b0:569:e7cb:cd4e with SMTP id
 k62-20020a819341000000b00569e7cbcd4emr4935374ywg.48.1695258303014; Wed, 20
 Sep 2023 18:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-4-rasmus.villemoes@prevas.dk>
In-Reply-To: <20230919113705.109639-4-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:03:00 -0600
Message-ID: <CAPnjgZ0ERUvzoQZNJYc0=xhybdkabyTMvAN+_F-knGaJ4at52Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] tools: binman: add test case for fit,
 align without fit, external-offset
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>
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

On Tue, 19 Sept 2023 at 05:37, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  tools/binman/ftest.py               | 10 +++++
>  tools/binman/test/311_fit_align.dts | 58 +++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 tools/binman/test/311_fit_align.dts
>

Reviewed-by: Simon Glass <sjg@chromium.org>
