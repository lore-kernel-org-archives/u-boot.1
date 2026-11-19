Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD03606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dt9aRdLI;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pXPlfw53
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D00E040D26;
	Thu, 19 Nov 2026 13:33:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wU96Ekqnzq-d; Thu, 19 Nov 2026 13:33:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7BDE740D09
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095224;
	b=SYUFmpuPmMKNhbHgj8LjIs9/hIvGvUFIc9I8nNePEPxSVSVHMOUXGC66NkBTTMKLM+ZD
	 uMNgMixKE7YRmz7NA0R72cZa+VZl89psdFmqfgIABfkXdpFTuMhOuQPU+7mgHDOpZanDG
	 yGUOhhTPX54oeWy3thpNb5ZmVyxsKDA5FaW5E5VluHKzX67nNmUn7dRGtBnKqMZi6nnbQ
	 ccX38xD03jGo2DO0gx8bRaCtQkkI9BdVZW00njH9k3mGGjWU8Ia7AM2cAtUG1rmQxwsC1
	 1O/hfhYxmblgpjcPuztvENQcb7JmPkSeN0d68oRPTVSH6uQUs/zcWG+LJb3GcsdEQcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095224;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GOBPxK45EcoUCRU781XAJrcZL/Ch+hLXzBn402KudBw=;
	b=P9cBQahJf9d3kM4/lsdDV63Ws3ge+fErTh4IIk8bxCq1PQfmKQj6W/AbrBAk5ZkywZqI
	 zSMm6irbgaItEjcAv9t1P/oDX/VeYUbYp1tfKQx46l/R9DcfyE+7ye+OHILYdel2KDgo2
	 O8ESbRznhTm8mVplh59ULCbD52DjAcqzJQ68fQdB+GaPI5caRk+s0P9Xasb0cXeAqFMki
	 tNtVCHSyRyLqn3UuySj/f1Kcx2sitRlelKGmAVH+BnjcADnRREukQm/M6ydlOv/p+emVR
	 lHvZxWfIYPTIgIflQv4FtwaUXSbgLlou48e685HCXjDBGL9P2RK1QgbFxSyj83cjceA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pXPlfw53;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095224;
	bh=GOBPxK45EcoUCRU781XAJrcZL/Ch+hLXzBn402KudBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dt9aRdLI/T6J8T33kKiA3I9ojrsNIkBEjugt6E8zqjnU/eO8c3D9kNuSTgiag+RXv
	 ANS7wj22WrpdYEI8gKdjgTXMM8SfggHf8YH9FX6VrVwnaxrfBgvQkf3TGKAzSc1YUn
	 +iD9yYawsTnLSWNtDTJbEELJeXLHPh3XpVIl268rRFRNCOiTVU3WqzXfBHQNZcjFJ8
	 yDxLTlYKOBTQZphJT+4ylx7n6nysoZuN5uEPPB+OU2cvt3g7LhAbgROv54ROoRtIao
	 5BAm4O5ceMg22SBFdUxZ+hyZ1ccR76fbW1+vWuXb6osLMqRE3Z07Sxrdw6mtxjMjEu
	 Zawsx8A5SBUQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BDE740D09;
	Thu, 19 Nov 2026 13:33:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CCA2F9F8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF03540B0D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oxKmYGjKdr8B for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9D77440C4E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=pXPlfw53
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D77440C4E
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:31 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4a9be758734so444794f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095210; x=1795700010;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GOBPxK45EcoUCRU781XAJrcZL/Ch+hLXzBn402KudBw=;
 b=pXPlfw53s9imt1T5bHr6MRdl3YQUSucSDfV53F7Acj9kGQ6yA0cKDOYT+0Zx30vdpx
 gtNG3gTSOJP1QSm22s40teI5nTtNSEfIj7db11niK9ESfYUI+eiBxwUoLU+THHx5MYNc
 kpfBLE7YMIYqYJ3jtIymCla5TX3arClaCLXbgYFxjQ5Kfrya7CloTQiGLDkkswAz24uL
 NJAxyIY1S4yzLM4oXnWh+1wGrJuV7GltW0/diDMHaGRYK2xOEs2AG4EhoVav3gi8xZHq
 qW1M45Zji5mFfPhrDaPLmFg8cN1MBFa80m2CZIVDCedvM3TAMrrfLQZ3Eaelh8AYx0MX
 P56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095210; x=1795700010;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GOBPxK45EcoUCRU781XAJrcZL/Ch+hLXzBn402KudBw=;
 b=xZZvfe5Oql90TxcynoGwPtRJuukuNJconmT3Y7PuGvkCSzHhHjfqbAqeyinsoKjgc6
 yIa+uSp3eWyUBXFHHJZZhOYYTvvz1/Q7BQ+1iptYdcdkrUikJlZTMONFeGoPzqmkU4TJ
 pSPFhkVIDZeN4FCLvw34wU+B+JwARlUNL0WhKH38OA5QP4u4Q8uC45Cxv1gBxT2BL1iM
 NHuZ+NS1kN3ShQSlKnsVz4ljt+VzOOeJp1hC7nvc0fgYTy/2RrxGntQqhoZSaFrlPL1o
 gKKgS2pTfc+YJ+CoMsSSgmqXfH+W7wfsH5qAEzEfA55ZRWZB/a7LNqHOBx0eBYXpnsgf
 rPIA==
X-Gm-Message-State: APuU4Z9iB4FVWKAqZp6BZeh6+gq51JKhEr0GZOyA8NMqYqj5VWEOGXg7
 bJVRU8d0vbqmd9dTfbKyTp6xumHKmFFL+rLOB/pWrBIKYRSpIHO3zdh/v975gf6a
X-Gm-Gg: AZFdTZf2DTKm08A64XCAgaR3Q5nctEpGnqLpR8eGEqm83SpLtYJ3OyESbvKriww9ik3
 g9OJKkds2NH7aKG63V5GMT/2ieFKxwDj0A5osMz7Pc67/y12aIk9d9b+P995CTL/fXTmLpukDbX
 K/oHHntFa1d5U+6+X8fL2qPQHmflkST3omL7AjeqZtMECA5H+zmFpIjeubN/3YLpiCBqtGrf2Pv
 o5Iar8lCwcWxGnGUGKE5Lji5mWU6ooEF4vIRcbB1Q18zgv4tjiSzgjECa90I4hUGBH1pdX3qjUP
 tx8Jm03+2QDAqgW9VTkG3WDlgQQrWhtZXBY41hkdoCJvUMQeBLi0fMLnuVI58Ojgfp8u2WgybZE
 0ObOMTMgZ+/kKVLULzMkT0bGsZGA5fgZyptuHd8pXLuPmuViJwBF9/oT50LumlZfdIAqcVxz2lv
 /Jg+rSSfxaFUgiqMsK5HgCbMEDrGjEGE/3Q7+n7KGlKDcImI9Mh71SsQKT5/7rraU2R83ggmaPF
 1duCMTIRfFcEypX6MNLGPe0pcHcRJVmEc1hZtJ9sYAWvXYq5+VdAxWaU4e48nF5QYrKtHd+Yeg1
 taZzIMF1bN0Qq3H/dbfviK9N18+lylOauBTeFBXIJsWsXj3cvOJO2tmVgBVPu9bzeUDseJQ/6aP
 FrhdQBY0YhgEyw42DbyiRE9AYBNXhaGHGrPbeXi7HVWLhhGltduyg6+ulHw1TiSLaTo8i7qdnNT
 ZiWp9VqpuywPXr1x5bHR4x7jdEL8swrT2J2lsj8QKqg4RZLTvqdoBy
X-Received: by 2002:a05:6000:258a:b0:491:fd47:5df3 with SMTP id
 ffacd0b85a97d-4a6332bc8fcmr13205685f8f.7.1795095209562; 
 Thu, 19 Nov 2026 05:33:29 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:29 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>, Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v3 12/14] board: CZ.NIC: turris_1x: Make NVMe and SCSI boot
 targets conditional
Date: Thu, 19 Nov 2026 14:33:08 +0100
Message-ID: <20261119133310.22732-13-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A Turris 1.x configuration without CONFIG_NVME or CONFIG_SCSI does not
build. The NVMe and SCSI distroboot targets are listed unconditionally,
and config_distro_bootcmd.h turns a target whose support is disabled
into a build error such as:

  error: expected '}' before
  'BOOT_TARGET_DEVICES_references_NVME_without_CONFIG_NVME'

List the NVMe target only when CONFIG_NVME is enabled and the SCSI
target only when CONFIG_SCSI is enabled, so that the NOR build can drop
NVMe and SCSI to make room for the ubi command. Both defconfigs enable
NVMe and SCSI, so nothing changes yet.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
(no changes since v1)

u-boot.bin of turris_1x_nor and turris_1x_sdcard has the same size and
md5 before and after this patch (Debian GCC 14.2).
---
 include/configs/turris_1x.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/configs/turris_1x.h b/include/configs/turris_1x.h
index c05614950c7..3a2818d1904 100644
--- a/include/configs/turris_1x.h
+++ b/include/configs/turris_1x.h
@@ -71,6 +71,18 @@
  *         define CONFIG_SPL_MAX_SIZE = CONFIG_SYS_L2_SIZE
  */
 
+#ifdef CONFIG_NVME
+#define BOOT_TARGET_NVME(func) func(NVME, nvme, 0)
+#else
+#define BOOT_TARGET_NVME(func)
+#endif
+
+#ifdef CONFIG_SCSI
+#define BOOT_TARGET_SCSI(func) func(SCSI, scsi, 0)
+#else
+#define BOOT_TARGET_SCSI(func)
+#endif
+
 #ifdef CONFIG_SDCARD
 #define CFG_SYS_MMC_U_BOOT_SIZE	CONFIG_BOARD_SIZE_LIMIT
 #define CFG_SYS_MMC_U_BOOT_DST	CONFIG_TEXT_BASE
@@ -266,8 +278,8 @@
 #ifdef CONFIG_SDCARD
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 0) \
-	func(NVME, nvme, 0) \
-	func(SCSI, scsi, 0) \
+	BOOT_TARGET_NVME(func) \
+	BOOT_TARGET_SCSI(func) \
 	func(USB, usb, 0) \
 	func(USB, usb, 1) \
 	func(USB, usb, 2) \
@@ -279,8 +291,8 @@
 #else
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 0) \
-	func(NVME, nvme, 0) \
-	func(SCSI, scsi, 0) \
+	BOOT_TARGET_NVME(func) \
+	BOOT_TARGET_SCSI(func) \
 	func(USB, usb, 0) \
 	func(USB, usb, 1) \
 	func(USB, usb, 2) \
-- 
2.54.0 (Apple Git-157)

