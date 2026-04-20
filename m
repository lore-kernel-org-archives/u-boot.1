Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E19EA71A4
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 02:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 229AF84181;
	Mon, 20 Apr 2026 04:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bhZ/Ds5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E02908419E; Mon, 20 Apr 2026 04:50:47 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A57DC839D9
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 04:50:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c736261ee8dso790739a12.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 19:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776653444; cv=none;
 d=google.com; s=arc-20240605;
 b=Gbj/1zhOT0BvM8y1Mh70F6YjmOGHC0QpFdpjPpq073SPHNiGjfxy0Dqt7tcFETZmAr
 /sm1g+ji8NepDh67LIbc9RQeP9aHTNG9Ip4gzCigBq63XWszt8xg13K4CiRehISi5L6T
 0VPogw9HV9e5JYmQfx2yA4zQUZFcJvGihtGo1n/tKnMdBSIx1nrNtgpDE04zwdJNhMzI
 qbhILkTgci62KXDHfvY69gAz/yS1CYWxgmd+jBzmzYBEZaLWrr4t56fL447FG4wyrFpf
 OrbSTuirqJ3fLK0oBze4+NF6KBEsc4bFK9FhPwIOPLVhnM5w5x4Y2U7eaXvM/CRJRGVv
 Eb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/gu4edmqze7fbFb1bNAVi6FLzmMwCgAp0jCIv6XXoPo=;
 fh=bAhO/2+dJLNIuyiSCWCsiQQck7gcMCfIwltRjKz8q4g=;
 b=e77RV8uY/VSmBbm38C/Xt8g71QlXZQelnH96B56TTsdnK/0vRGm/JDiLvIPNlrNyCk
 9bSlQurdLTU8zgmQy68GUVgAfEMg42GwA+pmfurypJgRPUqe2XNZQTdxYU6vzXj5kGO2
 iT0DeWf6t76FaVYIFbDET+5tdDqEYoBAYYvGkeoVc04EwO1Pfm5wlKJulPk44QieBoPm
 gnf/cGZLlti2fguSuwDc2QcLQLk+PzgNyAxiyon5GffPyy1YO9IqyeelXVFTvBgsl22l
 hBE+6ZYu3Mz4zTGdDgvHEWdKxpPJmMEidxtY0SyRDsH/B99dw6Fvqnqc+9baqLDQIb7q
 vFUQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776653444; x=1777258244; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/gu4edmqze7fbFb1bNAVi6FLzmMwCgAp0jCIv6XXoPo=;
 b=bhZ/Ds5DR13TU25IHnLdpnh5GpFyZEzNH2XN6YIgWDId8W9H/CcIU6V1bWB9QZFluv
 WyiPu5BlweSuaoOQaPCxlY4BPzWrbaV8kMyMLPLMojrJGIrV7Xm2hnDTKuViz3Hbziiu
 k4t7TW1jniDC5G6e7qvESW5bGp3q9/1sXRYfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776653444; x=1777258244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gu4edmqze7fbFb1bNAVi6FLzmMwCgAp0jCIv6XXoPo=;
 b=fbxcuEP2tyj4ovrAF3N8YRCyFg8wV7PF+zD3p9bXNxQ/KRhIHM5DoPZ3PdCNYJQ+Vc
 GJjUy8NzEzTjgHDPL7pDEfz2XBCOcwAYx9MagPAe3xw0iHG/pQGni23DIXSU+fjcFhqB
 nQzt5rUsSB9vzACzumXrxJt/3wZvFFlka7t90bgjNMaGsTANTx2rb419BzzMBOFib/1l
 U/2pXS2z+D2AB3aGqiik/pHTUXjM8vks8+1xywdCJq77gkZC6UYFi1ZZHzNjsM8Y1clS
 0qZE4Q3b+BxKbM8n1IpNEyelZwHKkI/rtRo6ahf8h1XsCgIcMJ27DQNxZbd+jShDBM2r
 vKMA==
X-Gm-Message-State: AOJu0YzbjLgRWuYP8jP1cVEBqEDuo1UU+UyUNaFid3cv+9Q08iLCuJfs
 /20L94X6EwYAv/CBf/bGm3JFHOQzgKB1lfLIRWvCRgLVJO9yr23d5PouK7WmmEYOfak9/n7zlCf
 ZSHmMi8S85l7gs51ygXPBazpfUwl7SPOqt0Znp97Quao7mr8KHRuQRw==
X-Gm-Gg: AeBDiesAiEOvh+guZMGS3bowuc4XLZy0MrKTZ612UT0bszLaL8xpA5rNlWoqFCtGQwy
 bxF+GtQT/YLnB9p+1gcyUpXRuagreKDbp0ylAELBAQQFcueF5iGd93Enq3+QAw+R89oQ60AS+r1
 sTKrsa6FJTMBRGrlVRqWDmT8DN/bLqEnR5jUSsSUxcC0NtpNFzTlRHY4cMxnWjR7ztxRoZjawkv
 YQikbHmdRixD/ImvnNoa4DKOoQqYnrb72mnC9te85+wlIEHtWfUENYDqdDSTqzlbRThTZ/z6YEw
 jCH8UWKqqL5v79/RcEAB
X-Received: by 2002:a17:902:d590:b0:2b0:608d:d8a8 with SMTP id
 d9443c01a7336-2b5f9e8e4a9mr116383255ad.1.1776653444172; Sun, 19 Apr 2026
 19:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
 <bb86af2e00b7f1ad7f5ef1831b64f2d120ae6dc7.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <bb86af2e00b7f1ad7f5ef1831b64f2d120ae6dc7.1776344788.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 14:50:29 +1200
X-Gm-Features: AQROBzDJGuB2QA6SDkTfT88eILhSxrKl9gTlTAiMlune3hTZwHAJbzP0BuRZnSs
Message-ID: <CAFLszTgLk38PdE1J6iEfqG-T3dSOJN4j8q1_7tPjngM-dAoPNQ@mail.gmail.com>
Subject: Re: [RESEND v4 02/14] mach-sc5xx: Remove update commands from default
 environment
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On 2026-04-16T15:19:35, Caleb Ethridge <jcethrid@gmail.com> wrote:
> mach-sc5xx: Remove update commands from default environment
>
> Remove the update_spi family of commands from the U-boot
> environment. These commands are not standard in U-boot,
> and boot media programming has moved to Linux, so the
> commands can be safely removed.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> board/adi/sc573-ezkit/sc573-ezkit.env           |  2 -
>  board/adi/sc584-ezkit/sc584-ezkit.env           |  2 -
>  board/adi/sc589-ezkit/sc589-ezkit.env           |  2 -
>  board/adi/sc589-mini/sc589-mini.env             |  2 -
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   |  2 -
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env |  2 -
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   |  2 -
>  board/adi/sc598-som-ezlite/sc598-som-ezlite.env |  2 -
>  configs/sc573-ezkit_defconfig                   |  2 -
>  configs/sc584-ezkit_defconfig                   |  2 -
>  configs/sc589-ezkit_defconfig                   |  2 -
>  configs/sc589-mini_defconfig                    |  2 -
>  include/env/adi/adi_boot.env                    | 53 -------------------------
>  13 files changed, 77 deletions(-)

> diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
> @@ -1,9 +1,7 @@
>  /*
>   * A target board needs to set these variables for the commands below to work:
>   *
> - * - adi_stage2_offset, the location of stage2-boot.ldr on the SPI flash
>   * - adi_image_offset, location of the fitImage on the SPI flash
> - * - adi_rfs_offset, location of the RFS on the SPI flash
>   * - loadaddr, where you want to load things
>   * - jffs2file, name of the jffs2 file for update, ex adsp-sc5xx-tiny-adsp-sc573.jffs2

The comment mentions jffs2file as still required. Patch 10 removes
jffs2file from all boards. Please can you also update this comment in
that patch.

BTW, CONFIG_SC5XX_UBOOT_OFFSET, CONFIG_SC5XX_FITIMAGE_OFFSET, and
CONFIG_SC5XX_ROOTFS_OFFSET are left orphaned in Kconfig after this
series. You may want to add a patch to clean those up.

Regards,
Simon
