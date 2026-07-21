Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D3CC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 09:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DB4A80E1C;
	Tue, 21 Jul 2026 09:22:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a-LdRY2nEiMw; Tue, 21 Jul 2026 09:22:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40B7B80DD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784625746;
	bh=7HCLFDcqSPa56XaYyVhTA1+uDp5CXA6EEXyG+fcDbtE=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RvKzVGcxpxYrBBEPeg05h0Sp7oNdweDuGwIBU1rvZW8z5UhjTgUVISrahzPxjkUJe
	 Ie0Qms8fHoZA/5XJPakyEi0fScbjMQzidcKTELzGeuASNGUwbkw3ItGkFxj50qM+ln
	 NPz/mbY9JJuvndVvr/uKJ92t6w9cjYkRTruGvC+YjnXZIJ87TOfhYFVwoF0M2dU+CU
	 WSq/ATE1s8pdNaTTTLD0H38OtL4mr9RjJnAuEbF0PEx7Xmu/In2K7T6bI7AXHz8XIt
	 WZ2SAz+rhkyF0QyPWR86mTKcI/B/fV1+vDgzOUmgpolCKmtX4VYveL2O9538VM+yBD
	 x6NxCxcjCufag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40B7B80DD8;
	Tue, 21 Jul 2026 09:22:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E1BB109C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2341960830
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qw6Bd6QF0OUs for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 09:22:24 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CBDD460821
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CBDD460821
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CBDD460821
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 09:22:23 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31696844F6; Tue, 21 Jul 2026 11:22:22 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C1F803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 11:22:19 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE4D943BC7;
 Tue, 21 Jul 2026 09:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B0DD1F00A3A;
 Tue, 21 Jul 2026 09:22:17 +0000 (UTC)
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Igor
 Belwon <igor.belwon@mentallysanemainliners.org>, David Lechner
 <dlechner@baylibre.com>, Minkyu Kang <mk7.kang@samsung.com>, Casey
 Connolly <casey.connolly@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Lucien.Jheng"
 <lucienzx159@gmail.com>, Alice Guo <alice.guo@nxp.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Johan Jonker <jbx6244@gmail.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Julien Stephan
 <jstephan@baylibre.com>
Subject: Re: [PATCH] phy: phy-mtk-hdmi: add new driver
In-Reply-To: <20260717-mt8188-add-hdmi-phy-driver-v1-1-4278457fe2cb@baylibre.com>
References: <20260717-mt8188-add-hdmi-phy-driver-v1-1-4278457fe2cb@baylibre.com>
Date: Tue, 21 Jul 2026 11:22:15 +0200
Message-ID: <871pcwk88o.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784625737;
 bh=7HCLFDcqSPa56XaYyVhTA1+uDp5CXA6EEXyG+fcDbtE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=nU+V8k+W5e7qRLOGXpovPv4ep18xUJJfO+6j+QKyKr/BCi/jqrSF9+r3Ooj2GyjZm
 oO7K7+FuwUweUmneiJL9rHS8mPZK+1lME1Axr5FxpDVJQYEMymTL42qvPxJzrpHWsD
 GUqDWTBsTdWTdxjzVexiTmdQ5mcj2uq7UXk/WGqYBPujKoV5yP1NEqw2HLSIQkL25q
 HhMNLJxgkHPU+qMyivZA8m3+XDjwdIL0ZJdX/LB7JTYqPbNg7+vmjA5FELy2IDFrzS
 17gZ9J2L6goTt9Ad3uwBX/vUFtQRNUP+v0HKM56M+I+A0zJ9V1/BXfr33fBwubiOZ1
 aWU+D1sngmN7w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nU+V8k+W
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="nU+V8k+W"; 
 dkim-atps=neutral
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
From: Mattijs Korpershoek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Julien,

Thank you for the patch.

On Fri, Jul 17, 2026 at 10:26, Julien Stephan <jstephan@baylibre.com> wrote:

> Add a new driver for the HDMI PHY. The driver supports MT8188 and MT8195
> based SoCs. The driver is based on the corresponding kernel driver.

What kernel version (exact commit, including the sha) has this been
ported from ?

Mentioning it in the commit message will help reviewers to compare this
with the linux codebase.

I can do a more detailed review once I know the linux base this has been
ported from.

>
> Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---

[...]

> +
> +	/* RG_HDMITXPLL_RESERVE[12:11] */
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_1,
> +			  0x3 << RG_HDMITXPLL_RESERVE_BIT12_11_SHIFT,
> +			  RG_HDMITXPLL_RESERVE_BIT12_11);
> +
> +	/* TCL_EN */
> +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_1_PLL_CFG_0,
> +			  0x1 << RG_HDMITXPLL_TCL_EN_SHIFT,
> +			  RG_HDMITXPLL_TCL_EN);
> +
> +	/* we should always read calibration impedance
> +	 * from efuse, unless for debugging purposes.
> +	 * This calibraion value is not board-dependent

calibraion -> calibration

> +	 * so no SW adjustment required.
> +	 */
> +	if (hdmi_phy->conf->efuse_sw_mode) {
> +		debug("efuse_sw_mode ENABLED!!!");
> +		mtk_hdmi_phy_mask(hdmi_phy, HDMI_CTL_1,
> +				  0x1f << RG_INTR_IMP_RG_MODE_SHIFT,
> +				  RG_INTR_IMP_RG_MODE);
> +	}
> +
> +	return 0;
> +}
> +

[...]
