Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B781DC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 243768171B;
	Sun, 30 Mar 2025 16:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LjNC+jX9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4AEF81A0C; Sun, 30 Mar 2025 16:16:44 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6525E8144A
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72c7332128eso100134a34.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743344201; x=1743949001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dIBLqJLnw7SEEj8UBthQDRqC8pVgHegeEmaFctmlHb4=;
 b=LjNC+jX92x2nsSwgLfqtV63BUYPdb342gWdFYbW6OQowAdZHtB26xXFBCYAf6qygz8
 utLBXenY/syzy70EamoekJstXfE++U5h84XWSv0JtqWja1o7VrxKDaa60GG1lTD7VXef
 3zp1BrPzNULCuCjz8ulZZEXJoGOaPtN7INZAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743344201; x=1743949001;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIBLqJLnw7SEEj8UBthQDRqC8pVgHegeEmaFctmlHb4=;
 b=BklGFx6gcycB8t7gmhlgncPgaASnHmpStQIBmGNX471FHcD2gAM1rpeUXmF2mGy7wx
 bTUIxzLzM+tv/ifYAAm8w24UZNjxta6SKHDdf9ITDfsadIUn5VsABVeFm56wiwdwNhug
 1bmNu4aSZ5Sn2Id1HHLZHYWWwoLl3uEylT51YFpi6GZdbdN/WXiwizS7wqUFEN2qxxYM
 fkxagCVZkQ6r3wtfoxn1W9WUNOWZYtUPr3dvPoUD65OjHzXCdNwzdYY/32eQqeoXctz9
 iuYzRNgwocL4OgviqA/erELjiaSAQZ1QFNVOmt15RxbPin8h8NpUglMaRPhrCfd50Drk
 yZ1A==
X-Gm-Message-State: AOJu0YxjZIQr6AE0mhws5EF20aD3QvNlg0Jb0OUk/ab8Dba7khQji2Qx
 iiXEmaYMJN4x3YyvyADyVBZU69yA/c5677lLtSTtiyGxxQnSyoK3XaQYtVwCtEM=
X-Gm-Gg: ASbGncvKn7oV1octEqJxJN6aFs9yctB3PRPSg9zb6r4w4/PEyWSJnu6qRoI6ZcTDkTo
 cdC0F5MvV1UoYtn1qw6qtYF7rDJkmANsQrHicc2pOQenW+X55dIVhR9dV9r52HpES4OmobnfhyB
 ZeupR/6MUeTxXlbCzRbMeOXYqMVaKsF2E4u8aTFy0j5vG7TlnmuX0tFtmR7ZpUTYppRc4kJAKRV
 s33e7Vud4vLUZpuDO2BvLkVQTwuwCUQ0D6GJDKQyQqNisAJadbpvgNPNmxrjwUmW3oGUWNJb/9i
 3132TnzkTLyBqahGlukp01RtS40LReCLpq9bfXeKU0O6e8wEmtI92hIkcj+z6wQauQs62z0eG3z
 65gnl
X-Google-Smtp-Source: AGHT+IHduQPTaqEYGKD/ppVeNrM85m5jgxfl6Jn0Wzfd8m42y+owo8+655KHdiNDrVYmmxnRU+LNyw==
X-Received: by 2002:a05:6830:40c5:b0:72b:955a:852c with SMTP id
 46e09a7af769-72c63793a19mr3304587a34.11.1743344201096; 
 Sun, 30 Mar 2025 07:16:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5809260dsm1150216a34.14.2025.03.30.07.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 07:16:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250329024035.291171-1-marek.vasut+renesas@mailbox.org>
References: <20250329024035.291171-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/next
Message-Id: <174334419972.1157922.11332305670855505699.b4-ty@konsulko.com>
Date: Sun, 30 Mar 2025 08:16:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 29 Mar 2025 03:39:53 +0100, Marek Vasut wrote:

> More basic DBSC5 DRAM controller clean ups and improvements.
> 
> The following changes since commit 4adbf64ff8d8c730223fd8ae299d770bebb6fe86:
> 
>   Merge branch 'staging' of https://source.denx.de/u-boot/custodians/u-boot-tegra into next (2025-03-26 14:07:37 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


