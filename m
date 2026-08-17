Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F41C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 16:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6922C80FB4;
	Mon, 17 Aug 2026 16:45:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id khcKxF5wN1R7; Mon, 17 Aug 2026 16:45:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88B9A80F2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786985135;
	bh=i+Z2yhT2f4QfkoRpKF9NM4MtfOX/4EJ3dRVWetcQhHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YShW+GWAiD/rvUTC7AClomt3gbGHC1UfAvd7CozEgR0CbYiw37hgwGzq7fOLzXAJv
	 PJ0505vNfJD7UkpX5EUSwqs7hb2OiZ7vLu+T9Lvvn76XIACVQIw6MhgBs0T3Smmq5r
	 91NMsv3BIPotIItjcv7CtP8xNpTXsSdUYo12dpCCuYhEGUERdJNgEiCzVEjSY9mewM
	 KJF2BWCDmb1n/c9+DwxSlaq5B5EPc5y3/VoxTqN87p196yN3FeWxXRLr208FsmRU9g
	 LSYRRYA3IYDb1wHOSToabnBkN5uKpsik6+X6r/5qQ0oYOUWWGU+MNk0LYfF+ljarqW
	 g8TwTzDzPE9cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88B9A80F2B;
	Mon, 17 Aug 2026 16:45:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4416D2EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:45:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35DE76071D
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:45:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GAutb679rwqg for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 16:45:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C19106061A
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C19106061A
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=jArM+P3z
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C19106061A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 16:45:32 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so38861725e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786985130; x=1787589930;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i+Z2yhT2f4QfkoRpKF9NM4MtfOX/4EJ3dRVWetcQhHg=;
 b=jArM+P3z4lMduiKuyy/kMeq3q/ID4DtSmBoPix3N9NteJKGuQAQ9z9ECyJFMcTY9aQ
 ifevsBCwBAfL2wpqIQ3h7F6qbau45C2hLBIPApsyjOJF3GMi4rEY7YFsDEcgPrOFmuEv
 KpJw3XzfTdwLjVs1KwqbAn8xNrdpb4b83mUFNEcZe1w5VU766a8uaKTO2YhJEcjkSZGh
 6e/JI+fFwNr5Kya2jEO9VI2jwIinbU0GNxLPKbTvOWBHer61yYHuLgjaH6zEasNss5BA
 960K++IbEZV0l2/mEPomHYpzRG3PwEmlVxepQHRosJrUZcVxWfLM9HTeUGoTPk0VID7V
 e1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786985130; x=1787589930;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i+Z2yhT2f4QfkoRpKF9NM4MtfOX/4EJ3dRVWetcQhHg=;
 b=QjnHSSLJgfLUgK+7YramS6kw9aO6G/YUh3XcQ+/gHiBGNJyuJpTEk90iajKDowZisx
 69FUieIE3pafdgeRVVwDLfbIDEPiHcBka3taFRxbsa5T3zVei8ElxdDbDsxWElZ2+YY5
 f0xl//6AjtlXtnpYolZ4O6QefG/hl11mfmjniRmTMUPjdB/bwXytdH0nUJSzGYmPdJQC
 dVyJ+vFzO4JwGASozOiWLqB45G6yOUvN2w6D5MMYuR4Bv+C+Urr/MJ1Zwi3DOY1O6CB/
 O2aVIN9GhuaIfEFF38V6skbrM4PHikZMWeaG7Du3DgL3+75pR/fV8HRqBNqV6+bxQ6fx
 jowA==
X-Gm-Message-State: AOJu0Yyc9wtX1YmwulJDtNcbhX+CJOMLR9BU+LkVq7WaZ15gk13l6U4d
 94SvnTIX3rTpaeuDOyUaEVvdEn0ZNp4xwLsKW16Tk9qxxWwc3LzPkhTQ+3HjAPU/3uJT6tnUfBw
 0UU6GYvA=
X-Gm-Gg: AR+sD10yE491D0H+X+fF4JiDhHBdWKG8sP4j1gi7aXBUEIBayE0MnTMUm8CucGyK9X3
 pD14m3gVgDh2BST9j0C3F4R4qTisLOY3wIEtJhUDkSCp+CwKoYaPlkCBWPYQ6KpKuWQpfChFHyz
 tQT8rqbQyn21gPCwv4V7UEXzc0IPgrJhdlxCdF6ll8f6IQcnf6txiHisITgQ4o4YjmBG8aicMle
 5UIj8Z8kx/3cE+CKWMyf1C6YQpmJk2jdQ5cALWtSRlQ1wloWffsefk+IkwuechtHkW+sjW8wBbj
 tIMw/ML5BJkREVR+dklN0XX1DYE1HynUNBcPGrBMUVJBtaTmYiPQfp0HPf4w3RkmpZ6nmCF+Uyr
 r3iqJBQ8KjtT4flh9mooYSpfa+bBbdL+Gks7LjvQwXlBhGR5yJfc/WB2WXQsCCO+8cczUivesqG
 9seDZNBkR4zK1IU52/4EyonqAEgD3BiFaJjegWHXKGkpEe1JpadlyH44u3H3ssmVdyJ9B+zRO4
X-Received: by 2002:a05:600c:68ca:b0:495:641a:bd3f with SMTP id
 5b1f17b1804b1-49987995272mr328809105e9.13.1786985130520; 
 Mon, 17 Aug 2026 09:45:30 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:7281:1989:ca4f:c9c9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b3a6ddsm5069295e9.1.2026.08.17.09.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:45:30 -0700 (PDT)
Date: Mon, 17 Aug 2026 18:45:28 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v2 7/8] arm: u8500: Switch Stemmy to upstream Janice
 device tree
Message-ID: <aoM6qJ32H35aumPL@linaro.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
 <20260817-ux500-external-sdcard-v2-7-ca9a110bd9c6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-ux500-external-sdcard-v2-7-ca9a110bd9c6@kernel.org>
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

On Mon, Aug 17, 2026 at 11:31:56AM +0200, Linus Walleij wrote:
> Use the upstream Samsung Janice device tree as the initial target for
> the Stemmy configuration. This also prepares the board to share the
> upstream Ux500 Samsung device trees with Linux.
> 
> U-Boot does not yet implement the U8500 clock providers used by the
> upstream device tree. Add a U-Boot-specific overlay with the known MTU
> clock rate and a fixed input clock for the external SD controller.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Hm okay so you're basically dropping support for the internal eMMC in
this patch? Can we support both? BOOTSTD should be able to scan multiple
storages for boot targets.

I'm also not really sure about selecting Janice as "default" device tree
here. Do you expect users to change this setting when they want to build
stemmy for another board?

I wonder if we could continue using a single generic binary for all
boards using CONFIG_MULTI_DTB_FIT. We should have "fw_mach" in
board/ste/stemmy/stemmy.c that should tell us which device we are
running on, which seems to be mostly(?) unique:

https://github.com/stericsson-mainline/android_kernel/blob/9508895090960012f916561b2ede5eaf8124fabd/arch/arm/tools/mach-types#L3956-L3965

I'm not sure about codina-tmo, you would need to check which number the
bootloader passes.

If these numbers are unique, it should be easy to implement
board_fit_config_name_match().

Thanks,
Stephan
