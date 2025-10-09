Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F68CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7194B84517;
	Thu,  9 Oct 2025 16:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ExV5OV/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 483898441D; Thu,  9 Oct 2025 16:18:55 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39776840D5
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-79d36a6298dso398528a34.0
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019532; x=1760624332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ULsGAcl6OYQLKuxJ2FwrmIPZMwlfDXkVMlftiUb4ei0=;
 b=ExV5OV/yQCro//WIK+EkSAMVLZCWJXaajjQNuRvgihoyK6uuPVxmrYsGGWzBxg2XpJ
 fnKG0uZNdLnxcKycWJ1wzwFHq2/nlkSucpHdBhTYHBAzO5ooqFiFLWM6DAiIvvWvNDWr
 QG5ieX0aQnDFrTATEZi1VtlDj3NL6LtxxrFpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019532; x=1760624332;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULsGAcl6OYQLKuxJ2FwrmIPZMwlfDXkVMlftiUb4ei0=;
 b=McjgDdjpnXDr6kJxwbcetoqmgrCYzPnn4MFJ3teL/zE6pzk9b6pyr8wLiTUoZNR3cG
 CC6k+qqRhtGGN9KnYNdYw/2jHbuZE7qRoJjK4kF6xrtz8klhE0G7terzokUqHw5Nf4v+
 ON7i6BbYGo0bMcoo5qItyTzoKH9XhHtoiBObs4uYcAMGQRVl3n0akbo57aTmF6k3akgm
 LhMO4IXkWFi5k5fW5DCqx/WWHpFWEed8cWqT+ao6q1cOzj0aG6XjYDEePP2bjWqlplTo
 PhNslDA2fLKG6pioR6t/aSQ8xMWuGlQtQcMpBYKnKLJRQ+xFsa3UnXZeiNa0Ih/C4RyR
 DUSg==
X-Gm-Message-State: AOJu0Yznw5zU92dybby1ml9Hdqzzt/dPFH6P78UxMNpOw+ict2g70JXu
 AMkbanJBE1PjKH97N17RInYTlBDmL+CUc3oaWTi8rHZRX9NpJmGgAnoe46qMA0veN8WdNuC/yDo
 N2s+SC1I=
X-Gm-Gg: ASbGncurM1OuP4qm0QbrS2r78pXZGxz5r7wRHYgcCgIDcDsL8ZM3p3UPnVBUfLGmDs5
 7EknoIpP4/U+v2ieNUi4EVwC352R8CJXBeGNc5ya38x1mWxc7N/Gl1CU41O8TaBL1kWJK07eyJp
 KAuLBRJViONeeF2ocTCg7TteEXhSgdkznY2gGFn6i3pV8S48NvqmfHLJl6i2BKR7hX6ZbKjI79i
 rPoxrSwuMwT+ADZFl5S7OkZ3xaT04atIWylTxJtQ8+ypgcyNApMzVUOZWmjUJVTZ+pXF8zQFJ6H
 IRBuvyJnFjHL9JN8s0mj3fHBCdtaA8io2pmw86epAC0xss1Yn+csV4cuKABLOsmv73Wne1qQ1jy
 7Eeg0qySxfWRwkGXSKbC7t9dG1nwWvMFy+AvvTKnV6el6QZGzbPeaMy9E9VQwA35cM/OzuP88A5
 7zkihhJMzu
X-Google-Smtp-Source: AGHT+IHyDB3ftqq+HqS1gf1qsVUe3rjS6+u0J5V7qv8LqYFhZK9vux1IeBzUngIqqUy4/RtWsnv1wg==
X-Received: by 2002:a05:6830:6d05:b0:758:21cc:a450 with SMTP id
 46e09a7af769-7c0df734f1dmr4702639a34.16.1760019531851; 
 Thu, 09 Oct 2025 07:18:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:18:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250925205122.3561877-1-trini@konsulko.com>
References: <20250925205122.3561877-1-trini@konsulko.com>
Subject: Re: [PATCH] Kconfig: Make further use of testing for !COMPILE_TEST
Message-Id: <176001953104.3159859.3253492359399317472.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:18:51 -0600
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

On Thu, 25 Sep 2025 14:51:22 -0600, Tom Rini wrote:

> We have a large number of library symbols that should not be prompted
> for by the user really but rather selected by the platform (or SoC) as
> needed. To start with however, make these depend on !COMPILE_TEST.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Kconfig: Make further use of testing for !COMPILE_TEST
      commit: 2d11e5ba4ea851947a6e27c96474fad0254031f4
-- 
Tom


