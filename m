Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2516D606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xehHS9XN;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RFg09Qnh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 033708179D;
	Sat, 24 Oct 2026 16:14:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6GBGS3Ha4iw; Sat, 24 Oct 2026 16:14:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64569817A3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792858461;
	b=iZLjOJcC5O8NnPmi5HTeK8/A9GbXc/sDB/lRxP9hsde2EemPDPwTiMcBX6rThGwcgqQb
	 JABJj7/+Oaz6Cem2Q00v0638wEY8b55bRDJFoil6pehHLowL2/6OO2ofpypcACEyl3dEG
	 0WSmRY13BISRaDorlm/Z122NYFnthCwKpBoyjxUhG4egErqVzV+Ax8VaIH0UdfsbekjWn
	 MekB8cyQfigKmw4HUJGdvR3P1rVVHMpV5C55/mBXOwbl1B0STo+Os4/t1kk2RuXMnBvCP
	 SV776wBLaJkqvY9NncT95+sApvsDlkgn/9HbC8hKKo5Eq+yDoYdQ9GyAnsSLB+IMlXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792858461;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=R7mV9vvTa5Rp+lcruJ+NMKthqxwEnLZHcvw9guJCFGc=;
	b=iVcluvBqaE0cwdgF1ocTmlE6V3oQUjMX0lOUuMDogClLeZmGLTacF91aUahLLiUHKQ5N
	 7L4ozTZb5fKQ1I68plh9pFUrDkP2x25LZ/UYvI8A0m/2rgiKfxeVaG8ePJDC9p6LzbdwJ
	 OJ4xMrCG6BvZDKMpNrqhQdVjlsHLuUoMFVMfOUDnylUYTAnPZcn+Sw4yxqmtwupEK71ep
	 DrQtDiIlopyzdLF2EWXnk99Bx/aXEkOgI9w41N1YOQpELgRIO5byaCPsLQXvDiHfOOwo2
	 ua4Hv0NOqbcU2/5ELElhPultW3I2b5hL2iUs4Z5XXL3ASgpxi6M59hG/w/mP75Bl7lw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792858461;
	bh=R7mV9vvTa5Rp+lcruJ+NMKthqxwEnLZHcvw9guJCFGc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xehHS9XNacjclVU2qZ3un6HW4xpDAFf/Sl4HAiA/ye14oY5hxKZ7hoVXJi8S7phMt
	 4HH0zMWhPfEyK1O4XUQ6sqVsgg8nOeLc4SP9vFu3x0lZb2Lv8BsHNrnkhsAeBzzDhd
	 1tDKKMC5TfWHiKquZZv2LQWc69ojOVP8m2i8e+tm2YUQxXtNg+jLqwNty7Gg8peVvX
	 ZvPv8xrsKjZRFxIjbjKXTN5F+GquQDq2UfGvgf9ljRmGLk1TmlkUAYjC3S4BoWgNXo
	 buAWWfufBr5dSuTi45nBpJPodq7WqJEim5Fm0GaNwm6Pdd4Rt1qx5XToav5irKtPAE
	 TFZpKtvuC8C0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64569817A3;
	Sat, 24 Oct 2026 16:14:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC3DE380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 16:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD9334089E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 16:14:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mKUkJZA0geqK for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 16:14:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 36B7A40873
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792858456;
 b=QpTDdtM6e4F2Jr8lwxI/e39SicBTNWREaJg0AkT73Z1xkKyVtTq17ofXq4lNX7zf3xjf
 lNdcukWCil6YwPuY/DFQZSclUYZE3tai59rsRnt4gGOo3k9BTdU0L9eDFDoFWlLXzYhsW
 nYPkvRtSs1B2MTsa7eZdH+S4HGoI3EB/tObPGlpl9s2U0mfu9Lpao5usLMCbiDzw9d9Hv
 ceSBb3Ht4JAUBXnVgvSSeQekkX5Of16jAlklfq+dLX924iXR5o1Y3e0WdDor9yhGMsS9+
 BGik9WvhDVXJcgAR89HUhCTdnwzjKptdcoi1l6zLLC6XaAcSf62HMjDMol1QEdjdh2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792858456;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=R7mV9vvTa5Rp+lcruJ+NMKthqxwEnLZHcvw9guJCFGc=;
 b=KTBu9NRMXXxRHOUwUw/weizkv+vRmhIqUNZvA/kFPcFMIaXkvjk0MSrPxB8fzrbV+Gmj
 ahsXbt0HyJrBIJHwqLpc/OxGStMbMkxP3809TUhfxU86QSATWW5gvEjNFwQlUxMuQ+7QL
 1Vs2rpRavaaWvu0NvZAVKbz4ME8jEmfAzzgADMAjqOEdlGA/Ka6VctrUU+9FUJFrWvsR0
 mQAuzc80CEEXxdkTmCn3rd+dxtJ9+LBjuCc4nPTNawRQOrtwqIcEW2Hj/n7lbhCJCB0yj
 SCChosD+WC1ROViUuN4Pl/Tzm4YfIaoI4lW9ljQe3roCYdxNrW3OreIrcazBqoauf8g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RFg09Qnh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32c; helo=mail-ot1-x32c.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=RFg09Qnh
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36B7A40873
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 16:14:15 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-843a4ca671eso922563a34.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792858455; x=1793463255;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R7mV9vvTa5Rp+lcruJ+NMKthqxwEnLZHcvw9guJCFGc=;
 b=RFg09Qnh1Q0TuORiC+sCwuO+gE8ZB7eL40p498AF5pvVsvA3gNkuaBxQjWQokiSZ3U
 g5kHvfN6pFhWTu4CaPao16tBHKk89NAnucs7GlR2XhmZEXtY83qkw/H4Ncd86uFoRNi4
 l2sCuVFHXragMg/FKliT+wyBcTM+vHYbsIbaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792858455; x=1793463255;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R7mV9vvTa5Rp+lcruJ+NMKthqxwEnLZHcvw9guJCFGc=;
 b=tWyczJShEzewdENelphXPYo6qIA8aobV1Tg+u8jFmts2gEDKTh4ixTWUkNQa2SCcLb
 1rFqitPxIlJs0JRS5RN6arpGKtuvfTe+oiyji53Bwia4zrYXntdDOmJXNpyNbE18A4Ox
 tr4HOeWSa0KYzISwynpVbpeRm+aXfBzuU+Ivj4lpc2YIShiwSMqgkOjikqV7P9ewgOEM
 6oL2+91RugPVx/7nUiaTUfwgtdaJVbibxRwrOgjQVu/FN9xvz3zoF83bJLWJ5LAm+p4D
 V0dWo5PbmslKieXWP3ObJemm35hXmGAIFYQ85b/mR8g7EuC/NfUvI0Bh76NEGxYkBio8
 KYHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZ8Rif5s6EWCPmT+TvZOuCqqX+RCq20G8JVlLcEKnqGYDxHJtZaWt1mu2PwiaXrna3nT6KUiI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKagaqvJt8sTndotyZI2+Af6TGiLDx3nye1IkLqFifHe1B4TcrU
 PB2YMcVL8C2UXTrVVfyqRCbn76RENSavo+GuGCf4fOChSC/u5rPdFXpxs6vWjmRIY/a6wPBe3gE
 +119v4wa2pgKC
X-Gm-Gg: AYBFou0JzTv6R9lzua80IvzQBeIwCpHF4K4r1zt6u13A1joerXesE6pH87QM8JOy5aq
 xon1M8eQCdwlPZSjuiVH3SUOkFN+9WuNGL54JlBOBxl8yjFfzYJgDrAJUf3oE4/UskndntS9rei
 d5W8lNiLryeefv3PhRcaj6ujEgZPmVZRRqjJmq2QimCtNz971DVm3T61kvooHi9wG2yjRNFKopV
 3r/256DFtIiSdXP7i9y8CHV0YiKR8Mjh5/FeiyxCM0IvbnqbOgxqlYEyUJQaW5hFtrcGOm7zKbp
 Q0ISPYHqPNmMw0xCZ0YTmtYo2G+QrVVvl4T+6ENW84snrRB9Ej02cyrPxhkE4I9INe023Md3SIv
 dEvhgTWBA4Fk2RogOC3FN+PyAkd1GF2wWFzRexfwW/2w6iq3X52rbkgNIw24aO1PZ1md7jApD1D
 MDcMyl1TLAnsNdNORDZPUJ7aKmMd6aRmBbIC+XeYOK9gNrKf08nAH+wxfeblpoFKs78kFN5K0nx
 jBylsTGQLOcB9Up8A56YWTR7pEbkTRvzG2578P+jf1c8cENEhN0X/rOJ4tqefjuEki7BApK1s9y
 hlnXYXoOW83QbU370ke4Dsi49LCVomBDAIO2A74RAjuFoDhEi2vTXUTfKKZQwoMyO4a6jIoPAPH
 o0dYs0sU+zyAfsJnsXuFVLeudnxrDBnZkwjCGMgEDKbggQrhUDchyDdeN
X-Received: by 2002:a05:6830:640b:b0:812:c5fe:5e4e with SMTP id
 46e09a7af769-850feeb3815mr1664652a34.19.1792858454879; 
 Sat, 24 Oct 2026 09:14:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850f8458d8esm2652012a34.1.2026.10.24.09.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:14:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com, 
 Zunyi Hu <roberhu001@163.com>
Cc: frieder.schrempf@kontron.de, u-boot@lists.u-boot-project.org
In-Reply-To: <20260612144121.24973-1-roberhu001@163.com>
References: <20260612144121.24973-1-roberhu001@163.com>
Subject: Re: [PATCH] mtd: spinand: winbond: Clarify factory BBM offset in
 OOB layout
Message-Id: <179285845352.52652.13131373983035206428.b4-ty@konsulko.com>
Date: Sat, 24 Oct 2026 10:14:13 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 12 Jun 2026 22:41:21 +0800, Zunyi Hu wrote:

> The Winbond OOB layout function offsets the region by 2 bytes. Add a
> brief comment to explicitly document that these 2 bytes are reserved
> for the factory Bad Block Marker (BBM).
> 
> This eliminates the "magic number" and improves code readability,
> preventing future accidental overwrites of the BBM area.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] mtd: spinand: winbond: Clarify factory BBM offset in OOB layout
      commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
-- 
Tom


