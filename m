Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA31CC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7460E87863;
	Wed, 13 Dec 2023 17:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PaVcAgeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB7E087830; Wed, 13 Dec 2023 17:35:17 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6594E87863
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d350ee90b6so1289795ad.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702485308; x=1703090108; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bd+dNYd3oGbKavwIyAmyhqHKSWBjNGcP2v+eR2ALNI=;
 b=PaVcAgeSLKdXAORMM0/N6tR+agxqPnnz0i1FRLs+dxKF3vUljJbKD0PL1WJz87NKpk
 ZeHDG2t1um/v0OVjSNEaiNq3XqPoWt8OMhPnYFbKGvP/xr7puOIBVeHbM8qvuwLhYYKV
 BhMKWbZ4iKe8Z+tV9lo//MurdOW+fbVwfZ93CoXw3stFSm7vjGIDufuPPomnWvXAPROk
 +yoKyPvXjJmhLNCWcRSbdfIOR+4Jp0wUAOSEpOLg3bH3EEWyZqIPJzlPsXv0CLwwddLn
 qW3Tlmx9xiaK2B26KUMQMrpGkVq/lxp0lWbHSMQmJE4uBWypa9COG86njEdZNw2Sq8AY
 2mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702485308; x=1703090108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bd+dNYd3oGbKavwIyAmyhqHKSWBjNGcP2v+eR2ALNI=;
 b=unP3/SCEsb9PIfH/Zt+KIxssxqmiRFdwLMQuFV7qybJtABdc4DEd4O7VZ/cz3t35tu
 9cFEiHN4PFqaC9F8+bYVsgA8VP86MbKD1nGdyXTW9YO4a1kf9SB3Yd8Snd9FyFBUBhQv
 W8Ul64QYmZZwHfHv/jscDMGKHfmubgZdX5hOBLDSMwfG89VWlE61/UaSDflGWxF/saIf
 kKZN5i4pLabxPMrkeJ/Ojm6jxxBskzWYyH3JvVkr4oiGUHmtdkTRfL5WJMmXojZxqaxv
 PkJ00khtuSXQP30hZhqXJJJpzMEd/M3ZpgpBk17/bKTmmzWtlx9fVx6rqPu72B8c1uL8
 1WQw==
X-Gm-Message-State: AOJu0YyKq8vTw90O8T2w+E1cF2xHRkcAKz+I1rr/bW8ikV2X7QCV4tCm
 rZNQZh7mtI4/NUDIxFbXGp8ZtKmDxPTt9vVNals=
X-Google-Smtp-Source: AGHT+IFo+frvIn/gROKwwG2MudxS8LSRFSJWj50xdfzT8LblK+Ld4MtxDtE9jQWnWJ/0HZ0eqv+519PtbOccyBbBOms=
X-Received: by 2002:a17:902:ea0d:b0:1d0:b693:ae30 with SMTP id
 s13-20020a170902ea0d00b001d0b693ae30mr16315075plg.6.1702485308593; Wed, 13
 Dec 2023 08:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20231211100613.46650-1-nicolas.heemeryck@devialet.com>
 <20231211100613.46650-2-nicolas.heemeryck@devialet.com>
In-Reply-To: <20231211100613.46650-2-nicolas.heemeryck@devialet.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:34:55 -0300
Message-ID: <CAOMZO5D1cnHPGO3Vxf56tPYdrpkH5T9_mK-4Frx6POU-qDx_UA@mail.gmail.com>
Subject: Re: [PATCH 1/1] clk: imx8mn: add pwm clocks
To: Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>, Lukasz Majewski <lukma@denx.de>
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

On Mon, Dec 11, 2023 at 1:52=E2=80=AFPM Nicolas Heemeryck
<nicolas.heemeryck@devialet.com> wrote:
>
> Based on Linux kernel 6.7-rc4, add necessary clocks for the PWM
> controllers.
>
> Signed-off-by: Nicolas Heemeryck <nicolas.heemeryck@devialet.com>

Applied to u-boot-imx next, thanks.
