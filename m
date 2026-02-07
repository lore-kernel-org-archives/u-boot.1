Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0770EE0AE9
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 15:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D352283693;
	Sat,  7 Feb 2026 16:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=rwahl@gmx.de header.b="GXZb9Q30";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 176B2838FA; Sat,  7 Feb 2026 16:34:28 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B060F8341A
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 16:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rwahl@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1770478465; x=1771083265; i=rwahl@gmx.de;
 bh=P50b1+parf88YrgCLCPHs5BMJVTLZj3B/U0bSrBLDsE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GXZb9Q309qAXQY49XpkVnm9fLoe5sB85WnNEktYAwuCK7bme40qcamCzrM+qbrqt
 XM3PGWujFND8sBjdfY7QLTubzKUDEsZracxUa4SzGuZ2ETdr+7hD9pwabdAi4lsHq
 jjWcSD2BZpEOPZ27Se8OJSiN7d6N7BJEzgyN7u3Cvx9+GYpNMqqv489sW/NGWTw6H
 +JjuckdCX09+/AruByNKSpvV/xKSFBbBrxNGmtrXooYkToyu0GHUxxiaouG6c+HB9
 YDM45EAv4i0/SYwQdLuzMunjOhvARkHaIf5M6sQgdl4v376Y+gFdclAc0H84iP0nP
 LJ7+yYO8sTk5jfnLOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.204]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPogF-1w9paM0sZ1-00QlqF; Sat, 07
 Feb 2026 16:34:25 +0100
From: Ronald Wahl <rwahl@gmx.de>
To: u-boot@lists.denx.de
Cc: Ronald Wahl <ronald.wahl@legrand.com>, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Dhruva Gole <d-gole@ti.com>, Simon Glass <sjg@chromium.org>,
 Albert ARIBAUD <albert.u.boot@aribaud.net>
Subject: [PATCH] spl: fix stack placement in spl_relocate_stack_gd()
Date: Sat,  7 Feb 2026 16:33:30 +0100
Message-ID: <20260207153330.90165-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:McYXpiNwGu0CRSgF8SmrHABk1FgOQBHMb54yM3WjaWmeLPl0EUm
 I3u0Qnor08RSvvDAHItbk3fiImr/YjWFtg2bTwJIyBUVU8DY981Z8L2reDhtRjVt0XUpWOa
 aSmz1OyXj9n9zpBDUUkRVndrTfT7k5ZpYVwSyRyCF7e6p78qLdBQdXmu0yAFRpb7LQXfqtm
 bp8AQRFPZwWrirs2BI2qw==
UI-OutboundReport: notjunk:1;M01:P0:r11y4s02oD4=;aGInhFiCWWsJB3/xgg1xDFRt+e4
 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
 B3iKBrvCEGp/Id+5W/dSkx8qTE++T
X-Mailman-Approved-At: Sat, 07 Feb 2026 16:34:51 +0100
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

From: Ronald Wahl <ronald.wahl@legrand.com>

Currently when CONFIG_SPL_STACK_R and CONFIG_SPL_SYS_MALLOC_SIMPLE is
enabled then spl_relocate_stack_gd() will setup a layout where the stack
lays inside the heap and grows down to heap start. Also the global data
is part of the heap. This can lead to corruption of stack and global
data. The current layout is:

                    0x0 +-------------+
                        .             .
                        .             .
        gd->malloc_base +- - - - - - -+
                        |             |\
                        | HEAP/STACK  | \
                        |             |  } SPL_STACK_R_MALLOC_SIMPLE_LEN
      gd->start_addr_sp +- - - - - - -+ /  (gd->malloc_limit)
                        | GLOBAL DATA |/
CONFIG_SPL_STACK_R_ADDR +-------------+

The above broken layout was actually introduced with commit adc421e4cee8
("arm: move gd handling outside of C code").

This commit changes the layout so that the stack is below the heap and
the global data. It is now similar to the one before relocation:

                     0x0+-------------+
                        .             .
                        .             .
                        +- - - - - - -+
                        |             |
                        |    STACK    |
                        |             |
      gd->start_addr_sp +-------------+
                        | GLOBAL DATA |
        gd->malloc_base +-------------+
                        |             |\
                        |    HEAP     | } SPL_STACK_R_MALLOC_SIMPLE_LEN
                        |             |/  (gd->malloc_limit)
CONFIG_SPL_STACK_R_ADDR +-------------+

Fixes: adc421e4cee8 ("arm: move gd handling outside of C code")
Cc: Tom Rini <trini@konsulko.com>
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: Dhruva Gole <d-gole@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Albert ARIBAUD <albert.u.boot@aribaud.net>
Signed-off-by: Ronald Wahl <ronald.wahl@legrand.com>
=2D--
 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index fd915d9564b..8256fa97862 100644
=2D-- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -954,7 +954,7 @@ ulong spl_relocate_stack_gd(void)
 	}
 #endif
 	/* Get stack position: use 8-byte alignment for ABI compliance */
-	ptr =3D CONFIG_SPL_STACK_R_ADDR - roundup(sizeof(gd_t),16);
+	ptr -=3D roundup(sizeof(gd_t), 16);
 	gd->start_addr_sp =3D ptr;
 	new_gd =3D (gd_t *)ptr;
 	memcpy(new_gd, (void *)gd, sizeof(gd_t));
=2D-=20
2.53.0

