Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB127D49780
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 18:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDE2288CA0;
	Sun,  1 Dec 2024 19:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1733078713;
	bh=fTgUOBJfedgXEWBomwpoLwjXwQyqQna+ZdWsjZQb0iU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XtkLwtq+0l3VUmdOK3e+b2aut8iAv0urjM7Blb+cqxx4OQYAHaPJa3mXCPT67Jzmx
	 1SlgHhGtBbA4+jA0nU1y2iWHCiA5G0/NQCCi0DnHfOBlWBO7Eljp4eg7BWIHunP90v
	 xYKasZVY80r6QVS9LnJOUADSdCr9S1aWk6fVTPv0RAEJZlFUQJJnnk9bGuaQyu4HUt
	 dHjG7Zha/Yp0+RBuldzrMpSptSU4/8HeJ54bVdNKKqjgZJ/8gtPpefoGi1ydoCoIqL
	 5prjH20/M7sTyP6SAGnH5gwJmCwEFterkEvvWYjJ8Fz1UmQlR7YPOxRGzP2BNopyoB
	 RRPC6vGRCGjtQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DC90B88B58;
 Sun,  1 Dec 2024 19:45:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1733078712;
 bh=fTgUOBJfedgXEWBomwpoLwjXwQyqQna+ZdWsjZQb0iU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=swYIn1gOAmoXbqfilXKV/0lZCVLs5Pa1PXZQWnQDyo63DNwhI8zISzwSZmEeLJo8q
 Eywvy29aNuKrY8o6zK92B9V8kRsYKlTIJY2/b0GDbF595LbPMuCBlCRwOuTzaf3VZt
 i4KdlLIT0avwkKzZQ1zsSfU9C2tg3WaioQOU990BOcf8F7qzJF/3ECT293hZMJo3io
 0abfzxperC1vGoB5NvjmIrS2v2NOnWqkWdu6PY/fkNd/k9zU7lkV8mH3YhkjK8ezO1
 M0ZMCy1zcZdbs7GXiTzDsRXwzrdvPxH2rucvp7wl+xY9BhPqAoAbD//QTxVDGN2S3X
 jK/NrxvFVV6Qw==
Message-ID: <3f220d59-c44a-4472-8abd-a091563d7ea8@denx.de>
Date: Sun, 1 Dec 2024 19:18:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/4] arm64: dts: imx8mp: Add aliases for the access to
 the EEPROM ID page node
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20241128142020.35386-1-cniedermaier@dh-electronics.com>
 <20241128142020.35386-2-cniedermaier@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241128142020.35386-2-cniedermaier@dh-electronics.com>
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

On 11/28/24 3:20 PM, Christoph Niedermaier wrote:
> The new i.MX8M Plus DHCOM rev.200 is populated with M24C32-D EEPROM
> that contains an additional write-lockable page called ID page. Add
> aliases eeprom0wl and eeprom1wl for the access to the EEPROM ID
> page node.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
Reviewed-by: Marek Vasut <marex@denx.de>
