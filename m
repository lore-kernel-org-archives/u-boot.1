Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87001C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:38:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 427B287A3B;
	Thu, 28 Dec 2023 14:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lLcvbD1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02ABB8781C; Thu, 28 Dec 2023 14:37:22 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED5487A24
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78106c385a1so568836585a.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770638; x=1704375438; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/jTSGyE+wejWaHVrCuh5sTmDVT+nds20AexhZ99JCo=;
 b=lLcvbD1KVrmxAxHa4jEd4u8VdKMImkL7lHeZztjqravWlJ8BU/kYANyjBOl1Vkmxcl
 AZim4MXprsSlbahbNcq+VhvimOO/68BYfoAgd1s7uVGNA/OsFC1o0OrzmbG6lBmzWUIU
 HnQt0+aFp05cICOnb1V/vzGjycYQSOHQsGgRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770638; x=1704375438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/jTSGyE+wejWaHVrCuh5sTmDVT+nds20AexhZ99JCo=;
 b=ZXCuEB67xtEHtUSHZ+yzdx/heDFd96R6S4CYR5o7q7iCZVzUUG5BJquJ5cy3aqrK8o
 rGfheqVk+ztyTO6UbuKWS6+XGi6McXdNUVoG2gIGCW0a88Hh+6iQMr6xl6ZQlbE/vsI4
 7nQ077jeVMm8A24XgELj/7H21cmCgIK92gPa+QYoVIkejjKsnrrQS7eVuHLUXxLk/ZIy
 tQ/iM/fYTKqx+EtWj0zaCdaz8tRiWcuiylKYte6jYEw8hlbNOyR8CLQ7JeFYFY6SCKTk
 zlwZ//WlCB4LNoz9vzmYrOb4yAAbTrYzwjuOsfULYgfNEW2/GftrNcC9oeYZx4yqn65T
 gpfw==
X-Gm-Message-State: AOJu0YxlZXKBOZXv1NV71+JeBk4sxWxigckANVg+4rqm8oAKogDWldPm
 y8Ay/IStvLj6S1C6rdG/zwtjRWUF929G+UbfyvQxfMC4buow
X-Google-Smtp-Source: AGHT+IEO9uU+6W9roXmL4gr8bHbNKnFt4AXr+fAMO0Pxoi20H2/Q47YSlI5TL+Dc5afuhpRO6ZuPFm3X9GJTseHzumY=
X-Received: by 2002:ad4:5cab:0:b0:67a:b1f1:9c57 with SMTP id
 q11-20020ad45cab000000b0067ab1f19c57mr17815479qvh.26.1703770638088; Thu, 28
 Dec 2023 05:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20231227082405.2202246-1-sjg@chromium.org>
 <20231227132156.GQ2652760@bill-the-cat>
In-Reply-To: <20231227132156.GQ2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:07 +0000
Message-ID: <CAFLszThBrAVSH2jYxhxFSETqr4za+BqjZBBjLaDokc1ZdrXXRw@mail.gmail.com>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 =?UTF-8?Q?Andreas_Bie=C3=9Fmann?= <andreas@biessmann.org>, 
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>, 
 Minkyu Kang <mk7.kang@samsung.com>, Scott McNutt <smcnutt@psyent.com>, 
 Thomas Chou <thomas@wytron.com.tw>
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

Hi Tom,

On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Glass wrote:
>
> > U-Boot builds devicetree binaries from its source tree. As part of the
> > Kconfig conversion, the Makefiles were updated to align with how this
> > is done in Linux: a single target for each SoC is used to build all the
> > .dtb files for that SoC.
> >
> > Since then, the Makefiles have devolved in some cases, resulting in
> > lots of target-specific build rules. Also Linux has moved to using
> > subdirectories for each vendor.
> >
> > Recent work aims to allow U-Boot to directly use devicetree files from
> > Linux. This would be easier if the directory structure were the same.
> > Another recent discussion involved dropping the build rules altogether.
> >
> > This series makes a start at cleaning up some of the build rules, to
> > reduce the amount of code and make it easier to add new boards for the
> > same SoC.
> >
> > One issue is that the ARCH_xxx Kconfig options between U-Boot and Linux
> > are not always the same. Given the large number of SoCs and boards
> > supported by U-Boot, it would be useful to align these where possible.
>
> I don't know why we should start with this now, and further not being on
> top of Sumit's series to remove our duplicate dts files. And that's
> where we can have the conversation about for which cases it even makes
> sense to build all of the dts files for a given SoC.

This is a completely different series - there are no conflicts with
Sumit's series so it can be applied before or after it.

My goal here is to clean up our build rules, rather than just throwing
them all away, for reasons we have discussed previously. I filed [1]
to track that.

Regards,
Simon

[1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/15
