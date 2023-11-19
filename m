Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F31C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 20:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3595787483;
	Sun, 19 Nov 2023 21:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eSVtIftl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XE3hpKE8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93AB687483; Sun, 19 Nov 2023 21:10:25 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C545F86F80
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 21:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SYMFW3fS3z9sqP;
 Sun, 19 Nov 2023 21:10:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700424623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXGXUMVEwzmfBHmMJEUS/VKDqa/dhUISg6lM3bJ2zgs=;
 b=eSVtIftlGifUlM49aC4aVq4fkSI+AR3+1BQyPnecPMOcNe+Q2xNMIvHN1OT4uHRW6tPC9d
 D72j53Sqshllz4liDCyJevSyVXfz/3M9m/B2/kMYuErT38yXom5XAXyAhpjYyW+yUJGrXw
 4Ggxya6+9WHuHl5X4eKywanVZesGl6oW8AtF90VPTIf7cox72ABz48Ckxu+R4vhB3Pqg0O
 dRZyGuaj9xr72JBqRq34eQACSHUSSOO5s8aXImCKpIDzYleypYVEUzadV3jFfpRhIlaQs1
 a4OQDFow1dZvBKDSq0a4kw/8j7WylW848uArwpmZYrgoqxXyD2iXYA6CgCEHtg==
Message-ID: <ac3796f3-19aa-4683-a92a-993260dc6a7d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1700424621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXGXUMVEwzmfBHmMJEUS/VKDqa/dhUISg6lM3bJ2zgs=;
 b=XE3hpKE8gw8gd5Qn1Kmiq3iTnWavJogmHwgGfp/vw1CKF3xMwxqhN55V7utZDR3+i0SzKS
 +SjynkA8bqtTDahESGcOR+cCYPfqJNTBxlImFolaPaQ/Ofj/6S34zBuS87NP2fAbM6hDVj
 zrW5ovrlm9bxdmhGHZpRxCzLyPv3N3Q9v54Bm2cHMakFWPC6VbVHHC5QPVieRdmIO9I2pA
 8EB0zocSBeQ1oSogP66+8qS8F+5SfskwcVyi3KnjJvbwC9Sx2D4R7ouY2RgADc3UH6UXsI
 IOzG41SbtoR4+zsiddY8qfB9uOWOS1odDuz3YeD4nvy68ekBpeoe9ZoWmlpNTQ==
Date: Sun, 19 Nov 2023 21:10:19 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] clk: renesas: Confirm all clock & reset changes on
 RZ/G2L
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
References: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
 <20231115174025.12974-2-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231115174025.12974-2-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rt9xrcsgzbr493o13hdyrx33cs4johuy
X-MBO-RS-ID: 62507f1cb3343dc94bb
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

On 11/15/23 18:40, Paul Barker wrote:
> When enabling/disabling a clock or reset signal, confirm that the change
> has completed before returning from the function. A somewhat arbitrary
> 100ms timeout is defined to ensure that the system doesn't lock up in
> the case of an error.
> 
> Since we need to dynamically determine if we're waiting for a 0 bit or a
> 1 bit, it's easier to use wait_for_bit_32() than readl_poll_timeout().
> 
> This change is needed for reliable initialization of the I2C driver
> which is added in a following patch.
> 
> Fixes: 1918ff5c95be ("clk: renesas: Add RZ/G2L & RZ/G2LC CPG driver")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
