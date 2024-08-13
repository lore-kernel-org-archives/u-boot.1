Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682BDC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 16:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C50889B8;
	Tue, 13 Aug 2024 18:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NsOelUGJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC1F889BB; Tue, 13 Aug 2024 18:27:24 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0135A889B4
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 18:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52efd91dd28so920020e87.1
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723566442; x=1724171242; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z978j74pPK8ebHmFCBJXGFHPqIElgKdI1EkjJppTaAg=;
 b=NsOelUGJvqHdD+FmedBwcOpXr9NS+qn6HU5WZIGzzSL7u9oAN/23ep4vuHpxs6YaLf
 HiJ47Wh4wPcuoFrNa9b2oBYnhPoXdxW3AqOf0SrCOUjPVkSwIV1LEkF1tGbR4aukznqd
 D+MJuT2BzWz8b+0LZAzeP+q41wGkWuxRSawQojwCJ4FyIFO3Rn2y4ididctgf7Txk6Wj
 FKv/EJCphhGlkXDhjCuutC5ovFDTCiqzRSEOanFGFTTfeH/5xev1pC2wIxU9CCC4gMP1
 algRni0Bgw3E+arLLRHB9nSmewre0uVHYDHf/8dKRaUuORUBLTs+FUb+crcbYj6Kd3gA
 OMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723566442; x=1724171242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z978j74pPK8ebHmFCBJXGFHPqIElgKdI1EkjJppTaAg=;
 b=I9TJ2fz9dvT1eEYH6aUXP9IehvAM9+UrV5V0aud2ZkUl5oC3r53a1Bd4Q/jgZ4Wo6S
 p9+BLJ+yozWnBAmRO5oEK9ab9RvsFYjTe6cj+GNyN4LIu7G0xMv3Q+QQeXdI/4q08mfb
 0jUId3pceqfBcdirTh8tZN49EtBgWGR2DPDvRqRL3tcYTMmv9wlym9cG+fVoNK60CdCd
 OionLWfoqy9FNqSSdgPFgr1dl8nFxIhWAfkjMXEIQbQPzlLsI1xUwiYMfrA/q9zFGUQ+
 JBac1/O6hll54voCs0+FsGc0a+GhIhj7NfeDV7u2lIqEkhcw0vgmXHw3z8VHQ3TQHQaL
 aWSw==
X-Gm-Message-State: AOJu0YxdPTPIGLpykuTaf6CjueI661zdx+BOMF71NM+S66Boy2X0h2j5
 q0gTuF6e1s5hkBotV+VkwtwIsFB5gsykDnnSlmAwUpfvKiuYQKiUsI3A2L6ALFI0WMM5ijEvG4/
 n+YCLWv2R84crFoDt/hSJpPclEDVn5g==
X-Google-Smtp-Source: AGHT+IGQ7lYjUdRKm8vA6BPsmhuOLXgnEyvKCLepuDK+b2G/2cQLLSeGzhhO4W9mxbi30ZvJtuJ1Kq9wY2cUoWUGXrk=
X-Received: by 2002:a05:6512:3d86:b0:52f:c142:6530 with SMTP id
 2adb3069b0e04-53215d44ec4mr877472e87.6.1723566442011; Tue, 13 Aug 2024
 09:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240809151247.539068-1-festevam@gmail.com>
In-Reply-To: <20240809151247.539068-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 13 Aug 2024 13:27:09 -0300
Message-ID: <CAOMZO5DTA5F=dHexES1ttX9fQoD8BLSnvaTR9BZvkDcThRN=Qg@mail.gmail.com>
Subject: Re: [PATCH] tqma6q_mba6: Convert to watchdog driver model
To: Markus.Niebel@tq-group.com
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Fri, Aug 9, 2024 at 12:12=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
>
> Fix it by switching to the watchdog driver model via sysreset, which
> is the preferred method for implementing the watchdog reset.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks.
