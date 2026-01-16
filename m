Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4836FC982EE
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:23:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB1AD83935;
	Fri, 16 Jan 2026 19:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kbT61GkS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1DF883956; Fri, 16 Jan 2026 19:23:42 +0100 (CET)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A82D8367F
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7cfcc131958so1522205a34.0
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768587819; x=1769192619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OL9WwtsmAIhxy7eVwFBz7qc7Fa7IwOWy1jx0Am9FRzM=;
 b=kbT61GkSFUmRyH7o7iWOsfPc/B+qsm4+BWArwd1HWI/ZbtiYElcGprSjXnrb5/sODb
 HBGhtGGgbrVtu5lJdccMnv06s5xpSX/0bkDIQzkgwSCd26XCJGMtwfYnKWcj+E+axTQi
 7bwZ0iv+8TDRvd2jzbxrhf/O/QsJaiQAhdT3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768587819; x=1769192619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OL9WwtsmAIhxy7eVwFBz7qc7Fa7IwOWy1jx0Am9FRzM=;
 b=tFKjPa80kL8iUQ5oRD9DawYaMxnmQYXWH5QLS5lTzwVMgFGHCB+pMDFrZAP1g6WiF/
 SMOgQfRAGACiQGLEUOQWNubjxY6v/Bw/lkpfD2lFj78zB7941C1gDfE7lsJbj5p0Csx/
 RHyUMZUk+325mbgwH+daVFdq+3uGBjx3qlwCPsNGVOS5dVGgI8lNyFnSp48C94PHTL+M
 jWHIw/oYmhEpff1spDSQXs89t7P/oMcCFoXBj/lphzOHGm3N6nll+DjnqTAa6OVCXPKJ
 JhLPwcdmtp18L2QJEsJfk8AMN3wulEVIIfd0vw6g9mO9peLaVMV+sM/28Zhc16T5nvD2
 hgBA==
X-Gm-Message-State: AOJu0YxeOg0Lxgf68gtNwioIXw3hfFIhBp+ZhwCcRrmaMLxbVsAWKjVe
 3EGfFLCUDthkqOtOJzVH1NsWdXSanjbai6ipnsWBeFeCgiQ8EzhQPnuDUO/jPssP5u+Lt4JOfAt
 vRHw3AIw=
X-Gm-Gg: AY/fxX40F6v5h+MjxLsLvyobnnQKaHPaGWI8B2bg5/xJKHbb/XtcuKcGmWEK71pJ4Gc
 Z4kIySPQMXEcxiAOCPbMMxRyRuEStgw2N9jDYkpkF6FKkPB1C8m0vb0a+CJ3cStald5/MPq82TB
 mFaQaPm+sNwz07i3XBa37rlIC2BCTn9ynGXTRL3ao4YHmNm2OWAaJnci/rmDloos0BwFCtlRMH3
 icgYcofgj4aEuVkvvANSF8PsO0cgVkL9OJACHOJvNrsC79XzAyYR0SwlmN2QyRl/R0d9Oi1hnYn
 Dl56wqTlwnBuZEHHnQkzhYeR/A0mUJ/oLczLH+5mJYNsaMAiYa2EuLaUQsqQ5K5s/A/vzCN4hCM
 QfKoTnhxeIEnBpJyZfU2vwS8w430IdJtdXYahAjltHa7EYifV/v3sziLjX4yt6XFc+RXFty2Nqa
 G8XXKfUcREnHxFU2zIZfwOB9Vomvb9fpLrzha866eLDQ6N7i3WidSkhbZACq79b5I4lzR28MVdb
 Bw1LdHHbGO4Rsu3MXI+Ho4rN498yWTnM2qov3YMVQ==
X-Received: by 2002:a9d:77da:0:b0:7cf:e539:dcf0 with SMTP id
 46e09a7af769-7cfe539e971mr848099a34.10.1768587819027; 
 Fri, 16 Jan 2026 10:23:39 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf28ef44sm2152994a34.18.2026.01.16.10.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:23:38 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, E Shattow <e@freeshell.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 0/3] doc: develop: process: Clarify some patch editing
 expectations
Date: Fri, 16 Jan 2026 12:16:47 -0600
Message-ID: <20260116182335.4081828-1-trini@konsulko.com>
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

This is a v2 of
https://lore.kernel.org/u-boot/20260109172905.1446923-1-trini@konsulko.com/
where I've rewritten everything from scratch.

The goal of this series is to make it clear that custodians are only
supposed to make very limited changes to patches prior to merging. This
ends up being a small series in that with the current structure of the
document there's not a good place to do that. So this changes the
current document to have the "workflow" section refer back to the
custodian section when discussing the state of a patch itself, converts
what we have today to bullet points and then states the limited
circumstances where custodians should make in-line edits while applying.

-- 
Tom

