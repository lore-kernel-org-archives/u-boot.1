Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A257FD5E378
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 17:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A5188885D;
	Sat,  9 Nov 2024 18:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UppmwoqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5981388D90; Sat,  9 Nov 2024 18:12:16 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7172887E30
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 18:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539f58c68c5so5692439e87.3
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 09:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731172334; x=1731777134; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/t9tgJ7JyQwH4tkpyDtv5Yl3/U90kYWmABhOAZt6dE=;
 b=UppmwoqNW67pswPeilL1iHs64Erq7B2Xuzm64c6H08yEItv8E7IoYQFYLbzPaHoPmL
 5PZulXJnkCnJZvNdH6Q5yFDlG+UiOpslFnA6mWUNHZVQd8YgiWWkgLi9vOxijKP3oPes
 mT7oXwdAkiKM5a5/aV1tYgWk3IK9zc0wT5OyKtgip8n5xibSe2y9zorBlPPMaT4AB+un
 PykX8TTWPZLULPCCq1MNVj4hM3NzNggKTYGae9LDg80TK64OACjvDaDPv61vZ6kpL29s
 oDHK69z+9e2CuKEYbP2vKyT3muNO9xc/frJS99rgIDgutC+2WL1m36jewByqSbrKQnPy
 fDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731172334; x=1731777134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0/t9tgJ7JyQwH4tkpyDtv5Yl3/U90kYWmABhOAZt6dE=;
 b=MBTY0jm8137TSS9FZwV8dfleHpaOarVeQj/hcpjk3SNlbIlMkbnP/GqFs0jG6kl+PG
 6Zl+LDbV6nm99jJLFPdb+WKRtCW0yN+BvGQEYjkmlTB1RI8p7T62VbkMpbqQK4ztfek1
 xOzdS21iEVywNKqVEWt4lWvGOsil/bUREx0x/sikaOulUaZXCmh41DTKXt+0WVrC4lSr
 ipFiFqQGiKHOXAvnejCGGGT633evyi9BmyRd81Rp3kALfeSgJqVpeXSsN6RgLvG/wz20
 9MkTZylQsbpvK+ejHKx9MhOw3Lh5tPTLImC2jg1kcwfKsMAUUSnI3G4++2sa073zTInG
 AYHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtQG+pYTMq3VkW+plEnrW0Zcl2fVQUelzV7AetskkYBZwNgXHvwnpHWBnCZS+3wGROK1ZdmkM=@lists.denx.de
X-Gm-Message-State: AOJu0YwVl5ZrhtgO+/6if/R8c/tvHGxTBo8Ws9LccR4+AiIxs+dNI8lK
 UhiNLufEuLYcpRUGEA/4f8azt0NpMgHcleeDz2QTq7r11j01Rphk237XGcv+FA2IU0J19EG9Jdn
 ej9DIODMy1h2M8kVa+0d3ssmOaF14KA==
X-Google-Smtp-Source: AGHT+IFuHKhFlPoASnTTq2YlPSPj/YyTpltQstc8haUtsPY4ELEcqZnpkl4dfAhB7kdpANMIGTVBQc7scwEUkU8mLFw=
X-Received: by 2002:a05:6512:3a88:b0:533:483f:9562 with SMTP id
 2adb3069b0e04-53d862ee7b7mr5144175e87.42.1731172333566; Sat, 09 Nov 2024
 09:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20241108140356.483-1-ian.ray@gehealthcare.com>
In-Reply-To: <20241108140356.483-1-ian.ray@gehealthcare.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Nov 2024 14:12:02 -0300
Message-ID: <CAOMZO5AJ-b97enXbrhe62CwtX1wP+N0hehApz0HijSLH3TKmig@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] arm: mach-imx: move snvs module
To: Ian Ray <ian.ray@gehealthcare.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Fri, Nov 8, 2024 at 11:04=E2=80=AFAM Ian Ray <ian.ray@gehealthcare.com> =
wrote:
>
> Commit 723f8359c1 ("imx: mx7: snvs: Add an SNVS init routine") noted
> that the init_snvs() call likely applies to other i.MX processors, and
> this has been found to be true for i.MX8MP.
>
> Move snvs module for future re-use.
>
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>

Applied both, thanks.
