Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACC0CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 09:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442B0880F4;
	Tue,  2 Apr 2024 11:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hmCKCVAw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6492A88327; Tue,  2 Apr 2024 11:07:20 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D3387FDA
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 11:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33e9115d501so2173023f8f.0
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712048838; x=1712653638; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cz4IFU5UDpAClZ0E4VZu8ESCJQeLoWbrfZfgCZ+4piw=;
 b=hmCKCVAwmRJNcvaKjuxUne0sscvj3ylrfAXPMIT0KcTFLSzheVwg16eeY6K0OiZkLD
 8mxdfijrE6/QwtDS9/XiMf79Ow0g0hZ8H2CkvBNzdfTQi5MaEONJmgqrmI4/XOj8xgMf
 yRuvrL0o8IXxxw9us9qV3Irf01f9cHs9jY7fPaQfQHPJHyNIMbZUI8+8pr9phNsfZgIk
 1e0+yeFxujYWOXNpF4xD0JqWJmPryZzrLzSGu7R8TuTA/XK6Mm9CYFLBRKPvK8N47mC2
 e8n1b7q0q4ffXCFgSkh85kltCxJokgoEgbdYH2ES303acYJZQunDAWZsYaZynlcHqSLy
 a+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712048838; x=1712653638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cz4IFU5UDpAClZ0E4VZu8ESCJQeLoWbrfZfgCZ+4piw=;
 b=MyTvWYcL08DI0tUZbpizKBzlxEaMJH9Fz6H8czOoJh338S1DK6pGQKhx3N42fYneQZ
 OQ17IdL401Bx14P3YPmPYHrP0ZPy6XIS2BcH7pXPAp8iZx8rseKC6/DdOiiAExtmfzUx
 KhXVWm4VByYXbRzPxYgTrVJaOt1f8iIm5+9ZZKfSzOoFmleg/KYsjQtrvgp5vrmfGeCG
 M6b87fqUIna0afHY2ssWOU8+KNcYJpYA9U0e82VbrslSMJkxhaY1pAGXbr17gUF09gjv
 wgGias4p9EtIBS/RAJ2MigUjUx2iyo2EDZGYMyMM85E9CF1ImxLbM/r5tL0f7ctatmog
 PMgg==
X-Gm-Message-State: AOJu0Yz/M4l3K2b2+IMeQAsd6kl1RXcbeMJvZCDdsA86KtC+p5MBsiF+
 ggzjqC1GoC427F1KLqQ3tiuxqqh7RtBEW0lRwK3ak+fjXx1UhmbXolq7YdSu17CPRLJe3x7oE7U
 N5XxjgD5mVEvqWfuc1mpVfTv9P98=
X-Google-Smtp-Source: AGHT+IEds34nr6vuvcceKAwz+cnxGgqvvdWXHMRlGG2zh+3cqNRgHFqwkBBbHjkFjc94rhgfHUHv827y9pHlN1T3tgM=
X-Received: by 2002:adf:ecce:0:b0:341:90a1:3e09 with SMTP id
 s14-20020adfecce000000b0034190a13e09mr7058498wro.1.1712048837205; Tue, 02 Apr
 2024 02:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240402014035.8169-1-dennis@ausil.us>
In-Reply-To: <20240402014035.8169-1-dennis@ausil.us>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Tue, 2 Apr 2024 11:07:05 +0200
Message-ID: <CAByghJZ0+gV6b3-OTOx4=a3fUe27GsaTDXWxVPLxAYDstROAOw@mail.gmail.com>
Subject: Re: [PATCH] mvebu: Enable preboot start for pci/usb/scsi/nvme
To: Dennis Gilmore <dennis@ausil.us>
Cc: u-boot@lists.denx.de, Konstantin Porotchkin <kostap@marvell.com>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Michal Simek <michal.simek@amd.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Dennis,

On Tue, Apr 2, 2024 at 3:40=E2=80=AFAM Dennis Gilmore <dennis@ausil.us> wro=
te:

> While preboot was enabled, it did not work as commands are needed to be
> run to enable some of the subsystems. This patch starts pci, USB, Sata,
> and nvme and makes sure that the system will boot no mater what storage
> is in use.
>
> Applogies for resending, I accidently left the u-boot list off
>
> Signed-off-by: Dennis Gilmore <dennis@ausil.us>
> ---
>  configs/mvebu_espressobin-88f3720_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/mvebu_espressobin-88f3720_defconfig
> b/configs/mvebu_espressobin-88f3720_defconfig
> index 7ecf5ab0d64..f4f7a809609 100644
> --- a/configs/mvebu_espressobin-88f3720_defconfig
> +++ b/configs/mvebu_espressobin-88f3720_defconfig
> @@ -21,6 +21,7 @@ CONFIG_AHCI=3Dy
>  CONFIG_DISTRO_DEFAULTS=3Dy
>  CONFIG_OF_BOARD_SETUP=3Dy
>  CONFIG_USE_PREBOOT=3Dy
> +CONFIG_PREBOOT=3D"pci enum; usb start; nvme scan; scsi scan;"
>  CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
>  # CONFIG_DISPLAY_CPUINFO is not set
>  # CONFIG_DISPLAY_BOARDINFO is not set
> --
> 2.44.0
>
> The issue is in a different place. This board uses distroboot
approach (based on what I see in [1]), which is supposed to automatically
initialize boot media before trying to boot from it [2].
Initialization of media is forced when the CONFIG_<subsystem> symbol is
enabled, for example CONFIG_NVMEM=3Dy (check BOOTENV_SET_NVME_NEED_INIT
define in [2]). In your final board config "# CONFIG_NVMEM is not set"
though.

IMO, with your proposed fix you'll drastically increase boot time
(by probing all buses regardless of what boot media is going to be used
next),
and hide side effects of misconfiguration.

Hope that helps

Regards,
Igor

[1] include/configs/mvebu_armada-37xx.h
[2] include/config_distro_bootcmd.h

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk <http://ua.linkedin.com/in/iopaniuk>
