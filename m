Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38359C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7427840B3;
	Fri, 11 Apr 2025 16:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C7MV4R2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D30CE840B5; Fri, 11 Apr 2025 16:17:37 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF4784085
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-54998f865b8so2010127e87.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744381054; x=1744985854; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3l9me1pke6Hgqs1dZ/u2/WVXOEIOzASPXq21OVKr++A=;
 b=C7MV4R2Nmv4/FoEBjVb4Baow2L+n+ry7TFCMYxMS4+LBo8rGveO7tmRn1t/okSc6ex
 5/vnK4jWVszGF5O3eSbAD6lsaIs0UGsRJkKRYEhG7KW85tyDahTGBeva3533+Amnsebd
 liMUIdj24dsfxeksgmlvHALskLlq1yRc5sHGJ36o+oCUtGt4YWOzeuSWlQKwfr1PndVA
 cKGaQCYXAHtqMAA7TMwoYa++1rIHATk5yPorTJnR+4bajb88fgD9FzH8PIMLmMb0f5E/
 vjh9V59okGsuZBheg4WK3UBJM1w2xLpyuowK29gJ6CAInHEIA2DJvmyCVphonJU6aoA5
 +F0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744381054; x=1744985854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3l9me1pke6Hgqs1dZ/u2/WVXOEIOzASPXq21OVKr++A=;
 b=R+1YjV5IMsPvtf/P1XAAHESIwpQqRqfgK2D7vlOuqcAbT0Y0zeLrZI7snkf79xXejZ
 14puqDCUJioNX6v3YAK4+Q+CEG97Y0t0uGi8tEGktYdaZZQ6ZAlkwLCEt+AkwrpXdrD2
 c30gBQKCPWGe74m2L5PnBX/o3noKbA4vacTJhzLZTRVo5/uMG5YpoCL4JlyRAkuBJoXw
 ONCyxtr+sQ3lzGa7kfImAiWVYZKDO+T6XeJXBWdDweNTjkXsD1TIQzUrhNdcGYJL1YyH
 hOb+aNBBhUS9qzy/BL8PS7LAFMddWpIjS0nkhZJ+pTSEEVofeTDTY8KU3QGpuKK2hfXE
 cd3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdJWyTVmOdfPlFm+paw/IaLyA0leUtKq94BwoiaDnRYoRKQ5CtkRO3DNegrZhZhGWM3qmp/04=@lists.denx.de
X-Gm-Message-State: AOJu0YyLsGwgDDXJzrwG3F3em7EsqNJ15IaMH80l3AX0TZJ0sej21Fsx
 z26FSs3X6rYwxyiXA/pr1x14znOmSaHeZpX+ypCZVZwR2MobZqVAaoj2udNRGc0DgYdOCmzvErm
 GaXJaVsLdRoMzG4v0QK2IgXdfjkY=
X-Gm-Gg: ASbGncsBkUAoRy1W/6eGro1vZ3IL4k80eL57bFNoYhTU4RqxI6UoJMurrRWGIMEwHR8
 AFSh2Yb6rnttQDF7e+LHJgKe7+lY0SZn2aYnl1+yexhspS+trk9n/xgfmUysLXIIW0pl75aRuUK
 ZvUylolJ3ccfYireXW4gzRQcY+gka11cRhZxqwCZEOsZi74NqSlclM1Q==
X-Google-Smtp-Source: AGHT+IEZpigteYBavjIIwTrX/dwZ8JlgM/rSdPeyxVbA94hrodymLosmNWUdeq3Ce91lVtpKCgJOTQzX8IyuMbPV36c=
X-Received: by 2002:a05:6512:3e28:b0:549:7c13:e895 with SMTP id
 2adb3069b0e04-54d452e275cmr1041983e87.47.1744381053548; Fri, 11 Apr 2025
 07:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250401075635.3802640-1-alice.guo@oss.nxp.com>
In-Reply-To: <20250401075635.3802640-1-alice.guo@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 11 Apr 2025 11:17:21 -0300
X-Gm-Features: ATxdqUH-kxpGHxDL89usZyqMMjAIqTR_i1XjMct-yalqrh7cElXfb2-uZv5yIq8
Message-ID: <CAOMZO5A3v+nrZ8PdS1NRaY1YcaZTD6AwSNujz2UKwPs6xL4oEQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: scmi: smt: Interrupt communication enable
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: marex@denx.de, trini@konsulko.com, sbabic@denx.de, sjg@chromium.org, 
 seanga2@gmail.com, lukma@denx.de, alpernebiyasak@gmail.com, 
 u-boot@lists.denx.de, peng.fan@nxp.com, viorel.suman@nxp.com, ye.li@nxp.com
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

On Tue, Apr 1, 2025 at 4:57=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:
>
> From: Viorel Suman <viorel.suman@nxp.com>
>
> i.MX95 System Manager uses interrupt driven communication which requires
> the caller to set Bit[0] of channel flags to 1. When transmission
> completes and the previous general purpose interrupt has been processed
> by the other core, i.MX95 System Manager will set General Purpose
> Interrupt Control Register (GCR). U-Boot polls General-purpose Status
> (GSR) to check if the operation is finished.
>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>

Applied, thanks.
