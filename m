Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A247E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 20:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCECE80379;
	Wed,  1 Jan 2025 21:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OIRov27J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C21E803F1; Wed,  1 Jan 2025 21:41:45 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B2C4800D7
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 21:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6dd0d09215aso88144886d6.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 12:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735764102; x=1736368902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmApw+MTb+VfC7sZucCXD87S+bYDnTGQscNmJ6hCKVc=;
 b=OIRov27JQO/e++cp110bL6myZsOPk3jnIkYeTOMTuR67T54S1yOKDlNp7WRk9fr+Xt
 jIPSFmsgaxC14qbgfR0lhWDffKzXUqCz18E1ifD5Pm3DHRzFWn9mIqg1NMX0q8pVIbKd
 m9mYI5ZhBqSFSwroMO41FCYnmTi0SJbvTvEFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735764102; x=1736368902;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmApw+MTb+VfC7sZucCXD87S+bYDnTGQscNmJ6hCKVc=;
 b=xDDySIGqmEsGA+qfPceonTTD+9gZs0PJqcCwg9q+qUkwtj4eYWjgE5VOaSlqMMdbSg
 H5dFzyGLO4Pdw9Mb0JToTtfo8n8nTW8gsL+L0K6RU8nXV1FVuoU6r/nHaUfl6tc3U6f5
 sNR2tjiDTRc7OVnkXr/FGexaAQMZT2UiyQkr0/S9DHwBKBC8cBMUf9PJmHcq9HGnL/2v
 3IF7Y5Bne5h+mm9oWRVGgWAN4aj0Z95alazWMHoz+yYcA/wWz7a4HlURIxqzZQ1brH2P
 jzub+4y+FjitWbQPDWkc52Oac6bHL+GKw9AOhV20GTiI3FB8ZBFYSKfD1bN5B4OXUDsA
 jEgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpUe+re2q0/lWF+wUZpFGmiKmQfibCZFbApLWM0Wyd26OlaS8+Yn7S1YZV2Zfx8HglQPw/jJQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwFST7hWdM+pf6Kz6Z7YJZHc+JreRyUr7NpWQqE2mkdzU7EOLCc
 kBFDnnFORybhuR1AFu91m8h4zbjphWNrk6oE5/TS12zLWtrNUwoOqJetSYVaUuT9DBdu17JXmFG
 lEF0=
X-Gm-Gg: ASbGnctRNGUGT1lYMKOYgeqvezGJcwZ5ptrfgD3rPTQ+Vt6H3FY13es67R/8dXyNtR0
 zXCrewGETPJr2vorpwaEpAZRjk+3DEvSBr3zx9JbH0S3oroH6Zzw1UmjQ9NhBS/dQB6ytqmHs0S
 ogwBJHj2Bu8nuyKLhswHlDmCBDcwT0MKRF745UcR/hpTQ4YAD2Jjl5nVuu1GUXX9GO/8ZHCxoK0
 WEtL6feWrz5fi0+mzN6tXPsKgJYl8iMs5OjEs3RlZalptieqsGzFpur
X-Google-Smtp-Source: AGHT+IFAqeSX3BtbnmmvEylxNgCzS7y5yvHEVzNAhzegnuzkG7FkRUwY1FEGdzYHYOpnp+OxN29TFA==
X-Received: by 2002:a05:6214:19cb:b0:6d8:b189:5412 with SMTP id
 6a1803df08f44-6dd2339fcf9mr725007616d6.31.1735764102111; 
 Wed, 01 Jan 2025 12:41:42 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd182070ecsm124054636d6.124.2025.01.01.12.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 12:41:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20241119100907.24531-1-heinrich.schuchardt@canonical.com>
References: <20241119100907.24531-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] net: correct the description of ip_to_string()
Message-Id: <173576410010.1694690.10679963111451174532.b4-ty@konsulko.com>
Date: Wed, 01 Jan 2025 14:41:40 -0600
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

On Tue, 19 Nov 2024 11:09:07 +0100, Heinrich Schuchardt wrote:

> The output of ip_to_string() is a string.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


