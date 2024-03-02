Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069CAC5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 22:25:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E6487D60;
	Sat,  2 Mar 2024 23:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="jNXdKP/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCF2187D65; Sat,  2 Mar 2024 23:25:06 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D67687AEC
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 23:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1709418303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOt7JWvVvJcdJ2hnYPmXBeLj7ZNr9z+965APGGeJZ6Y=;
 b=jNXdKP/lC37dgHG+Kar8V3BMkl5t6HemRL7mCBceotZjQBtluO946cdrmQNlFGZYiRWZdY
 8/Qr0Np3TSkpKtcTRB47NfDs0kN5NnSYWvq5Z4JyWpECms7xHUazuaB/+hcuAsDlYA79wI
 0Vi69BBoMehKTjzRq16pT/hM1qBnRpiUkDJb4acu2D6Cxd0tBNze20vRFiaLpuJAwF1PWS
 8HWxQES56i1ljm2miKUM9gaxE0GpkJhBfc3LtsEpu+yKIU/iiaSlGFzYRkbLBBrtK9xT0z
 M5ujyJdpu1SzFz1j+uYhrU9Pi2+hIs3SspzpIDwNfo2EjDbRojLjvUXI73YO3w==
Date: Sat, 02 Mar 2024 23:25:02 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de, kernel@collabora.com, Kever Yang
 <kever.yang@rock-chips.com>, Philipp Tomsich
 <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v1_1/2=5D_rockchip=3A_spl-boot-order=3A?=
 =?UTF-8?Q?_Fix_spelling_succes=E2=86=92success?=
In-Reply-To: <20240302145107.168080-2-chris.obbard@collabora.com>
References: <20240302145107.168080-1-chris.obbard@collabora.com>
 <20240302145107.168080-2-chris.obbard@collabora.com>
Message-ID: <6fcd5781e17e23732a8176f34a658548@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Christopher,

On 2024-03-02 15:50, Christopher Obbard wrote:
> Fix a simple spelling mistake in a comment.

I'd suggest that the main part of the patch subject is adjusted
a bit, e.g. to something like "fix a typo".

Otherwise, looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> ---
> 
>  arch/arm/mach-rockchip/spl-boot-order.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/spl-boot-order.c
> b/arch/arm/mach-rockchip/spl-boot-order.c
> index 2c39a215c10..e548a7dc718 100644
> --- a/arch/arm/mach-rockchip/spl-boot-order.c
> +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> @@ -29,7 +29,7 @@
>   *   -ENOSYS, if the device matching the node can not be mapped onto a
>   *            SPL boot device (e.g. the third MMC device)
>   *   -1, for unspecified failures
> - *   a positive integer (from the BOOT_DEVICE_... family) on succes.
> + *   a positive integer (from the BOOT_DEVICE_... family) on success.
>   */
> 
>  static int spl_node_to_boot_device(int node)
