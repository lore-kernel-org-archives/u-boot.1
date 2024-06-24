Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A818C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 13:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3147D883AF;
	Mon, 24 Jun 2024 15:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719237104;
	bh=UqWzXppHTe+IrjlFPQfv71D8qyQ1LDhJX1LZ9DsgHH0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+SjlSvGyxf7xCYfMrYvuLmXROCtC94RfWsT3HqcNDgzyJg2HCWlWGaA+9w2TR7/k
	 t8shek+xIdGwX3Axlyh63bjAv01QZ7XYk8Un9EQhJyVn0ED3rhxNOhAYLg610H9YKz
	 Pv4aUQ+V6pPwY63lz61MoG0pRYOSFAnltzQlHYVrQKuNCwXWTTKYmb93Hx/f1aDQmb
	 aHYjgVLk6e3HH0DN7FGQRzQrivqVX6QGeVZ9VlZwA237aF5l6c/sLIrdVsYR1eBuXK
	 Av4Ym/vj4LpNM+nOro66Mv0cmFI2V5YfoPZx2As/tDKmL1xggfO8DFZ3yrgkkdW3OK
	 GnUL9GgY2pu8A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F2F3B87DEA;
 Mon, 24 Jun 2024 15:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719237101;
 bh=UqWzXppHTe+IrjlFPQfv71D8qyQ1LDhJX1LZ9DsgHH0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gk1Oo2DzDLV310wzw/UewCG5B47M+b07XbjfTn87FMRqPrSffLkq6iEn3lgrB4Co+
 ibv6Yu/rALI6Jse+ktf25ERH50e/8AiSqOpLseLsVGtMq59HZzwfiJlpNUOosSPlqV
 Qyo63Ie1DJ2xxRARHKKCOepp2GnWI8ExevfUEUUh7p3pfg2xrSZenyeAlO1jdtOlMD
 PjAN/IuRYSXjxi0S43yzNAf9p+ujxk0RjgJi4ytM50lBtNE1t1y0cLMxVdyexPBvBi
 nHQzqq6xMzP7WogN/wAziXqPHbDCG/3c3Fl9P+aFs1K3K3IJFJ4kcH17znPVfBAb4n
 uAJCM7APV0d7Q==
Message-ID: <2f48e858-116f-4dc7-a3ac-b640725fbe90@denx.de>
Date: Mon, 24 Jun 2024 14:12:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] usb: meson: switch to set_mode callback and other
 cleanup
To: neil.armstrong@linaro.org
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20240620-u-boot-usb-gxl-phy-set-mode-v2-0-b81c027bc02c@linaro.org>
 <857a61e1-a586-43e5-be07-0321340e21e3@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <857a61e1-a586-43e5-be07-0321340e21e3@linaro.org>
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

On 6/24/24 11:11 AM, Neil Armstrong wrote:
> Hi Marek,

Hi,

> On 20/06/2024 09:42, Neil Armstrong wrote:
>> Switch to set_mode callback now it's available and in the same
>> time make public functions static and drop useless mach-meson
>> headers that are no more needed.
> 
> Thanks for the review, is it ok to apply it via my tree ?

Yes please
