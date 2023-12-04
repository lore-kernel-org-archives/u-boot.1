Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13F8C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:45:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 316E08789F;
	Mon,  4 Dec 2023 01:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UIFsLbuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D1F878E9; Mon,  4 Dec 2023 01:44:45 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0825878AF
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33331e98711so2347150f8f.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701650681; x=1702255481; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gi3We5h32dPqlSuzFqtvJkm3rqyFP/DZw+c5w1QdgrM=;
 b=UIFsLbuwj6VcJKeWehu5c5VfHGeMDKbPVWWIHeqIyO7hXO8wvWm/cHxmv+TsBozsx6
 Mdq+Jpby4r1Z/5cUoHiJ3fLXNjCaHgWUGHuPYJINuZqBRgdX7JpExCvFFd5bpwsyLzQ3
 OeR6yekK5Bnl8T50/5P35d6Nzp/8s7bEFdCGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701650681; x=1702255481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gi3We5h32dPqlSuzFqtvJkm3rqyFP/DZw+c5w1QdgrM=;
 b=MjL8eMJ8B0GCfV8A1YYQ7UdgGCQfE/z4+Ozp+dQadrSk6lx1njuLekJ1OGciu+lCzS
 eafvEKtayo/WJsgWsXkLuQQbxXcnhG8kGyia1cYQn0zYCtQFHT7vNYAyoAhZjV74nnzk
 S0wHnCC7RpRmjCPklfVv43tOzpZobyGf491HMp+o/FsTBHQXWyjXTgpyz+1KWNAZbzBx
 m59fHdDBGGICVkP6MOiMUnxDMFu4qy3gc6uE3iCjOSuNGESz73q4D+BszMXT/tLKllsV
 oOMgDQ2j2G4BSzp4FiHsS9RwKWJvCxcfDCJdcQvpkksKqURkyeFg/wEXPQMYIWHM5GCF
 uL1g==
X-Gm-Message-State: AOJu0YxhY6PvJRue2El8Ofikezc0pdZFMw5HQqID5TdEGm/fgtcKe+t6
 xYqivFbn2CKBx+RJ/7b4zKhh10riLaMmGr4tvI2enTCNayBN9tT6zza8fg==
X-Google-Smtp-Source: AGHT+IEHW7xzzOCJJwadBqUCr0ARKlKYabLPB/yu6jwdJPz34UWJ2hx1gTzkutc+/sugi9kIujihfs8XxFsAY8jsypM=
X-Received: by 2002:a05:600c:19c8:b0:40b:5e4a:407b with SMTP id
 u8-20020a05600c19c800b0040b5e4a407bmr1889884wmq.155.1701650680820; Sun, 03
 Dec 2023 16:44:40 -0800 (PST)
MIME-Version: 1.0
References: <20231203044719.667116-1-sjg@chromium.org>
 <20231203044719.667116-2-sjg@chromium.org>
 <966886ca-3e37-4c31-bffd-64d7ccbba7e5@kwiboo.se>
 <20231203213247.GW2513409@bill-the-cat>
In-Reply-To: <20231203213247.GW2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Dec 2023 17:44:28 -0700
Message-ID: <CAPnjgZ0S2RZuuSGtqu6EMdogAerWpmOM65DpCN+T7jdEq8MzYA@mail.gmail.com>
Subject: Re: [u-boot-gitdm PATCH 2/2] Add some more employers
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Would it be worth be resending this as individual patches and copying
the people for each domain? Or perhaps we could have a way to
encourage people to add the details?

Regards,
Simon


On Sun, 3 Dec 2023 at 14:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 03, 2023 at 09:49:49AM +0100, Jonas Karlman wrote:
> > Hi Simon,
> >
> > On 2023-12-03 05:46, Simon Glass wrote:
> > > This looks at the top unknowns:
> > >
> > >    git log --pretty=%ae v2023.01.. |sed 's/.*@//' |sort |uniq -c |
> > >       sort -nr |
> > >    (while read count email; do
> > >        if ! grep -q $email u-boot-config/domain-map; then
> > >           echo "$count $email";
> > >        fi; done )
> > >
> > > It reduces the (Unknown) count from a third to a fifth.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  u-boot-config/domain-map | 38 ++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 38 insertions(+)
> > >
> > > diff --git a/u-boot-config/domain-map b/u-boot-config/domain-map
> > > index 63cb60f..27f1a7e 100644
> > > --- a/u-boot-config/domain-map
> > > +++ b/u-boot-config/domain-map
> >
> > [...]
> >
> > > @@ -164,10 +175,13 @@ jmicron.com           jmicron.com
> > >  jp.fujitsu.com             Fujitsu
> > >  juniper.net                Juniper Networks
> > >  katalix.com                Katalix Systems
> > > +kernel-space.org   kernelspace
> > >  keymile.com                Keymile
> > >  keyspan.com                InnoSys
> > > +kwiboo.se          Kwiboo
> >
> > kwiboo.se is my personal domain and I have no affiliation with kwiboo ltd.
> >
> > My kwiboo nickname and the kwiboo ltd company have no affiliation, the
> > name conflict is purely accidental. I started using kwiboo as a nickname
> > from around 2005, someone unrelated registered kwiboo ltd in 2007.
> >
> > All my U-Boot contributions should be affiliated with me personally and
> > should and cannot be affiliated with an employer.
>
> And this is why I prefer these updates to come as single entry changes
> and from someone involved there as well.  I will keep an eye on what the
> stats do with the subdomain on the Renesas contributions, however.
>
> --
> Tom
