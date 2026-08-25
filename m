Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6090C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7985F40591;
	Tue, 25 Aug 2026 17:35:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 75b8I5bXfnHx; Tue, 25 Aug 2026 17:35:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787679316;
	bh=A62LhJJlpXCwRExFaWF0cQbApX996J7Vm3iO+o/gLhg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0fee0PCYMS4JrdrlB33hOzEGYA5yGoBcGgcvhIjXpWEFNKWFRk/tfuHmo5f9F0gRI
	 PfMeVFKLyBMFyivNpJ19OPrGZ8QwBSCXHf0RUlMKdYj1er+ZQgfOEfK3tLYaBNaqvM
	 zPXH2lLFOmeH5rW6L4aiQ9LLII6UnVQkZ2GbsgfSJhYQnye+Ufv0GYizPqiHBlcEmW
	 7jaqa9pxyUMLOZJ2kJXuImBnHcEJ1gt/XvROxyG50q3dAJk/vJQv+xBG7f9z6EYmHB
	 c3XbCPurrWm+WyxyZMYWjjKtJ9paKDgEfuDRIRA+DKDcAlbYoWIT4KnwEHKmkedPS+
	 x/IxY5VWN37hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F8A040545;
	Tue, 25 Aug 2026 17:35:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB91FB6A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CD9BF80B84
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:35:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z1GmB180VQNa for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:35:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eATc8b7J
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AD7280B96
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:35:12 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7f18c0e03e3so24110a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 10:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787679311; x=1788284111;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A62LhJJlpXCwRExFaWF0cQbApX996J7Vm3iO+o/gLhg=;
 b=eATc8b7JQ9OSBzcA9KU6wGb20jFZ81d9TnoBnBmGQKMr69Na5xBv99OkBcKhCsfDyF
 Mi16QTC6hlqRJvWDGxANXXpdHTquZFP+3J+foPg55hD/BufmuMNtsEEL5CTMmB3oFfQ6
 QlQlLlK5hF9apXgkSVN6soIf2uQk82NyxRHWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787679311; x=1788284111;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A62LhJJlpXCwRExFaWF0cQbApX996J7Vm3iO+o/gLhg=;
 b=fMuYhUlOtEkaguJVPkOE9zqPrOErloPVKI3kDgqjm5PPbfUxAqnah+bjsOFYX3DpiS
 1T0FviAecjC7qmrQ5a4XGofLGzR3hQPvtQN7DpvsDsO2CJGMBwaRJF6e8GZy/vGiYJGG
 kHYVoMWS897a9jQZK4KqJJ/U9BZ2xKT28UVUFUl1DVGgsWXmN84cCnaLmtFhDQQjnLMc
 pN8xxpiIsZfEgQgQgkZvrsuLTRHjFI0SbJpkB44jFm4HP9QasA6Bv4/uY0yyHLAgsWDs
 nVHPi6To0p5T262IBJW+7BXrF1SRgWgnh/tJXiyg8dpwWQo0Q2XH6PvonbwS9HCJ+mvB
 YXRg==
X-Gm-Message-State: AFuF++mYnBi1HjQzdkUrxdYibRApnRD4mriKxdpo3+fwkIA4sc8d66yw
 QzgjqGQyJVrXC3oGtXN/2oZBvh1Pekaj+RAU8IVDZNSaICc69ChHHLQmeP2NI/FPMX47RQMWMAa
 AUOJV40UfANhP
X-Gm-Gg: AR+sD10EpAkCofA9upk1gAQVqRUvE7gUzFaBMKIs8aA4QikcMd56rnpJimZp5VKan9K
 ZOHxKNxjygm8BiTvX2Bdn6+pFd3Z9vGUQykD0mBcaPbjbP0g4vf0QWFx6wd/WRAnkEw30hGvzKg
 zk3nWYSaZOb6ib7/JFl++l88jawR+TOdeUqyVOuZ0wDVsnlOjbW4Dl2zq6SOzCHBps8ReRgxp9H
 owrZJAgpJ6QqFdPr9x9eTIQ9QHEqqPIGsipxBbzyR1/4XDv+Mi+nY4jcIMThPYcpjwJR33TNbIp
 orF6XFszTLopsGVCwMvh1Ws/8FI0ckv/4GlnyxXP1spGyQNzoPcL6AAXSlQkz/4kq2i+QujtB9L
 LCU3XqKtlNyQCvRnZWgJakilbXM/r/4LE0CvBA4nAYRogBuU2koPk5I20n/QyE/FV4mH8FkRuTl
 oG4gbm9E7ho9j0ut4z6Ym6Grn085ikcIHgzK87wQkcCPxFNG2G3+5K259I5LFZ+fnLWZ7hYCegj
 ZNjXSDbj/IBH4/fsJIuqF/Ho1F3YWLuFA8De9k89M9LHDOEARSG3z3AIBMWmCwGqhF0kAYKQv1h
 UXIjhyQe
X-Received: by 2002:a05:6820:1891:b0:6b1:60b8:a7f5 with SMTP id
 006d021491bc7-6b1a0498b16mr411906eaf.17.1787679311408; 
 Tue, 25 Aug 2026 10:35:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1a0280d5dsm141391eaf.14.2026.08.25.10.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 10:35:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
In-Reply-To: <20260821121908.212186-1-marek.vasut+renesas@mailbox.org>
References: <20260821121908.212186-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] arm64: dts: renesas: Drop bootph-all from PRR node on
 R-Car Gen5 R8A78000 X5H
Message-Id: <178767931063.2316849.1422291168931910055.b4-ty@konsulko.com>
Date: Tue, 25 Aug 2026 11:35:10 -0600
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

On Fri, 21 Aug 2026 14:18:51 +0200, Marek Vasut wrote:

> The PRR node is going to be folded into MFIS node in Linux 7.2.y DTs.
> The PRR node is currently unused and does not require the bootph-all
> DT property. Drop the property from the PRR node, and drop the entire
> prr {} node phandle, thus unblocking Linux 7.2.y upstream DT update.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm64: dts: renesas: Drop bootph-all from PRR node on R-Car Gen5 R8A78000 X5H
      commit: d29122e0287aa05692c1c022d8d548f786773862
-- 
Tom


