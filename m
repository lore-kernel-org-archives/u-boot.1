Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3671C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 16:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 563D76080B;
	Thu, 20 Aug 2026 16:36:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0H21LTS8uSpH; Thu, 20 Aug 2026 16:36:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787243808;
	bh=N6V8BHbIDRoamxDzIwO8MMXH6sC0Qrrpv8zkZuTp+Z8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxTgslkRDvfT8Ej5+n/h/APt6aECicg4GwU4zMHtBaSHmOXWLANauUJ3goYQ4WiAd
	 AHWdItaNVejqB/Xdne1MyTXBVKWE/EexzP5tFJ3ec+dNbfIfO0HUfp9TqZt8C2hLdk
	 beA43gD3nIobKXoixfhbx8vzi7d6fqJ5xGyeG4oelYVf5JHnW9bvjl0sWo6BA8t5ty
	 GcvGEwUCZRehQ4tIVK9yVYK1rUp6qHru11sO9kOijvFdME7S9M9vC/etw6VlFABhLQ
	 dIUAAY0tPX0UCCy1c9WSGPUQ6X8XU9EPvlamBJbUumTLBgGgK8GPTyGJZE994Sa/U1
	 pYogitolFqZ/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A499B607EF;
	Thu, 20 Aug 2026 16:36:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B1E33A4
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 16:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01F8380E65
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 16:36:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cep6IwZjHEno for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 16:36:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=4da3=go=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=rTnCxvuG
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21BDF80DFC
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 16:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1787243805;
 bh=N6V8BHbIDRoamxDzIwO8MMXH6sC0Qrrpv8zkZuTp+Z8=;
 b=rTnCxvuGUAYZYn3Wl70uE/VDP9gKo7XajnwxhFTo/o0/1r5V96HcVUlZA22fqKcepoWiuCec6
 1yFw5gcGdRP1qMgTQa/5prM9YmXjWR2yf8hSk+BjFapgYJ1z8b2iwh9wdUd2fqS8thM5ZTyQeE1
 uivOjsztuJV43mLmOIo6tZojWI6usQNWZm3Z+xbdQ7TBEdWJ/AmW+6M+ZAL0r/nyRwVjFpFWaaA
 ypt9jzSmVSUUDF3kE4t7PeH3iBW2LJGB/JE4dElKixtQ2SGxcypb68Bm1GMMgEwYV4lzQb928r9
 HzVkGGaDnYB2YPMzMj8/HIew/bjoUp+8YO9jFx0B6S2g==
X-Forward-Email-ID: 6a872d19d7a990f7b6f27540
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.16
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5328ff1c-2b50-42e2-9137-9e5f6720c345@kwiboo.se>
Date: Thu, 20 Aug 2026 18:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] arm: rockchip: spl: Add hotkey detection support.
To: Valentin Liu <valentinliu@icloud.com>, Quentin Schulz <u-boot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>, u-boot@lists.u-boot-project.org
References: <20260818165526.764686-1-valentinliu@icloud.com>
 <20260820162757.665777-1-valentinliu@icloud.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260820162757.665777-1-valentinliu@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Valentin,

On 8/20/2026 6:27 PM, Valentin Liu wrote:
> Add a configurable Rockchip SPL hotkey feature that checks the
> serial console during SPL startup.
> 
> Ctrl+B can be used to enter MaskROM mode and be widely used.
> Ctrl+D can be used to enter Loader mode, Ctrl+F for Fastboot mode.
> We can add more boot mode support in future.

Why the need to have special hotkey handling in SPL?

I would rather see that we extend TPL/SPL/proper with support for
reading any 'syscon-reboot-mode' reg and act according to that.

Also think there is a series on list to extend the reset command to
accept a reboot-mode.

That way we would be able to reboot from OS or U-Boot proper into
maskrom (or any other) mode, instead of trying to implement platform
specific hotkey handling.

Regards,
Jonas

> 
> Add CONFIG_SPL_ROCKCHIP_HOTKEY to enable the feature and wait for
> the serial port to be ready to receive input before checking for
> hotkeys.
> 
> Signed-off-by: Valentin Liu <valentinliu@icloud.com>
> ---
> Changes for v2:
> - Simplify the dependencies of SPL_ROCKCHIP_HOTKEY.
> - Remove the conditions for the newly added includes.
> ---
> Changes for v3:
> - Add a dummy spl_hotkey_init() to avoid undefined reference errors
>   when building without CONFIG_SPL_ROCKCHIP_HOTKEY.
> ---
> Changes for v4:
> - Add condition of CONFIG_ROCKCHIP_BOOT_MODE_REG != 0 to prevent
>   SPL hotkey be compiled and used on unsupported platforms.
> - Add more hotkey support (Ctrl+D and Ctrl+F).
> - Remove prints on the standard path.
> - Add some code comment.
> 
>  arch/arm/mach-rockchip/Kconfig | 14 +++++++++
>  arch/arm/mach-rockchip/spl.c   | 54 ++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)

[snip]
