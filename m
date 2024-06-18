Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A961FC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 12:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42222882BE;
	Tue, 18 Jun 2024 14:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718712087;
	bh=sG0NRy7NRTtxtnfuFCal1jkUP4gcYXcCM0ntQT5JSMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gh7V+K+0WkOvobB30imYJ6pd0ky6sQfvMb4uvtlvOUEEuBzuhlpa/Wvc75n57jB+U
	 C/DNE9V264J0FQnAj7ZU8/srdqCmBdg1NQPL2DswHmQI+zNScU5e1i4byqHUSDalBD
	 dle4opHPpemgdRor354FtS3WIv8LaRDZx34LKnuGxEoq4dtsOsZ3smKw6gmQGFt+pH
	 Q6Gguk1eBG58uK2sihWzUxNBWULsPmlNjZPaiIlh9gVZ7YDuZemRJZrpwK3M0YTBr+
	 suzMmQOJ+i2pNjEZY18Djd9O7Oqz8J68iUhmmaX1IptBo/CC1RhpwgFh5pLKNxVH7J
	 IAU26OlEiMnow==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 441DE88271;
 Tue, 18 Jun 2024 14:01:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718712084;
 bh=sG0NRy7NRTtxtnfuFCal1jkUP4gcYXcCM0ntQT5JSMI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PdncvIT7nBJ5Q3i6Lr5XtUGk6D8NbfbogW/S8CKWyV8CA3VV4fQsOZE1+6XUaHd3B
 Loc3XPsR2G/DLdcm+d2Cq/wqOSAsFzKeVjmyB+HutcaqF5g9hUQJ8UqLcCKjnUxUPj
 /ZWsIYA+7+FpqnZ4BOHT/GVKbjhYt9i34vGJzVi+A4uycAu0A0QCUBoRrl8lTKWdCk
 JTvee32XgJ0vfd0dFY4WacilLiiGykgh92dXZmyMXlP4YJQgqcZy0yGbh5LsJDd2S0
 iu4HAuyXyVKuIdWFjuI/idom8y6va3CEOod9nouXXQTSyIweZyNjjWoDmsa5RpWZiE
 pMRRpADdlZCzA==
Message-ID: <b8d83d44-e182-49df-89ad-fd44e1322209@denx.de>
Date: Tue, 18 Jun 2024 13:50:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] usb: informative message if no controller
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240618095857.58088-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240618095857.58088-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 6/18/24 11:58 AM, Heinrich Schuchardt wrote:
> The message 'No working controllers found' provides no clue that this
> refers to USB controllers.
> 
> Provide a message that refers to USB. Use log_info().
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Marek Vasut <marex@denx.de>
