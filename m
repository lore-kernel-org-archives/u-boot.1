Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6D6C54FB9
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 20:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EBD186F0D;
	Sun, 19 Nov 2023 21:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700427190;
	bh=dGj+dyesMJbjxATMRPwBNvGMybzcViw6y7RtkanSQ+k=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pxfY89jN1vyt+uq7zdg8Mmszr1P5ceSD22o+tVfxuhlP33mtEDNhPgkx2g41MXUqB
	 RwI+elCR157WYey9jjm9Bukx6IcAl/dxueEKMt0qq4pcOEeVXUNs1UGUVwwg7hcptM
	 qIEedqZ5kXVHteHTV9esPIJYzwqQ1/JpbkwG3aTs3Og98p/0FXJI2ufRm+DUjTrJED
	 GFYk3b6aYoq2RSk2wjoUf2fZ4uIR+nKOSi4vMTOfAzcJgKbQSlQtENv+yStNOP7M44
	 Qezc7X51qQMDUJ+Hi+cFzKjDZvG1AbQK1gpTW9OhlfhJCqAqwPzsGGM2R8oMKebnsC
	 uLL9XOQ8PHESw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 062AE86E65;
 Sun, 19 Nov 2023 21:53:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700427184;
 bh=dGj+dyesMJbjxATMRPwBNvGMybzcViw6y7RtkanSQ+k=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
 b=OO23xjGcz06QCIIPkZd5ous9ScIbs9Kj/Q8WkWqhM4TzcSG7Daj/RFDj195JSmKHN
 AnN4QF4Bb2mH2eP6fcf6caZAlVQj9saGKkh7xVrQvI7z1MTqzZBTO9EF1Y8p13WLu/
 LgkYZ8W1I5eXIScEWzJ6vJvxtC66HGM2RVWK2JL+A3E0QpCUykg+FlCPQscc0vwDHn
 xNXya4OINi5l7oilwyzPB+9lo9MxMtYdnCLfdbgsgen2YX3UeFffiOUnMZIKN5r/Gz
 xFvZ/PVn1QNHBGeUupUI+WSG1OXAFFmRRtDyZ5hUcqMRoARfzo49zkOMdnn0OqE7nE
 L/HI3YQBPUmvQ==
Message-ID: <a911092c-78e7-469b-abd8-2aeb9f7e28b7@denx.de>
Date: Sun, 19 Nov 2023 21:53:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: usb-hub: Reset hub port before scanning
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de
References: <20231110141311.512334-1-i@shantur.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231110141311.512334-1-i@shantur.com>
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

On 11/10/23 15:13, Shantur Rathore wrote:
> Currently when a hub is turned on, all the ports are powered on.
> This works well for hubs which have individual power control.
> 
> For the hubs without individual power control this has no effect.

OK

> Mostly in these scenarios the hub port is powered before the USB
> controller is enabled, this can lead to some devices in unexpected
> state.

This ^ part needs clarification.

Which devices are in incorrect state, the ones connected to the hub 
downstream facing ports ?

> With this patch, we explicitly reset the port while powering up hub
> This resets the port for hubs without port power control and has
> no effect on hubs with port power control as the port is still off.

Should common/usb_hub.c usb_hub_port_connect_change() trigger the reset?

Could it be you do not get a connect change event ?

> Before this patch AMicro AM8180 based NVME to USB adapter won't be
> detected as a USB3.0 Mass Storage device but with this it works as
> expected.

Do you have HUB power control ?

I recall there was some companion hub discussion recently.
