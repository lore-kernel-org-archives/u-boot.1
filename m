Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27F8CCD192
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 14:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8893835B0;
	Tue, 14 Oct 2025 16:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sSfLrqdR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66371835B3; Tue, 14 Oct 2025 16:20:36 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CBAE83303
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 16:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3ac1ad95537so3072958fac.2
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760451633; x=1761056433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EX1X0qe4h/90+QW5Re5lru4Sbb1O/6LTYcJ1R5wkNZs=;
 b=sSfLrqdRoT/ndK+Od7LWLubgoWCxsz+/ScgbTj63vPn2zkvfgJwmzjYKvAELj4ABXu
 Yb6VZqRliF0rcS94MeoWM0xWYwJKCZj7Ib685SSTNf5bMKcGErqhhS8op4kSzZR+5W+D
 EpRyuIqjsqadxX1SbRim5KdbDCvO7IjzqxYzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760451633; x=1761056433;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EX1X0qe4h/90+QW5Re5lru4Sbb1O/6LTYcJ1R5wkNZs=;
 b=Gh8qPEvsOl6HtQ13k8FeVTLSanxJUtrWawU4Ie1nLBZZ76ReVmtjI3xKQ33IIOBZyZ
 iB9BYrRBaWvOS50hIAUkPoJ0h8uvBr8j6RQ7+U1NzdjangL0SPC1AcGv8jv/UsfO/NtW
 OCIi8pGYMfgAf8SIQtHmnkzABTfDeJ1HPnNEpyJcqZjWuLyeuv27Z342/w/1vEM5+NHG
 E8POMLyzBROje4KK2Y4wW6KsBzdsbtw7+0rOZ2MBFt8MgpzNrEs/czSSRVebT4J55WX1
 SnfRykpgI+HOxZmGJ96glR7GdTVpz1QCCVmMiAgWwFMgRDmVkewujc4l5dubtPQ7CvDU
 Z2uA==
X-Gm-Message-State: AOJu0YzzOas4G9mbpcvvrmveroh927m1nKJgEmqCt7+KcGqNnVkeVKuE
 NLb4jelwNGVjhjRCFA0qisO4yN/TVLMeJGbkhZwIlkscGj4dYHpKJ+aComsvI6mRaGCmQ36eyQC
 i9ncA0t8=
X-Gm-Gg: ASbGncv5OZYYprsKgsDsXRXajPb9eIqFMjGPgpv20nTym7XFjdk7nb+yTjzEg7bUvqH
 8RMpVtN/LcBSsqVzD4zexNCvuW34TPPU5JEAPDq9+mg0T0GqzN4umjFtX2+9mu8bDEccaPw0Jav
 co4Z1diQW02HKPywvG0knQ0lL97uV1Wz/LeV1073CR2gmJhoQkCbaFcUa8raj+v0JjVV/EHtHs4
 cOcIc2KpzSeZK3MJgwY6yf9LIidg51XolU8+t3nT7rn8kmtLf6bvbkaOqShAzdmYfKJUnebc8TV
 LPH8t5mvPLEl33/MJe9iSn0JgNvlWz8JmMiqqMmJBbBWOEOjVulumtlEiz43ra3lUoJr2k8NYLI
 Wh3/TjHLIZOrflJe7l219e3bAFwTrzm3EKNkIC4Q5FSze0A5589y8Ck5Pjw3ecPPnNm7OhZ6dyv
 5L/5BOZhjAXjsh8w==
X-Google-Smtp-Source: AGHT+IH20qLDZKI62LRzcQJHtd7ANxlKaM69m3N7dja6G5IyZDZEV1bZ4Q6VJYD8Dsub9cHcmi0MUA==
X-Received: by 2002:a05:6871:79c:b0:344:5201:15a4 with SMTP id
 586e51a60fabf-3c0f66ec655mr12574037fac.16.1760451632502; 
 Tue, 14 Oct 2025 07:20:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8b5b44asm4616709fac.7.2025.10.14.07.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 07:20:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251003203917.1029944-1-trini@konsulko.com>
References: <20251003203917.1029944-1-trini@konsulko.com>
Subject: Re: [PATCH] SPL: Make SPL_OS depend on supported architectures
Message-Id: <176045163139.284655.8861693581975789228.b4-ty@konsulko.com>
Date: Tue, 14 Oct 2025 08:20:31 -0600
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

On Fri, 03 Oct 2025 14:39:17 -0600, Tom Rini wrote:

> We can only enable Falcon Mode (aka SPL_OS) on architectures which
> implement certain hooks. Express these dependencies in Kconfig.
> 
> 

Applied to u-boot/master, thanks!

[1/1] SPL: Make SPL_OS depend on supported architectures
      commit: 66873b9ef0b447d9b0f9da81eb9867e1f19b99cf
-- 
Tom


