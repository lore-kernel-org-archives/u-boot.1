Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E776606A32D
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TAMLCMgL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X3QYEg84
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F0766063F;
	Fri, 13 Nov 2026 15:08:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p0XoaFwmISY9; Fri, 13 Nov 2026 15:08:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 138866064A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794582496;
	b=NUw27xyTnI47owVKPLT/b4OYeYwuXxLlEoCiGIJ6gOLbER0uRI+z7fVrVxVBmrdQWqVr
	 7Uh7qLq8+FyWDhJp9HGYijKyorVwUgt/3u3dLFu5drJj75MGkzT7xoDny/dftzXTOVUD+
	 zv7Gdp/08aPc0xSRVKXfrMTJjMeGwJWDAUlP/YUDRomD7eyD+ZkbQDjljG0qG+BpzBIBv
	 /uaYuQ4M1O7RwBW1v2L/aNSkcsgtCwJGoaq4UCoxVv+IQpApT7eForL26LsmQAqVlk6YO
	 qxKsZOz1OQ1LuLQyGJIkyMypw+L10HaiaRU44kUPgcqBYK003abSeZy3OkWIcv7icpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794582496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=92jnREwNGJyIyosYa2H+Q5mlCC3nYLzQjH+vf3l4wAs=;
	b=A570FHTKQw50gCzKE6MOOB2aN2XKogA7Tx5pvsoZGn4oa4xne9RTSJhfjKO/FNEf+xgk
	 pSPoQOh76nZtTMUWtXM4f9Ux5gYbfQ1v2TPS+SKyOq3UGC5BG1OYay3d62THuwmPgFuzI
	 +FskpqyIa55icsUWq5KrM8V9lRhTKqy83Gz1pW5ftKL4xF/EwF6eQ/O0Hu5KjwdKebWJS
	 sFVe+K1EUwUQC7mB7Cz+Ri7YMpDd4VxsP4STAZupcKBcR/Xj3gLQ/VnWQGdjWLDzGrCwA
	 JkjvFP0l99rBL8yrOTNaUAXYWPw0ewyHxbQI4hff7o0M7SkiobxDyyNraopWoAR6Y9Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=X3QYEg84;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794582496;
	bh=92jnREwNGJyIyosYa2H+Q5mlCC3nYLzQjH+vf3l4wAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TAMLCMgLIdQMGsXXxus2PR+L3EoHs6p8Sf4vTxt8yjRYInZHX2YOr5MtSJh4thO+R
	 mCKwQAsrtkrjXYW1i7Apo0I+mqTXAs3YerNQQJimcw70uurnZpPLRlBmymlGb/Rdyd
	 UfQFyfPF4n6DpBOkNv72vySPYRwcvmRd8Uao3aw2K+tRrRVGYJ5pA8qJs5FM1oeDV9
	 0HnvREHgrR2HaLTG2eCx4KJRhW64VycY0RkB8YXHhWNXTBSIVnULbvUSgMcUTTvSlv
	 9bQbETQJdS6N/GxyIMnol3ambvzDETcGIgsBfIJMDbW+z/ZcMeUFIxav4UvtsWbS4D
	 l3PvP4QjfHXvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 138866064A;
	Fri, 13 Nov 2026 15:08:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 72CEBAF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 646EA6064A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yu-SJlS2OmOl for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:08:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0435F6063F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=X3QYEg84
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0435F6063F
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:08:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74BD61516;
 Fri, 13 Nov 2026 07:08:07 -0800 (PST)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.129.4])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B29603F85F;
 Fri, 13 Nov 2026 07:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794582490; bh=xOXcIMlAFaqcJ/h64+EmUe1/BqOVY98hp+GHht5mHLY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=X3QYEg848ZPrcy+nF2Z61PLPMFibKa9kU9C1ZTcXqlzUbO/v6YOWYTVqWE8hXH/IV
 YT3qg9w7D/LEaQLzMYRefr5epaDKeqJAjm8skMkBmq35zaQPcNqMnc16AlZFgsjBNi
 ZbaSvdE4Q5qaMendPaEGakgWsaumbyGuwlIzr15Y=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 13 Nov 2026 16:07:56 +0100
Subject: [PATCH 1/2] efi_loader: prevent set_variable() to record append_write
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-append-v1-1-4cb63d522562@arm.com>
References: <20261113-append-v1-0-4cb63d522562@arm.com>
In-Reply-To: <20261113-append-v1-0-4cb63d522562@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1401;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=xOXcIMlAFaqcJ/h64+EmUe1/BqOVY98hp+GHht5mHLY=;
 b=kA0DAAoBy0n4VnajBpQByyZiAGr3J9ihkRpCi2x7t6Jk/hDVDd4ApbJKagMayTDYJPRnhuh4x
 IkBMwQAAQoAHRYhBNdgFKCOWlARcHgqbMtJ+FZ2owaUBQJq9yfYAAoJEMtJ+FZ2owaUgIAIAKn4
 5VSJVUuA+9sJtXqZU8aldAMt6zaQw/ww6BHypAgTGgTMax2VNGboxq+haqoulPL7AXgiyOUk96o
 EM49yPAZnoh46qExydMpApBP7upQuv1lj+efPxUTG10Y5BLQzO+5d/F3kt8PKDu6wub1Qj1v+B/
 Ao8N0BPjg5xjGHGXChyeSVmSilkDQvCMcbaWPE5X8KL+dRSvso7w+PgS+PUSIuUXlEU678DhpDf
 6UQAKZXeewNI8XndV2KzM9vCGpiZkbpUyD7QAcfO9Y+2JFEZ0nEx5ugs0o7u/xRYUK+3HteB+lz
 lGgHWmZEFXTXb4LQqzZ0pXlTnK8kfgpGpjHkmw4=
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If SetVariable() records the Attributes bitmask with the
EFI_VARIABLE_APPEND_WRITE attribute set, this attribute can be returned
later on by GetVariable(), while this is forbidden by the UEFI
specification. [1]

While the non-TEE SetVariable() already makes sure not to record the
attribute when appending to an existing variable, it forgets to do so when
appending to a non-existing variable; fix it.

Link: https://uefi.org/specs/UEFI/2.11/08_Services_Runtime_Services.html#getvariable [1]
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_loader/efi_variable.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 9923936c1b5..8bf2c91f3f9 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -384,7 +384,8 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 				      var->length, old_data, data_size, data,
 				      time, &changed);
 	} else {
-		ret = efi_var_mem_ins(variable_name, vendor, attributes,
+		ret = efi_var_mem_ins(variable_name, vendor,
+				      attributes & ~EFI_VARIABLE_APPEND_WRITE,
 				      data_size, data, 0, NULL, time,
 				      &changed);
 	}

-- 
2.53.0

