Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2DDFCD0C4
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 13:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2371A84142;
	Wed, 18 Mar 2026 14:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DoZ8W0XQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4220B8414E; Wed, 18 Mar 2026 14:00:13 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E590D8413A
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 14:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b98069e41b0so63783366b.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 06:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773838810; cv=none;
 d=google.com; s=arc-20240605;
 b=dVR9Eu/GpfcjdiZ+EYNwP9iQcUsWu1uATXr3QUdulTo6bui4Rhjl6rkRP5p+UX803Q
 UQ/rc47c075e9hTkP2905co6nnxp2I5T05OtYI2qOLXs6GHvmPDuYp9e7X0KYbYgYvGU
 F09mZmk9nfKvlHCJhVTF+UoNHcLQBMJ/YdMEeIxLwB/2zbYXU2X5DC2idpAvdToM4kDj
 BM0KLRgSI6lrfafK1lPjyRo7GoWTRxoeH2s5bWGC0R4ehXESao37lve1TVxv4q/nqYy+
 prZZv/8y45lCE3kgXG9pQGf8rd+v945L8gb5HwMoJ889fpfydN/dq0JFnKwVjCJZlGCi
 gSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rfLdi+0RVy2OxuSzbsC9b2X+NS72fJFtagCVaDR8su8=;
 fh=6TexoJ5yKuEdpnuZGuPIlVO9D08xF3U4yWlT3PeMtdE=;
 b=gTxE+HfgZXqvKpTZdkQ2VZ27/fLw5YDveUZySRUZ1rz28LArBvAkmNjGyCmf9d+RDj
 QLO/eStiKxtDeVtZJEenap2ZHU1/NkXNZQCf6IGBoDJwVXhMXF68ejq8BHV2YRtz44CZ
 EOOdY2sMLPJ2TjAVYBv736OgbFO7C8evA5tuX2InARg3HzrEybNssE/tpH+op3geSM7n
 SQxiK8I03xRY7gTx6kTb481o9VnzgTjAYgZTAJmrxAVqlRYdyozphe34MbxAnP+QdPFO
 XFhE6/xi1w39tvo0q4U3oaOr9t13yaf119J3XkkJy5ncw4HbSQe65+nJ4s8mghIvzS2N
 tJZQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773838810; x=1774443610; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rfLdi+0RVy2OxuSzbsC9b2X+NS72fJFtagCVaDR8su8=;
 b=DoZ8W0XQcK7q4xGTbgUCBA9KmJta41TM9W0hOhPbySus9bOB3vK/ebPXKNYGAroQ7O
 PAagK6dt4eCrMpzWeXstmfFCoVGbMHP5s657u+zR6JNf9uaE4d2cWgjDGvUVfOYWiKtS
 dr7FIxnHE0tfwAb/p1HDw3k6zU/MeanYU6sQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773838810; x=1774443610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfLdi+0RVy2OxuSzbsC9b2X+NS72fJFtagCVaDR8su8=;
 b=EAXJDgHYw/ZaPKk55Wg8Xqz4V9zmw8twSbmgqWTBUPVX929yvIaIJzCCGvuKqk4sXL
 lLaHNFqnA5fOGjL/14dfZ2z4F6EWJOs+214WfBqGr26ElGjbk89jxwOMh/bcwAzX7tfd
 aKHSF55M77J8PFsU9BUd5zr+Tn0U7VOWXPIbJ1SR+0ift5vBmfoyEgDYcqNCc59DJQLm
 0UOYVO5c68hulwPk+xx49qzMIDJ9i0tNQjSFi36nDNjIs8qzLCj8IwrP7iqJX9cijfjM
 NK/gKKWJHcuD0hQsPrQBIaKDXvLRwxGPrvLkfiMSLYrwkXaagkWP1MesVYdrOy/9rz8H
 k+EQ==
X-Gm-Message-State: AOJu0Yw7E2RN0xxUI17hpVR2tW1xTsry9UCLlZlZtFPJUhv2NuDUn1+M
 ibUwPvwjV2PboeCAZy2v93hTJ/MemwEUL1LXJKT36Fh2tf8OwPOWrpV7LiDgj8SrNN1Hiw2mvPv
 ZY2D/dHraOjcf60Ayv97fK+h4AKwSkdhhpHu9rdxF1dmMudztDc0ynw==
X-Gm-Gg: ATEYQzwAPg5ls7c1wz1621JOxCephrFOkCP8vwIAdO61fzDPNDyi6UiYznGFBFmxv98
 nf2MKrS75STSfFR6wdliFO9bk6TBEzMriLyuGZeRMB0VzMVdeBF5Js52JowY7h9x4PL3EFvUIlB
 QzZ/WoD4NuCm1OlAqiBDCGjKvBNIUAhrlRiHLIAdFrfagQLJptwByaz0zxX2QjkxhwCQeK8CVQ4
 ciSIieoL85hOtCDW/IhL9LxWZhAAj4POxZMeootE3qE+XnzSAqubezeBjisDGX55SmwT0mD4Tmc
 qQYgW3KeY7ju7BIzqGdD4oyUchzZEKymDtfNuA==
X-Received: by 2002:a17:906:b84a:b0:b93:514c:b420 with SMTP id
 a640c23a62f3a-b97f1bff990mr164654266b.13.1773838810125; Wed, 18 Mar 2026
 06:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTji9OgwrDfXOif9rExEKM=Op66qQ0MYjcRPnY_V_XsVNw@mail.gmail.com>
 <20260318012815.GH502704@bill-the-cat>
In-Reply-To: <20260318012815.GH502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 18 Mar 2026 06:59:57 -0600
X-Gm-Features: AaiRm53KbIhf1StxjCQdL8UkmFaQNuwChec1UtL2xVZxvbi4a2DYqIYLdF7UvFQ
Message-ID: <CAFLszTgkcc0E5aSh0mqtmQ-NPTko+qwG+J6ATcSfJQPZrdn1Mg@mail.gmail.com>
Subject: Re: Please pull dm
To: Tom Rini <trini@konsulko.com>
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

Hi Tom,

On Tue, 17 Mar 2026 at 19:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Mar 17, 2026 at 06:11:28PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29554
> >
> >
> > The following changes since commit eefb822fb574e28d49fc9f358328854e17fc8406:
> >
> >   Merge tag 'rpi-2026.04-rc4' of
> > https://source.denx.de/u-boot/custodians/u-boot-raspberrypi
> > (2026-03-12 16:10:46 -0600)
> >
> > are available in the Git repository at:
> >
> >   git://git.denx.de/u-boot-dm.git tags/dm-17mar26
> >
> > for you to fetch changes up to fb275d2abf38736626c6c5d8e46e6273f73f59f3:
> >
> >   test: binman: Add test for pkcs11 signed capsule (2026-03-17 07:41:52 -0600)
> >
> > ----------------------------------------------------------------
> > Binman test-file reorganisation
> > Binman EFI-capsule PKCS11 support
>
> Please rebase on next so I don't have to, thanks.

Ooops, will redo.

Regards,
Simon
