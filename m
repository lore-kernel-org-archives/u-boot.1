Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0397CC27C50
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 02:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BDE58826E;
	Wed,  5 Jun 2024 04:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lGt6kOo0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15EB7882E0; Wed,  5 Jun 2024 04:13:46 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D0187AD2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 04:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-628c1f09f5cso60151427b3.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 19:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717553623; x=1718158423; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=to8fdmfIcdSbnSpgDylSgzj5a3Vw9ypWhYqxsbiACHU=;
 b=lGt6kOo01fkChexC0d7ySs+Qnu8zIqEQEgYGB+lGB6c2H1GRyL1cN6ZPPT4wTijfJH
 UkNcXC/hj42z1w/EUPZ+8/KvzhET/U7exCsFAjw3YVmfwNiE5IonyGnGQLY5uTpWFcu9
 4J1GdV0r/t8ChcHFV4VcHpEVvecjF+9ojah+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717553623; x=1718158423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=to8fdmfIcdSbnSpgDylSgzj5a3Vw9ypWhYqxsbiACHU=;
 b=tGdeWsjUWBM9lNEoat+BYLanX94qw2PPr5qLjHIwmpA7GFN14jhMFjyCeEpbdm6ZEC
 G6IiZi25hx5LKorXV8CTHwRjXErEL+68I+Mi1Tsw5S62hQsaZ36GCV/N9wD6R7X3xDIp
 Dv/RiLyN0q/Jo9LyGZyonBXPD+91C4njK/9G7ULWZ6LJhxO2Yg9fcswG8NXCYmymx+Ot
 H+pVEMo30eOwiPIlLuMSjQTjai+00yNAZMZBLS9e1kd/Ijya+guBZFXvWALcriTJT6Jp
 o0LJxdAs5Fd3xe8yDToV6jK3SBVMjgK8gJrRW6ofaTu2l4LLd98CDTAnEvk23mZ04o5J
 LQEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCLf2FufjT4kRyrTaNA8Y0Qij6Lu7kqSoIaYVNQQFDxnhAhin1w9n1cZLQpnhNWsNFYDA9DrZOoehQVDHjF6iduQLLAQ==
X-Gm-Message-State: AOJu0YzLyQKdza4FdIoQNkeZ6zYXTbMCwyWjB82Qko3ER9gbBhafeJLF
 yUVMhyLM6zViaEMpLQRmHWpblcu0gPOR9U4DkuTv3T8Yul18HtVz8nFTmA6XklPgRINyz1Q7OVO
 ++JcU6vUIb56WgoJLnngXtxcSw4dVt2+7IvU0
X-Google-Smtp-Source: AGHT+IHC8Hky3Tuzw/YIEwd0M3EqMBNFluNpFwINpQVQySLDeOrMQ14Q2elPDYPQuxweVtHu5bbmFiQJawk8Y/6BY0M=
X-Received: by 2002:a25:ae86:0:b0:df4:978c:3794 with SMTP id
 3f1490d57ef6-dfacab1c579mr1222403276.1.1717553622623; Tue, 04 Jun 2024
 19:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
 <20240531-b4-dynamic-uuid-v3-6-ca4a4865db00@linaro.org>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-6-ca4a4865db00@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Jun 2024 20:13:31 -0600
Message-ID: <CAFLszTijYBJ=5Lh7TCX+1=ayY9zV529dFG_NdsKEHUMOD56-1g@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] tools: add genguid tool
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

Hi Caleb,

On Fri, 31 May 2024 at 07:50, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add a tool that can generate GUIDs that match those generated internally
> by U-Boot for capsule update fw_images.
>
> Dynamic UUIDs in U-Boot work by taking a namespace UUID and hashing it
> with the board model, compatible, and fw_image name.
>
> This tool accepts the same inputs and will produce the same GUID as
> U-Boot would at runtime.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/genguid.1   |  52 +++++++++++++++++++
>  tools/Kconfig   |   7 +++
>  tools/Makefile  |   3 ++
>  tools/genguid.c | 154 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 216 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Can I suggest you look at patman, which will provide a per-patch change list?

Regards,
SImon
