Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DECFCCF2C1
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 22:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4493D40C6D;
	Fri, 16 Oct 2026 22:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6rnoUop3CAB7; Fri, 16 Oct 2026 22:52:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4CFE140BFE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792191143;
	b=XFJSJy5td5nbW2F34vklZzk6nQUIh7BHxS8051X9vBNMYVEod5bVdRIoQFnQg2bc6Ar4
	 jvbYWOVUiHhyszB+gjjxY9uyWnJEwuZAWMgPoUaLDKjWodw09itIk9rW9HkuCUtA2vVr/
	 bhcWtK90I8dchTpLNteF9UQpHzmSa+9ivIHm196iJkCuDzdog+/V5jxtXhrC/cmXT1dAT
	 tQCCXaMkKao2uHf9Jf76+xcTsfX/2zvrqXRZ4RRfaQ7rfVBvo8YZIOOFIUJD8X6p++hgt
	 3j2mb7091VMEDCJR0C8QqYjmx8sAppkpzBJQzdwrxJQNZyYyz41vIl5zO3cnreH7U7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792191143;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=lrknIIe1NiuUpEIeFEQrHKV4NUL6/6SVAG4HbQXSWt4=;
	b=OM5C/MVO5DeALX4kt+aeFJN79rCZ8gqI4WSNH5w2L9BsDTY5Qo6Nz0osWvBNg/HIw+Qu
	 uUF1g6sXbW/VSsjQk39/X/yFwe1NTkQI8ZkbjbwU/S+mbmkh+Y0VOpujiqoaYUreGIugx
	 1eI2th1Dsx2pYhXfsH+WlV6VVXoX2nzklG0oLx4qZvhKjjw+MzjAam/yhiZL37w+U0OvK
	 KYz/AgnV4VikE2/LeLxmetX0aJpcLhSIKWSRnfZ0RFuBqADTUnd6BmEeBxyy1EI10jNvt
	 NmX09tEhJ8M/PiolrGwsdH4+kyRMqsmoQHAjX8KxByyXsga5HdogICoyvsoQaGAgVJQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=u0qDp8AR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792191143;
	bh=lrknIIe1NiuUpEIeFEQrHKV4NUL6/6SVAG4HbQXSWt4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=oloo2EVMvovYdaBEyvszUq8bPjf364GxTxlJDU1MnIhv0HrVeXk9fmfHls8IZeedy
	 NUtfjQB2o31ozb5e40oDqWBWiVX6FNmLUaWRbs+cpdovsoTLnoX56K5zaedwquCeF1
	 VSdpRzSWGRr0uPudsEaH7NPAmJ9lH8oI6s0vJER/0OT9HdGQ21hwn/xSFyyHopsOJ4
	 eLJSvzk5LwEVYOx16uz6apUf9vssgl8Wu8GHP/CJGfghUSr8/p1Nn/YuUtvy8PDhMS
	 +rclppnpm6grEx0BPNCISaKyLeaGHSArj/d2vkLK4NJpo64AjsLqC/bfSMFRJY5bd/
	 l2hBzLpBwW5Qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CFE140BFE;
	Fri, 16 Oct 2026 22:52:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BF7A71DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0EC540A29
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Q9Z3rA4eoOm for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 21:50:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1496A40A18
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792187451;
 b=Jsafn3+/ORTLpDEqpwFOKw17GwCHf1af8PZR0v3q3FYhHKsV/g3LC+MSADoQwPgueJzh
 DbTSo33AtNgqqH9UfG2eoge64Dm5ySZ3IYuwUiBDF3PAojWl4sU4XOMqxEpDupxw9VoX0
 /C4lz8r4J8tUR+UhVPMnmdgxOFVWQ5/J+1PPQ26Smq+KXTIAYXa9njm7QCJKMwyeDeWYD
 1T1I0UbvqmgjFvdU4X9EZdIyBuuGCtFZfMZA7Soy+FIhcHu23Ok5CEY7vI91Vp6JmRvyV
 uqagBf9z26Clv9nPQ17yCMcApVC6gMzAE079j+35uVLT5uX7jTeW5NZwKZtuFvZ5NPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792187451;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=lrknIIe1NiuUpEIeFEQrHKV4NUL6/6SVAG4HbQXSWt4=;
 b=q+PHGrV1LlX+bsgXxvR8mmS9NInrMqfF2nWcJNggikQPNTTgrCpOssk3DxknAn0JHjtj
 tN+Riwg7K1yUNV6uEr6RPzTlxuplW1ii7tHbaeFbyZcX409wFWDQZ0CgoRW6zKYBv5ejZ
 Ppp7t9tItisRPTymHSFSuEpGEx7q4zdfROU0oFEgdT9XQ4fwvqkJIkpVQbuw05VBC69KB
 xZmkRsXSDtNnkru+SCPqTctUMgNdNt8QtSIOye+SMN23KGQyiDP59tNAPzN2M5DmSEAA0
 aSfRZQx5o0ZpdvVEPsNxqtweByUf9sBLk5xQoeNLb+1XsMJYwwVVNbfdTcgEKPSUY9g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=u0qDp8AR; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=u0qDp8AR
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1496A40A18
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:50:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 75CAF436E6;
 Fri, 16 Oct 2026 21:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E9F0C2BCFA;
 Fri, 16 Oct 2026 21:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792187449;
 bh=Af5D+TvCBzqGiETJZKgdSQwbompQP9T+Jjsp8SzxuBI=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=u0qDp8ARUkt+VZz2b4vBatmJ9ocXx6knsA5gtqYO9rISAW9PadJ5Y5TFvI+MyqPfp
 nNaegJWeV97sPrMaF109Ty8Ate+/1LoSnpFtFC7JAIPzzcCV0Cxrg7IRbBzh0dSrho
 tpwvdmMRyhbGy2bcyQxgFjVJMFVbSkC7jIfDTPegncLaavzrmXzRqETgOto2QSE7cO
 8+FPTYbJE7TCFyaztwfnX5zkNOl/X0+yR6ODZ0XycC9qKiUVEfH/HaZzh2qbWpeNzs
 mzxTAraF69pdodPexVIo4aSom8DDvAJju0IaydAY2vKtad4xKHiCbIi84dlHYZQYAF
 TdUPHQ2KJmmzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 383E9CCF2C3;
 Fri, 16 Oct 2026 21:50:49 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 16 Oct 2026 23:50:44 +0200
Subject: [PATCH] mach-snapdragon: fix the serial number taken from the
 command line
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-b4-snapdragon-serialno-v1-1-9d0aa26d4229@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDQAxA4atI1g04489Ar1K6yGjUlJKRSVsK4
 t0d2+W3eG8D4yxscK02yPwRk6QF7lLBsJDOjDIWg69972rXY2zRlNYx05wUz5qempA4cNf4ELv
 QQInXzJN8f+Pb/W97xwcPr/MG+34AWZI5+noAAAA=
X-Change-ID: 20261016-b4-snapdragon-serialno-ae7e5327b573
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792187448; l=1780;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=0CLedReSuo8u1BPyLssJGADja6VBG1fKJ9aup0vJ/RM=;
 b=9yHLJtPqF2yQCSPsKgIoCpraqVp13MrBy2NY4wsmwkzlVQERgTmO0/ahyoFqBJYfn8mCKHQrw
 ua1ezF6zqL5CqZXJIfcgEPafWH2ZJRdB82CytwGOx3zqXh6VyXiM2rj
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Fri, 16 Oct 2026 22:52:07 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Check the android command line if it contain the 'androidboot.serialno'
so the qcom_set_serialno() either the return value or skips the value.

Fix also the helper to parse the value as the last word of the command
line.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
The serial number is currently broken on devices where the command line
has no androidboot.serialno or passes it as the last word.

Fix it so it does not set the value from uninitialised stack data.
---
 arch/arm/mach-snapdragon/board.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..50edcd0f6ce 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -331,15 +331,13 @@ static int get_cmdline_option(const char *cmdline, const char *key, char *out, i
 		return -ENOENT;
 
 	p += strlen(key);
-	p_end = strstr(p, " ");
-	if (!p_end)
-		return -ENOENT;
 
-	len = p_end - p;
-	if (len > out_len)
-		len = out_len;
+	p_end = strchr(p, ' ');
+	len = p_end ? p_end - p : strlen(p);
+	if (len >= out_len)
+		len = out_len - 1;
 
-	strncpy(out, p, len);
+	memcpy(out, p, len);
 	out[len] = '\0';
 
 	return 0;
@@ -373,7 +371,9 @@ void qcom_set_serialno(void)
 		return;
 	}
 
-	get_cmdline_option(cmdline, "androidboot.serialno=", serial, sizeof(serial));
+	if (get_cmdline_option(cmdline, "androidboot.serialno=", serial, sizeof(serial)))
+		return;
+
 	if (serial[0] != '\0')
 		env_set("serial#", serial);
 }

---
base-commit: 1bcb2fe324180d0a8cfbdb0511737eba1d5b8550
change-id: 20261016-b4-snapdragon-serialno-ae7e5327b573

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>


