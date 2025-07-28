Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463A3C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 13:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7609E82E26;
	Mon, 28 Jul 2025 15:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="ym6lzYzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C078F82E34; Mon, 28 Jul 2025 15:04:01 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA10882D88
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 15:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail3; t=1753707839; x=1753967039;
 bh=zkp+vP0BhMQ9BulC+BWnSBNXKanjLIkKJtyyC8ztrlc=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ym6lzYzNTQ02WlsFrOseSrFJIopqoovS7tLEBjZ9WjTf8FG6AT42HQsSVQ5NvXMfN
 9YYA5vHGm+CXpPlJ+uuRVGgl1P1XeqBhWFIexRDX16LMvnbV7MCeK9l/B7OIONSfuv
 D9gQwYeBTLCJ4D46ojdlwLlIb/fCHv2LYK34Hd00mhDgaPkSKBP9FGuD9YK1x+D8hH
 MpPwaMV/TrpvZshRX+aZmneWGyXGoFA+LW90M/q0vUZjIv6sNU6C16hiWN7elYRhoD
 L/+Nk+kjNCAX1x8EgqlYy+r/eZrFIZfjuKlQ3bF/ZOjb1GVU0+fDH1ImGOaJ+c5Or4
 ZHH6xjTE3FFbQ==
Date: Mon, 28 Jul 2025 13:03:52 +0000
To: u-boot@lists.denx.de
From: Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Philip Molloy <philip@philipmolloy.com>
Subject: [PATCH 0/1] Remove expansion of undefined make variable
Message-ID: <20250728150333.1716886-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: fc5d23d9254b89d53140b318b5777867b3a74cd1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Came across this while digging into the ADI ldr, which generates boot loade=
r
streams for ADI DSP processors.

Philip Molloy (1):
  Makefile: Remove expansion of undefined variable

 Makefile             | 1 -
 scripts/Makefile.xpl | 1 -
 2 files changed, 2 deletions(-)

--=20
2.50.1


