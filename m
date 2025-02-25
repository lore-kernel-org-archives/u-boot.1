Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505C6C021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5BA380805;
	Tue, 25 Feb 2025 17:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x7Ulkp6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53F7680EC0; Tue, 25 Feb 2025 17:34:38 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B108807EE
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-439950a45daso36813025e9.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740501276; x=1741106076;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fHJ8ybWyvu4rsrc5bpVIsnzq2AXD/oc+sEBmM9p0udw=;
 b=x7Ulkp6H2xaHviHA73+A1TotQfRFKkBNlfxfM2cgeoCpbOpzOR1XPr9lgwjrqOzpNB
 9PumazztfwZEc/fsvrIY5VIZzVl0FZ2f5CkDyFf4QlQ75OueWJWQ9VE0qba+aPv77F+K
 FX7grFfcQLes3e7eALK3YPyMI4XZCe6NVIk7g7vOhGcuCmGT7CQT4cbYrfGGo1hLZp+3
 mTtOAdY2+mmJEE108/FEHBNcYxbmZo0l+Qz1k0+AqwOsugAEKCr9ww4m5FhjMKn9I21Y
 ojokwMci0Y2wRaWwlCoaT+LFHLxiWilzYnGaWRZKPRgDIydoQC/EmvwnkqaYqeik25Tx
 VgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501276; x=1741106076;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fHJ8ybWyvu4rsrc5bpVIsnzq2AXD/oc+sEBmM9p0udw=;
 b=Re0wHPnlFOLpPJa2PoI+ar6cU2eWLL5QnJnR9Hr6PstKUVgABDdPmyKatULSwx1yCs
 M+54JKkO6M3Hur33zuvXDg/1/NI9vsjNQSb0aOExh3NRzSWwUG2cwJVOW+uuSODe1jQp
 bLNNwhGQ+ruWXmkuMytdqA0X2Tgsxolk49E8hCezXE38qRL69yKyVw6OXkB7dxqYQJC9
 FeFQl7S/DQEKZif5WEtL/ixRKsVfDltiRBtMVAr+pDB7z9JRB+KjojxFlCrdBm9n9R2f
 qIGloe2vAd/1ZsbkN07NF4yYynBYnYg6CzmedWHxEmKIcjifg7cVq2zODMVCcaeVfCF4
 ysGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW87l1Rkvy3+P0k7QYPYtpWPcp22bZufShrux509WPCBc2t35QaRjNsea7Yr0t20y3dzAd2x8o=@lists.denx.de
X-Gm-Message-State: AOJu0YwntZeZkDw49gG3VGU6EP7giMKdqVqc1Osudh28y+Xzli2Mm8RN
 kR9ZOKaEZtyEf3NsEcWwCNPmlBISkNLtFe7MU7psrpRrB8WMh0NIHTJd6ttIJeY=
X-Gm-Gg: ASbGncuYFNEkYkg2J6T76ZD2aCHrJstYalhN4EfA3D18Y+F2nPMwkoA2WCAxUibqxCU
 0FsaOEar4ar+txjXSmUziZKCe7Q8fdXuagrVmhIJQmjg/Raefv/TkSlniMDwwPOqyxFXEtuiaTG
 b7C9gPepW4RaOrDWpiNIq5kqPw7ocNMCMw0l3YY04FGaH+KcLecoU9AYzY/VtPEHsJtdPlLzfi9
 kpDE3K73eQWzb2FEDu8HknrhEVtJiV2MMYK2cGI0U7DDvhgtIH7qgbzvsGhW22lnJm7V3puTZ+G
 cyAzWaVgRc725Ex2LrNOqiZzi08H/8J5Vus=
X-Google-Smtp-Source: AGHT+IGKc80xm7GGPaEFXljrkW5ltCXGhJvZ4btbQM72DlLmUD/n6RpSjxtqVkeYHZWgJVKcBNzObg==
X-Received: by 2002:a05:600c:3114:b0:439:9e13:2dd0 with SMTP id
 5b1f17b1804b1-43ab0f255b5mr34207255e9.6.1740501275783; 
 Tue, 25 Feb 2025 08:34:35 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b0371c67sm144673375e9.34.2025.02.25.08.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:34:35 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Dragan Simic <dsimic@manjaro.org>, Joe
 Hershberger <joe.hershberger@ni.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 2/2] env: mmc: Clean up env_mmc_load() ifdeffery
In-Reply-To: <20250221184732.202336-2-marex@denx.de>
References: <20250221184732.202336-1-marex@denx.de>
 <20250221184732.202336-2-marex@denx.de>
Date: Tue, 25 Feb 2025 17:34:34 +0100
Message-ID: <87bjuqf0f9.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Marek,

Thank you for the patch.

On ven., f=C3=A9vr. 21, 2025 at 19:47, Marek Vasut <marex@denx.de> wrote:

> Rename the variants of env_mmc_load() for redundant and non-redundant
> environment to env_mmc_load_redundant() and env_mmc_load_singular()
> respectively and convert the env_mmc_load() implementation to use of
> if (IS_ENABLED(...)). As a result, drop __maybe_unused from
> mmc_env_is_redundant_in_both_boot_hwparts().
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Nice cleanup!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
