Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FF4E77188
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 22:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52846801A9;
	Sun, 12 Jan 2025 23:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736719586;
	bh=gzH/Gb6LjghZ3Xry+yWw/Di56/anHtYAgHCnI7BoHMI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ec+58tRVhs6GvZYfdq2oMtveVMMi94sSKpd2+/gVtcEqNM4kDqkFcHcwZhaAoucX7
	 W9psSxz82hhupgVu+gAKc0fBYzy44wT8wBp2iSP2RHtJf8DlST52Do2ZoKU/2gMPJ+
	 +WEgHhBuq2dfMqici9BED9icWan23lc+hiN6Ieu1VwDgT5oMAuIvbEo/75qo8sZnf0
	 NSDE4gGV1S+w3Vb8MegqGVtAgg6D+ZnWrCoMXjjn7NLn3ZcFkZ2cUx0BNZ5vNfZ35I
	 mVoSA8bQw9p0KMlO+99dzd0TX65z+xpRbINajruNo6kfqQJpyCiIp+/5hxKOBHLhm+
	 RD+Qvamg7XbAw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74814800D2; Sun, 12 Jan 2025 23:06:24 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2410980027
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 23:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="c4rcBW7r"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 837DA101D23A1; Sun, 12 Jan 2025 23:06:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736719580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gzH/Gb6LjghZ3Xry+yWw/Di56/anHtYAgHCnI7BoHMI=;
 b=c4rcBW7rMF3FgNsS/9QkJkT5CkNNS8+kIH91cAKv0sJb5a/BqGkPEm0jE9a6SPFWtAGMMd
 5JMi8GroRaDw+5BTZkAit8ZgtyZSOhlO8Zi3rJdtDyJlRlDk/P35IJ4rMeH7GPre+VRh2u
 UAcov9AxDbOoiPXoXUxVjbXJrUvgMhcQPuIitObWROs2ZkfeAKYnq5CmHNuYOBDfG2zc/K
 i0yxrXBxxOWeYxxC2hS0MGkBlzmYf9JUZH+qZcWHyaICFhsGQo7h5kfAmU8SiJsRgSNgSX
 7y3aH5L0RtrFcHSo99dsbUoPX32jP4dym9h1TWomZK4hV1RapN6xNo6wsXOFRA==
Message-ID: <7f7962fb-1772-418d-b06e-97ea33099ade@denx.de>
Date: Sun, 12 Jan 2025 21:48:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: dwc3: core: Fix timeout check
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, u-boot@lists.denx.de
References: <20250110074306.3897847-1-quic_varada@quicinc.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250110074306.3897847-1-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/10/25 8:43 AM, Varadarajan Narayanan wrote:
> dwc3_core_init loops 'timeout' times to check if the IP block is out
> of reset using 'while (timeout--)'. If there is some issue and
> the block doesn't come out of reset, the loop will run till
> 'timeout' becomes zero and the post decrement operator would set
> timeout to 0xffffffff. Though the IP block is not out reset, the
> subsequent if check 'if !timeout' would fail as timeout is not
> equal to zero and the function proceeds with the initialization.
> 
> Make this a pre decrement to address this.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
Does the following patch work too ? It removes all the fragile 
open-coded polling

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a35b8c2f646..7e7017d4be7 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -29,6 +29,7 @@
  #include <linux/usb/ch9.h>
  #include <linux/usb/gadget.h>
  #include <linux/bitfield.h>
+#include <linux/iopoll.h>
  #include <linux/math64.h>
  #include <linux/time.h>

@@ -587,7 +588,6 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
   */
  static int dwc3_core_init(struct dwc3 *dwc)
  {
-	unsigned long		timeout;
  	u32			hwparams4 = dwc->hwparams.hwparams4;
  	u32			reg;
  	int			ret;
@@ -610,17 +610,12 @@ static int dwc3_core_init(struct dwc3 *dwc)
  	}

  	/* issue device SoftReset too */
-	timeout = 5000;
  	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
-	while (timeout--) {
-		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-		if (!(reg & DWC3_DCTL_CSFTRST))
-			break;
-	};
-
-	if (!timeout) {
+	ret = read_poll_timeout(dwc3_readl, reg,
+				!(reg & DWC3_DCTL_CSFTRST),
+				1, 5000, dwc->regs, DWC3_DCTL);
+	if (ret) {
  		dev_err(dwc->dev, "Reset Timed Out\n");
-		ret = -ETIMEDOUT;
  		goto err0;
  	}
