Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA700C4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 18:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 455E287883;
	Sat, 13 Jan 2024 19:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J5kfx0Bu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A96098798D; Sat, 13 Jan 2024 19:03:59 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D6D987134
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 19:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d5595997ffso11232775ad.1
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 10:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705169036; x=1705773836; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCq19zP8Z3OTfpbPXwgCEJLk+BcoLeeKbCnxuFPF9PQ=;
 b=J5kfx0BuTHFkxzQAPLqLRWZN8MzwVZxZ0MiJrphKVthjbORagUqTKvwdszN9B+Wlnz
 PSgCIDw3UnMN/xPeBiER7XRRHs9qvw4ojjYnI65llMrmV5JB8FlBJUD3JrDTf+7WEAcn
 dcU5rOXtn5jagAqA5Gv7Mn+xAaDnp14gkLPrqwaR5sVjIFOQXd9tCPW+awkADS7jZnMF
 WrDsm1JV8uwr71wLK3/PaahN6S5Cv4EIniZgvLOGe7CaSaH3iHFGyYHxr9AE5zLmZkqB
 f3bLYZ7du1y6tMaUqYCghyo26PuwR59/AJZVdxDdsXkQ1buuhF8jsZy6xn+nqu2q8Fvk
 nT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705169036; x=1705773836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCq19zP8Z3OTfpbPXwgCEJLk+BcoLeeKbCnxuFPF9PQ=;
 b=ZPi4FrF/cF3WeztXJKy7Ki+opLx20pyKlskJMIGyGNEzNjZ/os36Fsq+LVasqrNzEG
 G3S1esZBZa1A07FbUx1K98oo28WMj/wzyWZhjgqwFet50n6TP33aEfh06t7qtOtd8RfV
 b4KY8N0S/3R2EUBBQuwYEAjhjDoiLAF3Qum4ehenTAWR0+qcnIhTboAYH07hY6rJTWqt
 nm6C8ieIQDZkbkJLtGPje6luKuRdsh5/StzJRSfXUcyUXzMEdhFU6j0fo4CfaStXjOAK
 E2fy37xvD4aawe2Syac46wXv3ts5rvSVPTgMPKtqgqAvbKwf7rzPBofic8oLiI0gPRuY
 wn5A==
X-Gm-Message-State: AOJu0YxN/lo6BitRY6yLeY8iNJFBp1FqMXhq42YZf1JZ2BZaIaRvMEqh
 xhQKp/dlgK7cxv6wdjKK5JX4YAQDRpjDPEmWWKlya5EOXF8=
X-Google-Smtp-Source: AGHT+IGlDcHO1jyR8lPw2lNhHmRFFNxutRiOcaGzwcro/IHY/lpLuDPj10TBCoLqqMI5RecOC+mgezmtu1bcTH97Fwc=
X-Received: by 2002:a17:90b:1bd0:b0:28d:e180:5429 with SMTP id
 oa16-20020a17090b1bd000b0028de1805429mr5527270pjb.2.1705169035965; Sat, 13
 Jan 2024 10:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20240113175941.157275-1-marex@denx.de>
In-Reply-To: <20240113175941.157275-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 13 Jan 2024 15:03:44 -0300
Message-ID: <CAOMZO5C_nKf-xKiW2=vrux5EwNc_8GPjvL_f7vjucmF7EUDzBg@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Set stdio to serial on Data Modul i.MX8M
 Mini/Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>
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

On Sat, Jan 13, 2024 at 2:59=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> In case CONSOLE_MUX and SYS_CONSOLE_IS_IN_ENV are enabled, the console
> stdin, stdout, stderr must be defined in environment. Define the default
> settings to fix the following warning on boot:
>
> "
> In:    No input devices available!
> Out:   No output devices available!
> Err:   No error devices available!
> "
>
> Sort the default environment as well.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
