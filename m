Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40168606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n42txL99;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcCpSgpI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13765808C8;
	Tue,  3 Nov 2026 20:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dm2MZB4Ylnif; Tue,  3 Nov 2026 20:53:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B14A808D9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793739230;
	b=ls9sS2oORLREzJxICpvqrBAmIjTWllmDaNoP0Nhiq1sYOcnV5Ge4CMcwYbttzcnQAFVk
	 qYbA9NrosDHCpJGOUicMpJjtALd17LoIcQ87XFeg1MmtQla3xcL6mlhADcva7m8aT4eIn
	 OfVmlKsCHbaf/0oMbGjFIUSp3lcoEiUbA7QXlw8X8L3/t2FmAT34GynYPXzBW3K6Uh48e
	 AikvFrB4rIAeRFrD1hh5TOCCTo+L7tas7wUviekI+aWiNthWwHRdAepny07mQ8DyrQejV
	 r4SLEHps6oA2T+gIOZ47jGdNoKhT/+1C/SmVeI1koloP6IAT8xEVd0toYZvdDrAJ/Yg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793739230;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tkbqR7dQF20e024rnu0qt0mKRvLRUPK0SfW2506pVBY=;
	b=glEovTPwZ83k5JK3jvH1APmOnH5V7nHQbZAIapuqnyNHBh/fcctCJVPUi0tquEnt4/Bg
	 TEkgw34Qcg5XCLGgLlIJUoVpeU9/9P9uKTp/OVcrx/NrzYvl9kk0ROQ86e3Eexhfnm6d9
	 /C8klmHcAg1L19HhY7tUbXlDyfNLHsWJWn0ViIE8g87vXtw+LC4PftNexsbsS8gchoprd
	 /a7aySISXpn4z7kci0dDkhc+zgR9CIcrW+YlQ+HoA2Rh3wX5FtNNJu7I35afqpIuSfHrz
	 C0EWjYwUkKdQlLuang0lNlUZN1WZzPcAAcGob/li499aCk8EtQ9imzRFgRLXz/Q8a8w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793739230;
	bh=tkbqR7dQF20e024rnu0qt0mKRvLRUPK0SfW2506pVBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n42txL99U+lQjDjfwzGzQv1Xa0/Ma+K+eGdIKj+thk+LsrjbcROIyRTAlV4hIuKvS
	 SvgEX9L7A3C9n6HLlxeOhnmLHqaI2MApfha0MURwctSbL4jdWN4CgZu7ebcXy5Tkrt
	 iZzuUIlCIK5mS0n29+I9I/FRGpX+ZinKR8cF5Y/ZGfOzyvpSr2StlEOFsRMqFcmmLK
	 JUGzcj6dVYp3YQleZSb5hANRa6O+mgWs42FQRmUuZNmcCIDGhyh7skbYQZ40gunbHK
	 CXn/T1nNZ3L6PwCpZ61bsuKWXkJkmKt+HZFIh8l850EyeHeinZXXZ06xkFxkrtj5Fn
	 0pPXYx6aXA3ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B14A808D9;
	Tue,  3 Nov 2026 20:53:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4684E2B6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 19:36:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C2964009D
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 19:36:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HZetnWH0j3Gz for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 19:36:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4CAEE40062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793734583;
 b=ZTuIcfV7sBxvI2RNbYR6U2OkbCCgo3nXgzv4cKTKHVSPHfkFznsYf8JkN2RkYy90johN
 rqKtZx2HBP26xgfQD7SeX954K3QSLqaKgx0L2QPGf9ijUOFmupA8R8CEmKw03reTr6Z0d
 It0UHL1GCU+jjaISxrL9PgqjyMnExcCHBULNpGmN8vlPg16cTY64CY/el+8ZMFpqnlRyy
 2dmdMKwZ/NatCKi4pCliW0I2iIFTCCU5cjUuwHGfTG1rHIczF70ONMKsvGV5afdk2X1IT
 D7ArSFrpJDim62KVywvnuNMyOysTG2RpxWgjfH3AGMCqkaQmTfYxMKqILjEySknjr4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793734583;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=tkbqR7dQF20e024rnu0qt0mKRvLRUPK0SfW2506pVBY=;
 b=nhsybbcIaGX5D0ce9l9WCVVLygAJmOzxy1EhAvU90gMLDjUeR4ZRGTA4V7R9/LVrqvl/
 FZWLyHnhuQrywbpBnPA7R6qqYatQsMS6vTacW/P+nHrwlIccEHJ4bo1jmL70PJLcrx/Xe
 L67PlB8YvK6dbL4g45EBpveA/oJzq2vgMAGuT7TBmjN9Dg8up2kdUdTUJl7zFdqzKCuLK
 iT9wtN8yUg0BJeawG4YjZR1TPv4iyoEVO56l1tcJnj6zhHUrBrdsjARXz4s/sYYJU+0Ip
 Mn1qon++2BnsoRphHgbokM/ODpkRFab3gKgmh10nT6OzETNxFqIoxRuJ4BsxM5EL5GA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=qcCpSgpI; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=qcCpSgpI
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CAEE40062
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 19:36:22 +0000 (UTC)
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-91c847584b8so13610486d6.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 11:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793734581; x=1794339381;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tkbqR7dQF20e024rnu0qt0mKRvLRUPK0SfW2506pVBY=;
 b=qcCpSgpImF45IB5IZwe+0tarkJkcApI1H37K482x+lcn2ItdvlWpEXo58rbsy5azDx
 Pys+ndMcswSe+6qXzGYIRwMrTUz0J5tLvyTjGg2KAOfnHWboslQOZVwEJaFuKTjorhLa
 Ick8h42JVxLynpoOvJFd/plr0BOQgB7vMdT7PeX64qBbw4Q5Nl8qYrtF7hexpMuOR8z3
 evcQORJJZWmoYk5llcGXxFsoQAK/eI0Yfr9q65AQyZSOwjllzyPimtNYY/fDqAma9ymy
 TvQ+2Y7NLIjh7bmBX2pD7vITHiEg5PfncBbW9m3RSWRtrParlfvFwM7RMfdjc96XPM5b
 4yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793734581; x=1794339381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tkbqR7dQF20e024rnu0qt0mKRvLRUPK0SfW2506pVBY=;
 b=tmYGeZboZXNQdFph9IlBkc3s+VeKh57qhuV7Av+1rt/gUoGgme1D/Wt4EvQv7r6F2Q
 kR4tBQ+xVO9D0uH69n2EFgPiJz6ylb3V4tolmlO7rEYpHxGDwBCz/BHuNGW97103x716
 ZvxAPHr1Ggc0jYl01AgDSBC7H0H7njZ/wU+oNztOxQ2PHXIw5/v5q0kGfjXyvU8zfAi4
 eBylZVQ/p+sDurqq5W9XhYSKNjTHvqRo1jJdaYcva2h8uLlgdiETNKHA+zN5xEL3vlQV
 +ZWkJWgBoC07/DBntSOQ2mLE0dhP3UoF+aoOIwawd/WYFlOua3giAhOVxokZddB2Fk1m
 9dXA==
X-Forwarded-Encrypted: i=1;
 AKwUvByw8ZWmG+j8R2FHQN5//yP6cYLH2FAieQOJEzlF+wVnLbVB0r9kJDwIZYo1tiMRkNc/b9ptDG8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9mbMhac3kChnlwB5I5jCnBEmtN9A9K6QUXDhfv0grndWpRNxpC
 wTsF72Js/2Ku22bEAfSCY2z6b2AtUQuMVGQLSl6rrlns/6AoIsIz2pqf
X-Gm-Gg: AYBFou33Vf8BHnraBywms0TqNwAytEAYdymlCrEGT7BIg6yhepIvNh4ew83ApMmWM51
 mDPY7aMMvSeRv84++Mqb330cpfJNGlS5nYcYSpN3olUXr/BTAMELivmZ8vEjkLsOYvsXtCUKn4W
 D4Qt1kJCa0TDRlhvjGJI/ITlggW+t4IkDpumyJcNQS8kBRnawZoDqX25pw7sckveMKWpOaigFmI
 vgOKrR33VgykPOVnG4iCnqVPdWZBKC9HvxgB0Uzh7Tya+aNyahzoNQHz0u+IsxQ1+CSa+yxBFWY
 4CCefVGg5KArNOnTXcl3Zh6eXJ4Zzn4S5ctSyhjmkdDZp/k/qC3tSbxP7rqNgpJU5gzRfB9OvTg
 MqC4gHY8uKpSp66k3whiARHwVGLMw8Ojnn/K9UKw+lX4HSILF8W3VvIHuBOf3PFqR0SuIxk2e+Q
 G38L3WinUPBINU4J/vecfBoC6nImApZhRliFFrEbvYeBz15wzpc5+Vj1RP8OyJPDroJmFm4o/gP
 CDEaEIMUqqr7jXWE60+qUb7DuJAWtyAt1jMZPEBzqQ3+YseZ/8iR5rkl/W6RKuYI02C1Sy4CqAU
 Ve1qORcAt0fE0pdjES1clnlB5qxEvNw3F6klgT+Wa9ga5E60bgRg
X-Received: by 2002:ad4:5aee:0:b0:91c:61c3:c044 with SMTP id
 6a1803df08f44-91c90633d16mr282590616d6.7.1793734581360; 
 Tue, 03 Nov 2026 11:36:21 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91e7c702d59sm1094456d6.23.2026.11.03.11.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:36:20 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v2] dm: core: Unlink the device when bind fails without
 DM_DEVICE_REMOVE
Date: Tue,  3 Nov 2026 14:36:06 -0500
Message-ID: <20261103193614.1250525-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026030925.1002846-1-oss.patchbox@gmail.com>
References: <20261026030925.1002846-1-oss.patchbox@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 20:53:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

device_bind_common() adds the new device to its parent's list of
children and to its uclass before it calls the bind methods. If one of
them fails, the error path takes the device off both lists again, but
only when DM_DEVICE_REMOVE is enabled. The free(dev) at the end of the
error path is unconditional, so without DM_DEVICE_REMOVE the freed
device stays on both lists.

DM_DEVICE_REMOVE is disabled by default in SPL, and a failing bind is
not unusual there: lists_bind_fdt() takes -ENODEV from a bind method as
the driver refusing the node and goes on with the next driver. For
example cadence_ttc_bind() refuses TTC nodes that have a #pwm-cells
property so that the PWM driver binds them instead. Any later walk of
the parent's children or of the uclass then finds a device that was
freed. With the simple malloc() the memory is not reused, but the
refused device can still be found and probed through its uclass; with
a full malloc() the memory is handed out again. Sandbox built without
DM_DEVICE_REMOVE shows the latter with test.dts: the first driver for
the multimatch-test node refuses it, the device for the next driver
gets the same memory, and the boot hangs in uclass_find_next_free_seq().

Build uclass_unbind_device() without DM_DEVICE_REMOVE as well, call it
unconditionally on the error path, and take the device off its parent's
list unconditionally too. The remaining clean-up, which only frees
memory, stays conditional as before.

Fixes: 5a87c4174d18 ("dm: core: Drop device removal error path when not supported")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Changes in v2:
- Build uclass_unbind_device() without DM_DEVICE_REMOVE, drop its stub
  and call it unconditionally, instead of an else branch with list_del()
  (Simon)
- Mention the sandbox hang in the commit message

Tested on sandbox_defconfig with DM_DEVICE_REMOVE disabled and LTO
disabled: without this patch, booting with test.dtb hangs in
uclass_find_next_free_seq() while binding multimatch-test (gdb shows
the device of test_multimatch_second at the address just freed for
test_multimatch_first); with it, sandbox boots and multimatch-test is
bound to test_multimatch_second. 'ut dm' on sandbox_defconfig gives the
same results with and without this patch. On xilinx_zynq_virt, which
has SPL_DM_DEVICE_REMOVE disabled, SPL grows by 70 bytes of text.

 drivers/core/device.c        | 10 ++++------
 drivers/core/uclass.c        |  2 +-
 include/dm/uclass-internal.h |  8 +++-----
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/core/device.c b/drivers/core/device.c
index 6024534ff93..08edba62d96 100644
--- a/drivers/core/device.c
+++ b/drivers/core/device.c
@@ -201,15 +201,13 @@ fail_child_post_bind:
 	}
 
 fail_bind:
-	if (CONFIG_IS_ENABLED(DM_DEVICE_REMOVE)) {
-		if (uclass_unbind_device(dev)) {
-			dm_warn("Failed to unbind dev '%s' on error path\n",
-				dev->name);
-		}
+	if (uclass_unbind_device(dev)) {
+		dm_warn("Failed to unbind dev '%s' on error path\n",
+			dev->name);
 	}
 fail_uclass_bind:
+	list_del(&dev->sibling_node);
 	if (CONFIG_IS_ENABLED(DM_DEVICE_REMOVE)) {
-		list_del(&dev->sibling_node);
 		if (dev_get_flags(dev) & DM_FLAG_ALLOC_PARENT_PDATA) {
 			free(dev_get_parent_plat(dev));
 			dev_set_parent_plat(dev, NULL);
diff --git a/drivers/core/uclass.c b/drivers/core/uclass.c
index 5365ac68f9e..867db8bc20d 100644
--- a/drivers/core/uclass.c
+++ b/drivers/core/uclass.c
@@ -751,6 +751,7 @@ int uclass_pre_unbind_device(struct udevice *dev)
 
 	return 0;
 }
+#endif
 
 int uclass_unbind_device(struct udevice *dev)
 {
@@ -758,7 +759,6 @@ int uclass_unbind_device(struct udevice *dev)
 
 	return 0;
 }
-#endif
 
 int uclass_pre_probe_device(struct udevice *dev)
 {
diff --git a/include/dm/uclass-internal.h b/include/dm/uclass-internal.h
index 9cb3f090271..e004e911a02 100644
--- a/include/dm/uclass-internal.h
+++ b/include/dm/uclass-internal.h
@@ -267,6 +267,9 @@ int uclass_bind_device(struct udevice *dev);
  * Return: 0 on success, -ve on error
  */
 int uclass_pre_unbind_device(struct udevice *dev);
+#else
+static inline int uclass_pre_unbind_device(struct udevice *dev) { return 0; }
+#endif
 
 /**
  * uclass_unbind_device() - Deassociate device with a uclass
@@ -278,11 +281,6 @@ int uclass_pre_unbind_device(struct udevice *dev);
  */
 int uclass_unbind_device(struct udevice *dev);
 
-#else
-static inline int uclass_pre_unbind_device(struct udevice *dev) { return 0; }
-static inline int uclass_unbind_device(struct udevice *dev) { return 0; }
-#endif
-
 /**
  * uclass_pre_probe_device() - Deal with a device that is about to be probed
  *
-- 
2.43.0

