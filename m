Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB790C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6128E84A51;
	Fri,  3 Jul 2026 15:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iasdPp+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8B4784A5D; Fri,  3 Jul 2026 15:33:03 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7411F84A4D
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 15:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61E1260051;
 Fri,  3 Jul 2026 13:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC4D1F000E9;
 Fri,  3 Jul 2026 13:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783085579;
 bh=p3UO63SI/DBOZrGTkavebgtAjKOcGCYdx7p0Ndq4dN8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=iasdPp+Ps/3+6Ui2CWyUJFahWf8fSj8tIpvR7Ew7xB7ZVBT8kFaYaJ92zMbVmSda5
 5yEW6uw7cDizHNK1bDFE5GSjhvH9PQ7PzCs+gAzGSPVWeo2WmGnxS6/SdhohxkR02N
 ntGBmEZclOwn1/yvx2mZXt3o2EbcwgUinXk+q9M6hcsWNw5+7hagy5PdAtlqaPF2QC
 z6KrWkOjyqNPrT4ltqGV9cJOlpANGOkp1KA9Y2Y3TpN5SsJZzGFJYyo7Ry0g78VaN4
 i3aqzOyn3NUo066fbsGlthw4+c4DeiAJ7tzGWlod7d+f5xR3/xn4wlnt56dxdl8S77
 aUVs31rgqjkHg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de, Marek
 Vasut <marex@denx.de>, Andre Przywara <andre.przywara@arm.com>, Andrew
 Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, Bin
 Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai
 <eddie.cai.linux@gmail.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Ion Agorria <ion@agorria.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Kongyang Liu
 <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>, Neil
 Armstrong <neil.armstrong@linaro.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom
 Rini <trini@konsulko.com>, Varadarajan Narayanan
 <quic_varada@quicinc.com>, Weijie Gao <weijie.gao@mediatek.com>, Zixun LI
 <admin@hifiphile.com>, Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v4 00/64] drivers: usb: dwc3: sync code with Linux v6.16
In-Reply-To: <CAC_iWjJnFVq-nW+EoB-svBZuXf5kjOiwXHcMV9BHfujpMVg+Gw@mail.gmail.com>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <8733y48j44.fsf@kernel.org> <87zf0c6td8.fsf@kernel.org>
 <87v7az6l03.fsf@kernel.org>
 <CAC_iWjJnFVq-nW+EoB-svBZuXf5kjOiwXHcMV9BHfujpMVg+Gw@mail.gmail.com>
Date: Fri, 03 Jul 2026 15:32:56 +0200
Message-ID: <87bjco6vw7.fsf@kernel.org>
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

On Wed, Jul 01, 2026 at 22:56, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:

> Thanks Mattijs,
>
> This helps a lot

Happy to help !

The diffs could actually be done on master/next already. So i've send a
standalone series to make sure that we don't break VIM3 even after this
migration:

https://lore.kernel.org/all/20260703-usb-prep-dwc3-sync-v1-0-1352bc238c9b@kernel.org/

>
> Cheers
> /Ilias
>
