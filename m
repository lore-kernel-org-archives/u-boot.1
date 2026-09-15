Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C58C88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CB074062C;
	Tue, 15 Sep 2026 20:35:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WoQvweRkhi_1; Tue, 15 Sep 2026 20:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5B78240603
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504520;
	b=mZypXWVdEfBhHKs5ntO/6roWGozuNuWzBOKgjrgVHF/RJC0U33kZ28lZRReA2jGkJWmG
	 Ff94i7fbJHWinpjCjXHArhopjr7Q8xlu+2OTSaHt1mgFvJNglBcoNPtXwjT/ySIfBi3xt
	 n5iXOpHPddL0duZab5G/vp40TBdZll7qRXA/yU3qyxVQA4eO/mfjoQUNe4PG6K+i3hncZ
	 8QI6opyUu2qikq6eiuyL01sO8HcpY8q33vHFn0rfjS3ZwGWPuoWSegUJaAN41qZDHS+3b
	 ou2a/fszCjylVXJAGGlAjVX5LFjPMfvMfmIb4nFJmfeWcLVEAr9ZOBTLspyBowNvxUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504520;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BE5YChFo16WcedJbp8kMX3Pajb6EF6U6eyDCfDBQa84=;
	b=LHRFlYpsZzMeHXxPrr5UdpyIdmfm8H2l05Fmp/8xOcdbWFAhwfU+IGuCH/h7g2k1OEiQ
	 c6+/BAKdqvDwr0C2cjevBXZbejbUcV8DczTXwp+FZNGbXx/RARmpn3u5dDTxS0OSu+XjD
	 huBMxdfYi5Gxfd2xzwx2RuJAt3C22Cu4Ac5jSOHmJrXo1nkcL2Pm4CMgWHPeuUvwUHw5B
	 2vEaohiURFPji8mq0Y4+OoQ6ZhPgj6VxMIuKBL5uyolrTUU327OcMAD3Onl+Xd0Q+NiJg
	 tPaJXeakyyvrNWfIhuqYs1M+SsKqBa1zf+m0MY3305aBUTafKklsFkyFU3HAb8fDdbA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504520;
	bh=BE5YChFo16WcedJbp8kMX3Pajb6EF6U6eyDCfDBQa84=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m55R7VpVdmSyTuz2DI/YS7pMaldAvNd+GAtMn4oStdEwi+2/IKXewUvv7A7Yr+dFF
	 Yia8vN0ggECjzf648Jvi1iOr5Bp8+ABLJOZDwWumpvDHBS304eUpbiAVDUIIV/Fsf7
	 w6BndTxPeQhSfeZ8XQVy77wHM7hEBE3P8GxOi2C+sspLHQUhU5w5Y+jsH9//wyaxNh
	 1yfrvIqjQpgPlLwIpg6UERLGhkfUoGsVVm/KLCXVCzqmZ0/X4m11YD/pWG34m4PeSh
	 MPMLTfdgfKzOeIFwpmA2Al33G5rrdgLQHcaLXwLMCgepC+7SMmhv0NYdoDLeMTlMf3
	 aBTZ9lmO1U91A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B78240603;
	Tue, 15 Sep 2026 20:35:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B142B23F
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9680C80AAA
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uGFzXv1BFCJ0 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DD04080969
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504519;
 b=C2/5Q37cxJhI3FFRio0P8RJoD3E551TMLjusfqUxLEqzY6wB1ziCnXYfC0Xdn3IKtR60
 iwZShQYkvyMyulE8UmHZ8PjMeO6i0vFtLYSPNkXsT3gxow04YSBLLN3SfyU68DFDBevfU
 hejiTLRRPjSSWFS87w0awD/jkzXsL5cPhOiOssj5zqY2GeqBS4MJOD/sIwJWHL+VSzout
 jfqz0WRk72qN/pV2efdKzFdMtEcropRFfL/3j4EWxdL9Zs8Qo82IYyXUhu5TgNsZv0KXR
 r+FwSBNy0sb9d6eD/ZNHlI91G9J2JR8mghWl9gWu2WFu/dVUyRepffhmWI7snaBqreQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504519;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=BE5YChFo16WcedJbp8kMX3Pajb6EF6U6eyDCfDBQa84=;
 b=mxre+r1DocUf5G9rtDdxhE/k6M6InyDJAqIV9T5r0S6OxB/48oFmfKDuAvnT0Im7pEXF
 ljxHoMwV55EzFELuulV3IspV9LoNqfMswKGC5BcBbqZNVPRFVXaa4FcgZ4vYXTiwFvxQM
 6hWZFeKLWYUrg87GOh98xrgGjJaRstB5keH7owEB+otvcjMug95K5UUp7fC3wy1A/xizf
 UlfZ1Wh/bbeH17MdKjzjTu/Bt9sElcqpgB2E5s5uOBjWF0wPCYYEQ8v06NgXCyl2JcZwD
 cYFQhMlnjdzoMsoWsOmESRN7qv0T3P5WKNoyO2Ev2Uw4g9+uANkwhIppAGkS9dJjCOw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Bo31LmAH; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Bo31LmAH
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD04080969
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:18 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c2c08ff3f8so207013b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504517; x=1790109317;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BE5YChFo16WcedJbp8kMX3Pajb6EF6U6eyDCfDBQa84=;
 b=Bo31LmAH6dYWiFj/tUTq1nWmjr4IIQrXNN7ZR8vgN32bdlOQw/h0p5DZgh6Vc2Z/j+
 YFv5znrq1MuP4NtNVC2QpcKB0SLJX11XRIK5eAcf2WBIgB3yfYBRmhDG8T9G4giY/Lwl
 Qe3RxhFNcZBDA3F7W+PtmBpPSy7U5XJ7AJjYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504517; x=1790109317;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BE5YChFo16WcedJbp8kMX3Pajb6EF6U6eyDCfDBQa84=;
 b=d96DQdEDDCgcJ7Ol0wWcRhp0jfdjp9lSgoA64YONywzaqTdrSZhTFyNC1rqTZkcAFS
 9vY97lUHwWDiID7UJd3rqd3pCAXkrEcBAJLXphEWU2Y0aJZ096eUNAdpQ87tW2gQW+H4
 wov2+nXOVAF6nrmIhMWSNbnZV8ar4WSac9neEujuqIHcjq4YgpY5zHY1YY8BG+fIZxIQ
 3jo3/zjGgiJQHCoVgF4s+xpaSOsH71UCMl/tAL6RLkPOg0oYR7JmDT59xEFedQjrwhaA
 Nzkhm6TUjO8aq0b+Fl8fn+kw9APc1ELpshIylM//labPRyTXqyUZoDXmeX80XudiYOBg
 b0Ew==
X-Gm-Message-State: AFuF++l3qbhQBl3T2/qvUW/1wMi6O0cAPCt74P7M9Uudta/3i6q2UP9S
 dtkag6iWdCchezmfy1k0HH7Afk/jrW/UNsr3vVIGRKjRz7tOiPCzfKvyOoD45FUdjsnnlDMzpXY
 DM2LxV9qpSIoR
X-Gm-Gg: AYBFou1WoHDpU7g0ov7BCNw7zGRQODfqHy9JGQwMru4lWOzse64SvAHs3SCSchUXqQE
 ggB4zVMIhHOuyTAD2xcQuK5/Xq43HLpu3pmTjHKbuYdLmdu4hj9Zqdx27ANZHUBNKCQHh/OyuXI
 ZS8vxYgigj3awFPT5/oronwMf1/wU0C0NQTi1YJyAxv2GOL9kz6GfrsNJUA8lvKIOCfktFYnJft
 kEKXTDL4LVvrxV7sLnDPPVy6Mpu0gMxl5Jb7VPRrLEwBAt5vr2nUzwuf+XSaOtQzN+RkF6Ltor5
 CqagahXXMfKhm69DezwLosy1ccUox2Ajp+eGN7hSz+bUOMcfUaU/op5OjCqDc0dJG5c4pAd9H6K
 XaFd1T9cLRntiVmYrU/efksCv7z9jSJC6l32ObBcUNhCZu+6CitXxyKzMyVA4DYLulHEw+cTk1M
 z2ika0oh5cEmw/JOhj4cWHH2Pf0kink2D1ysS5WFR00/ACywWEo/VJ8NjLRfiw/9INZhnvC9PdI
 7ZJytBRiwcigNoXGW7ygRmbNfgR2aV/iZRBCPMxoZIA2Hl5PCuHrkr+Yggmnu2inFCGdDY2fx2f
 kS+z8M/Q8Rqjnmk0Vz8=
X-Received: by 2002:a05:6808:6d82:b0:4b9:a829:f00a with SMTP id
 5614622812f47-4ca4bc745acmr47509b6e.22.1789504517077; 
 Tue, 15 Sep 2026 13:35:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260827-v2026-10-next-topic-am45-ofupstream-cpsw-fix-ports-v1-1-764e97251ef9@baylibre.com>
References: <20260827-v2026-10-next-topic-am45-ofupstream-cpsw-fix-ports-v1-1-764e97251ef9@baylibre.com>
Subject: Re: [PATCH] net: ti: cpsw: Skip disabled ports in switch binding
Message-Id: <178950451629.931545.3595455856556666598.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:16 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 27 Aug 2026 14:31:10 +0200, Markus Schneider-Pargmann (TI) wrote:

> cpsw_eth_of_to_plat_switch() tries to parse ethernet-ports that are
> marked disabled which breaks because phy-handle on some boards is not
> set for disabled ports.
> 
> Skip disabled ports instead.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] net: ti: cpsw: Skip disabled ports in switch binding
      commit: 71f3bd694b3ec03173c508f334a818486b13bd25
-- 
Tom


