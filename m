Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21E3FD4F34
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 20:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE5438414B;
	Tue, 10 Mar 2026 21:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nC79Z7uU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B261883FA6; Tue, 10 Mar 2026 21:45:34 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1990583FBC
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 21:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4671cbce465so867051b6e.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773175531; x=1773780331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdABiOvWKsB8N8JH4wiUa3+2Wlawgt/cw61ZotQ+rpE=;
 b=nC79Z7uUS0KYx/uqUpOizY2Q3qSwX/Cem/ZuQlh80w8q2DQrrQ9ADtQ+MAxha1Kwu7
 26mGvYPZ1+8cM57cQTWScgD2E5rCPOpkGDmyJx5ymIm8YoDTTRMeh3emSmC59Q+gYqQh
 I+okAB2HPyUHC+1qLN/Vs5n2YRkta4+QNQ8IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773175531; x=1773780331;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CdABiOvWKsB8N8JH4wiUa3+2Wlawgt/cw61ZotQ+rpE=;
 b=XC4tVFlDqqfOw1q9bk3NEGjVWLCHA6k3E3+ta6UCaqJJEOVC+PP/9wieynXu+Hrj3G
 8uvvm4EJQA7OFapOhC8mM58b24jA9Odve5Pdji0TvEQyLkooZOTTn8ulzNZvY6gDY63h
 A71WqCKmOTCyCvgREXcMqtzl1CtPSHjAgKrtwXUfpC+Hg6qPSQIDywIbqsppj0zF1V8k
 1I8hI+8igMkis3tpKQi7jtIlX5BoJXSYp92gqFs6CXvwZcCiOY5a2o8+Er1LERt6Ei1g
 Hng2TDPz4vBYq2DJnFcrD2KdbwuWHR6aJ3//Iso/No4UHOUHcyjgRk0U6C5CWH8I3j+b
 c49Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX80jRvoaiG9otGs0cbQCiPUH19pQd+eG/RHLVijH/trv8QITWQCFgtB/tWwRCGwYlv8w9q7ZM=@lists.denx.de
X-Gm-Message-State: AOJu0YwuAfcbNLQkC8DmcyjDLtbsj4X5b68kWpJ8JCG7PIPSeEqvtdie
 JIyu+Jc42ZBv6G1QgluHtI8B7DDgmx8WiZ7SJ8b0bcIBsXWVKSuRKRyHq6oujWeyeXI=
X-Gm-Gg: ATEYQzxyTOa+/sxf/KEy53yB/6+jNGiRjdpKskX6JJyAqdG9HMCsLes1TqigAT2kiN6
 hUoAgxV2z+9ZyaPSNOkwN/J7exupkwmdhM/1MCzIBqZjwYGRM6wnu8NCeynxO63WxZod551hMKA
 53ChZMZ0tnSMgwubrooWhyP4QGnzOTeR1KrrLyiE9ajrq90ATiPulw8zzj3MOIt/7wXlorASwzB
 1OtewXtMSNtMfUzXfnEFf4jY9LAENaH5Cj6VjlOshetnomFbg0MVyTS0H2D2/N8Td+gOWs3BYed
 2/xZVJ6i03WmTKu7qa0/4icG4cOtHh9yFo9QI6Gxy5gziVVJ8BJDfZXxGnayhAGTLtnB9unqi+H
 /lvsgSq7Cuunukztf6Gt645oVjnEW/54JYXKmdASQYJbF+D0P1/sp6TCoxOzu6jGMPqtVZ1DzYG
 qke8B+MNjTf3SwZ1Ko2iwV0mmxWuWLUduWwBpdGvCPUm9FO6XMlQfhYIkHwzcAUanZ7k/soFPXi
 585f1hHGOZwl8EbRFGtQ3pXDvlp90cKHwPbMyErbXeu
X-Received: by 2002:a05:6808:1927:b0:463:c56f:a45b with SMTP id
 5614622812f47-467334bcce6mr45928b6e.28.1773175530732; 
 Tue, 10 Mar 2026 13:45:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfac3acfsm8256086b6e.16.2026.03.10.13.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 13:45:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
In-Reply-To: <20260225095830.45904-1-heinrich.schuchardt@canonical.com>
References: <20260225095830.45904-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] sandbox: don't imply non-existent CONFIG_KEYBOARD
Message-Id: <177317552929.23044.6309786862243316265.b4-ty@konsulko.com>
Date: Tue, 10 Mar 2026 14:45:29 -0600
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

On Wed, 25 Feb 2026 10:58:30 +0100, Heinrich Schuchardt wrote:

> Symbol CONFIG_KEYBOARD does not exist.
> Don't imply it.
> 
> 

Applied to u-boot/next, thanks!

[1/1] sandbox: don't imply non-existent CONFIG_KEYBOARD
      commit: 553b939146ae48064a64e5a545bb3864e6f81c83
-- 
Tom


