Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFF0E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 22:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93092803CB;
	Fri, 20 Dec 2024 23:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D6rjByWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9BDB803DF; Fri, 20 Dec 2024 23:26:20 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C198034E
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 23:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6d8fa32d3d6so29822956d6.2
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 14:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734733577; x=1735338377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7lNXlkphmtPd3F7v1qPFFyUePx4kBurtRMez66ipc8E=;
 b=D6rjByWZ1DfNAP22Qf1WRhZ19efET4XCGacnnkO8Hn7ammCM2yaolNXi0zx3NRw3fV
 qakCFOMFVglLQMcNiP1UQHrQ4xI/8trqTXzi0fat7ZN1aPutt9S1+Es8G/qraLgGsbcG
 N3WaUkvysVhAH7XCHcGeUayVuxx19O056Lcvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734733577; x=1735338377;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7lNXlkphmtPd3F7v1qPFFyUePx4kBurtRMez66ipc8E=;
 b=YKBcMFe2AKx+hfGdU5+CcmwmVk2nC+n3eu4TRJqhA1JEng7F9E80flYHBdLdvYGamK
 Voj8ZTzTeRftbHKKRiAsmvjp9nmEVWI++QC9nmORZ7q5xW0a4Jeh9ivxtN5Do89w0uix
 BVLjlzzGhej7hvV1S/FjfEYOiuN5g0KRxTqMVWQFbAsZXDVTNoRwGRH9ix6y8DdaVSLb
 MAd7CB7S8ppzKkAZfBaG9RTJh9rHUbpDw/XCP8N3hdUN1SkkbgZeFp0EnGHsgyEess1Q
 cruh4nR939dODAmts+glY6S8qXPoCOgg2QJDTwJ45KIUHRtSs0qFbHVgVp8tE0Zgixtt
 N4wA==
X-Gm-Message-State: AOJu0YxANEq/BDm+wfxK3Xe4/xEhHHLNiMmCG2WAEmOAWaSkaNj2bfEw
 4KXr01xYwCpiIc07sxjkvqkvA58KM7a6BplMEaxhKafcPzVZ5QvGdUyqSC/3VisBtHch8HIfdq1
 jNGI=
X-Gm-Gg: ASbGncs+7BGyme5oa4CU1nCAeEqyoBLKuZbcZU2qe606LKycNlIvBy+uVybEVgjHlCR
 /rGSHx/90mPlfmQy3nnTF8YSOc+6QuTbjvfiRP5PvSY+Vhfl859xJTPyW5+EBkN5WbMc9JPuyhd
 0iVr4IC9Vk868hhtkaW2eGariZCCE0RHgJWhRZkxEzX4ylACs913zS8qmHMj1v32p8dHLnZZdxH
 w/ApIKQoVonB4oEV5xeVOoaNBzz68bSCwC7JC50F6hRuuALr5Pb+cDe3ZIakis60ywkfnL3i0wG
 ato=
X-Google-Smtp-Source: AGHT+IEQXSYTQnvoi4lB/H9jXh3qfqlTcp6pcBIHC2ixO9rmV/hrcfSMZRWbXBbyYo/wSQyL3UXhjg==
X-Received: by 2002:a05:6214:d48:b0:6d8:5642:d9dc with SMTP id
 6a1803df08f44-6dd2334bccamr76100326d6.11.1734733577299; 
 Fri, 20 Dec 2024 14:26:17 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb4desm21055606d6.87.2024.12.20.14.26.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 14:26:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/6] Rework the BLK symbol usage in Kconfig
Date: Fri, 20 Dec 2024 16:22:16 -0600
Message-ID: <20241220222612.1757884-1-trini@konsulko.com>
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

One problem we have today is how the BLK symbol is set and used in
Kconfig files. Part of the challenge is that we use it as a gating
symbol for "we have a block device" and also for "enable block device
library code". What this series does is move to always use "select BLK"
by block drivers (a few were and a few others had it the inverse) and
then "depends on BLK" for functionality that needs a block device
present. The end result of this series is that a number of platforms
which had disabled EFI_LOADER now don't ask for it (they have no block
device) and espresso7420 has a regression about MMC support fixed.

-- 
Tom

