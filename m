Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD575606A32D
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xKWq0ItR;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vcat0JYY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B253814C3;
	Sat, 14 Nov 2026 15:24:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26b2cHASCc7W; Sat, 14 Nov 2026 15:24:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E76D28143F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794669888;
	b=SxNQbwG1gGbGJrvNWTjz6zCxd7oZ/P4W0OZUu2hTYHkerK4y2pPEavq0ykKCZ50xLWd6
	 psWxmwlD4WqsQa7kdoXIBdvE4d8teegDZZseKZyeaOF5IPX6fZEl0z2yYpwu/QXM1y/fm
	 I3PtBI8cTVkadRV4nfsc/ndm7DNsiJxOQSnsi8eJLQHDZhWQvTY0onB0oCthmtEvABoxP
	 eO8xjYaUUfeEbb7lULAkQfA8xbs0nrwiXtYPGfoFBQqqNY0nKpvKwoNyhOnRrpMBFwoBm
	 3epooy2DK3XRY8FPZ9mMDca9s5DnYctuRiArr19N3MYLhpvYUvdOIAl6pY/eOinT72Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794669888;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Q8IyX/A0VUsC4EL1eUHPr+xX5C56eXUM2mSHbdTPEf8=;
	b=BD12mQGhEA/rAA+UPWPSBwDIA8VK4SruQgYcL7Zl5OCULomFnYK+hbfDvLE2iSlpxgo5
	 uhdS26wcEA+co5ilM/PgBr8beftbZhDxigSFva9oAqzuRlfP9ofk+X5Ha+YIhsuLaEnQ7
	 HNOOGEbHaR7Lcjt8cxbgtIpAGFRaYVICeXkqsVGkTq5zuYl1tCjbuK6lLOC5NM1C08MrR
	 uafJYujIDmBwcVmX1fSKXUMr5GcZsUjgZWWCfZBdemsTNFoq5DwQK77CQ7x8mmXcsQJWL
	 emc/lSA6Go4DlBeVrr7nYxR+pJEbL1zUdexqOdr06qz19MqrVVjj1dCr4eO9aL30OFA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794669888;
	bh=Q8IyX/A0VUsC4EL1eUHPr+xX5C56eXUM2mSHbdTPEf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xKWq0ItRLQ3zxOe7OmHJmgfuqSD0wF9t9ZVEnnq4D+axgY6vQJoDJ0cN13aCJCjv2
	 RDVH435BqPY5X0HzH09AoPUPxIyn5qIUDMiN9RqCqKnPJcKvEJnJX11Ny6Tw6A0yvj
	 SqXxGeUwqeU+e+miJNJ5lObu/Rc6AP/Pl3yLY6sj1ooGnY2PeTp5uumPwxWYfLd1yC
	 1OX3bIyyVBO+WYZZkm1vHbL98Sbhfkutg1+8OQGhNt/AcsZSCEcVDd11OIvv2lzvH1
	 +2VV1YF4ZunmI6wm+6PHSBYWq77hb1tb+iDGgvDch4qJR7IFEK0brnjKIkOUOiVD+t
	 frQLgvpFh0byQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E76D28143F;
	Sat, 14 Nov 2026 15:24:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E3D270B
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 15:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F3B2400E6
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 15:24:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6HtPHSo4LL-n for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 15:24:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8F0DB400BE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=vcat0JYY
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F0DB400BE
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 15:24:45 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so28981775e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 07:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794669883; x=1795274683;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q8IyX/A0VUsC4EL1eUHPr+xX5C56eXUM2mSHbdTPEf8=;
 b=vcat0JYYmv1s05iG5K+je1NY3w8Vcy2dM9QSUHNZHljNqkp/4ODi6GGYYQzQXI8+Sc
 spuACJU8cchBunMZHYSTTlq75ZcPBNwZCWuhc52ZyEObqQO5Y7aMoz/Lrsg+AaHSKsZy
 NZuBJT7Z4o0p2R9ek9z5ikPAA1axyal2AGaVO1bv5FOZ3lxbJrTPVYGYopozO3doAiE1
 XhhX/r0BfWOmnrELVg0l/FgeID2cNB3MgbR6YXfcA8wUQ5/raeAcWmbvJGOgbkkNS/ey
 EXsfZszozbOjMaCMWdGxy+Im9Ib9MZ4097Fi2dotFKHUox7UzvbiRTHoy2oB/+hVjZl/
 m6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794669883; x=1795274683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q8IyX/A0VUsC4EL1eUHPr+xX5C56eXUM2mSHbdTPEf8=;
 b=0MqrcmX9EXNJVzHou3NmYIo/I+TByzcxBvKU65jDYkGIpwb8ydHlqyeN2YROJzYfUq
 9aZQjS/S2sVR1rtWRXBXQro5hr6du8/TA/CmCgaadcLWt8dhGOxaP6J33n7MqdrNbZGC
 4KFwUJ6c7/00X1JKRy2hVs7Aajn8kQg3MOWWJi9SpAqSfM3LX0DpqdW667m3tkGipEz8
 K4qD8cFJ1A2mPnPRUaugvFyzq0Ebj0J3ZDtpp9ZhL5nZkcw1i1cx4/3LTe+0ghMQa1fb
 SyKUAp2L3fvxxJ5tilmGLdfN3+rbGzBRrfJ9CpZyWaiDUJsElfSKIs7x3z8t19n5l6lN
 8dOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGUlxpB8B5Lzv5xIS0Y+Cv1EGAHCGUcbu9xqHaqyTd9huUQADSPGry7RvtLMIqBI/O+GjfzocY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9g7gBMVEQhcqo9TI7SkoutXJUH4xUuIZdTs/40iy8zKJSCFhRk
 TJERbj23cPfpth6MxcE5rpOi+R0v9t2YJHCqssbeJ09nDPEA6bXgtV1a
X-Gm-Gg: AYBFou3JQ8v99ZQAG3yTmUbwewPSjOnVnLZp6D2N/g9EDMZCPv2QftlvY0DH4u6cRhc
 3ACq7Vf7CiUzIbLTO4llFvW1K6ukfC1Y2AAkDVvjAvitCwO4EIoupcIwds7HCUmxnJ4Z26evGky
 rcyJZM6eZzu6rBaShWGo6YJn8wn2AtYNtaJtMELDrWRUOrCEU8QKDoolaJ6xpAF4Fvu6rrjkzfc
 dcPbxz1fu612q+DuhYSNIkwpcIRyzuHK7A9aqHVos58rrYoSd6r1Ki4IIuPCp+lEQyapQnytCWf
 ir1vwq6kXHVmM1r357GicYfh6N2t1WPy9oObueAes8wD8aCJMjRGl7UzxfBYno/VFwcq7iPJdEz
 crprUzkJa7LBEd3mgV1C7lrQO+KWiT96pI0FgTZO9qdgmsXjsnQqIgx0gfuNC8sIjdvgYm/1BSu
 XK7dMJJbWZWaXFTNP09ltJuX6qbg/T2x+dhS9XZJCCOZY+lLrP8zBdB1KpcHkncIJBnPzbdswau
 nVf5twtgtTU/dfnJ7ZwC1QM/aUBe7stcH3HW77e3vzjzy7+jgwcGHWhfLAb3USC8k5izeKjj11m
 +sGCJxVMdY1md1TTUfj8k01YH2NmbK9LpX+5l7WHP6oSEAf8423F3S1C
X-Received: by 2002:a05:600c:2c7:b0:4a1:cfa7:e968 with SMTP id
 5b1f17b1804b1-4bb55a595f7mr79359805e9.21.1794669882865; 
 Sat, 14 Nov 2026 07:24:42 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60021375sm10747021f8f.29.2026.11.14.07.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 07:24:42 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v9 0/9] usb: ehci-vf: make the USB host port usable
Date: Sat, 14 Nov 2026 16:24:41 +0100
Message-ID: <20261114152441.881148-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023111559.4081795-1-mehmet.fide@gmail.com>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

A gentle ping on this series. It still applies to today's main and next
without changes.

Is there anything else you need from me for it?

Thanks,
Mehmet
