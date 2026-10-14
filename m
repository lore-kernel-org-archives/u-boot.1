Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF856CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E48680DAE;
	Wed, 14 Oct 2026 14:07:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GnSHXKNwNlhm; Wed, 14 Oct 2026 14:07:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8DBDE80E26
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791986852;
	b=bOmIW4ovqAxwqR5u0ftI3DCNpLau0bUBgBD1TGYpqT7SgUTsNW5snS8F0E4ZLpVj+T/e
	 ij3em3KbEC/aROLFF+q3+0npB0waE8JzgRDxkziOEFms6px6/43RbmJzNOxzaCq3KIMLo
	 3IQ49Ef71Qp0xXjOgbzmEXeMSf47MrfS3tS+ar8BAgf4RfgsgqeNxI06/piVfZUGxQLJp
	 0UT/XkL9oumP6NB+vUnPNDxIB6SgexlMo2fjH05MMbaHUtrUZedsp8asELJB+SFJRuygC
	 hKt0TP/4112usjCWcJbDTK0IPd+pUPOCttm3aHMB8xVy8iANiPGYFVsh/j1VPhawWjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791986852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=M2Gz1OsJxLF//BIYcLf4wdMusoVnMYPg4ng7nFLhAbA=;
	b=SV/6lCUxVi2SHk0IblvQFa4j8rFaqcgUNGxwPQuQQsTxNa5xD8pOyk8YzcEz2uFTfAq4
	 Lsgx7b4IuXTLw0hefnvZJ+k4WrHPtzrn8tRcx2F1nnTVmaHGlaJAEEFymKeHg/t2gEQ/o
	 xrpWAGil4cRsIyaspk7Kb0FqGLvxCKtK4eMXN8Qyk/ua49LQMkIAXdiLy7K3RRhe3IGlr
	 T2axqC0U8xRqWL0TR88DEiqsjeEzEqibFtcNAw68hHqMlsNbKumQ9lpOdjOXssElilMtp
	 cpaoRYwKoVUhJmZuddanuc7PwWPDDXitS3YgwHUVWijNwhI1fnNlJD3Ue56MM8NZ+VQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hDtyIAb6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791986852;
	bh=M2Gz1OsJxLF//BIYcLf4wdMusoVnMYPg4ng7nFLhAbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fEKkr4BKaZAgVg0XQBS/gc3Hzzp9PkdCcGhXQsMoBQm8yFx9U7hs7ASVaaaqBcHfv
	 C2tKeF+aLp7s2tGXVPFBIdCgbT9nvF2XjwziW5ABTICyNi/62Y6u3Kak+XIeFPC6/I
	 zHB4ISK2qiydAyT8NzH1Jh0i5Y1RjE5AiphWB0Pj1VoZMNZf6akfmCmQdGVRGblGlE
	 X31QfXGkxjJ/0DXLP0vKXvWlCmvdBm6vDTF3Xpc4GZG1Rl6qnaJA+0D/C/luz/Y62y
	 /GLjvQ99Fhhs5iH+DVCrgjs3L2AM1f80yZwT/IuI1V/MTcN1kzBCI3Bu4oOqg5pBx6
	 ro82aIw7Rg+cQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DBDE80E26;
	Wed, 14 Oct 2026 14:07:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 302DB2A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1385B80CC2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OQtQss7-iDOD for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:07:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 49F7280E13
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791986848;
 b=KcrnwaHZcImJtrFI6W1iew5Qe7qi4iqQN0EBlbzr3aQkjHtTEd9NCYm445IyQt0NUUIH
 iYAR1XUSSMP/vqPpxqhi2ocaeVbR9RWNSTBrjAd2yb58PZVwyrAzKl/DLidUXnK4d6vTG
 G6z5rO/r9rLp87brTKgmAb6FlHNenAVcf75xARmzgOUgXHPd391bW9XnZDJy2Z2BzYH9M
 iKSyVJ14V7G8UgLs5FiR0nUTg1ChKbtY4ZrQ22SC9aSjINA+E5KaUulzFkJQBOL1KB/u1
 w8KJUZnDGEIF60J9f4/lFHX2+3FDULOQieKku2c2+wCRtZWNWcmTHC4pnZ1Ti3ZZkhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791986848;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=M2Gz1OsJxLF//BIYcLf4wdMusoVnMYPg4ng7nFLhAbA=;
 b=tUUsSXZA9Q3pyt52UhG39Xa320M4wIHSD2TdRzTYco/SyZzLUc8Kc5acgRnusA6nN564
 wzxMZrRhoJ55V4rGJKIg/VxEknkAcOveva7mEfBt4bAlXS+lw4bulv61/02Wi24Xuaar1
 Ju0fouLizTSjeJYMAF4KPcNwsRdYdkoc8p07OYtPdw8IH21QC7BOxpTbmQQ0OIgOSvEe/
 IzenE5TInYLXs4BsUJIeUXIRRVKUZyLx4CqIF1NmZbyRVKjEW/Pa9bAYCtAOkN3/E9gih
 UczOJpCFW4KuTsa5lbEyCPX+1Uopl9K/h4NFFV+CRYzJJ4wdd66QnTANjbMXaKRm17Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=hDtyIAb6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hDtyIAb6
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49F7280E13
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:07:27 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so553332a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791986847; x=1792591647;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M2Gz1OsJxLF//BIYcLf4wdMusoVnMYPg4ng7nFLhAbA=;
 b=hDtyIAb6J3BajAzoSKtU1qpht2h2g9l0lE+fZVvLRQy4+NlOOOsHEi5XpFLnyvigw3
 i0F4TdsYlLK6AuLSdigeTQ6RolhbDo/lbfm85QlGn1wLbpHpRLBVv4dFZvUVQCU8tp1b
 iOIO5T5ZJlD0363DFjmsU1t1tZO6fOjpHpyQt4/c++MjUm7gDyux8UWWiKFcVHhHG+rB
 H8cMvfMqgwlk5QuPSWIOdvkP4lxZgsYo0lTLtpVsaOGzpAwUFeX34y4nHmh2E9RkitjG
 FT4lhevJ1SO+qccDmQU6iEpOJxe+YCysiSq5FYICiRF1Y0dWsPaRPtkdVV3A74+QQv5w
 Ss6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791986847; x=1792591647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M2Gz1OsJxLF//BIYcLf4wdMusoVnMYPg4ng7nFLhAbA=;
 b=uoNzLtDmv7KkIGzcPR1oVMI/tUYMUFs+gJnzBj6FGk0HRcT3NbSSDpfVgOMYaQzrkb
 q1UA8bqAqtjn3iCA5kTdLpNA7+bS3XX1Z2K5PpwAIVy/pyRkPklpR5SRyPM1O32mVWZz
 Odt+1KvuRkqtcBUjtDSmINg+qJpLi4ywE3Xx3KGZOzpSxFnmXX7MDQY5Fm+LUY9adMgL
 sGrBGQX3BIho4PTlgMjOmPWuJSoDiFfyot4+OLL3v3cAu96Go02W3dlr55MppnD4QwNC
 n8LDiLqxdPf/iurPsRHCAtx2bbWyJ0gXC6lSzpywRBn82eRD2CZzvNfincdfSevt5Rhl
 /1Iw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDXv3nbQZmiK3nswaF1B3LiseHbx+cjz2X7+xSIVPWp7uLN6uooP92omJ8+AeIT2jiqTh1FH4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ3FYyMJb/ak85lDbgES2UMIBmD3cvSuJMPDvrjtG2KgpGsAa6X
 mSUC6L3XnLt5Se8WZIh1cv6bzEU1FfXbrWWi0A9s/SLVgfgSXxNYNj4H
X-Gm-Gg: AYBFou31MWdrfmyjbK+z7Gm2Obsxke35FSoG4IosWFf9DQBzCdspok6OIq1KLmLbJzr
 aRvB7opXoHqBHVTQ4jO//DopihDXMhLiOtKKEePOcnrh1eWsE4yr8aHpt/MrvAvKUaL8KlkQiup
 Kh+vrct8ANDY3LgQZxUOUqZLwXjZP7K7hHxdcJROJuBYWkI4Z0luzPifq2hPf7APg4//64LvL5L
 SDamrUdO2zvCSk4hCXNVQ/kiG39cw9z9VFKA0BEPrBYYFmS8iDxfY78XjmwJC4bR8lwm65HGtAj
 NwKlSUxg6m/bJpWIi0kxBbwNwramaRjz++QjncFmHZAt3bZpMv3MOw8aSkVWkzJsrqBN8ezzKwg
 2xsCSix/vuOC4vnGJF2ULG2/2lBzXHXWtpaa7qD2noONHhYy+fcSjbYVma/MO9kaivZynG4vm2B
 XlscwVOUlT7LTV0YT3Zq5tOWkvFg+Zf+B8MiRBkof7JxHD2iNvLCwD38OgeED5F3kN/4CpqRrKK
 unGNHMIJpQlfnk37vbWHt8j7W3VWaW6Q7t9qiB4bKWf3/6r1I1kABfq42LvkANIG2QKhz0uBLfr
 2Cs91dIZqJYqYwroGtLReuQkXhMsf77mUNO7P/uJMyN68HB/EW985g==
X-Received: by 2002:a17:903:37c3:b0:2e4:9fbe:f72 with SMTP id
 d9443c01a7336-2e842cf91bfmr137044005ad.44.1791986846941; 
 Wed, 14 Oct 2026 07:07:26 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b8202sm66885495ad.51.2026.10.14.07.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 07:07:26 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH 3/3] MAINTAINERS: Add entry for virtio RTC
Date: Wed, 14 Oct 2026 22:07:16 +0800
Message-ID: <20261014140716.1181882-4-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014140716.1181882-1-alan.tseng.cs@gmail.com>
References: <20261014140716.1181882-1-alan.tseng.cs@gmail.com>
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

Add myself as the maintainer of the virtio RTC driver.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28d090d3c..2ce94d7f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1872,6 +1872,11 @@ F:	include/virtio*.h
 F:	test/dm/virtio.c
 F:	doc/develop/driver-model/virtio.rst
 
+VIRTIO RTC
+M:	Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+S:	Maintained
+F:	drivers/virtio/virtio_rtc.c
+
 WATCHDOG
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-- 
2.43.0

