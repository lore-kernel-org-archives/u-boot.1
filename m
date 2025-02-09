Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A0FC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 11:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACAD18083C;
	Sun,  9 Feb 2025 12:52:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vPAtjU7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47FF680141; Sun,  9 Feb 2025 12:52:41 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A4BB807FE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 12:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0B5BB3F2BE
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739101958;
 bh=ZlA4pcbG6qvqzRM54MJoHxR69IouLcd7p1B5yr+ngQg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=vPAtjU7cXiFJbFP6n2uRy1JltzA93KkJWx9dGYvNE7GFQi6bLA9NSRS7++63txCrZ
 YnehMf6op4DIl+BKo58GHrRPUHgrzxrmw5GYuL1vvUdUNYb2Z6oc+k+EM17lUrnjm1
 JRnPaCtUeUDM4xDc9m0dmWesBu6x4DWW8+FzWV+1WyGEBjAvt7T4tZ483rpJRduQXc
 dxTRPjTPkJ6N2xW1i2ZQ2LodKa8LqaaxQ1YNZJ3RjghUWyRfYWkpP3MzlaLqBV3RYR
 gPzEAd11raZKWqE059i73CaW8WWP17toKtmcny1iwzjLV715qdJIZ4CToJWZ/oZxnE
 NDvE2p5JF/vBQ==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43942e82719so465435e9.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 03:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739101954; x=1739706754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZlA4pcbG6qvqzRM54MJoHxR69IouLcd7p1B5yr+ngQg=;
 b=WgoyWiUcVkv7yOcR2VwetSXTvxcUgDeB17taPsOU8XXceBabaVlW49bRH2KOPRhsb7
 u4QjZBJWpW7og91pX9hRbD/X2L7vbTnpPZ+jV+i++JLbXzj5WiEyLQ7LbDZcu6Oo6iA9
 LnG0PS+04gXfc8UvQ2Fj8rCRq73fgnw9FZoAaPbu3MOTUgGNO2QhpM9hZzd8IfReAy5m
 XdBvXIyVsjoxSj39ShnAujwVjD4aqvNJRdNCzwUYev6p1Jyp5v1iqPJd7nI99+PEXf8C
 95IWV5Ov9SXA7VvObISiRamM+T+d9h6xhzMJ9eGrG1lNMfwOYRVOZsWiPE0ghyHzilJK
 2SHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKH6GbtHAyhGz8cKHnjib76RHTlzTrJVi/Pi/47oXnTtby8F/zEtG7/I0hUj34WtuPcmrVUZ8=@lists.denx.de
X-Gm-Message-State: AOJu0YxRfAv4UXu4/3Q+Ih5QS12BOM871MYJToBcBHkaUxm6UrPVZJn4
 14g6uWq7bvQQNzVE/gW+Y3U2T4uwWfe+rOSt5Rwbz2pJbikWqzZba1GmDPSsLIOpdMs1nhEJ1Qp
 Ry0CtvrgIL8IhLDH3FlvPKMBkx5VnYF0IFtBp7ik6STMa3shzf0HovKjp0lOIy3KhJIE=
X-Gm-Gg: ASbGncuKXfxyy8QblX+AR/bOhLhInQgvibceDiJBD1CatA9PQ1pC5X0WfHGKOT+VsJE
 fBQCBpuVfoVId5N8vp3BV8LQaAcX9Ph//9hfpY+XPqbwbsQU04eIdpf1etTlB2Ygwh9YYzTStU2
 emuH+PyFjc8eTXTNbeMKTEYDbX2Nr5KYEIlFB7/frwyhsYiiM2KCB70ob+z1D4bH8j6rN/cmpTR
 1dkSkkW5oXgLehHwxlzH5IzdgZm7ygPe3SN7h8YZOnNCJa2w2gDJULbFqRLe7jpNv3//UsOAZ7e
 fILqP1z45gwuK2Bl4qctYIQqhMqsV0lMyWLU85zdDiNemBI0LyI0yKHRTxJ4Y8MwDuTBWWrLuJh
 EXbOmf8w=
X-Received: by 2002:a05:600c:3b11:b0:435:1a2:2633 with SMTP id
 5b1f17b1804b1-4392498fd9bmr79059515e9.15.1739101954462; 
 Sun, 09 Feb 2025 03:52:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBtLcOBJqVQEDM0jQAgKX3FcWmsc5HEF9i5JcfA200TKV54AL9LbZ43BOI5LjNtOf1+81hnA==
X-Received: by 2002:a05:600c:3b11:b0:435:1a2:2633 with SMTP id
 5b1f17b1804b1-4392498fd9bmr79059305e9.15.1739101953971; 
 Sun, 09 Feb 2025 03:52:33 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd84b9sm111772795e9.39.2025.02.09.03.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 03:52:33 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 "Franklin Cooper Jr ." <fcooper@ti.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] boot: improve error handling fit_find_config_node
Date: Sun,  9 Feb 2025 12:52:15 +0100
Message-ID: <20250209115217.85250-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

If a single configuration node lacks a description, this does not rule out
that another node with a description matches. Anyway we have the default
configuration as a fallback.

So continue if a description is missing.

If the description property is missing in a configuration of a FIT image,
relating to it as 'FDT description in DTB' is misleading. Provide a
debug message indicating which configuration node has an issue.

Heinrich Schuchardt (2):
  boot: continue in fit_find_config_node()
  boot: correct error message in fit_find_config_node()

 boot/common_fit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.47.1

