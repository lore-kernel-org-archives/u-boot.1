Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0DEC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C4C83900;
	Thu, 24 Jul 2025 23:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZV2rjZIp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6657D8390B; Thu, 24 Jul 2025 23:17:07 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B910835B2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-55502821bd2so1657137e87.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753391824; x=1753996624; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9b+Cm8Lw0H1VkvvtgcRFQLEZWcgkYkq1cf7fHInThIw=;
 b=ZV2rjZIpGE9L74FtNqgTIanM+c+FuLNpLXRyTSeCraqahANVLOAf17X80zXMbT8gwN
 QKGT3mnx23fDCOgoM7jfDCIeV/Dh+adLLKxDcNYDKTqE31ctMFc0G/ORu/qiDYgt0P48
 F4EpRHGOMz7dGIYsspeyaXoHXfYgXfr5SB7nIrR/zU9js7LMgCN3tEEcNPi4zlxZUZck
 O1KwVG1cMvYp7gmH3/SJjR7+w/2IBtnbThzXF92fnDnFwqai/LaWohgjur+miSbPscf/
 C2odgNk+30fGC8wnJIuvmHm9Gt8POohJQk84bGdu2KN3t5fSW5brZcZ1WnMV5g2SjkJ7
 /Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753391824; x=1753996624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9b+Cm8Lw0H1VkvvtgcRFQLEZWcgkYkq1cf7fHInThIw=;
 b=c2GKrAsdYgSZ+EzycMCycxWlFSzzkAyYafX/BwQd0ZNVaM899z1Tq2FxuPNHj3nXdZ
 8rFldzISL6O1ru7ZER+TZHzme7dp7uC4s7uPc7wYrCGYbrQSpEVQfcRxs+hiOsfk0Lg3
 OJ1CNbAkGgrKBcColv/AaIAGC/yF46mpMOX6201RNuNtpMdM18dsBXTZE6fOuN2xPy9K
 +kizfogXORqIw9jUMKdZLUe8Lv2S75HK51YpaKHRjrtnsArOjosXo66e63zgWvpgyb9M
 u9HTEOEFsdK6UYzCRGy2IaNAXWQbHmk/GoMvLxflvlmrZEPEpgF/5/wrY2eQu83bJDVV
 FRpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs6msf6MIcKv0OuaYJXRmWzdPTMuzz2u3Szj1kW0lrWrh0iMR72abkI02YSl5a9Fif7sRso4I=@lists.denx.de
X-Gm-Message-State: AOJu0YzjzgF8jV9jbgcHEEf4h2aW9ic4J+HqfHpwBgTL979NVh7dXEqp
 NbOZtyu04DRzW1MYjybeiyseqcuvDJOhDhZ+0ItfqV5nxoHuHqbC2SuNp1owvY8yWKmOmhCSlVI
 2Eg/0SKT8A0gksmz/Jh82qAVPLmNSPA0=
X-Gm-Gg: ASbGncuPsbMZ04Od5cFKLhC+be9nbk3fyUJ9jU9uMCIvguRTEERqfQ6nnwea3OhZQM+
 EAlgOJf2I4A1YMi0e/fIg9kXtnLROJAojC2wAQ5z0JdIsDQvndaIYIRI+eYQmR8qTFjI/G5U3IP
 5Y8cPzyXWdSV34jSZTLZRhBI8eRZZD1ifH0tJQ6cCIgRPm30a+LhHP6S++7qqWfXUpD0BZb9KMq
 yO8f84lqAL6CktVA3f7biQo7yihLZiMjglVHfY=
X-Google-Smtp-Source: AGHT+IEaOnKxbrWEsKd3Hin06MaP8CLmCJvCPGY2wLvoFYRya+bbQCnGtlSeEZWIockXmRmaE14FDEc7oIHEROg/kr8=
X-Received: by 2002:a05:6512:1104:b0:553:2c65:f1d1 with SMTP id
 2adb3069b0e04-55a5137e065mr2122233e87.13.1753391824309; Thu, 24 Jul 2025
 14:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250722-phytec-mx8mm-standardboot-v1-1-a389a801eb6f@phytec.de>
In-Reply-To: <20250722-phytec-mx8mm-standardboot-v1-1-a389a801eb6f@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Jul 2025 18:16:53 -0300
X-Gm-Features: Ac12FXyghxPUGZ_gK2T63d-X7Y_YoX8pcIAKvuH4nLaeAVBzk9Y2icl1qrDodng
Message-ID: <CAOMZO5ALPU3BHk8YR_F8R3gp5tpchc+0DjB9AJWd-6c9zdFAyg@mail.gmail.com>
Subject: Re: [PATCH] board: phytec: migrate imx8mm boards to standard boot
To: Yannic Moog <y.moog@phytec.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Tue, Jul 22, 2025 at 9:44=E2=80=AFAM Yannic Moog <y.moog@phytec.de> wrot=
e:
>
> remove boot logic from shared env file for phyboard-polis and
> phygate-tauri.
> Adjust configs for both boards as well.
> Space at the beginning of addressable RAM is reserved for space used via
> standard boot env variables. CONFIG_SYS_LOAD_ADDR is set to the lowest
> address behind the standard boot variables reserved space.
>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

Applied, thanks.
