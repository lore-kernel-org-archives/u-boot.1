Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B63E7E0CD
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39D798397D;
	Mon,  9 Feb 2026 18:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mnXyruuO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21FC38388D; Mon,  9 Feb 2026 18:56:17 +0100 (CET)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E7880325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 18:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x141.google.com with SMTP id
 2adb3069b0e04-59dd22b9895so6342018e87.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 09:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770659774; x=1771264574; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8GWblqx7ltn6ttg8eQ5LJIFsJdb7gNs7KCQMrTmsNGw=;
 b=mnXyruuO9rP/JRcx5XOp4ZCmiKQyUBsHA7ELsEmgOvtKSVwUbZY5uC85Bk1xxcgcIe
 1xPcCA9AoYTgvxHMquajzUWjcePbipIKPhu/ElgptMw0UgNKL/0DHa17N5rW3SW6y9IH
 wklXCY947Qf6lMV6f89oNap28G7+kh3iSC6V7uV1X/vgXfc3H0N3MXljaxlLenfC3avD
 LITGyHrGtqTlqlKeKWpRgXEFFib9XEbRvNe5fVSBmFMYjde02fGjA+G5UyXvUIbQrZqz
 2ycGGm5QA4U2ZO75yn3govmz9/1o9AENXr28xizExk9jLy8pE8rGBPd7UMGwlwKl7+yx
 3XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770659774; x=1771264574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GWblqx7ltn6ttg8eQ5LJIFsJdb7gNs7KCQMrTmsNGw=;
 b=VWcRrgHcY79arILCMO65xoHzZwpVEkzt8cVJ8u2yRKao7dp4orbAZYMTD0eRC65a/s
 G2WgClcQbDSRD3nnHeg02zClSV0IfAqzgGNQoHOXVNyOolQvSfZ0G48PdA+WowiyD/zF
 glH09HIThKHlvIgTiuP5OooLuTgkcZlscFgeUNCNvOQ1HJaEjNMLCDgnIcjtrocs171r
 5pyoZRNAW/tkgpQRsID1Swq/+6zxr98VHGiQ+NYv1sx3r5uvx17FsXqhFrKwlm362vHn
 Gr5OEomtuQ55AQDtwT4tP6KYs5c5R8pVkzHpWEEQRgFotbCGZzkzsUKZo3O4bR3PCmlU
 +2bw==
X-Gm-Message-State: AOJu0YwvkAyPDU/D+V6Qmfbahw7WOLoDmmrT8XH821i5tzsHbwMPUL5L
 uq649BdzsCDgeajde6KRuIQyBUv23SvcxayRKcCDfU0xHOfiMwwYqtLP
X-Gm-Gg: AZuq6aL9WUnlPc6sNfAZTjMwyuG8SxLp6K8lrCkVpNSaRaeGSpngY3Vl4HxPgQVDBn8
 WVjnBjwn4GCjBrnu9SY25VAzjo/kIoza3zQr9yWg4qx+n24TLziVVCmuOmQ39cfZaE1V8lg639T
 jFv/jgCpBjacSomQabHtZqQBcx8vIy3CEG3Ykf0ez8WBC+iStgVt3imqGR0LcsvW1K2M3IerYdP
 kocJl3yQKlSkIYOWb8NaesBAGQ3wT/GMXjyMhDxW5L5drRt+owpYZBuTJc8U/YSK0L4855gea46
 vDiG8A3LPIpZEOUqBUHgKdIONaykp4amct8qJaYVZMNqxn3zaNn8jymVpdqEkBS648PQyOEqNUK
 wh/YXuDr/Fh6ayPx1qdwy+7RccMlmxDe57s4J2uQSV1ubq+tYBieOyIPEgwTpSyDPL/8BVjIo/d
 ji
X-Received: by 2002:a05:6512:3345:b0:59e:4fb4:9bbb with SMTP id
 2adb3069b0e04-59e5438474cmr86441e87.17.1770659774140; 
 Mon, 09 Feb 2026 09:56:14 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e4c86dd3esm1706373e87.54.2026.02.09.09.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:56:12 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Geis <pgwipeout@gmail.com>, Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] doc: board: tegra: improve documentation
Date: Mon,  9 Feb 2026 19:55:49 +0200
Message-ID: <20260209175553.31609-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Remove redundant chapters, clarify and reword confusing sections.

Svyatoslav Ryhel (1):
  doc: board: tegra: improve documentation

 doc/board/acer/picasso.rst         | 95 ++++++++++++++++++------------
 doc/board/asus/grouper.rst         | 65 ++++++++------------
 doc/board/asus/transformer_t20.rst | 64 ++++++++------------
 doc/board/asus/transformer_t30.rst | 74 +++++++++++------------
 doc/board/htc/endeavoru.rst        | 63 +++++++-------------
 doc/board/lg/star.rst              | 62 +++++++------------
 doc/board/lg/x3_t30.rst            | 62 +++++++------------
 doc/board/microsoft/surface-2.rst  |  2 +-
 doc/board/motorola/mot.rst         | 23 +++++++-
 doc/board/ouya/ouya.rst            | 64 ++++++++------------
 doc/board/samsung/n1.rst           |  3 +-
 doc/board/wexler/qc750.rst         | 54 ++++++-----------
 doc/board/xiaomi/mocha.rst         | 12 ++--
 13 files changed, 273 insertions(+), 370 deletions(-)

-- 
2.51.0

