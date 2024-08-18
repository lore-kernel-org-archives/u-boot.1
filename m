Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458EFC52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 16:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D7CD88928;
	Sun, 18 Aug 2024 18:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kqOzpRMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A61EB88950; Sun, 18 Aug 2024 18:21:28 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B78DB8886A
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 18:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3719398eafcso1604208f8f.1
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723998086; x=1724602886; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=j61/A7yYNy1CIrTkemdntxRqLdF4F8XjhAG9QsE1Dxs=;
 b=kqOzpRMw2lj/m5QFLnu11khIHRGc8ENRPvZMGl3s5axwcuKuPKgjDx1uvBRrgX6OBO
 7+c/k6/V6Fjp1ilNY3y8cuPFf7/QfgBtQnLuMVPlBlh11rm7e1gRsttP5SU7JGhvl2lR
 GrmyagOEEo1nuLhobitU6A2UgfI8JHaNbywLXDYeeYvfy+6f7HyipZzj83dFItFMuCSo
 Vest81k89I6D49oGdSIkLd/uW0D+rOtedL/dzWdzpuGpVnyiCJgg2SnAemu5wKKNIa6u
 YOx/Jnm7LCDa7DOFAkOBFGy3bjcfk1XszntF08cEByZxAExVwOoyWjem1aAEzpCQ63jY
 iLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723998086; x=1724602886;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j61/A7yYNy1CIrTkemdntxRqLdF4F8XjhAG9QsE1Dxs=;
 b=LxlPkuEQtjSTtm/NT0+Uw/uojepxKNAn2wv5cDHu6bmqJ+TEuz09+ygurN/JrbXORZ
 GxN3jP2gSBqkyjcAUzLMsIq8n5c0b8WJYgbT+IieEdJPHrfbUUh72uJWlI/WVqf8p8zB
 G+YfEj/aMzMnKIyhWKYPwcNt0dNcgmIUDf/ZRgJoWLEG0i8KjlKn1mdZ0d5zL9WUnIdo
 ruCtkf9Bdp28wCD7b0dxDKH5d6acMxAJNWpO6npIBLfGpHtUNInJd5Nfc9t4/pIvCptz
 CmZWZzTKs6pzm7/CwxsFEzsJEuH8s6/i3cGL4K3HxnCVvuon2LUGm8fCIf7cyPo+MJwZ
 ICCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSrVPCPc/i0UdcLFAQeu3uQxt6CJN7QdOvFzJTGcsYltQw93McTey2oRCg3Ks0GYOlhDYtypb8aPzZfJpTK2T5OdlhlA==
X-Gm-Message-State: AOJu0YyuM4nvYph9WiiiYOBhyUsXObxRlZzhp+kzi5PDcubQxYzLZp9L
 2RQWqHOg4n1olKq62JGy/UjxGQ5yS1Vy06ZV/gj0soShb4wQfhuu
X-Google-Smtp-Source: AGHT+IELI2dfVSeu4BFThsuVCSUdz6jTP4qzpD5ZOPMdgWmSmJ/1u6lV38+68rnF3owYFen4ej1WkA==
X-Received: by 2002:a5d:56c8:0:b0:368:8007:e26c with SMTP id
 ffacd0b85a97d-37194651096mr5058601f8f.29.1723998085686; 
 Sun, 18 Aug 2024 09:21:25 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-47-255-50.retail.telecomitalia.it.
 [79.47.255.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898aa496sm8350134f8f.89.2024.08.18.09.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Aug 2024 09:21:25 -0700 (PDT)
Message-ID: <66c21f85.5d0a0220.234a1d.799a@mx.google.com>
X-Google-Original-Message-ID: <ZsIaNykO-cQuZrFN@Ansuel-XPS.>
Date: Sun, 18 Aug 2024 17:58:47 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Heiko Schocher <hs@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 8/9] ubi: implement support for LED activity
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-9-ansuelsmth@gmail.com>
 <32d0b8ed-3986-3011-a0a8-e4640ee10ff1@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d0b8ed-3986-3011-a0a8-e4640ee10ff1@denx.de>
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

On Wed, Aug 14, 2024 at 06:33:12AM +0200, Heiko Schocher wrote:
> Hello Christian,
> 
> On 12.08.24 12:32, Christian Marangi wrote:
> > Implement support for LED activity. If the feature is enabled,
> > make the defined ACTIVITY LED to signal ubi write operation.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   cmd/ubi.c | 17 +++++++++++++++--
> >   1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > index 0e62e449327..6f679eae9c3 100644
> > --- a/cmd/ubi.c
> > +++ b/cmd/ubi.c
> > @@ -14,6 +14,7 @@
> >   #include <command.h>
> >   #include <env.h>
> >   #include <exports.h>
> > +#include <led.h>
> >   #include <malloc.h>
> >   #include <memalign.h>
> >   #include <mtd.h>
> > @@ -488,10 +489,22 @@ exit:
> >   int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size)
> >   {
> > +	int ret;
> > +
> > +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> > +	led_activity_blink();
> > +#endif
> 
> Do we really need ifdef? May it is possible to declare an empty function
> when CONFIG_LED_ACTIVITY_ENABLE is not set? May this applies for the whole
> series?
>

Yes can be done.

> > +
> >   	if (!offset)
> > -		return ubi_volume_begin_write(volume, buf, size, size);
> > +		ret = ubi_volume_begin_write(volume, buf, size, size);
> > +	else
> > +		ret = ubi_volume_offset_write(volume, buf, offset, size);
> > -	return ubi_volume_offset_write(volume, buf, offset, size);
> > +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> > +	led_activity_off();
> > +#endif
> > +
> > +	return ret;
> >   }
> >   int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
> > 
> 
> bye,
> Heiko
> -- 
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

-- 
	Ansuel
