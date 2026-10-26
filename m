Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A32606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 05:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p3bf9qfO;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kzx82jrc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57D2080A70;
	Mon, 26 Oct 2026 05:34:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qJsxLsxlR15l; Mon, 26 Oct 2026 05:34:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D1E180ABD
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792992883;
	b=BTXkB1J0khHsSF/M0PhZHAOIM2C20qPJDMWvFHG6k/0LNOTNDqb7nclHB7iSOKqqSGDP
	 fawg/8gMfaINvSciahceYDD15A4TvT9fVB/eR6y+rgQATHJgRHiGXNtwS6TL6e/5TbGGy
	 TDnIU1cJR+SDMaLxtvfLoSrCtz13m82P2fgQPL5amsR0N2UJOsoFuF3S7zCwOQodXAIxs
	 FZCCUd4EySBLanxDrswo/eNYO156UKHGoWsnFjXG7Hn5AJajyGk/ecRFgT7Z29hX60JWR
	 ++NXJhMxoV9ErxJpDIKgEO9muEsIhqVX1pe0DkrTdINZFIxvHlcFxPaCam31gWCyjSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792992883;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DKVKRDie4vZ1ot6XD6h/BLyt8Uep195iDpLQfGhKOSk=;
	b=BhhA/czODAsa28poArV+70jF/dVxCobFEC2zyw39C8/2ktnsWjZGtWPxzhIGdHpKbnyS
	 gc5H3tp7RRo7Xr4csuTYLK0H1sZOWMXAP+f3Hu14O1hYuclzkrs9j4eM5mi8ZAGcysOTu
	 GW+QnqAlpi08t1P15RCy7SRSGdbw/HzJ3j+sOOhcNuXYRGUBoJ/e2X9PkBbHf6HvPxLY5
	 OCu16eC1jtkZ8eiU3zRoU4z1RPfSEdJEQjDCDk+lDflZZEOKMTRqy9OCb9chQqUWPo0A6
	 eGqJgV5hUYL8Ab967hyR93w8vqK+7pACluMzKQMs2e0AgWYRHfU/kbZ37e4pmFLZWEQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792992883;
	bh=DKVKRDie4vZ1ot6XD6h/BLyt8Uep195iDpLQfGhKOSk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p3bf9qfOCz9UXtHn8DnUjp2m3GM0beBhrkaeaQlBB3DJnvGPno9DpF25avSJvZx41
	 Ek4mEl3v1ILFHpVglD+/myaSIkooTF4GueG6gX1caQCc1tZn5JT32L59+GnSpVXNwN
	 xqSRmVdxEgS/d/ETcSI5CXLSxeWQY5kCV036ZnI+JCME+EOfX5E3rQcbAOJZ4gKKy7
	 jYZFuo4/0AD/g+dnGn74mL8KlrXYDL6+5MdYGGb27eRcK2tg8ux5bhst/oezYYu7jM
	 dW15uka1CVXcuV/fWVXWPZVge5OAyFLnApXzktC8oCeQta0gnRG8Y1YZQ23ERqCVdc
	 Jk5ADJOneYJCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D1E180ABD;
	Mon, 26 Oct 2026 05:34:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B365279
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 04:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 10FB44052F
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 04:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jnw8PVn_6mBH for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 04:04:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 080B64052A
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792987464;
 b=FT1ewi8Cb6uZc5PVKhVlcAWY1wYUAW+Anfa0WX+LuKlf1Zcs3mS/QmToJfDM/zgxtbNN
 4h5BGJzFAknZx1Qtnsy69Li4RWzJKyceIUgDaKsNgEn7JnWk70p+VIJJn92MJHESqXiIh
 puzz+A24PbG4bS7AoCV9sM2fqA/WTUsA9Zbf0OdUIuldEhtaw8pf63nJD4s+do/456D6J
 TcheaFw2Cr7yXL+5SpSDbKchlIW92Jo5X71Wgjz5phqSUPXg0kI4t+Aaw2sCcCb/rvyPq
 jiRHC3c/t/Wadi/gkgmoVZF29Pkb4YOT5+Vgzp9PJdFPhyripi7R+7dHUxgOpjWhsww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792987464;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned:X-Virus-Status;
 bh=DKVKRDie4vZ1ot6XD6h/BLyt8Uep195iDpLQfGhKOSk=;
 b=cxN65kUZUzBsJQ2k/rO+cb/mvfAUh7bzVQaRwoWs7g+GqSHlQdSr9J2cdRqrIvjJMrtx
 CpIMpBbtLl8HD5TgBFwe6i/03VxNb4AXnJ/ymLyW4iUWaZ4K+vg24KPjhtBQv0pluwkEB
 x6jvmD+cZfmVfUkcwv2um++3nguwZYag6pyQBTGoqFSxQtNoRkzHoZPbcEoBc9o22ges/
 qXZgOJvv1uWidwMpsbfjhOKKeJcb6yxtwQowMxAzpZbMykP80Ob5Uq5YwX/pGPISSzevK
 +pnVN+U4EJ8wC1YRnEWgBZq3UDsicGFyYTAt7M11PeTUNI7b6JDhrec5VbF8VUP3Naw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Kzx82jrc; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Kzx82jrc
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 080B64052A
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 04:04:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14BA4840D8; Mon, 26 Oct 2026 05:04:19 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18DE383108
 for <u-boot@lists.denx.de>; Mon, 26 Oct 2026 05:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mateuslima.ti@gmail.com
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-9906870a9baso1347143241.0
 for <u-boot@lists.denx.de>; Sun, 25 Oct 2026 21:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792987451; x=1793592251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DKVKRDie4vZ1ot6XD6h/BLyt8Uep195iDpLQfGhKOSk=;
 b=Kzx82jrc49iAOgbrdpwX5vmTqoxlrvkwNiji4NUbfyBmO79REpPlUPSWt9zQUoSafJ
 Xd2Eisdjf8EaZhvav/E8TXMlfwBaZuEL3dLOQ6aTrFaBRXgq+7GWVr/WVdQFpiRsKdZH
 ZA/xK11X32SV4R4i3+o91Q2mG5awMUukpEemXp+3G+k2yD0i5/88gZ/SK/9SVt1KdMsx
 UCMmBNiisdJs9Pp6hYJZihENCvzatnB68EHPqklMnl16t5OKEvr+q33UqBZ2XplY9f9Z
 wn+q7+CsiPrp46NZlMk5OuICWmXJMMclg+o5alA8hBpoH2m/rgthqf+/4EV4OsJpzM13
 HFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792987451; x=1793592251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DKVKRDie4vZ1ot6XD6h/BLyt8Uep195iDpLQfGhKOSk=;
 b=Jn4WNCGBUFjo0DjTpKCt7kaQ5LE5ZW5CBUnW7CUI0sq/gGVqkPVIJXsH/UEYxd1q+i
 fAa1cvRxTqZ0EA+6/pG4cJc0O0HSmoUbhzYRLhTkWPctkgReFlurU/Jku2sgx66dlmVb
 pTMY72nv5oCnGE9W4Sqvy0xPgOhXSeNcR85NIQiFCU359CTf7qSQgBW5DjNJTvtwbl6M
 ZYClXGIZmdLYqnQpmN3VB+HExfRU3JARKkXFXm65VBqPehapcO2JWSNys5kwwVbp8GBH
 J5dqNSZCaNFUqrTywNbHLZexfene4IBhOatFL60WaVzcHDr4VkypCe1+idT+ni0s6nIg
 oL6w==
X-Gm-Message-State: AFq9FYJKTNthbNpBXmFgt4u1SSb+FxFu9QNm2hQpBpEiHVZpBeFx2WWl
 LYyhFsFltWdQjVwi8/RFCJehQ75V2mtHaJKNkgJS3jfXOgfnw+zXXIREbMPq1A==
X-Gm-Gg: AYBFou1llh1cgPlC04owDHxMz5A1Q0tPdbVd+CfsB601ZNoKXnRzfcSloqudHmkA4Hk
 5ugj12mSR7L9xZFUymSPafRN8OBPqpJ5dJECFkkthMi+4d6LBY3FLnpa1L1JLgSMn2XWhBHxx4B
 pj7/JsSawIaksVJDW/jKk47c/EAfttnoFLtX1DR18evRTo5TVqOsoWMBJ77vzil+ng/9rXePICX
 h/mVi+2mtgVxoroVcRu2jpH4eQAh4OO9iAWet8p6rDKwabV+VaC1S4xl4O28SoTRDsRqlGm9xqe
 QwOvnqhrngqeh03TG3pFXMbUAOOmrMjbOxl/kYzqSfsAyfvJ6aF7zy3iGs1cw0phmKu3tWKFDPp
 m94/uoY525k2/6QwA5FVt7lPTzDey9E35dh4dR1IeuUuswm3YGiWKQJABAL0Jb7SESSrOUza8pu
 PEs8QxDJrVGPCHdIlT7jViwvAILzYfN38uD/BUvP9Nc85IvvI88ZMUamk/s/QECt3pTr62ZBWv9
 fBdRIOK5109bp6uEc+jOhZLy0+78SFBoTYoKd5QMY1DHlS1Y/5/b4iOrcVNYAebSklEI8BbGLPp
 FHudtPwrdx/wkZIRgwIwYnSMocyJ
X-Received: by 2002:a05:6102:4455:b0:7c1:f386:1b7a with SMTP id
 ada2fe7eead31-7ce5cd4701dmr1298830137.27.1792987450635; 
 Sun, 25 Oct 2026 21:04:10 -0700 (PDT)
Received: from localhost.localdomain ([2804:1eb0:a0:15ff:401d:bb0d:fbca:c67d])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7ce5df708e3sm6410250137.2.2026.10.25.21.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 21:04:10 -0700 (PDT)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alison Wang <alison.wang@nxp.com>
Subject: [PATCH] configs: ls1021aiot_sdcard: Limit the U-Boot image to 1 MiB
Date: Mon, 26 Oct 2026 01:04:03 -0300
Message-ID: <20261026040403.1863907-1-mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 26 Oct 2026 05:34:40 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The SPL of the LS1021A-IoT board loads U-Boot to 0x82000000 and keeps
its malloc pool right after the CONFIG_SYS_MONITOR_LEN bytes reserved
for it. When U-Boot outgrew that space it overwrote the pool and the
SPL took a data abort at boot, with nothing at build time to tell.

Enable BOARD_SIZE_LIMIT with the size of that space, 1 MiB, so that an
image that no longer fits fails to link instead.

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
This applies on top of "configs: ls1021aiot_sdcard: Reserve 1 MiB for
U-Boot in the SPL memory map". Checked that ls1021aiot_sdcard_defconfig
builds (u-boot-nodtb.bin is 586688 bytes) and that the build stops with
"u-boot-nodtb.bin exceeds file size limit" when the limit is 512 KiB.

 configs/ls1021aiot_sdcard_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index 0cee61568e6..1fb8f7b0f6a 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -30,6 +30,8 @@ CONFIG_PCI=y
 CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=1048576
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/nxp/ls1021aiot/ls102xa_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/nxp/ls1021aiot/ls102xa_rcw_sd.cfg"
-- 
2.43.0

