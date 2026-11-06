Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301C606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 04:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HBKSf0QK;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vDxQFDHV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFE6E608E6;
	Sat,  7 Nov 2026 04:42:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ykSaRGW6FmKQ; Sat,  7 Nov 2026 04:42:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11987608D1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794026573;
	b=j7vQSAPsQDNTaOeQ9JqBqq9fVeEgl+ue4htC7t2/N3h7TlfhGJ0dpV1mF/OCOf5XAVQK
	 K16YEAh/uQkKJx2qeWxD9cI1IT3yUzjk5miusfJAPjEIG5Sl81lxsQILjGQsEsVcbDaQb
	 LxdsaNhGlXYreOPXiuJvQmtVKU5WEgFiuHpNhR7jduoyaiL9S1q+EDQsa6ziaZKmBrP2C
	 8orcT8gbTVKF+EG6UtDGUUKPGQhzOrn5PK8cHyZxqnm7hmkeUX8aa0W8PJVU3OEQP7flh
	 ytsEfQvSA6b2c8faAy2cXsCBSCpEJXY9hhlhLiBdcfs19SXPzaFqoGUq0G2N0M3KO2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794026573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5Xw23kEV55JjliII1Cc1AjfJZB9yfJXj6edTTXA7bPY=;
	b=AA162La/9RBI2aQyrJKskDn1QZpiMGnCPsNNlsP/7RDCoNtkZ2gYsQCcELRXwUID6p4G
	 8xzs3m+4avb8OvchXFiPsT561eRQ3LWNhpR95h+5itqs04QAKAEbPZdjcEvnm4yO7SvQr
	 dG5ZVGHHzv4qAako/2cXBHvPinQB8/swGUvrB2gHEZ3IpSsPx3qtgGtNPw6rcEJqMnKE2
	 90xZrTntjIn3wlWY0mX76vi6Z4gS15I/aywiaGFLfdLOyjNevBL431A0kcsJoxEuTp658
	 LafEk6rbkKjv2TVx+s3z582YaS9AiG6IsuqltXKOcgN/j9ZRgqKPk+xW3ce6Vn8IZ/A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794026573;
	bh=5Xw23kEV55JjliII1Cc1AjfJZB9yfJXj6edTTXA7bPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HBKSf0QKO2dY4CiXVDNwABUVMIDWTd8Ek7o2N/J/DcLupXU22U44j4iXEG5HpD6KM
	 7qYf2WswvraVMbyocvtg3yAT7GVfO8aRzqCCnJRa1mO+lO9T9BLcagg948mHfbRpU3
	 R3Cyue4x1tENyJxlBKyBGkbrDl77h5mxD2vOZOWhnyJveSA3F6Z5AauInwrc+Ac0EU
	 vRR4bGvjORFG2XGuLM1WCzouPGVjKBWMlZ30ywqJAxddiSA2mwfxtAldU28flk3reg
	 nG/M4AIWUXCBpTfRYEVWuG4fnw06SJfSerD8WzsknN1aAzB8Gn1FbC+lkm4INihOl8
	 CH4yJHg4lZcfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11987608D1;
	Sat,  7 Nov 2026 04:42:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BA4B2AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C0F881542
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:16:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SGlgQ5goUIQF for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:16:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BBFC881565
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a32; helo=mail-vk1-xa32.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=vDxQFDHV
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBFC881565
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:16:01 +0000 (UTC)
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5eac4855401so410672e0c.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793999760; x=1794604560;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Xw23kEV55JjliII1Cc1AjfJZB9yfJXj6edTTXA7bPY=;
 b=vDxQFDHVdj1ay3fS4es/qlG98AhZUE37y2esOMCFGnFIj1k8nG+6lLmmevGAnheG8f
 8KXJCXAKDMPxJYdol0ADGfjuxZk09oN+fO0aqgsPV6TTrvrCuHr27kNNNElSdPf7rhar
 0Q1P8siEMsvVx4/XJgDqYIqAPgHbUYiTmzwBmXecdVrAGOyF9kwry4VOoPFKLVYSSlYS
 wgz4ZjJu3Qs3SsVb/GarPRIGpbRrw0i7aVfoWBoCyiF/Q5GxtDA5HgqwVIVJM792PPTc
 LnjeJuziQLnmt8WEZD66/RfiBIehsifu5I7KWsCFkGNu5YAlTN5YCsviRE3UsUtcxwHR
 Xx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793999760; x=1794604560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Xw23kEV55JjliII1Cc1AjfJZB9yfJXj6edTTXA7bPY=;
 b=0Q1jSVClRaCJ9zX/cCfZ9jgX2GaApiStaEc+Ij4q11khGtiU6dYSpRTvaoVYkjZt6a
 h5DvzMUV5FS8QIznr5JwvqhQirJFcUncxdDvP//ZxD1H4L/cPc6DtoTsE/M4EMKi4fh0
 AXdVcOaapyNDps50fpT05rd/yvzc6VWkpqAvk8BBca5KYxEVIPyYTVQJ0eMPVfMhkIF5
 6DAgnUUYPfowa5i7p72qPCJWZ8lIKwR6Y/JztWXp+H4IJcuUjMp1gZ4xWv47qwup20X9
 qM6OdNdM0zeNcaOt3JugTsxwbFdXGjH+UvXABApJKurI9v03p0iYLLAt/GnjthYSla4t
 v8AA==
X-Gm-Message-State: APuU4Z+X8K53EV87o4KGYP4ZTXWKiBaW2K0NB9Fj80eQKj3nSYSDy9Jc
 CK/t1FlmIoEfCW7cgiFEVq6xRyLiuBF3DzPzTUE04cNWa3MHqDDy4b1sgawbAAPO
X-Gm-Gg: AYBFou1tODldqce0CsB+Nr1viulBeYCIYJPCkp9K/h9oNmRsXUfqkJk9cRKjtN3J5WJ
 2cJaucMhty0Pjzf+8/D1FKFwbQeGeMpozRuTf3GA7hk9KMteykyt5MNFRHqgYgZTysW1M0KnvQ8
 PqSMc8On5tMicT4jai+iXNfz026L+aPP/eAkbbK9irsgmblxe4dvs4CLSWUvIaayj8ZF2vy4zYD
 nhKGZpGYoyDBVZxoDffhUbIS8npbHsrZtdBZ4js/rd7ClK2NuJMd1KEqQotyGoXE4FzdZ9o965W
 hYKnZpurAMhgTL5x307ocewOOnA1lwyJedqJRQuUZjocqbbNSu8IFBQxbwwvAsXG2KB0HoaaQy9
 VxdftVNcFtyKPF1OJLMEMaklz6szwLWpgMUi496CK8X/PhZxwYdvwV5dMJimfH73XXFIihi/b8C
 yveBNliSggS2OnmbzW4s/qIwqz41CJhKuHgS/ZarXkEke8g9dG/R2qH+4Q/ufRmCn9GHF8nQb8x
 rr9fqA7KsjZ+OB5TN+jrl6JsjRbMvBphz/2PIjm+pAcO1WYWsBQXEjcN8e5y7y6c3lD3gn7ilzr
 /CQZN+WGUyae/FxHyk+tKuJDAV3++pHdgpdeWEiG1Vf6aWWp2Rg19/8DFqkTN8efNSw=
X-Received: by 2002:a05:6102:2926:b0:79c:99ea:2c9a with SMTP id
 ada2fe7eead31-7d2a152b535mr1845298137.11.1793999758796; 
 Fri, 06 Nov 2026 13:15:58 -0800 (PST)
Received: from mateus-laptop.. ([2804:1eb0:a0:15ff:e3:543a:df0a:607a])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99bab48acb7sm2614087241.1.2026.11.06.13.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 13:15:58 -0800 (PST)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alison Wang <alison.wang@nxp.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>
Subject: [PATCH v2 4/6] configs: ls1021aiot: Enable FIT image support
Date: Fri,  6 Nov 2026 18:15:36 -0300
Message-ID: <61fe8f38aacd5b1bb7941a9c4ded7910c5f6b21e.1793999703.git.mateuslima.ti@gmail.com>
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

Changes in v2:
- Rebase on main, resolving the conflict with commit 8ab9f25f7e39
  ("configs: ls1021aiot_sdcard: Limit the U-Boot image to 1 MiB")
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
index 1fb8f7b0f6a..c574e7c6b29 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -32,6 +32,8 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=1048576
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/nxp/ls1021aiot/ls102xa_pbi.cfg"
 CONFIG_SYS_FSL_PBL_RCW="board/nxp/ls1021aiot/ls102xa_rcw_sd.cfg"
-- 
2.43.0

