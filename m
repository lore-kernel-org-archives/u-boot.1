Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC36B6082BDE
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ob2Op7JK;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=PoRD8suE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90DBF81D70;
	Sat,  7 Nov 2026 14:34:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFU8EUKociU4; Sat,  7 Nov 2026 14:34:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0BBF28165B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062074;
	b=F6QCs8wN9/M8ax0PMsAwljhGn7C8E+RVrvopOfIvoQPF4ftKy1S2E+PFZRhFKjgice9R
	 Z2CWD53iiO24szvmK0dkT7XgmJayeVPN5SLvubneBuvbOZDUY72StVigF6eOtKMqSfRrn
	 swzQb2GbWFkBCCu5aV4Cy9nZ7NSH66QCMplnsMyENYySgzqljXWGSg7sqU4ox/KwIfztp
	 fLMkGGuFfg4RuFIGTq1FgnTI10Zr1Hnuze42Wm1Tbrqm05kCNhxyjxdS/MHCX6vtYhm/T
	 Emsux/DlvN7fZrki1gCL+ybFSkTq5bOrEOnORQH69jTqjA3gZ9WZHGpywVzhixOM8LQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062074;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9Y4UPNCnVA6HC5YWVq232rLqLVhWkmS0JCz0BscfuCk=;
	b=YmQs4HYmTzmLeGz0zpIW8WUpZSYs2aWBPXOz4k8LLQlz01H1wv0a/lCDZXS7s3Nn0+EJ
	 mKzsoWfGJFuk8k0SwqmcfwbkT1uCbQ78Zc3kkKRo0rp40Cngmg2gHJxDwM70cz5APuqg+
	 mJJZqc0FCJ5z8KZvKNe1HuYNXbBYQbbyDzKCXJU+/kbA49HG/FE6z7WrimXezacVQ+Juc
	 XE3g/SAgDE3d5YD2HCWAyeh7kdaW92ExQqHkXQnZNplbiZKzTDhYp8lIlGUXKeV+vIhSI
	 p4d6pbbw7ws3XINMwMgKxBaSrbpZPDxPuQHoQKBOUnaVGcpEOvFkN2OX1QBQwwA/Tug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062074;
	bh=9Y4UPNCnVA6HC5YWVq232rLqLVhWkmS0JCz0BscfuCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ob2Op7JKaDgE1gQXymeVqSLFtQjbP3i3e1FjpQzJcsdmR44kb9uX8S0100GxAaNQb
	 THnTcO9bNj4Owy3by0rPkfkRNvDbjTNHe08GZqMnmTJBNWxo774eUWA/gQN6M8dMMS
	 FZuAVrmhgpgpcCY2wXFADh/CIw9agVMx+p3qLb5RIyPvzFU7Nj4iKVAEMBOnp+4hUa
	 F5R5iGEJuwI4pwpGKiVvpCTSCxwp8HT3bIGB+bPbXPmsVTd/Z4QUtPNMlKIixcCxkd
	 s8GarWTbQjzSmZxjVL0UnP+6CEUPZCtbSH0vOVU1yDo8TnFLTCnLVmELFEkMer6KxX
	 Yt2pgt6JHgCMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BBF28165B;
	Sat,  7 Nov 2026 14:34:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BDB1137D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A40B64075F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F42ihBlmTLgy for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC91E40757
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=PoRD8suE
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC91E40757
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:56 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1684247f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062034; x=1794666834;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Y4UPNCnVA6HC5YWVq232rLqLVhWkmS0JCz0BscfuCk=;
 b=PoRD8suEm2vNlsaKzqb8HE6QCTVbECSDoflzLn6MuxAdtPg6qu7PntUpAs/NHquEuQ
 tzS7pal8Z/11RJEhgiHX6vbnWFxFyWJcX8LsMym+QECuV7iZ+mfA+YqYLqgRUecBec7P
 IvwvTU1mRla4fKyrrJO8owQ/HCjK40RzavNeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062034; x=1794666834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Y4UPNCnVA6HC5YWVq232rLqLVhWkmS0JCz0BscfuCk=;
 b=FB00uh68GQRtxZk1kuViQ5uoDzoLyVf6Yw/yZzQ4c46ZrWhpmRVNOdRhjHzGM2riyT
 nu02+eUZNz6nIOa4lbE8lm5rcWWqlpZ85PcTQLoBtWSdEpCLugasZfqkjLyGlGesJUBH
 bxMPiTttMjeY61MnQ7szpeRwEJECXqlZ8OEQXT/wI19L+KCIv68ZStID1utdRPjrdm8h
 +gzUjUcb+30rPDBcVhTB1qUBxFMw0h4Iz/LyQljnXTnIqU12/rEgdsN8JwzqhdzkAO0o
 HcKBwBKR+o3/v0ebwEa0cha0fD2Kd0F1a1Xp8cjuel2aq84K8FsL0gJKeP8iTshasnRy
 Me2A==
X-Forwarded-Encrypted: i=1;
 AL+hErF7kF3S+fJwRJITrr2FRkRnBidAvO64WEu6kixdes212m9izCjZ7hwcx/xoxxhi5Kucio3rkFU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Rke8NLDRSC1v3MZ2fgRBbKWRrdP864d6J+4lNGoX+Jw5Ffv7G
 GMvYhkDOql+QhS7py1Sd2fCzdpCU274/tyJizRiyA753JoslTt6bKtXYenCJMhOkUC/hMFbBlY+
 QnCxg
X-Gm-Gg: AYBFou0zytoxWiYlbTKo6BXKPD1OJzv+nhGnGlLE9beegyHo9975VGQ80V0HKSixs4N
 8/31UH2EtG8v5w3w8BYrEq4lUGbsu4Qd3mimokkwzoA63101RH0Lavd19QuTi7COqeYqXrKXrGR
 Jc/0uOQJN5LsGaDtT5LByRn5srQgNwAZtuizT2OXJRjnjfReNJcjPNnYoszToBFWYlswTzdteL+
 sz+APzJT2lv3ZHx2xxeYRwN7AQ1glpyrENgTAc2mBPxbLc3xopthIAHoIGIdnxJNWx1+dNdszsd
 Ln1ZLrBuCdOH/yNxMiPFUPQMZmMgAvrS7X/w8sbYn3XOQTNWYET5P3gv7OIf07fBCNg7BzEpaVr
 LujMxCmAGhMxyrbH2OqpoF/CC+FIWiYKhIVzkRX4vk2Wqa0+p6AOsntj4HceX0sYfAPfg/A8bx4
 KCl/p4wyFwRKFW8CLdcSkImKLycsUCc/ng+agaQxwZCj5S7GZLlqReX8kFz5MZ356f7c3Rx8imZ
 uidRGZYI+jvi3/fVrwvYBByuG14OiDYM/5lvEjk/4QU7+JFJoBIhcyc1WgyCCmSkPiSCbkk4OFB
 3mUMqHKYCkESU4c7q659qTdyha2Vt8VNfB8p81ptcPAfbmEkirMZkg9MTP0ShU/cpPoMxVGleGM
 7MtCFwVxyGj4ZAiuYRlahDM2toenxjIJwleDdYMMtdSPCqW8uKXhdHYs2BUhapGr5aSjKeXAdfc
 v2ssxw78OgDZUZnVU0+Ko5USWY+w==
X-Received: by 2002:a05:6000:2501:b0:48e:5d33:da5c with SMTP id
 ffacd0b85a97d-49273f500damr10661406f8f.1.1794062034582; 
 Sat, 07 Nov 2026 06:33:54 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:54 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 35/35] board: engicam: stm32mp2: enable simple framebuffer
 for the splash screen
Date: Sat,  7 Nov 2026 15:32:25 +0100
Message-ID: <20261107143241.2236511-36-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the simple-framebuffer node of the Linux devicetree to preserve
the splash screen until the Linux display driver takes over.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Drop a redundant comment

 board/engicam/stm32mp2/stm32mp2.c        | 17 +++++++++++++++++
 configs/stm32mp25-microgea-rmm_defconfig |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/board/engicam/stm32mp2/stm32mp2.c b/board/engicam/stm32mp2/stm32mp2.c
index e15141677775..64fb44fd7f02 100644
--- a/board/engicam/stm32mp2/stm32mp2.c
+++ b/board/engicam/stm32mp2/stm32mp2.c
@@ -12,6 +12,7 @@
 #include <env.h>
 #include <event.h>
 #include <extension_board.h>
+#include <fdt_simplefb.h>
 #include <fdt_support.h>
 #include <log.h>
 #include <splash.h>
@@ -218,6 +219,22 @@ int splash_screen_prepare(void)
 }
 #endif
 
+#if CONFIG_IS_ENABLED(OF_BOARD_SETUP)
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_FDT_SIMPLEFB)) {
+		ret = fdt_simplefb_enable_and_mem_rsv(blob);
+		if (ret)
+			log_warning("cannot hand over the framebuffer (%d)\n",
+				    ret);
+	}
+
+	return 0;
+}
+#endif
+
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP)
 /*
  * The FWU metadata are stored in the boot device, the SD card or the
diff --git a/configs/stm32mp25-microgea-rmm_defconfig b/configs/stm32mp25-microgea-rmm_defconfig
index 73f8f7cf96b6..d5ae71354736 100644
--- a/configs/stm32mp25-microgea-rmm_defconfig
+++ b/configs/stm32mp25-microgea-rmm_defconfig
@@ -24,6 +24,8 @@ CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_SIMPLEFB=y
 CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
 # CONFIG_BOARD_INIT is not set
 CONFIG_SYS_PROMPT="STM32MP> "
-- 
2.43.0

