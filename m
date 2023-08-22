Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6C8EE49A5
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 21:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E68E1864A4;
	Tue, 22 Aug 2023 23:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nkSi/N4q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X89laLvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E65A864AC; Tue, 22 Aug 2023 23:40:12 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D59864A1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 23:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RVjSB0QFnz9sZJ;
 Tue, 22 Aug 2023 23:40:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692740410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qFnXZsL/0Q5KEH7/yf1WxTqjhZ0NHDJJsa7ZVg7wJeg=;
 b=nkSi/N4qC1ixL768fzMs3LqBd74ed8IfCUDOenJGicwRDL5kWzWKcFe99N2RN8IhtfSZ/E
 ccJsPtRfRxX1EG+VwTi/0583SPo+n0nS3hWmGpihU/C/+g3+QXCBAdkQ5wZ1hJurUb6fua
 f/jYHJWgLr6s0hNUhCqhwRtAU4EAJdJ+WpCKJmBNueh53vo5OkO58/1/XJsN9zm5jVyEhu
 9h9vffvdwhWzJkprDjU+12zWEQty8yMz4TEJMnRhW4+CMQxGGM1fRtOnLu6OoJ1m3b5uyb
 hbprvOQ9YASie3YjcwadhoUKL534/UGvG4pe9cwvmYfGIimQImVsuJdy1/GCzA==
Message-ID: <0b3dbe70-c0ae-9b83-1983-520b4c7df41b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692740407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qFnXZsL/0Q5KEH7/yf1WxTqjhZ0NHDJJsa7ZVg7wJeg=;
 b=X89laLvqcW6MkvB8WvtEaX0LIvK6oYfZDZCkYtV70E2qScOCS0Ff4mZebCfkAFGSRoQMB3
 oaeUh3WGnfi1/jtkGG7K91nylk5pCzvJCMlIH6COCAeiq6Cb/BIS2kSAljEjPKUd9B3RAg
 kKEec++ff0a5rXJ4wvp/fGAVOGI8yVEWm4BqEmudejnYX2qA3o6S7MF5sOa3Tngq45AXwe
 VXDxhAcc/JbNQoP78lYjT4jM/ZRQI9VJVSLW6az+7jiwhMgTJniO9Bwf3tdysAxEVzctuF
 mFH+0C2PMSkCvKDeKef+whatWP1awv2SeTRIsfaTMbcAvyiOGK624mvgtg7DWg==
Date: Tue, 22 Aug 2023 23:40:06 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] serial: sh: Tidy up pre-processor directive
 indentation
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
References: <20230822181025.339748-1-paul.barker.ct@bp.renesas.com>
 <20230822181025.339748-3-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230822181025.339748-3-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bs4kb1wasgcqoknhxennh3g5dhbtt785
X-MBO-RS-ID: 2f17fc07243faab5a0b
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

On 8/22/23 20:10, Paul Barker wrote:
> Let's make the indentation of pre-processor macros and conditionals in
> serial_sh.h consistent before we add to the confusion with a new SoC.

What exactly is this patch doing, adding spaces to ifdeffery ?

I would be tempted to say, can we clean up the ifdeffery instead ?
It is some hideous mess.
