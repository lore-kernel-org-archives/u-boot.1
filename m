Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AE6CC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 14:01:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AACD80F55;
	Thu, 15 Oct 2026 14:01:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P3ObIenAbMdR; Thu, 15 Oct 2026 14:01:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5693F80F5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072868;
	b=reGiySrIQNKCwBd+gyoVMTJ2a4Cc5TBMxx9qOzvSZFizT5h2aInyuUM3DJyXW+YEPA4J
	 YE/TR1a5oosxi/hFbdI+QecW8ObfXd4QpnMxGTk1yDt5txGu8S0G3B+nc95fI1d+Ityju
	 K5tAD4u4+ctZrsTlAso2KWyvEZDrULhd2jH5uNKvUm9dyfaN3Fy735Zj8FTQZ/piM/uqh
	 AyrMRtijvdnipxBKJ5OBy4Wj+2rFzmS96D4IZVtpQMKxw5Q6aU4easOIO2I9wBrMoTvuN
	 gPux6arJpV3C80t/hQstpovaW/DrlQcEH5H4z8JIFeIDTbBTg3BefsfHmJQ5f7m3JoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072868;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=icZgOnwwmumByG90DYYrM5wmpAxvhj6V/OFAinz3n2A=;
	b=Z49kL2ZBGK9toqPU/euOdyhzlRJG0FZ9ty6SI6oTaBxmoMVXhw0MFDqIms/4f68GKm/j
	 PRWoUmeGa/KVWCUq2sOuS6EJradxUf7Xp+zreTsXDkqvabzIUctojFOa213qPpI15iF3g
	 6ZlWWtpB2pHYc5U9EN/SNtLml5ize74tj2iaZWrbiyXd1cPz7VVtJVeEWxYZQn5qM1xXh
	 GKHwLT48clC+iEXKqrOSS6NgO9DxM7ZicuddOXG51aHDdb+nSN2M+AVL0wNvIDf+gRfLm
	 5ZfWTBFSp66MH8VwHgy51/TLBy4tpFHWzqRH3frSWZouCzWwjMQpT9O7e86mWcSyRFA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K4/HBDlL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072868;
	bh=icZgOnwwmumByG90DYYrM5wmpAxvhj6V/OFAinz3n2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b1/UUs9GSZqqPAMenesbSkyy2uAUWm7P5S7CUZWH9+2EAw2EexEDry4YeUfyrPIJZ
	 iE/azSGemlv0aCC9olqEAlS98tImOXf6d+xSGwXnKZ5MSkY4A3n7KTBYYDSx0SnOTZ
	 3lz3nJ/RaXtC+kAtWsTjgneGPtcG4fUyL2MQCzWnS7P0XgAqPtGvNNyEvEMo069UXm
	 g6iIzK2iSH5Oifu5NO9SQrO39fgdjd+bMB8KAy9AJM7NzUrlOD4DWfWHTGXZ5oN8wm
	 hzUBXUI34sWAGmkUw8gPkjMzeQ9USRjezzjYgGbudIXmTVZuyKmGVCHXBtBTnKz1yw
	 07BxD2D17wsEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5693F80F5C;
	Thu, 15 Oct 2026 14:01:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7620D2E0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C88B80F5C
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:01:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nPnmohghLbji for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 14:01:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93BD780F55
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072866;
 b=Q3EJ3JMAYLLLWRbt5CB/9Aq7STV8q6hpXNpwJKf1pXTX7gmlfXdipaZM160Vibz9E8zU
 h5p2MnNbK+8Bpf6arVRdC0ZZk3T8cbVjsIBusbFFmpdgsYdwDA1FwQp4Ut0+9/kT3CIHB
 IaJAhr3sw4yxBS2QZrzYggjN+NqkckkR9KEgj+1B3p2K3OXy59sTtbi+2hPATaMN3Yk3b
 DXQPCrQ8HXSjlYR8OyPzss3Nf5ktDm7DsM+uOyJxrd9OHSMwltjhXdxkKztfdhzKtp41d
 07R1BHWro4JehKtv34wtPXVIt5w00SKCEmbL2hws9WRC9MCKQCZPhl0n8ETLjdD0zKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072866;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=icZgOnwwmumByG90DYYrM5wmpAxvhj6V/OFAinz3n2A=;
 b=K6cWR5zow7HdA6+tFLK5Nlr8KgnLNPkkIzDd49Wlf/ts9MNY762wl8XN/GPPsuV7bRYW
 xYWDYj2iAzhyxPMT3DlLMuGbqhk40Ng1OcaW1G6u0X36nj7HlCouUgGKw6g/PPiBHgEWz
 kYHQ6uXnMERj2x6+Bi233a6/cJWl4ev7a5uf05fIZhXqjl0CJStlR3OAdemxgfCMhoBSM
 6ZgOCwkCSo9wGaqCFjd4TxACF034Jr/Gd6dmKuScu/sLKCfJkd3rKcDZBoX/KsZn84SeS
 aqN8SpuuUa5cfIrexa0+4mFq0JIEEe7EPQ9rv5nzEdJEcFmbQDLwrwpoYuhJuq+4e2g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="K4/HBDlL"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=K4/HBDlL
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93BD780F55
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:01:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2EC2E6022C;
 Thu, 15 Oct 2026 14:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B851F000C4;
 Thu, 15 Oct 2026 14:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072864;
 bh=icZgOnwwmumByG90DYYrM5wmpAxvhj6V/OFAinz3n2A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=K4/HBDlLCZ/mjXm+7BEoZFpG9kFpkzvR4vuH8Nau588yKvfiGXY0cizsEsSvkneqJ
 8rms64kkHcoqB0lJfXLPy1RxuyDHRX2HwaBZgpIxRtqo5qdcCJp6Y6o2SsiAOSRyw+
 B3zX6Iz4g4Hq2cZ5ooKA8+N6AS1yjRT1dm4STyOE08fBEE/X2wD+ndspVsoudeEcih
 Z2n2gX6unQhOmUrH+MSRk+eY0LkekN6nCdJi2JNXtthM1kXZrrqG0YEh+Uw/VJlYPf
 PsXSSIl11xLDj3eIxM2fAHIOsWSedFbxukNrW6n+GWNsett8LeJFiFBC5tWxB8vlB/
 5te4twIKP0iQA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.u-boot-project.org, Jan Kehren <jan.kehren@emteria.com>
Cc: igor.opaniuk@gmail.com, sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH v2 0/2] avb: Support verified boot from non-mmc storage
In-Reply-To: <179190423794.327417.14672541022250043617.b4-ty@kernel.org>
References: <20260915145629.995499-1-jan.kehren@emteria.com>
 <20261006092732.3577974-1-jan.kehren@emteria.com>
 <179190423794.327417.14672541022250043617.b4-ty@kernel.org>
Date: Thu, 15 Oct 2026 16:01:02 +0200
Message-ID: <xhkdb33u76p29.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Oct 13, 2026 at 17:10, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> Hi,
>
> On Tue, 06 Oct 2026 11:27:29 +0200, Jan Kehren wrote:
>> Thanks for the review, and no worries at all about the delay.
>> 
>> AVB in U-Boot assumes its partitions are on mmc. bootmeth_android accepts
>> any bootdev but passes only the device number to avb_ops_alloc(), dropping
>> the uclass, so an Android bootflow found on nvme 0 or usb 0 is verified
>> against mmc 0.
>> 
>> [...]
>
> Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu (u-boot-dfu)
>
> [1/2] avb: Drop the mmc naming from the block IO helpers
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/addda49825e13de708f8b8af61519cc4a465f6c8
> [2/2] avb: Take a storage interface in the AVB operations
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commit/ba044ad0c14b84b783387b22e488166828ea70f4

As reported by Igor in
https://lore.kernel.org/all/CAPzfCAah3xwR67hjz9Mi2E9CG-zcRj=Cdj8E55cH-0fiPA-XOw@mail.gmail.com/,
this breaks the sandbox testing.

I've dropped this from the tree for now.

Thanks
Mattijs

>
> --
> Mattijs
