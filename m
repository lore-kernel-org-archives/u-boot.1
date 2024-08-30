Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8CBCA0ED0
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FF9A88D4D;
	Fri, 30 Aug 2024 03:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724981205;
	bh=QHZnMcvlfyLbRoGgUHJKWBPfIep+DkQWyO2ESEh3Ee4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iQRD1gY+ctfORs654Z3NNygJ41T9QEFaqW4ThSk+GpE1OuRSPVvCQa/mh88ZJloKb
	 iQiyTcCnLgwOmP/AEaK9jJu5uQCEeCBr1dqV4+QMJfasIk4Yd0Fy7P++s3xi2bhLdr
	 PX63rhnJInsSXpRtEO0+iu+kXF9TPzRd5sn6bS43H1GKsMy5OSNF4dIc+vTkQXyrim
	 FRUOvXX1FzV0I3xHeSDTEKe0HRh/7foUUpc+PZ6qE/VpEWNZDYwTMGQztEhm5o3dne
	 wJRgoq8w+SRqdfxuR0iQ/0TPs/cV4Kzl5pa24afD6rGxR0jcg/DspUTY+FR8Y2XjRL
	 +Jg7PZJPEimhA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1EBC888D37;
 Fri, 30 Aug 2024 03:26:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724981203;
 bh=QHZnMcvlfyLbRoGgUHJKWBPfIep+DkQWyO2ESEh3Ee4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Q9DfRhvII4SqVnl43yuc33gSyBoH377JInknwkND4YXFKgIRJFbW7sKsQ8H9FjpD8
 AhMunkbPleNDWmrwa/On+0CSApn6j4OSFjg8xymC9R3ae4t3yoTmscmV2WcY10fieP
 p+2Of6t8i3FjopwDzEe+CPhiZyEhaaWf2114phi5OX47IBxo0vhRNwj2Io0MCoxlka
 Qs5da9SLLuKaAU8nRgKz8XuvsKZmZ9zP9uTRKPDo4zMgvjrj/C4zqVDzHG9/NhMmJ9
 KK+ansO4fkWxa9UZeOgDcqY62W8/FW3p9I8hKSYC4QTsrlDNFbOa1CpzvXNmfq4M8b
 3ZLDepL9ArhxA==
Message-ID: <801768ea-1bca-4e5a-b9d0-d4fbbdb140b5@denx.de>
Date: Fri, 30 Aug 2024 03:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] phy: starfive: Add Starfive JH7110 PCIe 2.0 PHY
 driver
To: Minda Chen <minda.chen@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
 <20240829013058.6178-4-minda.chen@starfivetech.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240829013058.6178-4-minda.chen@starfivetech.com>
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

On 8/29/24 3:30 AM, Minda Chen wrote:

[...]

> +static int phy_pcie_mode_set(struct jh7110_pcie_phy *data, bool usb_mode)
> +{
> +	unsigned int phy_mode, width, usb3_phy, ss_mode, split;
> +
> +	/* default is PCIe mode */
> +	if (!data->stg_syscon || !data->sys_syscon) {
> +		if (usb_mode) {
> +			dev_err(data->phy->dev, "doesn't support usb3 mode\n");

USB3 in capitals , USB is an abbreviation.

[...]

> +static int jh7110_pcie_phy_set_mode(struct phy *_phy,

Use plain 'phy' variable name, drop the leading underscore .

> +				    enum phy_mode mode, int submode)
> +{
> +	struct udevice *dev = _phy->dev;
> +	struct jh7110_pcie_phy *phy = dev_get_priv(dev);
> +	int ret;
> +
> +	if (mode == phy->mode)
> +		return 0;
> +
> +	switch (mode) {
> +	case PHY_MODE_USB_HOST:
> +	case PHY_MODE_USB_DEVICE:
> +	case PHY_MODE_USB_OTG:
> +		ret = phy_pcie_mode_set(phy, 1);
> +		if (ret)
> +			return ret;
> +		break;
> +	case PHY_MODE_PCIE:
> +		phy_pcie_mode_set(phy, 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(_phy->dev, "Changing phy mode to %d\n", mode);

PHY in capitals.

> +	phy->mode = mode;
> +
> +	return 0;
> +}
Looks pretty good, thanks !
