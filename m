Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B16C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 08:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AFEF8212F;
	Fri,  9 May 2025 10:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IRK60vGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7318806D8; Fri,  9 May 2025 10:01:42 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E099F8283E
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 10:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5fbfdf7d353so2372782a12.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746777700; x=1747382500; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OvKKjj7REexYcAru0oi/34BOYSDHPpu48wPY8e1wtwQ=;
 b=IRK60vGCYqfuCi9P3Lbd4b51euVkjv1KDqfkL1qtOtosfE3aHIsZ4dB9i9KTdNetd/
 pokb8wXJrWAUv3mknkbl+lTayywJ7Iz5WjK+h7injFtrAsJolFOS1rHynDzTjLXb1PpJ
 XQqj1giKbi4cxq0Usjho0aYbH5b8HaChbQvhxFK67JJT4GJmy1g2nxoi4zxEjHko5Np/
 zWCOg5W4eplSLgZzxBZL7v5IBt5ia5FHZ1+AJnEw8vZV0GYO9MpeZDU2pR5JcTt5itp6
 THkt9Ubw/r0u2L7AiZonxXj+2qvdKx9iD8leSDWSaY2f67TaMOnlQNlXIRv4Dnu8G4s7
 wxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746777700; x=1747382500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OvKKjj7REexYcAru0oi/34BOYSDHPpu48wPY8e1wtwQ=;
 b=KlE7AuhMRduSjoxhVtbWeflc09s37xSkGqKkQYRQmC5KuFEcHLDSVGsblfnKvq+UuK
 tuH+wDP035I7X9hAokBEO4mV4ea03Rc9SuaJ6uoObjKBAH5WSsxpdFIGjow8UaPlRaG/
 Lb3QxTXoj9RXoXOyuwN6mvx8NH2xw+AsKm4pWmsOSrJCbkshEJF+3oTjWzSf3a9aq4iv
 USOfxaaN289p6CYDK06qkP1/6z8/0pHJjRKUAqbrdat76e7kpeuWq7W9iRv1b2hE+A4N
 MYUUHFil4TaxTjUzZV874IUKSGKlefePXZuZh4EDasOvJY8p2JekXOwkM992HsQgmZHJ
 SqFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLZaSopToEcnuiypc0TluC2/OzByRrBxz6eAOLzsk78be4wKsG6nRSFHWVIfFrgS+/H4jjJmo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5okkfSadeF7Oa87Fd0hBQ9/+QqQg6m2Rd9e1LCxRCjwBXEYvk
 GFP/uHz2eS4884du6zDO640Mbh65Gtb4dZ2ldOKFzlL4gk6FGjabL1rOmuU+Hpc+omEHNoTJYTp
 xh+Zz8JXm1th1hr1Hi0e510eKoW0=
X-Gm-Gg: ASbGncsjP/1Val5vFElszc9ekFqYeVPpRUZJe/g9CP2hIBxUnSpncZ8YJFroSdnb/A1
 ARjMzAMiAXUnJraYKrmR0pa+HYjXP7nM9w1MOKo9EYTVF0wdI9unq5NA0znntLMLAigw/fXr9hh
 JGOMZghl6fbxQoGTmNeu4=
X-Google-Smtp-Source: AGHT+IG2ooyDLhyn7mlehr56CLKn+5eleiSBtoKgIMzx+BU+mf7Zf7x4TGC+U3neRcdRtjmwH/JsU/8eAslN2teJK0M=
X-Received: by 2002:a17:907:a4ca:b0:ad2:e08:ea00 with SMTP id
 a640c23a62f3a-ad218ea4581mr228337566b.9.1746777700217; Fri, 09 May 2025
 01:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-3-linux.amoon@gmail.com>
 <5c3f5474-5b5e-4e73-baf7-b211c482badc@linaro.org>
In-Reply-To: <5c3f5474-5b5e-4e73-baf7-b211c482badc@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 9 May 2025 13:31:24 +0530
X-Gm-Features: ATxdqUFEfQNmoSMowzLbybd0Y0sOjHo3nlzlCzInA1TAnVlCPDoz18pOrAFitcs
Message-ID: <CANAwSgTCkO_5iezh8KQ=gYPTALfXbXNSuC4nY9=o-76n4CepNQ@mail.gmail.com>
Subject: Re: [RFC v1 2/7] configs: odorid-c2: Enable Onboard HUB driver
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>, 
 Wayne Schroeder <raz@chewies.net>
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

Hi Neil,

On Fri, 9 May 2025 at 13:26, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> s/odorid-c2/odroid-c2/ in the subject
>
Oops, I will fix this in the next version.
> On 09/05/2025 09:02, Anand Moon wrote:
> > Enable the onboard USB HUB driver to power the
> > USB_HUB_GL852G-OHG on the Odroid C2.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >   configs/odroid-c2_defconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> > index bcaab46f8bc..f8a66a923c9 100644
> > --- a/configs/odroid-c2_defconfig
> > +++ b/configs/odroid-c2_defconfig
> > @@ -59,6 +59,7 @@ CONFIG_SYSINFO_SMBIOS=y
> >   CONFIG_USB=y
> >   CONFIG_USB_DWC2=y
> >   CONFIG_USB_KEYBOARD=y
> > +CONFIG_USB_ONBOARD_HUB=y
> >   CONFIG_VIDEO=y
> >   # CONFIG_VIDEO_BPP8 is not set
> >   # CONFIG_VIDEO_BPP16 is not set
>
> With that fixed:
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks
-Anand
