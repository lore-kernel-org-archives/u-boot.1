Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81D2C83F27
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 07:28:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A5AB831B4;
	Wed, 16 Jul 2025 09:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1752650881;
	bh=S6Sxbvdx9eHGkXd/1vgNMt8x7yAE7EAYjczIY6/aUdo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=e6UZYIwmC2Yf5gF3YIPLgQUZBL6wyXeXjR1gCWTU9LTppoOyILBEROZmzXT2NxW5l
	 sAfz9zf2surF+WmTei5TkulKwJW7I5haZqkBDDRQtzRkTZSPdBOtdALQG2FMABn2P7
	 SDuM+tAirMHlAbmVC7Uq6gRJ5YJ/DA9z3+D7z/bMC7TJn0YRoa1X47XRJbo1wQRglY
	 zTPVsCgggg4ikcEWepRbXto5aveaz1lKE8Ujf0MZFbEJ4RtCsFlcxXQe+HkEhD8ENM
	 O+Ae1vALiZKCu7QszSkaS/urr9k5H3UBaZWmmgBJedQxscbCXPkc5H+G+vQaFWVVwk
	 i5gWvdRNU5WNw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A252831C2; Wed, 16 Jul 2025 09:28:00 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F788319A
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 09:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="J/WU20Mx"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ABF6010397286; 
 Wed, 16 Jul 2025 09:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1752650876;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=S6Sxbvdx9eHGkXd/1vgNMt8x7yAE7EAYjczIY6/aUdo=;
 b=J/WU20MxzynXO4Rr1+ClZ6+2bgp5qyf/GJMMfeypXLlvir5/HWQsLOfLj0AFIg6317Z0Gc
 tpslTmpoe7jj9VBixcL+XYBcTaHqxK8tfVEuXRu+6WSgglOF/vNJJ2x1aakl/GYtEt9zd7
 QeAYNL/Gho8Oth6t3qpiMEseiWH3o+GCscYJqb1e4LUKgJngflNiwfnv4AEkhdl1tGJV01
 ZI5z0kY32JAGFA9OhGW1q7OnlBQR0LsaTdcEkQjyrYG9PApQHkiFMwz7dY1HwVk3m3ZC+u
 g6Uctet40J8N/cJZqRZXTWJpOZj0laOp1szvEVI9GFAji8aQjNqwCyXg98IRAw==
Message-ID: <68f95dc4-a1fb-256d-7911-38bfddee6e6c@denx.de>
Date: Wed, 16 Jul 2025 09:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drivers: i2c: designware_i2c: Remove clock disabling code
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250701045218.8403-1-nareshkumar.ravulapalli@altera.com>
 <a18b47c1-f872-4364-8c14-f18ec6d59384@cherry.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <a18b47c1-f872-4364-8c14-f18ec6d59384@cherry.de>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Quentin,

On 14.07.25 11:59, Quentin Schulz wrote:
> Hi Naresh,
> 
> On 7/1/25 6:52 AM, Naresh Kumar Ravulapalli wrote:
>> When i2c device is removed, l4_sp_clk is disabled; this would cause
>> unexpected behaviour for peripherals still running with l4_sp_clk.
>> This patch resolves the clock issue.
>>
> 
> Shouldn't we rather have those peripherals enable the l4_sp_clk as well so that the refcount is 
> higher and the clock can be disabled whenever there isn't any user of that clock anymore?

Yes, thought this too... Naresh, could you take a look at this, please?

Thanks!

bye,
Heiko
> 
> Cheers,
> Quentin

-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
