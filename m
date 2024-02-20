Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7340BC48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1980287ECD;
	Tue, 20 Feb 2024 12:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vLlUYaJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 528AF87D85; Tue, 20 Feb 2024 12:16:22 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 406D987F83
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 12:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso5280833a12.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 03:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708427767; x=1709032567; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcD3opA9adJPLI1dA+sDg+tjWAj3+VSTYkVedt/eYqM=;
 b=vLlUYaJr0hfB6vboLFDY6Sd2bfLfhmHbmpgfZM01k2mk4dyHb3tengTyDPfod9Jcns
 rN9/1eOIDATT57fdZ2LMwiP6CREX6/q3IXEM82fgEAiHraSVIGAW6cmI82umgnnCJtR4
 TqVvFCBlUZGqaedJnywLiLrPxrgAm6MasVxTUsXwEG1JUpkI2UUTeslIAVM2IVSF8Hxq
 GP84SK0E+TnFw7dQtFQWIeY/EUtYOmqHkAgUeS6OxgEpvT4Pdjdq71g4nPfOD7PAC/pF
 ErJgbmqtMCKcT4m2fQVSLj1tr1gDsl+HGspWOY7baq6ANemMdYaId31yuItrp9zg4D6c
 FqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708427767; x=1709032567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcD3opA9adJPLI1dA+sDg+tjWAj3+VSTYkVedt/eYqM=;
 b=VMsnzvDsmESCCHXweIbuzuKciCvl3OslLsz7T12jMv6rmplDfuf5J3yibJqsuRA5JH
 iE6LKksgniKoQ+IuSnnpr09oAxxKPOVcpLH4Sdu6PLiZ5Sg1Yqp8OUOk3CEipybRj2ff
 CEr4VnAAmBLK+LqrkwrU265f6NJwwo5N/twGSqfHgSKZvUZbRk/mkzV5H1u6b2cG7239
 IppDajUwjNTlHWlpuRSCl03rngh5QzP94Utdo/vhAvWfJcH+FTZhL0YAsXrKtTTZZ2Kp
 5v3TB2M/7C0pv5UbNCD6SCbksvix0v/Sqq9SWhyWFi4h/moEKy7kM65q7koaebx9JAC3
 DXgg==
X-Gm-Message-State: AOJu0Yyedpd6AQneb3X2dVI26HEN+TpNHMHAZRgB52NVRpliH8qeDndx
 TXUNwmF8c4M4/VOzqlrUCcKfGPGuCUgKo4dpJ9+D0woGGINkxgJkGHUsqR4XlOLjQr6V5bKPsRS
 bCWF80Cx71x2oGnan1RemudWVcTMKyPxtAQcUfg==
X-Google-Smtp-Source: AGHT+IEFZdiUcaSnKKCsa+9bgBsQTCPSfRLUklSlYAJpdgbw2uqQ9wwAjIu/hWANN3YCjqaKKtBIFXO8zafreicDmi0=
X-Received: by 2002:aa7:db49:0:b0:564:a76b:aa55 with SMTP id
 n9-20020aa7db49000000b00564a76baa55mr1608447edt.12.1708427767514; Tue, 20 Feb
 2024 03:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
 <0ace0a3a8a94407b84ee95c34eefdafc@foss.st.com>
In-Reply-To: <0ace0a3a8a94407b84ee95c34eefdafc@foss.st.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 20 Feb 2024 16:45:56 +0530
Message-ID: <CADg8p943k217YcO5LYv8LWnCivqPD3tyOJg8EhY0hRwgtRPPLg@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] FWU: Migrate FWU metadata to version 2
To: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>, 
 Patrice CHOTARD - foss <patrice.chotard@foss.st.com>, 
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Yann GAUTIER <yann.gautier@st.com>, 
 Michal Simek <michal.simek@amd.com>, Jassi Brar <jaswinder.singh@linaro.org>
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

hi Etienne,

On Tue, 20 Feb 2024 at 15:14, Etienne CARRIERE - foss
<etienne.carriere@foss.st.com> wrote:
>
> Hello Sughosh,
>
> Sorry for this very late reply especially since I have a quite negative f=
eedback  on the proposed changes.
>
> I don't think FWU metadata version 1 should be removed from U-Boot suppor=
t.
> There are existing immutable boot agent relying on format v1, starting fr=
om the Synquacer boards based on SCP-firmware v2.11 [1] onward (at least up=
 to latest v2.13 tag) and the stm32mp1 platforms based on TF-A v2.7 [2] onw=
ard (at least up to latest tag v2.10). These platforms should be able to up=
date there EFI firmware hence needing the update agent (U-Boot) to support =
format v1.

Currently, we have two platforms which are using the feature with the
Update Agent in U-Boot, one being the ST boards, and the Synquacer
platform from Socionext. Support is going to be added to the Xilinx
boards, but they are interested in v2 only. Before I started working
on this migration, I had written to the stakeholders in early December
about their thoughts on this change. I had also written to you about
this, but since you did not respond, I took it as an implicit
acceptance for the change. Socionext had responded saying that they
are fine with the migration to v2 only support in U-Boot. You are also
aware that I am making changes in TF-A to migrate support to v2 only,
and that includes the ST boards as well. So, will it not be better to
migrate both TF-A and U-Boot to v2 only support?

Since you are proposing supporting both the versions in U-Boot, I want
to check with you if there are ST platforms in the field which have
version 1 support? If not, I think it will be cleaner to support only
v2, and use that version in both TF-A and U-Boot henceforth. I had
checked with Jose, who is the author of the spec and he had mentioned
that he does not foresee any major change in the metadata structure
henceforth. Which is another reason why it was deemed suitable to
migrate to v2 instead of supporting both versions.

>
> With the proposed series, the new format v2 contains the same information=
 the previous mdata v1 based implementation did (apart that some info where=
 built-in whereas v2 describe them from the mdata storage area).
> Could it be possible the implementation support both, using for example a=
 internal structure fed from either format v1 or v2 content read from the s=
torage, and used to update the mdata  v1 or v2 format storage layout?

This is software, so we can definitely support it. But the question is
whether we really need to support v1 as well? If the feature has not
been deployed in the field yet, I would say a clean migration is
better.

-sughosh

>
> [1] https://gitlab.arm.com/firmware/SCP-firmware/-/blob/v2.11.0/product/s=
ynquacer/include/fwu_mdata.h
> [2] https://review.trustedfirmware.org/plugins/gitiles/TF-A/trusted-firmw=
are-a/+/refs/tags/v2.7/include/drivers/fwu/fwu_metadata.h
>
> Best regards,
> Etienne
>
> > From: Sughosh Ganu <sughosh.ganu@linaro.org>
> >
> > The following patches migrate the FWU metadata access code to version
> > 2 of the structure. This is based on the structure definition as
> > defined in the latest rev of the FWU Multi Bank Update specification
> > [1].
> >
> > Since the version 1 of the structure has currently been adopted on a
> > couple of platforms, it was decided to have a clean migration of the
> > metadata to version 2 only, instead of supporting both the versions of
> > the structure. Also, based on consultations with the main author of
> > the specification, it is expected that any further changes in the
> > structure would be minor tweaks, and not be significant. Hence a
> > migration to version 2.
> >
> > Similar migration is also being done in TF-A, including migrating the
> > ST platform port to support version 2 of the metadata structure [2].
> >
> > @Michal, I tested the metadata for the two image per bank case, and it
> > works fine on the ST board. Kindly test this on your board as well.
> >
> > @Kojima-san, Please help in testing the version 2 on your
> > board. Thanks.
> >
> >
> > [1] - https://developer.arm.com/documentation/den0118/latest/
> > [2] - https://review.trustedfirmware.org/q/topic:%22topics/fwu_metadata=
_v2_migration%22
> >
> > Changes since V1:
> >
> > * Do not define flexible array members inside the structures.
> > * Access the image information related fields in the metadata using
> >   the helper functions defined in an earlier patch.
> > * Access fwu_fw_store_desc structure using pointer arithmetic.
> >
> > (snip)
