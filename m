Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F00C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA1287A6A;
	Thu, 28 Dec 2023 14:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e8TPSCOR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BEC387A5F; Thu, 28 Dec 2023 14:37:43 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F2B87A4F
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bbd6e37a9bso199483b6e.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770660; x=1704375460; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQPieDva8iHY9uEqpW2B+Z/FOTOBqm9XKG4CWlnJXyk=;
 b=e8TPSCORBzboBB3mlVcjButaRQTrSPgA5B6wFfjoeqpYWi0eHIU27Be1etP2ybGG6N
 z3/7mLBPEnstAgXSSs9Miv1Dcg4afsg6PhyP8X/1zfpmzu4p2MGh7OMaE0HvAYYQFT09
 OxnXkxlr9K0YFuy2jj/JO1feArBa5rQLQlgjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770660; x=1704375460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQPieDva8iHY9uEqpW2B+Z/FOTOBqm9XKG4CWlnJXyk=;
 b=bNCfNx6t13pBdGUFWicU1apUJZDkzMGA8hB+XB07QSq4bhInjATuwToCQntsMqhas6
 EFDNcxJcNAquhY+dZy+762Yg3oS28Cp5Wq8VRZsbK7zeZI2jYq67Bf7IcdWwDHCxHGez
 aAi6zZ4cWDY10VjeX1fqqBYWzQGZuRvHjesxS+fvxqTUTQlWGKDrVJ9EL7WLoHAzG1B5
 aJ9WPZvmQd06A4bfDYSJyvl9Q3j7/xZwIUya4WeMV7+DOTLkDRB0ESJEV96TAeK5txvo
 hAAoixBokv6zWgKVoFTqDOfXI59abu8Hgi3V4FVLnGLnaOYY/cerQ05q5H4wi0Vds+lh
 oZ7Q==
X-Gm-Message-State: AOJu0Yz62EfgTbKUaWrOlZqczw8VjjZzorjTwMRsbDM+W53L+OkwDzOU
 jcAUmF+3IuO0zM6BHFjJW7QUDQthTJTxF5KcMK4xM2KaACA6
X-Google-Smtp-Source: AGHT+IFEDtbt//4uEDrgAl7NnvTRSyG649sV3g+y82UoCAPwgoh6jnW6gWJinzbCm2OE+bUrwEMFgBER7k/gt7YILXY=
X-Received: by 2002:a05:6358:71cd:b0:172:e3d3:4906 with SMTP id
 u13-20020a05635871cd00b00172e3d34906mr8762159rwu.34.1703770660074; Thu, 28
 Dec 2023 05:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-2-sumit.garg@linaro.org>
 <CAC_iWjJJX+Vuicy__sxqc__9nqLHf8A7v6Lr56=wSLEpieai4g@mail.gmail.com>
In-Reply-To: <CAC_iWjJJX+Vuicy__sxqc__9nqLHf8A7v6Lr56=wSLEpieai4g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:08 +0000
Message-ID: <CAFLszTgLDtunJxmwVTQ9NJXH48=dHeiyXghKmGbDDzw3fbZhTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] CI: Exclude devicetree-rebasing subtree for CONFIG
 checks
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, trini@konsulko.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de, 
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk, 
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
 mibodhi@gmail.com
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

On Thu, Dec 28, 2023 at 12:03=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 28 Dec 2023 at 13:58, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Since devicetree-rebasing is an external repo with its own coding style=
,
> > exclude it from Azure and gitlab CI CONFIG checks.
> >
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >
> > Changes in v3:
> > --------------
> > - Picked up review tag
> >
> > Changes in v2:
> > --------------
> > - Excluded gitab CI config check and added commit description.
> >
> >  .azure-pipelines.yml | 3 ++-
> >  .gitlab-ci.yml       | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
