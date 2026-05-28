Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C336FCD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 12:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1125B83FF5;
	Thu, 28 May 2026 14:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="FMv3dXzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 982DB844CF; Thu, 28 May 2026 14:55:49 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BB94803C6
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 14:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown [213.36.132.10])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 20D12B005A9;
 Thu, 28 May 2026 14:55:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1779972947;
 bh=eK6j2gYym8k/jDiuxLN/l444fPnJLlKwFuhYD/FyhFk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FMv3dXzn2q0S4DlKmlnRXg9jdxL2+QgRCs0Di1BSe8+EhsQcOkHZFI9ZWp07FgtkN
 A0FqLztB6qyaTzVwipKj1TozIVsVsH2Vfwasd90PRp+Zf08UqrTOeMznM+ohMKXUKF
 qAZ8gKs6F91vIBuxRu6wp0AxRPGQ5LV3Q4HyAcjKLixKPQDqm9cgkVEB14IDBuZegS
 0RzXrCZUNuNSJGSUlThSKJO6dqrxhgDpIwGIxRI1ymz8OyI9err5yGfSjK4ooQq22h
 UtYqdB0joT6KPXwh82/vn13+qSB9xlFt5PRTF8nPyIuZL6Zg+f7ox9Jzj+Wm+efhRv
 hMfkZo0aSi5IA==
Date: Thu, 28 May 2026 14:55:27 +0200
From: Vincent Jardin <vjardin@free.fr>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v1] thermal: qoriq: add Layerscape on-die TMU
Message-ID: <ahg7P7kr10_RQz19@L30177.local>
References: <20260527134744.511819-1-vjardin@free.fr>
 <20260527150459.GG1858239@bill-the-cat>
 <ahecFy5DsUzm/+aG@shlinux89>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahecFy5DsUzm/+aG@shlinux89>
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

Hi Tom, Peng,

Le 28/05/26 09:36, Peng Fan a écrit :
> On Wed, May 27, 2026 at 09:04:59AM -0600, Tom Rini wrote:
> >On Wed, May 27, 2026 at 03:46:45PM +0200, Vincent Jardin wrote:
> >> Add the support for lx2160 and other layerscape for:
> >>   => temperature list
> >>      | cluster67-thermal   | qoriq_thermal | tmu@1f80000
> >>      | ddr1-cluster5-...   | qoriq_thermal | tmu@1f80000
> >>      ...
> >> 
> >>   => temperature get cluster67-thermal
> >>      cluster67-thermal: 56000 mC
> >> 
> >> It is designed as a generic UCLASS_THERMAL driver for the
> >> QorIQ/Layerscape on-die Thermal Monitoring Unit (TMU).
> >> 
> >> It is similar to the "regs_v1" variant already implemented in
> >> drivers/thermal/imx_tmu.c, but the i.MX driver depends
> >> on <asm/arch/clock.h>, is_imx8m*() arch helpers, and OCOTP fuse
> >> reads that do not exist on Layerscape.
> >> 
> >> Rather than #ifdef the QorIQ bits, this driver is a clean Layerscape
> >> counterpart binding the standard "fsl,qoriq-tmu" compatible used by
> >> the Linux qoriq_thermal driver and by the existing fsl-ls10{28,88}a
> >> DTSIs too!
> >
> >Are there parts of the other driver that could be split out to a new
> >file/header and shared? Or are the i.MX portions too deeply embedded and
> >cannot be easily abstracted? Thanks!
> 
> QorIQ TMU and i.MX8MQ TMU shares same IP, with only minor differences.
> As I recall, the differences are in calibration part.
> 
> Current imx_thermal driver is too deeply embedded, not in a good shape.
> Need to give a look to clean it up.

I'll try my surgery. I'll send within few minutes a rework I had tried, gave up
and now trying again based on Tom's comments and your ack't Peng and IP are
more shared than what I thought.

See my next v2 on it. I did try to maximize the code reuse for both
Layerscape and iMX.

best regards,
  Vincent
