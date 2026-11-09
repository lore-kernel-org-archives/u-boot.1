Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A41606A335
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cObxM6jf;
	dkim=pass (2048-bit key, unprotected) header.d=lexina.in header.i=@lexina.in header.a=rsa-sha256 header.s=dkim header.b=IF+Z1DI7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF72380FFF;
	Mon,  9 Nov 2026 15:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aJQGWR09i93h; Mon,  9 Nov 2026 15:49:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 09C6280FF4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794239380;
	b=EqYSKna804ppTH40FlBS8g+IgglenxvQ364RfXmP5A38Rt6bOuwpAMJDDwrnsfDyBAaY
	 pOWGxG/+M9VBX4KIkqQMhw8drUtdsAYuYFE6XpZoBq3r9vkfgbvZlxJTknZcDEeRhYgka
	 b0mPywLK20a4EXp/2OHrx86cJywYUmS3ESW8YHNKjfJQiOZ9q7OA7PWMgpel/DQQLJYPz
	 gvFMeQjAs/6Pa4EorZR5X3tVElsCm9A8F3BID1RN02CPKXJ1zQ3UOaTXXCvIUeZhx4hYn
	 P+mXuooXd/ByCgj6vCqQ802agIvqe8wFuK7SVVpMxRvLgEa8aSdfRFWrGdWIe5z2t2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794239380;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DTQrUC+zvUNtXscto+O0f4GHcjxahkpeeS2FO2ZYTbY=;
	b=pFmB+phymCXwd1lg9VM2+1s/0rmu57LlS+bbmO1mpMC1WLloCR56cSUK+Jr4xzyb17Qv
	 sjDN+rlG1BaFQQNV9ccex7VvZ0AA3qNgaRwgPbT0yB+fp/JONg3Gg6676IwM/tqOJsqmS
	 KZhBBJz3DGwhijvRsxRBQg6PX6nVWZ/AcJWz15r9oz6cRKOttzUjtE6i0VMm0+bPXCDzJ
	 K2DWON4D/G6SPGPG0Kt+6/zpRPhvFJmnLMK6+qKH0jzSgJB7Ec4+wKLaGwafn8jf3t076
	 s7JismPgfoDSamXnV8LWeye5789bIYmPd1Ryh83zF2q2G9vzeXZTWBq62BxqO1sAmVA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=lexina.in;
	dkim=pass header.d=lexina.in header.i=@lexina.in header.a=rsa-sha256 header.s=dkim header.b=IF+Z1DI7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794239380;
	bh=DTQrUC+zvUNtXscto+O0f4GHcjxahkpeeS2FO2ZYTbY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cObxM6jf/cOoc19C8Y4Ijry7sq3biSwKGKUyOU/pK9Fs/wY/AhqGbV9PuxbEvKfqh
	 yy9Auc28bW4gfb6JyZqS7wnR1OQHW1wjHU5rPacUhYXbIPi3hgt9a2ANqzRE22mEiy
	 X0wF3eO7jYyA8c6gC7mSwyW0LgYMDkTbcN0M5pvZaylBnuhMGOUZNoXGJwhU//Bykm
	 g9By16wiLo/ezSyDnpw7nZ8K/SrAVVGD9ci7iMN9MTk4hIK/pidGAYFPsvxRaTxUpi
	 RshzZsnUv+Ido42pFX9kdUTXban3aTNG498kYRv8HIjtSVsL90rbzyu2eKsn4lQrPq
	 WZo0Nzav9NoOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09C6280FF4;
	Mon,  9 Nov 2026 15:49:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8ADF12AC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C50780E31
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xqKBY9As34e7 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 15:43:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 488A280F8D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.250.0.168
X-Greylist: delayed 516 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 09 Nov 2026 15:43:10 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=lexina.in
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=lexina.in header.i=@lexina.in header.a=rsa-sha256
 header.s=dkim header.b=IF+Z1DI7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.250.0.168;
 helo=mx.adeep.su; envelope-from=adeep@lexina.in; receiver=<UNKNOWN> 
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 488A280F8D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:43:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D66BF3397C; Mon, 09 Nov 2026 18:34:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
 t=1794238469; h=from:subject:date:message-id:to:mime-version:
 content-transfer-encoding; bh=DTQrUC+zvUNtXscto+O0f4GHcjxahkpeeS2FO2ZYTbY=;
 b=IF+Z1DI7ZG2D+fgJEN2lf8DY2a7k8C56GZb0H9BSRGXiT/FW78gbQbuDDY7+SAH8mO3Hw7
 UpUohwC8u5/JdH2FbTnFdXGPh5dshgXkwrRH1Yw27p87AWCxpDkxp+mcccB8XCpwBqp0eM
 6xG2GvocdYJl/MDBA4wddAfRuyqSZM2l0QUo8fnuZybDzE04yXYwGTknMn/ZT4kD7IbOsd
 3IoUvxPJZEAHP0VXXdmvfcaQK9GBAWXJFjQcaqfWqrGQb4i8tNeyZNtZwfakmfMTILJ9Qq
 34zmt62kj/rvEbiqPdgyAap13qyh9dY0mSiSuFUejPJXfunZuH3bxJDiq7dG9w==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Subject: [PATCH] mailmap: update entry for Viacheslav Bocharov
Date: Mon,  9 Nov 2026 18:34:02 +0300
Message-ID: <20261109153405.50010-1-adeep@lexina.in>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:49:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I have changed main email.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 76ba0a7fea3..9436ebfe4c3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -158,6 +158,7 @@ Tomas Thoresen <tomas.thoresen@amd.com> <tomast@xilinx.com>
 TsiChung Liew <Tsi-Chung.Liew@freescale.com>
 Varalaxmi Bingi <varalaxmi.bingi@amd.com> <varalaxmi.bingi@xilinx.com>
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com> <venkatesh.abbarapu@xilinx.com>
+Viacheslav Bocharov <v@baodeep.com> <adeep@lexina.in>
 Vikhyat Goyal <vikhyat.goyal@amd.com> <vikhyat.goyal@xilinx.com>
 Vishal Patel <vishal.patel@amd.com> <vishal.patel@xilinx.com>
 Wolfgang Denk <wd@denx.de> <wd@atlas.denx.de>
-- 
2.56.0

