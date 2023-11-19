Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818C1C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E72BA86EF6;
	Sun, 19 Nov 2023 16:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c4KYTkn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 019D286EF6; Sun, 19 Nov 2023 16:03:53 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84940871A0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5440f25dcc7so5083578a12.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700406227; x=1701011027; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhgRPtKLHKyCASHu64uGyNWJNnaZJqXUqiVwYsPYYoU=;
 b=c4KYTkn8C2uVStYQO3lP3xgK0ZEuilil64M/R8eUDybxLbzHFq7TPFmrLtsBAukPhW
 5v+qG005DzoJD6H4GHhyW3MwCUTC8vAxcxnFRTzR+wMZ0l2odpEza9cepAKApsTQ3MOr
 PibGsujKcDgfGSgDqSpHnahH5ny6X/lKLUXw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700406227; x=1701011027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhgRPtKLHKyCASHu64uGyNWJNnaZJqXUqiVwYsPYYoU=;
 b=psx1lNUg4Gi1uvQ1coLs2YXGGu71kgrqHbP5HJKAfSxzbjCZ01aeG+oWYaBHA5FL6k
 JK7bYjjZBt9ofzOcjjLbfLi8i740p4AiXy4GhPsIqHVqwGvWkPOtq/yPmvcdNI6wcfxJ
 Y2LLj+n2HwG6Y5aQ4chAcWafph7L7248QV+auqVMApHPoOLqOfLtjTnQscw2Qv1bfrDO
 vRzNOIQOudfIiKL3115uYp1ghuus9E/NiDVYFPG8W/r97bx0mkjEBkgaGPzsO/lx8TMj
 dfy0gkemd2bi1NDmmDMErOFVkOneHKiskG378QZofhlpI85aaRh6hD7lVNg1GnAvGZpA
 JONg==
X-Gm-Message-State: AOJu0YzfdrCs7hlU2KPCQQiOsZaUS4lXQDKId96siQ59GcUxXBiYhdif
 3PEQhhZO+TOPIgbxS7oEkElLaKAdoP/qQurbUXS48A==
X-Google-Smtp-Source: AGHT+IGzFEU8YWTTy6VrQtmHjiot+wlxwXCg5vwgI/KdLmFFd5niB+Mx16ggwlizicPuNRRu/BhQLB81+rZ1kcxVG90=
X-Received: by 2002:a17:906:2ce:b0:9da:e694:e6a2 with SMTP id
 14-20020a17090602ce00b009dae694e6a2mr2846142ejk.4.1700406226754; Sun, 19 Nov
 2023 07:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20231111002851.1293891-1-sjg@chromium.org>
 <20231111002851.1293891-3-sjg@chromium.org>
 <CAK7LNAQN_qGYztWGDmQyfg+eZ5P7RkM47mpgp0dQn_iuhvTSWg@mail.gmail.com>
In-Reply-To: <CAK7LNAQN_qGYztWGDmQyfg+eZ5P7RkM47mpgp0dQn_iuhvTSWg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 19 Nov 2023 08:03:35 -0700
Message-ID: <CAPnjgZ12nzMmpqJ5-=TzY+Dxu=4keFbJAB+RU99FqxKZfxjNUg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] arm: boot: Move the single quotes for image name
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Masahiro,

On Thu, 16 Nov 2023 at 04:19, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Nov 11, 2023 at 9:29=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Add quotes where UIMAGE_NAME is used, rather than where it is defined.
> > This allows the UIMAGE_NAME variable to be set by the user.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
>
>
> I applied this to linux-kbuild/fixes.
>
> I changed the subject to
> "kbuild: Move the single quotes for image name"
> because it is unrelated to arm.
>
>
> Thanks.

Thank you. I sent a v6 with a fix and without this patch.

Regards,
Simon
