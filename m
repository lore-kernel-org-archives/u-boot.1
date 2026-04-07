Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1D8FF5136
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95A22841FF;
	Tue,  7 Apr 2026 21:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FE1IxsGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CD7A84178; Tue,  7 Apr 2026 21:50:27 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B23DB84144
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-4138136f02eso3615430fac.2
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591423; x=1776196223; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g8BJP5awD6gpOYWgzE8cFlQO1QkaBdJCXgrqkqXvISY=;
 b=FE1IxsGj4I3RjPcXx2geQKK9E/nOJbuKqwvsugscVGagoc6rglUoTlvqjzFPHFAsJ2
 NzIycs5YTkGW0gnRxuJZUinqJy6VWdl3B4cX5H/j8fC8xhKzSgZKzOHNyMA+x/mFRf/G
 G/Cbkqnh46+mWp/nixsMVvWLmD+MAVRu4iqUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591423; x=1776196223;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g8BJP5awD6gpOYWgzE8cFlQO1QkaBdJCXgrqkqXvISY=;
 b=ALiaeXlqLTyFd+SxIWUHvTwDoqMEA8PetG38h7WEpeaF2v85K/iC/SrU/Mf/6abKe7
 SDY9ALk7DyYq4SUKNLeBi/MdURNxpY0aaWyMhyiJnftOOzknncLgznAQuyq1hP1vEEKq
 SuUh6OaM7nfFWbVv8MLBOV+MfLThPlCyPLBGoOVUg5YkYoEXaxrEj40xV/7YleC7D3O8
 MVBCKRmpecLEuKJqskKZ4H5ydUQK/tfdbjFjnsW2guFJgh+3y/3GpQqzZnHHJgkspqy6
 ivcqXHR1w7vON7r8l2Tr5sSh9DfOl1rl0NPGiiMbTSSk5k1qKV+sryuymDVZzEQt+2eo
 mu4w==
X-Gm-Message-State: AOJu0YzVj5nexuvTEzZ/qTlQtPPvZ+bhdbrvA4ofb4ByR/QbtHjgCcDL
 0F8hTRU1d/x7i0hqmJI1kziIX7RFccA5NttmxjShoaYu/tI0s1Zc0T49v4cjP6pL1XewPeFWCd6
 u/+safqs=
X-Gm-Gg: AeBDiet/iU8kehApOQ2yKTjQ05lpLoPLVfoeaLziDK6CewjhXd1izvCbjDcAgugudHY
 apn0e1oGVU6n4/ePvOrfPdKGazQcHfrtmB7yotIa1ZOyd2u08vHWwx9DRS0FR237USTJdvdYPci
 1nAJX+ubgA7F1uN9N5+w+cGEshgU+qE/WS02C1pmVcWn2+5lc8y/NJil759L32ZJXnMDf7pcyQ2
 mXPGcNae09pvgoJBrtrUwGiWzy0M0pH2jIzGm7K/R025iszMlOJO3QlT+JQ+h4tLxgJky5w0hMS
 SRSOd0CBYSHz5CLFth6jhwiVDjtO2t/p3f1cXYPIZdhjOlQc/Vgp4rMkPFZARL90saw9dQ++Wd9
 VSgZ7wOF2Rhyvdidjk/I4st3UJ+ZICR1R5puZu1Id8+8+pnPTzCPeEBEfy9s0vQcdI0xdLT+b7V
 nL7Y/4PaByFPXqdJmqNgtSsKMTi/KhIbNphpttWAq01t5rXeuYHF2k6XPjNWXH2SCUCB+JMQHKI
 E+8z+x2E1u02sMPW3zLvjDjCmL+EBLYevECsKF7bRoITIw=
X-Received: by 2002:a05:6870:d330:b0:417:2d6d:b7b0 with SMTP id
 586e51a60fabf-4230f6b3127mr10100373fac.0.1775591423399; 
 Tue, 07 Apr 2026 12:50:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260324194535.2338985-1-sjg@chromium.org>
References: <20260324194535.2338985-1-sjg@chromium.org>
Subject: Re: [PATCH] sandbox: Adjust how OS-interface files are built
Message-Id: <177559142280.2108693.12090806018187312104.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:22 -0600
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

On Tue, 24 Mar 2026 13:45:20 -0600, Simon Glass wrote:

> The current mechanism uses a completely separate build rule for each
> file which must be built with system headers. This is tricky to
> maintain.
> 
> Add a foreach template in the sandbox cpu Makefile which generates the
> custom compile rules from a CFLAGS_USE_SYSHDRS list. This keeps the
> rules data-driven without needing changes to the common
> scripts/Makefile.lib, which could affect other architectures.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] sandbox: Adjust how OS-interface files are built
      commit: 738428dc0e761617c5196a5210774ac7347e6bb7
-- 
Tom


