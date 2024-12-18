Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36064E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 14:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EC1F8033A;
	Wed, 18 Dec 2024 15:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xfp+87/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E06F802E3; Wed, 18 Dec 2024 15:51:12 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65C458022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso969458766b.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 06:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734533470; x=1735138270; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AHDRgePMh0dV9D8vRcW4/uagjJxoI3U8Z14Sbi/D4sk=;
 b=Xfp+87/4fjzIqKnlesrGX6TXi5Ej4AW9TrwvZuuO17Dg7lo9XNBknZ4nHybDt2Y519
 M/Q1N2TFqK/JIx0KnTDb5c5GUP1Mau+QdKB0eGTm4hlNF8UQ8BNpj+sHHdG7yj8siuGS
 eDJpBFYnCi3jutFnJn0fDlpfHM2nXq1fwkgRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734533470; x=1735138270;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AHDRgePMh0dV9D8vRcW4/uagjJxoI3U8Z14Sbi/D4sk=;
 b=YFaVHFwodeIgXrD6SSDUFnARtMhI2Wjr9O1Kv6YBLN0lVWELP+2XLfXzIEtTnwrakw
 MSQnENLLTMHd9MGJBaaXwr2w+Cqp94f13xy6p7/swDffjWmSV7Clgrma+YrIlzjoASm2
 jN+DOeda877ykgQPUtPiX+GUjMaXGWJyZ3EHW6jhpDt8qbeL1wPvneguHV05QgnTcIQB
 4KJ5bOiKPk2qQYQDP20ZL/RTuqhByC7maDXYFRfjYpo69IwPTtPLgDWRBPjm8UwVhG13
 SHtAUzJDO/+iv1JmZGU0IhWofyxiTknTBkq57I+V33YXeZfkgGEnfDqIoWPwBIxBdImy
 7rRA==
X-Gm-Message-State: AOJu0YwRTJsRJHvNKtuEA8scKzB145ninxYny2NE9q55Y8XSZGxQwZfN
 cfPbVlHYl2WcUK0iivJywnUcREI7yrzSW+4Y2lQS9TJoFAHUCKAqKZzROh24uqcHjeqhRBJqN9l
 yMp1hIqpivecylyo4XN/FWXPtxP81eBnqVZFEzNMHb87KEkE=
X-Gm-Gg: ASbGncvikilaPL7xN8/xlcLElvcPsRo7ba4iocCNpP3UrgQJrRR4hpFgosuYOAeb620
 5KHepSGlwxEUIMVucEOe8hrWYr6CCulf/i2S9FWo=
X-Google-Smtp-Source: AGHT+IEvRn118WX2uULJuuAvn0OgqmyhDLJdmjF/sNKmZDKtaTZ8qqYvk/b5Hz7Hp+1sXjnVEL32wjyURIVM+sRaxeE=
X-Received: by 2002:a17:906:31d4:b0:aab:882f:c631 with SMTP id
 a640c23a62f3a-aabf4990c90mr258831566b.61.1734533469863; Wed, 18 Dec 2024
 06:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20241218025540.3025522-1-sjg@chromium.org>
 <20241218025540.3025522-3-sjg@chromium.org>
 <20241218143222.GZ1505244@bill-the-cat>
In-Reply-To: <20241218143222.GZ1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 18 Dec 2024 07:50:55 -0700
Message-ID: <CAFLszThre_eACkivMO0E79to293joZhGr8XStMfgn6E9X9vNog@mail.gmail.com>
Subject: Re: [PATCH 3/3] gitlab: Resurrect the samus in the sjg lab
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Wed, 18 Dec 2024 at 07:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 17, 2024 at 07:55:40PM -0700, Simon Glass wrote:
>
> > This ancient Chromebook that nobody cares about is working again, so
> > add it back.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  .gitlab-ci.yml | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
>
> If for nothing more than my own debug needs, was this another
> OF_BLOBLIST fixes it platform, or something else? And is this using
> chromebook_samus or chromebook_samus_tpl ? Thanks.

No, this doesn't use bloblists. It is chromebook_samus, but that's a
good point, I should really bring back chromebook_samus_tpl as well.

Regards,
Simon
