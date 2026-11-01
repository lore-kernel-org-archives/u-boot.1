Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B5606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b9NweY6Q;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hGPyVJwO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C02860601;
	Sun,  1 Nov 2026 17:24:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vNW7yHjOLXs7; Sun,  1 Nov 2026 17:24:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C131860616
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793553849;
	b=Q7TZlJryy97iRkfLMQbOR5wH9xHyMqDhy9joaSKPrX34ji/9l6zk8Hz4dFyoHjIrynh1
	 KGB51VEfYqFPu7V2fy7F2Ry8h28exJdahqZFYuUJIjA3960Vamglv2aUG0Fm6T5DJf+Hp
	 xICe4veYQDtuzaXAEbXkZNxxKTaImPQMOUMzynb6r9AJ1Zg+BY/xlWgExAbUFwmNIZ/PB
	 S04We1HdCzY3+RM3NcqkZZbfAjmMtpsqYE9oGBRZpgJh6Huq3AnMOZYLuORL+m47UNjiU
	 oNIYNAUTzEYuP0NWJ0bjghekOYwZovPXRVpJtbqacBH8TthRiFr2+o0p4rixPvT32CQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793553849;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=M457Du0sYdwgZp12+4HZanEDFeOQrKBZ2VNwJD2bbWU=;
	b=bmpxsTkn2XpekI9QLmL1Y0PQKAaAoDC197HlWix8mkeBg0IJRGVzOE5gvO1eYVrzjK4q
	 I2nq30Uppeq3Ibcd3iE3XoqbXvsv/Xt/isimEdkE3X/lY8TbseO7yDVCA8AF4wOHZllaF
	 Ccn3hFu29AjdmTBOvgOZABZJ94WvRfDu0dJoEQjh9KYgUi12HI2Z5mcdUL+JsJaYrPktP
	 I1mEJhQjxLlaScX/GuX95wsoyqIaw8SMw4JOpvvFxcHI5Sw6pi4OOIyV6p+wHiPhDYfUQ
	 RU5FcL8dM6cgyskkkDRHz9CwLj76dVD9QkLFbOKH+PoCo8SG8GTqShHCIgaWqMIwEKQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793553849;
	bh=M457Du0sYdwgZp12+4HZanEDFeOQrKBZ2VNwJD2bbWU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b9NweY6QhOF7tWWHwgu1DrDlTPjd/Wt0zZDKCMhCs+9NXaO4302Q6KmCqpO3DCfC0
	 Aj0BGu9Szd6GB+kPF5FyFtp6w6Q2kfC0VD/mhrwsQTUM5OzUBCQDpK6fZ0VsrIO7EN
	 0QtqdfTwAqoKHgyPuMY65uxJmtkF7g2mH1UM0Git+at74kxFdPnHRhz/j/kLKv5daa
	 5g9TMIgk8h0Z1M6vBWawwRYsOdp9UWV9lkkSENBU2cueWlQjq96aK5tzuP6GnP6ll6
	 UholQMxXkA/PUJ8dBY9rv2drFdPyNkD9QeVhbIcaWqWrPoYeB4qRAkK3AJs7YnHK3j
	 yhjImmSPGwxsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C131860616;
	Sun,  1 Nov 2026 17:24:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 267D3EF4
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:24:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17A46404D0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:24:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LzQX-9gdFcwb for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 17:24:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 16B8F404C1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::630"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793553848;
 b=d6i77/d7mCg5Uv7ozm12TgJfg7oPT+cVysBHcmBxLbkBwjEbdjWbrdhS1zN468v4CFs6
 tSWQcgkOneirkAXpE+P5D6zUk0Pi+AkACg4PaImW4tvfs6XQNAwWRCA84l7pYokUNObbN
 hkmGAP3iNQcJOO3PhrzfNjHjqx4soLX1hffLvAe99Ln4jP6ABL/x+WbGEIHW5v1fjcTWt
 7K+nnB3N08FmHwVCikuOAdS/chgxpjxJ4V5Bvo/+UhoE/QMowhLw0WVOLQTsOkTuL8Qhg
 WCcnVXvzRyN3slQU+hpRlONlW5AVjEl0lrbRWF5pa5eHcuxhODwkfhVYbiivZj8I7ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793553848;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=M457Du0sYdwgZp12+4HZanEDFeOQrKBZ2VNwJD2bbWU=;
 b=Sw+ZPnPA0FpJTev/IVxku9HvgEW0VoiaUSOBqXF8jIJN9O4Ls7fAnRRiaaCdxOfine8+
 jmPj+3FaL1IlqeBpgXmYFH7pleqgvXWp30CZPmzJ3M4CkQrkDY1Li19NgLStI1bTP1vos
 dRHq1h6U/vDADhif14xIssnwGtIffPq1ko+nNanZYzApqMTenHB2kXhb1M47M1zuE+E22
 0s4+QRuCBKOqmRzrapUzIlDBF6Asfj2exhpvAF9fmuXUwbT87tfUNy1bEnhzJXj53Wf3S
 +30B0QVGb2i0qyF6yw2XDd5zazRf3SXlMK1MA6c/xKoAoKeOGZU4yY3jrj/+NLIOumA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hGPyVJwO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hGPyVJwO
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16B8F404C1
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:24:07 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c411e139259so179657866b.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 09:24:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793553845; cv=none;
 d=google.com; s=arc-20260327;
 b=IQjP2WvfHmihYDLp7YuT9cIm6pgJuNDX4QTU+BAYU8n1jRLzPV/JxjrCdgYU3RrnsC
 xzpi/NfRg19bbRdXGjPteC0289ELyq/zwgFhKWzyW5qkqPrArd0osVFURq6bH5jN726d
 xrQ24AnEWGZ5gvzNBo49LVB6q2ZZUSMKKnkQrTKRUU8b3W2iee9j/y5CWuxrUw1fo37o
 UWZ413/KWriiAjNcVHQFfGn4AW47cfMileeR66LYy6ODFRkl22hjrvFn46yc1bCi+t7C
 HT6lRBplRk9/mg8djb5FbeldI6r3Xudlf9idrshutIp+UQbPb242X8xQN8ZC2m8YTI+4
 GKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=M457Du0sYdwgZp12+4HZanEDFeOQrKBZ2VNwJD2bbWU=;
 fh=c5Veee58U2LIY9byuYDfPofBzAvRxaAza9seE0FlMjQ=;
 b=R9CJ67Qv5D0/VwVF5dC869gUK4d2VXfay/w6UiQx2GpFtGB9VxNTTBLbopYMPA+B59
 Wpy6pLxsy9l0SW0aCdcRDxbgToAaFvBWNkh7wHzxFkHMQmMNP/xFWo9hDadmMd4rTFxX
 Y52NdYNEh6y1mFWL+JgABm7+MI4uYXvdBPxGm6tG99pFZByfEC8ksthMx0kZZFLwZidV
 NsI7KodulT8ECXjBDF3lXGFlam2t41mgKQcyECy/2v9/aq6br+2t66MK9MqjfQOlA9Jn
 tKE8+GvQl509YFw5wygnQf4UnWZ/fjHUi51u6xJ6pzbIGV7dT9zBb2DrDVr1zi7Vo3V6
 tckQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793553845; x=1794158645;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M457Du0sYdwgZp12+4HZanEDFeOQrKBZ2VNwJD2bbWU=;
 b=hGPyVJwOOIy3zlPVgIDUQMibFUXEZ/Wxt+IZZlWzBE01q4sGmlLNeR5+7i92uEIbne
 l9W6NvgEQVPpsHF5fDAFTU7Mh8syI3c+m8HwjXqxoVhNxK62DFnOuRltjLg0/Z7vJat3
 eqN5L361QMtO5BHn2MoDyr7NDL8aW4x6KsXlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793553845; x=1794158645;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M457Du0sYdwgZp12+4HZanEDFeOQrKBZ2VNwJD2bbWU=;
 b=biWLtimAbhlEfKxDT7XbNr0RzOfEHkqv5f2eWpWHfKF29/ehH6bDQaGNqiBiKcSrYm
 DmRNcN2WQStcNFsXodX/ysznvGOHT+6lcmehxo1YS6XoU8Y/YE2SxGYOX+ShrG+PPJrp
 iEoyZojJkQnMhItQmDQKincNL8MDIXM5mhO1YiP8PfzD2LEhYYwNBZYQF63M07nAZy8e
 Lb3jGOqI1XKxhI6AT76Ff2pth1+uCEu2kg3AUoYop8viBeTOxmTLHoaGPE1ThtM4Wvly
 6U9qei3mdZNqRd09j0y1QUylErdIByr5MYdVTWKqg+dIDAuaRtt/M++8QqPgYM/QaTUa
 u8pw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxw1AOW63pww2+KratFYciOms//45TueKPbtXD7dCLl+p0WtyHb7OMCjsvE1ON8SEhqrJqZyWM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9n6wQOnS+rPlhIiazu268oNjNAu5CB5jnOxNVqUzKbTaK8I+Vj
 7wAn+v9rQbWmSv26G5Qp1Rk40HoIv/CLuRnUhIturFpG3ex3CWjMw1aCrV/rQQnhxSb65jyXEnZ
 VhT/Ctc5Z/Cy4o5CQsaQx2JsH2jq6Ffzpv7lHwmrZ
X-Gm-Gg: AYBFou1LqACegD5c3Ui4Ka0OQYc91ova4biuwZ6/RhH/Sha6kNmMXaUdQ8u/G8mIh4R
 eJVUQ0/+P3ssC2OBaxEfvsYNRmcrqYKG61Z06ye62fRypQKCOHNKz7m/Vf2a2T7k3dyAfWnYiaw
 bdFSN3x16AzVC5LRWjdfOBh2am/cdDwpOHyHDmqFLT1+NSgtGtYa/kumG3EIE74NjidtMkfwtjq
 orV5CeMG+VSbfT00ezxUaQYwSmzbwEc+SVsBhS4G6YYjc8rUWD1PuuA7YemKmrOcJhWKfpTQ5/t
 0mN1HdeFuupD1dzlLZAtBG/dkTQ5orUcGtgpCttnf/Q3dKGOW6ZSsz9bQuAHBIOK7E6ABSYMhZ6
 C3kXl2up+8d+Ymi1y6FTOiq4SZcgfe6yfjiYJT/1Nv2gJs9phk0pUMpglVfO89sHyz83E7b4=
X-Received: by 2002:a17:906:7314:b0:c40:5de7:33d3 with SMTP id
 a640c23a62f3a-c4ca7b450f4mr597439266b.35.1793553845477; Sun, 01 Nov 2026
 09:24:05 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 12:24:04 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 09:20:55 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261031150207.3315527-1-alan.tseng.cs@gmail.com>
References: <20261031150207.3315527-1-alan.tseng.cs@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Nov 2026 12:24:04 -0500
X-Gm-Features: AclHuK95HBvGIGXxNdJzefzI8LdTM__WprNKR0DL-m3U5U7vW-asKXxgGRrbDVs
Message-ID: <CAFLszTiuFK5=zBXSx9t7Y9HCcpoSb-nSvfkq-Mc8Tv+yrq9qSA@mail.gmail.com>
Subject: Re: [PATCH] doc: virtio: Explain how to reach the virtio RTC
To: alan.tseng.cs@gmail.com
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org,
 bmeng.cn@gmail.com, 
 trini@konsulko.com, visitorckw@gmail.com, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Hung-Chun,

On 2026-10-31T15:02:07+11:00, Hung-Chun Tseng <alan.tseng.cs@gmail.com> wrote:
> diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
> @@ -73,6 +73,14 @@ Requirements
>  It is required that QEMU v2.5.0+ should be used to test U-Boot VirtIO support
>  on QEMU ARM and x86, and v2.12.0+ on QEMU RISC-V.

>
> +The ``date`` command only uses RTC sequence 0. The ARM and RISC-V ``virt``

The 'Requirements' section is about QEMU versions, so this looks out
of place. It would be worth giving the RTC its own short subsection,
and moving the v5 paragraph about the virtio-rtc -device options into
it too. If v5 does not already do this, please can you also update the
'Status' section near the top, which still says that only network and
block devices are supported.

> diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
> @@ -73,6 +73,14 @@ Requirements
> +VirtIO RTC does not have. On x86, ``CONFIG_DM_RTC`` must be enabled for the
> +driver to be built.

I'm not sure x86 is any different. arch/Kconfig has 'imply
RTC_MC146818' for X86 and the QEMU x86 devicetrees include rtc.dtsi,
so with DM_RTC enabled I suspect the CMOS RTC binds early and gets
sequence 0, while the VirtIO RTC turns up later on PCI. If so, 'date'
would still not read the VirtIO RTC unless CONFIG_RTC_MC146818 is
disabled. Please can you check this and, if it is right, describe all
three architectures the same way.

Regards,
Simon
