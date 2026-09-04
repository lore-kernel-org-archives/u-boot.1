Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5119C79F82
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 15:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19CFA80FF5;
	Fri,  4 Sep 2026 15:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tktm2OuRHIeO; Fri,  4 Sep 2026 15:58:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 79C6880F90
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788537523;
	b=eNGwJ8+4f5zyDD/u9p4yGOWfWaLVVbFE2E4KWEtmxGhEjuPHbAfOKLQz+B/OUPR5eiG/
	 4bO7Eu49LAIVBTY07XNN1jQvjuWPOvOz1wpcqOYNrPjZPO00I4XaOhCEA7ncHqsF3jnIx
	 Nrk3+L3nDJnAH6rilEzZk74IdWSax+myGctQV6v+Kcn/OnoWhOpIhlbc+kFBQDkZu8pYe
	 5Nm8XJKqXRpzT5ZiKBHmu65uer3jlvuGCG9/4AUk9SoKs+3YCEWp8zrENiQUI3Z3XJlVO
	 wxK0MJ5Z6pHXLNn0wD+4UGsGaKBHnOZlQzPk/IGElpnE++pZtjxPUvhJctswnKQrmxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788537523;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DiDXYprBZhEMzIHUvoofEZmE61fcfR914DU9wQvONqo=;
	b=tVqKb3lDUfsWDUunmxo8YxCOocqy+1r5jrr5dRoav9SxMrUUjF4esCC7rBBZecSg4DMZ
	 thfsFsE/mSBHsQT2S2IKsXTQy60+C0xHttS4W+wLwpxfrJ07cLn5ydt9T4th6lS1ciNUq
	 tYHDR+nsmhSk421zQCn+Y93NOkH9+RSoCi8wpWTvvGiWr0f9UEIHXVU+6cbqTJ9xNjZQN
	 BaUG5RarhsW5CAUjAggItM8AoY+aVdkuwz0z7FqDbhDK2DTIB6lsvATgiispkWDuyLi9q
	 JJJ0fb4ahqyX7/O/9mj4P0KR3mwzilYSbL3PhBu0x/5mUwCGXscnyAe7lW6FwZfMLEg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788537523;
	bh=DiDXYprBZhEMzIHUvoofEZmE61fcfR914DU9wQvONqo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nxhTZX3WbAetkCQ6UX7J5XG/V1h2ensjhQAS5/InOt3BHX/Sd67CgCPS22bNpLS1q
	 aCxH6H5bIHIifkh9AEge7TPr1ZqMqRvvWyu7FLtSlyBiibNDWLDvMqC1rS5Bhj/1KQ
	 8H/7ocKfpvNj/vn6YDOPtFYIy85VsnYz2fewINvWJt0nO13fl3aOa2uo7JqKvnzrMV
	 fjIPhBm8aGKQsmXeV3WotfvVofL4tAE9/e5ISGJ95Kj5gMxqJswMX351c2vmYUhYRU
	 DfZvdg5CY8weaKdGb5Y7csxG/1IOJWJKmkz3lzBQQtSKjxVtV3IPW3ubaZUcycVhuM
	 K9FB2CU8XZq4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79C6880F90;
	Fri,  4 Sep 2026 15:58:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EC002FD
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:58:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5070260B68
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:58:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bM4EhCme3AWG for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 15:58:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7912E60738
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788537521;
 b=WQ+qEjPnp7i7/C8FrmWBT8wS8YGco+SbB3vltlYjywen71zsLHo2wHkxYddrqScUYtZC
 KkTn6Zn/4RyJtY9GNSeAVr3Lbr1CCotwwdYK+hQd7uBzWLh4/Wg/wd0csoQi/cQkmG+Vt
 0vW+0zuPWA5o4iDOcG9UhDXCyvEn1vX0UW2ZDNtsADwmxEYbHzqO+Mf7kM6FkQBRFkaG8
 0DNVxIo5Q/kzbXS1QQy3b3CVtKixw7B39M9Xwwc9EXfmXb3VVntaSs3yNTqVzZbzaGiMT
 TEFkpMrGNzRf01unZA+IoQ7Yghv1zCC0BQ027oqCeLzetKrwsuchG8Xk0bSbTqNcB3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788537521;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=DiDXYprBZhEMzIHUvoofEZmE61fcfR914DU9wQvONqo=;
 b=Psd4PFqR+tVU9XDQR1aCjtucMT5eXgMZhmmXRMl+OFgHBpDjbcKcqPmU+KLbgW1vpu/d
 i6CqVgOAG68C4s8l3jMfbYr3STz1kCTZTwaEJwUwM/Hm3eYpyIgjmjOtUcPdFzeHuPc1v
 WZ5p9urG29+d4+atrRnQxWCMX8CZUYMbY0UphfZyK+XT2Qk+AYagcgmj17DJGUCk0Whg1
 NsHmX4ok9DNDv//WByAWbybrw/n+Z7GkxVxioxNaMqCn/KH3OR3Qg1twhceR4JEcGgdZF
 O1pAgAfayhKXbyzV21XPpZKVmPF3Wn6ZpnRp6+aW7dCpgS9pkVTeqQJAwfZYgXIkcCQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="XuDG/d0s"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=XuDG/d0s
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7912E60738
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 15:58:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E771B152B;
 Fri,  4 Sep 2026 08:58:35 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.49.254])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 550AD3F7D8;
 Fri,  4 Sep 2026 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1788537519; bh=p6C02JZoYil+avjUuWyoQH0nJXowL4qU9ysE0Rz6PW4=;
 h=From:Date:Subject:To:Cc:From;
 b=XuDG/d0sh5X04WcPzapWZpJT7tUchCrC7xOlHQTnLYl33EPb9wjT0sOjJX4iFJ6/V
 RruB9p049AuNarz2jZNQSJLt9g5zCjyaU+f29QZxCRvpLGUoQLR+m5JU1w6mv/iwKh
 UmaEO1BTNsREaIv8vtxHoc1BQtrwNfp6cxZ7l0R4=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 04 Sep 2026 17:58:31 +0200
Subject: [PATCH] efi_loader: remove unused function efi_dp_match()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-dead-v1-1-2ecf6ffe7bac@arm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwMT3ZTUxBRdQ0uDlBQjU0OjVJMkJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tANxGyFdoAAAA
X-Change-ID: 20260904-dead-190dd2512e4b
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2659;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=p6C02JZoYil+avjUuWyoQH0nJXowL4qU9ysE0Rz6PW4=;
 b=owEBbAGT/pANAwAKActJ+FZ2owaUAcsmYgBqmuqtroMm/3+aSIx+dpFtRquGhFOQYZFnMX1o5
 LHtLmxcV+CJATIEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCaprqrQAKCRDLSfhWdqMG
 lIVXB/jAvz9G04o/zLp/kIowZrEs2CcsAc6YOw+Ipk/JvLQJ0QRWlYMAAjxxa4LTKLSXAo6B6Ms
 qOz0YUwZ/PEyX10aIz7psew1U8/WLT16fFa7ITmp2PuqKp5zxaUgtSePNxXK4+fwDq+UVDT/K5f
 daERjhi6tE8QtmJi8zMbR3OHgKx2NLyQiY7nolmWjqHi2g6yv+BuTGZhpFtYwwi22ZM3mevQzbU
 MbWQUv2M3s6dMI8waN2NY2rmT82S9Oq7i5/zNhl9lMehEreHcZWmktmri6YriJqjQ308kisCcm7
 O2F+lgvlKfw9m/KSUiE0zEEqu0unZLib5dvzMli+lA17D7w=
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

The efi_dp_match() function is unused since commit c409593d0853
("efi_loader: fix efi_dp_find_obj()"); remove it.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 include/efi_device_path.h        | 19 -------------------
 lib/efi_loader/efi_device_path.c | 22 ----------------------
 2 files changed, 41 deletions(-)

diff --git a/include/efi_device_path.h b/include/efi_device_path.h
index aae85228f68..034a476887e 100644
--- a/include/efi_device_path.h
+++ b/include/efi_device_path.h
@@ -33,25 +33,6 @@ extern const struct efi_device_path EFI_DP_END;
  */
 struct efi_device_path *efi_dp_next(const struct efi_device_path *dp);
 
-/**
- * efi_dp_match() - Compare two device-paths
- *
- * Compare two device paths node by node. The comparison stops when an End
- * node is reached in the shorter of the two paths. This is useful, for example,
- * to compare a device-path representing a device with one representing a file
- * on that device, or a device with a parent device.
- *
- * @a: Pointer to the first device path.
- * @b: Pointer to the second device path.
- * Return: An integer less than, equal to, or greater than zero if the first
- * differing node in 'a' is found, respectively, to be less than,
- * to match, or be greater than the corresponding node in 'b'. Returns 0
- * if they match up to the end of the shorter path. Compares length first,
- * then content.
- */
-int efi_dp_match(const struct efi_device_path *a,
-		 const struct efi_device_path *b);
-
 /**
  * efi_dp_shorten() - shorten device-path
  *
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 9efb158f5dd..0389af23906 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -60,28 +60,6 @@ struct efi_device_path *efi_dp_next(const struct efi_device_path *dp)
 	return (struct efi_device_path *)dp;
 }
 
-int efi_dp_match(const struct efi_device_path *a,
-		 const struct efi_device_path *b)
-{
-	while (1) {
-		int ret;
-
-		ret = memcmp(&a->length, &b->length, sizeof(a->length));
-		if (ret)
-			return ret;
-
-		ret = memcmp(a, b, a->length);
-		if (ret)
-			return ret;
-
-		a = efi_dp_next(a);
-		b = efi_dp_next(b);
-
-		if (!a || !b)
-			return 0;
-	}
-}
-
 struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
 {
 	while (dp) {

---
base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
change-id: 20260904-dead-190dd2512e4b

Best regards,
--  
Vincent.

