Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9615AEA8109
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B1BF83DCB;
	Tue, 10 Feb 2026 13:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=minlexx.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="NssfwZjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6331D83DCB; Tue, 10 Feb 2026 13:43:08 +0100 (CET)
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9829A83D6C
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 13:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=minlexx.ru
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=alexeymin@minlexx.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sF916qyDIbqvNxQaKV0YWkYtV6o1ZPwEQhNpYKDrN3g=; b=NssfwZjY/pWufLf/1QtMOYaBmd
 /Y6DZtKKI8PG0lJWVfjtLoHHa92/Ae74bAl/dcS4C53eLhw0TP/9uj93zOeWoLajmvp3zSocpUiaZ
 HwalP+k7i3oWWPJNnsht8iRrz9uAAYfgWC2a3+0JHsb5yXk+PBWy+4aS7GRzyAgJ3JcE=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_128_GCM_SHA256 (envelope-from <alexeymin@minlexx.ru>)
 id 1vpn50-00000002Kcq-2deU; Tue, 10 Feb 2026 15:42:58 +0300
Message-ID: <39e525d7-0145-47a7-a739-b2b4c68f6801@minlexx.ru>
Date: Tue, 10 Feb 2026 15:42:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] Add clk and pinctrl drivers for SM6125 SoC
To: u-boot-qcom@groups.io, Biswapriyo Nath <nathbappai@gmail.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20260207092845.10421-1-nathbappai@gmail.com>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20260207092845.10421-1-nathbappai@gmail.com>
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

On 07.02.2026 12:28, Biswapriyo Nath via groups.io wrote:
> On Wed, 04 Feb 2026 16:10:51 +0000 Biswapriyo Nath <nathbappai@gmail.com> wrote:
> 
>> This is still RFC because micro SD card does not work with u-boot but it
>> works in Linux. I do not know how to troubleshoot the issue. Any pointers
>> would be really helpful.
> 
> I forgot to add the error message. Here is the output from USB serial.
> 
> => mmc list
> mmc@4744000: 0 (eMMC)
> mmc@4784000: 1
> => mmc dev 1
> Card did not respond to voltage select! : -110
> 
> Thanks.
> 

Hi!

Is card detect GPIO set correctly for board?

Maybe you can verfy card detect is working by repeating the command:

  gpio status socXX

(where XX is your cd-gpio) while inserting/removing the SD card.

--
Regards,
Alexey Minnekhanov
