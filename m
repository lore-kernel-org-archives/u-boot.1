Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902B8C3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 19:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4180871CF;
	Fri,  5 Jan 2024 20:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="S2nK4jfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417048787B; Fri,  5 Jan 2024 20:12:18 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8283787254
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 20:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a28bd9ca247so199194366b.1
 for <u-boot@lists.denx.de>; Fri, 05 Jan 2024 11:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704481934; x=1705086734;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3X8yNZ9RcC+2Vpm/XMhWOlvG0Hr/meatcxW5AOY6NLw=;
 b=S2nK4jfHXcy0ZJPhpuKOscy6pWWhkR/x3v4v4bzbBMxEjfbnGDEUHPaT/VVW+fxyY0
 tHL0USQaOq42DnKaF3lLXy8cXlqEsHW53Q/CTU/LmfKSycKQ4LwGbi9Is/egVwwut1QF
 tJUu5lEYy8yW67NLQ58TegHtm2acXvgTjUe3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704481934; x=1705086734;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3X8yNZ9RcC+2Vpm/XMhWOlvG0Hr/meatcxW5AOY6NLw=;
 b=UoGIR/YMGoeFGC21J4dl7mVla3tfvvLbGewjCVolkvwev61zAK8FjtkiAYFwxeAgm6
 I5G/aAiLHbW3u9S5PSv712NbUFXVFOY+b2rpfjPC7wgfG7+7UzGaqgzJ8VXjcz139nyF
 yR7wmQAEVRbnrfB/b6pYf6arA3sIMjn9DHi4u9bm7W51abkLGhLO2mNssOFzeRQBIaEf
 xHE/eUiNvLokGYmTe9e2ukH/Am9TMHbBKNGVYmiAPM211D/bJ7xCF+zfsGfMjEAKuw4R
 PCgZBTgBjZSeuzpbLAbojv3GHlgx7ua00F9si9yZWJzMGaD83Qm0AuplpPLTin7MH9H2
 Ha4A==
X-Gm-Message-State: AOJu0YwmRoU0KPgdFTvVjoT9ddXA5ZaXUFETAmP0W67TdkvCQeGGczv/
 jFyODsrjFP0nnmLUAxc8r1q5J91wsMUvj1P43FoJ/BeMse2srA==
X-Google-Smtp-Source: AGHT+IHGGR1ZpPihou8FRjF4vgyVWbrubIlKq3ro3/kkH0buA8w+e3WhV1FL5H7HdJmyoXbDbopcM1vvSFlaje+rQCg=
X-Received: by 2002:a17:907:50a3:b0:a28:31aa:5879 with SMTP id
 fv35-20020a17090750a300b00a2831aa5879mr1108132ejc.96.1704481933895; Fri, 05
 Jan 2024 11:12:13 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
 <CAOMZO5C+Pvv429sHPyKuznyvdPv217q=a8uTeNNTSyVmn1EoXw@mail.gmail.com>
 <20231109001746.GX6601@bill-the-cat>
 <CAOMZO5DtKc72Zv+Q6J3P6JY8jWVbu7KDbr-AViw1hPcm0N92QQ@mail.gmail.com>
 <CAOMZO5C0ZR=DgXkGHyG-Fgt9HEr3Z_x4qhgkfmObBpTTXUmpAQ@mail.gmail.com>
 <CALG-KHx081qs+_LHTSu7ssAOd0AX-N64OPht8M8nGufU778SbQ@mail.gmail.com>
 <CAOMZO5C4qF4A8uLdRfMeDVosA2NLNU=+WvidGR7QGeSyYJOTmw@mail.gmail.com>
 <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
In-Reply-To: <CALG-KHwHxdd_7wz6L+6VDGS04LggyqhTZUoqgV+euSqPn9D2KQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 5 Jan 2024 20:12:00 +0100
Message-ID: <CAOf5uwmDZ5DtAhe-GauhuyYwSSXQnavVNfzaJkdSG3TWE1N2FA@mail.gmail.com>
Subject: Re: inconsistent wget behavior
To: Paul Liu <paul.liu@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Tim Harvey <tharvey@gateworks.com>, Marek Vasut <marex@denx.de>,
 u-boot <u-boot@lists.denx.de>, 
 Duncan Hare <DuncanCHare@yahoo.com>, Simon Glass <sjg@chromium.org>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michal Simek <michal.simek@xilinx.com>, Ramon Fried <rfried.dev@gmail.com>
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

Hi

On Fri, Jan 5, 2024 at 7:57=E2=80=AFPM Paul Liu <paul.liu@linaro.org> wrote=
:
>
> Hi Fabio,
>
> I tried to investigate this by U-boot sandbox. But it seems to me that I
> cannot reproduce this issue.
> I put a file on localhost apache server and tried to download it from
> localhost.
> I might need a more persistent way to reproduce this bug.
>

Can you reproduce with dcache off?

Where are the patches to test?

Michael
