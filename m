Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C13D767F2
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A6689293;
	Thu, 31 Oct 2024 19:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PcfEH7GS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 335DD892E1; Thu, 31 Oct 2024 19:02:09 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B5189293
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e2b549799eso924151a91.3
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730397725; x=1731002525; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=69AT9EWcfDFo486Zmzd07Bp/59MvAOvyQ08Hyr2XWyY=;
 b=PcfEH7GSxfsRdhd/kGxd3+3T0yFLPDPVBIaac76XZPXfvfz22ZKCKFcpMmXTBSpItA
 GIrju7VmkSfaDOVKIICkRTE924y0Uyqk2axsjzxOxk3XQ5/r3fnC+1lKQzG4J+vrEJ04
 pt3UPOabyC87D+cJ/Yw2gXUrU3XyQeRrzmw7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397725; x=1731002525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=69AT9EWcfDFo486Zmzd07Bp/59MvAOvyQ08Hyr2XWyY=;
 b=sqO1JA4XUdmwFWnA6ktUkQI+AmtewQJNVtL6YH0Sbn3JQfdTqQf9+fBV9pjB5ZVFmQ
 V2DtuWfXSiEF5ZxfOq+6RlQ0Bj/lpjj9Bg9ZBUQ1OWcgS2+oMHAvpNV0K4+o9nJJlnm3
 Te7EcJGxcPaBsi+GOAVsWmGOgynWC8cPfqqSEtMU/leCRNn2m0v7vnA2lcAS/rwJ1qYx
 JTik3kmiJMIK2QZmDUktLA1ZhCqTv829NnTIbxCzt9rdM4dq36CUYldU6mse7QZUvYqx
 PDqIIH2HJ2DgwiFPfpD7BETjxp0rtMuADdE20xcmNgFznqvPthLHRsEdDRt+NdvBhnFr
 hOkw==
X-Gm-Message-State: AOJu0Yz4QnT3R22webqAjsKLSeQSvHP62P8h4hi+hV03k0IEAidEq5BU
 3xsGCo8g5ZN61e+XvI7nilmTeTEbXBQLHFEmFwm3DfNuAFMs3/gRxoyTxmR3/79U296c8jjm+30
 ixkEI+IYMxUuhbqFZtCsyIsqxy+b9e6QYSdaZ
X-Google-Smtp-Source: AGHT+IHOeWaTFpAbnAK1WewR8L8bloWL/fW2wp4E/JRxvEqn2hjUTZKffKq/YreNI4JEz/kwvpZ4jX9UANj0PWLG/jc=
X-Received: by 2002:a17:90b:3886:b0:2e2:b281:536e with SMTP id
 98e67ed59e1d1-2e94c2bddd7mr1113633a91.15.1730397725586; Thu, 31 Oct 2024
 11:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <20241028124815.47262-11-sjg@chromium.org>
 <A00AAF0F-5E6B-4DE3-B18A-DD564026D3A8@gmx.de>
In-Reply-To: <A00AAF0F-5E6B-4DE3-B18A-DD564026D3A8@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Oct 2024 19:01:47 +0100
Message-ID: <CAFLszTj9EhCKkxjBotx-CvuKjuV2T7C6CyJTpHB59nerLavKjA@mail.gmail.com>
Subject: Re: [PATCH 10/15] efi_loader: Add support for logging EFI calls
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Levi Yun <yeoreum.yun@arm.com>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Heinrich,

On Tue, 29 Oct 2024 at 23:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 28. Oktober 2024 13:48:01 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >The current logging system suffers from some disadvantages, mainly that
> >it writes its output to the console and cannot be easily reviewed.
> >
> >Add a dedicated log, storing records in a binary format and including
> >the result codes and any return values from each call. The log is built
> >sequentially in memory and can be reviewed after any EFI operation. It
> >could potentially be written to media for later review, but that is not
> >implemented so far.
>
> An EFI specific solution is not a good approach as it does not scale to other parts of the code.  Please, implement a log driver to collect the messages that you are interested in.
>

I can do that too, but it isn't as easy to programmatically parse. I'd
like to track what calls are made and understand better what is going
on when Ubuntu boots, etc.

Regards,
Simon
