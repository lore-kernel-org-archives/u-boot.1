Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BC6C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 11:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5628846FD;
	Mon,  6 Jul 2026 13:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thundersoft.com header.i=@thundersoft.com header.b="OEzjIfnT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 553038488D; Mon,  6 Jul 2026 13:35:08 +0200 (CEST)
Received: from mail-m6053.netease.com (mail-m6053.netease.com [210.79.60.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C967084105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 13:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=thundersoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hongyang.zhao@thundersoft.com
Received: from tsdl-HP-EliteDesk-880-G6-Tower-PC.. (unknown [36.129.139.90])
 by smtp.qiye.163.com (Hmail) with ESMTP id 451344504;
 Mon, 6 Jul 2026 19:34:58 +0800 (GMT+08:00)
From: Hongyang Zhao <hongyang.zhao@thundersoft.com>
To: casey.connolly@linaro.org
Cc: balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 hongyang.zhao@thundersoft.com, jerome.forissier@arm.com,
 jstephan@baylibre.com, kory.maincent@bootlin.com,
 marek.vasut+renesas@mailbox.org, neil.armstrong@linaro.org,
 peng.fan@nxp.com, philip.molloy@analog.com, quentin.schulz@cherry.de,
 raymond.mao@riscstar.com, rosh@debian.org, sjg@chromium.org,
 stefan.roese@mailbox.org, sumit.garg@kernel.org, trini@konsulko.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de, visitorckw@gmail.com
Subject: Re: [PATCH v2 1/3] dts: qcs6490-rubikpi3: Add U-Boot dtsi
Date: Mon,  6 Jul 2026 19:34:48 +0800
Message-ID: <20260706113448.132881-1-hongyang.zhao@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1fc22177-b677-4b02-b527-48727dd0e75b@linaro.org>
References: <1fc22177-b677-4b02-b527-48727dd0e75b@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f3735c3a309d5kunm8bd91ec725ad55
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEIeVh5CHU0YTRgdSkIZGFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKSUJVSkhCVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0
 lPT09IVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=OEzjIfnTfUoLBKxCur3sOUiJQD99ItW1ZOutXFNqbKJqOF3eYzTFhELv9lhBmjmXPFkg30rOjni25CeVijl4CYxMKrNve2tAg29g2EmchtWPdWpY6LRRukje0SY9lDbhnQUnbC/yJoj/IY4g056Xf1sINtT0F3XR6CIttz2aTxg=;
 c=relaxed/relaxed; s=default; d=thundersoft.com; v=1; 
 bh=EOLK8ae9IiVevjeS1OqBFj6UYRYqA1s74CyLLN7EWmE=;
 h=date:mime-version:subject:message-id:from;
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

Hi Casey,

Thanks for the review.

On 6/24/26 14:45, Hongyang Zhao wrote:
> > Add the board-specific U-Boot device tree overrides for the
> > Thundercomm RUBIK Pi 3.
> >
> > When U-Boot is loaded as the primary bootloader, no previous stage
> > provides the memory layout. Describe the 8 GiB LPDDR4x layout locally
> > so U-Boot can use the available DRAM.
>
> I'm hoping we can skip this patch, since we now support retrieving the
> memory map dynamically from SMEM. I'd appreciate it if you could do a
> clean build of the qcom-next branch here and see if it works without this.
>
> https://source.denx.de/u-boot/custodians/u-boot-snapdragon
>
> You also shouldn't need to use qtestsign as MBN support was also just
> picked so u-boot.mbn should be built directly.
>
> I used the Rubik Pi for testing both series locally so crossing my
> fingers you don't run into any issues.
>
> Thanks,
> // Casey
>

I tested the qcom-next branch on RUBIK Pi 3 without this U-Boot dtsi patch.

The board boots successfully with the generated u-boot.mbn, and Linux starts
via U-Boot EFI. The memory map also looks correct; Linux reports the memory
range from 0x80000000 to 0x27fffffff, matching the 8 GiB layout.

So the SMEM-based dynamic memory map works fine on RUBIK Pi 3. I will drop
this dtsi patch in v3, and also update the documentation to use the directly
generated u-boot.mbn instead of qtestsign.

Thanks,
Hongyang

>
> >
> > Signed-off-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >   .../arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> >
> > diff --git a/arch/arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi b/arch/arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..8518cd402d0
> > --- /dev/null
> > +++ b/arch/arm/dts/qcs6490-thundercomm-rubikpi3-u-boot.dtsi
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/ {
> > +	/*
> > +	 * When running as the primary bootloader there is no prior stage to
> > +	 * populate the memory layout for us. We should have multiple nodes
> > +	 * here, but ABL does not like that.
> > +	 */
> > +	memory@80000000 {
> > +		device_type = "memory";
> > +		reg = <0 0x80000000 0 0x39700000>,
> > +		      <0 0xc0000000 0 0x01800000>,
> > +		      <0 0xc3400000 0 0xbcc00000>,
> > +		      <1 0x80000000 1 0x00000000>;
> > +	};
> > +};
> > +
> > +// RAM Entry 0 : Base 0x0080000000  Size 0x0039700000
> > +// RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
> > +// RAM Entry 2 : Base 0x00C3400000  Size 0x00BCC00000
> > +// RAM Entry 3 : Base 0x0180000000  Size 0x0100000000
> >
