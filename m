Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B0DC54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 13:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC5B883095;
	Thu, 22 May 2025 15:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q9gb9C/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D93DB8309A; Thu, 22 May 2025 15:05:19 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F6C8006D
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3105ef2a08dso72640661fa.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747919117; x=1748523917; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yeo623kx2PeyPEMLxg4fhlv4DSFIFB6bz1wgWzwS4cA=;
 b=Q9gb9C/bm4/9ZsFCLgtORVqpvERs2gR3S6KUZp9MVJAIYqYRzvbZnxfSBJiwEJdStB
 dcoB3XTv+WWQg27cEGJNuVuKfFRCshErAtQ+BgS44nyCFNjPSFGvNGZ92hjTOT18ZVPb
 rdxF8KiB7562l6dpgPqE8z69ikGs+HPr7O849Vga/xo4uvp5zi542hmSN8qXvcgF71OI
 CIGzWRVMR2yddKM+JgDDHZRRiDbro6Y/P9P5Ljus0UJkxki7/PJYwgS9qUKxrp418tnk
 fhlbIsEy9eeRvl1I8aKRlzW/ifO3b0FDWMggkKTDBWyeEG8mBc4daTNwEU5x7bcw0IK6
 19xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747919117; x=1748523917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yeo623kx2PeyPEMLxg4fhlv4DSFIFB6bz1wgWzwS4cA=;
 b=klpXcLMmX6s/ldquLfcUJk6XjUvYlLxsOLq08ZmAKQD8FCQZ8mNdGlBDukUTTqBgR9
 DTFYoT3auuEX75CfAvAZ5YoQiIFW3GFPUmmHukAVIRQ1kFHaA2Qrq3PGSA5He8oV2qTo
 NUfsK53C9UlKQWEjjkWkMv7+FzLV1Zm69017sqsC9lA3n1y6ACRBXfWuA40xUqwVJLJf
 RQI47/u3db++RF+iWe3uw9t3iYMbDENVPQJ/xSepFQLLxBOcFPwYClzccrThgV2cC/GW
 e/w1cKgrRaC5ja0odi10ZECLu6GEydBm61irmqXRVqw4X4zMJy5WAQsjB/KCg38rXVUN
 x63g==
X-Gm-Message-State: AOJu0YxDbAhxVj7B48HofBqOBUvAlVG0V5PEqN35hJN571fB7yxdcGVT
 SnKz/eCPLK/vBNPDax3wNLDIAblkkMlq/hEmwmJ5b7T51DV0UnpzEz05GHze//jLYvhKBb1DL78
 5KWFSwmnz56YrNVjmuR6qVVgDUC0u/II=
X-Gm-Gg: ASbGncu6JVmInmja2d3P1vcqDKkKayEIHXdidl3uk0sMQgtz7ue2oW7gBezcCbHAft1
 mEntUvW1lNTbBixSQCNisFiyBvCkuM9CpBYPmkPnklY3rkPPHWU8/36hG6wjDd+SSV7Pn1EXKHs
 rim1F5H+tRTq2idYyQTIyBuYQ/wXraHed4wugDZUIVQUmYvu+T/JjRpiVEchtx/KQ=
X-Google-Smtp-Source: AGHT+IEgBA5BhUxZc3DCHMMd2bPIsD0A4GyU0+fF3MYc6ggniZ9fJ4l+U11FqKJZtjGBxAmFVZdt1aUPC/tS0v3lVDw=
X-Received: by 2002:a2e:ae0e:0:b0:326:bede:ea46 with SMTP id
 38308e7fff4ca-32807734b0bmr81576541fa.20.1747919116869; Thu, 22 May 2025
 06:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250516081738.2524518-1-michael@amarulasolutions.com>
In-Reply-To: <20250516081738.2524518-1-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 May 2025 10:05:05 -0300
X-Gm-Features: AX0GCFsJdXNudngLasXVjPpENKFWOrSZhd7lRh2amEgzNoBNgsXaJ-T7r6XnwhM
Message-ID: <CAOMZO5B7yZB_oa6ZewevYaAhqOxoOjk8A0yeHbFRB0whjoZnXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm: dts: imx6ulz-bsh-smm-m2-u-boot: Drop soc node
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
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

On Fri, May 16, 2025 at 5:17=E2=80=AFAM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> The node is specified on the parent architecture u-boot.dtsi
> file
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Applied the series, thanks.
