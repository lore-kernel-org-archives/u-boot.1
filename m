Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF37D62069
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 10:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 627278953C;
	Tue, 19 Nov 2024 11:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SRXvZdGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A67489543; Tue, 19 Nov 2024 11:09:26 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 356228953A
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 11:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B3C903FA4D
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 10:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732010963;
 bh=dWi2RFG3+J0NCpZstFJ/nmoGedgZQGIlIJcdr3l8i5M=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=SRXvZdGv7D5itbpHi3xzoeYlHV7Fh6tPdv8hPEYSRLl3rSNhg1Q02ZDv89lCW5HtO
 QkVQh6BCZt0Qri+egA75mzchADnyGcbvHTSylIX3KXsOgC4Xtkx2UUKTh5MoZr7veO
 BQV1yFZX7wQ+ApD4u71+46wHFblwGxrO483o77kJ+8vNcJ0J8+SjX1t6edmqM0dzVA
 fdcTP7E0hYNRxqAgy4v0nE0KHwsZoSRNTxDzH/sPz3hwziLcr2QUnYrida9blZgnpj
 dFfUBji49V3FIWOmsFtvoQAn19kiAKfoVWdemU+aofVaM3tp81cSB/LPSho6j8EJzw
 4dth5C2oQ6Qlg==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431604a3b47so5559165e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 02:09:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732010963; x=1732615763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dWi2RFG3+J0NCpZstFJ/nmoGedgZQGIlIJcdr3l8i5M=;
 b=TPCvYkHEiiVPxiEp/DPy5Xc/wk8xfSxFqZzBoB7qA/GXiAwciqVKgqf2Osrqc97qNQ
 NucCTaOMykxZR29steMivd7ptNvui9mNgSF6HdtFH4t4Cl199imuhFsFJm9pg0NB3z6e
 zIPc4mEecfi3OBCgVJdmYsFH09abpHJBlrWci0Gx3e4tPFZ1XJ2YlKauJAua0FJ0Gosi
 D0Ub9CgXZO/jTlMnK1Q9Nw53UBoGq1lzgxlpEiF56GiqNorf+OX7iaIctlNmNnthHhjJ
 BQyIsxSiphcsaxU72xjuq454EtLy3yOVwHHoAFNYA1z/WzZ3JdFoDgbg2cb/geu6LsZZ
 7vLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNJd1fKGdU02JoL0bYucVPUOk6kPKPyI9U6Quieka0AwqUBd28g8HWermvA/M9j0WX+Qw9qw4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz02N8CoTakDLXkeE7A+Bn94Dh7tqAyxRNK7S13wC5sm3O+3c3P
 5jOGwoYlnJQNatbNwA3VnXHTqJTXH8NApuqhKi2lOHtUOWoHmj2ISC0MEFEasCRIb3n1fYB5CD7
 nkOgy/DuFsSJR1pQZSdiSjS5bsQwnKOEi5ZEzRLdMCcL+iNAl3Mx0a7wAGA/WdgkYRqI=
X-Received: by 2002:a5d:59af:0:b0:382:41ad:d8d1 with SMTP id
 ffacd0b85a97d-38241adda6emr5469474f8f.53.1732010963292; 
 Tue, 19 Nov 2024 02:09:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELwJ7Nl2xu0w+OY8uAHDP+BNf3eyoyDCVOsDSa2N2gIRrJ3/Qx8LLH+uECmK9bkuQZfNjU5A==
X-Received: by 2002:a5d:59af:0:b0:382:41ad:d8d1 with SMTP id
 ffacd0b85a97d-38241adda6emr5469457f8f.53.1732010962975; 
 Tue, 19 Nov 2024 02:09:22 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3824770f3dasm5660945f8f.54.2024.11.19.02.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 02:09:22 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] net: correct the description of ip_to_string()
Date: Tue, 19 Nov 2024 11:09:07 +0100
Message-ID: <20241119100907.24531-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The output of ip_to_string() is a string.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/net-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net-common.h b/include/net-common.h
index b7a519e36db..ed3d0a4a185 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -427,7 +427,7 @@ void string_to_enetaddr(const char *addr, uint8_t *enetaddr);
 struct in_addr string_to_ip(const char *s);
 
 /**
- * ip_to_string() - Convert a string to ip address
+ * ip_to_string() - Convert an IPv4 address to a string
  *
  * Implemented in lib/net_utils.c (built unconditionally)
  *
-- 
2.45.2

