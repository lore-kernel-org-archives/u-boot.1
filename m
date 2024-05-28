Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848E8C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 12:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F114D88431;
	Tue, 28 May 2024 14:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MYP0XPC8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E0E38841D; Tue, 28 May 2024 14:53:10 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A29884A9
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6818d68f852so29401a12.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716900786; x=1717505586; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AGUB8ijErPILqeYZfUbWN+TSODkfKK9lFuLdXaeeeI=;
 b=MYP0XPC8j3yYaQIc/zb9KRxi/bOEpWLT0QD+ah0amQBYTW9gYINcRY4sc/fiKnDfuV
 4CbxLj62/FeGlAB3vzcX0NVrMRTINCbhTRQt5939fMK8W/Tt8wErpBPPjwY3MId3Kq2u
 S5zrN7QpzWhtNeR/c9m2BA36ON8XtQc6bMZ1O//Y/QRMI7gEEJeyHYvMwGW/pdXVx7xB
 8efbr6xj29M7zjAdnGFGs8cM8umqthYkfNctdAv6LGw8p1D79iPfnUigqdskDpqFUm88
 PPBUp7bYZkcbqhmIVWKU6vkQg9zrWF9ZZ9DgDFQAZktG3YkxhyPLNWZiOLMo3v+ento4
 hKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716900786; x=1717505586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+AGUB8ijErPILqeYZfUbWN+TSODkfKK9lFuLdXaeeeI=;
 b=w7zKCRDJhbMq1nBgPrXDUZnx8Pritr/eTpEf94i7CpgVnJoTofjDlUJo6A450ciBR/
 CH1W1+L9kblsQn2EN6EvnD9FeUXjrG/+hU//24myLpARjqaSGr9ip/R3xbFIOsRs+Fb9
 gWTI/jb3FhVqSb7ujyF1YAVtaGv4HbpDwbY/RPZ8imMZSOIf23NFR9IouJToioVbIweo
 7Z4/hoP/2XGklzFQSHquFVotGAOAaKvnU/1FzD9lH5UeMcdBAFiGxoD/n81vVYXhweNo
 SuTyjUP1qWgz6S/j4Ti5ONYLHcPlJNRH0jm2KZbCzan2fznANjw/9Zvkiz/NR3TUrwAA
 +Pow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmo6oe+NY+f5j02i4AP5DSl/gOmThMXebA9zo4opQftm/P0+HRwuJJqv9rmlwAkjg0nkMIL7nh3rqVUQvPt545LBVk4g==
X-Gm-Message-State: AOJu0YwjYdDoNieAlkVUfHB+o7ecG+6OEws2VBS3EgM3UgO8NqkEdDnW
 TKuSus/eXz672wRYT1j2fqPY24ezglpW0KmmLwY2IiKPZ9CwEY4Ky7Ldmhby0xgFsvIbuSHNikI
 Vot0fRX3ruzvyRiFrfRsCqRk4oy8=
X-Google-Smtp-Source: AGHT+IEgPmGVa++PpRNT0GEO5Cg5wMzWLAUwB6SM+uw1rqCkyqLg3K9MuLJZJ7jytzsM0D5H9tj3GxgVHfU8HHFRQ2U=
X-Received: by 2002:a05:6a21:627:b0:1ad:7bdd:361f with SMTP id
 adf61e73a8af0-1b212f3d52cmr11002598637.5.1716900786120; Tue, 28 May 2024
 05:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
 <CAOMZO5DhnEz_7Ldg58PnsQaFoDMnPY1_gmxZEeLUf2JyyQ8GEA@mail.gmail.com>
 <20240528123927.GA12666@francesco-nb>
In-Reply-To: <20240528123927.GA12666@francesco-nb>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 May 2024 09:52:54 -0300
Message-ID: <CAOMZO5Aajt8EfafoVngtMvLpwpHtV-BCYEwUtBJ6tTugD8-xsw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] board: toradex: Add new Verdin and Aquila SKUs
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
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

Hi Francesco,

On Tue, May 28, 2024 at 9:39=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:

> I disagree on doing this on this specific series. The reason is that the
> changes on the tdx-cfg-block are depending one on each other and they
> have nothing nxp nor ti specific, they are toradex specific.
>
> If I misunderstood your request, how would you do it?
> Patches 1,2,4 and 5 are for Toradex NXP board variant, patch 3 is for a
> Toradex TI board, patches 4 and 5 depend on patch 3.

Thanks for the clarification. I will assign this series to me in patchwork =
then.
