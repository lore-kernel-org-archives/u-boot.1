Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AA5C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DFA288915;
	Fri, 23 Aug 2024 15:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="fYwCjGGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0727388861; Fri, 23 Aug 2024 11:23:13 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 126D58860D
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 11:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f3b8eb3df5so16945201fa.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1724404990; x=1725009790;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jVxbiyT84jrG8nUIcus5rpFMOyDVVScZcX03+9jrw4A=;
 b=fYwCjGGHxKPMV6+nwT6Gg+BNj+L2hFEfSDRdHGhe+qNXjaYY1oIXj1BND0QUbUtycu
 AmtfsoY+JR+g4BbWxARLni4MY1ozzQQj1KgOTGY7SQ3b/mLPlu8vVAowBHEJllg3ktmp
 Rcu7rW+4yODwSdmZr2zZbLXb+M+4CC8iJnywxxdQ2/PqSq7Okwk8x3Pg4Yuo5VnyBigk
 8lQx9jmvvrDC89NvGdh9ASh4/UHhTqHS2snJU3xhpc9i/Yqfk0IK2/3TLCjDPmNx4F85
 /qZSkYzoGcNjeVFsvz+rlL3iMuEUiHMcRYbUkTorBoftj7DoX16uA73Ql9OBAk/qQPOc
 d3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724404990; x=1725009790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVxbiyT84jrG8nUIcus5rpFMOyDVVScZcX03+9jrw4A=;
 b=kKQYwHZGBEJ7ZIjsVN1+Gfvc/AVUA9lFlFBKa0bH2w6a7cU+2ZOhkd/iwad2JF5cga
 /quRidhFlVQ8aGc0VmSF1kpROpLpklJshEwsRQWbCMGxoyYpkWHnFhXSEvsuV0k5O/gB
 QjaxQKSue4dvBYVFv54EvS5GKx+Qovt4W3bZO0v+OAMngSPIQu2aYijL/cbzC/CAbBf8
 KFTccgFbxT6IJ82Dj8o068jIvOtEuE1joKyviz46gQ3f2QuktUwugqliSlvws6La0S41
 sQoBGAM81qYoX8LUsnSMxfHSyuBvvBOI52oEBvl+KMJQq5+pc3+GW6IiwaKiNWAcZ1Je
 drqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX43WapB9Csbhu4T2W5ldX1gc0uVQ5QlVeeF2pI+CjBycSOCZUTwyYeag3/Vynm7XsNXQe2oOE=@lists.denx.de
X-Gm-Message-State: AOJu0YxhKGTpITSPwI2qmP/43n9v0x3Xog3PoqX4jXB/oZInAdeD8eci
 nZw7qfEK8jfBG6rsQbs5HZV9Qfn1NCAaq+XJS5WZ/JgdWZJp+QtOFPezmyYkLMrAtXz99X7ds0w
 gcaOrB+qKp9gqmUP4MXFlSSKGSOptDgxK/mvn1A==
X-Google-Smtp-Source: AGHT+IGBKSQQ8yWgudo+3MuE458/uMxA9x5KzEQqkgvO+OOxRTBLW915eZJj9ERSf2Hlo1t/kcvKP4IXKP/w0EVivDI=
X-Received: by 2002:a2e:b5d2:0:b0:2f2:9f26:ce96 with SMTP id
 38308e7fff4ca-2f4f57a23c3mr7282631fa.40.1724404989998; Fri, 23 Aug 2024
 02:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240821212218.2092540-1-admin@hifiphile.com>
 <5a1367d7-be94-4c75-9f40-891ca79f9c5b@denx.de>
 <CA+GyqeYxig+5pyYaCjPmQodXGjCYK=819cNZx9XmvJOnoYne_w@mail.gmail.com>
 <67e8423d-f8a8-412e-ae4a-014d52bf6a2f@denx.de>
 <CA+Gyqea1r6rP8gXfS6nOtOaKZ=sJ1+z_KguGzzJygQKmSNRakw@mail.gmail.com>
 <c7c61399-8b64-471f-bfcb-71afd387317b@denx.de>
 <CA+GyqebS7gVMpLJuMdxN9c8U=CpBLiTuFkqm_4-bA+LstLJpsQ@mail.gmail.com>
 <a86dd37e-2e55-4947-b665-06d68831b63a@denx.de>
In-Reply-To: <a86dd37e-2e55-4947-b665-06d68831b63a@denx.de>
From: Zixun LI <admin@hifiphile.com>
Date: Fri, 23 Aug 2024 11:22:59 +0200
Message-ID: <CA+Gyqeair5Ak2-b32JL9PkoPrJaa9dg1NwQ3s+8+ycCxdv-HDg@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: gadget: ether: Disable USB pullup in eth probe
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 23 Aug 2024 15:36:19 +0200
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

On Fri, Aug 23, 2024 at 4:54=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> I think udc_bind_to_driver() should not call usb_gadget_connect() , that
> connect should likely be called by at some later point.

Yes it's more logical, to keep it in disconnected state you prefer modify
controllers drivers init (I can do usba_udc and dwc2) or add a disconnect()
call ?

> I also think
> that drivers/usb/gadget/udc/udc-core.c might have to be extended to
> provide some way to convert controller struct udevice to struct
> usb_gadget , so when e.g. run_usb_dnl_gadget() calls
> udc_device_get_by_index() and obtains struct udevice * , it can also get
> matching struct usb_gadget * , and call the usb_gadget_connect().
>
> What do you think ?

I think it's a good idea.

If there are multiple gadget controllers (very rare), since
usb_gadget_probe_driver() simply takes the first one from udc list,
is there a chance that the one to be started is different from the one
used by udc_device_get_by_index() ?
