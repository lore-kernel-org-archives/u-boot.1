Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037EAC38150
	for <u-boot@archiver.kernel.org>; Sat,  6 Jul 2024 20:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844DA88444;
	Sat,  6 Jul 2024 22:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wbw4dNlP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC5CA884CD; Sat,  6 Jul 2024 22:49:12 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D072D881AD
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 22:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52e9ab8b7cdso323698e87.1
 for <u-boot@lists.denx.de>; Sat, 06 Jul 2024 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720298950; x=1720903750; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGNm7zFFRV1SrBYxHtc7GPfkEt2l25nTSOYIjwHI+jc=;
 b=Wbw4dNlPvxJESXeXe4yKUWcnTcPx8VjjMAL8RwwOZL4u2OoOK1QUD9cT1hI6okXytH
 ze0nd0sll+vg2RU7ruZt+Qw72bW3s7ZtE6VBpuJpxLNgG1O0NcCiDc21CFVQj+KCl6e8
 7EX/+B8FNGG3M1keEsg6Iij7BLS6Yl5QWMaBdM03D4av7FK5hV+BoMMZEK74yzBmLtp2
 RAbhqdpnQUn10wlfPLi/2GZ5U+BYUomyzXFstQnM26uv4AV4SXNZs2cbC9LStvPeUDE9
 ty9vxajnMkg5vdYTyYE63AKMwJGAm0qVE0gGF+38QLBcB1dVLeFJMSrRgwAzympMpl9z
 12zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720298950; x=1720903750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vGNm7zFFRV1SrBYxHtc7GPfkEt2l25nTSOYIjwHI+jc=;
 b=jUMYeuEFb5Y7UVfzdBmxVvp/m22jZQGg7JS6RUtCqfts5YJdkXjOfC8LRUH6B2pkzx
 LITyKwUzdEcgjEXENJKeosaXhT+aT+SThwEuIfRfDaH2a0GmngnJzNKBAxKaT95uHwBl
 1oLaY2nzS9GNdcplflYn9kOCaFBlv/s1uuhnaEzO6jqnYBmrQC4jtQqRLqrMl3odPlbi
 GkkDIXUEaf7rrr9bvOJDwc8wrTAjahhOLuSSzJ2TTgP5iQPW+GQ/OPQcINYdsS7dhqjE
 IQhYTFIXCDPIhTQKOBj8hLxhWedR/sszc9v70eDKHe0Jwu2M2fF4QsiuqOfzxphGpYWJ
 YUmw==
X-Gm-Message-State: AOJu0YyooaXoR86Rnc+GqRGDkO7vJ28OJVYruo8fI3U2Xpg6PU9P7IC3
 nswkyRPL1wvzZFkFMLGLpvIuXrvfpW2e18Rl3jBGg8I8KD1N6vO0y1yBJ9R/XACjYbXXqYtAMp+
 6gJtW/6EyA5QgLeD9+q4qfMpGwzM=
X-Google-Smtp-Source: AGHT+IE49e+aEUqUODz+N6rehO+WM9f0MN3P/o06XXCOGU72swizUI7HQuQyAFQq3RqpWCS2y57RmiKB0r5eVxO6FKY=
X-Received: by 2002:a05:6512:34d2:b0:52c:d7cc:33da with SMTP id
 2adb3069b0e04-52ea07a0bd2mr4202052e87.5.1720298949992; Sat, 06 Jul 2024
 13:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240627000133.274037-1-marex@denx.de>
In-Reply-To: <20240627000133.274037-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 6 Jul 2024 17:48:58 -0300
Message-ID: <CAOMZO5C15MdNxx0md5meCF0UVZ+wp1Smn1FQGrRZcd9MBexf4w@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable cat and xxd commands on DH i.MX8M Plus
 DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Wed, Jun 26, 2024 at 9:01=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable 'cat' command to print file from filesystem to stdout.
> Enable 'xxd' command to hexdump file from filesystem to stdout.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
