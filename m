Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FD8C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 18:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5590087FB6;
	Mon,  4 Mar 2024 19:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709577129;
	bh=QXHQUydEIC73DnzwskvEgcZDi3aLFjh5zlqr/TwEn1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E3mP9eHdMOZFTCYUlhpSvoS35S3Y8FEH3mvfz5QUOUZnv2120GFXjmoeCf8m2aBAz
	 ysoPVM3ZrAgJNfK1YluoqXk7eB2nhOJazl1qeBQbi3Bw9ZLHf3StssZ8AHYhinqf0B
	 Xyro6aV3QLoetn2qwGA0o794Af2UuS5NUfXbtmAZWMABnY2LZWcAavlUBLwQ+XrYYo
	 1AyYYwORydHbLLiaURa25xvXiN+uZjg/omwLhswCjo87jaeSVHBbPwfNzDMYS64gX2
	 JRbWUGVtqfyv0uEttX6wwfRFWPgiqmS+9NBmKc9PqwEHmU96GJNvg30gj87VfZAr66
	 fFcbcBt1zhlmQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5E71087666;
 Mon,  4 Mar 2024 19:32:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709577125;
 bh=QXHQUydEIC73DnzwskvEgcZDi3aLFjh5zlqr/TwEn1M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=S9E1au5IadECoblCS8BpPlehF3JLqkH+dl2wSNmllFD561V7wLbgbJ//SkFnyo9pE
 C98XCRVDWNxhYWyTWsCLNOnO2XKtTFGITa77xC1a8twZ5BJ+83O4+f+YK49wjQVs41
 /GP9KotNbjL00BzcMbVqWpRl2IGzu7wVahiZLxbO6YgMlhAwzX26wYAr9R2Yirmk3G
 G+oo1pZ7iNu670BuY7753jsqtbMwk24jRrXywqyJL8VAtzRo4je+3Xxxwd5XgHfuVL
 nXp3e7JUN+AJCsyqbQVW8FEEpCUAsO+t7eqwMkm9AmDMiq+BUZ9NIq0JW1BieXB9WZ
 fM4ntPzN4EVeQ==
Message-ID: <c39e0672-ec67-48ca-b50a-8ce380e1df4c@denx.de>
Date: Mon, 4 Mar 2024 19:32:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: xhci-dwc3: Fix support for dis_enblslpm_quirk
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de
References: <20240302130951.4123405-1-jonas@kwiboo.se>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240302130951.4123405-1-jonas@kwiboo.se>
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

On 3/2/24 2:09 PM, Jonas Karlman wrote:
> No device tree in U-Boot or linux use the wrong spelling used in code.
> 
> Use correct property name as defined in dwc3 bindings.
> 
> Fixes: 062790f46131 ("usb: xhci-dwc3: Add USB2 PHY configuration")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Marek Vasut <marex@denx.de>
