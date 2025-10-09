Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98020CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 19:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A90438423A;
	Thu,  9 Oct 2025 21:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j7M5S0qT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFE084241; Thu,  9 Oct 2025 21:37:23 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 334B483C94
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 21:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-57edfeaa05aso1688943e87.0
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 12:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760038640; x=1760643440; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDWVcZi4k72xwDtjtF2sMPAi3cnp2Dp0yjiPKV8NuI8=;
 b=j7M5S0qTRFH8t3oOPkGMXJd3Gl4cwx0TKNxfGoaeo9v+3nMfJ3XTMDyU5Qgumr1vdV
 9BiT0gmpKORBgqZIKYCuXZumssS/UyteSyKB0p53wj7EKUPH6MtVVA9DnDk+q1QMWJ0n
 RwvEpjrjCfGhahZ0GrVxqQrd6eYeJ6d0DDNnrw8igciJldSmGlKJEq9X0oJN8s8QrsPU
 t5qIqO1h9XIXx+f1oCmeWXYP+JkDp6/DBoFvY9RqDfbttIGqjMeio7WEBAS1CwISCFTK
 ub+EX2mWTuqQSofHTBG79ZLSJahI6aZewborMbYFTqb817W28UQ/iNzJSEQ8MPnX+God
 uUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760038640; x=1760643440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDWVcZi4k72xwDtjtF2sMPAi3cnp2Dp0yjiPKV8NuI8=;
 b=hfkgMlsswB5JaVrhLvUdLXdSqFREFVNx3V8vrlgoItJDyUWZ4FowPsy7OSdtTOHTgh
 OFuToJ60CaPEjyNsd4D62okHAi1GhMZi+4PKkrzzyf+POZU2Xlc3hlopvDHVSGxdwBFh
 uR2iVeDtXpBGyZ+c4AUHphx322Tv6loh/Df28ODqCLsON0OhbX7iKA9fdEXnkkT92kaz
 5jJ6i7FDnqONlOKrjs1RxJgWr3KWQpnYg7EqgYTCZYfw6ptT1ihf57LP+owHj/A+nsRX
 ANpOlQmOGaVIAufkeXY5zYVr9oanQF+NCct9oKjdOnbUBPGE0DqLCKwu9mTOsamy42If
 YvjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTFfKj4EKNAwUfT80qvuvP/l10CYX3QBwJO3wF10IABLxQ1WQk38Jjb7lRlU9Zu4e6jlW+NB8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4JSvFjgSLd2vU62/tiASzPcJUUGp2vE5Cz3C9ICmi7QdpsMud
 zqIRTX9G72KirHPnRSfkMXj1a277475JgWerEZeaHjsbL/fqKEglqTDZ2obhIcV+SKJA/pjNxS7
 x3WVPwtrDWKVKygoIMg5EjSefEPKmFh4=
X-Gm-Gg: ASbGncurFedFXvITqlrfujq4KP9RGBgLJ5Q/H3Dtq4zJ+Tw+sp6zGBGS1v/iE0EoC0p
 WxmUHDfy3la6y3kYqRL/lAX0zaaVyURi5Ed1om8J6K8CDd2+NhZiCQf8Z1cF2VM27EWGfk4xbd4
 WJH+lhM6DEzYYlimyaGKcqbZUkd/yKO+RBgYl7cqE1pCsgVuYs0JGJg4TKPdoEQ80kkfNHtJtLN
 XshWNqgr2R7LfbEL3f7znCQX4t+XVp56pW9QJQ4bdMj8T8HGLl0PotK+4be0LQ=
X-Google-Smtp-Source: AGHT+IFDL7LIfb/+M38BXHrMCDEncYSBY5TwLt25hVFHn2dBDvE2ypiTJcNK514vU9GISDJhrdEpJv0LR3gTwD1J8yk=
X-Received: by 2002:a05:6512:68b:b0:576:d5d0:bb81 with SMTP id
 2adb3069b0e04-5906dae6c4fmr2273636e87.37.1760038640330; Thu, 09 Oct 2025
 12:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20251007081640.61772-1-frieder@fris.de>
In-Reply-To: <20251007081640.61772-1-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 9 Oct 2025 16:37:08 -0300
X-Gm-Features: AS18NWCmlfr5xqctMxd2JcXNovUCsxPPEM0FJG1c5oh-e4l51pmur9Ej-A9MKuE
Message-ID: <CAOMZO5AbOp5poMz4L6+FKDKXJ=KhW3hrVXE3XMcFDKUjNAtbDQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Misc changes for Kontron i.MX8MM SoMs and Boards
To: Frieder Schrempf <frieder@fris.de>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Stefano Babic <sbabic@nabladev.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Andre Przywara <andre.przywara@arm.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 Garrett Giordano <ggiordano@phytec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Svyatoslav Ryhel <clamor95@gmail.com>
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

On Tue, Oct 7, 2025 at 5:18=E2=80=AFAM Frieder Schrempf <frieder@fris.de> w=
rote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> This is a collection of various patches that we have collected
> downstream and the conversion to OF_UPSTREAM.

Applied the series, thanks.
