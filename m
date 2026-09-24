Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B554BC98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 06:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DF5140CD5;
	Thu, 24 Sep 2026 06:39:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2dpdJOyy1wBR; Thu, 24 Sep 2026 06:39:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 97A6940CB7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790231963;
	b=KmEe8FZbcYVkyd2zmB1VVboSZqr2rZnijLNQ6i+hVWI+IjrLHqz7qaNZL6I3rhpZJxGf
	 ex6JXQfOOoHaI6w5LGrwcZfcH/T01S0vvPauxT6RWVPZzfKWMHPp+4gThSel6RkbAU4Hw
	 SLeEwv19PmCszSpO0enz7B+7UdG98gzi6/VB+dThPGrchVxUQs/plohiEKuSJXDwn1RdC
	 l8yCI1UIpA3+CUGHHIpHkVezCAz8A/iivTt7IWYZlH735G4aPukcZUHq7aJEmKjzOWfrw
	 7OFwji19/MYD9KLsW4v6Adtp/sIgOdqzH5ki4CXVefH4EAbmxVW7iQpwye4zalLf3nQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790231963;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8Md9urQDPdPLSfROepdHpvkmGXHjNzK40Z7oycNSsNk=;
	b=Ob80Vo4kc8U01JCOf9ZLeaeAYX78l1Y+TsgE8Xpr4DYQA0Tcr9Y8MU4D21yViIbd7vr/
	 zTp0C+9nco6hHPb0GZC7orxuWbJ7v8fCiWCYyDx5yLbpEZwTSucXITNlvIBaYBKAWt1Lf
	 DveisQVmqv+riQTyJyL/Z2Ze7Kqt1yggKJ/v+j4sO5Tmzb6P/eRn+xah3Tv8RvUMSeoy2
	 USKgF3sFFNsaVndsk4/4aKyv5YD6S7P7/Ih1kcsClaNcbpLU3oNAgRgqfrnI1cdaSIm8M
	 G/eTNI9wKrcePPBMdSjuW84AGq3zCsw3NkPW5JaaW3LqGa+rvh9vNV/bkDo8cUPoLGw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790231963;
	bh=8Md9urQDPdPLSfROepdHpvkmGXHjNzK40Z7oycNSsNk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OYZP9QRTcBEoPsyztlD4llJMV1T6Siqg11S/1YtvNurXegjWjNe+aVpuFzXeejy3T
	 4oyqj3iNr4dBOOEgG9Ey0recjmZOnmdwyPBBSN9SCrAoik9S4/7X2EM9ep7rdPrOuX
	 BE+wxphhdpSgUpezcwyOSjGDoO61D0sX3jwywSOtyW01nvQzSfvm1KJPzy886v84KK
	 5t6rdgX9pUCn4/HIxqUep4HwzbSbr/DSNHIH3Y7TSq9M/t3eUuIjjBYYVqVaOoKZp9
	 0eYyMbKCtiI7dWCo5yxbiI8hqm+HLlhpYHdftmC+tJ23LcuL0bAVD7f+u2g/J4qQxf
	 cz4yxuMRMQU2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97A6940CB7;
	Thu, 24 Sep 2026 06:39:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A4ADB1344
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A56E6086B
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:39:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qBg355nLTEa7 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 06:39:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DA52560865
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790231960;
 b=AYqotXWUFN3Fe6mCtB7gMBL0+HcwsGrdUfB5f+R433Z370CryBdk6W+C9OmuBqcbax8q
 EgSOIiFd2GXOpf3cXZtbWMJkMnSlq0XSzdUPkY97lEA7iKXMLftLnViw4F9CiQhviF5m3
 zX4qG6Ew30U6IxdrOuq6A+M+JdtuAqaoIOmwX2T0yiKKq04x1kbOYh+DIP/4Xg/wIz8oQ
 kNzwNxTyIVM3o/rERIHkrln+xKObwdVMPPkFVA0YSf1H/L8ifUJLV76E6e01gtAX2OVct
 NPCsD1HNEgR5+mbOK3wBeD0vtBAjbBPs2LviIaNsHmltugtmaFPP9i+7EfNrkAcd4/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790231960;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=8Md9urQDPdPLSfROepdHpvkmGXHjNzK40Z7oycNSsNk=;
 b=Clix0i1dAp+BA3+pIzJ1cMFJccmVA9/BEBC0a/sQnFAE6Lc0eTc0V+jUa4Sh7uGvpAG0
 jgTBNgnEopaAvVD9tFSYYWWAAktQKJ4C8D1IsYR1tT2Pmr7ptdj3lXCdohkgouZ3HvMpF
 y3GqZrrUq8uDLHHvwBtbYVb0QT5ZTUd99urj5fPWFE8uuGKujgjlC+6L35IFp4bJ2OCa2
 2lWzsDTh2sTfGJIxWBRGxPjJFqUSuhICXeLso50iho1qUQmFyJWX+LsEgD/nswe7DecBj
 /yzUH7wKEvaK6XMiXoV1v3UCzMt9LjdejpcacsLK0kSIuOvus5AhFcKB5nDs8IVKbwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=freeshell.de; 
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=T95M6D1I; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
X-Greylist: delayed 12276 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 24 Sep 2026 06:39:19 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=T95M6D1I
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA52560865
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 06:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1790231950;
 bh=8Md9urQDPdPLSfROepdHpvkmGXHjNzK40Z7oycNSsNk=;
 h=From:To:Cc:Subject:Date:From;
 b=T95M6D1IpPDJI9584lNlGUYMlAbMu+zH9pbvJUsc72/VSK3YUwtmebgFiAaD43LnN
 ljo+28dskvJ/KBPTfeeToVolCzGEihfEF/FaMFGU77NRJJMStkQU1KX7g0gBWlb/Q5
 EXjtfClG60edx27F8+9CI0AVvL4fNvvMp+UzvQbEyiHnVuetHaTPpX6KTmvhq7L+et
 1H6LMUgYSRNQe+d49lu2J3gSEl+wTnSQor/V7txOVG9wji+zaH2uXuI1IdyHBbTTEs
 ewJUxJ7//AOXOhkIOfg9M+YUl4jNJ7OvKgSxnbK9o6THHSP9UX2mSH6fTF8Kn/taUl
 cYk78G/CqSupA==
Received: from hay.lan (unknown [IPv6:2605:59ca:364f:d400:6ecf:39ff:fe00:8375])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 4D0C1B220FD8;
 Thu, 24 Sep 2026 08:39:09 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] doc: board: starfive: update jh7110 build output description
Date: Wed, 23 Sep 2026 23:38:36 -0700
Message-ID: <20260924063843.8934-1-e@freeshell.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Correct simple mistake of '-C' change directory combined with 'O=', as
Change directory has precedence so 'O=' path needs a parent directory ref
---
 doc/board/starfive/jh7110_common.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
index 013bab50045b..15f826fa8499 100644
--- a/doc/board/starfive/jh7110_common.rst
+++ b/doc/board/starfive/jh7110_common.rst
@@ -162,8 +162,8 @@ Build U-Boot
        git -C opensbi.git checkout v1.7
        # always clean build directory when building OpenSBI due to incomplete
        # dependency tracking
-       make -C opensbi.git O=opensbi clean
-       make -C opensbi.git O=opensbi PLATFORM=generic
+       make -C opensbi.git O=../opensbi clean
+       make -C opensbi.git O=../opensbi PLATFORM=generic
 
 4.  Now build the First Stage BootLoader (U-Boot Secondary Program Loader) and
     Second Boot Loader (OpenSBI + U-Boot Main):
@@ -171,8 +171,8 @@ Build U-Boot
     .. code-block:: console
 
        git clone https://git.u-boot-project.org/u-boot/u-boot.git u-boot.git
-       make -C u-boot.git O=u-boot starfive_visionfive2_defconfig
-       make -C u-boot.git O=u-boot OPENSBI=opensbi/platform/generic/firmware/fw_dynamic.bin
+       make -C u-boot.git O=../u-boot starfive_visionfive2_defconfig
+       make -C u-boot.git O=../u-boot OPENSBI=../opensbi/platform/generic/firmware/fw_dynamic.bin
 
     This will generate the U-Boot SPL image object post-processed with StarFive
     SPL headers (u-boot/spl/u-boot-spl.bin.normal.out) as well as the FIT image
@@ -190,7 +190,7 @@ Build U-Boot
          --set-val SPL_DEBUG_UART_BASE 0x10000000 \
          --set-val DEBUG_UART_SHIFT 2
 
-        make -C u-boot.git O=u-boot olddefconfig
+        make -C u-boot.git O=../u-boot olddefconfig
 
 Boot description
 ----------------

base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
-- 
2.53.0

