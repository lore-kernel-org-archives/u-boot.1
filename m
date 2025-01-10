Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8393BE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 11:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAAF6801F5;
	Fri, 10 Jan 2025 12:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gVWEYK6E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 771F88036B; Fri, 10 Jan 2025 12:03:03 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA153800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 12:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53e3778bffdso2039163e87.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 03:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736506980; x=1737111780; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rhBqZm4UlysgCgYA9a2sNIr1YDgJZSjSnqHDWc9yzOY=;
 b=gVWEYK6E/GF3F+bF44bZqUy6MbO4/HpNmkX81QyDfZxMEUnEAV9D1NQMoG6d85pgiW
 YQBpKBBqKGcGxgUlxmIWHZXobCol5QWEfYqqFTPSDY9gjN+lf7jRTxYg6CCSp1q6w6/u
 emYyzBqcLr357q3Op4kkwrghGHRPh3JN1OoDJPxRJW4LM/ipZx9lvSJRTKfBaSVzbVFB
 0qiGgDAY2diXHLKNnXTDhuk/6OiVjwmHUZMVpxS66WeNghwbijC2r7frnS7pjMdO9CFU
 AAs/cInUXL08RBm04QcmuaugegK4tPFrZJsmwLPGGVIhtGhQJH3qxxezVXJnqIQNn9na
 acIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736506980; x=1737111780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rhBqZm4UlysgCgYA9a2sNIr1YDgJZSjSnqHDWc9yzOY=;
 b=C1uE7sTjnbrUITjIobTj9sDOclni6ph0WhTdZ4kYEICQfGIQgWY3jjHPVAk2+7gWZO
 ejS18nuPdG5tsKotOlLyvnHQfdkqG/XdoQvv7vc5gQ04dUBUCW+QEKLBNaSYGzyPr6Cn
 jIiVIzXwre6ANmDaDX4I5UrNjDqgCOwTXGPmJGyUxID2XSKsOR3EYVDYotwPYwM9gU3C
 9Ro3HUDNYQDsSSQECLLan5tFOT61bcch5tRF3yQSLJGXM7GnF0timvDSrf33pUgtbRS2
 8hW3qsQSzqSivlpWglCPhdZj6yYglCh+zAwR0ecbebU7kJOsKmFRN5JOJ9wq7pKN1wiV
 pjAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi3MoE1D/Hxc4YTmXwYOlvkGTOS7Qxov5kWJ2O+I3Cjjvw3MkFqvPmzdkC3rDp4kNXSqlfC4M=@lists.denx.de
X-Gm-Message-State: AOJu0YxoDisv9VhV4Q0Xo5qXCChQg+NVWbkKcoQCQWCkCw8iEUPttC8L
 YJbKbtSZdP3es+jiORu/gHVocbEd7Xd9utPfqrXLsZDnun805V+HMxH+hGcCK8/BRGvXFACjteX
 P2pHQm/XqAvAx+D92vY5UOGJbZ9Q=
X-Gm-Gg: ASbGnct5nJbVMKViwQ+AgvkKVqExDaWLxDw6TB1d9NU0hA1+fnYAQUqy+u5M3d3KF0E
 T6hrHoX/ol8oxPcpsTKnhr9x+cKyNTowooOWn9Tob+brx58InKD757pN0iNh7Y9GN0iQ3uw==
X-Google-Smtp-Source: AGHT+IGq4EMGmJgi1X149VMyxOtU8t40oIU8LqcIjuEQD1qmzVC8evIlXczV3uegm6tKZsc9+E2Zx9kaUjHII0HFrMQ=
X-Received: by 2002:a05:6512:398b:b0:542:29ec:d338 with SMTP id
 2adb3069b0e04-542845b0a94mr3025241e87.39.1736506979877; Fri, 10 Jan 2025
 03:02:59 -0800 (PST)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
 <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
 <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
In-Reply-To: <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 10 Jan 2025 08:02:48 -0300
X-Gm-Features: AbW1kvYKGNCmSH2v2ofRVVUjEE_wPFVdQbJsMuURa6ZbyXu_F3qnKDB0_M78NKY
Message-ID: <CAOMZO5DmOw=QUeYCfSfm=URZHZh94rsvB7_cSGwBSNxcAUFvvA@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 Brian Ruley <brian.ruley@gehealthcare.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Thu, Jan 9, 2025 at 11:21=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:

> I was able to build it from source code without docker. Is there a
> public source-code repo somewhere, so Binman could build it?

Yes, there is:

https://gitlab.apertis.org/pkg/imx-code-signing-tool/-/tree/debian/3.4.0+df=
sg-2?ref_type=3Dtags
