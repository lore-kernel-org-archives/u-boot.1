Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF58CCF2CA
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 17:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8A84812D2;
	Sat, 17 Oct 2026 17:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V5Hv4XvN0ham; Sat, 17 Oct 2026 17:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1258D81326
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792258399;
	b=FwecbO7j9AwFsubOsEMjdB3ZoNwFuGG1uNhZ9iRNnZOfGSWal6/c9VaQkRgSEHGT949d
	 vINhU549icfLrUer/hXjdfbytOtXYSwmNkzfcc1o4dSTPugfYfa2SQ06I98vXLdUWCU/A
	 6Dayu1dgZ6Pp6rggyHegmowarYDeLRQcz5QI3cdqbj3wAdoRNUhi6JpVDXPZG9PH2xUUq
	 Tg5tRePMGRvQelRgmrrDPgvoOiw6KSF23ysm9zMb2yzX/ZcZVXwHvKcU0i8arEjlO3TLp
	 QgfUD/muo5uyDN7P5YmSi2GMMm3gYQpY+il7IEXFB0DkdDZIuYEgWB+9zKcfwlQGdxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792258399;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZgL5w7+5apUc/hDJoY+Yujv9Wyb5FL8ugcTefyHzQiU=;
	b=pbodGDpvkTdj/C7Vy84V5VHutdgtIcFaZ6c/o7+aHoWzmNNd2VfOT8xwF91QammMOxjG
	 65Y+7VTK/E4GyhtzxOjdNs5YmfhaJoWmiveZar6Fe9HIiDOZu3RiYWHz4e/IiASBA5Z+J
	 GTYqx/MGaupgZseIjYfNwPwk4bPhb6UyKUGHhBLXjFynhzI9T7TnMCQR1NFoT+UQ9VtYi
	 NzZEEhXLiT2O5GPvYS+dEe0dVJKgvHq04VOj0TZ1rGH4ywLsJj78Sj93r9ya+tZHgLwgM
	 Fo2XcGs7PbnVJ6PHap3zSSPa78eeG0BfxmQf7qj7E2yqsUTowVjrqaD1gmhZBdemKrg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792258399;
	bh=ZgL5w7+5apUc/hDJoY+Yujv9Wyb5FL8ugcTefyHzQiU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gF+Ot9hIBIaqzLF8iP1Rpb7UlXsXBtUgQ4qLisihAw/7e6oYeTKCyv6bJCiOYKod0
	 jIPJBe8f3+TwoUGPhb3SHWFaj8OYgsdN4O4tyK7ETI6OionVto/zVtriMZBVhq1dPC
	 r33gHf/ZBb9bZ8ioxRBv90FMJwEACamjgq8o0eoO/PhqTn/51do+0PIXojfJnNHfwu
	 EXtAKcy+WX0CZ4+mXG6opUg61Cc/CFyEsm2ypUJutdumSq5RHdhDcGhmExGbo2jEAy
	 fOCe9m4dopuvOH1dhrBfyrEhhLCVqk0pUycx2bDbdjrmU4OvsYHlHTJ/rj43nQuknl
	 mYYiDKk7JsAhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1258D81326;
	Sat, 17 Oct 2026 17:33:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B733A1AB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B503540846
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FBtAzW6Gm5pV for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 17:33:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD90140845
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792258391;
 b=hMX2XTIIZM+CnF1dHn3bqVJyu32V/6UIDzDmJCdt9QhDJjI1FHctWyjqLuoxsuESC0z+
 QNlKI+94euRpfOOKxOO9P1sVnbjvkbjBTYTKJQtXJOV4ucDXsNc2XZjpvV5LFMspa3sxm
 SYzhsf8rsXqWEXj0Rv7gn+IVQJcvaGUv2cSHT0X4efKl1ZUtN5tc3wuo6Rqcz+qIOzqd8
 RWpyiCxMFohZ0ZQ1aSezTQjCJ60Ru+mDoGwHhR+KhEVaql6uXMBbL+VRkPGLG+OqoDofr
 PNBDo6KSAx6P6Qx88wquIuEYtuRs3JFj/EAd4iXZZFuOekc36BpRWfuN5nPNuBw4Tgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792258391;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=ZgL5w7+5apUc/hDJoY+Yujv9Wyb5FL8ugcTefyHzQiU=;
 b=r6sOjyrS56szcGgebRqFVtKsdl3tHudeZzt5rHusibEVm49OYz5AuUy1xsRuI9knQ+oW
 6g+tUSCMLYPJ1kmFq9gan2J935kgd9cJG4Rio40sdxb48uRfHI0tYLunitF5BP3wnhdZD
 F+KAdNM259GBC+xmfXQZhbKhTFk32fFoQ1JMZYuq65kbC2oY8J3CwpI5ecz6ROjkFctau
 1EOnEmfQ5XDDu/XSPTVvLRBRNnjJfsYeWVOKeuGLlSXKDmFXcnkS7l0XRJTCGaQ/Y6nnU
 WlX6PyPv9u3A2ImDMCzcPzEjGmz71cHXt9g/7gf7+ZLc6F4F0/Dz9+p8dBO9AFIkOJw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=sLemhhW8; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=sLemhhW8
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD90140845
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 17:33:11 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j6TRQ61hyzMlhB;
 Sat, 17 Oct 2026 19:33:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792258386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZgL5w7+5apUc/hDJoY+Yujv9Wyb5FL8ugcTefyHzQiU=;
 b=sLemhhW8JgSEXhXiRC6v+va7pJ71Nq38AwVaz82U1Q4KAs5Ht8ept146YmJOnOokjeyh10
 PRIt/w4LDHj/v+LV+sSxi/tNlMlo5x/oBlINI/RvJpbyCSLcGxzjoeSwj/rGPo+JAkpNgO
 AHiX6/7489pLDkh17EYDDSNSd5WSZ1c8gEJ1A0tMWvuX9PZ7ecTkzNGHB3ETeX1pu2LpOg
 kp2mlhiaKut5nYR8fSyUkHZPMu75NkcE60PhMguHq6rqHjZ8v6N5ctGXbDY26oj6/rhvpZ
 z7bMbSnOI+FW0xQUNGTC0SJduATWfNpi55e48R6oT56hCu1PvQAWUPZMi0x46g==
Message-ID: <4b24f045-7fa1-4be0-8993-2bd441a7e716@mailbox.org>
Date: Sat, 17 Oct 2026 13:42:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/26] usb: dwc3: bring back the samsung usb phy driver
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@denx.de, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com
References: <20260916123826.517181-1-anders.roxell@linaro.org>
 <20260916123826.517181-8-anders.roxell@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260916123826.517181-8-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ce5db0399bf73d51003
X-MBO-RS-META: soi95xbg3bsajdmcgt1ydkskd11ss69f
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/16/26 2:38 PM, Anders Roxell wrote:
> The restore commit at the start of this series deletes samsung_usb_phy.c,
> because the file was not part of the original v3.19-rc1 import. It never
> came from the kernel, it is U-Boot code added later.
> 
> Nothing added it back, but CONFIG_USB_DWC3_PHY_SAMSUNG is still in
> Kconfig and odroid-xu3_defconfig still selects it. exynos5-dt.c calls
> exynos5_usb3_phy_init() from this file, so that board would lose its USB
> 3.0 phy setup.
> 
> Bring the file back unchanged and add it to the Makefile again.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   drivers/usb/dwc3/Makefile          |  1 +
>   drivers/usb/dwc3/samsung_usb_phy.c | 77 ++++++++++++++++++++++++++++++
Maybe this file can simply be retained and never dropped ?
