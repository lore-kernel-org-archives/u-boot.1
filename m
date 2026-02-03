Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA5DE87852
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 18:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FB883C39;
	Tue,  3 Feb 2026 19:48:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qeRxfPZp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A69983CEA; Tue,  3 Feb 2026 19:48:00 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A83B83C29
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 19:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45f0b597eb4so3710136b6e.2
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 10:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770144477; x=1770749277; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EsXpJzA164Qj3cIMdbpwvUV5+SisZT+rCa2krUs5e2w=;
 b=qeRxfPZpfk0UiY6zoMH0EkosiAVpJ4eLU7tx8fNKnLaZmy3ElZo3aF7Fk0R7W2JiHS
 KTt+KMKdhWwuSZbqaLfp2gjyz7We1ETqEWSVz92GfSAo0scuoGD4B3KE722nQkdqiDTV
 ZqcJNifzhF1j/6+huS0cAw7hMOeOfQID/qSHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770144477; x=1770749277;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EsXpJzA164Qj3cIMdbpwvUV5+SisZT+rCa2krUs5e2w=;
 b=qKyYlwpbKthfLBUcjZuBVp1a/jmGxqv+gz5O1kFllJ6JJAXMdcQ2JkjkkYli3z/CLE
 d7o+GlQZHY82UV718s4Iz6dBUhp9J/Gx0WeF7AS8kUapCuR50e1PgBfg7afBjQzOgvmL
 7ngqlI/Vyf8AXIXx9OQEpUoSJK3xcKvHlN9O/Dnr6hCnkEtHgZj4USKGPvMtAECrIj9O
 XFmAfK17EvNi5EphZJe1WpOfjgh2NhzGFuf89vJrW9SPp7x2ndLsoBXdld0fXFFz92VM
 T29px+aSYAASaH7+w8VX34WGTpc78ml7Kyt//ilUHB80SANV5e9EcWI+pcwDrkRtcBEn
 6EYw==
X-Gm-Message-State: AOJu0Yw28cvcJravPofSiJVcvU9q8SYeLvgyqT9b/LhKpE0qFEr5uwLv
 9rbZXQIPqTPI4EduzVcXY6wftNb/GCB8TFq1cV+ufdn4weOlC5erQWqVE7sChZ+Ljts=
X-Gm-Gg: AZuq6aLHy9DjesbpjG6slJYsb89P5m9qN/y5x6HbrBnXGtvsNmLFg958B6L3oCcQXoO
 3yaJRFt7zWNnZKCNRio9moeDDQufdNuKSOGNhbO2Ea9ojZXvzY2JnGdPO+IunSIbYwNLEKuVyi4
 jhedc2O1pZZ0mPntB2wOTlFq0Ciz492+6oOVxIZCfcaYisNPpffZCfjLqQ8+rjjbAz089piYlfw
 0CTkPUJzEFtg/aEQ6uKKnKxbadhLViMc/hYmYjU7XaeY6heeroFAgbzM5D0EqyplwTpTQoTmDTm
 vEEVgfcrvp+FuOpqevQRx9dFDGRTAJ1lpL28gwuDCjJN5DADasr/FfWYQtuOMAl2Ijaho7nBZMf
 xBEZOnPsFp8b3+1imqqchMTgRuXETRaNtGI4tFQALtQoVMVJnUpdO0k9Tjk2UkxIBF3d+WsNTqY
 DheSsROq1NCmoNoW4JQgENtZwmXXPdM9ospjAkw/phcVoJjMk78kQ6rmW+0Wbtgdbz7NaXlsvS6
 816UVt5xGSNElF8Gwza144pNUvjZwuqARped5Ei/weM6Ttk
X-Received: by 2002:a05:6808:ec8:b0:45e:851c:7ee7 with SMTP id
 5614622812f47-462d58e3998mr206725b6e.24.1770144477056; 
 Tue, 03 Feb 2026 10:47:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462d67773ecsm55054b6e.11.2026.02.03.10.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:47:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, tanmay.kathpalia@altera.com, 
 dlechner@baylibre.com, me@ziyao.cc
In-Reply-To: <aYIdaqjGss6ZueXm@nxa18884-linux.ap.freescale.net>
References: <aYIdaqjGss6ZueXm@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] please pull mmc-for-2026.04-rc2
Message-Id: <177014447624.1468348.14427158934629653337.b4-ty@konsulko.com>
Date: Tue, 03 Feb 2026 12:47:56 -0600
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

On Wed, 04 Feb 2026 00:08:10 +0800, Peng Fan wrote:

> Please pull mmc-for-2026.04-rc2
> 
> --------------------------------
> Add DMA support for mediatek mmc
> Cleanup mmc cmd
> Fix typos in mmc
> --------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


