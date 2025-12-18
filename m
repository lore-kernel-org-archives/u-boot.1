Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2D9D711C8
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AFC7836AC;
	Fri, 19 Dec 2025 00:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j4gJrjPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D4283710; Fri, 19 Dec 2025 00:37:00 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8B8800AB
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-65cfc0cbaa7so445213eaf.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766101017; x=1766705817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJP+5AKr0YY6xawjHUyjtAUx6K2+O2cZ61IQmCn6oRk=;
 b=j4gJrjPt4gyCn1nVDYU1PWA+5SrTbzfltM4n+Fk/eB34k7+FBqanwk8saRXh1YuCgc
 baundVf6uE9hDQghl6RUheqdBeJ/HJxGUTRVmCqf7wi83g48SggX/xmYXgptjrNfvxT2
 9SRFaoD0VbiGrwvdZens0LyuzqQryywZwezvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766101017; x=1766705817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gJP+5AKr0YY6xawjHUyjtAUx6K2+O2cZ61IQmCn6oRk=;
 b=FNrrXhG3jfVA+UOXYkBQMwatdkdiZ5BZOUH7ZlHJdrOMCZtU8cwgrIXYW0gHl20KdV
 fz+gzs/BdY4wbLFy1K1zqO02MxK/lSCN7PkFYUlZiM2JJw37ovUzCDt9blDA3b1ZTh+G
 iJ+OiRTH1SrJ+2acjPtXHdDvNIyH7Q8NRCPbyCQn0rEPy5/zHlhjP/jb8JVZYHkih/cZ
 0GeJEmLh8l5tk9IpvsKg1qbKsc8elZUX+4Xn7rd8D3anLJflk8FKbWgTGtBRLpNZWM10
 xj9YfcPUHYY1WLGIss6FCC1MrIhP5IE4/Q0g4m0T/LHp2REA1lI66x5LlZQeXDevKBFJ
 ZD+Q==
X-Gm-Message-State: AOJu0Yz2qsOpNMItIpJzWUbLzJ9d8YgXrS62r0mx1VH3oFHFLrcEympO
 xdTncZnlbVLJdlpPQdP1TxGffdWo0U8PYhNR+GV4MK9OD+15Jz6/it5Xoj31huXskB+singC5W9
 FMnVMqL4=
X-Gm-Gg: AY/fxX4zgfxcBQ06Uk54FZoe1K5CYeOK9/efgRrMep1QMQv2bGDaEH/qGKfwnHa7jBP
 x7CNutc8cAfVnjKR+Y3JC+Qdvq+4jrenbdFqK6j9TOcHzn68ZOtVCO5b7JpPPSuc9UAdPqup0QI
 uDxawPeWL8rxP9QchSMpoRy0dBGlxOEDns3tPukQaE0jmsM1aKflGaCXYplx+IEfXJfGan3Af6w
 UwzQzx5o05l113kqk/qOu+LXac2Dk7P6xbpoo9WiSdoZMMDCwrNG1OuW8xcsoZnEwLdiexCBJ0G
 2Y9P/FpJGixsD7hwa2kzLsMFPGAkO/oXwNDEYdck9/Vag7+e1S8fA2BUo9HDbAvy/Vt4E1QyPw5
 JZ8ZK5kqmM421kTUl1aQkurWzPdQs6bR9B/oo+4mx5rtNOQJSZz2URhwwkA8iLI03sNeT+1e52F
 jBRd3ogegylIsegc47EAx5NN77Sz3KVvPVoFfaAWKAUFQ1F98XZHDL
X-Google-Smtp-Source: AGHT+IGbgwouEHkjuTct+7lwbeAHpcB/t7p5RpRqDL+RGw+bxMxNs49vagfJ7tOMyGcnVfgN35cW0g==
X-Received: by 2002:a05:6820:2d93:20b0:65c:f9c1:cba2 with SMTP id
 006d021491bc7-65d0ea694aemr402961eaf.30.1766101017341; 
 Thu, 18 Dec 2025 15:36:57 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaab5ccb9sm449605fac.10.2025.12.18.15.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:36:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
Subject: [PATCHv1 0/3] lzma: Update to 25.01 release of LZMA SDK
Date: Thu, 18 Dec 2025 17:30:55 -0600
Message-ID: <20251218233654.3938385-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218232255.3934258-1-trini@konsulko.com>
References: <20251218232255.3934258-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

As I mentioned in the RFC cover letter, the RFC version of this patch
set was expanded for easier review of the changes. This series is
intended for merge and so I've squashed all of the updates together.
There is no actual change between the two otherwise.

As potential future work, the LZMA SDK now includes an optimized
assembly routine for decompression for aarch64 and x86, of which the
aarch64 one at least at first glance looks possible to integrate with
our codebase.

Link: https://lore.kernel.org/r/20251218232255.3934258-1-trini@konsulko.com
-- 
Tom

