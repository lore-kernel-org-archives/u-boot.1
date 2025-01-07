Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B536E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 03:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DBD380600;
	Tue,  7 Jan 2025 04:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ou0qBWzs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE76680601; Tue,  7 Jan 2025 04:50:40 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C522805F5
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 04:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aae81f4fdc4so2547163466b.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 19:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736221836; x=1736826636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W0y0n4HrD5IHeym6nQpjK8OHQ01rHpE+APyB6nDDqpg=;
 b=Ou0qBWzsBiE2GLbED029EXUlWL61H8KF0/m3RQyGTV0vcYYn2wU9kDQNMjoq+CTEUR
 XGCp9vgtdphlHS8S5evDxkr8OXhlPsZhZ8K2QJ3CY2UYXtfmfCTv+nVwx1Cqlqx5R+2S
 +5aMA8TnpkCf7jVJsd+l1kcbi2iha9dhmz7vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736221836; x=1736826636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W0y0n4HrD5IHeym6nQpjK8OHQ01rHpE+APyB6nDDqpg=;
 b=MBcyH8F+ZRn/FqcQkPMdfbYx6NchYZXcJz+E6Bqtz+BiEuUnRxG8yp37mhKnPEKq0B
 7PokQOTBMVpVzJ7eC/YSx+Hu2mRZU32Pgmzow7M/ImYvPp9cRUvlMTfrX8aissp0UM2B
 kz1dAu0XTFsqoC9EzSjtO9gv0RvbYDjdJouE71epJRVjfPjy0Rmm/U2E1j/rGNK1uLOG
 eznrj6vxSjC1huI61ChyNR+N0ZcypV1Xxa9IEWXLAAI5BGnYj2HtR1cXJKI2EEQOEI6+
 4fwri1Phnza3DXc/nnVFXlZw1NJJh1DB1Fc1AeWVXLTyj/ItmZ1Y/pYQCR9ljEnTVYwb
 8e6A==
X-Gm-Message-State: AOJu0YwSKVvIuEGDOf8566jNHA55XrGMz9b+S1IiQug2/UHaI6E5744o
 LwS7eSEJhGLWBqrpl2uSV9F8oba6TIgsx3onWdcUWgMonGXinf6k1vhkl8QBu27oWQSfKwgI2ak
 EQURYhYZptKu9mtGBV3DWjvYUGoLqWqCc3Kzu
X-Gm-Gg: ASbGncum2viNf3CLi8U3cW+qg4kq/msVLUUZ+HScgd1VyQuWo7PE0r42axLVipt442S
 qKt66mFDHP5RhZ+X72iNxfq3lCJ5IKPJQAkiO4AU=
X-Google-Smtp-Source: AGHT+IEWaSCuRV7URAyw6clRp7U+51hfKDvpgcO0v0Lxvm2C/7nFsIl4fM2u4UdVzLHpd3j87q5swod5ddbKfyE6wy4=
X-Received: by 2002:a17:907:9804:b0:aaf:123a:f303 with SMTP id
 a640c23a62f3a-aaf123af418mr4165306466b.55.1736221835880; Mon, 06 Jan 2025
 19:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
 <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
In-Reply-To: <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Jan 2025 20:50:23 -0700
X-Gm-Features: AbW1kvbAPdzRsej490xoM53n4aIKbhPvEckRKlosd1osNggupMrEXz5mWo6sDXo
Message-ID: <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Brian Ruley <brian.ruley@gehealthcare.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On Mon, 6 Jan 2025 at 13:51, Marek Vasut <marex@denx.de> wrote:
>
> On 1/6/25 3:38 PM, Simon Glass wrote:
>
> [...]
>
> > I wonder if the cst needs to be updated (binman tool -f cst)? At
> > present it is using apt-get and has:
> >
> > $ dpkg -l imx-code-signing-tool
> > Desired=Unknown/Install/Remove/Purge/Hold
> > | Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
> > |/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
> > ||/ Name                  Version             Architecture Description
> > +++-=====================-===================-============-===================================
> > ii  imx-code-signing-tool 3.3.1+dfsg-2ubuntu1 amd64        code
> > signing tool for i.MX platform
> Perhaps. Can you suggest a fix ?
>
> I am also unsure how to get the CST test to 100%.
>
> I still don't fully understand what exactly are these tests testing or
> whether they are even valid.

Well, if I could run the test and have it pass (like presumably you
do) then I could suggest something. Could you point me to a cst binary
which works for you and makes your tests pass?

Regards,
Simon
