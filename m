Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4657C98304
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 21:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD444412FB;
	Wed, 23 Sep 2026 21:31:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c7veMmLnnvOV; Wed, 23 Sep 2026 21:31:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0B04341317
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790199072;
	b=nQK3xazaZ4679IDIi99b/bN52cH5gDdYL0OMegKmK+yTvWIUQSgXP9y5NZ06J2aEq8Ct
	 5nK4u5XLjfRSALzSS1iTu8mmNH02XSebCb5Z2icejD2czVMH9hffZHRpuwtfj49sxKhXU
	 evFIQSV9mRtUnTT8VpeBecDTVSXJabDv2WB+X2rm8OpbGwEQu2ZuETvXSduZtWRWuv9fd
	 80d3UDHZjtCbpEDZ8ApRLo1+nIk2bg+qrayyguBY3wvwzYhy55wzLDGnIdfmDWkugQcF5
	 CI0gS5r6Vm3OxM1UcDIAkxxC/Vzu1vXBWc7O6yLzqFU5jenWWZaBea5KE7dyO/jtJhg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790199072;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9jAIEvRPn9jTEJAKMw5I0M0D4fke164l8G4vsKpqDDs=;
	b=o5gzu3gZOSV2z7PZNkCQxTanAaQwNUBnPaJG3tDuJ5KGsgxkes4NfFy0QsI5lX3C4183
	 svxTYc1swJ1Rzf9fe4hahhmZH2F/vkipWgbBSLLSbMyyvKci6NvNFRRPUR3HXfj0ZBu9D
	 jeu7mEHDk1mKmQm3OITXe1FIW3UmjJ60oH4blPyLfM127KmUhEwyFiX/ubhOWoprEpZmM
	 +6WCpqamPLTVOC24Kc/wCduMoicoB7YauW0kkejSO3AKyvL8FvU0bq/7Bxiwgz75Yh019
	 d/I/efz33LU2tQeN4BzfrqIBDml3H3FX4BGApflP0gn2I3aYH75Dye65nZN7WRYS1gQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p7A+ShqJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790199072;
	bh=9jAIEvRPn9jTEJAKMw5I0M0D4fke164l8G4vsKpqDDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zbSGlWqMESyYi0OH5Y3krOmc9EaPaSN2FEdSrEwavOXnIBQj+Xj+RP6x1RZk9N9TZ
	 6dIRqHGzUoMcjrTjH6FvH5H7299p4hr6pCtd/dXmyc2weMeo/yVHP/qfFqgHBXRnMu
	 j+33JgQdGNIsK8zv4kHGjGe+GcSFgAVk0RPf46VhrBPNmLGlvuNAZvuB8ICUZ0DHxX
	 vaJ7Vch7oTzFO+NVLwbiswjTli55ZjEN2bm06kRMScygG7RC1Omo30UGneaVsA8QT5
	 O35C5lPyhJAfFhh9tc7CUrgEUla4Y+/se8WvTiRtlP0Ac+Rg8h6HFm4gJttLhp16hA
	 amxqi8DmTLdVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B04341317;
	Wed, 23 Sep 2026 21:31:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 03D0728C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:31:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA07D41358
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:31:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D-hp2mAMqDC9 for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:31:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 60C3F412FB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790199070;
 b=DrhMckrAjv2hnymRBPRZ0hOlu+gRhTneMXzvl/c+r9r7NKdXBsG7P1xkwx+OivScNRmO
 pfdQBiuVKyMlPbzu522RovbFssUxVXOKpKgMhXmo2u2fDO11XiEBLrgh0RtCCm8QgUV5I
 RHIWw0OPRjy5OKJHr83MrimX3MlV6/T8iIcBuNF2L2Bgi4AfRTYjAcOC4nM03lHg1zhk1
 SFAOsPHU6x0eFhDBcs7ueIBqQ7hxn9L6CSqJHZ9YwzmuB02ToIjTzlujxvvFh2VDQMso7
 OruilQVSgRGLmlrJ/Yhn5bK/LkJPB7cVWgv2BxBRJQazclkne3pJT6mMtdOpSbLoqXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790199070;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=9jAIEvRPn9jTEJAKMw5I0M0D4fke164l8G4vsKpqDDs=;
 b=WDDNgv5uZKqTdJAYXeKFZ7ociNFUs9btpqW0IthPqo4lUk0I8kJS5x6f9ViAgkyOYwCw
 TObQbImC63swSr0hvdwPlumu8KyLoXY9deuGQtGfa3hVYOk+D5ydgcZUAgt3bUUfEy0LQ
 Wy9IX2/+7nDyOOt9lUbcr/gRb0zthukRWY3/jzPC869/cfujt7kdaeVijbbxhF2BRbn+e
 YN7AcjWKJha5U1r00USlRa1qzv58houciTlt8bLRoDBpfwvDnOhn+qPRDK4/Of8tEVHzC
 l4IJttIBRO5YqwJwEJudrE/b8JalzxsVbh6ZF+EURgvEE30e1hn/dNTSsHkLVXJ7XOg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=p7A+ShqJ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=p7A+ShqJ
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60C3F412FB
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:31:10 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf02so819803a91.3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790199069; x=1790803869;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9jAIEvRPn9jTEJAKMw5I0M0D4fke164l8G4vsKpqDDs=;
 b=p7A+ShqJRr9S/U1TQyMwoxG5C/erS8Hi5Zqck+NKJESPr0NXrqieC38Gs+aqIb5ZUg
 OPdw/ZektHr/22awpXkZ+0D3IH+kZA31tdkixH9flm2KmAfx3MIrlGW3afxJ0hBGg3bS
 LBjMGv3UrPNCxNum87CvubNUFmGYXKdm2RZpRqeKLz79rIrnepqLQ5j9/nDwqRZ2a8Ns
 ECdlENkEGze7K2fZXHZ6c29FDE4r70SDT91hnGzww5NeDyyaPECCvQmvdkyyLn5lBfBL
 VfS3AnoHA8Gxw10RCIzP+cI2nvtCuO0cHxWMyn2zeT84b3G8p6MxbDxZ44vPwkPSxUI+
 XHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790199069; x=1790803869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9jAIEvRPn9jTEJAKMw5I0M0D4fke164l8G4vsKpqDDs=;
 b=xanZQ5yxfkiwrHOyZDEJbgpoZT3i+7NKhXtAsztO6gSPX+mK77Qo8uAGV3hqkDujcJ
 xA5dbzBfS1TU886CmLbJG9aewBSZTBBYkolYxNzvjS1OiNcxnFpBeII1hgcTHehN/aqC
 wDk2p1CfYq209hqm7mD8F8YwqIAMkV/ET3igE4tk5608uujqtH/WXILVtQsmuEG/s4eg
 mFhyZlOBEgsLwRNrFOE0DhigYpXfwy7dTz//jv3Pgai3n3LfzUsSi1ne70/V6RST70Qj
 JxlmkWzsRjnHknAAOIqidCOFvaUFwJlp+Xvbgd2LpIrEol3Zddd3fjq/0YrpOFzueV5F
 4ofg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGDeHqU1GvSQrRATDX9nmAccTQHViCL+1Sr7EhGNkt++GKqjZpcyV6E7qWdLBJFLxrHg+b/cE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n66ebSQP+WtOrxYN/KW/HPuNUFrJmsPJJRu3upQYUbTPOiYy4I
 aVnbO2DK34PsPJ8HpDDvYS1RexBM6/HK1qQ9YHjBV6PkCeCjfKYZLsSRUkyIVQ==
X-Gm-Gg: AYBFou1DJHBPtJd3fjH1FMrxfsdC6BP26ZKYfCvlnbM90mFJjLYhyFnKJhl9kpvJygt
 iRmnEplmPZ5J+igCKFaX8qJl7jy3uMOcd2hRzekLdG/BfyhmgjKhcx7FVdEwAWm2bxbcQEz6jhK
 Y5lF7v09ltpDbVfrFMOmLeSKM5K89a73hBt8XmstsPC3DbcuSafDlhcq+gmPbjiey+0gEXT2BEB
 NpzqOzLk/HpSPQFP5QrV4VlS02TQtkTlGpNhXleATRNMVCtr9sANXOG+Up66qF8NEJ7k6YD+9+B
 H4YNDYUkGWe8uOUSJ3SgTZKVZXLK66Zo/xlwREJMomz0sz3pUxf/EkiG5gYQ/dXapXXd2hvabNE
 ygDBtW6m/MJATNZn5oWHhj3PLDCDEV2awU0yOvruu0Jdxcwj+04xg2ujAuV69fUcmE6QMGwplxM
 NzNR5CZYLRj3yRCAYKiIxJV956NijdB1rDFHwth1cRnzDdAWAmnupU3DKpcKQVbQh3nH3YoPCxH
 XvtbnLMLg+yVXIpIVCYD3K10UmxM9wO+NTBJwNKF0AEslowXzec4STQHIvZRgIEqVqxiE+ExgKw
X-Received: by 2002:a17:90b:4b83:b0:398:990e:1587 with SMTP id
 98e67ed59e1d1-3a0986ed065mr322221a91.9.1790199069543; 
 Wed, 23 Sep 2026 14:31:09 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0973c4fb4sm909513a91.17.2026.09.23.14.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:31:09 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 6/6] MAINTAINERS: Add entry for 9PFS
Date: Wed, 23 Sep 2026 21:30:02 +0000
Message-ID: <20260923213002.1070404-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923213002.1070404-1-visitorckw@gmail.com>
References: <20260923213002.1070404-1-visitorckw@gmail.com>
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

Add maintainer entry for the newly introduced 9P filesystem
subsystem, including the protocol core, vfs integration, and
virtio transport driver.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index acaba95ed03..5bef76bc43a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -50,6 +50,18 @@ so much easier [Ed]
 Maintainers List (try to look for most precise areas first)
 
 		-----------------------------------
+9PFS
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	doc/develop/pytest/test_9p.rst
+F:	doc/usage/filesystems/9p.rst
+F:	drivers/virtio/virtio_9p.c
+F:	fs/9p/
+F:	include/9p.h
+F:	include/9pfs.h
+F:	net/9p/
+F:	test/py/tests/test_9p.py
+
 ACPI
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-- 
2.56.0.rc1.310.g51773c2048-goog

