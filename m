Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590EAC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BADAB82B26;
	Thu, 15 May 2025 13:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tp4Fq+fO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E8482B26; Thu, 15 May 2025 13:11:28 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85DEB82B20
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EE8B544A07;
 Thu, 15 May 2025 11:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D09C4CEE7;
 Thu, 15 May 2025 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747307483;
 bh=zyaU1kMZIYcFvoYTpfyfVcF2Mecc0/aVGQMF50tzC0A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tp4Fq+fOmjW+CGMuSm1o+xedp+s0Co6JYvwJAnHDm7FaeKAGuQCIdbyXd286z++l/
 fZwb5eQsShigWeMOLsFNKz8lvT/MN4JYu54dbhKVg+m1caoLpajebtSceEV6IDXDbT
 66/3hYujp04fW1JeokTPWbaDSvNv40EM6olgBEddbPTeUKkE6ex0NUZEUCnZSTgTeg
 iPzdajGocjAYhx92KVJj2jUaxL1khUFiqVcsmRj4LMwbRoVel8fetT4qkXCh/wZ+Ov
 vhuOB1Jsf+eEkhHFKw3W6mIWZWEQIidV6MJXXZw/PgrMLtWeGI0vonvSfVI9P+mpto
 Gaco/LSYylijA==
Date: Thu, 15 May 2025 16:41:13 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH] qcom_defconfig: Enable AUTOBOOT_KEYED support
Message-ID: <aCXL0SnVrhfueAHk@sumit-X1>
References: <20250508103238.230608-1-sumit.garg@kernel.org>
 <fe44fd2a-f16e-4f84-affa-3f9fbbbbdc9b@linaro.org>
 <aB4XFmFxBj30x5U6@linaro.org> <aCGc5giJlI9Wqxwl@sumit-X1>
 <8ab60d1b-8afb-4659-837e-fafd4b46a060@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab60d1b-8afb-4659-837e-fafd4b46a060@linaro.org>
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

On Tue, May 13, 2025 at 04:54:22PM +0100, Casey Connolly wrote:
> Hi Sumit,
> 
> On 5/12/25 08:01, Sumit Garg wrote:
> > On Fri, May 09, 2025 at 04:54:43PM +0200, Stephan Gerhold wrote:
> > > On Fri, May 09, 2025 at 12:45:20PM +0200, Casey Connolly wrote:
> > > > On 5/8/25 12:32, Sumit Garg wrote:
> > > > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > > 
> > > > > When debug serial port isn't connected, it is at least reported on RB1
> > > > > that autoboot gets interrupted. It is probably due to random characters
> > > > > on the UART RX line when disconnected. Lets try to fix this inconsistent
> > > > > behaviour via enabling AUTOBOOT_KEYED such that the autoboot gets
> > > > > interrupted only when the <SPACE> key gets pressed.
> > > > 
> > > > Honestly I'd much rather fix the bug in the UART driver, maybe it's broken
> > > > pinctrl?
> > > > 
> > > > The older UART driver (for msm8916) had a similar but that Stephen was able
> > > > to fix with better configuration.
> > > > 
> > > > Anyhow, this is a sensible enough workaround if nobody wants to look into
> > > > GENI...
> > > > 
> > > 
> > > Well, the main fix I did for that isn't related to the UART driver at
> > > all, it's simply adding bias-pull-up for the RX pin so that it isn't
> > > left floating when UART is not connected.
> > > 
> > > For RB1, qcm2290.dtsi &qup_uart4_default currently has bias-disable for
> > > both RX and TX pins. So please try applying bias-pull-up + bootph-all
> > > for the GPIO that belongs to RX.
> > > 
> > > For details, please see the following patch series for MSM8916:
> > > https://lore.kernel.org/linux-arm-msm/20250422-msm8916-console-pinctrl-v2-0-f345b7a53c91@linaro.org/T/
> > 
> > Thanks for this reference but unfortunately this doesn't fix the issue
> > on RB1. I have tried the diff below [1]. It seems most likely due the
> > chainloading via ABL on RB1 as compared to U-Boot running as primary
> > bootloader on db410c. The RX line seems to be floating even before the
> > U-Boot starts which is causing the autoboot to stop. So for the
> > chainloading configuration, we need to enable AUTOBOOT_KEYED. I think
> > it should be the default sane configuration on Qcom platforms rather
> > than allowing autoboot stopped via any random character on RX line.
> 
> I dug into it and the rogue inputs actually come from the button-kbd driver,
> maybe the buttons are slightly misconfigured. This explains why it only
> happens on some boards.
> 
> So the right solution here is to fix the buttons, or disable button-kbd if
> you don't need it.

I tried disabling button-kbd using following patch but still the
autoboot gets stopped on RB1 with disconnected serial cable. It is most
likely caused by rougue chars on serial sue to floating RX line before the
boot flow reached U-Boot. I am even able to reproduce the same issue on
db845c in chainloaded config.

So, AUTOBOOT_KEYED seems to be the best possible solution here for
chainloaded config.

diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
index 87703b5a643..eab153d6879 100644
--- a/board/qualcomm/default.env
+++ b/board/qualcomm/default.env
@@ -1,4 +1,4 @@
-stdin=serial,button-kbd
+stdin=serial
 stdout=serial,vidconsole
 stderr=serial,vidconsole
 preboot=scsi scan; usb start
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e3dac23f1d0..45a203ddf78 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -80,8 +77,6 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_QUP=y
 CONFIG_SYS_I2C_GENI=y
 CONFIG_I2C_MUX=y
-CONFIG_DM_KEYBOARD=y
-CONFIG_BUTTON_KEYBOARD=y
 CONFIG_IOMMU=y
 CONFIG_QCOM_HYP_SMMU=y
 CONFIG_MISC=y

-Sumit
