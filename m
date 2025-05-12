Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8B9C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 07:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD3881FEE;
	Mon, 12 May 2025 09:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EWTryx/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A660181FFC; Mon, 12 May 2025 09:02:08 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88B3681DD6
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 09:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7A606A49F29;
 Mon, 12 May 2025 07:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF31C4CEE7;
 Mon, 12 May 2025 07:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747033324;
 bh=2CRXDIp4gM1fevXFsxmnOCf85QFcTk7p60znfzs7wJA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EWTryx/N2597Tnd+Q2rnLNZ9IKH8vvd8Y/76jNP9hQ9S/R0vNzWIP5urgj3JvjHoe
 dNHRvkSdNbxFFefNWuUtYOynmGxZEXVk97hYP7y0a1xKuOOX7IyOBC+8eVB+WxplCt
 JQrXjsJv9XoPJ4QraQKcJah8OI1YifqRHY0zUFhajcgip+R+nqSjywmyH2fjc0ADhh
 qULzBk5vpNN/Rzo1Y9CzjBC9/KPjOu6ZxrtuAl1G2ed+4gpKPfugRQyEiOzDFM7CH6
 uc7MFZCgP0ssmUZ46DmQYR0g7YWgQgcYOTnKvyw7kFzo15LlC62p62GPsrrFAW9kpt
 eBlcropzidcxw==
Date: Mon, 12 May 2025 12:31:58 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH] qcom_defconfig: Enable AUTOBOOT_KEYED support
Message-ID: <aCGc5giJlI9Wqxwl@sumit-X1>
References: <20250508103238.230608-1-sumit.garg@kernel.org>
 <fe44fd2a-f16e-4f84-affa-3f9fbbbbdc9b@linaro.org>
 <aB4XFmFxBj30x5U6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aB4XFmFxBj30x5U6@linaro.org>
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

On Fri, May 09, 2025 at 04:54:43PM +0200, Stephan Gerhold wrote:
> On Fri, May 09, 2025 at 12:45:20PM +0200, Casey Connolly wrote:
> > On 5/8/25 12:32, Sumit Garg wrote:
> > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > 
> > > When debug serial port isn't connected, it is at least reported on RB1
> > > that autoboot gets interrupted. It is probably due to random characters
> > > on the UART RX line when disconnected. Lets try to fix this inconsistent
> > > behaviour via enabling AUTOBOOT_KEYED such that the autoboot gets
> > > interrupted only when the <SPACE> key gets pressed.
> > 
> > Honestly I'd much rather fix the bug in the UART driver, maybe it's broken
> > pinctrl?
> > 
> > The older UART driver (for msm8916) had a similar but that Stephen was able
> > to fix with better configuration.
> > 
> > Anyhow, this is a sensible enough workaround if nobody wants to look into
> > GENI...
> > 
> 
> Well, the main fix I did for that isn't related to the UART driver at
> all, it's simply adding bias-pull-up for the RX pin so that it isn't
> left floating when UART is not connected.
> 
> For RB1, qcm2290.dtsi &qup_uart4_default currently has bias-disable for
> both RX and TX pins. So please try applying bias-pull-up + bootph-all
> for the GPIO that belongs to RX.
> 
> For details, please see the following patch series for MSM8916:
> https://lore.kernel.org/linux-arm-msm/20250422-msm8916-console-pinctrl-v2-0-f345b7a53c91@linaro.org/T/

Thanks for this reference but unfortunately this doesn't fix the issue
on RB1. I have tried the diff below [1]. It seems most likely due the
chainloading via ABL on RB1 as compared to U-Boot running as primary
bootloader on db410c. The RX line seems to be floating even before the
U-Boot starts which is causing the autoboot to stop. So for the
chainloading configuration, we need to enable AUTOBOOT_KEYED. I think
it should be the default sane configuration on Qcom platforms rather
than allowing autoboot stopped via any random character on RX line.

[1]

diff --git a/dts/upstream/src/arm64/qcom/qcm2290.dtsi b/dts/upstream/src/arm64/qcom/qcm2290.dtsi
index f0746123e59..9392bd6f3e0 100644
--- a/dts/upstream/src/arm64/qcom/qcm2290.dtsi
+++ b/dts/upstream/src/arm64/qcom/qcm2290.dtsi
@@ -551,10 +551,28 @@
                        };

                        qup_uart4_default: qup-uart4-default-state {
+                               tx-pins {
+                                       pins = "gpio12";
+                                       function = "qup4";
+                                       drive-strength = <16>;
+                                       bias-disable;
+                                       bootph-all;
+                               };
+
+                               rx-pins {
+                                       pins = "gpio13";
+                                       function = "qup4";
+                                       drive-strength = <16>;
+                                       bias-pull-up;
+                                       bootph-all;
+                               };
+                       };
+
+                       qup_uart4_sleep: qup-uart4-sleep-state {
                                pins = "gpio12", "gpio13";
-                               function = "qup4";
+                               function = "gpio";
                                drive-strength = <2>;
-                               bias-disable;
+                               bias-pull-down;
                        };

                        sdc1_state_on: sdc1-on-state {
@@ -1293,7 +1311,8 @@
                                clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
                                clock-names = "se";
                                pinctrl-0 = <&qup_uart4_default>;
-                               pinctrl-names = "default";
+                               pinctrl-1 = <&qup_uart4_sleep>;
+                               pinctrl-names = "default", "sleep";
                                interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
                                                 &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
                                                <&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG


-Sumit
