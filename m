Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892F3C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 17:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0ADB82B07;
	Fri, 11 Jul 2025 19:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bbyeawcy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B180382C84; Fri, 11 Jul 2025 19:24:43 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0CEB8277D
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 19:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-555024588b1so2645179e87.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752254681; x=1752859481; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oA61wq9UVTgwWQ3GUlMhx3PYnjiduCKSNyPK++3LMD8=;
 b=BbyeawcyRrNG0odmayZqftNsGssn37Ro30yerYMByZlHRUnhUBu60P35nLCFuDUY2a
 /eln2UfzD7eovSnGcCYL8+ubhIlymqKsBG9CDpSiaOFxq4xxi3F9tEHyyqi0dGMFE9eo
 MonQ1L2mDnoqMtNYhLYX7g8UHrB2xA/cOy4p1ONyZ0K9GZTvy6D6Q/iVytXD1JyjacdW
 XJl/IfJfmvgdv7FBQISddFUTOpEXccS18csJ2eobsJqRxZyGPlZMx/r12Rbmtb8qD9YZ
 2JVQTwDeTqwzYtYXDTmm1K0rSnEUx9YUrXh7Ya7vZb63sqzHutgv1TUfOiB4MoTQwAZ3
 K/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254681; x=1752859481;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oA61wq9UVTgwWQ3GUlMhx3PYnjiduCKSNyPK++3LMD8=;
 b=gfMVFz1Tv66vTCG/wQMMfd458TeS6KIOUzhrHcfp6rEFoM1Wm5uFEHYIZF/inSsf4/
 Yrevqxz35rXX7aTCJ05q1czL79GHDm5KEuEJ1D5KW9SLl1L8Jy/24GAjoq4sA1f0JtMy
 vJM5Xv9kstUU8jEQ7W7M21YH1PAEHt/ShMQ3azECMrU7C6tU6wSg7nyOAtvO1wM4GYHo
 9T0Ln/nwfF673tlTsrCSWTXTCDyIe5baPrNwRztVjhJ0mzgyc8DbJwCBZoPqmLEPxqL1
 F878kN8IY1jfLbXVnm7chsbE6VjVyyNgudEnTJ3tBn2VNqlqvR97umoxvgtA5rJJS6Bp
 RfnQ==
X-Gm-Message-State: AOJu0YwC3j6BgShtpQbtEh0K7ZhZAOH1+T3esPGDFuGnf1H8ZTmPa76o
 UYzZykd2274PU35mdpJ90MGfBSaMsHrJodrR6n59NVcCFsCsvt3QsI/X/8A5ZRX+Qxqc6B+waag
 ADxhkkRvIJMHWCz2M8+JdsHP6qtg0OHQ=
X-Gm-Gg: ASbGnctXLCPaCKXkxu8HRyiRREUQ87PKMj1jjpBLu173hGl6W4a/6FSITwNcZ1pdF/m
 Lzzh48/IHZj3dp0tvuIzppTZmtLFgdijUy091ZVuByE5LpacxK0LjJfI7RjhbuvKUAAxEXeTGYM
 Pa6Lf8LjC9IpCn7PyMpAzgMrm1kKIwqvjt4CYqsW+vVzXMtyM3UJg2CujN4+JIuPXR5KHhh87oa
 Ib9kUDa2JznzTXX8hpBxAPKu4a4j11HyvsJAllhdBc6fuK9bQ==
X-Google-Smtp-Source: AGHT+IH8i5fb4D8NuO18aJVWJwz9Sl7aRSTFD7vLnYklk7m4I0G7HnaLXa40S066ZpzGpnjERczouLhG471CzR/jBpU=
X-Received: by 2002:a05:6512:3e1c:b0:553:297b:3d45 with SMTP id
 2adb3069b0e04-55a046396ebmr1418676e87.43.1752254680744; Fri, 11 Jul 2025
 10:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250709234918.140919-1-davidzangcs@gmail.com>
 <CAOMZO5D1d=Y9i9E+Pcm0sbyKE+M=zUj_9Rs_QHbaE5DPvWFA=w@mail.gmail.com>
 <CACwB3C-KKZS_5JOfFvF5hWsXr4AXUU+OTR1+rBSd5NpkH4r+rg@mail.gmail.com>
In-Reply-To: <CACwB3C-KKZS_5JOfFvF5hWsXr4AXUU+OTR1+rBSd5NpkH4r+rg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Jul 2025 14:24:29 -0300
X-Gm-Features: Ac12FXw_Heo5SzZGRcXVn2R0t3cMECvhU6C7mwl1cY6OfM43DBGJkyWEDpWOkA8
Message-ID: <CAOMZO5AXxp3x+mErrWFMX_3SUt58jGDZCAXOo+De=0b-ORA2GA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx8ulp: Add celsius unit for temperature
To: David Zang <davidzangcs@gmail.com>
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com
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

On Fri, Jul 11, 2025 at 2:22=E2=80=AFPM David Zang <davidzangcs@gmail.com> =
wrote:

> Since it is a simple fix, do I really need a commit log?

Yes, even a single line is better than nothing.
