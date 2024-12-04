Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E45E7716F
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 23:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3198971C;
	Thu,  5 Dec 2024 00:59:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mind.be header.i=@mind.be header.b="a+5xkrbf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6D8588EC6; Wed,  4 Dec 2024 23:31:46 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E2C89443
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 23:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=olivier.lheureux@essensium.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385e5db74d3so167144f8f.0
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 14:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mind.be; s=google; t=1733351504; x=1733956304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KzgK3FXERQKN2KPC2pTn9PVc2bi5WvOMyTJOraRkkTY=;
 b=a+5xkrbf5cbg6iIY+0+kv7r1XOxPXsZjXv1DmbtC8FOeWWLtnkBTwUE68bX1v82+QX
 2jRx/tVmDGUuMNIhOeCguZhJwD4XBG1MgWOF5eYXx0cXbFDktZTsthR9xnXG6KqoYmzi
 /GGWmyl0LXFUqtLeg5P26y69b6L33JlxS3uIxLNatVrdaynkxXhvEtUkiw+3ZkZmNdq+
 Qrq8JMl5iqAwLUPQDlJC0BjLGdN58ffI9qLeDU0wi0sysBHz6VL5n0J5l8r13Q0kgSeC
 KQHUQyIRhgGY3YAnoMJJ7T+MvtNomlvzjFsCn79jbEUKIYjQQauriKN9ZGwF5iXr/XOy
 Dg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733351504; x=1733956304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KzgK3FXERQKN2KPC2pTn9PVc2bi5WvOMyTJOraRkkTY=;
 b=vclFqEm8M0LJSji3DQsfDupmc5suXnJy3xVWgcghW6/Qy2RMPJ+GdFf4eiHk8o8IJM
 zEXXsziSKBFRL9Mr8TMAdS4CM/ogQHLJZ6NaujQyTjJQrLiWwP1F/PlLYqod1LRDfnJM
 K+o8HCbpAL5PJEB8nQD+op6G0bWCF37Fn5iqhXlpVnNCZrDLZUFi9LZlBmUPv1sRWURA
 +kkAd7P4+OXNcQ1XOUJtk8Tn4ccnltV054K+G+0q/U+IVlzKErK1T+9SYH0Ss7XyQluw
 ff2wydguzTG+mzAMg7T/0oFBvfD6dNMGncPYYtzte/WSUXmDCWfK37Ivd2qrA/UDb4wG
 hi0Q==
X-Gm-Message-State: AOJu0YxbG9qBcpoG+YE5XhBn5jcZLrTBqtFLFdV6Y9+dFsdlLOyjKM+b
 SCdb4fUQc9IyHc2KTZAlGqCNciMsv1OAYfsqNQQKsKHDnVMPtb74ou4+s6QTJOWKzJlvVAlMS0G
 a
X-Gm-Gg: ASbGncu7hBOpPSC+jWycgiKOFyW9DXUtL8NR7ygllKKiRyWJ0FAwPkoyrmqMCcJHDbm
 9dFQ7YpmvSCp3KaK4FaSXsK3OceM/8Dt16rdGN2l9iuOqrtIKUKqzOhffOXK43u75Hwhwy0OFgy
 n9zuDdyZZqm/Vk9EveoWA2cAK+HHxSgGXt6ngg8QE/lhXDapWYNQ3Zc6UB4wFTXNCmRqFVH/Ymj
 WXCsCYUr4u0+C/n6xDmSq2LDpqLujzl/Co8YKWB/kQbcwdlYNOfixffthm3JwTKYNWGMeUe7ZWJ
 T/weqMEoSw==
X-Google-Smtp-Source: AGHT+IFrRKln33ZSs4VtArptnN/UAVJYmMIKFXOlxSzHUR145QEL3qrmi98qmxCEdbCqC9u4YQGDaQ==
X-Received: by 2002:a05:6000:491b:b0:385:f13c:570a with SMTP id
 ffacd0b85a97d-385fd3c59b2mr7532026f8f.7.1733351504184; 
 Wed, 04 Dec 2024 14:31:44 -0800 (PST)
Received: from olheureu-ThinkPad-E560.fritz.box
 ([2a02:578:85b9:1300:127d:9c22:de23:d041])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da0d6b38sm1419385e9.17.2024.12.04.14.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 14:31:43 -0800 (PST)
From: Olivier L'Heureux <olivier.lheureux@mind.be>
To: u-boot@lists.denx.de
Cc: Olivier L'Heureux <olivier.lheureux@mind.be>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/1] doc: fix the "sb" command name
Date: Wed,  4 Dec 2024 23:30:59 +0100
Message-ID: <20241204223107.43349-1-olivier.lheureux@mind.be>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 05 Dec 2024 00:59:15 +0100
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

Hello!

I have found a trivial typo in U-Boot's documentation: the "sb"
command was documented and indexed as "sbi". Patch follows.

                Regards,

                Olivier

Olivier L'Heureux (1):
  doc: sandbox: Fix the "sb" command name

 doc/usage/cmd/sb.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: c498b6cace9e0de45ea12146312f5a6f43a03a9b
-- 
2.45.2

