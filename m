Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EF4E67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 01:40:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F5F890D5;
	Sun,  3 Nov 2024 02:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KxbRCFyf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28BA8901D; Sat,  2 Nov 2024 20:52:25 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EF848901D
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43158625112so25509455e9.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730577143; x=1731181943; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=H5BRaRy7+8se/96g/+njulZxtfLV5c0KdYnAC48O1CQ=;
 b=KxbRCFyfVGZ0SYGSUStuvq5M4kwNdTkOZnpuWgIJz6Q0JKFz01DelWTE1ejUvOBoRD
 HC5r+ktyY+u0Y7F37gQVXz4CXPgIH/4cN21DeEE/dnkDunBSciE1HJdggyCkscRv42PY
 vlp8C59mi3aHL5OGldadh1g2G0MestxhQ0eJTHfo0oBbqcJ9etv+0PXSNbcz9POpkaoq
 +79So1FrjbSlywL/KGqRdCyGrSW/thpzU28teKhPZUkkt/V6TF9UBc53t6NBFDBBb74p
 j2LqA1C5Ac0RHuCF1Q98TwzL/2SEKZGIT6mMvilCQ9fIjfbDqau9pUqkJNrsy1ljFtKh
 QVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730577143; x=1731181943;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5BRaRy7+8se/96g/+njulZxtfLV5c0KdYnAC48O1CQ=;
 b=Fc7bpM5F3/Ba0T9at+oowDRGxsTwnPEw5H4+mInudK6b8kqUKQd0mbE2R3xkg6GFu6
 k1u0hmIam/bFj6yLtcZz7Bt55Ss38QDrYeXVSwu8nLc5hbTW9XGaem0YIS5SafB8yTDh
 xmPwi5rBwTmr602aZ8FK7WnrQYUXL9yGcRjEEjvqqIf8xj3yz0+/9jGufrF3izy/bkrn
 8p60hL/ZFuQUDgAyvYEQGPKadcKw0CMtfY7DMgN54o+9FeliyZQd7qzXcnLfzLr+NHYu
 P9TTV2D1ixih8YSaPQzt/HY6lKFMXHepbnIUrXFjc0dcod4yLwXbodjTr/6ssRDwHuAK
 7QxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/ikIZo3+/rwkJ2Zu5esCS3DSLsXm19Ymicirb/W2Z1B8AtgxLXx7aUbcsFEUIVVhRHWXVB50=@lists.denx.de
X-Gm-Message-State: AOJu0Yzmkc9iUeEGA1eokdUwX4Hp8By3s8jik6XKBWVuE2hg006yPDLW
 xbe20fJIwTkr3Tc4u/aDgaWw6UktPszVmZVYUeBd8JMwjVzlPMBq
X-Google-Smtp-Source: AGHT+IHuyjq2AVLMdxjaqp0KP/h1eKi9wMIcpr1mWHxNzCF/CO/EkmZizi3tNWK+fadWBAFCfT1tuA==
X-Received: by 2002:a5d:6d0e:0:b0:37c:cc60:2c63 with SMTP id
 ffacd0b85a97d-381c7a3a23dmr6480995f8f.5.1730577142826; 
 Sat, 02 Nov 2024 12:52:22 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e856sm8786128f8f.87.2024.11.02.12.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:52:21 -0700 (PDT)
Message-ID: <672682f5.050a0220.361a4b.7e2b@mx.google.com>
X-Google-Original-Message-ID: <ZyaC7wd2qGrLSsDW@Ansuel-XPS.>
Date: Sat, 2 Nov 2024 20:52:15 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v5 03/11] led: implement LED boot API
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-4-ansuelsmth@gmail.com>
 <CAFLszTjB4OV-k65rhqJ9pBTmKUnnWthbDJ2Vk3eRxzBgmMeOOg@mail.gmail.com>
 <CAFLszTh9WYnya=8YXXFEcSuVUYuhCGy-+iYFRucgMZq+-1H5UQ@mail.gmail.com>
 <67267f36.df0a0220.87602.7b89@mx.google.com>
 <CAFLszTgP5r56eCTGuG4fbga7Wj8iU97dQZmcvw4ze0UBOhRj1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgP5r56eCTGuG4fbga7Wj8iU97dQZmcvw4ze0UBOhRj1g@mail.gmail.com>
X-Mailman-Approved-At: Sun, 03 Nov 2024 02:40:26 +0100
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

On Sat, Nov 02, 2024 at 01:50:13PM -0600, Simon Glass wrote:
> Hi Christian,
> 
> On Sat, 2 Nov 2024 at 13:36, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Sat, Nov 02, 2024 at 01:33:10PM -0600, Simon Glass wrote:
> > > Hi Christian,
> > >
> > > On Wed, 2 Oct 2024 at 16:55, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > >
> > > > > Implement LED boot API to signal correct boot of the system.
> > > > >
> > > > > led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> > > > > designated boot LED.
> > > > >
> > > > > New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> > > > > This makes use of the /options/u-boot property "boot-led" to the
> > > > > define the boot LED.
> > > > > It's also introduced a new /options/u-boot property "boot-led-period"
> > > > > to define the default period when the LED is set to blink mode.
> > > >
> > > > BTW could you please send a schema update for this so that Linux accepts it?
> > >
> > > I'm just checking that you did this?
> > >
> >
> > Yep [0]. Also tagged Rob 2 hours ago. (eh the coincidence)
> >
> > Tell me if I should send it with usual way with a dedicated mail. (any
> > hint on the mailing-list address?)
> 
> OK great! Yes, once it lands, please send a patch to bring it into U-Boot
> 
> Regards,
> Simon
> 
> > [0] https://github.com/devicetree-org/dt-schema/pull/144

I'm confused what kind of patch I should send to U-Boot? 

-- 
	Ansuel
