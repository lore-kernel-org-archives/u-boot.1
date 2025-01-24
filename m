Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1576FC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 22:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6682980C77;
	Fri, 24 Jan 2025 23:28:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YxQT66Z7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84B1F80ADE; Fri, 24 Jan 2025 23:28:44 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53BD180A52
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 23:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6dd43aa1558so23960956d6.0
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 14:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737757721; x=1738362521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3r4wdlr5oy/7a1XyhBjOMe0Mn77H7KiuEJuJPu1J+M0=;
 b=YxQT66Z7WLxlUn3pbEogbw8spPxdZpjbrkm+ePGMYkh8qQLV7MC3QxCnXuOnuhm+86
 ysSU735sRiY8skjcg2tw/uPjUBV3xf2F6+qww4SWHoDAttTLqCnY4kBoSR2orG5oKKg6
 ZZKjY+GzBFD3EQG/wzWGjp7w5JGBJlYK4nqq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737757721; x=1738362521;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3r4wdlr5oy/7a1XyhBjOMe0Mn77H7KiuEJuJPu1J+M0=;
 b=T+ZPzvbBLnturJF29SG7eWOg2IeIfUifK7/WoSTpo+2Q/RLy3zM6d5nu+5CpPK6GQJ
 2e58BxKCx/y+atuhiB2MJa/WyIOixe0orQgY2rRNklwBjM53E84Enh3YjJ7NTwnJGN8l
 Q+MMSV03+tFli6FOfXZNVBHMdP4ItH9fgGNDWT9FkIdMNfzH2blnd3XCzU8K3NUSBbG8
 4UwHzl8jJ7+fM3dDdrPg/uRkympMByQ5p7Nw/nprIH4NkEfGInknpbziBsrctk+2DQfS
 ++wVM3NIuLwORGecGBxPyCGpJ3b6ddhrl1+WcBWjp2fJd25r43KbQsXZjKs9kxybymVl
 EOWQ==
X-Gm-Message-State: AOJu0YyD0ZKlE7YRXOfTIdvL7fSvi6gmYJS/XkLiyBLlAlfAkGZSxcQo
 yQEUL934gY4AF9lKsNGA5v/5EABeXvLZ47PB4pi4ohLa3jyyPBGdRC4tb4C3wW4=
X-Gm-Gg: ASbGnctzcGkk3LD5cKAEyyOhpXT6h5drGHlNyOF7Obl18x6EBU1fS0ASOfbJiOdycF7
 tRxEyABm5Wz+uFrrRyYhz4XqOHKFehEy0FQgHqqDJAA3X9IFzTrTaF9kcsdpuAkHXkLPzh4wT9L
 PqKih/T8IkRcqWD2VFnqm8+Bb50mNIJthJISs2VTn8qj4eBZet/V6RI+6osfsfVS1JB/izoiYXx
 SIGXAzJKwMkZgomxnHyjz0wx0aBLTMnYiSQerr7j0HsFXDzTaL9S5bpTXf9vbybRVd5JAQfjpC/
 B9o=
X-Google-Smtp-Source: AGHT+IGg6ssbYrOeFNQwjsMeRpr+5s2WRK96GHCYuBNdIMm0oScb7MJ3fnroZ9pFm+hyzJjj9ChnBg==
X-Received: by 2002:a05:6214:54c9:b0:6d8:916b:1caa with SMTP id
 6a1803df08f44-6e1b21ef52fmr542996696d6.27.1737757721226; 
 Fri, 24 Jan 2025 14:28:41 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2052498d6sm12787946d6.47.2025.01.24.14.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 14:28:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Anurag Dutta <a-dutta@ti.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hiago De Franco <hiago.franco@toradex.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
In-Reply-To: <20250121153836.83878-1-marek.vasut+renesas@mailbox.org>
References: <20250121153836.83878-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] treewide: Replace Maximumm with Maximum in Kconfig
 symbol description
Message-Id: <173775771931.3136238.12379658221142813359.b4-ty@konsulko.com>
Date: Fri, 24 Jan 2025 16:28:39 -0600
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

On Tue, 21 Jan 2025 16:36:11 +0100, Marek Vasut wrote:

> Replace Maximumm with Maximum in Kconfig symbol description, fix a typo.
> No functional change.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


