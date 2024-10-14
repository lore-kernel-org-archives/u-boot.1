Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E16DD1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 19:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8462689082;
	Mon, 14 Oct 2024 21:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R6Di/TcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ACF689082; Mon, 14 Oct 2024 21:18:03 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BC2188FDC
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:18:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3e5c9295f3aso874320b6e.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728933480; x=1729538280; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=814NmXplBKw8kTF3c1P1ram8029c8Aon9ilqBDUep1A=;
 b=R6Di/TcNzVr2riFL9DsUQo+of5F4abBklMNdGSbEH87P6n30CCSDiSTDndgXsOuYBF
 RpxuCIqIEi761tK6eISMyB/t6QKXZ1ZTJR6yJiMrnTBFDM9EawPValJN1fm4hzoVXPlm
 USp6SYANSefr911H0CQKSpl5MdccOySVtpq6U81hdDGZAYe1+SP1rrwPleBa02AVQPcH
 8R/8Do1sYZiPBzceexG8Fb7pJHF6VJJl1ZlFEGL+7OsySIt235xuaBS6hIHcXlGInVC9
 EupGI9l1P6N7VPs21oHxcAwhDwHcjGPIiF7NYigwS2qb2N9dbFqbtiEWvAT+zV3NzdS/
 2n7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728933480; x=1729538280;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=814NmXplBKw8kTF3c1P1ram8029c8Aon9ilqBDUep1A=;
 b=YSGtAq+ney7SgZSuyz4Eq0dTKpUkG4uWY3vXB+QiBPoKvnLYvTQmVr/fYW5OVbHJ8X
 Rbk+oh/Fhh6P5MGFsrbVBX3qnP+gVmtlghCgVBJdx2n/lRwEjUWdS9NxVa6WAYZJoLco
 MCDl4VejKG0TFw099IGJX42I82uRcKwjMTy7BhrGcdrFfzQFiduxhK4L4FDclJ51faud
 5C0gcvrWlklrRB0/NPpFAszviJWS74LxOP33e8TTWa8s2aeBxrcYj28AICQew3842WYE
 IkYUKZEIUD1newCUdGWFWFWA3sxOD4j2dFbDYjobc58ec40DkC9y9sXdMCz+FX9byn04
 yhvA==
X-Gm-Message-State: AOJu0YxO1t/I3Tb2E6t1FLPJ4kNirGvB8SI/YrVCnHA7fjMTiE1zfCGZ
 1WssJQ9ciMqhH/oaPU4DnfJxkfrGK+o2Woz9lv+yaJMZJDHLK1FphsBN3OqASiF4ll36Q/VfK+j
 W+HOM9LbY7bHshso9hYsBIoOUA/0=
X-Google-Smtp-Source: AGHT+IGlvDVx+xP1qh7ik3yYdbR0WFLsBCAUIAeZQfWF1ro+0wUfETNcql/HXHUp1/cNDzlV34jW+kDSq52oyDjXM84=
X-Received: by 2002:a05:6808:200e:b0:3e0:6d69:96db with SMTP id
 5614622812f47-3e5d219ebc3mr5419849b6e.12.1728933479785; Mon, 14 Oct 2024
 12:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241014175338.2675136-1-alexthreed@gmail.com>
 <3f4143078e0dc3409c96ea13be5b8317@manjaro.org>
 <CAF4oh-PM8JCymzEbw3ZtYnaF8_fjckHUPUkqv-xS1fZBh5o2cA@mail.gmail.com>
 <65bd30e10c687ec5bf19bda34da7df27@manjaro.org>
In-Reply-To: <65bd30e10c687ec5bf19bda34da7df27@manjaro.org>
From: Alex ThreeD <alexthreed@gmail.com>
Date: Mon, 14 Oct 2024 22:17:48 +0300
Message-ID: <CAF4oh-P-6unDx0HVRegos7FNYv9z7FpQoctu4w465CfFfLzFGw@mail.gmail.com>
Subject: Re: [PATCH v2] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 14, 2024 at 10:00=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
> To sum up the replies from Marek, the lower limit should be 64.
64 by default, warning for custom values less than 32. Right?
Since 32 bytes is sufficient for kernels released in the last 2 years.
