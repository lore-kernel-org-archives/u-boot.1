Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B226FCA1013
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 15:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 474CF81E13;
	Thu, 18 Sep 2025 17:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="elLvVA39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 989F08319C; Thu, 18 Sep 2025 17:06:53 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8474F80B9B
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 17:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cSJrT4RYHz9v5D;
 Thu, 18 Sep 2025 17:06:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758208009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4mW5kBJz03x/CcfyYb8DcttFUpWr5pNz5QDTwbr99g=;
 b=elLvVA39Q9m5oVf096I0D+ZAOTzlmzBoZj3qYG9CE4liSgBMeoQQ5Y0MDpsp9j/ubYqZv7
 mRztt5wkObJAZcn8Ke7rcfBAknYDawZsqdyRFQbHQTcq7t8umXWbCXAKzvneTKLCBKAL+R
 wHMag+VmP2fAPRK/LdaRqoytFiFdmu5sAvG+Z2j3EDF9tJ2TeJLK7GCgymVdFetWCVYSWL
 cSJJK904CvnMjZLd4QcwoDY7BPQzNIHdHcoWuQymuJxfM6lGkMAXdqvVA5HBb5NiOh9tpY
 8yNyE1exNqy2o3l1JRfEREbdDV4O4dRw76nKgfCvL+IR5XtVVYwu8jlGYBa90g==
Message-ID: <e66af909-d82b-4f4e-aa41-99a043abee76@mailbox.org>
Date: Thu, 18 Sep 2025 17:06:46 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] board: rzg2l: Do not expect a DTB blob from the TF-A.
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: anton.reding@landisgyr.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Tom Rini <trini@konsulko.com>, Paul Barker <paul@pbarker.dev>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 u-boot@lists.denx.de, Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>
References: <20250918124827.5577-1-othacehe@gnu.org>
 <173f12da-c201-4272-83a1-f70f2d4ca47b@mailbox.org> <87cy7nhlk1.fsf@gnu.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87cy7nhlk1.fsf@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9994bb32e019b55c311
X-MBO-RS-META: hy9cdr85fzobpzznfwx8kafnkzub5q43
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

On 9/18/25 4:39 PM, Mathieu Othacehe wrote:

Hello Mathieu,

>> magic validity first. Is the magic actually valid in your fail case?
> 
> So to clarify the situation, the mainline TF-A does not have RZG2L
> support. So the only one available out there is the forked Reneasas one
> that I have mentioned up in the thread.
> 
> Now, the mainline U-Boot is doing:
> 
> --8<---------------cut here---------------start------------->8---
> 	void *atf_fdt_blob = (void *)(rcar_atf_boot_args[1]);
> 
> 	if (fdt_magic(atf_fdt_blob) != FDT_MAGIC)
> --8<---------------cut here---------------end--------------->8---
> 
> unconditionally, with rcar_atf_boot_args[1] being NULL as no arguments
> are passed by the forked Reneasas TF-A fork to U-Boot.

Ah, thank you for clarification, now it makes sense.

> I could test for NULL pointers as well, but I thought that getting rid
> of that piece of code made more sense as there are no TF-As out there
> passing such arguments.

Hopefully the RZG2L upstream TFA is coming. When it does, it will likely 
pass the DT which contains various reserved-memory {} nodes to U-Boot.

Until then, I think check for params that are passed in being 0 is the 
right future-proof fix.

> If you think that it will be better to take the problem the other way
> around and modify the forked TF-A to pass that argument that also makes
> sense to me. Picking one of the two solutions would allow us to have
> something working out of the box.

No, because we cannot depend on the fact that users will update both TFA 
and U-Boot, they can update U-Boot and keep old TFA.

>> Also, enable CONFIG_DEBUG_UART in your U-Boot config, then you will get very
>> early UART output capabilities, it works even before DT is used.
> 
> Noted, thanks :)
You're welcome.
