Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E09D711B4
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 696F28933E;
	Wed, 20 Nov 2024 16:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PJyATu6A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF8CB89348; Wed, 20 Nov 2024 16:37:45 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E34087042
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e79f73aaeso1815045b3a.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732117062; x=1732721862; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5uidUdmQiMP3tO9L91LmykUXJgIQym+KV3jeXnclG0E=;
 b=PJyATu6AaCCVvOKSLPfnfh/meGCsYEJ/TtLyuhirgnRni6tnGahalqFyddzCZM61Z+
 TwX46njNPYLkwWAm+TZ/LdoclX/CAu/uaq7FA74gxKZuvCPCo1sjBbSb2OUhAYUwvRTX
 JDTRjim+Xekf5Sdlexer/jyyWVv7UqU73Qe8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732117062; x=1732721862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5uidUdmQiMP3tO9L91LmykUXJgIQym+KV3jeXnclG0E=;
 b=qYa+eLsxDxbF+TcfwqtAk6WDQKS/TDL3J3XKzfmxKTvG/rwQosi2j/3cRwaloeieLw
 dhZULkgz3Q+ZxCfqO0FmmvecK0pMmf8apwjqjCK3KcrhzyLYJA3u0Pp6dSrLAv6Om2tI
 RpJoNw9NiUuokH1WLlnnw6sNaH43kXfJ6ssK+di+9kFbiBcXd3sHH7AnBxNxiueQ8uBe
 rhVWsiPqGgifYW61TFObrQdVcDX1A+unLH0MgZ7gCa51SyaqW4OrUGWex3VjuIMzDygG
 OAi7WQKgQjiiDpg6zNLsVyWibLGyNQMAJ8gpotDRTjmkcR+SEotz4HJSmq55YbiRjWMO
 TuEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURmcBDmZJqoY5ObtH9LgxpWI6CC9yUcRkjE08BYz9ceWUBd4QHPmf143EXokjhkLipIVyDCzE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3CmkkkyHQU4XJxdLdLnIpgn0ZUAWNSJ0QC9lSO+pq8R08oP8y
 Q+Mzpxi6KodHZzb9E4HTsogqMdLmfh1RpiX8wMG7ag95B5Zxa7F41IeyuJRh14MOF4qos+sTh7f
 a40ACa/+rNAH9CEd5E40DQ745FZVhcO5ix1c4
X-Gm-Gg: ASbGncvDW71m5iUMyBYMsgatHOrxGhM+y9oH00xQodZnMftScU02/meW6KhBoELRmUB
 jU2CAqsMofMfnrUBXoRtdv8RrrNv/uwc=
X-Google-Smtp-Source: AGHT+IHBv2WkYm/aalcbMzl4hN1YtA0mf93vLRPgTCVH14qKn+66m0G1O4bcKbdcgac2fKPBVyg3jb5k82kh7iL7WPM=
X-Received: by 2002:a05:6a00:4f86:b0:724:5c66:ecbd with SMTP id
 d2e1a72fcca58-724bed8e59dmr4265891b3a.23.1732117061953; Wed, 20 Nov 2024
 07:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20241028124815.47262-1-sjg@chromium.org>
 <20241028124815.47262-11-sjg@chromium.org>
 <A00AAF0F-5E6B-4DE3-B18A-DD564026D3A8@gmx.de>
 <CAFLszTj9EhCKkxjBotx-CvuKjuV2T7C6CyJTpHB59nerLavKjA@mail.gmail.com>
 <00941595-FD52-44B3-B618-CCC43F7342CB@gmx.de>
 <20241031223757.GI3600562@bill-the-cat>
In-Reply-To: <20241031223757.GI3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 08:37:25 -0700
Message-ID: <CAFLszTi5rWx-hc5FnzWqq4oz-6oPdqKLYf8SwrfUq_ATBVi_XA@mail.gmail.com>
Subject: Re: [PATCH 10/15] efi_loader: Add support for logging EFI calls
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
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

Hi Tom,

On Thu, 31 Oct 2024 at 16:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 31, 2024 at 11:30:58PM +0100, Heinrich Schuchardt wrote:
> >
> >
> > Am 31. Oktober 2024 19:01:47 MEZ schrieb Simon Glass <sjg@chromium.org>:
> > >Hi Heinrich,
> > >
> > >On Tue, 29 Oct 2024 at 23:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>
> > >>
> > >>
> > >> Am 28. Oktober 2024 13:48:01 MEZ schrieb Simon Glass <sjg@chromium.org>:
> > >> >The current logging system suffers from some disadvantages, mainly that
> > >> >it writes its output to the console and cannot be easily reviewed.
> > >> >
> > >> >Add a dedicated log, storing records in a binary format and including
> > >> >the result codes and any return values from each call. The log is built
> > >> >sequentially in memory and can be reviewed after any EFI operation. It
> > >> >could potentially be written to media for later review, but that is not
> > >> >implemented so far.
> > >>
> > >> An EFI specific solution is not a good approach as it does not scale to other parts of the code.  Please, implement a log driver to collect the messages that you are interested in.
> > >>
> > >
> > >I can do that too, but it isn't as easy to programmatically parse. I'd
> > >like to track what calls are made and understand better what is going
> > >on when Ubuntu boots, etc.
> >
> > What makes calls to log_debug hard to parse? We have __FILE__, __LINE__, __func__, and message text available as individual fields.
> >
> > What information are you missing?
> >
> > For tracking function calls we already have a trace capability in U-Boot.
>
> Integrating EFI_LOADER with existing U-Boot logging / tracing
> infrastructure sounds like a reasonable path forward to me.

Yes, we already have that. I replied to Ilias' response elsewhere.

Regards,
Simon
