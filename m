Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1BDCCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 15:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECA3440726;
	Sun, 18 Oct 2026 15:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gkT1b2LWZAtT; Sun, 18 Oct 2026 15:59:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 03E5F4060C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792339159;
	b=aqrSPidLbGYYENKtozR8TZwacmDJOSnWHXR7vAWHpZjVEAIti+wImcZqP5AiXCpkf9MF
	 duuxUX1KzLjv2WSpt0/ZhYEu2kKVliUDlcIFW0TvRhcOH/6IH0Yt9RIB/PWQtClAjtTz2
	 p2dvGaAkdY7JdUBAD7937NXHKOVhhGNxGvNOzaVLG5hDw+Y9nL7eCAkOhI58qpZyvPy43
	 JAE39RbIMVUHnkQNUHAzKOq0WRZcf2HyYMqGd80fWMLyNOiGSzpInywLG8P1+WepbjEG7
	 yNs9k+LOHd2esr5hFwFIZSumsUf8B3IvL2iH6FgreTRm0RXuJ8uqs25uW1jrr4Cedkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792339159;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Sender:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/rEn3KTzy2qzhBpvQL40jFQysA+90756Lx0d4NLMqmU=;
	b=b3GuOGZVsl042qy0Ucs5mzp0vEXrmGdM1Ge6ZS/pSlg1lSlUXihoffRF5YsR064h6KDx
	 SzLva2t8OP3XNZWwecJvsGYW5sBddcoCqzcDPLLURdPISZy5GDKCicWlWFsWaLA2/cmz0
	 TTCObgjKRgtI96qRv/MQrGzTsfkW33LCtJM8oKzV1CBG/ZoMkgii+vssRMkwobezfc4e/
	 TO311q/QXt8735SHOevlv6Yvk1M6A9RihaWiEL2vCOt662F0EDMc+jw9frUrCz5wxl4M0
	 N7Icolb/6GGO8IcdKpnEfcfdWThO6DE8S0WONoNX+mXErXZ9B6AktE4gMT8AKDBY5cw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y9eogFGI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792339159;
	bh=/rEn3KTzy2qzhBpvQL40jFQysA+90756Lx0d4NLMqmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vW/HX4RL98UAm1UMO3THHCv9rVl9vuRxsny/+IxOPaN/k0Eg1jzhc7dthd2/L2Nmm
	 otwJbe+NrTaR7+qoOQuQjYoDYEGBqJlqDV0qxCljL3uaQIdlab3vDH5QXgpuL08uxS
	 1WOnvG7cY3EPsFEHc3nphGi7IYnm5mm4LazqPRTZ8PdWcYKzRmUH63YbN8J/LbnbRm
	 PkCWMfXPc4GNFCXxgjHSypXJeAYSGG2hfTne+uZfTur3UXT4isKLk8WIResouE2ZZa
	 NB2cqbT7UWeQ2yhH+3DGQ7D564ymsBYZzP0I9yeaLkd7PwDsiuFd5eGIh+Xe/qpew7
	 qe1v0mQ0YSfdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03E5F4060C;
	Sun, 18 Oct 2026 15:59:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A11D61
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 15:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07DAC405A7
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 15:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PBZRW6IWt9U0 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 15:59:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E95EC40569
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792339153;
 b=GP9cr01GsPUamxdfSdBKUw83L7/3ktgEuFoaV2xp+PBK9idkgE1jw71mSMHCRQ6BUezB
 hM6El+XtSEgYABLksFt4PO5e0Hpqyjsi6phsFIefjWtOQVRTsAx4xNmJgz/CKCcPT11pj
 0QocKu1x6iyTGWVpj/vywvzcHpLUfBr4Wly0AQZ4butslrV9RVUNP/aujTo0/D2kHsT7Z
 9C90SOrVc20axtHD4L2b42rrGHSruQbeuimtYCkwbqCmZDlbEQw9yxdstGGxcBiFDnKgd
 24jIp9BxdgumKcG6Zk5CPS8pRSxfn1URQ6mkmkEayWTm9EQGMvXEb28p3HoghvmCk1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792339153;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=/rEn3KTzy2qzhBpvQL40jFQysA+90756Lx0d4NLMqmU=;
 b=K577bGIbsvbrYkDJ6O6UGZ+ubuGR4zJs1CRKWRtCjziPyE1zg26xUB5MqHHqYzjlrC4g
 5208jemzCEl6/VU+2c027r6ld/z5R+5t+ZjuZuoUCA1GH1SHttpuzCtyVWMixZ/gsO2Ru
 /BscSLWEZwthbkfznJ3nz0xFbi7pTjqWspTWbmUfRpAhIXvUccTefoxbTXBwTbHwr+Fb1
 csL5xXrXhrZgyAC1SuTIPzbjVm2h32ihlhOA1BX3BHOahwz2gcx3yZuPV+NdYWrt9olDl
 OChcRt3HhTOTYK/05vWOf6WVOaW366tisskG2sJujlNcOAv7T/80XPLC8qCC3ewIAog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Y9eogFGI; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Y9eogFGI
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E95EC40569
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 15:59:12 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso921853f8f.0
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792339150; x=1792943950;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/rEn3KTzy2qzhBpvQL40jFQysA+90756Lx0d4NLMqmU=;
 b=Y9eogFGIQTBuqUb5O+uTWh6eog89Itn8/JquU1Bw/yhlO8iHTCGNsn0iy+VjbZDEmI
 3m0XUp3/sUYsCxg7TbKuNy8skLdYVNsy+Z2p7x2umCmdOzKIsblnJZwB50qCmGSOXv7Y
 y6uW4zeo6r5l2JQs9QvrpV53FnXsZJYCM5WF6atUrtsuYW/DwHMQQm0eRmwoBRYSm5OP
 qCKe6q+8iNwGBJEY5Lkj8aTquWfan4hTc5IuVit4LwRkjY8d58mq/Z+eTicqVGI8b0eO
 c8EszBTOQBNqIG8WbRXRe1kpALVZ4MPVzX/2k+bBXvNuyj3yOieloOQEdI/nLhGHEd8q
 W1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792339150; x=1792943950;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/rEn3KTzy2qzhBpvQL40jFQysA+90756Lx0d4NLMqmU=;
 b=PKsYh09IFNNEfdBH2R3+HzS0scre9TQ+058S2Kh1HUn5orn9haMLnmZtwHj4gx0wxo
 PGXkNteL11EeWaAZn0rsrEbBuWG2+WF52NLu1BPoJAtM8CMpRavpgzVah1jWJsCLTecb
 Dm+ZbXZkS2TtMIXhSN8wLN+3njUVhe30yAXTxVVJIVgZsUYbXLAgybPsPoofZ2gnOqpv
 FuLc+63eeiXPGSnar9APjfA6c42DV58OCjjhvw0SpdVQ1GAh1kkuvVzojt5doWSDrxba
 abLwkCHBDZWGY9j0TM/VDxOBM7v2vuC7HIxaYyVV60ZEX98GzZXLhubMI+uEcMXsRX/L
 Pn1Q==
X-Gm-Message-State: AFq9FYLhhyfARPCt/7bl+ESSNtflgJBBmX2wNvjjmdFTO2DQrsk1eYbn
 AJfHZ+ghBXe70Z8pOJd9S/9+4jElVRFLOmt1RfyHj5zl/GmUEZisBX2y
X-Gm-Gg: AYBFou0xTAsBCd+ggvDpV0vAErhNFPlg0mCHCHSKzTtBPk6EW1L4N0VAIYoCBehpeuc
 6/hrtvkNLOyUlUicVBqaRqZSRm0Zb1wP4n/+S1fsWwKq88qHWHnuVlw9ppe6dXnZ+rPUQgMJjup
 01hIk5QiKLWrRSZ7aFu0l0bL8bkkgs8QqnBPBtPh8SNzPcdqonttGgpUv5rQTaBXkq+/CHI9Ecp
 sL37jv7ot/IMQlbnmgYzH1PUFKdjIKKXrzkgBoPzVslEZfdFx8tb3agQco2eACmP2QiIKAX6hyG
 3zyArJFAE6pmzzEO7p2I7Bfry6zVCvBNj0FY/Lc4II2qtkPEocIGgIWawVpAvqbJVBafGgO96pp
 pGNfHU3MLTlYlA3bwe3z4MtXbbb6sJU7MiMTOUOGqVmHqpiPJnAOQeYR54L8a73UgIrfJwzv/a5
 4uiVT1h+jNr422n8g1h2fE4+ny7mqHK+zodel1pYjhTdAcrB1l2PzNgY7BcvAs6rkfD8Y7v4jWx
 0bGDncw
X-Received: by 2002:a05:6000:490e:b0:488:6561:b324 with SMTP id
 ffacd0b85a97d-48e07baf65dmr10554038f8f.9.1792339150237; 
 Sun, 18 Oct 2026 08:59:10 -0700 (PDT)
Received: from [127.0.1.1] ([151.71.143.36]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503d78sm17053434f8f.50.2026.10.18.08.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 08:59:10 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 18 Oct 2026 17:59:05 +0200
Subject: [PATCH 2/2] global: Update references to U-Boot git repo URL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-master-main-v1-2-e07455d232bd@gmail.com>
References: <20261018-master-main-v1-0-e07455d232bd@gmail.com>
In-Reply-To: <20261018-master-main-v1-0-e07455d232bd@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
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

U-Boot git repository URL is git.u-boot-project.org. Update some
references in the documentation still pointing to the previous URL
at DENX.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 board/rockchip/evb_rk3229/README | 2 +-
 tools/buildman/buildman.rst      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/rockchip/evb_rk3229/README b/board/rockchip/evb_rk3229/README
index a8dcc40f09b..01839fe504b 100644
--- a/board/rockchip/evb_rk3229/README
+++ b/board/rockchip/evb_rk3229/README
@@ -3,7 +3,7 @@ Get the Source and prebuild binary
 
   > mkdir ~/evb_rk3229
   > cd ~/evb_rk3229
-  > git clone git://git.denx.de/u-boot.git
+  > git clone https://git.u-boot-project.org/u-boot/u-boot.git
   > git clone https://github.com/OP-TEE/optee_os.git
   > git clone https://github.com/rockchip-linux/rkbin.git
   > git clone https://github.com/rockchip-linux/rkdeveloptool.git
diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 151123ccdca..9dfd32ad8ba 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -179,7 +179,7 @@ Setting up
    .. code-block:: bash
 
       cd /path/to/u-boot
-      git clone git://git.denx.de/u-boot.git .
+      git clone https://git.u-boot-project.org/u-boot/u-boot.git .
       git checkout -b my-branch origin/main
       # Add some commits to the branch, reading for testing
 

-- 
2.34.1

