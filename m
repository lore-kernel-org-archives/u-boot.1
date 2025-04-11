Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C08C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B21840AA;
	Fri, 11 Apr 2025 16:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P2zH1o5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA06C840AB; Fri, 11 Apr 2025 16:16:56 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0F5C84085
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30beedb99c9so17182311fa.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744381014; x=1744985814; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/b2Lj+zcF95nRba+Pvz3KIJ6PjzDBc+VX1J+5akoOM=;
 b=P2zH1o5PGA2mRSd5V7i3SRf9ykQfm1HieKFnk/qW5cGL4BWcTBg7VEjPWjsXZRT48T
 Ua15ndfuMchZjNGqsbzAIpMhXytKguJfQlXqOjMMUnwiNi9B++AR24FviAOUPIygTMMN
 cPmtO7GLYw0opXtTSCLDvSagVN1nM2KOciSmhbZAapNXa7RLkPX7lYf7G6TQAldwdbEd
 xkrvfQWf0utz8j2Dy43kFBg/tqWRWx/ksTQGs1HW1azM989STw3vmx4TRiA+FQKTwJiY
 wXCpyXkjfAJApFsg9pIUKaiwHS1ApahmoeW6PucqazsAvVQN0Zr5QZ8Gya6f/NIhtoOy
 ZTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744381014; x=1744985814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/b2Lj+zcF95nRba+Pvz3KIJ6PjzDBc+VX1J+5akoOM=;
 b=Jk0EKTnh7hgEhtfuQ9LOy3aZCdBTiF/dAn6NYVBt/mO0ylIWQq+ICOwAfl2kLBIrqs
 4yqs8Ligl8k8CzmXcThsVTGhn8SGwbqoQlMiUfLKWi4Ol2Po8r3BK6Dl1iXiF30AxLid
 k+7fn+C1f6rNnSCNPv37SCyil7+DVQ4uo8kGlYrTgXBTXOF2AjCSU84ESWKozUHSBpau
 tYbi7iz2c202cBPVab1n0V2E7eK0QtxLfrvPTbweWIGwCCIWE2AWV+KnkejmhLTDvV5U
 E1vwi4W1QPGvJyBn9OCAM74zxOOddZ5kmtJkqQvgg4jcWmxshvI33DC6CeImxl3/C8Lu
 cC8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTfvmlvzrt2mu1E9iEyiGv35cj0f06x2Qbj1s84GRKmWT3Vw//bxaYEXcgmm6t+29RnUBtKHQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxFzZ2+EVie/s0RkVz42XUhVZ3rTnj+suVHPGEV1ze/iZ8KwJa1
 FAJFkKfUscWShk1PixUJ0UX06zlRxJ3w5OSqaZt/+eshoxrHE/GpDb0KQn6zNXl2UnIx/AgBaiF
 6jn2LFQKHdTNpAM9uGK/ZxsTX5aA=
X-Gm-Gg: ASbGncsUmtKe6/w43RRrHoxt84aZw4tdpQyPiKppaMlcgdjOlQ49EwI/pdbYJ3uD/wX
 lJRGGy6z1aqs0kb25+NKRjrs3BqHQYKJa8srVIz3UXTv/Jpj+kYFMliw7FL2gvt8GcMp/uRfzHa
 QuAPWyWTJBMCRRhNDIbnpVHwmNQgRIWcd5iRvZ1Hm6UYGDr0p0jmWsZw==
X-Google-Smtp-Source: AGHT+IFiRBa3UpuCQ4SBfyB9nLpmFeor7nf00my3nrVTnQ4X6oiqi8cXlTjEONJ3+CjAr7NXPVe34wj5Z5A0whd0Z1w=
X-Received: by 2002:a2e:ad89:0:b0:30d:e104:b796 with SMTP id
 38308e7fff4ca-31049ab3624mr11100491fa.40.1744381013699; Fri, 11 Apr 2025
 07:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250328102051.2614040-1-rafael@beims.me>
In-Reply-To: <20250328102051.2614040-1-rafael@beims.me>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Apr 2025 11:16:42 -0300
X-Gm-Features: ATxdqUEBa9LM9PYD3X2gDgzrfQ0BSdcuNRmCD_5Djx5LUKeNhyh4g1Xmyet8cRM
Message-ID: <CAOMZO5CZfxb1k9G4Nt=ZEWypSQgi-eeqYKJLXx1=Ly2t1EOzZQ@mail.gmail.com>
Subject: Re: [PATCH] toradex: apalis-imx6: Fix build failure when
 CONFIG_VIDEO_IPUV3 is enabled
To: rafael@beims.me
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 Rafael Beims <rafael.beims@toradex.com>, u-boot@lists.denx.de
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

On Fri, Mar 28, 2025 at 9:43=E2=80=AFAM <rafael@beims.me> wrote:
>
> From: Rafael Beims <rafael.beims@toradex.com>
>
> If CONFIG_VIDEO_IPUV3 is enabled without also having CONFIG_IMX_HDMI
> enabled, the build fails for the Apalis iMX6 board.
>
> Fixes: 592f4aed6db7 ("arm: imx: initial support for apalis imx6")
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>

Applied, thanks.
