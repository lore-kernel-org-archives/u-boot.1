Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6554ACE7A88
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 22:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0E0F8656E;
	Sat, 23 Sep 2023 00:13:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WC9u2+Z2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B7D6864D4; Sat, 23 Sep 2023 00:13:58 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4484D869F1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 00:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c008d8fd07so48556111fa.1
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 15:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695420834; x=1696025634; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UI8wDlQnW8amJ/ldjuMJD0bwFBgDvKObXJbDeciUA3Y=;
 b=WC9u2+Z2zEaEObfAquHe0DzgsyYV5quHXWXEQln2pMsDhbUbxkb+zIYijlODNVpue8
 iI+1nxmoh+Q3AitXeQCDOJYqAt4QE8DRp+m3d1CdFlu7H4z8wBBEx8V1UmI1l44LR3CB
 rX2D4P7w6AB8P+6ozGX711Ix08VnKdlVDJK3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695420834; x=1696025634;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UI8wDlQnW8amJ/ldjuMJD0bwFBgDvKObXJbDeciUA3Y=;
 b=f9Jqd+tfUGevC9ZUgUbjSNYZ0mCIMptFV7gM7ayVJqGU3o8LONMA1fOcYiVCv1/6Zx
 BKk/wDkT0WWALsnBLYieFg/rgLXsQjrs64XvtRNDigNuEI7pATXdS1SAOM0lwvNS6vdN
 BfUxZZrCCGj7aTOTAYcZ/UHsWgYqxOu/vqGANlKACp1LV648uu7DDjbqvvjhpfZVcmCN
 IidU28y/uvUvgS6Z8RHEsEiIQp5LB+tJAhhCROzj1dRgBEpT29Vi/+hhWX/JzlKXxQw6
 tBLkA5rn/955kXjEFPR3HKkhzjz/lU6lmaXACdiszpjIugG73fQeUKUfAgW4+yEU11bb
 L45A==
X-Gm-Message-State: AOJu0Yxm3fJDoZ1TYYwxA4gtwT1/vNtHs1mZtOdp+DD4i8UNkZP3SGot
 Da+wxGlTW2br1ZbTcPnnFz6Sc8yfKGEbmSFEkGZ9KZ9nLZ4V1oVGLXk=
X-Google-Smtp-Source: AGHT+IH+1dFacclrm7YemTmfp/Nip15lUm7q0gIwhP2FiwALCS2NJUofgsIgqoImxMA5lWfRHL0C1Xf7gqqBVlkSVag=
X-Received: by 2002:a2e:9788:0:b0:2bc:b9c7:7ba3 with SMTP id
 y8-20020a2e9788000000b002bcb9c77ba3mr420843lji.12.1695420833800; Fri, 22 Sep
 2023 15:13:53 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Fri, 22 Sep 2023 16:13:37 -0600
Message-ID: <CAPnjgZ2mhRhOWoObKbw0R+8jmFT0QY4THpXR=f2s1svi6cwEvQ@mail.gmail.com>
Subject: Reading from ISO9660 in U-Boot
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>
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

Hi Heinrick & Bin,

I'd like to be able to figure out in U-Boot what OS is on a USB stick.
For example, with the Ubuntu installer, I can boot it (through grub),
but I cannot see how to read anything useful from the USB stick that
would indicate that it is Ubuntu, what version it is, etc.

Does U-Boot need an ISO9660-filesystem driver for that? Is there any other way?

With Debian I can see the actual files (linux and initrd) , so it is a
bit easier.

Regards,
SImon
