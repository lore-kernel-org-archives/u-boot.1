Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8DFC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8822F8842E;
	Thu,  6 Jun 2024 14:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XPXuH/UB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD44B8823C; Thu,  6 Jun 2024 10:52:11 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D19A688027
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-354dfe54738so610102f8f.3
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 01:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717663929; x=1718268729; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RRygEFq22WrwEaEKzKWX4GoodOltnbMGIs7eBW1bjUk=;
 b=XPXuH/UBDvfgXqC9ICIzNgL/DSIaNXduyQRGa/Rjda3PFel+Gg8DaJnKDOrT3mPKa2
 T8dPdlFhk/iK5OCcUTlRqZVzTT9dwPpUuejHq1G+uqP+nqtNEXRJM1DHMgKOFXOjAlRm
 FmuwFlefpcwrM3iCJ2jRXwHxJ8fjwBHnSLvdTBk1qk/OuoCuGeu0f7ZGWLXuVTzjXiz4
 BbGfIdfs7mH6JV4g5mlCa8panv/eiNuhaNSWbEFlLJP9Rbo87jYmQqBLHY/W3C3otFO/
 IgdWzyOqhTf8Bt3SN8Ko5Wrx9+xxQdYmWBHaxyf1wqM4aP1aN53tnYGAi61GY2xGgvvD
 UW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717663929; x=1718268729;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RRygEFq22WrwEaEKzKWX4GoodOltnbMGIs7eBW1bjUk=;
 b=uWqk28BOb0e0UNsOUfB8FdatPpfyoUZmcfoSCi12hnCUegvKCgsW4j3Hj6zz7Rp2Me
 J/ahFrdyrIy8OVLmuUTmK7c0DT+IiI2DCMEVDhdY8qamy38VfGji4WYs5gHBsNxOiFTz
 Bii6cNI5buzT5a8PZFCKrKl3CDNP+FiXJxsrNgLgC632pbc7v8Qxt3vkBvZWUOVd1DF7
 HfGMuVcatGyysdhDJPcaY4Axx6oWHvcQrRjbHMJBdQ9JrVCy0nY0cdHgy4AHTb+oTsXp
 vQOW4ydlFkQcYdWGwMh+cGeGQsesMKehQAgZZxXaLSfDkWwBzWC7kkE0zq2tI1sjBnEH
 FD2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3uVGHGY3oON0wX7yKCFBLOYSTsEJ4HZlxCISda3Ym/j25NXoBnjp76zzAxZ4nmuh19MJ4fcqHqOpvWUnFRMYDH7DGiQ==
X-Gm-Message-State: AOJu0YwEtsaGTX7FOMdHY8SSAPrje/xWhd+KqFS44XBmE1we/XMJ8ieO
 lGphJvXehfIqv0+JNHeWCn0CRbtYnwzvtQB5105T6rLSv9lUfAQds8djoQ==
X-Google-Smtp-Source: AGHT+IFohfS4LZ4nYjCk8aHAQL2asyyexU354P1DR4o48gD44Y1BXUxKHulJNr5g2awHaDciv2lVGg==
X-Received: by 2002:ac2:55a6:0:b0:51e:41a1:4d5 with SMTP id
 2adb3069b0e04-52bab4b84d2mr2471692e87.9.1717663467345; 
 Thu, 06 Jun 2024 01:44:27 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52bb41ee01fsm133165e87.69.2024.06.06.01.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 01:44:26 -0700 (PDT)
Message-ID: <666176ea.190a0220.1a2d40.0d8b@mx.google.com>
X-Google-Original-Message-ID: <ZmF25GBgIJ-7CZ6D@Ansuel-XPS.>
Date: Thu, 6 Jun 2024 10:44:20 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Dmitry Dunaev <dunaev@tecon.ru>, Devarsh Thakkar <devarsht@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eugene Uriev <eugeneuriev@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Shiji Yang <yangshiji66@outlook.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>,
 William Zhang <william.zhang@broadcom.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Pratyush Yadav <p.yadav@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 5/7] tftp: implement support for LED status activity
References: <20240605192146.19052-1-ansuelsmth@gmail.com>
 <20240605192146.19052-6-ansuelsmth@gmail.com>
 <CALeDE9Pa8362N_HBKk6Z1Rjn+nTa_pQky8Cur-ABB9NpySwULw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALeDE9Pa8362N_HBKk6Z1Rjn+nTa_pQky8Cur-ABB9NpySwULw@mail.gmail.com>
X-Mailman-Approved-At: Thu, 06 Jun 2024 14:31:15 +0200
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

On Thu, Jun 06, 2024 at 09:22:05AM +0100, Peter Robinson wrote:
> On Wed, 5 Jun 2024 at 20:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Implement support for LED status activity. If the feature is enabled,
> > make the defined ACTIVITY LED to signal traffic.
> 
> Would this not just duplicate the activity on the NIC LED?
>

Yes but most of the time Vendor doesn't ship NIC port with LED attached
or even some PHY require additional setup to make the NIC LED blink on
traffic.

-- 
	Ansuel
