Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB72CC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:16:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C902C810D4;
	Fri,  7 Aug 2026 16:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ANQxESN6wy3k; Fri,  7 Aug 2026 16:16:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF8FD8136F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119402;
	bh=xBWJzsEg4ay5v6E4bCj2LpFOO0zkCPxooRV8rP5h4TE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bjMvkeXSHE6Gjtjv2FIkPRJVTJqj78QB1/9AODFFE/EphPlQM4WFo40Ymh8L8kJgT
	 2/wlGp1fKmpz/zDsQ/Vgrxqg9AxCfnNgIOFEfugMOONDsDJ5a1KQin5xdLLjlC3G30
	 QZGiyjPlKkYGQPi+4sX9Bw1sZawBKa8zk/dElmPI52tEeSc4Iv4oxwcL79X33Vrb4Y
	 8/3KXmWZw20bNxzPlpv6YBsa2iUGJ8JmoTdwffHFU+x2mGjKWbqfTEITsl2L4RgiwR
	 8+WAG3HlD0lPCD7EqBOys7v8lQ9BMmervVO/1P9CgYNktvzHkeIbLH64cELDzr0d+/
	 ZhVWlWjLbJCxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF8FD8136F;
	Fri,  7 Aug 2026 16:16:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E3BE62F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D5C984010A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F1UTURDWkPX7 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:16:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C75AF4008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C75AF4008E
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C75AF4008E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:35 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6ae5baaef5dso1720175eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119394; x=1786724194;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xBWJzsEg4ay5v6E4bCj2LpFOO0zkCPxooRV8rP5h4TE=;
 b=YKtcFx4TdrioVS2tnjT2r9OGIoA33ERBpCIitqL8txd5f3Gvh24LwgGwRNqxuUYmz3
 Uq2I1sr7jXOpz1HWNtZzIVVAL0driXsIiG6bWgmJU7WKkzeWB7UWuyaJV5mAwEGz9un7
 KuDkcihhoH+ZNwraA9yrW5Zi5fBExTgZRLIrXlpmtZ2Z64ncEjrhqBnBP1/eo7XcSs45
 zhnzZM/yUBsqG9YhDp6E/O4h+Pbc+7F1NRkicScn4RYlSY5L8H5zx4nerEDwqpZQAPYI
 j5UVNThot0ZniFO+pCs3tD5kNUtQu2uDhpGgk94d84G36b6dcVPiLMvbhM2ZT6p4vtgD
 F/Hw==
X-Gm-Message-State: AOJu0YynkiKmxn8S6QdwZ2/y/hKJktix3VWE1ZjVIJHZT4rVxbe/PpMz
 BFrMgsCv6EfQLFi9a8/W+km1W9Wy0/g9vyc0OXrhh3cO1aEkqaxktiae5ZTV4XAH6st8JS1QPro
 ig28yUmc=
X-Gm-Gg: AR+sD11tw9hzBLFn9JI7slvrHNbdOEejgKlw/A2rHwq7clTQct6/u5gUCCndxGLHaHE
 Ii2v/gsU6p2d5diFc45lMUhqlPKy9fOq0ltYHeBf4/jqnZGufuqQFq3jFAUZ9crqvJT/PXyU+mp
 UzMNpnSG/er7Z3rGNMWsrIiveGanIYMg/p/7p6a8Y9GYdStw19Nr1mAqRzZAJCTVm9Oh9yQDbPK
 ND6iS11vH3f0lJE2QzBnFO9b5T8noBbcCJjsnpNH52rvgFF7bQBeCDXU/YOO587DVv6I+c8wa8+
 Y9E+mcD0Y5hJsPdEEKrl5ZMHwgOt+yOi8r53UDJyfoG2g5TbVpYmbKEdYdumwvAEsBbrvZbTD+M
 ZGGtwSPrj2PwlDN5yEpewL0l/D8TVw79WO5jgORDC5IJHYEjvnJ5tNzjyp8DSvdq9uSrCqMEb0W
 YiUOmPx5CK4A0Ii0YOor93f/1GLzzPQqYXUVfawprgXykhEiCtLTQsp2LAAPtajXMMHX5Oy93sH
 qxs9LZCQLfgmRSryVpp9d3IBLhSrl+0iwUbfg8SLhXk133q0cx88XAVF+jLFaavQO+FzRpoqyfY
 Q9FJAf2R
X-Received: by 2002:a05:6820:1389:b0:6ae:47e0:be1b with SMTP id
 006d021491bc7-6b042dfd94dmr421185eaf.6.1786119394478; 
 Fri, 07 Aug 2026 09:16:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02bc25c74sm2712445eaf.5.2026.08.07.09.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:16:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260803162903.3214106-1-stefan.roese@mailbox.org>
References: <20260803162903.3214106-1-stefan.roese@mailbox.org>
Subject: Re: Please pull u-boot-watchdog/main
Message-Id: <178611939388.381449.14366376564868840048.b4-ty@konsulko.com>
Date: Fri, 07 Aug 2026 10:16:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786119394; x=1786724194;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xBWJzsEg4ay5v6E4bCj2LpFOO0zkCPxooRV8rP5h4TE=;
 b=mtyZ64hKSQsHvFGrY6wf1zGRKQmpkjJW0ViXX/nPi3zkVj719+uG30L2Ji0AZorjl9
 rXSFF1MS8xP1mJ1S6YhesNMKiMQl8x/Aw/ZzAdc0aR643Dpibj81MXLGBPAlAWNLUOT8
 JbIEWCqKUm4ToR1JKwHeYUb137xFLzaqr+55c=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=mtyZ64hK
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

On Mon, 3 Aug 2026 18:28:55 +0200, Stefan Roese wrote:

> please pull the following watchdog changes for the main branch:
> 
> - cyclic: get rid of cyclic_get_list() helper (Rasmus)
> - cyclic: return early from cyclic_run() if the list is empty (Rasmus)
> - watchdog: ast2600: add AST2700 support (Ryan)
> 
> CI (GitLab world build) is passing:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-watchdog/-/pipelines/867
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


