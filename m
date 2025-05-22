Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FA4C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 16:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 924268312A;
	Thu, 22 May 2025 18:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XAGoOOgi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 354D88313B; Thu, 22 May 2025 18:21:27 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A3BD83121
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 18:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a4bdee0bf7so703506f8f.1
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747930884; x=1748535684; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gx/gI2Ve/U8BhDTNKuXDFig3lmeq+/9/U/3TcqPYSts=;
 b=XAGoOOgi02uTaleMMLZpjuF81+cObMGrJPiQwA1947DcNOZ+dp09aASvG0tZvtvDk4
 p25/lTUyR3fhsG7ur0pDpQpU1xEytanDg0uDGVkyA08HUywebtFluoSv8TRU1zXsGImh
 EmwasoFA3ZQy/8ad+V1JVx8F0L0CcGo8Gm1k5QobeZnj8ioBLvdze3NKLShjxJyruzyb
 W9OJLhoHZrSd3dj0XjzMNcvbcO+HNaBf4O+GHT2gpRINDPGPSPx2i3fM1ujvufJ+iXSh
 BYFgJuSoskdrssjyX+UVSWJ5TOdCXr1o+3ih0nKE0sCHABAyJS4ais82iEWHj2CSYtwm
 dQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747930884; x=1748535684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gx/gI2Ve/U8BhDTNKuXDFig3lmeq+/9/U/3TcqPYSts=;
 b=d60IS2N111wgNsxlBKDDSHLXuAkgFIwiR1svB9YcqjcAMYGgUYRFSO4pFJ/jcgwS6B
 ENojUkiAYPV2t0fVewEBFi9TIkmh1vPmdKSkjtCwAmb0izB7Qn2ZWXz/xZgz5ajbJSou
 91NaxExt2oPrHc84ggBECA+OJX1cbWluzjJomX9NPguAey66dQpOu4odSR/B0vmWBTNr
 C2DO9EmJ8epLBmK8Q2WXqvcZ6KyFXbUeWCzR/iNRrNT7p+d5268ND0wTKZ86VAT9C9WO
 P1HRisMB/ADO0kXfKMMl6ecpII2f/TSyX8aq1UXJt2wobNs+3S8aYrzP32cFQ5sgAdcQ
 pofg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXolOYJbKix9rW+Kif7LYp+Qyyx7aei2mnCs4youxEx6JPReim7gqO5a3IpDiwLOtgYATutIe0=@lists.denx.de
X-Gm-Message-State: AOJu0YxHlz+6VLU8O92YrGNRhHq8w1NvrrZdV3A8DeXLtTvT1AcZvjsL
 PCP2lCDs+nZm1MuccG+YECUZw/YgM3gXjuDN27nnrIQdG/gsVk562BCa7Gf29JI3H8g=
X-Gm-Gg: ASbGncuA7bESKVM8YjyDWOQEX/xBffvhCUrrRYD+hN8n+gvxNF21cCbKofQx3uBkv+M
 TjSLEAGEZVK/feOsVzbVG4he5jyq5LhVnYbWaJWkqYkOgMWzyNAosKQSIG9z26Dqm4dGpiy0J4n
 j+DXa9380siHQQKI4a7ppcZ4PC82xv1HXoRRxo5k7shTr72KvN8VbRfqwHeQ36a4kACkT7bDk43
 ikpgFiIQ+CRsYFlicoo35ocQTew/D1T1U5B+CjX2mDVUFgvCiWVtqMu6NY9O3RhuwxcQME838ll
 aj6yLW5NTU9MRdF6pKruhtcUNDKwkE2rNLJibeWUOCevcRs9Gi1Ayh2ZWZML82U=
X-Google-Smtp-Source: AGHT+IFXDa/q48FJSIHA5yERgLAoPtTVvRmYG0B3BS8bKsjXSAU5W/hhMexFEfHnsc+NdjB+yiHmiQ==
X-Received: by 2002:a5d:64eb:0:b0:3a3:6e85:a523 with SMTP id
 ffacd0b85a97d-3a36e85a8e2mr15331097f8f.42.1747930883847; 
 Thu, 22 May 2025 09:21:23 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:c340:2dcf:7e37:1be8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca888afsm24036224f8f.64.2025.05.22.09.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 09:21:23 -0700 (PDT)
Date: Thu, 22 May 2025 18:21:19 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH] qcom_defconfig: Enable AUTOBOOT_KEYED support
Message-ID: <aC9O9rUSv0iPVSbQ@linaro.org>
References: <20250508103238.230608-1-sumit.garg@kernel.org>
 <fe44fd2a-f16e-4f84-affa-3f9fbbbbdc9b@linaro.org>
 <aB4XFmFxBj30x5U6@linaro.org> <aCGc5giJlI9Wqxwl@sumit-X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCGc5giJlI9Wqxwl@sumit-X1>
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

On Mon, May 12, 2025 at 12:31:58PM +0530, Sumit Garg wrote:
> On Fri, May 09, 2025 at 04:54:43PM +0200, Stephan Gerhold wrote:
> > On Fri, May 09, 2025 at 12:45:20PM +0200, Casey Connolly wrote:
> > > On 5/8/25 12:32, Sumit Garg wrote:
> > > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > 
> > > > When debug serial port isn't connected, it is at least reported on RB1
> > > > that autoboot gets interrupted. It is probably due to random characters
> > > > on the UART RX line when disconnected. Lets try to fix this inconsistent
> > > > behaviour via enabling AUTOBOOT_KEYED such that the autoboot gets
> > > > interrupted only when the <SPACE> key gets pressed.
> > > 
> > > Honestly I'd much rather fix the bug in the UART driver, maybe it's broken
> > > pinctrl?
> > > 
> > > The older UART driver (for msm8916) had a similar but that Stephen was able
> > > to fix with better configuration.
> > > 
> > > Anyhow, this is a sensible enough workaround if nobody wants to look into
> > > GENI...
> > > 
> > 
> > Well, the main fix I did for that isn't related to the UART driver at
> > all, it's simply adding bias-pull-up for the RX pin so that it isn't
> > left floating when UART is not connected.
> > 
> > For RB1, qcm2290.dtsi &qup_uart4_default currently has bias-disable for
> > both RX and TX pins. So please try applying bias-pull-up + bootph-all
> > for the GPIO that belongs to RX.
> > 
> > For details, please see the following patch series for MSM8916:
> > https://lore.kernel.org/linux-arm-msm/20250422-msm8916-console-pinctrl-v2-0-f345b7a53c91@linaro.org/T/
> 
> Thanks for this reference but unfortunately this doesn't fix the issue
> on RB1. I have tried the diff below [1]. It seems most likely due the
> chainloading via ABL on RB1 as compared to U-Boot running as primary
> bootloader on db410c. The RX line seems to be floating even before the
> U-Boot starts which is causing the autoboot to stop. So for the
> chainloading configuration, we need to enable AUTOBOOT_KEYED. I think
> it should be the default sane configuration on Qcom platforms rather
> than allowing autoboot stopped via any random character on RX line.
> 

Can try again with the following diff added in addition to the
bias-pull-up changes from below? Pretty sure this is needed to apply the
pinctrl before the UART driver is initialized in the pre-reloc stage.

We're resetting the UART controller during initialization, so I don't
think whatever happens before U-Boot should make any difference.

Thanks,
Stephan

diff --git a/drivers/pinctrl/qcom/pinctrl-qcm2290.c b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
index 84f76b63b93..dcd499d99ae 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcm2290.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcm2290.c
@@ -67,4 +67,5 @@ U_BOOT_DRIVER(pinctrl_qcm2290) = {
 	.of_match = msm_pinctrl_ids,
 	.ops = &msm_pinctrl_ops,
 	.bind = msm_pinctrl_bind,
+	.flags = DM_FLAG_PRE_RELOC,
 };

> [1]
> 
> diff --git a/dts/upstream/src/arm64/qcom/qcm2290.dtsi b/dts/upstream/src/arm64/qcom/qcm2290.dtsi
> index f0746123e59..9392bd6f3e0 100644
> --- a/dts/upstream/src/arm64/qcom/qcm2290.dtsi
> +++ b/dts/upstream/src/arm64/qcom/qcm2290.dtsi
> @@ -551,10 +551,28 @@
>                         };
> 
>                         qup_uart4_default: qup-uart4-default-state {
> +                               tx-pins {
> +                                       pins = "gpio12";
> +                                       function = "qup4";
> +                                       drive-strength = <16>;
> +                                       bias-disable;
> +                                       bootph-all;
> +                               };
> +
> +                               rx-pins {
> +                                       pins = "gpio13";
> +                                       function = "qup4";
> +                                       drive-strength = <16>;
> +                                       bias-pull-up;
> +                                       bootph-all;
> +                               };
> +                       };
> +
> +                       qup_uart4_sleep: qup-uart4-sleep-state {
>                                 pins = "gpio12", "gpio13";
> -                               function = "qup4";
> +                               function = "gpio";
>                                 drive-strength = <2>;
> -                               bias-disable;
> +                               bias-pull-down;
>                         };
> 
>                         sdc1_state_on: sdc1-on-state {
> @@ -1293,7 +1311,8 @@
>                                 clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
>                                 clock-names = "se";
>                                 pinctrl-0 = <&qup_uart4_default>;
> -                               pinctrl-names = "default";
> +                               pinctrl-1 = <&qup_uart4_sleep>;
> +                               pinctrl-names = "default", "sleep";
>                                 interconnects = <&qup_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
>                                                  &qup_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
>                                                 <&bimc MASTER_APPSS_PROC RPM_ALWAYS_TAG
> 
