Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8784C61DD6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA0D240BB3;
	Fri,  4 Sep 2026 13:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bpx4eQhBZSRd; Fri,  4 Sep 2026 13:08:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 01DF740BBF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788527300;
	b=Fput1SHqBRS0+KvW7EIcQyh5O88dxzH3BAJTzErauvSB8DGfGGGzfY2PyFpwUTM/KPfK
	 IA7y+i4Czuk5mPxmfVxjDcpGO0yJDl5hS6YjcJD2mozD4etiXpQBAJr5YQsO6llnj5UlE
	 zHis437jKAM5gu1qUNqTCvTB6wwyi4JbtKTsSKBvh4PBhIdENeeif9WJ+O/0o3PicKVuu
	 yLQj7G8Z9u3d7fdENCGQnAWk9IAbPvvQsOoQY9SZmNB5neEJIEvR5ngVOFSfxYOYobxzn
	 2QTxMRD72zsV+L0jIuFGdd6VdNNWmE1jZKmnsZXGWWSs+lEo6FB279Up5laPh71NFJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788527300;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U4v/Rd596CW3I1R5RGhkVVX0SvjLUmd2mxJ4mJ8hPJo=;
	b=psZoJe7goqVsuO3fGXN6qyyjJEgadJvbLwJiAKkfe2E/x/8oA3BGo6LpM3Y2B1P8yyE3
	 5VLzH5uL3xe+korePgvVd4lxQm0//KJLhSDLnHBBzFXuyQLg0C/YwCMOYhbWa/wvDzzoe
	 ddq/xre9gEPeE6btUGu58oKHnwDS3R1J/Gn9trYCEMlfydn2fzpWVhtOpxmL0OHKAxDP5
	 2c5do0y4J3SpfTByzQNnA8iH6z4UtqXMwR5STDVvC8z7uCl21zQ+eeEJeRFHsroTRDfKp
	 Z/TZ36yyqt9wAHo8aWsmcenAI7MyfJ9NqJ7ICreqpbg759AGD7xlXZiyeDV2+l6o+ig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788527300;
	bh=U4v/Rd596CW3I1R5RGhkVVX0SvjLUmd2mxJ4mJ8hPJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rA4mNInVRhk41mpuMREAsQilvzZQ+BUpPhT7q3lKGArgSTtC8k10gBRbp76MwUCun
	 SVmO2AC+0K0Cm+a5iQFHBRWJl+ezioB47f3z2wfKJs0q2HDMHuLRm8LZ94Eo/doFBq
	 CeCbqTtPGeXLol1mz4wsR9WLq041hzPEc43yzbXFDH+3g4M3OuOheZl8waURRoQD9m
	 i7yjqcrjy1PmeusM/w/oDKdc0cmwWVK0ZAF9Zpg/4KypEGgydg+Ys4FC5eNaJ0+z5C
	 gpq+OgBfBVqNdzty0cxltnv9hK2icLanb7s4v1oR2tenV6HLMiZQIxrpgKH+5Zslbs
	 wnsYlzXPYABVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01DF740BBF;
	Fri,  4 Sep 2026 13:08:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AA702FD
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 11:54:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CC184031A
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 11:54:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zk0AjRmhXGlM for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 11:54:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 65A5C40080
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788522882;
 b=MxOAq4kJrKIrdCR0XebRxdgH7NkTTRQTWd0fhAerDaUQ28yEEW384c1L9oi3kZahin4T
 jzca4svnxrMQaCsQDI+VB+ywTt0YiV2nzUCCxn/oY+NcOhlYTenxY6bacyegbpg5g2TXP
 9gbrO43zbu8I7v+jpmW2rFEGfQwb+LjfpPd7wgoPdDe7Dso9JwgnWCFeEZZcH6wBPOX4s
 1OnUyCMc37MccUDfujugMnzEHDInsjOZimmboAS7eNB2cZ8pO7nyeSmjJY9eyNr02RsmQ
 mJpjk+ayNv7PAOhwdwCPUAIabxveYhq+u3jG3l7LsJOZpHIcmUXR/eNYzi8U06skoFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788522882;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=U4v/Rd596CW3I1R5RGhkVVX0SvjLUmd2mxJ4mJ8hPJo=;
 b=esLofqOhgFaGm3Do8ao0pdgoTPC8KzxNuTbfUeu8dGOVji7+QOVouXn2zXtSWOC/hBDx
 1a7rFDxmP09SiF6dgmUTFq4+V0KPUFmke1yQtAbDlG39hxKoUMN0LxD58l7SdKo7YF2nY
 7oYsokR0R25ae4a/tEGMF/Gk8xYioogU2O9sbC5CIf2f+sLGQTpSvw5gqTt6q7Rd4JwAa
 zkDl88uas5IEwiOjdXT1Me7aF2zLXF2DXy2+bIOdXRw1FHAOIVEUqvcTni1SC95nVNbXj
 74btk2mw5mKAtbYzT+DBKubNFzApovLH1oLXApv58e3+3h6QL3Ycc0P9uc5IDBcTe2Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cG5PnzBm; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cG5PnzBm
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 65A5C40080
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 11:54:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0106B600CB;
 Fri,  4 Sep 2026 11:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E209B1F00A3D;
 Fri,  4 Sep 2026 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788522879;
 bh=U4v/Rd596CW3I1R5RGhkVVX0SvjLUmd2mxJ4mJ8hPJo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=cG5PnzBm0sZ+WGOGiJIicHLd9cAc/Qay9VLVuTI6M4y7rSbpnwo/DETxsjCFbpolj
 VcKT6eM5hjq/HIc/R+o4vnTPxMmp5spvv3nDyHkxDocTmEVgQ0V2fxst1UcnWKDcAW
 VdGfS0WA2508rJWq5uZSxlXEoO5u6SvN4toSyf6VmLjCDPivXdCzdSIbZ2ORX2K0Ft
 DEG6V7SdnjmL6cZiqmORHXit8fXklKiNLAnU607iZi7xo2wxzPa74D9y1HA3m+bb/l
 9zjnVyJMQ07GL0XVB+ytgb6Ec8rjD4UAD6cG78ZlnunoNdK6QWPVGwRgpteH8teRIm
 Dtgk93oHKRR9w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: David Lechner <dlechner@baylibre.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Julien Stephan
 <jstephan@baylibre.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini <trini@konsulko.com>,
 Julien Masson <jmasson@baylibre.com>, Bo-Chen Chen
 <rex-bc.chen@mediatek.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Christian Marangi <ansuelsmth@gmail.com>, Yang
 Xiwen <forbidden405@outlook.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, Sjoerd
 Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>,
 Claudiu Beznea <claudiu.beznea@microchip.com>, Casey Connolly
 <casey.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Chris Morgan <macromorgan@hotmail.com>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Dylan Hung <dylan_hung@aspeedtech.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org,
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 06/14] usb: dwc3-octeon-glue: check dev_remap_addr() for
 NULL
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-6-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
 <20260903-b4-dm-addr-null-checks-v1-6-db945bd5e712@baylibre.com>
Date: Fri, 04 Sep 2026 13:54:36 +0200
Message-ID: <87zexxqlj7.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 04 Sep 2026 13:08:18 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi David,

Thank you for the patch.

On Thu, Sep 03, 2026 at 16:35, David Lechner <dlechner@baylibre.com> wrote:

> Check the return value of dev_remap_addr() for NULL instead of
> IS_ERR(). This function only ever returns NULL on failure.
>
> Drop the now-unused <linux/err.h> include.
>
> Fixes: 92ca2fee08d5 ("usb: xhci: octeon: Add DWC3 glue layer for Octeon")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/host/dwc3-octeon-glue.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/host/dwc3-octeon-glue.c b/drivers/usb/host/dwc3-octeon-glue.c
> index 975f375e15a..39f2e70e47d 100644
> --- a/drivers/usb/host/dwc3-octeon-glue.c
> +++ b/drivers/usb/host/dwc3-octeon-glue.c
> @@ -19,7 +19,6 @@
>  #include <dm/of_access.h>
>  #include <linux/bitfield.h>
>  #include <linux/delay.h>
> -#include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/usb/dwc3.h>
>  #include <linux/usb/otg.h>
> @@ -351,8 +350,8 @@ static int octeon_dwc3_glue_probe(struct udevice *dev)
>  	void __iomem *base;
>  
>  	base = dev_remap_addr(dev);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> +	if (!base)
> +		return -EINVAL;
>  
>  	dwc3_octeon_clocks_start(dev, base);
>  	dwc3_octeon_set_endian_mode(base);
>
> -- 
> 2.43.0
