Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68775C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 23:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CEC58338C;
	Thu, 29 May 2025 01:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YEAX5Ser";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DDEB83339; Thu, 29 May 2025 01:30:58 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6622783339
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 01:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c16e658f4so230614a34.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748475054; x=1749079854; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EC0QwJNfka8OKZhefXDsOJVeP2QxRfRU0JHyw2n42wE=;
 b=YEAX5SerjzB+RSS3Nwl3TYnIjK8GFZQi9Uh+q1QU+rosaTOYFPs9jrZ7qLqxPzWLxa
 zHSy+XY+JbFxQJtVpSYFJ+kCzHNXnlbPqdikd96WP1OhETbPq8JTtyNoaZitiHAzl1nb
 0EQ5xr8JVgPn75Y/ssYWJGJbwewemAxHaTnvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748475054; x=1749079854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EC0QwJNfka8OKZhefXDsOJVeP2QxRfRU0JHyw2n42wE=;
 b=fG6i2WDtKeUm0w6g9o+DSgvno8HGFl+BjeU7PIzB6uh4d5e7A6Th0Xo88jSiYRZevY
 PtulO0K0jI94Zw4zODkMCFPJemFgy+YGx8+K65jpyRrW/MYm6nG6z9C6mwLafIYfiZdq
 SEVm18rc3xJOOL3Qfwdx7HZn0CTabJL1/BOYqi8J23qtBwY+aiTf776KlIGxSFdTvAvu
 EdterlWgq48Se8m2tJrOXh+CXVRVY/0X3aGVadoPshaS1BfdVIOWkh7AVdVx0XZenx3a
 niHQYaxXkMt/lPg/y4cf25xld79NXxpCnRnWfkHUfnXGbZdG0CdcnuZ/ub2Vgy44eomq
 52cw==
X-Gm-Message-State: AOJu0YxfzxOd0ZWdC0TU0Jl+LWhrbRrzkBqL4+/nfwisAks8EcPVnVFK
 BRJPNgv3r5uZ1NU0I7Qa6rVsMlGuQl1dOVagagGiwE3kHr83x37yeBPSp8ev/1T91lrotLIgLVU
 TH+lbu/4=
X-Gm-Gg: ASbGncuJQrrUo6wriGLRGVXfEvry2lu39P+D+R63t/4jfcOQThyNarz92kJE0w5ojpq
 aqKfjhBIe2M+hxpsIKBf41K3+3EBz76DXC/OEU5+eBs/UOIP5HcSRLiyRJfZD6P4Cmu7UUPJVEp
 MbDa1mQz/Oh9wCyQJ5WSLeMuZ96MhVaSQDuzaKpOBX8Qth2TNtL4a4gKzgAK0K9aDkwOGVZ3jna
 2uNTN91YAeps9Uv12/LFiB0OAL1wKsN8FbBJeKWYmBBL5KeCdMr1b3QfaUGD+pKD0fAh1AFCG+Q
 yCqJI4YdGIVPIT69VPsaMtGWsreqifVWMGAA8I20aDbyAhZ6yb/Tq5I0Rw1XstL7KHXnIUdEdrB
 mig3W6jJf5pqpRH0K6z2q30bRyw==
X-Google-Smtp-Source: AGHT+IEvNP7rT8srXLIJG3elzljDlm1CtIwOMX5p5Q4+VpYjZQUPP3cezQqZHjJkku/Skfr/IQZINQ==
X-Received: by 2002:a05:6830:6998:b0:727:3664:ca28 with SMTP id
 46e09a7af769-7355cda0879mr12579241a34.0.1748475053777; 
 Wed, 28 May 2025 16:30:53 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af9bc741sm58239a34.44.2025.05.28.16.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 16:30:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH 0/7] Remove as much arch/arm/dts/*.h as possible
Date: Wed, 28 May 2025 17:27:03 -0600
Message-ID: <20250528233050.3820722-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Taking inspiration from Heiko's patch[1] this series goes and cleans up
all of the arch/arm/dts/*.h files that can be easily removed. The big
challenge I ran in to here was that for some platforms that aren't using
OF_UPSTREAM were didn't have a sufficiently deep search path to find
files there rather than arch/arm/dts. This also showed that only ARM had
local header files to deal with.

[1]: https://lore.kernel.org/u-boot/20250528090536.765499-1-heiko.thiery@gmail.com/
-- 
Tom

