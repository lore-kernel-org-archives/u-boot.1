Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC9CCCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 20:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 769E88004F;
	Wed, 29 Oct 2025 21:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="moTum3Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7CD800B6; Wed, 29 Oct 2025 21:12:40 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD278003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 21:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b7042e50899so72922666b.0
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761768758; x=1762373558; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n2I0wLLE+7U2uDCGBP/Gpc2bv0BiEcboTf3mOY2ou0U=;
 b=moTum3Nh7qzPN7s6uyXQcdl+QzBr9p/obZeO3KnYOfQ6pew30r/bh/P6lP+46rK90F
 Y9Puq7HZoXSMXn7RVL51h7gTeB+b7i++wubqIHPnD06h5ppb1C1pXY/J4JiCzQ/kS4/Z
 R/GdE+Bd3soSB2IzAVbPmJVJUs2BS6uCytiGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761768758; x=1762373558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n2I0wLLE+7U2uDCGBP/Gpc2bv0BiEcboTf3mOY2ou0U=;
 b=bur2KVF1/nM+oCJNAnVtgIL97K4uUT0PV5tcTiV2RWRIvVonOFPWOJEDWuISPmSIje
 7q3jgijSyWpqi9Js/HgKfWxA/Dm+j5Cn5/jf5/9AB5/Bl5f4wXY+eliMRMWXrc1UdqkY
 MYUYXPTbDJzOcLGS2N62JajV3O3LzW7desqgwR9zlyeM73HRVtvBptK7U/uKPA/A7QjB
 QGq48YLfhqfQWb22Loatq3LRg5AtC03w82+6S7d89rMAESG1q/xPbw6gaUuWkoAiYdtx
 Ws+BWvWo8YcvJCj+0GGqXP+ilv9bAmM+Mij6E7rr9dOq85JHYCgEdF7A+a40uZJv1s6C
 XhyQ==
X-Gm-Message-State: AOJu0YxqTzVIsYhFNQOi0aes86PuEActCiSPaU376JmPFSopiOpLdTLH
 GiBmcxPq5eUOk4HkdEDizfO1MLWV2wDXHyelZMV0+avI/1VzI8ZnSt9lO421NXBHYrZOXzH2258
 Bovo3XcnenCbMT5rmZfskJiM7H+un1AqO05ZstlEw
X-Gm-Gg: ASbGncu2+zPh6ZVzZjwdTsNxWjetP5LJpAbhXQQJoicjqYq/NYNLPTKiV4Tp+myPShs
 I/6+4ijazBD3rCJ20ZlET7IeY2LsDb2bZ2S2EFIhoRXGBrD+EDa0K6sLLfaicA+kTFRpWuPp/E7
 kni8ITxrbrULIRjAvvPsBqJyeAPG1n7Ciq+U8oqxErBKIxUzbZeqs8HQhGYztEoVEARnl0J106P
 MyLogRg/JZPmmtyZeuZLaf2K4bvagilwGLKUOF/CX8usB0NWBOE6gOLGhA=
X-Google-Smtp-Source: AGHT+IEgcun6sMqFTMAMA0F5BuzvR5pcSjbPSukineeN+Ws6UDHsoube3eMkz66aUH49b9nA2QCDB9pU7ufYXrwmRJI=
X-Received: by 2002:a17:906:f5a9:b0:b3d:c47c:7ce9 with SMTP id
 a640c23a62f3a-b703d5b452dmr443873366b.54.1761768757895; Wed, 29 Oct 2025
 13:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20251029-vpl-dm-serial-v1-1-7117f541511f@cherry.de>
In-Reply-To: <20251029-vpl-dm-serial-v1-1-7117f541511f@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Oct 2025 21:12:26 +0100
X-Gm-Features: AWmQ_blscdquFIaFa0Y4EGwjHyjrr9qdarX2ivR2l_zlV8KAkPnk2E1jPc6WxDo
Message-ID: <CAFLszTg4N7c+f7TRPZoND7TQJcogj1L8SSOgw4LR-oEa1tkxqQ@mail.gmail.com>
Subject: Re: [PATCH] serial: make VPL_DM_SERIAL depend on VPL_DM
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 29 Oct 2025 at 12:17, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> I have a hunch VPL_DM_SERIAL should not be selectable if VPL isn't set
> as implied by the prefix. Additionally, still based on the prefix, I'm
> assuming VPL_DM should be a dependency. Since VPL_DM can only be
> selectable when VPL is enabled, only depend on VPL_DM.
>
> This mirrors SPL_DM_SERIAL and TPL_DM_SERIAL so seems right to me.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  drivers/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
