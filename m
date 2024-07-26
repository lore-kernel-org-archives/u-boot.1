Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342E9C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 20:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B23B987C7E;
	Fri, 26 Jul 2024 22:43:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DTlKBHs8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62B5C87ED1; Fri, 26 Jul 2024 22:43:06 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F3278780A
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 22:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ef2e37a171so2468361fa.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 13:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722026583; x=1722631383; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6uNfSMrT8WS6j+L0Diz0eEilXm9kHoomHsecxw4NPvs=;
 b=DTlKBHs81q+MtyVAmVKibndqLyqKb37PyCN7KZxVQi0g/EJxRQHoOPPLl5IlAc+jMc
 beBCk4O8g7utTKMEQ4ecDAb83BEE8/ZXPjhVMH+fDx3nMe+mtk1/c8Hfme9uS5kKkM1K
 4+OIaVSC5ezCpC/VMw88xT7DKIpuFmhpPeg/Vzj2Lduw3Db8QzmVMKHLeg10Vg4HP1Ei
 u+TiPMH89HauyndwyBBxq0OY4ahE20MpQ1OEPW4Ss3aHpeoqRGF70iC9vvyZbC8i/cNU
 tfHh9xmC6YTARcjzRrGnjGgQAuWzO5UtD3r6QawZ8mqPFDft7W2rwpyQEHfP8FBM1PIP
 OQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722026583; x=1722631383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6uNfSMrT8WS6j+L0Diz0eEilXm9kHoomHsecxw4NPvs=;
 b=hXKyutoGwAGAGd+CAyqyM/XhigRAdlA2KAfKdy4cbiWDKbTNKSJzZQ8J7AAbLWN0Jq
 Z7mZ4yt59FceM/IqW30U5YAcRX4XOBU/AcU9LFqpOZHkTijj2kUzd95d+bc3enzlsbf3
 BiTroE+CsKCO6WcqNGiUmhpLPuSV6iKKNbi1iuWgiOJsQscsocobNDL/6vXPt+AU6KLp
 iFJZyeWYScFf2CrJp3cC8xcTmxu32FV0R94Z+hXOM7jzZDEK9gGZRUujlipdBQ/HLJ/L
 W7KEAwTTMlcv6CiVqcnH/5fJKdZvsvjpkjq8YkCR/pVWQlhDa0EJ8Z0zIG1xe8aTUnks
 mR9Q==
X-Gm-Message-State: AOJu0Yz32ARVMQowf7njc7gcq+jA6Nd1NGrVCUFJXXaG1te9F4ch5gyk
 5R2E0USe3g3MzXNsAJJKRo+d/yxdUoN/rhULrWu6ngfujuQ/hDnPfdQiie154J/U6PpJqxWcZmW
 PWrfNpiC8IIMEJDazBylTqWRbwXE=
X-Google-Smtp-Source: AGHT+IHAh5/wxEiFo1lqE/a9JH/BY7icF/iVbEtmmvIpeG2KsGa3sKJjjIRrcnYoT6QqrpLLczph59t93GcpFtGddPU=
X-Received: by 2002:a05:6512:3f0f:b0:52e:fb8b:32d0 with SMTP id
 2adb3069b0e04-52fd526b79fmr2868740e87.1.1722026583048; Fri, 26 Jul 2024
 13:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240726175108.34704-1-Zhiqiang.Hou@nxp.com>
 <20240726175108.34704-5-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240726175108.34704-5-Zhiqiang.Hou@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 26 Jul 2024 17:42:51 -0300
Message-ID: <CAOMZO5DFkhSd9Hi=aHoJQ95aq-NbSfr=_X3cmOHUGvr2FH5aow@mail.gmail.com>
Subject: Re: [PATCHv3 04/12] cpu: imx: fix the CPU frequency in
 cpu_imx_get_info()
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 sjg@chromium.org
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

On Fri, Jul 26, 2024 at 2:30=E2=80=AFPM Zhiqiang Hou <Zhiqiang.Hou@nxp.com>=
 wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> 1MHz =3D 1000000Hzzzzzz

Please provide a proper commit log with an explanation. This Hzzzzzz
makes no sense.

Please retain the Reviewed-by tags from Simon on the previous version.
