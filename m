Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AECD340BD
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC50183EB3;
	Wed, 28 Jan 2026 15:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="czT1VzSN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97ED883B97; Wed, 28 Jan 2026 09:42:51 +0100 (CET)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B9D583B55
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregory.b.dev@gmail.com
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-5f52b3d98cfso2376061137.2
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 00:42:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769589767; cv=none;
 d=google.com; s=arc-20240605;
 b=Pw+BPzWU3EFoZ9HSpTgYA55QBIeU4z+++WuUxg7doMBYgfm2gTOVD3xaPiRVxFg6KK
 Vc4F7/hOTWwUNBUzCfwwpO9JYDCvzaL+HrmvhsROUvfw2pD1GcYJfm00UH3iECD5d8Wx
 9vX/Xjz6W1WBEeXoVVadI7U7fpho2ISG8FAw5zVLbQkgLcqnH//Q0byE+hSXeJ5bs1+B
 LXrbvog5Zbb4EnofEWgVlKFx9zaAMTJ7ofn48epXx0lMnHJmTAGruJu5qCcu7t70CAI8
 bNtLlR32VSW5CFotD3LPkr3D+hbDdzPRBQXlkluE/Mn7xnaWViin65w08sW5ZHgTCwHF
 dNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=pXxkfQ8zNB6CMewWw4+AOIXItHFbduKJs0WoR0w6egE=;
 fh=K4vm983Q2G37R7/BYHcY8BpitWW6ydyFiQ3lWVBV/YE=;
 b=Hg5qWOytC8+1SKIEgAzFuVInGsEKPpiYWRlIyKlA9OUF0ClBFpl0AnzWtLxCu2gMEl
 FDML2unPt9OXo+hYMZXwkrXtV1s0de9tODuEoWi/E2AW/RsJXDXZ584ve/cUrnBUW+5m
 xlSmE0QPLxWivcex15CpxhZ13fF8mapxmTpdLn4LtHAonYKlLIu5pvtD8bmDI8CBbJJ5
 oUO63Y8mmBNzOUavzKxlqHBm7deWFBfILJRG5sOlWyL7J4N+T+R7SN7ZrDmTdtlpwqks
 Ewfb9pRzviVBCCF/c5D32Octfep5XLfnYOOg0VV23JhMtJ1b3mTZ7rQdB/n7jNNJutXn
 kE7w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769589767; x=1770194567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pXxkfQ8zNB6CMewWw4+AOIXItHFbduKJs0WoR0w6egE=;
 b=czT1VzSNu7ety6VOsFrcs2W6IJ+qm/fFq1RDVA22LNwgDuJuvnACERa/5rl8oI2YuG
 OurAY0lBnWLCZAkD4JDMcIYVOzbVMIl4CucWHlmogt0uq/2Ey/YTA64JuTmwWoli7g/h
 RrSjbr2ZRnHHKVUoVMglY4g9cIIVmOkmsGarqNxhDSA0q7Il0uJ2/LImuG0BomKkKmJM
 6cTybZQS83/mASyJq5N34wFpHXMZe6MMtcZy30vrdU5kb4kKWMcGA/lRnyQCe3N8hcws
 W4JdF9ZhuE3rJ9eTU2cYSMM26vum6LOVxqJxa+KPGTgSCSY9lPPQyc0/qL5sJQllUk8j
 b0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769589767; x=1770194567;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pXxkfQ8zNB6CMewWw4+AOIXItHFbduKJs0WoR0w6egE=;
 b=Lq03gnmgNidoXJdAlVFChgDAfd6YitvHh3nonzFCMj3CnJ3lCgRXcgM0a1s561cYOk
 ACgqaC/w+EvA8SpZ6ldoPQRWeXatBdzHMaCufbA4zasia5SEG3k7/SOrsnBTK8z5YUzH
 JmpQntM6ab+C3w/6d1pUIOIn1mDoSdTiUqlxBNpPu/dc5KTvn9ZPp/ouxLTCpNcrRQfu
 CUBrvRv1L16yT7JWXQiRIAcAJG5L/o4QUEn478doe5e4bZvhQAUA1uCD3fL6utu2ZrFW
 abwxgi1VxKAPcRaAskJUT8pNkexiXnh9010fsU84nQL8M3W1FRQnHixR9ii6inD/Mzz7
 y+1g==
X-Gm-Message-State: AOJu0Yxy7nCCfY/pJXoIn2ASrEFR+nlx8KgPH2NN6uKHdbqwya/8uINf
 hMybdBjuqNve+hRdFVoAIM39VVrd3G0fFX47awXebVKVGrBLvv+EbL25R77oWpYLbw78hzbCUzm
 7G9kdYkZOTKc20lNq3sKrUtfAOFrIS64VFJw1
X-Gm-Gg: AZuq6aJDEpfmKYX6KADmlb/4HuEjchFY+WnAr8I1dBNSMK1jFdeDOUnbZ1gyzEQ6M37
 8jeTc4CIYZT0oeDjU8sn3L2q5bZkZUji1J/2NvpnI9AepesLvLoA0iqKrfJRS2DxO8fimLKf+CQ
 XdnNDSEIjBkbYcFPqAARfQTH9w/k4X9/rzH9IUf1aNjzeIseueIBdN4v3mPaYwFgYFzb46aJo/2
 vko3AuF2J3FvoZKkgZDI4ezbZLuMVxNES8CNV+Ut2dRaMnosy/ey09oO7diFbuS2vTgvZA=
X-Received: by 2002:a05:6102:d86:b0:5f5:3c38:c4bc with SMTP id
 ada2fe7eead31-5f72379c561mr1487011137.23.1769589766703; Wed, 28 Jan 2026
 00:42:46 -0800 (PST)
MIME-Version: 1.0
From: "Gregory B." <gregory.b.dev@gmail.com>
Date: Wed, 28 Jan 2026 09:42:35 +0100
X-Gm-Features: AZwV_Qgj8TlHGwlwnu-idlRv-eoFu01BrgVW_1NJzMfxOrWLWgJPqyb9LOpFYQE
Message-ID: <CA+ZXaAbay3Se5+ZorL6HRHzp-vYXD4Hk_n_NqHZNOMhk-o8M8A@mail.gmail.com>
Subject: eMMC standard update JESD84-B51B
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com
X-Mailman-Approved-At: Wed, 28 Jan 2026 15:01:19 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

 Hi,

There was a recent change of the eMMC standard at JEDEC. The latest version
is now JESD84-B51B.
The CSD_REV has moved to value 9.
The update of the standard is essentially to redefined the manufacturing
date field in order to be able to encode year 2026 up to 2038.
More information can be found in the commits of Linux Kernel and mmc-utils
reference below.

A couple of patches are now being released in Kernel:

   -
   https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=next&id=bf60037e32e963f8053c3372c438ba272b7c30c0
   -
   https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git/commit/?h=next&id=b40ebb75b7461c69ee4da1e49cc2fed309a96349


mmc-utils is also being updated:
https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git

I was wondering whether a similar update on the uboot code might be needed,
and I haven't seen any patch or ongoing discussion on the uboot side.

Best regards,
Gregory Baudet
