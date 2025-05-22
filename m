Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D88C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 22:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35324831A4;
	Fri, 23 May 2025 00:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oczI107d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49AF7831BB; Fri, 23 May 2025 00:48:37 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2848F83164
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 00:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2cc36b39545so236155fac.1
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747954114; x=1748558914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mz3+aT2i8GLxwJgk03lUEJeWQHm0qUmkv/NEGgLzgZY=;
 b=oczI107dAEO3sAEbztzRwCfy+1IIfe99U+FG/DToq0PRLnxG5uOpMGhUdpNu6CWq0V
 NJAW0YK7zFjag9kBATb7+oeqdyIpL1QQuJHgsu1WOa23njmlMULJyPugSwxM01PxLFJ4
 b9TW19m15bZIjtT2VUdlDU6XmLHwW58mH56pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747954114; x=1748558914;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mz3+aT2i8GLxwJgk03lUEJeWQHm0qUmkv/NEGgLzgZY=;
 b=JJ3kgBMCBPw046rGQyE5M4lkFZMEyMMQxBdCCfnqznQ+weqZGBGHra2vFV1O6hsaOS
 hYAtbj9zlewSHni5abUGId3kXIefnL4vwx79jgH/MOqX+Ipd2mdt4iKYiNh9oJg4O+dZ
 aMiq6YHENsHmHhCLYkSUO+wjVzbA4UzUbI/YQq9pkCUCXG2scyEJY7DbW1FZrRGnoP9b
 l/aSXZ6vlMA/oRZG3ndH0VJVVG911L5RjGYKPQtajaMwNkwjxpHk3LnYXEdkCyRVJjcf
 Vyn5/JzM59vWo90UgOAF5gLgC1UziTQ9IjOUNb7PznWi5blEInbaWp5Zyb5Iyx6AJvnU
 aixQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrJBhq5h+AtC6CdFoIxPNMMLWWe9Mm2trs5SizVj5c/gfN2D+gClPJTFJRWG8SDKs2t3v1nI8=@lists.denx.de
X-Gm-Message-State: AOJu0YwaQhQBYRfcIFMFB+Ssm3pKF8dD2FFMExvRWYeaxiXUKM5WHruU
 kBk/6q2JJkp2iHEAHqwaUqZ4MPDDlLb5lj/Nuit6Jo1cmuERzyFbYS7Er3wlSgDhI/03lv/2z3W
 bninmqOQ=
X-Gm-Gg: ASbGncsRn3ELqKOpduPn18BGhxUYwnY9EzVc3XxXhtZ6hY1dAIj4yns1Uoh9pkatpDV
 dIuhee1OrI4FdxZTrL5q4yz6GdsPTmS1okZvp2jYqNkml/jfCm5MRymCj35bR0P/QouVCffc5M8
 0xz/tJY9hnv0MWejFK7OrBhiVUo61FiJjB4gLZqHeOc2KObc6HlEwrEEVXznynlqY87iEbfQ8Sj
 8LDqhOp/71+jZuu5NrD+TtIpLltlRfh4LmzcKkZ3taGfaQ3RQ0MtU5Gt1KJBp1kkqUtRixEX60N
 DWHSp0Pujkgn9PzES3Btjq7HXOqvEMELEknGa9RtR7O61EwM9tdwKTU2o9+jRual3dx3KFAS5Me
 xp3HGIqCbJDo=
X-Google-Smtp-Source: AGHT+IEG7RfMYq22nzTi0pVfc5326XPZgfvEbMBfP3MpVZviMqNv7GUevJOhmov6lzm+8J8UVkeMBQ==
X-Received: by 2002:a05:6870:7302:b0:2e4:9c8e:f59c with SMTP id
 586e51a60fabf-2e83e974461mr674351fac.19.1747954113872; 
 Thu, 22 May 2025 15:48:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c060af78sm3258534fac.5.2025.05.22.15.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 15:48:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20250506070907.1267279-1-ghidoliemanuele@gmail.com>
References: <20250506070907.1267279-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1] configs: verdin-am62: Drop unused or redundant
 config options
Message-Id: <174795411239.2210140.3537076818487659414.b4-ty@konsulko.com>
Date: Thu, 22 May 2025 16:48:32 -0600
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

On Tue, 06 May 2025 09:08:59 +0200, Emanuele Ghidoli wrote:

> Several Kconfig options are enabled but unused or unnecessary for our
> use case. These include features such as SPL FAT support, YMODEM, and
> USB keyboard. Some R5-specific configurations are not used at all,
> as U-Boot proper is not executed on that core.
> 
> Cleaning them up helps reduce build size and simplifies maintenance.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] configs: verdin-am62: Drop unused or redundant config options
      commit: df8dbc87a2570e99ba73d8e0a097797126040568
-- 
Tom


