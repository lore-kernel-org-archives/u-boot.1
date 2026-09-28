Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DA9CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 13:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D52E80FFD;
	Mon, 28 Sep 2026 13:42:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7PVFCSdXHEku; Mon, 28 Sep 2026 13:42:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0756581000
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790602965;
	b=YWBV8rOFyNCq9APMyqn2ytIrqzBu/ZU8qgmmW4hKf/uiAarwXU2QOcINPAFnAVWvv3HK
	 jBFNP9N5ZIpGlJH6+zc10g3vxrNAB5wNraG6UQbQKSuHCn/6U+DVvIubbMpzAqq934av8
	 Vj+aI/sTIW0HCk4bZAj7tNzaz34E4dC+qg9m49K0xIwpVkOVGBfqyApECcUEWqMFcm7KO
	 R8n90hRkihl6ynNFKc1ayTR1Kh68jpuS/sgZZd7hhm8aNqeq2hz8qukYNrLkr4us+VU0a
	 gwHKTRi88Eo7tRO+lx7EiK3E3vRtM8wTbUZTiRFcorbo6SZ1W/n4lKVfDEoQWok1IBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790602965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vpmbQD8tOt0b5mgLeHsrFELY2DxVJr5lwhF4ATxxCsw=;
	b=g1UicmFravdDGxmz2BQRPRa3Zrv5rt9QdRhS4igq9l6gsRT3iT56911KHji28SITbZSX
	 47NdYMR3gMj8UB0PKJo/nJ5GpGWfi39u1JMkD91RFDQSdV7nGvpj9PBftq1t0aXj5C1Fm
	 J3clD0Xm2DUOXQQotW7THqGOfLQJhFSKXgbkSfVbI4VyW6v+RDLneS4tzH06OKGsEfNit
	 Z+9p0gZUESIhsM6L+p1aP8q9KzRF6S6f1XgM3v/BMBK4JiJ0jEJXfZqv4pNzgAkVWEkIQ
	 IoBtn66l9PW95i1dQsPjvyOdFuz3TgSlWzbf1kkZdwoznMUk9BxrG1h3tdXwvwc7HVw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790602965;
	bh=vpmbQD8tOt0b5mgLeHsrFELY2DxVJr5lwhF4ATxxCsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+h/TEj3DiP9NKxToK9Q9mixtSolvIv5Z7/cU/ZPh3RdqJVkVHELXkBPXqzMMk3Wv
	 OY4ggC5JepITUPCGKWWh//8uEI5Q3uoxjGlrcS08Jv4bRzHH+uV0AFEvsNPROK+Aqm
	 R8BWMPje4R7FH/rYW8f47FdPnx8DwBAVuRl2wL3pZPMgaAEOJ9I2frz8wQ609DM7Ge
	 CEqm5RXcfuUvwxtUg5mB95AH5lBn6St2UV5dPAPEKzAFewPZCrKsXuxhhsOoUyYX9e
	 aPCnKszLIXYLrxJe+lj/2p2Q+cJMmb//M0icBRKYpN/mJhojqn2UZdFdtXZGQ51Uhn
	 9b13cl2SWWO2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0756581000;
	Mon, 28 Sep 2026 13:42:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3254B361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24232405DA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TM45jB5tVQaK for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 11:05:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 40D10405C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790593534;
 b=raQBE7CDPTdO90zKv3O2xYgt1PsMv5MzAgoi9q5+jGaEc1pbCTKJKLI61esm1OpHtiV6
 GrkAPBjojCBjZG2YFunp8/BpQ6IIQU+I4k1HVNfW7vGIND2grAuRryIYiclFCy4A1k/lM
 aGkiwDNsJxv+vPfmcdbfkV732XmdoPaRSDpQ3Jw7xOW66MGgVKdmJ9jUEntwGup2TRmbK
 ZkTYrsZEOjn2nlD2aXYyimsKfrJpkeohH9wVFUKxc3anT5yFt8JszBi59fRZe1BQrM4M8
 S472qMxydlSO0Zj7dvrVJRp6T5F52yVc/HkRC4x8DbkrZ/K9TBd+hKJJuXM0yK7agYA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790593534;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=vpmbQD8tOt0b5mgLeHsrFELY2DxVJr5lwhF4ATxxCsw=;
 b=h0UI048LCZhyBg3fEgezum7Lhk3JX8xX5MiUE2cztUJlRW1w7gIHWcChJ4zlNl0Rsaxy
 LzANdQJDC7k/XYqSeEGXUSMkp44A8uyXSuvvHEqmJzMN4JfaYKMFFFuQEwvKoOg/sZUX5
 /C4T3KSN8PTTSALDdk9vPsfqYiACgNxiJ7+kMLlt3wAX5piQhrp9zZEchfTLTnI/iZtw0
 qmeHh3xJyH5jKcePt05UMHjaEn0GEXGaLpokgRSHWmWBF6IqCV0eMsnRb/Ymjwk60WDti
 NZtibZeUXfpI/PpKTqz1zVi3FB6S1lq90B8b70fbxEUiMcCJZVz7O5R02QRu31QHlNQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qWtdzRpH; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qWtdzRpH
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40D10405C5
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:05:34 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6c0fce17so14720285e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790593532; x=1791198332;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vpmbQD8tOt0b5mgLeHsrFELY2DxVJr5lwhF4ATxxCsw=;
 b=qWtdzRpHcL6DPqgo1VzvvXc/PZIQO6wY8xpJsxWFP9Lp2Fp6fLEVOOqdz2EzyxdtJi
 SGfvCVEeXWdqWus0O8wMuj8TXnoZSERwPSF0s6lEzVyl1dIvzzbNoNZ93Qsw1ApkrZbo
 Y/ZxezgWgPt3nI7tdI5VzvlEg7Ex219TfuduRq+FT7+EF+Ih+SjxZCni2ZBfolExSurp
 O0YLI8OzG8AwaFzi+cC7o/z7PjnFPSehY7V3f8FZW8M7jpy5tRhan1OZiY+84RA1CReL
 sgeAkLx2W897NN8zLFjbAI+bZi2x1g9ydNu7gBCTeV3dESUHvnmQQHGLHqIBcLXChB4I
 XjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790593532; x=1791198332;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vpmbQD8tOt0b5mgLeHsrFELY2DxVJr5lwhF4ATxxCsw=;
 b=TnMeC4bGxcdhY3MbjwSivsQh713Iw/0QfT6OavC0Ml1jvOCdaHP72p7+S82smi8oW8
 yUaTgwcnh7/BFL1zcWi+GxvWrClJFhYgdpmRBXl5OMlISf2JyJtWi9MDxF2YmQNrWrYf
 x6Kv16kVAojM//owDn/fa16PP41IvJsTb7OAHZfoK72p35pcR9RuJl/hYh5wkDPomxIx
 mCOR5+qSlVG/TR4VkzJTR3CGrxQT3cps7y5wq4OT3V6IxITFWAcR4xm4bwbGoNbbACaV
 3GzvY0EqMT2qh7HyTOEej5VGcWKhFlmtD0ZCLfv3N4S5tURtyYVd9UlnUFnj2VBiq6rb
 cltw==
X-Gm-Message-State: AFuF++lVd3yfcQoqu/b2LDN0TMfm/htYUZ2KB27ZfV+yTdVzUoy12ydf
 2LIHC40Bm4/yGDvv9aSkkBKvb4P4Mc/sOcbPIzeglOwFA1q1HIEejRyHmE/SiXDvido=
X-Gm-Gg: AYBFou2mobz9XTyLnwd0w1YNSMNhJJuhnPMnUu1axwUWMt0dVSAP/AlQSE2li1zDfcR
 cMkJuho+82JlgWZYiYwDLyt23BhCsIHZxdONkwyRkKofFr81U00FB5h21vx7XCPqbq0UAxhwl6c
 JDbFsmH3XfkI7CfUTjM65YpsINWGXTZYcj0EZED16mnfQ8v+f84cvsbeQBpOoigRkJhEMQD/7pz
 fHBVfI4UXrCeJizSE7rMK4QntFQUeX3ncN5rwnDJtOZtto5L5rWLqQ8a/BUG8T4nQLxaBYD+wGI
 WtoPG7Z8/2EiyIyT24QHwrSJV0/ImHO09YPY62j+5v93avUXguLvGU0PfQ9vKFxV2XcjGAelJT8
 s1YbhfkFbKhRN7Wt7R9RZWRdh0M2WQYihPu7f+Fj1Yvsgs6OCKS4Edm3xf/JhC9EZvuJOW1LE4h
 zBOmVNDkDw4apW3sVvRbmMQGen8u8TvxdO+Dp3q/1RkErg1rTY4JEZMhJXjS/5GbEMDu0/2lAZY
 wWpX2yxCzW6IPFHL2xnSziSTeLlVkXjPrEznertx4Rekkqb1zc1kHVMyQLt6TcmXlRjyHLkZJI7
 1JYEvM8CBnx1YRODWCqDcqbfWMvZLkhnF+0Lqm7b
X-Received: by 2002:a05:600c:698e:b0:49c:fc6e:a3dc with SMTP id
 5b1f17b1804b1-49fe66f1491mr231505005e9.27.1790593532046; 
 Mon, 28 Sep 2026 04:05:32 -0700 (PDT)
Received: from localhost.localdomain (37-188-186-98.red.o2.cz. [37.188.186.98])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017816efsm131458075e9.9.2026.09.28.04.05.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 28 Sep 2026 04:05:31 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Priyanka Jain <priyanka.jain@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH next 13/13] board: CZ.NIC: turris_1x: Fix up MACs and serial
 number from OTP
Date: Mon, 28 Sep 2026 13:04:34 +0200
Message-ID: <20260928110434.70686-14-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 13:41:44 +0000
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

When the environment is reset with "env default -a" before booting,
the kernel device tree gets no /serial-number and keeps its all-zero
MAC addresses, so Linux reports "Using random MAC address".
misc_init_r() reads both values from the ATSHA204A into the environment
at startup, and the device tree fixups take them from there, so the
reset loses them.

Read the OTP again in ft_board_setup() and repeat these fixups, through
a new weak hook in the shared P1/P2 RDB code next to
p1_p2_rdb_pc_fix_fdt_model(). As in misc_init_r(), a valid MAC address
or a 16-character serial# already in the environment is kept. An
EVT_FT_FIXUP spy would not be called: without OFNODE_MULTI_TREE, which
Turris 1.x does not enable, image_setup_libfdt() sends that event only
for the control device tree.

Tested on CZ.NIC Turris 1.1 with the NOR and the SD card build after
"env default -a".

Fixes: f41582035cf7 ("powerpc: Add support for CZ.NIC Turris 1.x routers")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Marek Mojík <marek.mojik@nic.cz>
Cc: Marek Behún <kabel@kernel.org>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
---
 board/CZ.NIC/turris_1x/turris_1x.c    | 20 ++++++++++++++++++++
 board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/board/CZ.NIC/turris_1x/turris_1x.c b/board/CZ.NIC/turris_1x/turris_1x.c
index 32535ed6ee0..8173e021f11 100644
--- a/board/CZ.NIC/turris_1x/turris_1x.c
+++ b/board/CZ.NIC/turris_1x/turris_1x.c
@@ -315,6 +315,26 @@ int misc_init_r(void)
 	return 0;
 }
 
+/*
+ * The generic fixups copy the MAC addresses and the serial number from the
+ * environment into the kernel device tree. misc_init_r() puts them there, but
+ * if the environment is reset before booting, e.g. by "env default -a", they
+ * are gone. Read them from the OTP again and repeat these fixups. Valid MAC
+ * addresses and a 16-character serial# set in the environment are kept.
+ */
+void p1_p2_rdb_pc_fix_fdt_env(void *blob)
+{
+	int ret;
+
+	ret = turris_atsha_otp_init_mac_addresses(0);
+	if (ret)
+		printf("Cannot read MAC addresses from OTP: %d\n", ret);
+	turris_atsha_otp_init_serial_number();
+
+	fdt_fixup_ethernet(blob);
+	fdt_root(blob);
+}
+
 /* This comes from ../../nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c */
 extern int checkboard_p1_p2(void);
 
diff --git a/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c b/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c
index a19a98dd0d1..07c18117cbe 100644
--- a/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c
+++ b/board/nxp/p1_p2_rdb_pc/p1_p2_rdb_pc.c
@@ -373,6 +373,8 @@ int board_early_init_r(void)
 
 __weak void p1_p2_rdb_pc_fix_fdt_model(void *blob) {}
 
+__weak void p1_p2_rdb_pc_fix_fdt_env(void *blob) {}
+
 #if defined(CONFIG_OF_BOARD_SETUP) || defined(CONFIG_OF_BOARD_FIXUP)
 static void fix_max6370_watchdog(void *blob)
 {
@@ -418,6 +420,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	p1_p2_rdb_pc_fix_fdt_model(blob);
 	fix_max6370_watchdog(blob);
+	p1_p2_rdb_pc_fix_fdt_env(blob);
 
 #if defined(CONFIG_HAS_FSL_DR_USB)
 	fsl_fdt_fixup_dr_usb(blob, bd);
-- 
2.54.0 (Apple Git-157)

