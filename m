Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677BECD4840
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 18:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D6AE83FEC;
	Mon, 11 May 2026 20:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LXUH4Y9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04D7884255; Mon, 11 May 2026 20:29:10 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C1683C2B
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 20:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bcff2d08ca8so183957666b.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778524148; cv=none;
 d=google.com; s=arc-20240605;
 b=lnkLM7D4ytAVEbU+44MmjlcfbHQ2eDMHWyEstJRXHOKiL4mUp+GLUSGX1w6TpON1zT
 XdnGwBd4rMgjfWiHQj/VWUzhgwUIGCcy4dj7i65UZuMm46V88ZOizRshBp+s7QMX2UkJ
 MwSJZLkIqwAxpEfcoiPl6G6lgmj54Lj67ksD7WQ+mwUXTH0YbTomML/LZYWE8pujYDIk
 G8nJ6G61vGaLM8r2YBTtS6PdKUfE0RawksPHIAG3A1NcXSfQxpDdCS1ZIKUbqABTkolw
 AbR2wPFE1cI/5rYAZzR7QlQqEbnYvHAMTH1CraSxfoCRseNfAYCIc2DpPqTQvP2ypOZi
 fwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QlIFfWXcCRDnp0Te9QCQuX/f8LbGogzK5vnOT4GutsE=;
 fh=TflzmWvmCd4uc1/jF8JEYhNQl3V4yAPDBTvbqMKuwrM=;
 b=VWjo7SGkLPNIjrJwU063oeFWynMT/IOp1aqjitxolZ93RobIyjEdaQ3Y25+Snpdj9d
 MioxRo+5zLxOo64yKB2vqsQ2+n8cQailnyu0AN3D0ZSuHc11mI5/WCNXHrA75sGphmxP
 blUASU8Mjx9DSgYZ0mcEfstPpeqQn5w0G9lueqVAoyo/N0k0lWi1JiFCUAEZwmIiJxp3
 Yrbi/t59l5ei0pwts65dnKjg9+S9t9+l94F7wl8dO76Ko/7gpnfB+VCFCgC7NY6nii7O
 pjXvak6GYyCxAlrOHO8SJG+0A41mKZnpjNe6YOVmlGDw+YmhhB3ay1bjqRhfNGRlxhnq
 e3JQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778524148; x=1779128948; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QlIFfWXcCRDnp0Te9QCQuX/f8LbGogzK5vnOT4GutsE=;
 b=LXUH4Y9tQ97EOJBowfTaZIdcBvJb9yS8D7VzOLsCxi5tdKc5Irs2hUt8KnWRntufHs
 kmUlRvVikXECmTAMiJyVznF3EGQvq2Jf9Z8xtLiD9/CTgybGFb6q3nWtwFG+vvukfj12
 H4EskCs/adhTDt2Of79pu/hW6dLajRoljrVec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778524148; x=1779128948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlIFfWXcCRDnp0Te9QCQuX/f8LbGogzK5vnOT4GutsE=;
 b=AhnjujwRGUI7CyEd7rfnQdhOAjz4vjAk6du8XwrDwsTavE0m271NvuBwq2MZWHlr5K
 vEMfdPkd4UTXmC80Rhl7H+u4iFs3Oz1DH4T511MFbUJd8y0DxVPGmQLkSmDiyBGjsG+Z
 wEotgRQ7wMD6Rg1EcZw+aaqMqnaOpyBP4D9CVfS+q8wdBt7QSvspNc3uCxklPTkdFQQ2
 GWu7PR458Z1gStVE+fNV39seFIl51lW337PxWD50udPXIf1eT/uNtxq+ODYglyJrdu4/
 0O8uu12/zUECSGvkGxBtnOtbpK8JFTGSZqS32Z4gjBLanwj2k6zcdbmZcxoDgHGY8QDl
 5d8g==
X-Gm-Message-State: AOJu0YyyS5MYShpOxuMJnq+HxeersH5hZOiuC2xhO4g3yzBEhiRLJRnt
 JyyYYBSEw9gLrVscNSKopvx1uDuaESY2wPSWDItFV9VoLVNtXB4gEzHCkJSMJXFCt3cldsPQB2v
 0ErTxnn17eLSbNHEJXcK+UBxdDOxoHOYKLQ5lbSZ4
X-Gm-Gg: Acq92OFgSIL7PL62hWX/fjg5f0VT+ggIt4KjazVFI7LS+JfcEiS0v+2n8epDEjuQbJP
 etwRYhqUb0NnqATDGSe+EwhZb+rO1jc35Bfk40tyhn1ru+O0jOl/adF0sunftbO0c9ZS3+8r74J
 FBP6t2P2PMiuAmJ1G6JTuvwEBetbkG+yu3iJrner3FC6qY+Pbem/6p59HVk3yE2jfdCYFmSF2o3
 71vzeg2uVQWEkrE71re6dHOe2RpqoxdKiyk5cB3FuN/BIaMuUFBETvzD9RtVcWmGQ9BQ2INFPXM
 PEQ8Hw==
X-Received: by 2002:a17:907:1c0b:b0:bcc:14b:3671 with SMTP id
 a640c23a62f3a-bcc014b3e8dmr630096066b.28.1778524147540; Mon, 11 May 2026
 11:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260508222911.450165-1-rs@ti.com>
In-Reply-To: <20260508222911.450165-1-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 12:28:55 -0600
X-Gm-Features: AVHnY4Kl3XDpEILqyB_BeZB95Kx-wJNOitBniq9sjshK5d0YpJi0OJ2dCp8M7Es
Message-ID: <CAFLszTiaSYykXHe3P7tm0mAvfQjcOFgrtL088rezfGcHHCaFMA@mail.gmail.com>
Subject: Re: [PATCHv6,0/3] various memory related fixups
To: rs@ti.com
Cc: u-boot@lists.denx.de
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

Hi Randolph,

On 2026-05-08T22:29:09, Randolph Sapp <rs@ti.com> wrote:

> That second patch may provoke some opinions, but honestly if that warning was still present I wouldn't have spent a week poking holes in both the EFI and LMB allocations systems.

Thanks for sticking with this.

The series really needs test coverage in test/lib/lmb.c - e.g.
exercise  lmb_reserve_uboot_region(), PRAM case and the new
initial_relocaddr semantics, so the next regression will be noticed at
the time.

Regards,
Simon
