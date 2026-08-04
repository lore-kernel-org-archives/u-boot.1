Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4979DC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1354C6074D;
	Tue,  4 Aug 2026 13:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbsvaLys5mOc; Tue,  4 Aug 2026 13:06:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A39960716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785848805;
	bh=mymIbDbKuAOetI/OJ7sbHSgSAit6BHj20oGdCxwYzGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hPYkdgzXpbqp9vn7LIxbsjE9+JRUpasJYnVl18yMUqgWt3LtUT5jrlfXokdAEy0e+
	 ekqSvS052yaMGTAd08d9DDOaedSpWM7Ql2b7uVHxygNjzRlx5f7isvtIPTphPdiMHS
	 Ux+oQh3ynHoJkbkxspgjTQ0+7FEmSPPcMYeaWuPC4pyF5cQda2UgAcz0hZaEjug79b
	 0UhO1hxQpaS07t6tpXB2yITsk+JJWOTwzwjVxQaBkO6fvUqNE4bnrdE1+Q4cQ7xhOn
	 /LZK/00ubr/Rt0SO/4VDFbcRJfN9gVdU36AXbFC1qTJ5WkM63NpcW9GplGCK/+FGSJ
	 tmHiuNs3DaZ3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A39960716;
	Tue,  4 Aug 2026 13:06:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E09862AA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEAD3405D0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNJinZ3zy7A5 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:06:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3F34740550
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F34740550
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F34740550
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:06:42 +0000 (UTC)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso39719355ad.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848802; cv=none;
 d=google.com; s=arc-20260327;
 b=OtkqFK1VSohvUNAOcRF8sb8WGd/mitoguzPuqxhYCHKBRnG3s59N/hPLgdhIj+uO6l
 GoXVA2Sc8vNh8D7NvACHmShGX1c31dXBHVWOQFpfhkiz3mdiiRY5J+ulNU/fQ1aV1F5v
 f34al0oKcUKGAsYWW1ixBT9ryNkgnKo99f6bVBOA1k/750ZtPp6cd0T/wDyVO5JqTLLI
 rUhp7ou1V02yI4S37rB9IaeT6m0p+zZRuCK1h2nWh+BTs7EvZrEGhrV0snK5Xzrj/5Rb
 cBsxkVb22U++YyefgYDGFDIKjJXw2md0of+IL2CEhhgobYNa5b725HKgt+ZE1rk5VX+H
 trrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mymIbDbKuAOetI/OJ7sbHSgSAit6BHj20oGdCxwYzGc=;
 fh=Kycz0RmuF12z7/MfMEx/C/XJlPwcni/aTJr26m8kUJU=;
 b=SKwLSYvXmT/5Ap6Fa7VLzk8wuj3gqYNeOOXDDI2eUGm8ATJ0z8/DczMfuMZv9+c4Iz
 UNIKRWc3GP9hPXVzQ1TSzqdG9gWOk+XCzu8fqHzn4yABapmxSeW7xU2Rd9ij2xW8KSqX
 LEnkdbwrnR04aWjuKr4IpQBk7wxeIpox0X6/U2Lu5BpnvnyaBg6K+efna946ROlb3YRq
 TJc0z+xYuBlEyEA5mPRT/q24sgJKaJkADKGqsnB9uTeQhTZ7vuhZeyHEe2SfcPpJGARu
 ZpBEkmg4Al9qM54CLT6K/FAoC5/wMHKgqk2pxTSo8obfOIqlWHsQEtJFX2+pSVsUYWq7
 Z9RQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848802; x=1786453602;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mymIbDbKuAOetI/OJ7sbHSgSAit6BHj20oGdCxwYzGc=;
 b=Kfd83nxbXJoe50RcPq8qW9zperYnPG3mVgY6E8CN/1RNgWGg6vaUkAUyVpuemoQhKD
 MoDwOZSJEkdIqQ6MQplZPEQFV3YHhNh7z4EA4wPkPHgp0si1QPrOM1/jRxf/H6MoxWkf
 1eA68NIFMaDwH7th47azKvpk2OrijEsySpv2yjxT5EOZeeqlPat0VR3Qrwb3fJrJ8uGN
 0Ij3UEsA1PHyicedgAVH8IHm2V/F9GnVHkXsQrNA5Uw4JlQZ512q3tZek2DfG2HHJfC6
 EK2f8y2JBaCjZCjKYFYON2YeR/DhEcN9b+AtzeYeFtA0bPuBMd+InmEi/rNx+DlEAqrh
 yNOg==
X-Gm-Message-State: AOJu0Yz+tFHOuW47QcBf5tVoA/WM37Li9DCCxIL2OV86aravALSGM0FE
 YxJ/fIZOG8Zr6iim3F8lyuDNmJeomtYwxYY8ux3Ff1onP62nRLkc76jsUPHM8wHCfiZrQhL8AVD
 XnTgG5TWeLJ07jNqQkObhEdeAclkEt6Li3B/IoEpU
X-Gm-Gg: AR+sD10PSSoGHHT4w4c4Ul3fNG7kK7xg4DlAVY7e79WilZAUjhoDnuRI7tChq5gm3eQ
 MaL+rcu8e2slzDE5IjSig84kIdaWb/rLUnceusCwTmSpmHyaMiJWuzL1qG25oX7qD3WKSJQEoc6
 i3/PM/kc8tAcRktlfderVne50FZSlR7uzociWVQakztEHGXzR6dJFBje8ITD6a61JCr8a6Ph1rK
 MRGYc4XOwDjElft02k/eEEmhab6H8Ju98ZZmMBLx3cMKFYSPDvoDVPP/2sOQCdYVISPPxpJ41Ov
 vtsQGzs3L7gsDcEZuW7usAvtHuipF3/AKGgd+7mPzag=
X-Received: by 2002:a17:903:24e:b0:2c0:e2ea:6b0c with SMTP id
 d9443c01a7336-2d0521c66abmr132445675ad.21.1785848802457; Tue, 04 Aug 2026
 06:06:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-6-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-6-a3f1f16b53ae@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:05:59 -0600
X-Gm-Features: AUfX_mzYJ22g9TUvNL-d5LNjhy-mjJCErIIaNA8Rfejg1Vlh7qIfrp2-gtX1fmw
Message-ID: <CAFLszTgn_fY1d_Zktw+3iXLv+JPvk14--Cexbs631F2h57o5VQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] test: py: gpt: Test the GPT layout on a device with
 4096-byte blocks
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Klaus Goger <klaus.goger@cherry.de>,
 Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848802; x=1786453602;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mymIbDbKuAOetI/OJ7sbHSgSAit6BHj20oGdCxwYzGc=;
 b=gulCjWHAsgSPsy5BKG9qFQRMVnrTGbzK1qf9ec6bWbovZWmh5MPvlP28JiaS6KtAE4
 rw2n3/j1ixBBOCloe5HG8bLI1aiOESBh7R5uIXBnbneQ6PXCB7zRbUSxL5ggrT/tKl4e
 3a05GnjBDnrCOdrwGhrcTtSAcwB8QRhcmzCCs=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=gulCjWHA
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-31T12:39:59, Alexey Charkov <alchark@flipper.net> wrote:
> test: py: gpt: Test the GPT layout on a device with 4096-byte blocks
>
> Bind a blank image with a 4096-byte logical block size, let U-Boot write a
> GPT to it, and then check the result both through 'part list' and by
> unpacking the primary and backup headers straight out of the image. The
> interesting assertion is that the backup partition entry array ends
> immediately before the backup header in the last block, which is what
> regresses when the array size is computed with a hardcoded block count.
>
> No sgdisk is needed since U-Boot creates the table itself, so unlike the
> other tests here this one has no requiredtool marker. The number of entries
> comes from the build config rather than being hardcoded to 128, so the
> expected LBAs are recomputed for builds that set
> CONFIG_EFI_PARTITION_ENTRIES_NUMBERS differently.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> test/py/tests/test_gpt.py | 115 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
