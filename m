Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38906C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 14:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B797787C86;
	Thu, 25 Jul 2024 16:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1721916125;
	bh=vPgJqJcO/GaMBygMNdP5j+rTo4k1Y6/9PCgFq/uE/Mo=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e6d8RDRIv0Z2ALb0tj6R2Alfhn1q18td0RmzOV024dqZ+oNQIjX6ZPOISavBxWo5s
	 a6OmQaVNvCODBBZ6/HAl64Q9J2Y/kxNv5tlz/5ZS92lfk8OPxmRqPoNn6gBelalrPH
	 v6E1OVIj8KsQqOHOLJVycTTE596jest6u37jewhtJ6VboFUuryEnnRB6hV9IkEv+No
	 NbPA8vbq7u7U7C487380ubz5lF5ZOmpJJjz2nZWE+wQiiRVVfefYeiVZ14TOJ8XjR4
	 xYZ8T0mmlqZ9JxkrsqwNUhf+EM3DLr87C99kbXcUx0ze68hpWZbejLLCka70yqu3CZ
	 Qx5HNGUGTe7Tw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0DE4586E35;
 Thu, 25 Jul 2024 16:01:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1721916124;
 bh=vPgJqJcO/GaMBygMNdP5j+rTo4k1Y6/9PCgFq/uE/Mo=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=QHt4K2tppowAXnFC4O7cUxWoXciMY49H+nsVEHN+p0QMnWDR/vru7Fv905eRe+Rr9
 kDdgoQcv3tHi/RITLpdwpvOS7YNMDaKR83wgS1/VhvdQC090JO8cCBD9P9zvLog7Lu
 RMglhIZe5gjiJTYfTlY1mcNqRJl6xl94IRhuSaqIowCl9U1stkIkkVB6wMw0tJs1Gx
 Ihl35g4y1Yd0pYqnXVXZAF37U81hWX9bnQ5TYPwqH3tgyAwboes3deA7fw3odYzB2C
 gsmI41SyS5U9IG5/Mmchl1WMI144vzAYljMBZzwtc4GTiqNfS0rxGck3PCWZe48x9k
 p7k2bWOGHP/KQ==
Message-ID: <a0665028-3051-4e9d-aaef-5d32349cd648@denx.de>
Date: Thu, 25 Jul 2024 15:53:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: imx8m: register ARM A55 core clock
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, u-boot@lists.denx.de,
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com, festevam@gmail.com,
 peng.fan@nxp.com
References: <20240725083655.24486-1-Zhiqiang.Hou@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240725083655.24486-1-Zhiqiang.Hou@nxp.com>
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

On 7/25/24 10:36 AM, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Register ARM A55 core clock for i.MX 8M Mini, Nano and Plus.

All those SoCs are A53 , which matches the patch, not the commit 
description. Please fix the commit description.
