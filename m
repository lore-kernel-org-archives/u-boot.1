Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182D2C282DE
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 00:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90CA381335;
	Tue, 11 Mar 2025 01:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741653849;
	bh=s5Hs6ganju4ijw7vVOLFXv7L7uUl7jJGT+1EVY2QTH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q6u8eWidggTgnEP7HYC/0NBKp+qtOTzldk21OU+RoIC5UgI9cUipLV8zj/kh2aEFa
	 lhoP+3UDf3Jl7wGMU5ADhqjmmn0Im6AZyujcoFX81CxXyLZHRjFUsedPGnokV9TmTt
	 QDHt8SLxZSmpVLAgLu0BJmzeoXnJaFa7brjqXHPHT/RweBTcRyPkOtJxf8VGSSHSwS
	 dHtjEXqKmniLWjpl//KHhYf2UW30e0+v/LNs+pVNbmh0BoiFRTe5+kM913IVbfREBj
	 B7nm+pqKgSyhMalBg+uY2MpExC9GCH8k0h1HECvQfp+uuvIQN3ZLch3QEIUsFIeoEB
	 0GbCbr5r4X28g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78277801FB; Tue, 11 Mar 2025 01:44:08 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41DA0801FB;
 Tue, 11 Mar 2025 01:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SKzf+KCj"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3E080102A4CBD; Tue, 11 Mar 2025 01:44:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741653844; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=s5Hs6ganju4ijw7vVOLFXv7L7uUl7jJGT+1EVY2QTH4=;
 b=SKzf+KCjtvxtYCd6R7wbTXTEt7X8Ntp8J45VSVLk0liA+ey95bCpwaDfUv6RRuZpHt72zp
 gquc7yzaGSy9uIMzvnrFxI2cqCV6EZzfqvy+TGccFjTXsdfmXo6Yf6fbXDLm1jhKXbjNXV
 SFMTZK3WI5GL84vJPaaCC93Uk1wCBGBqv003S/jNliXo4CAQAODUknf2qBYfzqkL3lveHI
 vxSizPJEp9J3zyws4JjYSZh3k/7sfumAbP89YpX5v4GMxuL/kE1Mt6Uoctfn0X5Tlz2psQ
 M6n2mwbiS5RgiEWyR9i+Rjw9EmjcvUH5oUL0YQhqtQHpwVz+nltkwANq87HI+Q==
Message-ID: <5b90d598-8b82-49d1-aba1-c6e70ba447c2@denx.de>
Date: Tue, 11 Mar 2025 01:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] U-Boot v2025.04-rc4 released
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
References: <20250310233215.GP2640854@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250310233215.GP2640854@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 3/11/25 12:32 AM, Tom Rini wrote:
> Hey all,

Hi,

> So it's release day and I have tagged and pushed things out. This will
> be merged to -next shortly.
> 
> Continuing on with what I started after the -rc1 release, we had a call
> today and the link was
> https://calendar.google.com/calendar/event

Maybe it would be good to inform people BEFORE the call rather than 
AFTER the call ? I would've actually liked to join ...

[...]
