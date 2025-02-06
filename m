Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA12C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5708380834;
	Thu,  6 Feb 2025 13:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Uw0lnZ3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 621348083C; Thu,  6 Feb 2025 13:31:12 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6159D807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5de34b72ce8so472071a12.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845070; x=1739449870; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vUZHOGDwophm5ctdcagTIsT/u4V2ISKKsVvwluUvQo=;
 b=Uw0lnZ3hn12FWtg8sz+TtT36y4RkrsR16lEOrZi3qPnNNjWp5fvD/W+tLQzWEqcxpI
 26Kul47Ti0m7XzVIVAI6zNGZDav3xTw1a/O+7pjwWxPgLlFpFB/CzS1i3EV7c2ASJ6bx
 q4wXY8qaRCx0xpBHPol38tuCZKjPj/NHF74Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845070; x=1739449870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0vUZHOGDwophm5ctdcagTIsT/u4V2ISKKsVvwluUvQo=;
 b=JiDL2+4KG7mCKsGBo0Qu192c7ITOTMzZaSNmZ6cnQbNGwStW0FDGh4P4V1ODdyJwbt
 pcuz4Me85jd93c1fmzQ44vtBFlYh3VlQALNni6TmD49xZr3QmRj1S+AcQCg4k9X0lLEZ
 ASwjfZhAE8Wvs3sJX76iCXc6aGn59vlGNJMRQEuEzkHwTJ64Up5PGZ7QduYCdiLyhaVN
 M3BGhkBZAEMS5LgenPD0cEwinNvHVoqsWvPrgPTeTWGUcsNqzKVzqJldyz2Nxyfw2L7F
 WZlc4jGv6eNqPn5aJC+uVWLs5W7Ui9MHOAeFDKRNAF9lN9a3zgs80xkUWD9OZC7tcXPL
 F+Yg==
X-Gm-Message-State: AOJu0YxRi4E3J2iaJYPpKQw476PHb0330QMIh+E3I9SBea70Ou+awFp6
 Sq341eSnzG7KkUSf4Gjey1NKiX5/Nv+GF/sANOpJejxbeMMeQalFvM3LIlhq0Pnw673NkaCGtwy
 qjyL3v2AHzmhknLmwuEt+rIoc7mhwBBZb16Up0l36+2IniUwSGQ==
X-Gm-Gg: ASbGnctU3Onp9c915JnN8x8YQ85PKRwAGzfkKc0cE05UUtguVcvvu3BJTmPPImY6EQc
 WU4b4uI3jxwtCXZcVIpInoOVxCBb6BoQ50Kr0NEMEPRFNYIAWE74z7AbvXmkiXWjIxSvrq6bP1Q
 ==
X-Google-Smtp-Source: AGHT+IE6eWEz+9TMMd1uGIKcl98qqJQwk8QtHV7MzEsbmCzi/47xLV0z75ycencBdplR0EcywNOk1W9eTS9hIWv7u2A=
X-Received: by 2002:a05:6402:370d:b0:5dc:882f:74b7 with SMTP id
 4fb4d7f45d1cf-5dcdb77fb64mr8140369a12.30.1738845069695; Thu, 06 Feb 2025
 04:31:09 -0800 (PST)
MIME-Version: 1.0
References: <20250204205617.1238-1-egyszeregy@freemail.hu>
In-Reply-To: <20250204205617.1238-1-egyszeregy@freemail.hu>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:30:56 -0700
X-Gm-Features: AWEUYZkKsOXPgmWPVzXYgsFLWu7P0VTdh0HJRHpMJ2FaHLT84bJRxcLQ8obyuk0
Message-ID: <CAFLszThdhXWbKtaptExYEVm4Y_FaBPjx=LGHidGazX0-+0MH3w@mail.gmail.com>
Subject: Re: [PATCH v2] zynqmp: Save "bootseq" environment variable in decimal
 format
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, michal.simek@amd.com, love.kumar@amd.com
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

Hi Benjamin,

On Tue, 4 Feb 2025 at 13:56, <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> In U-Boot, most of mmc releated commands uses decimal value in arguments,=
 like
> "mmc dev ${bootseq}" or "bootargs=3Droot=3D/dev/mmcblk${bootseq}p2". In o=
rder to
> improve compatibilities, export "bootseq" number to environment variable =
in
> decimal format instead of hex.
>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> ---
>  board/xilinx/zynqmp/zynqmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 8cdd9d8600..820fb252a3 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -488,7 +488,7 @@ static int boot_targets_setup(void)
>                 if (bootseq >=3D 0) {
>                         bootseq_len =3D snprintf(NULL, 0, "%i", bootseq);
>                         debug("Bootseq len: %x\n", bootseq_len);
> -                       env_set_hex("bootseq", bootseq);
> +                       env_set_ulong("bootseq", (unsigned long)bootseq);
>                 }
>
>                 /*
> --
> 2.47.1.windows.2
>

Actually I think the 'mmc dev' command is the one that needs fixing,
as U-Boot uses hex. Probably there are seldom that many devices so the
issue doesn't arise. Anyway, I see that this is a zynq thing so I will
leave this to Michal.

Regards,
Simon
