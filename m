Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3F8FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 16:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD4A78407E;
	Sun, 26 Apr 2026 18:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h6begD0z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qoT4v4l9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C25E840ED; Sun, 26 Apr 2026 18:21:11 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04EC683FF5
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 18:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g3X4f1RRcz9ttB;
 Sun, 26 Apr 2026 18:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777220466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EsxO0jzDPqunxzVm4JIq+DzQpxjZBgbwSgxw7pfUCBA=;
 b=h6begD0zNCVaNwzQu3qu4ByajfkB8tzEtEyJyyLXK0JKHF6KmJ1jhVxeyVU9lWvjf6dVAN
 p4rcTlsMgOyEF6YKgsCg6/o2KL/DCX8Bat+I9fevU/b6T9UC3+OBzuhvW3EMj789lpBpdB
 bl7o77SYAU7n0u6mFAokFEXoetNw8Dwj7Udlwx+nSitYPx3LjVSjMNojodHfA1+EDo/s92
 MgfCt8XPylHir0RDdvXj8U5MyrU1YUalo+gP2lMssL5enad0ZcfUyBf02uf2iVjfMttMbA
 Zt3lSy4kYNv5wiGYsPQR6DN17mrHqQYa2gUNFsXC3Ko1qrwFsTjl1Ne8GERO7Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=qoT4v4l9;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <cf943303-9f48-4cb0-b055-0c2115fceeac@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777220464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EsxO0jzDPqunxzVm4JIq+DzQpxjZBgbwSgxw7pfUCBA=;
 b=qoT4v4l9t/13+RkDUTeOrckN75I9siAJ51CTkyRXLHjvCk2yh8Vk2I9FMTJclCI8iVCaRM
 +qdm7glK+YruR1W8x4viWs0bqWhVLddXgWvBqMOFAuRAKG/iMfQJrszLvB2qfgHdtXnEOp
 ivebpmLIEVksRvbsbO6fftJahjxwp7gNhTGP+HM3/y4BIsImnLAO+a0wmswHXBQInecr9z
 DvMH0A1fFK1r39BdXahE3ZVJcEe5AkvI08CKpYW8kj1t7j5f5ejjNTMdxj+DupnNkrQA0K
 HW5aqE65nUfSJPGZQhG/mfjn5yyBf+i/NpHQCSal0CZPE3VzNtx8c54lbW/yHA==
Date: Sun, 26 Apr 2026 18:20:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] fit: dm-verity support
To: Daniel Golle <daniel@makrotopia.org>, Rasmus Villemoes <ravi@prevas.dk>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan
 <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Benjamin ROBIN
 <dev@benjarobin.fr>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, Jonas Karlman
 <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>,
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
References: <cover.1776302805.git.daniel@makrotopia.org>
 <87wlxxltnc.fsf@prevas.dk> <aeocicfRVu7NuC6T@makrotopia.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aeocicfRVu7NuC6T@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: u884pidrdf9qdqwf81bahzuk4jmqmync
X-MBO-RS-ID: 71f1de9f011e37d1509
X-Rspamd-Queue-Id: 4g3X4f1RRcz9ttB
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

On 4/23/26 3:20 PM, Daniel Golle wrote:
> On Thu, Apr 23, 2026 at 02:59:19PM +0200, Rasmus Villemoes wrote:
>> On Thu, Apr 16 2026, Daniel Golle <daniel@makrotopia.org> wrote:
>>
>>> This series adds dm-verity support to U-Boot's FIT image infrastructure.
>>> It is the first logical subset of the larger OpenWrt boot method series
>>> posted as an RFC in February 2026 [1], extracted here for independent
>>> review and merging.
>>>
>>> OpenWrt's firmware model embeds a read-only squashfs or erofs root
>>> filesystem directly inside a uImage.FIT container as a FILESYSTEM-type
>>> loadable FIT image. At boot the kernel maps this sub-image directly from
>>> the underlying block device via the fitblk driver (/dev/fit0, /dev/fit1,
>>
>> Can you show me where that fitblk driver lives, because I can't find
>> anything like that in the linux source code. Grepping for 'fitblk' or
>> 'dev/fit' turns up nothing.
> 
> The driver is currently downstream, but going to be (re-)submitted upsteam.
> See below for more.
> 
>>
>>> ...), the goal is that the bootloader never even copies it to RAM.
>>
>> Hm, how is that achieved? I.e., how do you load and boot the FIT image
>> without loading that part, but still reading in e.g. the kernel?
> 
> The next series after this is going to suggest a way for on-demand
> loading only the actually necessary FIT images from a storage backend.
> See
> https://github.com/u-boot/u-boot/pull/870

This should be posted on the ML, see .github/pull_request_template.md :

"
Please do not submit a Pull Request via github.  Our project makes use of
mailing lists for patch submission and review.  For more details please
see https://u-boot.readthedocs.io/en/latest/develop/sending_patches.html
"

That said, U-Boot SPL already handles on-demand loading of parts of 
fitImages generated with mkimage -E (fitImage with external data). There 
is no need to reinvent the wheel.
