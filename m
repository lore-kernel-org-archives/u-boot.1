Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA73D743D8
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 20:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14A0789347;
	Wed, 20 Nov 2024 21:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S/SDvTw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236BB89353; Wed, 20 Nov 2024 19:57:26 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F0078941D
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 19:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4314e64eba4so19595e9.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732129043; x=1732733843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bSr4gd1687+pXSDgWQfgViSMB+dZieEBZd8sw87RCRU=;
 b=S/SDvTw2kHJRAelKu5fnmfHHBRwVVbaKuCHxb+IYB3UPmddjDVnzb4EyDbIdQ9PhOw
 xno36sbnR1eqnMJRL9eyUQYGUVzPuM5iwsNhZP679BL81iyp2HOKtM7vjGcXKG1G6SU3
 DIn1OcT3BOLGTdrtMz4gxxZsVx39s3C1PcpZQDZOWDiA1wWm5iKTeEAwx7Y/9maovViX
 61xG7F1u+5X9XR5APJ5vCElUoSMDbVNI18keQAeEKUL+5c0M4qCXUwUH89WoCT/GsDAX
 P87bctc1Hxtax+Spsgj36CD7f/JJUTXvysEvteYYPYdWiELlx7ggIeW3Ynq7Nz4cfSCE
 2uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732129043; x=1732733843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bSr4gd1687+pXSDgWQfgViSMB+dZieEBZd8sw87RCRU=;
 b=p2kORfWYotZGgHZAeuZjruy6zPnSV4krBX4KNZMGciTi0ySSnnmSAyLCGwC9BCkvOp
 KnqQo5jfg4G+6QHbGPgrkwJUeSbBnNXB/yD1561XuCpQVeiiOHiD7uHTxozZOhwJ4e2m
 ApDEY3zy+D+ursoul2Av8Z3hi8uMfO1Dyk4wiuAs7yJ6eixMTSiDf9itbIdHrulrz6Mg
 4gQZXHAN0qDgzquXk/Gde+G/auljUOk3yQ9onz6QfqpV/W32ofU0dFkQkD1u3IxsjhZA
 S5AYlHo2PmCVhwQWvZefey8cW8ZKH1h0pVY5x8uJcJKx7R7Xq+LOgu+wRjWAzYL5cgoN
 eRYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUicgYEs80SXz9vNWfl9hMRwirTzjbZhOFNF9H48+/LvUlNjAcv9REVWvgM72Dwk1UyOjycXfM=@lists.denx.de
X-Gm-Message-State: AOJu0YyNOtFGQyTHK4DZSpHxOt03l8L7Qi/VZXjlMkHpdDRFT5ZWNiqH
 poAWrfMYFhzw+jiUUCLPdR0XSeR5qIfrNGyxPu4ugNuFU+ZlALYG
X-Gm-Gg: ASbGncttnanZKZtfwaisc2V2VX7mtS4cLEGqyPodEP0IPO9etWdEhiTTfoMqKVw24UF
 FA0hNoDbkyjYZ5NTzKIK6hCiCF9Adc/+js+j+mnkYzqQwwR7Y5KH04d/Sms3+CdVD/k1yIu3Mc9
 mwbGv4qIJo1PxTjLlafzWc3zjpdNyrLMa2IlmFrwGxBeHnAfiE+XD5HXmPJHvw2H3id2poe7pYs
 FV+F3QF6lsZRXivJNwFayoYkTDDr/3aTtEzHSJzlf+h1/4K4M40Du6Ir3DSQwKyv8B1rVweKRT2
 lmTnc3WcfSgeqfnz2c6DXoeAsDuO
X-Google-Smtp-Source: AGHT+IHXshHJL6DKwqAgH7zxdcyqLrExngXn0WSpqEopvIXiYXBfiqpj+3FZ0KA+Ww/7DRopTGb3Dw==
X-Received: by 2002:a5d:59ae:0:b0:382:4e5c:5c96 with SMTP id
 ffacd0b85a97d-38254afd120mr1345038f8f.8.1732129043414; 
 Wed, 20 Nov 2024 10:57:23 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463bd19sm28161785e9.44.2024.11.20.10.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 10:57:22 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com,
 ada@thorsis.com, xypron.glpk@gmx.de
Cc: mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 u-boot@lists.denx.de, l.rubusch@gmail.com
Subject: [PATCH v2 0/2] doc: orthographic delights
Date: Wed, 20 Nov 2024 18:57:15 +0000
Message-Id: <20241120185717.29768-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 21:41:16 +0100
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

Fix some typos and wording in various files. As asked by Simon, several
patches per file. The commits are extracted from my other patch set.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
v1 -> v2:
- dropped entries.rst, since it is generated
- prefer British expressions
- use term "devicetree" uniformly
- fix several typos mentioned
---
Lothar Rubusch (3):
  doc: develop: Fix typos and wording in binman/binman.rst
  doc: develop: Fix typos and wording in gdb.rst

 doc/develop/gdb.rst     |  10 +-
 tools/binman/binman.rst | 232 ++++++++++++++++++++--------------------
 2 files changed, 121 insertions(+), 121 deletions(-)

-- 
2.39.2

