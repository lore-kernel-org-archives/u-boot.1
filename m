Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A021CA100C
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 18:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCC5188CFB;
	Fri, 30 Aug 2024 20:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725043875;
	bh=jUYUh+qWStF+awg6lr9IayP4LbOA9J6wkyZoCi6fBxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JGZ/5XMaNEHHHb4Ke9rroddEr5YqDyZRaTkZyv+2bmHu6919eC+xC5JF7/YxH2Ujl
	 nff7gP315raHR4Ai1wut+XORgGB+hqFATTAYuZyzGvXgUFXP7IH0+1DlZPjbz1/dwg
	 W8jmg8dt93J4Mztl+W/BrIEEEkekYdcGJPa4BBQDTIpRyHDJkjjqgF5wzyOTsZ4Ms0
	 26VqwN8emw24YrDvm9ikqN24MYGsl6S85Okm0wAh1/MJJQilezQcwjHryE+wZqGDv0
	 wzQoiLdwlxA7vcQVHrkbSWyTGxJWd586QPEDaJYoR35md9UlPcEOKc3mqv8OrhUT5k
	 Qeqh2qz2I0KjA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 619A088C60;
 Fri, 30 Aug 2024 20:51:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725043873;
 bh=jUYUh+qWStF+awg6lr9IayP4LbOA9J6wkyZoCi6fBxk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=XEU7ZyOo3InSZTR8Y9kZcBPQaCl+CAWhtRgsV8yr2434btkam+nDXIuBeOsMSBnDu
 AnqXR1SwTep0l5AWQsGM2eyPhhNlTRhF90wJwmg+wZo0Eoik7sqxIMY4DIIoQmJP8H
 1QFh3SL9GPZlAqVzZXykDR1h/g9Vt5aXSYpp5Mwb91GXLhn9UIWjAPxLZpWQ2TXrf0
 99MM6Dpem+Qg8XPj02iBQCejbVGR72AOnjGfyyLik8HOed9MuiKCiZGI5BNOlhdza2
 4/c8t7JikqidgaLoIsMRleVQodkdYEFb8IxNQ5UdYiXKwmg+2m/G8ElTXVuPe+rdhv
 eSnyXP3xLUIGA==
Message-ID: <84eaa9d5-4963-4a51-ad3e-b5df5cf7b33b@denx.de>
Date: Fri, 30 Aug 2024 20:49:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mx5: Remove CFG_MXC_USB_PORT
To: Fabio Estevam <festevam@gmail.com>, peng.fan@nxp.com
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, smoch@web.de,
 Fabio Estevam <festevam@denx.de>
References: <20240828132529.3098961-1-festevam@gmail.com>
 <20240828132529.3098961-3-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240828132529.3098961-3-festevam@gmail.com>
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

On 8/28/24 3:25 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> CFG_MXC_USB_PORT is not used anywhere, so remove this unused symbol.
> 
> Suggested-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Marek Vasut <marex@denx.de>
