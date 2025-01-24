Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49718C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 21:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 687BA80A52;
	Fri, 24 Jan 2025 22:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="MFq2Iwg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5385180ADB; Fri, 24 Jan 2025 22:19:57 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29AF780A45
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 22:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=waldekranz.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tobias@waldekranz.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3072f8dc069so27997391fa.3
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 13:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1737753594; x=1738358394;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Igl/LR5NsUxgSFk1+0cF2+GJ5+lo/9Qvaiyegfh8cSU=;
 b=MFq2Iwg6ToWCN6Fz6DTaJgUaFqdBlH/PUgeADqOKCsTcX9iWDy1IfFOsBEwIZ4zLU7
 toS5wLPz7K840FmpskMnCGCZyyARICOk9D7/0kLqRRXKRjlaalzt8ao3Ka8H/Hu4Z2R2
 S6QbeN8R3G3A8SlRjwEz2602NkGLIMXYXd9Xrs28w3WHMlPauN30DQviyWTbi5IkySr3
 YGdkSJJxxTtQWHbWONyWHodt5roEfZn8QDWvm1VelTylIR9CMs9J4xAdWRQ8CCPLybzH
 wKo9Yo3UbFqiwjP2VaRC6BMkt1Il/ye/zqPXT8U3cuFIWPv7Awo94s/FvCeVKIXQlF4I
 jLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737753594; x=1738358394;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Igl/LR5NsUxgSFk1+0cF2+GJ5+lo/9Qvaiyegfh8cSU=;
 b=gynwNFSpyyhfAxiS4h/eIraepu+NrcBFLcdbf0nBi7R6L3lc6RNfN/HN0NtvEeVaYF
 pqzuo4Pf4+ZUN2oR/a/neCSP8nHuci+JEDI1ybYNG7tgVtbSJ3PJelsqvLGF5kdGBzt8
 05pzVFMU9IxvsTVjzqLmXumhUU9TeEu1/XlyMnGDSx3YWG5D5HFJh63qG5DgwHMUo2yk
 qSKWcRsb14BlVxKV2Ks0zE1j9zLdNhPm5idM5uWx5JZB6t1ovGb+LFGY/8kEmEDcl7YE
 Hxr2bIYOCbSA5aIvO8C5mGbT8CGoJdLpWFe4QZ+HVSo0vTSO0PmSGGCpnotuYPuHdTgK
 mXhw==
X-Gm-Message-State: AOJu0YyOEiNZWoJrtCYWZW0RzxVhG2WMyHmdusjmMf0MrvKJIviy1IaI
 xDSOsF38xHbIcWMJXCA6798E8KJjPMwOQlMiiUALBYLae7ZsskY0V2D+4BT/lh0=
X-Gm-Gg: ASbGncvsR8UFRRvKGe6T2uPM9My4UXJUImzvdDSoYjV7UPUUzi3HjBJfdX0wFuQe243
 Fn/it+fQsM5sc7cviTveI+RZD4lAlgUDfXR3EHSoev+Thxy0GVhS2OoAXrON32DqUSVWng8pg2P
 dwYJmAQS7A/EVn8DyLHmw7XeO+JtL1NbFTVZjuvpMM0ii1U3N1abocEvzbtxpquPf7250htO0nV
 Kw7JVc/X6NMJHaHDwkBY8PJdj8AbLnpAHrq8pyY3isA1bWutryMtv+X5L3xYwWiI0tkfdfLCOMR
 jNY80Ulc7y3VmVS1xsprLIdCGFpzYM/CjiFwpg==
X-Google-Smtp-Source: AGHT+IG5sRG5ETEx64zaAsTBWGDDCBvQG1FrLWLqq1/amSsaIC1fp5giMfj2cZZhA4Ia1cbW2rFRsw==
X-Received: by 2002:a2e:be9d:0:b0:306:10d6:28ad with SMTP id
 38308e7fff4ca-3072ca5dabamr116200251fa.8.1737753594225; 
 Fri, 24 Jan 2025 13:19:54 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3076bc49f38sm4790411fa.104.2025.01.24.13.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 13:19:52 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Anton Antonov
 <Anton.Antonov@arm.com>, Bin Meng <bmeng@tinylab.org>
Subject: Re: [PATCH v3 0/5] Add pmem node for preserving distro ISO's
In-Reply-To: <CAC_iWjJtjNE0-VJJT1+aCoaADDNYyy-niZSizo-Sn6898ArLHg@mail.gmail.com>
References: <20250120105045.1281262-1-sughosh.ganu@linaro.org>
 <CAC_iWjJtjNE0-VJJT1+aCoaADDNYyy-niZSizo-Sn6898ArLHg@mail.gmail.com>
Date: Fri, 24 Jan 2025 22:19:50 +0100
Message-ID: <87tt9n6hah.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On fre, jan 24, 2025 at 13:39, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> Heinrich, Tobias
>
> There's a slight problem that I forgot when commenting v2.
>
> Heinrich's idea of plugging this into blkmap is eventually the right
> thing to do.
>
> However, when I started coding this I only added the pmem memory as
> 'reserved' in the DT hoping that would work.
> Unfortunately, this depends on a kernel config option. I've managed to
> track down the problem here[0], but I haven't found time to test it
> properly and send it upstream.
> So for this feature to work reliably we *need* to remove the memory
> map we hand over to the OS.
>
> Since using EFI memmap function into the blkmap code makes no sense,
> can we perhaps merge v2 (or a variant of it), which only targets EFI,
> with an explanation of *why* while I try to sort out the kernel issue?

I was not a part of the first two iterations of this series, but my view
is basically this:

Adding some flag to memory backed slices of block maps, that the
fdt-fixup code can use to know whether a pmem node should be injected or
not, is completely fine by me.

What I am opposed to is adding restrictions on how block maps can be
composed, i.e., limiting a block map to only contain either linear or
memory mappings.
