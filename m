Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3CEC282EC
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 02:18:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25FF3808A2;
	Fri,  7 Mar 2025 03:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SBRVLBDw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E78F80E94; Fri,  7 Mar 2025 03:18:54 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08BDF805D7
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 03:18:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5e34f4e89so584086a12.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 18:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741313930; x=1741918730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mUCUEL75lXWENzNBqSHQXGHyLA4hxd+ghx/rrbU3pvQ=;
 b=SBRVLBDwW8F7fBpjXpJNBgoxlPBH1KH5F6QXz8U7LH9rp0QQ8NDL0I5SrY5mZwKk2+
 oGIwGvMmB7gLKR5CnHKXLZ1GIak7xp2Sx0sANDgEOAgebZ48VL2Jsjq4/73Pg+1aaaQw
 fmt2KJIus0q7dqs1SsGAjtIqKILik6zsOV1ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741313930; x=1741918730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mUCUEL75lXWENzNBqSHQXGHyLA4hxd+ghx/rrbU3pvQ=;
 b=GS0FZjWOdIITzUm/JLaipovcPI+T2sZ7fwYOccLdgjtYqbonD+TMls16BvCSC4UXee
 /ZLmA/a/g9MeqPhQYNn0FajhyMWn6ax6C/gyr37p7225SuRpTvldGlDqPqa7wj6mHrdI
 lS8TJEw3wKovyemSMBG0z7LBh6OjURr/5nHEUCtKnTfgdIDSegDVts5CjN/d6wbRNgyr
 SuzsCQQ83/lu+igHD2fkKPL3Qr0CyaL1OA9BTMJPq9TyVQF88L5LT10OXEQV6tuGil48
 ZcKuLTJUztItJoIHezpZdngn7Zr7tDzP6p7iphFvt/vyZKp2ApiQN24yD3EbkEtbcT1/
 nPEA==
X-Gm-Message-State: AOJu0YzuJScrY36BPRYhcAtMrtFRLaMbjxxFSu4r1hhFZ1OXVbfWyP52
 9wY615Nkb70k67fpf92nwDwicixE+mHAIAEefosX+Ezz7VB8A8tpTCIuR7w2VvytBgDt5+plFq7
 n4NPwB2Gm577UPjKbzkfuXML+x3cglTsXMBu5
X-Gm-Gg: ASbGnctRAD+OOUajdgsQY7YS8BSNZqrGQeu+N4FmRZnrS2DuBkQY0ChLsoEFR2AyF8O
 vSD6jvauSHJun+AkH/y+HCLv5b30B9biPzgQffq2b+jU3ahyOgZ7QnU39ZyDKdzaY+Xo5Fu1IjV
 cRIWzhTJK8t9dj23kcLgGhCSKjhLQ=
X-Google-Smtp-Source: AGHT+IGQopFIGptL92Bi2R0rkDrLx8R4pBgkUMkAyK3TEYio+TAJdWWzjg+QVnFmO+JLxNbbPFn857OEsxex0vnikTo=
X-Received: by 2002:a17:906:124b:b0:ac2:591a:d1e9 with SMTP id
 a640c23a62f3a-ac2591ad9f9mr41472766b.28.1741313930186; Thu, 06 Mar 2025
 18:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20250105203714.158480-1-marex@denx.de>
 <CAFLszThQvKZfwsQudbOfDvnCMe=aeY=ppUhHKj6nV8=PtadDaA@mail.gmail.com>
 <1b77dd3f-e0f3-492b-981f-1dc9962f1732@denx.de>
 <CAFLszTha01kuuPwz0PnbuwvVqv40UDd8mrEsZBeL=z=6k0=ZDA@mail.gmail.com>
 <d9a39908-b614-438c-bfc8-34027a27db72@denx.de>
 <CAFLszTi0BQwyxOaMFCbgRAzFyBtcY__bXjAHkqZECLRJNW4-ng@mail.gmail.com>
 <ff692c58-76fd-432d-a73c-191e6e753d9a@denx.de>
 <CAFLszTgHHtNzPONVhz4ZrsZqUb2Cz+CeaaNpggYpUx93=TwdRQ@mail.gmail.com>
 <cc2896cd-eb08-4c26-b86c-a4f37ccf70b5@denx.de>
 <CAFLszTh6f8efphOYgv7wMU=z6zt0E=uiG6RK5O8hE=q1WtEhhQ@mail.gmail.com>
 <dc010565-03b3-48f6-85e8-1b79e17be14d@denx.de>
 <CAFLszTjcdFKn2ayTrLx930b+P5ebBfX_EE8-aS8sOJTBsqQKHQ@mail.gmail.com>
 <8647abd3-9378-42cf-a1fa-302c7891d439@denx.de>
 <CAFLszTiw01KB4ipwqi1b64A4MP3SyU=zFRymV4moiJ_nBtnHRw@mail.gmail.com>
 <a05cf63b-820d-4b27-8f66-37a6e6c7b372@denx.de>
In-Reply-To: <a05cf63b-820d-4b27-8f66-37a6e6c7b372@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Mar 2025 19:18:39 -0700
X-Gm-Features: AQ5f1JpDnyxAMzYUsqnYH4JCYaHUz0rPuNOUXRsigpBXxJKI9fbhmRGS-lIcId8
Message-ID: <CAFLszTgF+g2OXz=L=r7rOQcNkk19GfdCrwixG8ZAsR=1rh9Fqw@mail.gmail.com>
Subject: Re: [PATCH] binman: Fill in most of the imx8mimage and imx8mcst tests
To: Marek Vasut <marex@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Brian Ruley <brian.ruley@gehealthcare.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, 6 Mar 2025 at 17:19, Marek Vasut <marex@denx.de> wrote:
>
> On 3/7/25 12:30 AM, Simon Glass wrote:
>
> Hi,
>
> >>> One of the main goals of binman is to reduce the work needed to create
> >>> a working image. If people have to go spelunking around the Internet,
> >>> build it themselves, etc. that is not good.
> >> What you are asking me for is not the tool itself, but key material,
> >> which is generated by these scripts.
> >
> > It looks like someone has done this here:
> >
> > https://patchwork.ozlabs.org/project/uboot/list/?series=446218
> >
> > so I think we are OK now.
> >
> > I've applied that series to my tree.
> OK, does anything need to be done about this patch ?

I'm not sure, but we should apply it anyway as it is a big step forward.

I did send a series to turn on code-coverage checks:

https://patchwork.ozlabs.org/project/uboot/list/?series=446956

Regards,
Simon
