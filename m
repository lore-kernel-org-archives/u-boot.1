Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7157C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 16:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55B97834B4;
	Thu, 17 Jul 2025 18:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cASZFgMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25533834D4; Thu, 17 Jul 2025 18:34:23 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32FD383496
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-32b50f357ecso10562571fa.2
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752770060; x=1753374860; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ps5wQ305ZAImYBRK00A+NnwGw5Ecv4SOZpJHFPvJEM=;
 b=cASZFgMfo+XDpFUnoVaSaGmeib9lYoqKQs2QGJqF81OHbTXa9M362/XGr0UkIPHWJn
 BPRzdq02A8lUdZQ1fI6ZnWva+EBZL44epPXE1ZihMp28hWs9Yh/C6JFurP0/Y8zI7cOX
 0sqq314AigPEW7EWYcJ60jlwbB2W78eGJPpBcOGutfGCA6OtoX5dtVKQw0k6AUYOh8QY
 6TlmynfHJJ5HE3hgBXeHLetLu3EjURyQHTkzb1cEyDyisWhVbMUUG/6+WfvYxKjU4Slm
 mslugscVbHWKIdkY8gkiR33BLCeoS48gbtBSdHrAxVuu678cY2op7NnA5X9iwCKo9TAU
 dyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752770060; x=1753374860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ps5wQ305ZAImYBRK00A+NnwGw5Ecv4SOZpJHFPvJEM=;
 b=FUMPGjX/b8fuBxncrpK3iEXBLwic8iGQy7t0OPvy/rkmZ1tSxbUv5Y2N7EQOzO13gU
 fyWAWZGpa2HD2b50u1DmtYyTEci64BLg3P0ILYtEF8mljcfad4hcpJcLdiNyUEWLLqpI
 iajNumT4dbn+QY+UO1CJwI/LhEbKtdh6STQZui+8it0PA5aNIszbsDamYDYyi6pmZ5C3
 xX8E7c2EVO+kHHNbDibBx7xsBTZioW3dBe5us/PwQRe+QlrNjA+Byvt54/X+tOHcVPh4
 Bx4jC9vwklitGgwLdFKjgplF44IRRsjaIZNxxay6u9qamQdHlghRFLGp6QeTpwXKc+Tv
 4rLw==
X-Gm-Message-State: AOJu0YzEh/CwZksjwaoVDcvUNP29M2oQ6YmOSdaxKYCUIFaajYggmj6P
 K2DYIf8AiPjWsBz5/G/QIDT1IVm8ZPCKqWfkIBw2lW6lB9u57fTKTiyyUTunD8lscZs42e3AhUS
 DUhhvyGMt1NTJA4rD0LnPvVd7bcppcyGmFA==
X-Gm-Gg: ASbGncuXo3j8WVfVQfWZLiiXCX/hdwIyieikDC5Ounqm2aExSue56dyjN805Z6cTyjB
 6MGk9bkSVlRzU1rb+u2NR5f86NwAh6t9Ojz5o4o3Db27bTR5UCZXiYA5bfQNgIKm1aY7m5mhb/l
 ks9RBAKSDS3Yf49Sm6sOdXBc+iAs9oHrbd0ELs11tq1cjUVYrqxJFOpgagoLlyg7/aCo2xAQvrv
 gPcGZ+/pYcZ4FSJPS6I5QVa3pC6w3a9vdol
X-Google-Smtp-Source: AGHT+IGxgzRzgra43+G394iVRapsCJRNAij7SNqospsyopbRpXljnsH1uV8MmZN2KWcS9GvUz60UYaom55VSfeYmrYs=
X-Received: by 2002:a05:6512:3ba0:b0:553:2c58:f973 with SMTP id
 2adb3069b0e04-55a23fb7428mr2133369e87.52.1752770060183; Thu, 17 Jul 2025
 09:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250714172304.4095241-1-tharvey@gateworks.com>
In-Reply-To: <20250714172304.4095241-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Jul 2025 13:34:07 -0300
X-Gm-Features: Ac12FXzCHnRM-KSPqhMcKsHNXsJWJ-YhF_e4y9iTTsvVy5X3rX63HUsFxh41Br4
Message-ID: <CAOMZO5Dot+UM=8NyBYq=7cNQ72sb-XT+4yFUOYQj=saufCeusw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] venice: lpddr4_timing_imx8mm: add DDRC_ADDRMAP7
 config
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
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

On Mon, Jul 14, 2025 at 2:23=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Add the configuration register for DDRC_ADDRMAP7 which was added in the
> RAP spreadsheet v19. This has no functional change but allows DRAM
> configuration to be patched in a later commit.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied all, thanks.
