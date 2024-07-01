Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8449C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2DD88677;
	Mon,  1 Jul 2024 15:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AMrp+y/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A574F886AD; Mon,  1 Jul 2024 15:57:55 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93F98884EA
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 15:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b06e63d288so14464096d6.0
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719842272; x=1720447072; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WsyuAW0zhBAoutJTx2a6DxgFfaEtURCVzhNW0m7NYms=;
 b=AMrp+y/hnvOkcZgSCjPoUGkEOpApPKMLwxjfOaPVFc8cXy+Ru+le1hZ6oaXqjYwh46
 AEaOKSh6roXkqO4ImekTHzXCzjAvi/+0pjm78JP3vKvFOlu5jCQtUO8XKYW17Q85FQnC
 NN+PqtBJY9ddThM1/ck5OpUvwf0S3nR+S5xi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719842272; x=1720447072;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WsyuAW0zhBAoutJTx2a6DxgFfaEtURCVzhNW0m7NYms=;
 b=u5CLj2gukgLbDKsIug4Opmd40hbPhLn5q9Wczt2lyq11myjWcT8QEIfmFV39v0Qk+O
 bqS128QufigW/d1MxVjEdth1TXHW/goldBh8ClfpNBZCJ3EIkQT2fnDcvsYlJNKDg44x
 ZCidgg5gGfkZ4tfUGZkfm6rLmQwa9/05sTbhPXkBATtCv0GIFeQjevs50JGKx9EeOUOe
 Q010DvU0i5TRPi8U7Vd6o+gPduRstc+ITTCeGkG6XIzkDsCxK1UbgcBTZGteQs+zyFHD
 UmrKqvOVffnyC1uU5Po1rzFEUek2wsQK4LBScnnxzbpfFv6rZJHTH7HrZNFfIQTWYJ02
 lbBA==
X-Gm-Message-State: AOJu0YxN2FQrJ+U7z4vhgJa+azyPVaN0ue3yrNye/CxSzSe6g0Y7ZSW+
 OpVkvYn084B2LbclhIBecW9IREGhTUYRYpHtGQptnscfycwDzYWyBEqRaMl7gK4Nn5i6cxsEAxt
 q1NBKXyw/WpDLch1q2QwUUPk3HVT9T0gJSVB1SxyQmgNn3vE=
X-Google-Smtp-Source: AGHT+IF6Pvcl7omnhkE5WmgQaLvvTkGoTAsQjYuIHcVIJXaPcw42ITvGVZWqPoF6ZyMky7QFI0t8swp7trVDw0CCE5w=
X-Received: by 2002:a05:6214:212d:b0:6b5:26f7:76b5 with SMTP id
 6a1803df08f44-6b5b704eafcmr96839496d6.7.1719842272550; Mon, 01 Jul 2024
 06:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240501231657.2088609-1-trini@konsulko.com>
In-Reply-To: <20240501231657.2088609-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jul 2024 14:57:41 +0100
Message-ID: <CAFLszTgBghtvKxf5-92k7bfXFeOKK9FK_R9h3+Uhsq5K1AnR+w@mail.gmail.com>
Subject: Re: [PATCH] buildman: Add flag to filter out missing binary blobs
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, 2 May 2024 at 00:17, Tom Rini <trini@konsulko.com> wrote:
>
> When doing builds of a number of platforms and not intending to run the
> resulting binaries, we have an option already to tell buildman to just
> make fake binaries for linking only. Add another option to filter this
> from the output, to make parsing build logs easier.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  tools/buildman/builder.py | 13 ++++++++++++-
>  tools/buildman/cmdline.py |  3 +++
>  tools/buildman/control.py |  3 ++-
>  3 files changed, 17 insertions(+), 2 deletions(-)

This needs a test. See eg. testFilterMigration().

Regards,
Simon
