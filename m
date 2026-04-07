Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFF1FF5136
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92BD084148;
	Tue,  7 Apr 2026 21:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PJujJ/AI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A16D68412A; Tue,  7 Apr 2026 21:50:14 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F63383936
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-46fb6d65c89so1157971b6e.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591411; x=1776196211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HXdAgbmPAWOsMvcDtnQ0KYFGuNRH3j3oUJkyzdachGM=;
 b=PJujJ/AIleZZrqI8U76Q9+WOJ0AOrcp345WbfyPZ38iqN4udJk4/TNtYzPaLsSMg65
 dY0t3u//9TQIE+mGOh4eH8JVFyS08f2GA5CMSFw/lfq95GZF9Xxj5s4Zry0KcHuOn9hb
 YFGAcZTxrTrp3U1cRE7aX+PbsfY93EfwfKOMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591411; x=1776196211;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HXdAgbmPAWOsMvcDtnQ0KYFGuNRH3j3oUJkyzdachGM=;
 b=gFviMiWvyQPFjZIJxwfAKcPLD1uuvy5zQIYf5C2Csbk7JA8VAk+g5bYWk/6otQxXFg
 Ng6gV5E+8i9G/qRvDwaR1uiRaZ4W1ZT+cfjwKY18QVWI/Q44rTQ/tzOY3iClnUgFuTNZ
 QnqghQCFBY4bRU1UGjPf2paDZZ7KUNfTyQlVS1WLMAhdkeMneo/7Jw+aiBE5DYjK1mNE
 GmrxNOAWKCfPNH/0U5fMxj/0Tndo5iUjrAhU/we8s2B/ZAXEoCi4cdB6JnIv2DvVhjfS
 CfWRsy5VtaIiRUBKwpGinFD1KoF5GTuKa4UriGd4AWXVSF0OP0LNvwaFcru8JiI9zC5O
 LIsQ==
X-Gm-Message-State: AOJu0YworBP3SBwaSYcnF90Llsiml6E6Hnpf1hmJQcjibQKso8gtlBx4
 cKpZKODo4Qgv4+wRAhe4Usq/277GEaoLPvPZfwhqva3zAaoM/PS8mTKr8C5GPcYX6Ve5aWpLM1G
 CgKrqvE0=
X-Gm-Gg: AeBDievXKrqdA6usi0QC0keSI5UoN7jLW2DiYLWTYhtoKXbd3DqJCvwTi5vEwRbI51H
 eFwb2wxWZHk0NGlQ4n6V1QQedVL7hzEbHc5a5Naq71qZOuRPh1l50jkXd6g2YYQoqFn7IR63Ele
 RTe/p5i2np2GmXGqodQtnl1sJTNKCAIwA64jivbIY2+2uir6OOhgqv6/GMeGS7spVHASZm7tSNA
 vWuIjTLer5E+UCv4ahRYxM4rHrjYWAXl660nwcH9XlJubqjKU+rTXwoZvwzmZfFdLWBraHV9Fko
 XZi5MyI7sRjRrxMycHX23r8ARNxjF6omftxekTGaST25foV3wr2+Igs0HjgvOfxKIRsmFB+heFN
 RhqnrRSXnhzPryYNorxcNu4Rr5Ng8sOfV07hfY3uySsI6s1YV0VJEIuTthvh63HF9D68xcWH/DK
 jdY4XlRzw7kyeVlkTI0I96ghxWHgec2GVuKbhN1yj9xDweh2JBjuoAeJV/Igyn0UpXAsh8ubPnt
 pkypyJc3OLN21Z5UKNEDTUZFdyVH2vdy23MAmJjsBwI9VU=
X-Received: by 2002:a05:6808:6d85:b0:467:143c:7733 with SMTP id
 5614622812f47-46ef83175b1mr9852109b6e.46.1775591411298; 
 Tue, 07 Apr 2026 12:50:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195244.2363402-1-trini@konsulko.com>
References: <20260323195244.2363402-1-trini@konsulko.com>
Subject: Re: [PATCH] dts: Disallow OF_UPSTREAM for sandbox
Message-Id: <177559141059.2108693.146575333739861927.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 23 Mar 2026 13:52:44 -0600, Tom Rini wrote:

> Our sandbox platform are not appropriate for OF_UPSTREAM, reflect this in
> Kconfig.
> 
> 

Applied to u-boot/master, thanks!

[1/1] dts: Disallow OF_UPSTREAM for sandbox
      commit: 7396dca4053c87d12a0a27bc0359df7cc8401e91
-- 
Tom


