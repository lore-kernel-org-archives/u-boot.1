Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92391606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UNGAjkDI;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yhrk1tHk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1B4580D48;
	Mon, 23 Nov 2026 23:03:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VVw_QT3CNn73; Mon, 23 Nov 2026 23:03:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DEAB980D3E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795474985;
	b=cZZ8hrPQkJTNZxBvo6qBlExK7GVJqYAZhcvzhs+NFA53xaD8lAVRF00bT+04LECMrbRJ
	 vtgNZqPKZCrOW6Kck8GePmkIWzPLmgHjjrArEpdn+Rbkchh5dLAFvw5/76ojjeJSP14Q5
	 UWmwn9T8wsf4h2HNSqeHtATbhC4eWEbIdiMIX0O6aQXwX1nFN++ybgXzo8RaTiz+lEVbO
	 csMhaZZWhUw91KUepUbIunusaDOb2xKp+d+rTzlkov01DDziTaa78EKpIkxjAfulYBE28
	 /4w/mdeWwjwjwCGcdeCJnwWhboK3L24eVnkeOaMw9ZI6gR1GspC2NHi2TtlgCwYFgsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795474985;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=x/NfMxODq876kOaDGiQbZEMCzVnfz8DxQ1gOx1T4BKU=;
	b=LDs3W5R5F0o6DetVSj3s50tCeTAtuSea1UKf8kZyl+fw2Sj8zzOYM19TXbPu/fo6U9AP
	 qo0Ibv6N3CLwd+/z1cBEFMN3aDtXeqY2Uo5kj7Y8lVQbiWG3++aWoJ1FsmEUyXenHb6Dk
	 K9m5I3ZfiCH0zvySBAziW07e2sVI42INNUZar+1dVvojKhLz6z9YEIMvnN10XLbBX9ceY
	 4yPAu3aLIW7zeNn7s+r3mp/jBQeU9FQ5BnJXyKcLuphxoHfDn3n5hBdPKPpEnIEN5Y/lF
	 gPAPVtW+fF6zXS5KzNC1f1U5I1KCMXZUtCz+DeraYjtIBzjbbJ/4O6v3ys6Q6yWxIHw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yhrk1tHk;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795474985;
	bh=x/NfMxODq876kOaDGiQbZEMCzVnfz8DxQ1gOx1T4BKU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UNGAjkDIaOW9kQ5+YTCqPDJhUkAYVjNzB8huJ2OEnxRu1cLLqqOq6WJx2VSZ2DzBn
	 kXihEOq6gmqQvYgiecWua4FImW934u3SSA/Sx4Y6vRgb5Ss0GH5En15BtMh1TeYPsX
	 tXJnYqdicdnKFysIPus4PMnMFoXkIW+ha1hDUE7P1HSrcL9ZA0BxtMJwxJ/21s1x87
	 9Z77Q9R2XwE8dxxq1VK80bKtV8gQiZPxP0k12RWXYr2vJcFP8vTgGYtwNIi/c4qIQ5
	 lzOYhzLrzyU0pU+vWKifpFl75u72Oqc5tss3V7IT2TTMKGHaFPWlPz3MNqJ/bWEzNG
	 vPR6X4jxfOhYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEAB980D3E;
	Mon, 23 Nov 2026 23:03:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB9E4311
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B479480D2B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:03:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t5SyHVKczo2g for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 23:03:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B896580D1C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c29; helo=mail-oo1-xc29.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Yhrk1tHk
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B896580D1C
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:03:01 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-716c0217635so4704632eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 15:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795474980; x=1796079780;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x/NfMxODq876kOaDGiQbZEMCzVnfz8DxQ1gOx1T4BKU=;
 b=Yhrk1tHklXOCnS4urrIHKEwh5E4ZrxT9Vt5qeunM/DzXD5yqUPJvJ5YxwK44YqrAIV
 dZpdNbzz69L3+YJyu3yNWzsjI4a8sj/UGnCqv3XoiNdFPsDwv+lkYf/SechuwVM6qnsV
 yY68NBwxe3/TFAoQgVKXUHoXEx5OTforL61YtSZailmycUPwkd89m3XrgT2ofptEaQsr
 CwXXFtY2aYSy0WM5iQrjE7aY7evzEKqe8Vt2FwdKr15zgsX5iGWfGyNuNuzA8aQEx0WA
 BxrswcqVTqHT7sExjXPyx0z1AEabQ4NMmDJOoff/s8LjAdVz3JMyyIsWt4kCPBTGqCst
 lPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795474980; x=1796079780;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x/NfMxODq876kOaDGiQbZEMCzVnfz8DxQ1gOx1T4BKU=;
 b=Xqn/UnGG/Pwl8sEpsP8oHAo2tbGBD3ywgTHIQzFH7dhLe84Epbbjr+qetYCgWJeL4N
 4w3QcLC6tROS5kO48IeLopqu2o8Sojpo3wCckoNeLqznDgKVlGBazvj79t7evqcJtGsX
 rE4GNACeTRdzTQOYfY2HUQKXwD8KpRiK+5URE6g5WCYsShBY2K4uY/iYBrr5GCCnBPae
 Bsjx1SFh7dx465yJjbmG2Xjp9zB+X8usx5bBt/fASjv5MLP/PcTqaxzHZ4ZUG+/iMaVf
 UmiTzNesB71K+Jend2n0F2eHL6DBM6KiHhJPfCt3l466SApIGnBRXAD8kUGjH5wNy1sy
 +WlQ==
X-Gm-Message-State: APuU4Z+6MMEpK/0oUdV7czJFvR141FwTqByBTsHK+uhr5Cr6F/LZAoSe
 Bipj1nbNQF0HJrNb5qulmLOCGXIcBrDZhYOd4DlYmMP5+O6kDDzjpPhmPXVjqGJE
X-Gm-Gg: AZFdTZft33w8/7Ipeu6Y52x2MH7Wub9Yj0nf78zBGJSUuhmGoTOeXoFQItA0QKdpC7s
 MobvFNQfy65Wql9bWfUgHvZfo4MD+fEvFb5AH72fE5AOT/jYdG2YM4l2pGgUIJuJE/Fh2u9Y6mh
 PdhQptzVRVqXu/GD4d9EP30CiGKoZ5ifs9gvcitermyJmfJz36c3UUeYsiP+8hAbHBwjKopwvcy
 gDEsTWbduQgzsMmDFqNMGONGsIyw/jzGYet/pVx5fQvRXBgnxBbeyZkSCfHGEMFqUJS5202DUTU
 IMMg+Va+kzvciMMNicXhK1JvFozHyra8C2gYNxCKJVWqcagRiSHaGdoAQ/3BOuym2vqhrFUYTWJ
 bsks5oMVfW+rboMSTU2cXEwNMtoxJm+ryV6YPaD6AQK0/ftDBISMI90ZqTRP7HZoK5P8V4i/nuz
 5CbQ2Qpx7VphQkwhzv/fMzb7qQnYZ1Jbtr4ly6d5onZA5WmLjew6BwKETJDmKPN41gJlfEe/MYh
 2ppOJknWS3AGJCZhonS7PayF2/2jAAs3ttMQisKTGs/WIaZ4SAJF/NAVBJZ6ETDGgfc7uLceo4P
 N0z7Ww430pdlLKzmbBFaR1miU7ppH0fJMIkD9yRhdeAVqKsv/fLPthOmfqGTxPOdO5AVfKsWJlL
 y+CXUKJnscQUndTwwgNpkF0rKLh8ivruq1pZvz4ZwDGeZ4C6uOaAB7qVgJpYpYXzu29V51metBF
 BkNbFyJbKxkRIUaMuyo8xF64+57KK0NlXlqWMS8mOzdOYdU90hvuc=
X-Received: by 2002:a05:6820:820:b0:71b:42de:9787 with SMTP id
 006d021491bc7-71b42de9ef5mr7000125eaf.22.1795474980196; 
 Mon, 23 Nov 2026 15:03:00 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b6b680b66sm701616eaf.9.2026.11.23.15.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 15:02:59 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 0/2] net: lwip: serve Fastboot over UDP and TCP
Date: Mon, 23 Nov 2026 16:02:55 -0700
Message-Id: <20261123-submit-lwip-fastboot-v1-v1-0-34c1eff8b1f0@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAxA0atI1g2YKSj2KtKF0agR68hkagvi3
 TvV5Vv8v4NJUDF4ZDsE2dTULwl0y6Adm2UQ1C4ZXO4KIndHe/NLI84fXbFvLLL3ETdCKjsquGS
 uqIJUr0F6/Z7n+nk5pZO08b+D4/gBKw8R5nsAAAA=
X-Change-ID: 20261123-submit-lwip-fastboot-v1-17d16b7bb919
To: Jerome Forissier <jerome.forissier@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sam Day <me@samcday.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Simon Glass <sjg@chromium.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow hosts to use the fastboot command over Ethernet with the lwIP
stack. Both transports use the existing command and download handlers.

Share the UDP protocol engine with the legacy stack so both can restart
an interrupted session and retry individual multiresponse reads. On TCP,
parse length-prefixed frames across segment boundaries and stream
downloads directly into the configured buffer.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
James Hilliard (2):
      net: lwip: serve Fastboot over UDP
      net: lwip: serve Fastboot over TCP

 MAINTAINERS                |   3 +
 cmd/fastboot.c             |  24 ++--
 doc/android/fastboot.rst   |   4 +
 drivers/fastboot/Kconfig   |   7 +-
 include/fastboot.h         |  16 +++
 include/net/fastboot_tcp.h |   1 +
 include/net/fastboot_udp.h |   7 ++
 net/Makefile               |   1 +
 net/fastboot-udp-common.c  | 176 ++++++++++++++++++++++++++
 net/fastboot_udp.c         | 284 ++----------------------------------------
 net/lwip/Makefile          |   2 +
 net/lwip/fastboot_tcp.c    | 302 +++++++++++++++++++++++++++++++++++++++++++++
 net/lwip/fastboot_udp.c    |  96 ++++++++++++++
 13 files changed, 634 insertions(+), 289 deletions(-)
---
base-commit: d778970a189b977c14f93961d7009f404d895b5b
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git for-next
change-id: 20261123-submit-lwip-fastboot-v1-17d16b7bb919

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

