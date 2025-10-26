Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26376CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 01:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98DD683804;
	Sun, 26 Oct 2025 02:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lmPz3rFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AAE283885; Sun, 26 Oct 2025 02:11:07 +0100 (CET)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B720836F0
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 02:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-63e3568f90dso3550107d50.0
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 18:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761441063; x=1762045863; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MV3aTJB18vFPpOrPVth0k/QnxdMdjio1x7xJwe9r74U=;
 b=lmPz3rFOi6UcYImmN4DheAfn/ckVTo4PHcpdJ0Zs+ckuPn6uEVbYBPniHdkU4C2UMG
 S2ZC45+0G0N4qHjCKpYSeiHNYi67let72t0DKhqycwqwgOiVKGhZjaYvia7gaysEcWHn
 hSrpVu10bEQoBvzBLwORFxlmoKPBLUXi26jOEeeC330KGRmAx08GovDC1eWCJ+E1rDMk
 KnDCR+HcP2j8PMVVPmognLnAZwHBPnptnzJlVFkasZLgBTmTCaisgtmd2/uSN+6iLaNv
 DybVGPDEAhlmRJc/4Aewlk7RVdNv0UaHs3R/wTJ2Mjwd4lWOVMhB5QoT+5nZv7JO9wJ2
 upWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761441063; x=1762045863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MV3aTJB18vFPpOrPVth0k/QnxdMdjio1x7xJwe9r74U=;
 b=Hz0wQFNpFdYhjL+rVPVY6jxpoyK5QHuaOmAyaFG9gQ9SMIsBV3bEDZ2VH0irU556he
 L7X9Mt56BTuWz6w91/RwIrWLJDrdt6UqRsHzzEeUoDIIiqJ+7tDZAqSE82/D+zgpNJQr
 +LZjEhxK0dVGT9DIxQ+pnBU+D8xlplzYHef0+98Idl+f/UKzyFx+ofNh32kWShPkdoSQ
 5DqrXpK4PDn7NU1/JbPNTuIUnFoIJEfn4PU4Fa52ByTIdorYAaiKIfz/lVicOJwDpZWc
 cs66xXnpl7dmbAk7uX9Bzoq/DhdomXyYKNqvBN9eqUF2O4CwYN0W7CYk9UrfACXosKKW
 rEwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU51K69wnEqULCku/jvDCiGuEG3TLCwSSPo/lpHHIGAPH0JXw6g4g70VTesoSTAZtY+lKRy+RY=@lists.denx.de
X-Gm-Message-State: AOJu0YzciwQzSDOUR5vFqIZC2ddEJFfsnwv1HmQlZ/5Bgix0SlSFAcu9
 9eV63qvlyDKg4eXmQCIBdsFK8HBM5p+56U5wTF54lmeu5JUhqZEWMwGU6XFjCXPewdrif/X7S/n
 /vRRRUXUGg8pwDhu8eSFtbZusVy+HKSA3RfAJlzJoOw==
X-Gm-Gg: ASbGnctxK1zMbVo7DH3ipBFKhLDMg3m1NpoWy98KMqIAqM7W+ieEW+RzD8kBp941UAj
 wDZuTmFFDS/iuH3N05YKMkSns3nEmqGcGAVFP2e80fKEeZaMRceE2fs1/a5wmhKoCAWPzKsoI5Q
 0k1aj5w8Yz4FJy8ijXno5y4Ekfcs3ubx9b2IcmrIqRVQXspD0YXao/VEdh7ZD06Fy1k/YI5+fwp
 j6ZzCQgHREDx4lDdNkPRGS/b68Jrtyl/eUL7LgbLGhSfLJR3fZLRnPW6H17mouw8Wo7xrhlLiGe
 1p9bkqB/klHYuDm3sLvqSCVS8qE/kA==
X-Google-Smtp-Source: AGHT+IFZ7lXLVWHiOJ0w+vhZHHwPRjdsCcdJZurT/MCkNjeD20NHOBuZyE7tlGbUXfC+YX9deCjskgVeze3GSvPb17g=
X-Received: by 2002:a05:690e:4242:b0:63e:1ee2:eb0a with SMTP id
 956f58d0204a3-63f377f6d94mr7869480d50.26.1761441062961; Sat, 25 Oct 2025
 18:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20251026010658.19271-1-semen.protsenko@linaro.org>
In-Reply-To: <20251026010658.19271-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sat, 25 Oct 2025 20:10:52 -0500
X-Gm-Features: AWmQ_bnJtjeQUO0EYK1zqQWRjxEWhbIiiLR6Pp2wxFIUMjF8wv8sTGZRnlL1U-A
Message-ID: <CAPLW+4nq8i5f-Z-TTi2rpdwqHQFYW_YsnsC4baHgaRa3WHGihA@mail.gmail.com>
Subject: Re: [PATCH 0/6] mmc: exynos_dw_mmc: Disable FMP for Exynos850
To: Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, 
 Anand Moon <linux.amoon@gmail.com>, Lukas Timmermann <uboot@timmermann.space>,
 u-boot@lists.denx.de
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

On Sat, Oct 25, 2025 at 8:06=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> When doing USB boot [1,2] on E850-96 board (based on Exynos850 SoC) it
> was found the eMMC becomes non-functional. The reason why it happens is
> that the FMP (Flash Memory Protector) is enabled in FMPSECURITY register
> (eMMC block) during USB boot.
>
> In regular boot from eMMC the FMP is disabled by some early bootloader:
>
>     FMPSECURITY[31:0] =3D 0xcfe2_e492
>
> But when performing USB boot, this register keeps its reset value:
>
>     FMPSECURITY[31:0] =3D 0xffe2_e492
>
> which leads to non-functional eMMC, because the next two bits are
> enabled in this case:
>
>     - FMP_ON[29] =3D 1: FMP encryption is enabled for eMMC
>     - MMC_SFR_PROT_ON =3D 1: SFR memory region (peripheral registers)
>                            protection is enabled for eMMC block
>
> That makes eMMC inaccessible from U-Boot.
>
> This patch series implements disabling FMP on Exynos850 to make eMMC
> functional when U-Boot is executed during USB boot. The per-patch
> breakdown:
>
>   - patches 1-3: cleanup
>   - patches 4-6: adding FMP disabling quirk and enabling it on E850
>
> Patches are supposed to be applied in the same order as they appear in
> the series, to keep the dependencies straight. The series is expected to
> go either through Minkyu's (Samsung) tree, or Peng Fan's MMC tree.
>
> [1] https://gitlab.com/LinaroLtd/e850-96/tools/dltool
> [2] https://docs.u-boot.org/en/latest/board/samsung/e850-96.html#flashing=
-overview
>
> Sam Protsenko (6):
>   mmc: exynos_dw_mmc: Extend dm_dwmci_ops without code duplication
>   mmc: dw_mmc: Do not export dwmci_send_cmd() and dwmci_set_ios()
>   mmc: exynos_dw_mmc: Improve coding style
>   mmc: exynos_dw_mmc: Add quirk for disabling FMP
>   mmc: exynos_dw_mmc: Add exynos850 compatible
>   mmc: exynos_dw_mmc: Disable FMP for Exynos850 chip
>
>  arch/arm/mach-exynos/include/mach/dwmmc.h |  6 ++
>  drivers/mmc/dw_mmc.c                      |  6 +-
>  drivers/mmc/exynos_dw_mmc.c               | 78 ++++++++++++++++-------
>  include/dwmmc.h                           |  3 -
>  4 files changed, 65 insertions(+), 28 deletions(-)
>
>
> base-commit: 1071cc85bc4d1416fd93a063ba4abdd2d17ae0db
> --
> 2.39.5
>

Clarification: the series is based on mmc/next tree [1], so it
probably should go through the same tree, to avoid possible
collisions.

[1] https://source.denx.de/u-boot/custodians/u-boot-mmc/-/tree/next
