Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD55CCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B91508102A;
	Mon, 19 Oct 2026 13:17:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tubNGlC4C4Hd; Mon, 19 Oct 2026 13:17:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E567580C1A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415821;
	b=cWIPLj0eRkB/xy+/eGBiSpfsqDAmjvaMjXIBnYU6PYQz+rXBsH/LX9HcyaQijll63Ta1
	 Nl3CKjD30m9Ib51oLgp/C+zaps4/DnPCcG804B9hlnv8RDlHMaWGLeE4BaU/S7U40MY+d
	 4p39CcQu3YgnBTRoRs7ajR7LmMC4VoDdCJuuU5x6CbSQYng5QB20soNG2KEzCYxyOcsAq
	 aH4gkWNWOAP+7w5DctjvACdq1p7EN/Ilm/0bDnXe3KvSny3lCUpEEM9UDX/lZLx3yXptv
	 M24mWHGcxBrFHmR/HMxwbICJLJ7n9/IB62VY54bk5Uex+SVgINgaLCdn6Sx5AORPmxw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792415821;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lho0j3zVOV6DkqqqqQALJbXohg7simLF3KB0e0zwLXE=;
	b=rsG/00f9n2w5/vpEzWCFDu0uP/+jed1N+MZn4NbCE21rG+9lVkDhytYTEPTGkiQLM8uN
	 AZNzxMwWB5mdcs9uVcCwitioYIG8AgOl/6FankkDvXBfZ7XlWywPYokeTbaLRWY8ZP/la
	 HyG5sBdUF1x8GS1hVGwPaUjHXWgO8cLltrLT8WIpwTtcXD41xuax3IXAijKhvqIB+Aryp
	 Xr+J+NEr3V/LtZMdAHjg8Y/QGVLGOUZuW3KVgDjirxqKrYybsyxK+cf/iFcbA/S7137wh
	 NIwK0QxTtm71pu4JpFAOQlS9M/O4oQ6Gny6zbHumFWNSTE8jyNOxsczYsv9oSh4IZ7w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="ma/Ru1Za";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792415821;
	bh=lho0j3zVOV6DkqqqqQALJbXohg7simLF3KB0e0zwLXE=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DW+XHiwWMbYxkV7dpYe/4zrLfShRZaSo7/eLfOa4GafndxrNV9Dw3diZhvHjewMjv
	 bzfCFJF2CNUbY9lAsES18RGGYpoC1Aj6AtvJ2L/Eubl98UvgQrdyCVu4aXoChazDyn
	 hfPbyw+lugoDA8kVzG9Fq1OCwFp2LKEIyoPxN1Ch0fG+qGQV7HBSSnAEc7sRf+la0c
	 gXxoPAuUWd/iIAwdEaGzvR9VVgaR/3rWcbWF0hWkW7xnZUMIfpIMKUpOI8/JuZ8cCz
	 U/rdE/JA5gupCn0AMgN5rmeuRKKKXgNjFJW6VO19qKCOwCLJbgsj4nBEHHdsZajbtT
	 5hYc5RJZeSTAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E567580C1A;
	Mon, 19 Oct 2026 13:17:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B409823A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A635980DB0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IKo1iQNAwEra for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:16:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C016480EED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415817;
 b=RbuPpGyVdR1gNZgEf090lerOSDnsAcHl/WGNV+TO5jzYsEx5gJLD6dWFadQLf+HDsC3D
 09H3Pc54E4i8OWzx+HbZsNEFus0eca4KA541XW6tXd2umjEEghqeyl/BcPcuUEkK5x6d0
 n+NMYhCz/YCQIp8z8ZsIS4VOOI0dDVbl33GG9SaxdB2KP6Nyh+Sj026gNKm+NjxaSnmDF
 IfnytPYHv570sORyg0pamLOx9rFtZKPsLMeUOJq5HcgH3hgPNffn89xQh3pY74AQmU+Zq
 HDXkpAsLOChBc5uZqGTDWS68HkVBexPtTRYA90uwNy2kBXjrEU5oZR28HaPZ0ZnUigQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792415817;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=lho0j3zVOV6DkqqqqQALJbXohg7simLF3KB0e0zwLXE=;
 b=OW4UUkKPU3qOdv70wxyX+YuQ/H1b7C6xTI6y+TaQDOt6iB2aAIgAKRFdT0+oiVDG7KDM
 Xb1fR31gi5p5cCqJNjF5QDGZy0x55mTtOFJWiP0IoqXkmFz7mplIfNjcAah29C5BVcP5Y
 LVjN9tICizNIL8PkJuTroE2Uf2n/AUHFngw+BoNmvlSAfUwgy0U8D34jcnx85pwZPAFus
 0sRczRP0qLZVxyAtV2DbjpqhIYB57e8UxtEIbZfEqBfkA2zhutkqMAUKTpu2HLf2YNbWh
 lTfMl/1r9jfO1+PHh1VPTVh4mT2mDQQcJrgEor9eucwLfUV8oCDPJmdT0G8Fe0DEZuQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="ma/Ru1Za"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ma/Ru1Za
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C016480EED
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:16:56 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so3170614a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415815; cv=none;
 d=google.com; s=arc-20260327;
 b=byZqyDuK92FVvz8hAUkp3JubHfxROgIRUzeOvcMCM5EalyKPKMq6Lf8R2d29cJiGH5
 fLHJsFkZw5eBeb6Z5bm3g/HiB1rS0uKCVkjMWkp+c9AEEivM5KBoiWza93Bu1RIhAifL
 PbPO8lMDuLzDNGNDrrZfOqZzTIXjGD0SDpE1VHEkHpw8wHAVcajiSFogW/SAKS2gvxD6
 fzJ0WUEOQJpWkxM2m5AsltEH2twAUJF6HfwQA8iBLSKElJNT62GR8knnnCmTKTdXBleZ
 5diGv5hT3Os7cyqp/d6stqDWm3zuSsQewX28Ewcuu+PWmsaNJaEFPemipAKP0GGYNe9Q
 nXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=lho0j3zVOV6DkqqqqQALJbXohg7simLF3KB0e0zwLXE=;
 fh=7yebyOBftD8W4YIFSymMZBHu2i4W2F2zuwRkHRHfhlk=;
 b=VcRfUZPPJQU6FhRSJg6UcKBhEdGmbqpxvAxKYsVlxLEysAwa+qw0RIG9vA80P2imPl
 GsAaEKs3Xby2QrbDBfKYPEPgJpRKlwK5skqxuddJrEJGUjI6+/KU4groFgCPRiCbIdtB
 oLuSb4HC2vW/VhbXY0Od/SjwNCVmr48o6jeoYJgJ9FM3G0LMCCV6uCxMtArUfXolHiCn
 IHXmzKqCGNwwUO8gbF4mm9SLTQ1afI+bH8AV/4akVklDvr0bjImP+kz+vX3mSKbDWZii
 59mw+0YdcQuWhwhjRyVjGhKEpIPsw9Td6HR+XO7LbH1sgXSBgvlVDsrPvdC+z3Bx3dS+
 oPrw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792415815; x=1793020615;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lho0j3zVOV6DkqqqqQALJbXohg7simLF3KB0e0zwLXE=;
 b=ma/Ru1ZaDLrTA5V9IqLEsj7ZKkSVXVSIsQkLZ0cE323Dd7wRM3S9GEKSmCiRVTKNbm
 6gCPfbE+19o9PpixAD5uouvFmufCPluf5IxQuhY/Mnp90KJZ6SlSEf6vx6l/tfOMzQbZ
 wAgLIK3/41kwxLRkN4kfoXrRPP1egOEIGFzAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415815; x=1793020615;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lho0j3zVOV6DkqqqqQALJbXohg7simLF3KB0e0zwLXE=;
 b=MpCaKiFe6CuWsVuqJ274QRH1e3aXkEVfLltC6hFsvzJHpj0awfZen2DW8ISFzJhTTV
 ovqrSwhxIxUvsLJcu8tdrgYizJqyNvlFal98JOecsyM52xgMFdJ7ch5ULMkt5LZXWbGn
 mv2nev3T2WTSFg9u+G+grRNt2hCRn+3Lueu7QJtH05JsZEWqRjBdsZENtm8cs6Xxk33X
 VLpMhiOV6WwxD9N5M/Pb8B1R913hlmXvbHAB3aOLjggH+nS5AQCrSv+dMHrwe20vIUFF
 cNENxy63sjTjyEZGiyffnX7KgDIKGBiKKQkvrsI9VjAygU51aAGJe/oEZ8AYwB5G/JoP
 WGEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwSiPWeLDVEEPO1PZP434x4FevHiT4bTQEV5GkjL2VDgR/ILwb+XxQ7YbvZC/WII6z/FFsjmTo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLVtzswbCop9p0wU8VADkBbKzodl3q7XxnRscz/dtUKlq8AnR4w
 BnU1Qr/ffxX4r1Mj7SoIRY2tWD6WOZqeX/R1kkzimmad41Mv0/jKT7wL9VD0s1cpWuH9U4hkPIv
 cyfhX9q1lLHMMEPgnDoIKE6HOalCrbm5xaVo/z/Qi
X-Gm-Gg: AYBFou2iq0uX1qRgYa2c0e8BEKQTco5Rlw6HI64AnO3D/rqN+ey3upve+UOpFdHJ4Gi
 MAzjLiim/EVSgI0qZNnluR4Bv1p5qfzp3EABVKnlWS4Ok7R1CMO5KKjIfnfAhU/SirPPzkMQovK
 JmoqNqegsuoA3UiADmn/YLJ6NKmcPz5Lqwmxp3Sp0K3+rwqXQ86W5fnO0JSAQ0j0lDMoQgCy/82
 8EWnoy0qPB5eYwUWODVJobNMM3xZPUlRVkC5qR6I+sSKESJCU5oneIjhGZgSfffA5V8XYJhQ2dd
 Vv1XBLy61pKViwlwYHFMp8sqrldmlMIoTB3hWhJYBNqyHJjBYAbPMA==
X-Received: by 2002:a05:6402:f0f:b0:6ac:765e:def2 with SMTP id
 4fb4d7f45d1cf-6b3a81b87d8mr3454497a12.41.1792415814615; Mon, 19 Oct 2026
 06:16:54 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:16:52 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:54:53 -0700
MIME-Version: 1.0
In-Reply-To: <20261016065500.137544-21-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-21-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:16:52 -0700
X-Gm-Features: AclHuK-onFmhuDFowmYKqPSGhet5IitrdPY1eUtK20RnYVrsseFd2Pa9AExTzmI
Message-ID: <CAFLszThQ0WX7UdmzpZrKpJpp59rs3PApGbSNVaK7VduM8d+2bA@mail.gmail.com>
Subject: Re: [PATCH v5 20/20] CI: Wire up qemu-loongarch64
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-16T06:54:41, Yao Zi <me@ziyao.cc> wrote:
> CI: Wire up qemu-loongarch64
>
> Enable qemu-loongarch64 in CI so it could be automatically tested.
>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
>  .azure-pipelines.yml | 11 +++++++----
>  .gitlab-ci.yml       |  6 ++++++
>  2 files changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
