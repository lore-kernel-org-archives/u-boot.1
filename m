Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BB1D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 09:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C2EF83A8F;
	Mon,  1 Dec 2025 10:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZRzzDu/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C1483AA0; Mon,  1 Dec 2025 10:06:46 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A82583A83
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 10:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c75a5cb752so2308405a34.2
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 01:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764580003; x=1765184803; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MmRZkViQHJc8/h6XC6e+TjqtGsRJlh+roWoDuj82LZM=;
 b=ZRzzDu/mlnwcorxjR1ExxafjF30Wua9BstJLA6sOoIplvN2dPfS0b61mejo+CJYuLo
 hLcX8e3bgh2brm7eQyAAcGadb9Rqp0ee/iwx2o2ULn/K3zXl/vUjRCXCSDAgic1Xd0Hf
 hT2py4ug4hb/CbGnvitbl8+FXCfocczbDJ1qgBEtEyFfoSo8Zwi9FGsap3wkn8ajZrjE
 KN3dB7rVAUdr7mp2G16zMQuUC+TL0l5HpWlJujsOHUocOdqUEztnh7DOSBxa/RN5a54d
 Bd2DDCmfSQf5NTpJMfGC8yDlpVXq/rtaUNV5epaFZxJ72wFHFyiPUoija6bKXhm1C5gz
 dSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764580003; x=1765184803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmRZkViQHJc8/h6XC6e+TjqtGsRJlh+roWoDuj82LZM=;
 b=mRy2HvzwIdJQT2u68fg1Igiyqt36FFwvuPoU00ivSA58JZ0oAnh3aanUnJVoUnhV+G
 LF3N+fCyWYP+kjnA5pGLBTHkmXDpgKt882ogH2+5AVIBAVMtM+enka1155gAEfDacpyn
 +MCw2bvL6BboM8gDnhM3WQb6EG9T8oF0csCrjcFc8LG2gZiislztVRRjWBawuKCLcLOi
 wD2XfV2SUv9l6gsmAdEAWHqTDBDhZB+EHNj7a6RGsibuoKaBpep2OVUrZPjNkIwDu7Uk
 fV7C5NNOOJ21SB8EoNrjSdMrecGQ9YKYrnPGIusS8ZnRSxQqnH6t3lOM7ShZGnm/7xoC
 vDLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpi003264uhWED2ayj7TQLpSeMReOz+oPlmD6VkYl2Fs5IJ9vPNt7kDVebVUUcyhWKhnFoklU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2ztdI0gsiDwYBOllDPR60CfpHzbPmcmFZpdwVz0ywXx9dHB4P
 +j7H6/cOTr+l+mhCHYzzQmHvuLM7s9uJMBi1ycFGrXt6XuCHwtyWJwWw5RKKDGRByTEdDUx+0AJ
 8Ji/J/tUopPVF1rxYoJNEj74Q7TeO2W+r+uCZrkM=
X-Gm-Gg: ASbGncvIyDjCyWdglSYy+rm6IxHzTrY53kA4mxGgPECgiUQL4VYoSn2VhuWzwXLMojV
 V3xIaMVzJy9gN7zoL3yoU7FQPng3G/XR/nm53oVZQwZYWXTYjnxQp6C1jzykkPMh6bMNg9xl1H8
 0JdlIeR+06DGXcHgIIIK01gSs4OBSFxQXyuobYdMVuLnqN5LlQpCY3Ayt2UNFZItF+W8dqYf2V4
 EQz8CUv1Oh230mGeKyy5X0Z3cWqoMPsPnnHYN5N2jXoMO2jDiC08shlC4aEmsUPyLNXnVpf
X-Google-Smtp-Source: AGHT+IGS4mHyZCoSrGdlZdd5AHHacb0RRyTlpVlrsAARKiUsrDyUgVmuOxjKDOhf2uOdDPpKUQk9zL5pLpmqF9G3/hY=
X-Received: by 2002:a05:6830:43a3:b0:7c7:59a1:48d5 with SMTP id
 46e09a7af769-7c798b89958mr16587537a34.1.1764580002683; Mon, 01 Dec 2025
 01:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20251201090407.616-1-briansune@gmail.com>
In-Reply-To: <20251201090407.616-1-briansune@gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 1 Dec 2025 17:06:31 +0800
X-Gm-Features: AWmQ_bmrWOS0TJAp_FWElAyirkac3RlV6quYPY0trbmD3_ntnBfYyQSxZIKiT3E
Message-ID: <CAN7C2SBCsNu1L8bmNwxirQcXsh-j5L8ijGqfyu8D9pBae=vnxQ@mail.gmail.com>
Subject: Re: [PATCH v9] Add optimized Makefile support for SoCFPGA handoff
To: Chee Tien Fong <tienfong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

>  arch/arm/mach-socfpga/config.mk | 48 +++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 arch/arm/mach-socfpga/config.mk

Hi T.F.

I had do a clean clone on u-boot and git apply v9 patch no issue.
Also run make full flow, conversion is normally.
V8 not sure it is accidentally damaged or missing lines.
It is corrupted somehow.

Thanks,
Brian
