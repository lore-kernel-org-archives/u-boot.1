Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB13C41535
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 12:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFB2F87B98;
	Fri, 15 Dec 2023 13:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BWphCtr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B97087B7F; Fri, 15 Dec 2023 13:07:29 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DF7A87B9A
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 13:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c6e329bd3so574715e9.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 04:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702642041; x=1703246841;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zJDiVqfTvNLP62pUk9jgr+cJK94JsndqT9rR/tHM0dw=;
 b=BWphCtr9IOOdaOAlDa2H4ZtdnpkCOC/NmuesYJMh1dh1al8m/dyRqyJE/B4at5zGY2
 3Z/lg7uT2Vy3bmN6YpaGxRcVanIvU8VYIgpUJFXYXA3jmPsWTioxJZ4B6U304ruRqi/x
 zCCwuPtx3RK6OlGeTscstKkilG8h8wXuSGJmdMrtM3Kc0fH/8oaPjAXk23CHjrBHqjuK
 /XMeu7hwE6ORsYTOK1gxe1A8wfRMaBwlFH1kTPznE7xiIMqAozyLyoaEY03ZKe2jBNIs
 ZGPlDtca7/f+Bwj1NU6EoErfZZm0EADJ7mF9lMBW3m9TcgEZfqrDqSV6WVmy7pOIzoum
 IbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702642041; x=1703246841;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJDiVqfTvNLP62pUk9jgr+cJK94JsndqT9rR/tHM0dw=;
 b=qQuBh0iJqqjitLV3Jx3Hs8hWgbeV3U60TXTMM7nciaviLST4m4EubBbOiJrzsZw0fV
 gT6CLOfyeKo9r+BkD31p5EqdSRKpAPkobLRmS8X00GOUtRtcxRNHAqdqmUvXNYq3pFZn
 1hFMvOjH/SggtKMnVUI3F3EwXYWtWPwNOkwFHFQ8oH8mImRQQTZY+czCC/2BDOLG3TZr
 pFWLb7NIY6RcIQO9mWOraRQsutVIZkdLdt5+jegjqmuSaTv0U7AUE1CpnbpTpq12lMOL
 oPhxii9J3eRyNsY73+nA+oicK2i0NShP6VT9Wx60hiu6vVuRZgFKyGKqFQia07YJjMcx
 modw==
X-Gm-Message-State: AOJu0YyOylir++ZKUtTptfslvVx7A+Z8vOJMAMxtO51picBCinYYY/3v
 bKWYWKPqtdCvlRj5yX4u4euILGej2Kwl8A69FD4=
X-Google-Smtp-Source: AGHT+IH9b+ZyPWUrec7+Gpc3auta7aGn9YhyTBXCjkjnU5077X5NznLmbLITXgxTabPKjZ5rAcVL7w==
X-Received: by 2002:a05:600c:1c01:b0:40c:2ba2:8add with SMTP id
 j1-20020a05600c1c0100b0040c2ba28addmr5619422wms.117.1702642041527; 
 Fri, 15 Dec 2023 04:07:21 -0800 (PST)
Received: from localhost ([89.207.171.106]) by smtp.gmail.com with ESMTPSA id
 t11-20020a05600c450b00b0040c495b1c90sm18261386wmo.11.2023.12.15.04.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 04:07:21 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 09/16] doc: Mention fastboot dependency on CMDLINE
In-Reply-To: <20231215041919.2197788-9-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
 <20231215041919.2197788-9-sjg@chromium.org>
Date: Fri, 15 Dec 2023 13:07:19 +0100
Message-ID: <87cyv7u0so.fsf@baylibre.com>
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

Hi Simon,

Thank you for the patch.

On jeu., d=C3=A9c. 14, 2023 at 21:19, Simon Glass <sjg@chromium.org> wrote:

> The fastboot 'boot' command only supports running a U-Boot command if
> CONFIG_CMDLINE is enabled. Mention this in the documentation.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  doc/android/fastboot.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> index 1ad8a897c853..933a652538c7 100644
> --- a/doc/android/fastboot.rst
> +++ b/doc/android/fastboot.rst
> @@ -127,6 +127,7 @@ Boot command
>=20=20
>  When executing the fastboot ``boot`` command, if ``fastboot_bootcmd`` is=
 set
>  then that will be executed in place of ``bootm <CONFIG_FASTBOOT_BUF_ADDR=
>``.
> +This is supported if CONFIG_CMDLINE is enabled, which it normally is.
>=20=20
>  Partition Names
>  ---------------
> --=20
> 2.43.0.472.g3155946c3a-goog
