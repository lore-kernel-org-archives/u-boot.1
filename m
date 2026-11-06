Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D706606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 04:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OP9Kj/tf;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wl97/pRv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2EC881479;
	Sat,  7 Nov 2026 04:42:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A_9YEGShwzif; Sat,  7 Nov 2026 04:42:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A0C83813AC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794026571;
	b=EuG/ezWAd5B4XHSTzGaF2f6UsEIagvzmfkOvTSwToNFhCZSFKx2xBG/wP1JEGaS9+ZPM
	 EGUSNQ9ldMNgnUdxGX5XLLZIO2YsYPu5g7NCfh4d1IbB2iqeOaGZ3Cv/pa/bSAtEhChT0
	 m4m+sM+xsG455bTmTH8Zpc8Zspzk+Td7u314dnPei8EayJ+dBryUaprr3fdMSSO9aE/jO
	 YN7avnzLxEKGWE/l2e5RvZ7pl2wISwdItUyF8KS2HbJzSvlE3ZanmB86JG2/Jd57x4IkM
	 Xr78ztwbhPO4wVL4WKunq8wazKPuTPKZdQfwyUpSdjruWPGINTidIUBqcJoBqw13m7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794026571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eBTEMjhdV7k7D5z9s/+Hul525atgv0I/TKBFMtf8k/c=;
	b=pL7tK6K13BAheMv5/qP0k2un4k6tjsLU3UVc2tS9nsr8PbNMwa05DE6q3Ly4df78iWQO
	 8Z+ws2JQuQvf9BmRKRh5TQ3DJTu5O4LZoqEmXXuZVpI7pMnLpDSXjz5Dg7T9oXFqooEWf
	 gOZCfxz3GEqUw+M4keHRy/TZGVGveXkd3HkINCDB5ztUHdkUif21xW44iyFsTikbLZ9v/
	 77h2PqcSR4hHEMx/SIzorH+GiPGmJksjWCey6C+qBXLOnnQKIri9zccubsZSYKwlQSjPb
	 2aQWyLlI0Ev6KWw7Y1gw/SFs7pEVGt4jz2bcN9etcOUkLMNQ7fY+4EGxNS9D75vf73w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794026571;
	bh=eBTEMjhdV7k7D5z9s/+Hul525atgv0I/TKBFMtf8k/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OP9Kj/tfQVvE6xkCJ075tpvA340ywfw8/3rmiSRFZHdgvavMeB9dmTpyiijW5yn4o
	 czkCxDtq6Q4mCP9o6dd7Q7w3+5wYd27/xG6Outwkz8lPpOLzzCCgQeXT+5H/DQ+F/M
	 LPSGHtBcQ7BTC1zD1ckoo3L2lokFVTy2jW2KPCBni7SzHc/AujkRx7A4HybDyLWxTa
	 VJM5nCJ+Wz7BJ0L0FuMj2zFq3WcuRWBVAA8WOHQ8DMHmytE96VtYnLoudmk2rHpvaH
	 ZglRKf3O0FQtSbiXzpmemvCVh9EL8Po7ddT29egGh+ugEqmgdnl+WopcFs4XunGxZl
	 ShcUCHhTYateg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0C83813AC;
	Sat,  7 Nov 2026 04:42:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D10232A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4EE6F60AAC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zfMtBuaTDub3 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:16:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8DE3B60ABE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2b; helo=mail-vk1-xa2b.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=wl97/pRv
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DE3B60ABE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:16:03 +0000 (UTC)
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5eac7220e9cso393377e0c.3
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793999762; x=1794604562;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eBTEMjhdV7k7D5z9s/+Hul525atgv0I/TKBFMtf8k/c=;
 b=wl97/pRv70/twucM9mHdc90sxVZdpRgWlIz84Z+07jMUNf/unEALTNqHGX/UPQnsvY
 s+j/o6zhXQHJIcYzzU97EZum6Fur86I6BqFfPk/b8ReL4RSPyvBcSVTvsR9MczYm+Owz
 kA25jVw+cBc0/9eh6M0s7TXDhxsOLp8GdsGtzI/HOTJOiqHDKzT6Yql51Q3uQ+7WzRV4
 7qBgZ2NhOw4QMgyUYTomDcc7bOyVPf2UgHpAu0TCwEPuIZTvmTauisZpSPdlN3KvfW1p
 SvvYepPta7qm8O7BV3U9Lh7muWacX3Bz2EDVcwwthJdPqpmMVdvIJUEI6+yBuJFHuaHR
 3WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793999762; x=1794604562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eBTEMjhdV7k7D5z9s/+Hul525atgv0I/TKBFMtf8k/c=;
 b=psK0xRyLlKM/Q0wN5+cs0JU2jooS6QHK3/2PGtA7te5UwrO1dvMGFcOF8S+8Hq0o1d
 3J7fnVAx1YziiDvKKXLkMDQCDGBwP6pal7RctfZJqt8IjMq6d39B1lqIkAYYgalVbAQv
 HIj9a8s9jd7HI3V/k7f7ZxY/ne5Kd/a7i1eSY7aUY+CASe2q1qxql8dw8qsz1/bYOHSb
 EhPgIvYkGhgJ+5LsyiJujrOoCqCEOPJOcIj4XfNeeb6TL1XQEY+Qb7Jol8hTbbmDHmTw
 OKPlDemOYYZsRI8WKO5JSFaNtT51Kw0EYjI8rSFnyFmol+HgBu6M4BAJyMcSX928jmhx
 mmAA==
X-Gm-Message-State: APuU4Z9rLcH/RCOEGszu34tQX7uDRWKwTqiMeLtewBRpdEtK4GuESP9F
 3kvvwuBROZNpW9+/rWH47BNsw2HeiLJ/eKhVspcHPiRL5X5o8BPrXb+jDV7R8bWv
X-Gm-Gg: AYBFou1UcN/BDPgROa/lBURQ+dx33L/lBMcmXOxeqlVoH+q6vRz11B7hsuYmSn/62wo
 ZF6lYaGSLOHO1oXqjc0S9kfNgi9dpin8RRaEqcw0UranTzhMlKNyE6aiHincPTm7KakzY80UdJz
 7Y/PjpdWAIgJWLieZeqyHik125ooIx0Hk/3iAdDgmEkUUmVXUbOlfW8OUNFEmWZnB6x/ORtyx46
 AX3thMVsimLpCngrlReQYpRkR3imy9oJd1gceyYtBYDWZ7VXgiZOfkSCcitDJFkdv5Ue4nzRh7V
 U7Ve4LkrDxzvMjV0RcIaW2OAML9Qmu1FVWHgS+MFNuvAH0FFcXMQ0b8lqcbRQpRgiXtGO9oX++S
 m/CoNLlHM1dLy7FVCKNp6FHr8xGI5PCctvYO/77Wf9zZmRNolxE/CL6p7zrdgMI44V2kQol6d7z
 v2JgWcmBdwaTI15fZxmoEi0MJVMjE3sZSJ/TW4ACbeCBx29hrNZESs6nAov+RRx1/SSOUvwW9T0
 0GUijB6mf8yqorEw2SWm8ptfiiIckGVjF6bf0t+dqrFPFD2KcBVGDaMvBSLWu051/RRBeY60l7V
 Tmwd3PZ4ePnrdXDfnODjCro319nraJ8c2P63OUZVSHL2e6zv9NEP7ERA+VSBOPtEXOY=
X-Received: by 2002:a05:6102:160c:b0:7d2:75bf:2fd6 with SMTP id
 ada2fe7eead31-7d2a15aa89bmr1719645137.18.1793999761884; 
 Fri, 06 Nov 2026 13:16:01 -0800 (PST)
Received: from mateus-laptop.. ([2804:1eb0:a0:15ff:e3:543a:df0a:607a])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99bab48acb7sm2614087241.1.2026.11.06.13.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:16:01 -0800 (PST)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alison Wang <alison.wang@nxp.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>
Subject: [PATCH v2 5/6] configs: ls1021aiot: Allow 64 MiB decompressed OS
 images
Date: Fri,  6 Nov 2026 18:15:37 -0300
Message-ID: <74314c7eb4719c8edbb7c96fb74a826109fc3d87.1793999703.git.mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793999703.git.mateuslima.ti@gmail.com>
References: <cover.1793999703.git.mateuslima.ti@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 04:42:41 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit cc7b8b9abb1d ("armv7: ls102xa: Increase the supported kernel size")
raised the maximum size of a decompressed OS image to 64 MiB for the
LS1021A boards, but the LS1021A-IoT board was added later, in commit
20c700f8daee ("armv7: Add support of ls1021a-iot board"), and kept the
8 MiB default. Its kernels outgrow it: an OpenWrt initramfs FIT image
holds a 16 MiB kernel, and bootm stops with "Error: inflate() returned
-5".

Set CONFIG_SYS_BOOTM_LEN to 64 MiB, as on the other LS1021A boards, for
both the SD card and QSPI configurations.

Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alison Wang <alison.wang@nxp.com>

Changes in v2:
- Rebase on main, no other changes
---
 configs/ls1021aiot_qspi_defconfig   | 1 +
 configs/ls1021aiot_sdcard_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/ls1021aiot_qspi_defconfig b/configs/ls1021aiot_qspi_defconfig
index 00346509706..8f01b649ea7 100644
--- a/configs/ls1021aiot_qspi_defconfig
+++ b/configs/ls1021aiot_qspi_defconfig
@@ -12,6 +12,7 @@ CONFIG_SYS_I2C_MXC_I2C2=y
 CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="ls1021a-iot-duart"
+CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x82000000
 CONFIG_PCI=y
 # CONFIG_DEEP_SLEEP is not set
diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index c574e7c6b29..6d5bbbfd2f9 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -21,6 +21,7 @@ CONFIG_SPL_TEXT_BASE=0x10000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80100000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x82000000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
-- 
2.43.0

