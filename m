Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ADD606A31D
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kd7Yqdr6;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ARgEa91R
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47BCC81510;
	Fri, 23 Oct 2026 17:12:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gATLmR1J8vF3; Fri, 23 Oct 2026 17:12:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 909D38150D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792775523;
	b=BDGo568j0T3j4Sney7oX5LREPwZj165DLWLUxB/JkCYO1lYwVnTWu4kIfJ514tXzxHfU
	 aiQUOD6Hid5XYnkV4Y3GaADy3ZenYxn/dTsNgIHGtLDwHQJ9SkZSJfK5drfWQdBRplxHS
	 rvYlqYR7pKlvMOqetTjqHMwPTQrXUKJV6WRnD7v2AMdOXKuXIMN4he3S8M4VwGfElXWBe
	 Flr8HWz4d6/dEG68fs/dVTGLmOkCyw9+1zmLLpb6fqR7dJ6IRcvAXCu9O2DwriE0NleTM
	 Y9CZqrSTWxdE8aCU8PwbE35PksHfEV/7mlVO840ZI0MBCDyW+SPe8p9+PrTxwE10yFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792775523;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=56L/tyPWbda3tKOaJG6spnvlFTSJ7HZndPtR6XxOdWg=;
	b=FIHOC1TZeFWRrwNc8+Tfabufxwy2BJ2gROY8EJJcKonDN2D720Aq1CrOEdxPu7uv6lwL
	 Vr+Xj3ZfiQm58XZvvbhEw6rnZyfFOxKzpbyjKDkBW7b4e57zSAAd9rsqShuWCaq6GdEVV
	 atQptvNopKbUNi487/Snb9R2py/l6rCPJ7IGlbvbLcf56n6FUXYHS1YClQ/YWG11KKi8d
	 36jVpKkiG/AzqNK8ploXXXtKIaP2Ux4l+6UkIb/I4CgtoBNEMZd20kgobMl8QzyIY78do
	 X5CsYuFBIl/XB0eCrEuB4ZZ+7QF0sTQy70Iyr9YsEOGPfLcSHyl/mvICUaC9LH4tbwA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792775523;
	bh=56L/tyPWbda3tKOaJG6spnvlFTSJ7HZndPtR6XxOdWg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kd7Yqdr6cQW7mGsLh6EBdfWMYZY6IEUVM8mvC/jd2A9G5kDyzL2Zb1ZlL8OiJ10mM
	 1YuZ9mj/AGjglx+eSE4bka2Uy/pOjosHai8nxo20h8f3IyUmvTj9mtJzbt5HWXRaLb
	 a63iYt28rVwsfWQrczt7B3xFproUih9rhpJkTQ+XZJf78cV2YzvJZlmoEPZRbRREr8
	 aAg8uMkXJt3v/7gH/zrqCPEOOfbmqT8X6W7vzPSI4nHyGIMRQuULljZjckXyV1yugM
	 lGaRGpe7YRpS4kazTXqeb62nuhvpnplOkrw0SPr9/uU1+9qhzSloEPSPMkcnnq7Czx
	 zYwKEPmhs0H6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 909D38150D;
	Fri, 23 Oct 2026 17:12:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AF41235
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3110E40234
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:11:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ad-4oJs8mlU9 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 17:11:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1102B401DF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792775517;
 b=mKt/lL23MahyCkuoizg3PwVkZipBXQgeYw2uXfMnW7829ST+dVICkEReShIHFkqTa0M6
 teZH8alHxuqemNQMyklyQG/L8MVZsR8FUUL54X4enH0g+lrrekWi2wKc09rEHAPGutmmz
 n4Iqp9/5mTsEpp6mj6UCnnbLKOcdqA0raBh68jWgoBabwe6+Ske6NoekwlIi/CJVnEcuk
 KweoZfS+wKoV/8g6h0ZpjFCgxWCYZGRN3KUXYFwRdsOgUvaeOaLYYs2etufDl/P8jFvwW
 HbIGGyZlFS41logdyKdL4z8xJoG3K3n2N//jm3xUB/dwQlvqAu0dlhbfV7krz6GCj6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792775517;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=56L/tyPWbda3tKOaJG6spnvlFTSJ7HZndPtR6XxOdWg=;
 b=lV9seQT6dQBV+ev9MSfSboQpue2cDF1b4YsX5Bm4gfHwlkIZoeAJ4yHCCwJPTC+M9n8c
 7ihHJp9OL2OQ92hKD/QCAwsgnrhX/+EJ102tnSYYIdcMmfD5wbATs9wlDUQ0CH8v6LROc
 Cnwp99Hix7l22V+LBDHK0oqu+KzcBBLRZqvdKZCVbqQICd9jySFyKNxJnfQ4DjweGfkxL
 MUBSOVQDieJ/caXQryNdY/aOSWTjTGPH0G74SKdHk+4ZpUHiVQM41+fOIKRoKKwGk4vM1
 i9bcsFMPNwC5TFkOX484J6cQYexc57TzbqO1skpQgFoINu7Ei+LVYnzFvXT87rCBrOQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ARgEa91R; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ARgEa91R
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1102B401DF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:11:56 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4d198f1a591so591234b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792775515; x=1793380315;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=56L/tyPWbda3tKOaJG6spnvlFTSJ7HZndPtR6XxOdWg=;
 b=ARgEa91RdXM6LF1rujDyiFJXu+nOpyRd2nquGGwk1N4WrZAHBwasc2cZ4AD7gX5i1G
 J8dgys7sEhApAMaQyZPpaNfWbODih0I3Xq+qtTAvl8WUfCY9hOhVmuPwigoY1eCzcj6b
 +BgYQHoumelYZjFl03VH5siQAW1AxbdOMPVXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792775515; x=1793380315;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=56L/tyPWbda3tKOaJG6spnvlFTSJ7HZndPtR6XxOdWg=;
 b=BOAwnVpF40RMdRSCDP7vm2+jlG5m3tFIg2KBbBB/wJLmHu/OyTurcRS2cr55sUBHOZ
 nsaMGbmngN3EALQRjEpKj5d5vFihrqNJHoboh+7ErPpoEud2TO4KdmGQJgYIo/czKEw9
 pLWY1Vex2i91xhZUvvdxnnxMbsH7NnUrmSk+K0ykJOMAEUd/avj1iwO72t96mMmsxF0r
 ZoqhRr1PLAWEWmCy9HeezjtbLbogVQWmMaY4IHKcSh4zynMIEI/NSKOzwAm5Jbxk6p8Z
 csJrVCy4AG5MPDFVr3p8WYyEZMJV3P/2tTSDzZreWmspFDfkDrbNgcThYCR+eZewoCJB
 lHww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMRZkufnzLuwFAyZFqJuQ0xA4emugJzFU7fOON6mnjW/tZPLocTY5zmRrtAY5p36CAYyaJczA=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLD78ydhb4+MyoxfS0lwA1e/ndQDkvRRfPGSDzVkmJ99LYYdeGm
 TafhfvM+WWITjJUIhIFOzFbjYXUYx1d2ICGjqIooVqR4Qp9gZ6oMA3VRBEdEcMjne6RHg46GSoe
 hRZgQlwxv+OV8
X-Gm-Gg: AYBFou21Bzwf5kudJD+gAo/25nSP4K1YKUXkXWYAMg5LK0SSCQL9CpmnoB5ZD/+C6eU
 D3/AI3JBLw8bYuyZXRL7HO3wczewsqu0e+X1lc3HqJ/qFB5LPj9OKENyqxH0jcho1HaUCITE+RN
 lC6zQtBBRpiFKeXyGIsciEiZLRSmWDuCOm4z7ZjT/3JN6It8dzk2jCjd69LEIJAxEc9kHTiAgAD
 G14f0M0/vmH3sQWvSEF1E3rEzs1kUoKtWA0BlAN95yH2bL+insCsRVUx6p7GlYoVTg70M8jHxM9
 G0W4WU2ixJsIflLvih6Yk757u/nYYF00j5tH4tFs7cGRILYN0d3AwkG8F9nrnbRP3vaF5c20MsT
 jEf4WUnHHExNmO91LIv8kXguTAHlFX/N+PaQVfPY07vmSPPfBwQISifAylQDBZnN8/xp4z3TNFJ
 nREq52YSlQb1Pnx/mP9HhJe2fegNBvBPoQeemOETlVBeQ66puc6kHirlm7XLiy316q6VB4tgzd0
 KEpLZ76sDbzijNxtZS2hHlQg51UnEL7ettRfhXrZdLXOeJk8cOfGrvHtGnnh+LfJzL3a6beX96n
 SYNssIZyIwU3s6MUJ7W6rbLrfijDsH2RaIfutgzLJI9KPm/5zl/VBzEfyu+Csg7SAjf9/fyxiGz
 bNIxaNMdb+l5AQ8An2uSI83mLqRfYivFxZEMmVWtiE/f+GWhtxj72sjjD
X-Received: by 2002:a05:6808:120c:b0:4cb:f21b:6f91 with SMTP id
 5614622812f47-55be83b26demr2159886b6e.36.1792775515595; 
 Fri, 23 Oct 2026 10:11:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55bfe1537c3sm161329b6e.8.2026.10.23.10.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:11:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261023105047.272280-1-heinrich.schuchardt@canonical.com>
References: <20261023105047.272280-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] test: net: don't count ARP replies in DHCP test
Message-Id: <179277551451.3931275.2905788106863213765.b4-ty@konsulko.com>
Date: Fri, 23 Oct 2026 11:11:54 -0600
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 12:50:47 +0200, Heinrich Schuchardt wrote:

> The number of ARP replies received is not a measure for correct DHCP
> handshake. Checking this number leads to false positives in the CI.
> 
>     ETH_PACKETS_BATCH_RECV - 2 == test->arp_replies:
>     Expected 0x1e (30), got 0x1d (29)
> 
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] test: net: don't count ARP replies in DHCP test
      commit: f97bb5c1ad78e95856917b92c7270c82d4b11e21
-- 
Tom


