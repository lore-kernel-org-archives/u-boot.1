Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD2A606A329
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aEMeNlRq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D6d4eXlT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C60F681371;
	Thu, 22 Oct 2026 19:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6t_7CHzx4S60; Thu, 22 Oct 2026 19:02:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 128CB81362
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695775;
	b=Sm9W33G99mTKdv0qC4LuAvsh+T79nRjgaRY6ZgZrKq6hjme1tqhzYtOn3StFs8SPo6g1
	 oLVUQwgchUtSHdwapzlmK6qMcAWGGFQX3yqI3ZSCrZpASuXygTOE6JCY5ClCbMzEVwRh3
	 5/gxAv/v+JUTNAf/H+hMZPCYIrl8rfrhyAQjQpUJ50PrA/S8QM3HlfyBEseo15fpqiAI4
	 B93vFo4NGU+/stxtKypXt1UUfGBc0uWsACVy2Ch8cDpPc+ZQx1OhEfZsAroUHGhtwCdZs
	 uP+idRB2Nl97Et0XtLvedz9qHxdn2Ffg/QauLvToG1RLJfKuNU7WfxVy3l1xBA34XEw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695775;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JRriDBUvuMJuLQECeW9xj06cvuDaY4dHrDigxjujZX0=;
	b=Vbx3gYH0l3dg9oSdt6+1y/kfbwu27ndQK65ibSDd8Udh/clIe8TCdCmHbG/qaFxdkf5A
	 RNvX0XJwOgAF9T6MEMJGAh0ZUzjmNWPYqLOacHdHHlsYWYSTwlK9g/gBuk4pdWstLPsnK
	 r7GcsgZc2GlgKbxcKcobYnCJe7RXrBz6I741aZwY+cMvdAs6399/jx5YMrqwowwNaP5ny
	 x14OcxmvEv/Tgj7PHDDq3TXciCIDWx9V91kpUgcFpXGqivrU327raURkpqis7iq+6QIxA
	 fdrc8SFHG/BH8r7l3KvWhpYVgAp47YAID0RQAjUJJIvLQxHrfKqzJT5owT5u1t5LN9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D6d4eXlT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695775;
	bh=JRriDBUvuMJuLQECeW9xj06cvuDaY4dHrDigxjujZX0=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aEMeNlRq5gRHmjGRJNWTgcncRlTo1yiyL4gm7ktJhddwqAtpdVNtxkGGeZ+AGs5k+
	 1u0j8Y4WDvKSQii4YK/eAe/fJrfqGFM/VbTM4saiwQyzdkp6wwFnOML20CaMcqFqld
	 65f2Pj2PXiah99nSAtibM/95asHwmLnrkBBFo4ao9utIF1zZ+saErLyUSqc8/q+Y3y
	 CEvReVgu82iHCyRIBFNe/lV43M86vMA8snpk+xYbCS47YB9Hk0nY+tqoEuuPEd5GRf
	 ji5iJN3Vof/qhGUIxgyytW8wv5bajLvLrHW09HHvtKRBCR2/QPD4+NY2F7wsddazyC
	 pZHR9bCN7B8kA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 128CB81362;
	Thu, 22 Oct 2026 19:02:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AB9F3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C7FE8126B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Ir6tIg9B0jx for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4F99D811E6
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695765;
 b=SFlifgf3tSk/JoiUGG+bvOMpX22Cv0OKjif9Sp29RigRjCJAsNIEzo/hL/pdYJvK5J5V
 rMpNzkuQ/PoVyaaqA5LNn9Xensv6VRRzgCSi383D6rU0mbIOjJyRlt7HcYQFP3pAm30Kk
 stHQ2cyvzuyoD6JXJGIrrjgCiZIMyoGvLSJFng75O7P3me03zhVuu5qAh+/7Svn9mlVM9
 NPio/zzer74RcNsmv4qy1Kzt1IGFB2BRtugSF4k43ATo9WGJDioiYdQ1o+u3NATyS9Tj0
 em9iVVDmC+EHj5U+IB6lsvYX2XiAg1V+MmrwLcbDE4iZC1b3PShf5OgmbIIgZd6XCqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695765;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=JRriDBUvuMJuLQECeW9xj06cvuDaY4dHrDigxjujZX0=;
 b=h4HivTy/+0gO6+GKZpMQquKxEFTFTTdNA8dCFVq5dTzPgXFW+4ujI+fR/yqnJBdK07aS
 XBrQRbakq1Fk8gU3RoNAdinOJNzkj1wb0h1wMhy+GoCBvp+4rf7ahvaPdkp8jIhyTew7B
 XU4TPLO8UxL5dr+7M0dCtZplKNq8TkenzgW88c3pQi9/AKyHz69Q0/9QoI1V+trqRy+Mv
 9W97Rvr1gOQgWiFsRdudgY0Qth0UI1rb9a0l//wsX1WEYwvlE78BXN710k1sS+3IiFOpT
 BcspP51GIorZLrOP/M6tOjIAkJJjlGEgIlsVgGxDpY3Y1nVegsbQbva/PGKLjg5Ofug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=D6d4eXlT; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=D6d4eXlT
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F99D811E6
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:45 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so1126765e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695763; x=1793300563;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JRriDBUvuMJuLQECeW9xj06cvuDaY4dHrDigxjujZX0=;
 b=D6d4eXlTAPQclTJ+TMnzZNbMVybpdAyTNLZoTRjJDiHB2mhSkvoK925KwmvF3s3wRO
 bnPEieFxMygeamlXn7B7XaBZDTB7Vz3aGwAsNUToGov1q4lweQK3i+2JwbJRX+VqWND1
 eQqFTiwSLw8rdz6VRDZoSpU+VSAEkYi28gOoJmDeRQPZB2ao+6PChfYNu3PPoDqs9SoD
 fE0h+5KK4CnQjOVvGIxWclgnFiVJ3Dh9xP6cmOzudCnghc3aTo2pSpj/Bz2ZWOcVRNzI
 DqggFlNFcQfBNsC70sQyAnB4MxXWvA37v6JfDEgW7qyQhCQPN+0NLOhIVNdrw+kBUvwY
 Az0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695763; x=1793300563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JRriDBUvuMJuLQECeW9xj06cvuDaY4dHrDigxjujZX0=;
 b=VFVkJE3S/VhZq5Wr5mItql3KBZ17BhKG8td0Mnmqa4MpwFY+pVs4oGUILHMwQtAI0y
 SMFArmKolKmgPS7asoKlzd7VADwqZVd/5/WgQrmn2AGGJGqTDR0TzHLHng8des6NNazL
 P7+wKVFQyKV0Ik9CjY/vyGik0ibPHrsktILHnILuAXJNstMFAM3J5DC1OMAyLvXCFY6d
 fVcpY+H31MJekVaTLj/tal2pLwP5btzACzenD4yFdvlQDSJ+LcRbvlzrtK3SWOrnnDbL
 ogUG8Xd6dYwt8WzV2FWYiEszCE6VqfwHCgaZHoDbbXrCvx8DiXsW+WkJ9p9fUGAx9uQ7
 v2MA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWuNOYCyuIDhodYi/q+D1lBM3ldCLRfVJUKbOg38oRtvHPAA6Y03bHbkfOUsBBK69wFkqESfw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNRW5Dhwjv2Ua/UkQB7gEHZwzCegnbPjAEIRvrCs6v15swSsCQ
 ncLcffhgDK8LlX9vOTsmDGEkRDZ1lRLjhJiDXL91tddnwKjRusRv3/Ku
X-Gm-Gg: AYBFou2f9QNE+xbVYlUxXUKu3CX/LUqHML5oXurLUX2p/XBtMrwMgQqGHCKnRxH1ThM
 bdB4SNtXl06+XkFwusYSBhvB925mZtQ4S4wfcEGB0ztTZAI5ZNVruZ1fa+ladggra6JIgVKfm0Q
 utUCtPF746hi+T/Q99zKsj603oQafniYg3i/DxSCZlaz3Wqc3veVntJ/XeT/QEt6VHXHk6GoMRr
 B20HdoB3mqG7xClhyPWoTXSXCJREesGQIBMp+vL1EY9X1esKxjDzV+BBLWyN/GwzNeb+jgjM3Fv
 zcmesmvuiyQAC9SHgVwfI+t4S0q9dXiLOhs14WVodbQrEDDDwQTpNPyxQSVBQJpi+yyQ1hhOKrG
 2khVzUjakIK54NtAQ1oAqOhcGx7SEiX15TuhxLjrFRd86FEEAj8zL9YJgP989JuMwPU82fvVOr1
 1LGiOaRrNCbsOydKVkqlcik2YYI2e2KWZSs1OjVeL2302WyxxUmVUltkkWdvN7CueP+IbL//Xw/
 9iXJurrHHPjYuomrvSg5BD9fUHbNZ7q6BIiC48R0wmqxxbzePfYbi1epBjlA1FfqEZWeNgt+Ase
 LudjVbZoY16R0P2tljsXFfPsbH+piGV0S5J91iHGgFo008w4Dehw//WK0fj4
X-Received: by 2002:a05:600c:8b28:b0:4a2:fd2:985e with SMTP id
 5b1f17b1804b1-4a211ca52femr85435e9.17.1792695763267; 
 Thu, 22 Oct 2026 12:02:43 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 10/16] configs: an7583: add mii/mdio support
Date: Thu, 22 Oct 2026 21:01:52 +0200
Message-ID: <20261022190206.666950-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Enable mdio/mii command support for Airoha AN7583 default config.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
[ improve commit description ]
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7583_evb_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
index 16466be51b27..7178f45e3f83 100644
--- a/configs/an7583_evb_defconfig
+++ b/configs/an7583_evb_defconfig
@@ -32,6 +32,7 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
@@ -63,6 +64,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_DM_MDIO=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-- 
2.55.0

