Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F8DCD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 22:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 132B7849D9;
	Wed, 10 Jun 2026 00:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UGDzkq94";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C457849BE; Wed, 10 Jun 2026 00:28:28 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 476AD849C5
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 00:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-486d0e175e9so1757107b6e.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781044105; x=1781648905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIrnvzPbsnrjYagTWYANUsY1hdWpEnzZlsg/Wy0FMMc=;
 b=UGDzkq94LUd5C1WMuKogqcycGf/J9V3KFLcOO2ngfa/o7DlDR+ZvvdzWn9it1Nm4Q5
 OgITUIfYz2uBhVPK5eUiXH0hvSdkYR7Coszd7mrdynsvBwXqbZgouKzUz10PitmDKc1x
 w9uI3MUQYFb1D9Pg7AvWS94JOdjmUH3jV7QhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781044105; x=1781648905;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vIrnvzPbsnrjYagTWYANUsY1hdWpEnzZlsg/Wy0FMMc=;
 b=Tvc/evX7WqCZcTYfmcD4tNIr2JIuUHuhYqWtl8MzrYpzJ00ewP68EGCUTtcZzgLOj7
 huJAzS+Tq6GYVdzFvOd+AVmDOVs1QroGz3z3pkV3SB8x+g7u8z1pbVgqPP/9/6o5JRWM
 q1C1LzYYmTdwHmwGSE6xoodArdyLdPkVZZBlUse4RA2IQ9jm6CR/7kXUcbyECAqVNd02
 Ebd6Ob7lXTA9y2Nu/EYkrDEVvC6DOyJdtBDL2iGUdgRoz6vfA7KlSTFdqaO3ALwdyzeP
 aNysITN/Yj0VzvnaEsVns9QLHvS2hzijS3DR9letzVovV+8zxRuLU7BF5duVHIjYkEYn
 A7KQ==
X-Gm-Message-State: AOJu0Yw4JGNMp1BmIxrqNLre17HasDA0c3YpbI7ZdFYHm5Co+yJqR435
 R9jdCDBdqQUYhrGkdFRYt2buejVx9W+gdqfE2R7AqJ3tywUnB53TYW+6q3Cqz9ZAEqWWsJw3Tod
 bZyvqfQM=
X-Gm-Gg: Acq92OEL5cE3ffTGH5nQ+jVD03o5Cv1k/ahvzveL2t8fIXCGy0TkaLdeHxj8xI5aQYd
 TuMvR/yNcQtJWd9GdoWRaNC69fHSllCXTl3fplvt4hgPXRJ1uhdEWewVG47rB6Cxqq6Wo8+xNjN
 WrYgWGfFg8AvEWt0wSMgvp/ChisWUHhM7bSyq5ZZt3y0baRIAoeoIJ7+Rvu7HuKQX+KbVUHwi76
 2r03Jwo+yWxZdjJsX4lHnXdbK/y07txLNqLXmMM96m2hH1ldG9cC9QNWHjktZILpRsdLy9P416R
 4D6v/OcY+d/+xbEg6KSeqxGd+YUMmuT96X2UP9CP3AS1ORjj+43qyaMRA4zp4HhFlU5qHdnYEdP
 IWWjV49xVWA19cCziSqgYw+3VjPMJ7ebk2V8bhPHdqh3V2OhEvECTHRW6Bm7T2w10dnNeY30R18
 pqyU/QRxeY9w2Tt/+SxEyGRf+7WGaPpugtNVqRFOdr2VcJEVsUSAbFCJoVG0B3Xw5ybHanvVrYV
 M+Q8BWXhYs899kwCE/lotm6NsE00IjokhyvCL5bynQ5VZpoKwffjQF11FfzytsnYUsJPRg=
X-Received: by 2002:a05:6808:2444:b0:47b:c2a2:1c79 with SMTP id
 5614622812f47-4868dbe7bbcmr12399587b6e.1.1781044105085; 
 Tue, 09 Jun 2026 15:28:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm16790962b6e.8.2026.06.09.15.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 15:28:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de
In-Reply-To: <20260526064909.2741888-1-peng.fan@nxp.com>
References: <20260526064909.2741888-1-peng.fan@nxp.com>
Subject: Re: [PATCH] thermal: ti-bandgap: Use dev_read_addr_index()
Message-Id: <178104410446.79918.3919888277077980090.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 16:28:24 -0600
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

On Tue, 26 May 2026 14:49:09 +0800, peng.fan@nxp.com wrote:

> Use dev_read_addr_index() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> 

Applied to u-boot/next, thanks!

[1/1] thermal: ti-bandgap: Use dev_read_addr_index()
      commit: 8b5e2a25aba97e43180096de71a8ac5617ba25ec
-- 
Tom


