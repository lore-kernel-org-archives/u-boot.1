Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7DAC61DFB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 19:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3318B83936;
	Sat, 21 Feb 2026 20:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ke1IqOZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03EB83A41; Sat, 21 Feb 2026 20:18:18 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C8B6801BE
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 20:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so1922762f8f.2
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 11:18:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771701496; cv=none;
 d=google.com; s=arc-20240605;
 b=Mb3qSdQ9I4FNRiDKMI2qfKVDDrCbT4kPaKO+lJOojaY16/KjTk6zEvRdxVonCIKBVJ
 6azghX1MBSdWKbx0HjcGh1/FUwPCT72u5TWAarHJVZj9UgJhcc7FUYFpmr//F9+UvlC8
 f5vedhLIfJo45WL3EWZUWTSMDzutfkI2+wX6u9Ym+y0wlsKscBgf0nEPTGiuqEW/TFMq
 SCyhe84epTTkxeHWR1/zW3e40VjycuppF7nT8hM6M3coiRLyxRlM7+HyurlJe01Uljl0
 aDc42lYBuyr4a2UJsTszZMtkZfsBNEu2Ti+/ShmOvfUKtU4Tbwva0+synHHR5XkdqtXx
 rLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=51w0FoCzB7SXLjokwyJJISjERWoYPSBvTKcSpws/QKk=;
 fh=ZRm2Qbvc8+cssm5odBVy9hTPd/7xqjUP3BeUkAH8G/c=;
 b=KtW6C901wgMFGrkP4SNYzBvvt/yqEIXlUI/iUhNh3Bu6xPqm+rCC5xs6Kb0S/evvKz
 a+SWSuvi5XJtaC4WDQMsd/e8SRuZNOGOruV/C2FhdKDxNmzrkTQ1t1MhqQr14/DHxTRE
 blU3bpOvafTSDmf8BJ2t76S5+8Qm7bNyiTtCx74b7h4V9Dvb1n/gjVfu/EJrvfQPUVly
 iRG3kgu07IVdffWSfUYU9kwwcS5l8T0Oa7qQ3reWPZUXD7Pml+a0l96n/kPKu6z03eMp
 dSi2IA2e43BpJuh1kk9tfA0lCkz7dbPb0l2P8XVOcvU8ePZb9GDucdH37Go1SiXGlnzR
 hxjg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771701496; x=1772306296; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51w0FoCzB7SXLjokwyJJISjERWoYPSBvTKcSpws/QKk=;
 b=Ke1IqOZxylUSs8puSqsHoSQ4SNTgumSWfytvsEdtvc+ILaB9Udv7wEvm6ZcDiJD4/n
 z9l3s+AEyJCQxtkTNZZWZwD/W5W3k3enAQxGxdNS+HHnaDHNdSdXEeH+/xUw1mceM8By
 PLcedqLpc9olAIXTAonZR4oeV4Vx2wHLmusS4sdgwiJ3Us8uODarxEo90rF7tkOohbkY
 KoqDk6hj4dDAnI5EyzDhlAjAqlWy8q6gMKg9TBJX85GrrCcPoqUxSMFdsPVgmK39XhxF
 JIvPeoV2QDLi6z7TwytSs0HzS5CYdtcXTS7Dv7m7NsttfGUdASG32VpU/Hz/kFYkaAmL
 vryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771701496; x=1772306296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=51w0FoCzB7SXLjokwyJJISjERWoYPSBvTKcSpws/QKk=;
 b=LkjUTAfPJsMYkALqqE+lA5sxC6Zv72srFmnPHVIhK3VNb2fyWP7SwYFaB2MTCjG5Qn
 DG+yV6/k8WPboqG2YflBzguIfuhfDFDSrtNqMJpyLKfHO4uftS5T87yuZuLkKAYIVSQh
 jP8elHPE+xpGtvfyyvjJDU27raGANMwKLbP/CRCYnAlPfDlY/irvUFvuG/wuPj6Vzxb3
 spzsXNr3s8lbftrWMsAHbaN2IfC4470aRCiCuXCLlBkJZOaUGulupEFq75DqitFTxyET
 rObwuJxCv5//3PmnQ+WJV+T6iyNnZ/CtDq20bWbJoBEDUa5Gzp3VNHsHwtVIFDhJbRA8
 ejHA==
X-Gm-Message-State: AOJu0YywRPIoErU7xe+YfBO8rf5YyJ++YhSa2Jtzil4HjBLglbLzMXmN
 I74tnDNpz1ve8kp1TWORdZOLUyY+mSi0lCDJB0mvUnMCKMFccugHqxXUuYgo84txF7ltgf8nSvF
 FQr9n5DXALRzq/Q6xKnDntKP4EwAXg/o=
X-Gm-Gg: AZuq6aK8oKwtDuNypkPEEgNV7SIL/aIIDTbGs4kafcAIKC2E57pfjwxSa2M7iMadB75
 MhOmePgpRExj7dt8jzqYjBMtmA3KJDoJTUD2rhlQyPYoSpxFA1MXO07D0vnbdG/Ex2mWN+8cpdi
 IDKaqFku1EQiFYssfU/vMpFcJSsu8imTeF4uzsTmQoEXTZzI6HEOYmEqLMjV9XrriV0jP+OaEQ7
 Wged8KgAUYmgAHuD/83Lq31+K9jmv+il2k3OoUTF2YY0KTO7APpbugV/q+yvqv0NPjV1c6uPt0Q
 EfWTJWTQ
X-Received: by 2002:a05:600c:6094:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-483a95eab61mr60035295e9.24.1771701496167; Sat, 21 Feb 2026
 11:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20260221174522.3106292-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260221174522.3106292-1-dario.binacchi@amarulasolutions.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 21 Feb 2026 21:18:04 +0200
X-Gm-Features: AaiRm50ceki6gcbVzTfEExM5-OFEcrpYETB_fWOOrMGp8_qUbdntNLZUhlhToAc
Message-ID: <CAPVz0n0QXAK9Q2KxVrc=ycteF6COQEvzaKr3CnFEnPKpnF9iKA@mail.gmail.com>
Subject: Re: [PATCH] video: kconfig: replace tristate with bool for LCD panel
 drivers
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ion Agorria <ion@agorria.com>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Simon Glass <simon.glass@canonical.com>, Tom Rini <trini@konsulko.com>
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

=D1=81=D0=B1, 21 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:45 Dari=
o Binacchi
<dario.binacchi@amarulasolutions.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> U-Boot does not support loadable modules, therefore using 'tristate'
> in Kconfig is incorrect since the 'm' option cannot be selected.
>
> Replace tristate with bool for the affected LCD panel drivers to
> reflect the U-Boot build model and avoid misleading configuration
> options.
>
> No functional change intended.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Very nice! Thank you!

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
