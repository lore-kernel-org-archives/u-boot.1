Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DB9C83F17
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 02:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B08D5836E7;
	Fri, 11 Jul 2025 04:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eGwRW++k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFCB983744; Fri, 11 Jul 2025 04:23:47 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6B85836D1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 04:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-32b8134ef6aso14794611fa.0
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 19:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752200625; x=1752805425; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0Hz8kiZoDe2gvHrHzfS6kwiJf3vtbxh0lCuQBRl7Pg=;
 b=eGwRW++kyP1VWkzHm72t884wpRf4ednjAHYpcaS7GjCvUqKueYxkJkNYOVNBm5gXaJ
 kDIn1+jgWW95hXIbrzBx2xa71Y3fZIApnO85UZnOSCFGnIdDZF/x6S/KLhObOg5pPjEb
 U86wsxeD3/E4wKRLa6b6I0BYcasQ7uLbB1LcwZ9bSuEJ+lRKSs12s7YxDM2Tl5bArEI5
 n6lTGS0DVqLxPl+DDXNLhS7j/zs7M0R49GP8QAHotWOcI+rzGuUaJGzCxipo1SlYgmVO
 aa0lVoj9lVq3dADPWYpoZyaPRkG/Oe/klRfeAEmcLNr860Ie+cOub3VmTANgSYqjEfXi
 LnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752200625; x=1752805425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F0Hz8kiZoDe2gvHrHzfS6kwiJf3vtbxh0lCuQBRl7Pg=;
 b=NAFpfLwNyCvfCVVd5eFoYH5Ck6EO2U1WJ5vHAfQOO4JSDStWsVLpJnvhVZXJ2np0Fl
 bHr8rEdhdGGFz6huNryqWK9fi7SW9ny5uKYBIDHR3f4JY1nBRfIZuzZEBGtitbl4R/y4
 Kje7hjAEXhklcyfX3DTqGA/rJ/77Sp7jZ12sow3Vbms8FSPBWGMcZkt+a/eWv+4Vunk2
 Cml46+xOoXAt9cf84jcYJi87hAae3RSAYwpxxMLXHUzTB64AEwIQKwULJ9oY4gdcRvhl
 XxXBei5NV7Qh6Z9MvFxzqdpH/aIv5t2xF7FJwUJdb/t5023Wpm+QDvFeMmqAzO1tSGLV
 9WQA==
X-Gm-Message-State: AOJu0YxS7XC3pI8JgG5UyvrP2OUb3s9YJ33q9OZx9wZPU779Yjwq2kjs
 HH2b4VUa8ARGdNYAy2rFBXW2rCDUKsZxKo5AonNgbcCUHEOlI5ZJNtOEwjM9YFwtgCtnrhzVDqm
 G7xU/euUH82pMPpT17eDTuECQKbUyTUU=
X-Gm-Gg: ASbGnctjk4Ydtai5+nIYUXNKP4q7SecSjCtdElMaxZsKKU7GMG+ZyPnKaSSZOS0uzIx
 0h6Q7pinBH5cz1hIfG3xfrh579acZg11XRi8D8dSdmFnVrdXdFSd2RU1kIBS/EG2NlaU4p0LgPc
 w6m3twE4hnYSXbHb9JTloeLcVb6ySoqJazZCjEHf3wzFfN2KFb1Kicgj3kb0RPBR++cqPcfvCl8
 hHn4XLfd3ZzYbpof9HQ+cXawI4Bu/hzVRWc1FvVtJvXWKRG4w==
X-Google-Smtp-Source: AGHT+IFPijP0Ybmeqqg/zEkrsZoNDOlbUN3E2/85guKy4FN22NG6gNuBBpjYwD+feeYb6X3uTXCK4s70H3mBUnwIuys=
X-Received: by 2002:a05:6512:1598:b0:553:ac4e:c41 with SMTP id
 2adb3069b0e04-55a04608d5cmr291475e87.28.1752200624776; Thu, 10 Jul 2025
 19:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250702010511.19141-1-trini@konsulko.com>
In-Reply-To: <20250702010511.19141-1-trini@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 10 Jul 2025 23:23:33 -0300
X-Gm-Features: Ac12FXx1R7ZPQVOIta2EpnlpY_VsRqSBPUPjN4jbvPDx1qfDhPkYj9uVtymjM0k
Message-ID: <CAOMZO5DkasJP548K8eiQUAnihycH5f0bJQWhUoRmQ8ktewUenA@mail.gmail.com>
Subject: Re: [PATCH] cmd/Kconfig: Tighten dependencies on CMD_BLOB
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
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

On Tue, Jul 1, 2025 at 10:05=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> In order for this command to build we need to compile
> drivers/crypto/fsl/fsl_blob.c and this in turn includes
> drivers/crypto/fsl/jr.h which references "ccsr_sec_t" which is only a
> defined type for SYS_FSL_SEC_COMPAT >=3D 4. Express that requirement in
> Kconfig as well.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied, thanks.
