Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C8D606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QPuPNXgA;
	dkim=pass (2048-bit key, unprotected) header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=ugjMykEj;
	dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256 header.s=ed1 header.b=CnCWNlIj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33CC880F97;
	Wed, 28 Oct 2026 10:31:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WrZrlSbHhxXY; Wed, 28 Oct 2026 10:31:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2CF5C80F80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793183503;
	b=GChgy7GoYuRw7rVcdfvMADkt9iZ/YUoIbSxucDc4/O2Bu6flMbHQ2W6fno/BhDR8oj0x
	 2En71sP5BD262FVi+pyHgZn2SxLrIhtvTED/+zIjvSutyPQMmKKplIRLrLe0kXRTAjEO6
	 xs4VGtq+J96NhlI02IlWAS339LCSbbRyY+JO6lQrhbEhG17JJ7sSSI13h7fz6fVjX9WgO
	 6IHWa6XrZ+Rk/caoSFO4Sv1xbDybApIK6kuibiNSWMmtgllKWAfitTwmvFqa0RIcOydeq
	 Y8hKj45R48exLQO8YfVI8HMvdr9xnb7inkeVV3GR2e5DxBGrOXfP4b+9XwVibWu5Fsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793183503;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J8fYsF61CLPtrZOUhhxrZ26jF3M03+ptaT5pMXX4csY=;
	b=obE1PAse4kNXyGA6a/A6LTQjF2PZturuMGF6o3J7sIOp/xLBGyyyqAyKZ+E3lkSn8LAt
	 YTyk4L9hh6ASYUABaChf+ZkO0Z9hPfNr5lK4Ut6fvkaN+ynEfNgGoiAjQPkZhbK0xQYej
	 FwcZdB4yfb0GV+wJ7bwQHL+fF8XlU0pgqU4hujnfzle0rcAQD0bOvLFf+x1qgaY8/ic0O
	 Z511MREAZoKu1W2FBmxxD27APbSkdTRXKXRY8E71cb/QakcsRKHuwUxGeuaV6Z/zcqi0+
	 CyaC/iB3keQrFozN1ryrhZcAtY/MLwU/sPu+auU3JMCEQpXRpb5QW8P1L5AeNOLxFXQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793183503;
	bh=J8fYsF61CLPtrZOUhhxrZ26jF3M03+ptaT5pMXX4csY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QPuPNXgAOlIsToKrGpbrVK5Vf0QqM82Zz18O1gbhjxzs7HoP3knx7iN5tbjQH9Xvq
	 Y8GitJArOgeSHe2/ogdSTKV3S1s6S85roTAKjV/yc1FB3eg+sVWIPMYt73m8vNfWzK
	 XfLa1ZWYHWGnt1C1hZAp4JYaMPLUa9+47RbNDh1fKHXW8kA5atghEHE/QRxFlf53bt
	 +1ISx6cF5C0VTxFHA6FbG2xoMWSWdpXI4BM4537VuekS1ce9DabcE8bbYJUrlqAsPM
	 sFjpnAJt04Ysm7n9D/nTVhzU3cJyNnS+Iki3PLBm3S6txmrwZD91kUq2F0b+3Z9vc1
	 dq9adSQkXvXHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2CF5C80F80;
	Wed, 28 Oct 2026 10:31:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DF20356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 549C7400CC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hBImanzZpU-9 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 10:31:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 05FCA4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793183493;
 b=g7Ri1ZV69vXEWZQiGegROj3t8t8RgDJICOroMkoUQdm5Uw0um+5xLqdX7BcixbrXiihK
 kTtNmIQTLxi9IKtjHP3AyU95cnkW82kp9B06K0juNxASKsNLX81XabYwSrkcT4wNn+Ae/
 HBgqEsQD7v4SPOUZvnPR2PPk0t5BlHTi9xmu9Aq/Da5MndN2dZS8h02Sw2/OxcitXTex1
 a2vR2X1Ps7ZO2Qnw1MOaXM8EwzvbjW22fxyWkoVz5/6yXH1z0DQV7y2GaGd/ovNG0r/03
 OaN0JslzjU1mk83AEFcn8pxL4AQ1psemXGNSthTfDKXmmdjeVrO03k8ymHJAghZbaCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793183493;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:X-HalOne-ID:Received:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=J8fYsF61CLPtrZOUhhxrZ26jF3M03+ptaT5pMXX4csY=;
 b=NlWVGkWrlZqA/RwEyXHFZL/UQN6MiY9+RTufomhvIMngD7Y8X0Fnt2QLRj3ExiiBhtDD
 15cOlQR4sGgEpMyR3YP3mJ8K5Vvz0gURKL4M8aEuhZca+Yuz2i/SkwLG5Fy7upzzKEwIB
 SZLa24ylH1h6YEqlnU1mWFn5LOF26zAtU/wTyi6smcfo6Fl7Rsr29B+pIZPnXkIS+NSww
 W5SrMPMOW/yvW429mMKcDvP9EAACUiXuGPPleOmyU30dl0XmeY8oOm/4Iks00F6quCZnq
 jh35IUzytDkrANJMp6rcuXFmiyvAbmkF7U8azYEzznzFJr0YyI2XHroB4YwpuA6Pu1Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=embetrix.com;
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=rsa-sha256
 header.s=rsa1 header.b=ugjMykEj; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=CnCWNlIj; 
 arc=none smtp.remote-ip="2a02:2350:5:505::1"
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=2a02:2350:5:505::1;
 helo=mailrelay-egress18.pub.mailoutpod2-cph3.one.com;
 envelope-from=ayoub.zaki@embetrix.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=embetrix.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=embetrix.com
 header.i=@embetrix.com header.a=rsa-sha256 header.s=rsa1 header.b=ugjMykEj; 
 dkim=pass header.d=embetrix.com header.i=@embetrix.com header.a=ed25519-sha256
 header.s=ed1 header.b=CnCWNlIj
Received: from mailrelay-egress18.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress18.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:505::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 05FCA4006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793183484;
 x=1793788284; d=embetrix.com; s=rsa1;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=J8fYsF61CLPtrZOUhhxrZ26jF3M03+ptaT5pMXX4csY=;
 b=ugjMykEjFL7mbYW+GldsjxJxjT+0wkEQQTzWvVh72JYQStn9gqemQNmSlQjJt1gWJk3e2UaEZICNT
 9t947IWYud3bILD32OoDfubpdv8I9i5M84nvV2Is9QYQklzVKWNhg0aoLNc05HOtHcq+SYosS5Mqhj
 RSs5afhJaLn2lhYhKST/lL9UKYxkJ4qhNHy9fpKi+1PtbG6U0rC2Hzyc55cF8MYZqqtRaPdK8x7mTy
 quyfnhIv2l9no+l0jXjxsO4sQtO+Vhxibo8UYiOkiKBxYBs9t8A5sQzlP1B5aSjdJWEo+/aDIwb/1y
 jzHvtpAGNWdjgKiOEJxnQAwuDJ2s3Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793183484;
 x=1793788284; d=embetrix.com; s=ed1;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
 from; bh=J8fYsF61CLPtrZOUhhxrZ26jF3M03+ptaT5pMXX4csY=;
 b=CnCWNlIju9ALdqEQMsnIvuilVaJUOOk6F0+A80mt4F9001iUYBASME4pLtVJlCHoIj0ZYlQOi28+o
 nkYKcUOAQ==
X-HalOne-ID: b8d09011-d2ba-11f1-9e3f-5b5978544972
Received: from xps-13.fritz.box
 (dynamic-2a02-3102-8c10-1ae0-c98b-5300-3c35-71e4.310.pool.telefonica.de
 [2a02:3102:8c10:1ae0:c98b:5300:3c35:71e4])
 by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
 id b8d09011-d2ba-11f1-9e3f-5b5978544972;
 Wed, 28 Oct 2026 10:31:23 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, Tom Rini <trini@konsulko.com>,
 Ayoub Zaki <ayoub.zaki@embetrix.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH v2 0/6] mkimage: Accept .key and .pem private keys for FIT
 signing
Date: Wed, 28 Oct 2026 11:30:56 +0100
Message-ID: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow mkimage -k to use either .key or .pem for PEM-encoded private keys.
Preserve the existing filename preference for backward compatibility.
Try the alternate extension only when the preferred key file is missing.

File-open errors such as EACCES previously allowed mkimage to succeed
without signing. These errors now cause failure. If neither key file
exists then mkimage skips the signature without failing.

Binman's FIT signing-key lookup still requires <key-name-hint>.key.
Support for .pem files in that lookup needs a separate contribution.

Ayoub Zaki (6):
  lib: rsa/ecdsa: Preserve FIT signing key file-open errors
  lib: ecdsa: Remove outdated key lookup comments
  lib: ecdsa: Accept .key private key files as a fallback
  lib: rsa: Accept .pem private key files as a fallback
  doc: fit: Document private key filename fallbacks
  test: fit: Cover private key filename fallbacks

 doc/mkimage.1                          |   5 +
 doc/usage/fit/signature.rst            |   7 +-
 lib/ecdsa/ecdsa-libcrypto.c            |  35 ++++---
 lib/rsa/rsa-sign.c                     |  22 ++++-
 test/py/tests/test_fit_key_fallback.py | 121 +++++++++++++++++++++++++
 5 files changed, 172 insertions(+), 18 deletions(-)
 create mode 100644 test/py/tests/test_fit_key_fallback.py
-- 
2.53.0

