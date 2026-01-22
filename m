Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3C7C44536
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 03:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DE548313B;
	Thu, 22 Jan 2026 04:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y7/XbtvZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFBFD8341A; Thu, 22 Jan 2026 04:08:22 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C781680077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 04:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59dd263bfd3so463860e87.2
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 19:08:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769051296; cv=none;
 d=google.com; s=arc-20240605;
 b=Qk4d/hMAaphGWtAf+ZBCFZ0lPtoEaiL90C0N5QaYoR/NDZZsW7B/I7wDXFUiTDJlVg
 KRRR5Tc5HM41qoCQWl2WS47Hdsv4X9Cwi7OBB3fImPMThnxzpDWFOYlSVUFIuPwVkJA2
 HYqvEH3XkMtWFBzxw6B5viBQwZoppMcIH/AkWybvOUpJj0lCIVpqGX5RuOuwWvq1G5c8
 IwVBl9AXsp7y9WeZeBdQB1wUyQadRPOri45A/oZpeu4F+Li09XG7X0Hg3Hp4Ci6zDFbA
 Sv/fKFbpEwUv1WIuCcZNDZP3UF3vTeqa3zBPzoEOh97NuFIs4Sh6SsnyOiDvBWX14F/2
 hRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aVs4/SNRe2ok4+t6zAa1RCam+hopDPb2+8qQsQffANY=;
 fh=JyVYAqOQ1ckqGUG7bs/mZLOy/LfusYtfrFTH5a5FbxI=;
 b=it1KR7El/7pbrGc//GXnD1zsYXk1KD6cgC0zMFwBOMUtMkeBELV9YQGAvA8m9bbxqb
 7zhDFBV/hVSbCNYLFhpfpQEe0tbYswzKR2BpT16BVC3jtlaJI7uqJqckujZraswVhe6q
 rYErvpVD4silPeMJByQbcF+DGH8ue5CNT5p/xaTTqsWh3vFK7xtW5PucgamMPRNF5M0m
 MLVr3A8hTpSjMixdsfxis9oOBtP31YxtSbLnNqE8EKEPmUGf4ZkPet1T8LHa2ULwdKAH
 aGV99YnXizwWgzkDtxSFYtIc2IpZM1sllN/jtmwa0U8i3JCpd8C3EfY8K9lQFGHYfW21
 mcbA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769051296; x=1769656096; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVs4/SNRe2ok4+t6zAa1RCam+hopDPb2+8qQsQffANY=;
 b=Y7/XbtvZcVlliZRRfLnXGMN/XZB452fPDBrFsE0JZatNEyPEVS/GyL4qRr0qc10WmN
 lIiDueEPEZ296m9TlFJgnKYpxf/ZuIkJ45R6qi7zDtfEmWcmg7bmby3dKDK7ywhEldVD
 cIu/m+ijbsNl5XNcHfLsVr3eyt7sb+mF/koMMtAsAvmnJa+XRwdW4XPRj2p90feCLGO2
 I00tNBlwxTvWe8ph1MBPfD8x5OCxFZB9YYOEYz9UX+Lmcy5lbLh72TO5A9fTpW4cxQML
 O3sIKFJLKTgQ3OZcDKmRrQDFX7Iy/pJapFs8U7jSu1MTR03W2sYgHTDDCeVaUx1d1WpB
 jaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769051296; x=1769656096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aVs4/SNRe2ok4+t6zAa1RCam+hopDPb2+8qQsQffANY=;
 b=KVlEU3UkA8p/5h9h74HGVEaCxOl3wFPA6qIPuAjdc7dGf+rn9E6RRVkljPJg7dV0s1
 enQZFxpKQQdpZg4hGYrqFQuIEmTB6UllZR5ROI2z3J88apHCsjrslHrDmkAm6wkZQetr
 5Htsw8cet5+9YndYOgoMCATEVkJEIuuvk8udhKUNpfs2Ezb6yvAFFU/cpjen74b1NqD2
 hYzRv9jsQ/YjuDRTt8sUH05W8d54NQNg3nDPJWKKGlfPXZdG6uacsezt/SBqNhvJsiMu
 8QiSJ8bvBl0TmO2YPCglFB28closf4dvDNyFl58FrjW2kLhgCf3GlyPOVrbdjhE/Fcyk
 hJ/w==
X-Gm-Message-State: AOJu0YwbWnE/TxfdHvJ2rsj30hPgeKfQTNCkJULWUHBlUckD9TfBfRpU
 fcpyTrGyX/p3j2fV6m8d9WF1yx+XSf7EOnxEr86nuR+qeZFy6rWwm+Ydy/G5JtgmIl+2eAbARAf
 ++NaLNc1fxYRqbXxcRwAwafy4qpdS42QGKBIH
X-Gm-Gg: AZuq6aLMbi4fiDysAZKJYrybjCoIjSUMqfxcbmv6x+nSMDQcpe3xcCp6zKWs/hfG6y7
 qUiWw7B0OOsBCWTj4XJeIld7s/j0qRnB8qm3B3lemFxMAhBHyIJcxA7kzHxswK9ESKaeCgInlPp
 +CXc5rAadTbg2nyJR3nCuJyZUoNaufvv3Srn9RZJ6h5HsdWHJbNbmLYDiMSfSpOLk/u5KiXzHYk
 2rvUJinIo2Kon9bwWSagjoTyfzeuqj94Lo1nhF8/6L1UeE2/nPxQEgIOdcMOhC0X+UYpDwpqnVE
 uNGfwZeU5t8g6V55bVeZnJOu
X-Received: by 2002:a05:6512:1246:b0:59b:8436:79da with SMTP id
 2adb3069b0e04-59baffd6f05mr7210437e87.44.1769051295650; Wed, 21 Jan 2026
 19:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
In-Reply-To: <20260115222828.3931345-3-trini@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Jan 2026 00:08:04 -0300
X-Gm-Features: AZwV_QjhJ2cw39eg4YXEoFll2EssMA2A3tPncpET5FAxwwjtNnfvLGhajv78AjM
Message-ID: <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
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

Hi Tom,

On Thu, Jan 15, 2026 at 7:28=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> that we must have ALIGN(x) statements inside of a section to ensure that
> padding is included and not simply that the linker address counter is
> incremented. To that end, this patch:
> - Expands some linker sections to be more readable when adding a second
>   statement to the section.
> - Aligns the final section before _end (for U-Boot) or
>   _image_binary_end or __bss_end (for xPL phases) by 8-bytes by adding
>   '. =3D ALIGN(8);' to the final section before the symbol.
> - Ensure that we do have alignment by adding an ASSERT so that when not
>   aligned we fail to link (and explain why).
> - Remove now-spurious  '. =3D ALIGN(x);' statements that were intended to
>   provide the above alignments.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> The only part of this I am only mostly rather than fully confident in is
> having caught all cases of having SPL_SEPARATE_BSS being false. I
> believe I have as the generic ARM SPL linker script enforces the BSS
> ending with 8-byte alignment, and the point of the ASSERTs here is to
> catch the case where the section we're adding the ALIGN to ends up being
> empty and so that ALIGN would become useless.

I'm working on bringing up Rockchip RV1103 (ARMv7 SoC, no custom .lds file)

After this patch is applied, the board does not boot anymore:

Missing DTB
spl_early_init() failed: -2
### ERROR ### Please RESET the board ###

If I force "imply SPL_SEPARATE_BSS" in the SoC Kconfig, the board boots aga=
in.

In this case, the build shows some warnings:

  LD      spl/u-boot-spl
/usr/bin/arm-linux-gnueabihf-ld: invalid length for memory region .sram
/usr/bin/arm-linux-gnueabihf-ld: invalid origin for memory region .sdram
/usr/bin/arm-linux-gnueabihf-ld: invalid length for memory region .sdram
  OBJCOPY spl/u-boot-spl-nodtb.bin
  SYM     spl/u-boot-spl.sym
  CAT     spl/u-boot-spl-dtb.bin
  COPY    spl/u-boot-spl.bin
  BINMAN  .binman_stamp
  OFCHK   .config

RV1108 is also an ARMv7 without SPL_SEPARATE_BSS, so I believe it is
also affected by this change.

What do you suggest?

Thanks
