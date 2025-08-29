Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB6FCA0FF7
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 10:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E44F835EA;
	Fri, 29 Aug 2025 12:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZwD7TG0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B1C9835FE; Fri, 29 Aug 2025 12:19:18 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7997183542
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 12:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-afe84202bc2so276534366b.2
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756462756; x=1757067556; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1OL71Qx5RGbgwNuz97CMQEbF33prK8TJug9SHG8/ZD0=;
 b=ZwD7TG0zsy/pWXfqbyUF4tNIBQngxSo0ozPVjdikeLINpF8UMOs+AuEsrGjQNQo5HC
 tH21BPszhu1jqbyWlJfgeVYvvMo9XKYDYg17ssRIXa38s4Ted4ysLbaAPLUT5PTorTCH
 gxOpjeA88opjYQmKkFAAvrSH5CgPPw5eULytdduFBWWcHVGCH1gvhP26/MVdio3sVLHS
 9l/A93nHhxke1Uy88hx8BkmIYXLa0EGRXki1NeNuj4vLA58Snrsf+Y2G/K1V8gUhKKxu
 eMsQXtwnTUvZJ98hfJggqXr6c4xixmDPZr1ckhY1h5fPo0h4W256SitsvrVHMgkOTr/+
 6amw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756462756; x=1757067556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1OL71Qx5RGbgwNuz97CMQEbF33prK8TJug9SHG8/ZD0=;
 b=vYVpdwWqsO/8dFVBvoEaAcNLA7uGKWr+bCe3DFPWDcNy17KQfmdpi2yA3JpUfQtI6V
 TfKjyHbDsdYeYguhWh60VRjHbvOfqwpJ5ryti4fokYAX6HY3j8FdRIFgi3t8OdEpeQIz
 uzNv1R/vGp6vKcQCgNtjKd2kux+oZkenFXfYN82IfBUaIt+1yqmsI/+jYMV+HzB0iD4T
 0LMhsE+hQTr+MX4deFcp+F8Qt25JWVs3BLD+3HfzoRTP0QD0gnavnn2Ofwlf4D5V/KEF
 lGlCWiRfarY8f+Yurh/enOxc/fuyeu7MLLmbTnIsHXbYuBZnhHq5HAPSi/nDo2G5aDiK
 X2qw==
X-Gm-Message-State: AOJu0YwXB5koV+kM57CqPjxjrVwYczyDMOQhUyXEaWKQwb2qLQ6SD48s
 KnoYeJ83Jx7zaBb3w9+vl2FOV3FCE032LGIfMPSA/5hvq1l+HUxZyxqg4I2QWvdbClRw9VLKGXe
 ocl3IcaJT5bZGgSbuP/P6wmL3dKSD6PW1FhHt
X-Gm-Gg: ASbGnctWb2v2OvXaS/TMobK3ecmwBNe3lqOdJrdwczXJa9uuzqql/5wfDaL9hgTUaHO
 izzPmSCl0LcNqz5Zyfhp6ksa+kt2Lnzl2jQ3BRF3iMS/bbUJVzJDviKZUQ3L5ZHkbQuPUk78wkX
 oN0cEWZzbqredVqWzNoJkGBBD3k1IrZhnwrH0zJXVpV8Jm2oRW+6Hy1aafRBTiN1INH6Z4L1MTy
 FljCUsaYg2M1g56lY7mNQt3Ys9jGjCTKQMkLNz6m7bjug==
X-Google-Smtp-Source: AGHT+IFkbZ5NAQI2BNueHYGzG1CHrBfFDsAKdIVptv4oM12Eq+5+wc+igVlIGB4o6LfEc6d2SvyFjGLFR8G7FmyTF9g=
X-Received: by 2002:a05:6402:40ca:b0:61c:8fe9:9423 with SMTP id
 4fb4d7f45d1cf-61c8fe998e1mr11092206a12.17.1756462755745; Fri, 29 Aug 2025
 03:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <CALeDE9M1gvJ1Z=vNr345V35QjgfGU_Q2Wki5dMF-zAqY-ko=BQ@mail.gmail.com>
 <f5074534-b565-460d-9943-6493174db3f9@epam.com>
 <1b82498b-73e0-4793-a320-b49828273fc7@munisense.com>
In-Reply-To: <1b82498b-73e0-4793-a320-b49828273fc7@munisense.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 29 Aug 2025 11:19:04 +0100
X-Gm-Features: Ac12FXzitxnkH3vvRR8LkJWgClmnyggQot7wEmYMueTysKgaACGkaLCuboGN1lc
Message-ID: <CALeDE9Oks9P+ZGRUYOvEUg-1DD0OvsRsPYmNbakWUar2LVbN=A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
To: Gijs Peskens <gijs.peskens@munisense.com>
Cc: u-boot@lists.denx.de
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

On Fri, 29 Aug 2025 at 11:10, Gijs Peskens <gijs.peskens@munisense.com> wrote:
>
> On 20-02-2025 09:54, Oleksii Moisieiev wrote:
> > Hi Peter,
> >
> > On 19/02/2025 21:37, Peter Robinson wrote:
> >> Hi Oleksii,
> >>
> >> I've started to look at this.
> >>
> >> On Wed, 5 Feb 2025 at 10:15, Oleksii Moisieiev
> >> <Oleksii_Moisieiev@epam.com> wrote:
> >>
> >>      This patch series provides generic support for Raspberry PI 5 in
> >>      U-Boot with additional hardware drivers.
> >>      The following features were implemented:
> >>      1) add generic board config for Raspberry PI5 including device-tree
> >>      files;
> >>
> >>
> >> We already have basic support for the RPi5 since Jan last year, you
> >> can see the patches [1]. This serious should build on that rather than
> >> add new duplicated bits. It supports basic serial and mSD support.
> > Thanks mentioning. I will do full rebase after upstreaming of the
> > dt-bindings to the Linux Kernel.
> >
> > Oleksii
> Thanks Oleksii!
>
> With RP1 (seemingly) coming for 6.17 does this mean we can start testing
> a V2 in he near(ish) future?

It will be at least 6.18, but there's no reason patches can't come in,
also they can be broken down into smaller series, thinks like reset
and pcie can land before the rest.
