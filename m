Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CF8D4979A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12D0A89646;
	Tue,  3 Dec 2024 10:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3SElcbSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D17398964A; Tue,  3 Dec 2024 10:47:41 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C549B89643
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:47:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53dde5262fdso6103915e87.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 01:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733219259; x=1733824059;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SMntASOa/HY1z46JFHxK1WzDul73tI6Z4ti7XDkdFWg=;
 b=3SElcbSjbjdKCqbDur9a3D8PlVFgXR/w6cLj2xz7G3dAHRLcVosEiL3hkqkqrlC6z4
 Qo0MjLxweVAvgtfyHm8TRgV2VFWG3vsCYPo3GYBpE16+4//c2qr1LmIBSvei9or8VEZt
 zxCmFrnVkZRGSX7JfeMZkXoDPb4u6EHUrC6+tlQRf7I6I9XgWXULJ2MY0NJVQ79eegg1
 Op9icxhRG7CqnZTBK5GTemmZdC4O/dEdROYmZPMrMhpcBB2OslbH5X+jZ7TL6/1qkKzg
 jCkTDV6rxEeEKZ9mvip1JPtjkI1wdRiGyYydElHKBhTw6fwHCzhwQVvZLmYIKQscXLI6
 oREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733219259; x=1733824059;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SMntASOa/HY1z46JFHxK1WzDul73tI6Z4ti7XDkdFWg=;
 b=gD79L+q8xdtb9iczleRdX2loXo6yvsguKQo+7VyH7ubCqkym0FwerWQKDtbSrsnM3y
 4HH0iYA6Re15G2vuHaeuYQPTd+/j0hL0uu+IS0LJMvmeGwCpiLpGWA2LT546GEVL1un+
 wF39dQhm+2Y+9NQXwwpFFjED9GeKW7WP+iMMO3zbWns7gyYdAf3r+JYQf1i1QIzZOo3z
 U1hsLK3a8ZVUdgIkdiY/BL2HG627pJ+VSPIOoMm+N0iG/DZ4nK7/5UhhevP3hfsLH+11
 gClvKol2aq9DWiHLtIQxjXKgpMB/rJY9RsNtlOReWnuh6gEy5RBuWLRxeoZpr+AJug8I
 OiVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURuFCarDSUeNqtoJ1jvpb4DEEQL5B24Zw/ZoU6AtgyfwrapvOSS1XTd2IoH34vdlm+wGIbTl8=@lists.denx.de
X-Gm-Message-State: AOJu0YzF9MdYsSGMpNHXXNPQB/eUb8ffJQ09FpwTUaEy6cI07ufceXKY
 cpWH8AvuF7/5Q5nYu0ba0eXo9UO/oQWqYstahbJX27ceWJZ+TqfuPr0TDQ9rD5A=
X-Gm-Gg: ASbGncv8L67+m5g+iQjXWo1WG1reA/tejl92JBxKewGEx0ODh4ZP/aI0rSH+fPQWTnO
 Nr0SLtY7wNtLr3flY8EiZbIIJ7BY9Rb2YcxvycSfpPj1BmTtlx05a5B2yP0yi/JBlcJDZn1+khO
 AICW2NfFPEuNA3B+tWdngmYCDmflNtvEaXRU/hv+h92iAgO6S5LfJBDCaJLunj5XBfYolDCZrsy
 KbaDNpDgxZl6aiFHNvz84bJWeLaKUnOmHh+cZSPKKpDnQO5eFLPyw==
X-Google-Smtp-Source: AGHT+IEcPKJ1DGgnEWT0GXgmat/04FjIObeghUxuRhY3szj1+ljWI7zrMsZpuKAwoNsfaEm/63a69g==
X-Received: by 2002:a05:6512:1304:b0:53e:1959:322e with SMTP id
 2adb3069b0e04-53e19593377mr225558e87.34.1733219259078; 
 Tue, 03 Dec 2024 01:47:39 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dc6831sm181632855e9.20.2024.12.03.01.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 01:47:38 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marex@denx.de>, Neil
 Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Add schedule() in
 sleep_thread()
In-Reply-To: <20241202074644.5380-1-patrice.chotard@foss.st.com>
References: <20241202074644.5380-1-patrice.chotard@foss.st.com>
Date: Tue, 03 Dec 2024 10:47:35 +0100
Message-ID: <87zfldnlmw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Patrice,

Thank you for the patch.

On lun., d=C3=A9c. 02, 2024 at 08:46, Patrice Chotard <patrice.chotard@foss=
.st.com> wrote:

> In case "ums" command is used on platforms which don't implement
> g_dnl_board_usb_cable_connected() and USB cable is not connected,
> we stay inside sleep_thread() forever and watchdog is triggered.
>
> Add schedule() call to avoid this issue.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> ---
>
> Changes in v2:
>   - move schedule() right before dm_usb_gadget_handle_interrupts()
>
>  drivers/usb/gadget/f_mass_storage.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_m=
ass_storage.c
> index ffe1ae6eb73..d3fc4acb401 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -682,6 +682,7 @@ static int sleep_thread(struct fsg_common *common)
>  			k =3D 0;
>  		}
>=20=20
> +		schedule();
>  		dm_usb_gadget_handle_interrupts(udcdev);
>  	}
>  	common->thread_wakeup_needed =3D 0;
> --=20
> 2.25.1
