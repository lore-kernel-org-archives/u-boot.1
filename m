Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C08E65D25
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 04:12:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A7D88D7E;
	Fri, 22 Nov 2024 05:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732248743;
	bh=UBCOyrfZyNaHuwOLBWvOKhwwV6LqcKNjb+zfdiEjmu8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BxSaHt+RRMKnDtjyjJqC8bOG/nw0KXbQ0JDkk0dqUYQWyqAIqh/6z6WPYaIYj+m6H
	 YxKZze4T8mVrvjOYD2DzvpjQJTQMNCwUx2gQ9wVQXkAvjhAr1Uy0WgRFpbDvuPwArO
	 27qC0QrV96RTGiZ479OfiXuuRL1b9RrzPBZKXQFzJjDXRQmUpZBzWqCMjL5cn5WZM5
	 4OE///w9DJC4c+c+3IArOTiS18QMOC5IDwZKElg1wJiyzZwCrpnT0+pkYw3qKCk/5A
	 oWOYl0rWvEEVnNXQ205TloFux1Zx3rkywjT6Y1Erd3j/N8NsBNB0N4MXVdySmPN1AL
	 AUkziXAtVrBBQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 85E6A89759;
 Fri, 22 Nov 2024 05:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732248741;
 bh=UBCOyrfZyNaHuwOLBWvOKhwwV6LqcKNjb+zfdiEjmu8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vOs4w42EFt/59O8KO44YzV70W3YVv+u4+qPgre0MFUdzMZcQNV9C8tYzZhEo3kEKa
 avKRxbMq7GU4MwI1g6O8rpr+AJKIrHc9iKOxJp5ja2NL4P82Nj8+KJOymHa3D0DqbW
 mR5r03iWrEDBtO4XHz2u11s2Rb1yhuDhMO43M+uL62ifV8Mx/yWq5mUiDMzGtmXrKT
 d8so2I5crQ++tL/G3hoaqyEnWfWd/YtatB+MdEc8JcFcobob3wu36z+FVOdYaPlSKh
 lxwPHTC58/Uau1gvXX+buL3OeZWpYiB7iqniXsvDPKsPsAPyaesl1JGvsQapx9iEVh
 TGcJYnv/86Vdg==
Message-ID: <044e0ac0-9c86-404e-acb4-e1db149c4bf6@denx.de>
Date: Thu, 21 Nov 2024 18:37:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/3] arm64: dts: imx8mp: Add aliases for the access to
 the EEMPROM ID page node
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241121172154.90507-1-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241121172154.90507-1-cniedermaier@dh-electronics.com>
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

On 11/21/24 6:21 PM, Christoph Niedermaier wrote:
> The new i.MX8M Plus DHCOM rev.200 is populated with M24C32-D EEPROM
> that contains an additional write-lockable page called ID page. Add
> aliases eeprom0wl and eeprom1wl for the access to the EEMPROM ID
> page node.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject reads EEMPROM , should be EEPROM

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>
