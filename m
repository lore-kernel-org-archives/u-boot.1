Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295EEC47073
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 17:50:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0564879C0;
	Wed, 27 Dec 2023 18:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c2EGSsZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BC49877E2; Wed, 27 Dec 2023 18:49:14 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F8D879C8
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 18:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6806914dba7so2273586d6.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703699351; x=1704304151; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHnt9z+U14veo+hksyp5v70BWG8s3r9jzWS8F/IeR3w=;
 b=c2EGSsZbPsejPJAz6br+wJpqx998CyxraWGbUH+iqTLNqsCD8441q2xIy8Z0zqpnj2
 LEZU16pX8NDxJeAb5r7HVXdtzjeZhY0362hL1s0poux0W8/zbHGMpR25QUQ2dLhMIIXE
 dg7itGtdTJKE5pK0yKai2BnrAHK3W4VV6I3Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703699351; x=1704304151;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHnt9z+U14veo+hksyp5v70BWG8s3r9jzWS8F/IeR3w=;
 b=B0WI6DjPhtzUpZf4AUwHklRqbKt3RuNLdf4NO5CF+bvoZ/joX1C1SHwOPEwUpsHx1N
 pYfpOwb19kRmO91yKVVt8FcLO3SfcgX8odlTLem9T74dare5BX8sHtiAhvrI7MsHuDGZ
 B2SMTQjGG2x3CQbL56MCOBfEKLoMnG54wPcJXMGHAUCBB//rGQGibsR31boZ/dzJI1MF
 bT47ptn2u2CDmrUHKOounia2e2mXwtp8pzGjmMgcMjMoOZYwUy4e4nMQJg/G/7TayJHn
 gsD9RhN67lG5XT4HFbMFwNqhKtqeokuKOrWgnGbzgD16dWi0jAd5d+2B0FFILHPAZB5R
 Ir6Q==
X-Gm-Message-State: AOJu0YzbJsWMeDv40xkMlJJEu2qEkcOlRwiY95PBhhBibLQwjagpxEdx
 31+zs4kCyb2klQN1yGwt8mzoYTpWBRNRxjaP4ZdH8iqHZlCt
X-Google-Smtp-Source: AGHT+IG2WIeH4DcHm4yIiaSbtWfCQNnTIMYnJRkYGkt8CTNwiOFEdyLQHfqVjZUYwQ04pMapYjTSDrgpXnhQNeT/5KI=
X-Received: by 2002:a05:6214:d47:b0:67f:8f14:cbda with SMTP id
 7-20020a0562140d4700b0067f8f14cbdamr15595223qvr.16.1703699351189; Wed, 27 Dec
 2023 09:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-10-raymond.mao@linaro.org>
 <CAC_iWj+a=kTUm5Kp+tgtea6tG1XgkDC+V2JeZ3zjqTS-9T6-uw@mail.gmail.com>
In-Reply-To: <CAC_iWj+a=kTUm5Kp+tgtea6tG1XgkDC+V2JeZ3zjqTS-9T6-uw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Dec 2023 17:49:00 +0000
Message-ID: <CAFLszTj6JtV=ragFvNpoCKXY+PemM+7s=DaRpgH21Rhpj2PeaQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] bloblist: Handle alignment with a void entry
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

Hi Ilias,

On Wed, Dec 27, 2023 at 9:58=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Mon, 18 Dec 2023 at 20:20, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > From: Simon Glass <sjg@chromium.org>
> >
> > Rather than setting the alignment using the header size, add an entirel=
y
> > new entry to cover the gap left by the alignment.
>
> Hmm, why? Does it make out life easier somehow if new entries get added?

This was one of the spec changes. Not one that I agreed with, but there it =
is.

Regards,
Simon
