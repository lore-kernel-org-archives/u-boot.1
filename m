Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34554606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M34nPSO4;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R3gxkpkg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E747A816E0;
	Wed, 28 Oct 2026 14:49:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qIAHLBpO-JMY; Wed, 28 Oct 2026 14:49:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 061E581109
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198888;
	b=OSqeFMTnJZT81KFwRUSsli14/MzbBRpiiUDvx6tK8XHMQubL6IeZvPsrUNVierck2Fv7
	 DM1cpIDQgt5bxQtKPq4jrAdVFvcHIkl8ODS97qC9Gkj16mjhTffpemh4cN6lHJYhlM+eH
	 EOMfAr/f1tQQFBFyba7FSZt4Bt3QtpzjpxQPL4d3FDvyR+CGwy5wk7ES+QHN2bfphcS2U
	 DJUcvnKZl4Xtf4nevk7/A+fp0UD5hcG1l6TRp9LPMRY6uBgBOMNE2Ed03gpz7TZqanEcL
	 AMEgAE8L08tuVTTcDVDRFx8v4TAHuMpz+o5QRQCxlhTFpZUT8ad+f22YInOnGy+nc0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0OzRw87hNpZ4dBe7E3aKgg3xp/eszQe/2MIghDZX5sA=;
	b=PzwntNtzm5xy7lY+3l659ivu++oKolGWzW9G0x2QDxD71X5tqYcRY2oxPEExdy1BV5O7
	 A0yWqEHK6+UUPfMIZ1wnSOasWCWLTd3bpMSq7grQWunZkGCfUS7a21xsveLmeYw5qOJLi
	 /6f06nXSbvWRJPE1pS1KKEn00CR/Q2VVAFPZ0ZE4BHE0JkTJOLxt2jUW6c5yaLFC4FtxC
	 52mP6sN1b6a8Gwrfv3adCWzr7bEMCmOYUzrArRygdmnfOWuU0Z+sIEj/BI4kb6Z52IZSA
	 /WZKZlRXBFXArmOYAqYLFCu8Vt4vxL20SSD2ZbowgdmrpQW/hmAmFf2Tbg/i+Ts19qQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R3gxkpkg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198888;
	bh=0OzRw87hNpZ4dBe7E3aKgg3xp/eszQe/2MIghDZX5sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M34nPSO4/I3/IesirBdl20A+y73VQLzibDjRHdFXMlsgTlcJ4mAeLRH5h2caINvJm
	 S58VynA87a5jOP8Jn1wOBRMjbwcxMsVuxH1IugZwecnJf8HJdpz096t91X/0xvNfPc
	 lodtHE1fkFfN5OIojdlimDtg1JoGwdgFMtdO3nD8+kfgzcfb3gr3PJ40O+qAc5ZdNV
	 3ehUZzvndsFlELEwGPIhgyjM7/7HRVgwt6/8D4IOeszy9CbjnUdfJnZm69GSXgXc6t
	 XE4jUEPS8xBTbcuNRaRhnrJnOh12DmKIi3s9VU7vqChxwYyQtAmJvlneRYiC9oEAFV
	 tCs0Rt/RC8AmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 061E581109;
	Wed, 28 Oct 2026 14:48:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C757529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 589B380D0B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rf7AYVbH3sAJ for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C909880CCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196973;
 b=UDMg1v44VnHrnS031Hx781nsKAAbn6aIjl0iDBcdYN0cgoWb+PL5ZlRuKuka3REsWlEu
 jl1pRVAxMVH98jJrBCdxRpjZsgJgJayehtqlilwPLu+7lQk2Oq+2yZAzYW2PjMeG6c0Z+
 hiGqLbyzoKtNXAGT1zSn1JcgH9M7JjzXzUnf5NMCwWYc8BYtEQvDhj0OlMXaDgpjaP0rN
 KyCMQR/tm/lR0S+RJLTv+vmYDbxgoU/43K4iP+vg7bLmh7bG9La6WtKElJgA90oayYIOH
 IaG6nGjslQ9ZuC9HUN0LwATgbQ9Wik14/Wbc+q742FIhMBI/4GDxJZumevWFitXGiWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196973;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=0OzRw87hNpZ4dBe7E3aKgg3xp/eszQe/2MIghDZX5sA=;
 b=H7h2YMxNOayHvghWEscwUCrbuKIXuWoeVWXDU8HZDYdcLzqUbMRm4QyagMQUrRrqQob9
 JmERjhPJvWcvUJWwj/3Oisg7UY4Fxyf2ogPIFJ0yz7ttcd01S6samSK8iWm08byh56wHz
 3CQ//DVEIa/WkmjUuhiw18kdcuJfRVb2HxINazufgb6BApC+lMQ8MIdIZIvJK/vkt7f+y
 xEjiFL34vOXWpz2wLzrmp3scPhY4pBydqVW9hFdLJ586+y4qtgsDivqDRMFKv0KSrPeGZ
 epXtWYJkOeRChltM1h9QYWUzeAV/7O2ummjjEl5jjcXq531B7pJu1eu4HmAGmPP36zQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=R3gxkpkg; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=R3gxkpkg
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C909880CCA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:12 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6acbdf8e70dso192808a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196971; x=1793801771;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0OzRw87hNpZ4dBe7E3aKgg3xp/eszQe/2MIghDZX5sA=;
 b=R3gxkpkgIi7QNuVu6W5jnwnriDaFMkin7tvCOQ//+B2NGSKBplDKSowdDJhhX+AMpa
 pLK2ZZF5zobf9FAynaMmXASdnsfxi+3qZUX32FUbnb+6DcV2UbjjqsqL15pE+afTqokG
 xjq6rRS4kJqZUv1yYoFMuyeZlZkpCxiYbZB6PXP/0OSYgVNnKBQfTMawQJxhkq4X5ykc
 sgXCZ089aYU9pziJwMYXCtcrLuL4f4ZkGr5EjcT5h39Tf1pQUz6whXHqPJX/FNP7ayHc
 ywGSi0GPANByiPJAon0NCMDIuMj5CZpmzFNBMD/Zq+ueYFA3Nw/fdWjln+Xmp/IMhrha
 uiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196971; x=1793801771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0OzRw87hNpZ4dBe7E3aKgg3xp/eszQe/2MIghDZX5sA=;
 b=yEATAVkf09CZ4tXT7fTxSpTEPTcZm8otrs+VTmw4yAgqGi86cubsiFLpFH5/bFLRVY
 2oonB2U+IXnKmRakgyruwuH4IMorIJIaKg926OXMUv8ccfX6cNIzX6GaE2iDwvDnILLd
 HSPwwZUG3zpuyty0jti0aP8gUL/19uYXdZoPElDaGiO/7VfkyUox5sYJcVQxmgcU011V
 Z7hmQdLIiKnx7r9sftyNnMoyOXDhBRRWSE2+iPyBNp99z6HK9y/sq6L+OhnBzLU9eqx4
 q2eDwoEtWG5M5hc+Egvy1UsRCMezOXT3Ni5/gSLt0kM9hIReUCmeMZL0VSrHLTeKqo4B
 aU9g==
X-Gm-Message-State: AFq9FYJkZte6KsxYctKOfoH49+HTYHUb/j5IKlReNS8Fri0eJ2imAJiv
 4uUpawfSg8KRV80eveAYWr2csFk1JHcWHXThxRLk5pZw4SGZEJMlK15WbA3My0Sg4CfADvnmfmY
 ooO6e
X-Gm-Gg: AYBFou34ZbofbqGwMsfauOYTCzGtnmxf4EzwpKQnZa1tRZ+IahFqijxBvtkVOpypLJ6
 7sh4Lugt7SaM5C+0DMoehtR444QofjuwhT/GOThOY5ZbG0xm5Ew7HAxhdSigx7KdM1y0zcxdMHw
 IEJjuexOiGoNyJgsy42QZoPW9fEHaK+ekvPqXsiMQLu6TOzukHTZ0zdGGE9haiL4hMSQSylkxz0
 fSe+Nshry33OGc2olGJHWrWtLqare9L3kt+hlLOlToUkbi3LXMp5TzsR8Fz+HHKDOlisQrzjP35
 GNNgd8CdP86//q0Hose87vgFUjqzXuicA+Gf34rzeg+kpnY7RFmFUK2VxeZap7sEFW5qDtbrPZV
 0VXAM8IFNAHpnAMFFfGFJnAJ0g1PDdV2TOIGsQz6Pnjf/Ixgr59ZwXMvCYYYxXm0nWUMjJkCyWA
 VJH0kaC7e2XC1S2XH4zoJUrrh7UaMWyjC6oZoDB3aOgrIYwOnGDuWjVsNw8druSTdaamfRwLOax
 ZREiPJ8WTe9opSI85RllhAS2bY3cBmW7JBBW3e1K77Ul/IiISISZiMkm/8xkrq5fTvU/TCiboNw
 GPbh+OKnC2+OTiEXUbyEvCaBkLDkmYyQt2xSN0WZcaiejmED5e+Y/NPJi81yTjoXgFVlWMIy58D
 1rGZdxHlNPZM00y9LPWTZDfQNSenSPXs=
X-Received: by 2002:a17:907:180b:b0:c25:2ded:ad36 with SMTP id
 a640c23a62f3a-c49bda65ea2mr311118066b.0.1793196970396; 
 Wed, 28 Oct 2026 07:16:10 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650890sm629859266b.51.2026.10.28.07.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:16:09 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v10 07/30] usb: dwc3: core: remove the code U-Boot does not use
Date: Wed, 28 Oct 2026 15:15:31 +0100
Message-ID: <20261028141554.3073545-8-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After the resync core.c is the Linux v6.16 file. U-Boot does not use
most of it: the platform driver, PM, extcon, power supply, DRD mode
switching and the clock and property lookup.

Remove it. This commit only deletes code, so the next ones are easier
to review.

dwc3_clk_disable() stays. U-Boot gets the clocks in the glue driver, so
the function does nothing. It can go in a follow-up.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c | 1420 ---------------------------------------
 drivers/usb/dwc3/core.h |    3 -
 2 files changed, 1423 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8002c23a5a02..dee68745b94a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -45,68 +45,6 @@
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
-/**
- * dwc3_get_dr_mode - Validates and sets dr_mode
- * @dwc: pointer to our context structure
- */
-static int dwc3_get_dr_mode(struct dwc3 *dwc)
-{
-	enum usb_dr_mode mode;
-	struct device *dev = dwc->dev;
-	unsigned int hw_mode;
-
-	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
-		dwc->dr_mode = USB_DR_MODE_OTG;
-
-	mode = dwc->dr_mode;
-	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
-
-	switch (hw_mode) {
-	case DWC3_GHWPARAMS0_MODE_GADGET:
-		if (IS_ENABLED(CONFIG_USB_DWC3_HOST)) {
-			dev_err(dev,
-				"Controller does not support host mode.\n");
-			return -EINVAL;
-		}
-		mode = USB_DR_MODE_PERIPHERAL;
-		break;
-	case DWC3_GHWPARAMS0_MODE_HOST:
-		if (IS_ENABLED(CONFIG_USB_DWC3_GADGET)) {
-			dev_err(dev,
-				"Controller does not support device mode.\n");
-			return -EINVAL;
-		}
-		mode = USB_DR_MODE_HOST;
-		break;
-	default:
-		if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
-			mode = USB_DR_MODE_HOST;
-		else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
-			mode = USB_DR_MODE_PERIPHERAL;
-
-		/*
-		 * DWC_usb31 and DWC_usb3 v3.30a and higher do not support OTG
-		 * mode. If the controller supports DRD but the dr_mode is not
-		 * specified or set to OTG, then set the mode to peripheral.
-		 */
-		if (mode == USB_DR_MODE_OTG && !dwc->edev &&
-		    (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
-		     !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
-		    !DWC3_VER_IS_PRIOR(DWC3, 330A))
-			mode = USB_DR_MODE_PERIPHERAL;
-	}
-
-	if (mode != dwc->dr_mode) {
-		dev_warn(dev,
-			 "Configuration mismatch. dr_mode forced to %s\n",
-			 mode == USB_DR_MODE_HOST ? "host" : "gadget");
-
-		dwc->dr_mode = mode;
-	}
-
-	return 0;
-}
-
 void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 {
 	u32 reg;
@@ -158,146 +96,6 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
 	dwc->current_dr_role = mode;
 }
 
-static void __dwc3_set_mode(struct work_struct *work)
-{
-	struct dwc3 *dwc = work_to_dwc(work);
-	unsigned long flags;
-	int ret;
-	u32 reg;
-	u32 desired_dr_role;
-	int i;
-
-	mutex_lock(&dwc->mutex);
-	spin_lock_irqsave(&dwc->lock, flags);
-	desired_dr_role = dwc->desired_dr_role;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	pm_runtime_get_sync(dwc->dev);
-
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_OTG)
-		dwc3_otg_update(dwc, 0);
-
-	if (!desired_dr_role)
-		goto out;
-
-	if (desired_dr_role == dwc->current_dr_role)
-		goto out;
-
-	if (desired_dr_role == DWC3_GCTL_PRTCAP_OTG && dwc->edev)
-		goto out;
-
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_HOST:
-		dwc3_host_exit(dwc);
-		break;
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		dwc3_gadget_exit(dwc);
-		dwc3_event_buffers_cleanup(dwc);
-		break;
-	case DWC3_GCTL_PRTCAP_OTG:
-		dwc3_otg_exit(dwc);
-		spin_lock_irqsave(&dwc->lock, flags);
-		dwc->desired_otg_role = DWC3_OTG_ROLE_IDLE;
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		dwc3_otg_update(dwc, 1);
-		break;
-	default:
-		break;
-	}
-
-	/*
-	 * When current_dr_role is not set, there's no role switching.
-	 * Only perform GCTL.CoreSoftReset when there's DRD role switching.
-	 */
-	if (dwc->current_dr_role && ((DWC3_IP_IS(DWC3) ||
-			DWC3_VER_IS_PRIOR(DWC31, 190A)) &&
-			desired_dr_role != DWC3_GCTL_PRTCAP_OTG)) {
-		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-		reg |= DWC3_GCTL_CORESOFTRESET;
-		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-
-		/*
-		 * Wait for internal clocks to synchronized. DWC_usb31 and
-		 * DWC_usb32 may need at least 50ms (less for DWC_usb3). To
-		 * keep it consistent across different IPs, let's wait up to
-		 * 100ms before clearing GCTL.CORESOFTRESET.
-		 */
-		msleep(100);
-
-		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-		reg &= ~DWC3_GCTL_CORESOFTRESET;
-		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-	}
-
-	spin_lock_irqsave(&dwc->lock, flags);
-
-	dwc3_set_prtcap(dwc, desired_dr_role, false);
-
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	switch (desired_dr_role) {
-	case DWC3_GCTL_PRTCAP_HOST:
-		ret = dwc3_host_init(dwc);
-		if (ret) {
-			dev_err(dwc->dev, "failed to initialize host\n");
-		} else {
-			if (dwc->usb2_phy)
-				otg_set_vbus(dwc->usb2_phy->otg, true);
-
-			for (i = 0; i < dwc->num_usb2_ports; i++)
-				phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
-			for (i = 0; i < dwc->num_usb3_ports; i++)
-				phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
-
-			if (dwc->dis_split_quirk) {
-				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
-				reg |= DWC3_GUCTL3_SPLITDISABLE;
-				dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
-			}
-		}
-		break;
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		dwc3_core_soft_reset(dwc);
-
-		dwc3_event_buffers_setup(dwc);
-
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
-
-		ret = dwc3_gadget_init(dwc);
-		if (ret)
-			dev_err(dwc->dev, "failed to initialize peripheral\n");
-		break;
-	case DWC3_GCTL_PRTCAP_OTG:
-		dwc3_otg_init(dwc);
-		dwc3_otg_update(dwc, 0);
-		break;
-	default:
-		break;
-	}
-
-out:
-	pm_runtime_mark_last_busy(dwc->dev);
-	pm_runtime_put_autosuspend(dwc->dev);
-	mutex_unlock(&dwc->mutex);
-}
-
-void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
-{
-	unsigned long flags;
-
-	if (dwc->dr_mode != USB_DR_MODE_OTG)
-		return;
-
-	spin_lock_irqsave(&dwc->lock, flags);
-	dwc->desired_dr_role = mode;
-	spin_unlock_irqrestore(&dwc->lock, flags);
-
-	queue_work(system_freezable_wq, &dwc->drd_work);
-}
-
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type)
 {
 	struct dwc3		*dwc = dep->dwc;
@@ -928,43 +726,6 @@ static void dwc3_phy_power_off(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 }
 
-static int dwc3_clk_enable(struct dwc3 *dwc)
-{
-	int ret;
-
-	ret = clk_prepare_enable(dwc->bus_clk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(dwc->ref_clk);
-	if (ret)
-		goto disable_bus_clk;
-
-	ret = clk_prepare_enable(dwc->susp_clk);
-	if (ret)
-		goto disable_ref_clk;
-
-	ret = clk_prepare_enable(dwc->utmi_clk);
-	if (ret)
-		goto disable_susp_clk;
-
-	ret = clk_prepare_enable(dwc->pipe_clk);
-	if (ret)
-		goto disable_utmi_clk;
-
-	return 0;
-
-disable_utmi_clk:
-	clk_disable_unprepare(dwc->utmi_clk);
-disable_susp_clk:
-	clk_disable_unprepare(dwc->susp_clk);
-disable_ref_clk:
-	clk_disable_unprepare(dwc->ref_clk);
-disable_bus_clk:
-	clk_disable_unprepare(dwc->bus_clk);
-	return ret;
-}
-
 static void dwc3_clk_disable(struct dwc3 *dwc)
 {
 	clk_disable_unprepare(dwc->pipe_clk);
@@ -983,26 +744,6 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	reset_control_assert(dwc->reset);
 }
 
-static bool dwc3_core_is_valid(struct dwc3 *dwc)
-{
-	u32 reg;
-
-	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
-	dwc->ip = DWC3_GSNPS_ID(reg);
-
-	/* This should read as U3 followed by revision number */
-	if (DWC3_IP_IS(DWC3)) {
-		dwc->revision = reg;
-	} else if (DWC3_IP_IS(DWC31) || DWC3_IP_IS(DWC32)) {
-		dwc->revision = dwc3_readl(dwc->regs, DWC3_VER_NUMBER);
-		dwc->version_type = dwc3_readl(dwc->regs, DWC3_VER_TYPE);
-	} else {
-		return false;
-	}
-
-	return true;
-}
-
 static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 {
 	unsigned int power_opt;
@@ -1090,7 +831,6 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 }
 
-static int dwc3_core_get_phy(struct dwc3 *dwc);
 static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 
 /* set global incr burst type configuration registers */
@@ -1528,75 +1268,6 @@ err_exit_ulpi:
 	return ret;
 }
 
-static int dwc3_core_get_phy(struct dwc3 *dwc)
-{
-	struct device		*dev = dwc->dev;
-	struct device_node	*node = dev->of_node;
-	char phy_name[9];
-	int ret;
-	u8 i;
-
-	if (node) {
-		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
-		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
-	} else {
-		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
-		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
-	}
-
-	if (IS_ERR(dwc->usb2_phy)) {
-		ret = PTR_ERR(dwc->usb2_phy);
-		if (ret == -ENXIO || ret == -ENODEV)
-			dwc->usb2_phy = NULL;
-		else
-			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
-	}
-
-	if (IS_ERR(dwc->usb3_phy)) {
-		ret = PTR_ERR(dwc->usb3_phy);
-		if (ret == -ENXIO || ret == -ENODEV)
-			dwc->usb3_phy = NULL;
-		else
-			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
-	}
-
-	for (i = 0; i < dwc->num_usb2_ports; i++) {
-		if (dwc->num_usb2_ports == 1)
-			snprintf(phy_name, sizeof(phy_name), "usb2-phy");
-		else
-			snprintf(phy_name, sizeof(phy_name),  "usb2-%u", i);
-
-		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
-		if (IS_ERR(dwc->usb2_generic_phy[i])) {
-			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
-			if (ret == -ENOSYS || ret == -ENODEV)
-				dwc->usb2_generic_phy[i] = NULL;
-			else
-				return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
-							phy_name);
-		}
-	}
-
-	for (i = 0; i < dwc->num_usb3_ports; i++) {
-		if (dwc->num_usb3_ports == 1)
-			snprintf(phy_name, sizeof(phy_name), "usb3-phy");
-		else
-			snprintf(phy_name, sizeof(phy_name), "usb3-%u", i);
-
-		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
-		if (IS_ERR(dwc->usb3_generic_phy[i])) {
-			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
-			if (ret == -ENOSYS || ret == -ENODEV)
-				dwc->usb3_generic_phy[i] = NULL;
-			else
-				return dev_err_probe(dev, ret, "failed to lookup phy %s\n",
-							phy_name);
-		}
-	}
-
-	return 0;
-}
-
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
@@ -1665,208 +1336,6 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 }
 
-static void dwc3_get_software_properties(struct dwc3 *dwc)
-{
-	struct device *tmpdev;
-	u16 gsbuscfg0_reqinfo;
-	int ret;
-
-	dwc->gsbuscfg0_reqinfo = DWC3_GSBUSCFG0_REQINFO_UNSPECIFIED;
-
-	/*
-	 * Iterate over all parent nodes for finding swnode properties
-	 * and non-DT (non-ABI) properties.
-	 */
-	for (tmpdev = dwc->dev; tmpdev; tmpdev = tmpdev->parent) {
-		ret = device_property_read_u16(tmpdev,
-					       "snps,gsbuscfg0-reqinfo",
-					       &gsbuscfg0_reqinfo);
-		if (!ret)
-			dwc->gsbuscfg0_reqinfo = gsbuscfg0_reqinfo;
-	}
-}
-
-static void dwc3_get_properties(struct dwc3 *dwc)
-{
-	struct device		*dev = dwc->dev;
-	u8			lpm_nyet_threshold;
-	u8			tx_de_emphasis;
-	u8			hird_threshold;
-	u8			rx_thr_num_pkt = 0;
-	u8			rx_max_burst = 0;
-	u8			tx_thr_num_pkt = 0;
-	u8			tx_max_burst = 0;
-	u8			rx_thr_num_pkt_prd = 0;
-	u8			rx_max_burst_prd = 0;
-	u8			tx_thr_num_pkt_prd = 0;
-	u8			tx_max_burst_prd = 0;
-	u8			tx_fifo_resize_max_num;
-	u16			num_hc_interrupters;
-
-	/* default to highest possible threshold */
-	lpm_nyet_threshold = 0xf;
-
-	/* default to -3.5dB de-emphasis */
-	tx_de_emphasis = 1;
-
-	/*
-	 * default to assert utmi_sleep_n and use maximum allowed HIRD
-	 * threshold value of 0b1100
-	 */
-	hird_threshold = 12;
-
-	/*
-	 * default to a TXFIFO size large enough to fit 6 max packets.  This
-	 * allows for systems with larger bus latencies to have some headroom
-	 * for endpoints that have a large bMaxBurst value.
-	 */
-	tx_fifo_resize_max_num = 6;
-
-	/* default to a single XHCI interrupter */
-	num_hc_interrupters = 1;
-
-	dwc->maximum_speed = usb_get_maximum_speed(dev);
-	dwc->max_ssp_rate = usb_get_maximum_ssp_rate(dev);
-	dwc->dr_mode = usb_get_dr_mode(dev);
-	dwc->hsphy_mode = of_usb_get_phy_mode(dev->of_node);
-
-	dwc->sysdev_is_parent = device_property_read_bool(dev,
-				"linux,sysdev_is_parent");
-	if (dwc->sysdev_is_parent)
-		dwc->sysdev = dwc->dev->parent;
-	else
-		dwc->sysdev = dwc->dev;
-
-	dwc->sys_wakeup = device_may_wakeup(dwc->sysdev);
-
-	dwc->has_lpm_erratum = device_property_read_bool(dev,
-				"snps,has-lpm-erratum");
-	device_property_read_u8(dev, "snps,lpm-nyet-threshold",
-				&lpm_nyet_threshold);
-	dwc->is_utmi_l1_suspend = device_property_read_bool(dev,
-				"snps,is-utmi-l1-suspend");
-	device_property_read_u8(dev, "snps,hird-threshold",
-				&hird_threshold);
-	dwc->dis_start_transfer_quirk = device_property_read_bool(dev,
-				"snps,dis-start-transfer-quirk");
-	dwc->usb3_lpm_capable = device_property_read_bool(dev,
-				"snps,usb3_lpm_capable");
-	dwc->usb2_lpm_disable = device_property_read_bool(dev,
-				"snps,usb2-lpm-disable");
-	dwc->usb2_gadget_lpm_disable = device_property_read_bool(dev,
-				"snps,usb2-gadget-lpm-disable");
-	device_property_read_u8(dev, "snps,rx-thr-num-pkt",
-				&rx_thr_num_pkt);
-	device_property_read_u8(dev, "snps,rx-max-burst",
-				&rx_max_burst);
-	device_property_read_u8(dev, "snps,tx-thr-num-pkt",
-				&tx_thr_num_pkt);
-	device_property_read_u8(dev, "snps,tx-max-burst",
-				&tx_max_burst);
-	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
-				&rx_thr_num_pkt_prd);
-	device_property_read_u8(dev, "snps,rx-max-burst-prd",
-				&rx_max_burst_prd);
-	device_property_read_u8(dev, "snps,tx-thr-num-pkt-prd",
-				&tx_thr_num_pkt_prd);
-	device_property_read_u8(dev, "snps,tx-max-burst-prd",
-				&tx_max_burst_prd);
-	device_property_read_u16(dev, "num-hc-interrupters",
-				 &num_hc_interrupters);
-	/* DWC3 core allowed to have a max of 8 interrupters */
-	if (num_hc_interrupters > 8)
-		num_hc_interrupters = 8;
-
-	dwc->do_fifo_resize = device_property_read_bool(dev,
-							"tx-fifo-resize");
-	if (dwc->do_fifo_resize)
-		device_property_read_u8(dev, "tx-fifo-max-num",
-					&tx_fifo_resize_max_num);
-
-	dwc->disable_scramble_quirk = device_property_read_bool(dev,
-				"snps,disable_scramble_quirk");
-	dwc->u2exit_lfps_quirk = device_property_read_bool(dev,
-				"snps,u2exit_lfps_quirk");
-	dwc->u2ss_inp3_quirk = device_property_read_bool(dev,
-				"snps,u2ss_inp3_quirk");
-	dwc->req_p1p2p3_quirk = device_property_read_bool(dev,
-				"snps,req_p1p2p3_quirk");
-	dwc->del_p1p2p3_quirk = device_property_read_bool(dev,
-				"snps,del_p1p2p3_quirk");
-	dwc->del_phy_power_chg_quirk = device_property_read_bool(dev,
-				"snps,del_phy_power_chg_quirk");
-	dwc->lfps_filter_quirk = device_property_read_bool(dev,
-				"snps,lfps_filter_quirk");
-	dwc->rx_detect_poll_quirk = device_property_read_bool(dev,
-				"snps,rx_detect_poll_quirk");
-	dwc->dis_u3_susphy_quirk = device_property_read_bool(dev,
-				"snps,dis_u3_susphy_quirk");
-	dwc->dis_u2_susphy_quirk = device_property_read_bool(dev,
-				"snps,dis_u2_susphy_quirk");
-	dwc->dis_enblslpm_quirk = device_property_read_bool(dev,
-				"snps,dis_enblslpm_quirk");
-	dwc->dis_u1_entry_quirk = device_property_read_bool(dev,
-				"snps,dis-u1-entry-quirk");
-	dwc->dis_u2_entry_quirk = device_property_read_bool(dev,
-				"snps,dis-u2-entry-quirk");
-	dwc->dis_rxdet_inp3_quirk = device_property_read_bool(dev,
-				"snps,dis_rxdet_inp3_quirk");
-	dwc->dis_u2_freeclk_exists_quirk = device_property_read_bool(dev,
-				"snps,dis-u2-freeclk-exists-quirk");
-	dwc->dis_del_phy_power_chg_quirk = device_property_read_bool(dev,
-				"snps,dis-del-phy-power-chg-quirk");
-	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
-				"snps,dis-tx-ipgap-linecheck-quirk");
-	dwc->resume_hs_terminations = device_property_read_bool(dev,
-				"snps,resume-hs-terminations");
-	dwc->ulpi_ext_vbus_drv = device_property_read_bool(dev,
-				"snps,ulpi-ext-vbus-drv");
-	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
-				"snps,parkmode-disable-ss-quirk");
-	dwc->parkmode_disable_hs_quirk = device_property_read_bool(dev,
-				"snps,parkmode-disable-hs-quirk");
-	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
-				"snps,gfladj-refclk-lpm-sel-quirk");
-
-	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
-				"snps,tx_de_emphasis_quirk");
-	device_property_read_u8(dev, "snps,tx_de_emphasis",
-				&tx_de_emphasis);
-	device_property_read_string(dev, "snps,hsphy_interface",
-				    &dwc->hsphy_interface);
-	device_property_read_u32(dev, "snps,quirk-frame-length-adjustment",
-				 &dwc->fladj);
-	device_property_read_u32(dev, "snps,ref-clock-period-ns",
-				 &dwc->ref_clk_per);
-
-	dwc->dis_metastability_quirk = device_property_read_bool(dev,
-				"snps,dis_metastability_quirk");
-
-	dwc->dis_split_quirk = device_property_read_bool(dev,
-				"snps,dis-split-quirk");
-
-	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
-	dwc->tx_de_emphasis = tx_de_emphasis;
-
-	dwc->hird_threshold = hird_threshold;
-
-	dwc->rx_thr_num_pkt = rx_thr_num_pkt;
-	dwc->rx_max_burst = rx_max_burst;
-
-	dwc->tx_thr_num_pkt = tx_thr_num_pkt;
-	dwc->tx_max_burst = tx_max_burst;
-
-	dwc->rx_thr_num_pkt_prd = rx_thr_num_pkt_prd;
-	dwc->rx_max_burst_prd = rx_max_burst_prd;
-
-	dwc->tx_thr_num_pkt_prd = tx_thr_num_pkt_prd;
-	dwc->tx_max_burst_prd = tx_max_burst_prd;
-
-	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
-
-	dwc->num_hc_interrupters = num_hc_interrupters;
-}
-
 /* check whether the core supports IMOD */
 bool dwc3_has_imod(struct dwc3 *dwc)
 {
@@ -1875,227 +1344,6 @@ bool dwc3_has_imod(struct dwc3 *dwc)
 		DWC3_IP_IS(DWC32);
 }
 
-static void dwc3_check_params(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	unsigned int hwparam_gen =
-		DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3);
-
-	/*
-	 * Enable IMOD for all supporting controllers.
-	 *
-	 * Particularly, DWC_usb3 v3.00a must enable this feature for
-	 * the following reason:
-	 *
-	 * Workaround for STAR 9000961433 which affects only version
-	 * 3.00a of the DWC_usb3 core. This prevents the controller
-	 * interrupt from being masked while handling events. IMOD
-	 * allows us to work around this issue. Enable it for the
-	 * affected version.
-	 */
-	if (dwc3_has_imod((dwc)))
-		dwc->imod_interval = 1;
-
-	/* Check the maximum_speed parameter */
-	switch (dwc->maximum_speed) {
-	case USB_SPEED_FULL:
-	case USB_SPEED_HIGH:
-		break;
-	case USB_SPEED_SUPER:
-		if (hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_DIS)
-			dev_warn(dev, "UDC doesn't support Gen 1\n");
-		break;
-	case USB_SPEED_SUPER_PLUS:
-		if ((DWC3_IP_IS(DWC32) &&
-		     hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_DIS) ||
-		    (!DWC3_IP_IS(DWC32) &&
-		     hwparam_gen != DWC3_GHWPARAMS3_SSPHY_IFC_GEN2))
-			dev_warn(dev, "UDC doesn't support SSP\n");
-		break;
-	default:
-		dev_err(dev, "invalid maximum_speed parameter %d\n",
-			dwc->maximum_speed);
-		fallthrough;
-	case USB_SPEED_UNKNOWN:
-		switch (hwparam_gen) {
-		case DWC3_GHWPARAMS3_SSPHY_IFC_GEN2:
-			dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
-			break;
-		case DWC3_GHWPARAMS3_SSPHY_IFC_GEN1:
-			if (DWC3_IP_IS(DWC32))
-				dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
-			else
-				dwc->maximum_speed = USB_SPEED_SUPER;
-			break;
-		case DWC3_GHWPARAMS3_SSPHY_IFC_DIS:
-			dwc->maximum_speed = USB_SPEED_HIGH;
-			break;
-		default:
-			dwc->maximum_speed = USB_SPEED_SUPER;
-			break;
-		}
-		break;
-	}
-
-	/*
-	 * Currently the controller does not have visibility into the HW
-	 * parameter to determine the maximum number of lanes the HW supports.
-	 * If the number of lanes is not specified in the device property, then
-	 * set the default to support dual-lane for DWC_usb32 and single-lane
-	 * for DWC_usb31 for super-speed-plus.
-	 */
-	if (dwc->maximum_speed == USB_SPEED_SUPER_PLUS) {
-		switch (dwc->max_ssp_rate) {
-		case USB_SSP_GEN_2x1:
-			if (hwparam_gen == DWC3_GHWPARAMS3_SSPHY_IFC_GEN1)
-				dev_warn(dev, "UDC only supports Gen 1\n");
-			break;
-		case USB_SSP_GEN_1x2:
-		case USB_SSP_GEN_2x2:
-			if (DWC3_IP_IS(DWC31))
-				dev_warn(dev, "UDC only supports single lane\n");
-			break;
-		case USB_SSP_GEN_UNKNOWN:
-		default:
-			switch (hwparam_gen) {
-			case DWC3_GHWPARAMS3_SSPHY_IFC_GEN2:
-				if (DWC3_IP_IS(DWC32))
-					dwc->max_ssp_rate = USB_SSP_GEN_2x2;
-				else
-					dwc->max_ssp_rate = USB_SSP_GEN_2x1;
-				break;
-			case DWC3_GHWPARAMS3_SSPHY_IFC_GEN1:
-				if (DWC3_IP_IS(DWC32))
-					dwc->max_ssp_rate = USB_SSP_GEN_1x2;
-				break;
-			}
-			break;
-		}
-	}
-}
-
-static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	struct device_node *np_phy;
-	struct extcon_dev *edev = NULL;
-	const char *name;
-
-	if (device_property_present(dev, "extcon"))
-		return extcon_get_edev_by_phandle(dev, 0);
-
-	/*
-	 * Device tree platforms should get extcon via phandle.
-	 * On ACPI platforms, we get the name from a device property.
-	 * This device property is for kernel internal use only and
-	 * is expected to be set by the glue code.
-	 */
-	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
-		return extcon_get_extcon_dev(name);
-
-	/*
-	 * Check explicitly if "usb-role-switch" is used since
-	 * extcon_find_edev_by_node() can not be used to check the absence of
-	 * an extcon device. In the absence of an device it will always return
-	 * EPROBE_DEFER.
-	 */
-	if (IS_ENABLED(CONFIG_USB_ROLE_SWITCH) &&
-	    device_property_read_bool(dev, "usb-role-switch"))
-		return NULL;
-
-	/*
-	 * Try to get an extcon device from the USB PHY controller's "port"
-	 * node. Check if it has the "port" node first, to avoid printing the
-	 * error message from underlying code, as it's a valid case: extcon
-	 * device (and "port" node) may be missing in case of "usb-role-switch"
-	 * or OTG mode.
-	 */
-	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
-	if (of_graph_is_present(np_phy)) {
-		struct device_node *np_conn;
-
-		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
-		if (np_conn)
-			edev = extcon_find_edev_by_node(np_conn);
-		of_node_put(np_conn);
-	}
-	of_node_put(np_phy);
-
-	return edev;
-}
-
-static int dwc3_get_clocks(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-
-	if (!dev->of_node)
-		return 0;
-
-	/*
-	 * Clocks are optional, but new DT platforms should support all clocks
-	 * as required by the DT-binding.
-	 * Some devices have different clock names in legacy device trees,
-	 * check for them to retain backwards compatibility.
-	 */
-	dwc->bus_clk = devm_clk_get_optional(dev, "bus_early");
-	if (IS_ERR(dwc->bus_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-				"could not get bus clock\n");
-	}
-
-	if (dwc->bus_clk == NULL) {
-		dwc->bus_clk = devm_clk_get_optional(dev, "bus_clk");
-		if (IS_ERR(dwc->bus_clk)) {
-			return dev_err_probe(dev, PTR_ERR(dwc->bus_clk),
-					"could not get bus clock\n");
-		}
-	}
-
-	dwc->ref_clk = devm_clk_get_optional(dev, "ref");
-	if (IS_ERR(dwc->ref_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-				"could not get ref clock\n");
-	}
-
-	if (dwc->ref_clk == NULL) {
-		dwc->ref_clk = devm_clk_get_optional(dev, "ref_clk");
-		if (IS_ERR(dwc->ref_clk)) {
-			return dev_err_probe(dev, PTR_ERR(dwc->ref_clk),
-					"could not get ref clock\n");
-		}
-	}
-
-	dwc->susp_clk = devm_clk_get_optional(dev, "suspend");
-	if (IS_ERR(dwc->susp_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-				"could not get suspend clock\n");
-	}
-
-	if (dwc->susp_clk == NULL) {
-		dwc->susp_clk = devm_clk_get_optional(dev, "suspend_clk");
-		if (IS_ERR(dwc->susp_clk)) {
-			return dev_err_probe(dev, PTR_ERR(dwc->susp_clk),
-					"could not get suspend clock\n");
-		}
-	}
-
-	/* specific to Rockchip RK3588 */
-	dwc->utmi_clk = devm_clk_get_optional(dev, "utmi");
-	if (IS_ERR(dwc->utmi_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->utmi_clk),
-				"could not get utmi clock\n");
-	}
-
-	/* specific to Rockchip RK3588 */
-	dwc->pipe_clk = devm_clk_get_optional(dev, "pipe");
-	if (IS_ERR(dwc->pipe_clk)) {
-		return dev_err_probe(dev, PTR_ERR(dwc->pipe_clk),
-				"could not get pipe clock\n");
-	}
-
-	return 0;
-}
-
 static int dwc3_get_num_ports(struct dwc3 *dwc)
 {
 	void __iomem *base;
@@ -2144,671 +1392,3 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
 
 	return 0;
 }
-
-static struct power_supply *dwc3_get_usb_power_supply(struct dwc3 *dwc)
-{
-	struct power_supply *usb_psy;
-	const char *usb_psy_name;
-	int ret;
-
-	ret = device_property_read_string(dwc->dev, "usb-psy-name", &usb_psy_name);
-	if (ret < 0)
-		return NULL;
-
-	usb_psy = power_supply_get_by_name(usb_psy_name);
-	if (!usb_psy)
-		return ERR_PTR(-EPROBE_DEFER);
-
-	return usb_psy;
-}
-
-int dwc3_core_probe(const struct dwc3_probe_data *data)
-{
-	struct dwc3		*dwc = data->dwc;
-	struct device		*dev = dwc->dev;
-	struct resource		dwc_res;
-	unsigned int		hw_mode;
-	void __iomem		*regs;
-	struct resource		*res = data->res;
-	int			ret;
-
-	dwc->xhci_resources[0].start = res->start;
-	dwc->xhci_resources[0].end = dwc->xhci_resources[0].start +
-					DWC3_XHCI_REGS_END;
-	dwc->xhci_resources[0].flags = res->flags;
-	dwc->xhci_resources[0].name = res->name;
-
-	/*
-	 * Request memory region but exclude xHCI regs,
-	 * since it will be requested by the xhci-plat driver.
-	 */
-	dwc_res = *res;
-	dwc_res.start += DWC3_GLOBALS_REGS_START;
-
-	if (dev->of_node) {
-		struct device_node *parent = of_get_parent(dev->of_node);
-
-		if (of_device_is_compatible(parent, "realtek,rtd-dwc3")) {
-			dwc_res.start -= DWC3_GLOBALS_REGS_START;
-			dwc_res.start += DWC3_RTK_RTD_GLOBALS_REGS_START;
-		}
-
-		of_node_put(parent);
-	}
-
-	regs = devm_ioremap_resource(dev, &dwc_res);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
-
-	dwc->regs	= regs;
-	dwc->regs_size	= resource_size(&dwc_res);
-
-	dwc3_get_properties(dwc);
-
-	dwc3_get_software_properties(dwc);
-
-	dwc->usb_psy = dwc3_get_usb_power_supply(dwc);
-	if (IS_ERR(dwc->usb_psy))
-		return dev_err_probe(dev, PTR_ERR(dwc->usb_psy), "couldn't get usb power supply\n");
-
-	if (!data->ignore_clocks_and_resets) {
-		dwc->reset = devm_reset_control_array_get_optional_shared(dev);
-		if (IS_ERR(dwc->reset)) {
-			ret = PTR_ERR(dwc->reset);
-			goto err_put_psy;
-		}
-
-		ret = dwc3_get_clocks(dwc);
-		if (ret)
-			goto err_put_psy;
-	}
-
-	ret = reset_control_deassert(dwc->reset);
-	if (ret)
-		goto err_put_psy;
-
-	ret = dwc3_clk_enable(dwc);
-	if (ret)
-		goto err_assert_reset;
-
-	if (!dwc3_core_is_valid(dwc)) {
-		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
-		ret = -ENODEV;
-		goto err_disable_clks;
-	}
-
-	dev_set_drvdata(dev, dwc);
-	dwc3_cache_hwparams(dwc);
-
-	if (!dwc->sysdev_is_parent &&
-	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
-		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
-		if (ret)
-			goto err_disable_clks;
-	}
-
-	/*
-	 * Currently only DWC3 controllers that are host-only capable
-	 * can have more than one port.
-	 */
-	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
-	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
-		ret = dwc3_get_num_ports(dwc);
-		if (ret)
-			goto err_disable_clks;
-	} else {
-		dwc->num_usb2_ports = 1;
-		dwc->num_usb3_ports = 1;
-	}
-
-	spin_lock_init(&dwc->lock);
-	mutex_init(&dwc->mutex);
-
-	pm_runtime_get_noresume(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_autosuspend_delay(dev, DWC3_DEFAULT_AUTOSUSPEND_DELAY);
-	pm_runtime_enable(dev);
-
-	pm_runtime_forbid(dev);
-
-	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
-	if (ret) {
-		dev_err(dwc->dev, "failed to allocate event buffers\n");
-		ret = -ENOMEM;
-		goto err_allow_rpm;
-	}
-
-	dwc->edev = dwc3_get_extcon(dwc);
-	if (IS_ERR(dwc->edev)) {
-		ret = dev_err_probe(dwc->dev, PTR_ERR(dwc->edev), "failed to get extcon\n");
-		goto err_free_event_buffers;
-	}
-
-	ret = dwc3_get_dr_mode(dwc);
-	if (ret)
-		goto err_free_event_buffers;
-
-	ret = dwc3_core_init(dwc);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to initialize core\n");
-		goto err_free_event_buffers;
-	}
-
-	dwc3_check_params(dwc);
-	dwc3_debugfs_init(dwc);
-
-	ret = dwc3_core_init_mode(dwc);
-	if (ret)
-		goto err_exit_debugfs;
-
-	pm_runtime_put(dev);
-
-	dma_set_max_seg_size(dev, UINT_MAX);
-
-	return 0;
-
-err_exit_debugfs:
-	dwc3_debugfs_exit(dwc);
-	dwc3_event_buffers_cleanup(dwc);
-	dwc3_phy_power_off(dwc);
-	dwc3_phy_exit(dwc);
-	dwc3_ulpi_exit(dwc);
-err_free_event_buffers:
-	dwc3_free_event_buffers(dwc);
-err_allow_rpm:
-	pm_runtime_allow(dev);
-	pm_runtime_disable(dev);
-	pm_runtime_dont_use_autosuspend(dev);
-	pm_runtime_set_suspended(dev);
-	pm_runtime_put_noidle(dev);
-err_disable_clks:
-	dwc3_clk_disable(dwc);
-err_assert_reset:
-	reset_control_assert(dwc->reset);
-err_put_psy:
-	if (dwc->usb_psy)
-		power_supply_put(dwc->usb_psy);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dwc3_core_probe);
-
-static int dwc3_probe(struct platform_device *pdev)
-{
-	struct dwc3_probe_data probe_data = {};
-	struct resource *res;
-	struct dwc3 *dwc;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "missing memory resource\n");
-		return -ENODEV;
-	}
-
-	dwc = devm_kzalloc(&pdev->dev, sizeof(*dwc), GFP_KERNEL);
-	if (!dwc)
-		return -ENOMEM;
-
-	dwc->dev = &pdev->dev;
-
-	probe_data.dwc = dwc;
-	probe_data.res = res;
-
-	return dwc3_core_probe(&probe_data);
-}
-
-void dwc3_core_remove(struct dwc3 *dwc)
-{
-	pm_runtime_get_sync(dwc->dev);
-
-	dwc3_core_exit_mode(dwc);
-	dwc3_debugfs_exit(dwc);
-
-	dwc3_core_exit(dwc);
-	dwc3_ulpi_exit(dwc);
-
-	pm_runtime_allow(dwc->dev);
-	pm_runtime_disable(dwc->dev);
-	pm_runtime_dont_use_autosuspend(dwc->dev);
-	pm_runtime_put_noidle(dwc->dev);
-	/*
-	 * HACK: Clear the driver data, which is currently accessed by parent
-	 * glue drivers, before allowing the parent to suspend.
-	 */
-	dev_set_drvdata(dwc->dev, NULL);
-	pm_runtime_set_suspended(dwc->dev);
-
-	dwc3_free_event_buffers(dwc);
-
-	if (dwc->usb_psy)
-		power_supply_put(dwc->usb_psy);
-}
-EXPORT_SYMBOL_GPL(dwc3_core_remove);
-
-static void dwc3_remove(struct platform_device *pdev)
-{
-	dwc3_core_remove(platform_get_drvdata(pdev));
-}
-
-#ifdef CONFIG_PM
-static int dwc3_core_init_for_resume(struct dwc3 *dwc)
-{
-	int ret;
-
-	ret = reset_control_deassert(dwc->reset);
-	if (ret)
-		return ret;
-
-	ret = dwc3_clk_enable(dwc);
-	if (ret)
-		goto assert_reset;
-
-	ret = dwc3_core_init(dwc);
-	if (ret)
-		goto disable_clks;
-
-	return 0;
-
-disable_clks:
-	dwc3_clk_disable(dwc);
-assert_reset:
-	reset_control_assert(dwc->reset);
-
-	return ret;
-}
-
-static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
-{
-	u32 reg;
-	int i;
-	int ret;
-
-	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
-		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
-				    DWC3_GUSB2PHYCFG_SUSPHY) ||
-				    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
-				    DWC3_GUSB3PIPECTL_SUSPHY);
-		/*
-		 * TI AM62 platform requires SUSPHY to be
-		 * enabled for system suspend to work.
-		 */
-		if (!dwc->susphy_state)
-			dwc3_enable_susphy(dwc, true);
-	}
-
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (pm_runtime_suspended(dwc->dev))
-			break;
-		ret = dwc3_gadget_suspend(dwc);
-		if (ret)
-			return ret;
-		synchronize_irq(dwc->irq_gadget);
-		dwc3_core_exit(dwc);
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
-			dwc3_core_exit(dwc);
-			break;
-		}
-
-		/* Let controller to suspend HSPHY before PHY driver suspends */
-		if (dwc->dis_u2_susphy_quirk ||
-		    dwc->dis_enblslpm_quirk) {
-			for (i = 0; i < dwc->num_usb2_ports; i++) {
-				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
-				reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
-					DWC3_GUSB2PHYCFG_SUSPHY;
-				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
-			}
-
-			/* Give some time for USB2 PHY to suspend */
-			usleep_range(5000, 6000);
-		}
-
-		for (i = 0; i < dwc->num_usb2_ports; i++)
-			phy_pm_runtime_put_sync(dwc->usb2_generic_phy[i]);
-		for (i = 0; i < dwc->num_usb3_ports; i++)
-			phy_pm_runtime_put_sync(dwc->usb3_generic_phy[i]);
-		break;
-	case DWC3_GCTL_PRTCAP_OTG:
-		/* do nothing during runtime_suspend */
-		if (PMSG_IS_AUTO(msg))
-			break;
-
-		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			ret = dwc3_gadget_suspend(dwc);
-			if (ret)
-				return ret;
-			synchronize_irq(dwc->irq_gadget);
-		}
-
-		dwc3_otg_exit(dwc);
-		dwc3_core_exit(dwc);
-		break;
-	default:
-		/* do nothing */
-		break;
-	}
-
-	return 0;
-}
-
-static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
-{
-	int		ret;
-	u32		reg;
-	int		i;
-
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		ret = dwc3_core_init_for_resume(dwc);
-		if (ret)
-			return ret;
-
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
-		dwc3_gadget_resume(dwc);
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg) && !device_may_wakeup(dwc->dev)) {
-			ret = dwc3_core_init_for_resume(dwc);
-			if (ret)
-				return ret;
-			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, true);
-			break;
-		}
-		/* Restore GUSB2PHYCFG bits that were modified in suspend */
-		for (i = 0; i < dwc->num_usb2_ports; i++) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
-			if (dwc->dis_u2_susphy_quirk)
-				reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-
-			if (dwc->dis_enblslpm_quirk)
-				reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
-
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
-		}
-
-		for (i = 0; i < dwc->num_usb2_ports; i++)
-			phy_pm_runtime_get_sync(dwc->usb2_generic_phy[i]);
-		for (i = 0; i < dwc->num_usb3_ports; i++)
-			phy_pm_runtime_get_sync(dwc->usb3_generic_phy[i]);
-		break;
-	case DWC3_GCTL_PRTCAP_OTG:
-		/* nothing to do on runtime_resume */
-		if (PMSG_IS_AUTO(msg))
-			break;
-
-		ret = dwc3_core_init_for_resume(dwc);
-		if (ret)
-			return ret;
-
-		dwc3_set_prtcap(dwc, dwc->current_dr_role, true);
-
-		dwc3_otg_init(dwc);
-		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
-			dwc3_otg_host_init(dwc);
-		} else if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
-			dwc3_gadget_resume(dwc);
-		}
-
-		break;
-	default:
-		/* do nothing */
-		break;
-	}
-
-	if (!PMSG_IS_AUTO(msg)) {
-		/* restore SUSPHY state to that before system suspend. */
-		dwc3_enable_susphy(dwc, dwc->susphy_state);
-	}
-
-	return 0;
-}
-
-static int dwc3_runtime_checks(struct dwc3 *dwc)
-{
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (dwc->connected)
-			return -EBUSY;
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-	default:
-		/* do nothing */
-		break;
-	}
-
-	return 0;
-}
-
-int dwc3_runtime_suspend(struct dwc3 *dwc)
-{
-	int		ret;
-
-	if (dwc3_runtime_checks(dwc))
-		return -EBUSY;
-
-	ret = dwc3_suspend_common(dwc, PMSG_AUTO_SUSPEND);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dwc3_runtime_suspend);
-
-int dwc3_runtime_resume(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	int		ret;
-
-	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
-	if (ret)
-		return ret;
-
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (dwc->pending_events) {
-			pm_runtime_put(dev);
-			dwc->pending_events = false;
-			enable_irq(dwc->irq_gadget);
-		}
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-	default:
-		/* do nothing */
-		break;
-	}
-
-	pm_runtime_mark_last_busy(dev);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dwc3_runtime_resume);
-
-int dwc3_runtime_idle(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-
-	switch (dwc->current_dr_role) {
-	case DWC3_GCTL_PRTCAP_DEVICE:
-		if (dwc3_runtime_checks(dwc))
-			return -EBUSY;
-		break;
-	case DWC3_GCTL_PRTCAP_HOST:
-	default:
-		/* do nothing */
-		break;
-	}
-
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_autosuspend(dev);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dwc3_runtime_idle);
-
-static int dwc3_plat_runtime_suspend(struct device *dev)
-{
-	return dwc3_runtime_suspend(dev_get_drvdata(dev));
-}
-
-static int dwc3_plat_runtime_resume(struct device *dev)
-{
-	return dwc3_runtime_resume(dev_get_drvdata(dev));
-}
-
-static int dwc3_plat_runtime_idle(struct device *dev)
-{
-	return dwc3_runtime_idle(dev_get_drvdata(dev));
-}
-#endif /* CONFIG_PM */
-
-#ifdef CONFIG_PM_SLEEP
-int dwc3_pm_suspend(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	int		ret;
-
-	ret = dwc3_suspend_common(dwc, PMSG_SUSPEND);
-	if (ret)
-		return ret;
-
-	pinctrl_pm_select_sleep_state(dev);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dwc3_pm_suspend);
-
-int dwc3_pm_resume(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	int		ret = 0;
-
-	pinctrl_pm_select_default_state(dev);
-
-	pm_runtime_disable(dev);
-	ret = pm_runtime_set_active(dev);
-	if (ret)
-		goto out;
-
-	ret = dwc3_resume_common(dwc, PMSG_RESUME);
-	if (ret)
-		pm_runtime_set_suspended(dev);
-
-out:
-	pm_runtime_enable(dev);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dwc3_pm_resume);
-
-void dwc3_pm_complete(struct dwc3 *dwc)
-{
-	u32		reg;
-
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
-			dwc->dis_split_quirk) {
-		reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
-		reg |= DWC3_GUCTL3_SPLITDISABLE;
-		dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
-	}
-}
-EXPORT_SYMBOL_GPL(dwc3_pm_complete);
-
-int dwc3_pm_prepare(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-
-	/*
-	 * Indicate to the PM core that it may safely leave the device in
-	 * runtime suspend if runtime-suspended already in device mode.
-	 */
-	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_DEVICE &&
-	    pm_runtime_suspended(dev) &&
-	    !dev_pinctrl(dev))
-		return 1;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dwc3_pm_prepare);
-
-static int dwc3_plat_suspend(struct device *dev)
-{
-	return dwc3_pm_suspend(dev_get_drvdata(dev));
-}
-
-static int dwc3_plat_resume(struct device *dev)
-{
-	return dwc3_pm_resume(dev_get_drvdata(dev));
-}
-
-static void dwc3_plat_complete(struct device *dev)
-{
-	dwc3_pm_complete(dev_get_drvdata(dev));
-}
-
-static int dwc3_plat_prepare(struct device *dev)
-{
-	return dwc3_pm_prepare(dev_get_drvdata(dev));
-}
-#else
-#define dwc3_plat_complete NULL
-#define dwc3_plat_prepare NULL
-#endif /* CONFIG_PM_SLEEP */
-
-static const struct dev_pm_ops dwc3_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dwc3_plat_suspend, dwc3_plat_resume)
-	.complete = dwc3_plat_complete,
-	.prepare = dwc3_plat_prepare,
-	/*
-	 * Runtime suspend halts the controller on disconnection. It relies on
-	 * platforms with custom connection notification to start the controller
-	 * again.
-	 */
-	SET_RUNTIME_PM_OPS(dwc3_plat_runtime_suspend, dwc3_plat_runtime_resume,
-			   dwc3_plat_runtime_idle)
-};
-
-#ifdef CONFIG_OF
-static const struct of_device_id of_dwc3_match[] = {
-	{
-		.compatible = "snps,dwc3"
-	},
-	{
-		.compatible = "synopsys,dwc3"
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, of_dwc3_match);
-#endif
-
-#ifdef CONFIG_ACPI
-
-#define ACPI_ID_INTEL_BSW	"808622B7"
-
-static const struct acpi_device_id dwc3_acpi_match[] = {
-	{ ACPI_ID_INTEL_BSW, 0 },
-	{ },
-};
-MODULE_DEVICE_TABLE(acpi, dwc3_acpi_match);
-#endif
-
-static struct platform_driver dwc3_driver = {
-	.probe		= dwc3_probe,
-	.remove		= dwc3_remove,
-	.driver		= {
-		.name	= "dwc3",
-		.of_match_table	= of_match_ptr(of_dwc3_match),
-		.acpi_match_table = ACPI_PTR(dwc3_acpi_match),
-		.pm	= &dwc3_dev_pm_ops,
-	},
-};
-
-module_platform_driver(dwc3_driver);
-
-MODULE_ALIAS("platform:dwc3");
-MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d5b985fa12f4..036a1440c8e8 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1231,8 +1231,6 @@ struct dwc3 {
 	struct usb_role_switch	*role_sw;
 	enum usb_dr_mode	role_switch_default_mode;
 
-	struct power_supply	*usb_psy;
-
 	u32			fladj;
 	u32			ref_clk_per;
 	u32			irq_gadget;
@@ -1565,7 +1563,6 @@ struct dwc3_gadget_ep_cmd_params {
 
 /* prototypes */
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
-void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
 #define DWC3_IP_IS(_ip)							\
-- 
2.53.0

