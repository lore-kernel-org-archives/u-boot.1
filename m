Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F93C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 13:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B003A88715;
	Thu, 30 May 2024 15:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YUgyzDfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C9E4886F3; Thu, 30 May 2024 14:24:53 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B29FE886EE
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 14:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d1dbd01529so456029b6e.2
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717071889; x=1717676689; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MHZx270k+8cm9v7/usPcctT+KNmn+HXx0uwW5mAApME=;
 b=YUgyzDfMqD76K3sSCIE84S01nWmmb7rrY+S2haLubpAv1eXfefCKhoEmKxi56EFC+u
 U8tZlQ7m3+d3Nr74kU0MsZ1oTplyKr5eNeTxxK9P71w61muNnL3g5u0/j6vNu8aNHNMR
 zHqLcP9oxrrFMpgJyeEtiHoEtF6BVOl5frK/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717071889; x=1717676689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MHZx270k+8cm9v7/usPcctT+KNmn+HXx0uwW5mAApME=;
 b=GlEvlfVorV8JsHQ1D+ZtsuB3U5yfAcgB20xOhJ+CJWE18sFL7nZYGHvy5wWK14WdNe
 B4LXlJs+Rxl+I3jnM63EzVlYWl9IbSNmQvXbMWveqFEElCS/nRATykZMmxb+zquwyJWt
 e8HU6w5elOojaQdYuuKxM5dZucBSWkjGfprfsp6grXhQllOFXXraf/GRyqWLky/Pa1uk
 qErxAqZPDsbqvRgJc1GjKJTynKKMTmGMNEUaxmM7iOY+VCKKsfu57aw0H4T2mBmttooc
 oz9WncepX9LdD6IDmJv8C0t4oX8aTPazskfKuRN7ZCx/Id2bvlcGQPcb/1FCJ0HjH5l9
 9mWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtIkCAa0d20UR/hpyqzo6N8f3QQiJdBoO7s0xx/MItaBe3KPGqqbzQ4hzQZKdbAEkgXRb5+SbCmjWWnvT39NGDRwXyzg==
X-Gm-Message-State: AOJu0YzHSQhDBwXZwR7yqCww22fLCSi6g9CYLQ9uwcMRK7VoMZnoQm0h
 FpiW9FxKWJd9aQWoGjpJOPIETcLTYNYuc82RLoQZ4ji7z7+nHQR6uxVCsLp6jBuBmYxaN/+oV+f
 szVATmQINwHicSTRvYongQo4tGp93qWOPQCVV
X-Google-Smtp-Source: AGHT+IFvs/svJ9mtAyA5b7XuL8A2sA7nDy62J1pD5xmRpThWBRp/5Wo59buMTyr/AsGA7HL7S4xn5RYwV1XQ2KmDvoA=
X-Received: by 2002:a05:6808:614:b0:3c9:d7e1:e6af with SMTP id
 5614622812f47-3d1dccfc28cmr1920847b6e.48.1717071889335; Thu, 30 May 2024
 05:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
 <CAFLszTj8vfZVW+0YPqcg6ST3MndW=mFJkOz3dJXuFb=P1HP3kw@mail.gmail.com>
 <b10fbb50-18fb-4483-a90a-22ec11db94d1@linaro.org>
 <CAFLszTiMjvPk7m9h9RAEPfxtL5B1sY-Y7-VbCEgbjEhL+jat_A@mail.gmail.com>
 <f5b6c004-81df-4fab-85cf-764a29d8285a@linaro.org>
In-Reply-To: <f5b6c004-81df-4fab-85cf-764a29d8285a@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 May 2024 06:24:38 -0600
Message-ID: <CAFLszThNEwHyY6bXeSPyQ89VuQUEtPDFb=AgckCumcMyhRvXaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 30 May 2024 15:50:06 +0200
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

Hi Caleb,

On Wed, 29 May 2024 at 15:55, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 29/05/2024 21:49, Simon Glass wrote:
> > Hi Caleb,
> >
> > On Wed, 29 May 2024 at 13:04, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> >>
> >>
> >>>
> >>> How about using the compatible string, instead of a GUID? Is that possible?
> >>
> >> Could you elaborate?
> >
> > Well, the compatible string (in the root node) is how we normally
> > decide which DT to use and which machine we are targeting. So I am
> > wondering if we can somehow use that, rather than producing a GUID
> > from it?
>
> No, we can't. The GUIDs are required as part of the EFI FMP spec. We
> currently hardcode these GUIDs per-board (meaning if a vendor productize
> some board they need to make source modifications to replace the GUIDs).
> This series generates those GUIDs deterministically at runtime so we
> don't need to maintain a big list.

OK thanks for the info.

Regards,
Simon
