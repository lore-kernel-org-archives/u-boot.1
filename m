Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B11C35FF1
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 215AD80FF7;
	Thu, 13 Mar 2025 20:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lfW2lfT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A7AE8168B; Thu, 13 Mar 2025 20:57:51 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38AB380756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5493b5bc6e8so1473410e87.2
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741895868; x=1742500668; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFfmTdC7YCA+Y/jJOgAVr0uup1A6kT0hh0N1/2b5FIY=;
 b=lfW2lfT78/JcoQHmnyKHXHvhQY+f8YPib6sXAP3ZAhomlM9pPgZFElkVgZ5HBJ1y4I
 IDI98hC0Y9foMC3p0rRswVIQRkozizsTr9XCMxZayE4o8NgNqTLCPJUoWOqgSa0hC7tC
 rEz0Zx5j/OnxdXYEyR8yfYygonK1apkbU69Zh8s+0oqPFj7EHzP3sCEQ/AYl1QlHxuBS
 /O36EiaIdshDpvFNeXi6nqFJPkQHM04bqmhhryN0dw371CiDwiZSQs/8CEcyBxNeY3rB
 urGsnmh4Ip6Q8jAwkTW9mv6kUHkwesxmfaSobI/yT/kIXaaqU+9N+8crbiXFxKiCIBZv
 lyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741895868; x=1742500668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JFfmTdC7YCA+Y/jJOgAVr0uup1A6kT0hh0N1/2b5FIY=;
 b=uSAQtqKkogswylcjVB9BYV8OgLO7GyogzssVj0USOZ+10RvYtGW/P13tb1DSG1s0kf
 3jAUHiEY6JUMd8zL/MsH2UKx9H8AQbroXlB4YRBdI+F7yABAuH6cAST6wmxdkMwdxUDV
 eDqoDWknqoJVQKuOc8Jgj69h4wKVJhHG6AbNUtJF90VBtUPqcwOwUtUeyBfUrifxNdFl
 +xx9xr6bWJy6PfRBZY9THtuiHDXW9kPttMYHBBCLm04K7adY+lJxkU0BiBg8JOlc+du+
 GDfHMtKBsNEWcUOpDVaPPxjfsStJ3byEdFtq361MmGihfg5N1QZMCelF2FbwOTdDhERm
 9y5A==
X-Gm-Message-State: AOJu0Yz1TDeJ6cyS5kjP0w5ykjoMqIxQNoDxMobzXNXcJsivY2GyKRbO
 kp2B55Yzr3CZXkDG8s/T90Zoi46QbYJLvl4pAus5FwUTv+2DLixqvRnmJBoDI5YnR9jF7nGlsm1
 1tFiM6aK5CcJnjVE+LC/MF7QraWA=
X-Gm-Gg: ASbGncvj8rfVI8Ie4jRl+NCh2yBkVjgYeNpxPDmhul0Bsf2kg/ExFCyYBkdtK73qOJU
 5ZIasHAhtme4JYlx6XdmLOWdAkpvNh+i78aAz1NTYX43AVAxLDyB2AqL3dS0R6NvRGpMWusqxWE
 P8Y1UOitRwT3cp4GJdQME485In4Zh51+WSYliBCH3hANSb//JIpKw9g3jkjgnYEJ6r/eMp
X-Google-Smtp-Source: AGHT+IG3JAxNyvoohsmiyx4IlPElOSroLpqbrU04PIXfw4IwSu+G4Qnw7cocsZxRJ98ATZl9iP8Z4t2oprZobYMbvpI=
X-Received: by 2002:a05:6512:1113:b0:545:c89:2bc9 with SMTP id
 2adb3069b0e04-549c0a5b12dmr431780e87.43.1741895868170; Thu, 13 Mar 2025
 12:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250311013430.510151-1-marex@denx.de>
In-Reply-To: <20250311013430.510151-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 13 Mar 2025 16:57:37 -0300
X-Gm-Features: AQ5f1JqYEfNztZL8-vCg-RYjL1FblaSKerEWrTnVRXdLL1EHUsaOXixo0351iJw
Message-ID: <CAOMZO5BuSS7Q2h_GOOkhcDyH4UNibe9FJHvHBmB8z+Qy9ZJP3A@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Drop bogus regulator extras on DH i.MX6
 DHCOM DRC02
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
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

On Mon, Mar 10, 2025 at 10:34=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The regulator extras should be placed in the USB H1 regulator node,
> the /regulator-usb-h1-vbus. They are already present there in the
> upstream DT, so delete this bogus node entirely.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx/next, thanks.
