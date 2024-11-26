Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADC5D3B987
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 11:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A97C8973E;
	Tue, 26 Nov 2024 12:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kiADqC/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57874896D1; Tue, 26 Nov 2024 12:59:30 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC3389748
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 12:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53de6b7da14so1786304e87.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 03:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732622368; x=1733227168; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSuZcIjjtV5ujszzhMGrHfInQ1PJ4w5u8SbQBsXOq1c=;
 b=kiADqC/wTQGSlw4o6HUXHc2Pnm7SOi5osJMAWwlF+4YZRdyYhEc+F7MOVo2SPw0BH+
 XBmgT9FuF62D/zA/GJZzJq7LCP6dxCY6SxEaD5Q7Bup5Hxcked47TOux7iQNKbQl6+ww
 MMnKmgufIp/mOjmpuDqoVuCEPp3toBYZDPcBZ5ISp/aEFdZYf0irE4uGl20/XKyURct1
 4s0kXYhxprBc62bvLnNcM07YSDc2/+rwaSgmjtCotBNxKeCYX2/b236pbjovWXHtPN6Y
 S0dQPKxTsjKEi/HkUUFDidlnIYtJPPjhC10Hg0b+ZU9pskdMj6wRavk5m5QVisAhsp8H
 YpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732622368; x=1733227168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSuZcIjjtV5ujszzhMGrHfInQ1PJ4w5u8SbQBsXOq1c=;
 b=qDWIoS+F5jJLYAZkhhR/tSIQWOYL5OXgVLBqCNYpvyxMdqkM4Q9ZEIbfHUCipZ32wY
 wSVX5a4Ti66EXmyYTA43ZwHzkLg05uqX2o4aoQOwhiLLiBvX28RYERlZwXMofnnYFSpK
 bkNtrEMcphFMclXuED6TcmT+uzjAT06ytB8eGdY5omUCOGKAorh5/7cZ8YWVzZH/16Yb
 k6v8EViLh6QIM9fhEnKp/MTVT38ANT4zazSWN5EfiIg0Hu8VikUwhqLyISGKnZftKkHQ
 MoWLwGpI6sm0fAH3K2xxBqIVGQlVfPSgIl1dwKD0DmSgGQiitHYU7sicuVmvee5wyOjH
 3Z4w==
X-Gm-Message-State: AOJu0YzFf//j7DZHzZBmL7zGpdEhuDSzlY3Mm36wf/xM6k63tI+uujXo
 6Aeu5nbqQDyrjLmjTJJur4FdWHmYd4F7g72WRfDZfxAFwYV6GKFo5bBiT8uoJS0Y9skMH6CI5vJ
 xcHrkLUSUhKBKa98F2iCgdktk6/lTVQ==
X-Gm-Gg: ASbGnctMMAglzmmYy8c0y5rc6SpwUhMKn3nSxFdglQJ1v4wLm+vSMq8EwZvxKScrQRl
 WwZxi24Z9TJIp3DI56IGLEc2l/VDWsLfromaqp1x1VtlgAVkr8F+dgAKRiWq6Bf0=
X-Google-Smtp-Source: AGHT+IEomAnpXBSXpeDUoIEatg4WmSO91sA/HRKb4cGVCNmKddrxEqkl85Q9zFWzOY3F8EHlAHXL75SocF9/g3uuzHk=
X-Received: by 2002:a05:6512:32c1:b0:53d:dba8:a85f with SMTP id
 2adb3069b0e04-53ddba8a990mr5707355e87.38.1732622367353; Tue, 26 Nov 2024
 03:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20241120163143.127862-1-c.stoidner@phytec.de>
In-Reply-To: <20241120163143.127862-1-c.stoidner@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Nov 2024 08:59:16 -0300
Message-ID: <CAOMZO5Ah_uN_nfeLh9chTBtTCCkM-ymSPwQTGx1vT10OmUUu6A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add support for all variants of the phyCORE-i.MX93
 SOM
To: Christoph Stoidner <c.stoidner@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Wed, Nov 20, 2024 at 1:32=E2=80=AFPM Christoph Stoidner <c.stoidner@phyt=
ec.de> wrote:
>
> The phyCORE-i.MX 93 is available in various variants (e.g. different ram
> sizes, eMMC HS400 yes/no). It's eeprom contains information which feature=
s
> the existing module supports.
>
> Extend the existing board-code to support all the SOM variants. The spl/u=
-boot
> evaluates the eeprom information and enables supported features according=
ly.
> The resulting spl and u-boot binary is able to boot each phyCORE-i.MX 93 =
SOM
> variant on each carrier board.

Applied all for -next, thanks.
