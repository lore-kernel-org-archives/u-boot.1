Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44700FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 14:57:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5DD18432A;
	Thu, 30 Apr 2026 16:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jdhDxJHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9647283693; Thu, 30 Apr 2026 16:57:12 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F17580F0E
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 16:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-479eb8bcacbso599295b6e.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777561029; x=1778165829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPLpHeZPhqmI8wXXmeN1pd4yCNBqKzPFEq+2juRiCoE=;
 b=jdhDxJHhWg8NaEUqIRvANvOxSftsHHe1NPPCphixMamdjfTPVbnYh0q5KqdIa4mN6q
 EmGL53BVKOpKJXC4HroxgOT37kQCKzOlF7Oz/O7stK01QzVJeYx6H+AGFA2IrdJ92ybG
 iljGHDoG/9qEgW3emejXoBeQRqNZZBc8EKvWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777561029; x=1778165829;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EPLpHeZPhqmI8wXXmeN1pd4yCNBqKzPFEq+2juRiCoE=;
 b=tTJM7/I6iyWYesL+xNLBcpYr1ATwrBS00gVCBY5v3NYalR4yMDMHH2WaGmJpjVsSBW
 YXzDm2hrLtNRDbRSmEHK9CWpzAE+Y7PYqBK6lpeAXcQdeVUDqaINHDkwZwiD9updbVl6
 wgxiN/YaXB0Q31MIeTgpecl/KqBkuT8YjQFFlM6B0DduXfYebYZmsl/UQHlgKkOZYxKj
 YLKqHMpHl80v136ptPgh0434XYLNvGrsqkHynpNO1UC1XwT1vrf7VHHePE9Xtasksrn2
 PI5ACFUCgQDZxWs69GUOZQxO3VxmRylI0cxvJCsOcfCrZu0JVQcX3xIubpX9zepmzVlP
 kivg==
X-Gm-Message-State: AOJu0Yx6r2UImLvUgO8smzspojTJg7oWaAPAWj1Yz9xZNchKvo6140WX
 0WGpAFBHB1VZdXQbbLLlwJgrjT7P+i6yrfIe+bTCWnV7ARK5CjPbd7uyAMX073aBXaFxs+vPmlV
 x8/NFAy5UcQ==
X-Gm-Gg: AeBDiet+/JHyLO2s/+j0TGLR1iQUIJYmUz4U7P3I714kSVpISVqUf3N6ZOVQ7c1Qdzz
 B2LFAE816AnumUJ4eIIyihpzTcMmRlnvxw3D+I83k63oEJEcEYJpgEixEM+eTscLpT3m5RhX4h2
 scQDvWNa6nliFHzKOYEJF4bK9dkL0PJMKVn2ArVA2Y01DPys01XQmEDhSzxJLKMMZeGxoHuGLXE
 s9bNCPziGExoexlMuQQFT99PZChKCIghgXELhyt6B3cHUi+s4tusGv5gnV8PauTQBGhe9wSWdky
 4uOyagWgHxC7jb+j1rambYMgc+k+G4m0pHIVTBI3cYrB/5O2wRwO6Ds1sX1Yso9lHs0dXqDTjeE
 xYe5gHx4N+jp8fVJ8nYGb6QMMafA45l7HhyFC0VZhsHLoxb5XM948kW8X/FYybBWBXyM/L5s+0M
 znV6hRRQbic/770Ok8LOWgh4DShKBU22bnjOhrRjpDJkXmn6BEpprHlYzrhscgm5DiGX44w9E4G
 QWffLyIR1DTm4lerrcMxyPPFv7rxMs1aTXXG0CEX+RfKdvGYL8UoGpDNBmA
X-Received: by 2002:a05:6808:30a1:b0:479:d57b:838a with SMTP id
 5614622812f47-47c5fda0c85mr1606058b6e.35.1777561029191; 
 Thu, 30 Apr 2026 07:57:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c43ee0400sm2998426b6e.7.2026.04.30.07.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 07:57:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@nabladev.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>
In-Reply-To: <20260430010918.1450541-1-trini@konsulko.com>
References: <20260430010918.1450541-1-trini@konsulko.com>
Subject: Re: [PATCH 1/1] socfpga: vining: Enable LTO
Message-Id: <177756102850.1633235.16585393137358243074.b4-ty@konsulko.com>
Date: Thu, 30 Apr 2026 08:57:08 -0600
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

On Wed, 29 Apr 2026 19:09:18 -0600, Tom Rini wrote:

> This platform is often close to the binary size limit and minor changes
> lead to exceeding image size. Enable LTO for this platform.
> 
> 

Applied to u-boot/master, thanks!

[1/1] socfpga: vining: Enable LTO
      commit: 13b3502157eaa194226c825aadaf31661ba5b96a
-- 
Tom


