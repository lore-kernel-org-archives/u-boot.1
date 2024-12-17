Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B574E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2FB8022F;
	Tue, 17 Dec 2024 14:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k+bAyV4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A4CA801FB; Tue, 17 Dec 2024 14:52:09 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 338F780107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 14:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a68480164so868184666b.3
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734443527; x=1735048327; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+gO6dggM051NlJssKDAASBklHZnC7VH7C07gRguQxI=;
 b=k+bAyV4SNFaljf/JT2warOHxO5Fg1VKXrxH2RVUZbgwxORtUntCM9zK1T3uMiHhDsw
 lhyfekmQEszbxzM9OQkpTweAASvhldhUYsfBug2+AK8Ddis60AOxanzyMLKFJKphDVG7
 YM3WeoeQM8Ei4ZW4N/wFa5kVI/l7hKTKglBBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734443527; x=1735048327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+gO6dggM051NlJssKDAASBklHZnC7VH7C07gRguQxI=;
 b=nN1/25NNH/ek8G9lLAkOcogIexi1WOBzyX17teCvWJkxE1Smga/6k1r00Qjoq0fF93
 NAjLjlojHrqmlmdXWu4H7AS6h5Q1KN7C1rpSAZFpAQ2DAuiSOjMnS7CBRhgchE4gdHKL
 WzwJJhZKzkBvf8Z0Iyhu6dbslnzudBOVNm6kf/5GgpbFp0RJ6ygkAwFanDqBigKbNZwB
 y/3ci2+svPHoSMUyupLtlem46NgEf8EJ9tGHWpT9cOSwp7oYe6UHy/Ws7Xa+LzKT8304
 bLTbrlDJBnuOQnuNLU6p0zwRRuVfG4NCf19oON5fCKpC557ieic1tfd/uZF3uOvIXER7
 2c/A==
X-Gm-Message-State: AOJu0YxPYcqy5hdVoBVm3TgfFPRTgB+vj16ozXyPe8q7kxb0NKtoNmwL
 pUUoj2DLZSuCXxP1VhSCaYW/yktOoMpen4gf3nVf50LIQqHGqg1zLSXurHJn/IIFLkRZPGKAhsf
 +fCpsH8HF8obp1jA3LMiR+SGfq9hYSvZ9Otb4
X-Gm-Gg: ASbGncv/PRdMjtC1sNe/nX+Be0rRLY/bFhCXBoPyYxWZZod4JDUnE+fmqYWomB6QsKI
 x/tjIUEx3H4a/pH9u5UFTlQ4B/dovAP9c1fYC75Q=
X-Google-Smtp-Source: AGHT+IFhsLsABy+8vaoqekVOAcZjVcupxiuC+WuPINgwrZCVoxmVixscv8/QNoedVjiMCG1etUJ/6nXA9zUb2sZF6Uk=
X-Received: by 2002:a17:907:3f23:b0:aa6:61b7:938f with SMTP id
 a640c23a62f3a-aab778c8b12mr1867772866b.6.1734443526696; Tue, 17 Dec 2024
 05:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20241217134417.4064239-1-sjg@chromium.org>
 <CAOMZO5CJGuSLog9Gsnw0cJ55FLJ+jGE+UB3kVw=79TGQZAhUCg@mail.gmail.com>
In-Reply-To: <CAOMZO5CJGuSLog9Gsnw0cJ55FLJ+jGE+UB3kVw=79TGQZAhUCg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 06:51:55 -0700
Message-ID: <CAFLszTj91_UNoN5PUpWrbbt=JtoHoyvQrkNN01QmovzGREzA2g@mail.gmail.com>
Subject: Re: [PATCH] gitlab: Add a Colibri iMX8 board to the sjg lab
To: Fabio Estevam <festevam@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Francesco Dolcini <francesco@dolcini.it>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Tom Rini <trini@konsulko.com>
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

Hi Fabio,

On Tue, 17 Dec 2024 at 06:46, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Simon,
>
> On Tue, Dec 17, 2024 at 10:44=E2=80=AFAM Simon Glass <sjg@chromium.org> w=
rote:
> >
> > I have one of these boards loaded with Linux 6.6.2 and a video demo. Ad=
d
> > an entry for it so that it can be used for testing.
> >
> > Unfortunately quite a lot of work-arounds are needed to make this board
> > work, but I am working with the supplier on this.
>
> Just curious: what workarounds are you talking about?

1. It needs a special build target to build the final image[1]
2. Needs binary blobs in the root dir (I need it to use an env var to
specify the location, or ideally use Binman)
3. The first time I build it gives an error, so I need to build a
second time; it should build from a clean directory in one pass

Other things, for some reason, there is quite a delay between when the
board boots and uuu returns, so some console output is lost. Also uuu
is hugely verbose and needs a 'silent' mode.

Passing run here at [2]

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/board/toradex/colibri-imx8x.html#buil=
d-u-boot
[2] https://ci.u-boot.org/u-boot/u-boot/-/jobs/8625
