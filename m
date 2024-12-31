Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F90FE77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 18:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54DB680463;
	Tue, 31 Dec 2024 19:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735668800;
	bh=JT9qVPiQX9IMGkoFRNJUVZHQjDPE1f/B3O/P+t+6yWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SpHSQQyza/R0XL2EAKOjS60eSHuAv90lHRf8Sc55ZO4JMIYPi3JbO0Oy0E8eLXUXb
	 cASXSn5/J/oqEqK39yNGVePoOPHKDPj28lvcatdKY7QfNY05/o4MG8hWS6jiCHr7dn
	 QEd6RAROP8VNNCQpTueQtpXevrDmQFRbrjC+xJBBA51EUzPJTWgM6zc9DFf1bqtnr6
	 NiMkux0XBYOEBKF09Tkd7mrTXN83leVkPHq2MCCSBFe/eWi4tYw9XAQggN16CXq4oh
	 z4h74gpixcoyhVrPOXR4YfOXHe1wAngU/SL/jguvvmzlhz3aYOrWFMsOXf8055DvCu
	 XAnTBlu5anSWA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DBA78021D; Tue, 31 Dec 2024 19:13:17 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E6FC801CE
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 19:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ElrT10cd"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 601CA10486D86; Tue, 31 Dec 2024 19:13:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735668794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JT9qVPiQX9IMGkoFRNJUVZHQjDPE1f/B3O/P+t+6yWM=;
 b=ElrT10cd8CV2fM0bvjWZcvpEKQn98lqMvOzOG7xKXoeaE1oIWBy22b06HMSpbwm1LcIVcT
 sRj3WV1smC5k4HNsaz0gsJzQgCeGgr9xq6lgGn0hqAvuCqNXlONPHnX37DttgwhsNMzPZK
 /ZR3VLR9RNPuem+J+scGBMfn42tcS+3bRm2Lo1fercTMofWXfT+lEd/2/bobWEvgdUB+PD
 csCK3P9BLzPpDml42sRBXTUlvt/H4M5ECKpuBPzIA54VbjP6Kl/HZt0cS79uocYHF8BFH6
 Z4t9VsY3zpUNI0Eh5QrllLZyCmMEvG+F+AIwhMLDWmRS0HyW7HAOdpb10XJtww==
Message-ID: <42ed7504-b5c5-47a2-979a-a9da8d89e01f@denx.de>
Date: Tue, 31 Dec 2024 19:09:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] usb: dwc2: Refactor and update USB DWC2 driver
To: liujh2818@outlook.com, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
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

On 12/30/24 4:30 AM, Junhui Liu via B4 Relay wrote:
> This series improves the USB DWC2 driver by extracting register
> definitions into a common file for better readability and updating the
> reset method to reflect changes in version 4.20a, including the new
> GRSTCTL_CSFTRST_DONE bit for reset completion indication.
> 
> This series has been tested on two platforms:
> - MK808 with RK3066 SoC and dwc2 v2.91a, tested with USB flash drive and
>    connected the board to the PC through the rockusb command. Test log [1].
> - K230-CanMV with K230 SoC [2] and dwc2 v4.30a, tested with the onboard
>    rtl8152 USB to net chip and an external rtl8152 adapter connected to
>    the onboard USB-C interface via USB hub. Test log [3].
> 
> [1] https://gist.github.com/Judehahh/878ace2607d201dc49211f2c655f0fe0#file-mk808-md
> [2] https://developer.canaan-creative.com/k230/en/dev/CanMV_K230_Tutorial.html
> [3] https://gist.github.com/Judehahh/878ace2607d201dc49211f2c655f0fe0#file-k230-canmv-md
The series is pretty good, only a few trivial nitpicks here and there.

Thank you for doing this.
