Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D84CA0EEB
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 01:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 689F280422;
	Fri, 22 Aug 2025 03:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ca3xB+cG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2EF080548; Fri, 22 Aug 2025 03:55:07 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D30418006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 03:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-61c212c3986so164967a12.0
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 18:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755827705; x=1756432505; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3A0cMpX3qhboTPlEGgSUfVlAoD+mb/CB4ZMtc9Rhzw=;
 b=ca3xB+cGyDFEKulRABkT9McrAmlOZKH07kIBRHf+f9xBZUAdwW7VpQJjl6ofszpl+1
 +3cuIdmjCDiOFc3Q5emcrdRiUWmvJd/Y2DtVZVcCn7cD4rnDjlmshAlWnSUdV6KGnASw
 b60ns1hz/rF/cRh/oPye3WgmJRqcrcoDhOiw/0wxcvDHFEjs2x/vtIkok2udC59pevBH
 B+oO66bUl2acrWOcBU1lY9/+csiszklI6/YkqxizuZPEwPDXRdSMrxXMmtT/H4VUyIRO
 dv89+70fl7cf1zLfNfX02rHFcEUgddxD7IfAAIME7fcS013BigK7Iaf1MRzHlid/5TYe
 6mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755827705; x=1756432505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G3A0cMpX3qhboTPlEGgSUfVlAoD+mb/CB4ZMtc9Rhzw=;
 b=kx18eNBbWHI/rfPPVop1mqr7LiFfvt0jLWOMpY6m1dYvdNTRxjMK6H5wZBm1W872bw
 pHromcDChrU6JebJ2VhHPQDmonFb6vU05JViPN3B472Pv5n0Bm4wNI81mt+ZiB4nMU5L
 8HdqptV11hLfOTaksiyOMtC9oZlUT7hnzBOroZ8l7cDIKC+42DboO1d17YkER6hI8l6z
 gpDBnXvTb/OCHLgUnkX5jVKK5FRoK+voR1FXf96JByoxz3gx+0+JN4vl0ptjIdoKr17y
 kS1iSjUVGH3WSqhzIuocBmclS1lcOSpHVngXSdMwTnDX+6qDKVLcurGpxF4Aj/s3IoA5
 P+jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKmhBs9gfhIkQzV8WvoTZoz8YcLhaF1vjiiJ5C+0sspzaKRVxITRasz1Gj0tjbTiRHf69xSNk=@lists.denx.de
X-Gm-Message-State: AOJu0YzWy/KgPeQaN5CvzvV7uATzycj/SxdlAj0eTFPEWWbS7qtfsgwo
 dDqQYhjNXn4mwNbwu+IU9NIzcPOb5G0rnJfYiRWCJEG8O+eKRSbrIz5NNVpoChEN0oDDNfnKFdZ
 hrvY64PYxhgl9zkCgqHroWUo1SeK/Qk4=
X-Gm-Gg: ASbGncvtc7e9uhP/9ZlOik/tzmyH4/71C13xzbi8M+Oi2WOiE2fnMGhfTx/AwO8F5Gv
 B11kMzQkOG8Nlkf0PbmyuR1V7R2jq+FL14zPxaFUsnWJqy+smisKTdADSncXWVBhR3w6BGB+w1z
 LtRnfoUBIYvW3dnUyPsppqAjxeu5CG1hJm5dsHmRi3HxwpQkXaQGiIiv/BNHHFPZ9115fAPqveq
 b6EiRnp
X-Google-Smtp-Source: AGHT+IGCN2BMpSSFkS+2q9HXksB7rTeOIQ7d522zfTlkhaoyweWEpuuEqlIx3Gm/cN0yxfvzU6vzpISZpA/YGgAzGLw=
X-Received: by 2002:aa7:d3d0:0:b0:615:223:e8ae with SMTP id
 4fb4d7f45d1cf-61bf990aacdmr2705606a12.15.1755827704554; Thu, 21 Aug 2025
 18:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250728-a38x_ddr-v1-1-4102aa87697c@linaro.org>
 <fc2eb511-430e-406a-a9fc-b47e6eb9812f@mailbox.org>
 <0d13343e-654a-417f-9f99-e33a5bc36301@mailbox.org>
 <CAJaLiFyNmTQQr-bN_aj4bPCL-4Zb+rakQ7RGiGfvkFupKG3fvA@mail.gmail.com>
 <20250821235456.GN124814@bill-the-cat>
In-Reply-To: <20250821235456.GN124814@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 21 Aug 2025 18:54:52 -0700
X-Gm-Features: Ac12FXycFhPw9wYNq7muAjiRmyF8r_0d4GCMLvjyct2SzARWaA7xT8lz_wi9Xwc
Message-ID: <CAJaLiFx_jpLstnU6ScsXdYtvuXzzx0dea5B9eos4skcKXmFN1w@mail.gmail.com>
Subject: Re: [PATCH] ddr: marvell: a38x: Fix unsigned issues
To: Tom Rini <trini@konsulko.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
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

On Thu, Aug 21, 2025 at 4:55=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Aug 21, 2025 at 04:43:29PM -0700, Tony Dinh wrote:
>
> > Hi Tom and Stefan,
> >
> > It looks like we have some problem with ./scripts/get_maintainer.pl. I
> > was the author for the Marvell A38x DDR4 port (Commit 54a08c4), but
> > curiously I did not receive patch email from Andrew. So I ran the
> > script,
>
> To explain, there's a time-limit on how far git history is considered,
> and so your last change to the file in question pushed you off of the
> list of recipients. To answer a possible follow-up question from you,
> I've gotten complaints from contributors previously about being cc'd on
> patches for something they did a long time ago. The answer is that you
> need an entry in the MAINTAINERS file somewhere to match on a given file
> patterns to always be considered for a patch. I *think* MAINTAINERS
> files in drivers/ would work with get_maintainers.pl and we just don't
> have any yet.

Thanks for the explanation! I was not aware of that time-limit at all.

All the best,
Tony

>
> --
> Tom
