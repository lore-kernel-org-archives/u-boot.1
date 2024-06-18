Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C24C2BB85
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3320688366;
	Tue, 18 Jun 2024 17:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718724623;
	bh=3o/ABsgflogiXLoPeLgRzNzZ1hceb86fOTvhqUUOZko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sqA+8NOEPl+2oslTwLlsOxM59Qu5sUBKIvqdosPByXDs339b5kg9cDjeNbCg/eJha
	 IaoUIC+tsgAkGQ9gbnTT2gSzBQrwAl7LMvp2XSxwNI9/CuTaZPrBK9Vu41f6xG+1gx
	 YNkcyXb4B7On24GODTPoBJ753jkuZenBVEIIn/LZVVdCTcuZT8lpOhoqYixgLae3N0
	 oIimFAADnAxid7ufNAfYW1TkOeoEsL9jGQcBwdEK7SU0UghfAmzgjPiQnfwL2awtZx
	 rd+02EmnWMHMD5yuJ3tzCAJ5CqwNBTaG1kvILgxcGrAzNjgdqnvejzBwu6zT5qszKj
	 DmS1A7JUMd0eg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3DF3A883E8;
 Tue, 18 Jun 2024 17:30:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1718724621;
 bh=3o/ABsgflogiXLoPeLgRzNzZ1hceb86fOTvhqUUOZko=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oD40+bcodFcfaxirQHn7Cw2X+G9S7Flo1CREBAjttlKbFelfmDn4AnbkWt/Jg6Jxf
 lC5h0kOVq2rsQ6LeYvALY4KDpiWRkET89hLUaKYQoL737jcUxykeraagA7F6hDhlK0
 jzzFj4AacF7+ECOUDge3d2qUXF+JPafRvITVoktEKs42PsNpy1cRRLCxc9RpW0jRk+
 QT8TEVC0sHPJaCDtcvs8nbBn1lO4N55DkBuKnuAxVc7BEjvDSAhN9XEM9P97t0snTO
 tJ4cXTBwvim8M7BkhC4dSOHuSyHPFx7zd/O7ZO742+O5rvd5yDZ2XtqYjEjUL1+US6
 SkmZ1i4eqa0ZQ==
Message-ID: <1b2bcb6f-1b61-422c-9ee7-85479d9775be@denx.de>
Date: Tue, 18 Jun 2024 17:17:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] usb: dwc3: add newlines to dev_vdbg calls in ep0
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240618150359.3306514-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240618150359.3306514-1-caleb.connolly@linaro.org>
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

On 6/18/24 5:03 PM, Caleb Connolly wrote:
> For some reason none of these debug prints have newlines, resulting in a
> "fun" surprise when attempting to debug this driver.
> 
> The other parts of the dwc3 driver have newlines, add them here too (and
> fix some minor nearby indent issues to make checkpatch happy).
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Rebased on latest next, no changes

Reviewed-by: Marek Vasut <marex@denx.de>
