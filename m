Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8651CCD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 14:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E812484374;
	Mon,  4 May 2026 16:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="QSkPZTGJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B15184661; Mon,  4 May 2026 16:48:40 +0200 (CEST)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [45.157.188.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB68B84255
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 16:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8PfF4CLBz1CqX;
 Mon,  4 May 2026 16:48:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777906117;
 bh=/kpw7p/o9yYLN1Y84Ai38/kwFtbTyaLtTuZc0hTU2X8=;
 h=From:Subject:Date:To:Cc:From;
 b=QSkPZTGJOwthHHHvuGqHvCb0SeNtjAoPqpcFOtaT3qcpQrnTMGqzUPVs/ejE6hkS3
 7+OPSYieMksrrx0VJS+Db1/ftuRIXr6TOvfsGMO5S5lb1uXVMKfhivcZLOxdlIhwy/
 18QfBxUKAF36ew7Qdaa6xpw/D/6UodJ7VdWOxjMHZI8/AFZxAZp7gfgXDlThNbCgSl
 ts6Lk9UUTr1AZYp/GDrpFCC6Zh5AwGceBHmcQYRBQjsV3NjHAQ6DuKZe/hOIj2p/q5
 vuE07QWmP+JMBtntUalE8l4mPS6WlPFwRXb8qcd3g/YdpikjLT7X10rXEHUdvdYWEj
 AApbNUo8/jUzg==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8PfC6V2DzN6M; Mon,  4 May 2026 16:48:35 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v2 0/2] cmd: ufetch: print Net feature when NET_LWIP=y,
 prettyfy if NET=n
Date: Mon, 04 May 2026 16:48:27 +0200
Message-Id: <20260504-ufetch-net-v2-0-01bec4ca7169@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ7CIBQFr9L8tRigUqor72G6oPAruGgNUGLTc
 Hehbl1OMm/eDgG9wwC3ZgePyQW3zAX4qQFt1fxE4kxh4JR39MJ7sk4YtSUzRsJGJYVoFadaQhm
 8PU7uc8Qew4/DOr5Qx1qohnUhLn473hKr3t9wYoQSYUSvZcd63l7v2qL329kgDDnnLw1LKFK2A
 AAA
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
base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
change-id: 20260428-ufetch-net-1ba7553a20c7

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

