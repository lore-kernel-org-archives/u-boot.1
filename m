Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C849C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 17:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1346838C7;
	Thu, 24 Jul 2025 19:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ez5n9Unb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3FEF838CC; Thu, 24 Jul 2025 19:28:41 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1F5838C2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 19:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60c5b8ee2d9so2620006a12.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 10:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753378119; x=1753982919; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3gD9lIGwVZIqaIKjoUQdyQxi2NasEB+3AOtQv4xktR4=;
 b=Ez5n9Unb5BRv5UCaZJfsuJur1chBGqfH9vBYVecKXwaYkRd5m8BoF2yLhCJHfVNt2c
 B5NCA+GJG0S67vBG/NlsqWO94MmqC/3Q6PDfddcICN3I7Vrn3ZkMDSaKgnJbNXocKwDH
 k/tlYukDnBfPoMXIzYBlatSsgmSZrZIgnNetXTrj5CkDG4PvEmRy452nTmzUjkpGj8h3
 oqo8lFrmzUtcLgH7eezg768RBRDMsd576fNmq8Dmqh0hRDwTQPG8bpBPnXrsKUCQB5oV
 C7KFP+GiO9MM86K8MhE018mrGspfDPGqCEjVleIkwS7AMVADvrE9ZvPjX2Rq2wWXbE8V
 wtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753378119; x=1753982919;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3gD9lIGwVZIqaIKjoUQdyQxi2NasEB+3AOtQv4xktR4=;
 b=Pbx4EMHEI5vGgCR0Tu1G3Ysn0808ul/jAHiubwhySKJpfbfX2z3NQ4VFgGip+9O2bq
 yZaVFjVAhSyu9nnh/VPycCRKObnJqBykDGUbyUpQ90U/C+iNnaUoFnCGpqRTpKZE6iJU
 dOd6lPArV1HevXjdpgsfMBOtkxTauke1zjMzoA4cR1MK+OAsCmbg8Tx6e0WtjpY4sobS
 QGplp2A5gqp3zHH0eRDzKcWz8il4HOgz+tYwq35G/crBgHpZyqjRiQwlxzkT8uezrRik
 Yho/52IKthFeAu427oY6/Y3eC0dMJLoc3wi+ES/BLuu7Y1HDHUEbRMLZuKRSzl7hKyCK
 m3xA==
X-Gm-Message-State: AOJu0Yy9Ln444DTXtrGQH0Nd91rI5YjpBskWeqbexjdFc2RKYJ9DeoXb
 glp0GkYOZB4YlSC5YOPO8VSMUCdgKdmq1LT+po9h612ti0jmTld60UiLnED5TKypfYpZI0WK6+4
 WgtImRlPp/0JyeibeAkNJBn8omk8VpPVLrw==
X-Gm-Gg: ASbGncsk/780A/BdRnm6087ax7MaAdVdDhIvqUxcYtPt74JVKUah+Wu9JpoQHzLKObm
 zQNBb5d8fDwNQCt0q8uLjjyAm757FQWaiD8pf5DTD8BIBZNT71ycGOh6OSM89zQkFWqOLGKF+P/
 EMPyGPYwyq2evY7Ox2mgKoxvVah87UUW3umvKT86dvZBqw7O874NHY2gaKLjOS447pr4P34wXbc
 Zp4SMMZBAX7qzRDwPp+PVbUoy4nBzXcanOywDIWuHfg/GHcBUs=
X-Google-Smtp-Source: AGHT+IFoO918NJ2SXJb2j84tfB2KIofxCgpyQAHSYloBxoPaEHtxdwKLIKiG66TNF7vMrT1kOUU4qtI1Ee7jI8Vevlc=
X-Received: by 2002:a05:6402:4309:b0:612:e108:93fa with SMTP id
 4fb4d7f45d1cf-6149b594191mr6963269a12.16.1753378118640; Thu, 24 Jul 2025
 10:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <jwv8qkea94d.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
 <CALeDE9NDru0WLy14gFRAnk=O+hVUS7D-b1Qg3Su+96FQQ8EVBA@mail.gmail.com>
 <jwvpldpsgva.fsf-monnier+Inbox@gnu.org>
In-Reply-To: <jwvpldpsgva.fsf-monnier+Inbox@gnu.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 24 Jul 2025 18:28:26 +0100
X-Gm-Features: Ac12FXxDn-GJ805MahqTylf3M2nSjDqRDacJdGhZwu_VOf2bDebhG4A8NAsOJyA
Message-ID: <CALeDE9Neg2HFtUC940xRfSTFwKENXH2mxdqHgoByVMaBeJ0_bg@mail.gmail.com>
Subject: Re: HDMI support for rockchip SBC
To: Stefan Monnier <monnier@iro.umontreal.ca>
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

On Thu, 24 Jul 2025 at 17:26, Stefan Monnier <monnier@iro.umontreal.ca> wrote:
>
> > Support for the rk35xx isn't upstream yet,
>
> Ah... I didn't notice any weird failure or warnings during the build so
> I naively assumed it was working.
>
> > this patch series is likely a good start:
> > https://lists.denx.de/pipermail/u-boot/2025-June/591737.html
>
> Thanks.
>
> Is there a place that tracks the state of feature-support, like

I don't believe so, Allwinner stuff tends to be purely community led,
so they have organisation, the rockchip stuff is a mix so there's no
real central location run by either rockchip or the community.
