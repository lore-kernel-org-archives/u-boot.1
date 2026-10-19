Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996D1CCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A60D80FA2;
	Mon, 19 Oct 2026 13:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id omnx3cTDrZif; Mon, 19 Oct 2026 13:16:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AC20880DB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415816;
	b=tEKKbtcwc8LVF5+Ofcfz25VDeJHecYD82YztejdvKB7/8qSE3v2dMxDfXk0diCLDXNSD
	 8aqiBaC2sdba+1P7aSG0edTuiNXfufsxM0uHL4bRerd7/RmW8Bo7954JBEjUTdLpI01Ui
	 Is5tKerrgA8N5ugOOfZY/QRMkPCuqVQYWIbsDNlVffVvwnBhdG3p5Y+U63CYfP1zop2xe
	 z1zBeKYiSKpId+uZvIq3JjlZPR4UzEA2ngt6nt8f4jraz6VO9sRz3nPFpQiakLpnmqwHm
	 eGSMz9QRzedxBhAHBs8jOcF5j4VZBTlr5BcBwHE86m6IJ5iaLMIc7aNDXy7IMnk+m0g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792415816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=00TDSeqjrjXg5CbBSqqSt2BsrHA1qHryWWsfCwINKes=;
	b=TqIIbNnVTxQ8T6Somsv64/BHtsscmGPju8OD0iMPGwtCRI+w5S9K3c8ghjBOvQSWJeqh
	 l8FgLyGhOWfvaZhL5PHn6zi5WUaPUxz4dqvtiM/3TKALqIGEP3YQb4Fp1qJQgdnRDTCfq
	 Pdmk9aqAC21BThCr5goXA+LNkYgqG53AIve4VIc4EXuUFKnOxXkwm5f9DxLJDiSy2X+ht
	 cZsxEYOQZ7E6qbi36RTbbZqhx0eBkh0mqBdM4PwtDjMn/ibIsw9/uG7H8YxL8L0WN0blS
	 UyG+t8qdwXpKzVLNkIziCNKXcW2u5kdWUdbMz/c4oohSmFo4SzV2ksvCaQdeGgZaCMg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Xp3xzx8h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792415816;
	bh=00TDSeqjrjXg5CbBSqqSt2BsrHA1qHryWWsfCwINKes=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s0HenfX568l1NW3lBSILxfxsH/uOSXE3o8E2R4vuuK8Z2zenSeAPnjV4Xn5a/tT44
	 VT5Bo6O1R2oTn/xXrCZrq1tz3SyDYZbirgUolfrFowGr6NtrUP/U1JoPKamJ0lPQLk
	 EbaUPduvsAg4f+2kYH8wFS4xrNC0iVvgsDDBatrpItYOklRQhrL/1/T1aTeslghweH
	 JOjE3IpUxe4dLUrEgDT7icCrFNcjCcvMXoaV466D59QYOLnr/T3ZVazX+DLjsPnY49
	 TM2VOw4gyQIr851xsZ32pjPth5EdWB5ovgSfBDqDaHem4WAyIpuQ1/B+fE2Okdwv1I
	 gIKjWQ48bq/BA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC20880DB0;
	Mon, 19 Oct 2026 13:16:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 756B91AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B32880FB1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8QHUyN1KgQCa for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:16:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6E1F680EED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415811;
 b=m3h6emrGiSdLgpDKCCRocQ1e/VHgr9xnlPLzCFioLxZs9HQ4Gyo5DM62mu8O+BE+sK+U
 7e1zhgpcN2jI3CjkyQahTWMzuhZwT1F9wIS1oLO3V6WtCODymPEEycvc8ZHjbVl3o58G0
 HXnw64lmSV9KFgxhIyqVxUjS6LszCkiZLeRWJPB8mTLDlpk6/6FvgDtPoTb1j0DPq0WTt
 5f8ACtfXanTkg19knSC73m7mnBVk3QD4rMErUMinm/09JjlepDh4tW7iTHuVcBCFvKiYV
 8UAQ3Q4FQVBB63TmsxqYiXwOShGDU6GzLPSC+JjLDugDKy2BI4MBBSMZSZEZexfjHNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792415811;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=00TDSeqjrjXg5CbBSqqSt2BsrHA1qHryWWsfCwINKes=;
 b=mQH7yUAr4lgSAYhBfVwvIO844k+re9KP/Dizp2Mx7xNHD9VqbIZuF+2Xm/xXQA9XYSY2
 H7rDmuoR1upW6Mv9+ZNJ2HUkBtWM8olgFQ1QBaeD925XiPIxnExmyVwpZzJUK6hVJNWn7
 uuNaEeLaHoRp23Wi+mVUos87QF8hIc6P5UxDXcBMBTgkWgZnUmRzlFAfuS+ddYL269Txj
 qOltbeltpdYyiBxtSgFpd5Cpx2/PXjXTiYAzsVLCroWS5a5Wg+LKVJR51/hqXkYxGhwcP
 JTWWxfFvRRlX1YkiBBLqav3iXn/gED3VC96/NnrsfxIhhJyMaCMCuXderKcN+wjkryg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Xp3xzx8h; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Xp3xzx8h
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E1F680EED
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:16:51 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b170129413so3276066a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415809; cv=none;
 d=google.com; s=arc-20260327;
 b=HJj9G7su0VnxEFmPImfosdV12cPHY1SeLcR/IrJZem7MHIPgtAknr62d5mbGI7cBxd
 Z23jaQQrV8k9qlGp9E9UcNonojnszwV4x7CB6MHO0ced3s2DGq0QRZTVAJiiKK7TE8U+
 6VA2+XVQ1WxY2phx5Ct8D/WVNqtrsAARsy4OrmGeZr5VuPlNs6e2+5FtACVwFVBhm77o
 rGikZ99LvvC43+kZIZqwAwxVXWYJN1IymnCAWSDhfrjakfv+N4ZJRinYka1DxBL23rHE
 bE33Rn2+6/qiUEwbmcAXKV5EMmiIOyCtPH4tHypf75wdaYD3BRfNd8jH2mGnchheMwGK
 F4lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=00TDSeqjrjXg5CbBSqqSt2BsrHA1qHryWWsfCwINKes=;
 fh=Fk0VSZ5VdlyMUrNg2UpKepBiCrErf6zgWj0J6JDR/ro=;
 b=VsyV2AoCnzA9KGi2eeEq8b6GH9CD7BoMA3Ik72AHBx70esfsptvCxgMJclR/oZsqVj
 RPVXkHuPXJ36NIlZBI3LBTQjjfY/LxmcSh1Ns8/sRJXYmcqWNsd6+XUix7e19KWuGb5/
 77/H/rGIX6MLkNgbU5Bc6vU1wNJYEKAe+aTnieMqMpbQRX4s87b6B/S5cIsvp4xixO39
 yqP/j2/JdMw4hPCBsJQqim6lvejtyR1zqbcg1hybmkyGOPOf8dcYbYdCS9Wios0CA7+D
 QgyP8hZa09KilkRbvEBUBI2RIhH7rddfFsc2fLhKn9vIUZM6fFqlRbSXG8GEGCdfIWOT
 8Bfg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792415809; x=1793020609;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=00TDSeqjrjXg5CbBSqqSt2BsrHA1qHryWWsfCwINKes=;
 b=Xp3xzx8hCbtMK2GchjywycuBiNCUSKxAX7nBIbYS3Q+9vMmobwgG7byBJAZPSkf2EG
 0JJ3Z266lSqSVIqLP8m1uE0L6hMB5Aqd6xzf5nQcDtngYpDwnkGkrmxr/fXIimecfShj
 EfYzeulTMcFgv/ZZAD9KKeLw6lictHCb517Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415809; x=1793020609;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=00TDSeqjrjXg5CbBSqqSt2BsrHA1qHryWWsfCwINKes=;
 b=ykUb8v9L/HohzacOOGZiEzKv8cBuCMZj1QVuAtTVvzP8MUMnHll3WMEwC2EmEaol4M
 c+rDNqYhhd+URDd0AP6RRngGzQbxdL/01Ai9sd0edAjtxDdXqvW4WGO7cSpOWFaqNuRz
 Kfm4ijazZrTJgFuYEOjb3C67BPw7bCtp2r1ynqR1tHOh4ebsqzI1eqtqwrl9c0Im7DCt
 YmWO5Pbacek0aJHldvyp1aTQAzZd9Q5tZYLvVmjoYQhhejC7iMd0xo+tjOX7hNMsFT3U
 o4+XU7LRFgLbdrb34Ea6GgQ8PL28i13DTO21E7h5om9p5H47CBeMYNbyoZsaAKcNwkdy
 mm6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUphTGkwhnyScbjeyI65OgwKi1LfA4ctCtP+SBH9xnNNcXHjRNaoKyPEY234UQmZRSHCzJ0+o=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL0yPTH3QjWoau9ef1TvTcavHkPqhDRk1tzS1qs4ZfkU49xbXSE
 kYF/JoWAUu6IhHGQWtwNklhV+mJU5/WnTvGlxotRR9W1FkdaroSuxvwxkwow0gxry9F46Cj/abA
 VaT9ZBFuGqx3eGFpYNj2RV81YVSJGDi4isT3VxVXw
X-Gm-Gg: AYBFou2af4YfZB/Aa47zp/5r7Ri6grb1SnmBKKyJAS+K8+/duDLWyH/6ohLglZx2NtM
 lg7sw8KeKiVB0tFx+8dINo8iDW8HQ1EhG2Yo2rjOGnuLlOSs3MYPlhqus8bCP1mqKj6dFzLpVPp
 ODV54dgPfhYKRgxmWekswObsfrXPRIOES0IZvbmb3sBo2FvbAtsEAwtplPAbxTCQVitIwtxARQw
 dUih4nGUBetE8muDijo2AFYiju9pjwH5Yc6xLjX9pyaKjhntPz95TTaR/B9UdlxlDp80r5sVCMt
 GPGuue5zo02F68yFnla4T6FtvbFBPKqGCWzJsbaOjS58+GLIm6AGCw==
X-Received: by 2002:a05:6402:501f:b0:6b3:c810:8f03 with SMTP id
 4fb4d7f45d1cf-6b3c81094c7mr2344421a12.22.1792415809361; Mon, 19 Oct 2026
 06:16:49 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:16:46 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:54:52 -0700
MIME-Version: 1.0
In-Reply-To: <20261016065500.137544-20-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-20-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:16:46 -0700
X-Gm-Features: AclHuK9RBtHl0X27PVQwHxMjUJTULHxvZQlP1j18pXFfuea2C5Nd0ZcFqxU2M6k
Message-ID: <CAFLszThp1K2ijNdKCELsWBjKfF=0qcma4ep8D1HhY+w5YBT5MA@mail.gmail.com>
Subject: Re: [PATCH v5 19/20] MAINTAINERS: Add entry for LoongArch
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
> MAINTAINERS: Add entry for LoongArch
>
> Add an entry for LoongArch-specific code and documentation. Jiaxun and I
> will maintain the LoongArch port.
>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
