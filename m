Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C135C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBD99605F8;
	Wed, 29 Jul 2026 12:45:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJ4wPoaFd992; Wed, 29 Jul 2026 12:45:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E219D60B0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785329111;
	bh=PnEjyvsf1HeZPsWSOld1VBvtyWO7T9OafJLnSp1ZQAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j4OL8lQDgI4fJNzG2QuRNlMO1xxKttbb6IdT7oaiWx/+uBgN8ELSMFuBFUgCOqPMq
	 ukCzds7hx4Qy8k4HY2ALSfJ52fscstO7PFheXPn9syIRg+f6QrkrjZEqog/uH9NMmL
	 IjuG9c5nvzFAt+RYuXcAiVOssZcAEEt7+HzDUszWUccKXGEb6pEO7LMRimCk0No3sV
	 z9i3H3Nzn9uuHP3zd3dqnWmuCccAWbl8xfGNc/A5VwOZTaUAsU4xlnoPBKflef1Mfx
	 Ym9kPO7VaWZJbm1I/69FGJAVz+QVGVZWYunVtTQmgQvlBQH32fE6wbpcCjjKz7AJWj
	 SmiIEHZchxVhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E219D60B0B;
	Wed, 29 Jul 2026 12:45:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 55A7C2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C2274025D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:45:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ootu9bEyUb_L for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 12:45:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7A7A640074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7A7A640074
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A7A640074
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:45:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A575942B93;
 Wed, 29 Jul 2026 12:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15B11F000E9;
 Wed, 29 Jul 2026 12:45:05 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
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
 <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] phy: phy-mtk-hdmi: add new driver
In-Reply-To: <20260728-mt8188-add-hdmi-phy-driver-v2-1-8b2893b151ba@baylibre.com>
References: <20260728-mt8188-add-hdmi-phy-driver-v2-1-8b2893b151ba@baylibre.com>
Date: Wed, 29 Jul 2026 14:45:03 +0200
Message-ID: <87bjbqx8vk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785329106;
 bh=PnEjyvsf1HeZPsWSOld1VBvtyWO7T9OafJLnSp1ZQAA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ZP9+MZSe7vuGt+flh7jCGdNCbiQnpH0/F+NQAe/MSh26qaB/TPsHpD7qKlZXAxDgu
 tnk1ytMmh0L7qg00JJjj/HUpBBKCUTE9WfsKPGoJZI3lrURP5DW9sIykh4cm8x3OQe
 0Wajn/Pe1iWITqJMwjWkHlvx8G7JYycYtY2/RlrTsmHX5v6wKMnD1DvhHffMuOEGCm
 8AhdN9E7Z7K40jI0Bh7XUTZlK3G8PCy36VK36bo6+FxroJltTQbnUTPsHseEzcC6Xv
 YEypFBjgBiaH6W6k7Yyxf2lnaVwdh/rHfNolIm9s7uLDUpyQiKoJDroyHMl5NbpeKO
 xmATW7CMftv5A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ZP9+MZSe
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Julien,

Thank you for the patch.

On Tue, Jul 28, 2026 at 17:01, Julien Stephan <jstephan@baylibre.com> wrote:

> Add a new driver for the HDMI PHY. The driver supports MT8188 and MT8195
> based SoCs. The driver is based on the corresponding kernel driver
> (Commit 7a4ce5a9b674 - phy: mediatek: phy-mtk-hdmi-mt8195: convert from
> round_rate() to determine_rate()).

In the future, consider using standard commit formats, see:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

In this example, that would give us:
commit 7a4ce5a9b674 ("phy: mediatek: phy-mtk-hdmi-mt8195: convert from round_rate() to determine_rate()")

>
> Signed-off-by: Pavlo Yadvychuk <pyadvychuk@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

I've reviewed this comparing to the upstream linux driver. I don't see
anything strange. This looks like a clean port to me.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

