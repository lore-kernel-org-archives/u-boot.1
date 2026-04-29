Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6D0FF8873
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 14:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD8584882;
	Wed, 29 Apr 2026 16:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FQDL78On";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61B09848A0; Wed, 29 Apr 2026 16:14:44 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C9C4846BA
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 16:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ba8472c1613so1848716266b.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 07:14:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777472082; cv=none;
 d=google.com; s=arc-20240605;
 b=Foz24GNYRnt5YSt4HqitbE7YUcSF51y0KDraGAjQLxnGa3tywt0/Zch2yc5ER9ZLKD
 v6DUGxe1n3mRNdm8WxDY9Yz7Z1shgFpvy40+/CawU3VR3t7J3jTbBnLkmbD0SObK3N25
 iXtcHkLcTBwJlbuV2HXLnUJ4ockO97al6D204fnR/DsJkrqFD5XuH169PnQRCCKVCwB7
 EVn4v0hHEdZsQysC9jOgKM+RZP3bs3mlD6eclw32q4zaaXloSFxK1krPlg0sYvoal5jI
 19FaMgGdRlVQsQ8X/DeeciebnP/8rSqsI7kwbgnrQGrO2q/shEvGOqJ5V2rHkspW5B6c
 NnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Y1MjXVTQFUnLVm36bSBya06/3dkWUPRvCDClVs5pQP8=;
 fh=Pxf4OEzlPrqi1OIjLsU8Uii8jKBvtXCinaJy1tLkUBk=;
 b=YM2fEVtMBnxU8q2HVyekJHTeWujmyYTbZF/YiGVFRoN/W6janOGNggX2lHsLGCTcto
 geH5JAFcRa6C2Ggz0t3vcIibQPpRce+IQlPxFXtOvUnBjt3Ds4bBPWeIETKSPUM46GGt
 hqXd8dcD6QloqjctiEUlziheSthdk6f2p296xD1ryIv3Y4Z2L4ppvyLjoNxaofryh1SA
 zb4fg4/97pJ1tfEFjwGP8SgOpY0f9/Aw+y9A0zr3IkIjryu8C8kfxwhTDO9L2C4QYkVk
 E1oOV+aITvSYiyQYKz+jd/xkNcAfQJFOT1vvk+jTvaondG7fu03uimKQZKZA7oFDmSga
 F2qw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777472082; x=1778076882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1MjXVTQFUnLVm36bSBya06/3dkWUPRvCDClVs5pQP8=;
 b=FQDL78On5PsD1D+sKxaxkxBAiTKorVphwOY5s60cXOY0ursy9yBcXJsTlkpgh4wZ3b
 7hWDokgf02fIffjVlp26U7LGWJmoczGCKsWmk4W0+XTbRVFdXBKgItZTUQ5CDj5vcIp4
 /sD3V9zxFEXEzaGmkQIfjm6bvXE2FDESJx0hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777472082; x=1778076882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y1MjXVTQFUnLVm36bSBya06/3dkWUPRvCDClVs5pQP8=;
 b=DeqJE8+/zey8ww42llzfwhd8HusaNIF3TAq1+waKMLKeByWEEfuBAKfTAoVMRYvKvX
 vug2Hei9BKkrTIA08pPYDuTK35jkdehwR468Titj9hOru+93NmoT4rBo0Dw9pXlqxBcQ
 /g1ApKbL1HA8FRwEXUvYqsuILL7YRbeFssue6z1WGqlFJQcayDQXtIDDG/y++CQcH/2K
 R/sx5g3yOo19q/unAyEv2N34pnZ0/FCaAydMlvWlEvtRN59MszFKhks6YUPvLSMlYsha
 ZU/3Las1Z1A/lPBLHHbdAncaOlm3YDnC1bEXJO4XS4xHMVY2c87VyvbgD6ZnPbngGl8t
 DPpQ==
X-Gm-Message-State: AOJu0Yz0XhYBmt/zlNkNfmX0AVq7glrhzcANSKOjd1skTSIjiIwW1pge
 NnX06sVVSxF622ZbDccjpHNq1dQpblHlS2um4Mw0mVh4b8RI1HMFAEn50SuzBw1M4UP5gvaiJoF
 CYknmAJpSWt7xBfhnqTX/o5ZOWuuA7y2WQ/pNFvI1
X-Gm-Gg: AeBDieuWufjWmx47S9fGoHgzn9AfNY51zYwKlzVDpHD4dL13VJbY4nwb+4AP6EqMBam
 r0JYxIMwp3Qj1PbOgLT5p5UUxp3KZqIxjh4IPZimT03qWJMA9PIkJAMbDa6qrozNIOq+ga1F2Jh
 R6GqPdgA55RY2GSI2F5J9EImDNkcyei14aldEhUOax7TkU8DD8iUDTgxExqEzBA/1d3/m3xHhLz
 SyqveuudNRCILpp5/XUfW6kZZQuXaoJyK9sHRmhAroaK6IEG4mpxoH30cxBtrUlzqyuv/lLzwP7
 fsd5J8Gncm0e+/OE
X-Received: by 2002:a17:907:c91f:b0:ba8:4dc2:a661 with SMTP id
 a640c23a62f3a-bb8015ef71amr335754266b.7.1777472081795; Wed, 29 Apr 2026
 07:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776954004.git.jcethrid@gmail.com>
 <dd31cfe89b1d2d8d207d5c91a2a5e9783c917ab4.1776954004.git.jcethrid@gmail.com>
In-Reply-To: <dd31cfe89b1d2d8d207d5c91a2a5e9783c917ab4.1776954004.git.jcethrid@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Apr 2026 08:14:28 -0600
X-Gm-Features: AVHnY4LpRQOtpQzfKxzLsWegUcwgUoY_LHHMtpVtBy7iOl_XsjRgHjAwQQVdyFg
Message-ID: <CAFLszTiFnbpGQH7RwbqhGVdkX+9kV=Bc3rkbmeX8aMYm40w+YQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/15] arm: sc5xx: Remove SC5XX_LOADADDR
To: jcethrid@gmail.com
Cc: u-boot@lists.denx.de, malysagreg@gmail.com, trini@konsulko.com, 
 linux@analog.com, philip@philipmolloy.com, sjg@chromium.org, 
 Caleb Ethridge <caleb.ethridge@analog.com>,
 Ozan Durgut <ozan.durgut@analog.com>
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

On 2026-04-23T14:24:50, Caleb Ethridge <jcethrid@gmail.com> wrote:
> arm: sc5xx: Remove SC5XX_LOADADDR
>
> Remove the SC5XX_LOADADDR Kconfig option, replace its users with
> CONFIG_SYS_LOAD_ADDR, and update the ADI boot environment to use
> loadaddr.
>
> SC5XX_LOADADDR was an ADI-specific duplicate of standard U-Boot
> load address handling. U-Boot already uses CONFIG_SYS_LOAD_ADDR
> for the default load address and loadaddr for boot commands,
> so keeping separate SC5XX-specific names is redundant.
>
> Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> arch/arm/mach-sc5xx/Kconfig                     |  6 ------
>  board/adi/sc573-ezlite/sc573-ezlite.env         |  3 ---
>  board/adi/sc584-ezkit/sc584-ezkit.env           |  3 ---
>  board/adi/sc589-ezkit/sc589-ezkit.env           |  3 ---
>  board/adi/sc589-mini/sc589-mini.env             |  3 ---
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env   |  3 ---
>  board/adi/sc594-som-ezlite/sc594-som-ezlite.env |  3 ---
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env   |  3 ---
>  board/adi/sc598-som-ezlite/sc598-som-ezlite.env |  2 --
>  configs/sc573-ezlite_defconfig                  |  2 +-
>  configs/sc584-ezkit_defconfig                   |  2 +-
>  configs/sc589-ezkit_defconfig                   |  2 +-
>  configs/sc589-mini_defconfig                    |  2 +-
>  configs/sc594-som-ezkit-spl_defconfig           |  2 +-
>  configs/sc594-som-ezlite-spl_defconfig          |  2 +-
>  configs/sc598-som-ezkit-spl_defconfig           |  2 +-
>  configs/sc598-som-ezlite-spl_defconfig          |  2 +-
>  include/env/adi/adi_boot.env                    | 24 +++++++++++-------------
>  18 files changed, 19 insertions(+), 50 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
