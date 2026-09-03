Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8378CC61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 14:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9310810F5;
	Thu,  3 Sep 2026 14:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2TXWg3zwIkxF; Thu,  3 Sep 2026 14:51:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D6C8C810EF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788447095;
	b=mGuRuEbgX49w0uXgNgEUW+RpR9WxjSg2sVAUotINHFtpCchkDhd6Q73henpWUoRsMGMg
	 rXAFvoFNoOXD9vw+wUjc9qRldcUOz8H/V92lhO3/3JvksGIi+iGsc6EtBKYRAxJpHLEp1
	 58kvFCsj/75WmhX4z9KGZ8B/T2UxIt7/EyWknJych5Dh5/pB+Yy5+mJYhekWqOkXKeyN3
	 Q1zji+ip/6uXucSdGb+fT9hSRf4wb0TcK/TF5Ed413P/Qgd/TBEktdJO1EsvdOMVAw1WG
	 lZ8+fBwgDfls90SC74DJWGA9lSRtE+azuRVuafuNG5kNKHulrcCOLMtaNZ6K0rKZfKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788447095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UEiarAHnae8XVyVgKBmEPoCm1jZnHJAb1PthSSh06gE=;
	b=WVnalfWPHEPTmhOpJ3ny5uJ8uNJjtzqSCA4Jn82qVtmTZBnk4fbPzyTOWT/EGuJM8nSa
	 SXGXaM9nlYOJQxG7Yuoj3l+wfylAqr+0mD+agFf15VfNSKLD+J0FxupWCP90s9RLY0Ort
	 r0P30jrBwsglWW088Ka1pHaT4/iuEsNM06qaXfllgUWbTZHnZ18VNNAp4fn6MGnOFgsJU
	 13+Smc+4Giq6tBQtd/5OZEkhoUc/bIhsXg75tR+gE+sIC5WRUiKJoU3giK5fr2H0eJihW
	 0CcBZviZ7XjHQSAb5EREKvbIzU07Cix3Kfx1az8gKJRwc/+b403TfNMm/IKhz7GSehA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788447095;
	bh=UEiarAHnae8XVyVgKBmEPoCm1jZnHJAb1PthSSh06gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rHLHOCpGk4mkebcF7QKBFul9K+FQ7n//EgzUBh8ibkRilfjd4mPkXduRIwUpFAth8
	 sfXodc7w61mlQ1iBygmmNbTIE7IphERX2wfjvmRpDna62O3XRBTgh5aCyihOEFnIS5
	 XFvRpSL+8hXX88Z98142Crhv44h35DV24c8AwE17R95AQKhYbbTGXfMqJ/+bpV9mr9
	 quAwgMfcDIkEl8KiINWdyAf3gi9DCNsvOzKBxb66W97qFU4V0Y0sU9OkjeKLHX6ZHT
	 yFSBvnPmzIpFDO81f8HNSzgCff9+/0JCY18ABb6KnttJcres2ojdBNAWqEhiPl67Cx
	 EHNUNwGL7QOuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6C8C810EF;
	Thu,  3 Sep 2026 14:51:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C70EA363
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8A5660B6B
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id stJu--tX8yyK for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 14:48:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8862460B64
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788446918;
 b=ZBOthL/lAMwSSVNdqATUhvgrs6WwWKBxcn6AE+X5Rbk+v1ijaClt60u5OZuwOyQNAEn2
 omsitOsP5SEae3vX2KDC0qruIv1mzU8a+pohI4BVnsIgaFpY0FQFHtnRROb9hnZ2FR5rr
 cWSE0qg0B1hHDxmGr2jjPKPNrahxHhbajnAp8BntWYSvUjwSMx2hxqsX51IFbQ245aJKW
 tlsGUv+BBkYX+fX55YhdINqptHMLGaL2holYbxLIJdPL6RFsYGnFXW+Tog1hx3C4GqoJQ
 l3lX88P4z7Ulm9/5AfOR8G1INv7CLKLSGvcyJwfRWtGN3l7stG0ZJy9xI1b3Dcosjow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788446918;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=UEiarAHnae8XVyVgKBmEPoCm1jZnHJAb1PthSSh06gE=;
 b=f0meEaUUArhaWH+fEABYPQiijdWfrnZhyIGXDCoV91oWRLCKQ7aCM7QA0KcY/5z65aSg
 12pJCXopAqDOdfCCGGLF9QSd+tiw5UFxtDIBbElnXTGot/cBoigQpwK/ayoeqQ0ATQ9dQ
 bN9fWr1JjhAehF8Yzzksvh9zP5Es1J56IT6SArLYvMH38JXcI04e4cC13gLvRF+JpFJm7
 n1D4TmB35aZ0Uktig4EscbNkY5TyjYlGuapCki379WjfUhvnD7cpmfrWewBN20cxHM76Q
 q/el5t/6UtFicYtfStnsSzU5LeMm7VUajDhx/HoobLxhbztgqBsM3v37ihphjHK74Hg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=pe0IwCOj; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=pe0IwCOj
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8862460B64
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:48:38 +0000 (UTC)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7E6D04293D
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 14:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788446916;
 bh=UEiarAHnae8XVyVgKBmEPoCm1jZnHJAb1PthSSh06gE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=pe0IwCOjBhikdfloZ+pSXV58bPuTInVYB5AT58gvrtJqGdvwDWZgGuHe7rjB0lBBm
 kWOXkq7MDTRxxvvNWnaOAP7iKnUYoeiNk8QjZwjA372AjgVW95V0q0LQYgW3OXVCqY
 y/iFiJzT6XguIGoJ0DRe8BH4XXSBioLeAyEjXez3lzwrDTSgNMhO1jfZUwgvE2/F/T
 p4P6p62xdwWcOkMz4WCvv81qIY/DJotyuhl7mC4IBSiJhqloO3hCEoHSTvMx9b5H+C
 SqCsiEHaeddntOZtXFvJRGZLvBNvD+GepzlO62XHG6klILCWur7YXFnEoCcJ/miRep
 XCGp62a7lj28vKZGyr3VeMJMNWPREhuMow1VXie1GBdifHe7B6TO5rBKA7DXzjV9tg
 WvfzGJg5iJ6gZFYAeqCU9pw7DCJVa5i/vAX4L9Y9SoBBn/+SjXjPGi4aR6ekRskXbk
 RklEN9MP6c5g7tXc2S+8uuheug3bKp/M9wHjSVVZCXwjYGuOr5SaCkdCorKj1rwpwn
 2JhrmtatUd1a61Z4liAt+qnV6lK+u+LWZh2Xt23gRxBp8gBRvk4E3XNDSYbU0wCVMu
 u4tf9s9wEWuUsQSvkBMTKe4MaAKgl72FnaCHUiIAhfsAdv2WcQaJJXg4dxOWIoK6D+
 SHCy2GDfbQU7uM7h5KlJYRio=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398d0010cfaso4284146a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 07:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446915; x=1789051715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UEiarAHnae8XVyVgKBmEPoCm1jZnHJAb1PthSSh06gE=;
 b=KzB/pMPLn5SVLc65V5stuyAKfswGUaknhKNn71rINXkPmxcVi9oiGnigXdfvnqK+PS
 5CshsFk21DHl/FOG8AlQBe5RBOHcUeRnijvIwO2iDB+oFssCSaGszVpfv+UEHO0KhmOA
 oSUT4p1so4hjIIqboc+q4HwqDSaxCWROTCuXPaqpz6GdRm39T2DaNpWrueDDG1cP2+KI
 57XbVFy3YC28+N9nnXtUZSFLT8oSV+QHPNaKDeMEl+nt4OqR+YX4KvB2LY1EABGa4QEn
 EYhN1bDn0QhTY+/TC5LoqW5vDS3TvWLUrID8kK/6QAizqYl5GstIC6I+yTYF0n6G9Vcz
 5QhQ==
X-Gm-Message-State: AFuF++me0BI3tuk/SfvVXCsYclikxwomYUt/dI9UnaClwoJvH2HMJYmz
 wiOm8YsF7x7XGSjefyXC7QGEvMaDnS+Gqwxjm775cm4AT8lStTeM/74K6HLHzYzl63/n/7+YexN
 qjUwlzpy0oTzK3VUV5vkwcWe2J+F7sjv1eLhgDeJbMjQCX8LBbclt7qPTFpoXtkoitjpKdf92Jo
 lN2byoLcWzQz/T0kWz8w==
X-Gm-Gg: AYBFou1QqWCZl/qa7KFMlSJrffkwiBHhmboOcIRm8h3jru1BzZNk/aXOUBQXT7sVJeT
 a0DF2555kxeA14ynMUz4taUv0yC15t1MfWFJzSkjjBp0ON99jaWi+ytKxXP2abmOkeDKqEksdl+
 f+SgGHil0aRRMHoy+vzC574XrEu8bh/IQA2G4ZP4fk8R8vXH2voNbbLdberLSNqfFa7zOrWnY+k
 XD0rZHYl/zPYssOWPCp9eu2DIDcgF/USrvMGOd7PSAgFelJn1DYyqdbHTNSW0s7SSaXjHG6WUyw
 6bGB44WkzsNbjpQI4UI1QGDuHLbMbLwRyvkNSysnXuh0ZQB6/sG6HwA8KICcQri4r1P4jZaTsJp
 H1iZH7dmRaXitOeOSdfyUfNvj7qSuT5Ccgv9dWgXj6P05xcxA23z2WEt0wYYk4v183tMhLw==
X-Received: by 2002:a17:90b:2604:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-39aedce056cmr19959655a91.0.1788446914849; 
 Thu, 03 Sep 2026 07:48:34 -0700 (PDT)
X-Received: by 2002:a17:90b:2604:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-39aedce056cmr19959580a91.0.1788446914331; 
 Thu, 03 Sep 2026 07:48:34 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08ce4221sm7051971a91.14.2026.09.03.07.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:48:33 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 1/2] bootmeth: efi_mgr: Do not discard the EFI boot manager
 error
Date: Thu,  3 Sep 2026 14:48:13 +0000
Message-ID: <20260903144817.9666-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903144817.9666-1-aristo.chen@canonical.com>
References: <20260811155940.17698-1-aristo.chen@canonical.com>
 <20260903144817.9666-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 14:51:32 +0000
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

efi_mgr_boot() assigns the status returned by efi_bootmgr_run() to a
local variable and then returns 0. A zero return from a bootmeth's
boot() method means "should not get here", so bootflow_boot() reports
-EFAULT for every boot manager failure and the real cause (no boot
option loadable, load error, ...) is lost. The unused assignment also
trips -Wunused-but-set-variable on newer compilers.

Map the EFI status to an errno instead: EFI_NOT_FOUND (no BootOrder)
becomes -ENOENT and any other failure -EIO.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
(no changes since v1)

 boot/bootmeth_efi_mgr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index 6e70c36ad99..eb4d9a5b5a6 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -84,10 +84,13 @@ static int efi_mgr_read_file(struct udevice *dev, struct bootflow *bflow,
 
 static int efi_mgr_boot(struct udevice *dev, struct bootflow *bflow)
 {
-	int ret;
+	efi_status_t ret;
 
 	/* Booting is handled by the 'bootefi bootmgr' command */
 	ret = efi_bootmgr_run(EFI_FDT_USE_INTERNAL);
+	if (ret != EFI_SUCCESS)
+		return log_msg_ret("mgr",
+				   ret == EFI_NOT_FOUND ? -ENOENT : -EIO);
 
 	return 0;
 }
-- 
2.43.0

