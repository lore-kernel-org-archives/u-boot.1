Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05159C27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 23:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51AA48769A;
	Thu, 23 Nov 2023 00:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700697224;
	bh=QPCUwNMDAkrV0YF+B6I+fli4bZVhXvMDXbhvlrzVD+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JtHaTj+DnR8DGJvQsyG9PWeoikxHkHpR66S83Xzq65YSxG9Go4yi4jqEqQQBfKwZn
	 YgcgGtzrT6uSgpfydUXvjuk+JcvRRflygbGB6oJI6Zt/oCYRvX1QJSvwofEewjeCqc
	 9ltECLpyWNf3KiNWahlpGDwTerYfJWCvgfUK5NJ1TV6U6A3nQWEbyEjRdTlnBS42zP
	 KUXMgNEhqYLcod3kDZrIC9CjSqtobVT5cz7PlDhVY/usYHUafqfTkTdRBHTAPlYoml
	 Gcb0rS3qq6M6SgV1EhTERYQK9eku0uw+CB9TozHPHmO+Z+cJ2HksJX/zvyxi8GjzqL
	 oEBdjJZukZtpw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B617A87675;
 Thu, 23 Nov 2023 00:53:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700697223;
 bh=QPCUwNMDAkrV0YF+B6I+fli4bZVhXvMDXbhvlrzVD+4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ia75JdmzDPb7eSdHEUoaaovMbNwD/kV8cJnRXQqlfW+rvAvlEWfmY6hJksLece88z
 a+O7y2jBm0kigtknkix2DpHoniDM6LPRSEKcuUcSGXIXnNZH/iYIdEp6/I0kOqTbLc
 DoAvQFtwAAaRhhoxAj7qzVMqcdvpHPvy2aHduHiY4zw0x38orgMn2AILzpBI4fLMjT
 QzF3YXk4L9/tm+iI96aX3nARj3zwiUX8ExheN7UvB53fxxjZzASL1TSyFoaJWvzs+O
 8mYe+nFh4P5EeJe4VyA+0gJ0rr7qkoG8D/0uuDYtUaxJ74tEfz6q/0q7Eu0nMcSQmA
 pf74WNaZMXsAA==
Message-ID: <333ec5fc-dc72-4600-889e-dc011b4381fd@denx.de>
Date: Thu, 23 Nov 2023 00:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] usb: USB_XHCI_PCI depends on PCI
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Angelo Dureghello <angelo@kernel-space.org>,
 u-boot@lists.denx.de
References: <20231120145636.110466-1-heinrich.schuchardt@canonical.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231120145636.110466-1-heinrich.schuchardt@canonical.com>
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

On 11/20/23 15:56, Heinrich Schuchardt wrote:
> Compiling with CONFIG_USB_XHCI_PCI and CONFIG_PCI=n results in
> 
>      usb/host/xhci-pci.c:48:(.text.xhci_pci_probe+0x44):
>      undefined reference to `dm_pci_write_config32
> 
> Add the missing Kconfig dependency.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !
