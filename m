Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1ADBD15DBA
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 16:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6988188F19;
	Mon, 21 Oct 2024 18:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QYwkef+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AABA8657F; Mon, 21 Oct 2024 18:32:39 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39C8288F0A
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a9a4031f69fso676880866b.0
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729528357; x=1730133157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lhwg6MVPbEek5sDEgt7HjsoY6wh/pa6Ai2go51kPrDw=;
 b=QYwkef+g1VbB9BJIh1MjLzY3xcXjM3C9teu9H28sMGiHA1NKRFp1kI2n9OsiTD14yG
 OQNkvEZLsKo8yfPj64EKTFXDvMmtA3IyC2v01DZP9NeiNIIT1DT+u3GBdPtp4slJa/Te
 BoVPjYvjn0sptfIt6/0Cm81nBx8z3/FlyCDP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528357; x=1730133157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lhwg6MVPbEek5sDEgt7HjsoY6wh/pa6Ai2go51kPrDw=;
 b=MYR2lxWZxW782Q6zY6gJjYZFSDeXATZ9cLQmrBFOmi5etLN0J1d0OMqr6/hC1RCg9+
 fRje+wVfAbQ7og4cEfP7MJsiz+qfPJg40Vjb+BtnIhCw34sxcOM2zY0Mp8SrXAcvlFA8
 /3MsO/0+y25MjM1HzPK9UmeCCOLVUB54TfDsPnXVH3xIZwnux2h5alCs/KX3vYK/PdxS
 hgqweCU13BPZ1gJxMJz2oTcLFjPxScK3M4DamOQkedm+x6g/5Z0zrAXMDUmknr1ZSjPx
 yhL3xBw7y3Bywokw7lae8jKOumfrumrbVslrXPRVusgkKLJrpdUapwwIBwOFCZAa4gRc
 6nJA==
X-Gm-Message-State: AOJu0Ywb5PaAH8i/2/WT+XWcDevdT6DUfoDfvjIS6tCvwTQ0YhGwCdeX
 nzrIONAFc3Q0+PcW4y//wXHgG5yyD8qaRxUI6657WmxKIA7SyR4AkWfHJ/uR+yQSBb7w6IBqnER
 4Ek90BVjtRiw1ILFt1EMhJCZzUjVg1QlEDfKkvwTfmYUvBa/YQWHM
X-Google-Smtp-Source: AGHT+IELq4rYBK5Xyh/caaYZJZj6aVl9NOkJd3Dsq5y2RVYOpQKCp3CsW0tsZJ+TzsEzFQQWY2z/UxTjRhIcQAmJRws=
X-Received: by 2002:a17:907:9629:b0:a99:43b2:417e with SMTP id
 a640c23a62f3a-a9a69ce1072mr1376993066b.62.1729528356668; Mon, 21 Oct 2024
 09:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <ZxZk4K4ff1T3gUVm@smile.fi.intel.com>
In-Reply-To: <ZxZk4K4ff1T3gUVm@smile.fi.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Oct 2024 18:32:21 +0200
Message-ID: <CAFLszTjuodDFZW8fJDL1Q3nByLVzcTTEAeJfws-sbtupCwNd8w@mail.gmail.com>
Subject: Re: enabling W=1 by default
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
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

Hi Andy,

On Mon, 21 Oct 2024 at 16:27, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Hi!
>
> looking at the redness of the output of `make W=1` here is the question:
> isn't it a good time to enable `make W=1` by default. Yes, I understand
> the impact, but at least we can do it mandatory for a _new_ code submitted to
> U-Boot, right?
>
> Ideally I would have what Linux kernel has for a few releases already, i.e.
> Werror by default and getting close to make a clean builds with that and
> make W=1` at least against default configurations (yeah, with U-Boot there is
> probably no default, but sandbox one).

Warnings should be warnings...if you would like to enable it for CI
that is fine by me, but the U-Boot makefile shouldn't do it. It
defeats the purpose of having a distinction between errors and
warnings.

Regards,
Simon
