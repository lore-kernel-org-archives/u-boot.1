Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E1ACCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 10:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB3F83F24;
	Sun,  9 Nov 2025 11:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Aogrhawk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9FE883E8A; Sun,  9 Nov 2025 11:10:37 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC1883EE8
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 11:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-110-120.46.114.pool.telefonica.de
 [46.114.110.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7BFED409EF; 
 Sun,  9 Nov 2025 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762683030;
 bh=Swlr1HDFJVPMon1wV5glISZh6zGgMbpivRUNN3+UaM8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=AogrhawkKLK8mOXmPfmRhvJHP70npJDVdBldFnOHPoZCX8A8WTFOqamA2ALxoaoP7
 W7eLXPE1q42mL93kReuEIHrW3N2+aGoDEM9uifkt4KIWE97Fai/TD2+FV1DwpUGjPi
 m8aHnA0LX458O659N8G8oPoeZMpyj7fTVl1DDToLrA4DmaLP1yznZcK1oz0Ljw/qxF
 fU0qCNHA/TjVNdgykjj/e6lIOBR7y1A9Emt56GczyZ1BmNPlLI25L1OYIm8o0p30b5
 CmpmQeEb86B04mbbDdVRtNGaG0w/PCeIHWk/PuB9ygBNzFo8a4qzv9fH3mNq570p5l
 T42HnWgLbxYqA68vjaJ0nGeNVscpI4Kg3NYcD1nh7vvlkqUW0By/xHix/Hh5xZ0L/X
 SxjsMXUDvIbZ9gsqb3ME/qUQUl/Yr5TBTB2LSg6d3Ghzh1Sqg9NwGYm0lD6r1pS1YR
 X9y3NuMw0QDmAJfFLcElJKj3HuZjLj1HfPbyOgEvRZnTo9sSAtuVWyj/pqaZKg30IK
 +HlkvoOeW0ig+E100GAgXuPsrwtTMZHKtwSDLM+5pjMVU4pQwMuoBstr4wVxgD+C9X
 /x1yUr9DfUBPZPRTFaKRzUeso332yqtMhHTVwovYrhICinrm7p0XZY8hN9cz7x4TVn
 owUsUa5iimRPfp+ChHEi0B0k=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/9] test: cmd/bdinfo: consider arch_print_bdinfo() output
Date: Sun,  9 Nov 2025 11:10:05 +0100
Message-ID: <20251109101010.306268-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
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

On x86 commit 9b35dbc93fd4 ("x86: Show the timestamp counter with bdinfo")
has added another bdinfo output line.

On RISC-V commit 66b5ee9c558e ("riscv: add RISC-V fields to bdinfo
command") implemented arch_print_bdinfo().

Update the bdinfo test accordingly.

Fixes: 9b35dbc93fd4 ("x86: Show the timestamp counter with bdinfo")
Fixes: 66b5ee9c558e ("riscv: add RISC-V fields to bdinfo command")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/bdinfo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 214b237152b..28d448a0866 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -215,8 +215,15 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 		ut_assertok(test_num_l(uts, "malloc base", gd_malloc_start()));
 	}
 
+	/* Check arch_print_bdinfo() output */
 	if (IS_ENABLED(CONFIG_X86))
-		ut_check_skip_to_linen(uts, " high end   =");
+		ut_check_skip_to_linen(uts, "tsc");
+
+#ifdef CONFIG_RISCV
+	ut_check_console_linen(uts, "boot hart");
+	if (gd->arch.firmware_fdt_addr)
+		ut_check_console_linen(uts, "firmware fdt");
+#endif
 
 	return 0;
 }
-- 
2.51.0

