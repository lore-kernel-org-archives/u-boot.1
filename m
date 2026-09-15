Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DDDC88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:07:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1813580AAE;
	Tue, 15 Sep 2026 20:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Onlv51DHse_G; Tue, 15 Sep 2026 20:07:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7931780AA3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789502844;
	b=gkDBP+m1bK3F7irdZrt4rIyICtM8jQXg6MB5jdQnG19Yry6ou4g2cHRR5pa+5j1k1pLw
	 88eo9CamRyWRjOzi5nCSvsscEwU5EsfqHyTgqr6NIokG7w4pHxOqrnIGp8brVQvBF4tq/
	 Qxq+mSUMxcZh8jA2sZhY5p+XAVVdhfEMs03WIVMbFef1fug+uookLMXUSQU03xVm4GTLc
	 EhaYQLJJb3GoHI4Bg6a38G0vHrsDhSxeMqv/hjYl5IEAFKwocutp94hj7kcQyHj4WTABk
	 TPn0OsXWeyy6X80S3XXaQUNbf9S0RHXW9Nqvuhc8SMp+2IEEyi5ewaBkDjkz+WBAXVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789502844;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9iUTau7LoLmzRKquBjDu19doFtrIGWy1i5kTw9w6MCQ=;
	b=Vq72egmo3xUnOvylbo+hToPR7/Zh61HrIGr8tQiQSal+L2vWDq/mF5RluGlUUmfNA5pw
	 t6n7ZMO5KAv9CEE+St5y4eBGyTyWUXyR0LNGIAffB+l5X+XzmGr6ZkrowlIw18S397cgk
	 PQRHr8FGRCbva8zd09iDR6rolIhawqKtEhlvY8wzoOkpu7hwUhhtDO5hx7kCamT6QAQfB
	 ZTq9AYmYJpUCfK7dmSUELzGbvDT/uHFpPcZkMIVVCKMMg//sEPZDaA7+81wI8uLWeqPB1
	 worvH8V26/pkauR0MOtqYpOBH1EuldSKF655WD12niPJ4EYVh7cgPcm6S5QQxqPlrSg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789502844;
	bh=9iUTau7LoLmzRKquBjDu19doFtrIGWy1i5kTw9w6MCQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BYn9YjGPEEtxBOi/M47IWoSAoeZuDn3D2NvAwRjzSgz9YDkQ/hIKUzzS5ToGwIr2I
	 5YTF5Cyb96aRhEIoDM703mqYRaq6387udKu8I5pHLY9lkdL57KIrfeMwSoYNYDTaOW
	 cngavVFE0sXYoESYt7A8KHmMiQL2nzktJm3ihcQHZJ9k6Y7yt6KF+S9pqrS/I3dqEj
	 vM4FlPkaP3Oztw5kDR3ESMOMRWpZ4vWe+LZrEP/IS+1SAGFxRLH2t1BsNp49CyBnkx
	 zcnqAU6tC31TjD2qV1Fo3g2LdEKZK+KGKZVcQG+58ylCZOlNWw60akk62HFAwE0kRw
	 JC+TEhU36Lupw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7931780AA3;
	Tue, 15 Sep 2026 20:07:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7643E2E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BE3C60762
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gZSY9jSSBiqx for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:07:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EEAAB606E6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.102
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789502842;
 b=kKQXUi3JjvOWJKTY46deghOy0pMSJ8CQJ42tL9r4b/uEvvIKmSNdJ9GZ9XfXUv+4Oq3H
 VmIAql6c5Zs7z3DfpN/lJCrnGBLaUW9iFW3wDxqJyY1t/4gLanWLs1G4h5/5HIyI1j1CP
 LvZtAkFwwFcQaF/sfX83BslTfelmhxd91Gt8dPdBfFeth0VVu4swIjPiK0Mu2oYx9ZQc0
 hMC7d6NKH076kWJmwUy61RNagaaiiaaqnwJl7C7kdisWRoRIuBjaB/ul0KgfzjU3zvvp5
 lfePNpSKbsdm+gDH2g/ABQMRHU/c+zuHG1jUNWOAyUzPp1ipH9jm0iEUth64RSm8fSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789502842;
 h=Received-SPF:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=9iUTau7LoLmzRKquBjDu19doFtrIGWy1i5kTw9w6MCQ=;
 b=aAyIe+cDC90fTRB4YRC/KXqk962gigDb7g57GaTM0y+iDdOdDz72v5SIueiGgK3P89N4
 pNvhGzptuFyqB6DX+KkoZdKv0/obmtpHfwhCfzYO+625bCHIEb7NoQtNkRZ+GvyNLGbQe
 8pJ93BzUjR+J+9vfM/GQlj9M2oPR9N3EEUiIJEOsfnZDmCpFCPvpIjKTGnez3hhp0hwYY
 ntcbX/PUeB6ry5jRxvjoENrgez2uvQsooPwhlJF0pk51Wg6JxuGJZdPuByjY/8TCGdva4
 ByPZOLXka0dzhSxTn0JgLXA600rDOTJJBuk4bqLqzblYorxlGzonyYDmLAl6vT7frJQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=rasmusvillemoes.dk; 
 dkim=pass header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=gigqK7eK; 
 arc=none smtp.remote-ip=109.224.244.102
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.102;
 helo=mail-244102.protonmail.ch; envelope-from=rv@rasmusvillemoes.dk;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.a=rsa-sha256 header.s=protonmail header.b=gigqK7eK
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EEAAB606E6
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1789502827; x=1789762027;
 bh=9iUTau7LoLmzRKquBjDu19doFtrIGWy1i5kTw9w6MCQ=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=gigqK7eKpiKmuGzS9W6z/QgxqmQW1xomb6FJGqcjJDgMBM6fZfJwbaTQUZV6crbBO
 Z/WxDWypsjFXKdG2MzYhpyYuo9W3V90V7xg6fltfB7iLNUafmiJJnPt/2jrwLbGLqH
 /CMSnGGof6Cyp7kRF2yadQ23ftFEthDevnhuw3pEKaqMPfaU0pp/jGUmqBk0hbbo+f
 eo1BI7l6s6qBp9sFHjLYeIXbK+A8xbEAu9OFhHwn/3LX1z6idTDf2di5K6Q4hn5e21
 Pygx8qca1XqpRDfMx+5Ss6KVk7SEn918jb1N/KcXJ5fz6Tt/8bM+63GgZNOLh7C2DJ
 wumHldnVVZ7Bw==
X-Pm-Submission-Id: 4hktMt0J98z1DF6l
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH] fw_env: do not create lockfile with read access for others
Date: Tue, 15 Sep 2026 22:06:12 +0200
Message-ID: <20260915200612.78621-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Currently, the lockfile used by fw_printenv / fw_setenv is created
with permissions 0666 minus umask, i.e. typically it ends up with 0644
permissions.

But, since it is created in a world-readable directory [/run since
aeb40f1166e ("tools: env: use /run to store lockfile")], that means
that any unprivileged user can subsequently open that file for
reading, place a flock(2), and never unlock it, which is effectively a
DOS.

For example, on boards that use RAUC and store the BOOT_x metadata in
the U-Boot environment, the lock file would typically be created early
in boot when the the rauc-mark-good service records that the current
slot succesfully booted. If a malicious user then permanently locks
that file, any subsequent attempt to install new firmware via RAUC
would fail, as would anything else using fw_setenv/fw_printenv.

Trivial POC (in two terminal windows):

  $ id -u ; flock -x /run/fw_printenv.lock sleep 15
  1919

  # id -u ; time fw_printenv > /dev/null
  0

  real    0m13.786s
  user    0m0.007s
  sys     0m0.000s

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 tools/env/fw_env_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/env/fw_env_main.c b/tools/env/fw_env_main.c
index 0b201b9e624..116a39ea909 100644
--- a/tools/env/fw_env_main.c
+++ b/tools/env/fw_env_main.c
@@ -250,7 +250,7 @@ int main(int argc, char *argv[])
 			env_opts.lockname, CMD_PRINTENV);
 	}
 
-	lockfd = open(lockname, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	lockfd = open(lockname, O_WRONLY | O_CREAT | O_TRUNC, 0600);
 	if (-1 == lockfd) {
 		fprintf(stderr, "Error opening lock file %s\n", lockname);
 		return EXIT_FAILURE;
-- 
2.55.0

