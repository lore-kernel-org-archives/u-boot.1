Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F251D1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 19:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4BD88E21;
	Mon, 14 Oct 2024 21:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="hdujhc2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3DBF88D72; Mon, 14 Oct 2024 21:28:15 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130DA88E3C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1728934093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qXEnS1J3FYAi6PDY94jq6HtWHuC4ZJfSbi9ECbDkFsY=;
 b=hdujhc2iBQXFyE0Ky4p67KmaUC27EmbjsmTHjkL68DPpmSofjsD/Q337REIyHOGPMrvBgw
 aWJmmu0SDNJj4YHBCj2TWImcTg+kAvb9Jvc5ts183ERii+0YjNCtCj/yuAiyUmeZJyMwjP
 Ks6Pz8nmWZkLOE3StiCLTwobzx0sbMNZWMhhD1/wOfHtTwKAgUeoaNK+if8h5PfPvePOkw
 XOwmExjv49j+tbk8wtQTigPml3SUhCUDR41wHUFMJy7KHtO4M3fibbt/8hCxQRzbTF03vm
 mFqAxOPwM7lz85UiV/S9azPmh85Nsmzv3tB8Tk0Gg1X1nU0dbtj3PkojP+mMmQ==
Date: Mon, 14 Oct 2024 21:28:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alex ThreeD <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Ben Wolsieffer <benwolsieffer@gmail.com>, Chris
 Morgan <macromorgan@hotmail.com>, Jonas Karlman <jonas@kwiboo.se>, Kever
 Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>, Philipp
 Tomsich <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Quentin Schulz <quentin.schulz@cherry.de>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
In-Reply-To: <CAF4oh-P-6unDx0HVRegos7FNYv9z7FpQoctu4w465CfFfLzFGw@mail.gmail.com>
References: <20241014175338.2675136-1-alexthreed@gmail.com>
 <3f4143078e0dc3409c96ea13be5b8317@manjaro.org>
 <CAF4oh-PM8JCymzEbw3ZtYnaF8_fjckHUPUkqv-xS1fZBh5o2cA@mail.gmail.com>
 <65bd30e10c687ec5bf19bda34da7df27@manjaro.org>
 <CAF4oh-P-6unDx0HVRegos7FNYv9z7FpQoctu4w465CfFfLzFGw@mail.gmail.com>
Message-ID: <839e5b9f561fa8e6328216618f9a2e38@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-10-14 21:17, Alex ThreeD wrote:
> On Mon, Oct 14, 2024 at 10:00 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> To sum up the replies from Marek, the lower limit should be 64.
> 
> 64 by default, warning for custom values less than 32. Right?
> Since 32 bytes is sufficient for kernels released in the last 2 years.

I'd keep both the default and the warning threshold at 64.  I think
it's much safer that way.
