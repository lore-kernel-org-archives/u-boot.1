Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099A3CFA756
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 16:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD48889C3;
	Sat,  5 Oct 2024 18:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZyP+0bsK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AEB488B23; Sat,  5 Oct 2024 18:46:58 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D577D889BD
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 18:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539983beb19so3933278e87.3
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728146815; x=1728751615; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqino+hV0YflxPFz8hWuXGu7Z1WLh5o9NECmz/Pd9YQ=;
 b=ZyP+0bsK1jYR+a/VzyGDa+UCboU5T7R0uwbLbPUNZmgeDmqTngx6hfynDE1l7/8L5D
 PXtqWPBb4rFZMLfUCjFf//kgDWy7ymtjgs5PyJYU6uSjdbFkt9tkkrvaZ4aKhf5w/NrE
 DF1oKxI8Hna2+2oRzHB1Xe6QdGpHugNrBOW9RDPwaWiueHHDuQ0uI4LOYqyvACoeT0L/
 y0GQjthSxJJLR5ZHIbzG34EXE3hgzzFw/v/oIo3dHxQnMpLQACfvrpRAWqEyXM79g/Zg
 jAEbhX5+1mnEU9dz87qOqj9/e2bvnMdwdeXFqpYU/x+l/9fYIC2HVqv/noScU/oLFB5D
 pU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728146815; x=1728751615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqino+hV0YflxPFz8hWuXGu7Z1WLh5o9NECmz/Pd9YQ=;
 b=mA6E4TfTEf9Ln/SWUwggf8jufSyBWn2N2zjEYIvt+twmje9WkREz9zUZZTalSmJ+jw
 NfdqpVo0QKvgglT6a1HeJBM0jontpHuwwYrJHfqvnsimnDPNEOhjgdc3tAxhXEzdqvVt
 Lc5gx9TNoxyOpT27/LL+XI5Vw/liyXMQPDWZebTK59HMWwheZSkNXGi3J6SMtPXhv/qm
 TGHsFzs5gzR1TjXqlzIqzIJ89pvwY1m1V7f4xdKvvVe+fv5I87bnWfPIa7RCqAI3nl+V
 1ho69Vdu5qEg8+SQGRNHEELNG2qDVVL7srIaCbf6g8H5Sh+GAE2KJIYpzNkaYkjDqBvA
 uaYA==
X-Gm-Message-State: AOJu0Yyz05C+uyrz6YLUF1eB4RhxnjhKN0YFUPZWgZ2HFbk5ovpVo/1V
 3qh0rg5kg+FRGG44l3sf0p8Ski8XNsI5dZgWW2PQlN413N1ZxKouJNZlw7Ffs09fHHzmZzj1jB0
 m68dJMOlbCmnIM9itIcW5lZJb5dE=
X-Google-Smtp-Source: AGHT+IGxMPJDt+vWpjhlB7bAL4olsCWTGtUJaHgUBa/IM60sdL2pawH/NnKYnikYpMzeFKMCrLWFtsLcx8GSvKTigno=
X-Received: by 2002:a05:6512:2211:b0:539:a4ef:675a with SMTP id
 2adb3069b0e04-539ab87e1f6mr3423472e87.34.1728146814977; Sat, 05 Oct 2024
 09:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240928235325.358821-1-marex@denx.de>
In-Reply-To: <20240928235325.358821-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 5 Oct 2024 13:46:43 -0300
Message-ID: <CAOMZO5BpoyobGyRmUqUpbR47mNjKP09oO=C+XT5+TtgtiZOKjQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: Add support for DH electronics i.MX8M
 Plus DHCOM PicoITX
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Sat, Sep 28, 2024 at 8:54=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Add support for DH electronics i.MX8M Plus DHCOM SoM on PicoITX carrier b=
oard.
> This system is populated with serial console, EQoS ethernet, eMMC, SD, SP=
I NOR,
> LEDs and USB 3.0 host used in USB 2.0 mode on PicoITX.
>
> Matching Linux kernel patch has been posted:
> https://lore.kernel.org/imx/20240928234949.357893-2-marex@denx.de/
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx/next, thanks.
