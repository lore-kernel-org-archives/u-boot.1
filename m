Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD2ED2A53C
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F04188DA0;
	Wed, 16 Oct 2024 20:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b4C7s6Cr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0AB888D40; Wed, 16 Oct 2024 20:23:13 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA63188DA0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539ee1acb86so160775e87.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729102991; x=1729707791; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKsrXWxVenlhDTT0SMN/QsB4LCSx1PKfkAMVL0EVd90=;
 b=b4C7s6CreiIBv8c1LqAZAc5gby7KpIixTczrbHQe6HgEMMrtQiTnIZCOwaXiz5I9NK
 0y2XmB6uGjB8pLHEBm+xw+r8GflOoju5Oy9aMDoeWeomrFxb2qhNLYo465GgQRbBe0rW
 MHNjc3iOKKdv6KlyouECAAPvv/rwrhplYbpefh9oZQYCtx+uWgQ5DlrfmL0nOqF5KsEK
 9MqdkQHfG0jlsy/emW4hVKjn2OIl242fii3TQ+LfO9JoapxK6Xj5eJ7uGjNzfe5irBnB
 u4nJVeRiMZoV1dU5dhffH6keEB0JzKDg2TfJvZtlSUlsr7rAiNPbkEn1oCeOZ0pc8914
 59QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729102991; x=1729707791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKsrXWxVenlhDTT0SMN/QsB4LCSx1PKfkAMVL0EVd90=;
 b=LyX08UOFrfrcLdtpuBelGZbNpi+d8UleYRd5bLpXcWA61IWknz+ve4muJy9uajt5w3
 dyu8carNxGLFFXRTjh/IUoZqw7di/D891+L/w3NA3pTabFg6nI+CYSv1JvOAkNkyyBv+
 De1rswn8QWdB7B8IsRRuRg7jk/fHLn9IvNWXjrGi2WqNOn3/Bu+Cufa5K77K0s/6nJ9h
 5iEk1B/pvbNr58HDW5O1VBc2ly3E7yKnDGILQ7ZqOiB/2f8gUhdUUvrP8nCNoR/D75Zj
 vrvwsCrhcekEOVIb+9zSrKFa33b2HoZIq1L+NW9MSmwSqSa1S+7EKQSQVizx/lB0K8f9
 mX3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCGlMrrNHG/XZH5B45OwYTIC53u+bPXAMPk78QlKjpoX6GpgP02ILWAzVf9uh+nuTlySeE3iY=@lists.denx.de
X-Gm-Message-State: AOJu0YyPm9cT+qop/NERYIK9R8lM7RlOlUdXodN2x2VXVVOaIxGo2PEE
 aWPNFLX/EW2EDKtvRI5BIOz6esLIDBsFJ9WpXK2iBIX5GZcYvwXm7DPtixM8T9UigTE0BbuRCAw
 FsCZt+gQ0aA+7lpQ5uYw09qu9DV4=
X-Google-Smtp-Source: AGHT+IGadMlYfPvrNAawJg9OtkHSGLRYZvl+VWvEEsddLWLhhiZvlWqfoJKaPr5tidl+VLrNvCkSAEP6EpiKVppOXTE=
X-Received: by 2002:ac2:4e08:0:b0:539:e3cc:721a with SMTP id
 2adb3069b0e04-539e57316d9mr9298657e87.47.1729102989296; Wed, 16 Oct 2024
 11:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241011105827.7729-1-peng.fan@oss.nxp.com>
 <20241011165616.GW14210@bill-the-cat>
In-Reply-To: <20241011165616.GW14210@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Oct 2024 15:22:57 -0300
Message-ID: <CAOMZO5AAV+aHwn0Yc8yrojpvnHzrSsXGXbhi4WDHq0JBkgtHvw@mail.gmail.com>
Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
To: Tom Rini <trini@konsulko.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Simon Glass <sjg@chromium.org>,
 sbabic@denx.de, 
 u-boot@lists.denx.de, uboot-imx@nxp.com, gilles.talis@nxp.com, 
 Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On Fri, Oct 11, 2024 at 1:56=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> Why isn't this padding and alignment with the BSS being taken care of in
> either the linker script or the binman dts?

I have the same concern as Tom. This fix looks fragile.

Can you propose another solution?
