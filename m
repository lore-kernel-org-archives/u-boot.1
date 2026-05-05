Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05065FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 09:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FC3B84879;
	Tue,  5 May 2026 11:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="aoY96rFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7BEC846B1; Tue,  5 May 2026 11:14:43 +0200 (CEST)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::190b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2243984687
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 11:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8tBR59cSz67T;
 Tue,  5 May 2026 11:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777972479;
 bh=Gr8+7V5+rHTK7wfIbr+R2LxQ5YzR+pgedLboTwx3im4=;
 h=From:Subject:Date:To:Cc:From;
 b=aoY96rFgziIzgw3X7t4X5jIUL5/70PrjrbqDpiLxx78w6jt0lm/LFUNMzxloOUqLN
 scYSNG2GnyqgYExA/Wycw9QuuqjSHd+6XQnqNIQAEvMFKiuHur59nVO+VnVUMLaz2j
 On1DUfCZAKUjeIM56Kkx5Kb+bNWlE7HX89Lz/gqvshUXFP/0ULjbBQ+V3i6D3wLLU7
 TpgxYjekD6o1V2JQiWaeSRouMnlqZDH5ayI5u1TBa+vdJXjNJNMhgLenRnolOPB48A
 uqP8SrVpIWCGyjDJuRx3ztU8GLn2BI5JNfNG5OFHJr/e3z4JIZidbvE09z5BsCuWcS
 H081URwqq7g3Q==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8tBQ5R3Hz3Vv; Tue,  5 May 2026 11:14:38 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v3 0/2] cmd: ufetch: print Net feature when NET_LWIP=y,
 prettyfy if NET=n
Date: Tue, 05 May 2026 11:14:30 +0200
Message-Id: <20260505-ufetch-net-v3-0-eee5eb9ca5ce@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6DIBQFr2JYlwZQxHbVezRd4Pdb6EINIKkx3
 r1gF41Jl5O8mbcSj86iJ9diJQ6j9XYcEpSngoDRwxOp7RITwUTNKtHQuccAhg4YKG+1krLUgoE
 iSZgc9va9x+6PL/u5fSGEXMgLY30Y3bK/RZ53f8ORU0ZlJxtQNW9EebmBQeeWc4ckh6P4qZJVB
 1UklfEWoQKteH1Qt237AG7iY+bxAAAA
X-Change-ID: 20260428-ufetch-net-1ba7553a20c7
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

Make sure the Net feature is printed when NET_LWIP is enabled, not only
when NET_LEGACY is.

Only print comma and following whitespace as separator if there was a
feature printed before feature to be printed.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- migrated from bool plus ternary operator for setting the separator per
  printf to a const char* which contains the separator to print, as
  suggested by Simon,
- Link to v2: https://patch.msgid.link/20260504-ufetch-net-v2-0-01bec4ca7169@cherry.de

Changes in v2:
- added R-b trailers,
- fixed spurious colon character before separator in cat,
- Link to v1: https://patch.msgid.link/20260428-ufetch-net-v1-0-5d58c7618239@cherry.de

---
Quentin Schulz (2):
      cmd: ufetch: show net feature when NET_LWIP is selected
      cmd: ufetch: only show comma separator if there was a previous feature

 cmd/ufetch.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)
---
base-commit: 57460fde4ba84d67de4066ee1141e89e8139ed23
change-id: 20260428-ufetch-net-1ba7553a20c7

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

