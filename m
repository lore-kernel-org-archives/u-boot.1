Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB4EC28B20
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 01:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19FF81D3B;
	Mon, 31 Mar 2025 03:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZdVZsLXj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568F581E5A; Mon, 31 Mar 2025 03:18:47 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B29B2812BC
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 03:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e5cd420781so7824932a12.2
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 18:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743383924; x=1743988724; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Prl7IzYcZOyK88vp8c1Yz5q6cab5sBtRMU/Lpe+2DgQ=;
 b=ZdVZsLXjCzY4mnY7m203xPytQTEGLlIDCKcBY7MPb5kjK23YZr03QhgCVKyl18fFwW
 iQH69b1tnpkg5Ua5QIC2B2mTMLtxCbTSm7/HYM2ORra0OcIGSiN5UdbbusuIfXVrJBK4
 PehOjCxeHWk0Mfm7MnluBtd6DTtdrXWW7rlro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743383924; x=1743988724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Prl7IzYcZOyK88vp8c1Yz5q6cab5sBtRMU/Lpe+2DgQ=;
 b=LDXwIvWohoNjoBBsumbYV/gdIqPUBqA19wJKIBlhhHmsW1Xdm2gg8CkAPyJ/uNTmL0
 ueOLUAWin/9FF76aPKoBKmPLrskd51Gei6OswatYKLbAw6gzZ8/DlpMPUuSZ1bNHStdD
 9EYBOZiKBtamJofqZM0aMQru+fEUk4QhyTpbNbZp8kuxsiKC6KWe3TO0Gd2htQYjvEzF
 ZZAntBdNnETlsUztpcqihHADJy8HF1bi0Z5crsfBn+ZqcZ53aphIAKBOfm8wmGMBPkM5
 jN6Gl5LmPEcKCoY/HzYf/POMVACo7wFp8xzjedl1GPNu3NQ8AtEaGnyFCdhY9tDVdO3U
 gO0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp8UHIFWANT3WREOZSvTAoihipxDEEVTFWEKrBRdIgzzuhNsG0G5sIHLqsq47pIjT6SbQl7GU=@lists.denx.de
X-Gm-Message-State: AOJu0YxgEN2VsufQwKHzD8fFJYgMYBEyfhMUz2JWzwX1QD6aLa+u2ruf
 ycQdls9OJbDQ44vf3tgkCMLGyvVDYpqjz3X5H9E6lHCVkWZ4ccFSakoD9EwoTVvlrc2P5iUBQ4f
 5UIGkX2xc2s8YufhJcBhXrVO+u5i4gzdqgEnk
X-Gm-Gg: ASbGncuMtd+CwqBg78TAe2ZMzqDjArr3DjckoSrWDAVpBW3ZVbA2xOAAEz2s760abCy
 qwVeVdBjIpt0eTycMe06jAG3FYtffqjubH1HhJ7B/rKeI7ABJmierhEhTxHmeqY+Bjo7sAneZhN
 bopfmuINMwW9dcVtXJh4EkQLLpUl9d
X-Google-Smtp-Source: AGHT+IGwB4Xg0GXZ7QpAjAR4E/LR8wm4/PszqflJQpCwI/0uBWh5fe2QVezzHo8OcSUi0Gzf9bJzb0yOYqcQ29HYrDc=
X-Received: by 2002:a17:907:9719:b0:ac3:8516:9cf2 with SMTP id
 a640c23a62f3a-ac738c27ec7mr642038266b.55.1743383924021; Sun, 30 Mar 2025
 18:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
 <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
 <CAFLszTjcdFKn2ayTrLx930b+P5ebBfX_EE8-aS8sOJTBsqQKHQ@mail.gmail.com>
 <8647abd3-9378-42cf-a1fa-302c7891d439@denx.de>
 <CAFLszTiw01KB4ipwqi1b64A4MP3SyU=zFRymV4moiJ_nBtnHRw@mail.gmail.com>
 <a05cf63b-820d-4b27-8f66-37a6e6c7b372@denx.de>
 <CAFLszTgF+g2OXz=L=r7rOQcNkk19GfdCrwixG8ZAsR=1rh9Fqw@mail.gmail.com>
 <f1e4014e-658b-4a47-af8d-72ef76c1b134@denx.de>
 <CAOMZO5B7cxEftN0TeTF--pKXqOmbmaFLc9mEPO4=8odrLBeypQ@mail.gmail.com>
 <f71762e5-ba15-43ec-91a3-dbdc8f8e1437@denx.de>
 <CAFLszTj69OUZj9ZBcmnsiLLvxCB+Y-rJYEW_Ep8V6WFtvXP2Nw@mail.gmail.com>
 <5bec35cc-99b9-468e-bc01-1de5dc39825c@denx.de>
 <CAFLszTh3weO+4bFuaRGR9-1zMU57R+Xcn2UVOMY9=JAtpfZgnA@mail.gmail.com>
 <0f4fcc93-9b9d-4fff-8110-70ac3f8bacd9@denx.de>
In-Reply-To: <0f4fcc93-9b9d-4fff-8110-70ac3f8bacd9@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 31 Mar 2025 01:18:32 +0000
X-Gm-Features: AQ5f1Jp9GN7zDZyrm4dlQrG1MH-12cHiYFzwd6L-nzrFN8GX8i2yTfbet4PMqQw
Message-ID: <CAFLszTjuR6kcvPQqQcuJFCKBW1obJn8J=+bJRbV0kbWoM3V9HQ@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Brian Ruley <brian.ruley@gehealthcare.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>
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

On Mon, 31 Mar 2025 at 11:11, Marek Vasut <marex@denx.de> wrote:
>
> On 3/28/25 12:42 PM, Simon Glass wrote:
> > Hi Marek,
>
> Hello Simon,
>
> >>>>> This patch causes a CI error:
> >>>>>
> >>>>> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1057151
> >>>>
> >>>> I think this might be what Simon was pointing out, but I never got any
> >>>> suggestion how to solve that.
> >>>
> >>> There was a patch for this...and it looks like Tom has applied it:
> >>>
> >>> 19a342f9122 Merge patch series "binman: build_from_git: Add argument
> >>> specifying branch"
> >> It is in u-boot/next , but it does not seem to help ?
> >
> > Did you figure it out?
>
> No
>
> > I'm not really sure. It works fine in my tree and I just tested it
> > now. Perhaps there are some other patches missing from Tom's tree?
> Can you push this tree somewhere ?

Yes it is at https://sjg.u-boot.org/u-boot/u-boot

Regards,
Simon
