Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D36FEC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F06486A24;
	Thu,  7 Sep 2023 17:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qb5S4FDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E9586A34; Thu,  7 Sep 2023 17:57:53 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB590869F2
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-991c786369cso144361166b.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102269; x=1694707069; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=53xhWLjuRFKINlrqHO49gIeZApf9Y7IW1ncSmdfN0u0=;
 b=Qb5S4FDk9SqfDjK8o4YjrmxQvuiPWmteBn183ccuMp3Wk6jemh1R1n7kOvJjHKMtW5
 dItSrU4+MZgvr5AI9pWtDUQAFMgnzNAz8OGU9/xGTLbZTyfI6Kg6KkmUGugMOhEXXr2k
 KWU5C3+brwoZMZvBNtJvliCM+u/8QDSAmC+D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102269; x=1694707069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=53xhWLjuRFKINlrqHO49gIeZApf9Y7IW1ncSmdfN0u0=;
 b=Mv2k5qJ8GIh+R6WlfxbbtSfEqCKqx8PupyDvJiJB3ZDUndsdDcXqoVUghs9x6A6WEl
 YK6O1hXzvt1+ZnP+6ux+4As/K0j5i+JW0T2LPSzsS02Squ67fMf8tKa4sDxSnUgdTaIl
 jgngzJwgD2DX11alCAV+pwkjv+MY6RDWVaVbXEnXLKhPHsAX/E6jRyx3IGfv4DVqopdL
 7MhUDMxxCHjarITWRC5OSdG26QFglr4WfSrSlxJ86SXOhzY4uYm+0A/JmUHvrVKErqbe
 qz6DgH30WCBNMSRYSanZXhS0obPZsKLD1WGLqeKKiYfn+1hE+vjGmkAwBBpgyTjJwUUk
 RlWw==
X-Gm-Message-State: AOJu0Yz5iWcHN6mxrJ74EXtxBgVKuQy6u7KQ1piCiOISe3ZOgFOa+oSl
 8b+keLB5Xx6ECPds6ioJnDlN7X9pvUIybfjbgqb2BwRCER8MGZntCDE=
X-Google-Smtp-Source: AGHT+IFLrqHrVDe71qycRqlUTT/zIEyCYymTgg4HTJASDplgNQcjZ1nMpk8p8w2yzdETlI2tW6wxvSASxrcuRSzpMSU=
X-Received: by 2002:a17:906:3ca9:b0:9a5:a701:2b90 with SMTP id
 b9-20020a1709063ca900b009a5a7012b90mr4910186ejh.40.1694102269331; Thu, 07 Sep
 2023 08:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <044d9cffc3d8ed891b40d24c63ff74445cb3014b.1694091612.git.michal.simek@amd.com>
In-Reply-To: <044d9cffc3d8ed891b40d24c63ff74445cb3014b.1694091612.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 09:57:36 -0600
Message-ID: <CAPnjgZ2ZKcpY5Z9SjgZyLNCXAs52T7OrQej6EyrA06oR=Vfbzw@mail.gmail.com>
Subject: Re: [PATCH] global: Use proper project name U-Boot (next2)
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Alexander Graf <agraf@csgraf.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Sean Anderson <sean.anderson@seco.com>
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

On Thu, 7 Sept 2023 at 07:00, Michal Simek <michal.simek@amd.com> wrote:
>
> Use proper project name in README, rst and comment.
> Done in connection to commit bb922ca3eb4b ("global: Use proper project name
> U-Boot (next)").
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  board/cobra5272/README                      | 18 +++++++++---------
>  board/emulation/qemu-ppce500/qemu-ppce500.c |  2 +-
>  doc/board/xilinx/zynq.rst                   |  2 +-
>  doc/board/xilinx/zynqmp-r5.rst              |  4 ++--
>  doc/imx/mkimage/imximage.txt                |  2 +-
>  doc/usage/environment.rst                   |  2 +-
>  doc/usage/semihosting.rst                   |  2 +-
>  tools/binman/entries.rst                    |  2 +-
>  8 files changed, 17 insertions(+), 17 deletions(-)

[..]

> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index e7dfe6b2a363..a8c7423c4005 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -2505,7 +2505,7 @@ Properties / Entry arguments:
>  See Entry_u_boot_ucode for full details of the three entries involved in
>  this process. This entry updates U-Boot with the offset and size of the
>  microcode, to allow early x86 boot code to find it without doing anything
> -complicated. Otherwise it is the same as the u-boot entry.
> +complicated. Otherwise it is the same as the U-Boot entry.

This is actually correct already, since it is the name of an entry type.

Regards,
Simon
