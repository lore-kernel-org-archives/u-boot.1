Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E35109022E
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 14:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C3F83E36;
	Thu, 19 Mar 2026 15:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NJqr1t7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83E4183EEF; Thu, 19 Mar 2026 15:11:18 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F15483DC9
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 15:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=olteanv@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4830b67aa6bso1547165e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773929476; x=1774534276; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wMypKDE5UXRF7zwn55ZNoQ+QIW1y2xyvfbtWVVaUwf8=;
 b=NJqr1t7uuXvOB3IK68LQrxOKuAYcXJTs9MYGOWxmaNWbw/op1ZfxGvEJoHDoxvZO+1
 uFccF8BBR0Luoj0uP09Y+1+PdB8Bk31TwN8glXO5DnAnUFC6oHIN0PomugDepuVuwZU4
 tnekTOjARUA/Q3WJuOt2xZ2avKrubBUCyLbuLv/qUgyo78/zHKT3GrsNU71zffQv0R/q
 902in1XGXdlzeyCF3TuJH1KB5uvKnQQU/jQuLt+KnLj7jG5eMCs5PIW0w6j5WRcieS2L
 I1OdH795rrjMGdERC62b2DPnYyiXVIZ/wV5isOElQogaGUfBXOH2X5kR3tddkpq2igT9
 sGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773929476; x=1774534276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMypKDE5UXRF7zwn55ZNoQ+QIW1y2xyvfbtWVVaUwf8=;
 b=elg35aYhpIM0GZeocoVaqXA2O2FcDu9i0DcH/rnPaIHM/K36M0JVlSBMv8CRYScyKg
 2PQm48ld4w4oIJdMQVdvrdb+uAEEYwXVYtkXUZRq2K0tfy5eAatQfzgA9qUYhJRTUwhA
 Vn8xaE7gEUbn06359K7d2PlO4xfll+ymKVkJN/BwNqbe/fO9eyMoOu1DnTsVJVllq0Nu
 9w90Mr9wdaqXrm/iOpCoEM+buWOhXA9USyaQUjGogNdinTa4jtqGuGfQWKMXUat1eSR5
 WEiX5gpO0AOAxy7L2OxnljExGnxjlWC/K0WeLFdA9wPFLvR6InsLX7F+dLXznxsnymyM
 8gxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhEn3iLfWh49FFPLNc/nJIu97Fzgga/6F4paUXzQEUyViyvATeHbeLk19Mewp0j663KvcXa0g=@lists.denx.de
X-Gm-Message-State: AOJu0YxSZXgLwFDvHPxk51a1jqHIykgLxf9ef1D8GrrOdn7xJAGcSJM7
 Bji2kvSs4cCGxXruZeLw8hulwzKNxps0iFdC7NCdgeO/2xyCPdD7T0Q7
X-Gm-Gg: ATEYQzzJLoi0YURcMUSuDvr5XMxFEK+oJ8EhVZP9PSZnk4h/j+Rf4z37lZvSbvzCY9u
 rHOuEhXiKiCM7jUrIMqnW2AWaPSdraaeNSnOtHAJTnebt67iLZcgzWYVltZM85KemDeLSJSly9x
 W9aD9K7q0csmiGWhUeaN/3nMitn4zPCBEuVFJlGyZhqCiaZ1lUewMCIMUnAadAG5kk2XPl0MBsA
 7xPPHJZ4hZq4XE2reu+t5f1XnwTkKIiHAAsQeOiQ6j1G34LnLvbVXDw4tHRHtJix72LGbv1l7CM
 dndBZJa2+WYnFy/ZrLEJk8peaPFGavfRWYjyNY8tmSZN34aSQOJsDOoJZ7E7wxQgikjIeoVv2WW
 fL0Hc978TszADmgrgsStzFFCYrylVkG29CO70J9TB9pBxyik3r8xxX9Rd5iJzAFSHdGdfi6/Paj
 6tSBaASwav3nFhjTQJ9F1hjm/jFQ==
X-Received: by 2002:a05:600c:314c:b0:47b:d992:601e with SMTP id
 5b1f17b1804b1-486f442f9e4mr84898635e9.2.1773929475506; 
 Thu, 19 Mar 2026 07:11:15 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d50a:b400:5ed6:aea5:dd72:edea])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8ba4baesm98824715e9.13.2026.03.19.07.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 07:11:14 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:11:12 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Ashish Kumar <Ashish.kumar@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Kuldeep Singh <kuldeep.singh@nxp.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] armv7: ls102xa: fix SPI flash clock
Message-ID: <20260319141112.3mcbxhhuh5ougbjb@skbuf>
References: <20260318142949.2479033-1-mwalle@kernel.org>
 <20260318142949.2479033-4-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318142949.2479033-4-mwalle@kernel.org>
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

On Wed, Mar 18, 2026 at 03:29:17PM +0100, Michael Walle wrote:
> Commit bb6f3c0f7634 ("armv7: ls102xa: Update SCFG_QSPI_CLKSEL value")
> broke the SPI boot on the LS1021ATSN board (ls1021atsn_qspi_defconfig)
> at least.
> 
> The commit message reads
>    Update SCFG_QSPI_CLKSEL value : 0xC -> 0x5
>    which means ClusterPLL/16
> 
> The original submitted patch had the following description:
>    Value 0xC is reserved. Replace it with correct value 0x5 which
>    is ClusterPLL/16
> 
> Unfortunatly, the little information which was there, was stripped even
> further. Why is 0x5 the "correct" value? In fact, it seems that the
> upper bit is just ignored and thus the value 0xC translates to 0x4 which
> is ClusterPLL/20. This, will result in a SPI clock of 60MHz (if the PLL
> is clocked at 1.2GHz). But even that is too much for the (default) 03h
> read opcode (max 50MHz). Set the value to ClusterPLL/24 which is 50MHz.
> 
> Link: https://lore.kernel.org/r/1568804284-25162-1-git-send-email-kuldeep.singh@nxp.com/
> Fixes: bb6f3c0f7634 ("armv7: ls102xa: Update SCFG_QSPI_CLKSEL value")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> 
> ---
> If someone still wants to have a faster clock frequency, because they
> are using the fast read opcode or so, I'd suggest to actually implement
> the .set_speed op in the driver.
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

I think we have a problem in the RCW as well.
https://github.com/nxp-qoriq/rcw/blob/devel/ls1021atsn/SSR_PNS_30/rcw_1200_qspiboot.rcw#L8
Those values should be interpreted as bit reversed (so 0x00000803 is
0xC0100000, i.e. the same value as U-Boot used to write prior to commit
bb6f3c0f7634 ("armv7: ls102xa: Update SCFG_QSPI_CLKSEL value")).

They are reversed because we write to SCFG_QSPI_CFG prior to writing to
SCFG_SCFGREVCR. In fact the documentation says about the SCFG bit
reverse register "This register must be written 0xFFFF_FFFF as a part of
initialization sequence before writing to any other SCFG register."

So it seems the QSPI clock frequency might be already out of range
before U-Boot brings it in range with your patch still.

I can take additional RCW patches if you're willing to send them.
Plus, I see since commit ba89878d7029 ("armv7: ls102xa: make QSPI clock
selection optional during SoC init") that SYS_FSL_QSPI_SKIP_CLKSEL is an
option too, maybe that's of interest.
