Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61441CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 01:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8896E849C9;
	Wed, 10 Jun 2026 03:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TUPLL0PT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43A71849C5; Wed, 10 Jun 2026 03:27:45 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BEF848D7
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 03:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B5C50602C4;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 687ADC4AF10;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781054861;
 bh=8vmiFgZD6CwfKAxDYTpPeGnShk7iNzUDqO1A7v4RTqU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=TUPLL0PTuO3eCO10iA4S3qf8vrihJfB3cUAfytQsiwvLa6rK0z1okPzeBiiy3YF1N
 eZXcVGHd4yuH3B4oqNLbIENKAz71zrUZyf4dwKOo8zJfYk6qAqvTfeP9OMbnMpsEi8
 ABpg5pJuY+U1klDSXiN30+K0RW+xSdroAWKctY5iyG+Ktmx5wV8wWGjBjghpSLB6Hk
 xqfb14Fayu0ws36pXwBXmsk45XkO2KxNR3eWnN0kozg83edw8UsEZFy9xUi158cux6
 zjUBzsnoDWV7fLrTq1M9Xr69WSboiMhOWt2dzRgfKLCL2OALyE/xA7Dbso/c8CF343
 +nrjNb64uhMpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6043BCD98C9;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Wed, 10 Jun 2026 11:27:41 +1000
Subject: [PATCH v3 03/10] binman: section: add AlignUp+PadToAlignment helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-android-binman-v3-3-710298a38fcc@samcday.com>
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, yan wang <yan.wang@softathome.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781054859; l=986;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=74gwJfk8KZmxEDQsTuqFoX/6rqzJ/dp/PciFvlMRD8Q=;
 b=/9IVlFk4txZUYD/eu7UW1bEvaU9IZ9aC17Akp8onDE+R6ChfvbJ4Jy5C7cvX58Y/zc9z5JF8Y
 6rOcLVMKmMKAuyK/fqutRSXgQab7QJhrN0ZkruwpaPeg2hu8lf4l/Qk
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

In the following commits we will be introducing new etypes derived from
Entry_section which need to align values and pad data. To avoid
duplication we introduce the shared helpers here.
---
 tools/binman/etype/section.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/binman/etype/section.py b/tools/binman/etype/section.py
index 8530b7ee17f..a8eca3eaf5f 100644
--- a/tools/binman/etype/section.py
+++ b/tools/binman/etype/section.py
@@ -1040,3 +1040,12 @@ class Entry_section(Entry):
             for entry in entries.values():
                 return entry.read_elf_segments()
         return None
+
+    def AlignUp(self, value, align):
+        """Return value aligned to given power of 2"""
+        return (value + align - 1) & ~(align - 1)
+
+
+    def PadToAlignment(self, data, align):
+        """Null-pads given data to given power of 2"""
+        return data + b'\0' * (self.AlignUp(len(data), align) - len(data))

-- 
2.54.0


