Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF39BC4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 22:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ACE08784B;
	Mon,  1 Jan 2024 23:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P+XHwE3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A8687834; Mon,  1 Jan 2024 23:41:42 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F220386FF4
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 23:41:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-680b8d50403so5092006d6.2
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 14:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704148899; x=1704753699; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mYlGOt6MD9GdNTJmklto55Yjofu07hpx9akWPPureGg=;
 b=P+XHwE3ZPxJhtOIlwDt+8o4TfRfLYpu3Lo3K7MqvC4fRh0xE6Qu0CXf1P5P2KrmrE/
 aSovS4WPeWsnOx++sMNeUx/dPsp1bWVtxYgHb3+x6t6MOH6guVmSnMoHz0Ii4nh5lVsY
 EvC6beMv2V4iLpoDQ+luufXdaKhSHST/fPLBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704148899; x=1704753699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mYlGOt6MD9GdNTJmklto55Yjofu07hpx9akWPPureGg=;
 b=po31j3CuED7lTEM7QOuEdCQbTS3RdF9NvblksjGp+RlTvEmb8F0vpcDqykY3Q03Fty
 NSKUZZJ+50TIlVQEylDIqzB/MdidoLXOMYMKbcw5zGoxCZFDGaOjtMomGZw4QwbhSCgH
 bvaqJZSGQ/rFLuutfzfmscW8/G9tebN+bhYFLZMjet5j0Zs3A6Ebe6WgBPrJntr3zq4E
 4xk7A31W4MFm1T7sUeq8pT++J4NcMZL/FlH/858W56PUp2J49uCcpf22XKDVUG4K4HLq
 WIXJ+0I21mRyIWqfnReNZNHoRvUDCx3ZA4uQNqn0Lh7/dxoOAQ0er9la5txiWR+P2gko
 ObGA==
X-Gm-Message-State: AOJu0YxerRnMR7C5OaU0WxfDfmgmorip/0HcMGk3d5cRkfuDA79Iu1aw
 nDpCCBH2zBr6LkFp5Rfexjwge2hFMz/8nfchUWfr9L0JRykC3Lz+3jjFo54=
X-Google-Smtp-Source: AGHT+IHaZzQaS3Y4g2r1fOHxJIYOckY6yGYps6jMO+mL1C/dAGLV7/zwrFtwCF48Yb1lbNNvQcJkPav5B+5gbIxzIKk=
X-Received: by 2002:a0c:f9c6:0:b0:67f:b7db:dd7 with SMTP id
 j6-20020a0cf9c6000000b0067fb7db0dd7mr18128354qvo.123.1704148898864; Mon, 01
 Jan 2024 14:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20240101185004.268790-1-heinrich.schuchardt@canonical.com>
 <20240101185004.268790-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240101185004.268790-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jan 2024 15:41:28 -0700
Message-ID: <CAFLszTjusHyPFPRh4DXv0JJ7i4s6mgWsEkyFBDiiGytXPHHqEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] smbios: smbios.h should not import ofnode.h
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Mon, Jan 1, 2024 at 11:50=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The smbios.h include does not use any definitions from ofnode.h.
> So don't include it.
>
> As DECLARE_GLOBAL_DATA_PTR is no longer defined via dm/of.h we need to
> add it to efi_smbios.c.
>
> Add now missing includes to smbios-parser.c.
>
> Remove a superfluous check comparing the sizes of the SMBIOS 2.1 and SMBI=
OS
> 3.0 anchors.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  include/smbios.h            | 6 +-----
>  lib/efi_loader/efi_smbios.c | 3 +++
>  lib/smbios-parser.c         | 3 +++
>  3 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
