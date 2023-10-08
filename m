Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A86E95A86
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 01:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 668D286DF4;
	Sun,  8 Oct 2023 03:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="I+c0LPdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC5DE86DCC; Sun,  8 Oct 2023 03:21:08 +0200 (CEST)
Received: from mail-m127203.xmail.ntesmail.com
 (mail-m127203.xmail.ntesmail.com [115.236.127.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B83F986DD5
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 03:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=I+c0LPdS8CKPSlgd5vaiu+opad6agBdZaozRSY4GzGfd15qaqrCRwVJrB7chEF/6+Bl/KeoxorXoNF/Y4bHUHn1nmIU/R9YajN6JmfGwUqjCRc1OO6Ns/PSSo8/NUO8sPrwmVBhLGDHL0VEmXCsPs7r3bER7Y5HtN+yiuqinjtU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=rLIzmM2tJKy2/HCQ55FlJ37lbBIjnoRi9zEtBTiyvF4=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 742EA4001DA;
 Sun,  8 Oct 2023 09:18:23 +0800 (CST)
Message-ID: <95062a1b-914f-fa41-778f-c7b0a21a48d0@rock-chips.com>
Date: Sun, 8 Oct 2023 09:18:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 RESEND] mmc: dw_mmc: reset controller after data error
Content-Language: en-US
To: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, eugen.hristev@collabora.com
Cc: jason.zhu@rock-chips.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 u-boot@lists.denx.de, xzy.xu@rock-chips.com
References: <87y1gea460.fsf@tom-fitzhenry.me.uk>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <87y1gea460.fsf@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNIGlYYGhpLGkxNTRlIHk5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5JVUpLS1VKQl
 kG
X-HM-Tid: 0a8b0cdd2e042eb3kusn742ea4001da
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRQ6ARw5Fzw8Nh8zSw8XVjgy
 CUsKClZVSlVKTUJNTElMQktPSUhNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQ05INwY+
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

Hi Tom,

     Could you have a try with rockchip vendor U-Boot, maybe still some 
other fixes are missing in mainline U-Boot mmc driver.


Thanks,

- Kever

On 2023/10/7 22:37, Tom Fitzhenry wrote:
> I am able to reproduce this on RK3588 QuartzPro64.
>
> I thought "[PATCH v2 RESEND] mmc: dw_mmc: reset controller after data
> error"[0] might fix this, but after applying that, I am still able to
> reproduce the issue.
>
> 0. https://lore.kernel.org/u-boot/20230619103347.278004-1-eugen.hristev@collabora.com/
