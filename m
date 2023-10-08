Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C28E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 01:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71C8386DCB;
	Sun,  8 Oct 2023 03:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696728561;
	bh=6WYNznKDe8jxRKbMi278PJ7nIXBb+v9POtaBpw8XZBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RuJQ8Y3ru9kyPzIl2yVuWr7k7/6H4nbOWccRqc1/3h9s51lIpWj2paHWdUEWwnSYH
	 rhcPD6Y0+RXjI4xodMC48ZfR898LAxrXOUHDT3AO9q+K9yHUOT/dzjDQqcRRWfCPDP
	 uZSHuTQ6SANRv/65/qFwht4LbYt5DVVaPzBTEjlgqu7HG6DwjzOEcpBPBImIWpWGSw
	 /pJWT+fabDqnzvbXcaR9clD9B9ZPUPUy0tTfpIoAJW81zvGgIQKvJpf8tcdJ5IEsjh
	 BexZz8gkstefxVJkneCsvef0zfSbqisqsmG8Y81DxeFEcZYX4AYKsBkVyscGvYjy3l
	 i/ns+A46fMfWA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D30BC86DA2;
 Sun,  8 Oct 2023 03:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696728547;
 bh=6WYNznKDe8jxRKbMi278PJ7nIXBb+v9POtaBpw8XZBs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cuygSG21qopaVj8nlfDa5KCcSgggAN7eswGYrmbZa1J5qEUFEeNN3fttnXMnkqdeq
 hLivJWxtht4oa0kx/b04VZbX7Pr8kvwwBpu5+LZ8rfNP+BbjxZFHbOr8LxNHQekYhu
 c9AoaRfbPcY9fzqla6dIXbZTOsa7HU1vz2szkJiq0mLt2KqMxZoby7n8YQG/lmSXph
 XXtwUOREzD/FSVCsOhE+2Sh4UvTp5Lg8aRk5Es6fTD292kkP8mcF6qzOgcy3kpziCg
 rcJ8U/7Hxf3sn4AVziNdatj2gu99E/ndtnNecZjUN0ioTRvkRgOuoBAhK5qyt+fB6k
 e4alOj0iQuM1g==
Message-ID: <c2ff503f-6c1d-439d-a8c8-dab86985237c@denx.de>
Date: Sun, 8 Oct 2023 03:29:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] usb: ehci: mxs: Use regulator_set_enable_if_allowed()
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20231007215648.3156877-1-festevam@gmail.com>
 <20231007215648.3156877-2-festevam@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231007215648.3156877-2-festevam@gmail.com>
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

On 10/7/23 23:56, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 4fcba5d556b4 ("regulator: implement basic reference
> counter") the return value of regulator_set_enable() may be EALREADY or
> EBUSY for fixed/GPIO regulators.
> 
> Swict to using the more relaxed regulator_set_enable_if_allowed() to
> continue if regulator already was enabled or disabled.
> 
> This fixes the following error when running the 'ums' command:
> 
> => ums 0 mmc 0
> UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0xece000
> Error enabling VBUS supply
> g_dnl_register: failed!, error: -114
> g_dnl_register failed
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Marek Vasut <marex@denx.de>
