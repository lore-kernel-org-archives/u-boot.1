Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EDE606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lg8MQTXn;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=TyCWOmFD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C52D240821;
	Wed, 18 Nov 2026 06:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXFUdNw0wNUW; Wed, 18 Nov 2026 06:51:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD219407FB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794984695;
	b=TpBNKl7GfmqrbvTVbFsSer7VY8HVGppLzZS42Z2XLqPEksNS8m82hTEDJKKLlrSAinnD
	 UeGMOoX1I+wYzbH+sz8Fp8M3fNVxkGkkQD92NOuMBAxvjR3HddLBbphZUYCWtsY6ysILP
	 sFmlEHoa0FZN6fpD3i6Me6IMNtjAPLYTeJJA/YCdV8x82SJhXkEF+aew1IsE311eyzVUw
	 bwRgQ02bGSJ3yAvq5QNEjEGCW5LTIBtpLcTl+cZyGZSb3BieOC366t3UN4FxqUThtO5Tr
	 m+jMWcV+V7zjMHXolvo4fPcLX+7mfmm7IHxXTf41Godp1ZKRpBgAINYzRQ9vW5mb0FA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794984695;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gsd0lqEmEi3WMLwaQ/VU8lEiqRo6Dq3D8xPRyyHInuA=;
	b=ZdtzBaslzVHTu8anoLtJRLw+/OMBGdgb9+c+xBy3Fux55vW+D5MvrNw4LysAQclNhe8J
	 jUeJ13rNdQlP/F9sFMjFoWHV1yBEFSv8J6AxPlfIcIElF2ptzXn8aOKRug23tWIJJgGNW
	 JNhyxLzQmn3rZeHvAIPrII0hWu9QTPYXV//4gNIEXJruVkFgPgVZyOnKsn0xD8MO/IchV
	 TYrdKowWYXy9qaZAKoINAJ3y4VjX3jbgorByR58xrofNTsdfL7rK85N2/TNGXHft4D5Z4
	 3ngy6ibovPEoycUQEF+CDDJeQknbLFtHOOe+OpDmxfV4ieYJGtKBgP8EVy/CuypjRWg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=TyCWOmFD;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794984694;
	bh=gsd0lqEmEi3WMLwaQ/VU8lEiqRo6Dq3D8xPRyyHInuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lg8MQTXn67ygnsoVYbja6FAejvuCfESTSKhSpjtNwVk8z/Z8XOdkTqMm9eIRcyuIL
	 9DGdDARU6tRule4YCyZZ9mYkUYgSlHPxU5iNRCJwXIeFV0aAdoG98F1aiMs3VTuwVY
	 HmlxmHomPOMLcWWpx2EnfCXq6SkTMAb4Fqr9MrorawseVm1SGzqq50Syi6PXzP/l/k
	 AVpCRUMpfLT0IFM2RhAC86qRfY0hLJRxbDZZB9ByJ23k/eq8jeopKQ/eUKl0qi/3J4
	 zkdGoXekx3PMY2vAiOzH+psG+2FhQngfF4AQ2zJwOOY1i8XD7uYUagRC45p8/yXQRL
	 IzXe8p0f5KLjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD219407FB;
	Wed, 18 Nov 2026 06:51:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A6C989F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:51:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4284407FB
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:51:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oHZZRzSIuCKH for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 06:51:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 92F1E407FA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TyCWOmFD
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 92F1E407FA
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 06:51:28 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so657273f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 22:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794984687; x=1795589487;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gsd0lqEmEi3WMLwaQ/VU8lEiqRo6Dq3D8xPRyyHInuA=;
 b=TyCWOmFDAtqUOuYBQ+eYio8XvGxegJiO1xpLGXsEixf7Nd00plItiDcDdeqVV4Oi/t
 S8Ev6sJnpgFIJEGfCxBuQGCa0tLv6cFQRohd3ZN2EHzVsC/Hgb5PCPyGHQjk+8Yf8MSV
 +FmdUd8i+yYJyrfSCMiuObwq3ZaJUReV8dXCBtf9KWzRutABdlST3PbVbRRoA7yanGWN
 kJ6l4Wtm08+W3IlGo2gLaFQGsys13BNlBAKtzFPkDDOfijWEvk4e38X8nF1zwwphL6ai
 KJq0Z9hPjUaFK0SDEAruVtvJvWpEvleAIFOjcFTl+CQhyuN0vAJsYt5LbK2385A6a4Bb
 LdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794984687; x=1795589487;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gsd0lqEmEi3WMLwaQ/VU8lEiqRo6Dq3D8xPRyyHInuA=;
 b=ZOyx397QfG7L2kYR2yrMH16uMrFryWCmJpdNvSjbbWijqCFahtwiEeCy47x54B+198
 sFWpPE3jM3lxgNPGyr5j0HxNMQiWJxWHzSESvV2tFJn4QEgFTnUkpCe7D00HKREt7meV
 6vdYFe9J5ntwdlW9rYKb7dLZuXb0GcbUVmDJHMrn5BZe4tGJ4au1JlaX/CiSngptVVR2
 uZvI1JKQAcBVs1gWmTm2dr5JU1XfzV1hsVWt1hUsZtCIbOoWg2EINIZSY/lwXgFkM6V8
 tqcJz2vWWzhqTSDaNFTgTTCYcVVM78KkFYWLy1VytPQ20pLvRVycN7nmaVlY4Jovha26
 U8bg==
X-Gm-Message-State: APuU4Z96KsRfbKTHUKCNAP+feh9+yg+UMYQwcffWOubX0dRHhwAhEQGS
 2nHqxNXHRMC1ZPFE6Sal1K2RBR49kJdRLM2rKvJnVwPwQd+qqLOz8Xwi5dXfC+SuzXA=
X-Gm-Gg: AZFdTZfTey7wbBFyzZIdCOkhQkdriAyB3d8fCMQyy9yPzMQwsBYqft0M34ZzY/AGoPG
 JDU204qjiJ6zRN9+9GOoTO5y5n5wZJKnPvYB7IweFgFIu2gHuGvgnyqa4U1EnEvrDvs7e3j0m4u
 Rycmgc/B0yVgTdHaKpmwuFXpO/tO3T6w9fl60dGFByKselli7HJ+7sdVqqly6gzKKZtbId8kegF
 +TeBCPnVc8F9rXgLbfBYnkeLMLmECI+qXYKHAtAs8sagPaHoTUz7G9oG4TjFp0NwXRuMjfKAQKk
 PJdkJc85MWDpXoVF9oqTtHwWc+b4cWmQcv41zMoNToUoPG4PVleqZ94rGJWKe4yg70noW3YCkfz
 ostrxAMbW7NJWtHrZ1CNfEwOwgDdyqX7L7ISQKfzYcGnrm8lJAyHYnRK1BmnFYGrP0uQvonD8mt
 3tFtJgoJxgknP0+EgiNA4dL2BfX+Rg8Bcv+kIcPaZ73ohy6Wu0IXLtvqw+1XUzwip1+gVliyjvf
 yWOnaI3+YPTS8FVsPhQ2MrjQlHfeBcStSb4IS+7f4rheMH9gQOA/FYQJ0TwP9EKUFuTfAWFs+qh
 3bQXwz5+KAlASjhWbScBI3V88nJsvAtNE6amDGn2GPrDK0AAxWlP66eh5+TyZwYGgW5dZbKey61
 Q/Zcuj5U=
X-Received: by 2002:a05:6000:2681:b0:4a7:851a:e619 with SMTP id
 ffacd0b85a97d-4a7851ae893mr614298f8f.2.1794984686836; 
 Tue, 17 Nov 2026 22:51:26 -0800 (PST)
Received: from macbook (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6573baaaasm3104604f8f.58.2026.11.17.22.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 22:51:26 -0800 (PST)
Date: Wed, 18 Nov 2026 07:51:25 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 York Sun <york.sun@nxp.com>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Day <me@samcday.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Alexey Charkov <alchark@flipper.net>, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 0/6] Support fastboot boot in SPL
Message-ID: <av1KkSo_66l1C33S@macbook>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <179492230542.246593.14014203987510433850.b4-ty@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179492230542.246593.14014203987510433850.b4-ty@b4>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 14:31:45 +0100, Mattijs Korpershoek wrote:
> Hi,
> 
> On Wed, 14 Oct 2026 14:24:28 +0200, Carlo Caione wrote:
> > Test farms need to run successive U-Boot builds without rewriting boot
> > storage. Add optional fastboot boot support to SPL so an already-running
> > SPL can receive U-Boot over USB and hand off to it in RAM. U-Boot proper can
> > then load the operating system using its usual boot methods.
> > 
> > The standard host command, fastboot boot u-boot.itb, accepts a FIT built
> > for the target, including any firmware required by its SPL handoff.
> > Uncompressed legacy U-Boot images and raw binaries are also supported
> > when enabled by the board. Raw binaries use the board's configured load
> > and entry addresses. Legacy and raw downloads are rejected when SPL FIT
> > signature verification is enabled.
> > 
> > [...]
> 
> Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
> 
> [1/6] spl: fit: reject failures loading an explicitly requested FDT
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/088e6f84ba52e62b96b018d48fc0a9d5deb57307
> [2/6] fastboot: invalidate stale and incomplete downloads
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/c99169ecd5aacd748dd2a84837ae80b346fd8e07
> [3/6] spl: ram: allow loading FIT images from a supplied buffer
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/0160e29255b32b0f0158da4cae69bf360aa9e6d2
> [4/6] spl: support booting FIT images downloaded with fastboot
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/93ba4e8d4d3d5c75470e9e4a805997260182d9d5
> [5/6] spl: fastboot: support legacy U-Boot images
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/a8ed070e54f83cb16149db910b2c46297e7e7828
> [6/6] spl: fastboot: support raw U-Boot images
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/c52cc53f454a3f7e039357a839a2b92f56432bc6

Hey Mattijs,
just to double check because I see this reply to my V1, but the revision
to apply should be V3 at [0].

[0] https://lore.kernel.org/all/20261116-ccaione-upstream-spl-fastboot-boot-v3-0-7b39e7a348c6@baylibre.com/

Thanks,

--
Carlo Caione
