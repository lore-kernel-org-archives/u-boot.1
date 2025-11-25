Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09FACFD368
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 05:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4FCA83F2B;
	Tue, 25 Nov 2025 06:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GUrAWuTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C291983F56; Tue, 25 Nov 2025 06:57:10 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 270A283EAE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 06:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c730af8d69so3115143a34.1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 21:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764050227; x=1764655027; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CmECwAF1HtDfwDux+cMhJMkx5QVMKuUUW6TL6MgX/oQ=;
 b=GUrAWuTAayuJ+4aNNcUPIc4nrcGw1a8NJNVzXU2Dcc9HYB1YZBL7yr3Qia1WZ2F20J
 AsOVcgRxMCfiqLGKLH7v+rrqhm93FgPJl3cz/sIdCU4v9qmNvHEgfwPedrtLHniZQrnW
 S0kwWVeL3jFGacxx9kXjyctpJ/rNivJzY+mvhcPHYCl4Liwxllz3n4OvELWlv1yDipXM
 Rk8URyXsnyPU/G7kJI5fYTLkR7BFv+2ZeNh4ozXOoGTSWwHTKobLFh8bUuwjcjOuWdam
 fsg+2mDVPFpdTCc2JnMbaPoNvRYqWq6I4PDzv96bBO5/CnZvAPVatk15dwBE15m5kdI/
 JVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764050227; x=1764655027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmECwAF1HtDfwDux+cMhJMkx5QVMKuUUW6TL6MgX/oQ=;
 b=AjDIAUM1SeOCKTpvhY821iTg1ANAUsRw426vYDkJnpod47vrEC5Av7VH5LxmpEKyNI
 5CeR7sp0Uc5DawxKI/hkFM+jBFxAkN8QKJkvyo25fz0EnhuM/wFuBKOZsxGa4sK33qUn
 ldRWEcKCrDbuWMkDYR6RX0/hu3VBv0Q9B3Av1KFWqfEX1Xg5vGkx0LQ99lIbcIPjxZit
 SrNUWt6QmB7KuZBANNDok2++eoRt7Mlaf6051jUPITU/T26nvAw57cEw+FmP+0rnNqMs
 YhUDSO363DQnhPVSokObzq3C3iRKaSJrzMP8G4bTaezuBdpWXszXwBTyRkUR2txbg0Mm
 ScpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgjWd2z+bdpfwwn1yYpJctHDvneuWTSom6dtjcKp39gAz2C1+ZdSI2x1/NqLJa7ZwR86j98Js=@lists.denx.de
X-Gm-Message-State: AOJu0YydPiHC2Mu3GDxODWoVzHR1upnRtyTKZgMlV0UaaKgeJDG/FaBg
 mXfkF05ZKzIsIbWeDIgRnRpJeV5C2GHR3WNSQb5bGjOAoko7gzJiqNB3ycFl58IHLo+Ws7zDJox
 0ueXzxUqgJYhXpvjG7UNVUwJP2KKK/iw=
X-Gm-Gg: ASbGncv1XfPf9hGx/WI1AspK7Xh8QJyqMpndq6bv+hXHnigdog8rSkvSwUBEvDbTw+9
 fpPL5SJYVRLoTzPMdrTdZuLUrMIgQVAq0/z4NskOZpTjX7UzN6WGo2qz7nU0MIJD7TYZlidIjLY
 tAecTf/89MLfvHp16DsqOtJ0JbwDWsr4j7x7n1KN69G75VtgSumf3//tf+AWIMYofw2lwEiWiEM
 oDjN8Cl5x5/i39xCCKDPrHWEiUVoDE1/79GHobeZ0zD/ayHsnK/iyRJs5ZxviajUF23hjD6
X-Google-Smtp-Source: AGHT+IFqBF9IOgKgPfHA2kaEbvCVjBGpdhu6aWDISLyGJiJkOp7CmBfBIDXZ7cNVYe0NgA2KXAeDCrtdM3wBNcj0O+o=
X-Received: by 2002:a05:6830:3156:b0:7c5:325f:f853 with SMTP id
 46e09a7af769-7c7c40a6b98mr810931a34.1.1764050226668; Mon, 24 Nov 2025
 21:57:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
In-Reply-To: <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 25 Nov 2025 13:56:54 +0800
X-Gm-Features: AWmQ_bnbD3gY8C8IvV0eb17Uigk9hZzzxjXX8h9Zbj5T-qZe_2p58GrG4f3J0c0
Message-ID: <CAN7C2SD8UUqJggXwgWSsaWjbdYC+SA8UKtJq74-dtQgtL89U+g@mail.gmail.com>
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
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

> SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR on some boards, so this calculation is
> not universal.

Use setup like my handoff scripts for GEN5. xxx.mk
Preserve a offset variable on that.

https://patchwork.ozlabs.org/project/uboot/patch/20251119111653.456-1-briansune@gmail.com/

Flexible enough and allow user to control when required.
But please first wait the patch is completely pushed to mainstream first.
And also documentation can be done to explain a bit.

Brian
