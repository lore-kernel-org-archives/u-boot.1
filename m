Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE918C982D7
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 17:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82ADB40C87;
	Fri, 18 Sep 2026 17:45:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id avgT8TkUkTsE; Fri, 18 Sep 2026 17:45:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 920A640BE1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789753539;
	b=QEWG9zUGqDOXsVsv7fGjtmVvPlK29an+dEBU3lhLqgHMGP8QfZuCGLoWTovjfoZRt1HB
	 Qn2MvBlIyXNmLHuELxB6hEKtEu9j1q7uzUtk7h3ZEGDob/OSHwDOn9xiv44KOGdwSt5lg
	 NNaSdFsCGjsZBnf60a6exw9yqxhTRDKBofxw67FWIyh24uZnnTAmx3FnzQIC1G8XypYNa
	 j8AQQnHUE8kIJJmbjXXL79KV8JuzUifnH/lqTccVwdsVwUJ6MvIa1C7Yd2V6V0wk7NciD
	 e7MItgmSp6sSTYurIPMdip9z9agiH0ZQI2Iu+t3KifB6sG9zATsyCZDb39WF6FjXicg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789753539;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VVcs92ZwnsV/u/fxPSOlkU8FtH5nc/58xTSLL9eUtEg=;
	b=sT+P0ba92jiHNFyMq3ifg8lRN+qJx+i4jJCJCDqB71oSKvpXJ6yA5Y8hGlTNjEp5a32o
	 c5E7k3WsBaJlH25sDOBbn+ZNlMub6U08GnPP5q6AfSsOY/DVtDDku7kaMzTrrCvcJYvVG
	 xcxBqZRfTwR3GwP012+QWwhypAJ5AgZuMeMvdP3+AVZMXUvFCkAuh1+7SvuZCgcE94gQq
	 EY36mnqaR00YULIFfzjdEHYWmBtms0QOk+JeU4bbZaEhGKV9zjKcZXpbSlONR8tBGHJ72
	 TYSKpYvVzm0u/uL8tPfNZiQeoM27X8t/n48E0wmDZBevi6rRQHQmgBgLbYKutbztXHA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=embetrix.com;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=L7IhpNBK;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=LOW5awAe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789753539;
	bh=VVcs92ZwnsV/u/fxPSOlkU8FtH5nc/58xTSLL9eUtEg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LOlB/CIjVl8U0PYPBOdz0qVXKwyKI820XMvxB96/MSeuljeZdBP08NAyYGKcboGGs
	 rKcRFVIiFpfS6D8flwl5DjD3c3GILC2yyedkOLXatsVsOexrrVsqcUI/Qlz7ganXx1
	 6MILLqEC1y7xdFlbpVkd2tns/duCyba3CqnZdJSMWxk75jeai5yVrVBw2jDKktN8qT
	 aIg2Wu5p4XWqeHBFeo5boU75GfyyWoOdL78YXG4j4xHz3v5+gL1n2dR9hrgHE3CHHB
	 ON7XgpqvLrpB9hfAoc9ToYEqANViWt4ylzCu2ddfKIrSUKP3ynW62n+DhV4c0KJ+0S
	 zGC6PFMuDm6ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 920A640BE1;
	Fri, 18 Sep 2026 17:45:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 67DE029B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59BEE404F2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:22:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZNUgk6qhH3P9 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 17:22:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 61BCE404E8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789752163;
 b=XtI+CzA7uhDsQCQ+5JDkPMAqPDMXOtQKPcCw9KmA4V3CfEWT8JWnXQYfBG9RWNeMm5hu
 1E5oaD9Xm5W8vtHJKD1y/MMNXGZy7OYd3YdnXTDNu0/EWnkQD9nOw43OwVxTk7+R4VhDN
 8OLGrtoTgW7qfbMF7PBpgpBlHEGQ/fQGCU+Eu0gOhcFjRZ1csthafWyouW1FIgvNudh1o
 s2Dy97soBeSp6faprDEefygwSlGhxRovJhdzpZttGA9P+w3mqbc8iWbhw932QgD/yMBSK
 aj2OBVAjGmrhDdgaZztMRu7g85Z7bCIvHM1lARQ+sCtEuPFOlQeeE5TGBsUfPEZT3QA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789752163;
 h=X-Greylist:Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:
 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=VVcs92ZwnsV/u/fxPSOlkU8FtH5nc/58xTSLL9eUtEg=;
 b=FBGyfYQL2i9fgA26SgTmoTgmnj4IgV6ZEzUm3OvujWYskSBxRfmG0Fo2QSrCyVOxf6UK
 Cu+N3/7fQpUZN6bzHluZo2wMeOscNMPsd2pOVaXt8/O8k4MtyIj5JXfo9YzqcELw9Z6jI
 Y3yaCgA2FbVnuoWuH6pL30FDn6e/DJyl4g+LhwsQl9t6LFJSNmVbuMASB3tVMZMSVDNcW
 s7qNMwXqI5pKyLeIxLpcb/ExXQfCOol6NCSQEV3SDXm6LwHQF6jwNo5iVsQ5+bITfZP+n
 nINnHS4QVtmcCJqOyPJVMz3jq+poHe82MagPu11PvTio4sSZ73FK4GHyFRvwKOUolkg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=embetrix.com; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=L7IhpNBK; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=LOW5awAe; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 18 Sep 2026 17:22:39 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=L7IhpNBK; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=LOW5awAe
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61BCE404E8
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 17:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789752091;
 x=1790356891; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=VVcs92ZwnsV/u/fxPSOlkU8FtH5nc/58xTSLL9eUtEg=;
 b=L7IhpNBKgi5DsG1PUjX6DYM/DuuQuotRXCzolOYi3i4vJ1TWWvRnhTLvIakYXDPlYRZvvF5NXVAF/
 Y55uA0p8HKi80KYGt9aXMo+RjLc9AcINpi7/03oMcgIVf18AKCZzkgFQPw255KX/MUNI6yatr2YU7r
 dDB7kXN2tIKShX+pzv41Y7/bGTcVANirBfUp/OpfWId/EfqO98o90q7mLJ5oo75YTnfZqjKo7Qri3J
 3bwzhewXNY4QpkdpzXR94iOOW0Z9NrdH9cqjnXwsJxS2mXtV6nrXiSaE3Cgen1JqQuQ5v8DjAJ6gAt
 THgEU+6oc2sl3XWtdVpXMb5lcr8m3+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789752091;
 x=1790356891; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=VVcs92ZwnsV/u/fxPSOlkU8FtH5nc/58xTSLL9eUtEg=;
 b=LOW5awAe/1/FTT0TQw2jaECsJ97JahiZ2NdMTxVwYFcLXST1AcPgvGnyt9Ex4THRTtOQ60+xGTj9T
 qrnze+hCw==
X-HalOne-ID: 620a130f-b385-11f1-aa3a-6d49bcc6f3f8
Received: from xps-13.www.tendawifi.com (unknown [41.251.77.168])
 by mailrelay6.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id 620a130f-b385-11f1-aa3a-6d49bcc6f3f8;
 Fri, 18 Sep 2026 17:21:30 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, mkorpershoek@kernel.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 pbrobinson@gmail.com, dlechner@baylibre.com, hs@nabladev.com,
 xypron.glpk@gmx.de, heiko@sntech.de, raymondmaoca@gmail.com,
 Ayoub Zaki <ayoub.zaki@embetrix.com>
Subject: [RFC PATCH 0/4] crypto: add FIPS 204 ML-DSA verification
Date: Fri, 18 Sep 2026 18:21:23 +0100
Message-ID: <20260918172127.66014-1-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 17:45:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Classical signature schemes such as RSA and ECDSA are vulnerable to
attacks by sufficiently powerful quantum computers. This series adds
ML-DSA verification as a first step towards post-quantum cryptography
(PQC) support in U-Boot.

This RFC adds generic verification support for pure FIPS 204 ML-DSA
without an external message prehash. SHAKE hashing remains part of the
ML-DSA algorithm. HashML-DSA is not supported. See FIPS 204 Section 5.3:
https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.204.pdf

It supports ML-DSA-44, ML-DSA-65 and ML-DSA-87. The implementation is
verification-only. It contains no target signing code or private-key
handling.

This series targets U-Boot proper. SPL support is not included.
Verification allocates approximately 8 to 12 KB of heap workspace
depending on the parameter set and ABI alignment. This excludes
allocator overhead. Any future SPL integration will need to account
for heap availability, stack usage and code size.

The verifier is adapted from the Linux crypto library implementation.
The series preserves the Linux licensing, copyright notices and source
provenance. Linux facilities are replaced with direct U-Boot equivalents
where needed.

ML-DSA requires SHAKE128 and SHAKE256. The series adds generic one-shot
and incremental SHAKE interfaces backed by Keccak-f[1600]. This code can
be used by consumers other than ML-DSA.

The public ML-DSA API accepts raw FIPS 204 public keys, raw signatures
and one contiguous message.

The tests are based on Linux KUnit tests and cover all three ML-DSA
parameter sets with valid and invalid inputs. SHAKE128 and SHAKE256
are checked against FIPS 202 known answers.

Validated with sandbox and qemu_arm64_defconfig builds plus the SHAKE
and ML-DSA unit tests on sandbox.

This series does not add FIT semantics or mkimage signing. A follow-up
series can add a generic incremental transcript, target FIT verification
and host signing.

Feedback is welcome on the public API and Kconfig placement.

Ayoub Zaki (4):
  crypto: add SHAKE128 and SHAKE256 support
  crypto: add FIPS 204 ML-DSA verification
  test: add ML-DSA verification tests
  doc: describe ML-DSA verification

 doc/develop/index.rst     |    1 +
 doc/develop/mldsa.rst     |   67 ++
 include/crypto/mldsa.h    |   67 ++
 include/crypto/sha3.h     |  353 +++++++
 lib/Kconfig               |   14 +
 lib/crypto/Makefile       |    3 +
 lib/crypto/mldsa.c        |  679 +++++++++++++
 lib/crypto/sha3.c         |  382 ++++++++
 test/Kconfig              |    9 +
 test/lib/Makefile         |    1 +
 test/lib/mldsa-testvecs.h | 1896 +++++++++++++++++++++++++++++++++++++
 test/lib/mldsa.c          |  383 ++++++++
 12 files changed, 3855 insertions(+)
 create mode 100644 doc/develop/mldsa.rst
 create mode 100644 include/crypto/mldsa.h
 create mode 100644 include/crypto/sha3.h
 create mode 100644 lib/crypto/mldsa.c
 create mode 100644 lib/crypto/sha3.c
 create mode 100644 test/lib/mldsa-testvecs.h
 create mode 100644 test/lib/mldsa.c

-- 
2.43.0
