Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31A606A323
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PVegnhdx;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DOQnVQWf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA0CA408BA;
	Fri, 27 Nov 2026 10:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h13mCFfVBwZK; Fri, 27 Nov 2026 10:09:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1DD644065E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795774193;
	b=NXRIesY691ADOUqa8WCn9L+3M91MVSNN1sEjnud/Ea3Axc4PJQZSKupNyMC32BySD0DT
	 uZ+Knd95eH6GyQ2zEmyBVqpiROnghP2z1hwDYAaBtNgBPEaYUBRhtJHosYHJvkU0R7McO
	 tfI1jFQXy1zaLgQZOLwQ/hVm9Q8yAdlVm4mxExREHQLJMT5MznwpnCK/8tbX8nDRUSzYW
	 Z6tLryXiT1slI2KFYq1rrXwRt/5+PYDP03n59c1QD3ofjkjG4j53UN4m9QQ7dCNIgZ7RB
	 NzuiUwLWlkS4/1qb0rXZF/pfCmaBnTNCPUb4yr9XEVSFH/nnweDW8Hi4Jqnd74nh7iQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795774193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0IX6lh3gH221Vg+fBKGz5H/N5dEuYnnmozcmYzUFAyU=;
	b=Y8IjRk7Vd9NuGWahC6CRUYZSaeKw9vaRwGhEi4xFbLPbk8sgc0twcArzGOZfd8jPzQGl
	 GPiKaW7ljkQ9XxLbFiETzzKbyx2RIBFBEEUsVfvDcTjpt2f9BUhlijcbHvyGljNFJluRh
	 sAB1yKL/B67tQf70HtbvozaBnlhouX6LfdLFoOiI8RATS4dlgK9bUSi0r1Lz+itiXk3x9
	 2piHTlxN/kscmS/dmt1aXxQQf4UYB/P9I71c/UZqkT9gr1W9J9ERs+yTimEfsOf7btnO+
	 lRm4MA6qt4hrQLbcAnsNo1q0v7wpDy/2aRTRSSpnrLs9QBiKqTYcKpfehHZY9FI49Iw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795774193;
	bh=0IX6lh3gH221Vg+fBKGz5H/N5dEuYnnmozcmYzUFAyU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PVegnhdxOBcRY3pFf/Ft3B3PZ+YsrwM8IcwYep6775W2ft2U+tEC5WHtS8NoelEvg
	 u5Xx8KlfxaJFoG5Dlu9DFv9qmm40/9gEPhqhkREWeQPYiLCLvOAixb8HmdvzKu6D4j
	 tyBYeVd6YTztG1BfoVHBP8GMVHMB2syLnnUQfs0mFTpqDt+S24SfwB5J8zFp+hqJZp
	 Wf6Qgl82VQN184dF4Yg396mtiMQ73tQWrVslrnd4dy339zFl3a16LWUrLs3zrUEGoc
	 C3cGMeWZdpSKFpSWZffYN3ve2GO3Ukm1SNoDVdWFJvCIJ6Fr7uqfspBvrRbJtsVOyk
	 9ZWqR0NzaNm5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DD644065E;
	Fri, 27 Nov 2026 10:09:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 366D82BD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F6E760AAF
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:09:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AwU9KP00tsf4 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:09:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4830A60A67
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DOQnVQWf
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4830A60A67
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:09:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21D4B43CE7;
 Fri, 27 Nov 2026 10:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3E21F000C1;
 Fri, 27 Nov 2026 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774189;
 bh=0IX6lh3gH221Vg+fBKGz5H/N5dEuYnnmozcmYzUFAyU=;
 h=From:Date:Subject:To:Cc;
 b=DOQnVQWfvAodmHL4MIbrz2nq7+1JTUzbWGMK1yjwK3fG7H2NShZ24Y6RrekVVC7ok
 x0xFmxUXP23FiNlsc+Ewg7IwcLu0D1g1fKtjCSmiB1a0zb3YH9J6esHIjYZjLiWfKb
 Te1bSbSFhwgfSp4q9cDK/OrtKmvM7qtBtrsbiiXsrnvgnoo23lKngw9wEZ9cpE0MP8
 KjxINy567TrSK4xPQkgrl7pC4Ra+pqy8Z13hYADoLZh9QWTyIHOfmQqQpKkpBF4ZmW
 KPPzCrRTqrgq7AqI0KvOsan8Nxb5++SUDIer+zKi++Mm+fQl0QN2CUi0c4fd+7xMH4
 ytKyb6Y7+FdFA==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 27 Nov 2026 11:09:46 +0100
Subject: [PATCH] configs: stemmy: Enable ext filesystem writes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-ux500-ext4-write-v1-1-0ca250dbe845@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQrDIBAF0KsMf50BFZXiVUoXaTNJZ2OCpo0gu
 Xsg7wCvo0pRqUjUUeSvVdeMRHYgfL5jXoR1QiI446K1LvKvBWNY2u75KLoL+zEGPwX/fkSLgbA
 VmbXd5fN1nhdjrUhpYgAAAA==
X-Change-ID: 20261126-ux500-ext4-write-4a654d54b861
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stemmy can read the ext2 boot partition cretaed by e.g. Nura
build, but has no ext filesystem write support enabled.
This is needed for EFI variable storage.

The EFI variable store fails to create or update ubootefi.var:

  ** File not found ubootefi.var **
  No EFI variables loaded
  ** Unable to write file ubootefi.var **
  Failed to persist EFI variables

Enable EXT4_WRITE that will write EXT2 and EXT4 alike.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 configs/stemmy_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index 982eeab391c0..f5519c7ab05e 100644
--- a/configs/stemmy_defconfig
+++ b/configs/stemmy_defconfig
@@ -42,3 +42,4 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x685d
 CONFIG_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_VIDEO_MCDE_SIMPLE=y
+CONFIG_EXT4_WRITE=y

---
base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
change-id: 20261126-ux500-ext4-write-4a654d54b861

Best regards,
--  
Linus Walleij <linusw@kernel.org>

