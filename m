Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DF1C36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 12:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44FB081EBB;
	Sun, 30 Mar 2025 14:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="xTpSG+/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4F69809A5; Sat, 29 Mar 2025 11:54:36 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0078059D
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 11:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30613802a6bso30606991fa.1
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743245674; x=1743850474;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3zVMr9mi4OZt8aBmnq4DYfYm44bWrX1d0vc9tHxYyxY=;
 b=xTpSG+/9PxyxhhCnamJyKXv8eURgmMC7Pa/UlnuE+fzi78lSxlfW/Zj4ewxe0q4NO6
 u8nk7iNzXh8mb6ZfJkudvdOU6+GsDQn3RzchsEW3uV+nu8c+IQAjBkHUEH86zBlXygVe
 yOIaS00ftmceFtJuMpWi1VbLt5HxNi4LuwlOFMn0NK7SIV967yZAfvrkfRAweNFop4y2
 D82WnFjmwG7PEFsM1HM3mrLtm0WkTKY5NoxDKWy/Jxr2FZxvLQp7OSKZbYNSrVxrh34h
 oVl6lepoQs/JIYDUtXycL8IxBonMA4YoRBfMvTCJ5lnQ0P3LgZAYVpeud5HWMtcpmVG5
 4OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743245674; x=1743850474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3zVMr9mi4OZt8aBmnq4DYfYm44bWrX1d0vc9tHxYyxY=;
 b=WYTkg7XdR+Ijts8Gm7gBobRB368SKve9p3wdkoIOFV8BnSWrOzkRaHH8kbFtb2gHGc
 AJQgzU+fIlC6DbNqY4YrPiVQ606F1q17Q9y99FzSEai/7JBbrZ1BdwAmcaKHTSr/mVQ5
 0hD+ttxEOuYntj0A6TUCOSXeHNqj22MpphKuTV/D7SZbHgpnxS2bYGY97o1ztaRbQP/B
 QoqZF0vaGCrZ1s5o0Qdc8PgbSat6vz1Hi70xsloQ6EBOpjOKqAwVqCW5typY31HLDXBN
 DKfd/g6A+RuYzT0Of5ljawvyInSukI4JwDCDiSwOXZ5iHOYNJks7WiR8xyWaSsKcma+4
 NklQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkxEPe06NZN65/SEljf1TJIwgr0xnr9nKGho1QdytX24X9i+0LUbnO0FkC2Knh8V22HekNA8w=@lists.denx.de
X-Gm-Message-State: AOJu0YyEPoS8zLnqPrV33UsZrRZsal5tqP/naL5RXg13zvH9bK3jBbtz
 JkNRon5JgymReyC79E7FovItbqy0gopPE+1YCCydsB4IFT6/uKM57PsSfokiOG9Ad5KK+hxcdU7
 yfBONruh9AG7X8ecoeJ2duRqfFLhEUYACJYJPdg==
X-Gm-Gg: ASbGncsi8L5nTIqH3QPFb1ykB3LJrQdkseIgNry2uIKoQIytQcMMmqfE6GDCTtcVUrF
 8F/ZH8UpsUnHiapOS64xWNS7h+gYahz7czysClw7jhcKJfc6zAUAB9PVGyZg2wv2Y52jikLpMhT
 2dSYJIAWYTIAUbX7JX3KuFEtY=
X-Google-Smtp-Source: AGHT+IFqLd0Gv1Js48RX4F5N1CDkMmjsvltPkCyhLt+VkYBDLxWG1zAS76myU8kx6IoqkkyAyxVHnYa2pgGq1O1upHU=
X-Received: by 2002:a2e:a985:0:b0:30c:dbf:519f with SMTP id
 38308e7fff4ca-30de035b033mr6773051fa.35.1743245673502; Sat, 29 Mar 2025
 03:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
 <CA+GyqeZwrAaQ_7DcvY6VgnVo0WTsMBiZsKZBmWVzQu2CAL6_xQ@mail.gmail.com>
 <87tt7c885k.fsf@baylibre.com>
In-Reply-To: <87tt7c885k.fsf@baylibre.com>
From: Zixun LI <admin@hifiphile.com>
Date: Sat, 29 Mar 2025 11:54:23 +0100
X-Gm-Features: AQ5f1JofEeLEgMpC5zEZ3aYV3vParT7DtbYGSqBLuwkE-oZUnBMPNA1_mpRBwJM
Message-ID: <CA+GyqeZSSM8dLbWei2SpswCk5pucRw=-eA5mEU1-O87q3xHj4A@mail.gmail.com>
Subject: Re: [PATCH 0/4] usb: gadget: f_mass_storage: Fix crashes on low
 memory devices
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 30 Mar 2025 14:28:18 +0200
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

On Sat, Mar 29, 2025 at 11:04=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> If you are OK with being mentioned in the commit log, could you please
> answer this email thread with the special "Tested-by:" line.
>
> Mattijs

Hi Mattijs,

Yes of course, I searched a bit for tag usage but did end up with the right
document you linked ;)

Tested-by: Zixun LI <admin@hifiphile.com> # on SAM9X60

Zixun
