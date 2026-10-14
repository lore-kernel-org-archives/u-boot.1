Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E13FC3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 17:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A334860884;
	Wed, 14 Oct 2026 17:47:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dR0th8ltO4il; Wed, 14 Oct 2026 17:47:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5432260855
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792000043;
	b=jgIgwHAaVMHzQJF3bkhD+alyyvnEa+AHUQKya3r9h7CVQcWpVbS23vZcvnFYgtapJCDY
	 8TD7AwuVNiFjqw4/AvbuYJV8LuFD89E0feb7Kn3VLKKAkDFaSP7E3RQcyCCWj9MAf4pZU
	 tnbKuLuPsyAQhejfuSU7M5L3o+2fOLyLN4GU7udDciRxq6kwdExsUrXIXunDpxhKr0wO1
	 0Uxq87gzmf+T9gIj53rMQLmyCpzqWvPsyKolDJekTqStL+3oQ0jJKt9g+lGeLl7Ne3Ogz
	 aG+njw7cfWUC7KBxcwbxMO5PxNWiW9aX7J3CwYpAGIfZ4KffbmotKp+wc+6eUZqMzZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792000043;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C+nqQw98KSiRXQjJc4eUiuVl+q6vuC5rcxp+aESKs6Y=;
	b=cZSJk3OiMq8QnarrUca7zT+eN6taKalicvgnIBx49Yosk+Q7Tu6a9F5sAGQ8EI+bloy2
	 DMtgXqNKKzr/P1uVhhCk63ECYByAC+ccFRsf8VfpxDZm/INmndJi3gO7gzA4fzvKXArIA
	 x9RwBjvatgEP36g0y9zPY2Z5NCDM1jcXeqZxyRRhmMKCAPHHYy9NDHSyWNwtVB9ON0khV
	 OjJA2/S5HvWB6aztJ8FHx6XXQP4dwUFxV1uqvJN5oi95aQqKq6GPWin9oV+Ou0pYFs6Zz
	 DhhAV2ECctsvh+nQ4o3wsBG7dpCz49Idl8BdMuAvDdj59eAm89jHHGxNc93WYJb8dtQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792000043;
	bh=C+nqQw98KSiRXQjJc4eUiuVl+q6vuC5rcxp+aESKs6Y=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=unAQPoVTVExIf9q0yorm5vrNboKVRG2a1HXx2u1AZUq5Im/HyaMLKzwUspTgEDdp6
	 79Em3stwpgijcU8Q6Afebbh68UNIBw1cImuhob7KqbFO/hck+FRV7LFKnz6uyfiIgV
	 vdr4vNoILwuCRh6iEfzOb7oJOiO61PY4xvloephDP8pbwJNTPGrlA1he5aIGOLCpuD
	 pZ56OYEYQU69AE/uoSiXQpYhK99yG6AqbNqvEvforySWqYUBuTrR+nUN0dzmgKX6U0
	 jju/egWgFWYeNnzwUXqMcvJuq4dhEoBkBenXWa4ifOG6kH6OHzUqH4W2yJLU750Csu
	 8Z4frbRSKJKVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5432260855;
	Wed, 14 Oct 2026 17:47:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FB46A58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 17:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 416034016F
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 17:47:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yc7diCEgch6Z for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 17:47:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 86D4C4009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792000041;
 b=fs+QIre8PTtfmprkVfMjMHfPFC8WwqZtYOjz/+fYLKlT/7UTPA83uCLs/NleVYK4qLJY
 Ul7UYew2llxukybO5jsRnm7vPsGLnL0/pwC64F8kck7UPkbzcIOtLlJcc+CrIgtCw6WAH
 hoMNMvpp8TvKbxqPr7VeNoOwS57Y95cB82hS75TlPY5uHZVPpD9uKD2hD3icZp07bbEzw
 RKBENkIwX67H7V4DpY4B4t9wniTpY/57pALntrsnFKM78dOwlCUmzw5YblU0L13q4hKlS
 7tUGI7PxGnqwJJppKj6ciugt4kJTQQf9eGJNs0vdU1v4v1K5QW3nZtR1pBIrxWGFE1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792000041;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=C+nqQw98KSiRXQjJc4eUiuVl+q6vuC5rcxp+aESKs6Y=;
 b=I1l9CX3W5rw5hcR4/81YggE1TW3fUOE/BM9qbo0PtWbdoX6gZE8foF+68BCcfAm2PNYn
 0E9Zl+JqxRmkrLQPiHmgmWp7ndhQDwtKjFNC4xQv3yUTWs5ITsueNGaORSKqeuhXiWM+5
 9vMmi5hxPk5wpypL2ehW9xGwNMVuaeCU+fxAVMWi4FtZjKCgQpByEFbubwfOpPp9sMF4v
 rr74rYqhHun44chATk9GVXiW0QC+6GYdYfk7nbVEAnpWLAzAz/15IpBurE5epCkPWv2rh
 +xR21Fwq9Kc9/SU2rQbqZDb4ZGt0afbHEEkymnmOAiAuW4IeUumh8Etx3d5CeaYg7Dg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=ZzWX+HU+; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=ZzWX+HU+
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86D4C4009D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 17:47:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58BA51516;
 Wed, 14 Oct 2026 10:47:15 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.arm.com [10.34.125.5])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 255063F7B4;
 Wed, 14 Oct 2026 10:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792000038; bh=Xr8lLFUSAOKvcf6SQ9X25uRPE9E/dy3NOaqvc6QlOOE=;
 h=From:Date:Subject:To:Cc:From;
 b=ZzWX+HU+wcBKU9V4j+Jpftko1mHhWSZkdN52sEW2Ze8oikEHgpfKO6u5X1plKKOKS
 SRv+ZDXHvk3C5e925cbKjrgBw6OxN7Rf/IhOTVIxLkb6140J9C/hTnvMbenOM8dmDi
 M5r2RYo3+jKKvhAsWeIG68uohmOLeuMiZDG4HPAU=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Wed, 14 Oct 2026 19:47:16 +0200
Subject: [PATCH] lib/date: prevent out-of-bound read in rtc_calc_weekday()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-wday-v1-1-d6a45cdf7c5f@arm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0MT3fKUxErdNGNTU9PEJAvzlGQjJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAKKIRploAAAA
X-Change-ID: 20261014-wday-f3555ab87dc2
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=Xr8lLFUSAOKvcf6SQ9X25uRPE9E/dy3NOaqvc6QlOOE=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqz8AlRyQ6UX7veciSZC697uN94Y690eJw6YuRL
 bt6WMxSRJ+JATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCas/AJQAKCRDLSfhWdqMG
 lFrBB/9NrxDfTRDmn5Ie9YHZohpPSqC4kglGgcwE6olTUgKV/9d8pIp0PKzoyX/kO/9z/qroZcI
 nDv8IjyIvocO7pADb7V2OuPtiPC4J8lZadgDCroUgwaqyY8ZitIgOppEPGvCl7YPsMWJnlWnlTo
 Tnl/rP1yyfEMFqpiPad62gH5SghSVUytBZIke/wySWkgPj8wHMrqyPv6spcnhAeFC18IgtKAP0x
 XfyndE/cDbAtBJiNsURE0QrkxouX9S1++IHMo7OweMm+YriqBX8/Nplh0sm+oT4JLn3ASGHR+20
 0uK/7R400q/F6bkLqYyDtZH42tfKvb75oVFRSKgFEZ9EeE79
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

Depending on its input structure's tm_mon field value, the
rtc_calc_weekday() function may read the month_offset[] array it uses
for its computations out of its bounds.
Verify tm_mon on input to prevent that.

While at it, change the month_offset[] array to const as it is only
read, and fix a typo and adjust the return code in the function's
documentation.

An invalid tm_mon condition can be reproduced with the FAT filesystem on
the sandbox for example, with the following command:

  ./test/py/test.py --bd sandbox --build -k test_efi_capsule_fw1

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
---
 include/rtc.h | 4 ++--
 lib/date.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/rtc.h b/include/rtc.h
index 22f6d370591..085cb68c584 100644
--- a/include/rtc.h
+++ b/include/rtc.h
@@ -309,10 +309,10 @@ static inline bool is_leap_year(unsigned int year)
  * rtc_calc_weekday() - Work out the weekday from a time
  *
  * This only works for the Gregorian calendar - i.e. after 1752 (in the UK).
- * It sets time->tm_wdaay to the correct day of the week.
+ * It sets time->tm_wday to the correct day of the week.
  *
  * @time:	Time to inspect. tm_wday is updated
- * Return: 0 if OK, -EINVAL if the weekday could not be determined
+ * Return: 0 if OK, -1 if the weekday could not be determined
  */
 int rtc_calc_weekday(struct rtc_time *time);
 
diff --git a/lib/date.c b/lib/date.c
index 0deac8a1bee..4e018c22053 100644
--- a/lib/date.c
+++ b/lib/date.c
@@ -17,7 +17,7 @@
 #define	days_in_year(a)		(leapyear(a) ? 366 : 365)
 #define	days_in_month(a)	(month_days[(a) - 1])
 
-static int month_offset[] = {
+static const int month_offset[] = {
 	0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
 };
 
@@ -30,7 +30,7 @@ int rtc_calc_weekday(struct rtc_time *tm)
 	int last_year;
 	int day;
 
-	if (tm->tm_year < 1753)
+	if (tm->tm_year < 1753 || tm->tm_mon < 1 || tm->tm_mon > 12)
 		return -1;
 	last_year = tm->tm_year - 1;
 

---
base-commit: 32ebe922e574a733d01c3f106fa77d9176bfecad
change-id: 20261014-wday-f3555ab87dc2

Best regards,
--  
Vincent.

