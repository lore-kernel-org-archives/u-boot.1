Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70255C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8451981026;
	Thu, 27 Feb 2025 15:18:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XQunS+79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C142810F6; Thu, 27 Feb 2025 15:18:35 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3133680F12
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5462a2b9dedso1013490e87.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 06:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740665912; x=1741270712; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MaSDHYXvcsTDMwuXafDj7rM8CcqTvaj0IdS3sBWIkqI=;
 b=XQunS+791fGrT6XlJlY2yxVYRZrZPJ31riEATbNPiNHZcZQ6LpwjqyH90O1jwrQ53+
 E2bRUtEqX9WDVZBYK7rlVeZbznafPkAQOG4uCFXiswE9BB30idaCrhmzFXDZxnuGmIHi
 //JXsunMlGPktwfGkxuJJ7ljY3Nj/6k/gGrtyPdtUzzYnklg/FQQR+TbcgtHEPTQ1CHY
 1fWsQ20QkEZc5AHqRlgGi9GGFuNmfDzFOpuE1LJ8FFD0Ma0W1nZbA9IRIBD5KtZ/lg9k
 boqTw48PdXdT/i4ERGBPWMsKnzdtPsJaPPRn71IXgaITRj+1nVLgbiwCDX5q9yZsJygU
 x2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740665912; x=1741270712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MaSDHYXvcsTDMwuXafDj7rM8CcqTvaj0IdS3sBWIkqI=;
 b=hvV+RNaHbHF1IpDwNQEk6FxyYkzfK6oa0H1HcXnSWpqL4euqjDtY6fS0hCVoAw8PVf
 tLg8Bb1FPPWFDZCLgeg6XwihS0vCQg7vfM6WyT3/GbAX5JaYp4tOgwSxhyz3hzdDuWmG
 9TKjdATz1sLfMnD+U5wpcW/pC++sU28qLMtOu7ty157WM8P7on8m9eEjbgbL+A5sySig
 4Pqv78Bfj/MM/LBpAFL+t0fHyhRUUA3GPf/bkrBaUCsPJMe5mwSs6z5ywl9VkYyWOGBZ
 3TF0YmeaNLVC+0bit/g/gBSAQ+YGh6I4f+oVIxRcbdVFEPaLtzasS+GJucpnQSzRgJYY
 43XQ==
X-Gm-Message-State: AOJu0Yyco4SF4EP6x00XOuitgl0pmp7v1lrNUpNc8nEnoiDrP4B+Y+/1
 HJV9Mt25WxDZMTu5Z4w5ribmaq2R8Js6A3nJeR09f4YfPOw/r8dpoaGVXPXnZyebDupjbiRJMaL
 wRNKxJZ1JsCyt8sty8+d8Rw+p7Lo=
X-Gm-Gg: ASbGnctb8x+vwfc77X5rdNyNjG+OHOho0nzK4M9q3Zzowk0Bwjqwx/A3mLBb0xEB3uZ
 dxt2yFu1g1ENYJM2LwoElbseZZcfVVgk/KGuPsGdXMB4TDkYQ5J562BBaMJVGIxOI6CQhVaZfaB
 aGvwdlIHhecc3qYT1vHHbN9pt3YtUIIHU+/x6jsfc=
X-Google-Smtp-Source: AGHT+IGN3mhkB2xseYdd94QkOgJqxboKkG2+9ZB3hKUa8c52OFEoYEEqnFftcq0aehXpWzeioCsvy4Z+t/M6o56r96c=
X-Received: by 2002:a05:6512:3d0b:b0:545:aaf:13fd with SMTP id
 2adb3069b0e04-548392717d1mr12725868e87.51.1740665912163; Thu, 27 Feb 2025
 06:18:32 -0800 (PST)
MIME-Version: 1.0
References: <20250221170818.184853-1-marex@denx.de>
In-Reply-To: <20250221170818.184853-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 11:18:20 -0300
X-Gm-Features: AQ5f1JoASW4HKxnJgyVCCd4YFNXQ8Ru23Snij2FeBUAyS8W2CN-ibG4nBhtvres
Message-ID: <CAOMZO5D=OxZjWsUcmbhdB92drqqfwconeDPP22m3se3dZ6UE0w@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Fix CONFIG_BOOTCOUNT_ALTBOOTCMD duplication on
 DH i.MX8MP DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Fri, Feb 21, 2025 at 2:08=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Deduplicate the config files again, move CONFIG_BOOTCOUNT_ALTBOOTCMD
> into common imx8mp_dhsom.config .
>
> Fixes: 940135eea5df ("Kconfig: Move CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfi=
g")
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
