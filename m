Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBE1FF885A
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 01:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B628468B;
	Wed, 29 Apr 2026 03:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ISkzoik7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NQ0TPeyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB9CA846AE; Wed, 29 Apr 2026 03:07:57 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B3B584682
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 03:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g4zgZ5wb3z9tpl;
 Wed, 29 Apr 2026 03:07:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777424874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OsKeCIo+B/UTRGBOBFGF7svpnWjPb1P2uebOR/ehfLw=;
 b=ISkzoik7LAoMKDM9OeyR1ZPSxBkmWyvYzupq2w/XBXXFLE48Zx6wLcw72a4FlYl3TfrMir
 DrWdiNS/eB9hovCEyyG4BZqjbSoF85866wDJz76vsFUcMJ2v+JqPxD8YLPH9WBxHm7sL+s
 d5rUvu0R6mgHcej203+PJgS+/59VjCad6yQ+oaRs6brddknaJD0E3b6X4VGjTI1bZQN6cH
 vi/kVXQ9tQKGOhjhx26rRZUUksUaXaXv4IXWxuB/3VOe/0aqTVUJg3PhkT40PY7hnjpadx
 D99PEhVegQ1g1CUOTB8QG/y8eUAGJYJ40QJSnQem3FTVL0TS2o398FTEzEgu/g==
Message-ID: <e9f8c60b-14e2-4802-830d-fec933bb7200@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777424873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OsKeCIo+B/UTRGBOBFGF7svpnWjPb1P2uebOR/ehfLw=;
 b=NQ0TPeyd8xiVOFP3ugbToXG/c4ShOn9GuDtelgshA4KYzj+3TeArIBs7093blRYYB6qKh5
 JAzQsEINenqXT90V8m5OPaEiZ1YpECALCHXo1JRAkKczxVmEZj0JNNFoVZUtE6GcdmFIL3
 xFFQ1ejrQTCBBIMod8hV/2QrW7dfrRFeMaeG6JxUsW/riWSWtHuTKdCMkB4oZVOki49CO+
 ycoAJeltN4E9W1YcKeI34AdX1ZIC8lRm6k1YWiKfkCBEy10bWNNI1Bzbn1lx99hfKC2Q5R
 8nNiNzxXQzlnD2BaKFJDZSZ6hgzjPn4/fTSkvxQktMvaf7O0YvcyJXobltYiww==
Date: Tue, 28 Apr 2026 19:26:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] test: wget: validate URI for lwIP
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>
References: <20260428-wget-test-lwip-v1-1-f611cea0c5ee@cherry.de>
 <fcf60081-849c-420e-ba7f-fbaed44ab108@mailbox.org>
 <a2c89eea-b74d-43d4-b2e3-e2a80875a2e9@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a2c89eea-b74d-43d4-b2e3-e2a80875a2e9@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8rhd91ds5y4obbgatrty1aspnihi3aec
X-MBO-RS-ID: 3c7516cbbb82ce95210
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

On 4/28/26 6:16 PM, Quentin Schulz wrote:
> Hi Marek,
> 
> On 4/28/26 6:07 PM, Marek Vasut wrote:
>> On 4/28/26 5:55 PM, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> We've had wget support in lwIP for almost a year now, so let's do *some*
>>> checks in the form of validating URIs.
>>>
>>> The other test in test/cmd/wget.c currently requires structures only
>>> defined for CONFIG_NET_LEGACY so it's left out for now until someone
>>> ports the test to lwIP.
>> Maybe this should be an RFC until it really completely validates the 
>> wget command ?
> 
> We can already test something, why wait for everything?

Because this gives the impression that wget is equally tested for both 
legacy network stack and lwIP, even if it is not.
