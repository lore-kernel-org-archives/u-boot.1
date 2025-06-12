Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AB9C61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 07:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEE2582A4B;
	Thu, 12 Jun 2025 09:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lx+/sgFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08A6382B70; Thu, 12 Jun 2025 09:35:52 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2948828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 09:35:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C3AF15C4153;
 Thu, 12 Jun 2025 07:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFD2C4CEEA;
 Thu, 12 Jun 2025 07:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749713748;
 bh=s7afy+qBFxLmt4OCk1r6+5OKxBZPNdvA3hpVA5R7pvE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Lx+/sgFehVRquivtEw7KjGxx+qjWJoWd8rAaP9pVcagwvW/P83+02YdXo6S9TSIjf
 jVoClaZd/o8v0tRgmONiWAmtr96Mfqeng+b495hL8MxL+TR+/TwHzFkrJjvArODoCO
 R5GIPTl0V7GU9tPg1c/YlyNDO1kDMOIyHjFBGhXaElGHHyErDf6lWzEThv/sRLGRQu
 w2+W2Dphoe+6B6o9Ih3p2wr7AB9veiZptRlTAbb7sVS8JFDDXlvSmHCKpKiYL/OzhJ
 YKTk4E/54hhX2eWp4h47fOEmmDISvRuyXwik6mQOuEpjT35OnwT2jmmvfZIkw/HOnp
 ZvLc9QqfDJs9w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>, Tom
 Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg
 <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com
Subject: Re: [PATCH v2 3/5] boot: bootmeth_android: Conditionally dependent
 on abootimg
In-Reply-To: <20250607-sc7180-android-boot-v2-3-2df5d7f61124@gmail.com>
References: <20250607-sc7180-android-boot-v2-0-2df5d7f61124@gmail.com>
 <20250607-sc7180-android-boot-v2-3-2df5d7f61124@gmail.com>
Date: Thu, 12 Jun 2025 09:35:45 +0200
Message-ID: <87qzzp9zu6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi George,

Thank you for the patch.

On Sat, Jun 07, 2025 at 13:24, George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org> wrote:

> From: George Chan <gchan9527@gmail.com>
>
> If target u-boot img do not support androidboot v3 or greater,
> abootimg might not be necessary.

Indeed, and this is already handled properly in ./boot/bootm.c and
./boot/image-board.c.

>
> aarch64-linux-gnu-ld.bfd: boot/bootmeth_android.o: in function `boot_android_normal':
> /home/user/sources/u-boot-next/boot/bootmeth_android.c:541:(.text.boot_android_normal+0xd0): undefined reference to `set_avendor_bootimg_addr'
> aarch64-linux-gnu-ld.bfd: /home/user/sources/u-boot-next/boot/bootmeth_android.c:543:(.text.boot_android_normal+0xd8): undefined reference to `set_abootimg_addr'
> Segmentation fault (core dumped)
>
> Signed-off-by: George Chan <gchan9527@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Acked-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Casey, feel free to pick this up through your tree.

> ---
>  boot/bootmeth_android.c | 2 +-
>  include/image.h         | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 8c2bde10e17..d7740b86d67 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -534,7 +534,7 @@ static int boot_android_normal(struct bootflow *bflow)
>  	if (ret < 0)
>  		return log_msg_ret("read boot", ret);
>  
> -	if (priv->header_version >= 3) {
> +	if (IS_ENABLED(CONFIG_CMD_ABOOTIMG) && priv->header_version >= 3) {
>  		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
>  					     priv->vendor_boot_img_size, vloadaddr);
>  		if (ret < 0)
> diff --git a/include/image.h b/include/image.h
> index 1e1bded690b..2c03dde768d 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -2038,7 +2038,7 @@ ulong get_abootimg_addr(void);
>   * Return: no returned results
>   */
>  void set_abootimg_addr(ulong addr);
> -
> +void __weak set_abootimg_addr(ulong addr) {}
>  /**
>   * get_ainit_bootimg_addr() - Get Android init boot image address
>   *
> @@ -2059,6 +2059,7 @@ ulong get_avendor_bootimg_addr(void);
>   * Return: no returned results
>   */
>  void set_avendor_bootimg_addr(ulong addr);
> +void __weak set_avendor_bootimg_addr(ulong addr) {}
>  
>  /**
>   * board_fit_config_name_match() - Check for a matching board name
>
> -- 
> 2.43.0
