Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A48EC5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 11:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4524283252;
	Fri, 30 May 2025 13:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A+AAk3Rv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713AC83291; Fri, 30 May 2025 13:18:56 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 869FB832BF
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 13:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-602c4eae8d5so3780835a12.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748603934; x=1749208734; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nlUbpHJSESAR0XlWjBrBSZvCM/MCQp0CQjPdbBXJWrU=;
 b=A+AAk3Rv45/oa2jYVEsJNaA+r29MDzDeJKH0Wgt7ZPkscMoa8GSjGtOn79cGk9ntwt
 RYppRSg2WzrBUWtoxB+SSbY1SWRGDpX320yY/Czm65GOJooe6JGcxaGJ1nis7MTDDcii
 GC+vIWXGQdN7iAZBLIfVXlOuOYI7CmwhUAGuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748603934; x=1749208734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nlUbpHJSESAR0XlWjBrBSZvCM/MCQp0CQjPdbBXJWrU=;
 b=wPNXLjhhwrHTl0T8w5D+AB0/W/HosHF82/bg35HjfTxtrk4O6mDCBGKIVc+RiTcdbo
 3JpET156KEqCUnCliD98JSxtIct7jyZthj//nN3y46WXUFX2kuVnsQbCpq9UWxHz1cNz
 0eza+O3czV/A+PG7uXFbsismWDx1EIc6dYb9g2uS3zXiCk2+scFLFLiD0ef37gt6kEle
 qeh4y01oNIgmUUME/NDImZ5X1j/fmPvGEfqpIeTUEkl6IryLvQytMR7L01gXK/Z5j2o5
 x8dcKplBbaemtsqsq7QGUir3AHzaeZANdiyVRMLVly+invaa/0SYrzMTrttD08nANDH4
 LbdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6jF56HwZr3NzZPtmWS2Bba7mllVGEy0TENkOnpLQw3v3Skza58EwAYNDjHa2wydwaxUboD/4=@lists.denx.de
X-Gm-Message-State: AOJu0YzT1L4dojvqwwqUd3/TE2+4SrfOFCciR3yGQCNSDpKfwNGH2jk7
 pbFP7POPIZmg+3Q86uN7ltHYgrb5PEPZ6iUGaEpySeGB2P56OZn950nXa8F+DVrrwDAf4wk7n3m
 kawBhvhS0GfTyJGiIfK79ZazzeD0nxQxtsPwAc2TP
X-Gm-Gg: ASbGncu/6oZFLEnjtVm+wz708tl97MOGgnUIPKmJYJ/vqewAF1iAHOBrWDSEIVPACIk
 f9cXFoHl2XAwU/nBzcqwOo7254N7Ld5BlAJsmygse780GJLLAIIaV5Zq9GCNP+sQz4VAbtl9fX/
 EvK9Pqsndyh5l4lhd277QH9evQFW9ItwIxGimChtj4Lw==
X-Google-Smtp-Source: AGHT+IEnsU6mazH+5jVL4NzEPeXituhPis31q/OQVwwXLyQ+C56Ths4lSJhTUfciJpEgIn+P1b7FfOHGxYzH5nF0ZU0=
X-Received: by 2002:a05:6402:84e:b0:605:2990:a9e6 with SMTP id
 4fb4d7f45d1cf-60535a63a83mr5806346a12.5.1748603934025; Fri, 30 May 2025
 04:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
 <20250527-binman_faked_optional-v2-7-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-7-3362ab897581@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 May 2025 12:18:36 +0100
X-Gm-Features: AX0GCFsytxR0o5yc3H_Ey4i7tdbAwPAQrWDjL0DwsBb-OX1LDQ4C0nP9DCJv9OM
Message-ID: <CAFLszThr2Qmyt3gkS6r_tC_Gwp8Bydf2zSx298r80k5iSk2vWQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 7/8] tools: binman: ftest: fix tests that require
 non-faked ext blobs
To: Yannic Moog <y.moog@phytec.de>
Cc: upstream@lists.phytec.de, u-boot@lists.denx.de
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

Hi Yannic,

On Tue, 27 May 2025 at 14:24, Yannic Moog <y.moog@phytec.de> wrote:
>
> By default, external blobs are faked. Some tests care only about more
> basic functionality. In those cases no external blobs should be faked.
> That would trigger a different (binman) case which is not in scope for
> those particular tests.
> Thus, disable faked blobs for those test cases.

I still don't really understand why the default for tests needs to be
to fake the blobs, i.e. the default for allow_fake_blobs becomes True
instead of False in tests. For most tests, there is no external blob
anyway,

But let's try it for now.

Can you push these changes into the other commits so that the series
is bisectable with 'binman test' ?

>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/ftest.py | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>

Regards,
Simon
