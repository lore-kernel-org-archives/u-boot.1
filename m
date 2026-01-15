Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB78D3CC88
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 00:02:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A5B80325;
	Thu, 15 Jan 2026 01:02:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FdsLlagx";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TiSNQkyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0779F803F5; Thu, 15 Jan 2026 01:02:49 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1064B80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 01:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ds38Q5kddz9tJ6;
 Thu, 15 Jan 2026 01:02:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768435366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0mM//xGnQJkzE81izynnnRAt05LbL46KjKGdLIxdlc=;
 b=FdsLlagxk+XNMrYv7mlxlyvJW0OyEw3SeRYSBhK8DOD8KbSfZS9URaCk/tQyLMBTZM2jiN
 e5PbhGwKqTxcqiUqTAGnmoRMX6Jq0W1tgknsu0vnFjjWN75TiUtkNTmnQhsgtGWmId+BcS
 ijE++2AkWYqxkytpNLsZbWpueITcaEpkcnc8nmV2K7tEaaIynWIffjKRj9YYWJXU92xYC1
 Xb+JW5odIGCMUw0E88+CYZySJHji8suDvWyUInQKu7iM7wJF+/V1Hi03Ycxr04fyK8Kuth
 7od7Oy6KnzRr/Sdul+Xd7EiuvTA8zL/amQfd7CfsEPJATotzmKBAG1QJ638xTg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=TiSNQkyR;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <7f1f7601-23ec-4a36-8e2b-3b4b679da6aa@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768435365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0mM//xGnQJkzE81izynnnRAt05LbL46KjKGdLIxdlc=;
 b=TiSNQkyR3gbDuVKQc+fNCIaPbldOjvlnGVBfyKMVLkbNKzuRlAW2uQcaoGKfu4RbHCjBUx
 rPuyxojVq8nMcbAMraO81ILD9fwlzIDpG8YfoMDEDJ7oyNBytHM+bcUxtcUcGucE+V3nUL
 e+tFcOhrlAEQyoqHzLSG/4wVC0da2Gh5fKoLGQys2rAvdneyJHSvBQbTSwI505hBAakHfP
 6B8fWgURpbLgCSpBfmOZjzwXzFIty9qsRtgqhbth2ibmkRN7Hp+Kvf7X7ZQO+qaLbfDEKQ
 aWWZyDSeZRRVgvGhQQMaofJi0Ufwsxr5CpYnKS6jJyDxcFU1ygxa8GZcoLy8mg==
Date: Thu, 15 Jan 2026 01:02:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
To: Tom Rini <trini@konsulko.com>
Cc: Anshul Dalal <anshuld@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, marek.vasut+renesas@mailbox.org,
 james.hilliard1@gmail.com, afd@ti.com, nm@ti.com, vigneshr@ti.com,
 n-francis@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com> <DFMMUHPP8BW8.3M5VVTPEB9IZL@ti.com>
 <20260112164854.GQ3416603@bill-the-cat>
 <8eb4eeea-a755-4032-ab95-2b293f2d2289@mailbox.org>
 <20260112220536.GU3416603@bill-the-cat>
 <66ec9e5b-1488-4e35-9a56-91d4b70ff0fa@mailbox.org>
 <20260113150024.GX3416603@bill-the-cat>
 <bbbb72e7-a7f5-48b0-b3e2-fcc83d5b1658@mailbox.org>
 <20260114141735.GA3416603@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260114141735.GA3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bxwpdxzmzjk1bcxbcmdbanjgdkt5efpp
X-MBO-RS-ID: dbfaa1e67c9a047c40d
X-Rspamd-Queue-Id: 4ds38Q5kddz9tJ6
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

On 1/14/26 3:17 PM, Tom Rini wrote:

Hello Tom,

>>> OK. And why can't we make that check at $sym rounded up, and ensure our
>>> build targets pad? Going back to the commit message here, it's easy to
>>> tell the linker to place $sym at the right spot, but it's hard to make
>>> sure the output is padded. So having typed all that, maybe we need to
>>> do:
>>> d) Update linker scripts to ALIGN(8) the above symbols and have the make
>>> targets use dd to ensure padding prior to concatenation
>>> ?
>> d) looks like what we should do, yes
> 
> Poking at this harder, I'm not actually sure we need to use dd at all,
> but we do need to fix our linker scripts, and then going back to when
> Ilias reworked and cleaned up a bunch of them, get the changes reviewed
> by the toolchain experts he got ahold of :)

I wonder if LD can always guarantee trailing alignment of the binary. If 
it can, then yes, dd would only be obscuring alignment problems and 
trailing DT look up failures which are hard to debug. It would be nice 
to drop the dd part, but I am not sure if we are able to do it reliably.
