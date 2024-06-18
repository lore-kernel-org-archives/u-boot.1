Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E50C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 14:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822F488356;
	Tue, 18 Jun 2024 16:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718720662;
	bh=FIDBeY5Bd29h+CWJ49o8lkLKCEjRyZX6haIz7hev5Ao=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eOPdzqsmx670o2njsVVe8BL/5p0EeCKPh3nAMMP5iSaoZYxQZXghJuh0/MzJf+gPy
	 m3uyOdyw/CxmcmwirTBjb5PK1xvYwO9RmYq6XXS93Z17Vl4MzGh5kGCUfAPCPu3u/A
	 9Repn1XubyufFix9xQG7CFuIPoqM5Ooa3pot4T4Q/XEobM6QF8mTdH8SLC7h0IjNCs
	 dhujCLyEvJToZ/0XROPssR/mDjgpZgL7CrGbHtS7yYJ97rB5/vpQagRGFdvLv/DlAt
	 Yru2WJ8YSGqUZvhPsgGRr2Q1Tqd6d6VEKh8Iy7c3332r5xkmBH5UwyjpxSH711Ch+Z
	 mUaYS++toF4QQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E6288354; Tue, 18 Jun 2024 16:24:21 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73CA588356
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 16:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4W3TXK0rKPz9sS4;
 Tue, 18 Jun 2024 16:24:17 +0200 (CEST)
Message-ID: <ad5a90dd-5264-4f02-a920-542e5af67288@denx.de>
Date: Tue, 18 Jun 2024 16:24:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 12/20] cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
 <20240612160053.GS68077@bill-the-cat>
 <49522625-8663-4102-82aa-cabc0f239afa@app.fastmail.com>
 <20240612165048.GD68077@bill-the-cat>
 <e94995af-f9dd-4262-8dfb-2c47ab817e61@denx.de>
 <20240617232904.GL68077@bill-the-cat>
 <c50b3dc0-0385-4548-80ed-ffdc8623bfcc@app.fastmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <c50b3dc0-0385-4548-80ed-ffdc8623bfcc@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W3TXK0rKPz9sS4
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

Hi Jiaxun,

On 6/18/24 16:00, Jiaxun Yang wrote:
> 
> 
> 在2024年6月18日六月 上午12:29，Tom Rini写道：
> [...]
>>> Acked-by: Stefan Roese <sr@denx.de>
>>
>> Can we please get either this, or
>> https://patchwork.ozlabs.org/project/uboot/patch/20240524210817.1953298-1-rasmus.villemoes@prevas.dk/
>> merged for master? The number of false negatives in CI due to this is
>> big issue for getting more contributors to use CI. Thanks.
> 
> It seems like CYCLIC doesn't have it's own custodian tree.
> How are we going to handle it in this case?

I've already pulled this patch. I introduced the cyclic framework
some time ago and as it's closely related to the watchdog stuff,
I'm currently handling these patches as well.

Thanks,
Stefan
