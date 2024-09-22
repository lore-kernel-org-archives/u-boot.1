Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B0DCF9C64
	for <u-boot@archiver.kernel.org>; Sun, 22 Sep 2024 16:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 976528899C;
	Sun, 22 Sep 2024 18:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O8jo0FG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3858C8868E; Sun, 22 Sep 2024 18:15:31 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20888899C
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 18:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cb2191107so27752925e9.1
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727021728; x=1727626528; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=99hwS6c+nw9Pmu2O/2YmKs4cMqqHjcLGuFyD5u9cxTE=;
 b=O8jo0FG5lCLhtXYZkDgs1AmmGI3NEuG1lqkHUw5rXWeqwp+NMNVXDocym+U/ZNBzKG
 t0ig7TCT/jwTCC8hjH52StaF2M2n2QxEXnjkqbm3Rtel3xA0aUOckg2b2KWRZkzPxKYX
 yItVRBx7Mz+gzOVRaw3V7j1JTXJiE1sWzgYVssD3JSiMaAbKePxj93ISsD42zV3uIOTN
 UztQZUnj5G9OWLV0DbJ9RmUAii63WjbEYQddJKknjCVHWxnJsgoVxM1YMgim6+BiVTAF
 C3g3kvEbZh7zkrXMiKlPHesWLc1UISqiH3KuOUJttb0UKAsEdmhkeN+q7Nj6LDaOmsVM
 9deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727021728; x=1727626528;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:subject:cc:to:from:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=99hwS6c+nw9Pmu2O/2YmKs4cMqqHjcLGuFyD5u9cxTE=;
 b=PbdBkJfW89uxpZV5N4Fz/xEvxQ8SQwEDiKEjvkdBalyLKUcKvbxjpDU5x20c+7A+9q
 P7aYgXXI+hKoqy1WIQttdmTus1ZXc+4FilrZknDhduRFsORSHe/TsHj0Mvftlrd0uXev
 KNqy5xi+YEod1gQPMLIdj6XGke8y91slgXoUOmV/b6wQAOhwHw0Zj1PbwV6dmB5BS3D5
 p7Z+U6mdHAzFHaG6Sxywvko3qdXsg55L5jJGG3L5kvs7v/NU4E03B9lhMdCl2+axq9T4
 e8Ce84UlGgOpbDGl44HGbbEgHX00s3WzX8Np62unAl41FWsi6kU3iOxN/XQ1ls8zpf/b
 yKDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCdA4ijEF2NeSyANc1uxnQsn1MIJy2R6Kjcaq59tZcG2Ncrw7oQCtgVCAoVux/IPbA10cbO/g=@lists.denx.de
X-Gm-Message-State: AOJu0YyPVtAql7+MyXtsVbXprrLMMQOSdKW9nDRa3Jh0V+cm060oCEop
 3UkXR3soquFiC4IMsubdUOIBdTMAlO9ZSg8lNo3jW7d78Cjj7QlY
X-Google-Smtp-Source: AGHT+IHXXnNYGFuvbc5LgzDpcANAnbhDBW3CNK9VUoBb9GTp7i6PpSMwE5ImpX6vNVcxxLVlhly9Mw==
X-Received: by 2002:adf:ea46:0:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-37a43129148mr4882996f8f.5.1727021727688; 
 Sun, 22 Sep 2024 09:15:27 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73f99b0sm22398814f8f.60.2024.09.22.09.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 09:15:26 -0700 (PDT)
Message-ID: <66f0429e.5d0a0220.a85a1.824f@mx.google.com>
X-Google-Original-Message-ID: <ZvBCmg68Nz_L6WEv@Ansuel-XPS.>
Date: Sun, 22 Sep 2024 18:15:22 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v4 01/11] led: toggle LED on initial SW blink
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-2-ansuelsmth@gmail.com>
 <CAOf5uwm=tNC_avNj8U_AfxqMq3BJsSrsW=wfO4TnvjcTmA1MRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOf5uwm=tNC_avNj8U_AfxqMq3BJsSrsW=wfO4TnvjcTmA1MRQ@mail.gmail.com>
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

On Sat, Sep 21, 2024 at 01:14:36PM +0200, Michael Nazzareno Trimarchi wrote:
> Hi
> 
> On Sat, Sep 21, 2024 at 12:51 AM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > We currently init the LED OFF when SW blink is triggered when
> > on_state_change() is called. This can be problematic for very short
> > period as the ON/OFF blink might never trigger.
> >
> > Toggle the LED (ON if OFF, OFF if ON) on initial SW blink to handle this
> > corner case and better display a LED blink from the user.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >  drivers/led/led_sw_blink.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
> > index 9e36edbee47..9d9820720c6 100644
> > --- a/drivers/led/led_sw_blink.c
> > +++ b/drivers/led/led_sw_blink.c
> > @@ -103,8 +103,16 @@ bool led_sw_on_state_change(struct udevice *dev, enum led_state_t state)
> >                 return false;
> >
> >         if (state == LEDST_BLINK) {
> > +               struct led_ops *ops = led_get_ops(dev);
> > +               enum led_state_t curr_state = led_get_state(dev);
> > +
> > +               curr_state = ops->get_state(dev);
> 
> 
> The led_get_state return  curr_state. You need to use a) led_set/get
> state or them from ops
> 
> if (state == LEDST_BLINK) {
>         const struct led_ops *ops = led_get_ops(dev);
>         enum led_state_t curr_state = ops->get_state(dev);
>         enun led_state_t next_state;
> 
>         switch (curr_state) {
>         case LEDST_ON:
>                 sw_blink->state = LED_SW_BLINK_ST_OFF;
>                 next_state = LEDST_OFF;
>                break;
>         case LEDST_OFF:
>                 sw_blink->state = LED_SW_BLINK_ST_ON;
>                 next_state = LEDST_ON;
>                 break;
>         }
> 
>         ops->set_state(dev, next_state);
>         return true;
> }
>

Hi,

I'm not following how this is different than the proposed code...
Is this a suggestion to make it more readable, I'm a bit confused.

> 
> > +               /* toggle led initially */
> > +               ops->set_state(dev, curr_state == LEDST_ON ? LEDST_OFF :
> > +                              LEDST_ON);
> >                 /* start blinking on next led_sw_blink() call */
> > -               sw_blink->state = LED_SW_BLINK_ST_OFF;
> > +               sw_blink->state = curr_state == LEDST_ON ? LED_SW_BLINK_ST_OFF :
> > +                                 LED_SW_BLINK_ST_ON;
> 
> 
> >                 return true;
> >         }
> >
> > --
> > 2.45.2
> >
> 
> 
> -- 
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
> 
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com

-- 
	Ansuel
