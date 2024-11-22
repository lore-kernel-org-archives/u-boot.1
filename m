Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D721FD75E59
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 14:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0968D89850;
	Fri, 22 Nov 2024 15:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="LpxeFxci";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5709D89851; Fri, 22 Nov 2024 15:33:14 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCAFC88FDE
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 15:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ldevulder@suse.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53d9ff8f1e4so2453210e87.2
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 06:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1732285991; x=1732890791; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V2hEwaO7l4n6QKjabveKMNUrzF2YjhT0ZbEM+Pz3dRc=;
 b=LpxeFxci33O9rVriwwJZgmY/N4RGD1h7s3YwQ+peq6yqmpEM0E0GnnffwdDTDwFaaE
 JEvlKCP9uYE68ml4e103JfTxPLwurpm1WdygBo9EkPOkueKQKcfYKzmyBDgGPg1ZbYYP
 w/VRFQGlylmgawFV89fOSF+mSg4vb+kykCc+tH5ODlWSbIiaFfVVU2Seqz+tkcUOJ/3s
 iAzAywzFPXnHCdImIMsym22rUpywLhgN2GsnyCHkzEw9+imzNvcXv/3Ur5ajOK/6qlmw
 UpxDcqeapwXkYHQbKeZ8NkYL3dZM7sjbHAWD0AS6Vp/eOwulRKRs25AkFNh5SIk3bpIX
 kbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732285991; x=1732890791;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V2hEwaO7l4n6QKjabveKMNUrzF2YjhT0ZbEM+Pz3dRc=;
 b=RLXtk49vP0gI8xR7cZ8k4YSSgvVfxWN4yaxn0iB5oQq5VzaFBxst1IFZp9CWkqE3cp
 66IujYh7oNEGLdLZVQ8xr0VwyyBx02RnUgEcSWkRx5Rua406u/+z4L6az8UwR/O1XYyl
 0Myg7ecZ16oYP82+SyyGZLAE/ADCD6CiBxdBavlTutOG0BS5GE2NCcgcLyMOeWLJof7j
 04gRQbIBD1vy+HBOkDD0HhnW2kZLgEMYxLCdjAQD7WKDeN2gS98G9/iNk7wQ5bgc0UIP
 wH6Poqlxy6W/TXmdM7JbOguFPeVhZp9iaqocwbTosjgHWEKrYqJQ2TMexzoqfp1KkxQ7
 1nnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRCfazQ4KgKbf/fE4DvUi/r3l48PKpMH5Jjg0846y3RkuUG9ccBTSJg15kqDnzNbANDXfDqDY=@lists.denx.de
X-Gm-Message-State: AOJu0YwiaK77PAV7O18T8uVT206Plr8qEWhZtQ+IPatTz39M/GkDJ/Gy
 LbQFbziNW2vGp9J5qju0YTgxvlZKDnO7ZvjRqCSRs6Tl7vPa4J5UiAe6CTf37IE=
X-Gm-Gg: ASbGnctxUl4yGQWDNSZ9K+xVbHixz5sMC6HV8HVEL5j6lSb3DT/iVIdGdjiXj7ZY9r+
 YQkSdFlJ8zP9zCz9j7E+InrIEDdUKn3tULSoAsdWHOQ6TH18b/6uwQupkqdvNGTRtywMBVJ+mPv
 erUp/vbUdDYWxANpOtgmlY8ag8t0Mc4DD0e9arvK8OGCNzkNmPfCzNnffM/a7Zn5eeS6yPknLrX
 lJKfFZGfeA83NPWLg0NoIBDR1yKLKqD7y2f/exZJk5OQ2JC
X-Google-Smtp-Source: AGHT+IFh+Xf1OWYQ/EhpTv5lBagXdfvXx81kU6pVxdaA1fjVDXIIzks1jQU8JBj4bxSulQkrk/XB0A==
X-Received: by 2002:a05:6512:a86:b0:539:d0ef:b3f9 with SMTP id
 2adb3069b0e04-53dd39b5614mr1211220e87.40.1732285990980; 
 Fri, 22 Nov 2024 06:33:10 -0800 (PST)
Received: from [192.168.4.7] ([82.66.145.28]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde06ed1sm28961445e9.6.2024.11.22.06.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 06:33:10 -0800 (PST)
Message-ID: <e6eadaccaeef3b902d15dba7f634a7225318f1bb.camel@suse.com>
Subject: Re: [PATCH 0/2] configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER
From: Loic Devulder <ldevulder@suse.com>
To: Andreas Schwab <schwab@suse.de>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>, Ilias Apalodimas	
 <ilias.apalodimas@linaro.org>, Rick Chen <rick@andestech.com>, Leo Yu-Chi
 Liang	 <ycliang@andestech.com>, Hal Feng <hal.feng@starfivetech.com>, Tom
 Rini	 <trini@konsulko.com>, Chanho Park <chanho61.park@samsung.com>,
 Aurelien Jarno	 <aurelien@aurel32.net>, Nam Cao <namcao@linutronix.de>,
 Jaehoon Chung	 <jh80.chung@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de
Date: Fri, 22 Nov 2024 15:33:09 +0100
In-Reply-To: <mvmjzcwobi0.fsf@suse.de>
References: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
 <mvmjzcwobi0.fsf@suse.de>
Autocrypt: addr=ldevulder@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
MIME-Version: 1.0
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

Hi guys!

I played with latest openSUSE TW image [1] for VisionFive2=C2=A0and I also =
had an issue but not exactly
the same Andreas had. Booting the OS from an sdcard gave me the grub cli bu=
t not the menu. With
Heinrich's patch I was able to boot on grub menu as fully boot the OS as we=
ll.

Tested-by: Loic Devulder <ldevulder@suse.com>

--=20
Loic Devulder <ldevulder@suse.com>
Senior QA Engineer | SUSE Software Solutions

[1] -
https://download.opensuse.org/ports/riscv/tumbleweed/images/openSUSE-Tumble=
weed-RISC-V-JeOS-starfivevisionfive2.riscv64-2024.11.10-Build1.19.raw.xz

On Thu, 2024-11-21 at 16:24 +0100, Andreas Schwab wrote:
> On Nov 21 2024, Heinrich Schuchardt wrote:
>=20
> > Our MMC driver for JH7110 boards only supports reading to the low 4 GiB=
 of
> > memory. Booting boards with more memory requires EFI_LOADER_BOUNCE_BUFF=
ER.
>=20
> That doesn't change the situation with the booting problem I have.
>=20
