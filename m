Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A28F606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZLP23mAD;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOoHmMKT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A01980F86;
	Wed, 18 Nov 2026 12:39:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1dCDyXzdgena; Wed, 18 Nov 2026 12:39:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6728180F8D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795005566;
	b=Od2BPkHeSUFR6DHJBBgWS0DWD4fGKin2t+C8X4ZxOk7Al+zq2MEzbyqi/N2XSezJ1NlQ
	 SAoLKQFXqyF/zVdLlvg6431J2ZQ5Bz/z8t1vtkQVN+Kig+xpwTge/bpW7WgbszHahpaK/
	 EfA8M4/CF2tzXBPk5LZH9VqlFWzX1f7WU+rVuUa2XqxUk5KW7o8rOn0HZeAv/o7oAoXb2
	 GUQMaFlzvjNw2grYppEVRs1lnDVd1WRk1jUNywldhmF5CDDeQxts6o9IBR8+IGujRuMbA
	 Qoq39iXpSm+H8OWzAOriV6dRxIM3asFEvQMQxWpx4ArVC7BP+iVw3cRw498hyGzmrcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795005566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YpKGyItD6cL6xDbvkp5MCSSIpsrgWcDxjKhO60YNd2k=;
	b=pmChnVA42MsyPesIt52OtH+zGiDF14vcFK39QSI1GFzKIXmrsWtIwzA8S9hwp2CK1QEI
	 jMIC99k3i1k+49I7VcZubPOvN1pp266ODXJA3CEUIVvHM/zwP+ZMnGAA55DIXeTs6G73W
	 rJBXY57NsUMD+vkuRgU6HTb1bK4A4fD/H/pNbiHh0ROfDSaKOtjXlXZqet5hCL7IA1oG+
	 qDBa/pxN5xbRn1VeqpQL55/HMql9DOWI88ZVX1Xk/VOOSqnEElogE2tbyuCP4HvMbGzG1
	 /ro+6zSAfPMs0EN59TAj8y6uNmSCHSmt/VEmFQEnrF8e+ugvbIhBCuPc9pm7OfErvrA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795005566;
	bh=YpKGyItD6cL6xDbvkp5MCSSIpsrgWcDxjKhO60YNd2k=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZLP23mADoMpuoL5maqIGs6+vKt4eJC6ROKf3Y9mWfLEAUwTUUnN+ZBCUc+WY5XrKT
	 CObuSlkpaX5h8WTgTQAJCGW1W2WF/T+mzraiD05lxT37aGqdULc2DXlwWR8mfTBWmY
	 NyTVdviYqE2AKOAEhTLzZpeXKbwmsPgr/7N1vKsLqtjk7opr8mGowJfHiknUNYRlBv
	 RF9QuU2W0RAzpjdpzgbCC2looVNmPkWa6lAGUFsv0UtGuiDXe60w0uOq/segk3ZbhU
	 tgeGjMb2QzLzuT6VDj9U5OL24BWGlci0r3EIQUWhwv8IVgn7k7s4itfXK0p9bmeaGY
	 RhwQuYdNbQNjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6728180F8D;
	Wed, 18 Nov 2026 12:39:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B7C79F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE54E60642
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:39:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id trLJ5sqiBaj3 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 12:39:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2F949605EF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=DOoHmMKT
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F949605EF
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 12:39:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B15261CF7;
 Wed, 18 Nov 2026 12:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33A01F000C5;
 Wed, 18 Nov 2026 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795005561;
 bh=YpKGyItD6cL6xDbvkp5MCSSIpsrgWcDxjKhO60YNd2k=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=DOoHmMKTmSE6MNrMk/knYR3z1HLi4bFCzpQbnGeJapAqkb8YYCHKifeJsNuL09YwP
 K0tyLib8ccD5jTIHPZDWbtIH1cNCr2zKTfH1FGh6Z5qJFxi0MonEtk0jEvt+hq1TgI
 9V4xm5IWpG0/vF3oYHkBHXwzFFsUEXxszMTQsACXJIBxmGiPLH36Q3WX0uepQQj2/d
 PAVrcTAbGFSzjBmYJxeZryF4+jz1FIcG65mtA8E5STmK3YEKnlZ5dVOFu422DeU1LG
 Qpsw9wfNv+DdtXyrSrCR1yujKhN0dDWWXoln8B3nBbeM61GtgeDtIuOvj4vh9Zet81
 QCT9OyyEjMSpA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] usb: gadget: dwc2: find the Rockchip USB2 PHY for the
 DM gadget
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: =?utf-8?q?Yal=C3=A7=C4=B1n_Can?= <ylcncn@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261030073746.165207-1-ylcncn@gmail.com>
References: <20261030073746.165207-1-ylcncn@gmail.com>
Date: Wed, 18 Nov 2026 13:39:17 +0100
Message-Id: <179500555705.285113.9112266427127720541.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2574;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=Shai7c2vm/Wf59DoMr+jIf93j8AIzPPsTEyLvO+zb2o=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Zx2cQ+Ky50VuPs9zUD3uzt+5+rNs3vqkwEPF
 5X6buQEhCqJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav2cdgAKCRAZDR20Zk4Z
 Na87B/9M3idcvmJ/Vxby8X6RjoqYcL3eN/+cv96q/KNQ/vFbRiwnpcbC9jHqn3E7asLq0LEEwrD
 YGYvcRFYiN+uiKUOlexmrTaT5g3AHwRIoBq4uGr8wa7+6Q2R3+ljLOK1FHIEVEwEcPt/kcby1t0
 1DYt9caUWm8dfNVFQHoW9pVHVwusbMUFmS4D4uzouSomoIZilUyAui5N7AEr1JvJhJpojZafVoJ
 ilgfrbGlbZwtwvl6RXGBBtoo6b1zGn9JPJy4mAoyeA3r2kGs0+1wOLrrrvBNDenYmg5a+mnfHHP
 wjx+XVp0gebRcl8C7W3TUkvD2qEwtze6NLd8OAlmiDc4Kagz
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yalçın,

Thank you for the patch.

> rockchip_usb2_phy.c's otg_phy_init() finds its register layout through
> plat->phy_of_node and calls hang() without it. Only the non-DM
> board_usb_init() path fills that in, so with the DM gadget (USB ACM
> console, fastboot, UMS) any gadget on RK3066/RK3188 hangs.
> 
> Look up the PHY from the "phys" phandle and set phy_of_node and regs_phy
> the same way.
> 
> Tested on an MK808B (RK3066): USB ACM console, fastboot and UMS.
> 
> Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>

Thanks for reporting that LLM has been used to generate this.

checkpatch.pl seems to complain about this trailer. I think it should be
removed.

> Signed-off-by: Yalçın Can <ylcncn@gmail.com>
> ---
>  drivers/usb/gadget/dwc2_udc_otg.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
> index 570fed347c9e..e982709f120d 100644
> --- a/drivers/usb/gadget/dwc2_udc_otg.c
> +++ b/drivers/usb/gadget/dwc2_udc_otg.c
> @@ -20,6 +20,10 @@
>  #include <clk.h>
>  #include <dm.h>
>  #include <generic-phy.h>
> +#if CONFIG_IS_ENABLED(ROCKCHIP_USB2_PHY)
> +#include <asm/arch-rockchip/clock.h>
> +#include <syscon.h>
> +#endif
>  #include <log.h>
>  #include <malloc.h>
>  #include <reset.h>
> @@ -995,6 +999,25 @@ static int dwc2_udc_otg_of_to_plat(struct udevice *dev)
>  
>  	plat->regs_otg = dev_read_addr(dev);
>  
> +#if CONFIG_IS_ENABLED(ROCKCHIP_USB2_PHY)
> +	/*
> +	 * rockchip_usb2_phy.c's otg_phy_init() finds its register layout through
> +	 * phy_of_node and hang()s without it. The non-DM board_usb_init() fills it in;
> +	 * do the same here so the DM gadget (USB console, fastboot) works on RK3066/3188.
> +	 */
> +	{
> +		struct ofnode_phandle_args args;
> +		u32 offset;
> +
> +		if (!dev_read_phandle_with_args(dev, "phys", "#phy-cells", 0, 0, &args) &&
> +		    !ofnode_read_u32(args.node, "reg", &offset)) {
> +			plat->phy_of_node = ofnode_get_parent(args.node);
> +			plat->regs_phy = offset +
> +				(uintptr_t)syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
> +		}
> +	}
> +#endif

I've compared this with the code in arch/arm/mach-rockchip/board.c and
it looks indeed similar.

What I fail to understand is why we can't do this via a platform compatible.
Per my understanding we can use '"rockchip,rk3066-usb", "snps,dwc2"' to
match this.

Could we extend this via dev_get_driver_data() instead?

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
