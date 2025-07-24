Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F419C87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AB48838F4;
	Thu, 24 Jul 2025 23:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HFALV9D+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B041838FD; Thu, 24 Jul 2025 23:16:00 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18A87835B2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-32b50f357ecso13507471fa.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753391757; x=1753996557; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+TjmNVEz6DVk3s6XDfI+vlhacHs96fJlyqwAsOGJYe8=;
 b=HFALV9D+RtHxUhWTPDdere5HsaEbt39s1UauMw5FmPJZWWLu3GFZSRZ07fqKhx1Fsn
 AhzQhCJ2Rgb9/9wZwlw2K1iC7w5c8lJSFz/CwkJyDgzZub0HMDG/7OxzEvJmWtZXTXV3
 Vcw7KUgmA7dJhp6n/52sbn+PUIYgmKsv77tLwewwCHah5jwwZWF86a1F56+GleAhA04l
 c+PNGqkwfHeoVf34f5kPGAEy4Wp2AjeWxBBJH15hP6ID1vlYTF2U1xhWDd8YkPD932D+
 kLVrlmFIpVa5GHRSRR/yPs79ljen+re64bbng0kP/M3WcXkMZTdCjwQASJU79irQa0dA
 lA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753391757; x=1753996557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+TjmNVEz6DVk3s6XDfI+vlhacHs96fJlyqwAsOGJYe8=;
 b=ic3QAv9OJZNtzOMi/AOhPC0bwNM/VNrWL4WAnXdsw4j2H/Y2hCTi7gdmBO4wqhF6hV
 q/OYIP4EuXKWHgO02225L8fPkVfDPuAvkdYAgSTLjlgjK56KPG2SnT1P8kxxxC6XjFPl
 eOTULG5+iPw4BxXgFs5K8PRk7S680IqDUCtLWsf2A0DwYZgVkuQLCdY1LtpnokFY4XdB
 b0DcBIwb9yDJoek2d7Nm0SXVvmL3QaVp2s8Q8YsL7M2IUNgJEG4XdxO3zAIHdbBRPAFa
 eomVL0dMTGEddIwt+TBmDCLQAJ/67a7ocQe+/sK8OgTpwmbxl7jgQqGJ++yRgJF5ZxW7
 Orkw==
X-Gm-Message-State: AOJu0YzCTcM4fPsXn8qaiQQ26jv2MYbkbnW+eDtTBOdbc+aCGfiKhGve
 XR4Iuk59gyxjPC3/QzD+CJ0yTa5PNo+EYLNWyvwohDcmt2r1V7X5CSoy4/5+S6CtOudaPHtO44h
 Qq6Pd93nyrZ8Z4/eRaGu199xPaLu+GI8=
X-Gm-Gg: ASbGncva5QJXSHwqulUVroggDW3poDl64ndpif9ZbSj82H707TFYb00mqU9qW4qPFaR
 0pOyYUxLPttAIFfFDwJxKZ8t9Ykl+ckJf6Hfxzog4Lx8N49s+8EMD7WbN0fYXZyvoo2YWzV6uV8
 /jKd0GN8eAAJIVAV6852+V1V1eP0V4pn0Xvssxka7TbkJxBYw08j92ksvaBVGA4UsKKn95v91NF
 d9cTboDVBbUh9HdLWeePT8hkiScKeshpu1UZZQ=
X-Google-Smtp-Source: AGHT+IE8dCwjyUNvcwZdbMC9EvU3ib3z/XCdTWMwGH1l1g6cgHjorecRcUh7mjADc0zDYJbY27ldpybMcVFQGr3uTPM=
X-Received: by 2002:a05:651c:2105:b0:32b:4773:7a80 with SMTP id
 38308e7fff4ca-330dfd27fc8mr30757751fa.25.1753391757127; Thu, 24 Jul 2025
 14:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250722083119.64084-1-frieder@fris.de>
In-Reply-To: <20250722083119.64084-1-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Jul 2025 18:15:45 -0300
X-Gm-Features: Ac12FXzcqoiOAMJyhS5KFQhy2-y9VB6416jfI4L6N8ZI_Oo7KaoWel7MFIl2bio
Message-ID: <CAOMZO5ApfBWx8dZP0k0-i2Vervc-cWZRCp=AfA_0pS7zzr8bRg@mail.gmail.com>
Subject: Re: [PATCH] imx: power-domain: Fix crash due to uninitialized 'id'
 field
To: Frieder Schrempf <frieder@fris.de>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Patrick Wildt <patrick@blueri.se>, 
 Tom Rini <trini@konsulko.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Tim Harvey <tharvey@gateworks.com>
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

On Tue, Jul 22, 2025 at 7:24=E2=80=AFAM Frieder Schrempf <frieder@fris.de> =
wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> In case of the i.MX8M power-domains (i.MX8MQ, MM, MN) there is only
> one power-domain for each device. Therefore the 'id' field in struct
> power_domain should always be zero.
>
> Currently if a power-domain is accessed after the initial bind, the
> 'id' field is left uninitialized. This didn't cause any problems
> until the following commits were introduced:
>
> 9086b64ca071 ("power-domain: Add support for refcounting (again)")
> a785ef24487b ("imx: power-domain: Enable refcounting on imx8mp")
>
> Now the 'id' field gets accessed in the power_domain_off() sequence
> and the invalid value causes "Synchronous Abort" failures.
>
> This was observed on a i.MX8MM board when running "usb start" and
> then "usb stop".
>
> Fix this issue by setting power_domain->id to '0' in
> imx8m_power_domain_of_xlate().
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Fixes: d08a194871fd ("imx: add support for i.MX8MQ power domain controlle=
r")
> Fixes: 9086b64ca071 ("power-domain: Add support for refcounting (again)")

Applied, thanks.
