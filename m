Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447B6C982D2
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B78981129;
	Thu, 17 Sep 2026 17:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tNqkp8VQ-Htr; Thu, 17 Sep 2026 17:20:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2A06A810FE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665610;
	b=OJeHkdntNFHVLfjeapSsz8S8RFaZad7NBFYfBYhgpsPFIYePpOe4yh2f13TzAMBPc58B
	 udoD0FC7CwtW31npErfuILBA4munv2oTFNV5fZ1PGFuupy3NRzFNJnrsQ6VniLndwxmTk
	 PuocVI2Gn6LNf3C1ZGuUfts8st5SsA5SHl8CATuxkI31SXY2UYdzbL8vRojkQ9C/Y7m1P
	 6SXv9bW4r9nQn6gtrfzIjGfqoDAczE1HIW33cXSegQVmu6Yj3dIk2TGbfjo2TuZl93Jic
	 6lIAgxvP2zSniU/Mm592EKdGlsx+p4OV8q7ab9uE6+nnhQpk8e9lvU4Jb6AFBZfCZ8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665610;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LXMtJwYk5KN/sFcgW9APqgrNQXm6mBepJcfSKbiLm5A=;
	b=iGg96dQlO++kHa0dZtj4qX8qDSKWvwE5QYb6kobAKGmizEvBofRRc7niARz9RWp9XCu5
	 YfFJ5sjfetPRK8m/2UtC0WEz/eoL9EArjCJ0wqay5kGYTe/mfXy9hB76hask49NgJ+l44
	 Z+Xn2KtAeZ99KqswvghV4cHlV9N0N0fupWU2Zv98H5SsIictN5bFh2xpUM6xKYR2ATY3X
	 6xtw41bqIA3UX3j70B2oMh1DqEF4+WOHWO8/UQ3Tt8ffMX7W3FRpmzRoX75rp19ZF8SEo
	 hXFwnYJmDPSSzra12DFALOu2Yu7UMuAIsjZsFcgkV4bb1SmaWAcdwy56srEscX81FVQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665610;
	bh=LXMtJwYk5KN/sFcgW9APqgrNQXm6mBepJcfSKbiLm5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z6KgKSmGvE2jDtLjtLlegNVjwaDwRkloMXx7a7mmYyseIO2ydaC9NnROhap3cSOrn
	 cQNUljqXrdY22EXLwdd+W69ooOZCblUZBLeOnPRkevNrrR3t5GcfsSRNrFbvqj/4wU
	 YpTHhXw53A/T4Dn6lyLuaw4VFk3jvTnkqTZM+Tv4l6CeyJoSqvqsvIlLmeJCay9PkJ
	 0fwV+dTjQIcVwzN7YpYHqRiyvxrfwVU1PBRrbStOQiOkExzamh+8mFJLWoNgSGs/jT
	 1boX0g+uigFapiX+Gtft+ovS6uTJVVjAfJ2itF1RctWWczU7uxFC/BK0uWsy5wuQbj
	 h8xJVQ0SDwgqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A06A810FE;
	Thu, 17 Sep 2026 17:20:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 404463AF
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 264B760B58
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rNkRJ7fzNkSG for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:19:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8917460B2D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665550;
 b=Hm9J5PYbZgDnwaTzBLCwiHOTn5axhZjn3kDpvA5w66FW4MQ5e1pP6M+ntosbseYcRKFy
 fqLCvFtDI87HMZRKRxCBGG0rfxnWkK1FA6LElwMVMnjyaDhndsEaBjpS+SDwUPaSmn6RR
 6LiOlrwsTLKqFquQmfrDJFLjKzKoHrW9sdzEpkyFEGDwZW9xNWM0EXFL6VWbRkHjcPOzf
 5HlaOPpblRmq+YRTR+wsL6zz5uC0bSjPOpnoRn2sCQ3SBrC0qi4gu1+dsWfGjHgdfKm1z
 FJ8CpdkrA4hYYuoYVL+FEEklZG+sv58hHczZl8kk96Hj/poY2D0km2+7QEJtVPzBBhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665550;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=LXMtJwYk5KN/sFcgW9APqgrNQXm6mBepJcfSKbiLm5A=;
 b=fNt2zubvmI2IeVflEyGYvU9vgt1hiIJfeg5Y+wJv0d5KTD2iUgWW3KJ+errh46ZD3pxm
 daZowWF12WhI2RcE904lUz/JXTA+Xvkz4pQoaUjtv8vjL/tmBfsOa/NCIXe8SETynU8Q9
 xpH+FQmADkzkAP7kV6OIfjFjxLrmWVVBtCnr2cbDlYErNPDEvr/ypowSKQrbixD4pcBnr
 IE5TSXS0Eqkiv/SjKKZBAUX3FbZYkIOQJ1IXhNzN4wNC/1+lRWlw/DDUD7kFLM8k1gSLf
 rD1LHPSoMJYPorbjVVn0IIH7XBtq3HzZEh4vNENwD9ASXjpxfKuT0tdrIP28Hnti5tQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="WaglLJf/"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=WaglLJf/
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8917460B2D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15BB41F91;
 Thu, 17 Sep 2026 10:19:06 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 404653F7B4;
 Thu, 17 Sep 2026 10:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665549; bh=1kRZhqFyVfyHUTgIVBFeWrxlqF5IDcOy/UUR/ityVoU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WaglLJf/LNJ8JQ/ns78L/tGbtnoJX9MrMJMTUe7R1yWxQekGnlUvp1zvVs1qaON68
 bHhCk3DT0I7xEqpG0nJK6WilGzW+uSTp9pqLB6LrXsPpEhNxScqRTkmgjtJb2WzWAN
 QLPHUYFaGxnL5bwzi0ayol5XmdfbC484+1Fb3PlQ=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v6 18/24] fwu_arm_psa: Add ExitBootServices() notification
 handler
Date: Thu, 17 Sep 2026 18:18:04 +0100
Message-ID: <20260917171810.4122899-19-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:36 +0000
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Provide a weak function that can be overridden

Some boards need to perform custom actions on ExitBootServices()
related to FWU. This function can be overridden by the board.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 lib/efi_loader/fwu_arm_psa.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/efi_loader/fwu_arm_psa.c b/lib/efi_loader/fwu_arm_psa.c
index 20e4fdf9b90..6ef11c3101e 100644
--- a/lib/efi_loader/fwu_arm_psa.c
+++ b/lib/efi_loader/fwu_arm_psa.c
@@ -1263,6 +1263,19 @@ static bool fwu_all_images_accepted(void)
 	return true;
 }
 
+/**
+ * fwu_notify_exit_boot_services() - FWU notification handler
+ *
+ * Description: Some boards need to perform custom actions on ExitBootServices()
+ * related to FWU. This function can be overridden by the board.
+ *
+ * Return: EFI_SUCCESS on success. Otherwise, failure.
+ */
+efi_status_t __weak fwu_notify_exit_boot_services(void)
+{
+	return EFI_SUCCESS;
+}
+
 /**
  * fwu_accept_notify_exit_boot_services() - ExitBootServices callback
  *
@@ -1291,6 +1304,8 @@ static void EFIAPI fwu_accept_notify_exit_boot_services(struct efi_event *event,
 	}
 
 out:
+	fwu_notify_exit_boot_services();
+
 	EFI_EXIT(efi_ret);
 }
 
-- 
2.43.0

