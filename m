Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB7EE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 11:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B1838006D;
	Wed,  8 Jan 2025 12:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HlA8vPqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD44F800DF; Wed,  8 Jan 2025 12:31:21 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD9A780040
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 12:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53ffaaeeb76so17594274e87.0
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 03:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736335877; x=1736940677; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HyTniSAEei9LZZixL7SWPAK7FInavJaKST4mh6tSrWc=;
 b=HlA8vPqahptv+ap/o/RVTqVSDEr2Hb3kSB3+Fgr31CclZMoej1FPNa1XBl0Qi9bryL
 l570W8cOX2J/L7UaaG3Vh1yr0RPG81guSdIFeN6+KlKWmUlJMgq8jZq7IpcEyvViac1/
 /zIUk8V4TbNjoll3kfoP8aa5lZy4LdHu2GFX5RT8kS6YZTMVhRRL1QkK3B/CyC+WofxH
 V2RzlzwSOZ2DYbVS5NaiIgsG2RjPWQU1zWmrmVY6ZjDWF9jZpKNIbDu//aM2xboXDUey
 UjZYTUMbjQSdj6RHalNA8oQQ0xXodJC5lSOS4Z74Psm+5+Ik3hXTdGUqNvSSnIfMTiQg
 gJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736335877; x=1736940677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HyTniSAEei9LZZixL7SWPAK7FInavJaKST4mh6tSrWc=;
 b=eOYrvjNWHuZQMgsBgqX8klCF2d0v+2nQj1QdNhgfMbIL6GGBSq8EuKtHtXjeLEsmEs
 F2FYuTPtqJKUTRe2FRV0s0nStdgc+p1AtWhD1lFZhXLjU6fxQMhqyBWcw2/iB9onR/Ib
 gHKiB52wsdvwlICDWjJkuPD42lifgQG3ncPDTQbPZtJSSsvjwWttEqJejtYZehDYh1Vb
 W/DlzX9jRdNwYElQNnZ3Au+o8apfAWg8Tx/rDGSJSf/ivHkrtNEJe/ObeuCQasOmQl7C
 35W7cnyeuB5+htu9pjzj7z7kGrIyiYzqU7ndZIj91Uu+1hkbxnHCuKbIW/2iAEdkmQQ9
 cTNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTNAfvWf5oI7eEf2Z4efWb0OM4vnvNPs2fr3FpfbvveWVwNDCdSpqfekk54z2dPS17fs/Dus0=@lists.denx.de
X-Gm-Message-State: AOJu0YyBV6MyqrBqabz7s8IOVIPgz4dF7eV8RtrF4P2qt9dyY9KSk7oq
 xUp0GqfllNDkoLZ6XYn2FezmuwIZPlQgPqPfRqn+hwL20KxN4YRyxQotheyDxR/jbXyM+XX6yv3
 hblkJ4ik10iZrdWLTJxEl8JahlUc=
X-Gm-Gg: ASbGncuYcSprgQ08+HbAaNhrZfmd6bfLoiybIvgPipMvL2q0HB7CxoT7BRFgguP+UHU
 Bdy3g5sMAab2p1bwItHmngcix0ISf+NYdqYioPzX5K/z4srDvZdvllHlKWREDZj1plqoSxw==
X-Google-Smtp-Source: AGHT+IEUW/3D2pqQgPw8QYXo2ydA4VqCjerUeVWyc1ykYr2gBnYAIxHj6p2SqxoA17ombLBzuIDN7bNilA1vi0iIO1Y=
X-Received: by 2002:a05:6512:318d:b0:540:2223:9b0b with SMTP id
 2adb3069b0e04-54284801dbemr620865e87.35.1736335876554; Wed, 08 Jan 2025
 03:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
 <20250107-imx-bootstd-v2-16-97671b1694cd@nxp.com>
 <CAOMZO5CmznxHyaA7+8JDn-ZSbBi1jAX4DYU7w2R=a4j8mY7gEg@mail.gmail.com>
 <PAXPR04MB8459CEEBDA97F0CB554701DA88122@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459CEEBDA97F0CB554701DA88122@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 8 Jan 2025 08:31:05 -0300
X-Gm-Features: AbW1kvbRKDBDb6aa0NN6T-S3Nx8kEA21tai1oniUW-pZYpfkTwmyVzzNGii0C4k
Message-ID: <CAOMZO5CnSxQ-t+=a7iL6w6mQBJDVwF-87iVNr8S03up4prg+wA@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] imx: imx93-11x11-evk: drop duplicated nodes
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@denx.de>, 
 dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Tue, Jan 7, 2025 at 11:13=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:

> Could I just send out two patches for this change without
> resending the whole patchset? Or you expect me to send out
> v3 for this patchset?

Please send an updated v3 as it is easier to handle it via patchwork.

I will then apply it soon.
