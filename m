Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B00606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o5P3wHbg;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JhrTRt2x
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EE5D406CB;
	Sun, 25 Oct 2026 04:47:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3bnZOZ81L5Jx; Sun, 25 Oct 2026 04:47:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4EDA4406BF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792903648;
	b=TOZ9hdFOEaxWFV6KxMkdYyDWam0L1cdL0JRtaY4+h2goX+ePavBo9tkE5t3ufo2Zo5La
	 CCwqu9bwbEkgRnS59QIwHp0SK3GEClgBFItbPBdb+VFcdj91He5FC+ltQpjhX4LUSnbG1
	 lDu3uaF+G8idvK8hQ8OT0jpnceBbc/7R2GRPtpVhgmOWTCmmGPNN/5350wypYMZoqUWlY
	 Z/OEArdnI/dyttJUKreIWgtpAZKyaCFqZ10Kuq+Nn5zAn0lPTY+Efm8fFBuUFX37tttk6
	 6z+67QeJoi/V9C6OHdwlqGzbk5eD9aV2NMsOPHzV4zdcSpubzch2vjpy8EId6mbKZnQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792903648;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PXXe5mMSKluyqaGn9OZqQKI0XslLNKmdyvZnoR1xm+k=;
	b=UTFQs8Pfy99UWS8mWZDdN/ctgSoC+TY13cFwfDg96ZYTnAHd+QN/CLRd10aO5bPlPrnQ
	 2h6QxMQRCJx0NGcqwMyRH+m+VgJFOegHaHbt8PipM5aCyCtXju6uAmkLJJwalvUdSeUjX
	 spHau44pt1m+Q1yYK7qgwLkss9gy/Q01C91HVfauGDvgTG/UUD71YD2pg95gQPdFtSk/b
	 L4oS8ffLu5XEwajMxJznpV1K3zRGhud13X9OR5Ckn3qCFtT13sxTDrQAq/JbFlD9qigz8
	 TNNkfe36Ukv0hSdnTzo2LPSoVLwrdLd4NE1a/Jxlu70l5kq3CfdQvUO1Zf8I3TB/lQA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792903648;
	bh=PXXe5mMSKluyqaGn9OZqQKI0XslLNKmdyvZnoR1xm+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o5P3wHbgtuc3p6YMF5OYjWZ6jV/gxjQs2ZTod1S6AHAAQEOj47iL0Hf077yZkMXr3
	 CfXBI8PfBiBGt00GnP9hM6AAUVGFiHLnTt5mipODX+07bC6YGMZWThE4n/gMGSHL6S
	 nOwjy1lT56CfSLDzMFcsFfzZ5a3iGRoI6riNV7bS6bvJxKPZuACBH76dWP5SEyKnnr
	 SB5bD4XSN7rflmmLIYBdOGyccBmtby35lNFXTrl5OLS99NomA1bArQOPUrrVE9NPQi
	 fiRQkXha/WuDPthEO3rSzpPgiDKo/Uz7kRcnyocfenVJbwIrlWZbIzy5dhzQ5nXg/G
	 cs+UDsHMPYpRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EDA4406BF;
	Sun, 25 Oct 2026 04:47:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A35993C4
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 953D760603
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fUanjpSuXSx5 for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 02:00:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D416D60615
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792893632;
 b=FWUOHrNLalNifao+D9rYzEofox+BTqLpHYqRqG4p76ia74ocZii+p0SqrohHyZAe9XBT
 p5YIFWwg8+TaDZWNof9+FTbMrHKa9jkqUHk+Jp4AesH6JWN/Phk2KJtR2stsWa8S7+VVq
 Cb2W2F8HayAhH9z6NWHCmsuns13rkPMGPAxqz7Fs53uB1JhpIGbA6MeQDOH32n3/3L1P8
 Zc7GqT/3hOGzSN5s+Y/a05AuOLBVchw04bK7Barw/CIxkUNlb6JsJW/fMSuF8BQd7XAsN
 wDuVRUSweNmpRbrhS6zAQJfWy5ZHIku1VzEfMq6CFKzbstVmBPstjjw74LHyBHKChBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792893632;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=PXXe5mMSKluyqaGn9OZqQKI0XslLNKmdyvZnoR1xm+k=;
 b=X7wA+zxNRf1hlP39o0i/U2rMkDlHpB47n+aK4Z27j3Fx7AIekFS2pnkje8B5ej4gkCya
 HQm8Gn3QvHGAM3ywYe9A77Ppx01KYPVKNW1WwlBxPhu+BzMbasr0XjDIRZpm2RJ5GhXiU
 vzWem98K38Uyp0han9J4DdgR5P09EDCsogYCtMxgN6Wt1r7L0WWswWXMitk8JDc1IhsYT
 AclSYtpNTRBkJ34L3qGzSkFzsvUXIMxrL9nZXfLwqfT8G87OSiDO7bcLSERzKX3HC6zLB
 ves6czt+m8WjoJu4Z7Xta6dzrDxa/Yev3Hz02HFoGhhi//sowDbCSF3xm0PBSefzd3w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JhrTRt2x; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a33; helo=mail-vk1-xa33.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=JhrTRt2x
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D416D60615
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:31 +0000 (UTC)
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5eadef147ffso1990091e0c.3
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 19:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792893630; x=1793498430;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PXXe5mMSKluyqaGn9OZqQKI0XslLNKmdyvZnoR1xm+k=;
 b=JhrTRt2xvSJ1j/ofR0DHQ3SppwSvqaeyNR4Ma9P20MtPaWzReRY9CNtjZMzuKJyWXn
 aT6rb0Oe6mdvtO8TIjJfeJ8zXvDv65k1Hf5MqsE/erZ8S2jZRzBuFu2IoKOaDKHUU1cT
 5YT0nMOVRHbG7OljWk17K7PRqqV2T6TRRRHiOLIrMetD3vZ9bK0GLYSKsHpySe+gQahF
 UUvYPDiDtnFcAqB0/sN2+XqSxDd7Rv9JqrTzJy5f6i75B70yhQFSrUmfWrREen7HJMVn
 etmVEuRZBSy4lzgetE34nQbVMsqMqhZAOcy684/nEQF0hsakuF/tT+xDRYbvgBgtOGq1
 LcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792893630; x=1793498430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PXXe5mMSKluyqaGn9OZqQKI0XslLNKmdyvZnoR1xm+k=;
 b=Lxzmin6nqZa9i9M8o8v6Nll9LVB2Q1IEj5qMczGQr3fED54i3tQ7aCC6TEIQZmKRmH
 QR2xmdKU78Pe3kD+PDg/koI8Oj9ssJmGNw6wUvP+tVxWSais0DJOExNXSt3+uuR54TyM
 xcz6cttIV+tcGdoUJEu7YUxbT/497RNRYCBcGbJawzriQBAc3bpFVjZT6nXvsLMxUwhN
 By+wBccmqp2yL/CKl8t7sx/hC/y188mAWnkPkhIZ0kr77hHs2cDF6UWZPSq8U8Q6DyWx
 pcPRkqHXbzDFRA/KZMgn5BefWtSLPTD+WYzAREVatRJKn272RQvo0qObAe913THQpqBx
 wEOA==
X-Gm-Message-State: AFq9FYKB2N0eYXbHZXJo86CL4HfJFCkhO2VQqC6KZtwx1m9/PCDDcroM
 PXCKjxXg5926n1NCJmO2nfhbe09C9s6SW8+qlfgc6WVRCkS22KjxF/oNDmIu8uLU
X-Gm-Gg: AYBFou36Dwmde5qbWLgjiJl3UxtgFn2jbHRVkz08Joy0M9rb6f4cKRwRbkkKKGDkpjU
 /qyfHyOnVatoG+hRjCM9NtQWPW7/9VaYAwpTCamypb+UC2Wr5TdCJkkv3lx27SSZELJXih4csMo
 +qPNBLkXkuzbcP+P/F2HYFb92ocVKh7GV/64bLG0STqygh4Iv5Oicbl8PZZrKAoPwaLxHANuiIO
 D89L8zTHSU3NdZ3NbSRu2CBR8DeF50SwbgHEEBZ+TR45ncQAMQHiLZyAqi03MZuex5XYDeVftDP
 bSEK7riXZciROUZgtWBznXV2XaFFH9oMiWqmnEmpkujI0EbVoPtbcPt6XsnaTEIKq0wIwkjmnC3
 hz1EF3+O07ASHuCRD1d6R8T8T3CGyF5s1rj0vNh7Kp6zYPtA14+ETY1d+zmcLgX6COFLG0BZVlP
 S+jubVf3RFpLMLCW5FIjHyTFTfBhYN2mWZ95RBFER//bHDS4FiaDWr9MHbb5gHp+Y7JfvW0tI92
 t7MPD3Vcdi7cWtOrmfa0sb4voxQvs64GSpmPtpFghqsAiWoqmCqd7Xl0dJKhZCmsO73n0w3Gi5F
 eCaNd9qdHO1ZR+7MtGwfIWst5G8=
X-Received: by 2002:a05:6102:4415:b0:7c3:fcb:180c with SMTP id
 ada2fe7eead31-7ce5ccde32bmr965755137.20.1792893630256; 
 Sat, 24 Oct 2026 19:00:30 -0700 (PDT)
Received: from localhost.localdomain ([2804:1eb0:a0:15ff:76c:632f:8ae8:6a5c])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7ce5e2baf56sm3485070137.11.2026.10.24.19.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 19:00:29 -0700 (PDT)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alison Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 4/6] configs: ls1021aiot: Enable FIT image support
Date: Sat, 24 Oct 2026 23:00:10 -0300
Message-ID: <008b75d687592a7f34dee1f818b318c7dd1e7be1.1792893601.git.mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
References: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 25 Oct 2026 04:47:19 +0000
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

Commit 397b0d9e2971 ("arm: ls1021a: Enable CONFIG_OF_LIBFDT and CONFIG_FIT
in defconfig") enabled FIT support for the LS1021A boards, but the
LS1021A-IoT board was added later, in commit 20c700f8daee ("armv7: Add
support of ls1021a-iot board"), without it. It is now the only LS1021A
board that cannot boot a FIT image: bootm stops with "Wrong Image Type
for bootm command".

Distributions ship FIT images for this board: the OpenWrt
fsl_ls1021a-iot-sdboot images are a FIT with the kernel and its device
tree. Enable FIT, with FIT_VERBOSE as on the LS1021A-TWR, for both the
SD card and QSPI configurations.

Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alison Wang <alison.wang@nxp.com>
---
 configs/ls1021aiot_qspi_defconfig   | 2 ++
 configs/ls1021aiot_sdcard_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/ls1021aiot_qspi_defconfig b/configs/ls1021aiot_qspi_defconfig
index 7a301138f1b..00346509706 100644
--- a/configs/ls1021aiot_qspi_defconfig
+++ b/configs/ls1021aiot_qspi_defconfig
@@ -18,6 +18,8 @@ CONFIG_PCI=y
 CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_QSPI_BOOT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index 0cee61568e6..2dbcc7ce609 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -30,6 +30,8 @@ CONFIG_PCI=y
 CONFIG_LAYERSCAPE_NS_ACCESS=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/nxp/ls1021aiot/ls102xa_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/nxp/ls1021aiot/ls102xa_rcw_sd.cfg"
-- 
2.43.0

