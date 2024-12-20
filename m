Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1873EE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 08:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 227C780087;
	Fri, 20 Dec 2024 09:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Lp5R8mLR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4007A8021A; Fri, 20 Dec 2024 09:04:53 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F06E8007D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53e3c47434eso1698210e87.3
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 00:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734681890; x=1735286690; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHxR5QIkY1SALDVBHxH0ZYl5KsEsIpvV8Ih9AMygwG0=;
 b=Lp5R8mLRU5eKQh8/XRWHeOZgkorBm+nBDIDfIapy98nQlFK5aRFhF/SzghbGQaep9Y
 xDsWN/WCjdNR1okazWWA3+SbLCZBYo9x7ManqWLr6e+SyAgO2hOy6lQsOATjTyJMrWw1
 N37X6soEMEL2sM4Yy55I62iEYV7Yf3rl+yjGqbyH4KSk+sLaJw5pWza8RzKU7rqy3Lj/
 TivvqZMmqCQ99wVaZkIXKJQlpS4PqUle2uys3/0qNO2p3DaPnFvn0X+1W/nNAPEcIIwy
 MpEpbgS1Hb0RFRn5NQ0e0w/cMSPcybxYbkDOSQjSzganLIGhJ7cH4WeLFUvPfKWrS3Fz
 Repg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734681890; x=1735286690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHxR5QIkY1SALDVBHxH0ZYl5KsEsIpvV8Ih9AMygwG0=;
 b=jEdeLIQlY+nutIMYcWv5djtJJ79p+7vbVRi2IwWLu86r7i7hr3dWElublrc3R3zsZA
 hcjiTEm4ymi7V0CacqzefQqthvlhwEAeufAO6BUkSK7z1unh0fFGbmTMZ+B/R8nVnVNf
 JlhFm06R+nv6S8wGE4r8EZVO8ce+FmVoVP81OjQcefs3VXQ3gAM2kJ/+waordFucNFNM
 eHBWNrohHHSbU8Do2n03aC5hiSC6VEiOA0qdGmhonyp/Jw9kAYFAZuHevzZy7UQNe+vk
 29JmUo2RSPxEqkr0b7+aFBdyMsE0SlXjKbqDLNtteH9SdcgQnlud8Fr4y2dcosqYENcG
 IHzg==
X-Gm-Message-State: AOJu0YzrUqPgF+pjGnFeOhy51rDw/BY7kQKuRcoTZ0mErSPjQICfWUHv
 WqnXkdgq538VnWrV94eH9UUKLASdTflv/Ov7VBjgmfvhgoRW8G3HlTm/iPfyZl78rw70KFjx3to
 Y0VtxbV2yTLyY9fpDDno89L0Rd5I4cAQpIaGnQQ==
X-Gm-Gg: ASbGncu6RSEcECmMcnqvg+syKBpkk5HKWbQumeB2J1taubXPQ+YrxM1g0I0YagPqWNM
 +6ku+enymlv1ykWRqD8EGbiFPWdkACZ6TJMzR
X-Google-Smtp-Source: AGHT+IEwHjKPvsUdTAVCweqDUrgmaZMwmdiMi5quMIjtMFxtDCGFRFFYmFqQj8OcTWXR8aANA3pVK/gQldqN3G7QAGk=
X-Received: by 2002:a05:6512:3f1a:b0:540:31e1:c8dd with SMTP id
 2adb3069b0e04-54229525231mr572810e87.9.1734681890357; Fri, 20 Dec 2024
 00:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20241219184953.226978-1-dregan@broadcom.com>
 <20241219184953.226978-3-dregan@broadcom.com>
In-Reply-To: <20241219184953.226978-3-dregan@broadcom.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Dec 2024 09:04:39 +0100
Message-ID: <CACRpkdZKL7-KQ7u=Y1Vm5AY1mzJbzS9BtJ0W_XZW8EFRF1Yjcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: dts: Update nand node for bcmbca board dts
To: david regan <dregan@broadcom.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, Tom Rini <trini@konsulko.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, dregan@mail.com
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

On Thu, Dec 19, 2024 at 7:50=E2=80=AFPM david regan <dregan@broadcom.com> w=
rote:

> Update bcmbca dts to current nand node naming convention.
>
> Signed-off-by: david regan <dregan@broadcom.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Anand Gore <anand.gore@broadcom.com>

Looks like a reasonable step
Acked-by: Linus Walleij <linus.walleij@linaro.org>

But:

> -       nandcs@0 {
> -               compatible =3D "brcm,nandcs";
> -               reg =3D <0>;
> -               nand-ecc-strength =3D <4>;
> -               nand-ecc-step-size =3D <512>;
> -               brcm,nand-oob-sector-size =3D <16>;
> -       };
> +&nandcs {
> +       nand-on-flash-bbt;
> +       nand-ecc-strength =3D <4>;
> +       nand-ecc-step-size =3D <512>;
> +       brcm,nand-oob-sector-size =3D <16>;

So you're adding nand-on-flash-bbt, maybe we should notice this?

Do you have to use the explicit ECC config, or can you just use
Williams new option
brcm,nand-ecc-use-strap;
?

(This can be changed in an additional patch.)

Yours,
Linus Walleij
