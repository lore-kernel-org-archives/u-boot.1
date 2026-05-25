Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55689CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E04258486D;
	Mon, 25 May 2026 17:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BmP+5lHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F25184881; Mon, 25 May 2026 17:03:26 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AEDE84841
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-67bb5ad91bfso19089701a12.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:03:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779721404; cv=none;
 d=google.com; s=arc-20240605;
 b=fK5ZPkDqT1boT7+8WoIH8Emy3LEIZOLgpFzux97bnwQLSuprlJXeSffsd+9UoHSj2s
 XfPUwKmCiid+cVZ3R6T9UuaAxQOR2l/zy5ekHALEeoAsKpDrisaqXCqq+jyWQHdzz6h6
 v+pWflYXtQ9xKGX2kDDOeJrAgkCw7ZMApQ3COrITEw+QJYb/iuA5H0z+b75wqkxbM+3M
 S1QKvDenUGqsICGLb3YbOQQC+KhMBlL7WS78xXuHN/q2dp3YDTET12lxShHhLP01zB/X
 D6drCaTUHzKgwRUQyaiJRUXot3kvW4XXPaTjNURiO3CmBjLB4QLcxi4YMr2TzHjmN344
 PXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m0u1HtoRYSm6UZ0ySyVQmfnNPU0+HBvkUlHIogQWsYo=;
 fh=uEwfVtgWmQ+BpqL3MMm4A4agCJ5OLHBunogpqm9TwOU=;
 b=NeLZwii3qQ+QJMdQm4DKQMe8W0oOp3UsKp7fR2VCN0Pkt2pNkVHHeCZNaw4o+MCJnc
 nbzF/ZvEU/fCHr2GzHJIF1wxcMyuF95sn8tNNTUxphCJVYMEy93BjpoCfsBhVAorsR2f
 kcZzamH5k1W3V2IjE3anEVU1xOtsRe3GJQssw7sSN8DpM7RXZ/EmMDjtQ6oFOS1hAKDJ
 TgPLrdkg5Rc0uAGjp/rDP50TByfIFp8+09Lh+RPix/NnX2jcJfyKxRcEjwUknYyhtI1h
 5voox92A1c1psokZxn7BOHVIkkfp2iP4260CVFa1hFwWOHCAsDK+T47zL5nd4PgrnBRO
 Gw6Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779721404; x=1780326204; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m0u1HtoRYSm6UZ0ySyVQmfnNPU0+HBvkUlHIogQWsYo=;
 b=BmP+5lHq447a7OznF2/FaM0KasfIiuwBNS8dpxrILWEuHLMilYL7NWdZaSYzFDG0Vo
 OOFxDC62mNgbV5/JWRq1MQmQDbIjsKqfH0Dxl4HQ1gS9KwjRkh67nc9KpzXWQAgjnZ1r
 DJuZIRbEgpwLQODBv4uusYGi+EFbSHYB0VoFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721404; x=1780326204;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0u1HtoRYSm6UZ0ySyVQmfnNPU0+HBvkUlHIogQWsYo=;
 b=bdusQr7C8eyNex99wBmWM+opiGDEJSiyKeUV/Zl/KhHSpej5pfb5IdGC26b1Dlvrm0
 9IxwBhxvIm/BzU6S5qqrKsQDhEYag8rHfRa7OIYAgN4HeEP+y8Nu2Q9gPqkfJ8y1lICe
 s0iyAbm/o2JStcuC4ZFMLhP+BnsIl1n9eE8HM6Qz5V9KW7T44tdGBpy63HtNnGctQzyu
 Bw7gwKpnw++TWyGioLn5e4YfJGX4GeC4CZ9lfgYMhZCSBNE7AAdvDAqg8/FMhBXxzgAO
 zu/X5acdUkdEzjFrlRJfRt16/qjDk8U9TYtpaY+VHqvPFUIemSR24heGvBAYR5C6Zmtm
 9x2Q==
X-Gm-Message-State: AOJu0YykXibyWqUlEpKNc3GC7SK6LrJoBswIPYmHKXSFrbrLUDc6GBqU
 MqDH6CDPmofSR+tb3UwWiEOs4rNEBb61+kU3zD4exlfFo5ohtwNDqJBb7QR6KULRwQAuvarcX/R
 CT0QpV0kiFC7tCiPUfJHWrAvchTE7jVfF12mSxTzi1HUpnq7ghDY=
X-Gm-Gg: Acq92OGdgpBnBDhOFd8CFzD2hdy5lMA2D5GxlcDeArKFYgxiY/vzJjg3LuhWaAph1vX
 9BNPkjnL7E3ceVi8gy5W/p+GZ3dHlzgmmKZlCooz7r5SlhmDYy36PaQ3Xk08nfzxba61fpLrGdk
 cIHBzwk7UiDr97YPjCyKSqBDFdwZ0knYoSvfyk0cOCyImTFIamwbsZJo7R1rRrvrtVwU1W4fvAZ
 EAR+sikUBk1N7kRyny1YiSFOQnI9oQKrHGyXngrWbvBrKuuj3QINplcz/aGBlyFp9pbAi/yyXnZ
 Tph9Uwsn6pVXSkA8k0m5HsW4IJg=
X-Received: by 2002:a17:907:94c3:b0:bd8:bb13:2227 with SMTP id
 a640c23a62f3a-bdd2293a46amr763172966b.6.1779721403652; Mon, 25 May 2026
 08:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-7-ravi@prevas.dk>
In-Reply-To: <20260522212756.3169222-7-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:03:11 -0600
X-Gm-Features: AVHnY4IccK2MApsh4LQ6kYojWpy_MBhdM8j-G78feSE92BUmEZl1WBBxwdUiHyg
Message-ID: <CAFLszTg2+hNfoBzMYiaSqad3G=JU40Qy+7oXXyUJxgH0Gk=Esg@mail.gmail.com>
Subject: Re: [RFC PATCH 6/9] linker_lists.rst: update documentation
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Rasmus,

On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> linker_lists.rst: update documentation
>
> Remove the initial _2 component in the examples in order to match what
> linker_lists.h now does. This also makes the
>
>   Note the two '_2_' constant components in the names
>
> easier to grok, as there is now only one such component.
>
> Remove the whole "Start and end symbols for the whole of the linker
> lists area can be defined as" paragraph, since that can no longer be
> done like that, and the (never used) macros doing it were removed in
> e2138cf1e60 ("linker_lists.h: drop never used ll_start, ll_end
> macros").
>
> Leave the occurrences in the "Alignment issues" subsection alone for
> now. They are verbatim copies from a u-boot.map file, and it would not
> be right to edit that long after the fact, when we cannot easily
> reproduce a u-boot.map exhibiting this phenomenon.
>
> [...]
>
> doc/api/linker_lists.rst | 54 +++++++++++++++++++++---------------------------
>  1 file changed, 23 insertions(+), 31 deletions(-)

> diff --git a/doc/api/linker_lists.rst b/doc/api/linker_lists.rst
> @@ -13,13 +13,13 @@ then the corresponding input section name is
>
>  ::
>
> -  __u_boot_list_ + 2_ + @_list + _2_ + @_entry
> +  __u_boot_list_ + @_list + _2_ + @_entry
>
>  and the C variable name is
>
>  ::
>
> -  _u_boot_list + _2_ + @_list + _2_ + @_entry
> +  _u_boot_list + @_list + _2_ + @_entry

Not quite - the actual symbol is _u_boot_list_##_list##_2_##_name
(note the trailing underscore on the prefix), so for list 'drivers'
and entry 'first' the name expands to _u_boot_list_drivers_2_first

As written here, the components concatenate to
_u_boot_listdrivers_2_first - please change to:

    _u_boot_list_ + @_list + _2_ + @_entry

to match the section line above and the unified '%u_boot_list_ + ...'
form a few lines later.

> diff --git a/doc/api/linker_lists.rst b/doc/api/linker_lists.rst
> @@ -46,16 +46,8 @@ Start and end symbols for a list can generally be defined as
>
>  ::
>
> -  %u_boot_list_2_ + @_list + _1_...
> -  %u_boot_list_2_ + @_list + _3_...
> -
> -Start and end symbols for the whole of the linker lists area can be
> -defined as
> -
> -::
> -
> -  %u_boot_list_1_...
> -  %u_boot_list_3_...
> +  %u_boot_list_ + @_list + _1_...
> +  %u_boot_list_ + @_list + _3_...

The commit message says the surrounding 'Note the two _2_ constant
components' paragraph is now easier to grok because only one such
component remains, but the paragraph itself still says 'two' in the
patched file. Please update it to say 'one' and adjust the rest of the
sentence, since the start/end mapping is now relative to the single
_2_ separator between list and entry.

> diff --git a/doc/api/linker_lists.rst b/doc/api/linker_lists.rst
> @@ -82,19 +74,19 @@ defined for the whole list and each sub-list:
> -  %u_boot_list_2_drivers_2_i2c_2_first
> -  %u_boot_list_2_drivers_2_i2c_2_first
> -  %u_boot_list_2_drivers_2_i2c_2_second
> +  %u_boot_list_drivers_2_i2c_1
> +  %u_boot_list_drivers_2_i2c_2_first
> +  %u_boot_list_drivers_2_i2c_2_first
> +  %u_boot_list_drivers_2_i2c_2_second

BTW '...i2c_2_first' is listed twice - please drop the duplicate at
the same time.

Regards,
Simon
