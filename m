Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796B2CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 16:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0014460629;
	Sun, 11 Oct 2026 16:08:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MP7RFVIfPs1P; Sun, 11 Oct 2026 16:08:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3934860607
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791734929;
	b=kW9WAKwbDApyv9JDbHZCPD2YrWl6/NGs1vhoBgyR3CJyBl8AgqeAnCSjWFsG5a90+TzG
	 KIxzqhdi9ZW4hX5BZuYhX+rIiu4SNWKAFQMJ3gDdhRefM84xW7DLPDhxcv3Vf0BAdRQ3l
	 Ce+lIF4FPvAzk6e5er+DI/fx8htkz9dByYSqMb7ZuuoIYzMu6pA052ZnF53zPfdIPzGwq
	 dyvJze3qy1Zc2HMMT0iZSHQsrMkonNmA/9maWmo0JAqnl1TIODc8WO2ev7NuppxkpXHmp
	 qHx7K9sdjlwu1WiJoFU7EkFxeHftkvjTWCKIxeyLF5ABW9FFuSgi8O8WroTaUtMeOiw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791734929;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2WhyLaNGBM5oLAlFtMUZTEJAHbQleQEFNWj9trtuHO8=;
	b=D0Mq3qDgrDQPpzTdSyIN7O+C7ilbVQsy70yny2ey5jnr8AtPVZpyVv126ogVGzsqa4U4
	 NDr7h+ymWsZNSYF2XOceNU1nU3dZN36b7roQbZ+u9oRPuvh+Jl/GM7Z+cvXLFW4SIONyr
	 RAwp+Suve3N9exe7IXlmivvg4zyqKhs+kaMnGfifZ/zeB7UDNqBsShp2IsR24YVzGA4aB
	 jmBotQiF+MmbyX8rLoSCleD5BR0resXiJiKOHEO9MtS+7HGzGTlu4f2WMGqqb4t2ERlwW
	 r5fG1YTpvXYlaCSrnzxzSfRGEXZJIBDyHHzebHsVnNNMdxiHAt69I4iEuIJpo/Y3cjg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791734929;
	bh=2WhyLaNGBM5oLAlFtMUZTEJAHbQleQEFNWj9trtuHO8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YShKxOKVZPqXVSNrQlz/QAxV6BcVHIVlkTK3UCfODKNHY5d1RleHIsalwDh1d/iMO
	 ai18pj2QoMVQu60wRUg3oPCPw2khdDJMrJVi9pJhWQuvuSKBj8DJQffSnwnszGmElG
	 krtJxljsJfuAXL8n6j/0MiF3658k70jRkhBWgKieL9Kb5ti59lvMMSW9nealvn9B/O
	 kAVBaA534eCLG982ld+0vMxzoyjy+Vsg1xOTBPllvLTDGZZnXRglcwxRWRQnNhoK7O
	 EqGCaL6MTz/VAVMm06HYj36Vus4yMQRAcHAv8P0mdn3WMgGuvwRIlfD7JghP2dYSwh
	 pxvvMCJWFWlRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3934860607;
	Sun, 11 Oct 2026 16:08:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B1521A6
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 16:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E5BA405F8
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 16:08:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8y8sRobhZRr for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 16:08:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 54A37405F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791734924;
 b=azQrFdUMr32kUWJA8Mdvdswi1+uCFlh885pG30dz2Q2PVz5XADOntTOTn9YSf2kaFfm+
 sfRfBIBLrkV+Bz+ks3LGPGjm/6aUAeQfj0UKDXXknYiNErT2CfG7lCnnpb7cF0WPpM0Us
 ydYi+obdlfVOdFaws+cU6wUzg9uQrzrmMdfjiHQvhJLLi3IU6hNBmjXn6MMJNq3FzpKG3
 vQ+i9eOZnzncrkoBYgRP2m8ZvLNrbqR8SCPzTrgDCLOwDdtJ7avBrisqj93Vq3md0Pqdc
 KxLAPNT1qFq612spfuy5DZNMX43rx2X9TJ9s4IpmBuPAEd4L5kL1wQJAAf3LavwyP/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791734924;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=2WhyLaNGBM5oLAlFtMUZTEJAHbQleQEFNWj9trtuHO8=;
 b=hvsbNbH12oCTU7BnHcIGL5qEtY3XzGi2QQQ2Gw/eR3TERpCIY2e4ArwlBMh3RWnoJy3k
 DN247Zsa2sLBv410YGVQASzSGPl5bpZRcFMQj7aRuFOWRuFlqmfoywgeky7xrzvQi7uOH
 P2bcY2YM67VqUKW1XYhObABgi40UZIbqVJP34akUKjhpLVxL+ofVkGDbVqw55xGk37FKM
 irTpW6rkiFJJNB0FSGbfN4hkuqCPnDc3YzNaQa0icBelq/9P9jAZvJNkFU1wOXlOrGbhF
 laRJZQBLcOXmqjM6cNfPxKZlt/aCZdYCrzuzwC3w7G+Q1GlIXC/D7n5jAwc1zaLzi+Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mOfx5GQX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mOfx5GQX
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54A37405F4
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 16:08:43 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6afa651700eso1703199a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 09:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791734922; cv=none;
 d=google.com; s=arc-20260327;
 b=IpuWiXnFinXCMToX9un+/wmTLhJl9rUq7jDBO0lBGq0ZxowIg00VqRXt6cK/9Fb++E
 d22ytoEPayK7fDJMOwoF0lhym0/hTYoDkml5Jam75axPLsJ/+W24nZAfI/dP0zLkfcN+
 cqIem7LTl/kJhwL16BJpxIos/katThZBlys8WynyVrsI3JJCFrj0zY71wA1BgSTbU6dT
 vvzC4ThLGGinogwn5aeRIWhFsIVhLGXyzUaJVPVJKIO+dqXP2xG4c8oVcPqf9MR8X0op
 44lIPzgbBEb+F67lcw6Fweg9MDDWwAs2XZIov3RzhF+wG9fZ+SR3d0d56adVsaPrqwnQ
 Hhww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2WhyLaNGBM5oLAlFtMUZTEJAHbQleQEFNWj9trtuHO8=;
 fh=hV6pNRdTXKEDGRNhPxF7NmUqcl82B+S6cSuGWAoOpPA=;
 b=r21hXe8WX95Lrzj98M6h++LNnuHm48wnm3liPs2YYpbJbdxyZzQOZ66l6hXbdmpy6i
 /7gOP6R2pySLm1Cxon8x2SuFhzwhIaQaHrDXU+mJcpq/Iywe8eGV4xEBNBjLQf1KMuir
 cXi3r5YAEFbEV7tLH3KJhzKbvfC6lEWYs8mD+wRYdly6mPWStd4+EKe/DdpY7J/AUOCz
 tJDDc1xxa6ACAvMjHPArL1qxaq/+yxR7wzpUsg8ZuduB3SI4q6Oh2bXrVdXzqH8ZAYvh
 XAzBZKRbPldpUUcwb9JIkDwfSSGrmukupFphXhSU8BbyBX4++zhSwd/qqNhYyBviyB3Q
 4u5Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791734922; x=1792339722;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2WhyLaNGBM5oLAlFtMUZTEJAHbQleQEFNWj9trtuHO8=;
 b=mOfx5GQX6KZcFEGBhDyPhyZpIe7OiYlJgvgrZ+ftE0R2WnsztpLQQOSlOujLEa9+FG
 H/yCf9FkgT/zyVU0dE+tCt5F/MmNMkGv5VM+asuaXSvD0GU50Kg5iU5XvNdFJcHcIQ23
 oLprS463S6cQ+mVe8aHxk/EBixnK00tbxg39E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791734922; x=1792339722;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2WhyLaNGBM5oLAlFtMUZTEJAHbQleQEFNWj9trtuHO8=;
 b=adoaWuQbXFnNZKy0cPhiT62aAlHe1+DP5wxGC30A+229KYzEnwopLolAM/0dTb2Ks2
 ElDpX6ycsd/EC++FQa3HeDwpJoUia8cTPHKvkJrKUE1jeMi2UWCtDlyBpNGKQu+JvezE
 0MD33/eCOlq/173iOKU+ZIakTECl4l1QK/2mSPsjDLsS09Quej6l4xb6R3I5ynO0Cztt
 EmJ3wWnc+cp9vXOxpWBy/X3mtkoWG99ixBtxFAEl9nGGrjzgpjYNTwckG67MYXMLEfJE
 I95zKHdUBzInmup9jRCuVTvQrZWUS2FAfLh7NpXpIErqiV9cw1RC7jSi7sZnWSm3v1Al
 ivEg==
X-Gm-Message-State: AFq9FYKLXyBmUnyMPZhkY7uaor877Nx2M8lDe/w0D0c5ZuRBkspsc7L5
 aSspi7jjtFkEObd57uGxSFw3cHI5gxVj0P8jnWmZBfv2y/bECqlUsirqi0wjew4zQOEvRaM4kEs
 gHWiF68UDZYjQ17hpSx3AdcGhg0i7Hc0ifBXI8WQ4
X-Gm-Gg: AYBFou0SA42FkpKzmfRymKpB/Abc/HCNsPnK42YJAgpaYWC1G/RNQx0mq4RnIM2fiBC
 qC8nKNIKiW805UpIbzPQTE/RDThuAbk53wKLVIyorOvcBwN34UhrtqBXByt3rDvU+nXkYWlJKrc
 PcBcGkbtyYXtAnHshSihOTQM8T12yHgRsbJuilSvT9H0F69kj0kIVckrFMlSFJF4shL6oJaHcCR
 TVdb6FDBbJnAIw+2ql/SfAKua/IuVF383WAKAajucRhGavRFYYN+Zz1giFsfzTzDmcUI9HPKKkR
 AgYk2Zc0Tk+fq45Guntqtcl9HiBu6O1C5J/3Fu4mdfQpKfowWHYimfjhbCF9xD6GzRw=
X-Received: by 2002:a05:6402:5285:b0:6b1:497d:1c64 with SMTP id
 4fb4d7f45d1cf-6b17c293eccmr6759357a12.45.1791734920423; Sun, 11 Oct 2026
 09:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20261010-gpt-4k-v3-0-89fd290f85cb@flipper.net>
 <20261010-gpt-4k-v3-4-89fd290f85cb@flipper.net>
In-Reply-To: <20261010-gpt-4k-v3-4-89fd290f85cb@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Oct 2026 17:08:28 +0100
X-Gm-Features: AclHuK9cj8J0QuNkPoYiixvhYMys5un4mmvf6kz_MMB16utSqFQcBVxpZU-AbBQ
Message-ID: <CAFLszThav1M0EVCJRV25Lo74gtK8U67KxFMNrb4Bf6TmyMQXbg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] test: lib: Check the GPT round trip against a real
 block device
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Denis Mukhin <dmukhin@ford.com>,
 Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>
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

On 2026-10-10T13:11:37, Alexey Charkov <alchark@flipper.net> wrote:
> test: lib: Check the GPT round trip against a real block device
>
> lib_test_gpt_blksz() drives gpt_fill_header() and gpt_fill_pte() with a
> synthetic struct blk_desc. That is what lets it sweep block sizes no real
> device here can provide, but it also means it cannot reach anything that
> touches the medium, so the protective MBR, the header CRCs and every
> conversion behind them go unchecked.
>
> Add a companion test that backs a blkmap device with plain memory, writes
> a table with gpt_restore(), reads it back with gpt_verify_partitions()
> and parses it with part_get_info(), then checks that the backup header
> really did land in the last block. That covers set_protective_mbr(),
> is_pmbr_valid(), gpt_verify_headers(), is_gpt_valid() and
> part_get_info_efi().
>
> The two tests are complementary rather than alternatives: gpt_blksz
> covers the block size arithmetic across sizes a device cannot easily
> offer, gpt_blkmap covers the read and write paths a synthetic descriptor
> cannot reach. Neither replaces the sandbox tests in
> test/py/tests/test_gpt.py, which exercise the gpt command against images
> built by sgdisk.
>
> A blkmap needs no host filesystem, so unlike 'host bind' this runs on
> QEMU and on real hardware, which is what makes big-endian coverage
> possible. Every blkmap is DEFAULT_BLKSZ today, so the block size stays a
> parameter of the case table with a single entry, ready for a second one
> should blkmap ever learn to be created with a block size.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> test/lib/part_efi.c | 170 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
