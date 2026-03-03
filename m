Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C640DEDEBE6
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 18:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FEC683F93;
	Tue,  3 Mar 2026 19:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SYTzj+Db";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADBE838BB; Tue,  3 Mar 2026 19:50:59 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F2A838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 19:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-463f00cda04so4075999b6e.2
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 10:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772563856; x=1773168656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TnlEkPCHWqlC2se2WriYXQAW0ff61pFia0dY9sZoT0=;
 b=SYTzj+DbML683UOeiFdokkFgVQ1mxs3O9AUTGAQ8XPVsymy4/9u3P+ydPeXRuc05ve
 bp3qB2g9yKQGk8SRj88l2gI+Y3vPWFyzN6r09uVf9ZtpRZ2Ex9GL8knERA47Flna1aE/
 S17NWgL4bdr23zHmtFgwQgOPQkhM21gXvTPOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772563856; x=1773168656;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4TnlEkPCHWqlC2se2WriYXQAW0ff61pFia0dY9sZoT0=;
 b=Cgcn95ZLpHFV7l7Z9G8N3eXV7j3Z4g9j01QspCQC5ap5Jrrc58JOOheUVEXeT7YxzO
 G3wnQG8NpnqcNwh5mS+UHfgmd39462CPATnTdxLAZuDudfBN+hzTPijAw6kAXvRieodc
 RPGHVG0zy2beue3KxudWwsTc2HXYSaynYjo8Bv6vrSx8ho7yFMcc5FE8caXgn7tIsj9Z
 F4Nu+CIRpKkGWbAxKZrgpqbqv5YWruN9+o8Q4/bozrxZ74x/VDPJahC8em2r1NwbbH75
 cdsULmIiA5bb6g8hphnPIVA6Y83oTRtoEstklhFgUZXcbi3d++VuOTmifNz9v1SyU1On
 lW0A==
X-Gm-Message-State: AOJu0YwvQKl6hR1Q3iMpsbBQba2xJcwKoXm8hBIqpMQdWhcv+Zoq8uaJ
 RapbySqxObR44kz9ooETPUSWelcZ1tWEf7MtvjbFJ1Yx3xFYO8N69q5GD9d7J83y0W/iSTbIq7r
 M0cHGuT0=
X-Gm-Gg: ATEYQzyj5iRI+/gsD/NQa/k4XDRZ02FCnW4Kiovb8vMJ23XIgMIh8plAl5wyS4B0l3o
 Diq2sBA8F8fjY3WF36DEBgyCLhQjeP/x6CLKAn2nYzyRcG4ilE44ST6UXNGvFfwMo8x4k6hBm3w
 t1IV89/8N3ubChcflpjkI8+LJ24wlEME5FofysHgETPswd+CxQKZkmQKFZQxgI+bGhH+ekrjNq5
 4BvXpatbcvP4leQlMMBXWhLKoi9Q1roOtkUR3E4S0N2al0zB+DF6m8Z/+epMJmqU/C2jnCWt8hy
 iUWyDmL8HoPDWIdoUQpb4lcmvas0WP34usQbXbm/cLw1AsDqQGW/Ilnnh1jz7pyz1KuiOGEwxLb
 mhk+43PrGOamMHXpPG48s18LFGRetJkraRYlSLQ3gQiZMfm54iW9wSmEkjU3Wi0s9sijyNTEATi
 nOIBXLnq/u1W0OCbKM48LyNrV1E20hiTUQ6zFIEAkw9YlJ1BMVPIR++6q2TVAnQCyK6aXvSs1lD
 nbu0N0SBVCPh4iLp1UkqLVOb/jxJ5ZIRQwV2RDNKyZh4kR64Q==
X-Received: by 2002:a05:6808:148d:b0:45c:8675:eef1 with SMTP id
 5614622812f47-464be942a6dmr8780833b6e.3.1772563856219; 
 Tue, 03 Mar 2026 10:50:56 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb605f15sm10180475b6e.20.2026.03.03.10.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 10:50:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <simon.glass@canonical.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
In-Reply-To: <20260214024736.3726811-1-simon.glass@canonical.com>
References: <20260214024736.3726811-1-simon.glass@canonical.com>
Subject: Re: [PATCH] kbuild: unexport sub_make_done to fix child make
 invocations
Message-Id: <177256385549.3975993.592734328770415000.b4-ty@konsulko.com>
Date: Tue, 03 Mar 2026 12:50:55 -0600
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

On Fri, 13 Feb 2026 19:47:34 -0700, Simon Glass wrote:

> The exported sub_make_done variable leaks into the environment of all
> child processes. When make targets like tcheck spawn independent make
> invocations with O=, those child makes inherit sub_make_done=1, skip
> the KBUILD_OUTPUT setup and try to build in the source tree.
> 
> There is a workaround that resets sub_make_done to 0 for specific test
> targets, but this isn't great since it has tolist every target that
> spawns independent make invocations.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] kbuild: unexport sub_make_done to fix child make invocations
      commit: 4284306d22c5b6d64ecd62b462551d9d313c8104
-- 
Tom


