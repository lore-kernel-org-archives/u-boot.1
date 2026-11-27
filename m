Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D7606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xLZcjoJz;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P3HrdBSI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A73E81244;
	Fri, 27 Nov 2026 10:31:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CN1poEqeroTc; Fri, 27 Nov 2026 10:31:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64FE981222
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775509;
	b=hYoz7Xi4XlfehhGZQc9LHxCexfbZKOPrczD9qFkd2o5r3i+tLfaopbQDFpAGWd7L/fkq
	 dUZrnQOsR6Nfn7jxlQ/rLgX2/dopTUTbaRjfmkXiNJP8NhVRvpi/HF/x1AxQOF2ZnpJUT
	 MFcOWhTe/Kvdb7R/cDRz8T6GCE57u9xnzIARnSwqSXkqZGt+BRWZ/FUR3EueWdNKGDp1i
	 Hvd9zMt+iM35IR8EI/z+Ph5qMr5QHug4pDlClqHMvRNNx8KZTcLhq62TWDLNZILbCE9uO
	 gv8k6ajGF0/ILIHOs9bemCWubEy9MdwWzBf33RTUetNX5VC3dlMIKVl4t7sNAopKtNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775509;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DshH5ADBHUlJ3V7LZW9j2sgLPIX3gDSYtcrMVx1zFh4=;
	b=atkKnJI73oY9cq5ZpJ+Q4xf2Dcplx7/h6tRdU4wBLhwWX5dEWfrftojIQZjV/GharwV1
	 VAwzMB9nGO2GHKEle/dpd3//w4+8vVjQ0K3HkZtFzNvFFPYkmiGb5htTuEZxceJKLkYPA
	 QKTLFJkd60S+8/2OZy0W1y4WTKzwSqtPCRZ0P06JZ/nwgkMQklZc84fa7YxvqRKKgNenZ
	 aliCzU2xaAFZ5jXj5VrzqaWBe7shydSairfMkBbxtuMjellzteb96OZgM6JjDDR2hI9Fg
	 G8jGR6uxE0LF4B7+qZaDCur5R3AIfmE3kTdzf2VacgBkmkMEBjzBBOGTi8TfgGYQQog==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775509;
	bh=DshH5ADBHUlJ3V7LZW9j2sgLPIX3gDSYtcrMVx1zFh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xLZcjoJzPd38n2I7Hm44bmUvc3c3qVmIWx8B41kT6j50K5hUqpwTJ4wjIAvzxm9HZ
	 ZrOUn7vPm5NREwKt/xtnZK1W/pWgpHsrkEi5LC1r8Xur6UVqPKEj7y7/Gf8aERiv58
	 XiUAqnfJtcRrY7dceNGCVKFL/ZonnzNWvW2iy3i01D8qpekqYRvEz0wVMjClOpiS8s
	 6HvI92L3M8roCvR9/X7deO8aWgkPxBhcYOkiF3TwXcJ0Orf9Ks59mG4QrkNv3tLZf9
	 5spwZvwIGJ5XWsEhqcvtcoDK7GN3W/SjELRWgXjPUqkHtJMfGAZHsDsVkS6IHWqwt/
	 H4QvTUmZaF0vA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64FE981222;
	Fri, 27 Nov 2026 10:31:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AFE5266
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F5EA40A70
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WTtQoOBLT73d for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:31:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 72BEF409C1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=P3HrdBSI
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com
 [IPv6:2607:f8b0:4864:20::1333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 72BEF409C1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:47 +0000 (UTC)
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-386ab9ab619so10847110eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775506; x=1796380306;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DshH5ADBHUlJ3V7LZW9j2sgLPIX3gDSYtcrMVx1zFh4=;
 b=P3HrdBSIjKvJF0OE14j0InRzGJGkOkVYL4lN4JD47JIiyhKOj2BTQqf1xPxaJ0cNJv
 xd0OoVg/TQp1nI5TVz7ZSwJcXy8qRsQAI9VOuAHudmTPZuDl5aRHj6nuTp9f6BmFhLEk
 1f3lCblKNnQdHSZCz3wQpgW8Nz6uB0ijmUjIny+83wCmA4aQWA09dXmmcTnOf7OhL6Z0
 VJDkZlyqxUFYeEQxqTNOuWccQ6s06Pcig82r7wjaOmhE5ADCh60ikB7xe4WBNUI+9GZH
 J4eVpb4Hr18785Fnc/N9tHYFEXRVa5A1OGKK6rSeZzkhyknIW2JT7HhIVFBcMb2QqvhU
 0fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775506; x=1796380306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DshH5ADBHUlJ3V7LZW9j2sgLPIX3gDSYtcrMVx1zFh4=;
 b=FZfSbTn/9znYZR2pU+I+Dqr6HP0ZJPZa8WvQLTgPF7h5gTWdXMDysxK/XFVkeIjMFq
 2fVSAfy6B2fReaEjU/DuHhHrOoupe5e7etuN9s5lgni61jJ/Ja9Jno5+FSGoy2u4hnLT
 ux6AD9vJ/hx66AEsfKb/A+9LN1QrOnPP0l2snz5il2FLDkd68hzOTA7BYur0YMa7BJx+
 occ24mVqcLmrvw8/bbLUa1X3DDm/peSPbs2aXjxpISmyraYhKAQxhSSddGLdjSpp8oX2
 zyaXQ5ekdXefYOhDbqMxR/+Uw2etXZmtiqdZwunZyIpRPb3Q8Lv99FC5361XRGSikqxU
 xHkA==
X-Gm-Message-State: APuU4Z9TZS85q0sF1wRCdbApY46dEY0VgMYZhzBzNpWWKYCtEIo/KsjF
 aeWaf9PN+pkAxrLxhm9qPue/AC/sW3KQy3n5Je0Eapd6/g2IdXoWmj+0JRbdjA==
X-Gm-Gg: AZFdTZd9azitT0Vbih9rM1/S8jnjWgnV3ohy4VKb8dJ+6JfHOwdmZf0t8qwqyEdKnSR
 bjAhXqyuOWzYq+VybY9B3AXL7K8B46TtS5qjv9hac/bK9BncORy7vcvhL40Uihwef32onkoyqSZ
 /1Ou9LApoKQu6eGhox1JHyt+qXxKfB8zHCnP16+GHzO7RKrahmDfK/bl2ez4xwP+45YFx9gzwAg
 71maU5eSx1UV9In/4oRyzZZSHP5OALg/EYHUO8oaeVUSRh3PpHg84MYWnMtKbIkU3d/aOdQjZau
 elsxNhvx+zmfWDJNfXF1WTFqAhwMYTd5AzQ6blg2T1ODUA4MZWtntMGJAiN9nU6Xy2eSekbT0Bz
 sUm5oihp/5HVilF4qvHTmJr5eJtIb9KsY+v5Pz+DvxFRCP+qT4jNVQ6QRsCEPbI8e39V6hNrkeb
 t8SoiR5z2EO4RVVoQtswfjHETRoPOnQ1ZDF9+GSnbXQQj9mOXWMsDfMNZv482QmikmOpQA2IEbg
 kC9xfYUfQeO4mLvTLG8XjE8FxCI1ytJ7UFV6iXaLYxfU4BLW4BG4O1bMHji4iUvqafBw5zJ5zv/
 aaOr7PS8xScsAqrjzqqMe+Gyj8D4
X-Received: by 2002:a05:7301:4301:b0:386:548e:e533 with SMTP id
 5a478bee46e88-386548ee6c3mr22655965eec.18.1795775506286; 
 Fri, 27 Nov 2026 02:31:46 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:31:45 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: [PATCH v3 06/13] gpio: spacemit: Add SPL support for K1/K3 GPIO driver
Date: Fri, 27 Nov 2026 10:30:05 +0000
Message-ID: <20261127103030.4647-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127103030.4647-1-linux.amoon@gmail.com>
References: <20261127103030.4647-1-linux.amoon@gmail.com>
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

Allow SPL to access GPIOs on SpacemiT K1 and K3 platforms during
early board initialization, including GPIO-based card detection
for SD controllers.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/gpio/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 7f12e39dad8..ac7bd642cf6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -457,6 +457,13 @@ config SPACEMIT_GPIO
 	  arranged into a number of banks (different for each SoC type) each
 	  with 32 GPIOs.
 
+config SPL_SPACEMIT_GPIO
+	bool "SpacemiT GPIO driver in SPL"
+	depends on SPL_DM_GPIO && (TARGET_SPACEMIT_K1 || TARGET_SPACEMIT_K3)
+	select SPACEMIT_GPIO
+	help
+	  Enable the SpacemiT GPIO driver in SPL to provide GPIO
+	  access during early board initialization.
 
 config SUNXI_GPIO
 	bool "Allwinner GPIO driver"
-- 
2.56.1

