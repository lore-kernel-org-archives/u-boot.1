Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB91CDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7CE086D51;
	Wed, 18 Oct 2023 05:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="FH8SXb7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 687F586E6C; Wed, 18 Oct 2023 05:29:00 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 818C186D51
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c5071165d5so256961fa.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697599738; x=1698204538; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iDdGyUFuqIm4bdN7TOouAxTGC4bTsIzlTOhzqDvnf+Y=;
 b=FH8SXb7rSjUm+aqEKRxQWwOVG38zrWG77aXF5SqXIjzOiAk+b7l0oEeLR33C4hzfsS
 qYPj7qEXtAec3gaOK60DlIZpVpq8LunQN9HWE1z2CiMDh4dwxYz5np4qnDbjKhZOrxQY
 l5G59qCqo+EmkhkQDksA52uN0XsoxJ7qjbwnnqAem9xYDG9FcGeh1ujWuBraJ7w44rhn
 u2VoaRHbXqFY6ds+QOo/8oAslNriOQuLpxQ/t0UlePYq9JXR2c+wEemVW9Pfmj/LC+dT
 2Cc3N+uDbiUziBUUBdfI3DgVllE5gmlNyYpjWov2GyoRy9eUul2qe72F6t7sT7bGo1kd
 UiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599738; x=1698204538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iDdGyUFuqIm4bdN7TOouAxTGC4bTsIzlTOhzqDvnf+Y=;
 b=GryQr31Y8N+GrTAJZ3ApHUyDu9+XoCRqe2/Q7geARth6BPCKHHszLWQA4X3grYPQdC
 CEjwBlT2pNBgIyoahOkhGMA01/PynOgzum1eSSUViWu3nQOaSmWPuQ9moXviZ5eRIRnX
 dPI1EvmsRB1VxayenfVY01ARN/i7XUjgWsQYkvSPFSFNXYBR7XQ3KH7MfAl/CMFzLL2q
 K0zax5B0ovHiYf9jenWNpsaGhnFG7mJHn0gXlDS7NaqCTZ2B8itEmRENHYXB5Q6wswJJ
 vidGHmTjwl1M0TXbf2yz9qxJ3fHllfqbuZ6yl6i4A/Rt0xjwfpBMgcS8PE+1sX3vTZHf
 QdOg==
X-Gm-Message-State: AOJu0Yz3fWlLybITcc2tkYXTlyCdoojPkJDZGWTOx2qUXLOvtlYOWk2N
 0mcay7K+490bXkhp8KA/vL/gueYJtnFBonYn3FoBeQ==
X-Google-Smtp-Source: AGHT+IHHfMCeTtS60ZLnJNLmeOB9gz1rfTzPfh7OMu1bqVfWhvWyWON5OhhXeqcUiPOtAPKxrayGVLBsDL0nGBiZrog=
X-Received: by 2002:a05:651c:1a09:b0:2c0:20e3:990f with SMTP id
 by9-20020a05651c1a0900b002c020e3990fmr3143244ljb.10.1697599737470; Tue, 17
 Oct 2023 20:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231016215445.5970-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231016215445.5970-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 17 Oct 2023 21:28:39 -0600
Message-ID: <CAPnjgZ1g-WiSgLx28Q-LaXoXFNsZ4F2H3np=K3-Y8D6zkXK=Tg@mail.gmail.com>
Subject: Re: [PATCH 1/1] config: qemu: relax print and console buffer size
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, u-boot@lists.denx.de
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

On Mon, 16 Oct 2023 at 15:55, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> QEMU print and console buffer sizes have been restricted on QEMU below
> their default values.
>
> One of the side effects of the print buffer size restriction is output
> truncation of the 'efidebug dh' command.
>
> As QEMU does not have special memory size restrictions remove the settings
> from the defconfig files and go with the generic defaults.
>
> Fixes: d0ee7f295d74 ("Convert CONFIG_SYS_PBSIZE to Kconfig")
> Fixes: d31466b382dd ("Convert CONFIG_SYS_CBSIZE to Kconfig")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  configs/qemu-ppce500_defconfig       | 1 -
>  configs/qemu-riscv32_defconfig       | 2 --
>  configs/qemu-riscv32_smode_defconfig | 2 --
>  configs/qemu-riscv32_spl_defconfig   | 2 --
>  configs/qemu-riscv64_defconfig       | 2 --
>  configs/qemu-riscv64_smode_defconfig | 2 --
>  configs/qemu-riscv64_spl_defconfig   | 2 --
>  configs/qemu-x86_64_defconfig        | 1 -
>  configs/qemu-x86_defconfig           | 1 -
>  configs/qemu_arm64_defconfig         | 2 --
>  configs/qemu_arm_defconfig           | 2 --
>  11 files changed, 19 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
