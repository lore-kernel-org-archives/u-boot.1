Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8271DC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 14:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F6B8718E;
	Wed,  8 Nov 2023 15:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ba3tqH37";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E02787191; Wed,  8 Nov 2023 15:50:54 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4059387165
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9e2838bcb5eso307169066b.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 06:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699455052; x=1700059852; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fGX0T/wuq4bSLgfaZWMSzoteS0HoEh0Q5H+UgoGVi44=;
 b=ba3tqH373Yef9XXzCsTAOthsZFRuIhS6Ol59Fu5SBLxvd8eZ2JfvMvvwvbsIj9ZHPY
 LgKFNibiox/LAtA/ssw74fkRUS1QzHpyS7ACodOOx8bHt4jM7t5SxcviKQ2qezTL983L
 PqL7aVZqZR+mtLrmgWqJutdxdMmDyJnsv7GEWMO3V0yPxCKp3NYjl/xY3WI8vs2bI/hg
 lucU+sEXYeVxfm1eft7npn3v1YdnhybUhDHoU15sT3c7m4lMXll5jgSwhB0aZgkdtLFE
 QpLPU9F5ZsNy6NNGvuoJF4x7uksy+UxHTBt2mhEuFQUfruaHeHktGKCd8hn9p/10ibFe
 JBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699455052; x=1700059852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fGX0T/wuq4bSLgfaZWMSzoteS0HoEh0Q5H+UgoGVi44=;
 b=ddaoljfs+KpyAFWmdd11rxdnESy+wiWMzQUfzt6O6tuDr8aL40XP5Ij+oVN2/9KRu+
 ubbZSzgmIdYNGJsOuyZqD2YVfD+bR0utqL09oXd9+e6uy2aUm0UPQw7Gf2x4LPSPc9c2
 PViE5AUafJ5PlHr3Eem5bLheJ1DHHYhIoD1INJ56p4QRGcxbE1w0gj83eEXrxmedhNhy
 Z+Ptc1fMNrEP3mJDN1o20wA58nNcF64qjntDopksxxeqVYO8+1rcb/8lhRhayIK9/VTV
 xfJuK0VibriRW80aC2aMkmyJ6V5IzafblqvYg2iL+mc9m+yc3xiw9sILsO4BZSYn92GJ
 63Rw==
X-Gm-Message-State: AOJu0YzQNIYCceAtXPvkkKUSDJ3O6iVFzjIIGXs9RQqgU0FH8lK8ORHm
 V0xNZ+KA3hu/8mICoulVR3klTK3pXZUbPp/Fhg0YJMzg
X-Google-Smtp-Source: AGHT+IErPOlZjfjsHn3fjmQwWJicxii2vZdVjODM0pHqQ01C1qKvrb8O8RzirUZMV75GTuMfoEmX9JHSjnJwgK4ihWQ=
X-Received: by 2002:a17:907:60d6:b0:9b9:f980:8810 with SMTP id
 hv22-20020a17090760d600b009b9f9808810mr1822567ejc.34.1699455051528; Wed, 08
 Nov 2023 06:50:51 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2RP2LB=4GAdKWdckzXwiWUpAGY4T1UCu=YuJQgFWo4Qg@mail.gmail.com>
In-Reply-To: <CAHc5_t2RP2LB=4GAdKWdckzXwiWUpAGY4T1UCu=YuJQgFWo4Qg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 8 Nov 2023 14:50:40 +0000
Message-ID: <CALeDE9MaboQPWpDND5WD8ywhg5C-nhGPToXadK6CY0u-aDHGkQ@mail.gmail.com>
Subject: Re: rockpro64 rk3399 dwc3 issue
To: Shantur Rathore <shantur.rathore@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi,

> I am trying to boot OS via USB3.0 ports on RK3399 base RockPro64.
> U-boot is failing to detect the drive in the USB3.0 port.
>
> If I boot linux through other mediums the drive is detected and works fine.
> Can anyone please help me figure out the issue?

Can you share the version of U-Boot you're using?
