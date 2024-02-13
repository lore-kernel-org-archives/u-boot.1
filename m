Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD961C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 17:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A8487D99;
	Tue, 13 Feb 2024 18:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFgKns56";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C1787D66; Tue, 13 Feb 2024 18:16:54 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB25987D90
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 18:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-292655cb454so429852a91.0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 09:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707844608; x=1708449408; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLl3lAf1h18bC+930qYphJRDX2mUrKR7fSnNG9cfmbQ=;
 b=YFgKns56uBOmNFBf7Lgi8wZRVkolaECpzOTpXJOAyHrVuYjpWpymwNkiHYp8gSlIJG
 yRPuXclqa2a2qwHdBSkexV61P2c1apUzWmZxsp9wG+chb5UcaZg2FuFJYetvtcGTX2AU
 2SBd6RfpPA52UzYZwKbp2Jlw6mELzWPLNavThMwo/cGEWXS0f7/Lx5Nw4Xk9006hMGj+
 Bo6ZW+DFvaJS8ZJfccSzS8RbyB07tUoiFRHJZF4LgYlLcjEQyO8hDHbyrJ0hdQ3g7bpT
 to6bUSGyMvmIHvCEdZn6BknIIR0q5kJeoWpkZ07mhz+jLhAw0O5LJFR/n+pB3pNlgZ/x
 /4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707844608; x=1708449408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLl3lAf1h18bC+930qYphJRDX2mUrKR7fSnNG9cfmbQ=;
 b=cbq0oDdBemGoFoWgOGIyJf+Pzcy5s6vrPkwrbtgIZOHxFGt2k0GMxIKvbKfO19BBc0
 KB5RLIqojSYDHcL+c017XFSbvxG8emd2N+GIgOpgHsZSn/DxCyZofE3fb1SJCKArBI6r
 0sZDRC+dP/oofOT1NDM+hDV7nkiInh+wBqtrB9g/OkNg8i18SEhrWuQa8dzhjzT8atzw
 YsTs0qpcXotulJ4tcZlAkVlGS6NoCObVeszBKMWdQVRRUf2dO8x6MzSfpD4o7RFAb0U9
 F5poTjwAAia622hKOIYybzegmQPQwV+D0t9rHg4xi6psjWCtDVYXiiDTHmaGEBOhIt5b
 myow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVReTdSShPqGs46kZW3eMawmvUtJZ4P1kvvIincrwFYSl812utj0InZRi7CLt5ky614PwONUR6ypnLH+JenWHMoLLYVrw==
X-Gm-Message-State: AOJu0YzEvcu5yTZFFwLtHBaN+jbraTF8z8XsY+OeVZJqetvVy7UlFxf4
 YzHaYqmPdIEQ5hQFYpUW4qoZJTB/XOEA7vH/oEwWdvYrF8r91TY26ifsdwp+LNix2fyoxlFxOkP
 0fOaMFpX4UczxEaDqVrDAgsFvwjhs5w7aAz0=
X-Google-Smtp-Source: AGHT+IE4b2KkmIlm54FPzTd+OC8maX1CsLvCWi+kV8SVXv5/7urcuRsP2jG4LyzmTsX8xPDFoxGQ71e4cINtfXi8yBg=
X-Received: by 2002:a17:90a:1283:b0:298:b4da:f90e with SMTP id
 g3-20020a17090a128300b00298b4daf90emr114228pja.1.1707844607957; Tue, 13 Feb
 2024 09:16:47 -0800 (PST)
MIME-Version: 1.0
References: <20240208165849.104787-1-frieder@fris.de>
 <20240208165849.104787-2-frieder@fris.de>
 <CAOMZO5C3JVhG4hfe3F6xfERJidDUt=Ow5eB+LNFx1EWp07wysw@mail.gmail.com>
 <69eca99a-e760-481d-817f-b312c71cc10b@kontron.de>
In-Reply-To: <69eca99a-e760-481d-817f-b312c71cc10b@kontron.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Feb 2024 14:16:35 -0300
Message-ID: <CAOMZO5Ca6gyU=2fEQ=EbQeqXr2JREEjHh8fTZTEcu5S8GrzZaQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] board: Add support for Sielaff i.MX6 Solo board
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Frieder Schrempf <frieder@fris.de>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Christian Hewitt <christianshewitt@gmail.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>
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

Hi Frieder,

On Tue, Feb 13, 2024 at 1:58=E2=80=AFPM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:

> I understand the reasoning and I can change that if you insist. But I'm
> not really happy about it as we already use the flash.bin as common name
> for the binary across all platforms downstream. Also in our upstream
> config for the i.MX6UL/ULL SoMs we already use this pattern (see [1]).

Ok, I just wanted to point out that there was an alternative, but if you pr=
efer
to go with the binman approach in your platforms, I am OK with that.

> > Does the 'reset' command work on this board?
>
> No, I will fix it.

Here is an example of how to fix it:
https://gitlab.com/u-boot/u-boot/-/commit/dbc4814515d37a3d1c4bb237f4e1c16d1=
f9e3736
