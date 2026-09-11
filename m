Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DA6C88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:47:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D25F40BCC;
	Fri, 11 Sep 2026 10:47:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hu3-QbKNTSIs; Fri, 11 Sep 2026 10:47:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6FC9640AF6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123645;
	b=iHIPtRu5cO4k4Dp3bZjpe7IbbXqfEE8k9dRoGzso2hhvKQbtx1rKGQZNAshYjxcCxFcb
	 iFmlJrXsFrFJ1AuNA8oHrJCpX6TqfUQG1IyhtWdwhqIEzmpOfwCwuQ5aJNhGYpYZkW/Qd
	 yA2C3vtE8TP59YacTueHYNA28BfZp22C6g5j/WVwIf4XmqJo1eXdraT/XPp8AM1D0ntoq
	 6yisIH9siryj2O2O3OKWXahUHjLzMwC9Nlb+6uNUx2+2xpwFQghEfzvhjI2ViPq+Nc94i
	 frf17AgmEs7clzy3BuU2hA22Ye0Xr/B6jAVKg550506N5fh4Dc2jRa4F8Y7tz0oXC6g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123645;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nbRgiE18HzSdxiV698TAHSk4a3jUhzT7n/zri99PrAM=;
	b=svbcvBdnAxIUhBCZGmaiyKUQnTbUZT+aL83Whkr1GqIGaSR0c8bh+6n2WLb5czrlYFvr
	 /fzQILtpEi8VrGBYIvQyCm7dghC066il/FquxjJEUHP/E3g5FW+tV722moecUKn711cjE
	 aZ2g//O0jNVyRmK+DZqnNlj/jc39leqG3d1IVCfTpbOKWiWrj9B8SJzk9QravKgOyzEGB
	 heLy0hQpR0MtZmadnf3+EBWlZs8l7UZudogSC6yvVi9CDIDvkC7BSF/6HM21GiDzgHsE8
	 tBCgYyqhByc+dXjJEHyzBosmJV+zVCSDj4hElV2+gm4lty4mjcGQsMIa6RjWc2d/PxQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=C54mVUmi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123645;
	bh=nbRgiE18HzSdxiV698TAHSk4a3jUhzT7n/zri99PrAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nL2CqWEih0HdR+sUKfuCiJ0H7JS6bYSL7VO+OEGvQgJqxTI1eSnV6J6XbvZk88i+H
	 wTSsk3y54v6kkZo0vrmZugu+UKE27G6FDDlHPFeGkb62THTnOxfvQu4BAA/vjwaLPP
	 KnWQsdgaUr6kEXGSMTPijypej1MGzy/IloqagQ1sQto58/tpRbd9HGP8EumBe2200H
	 OMmqjNq+zYd/nqw6MJ/FONbh/CKm7D5lTFBG4pa9QQ4NpUxrVxZv3D2FBLLz45XhA6
	 GCSRVuWWBjmSbr6rzrWcDtT2T8gQCUv5RLe/C6KNFoX/WuSuyc1yyImyV2yXi3zjdS
	 ngZvTyUZ6EB3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FC9640AF6;
	Fri, 11 Sep 2026 10:47:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F00914C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:47:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80B0740BA2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:47:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MvNy6RpozGwO for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:47:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DBCB040AF6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123643;
 b=MO/W/3prZBLJvDq2jzda6H2WqGEhM1EjilPyubsRAo/H/Wmt0dTYnPSj18eI7mE/dOm1
 FcRrZ/q0hZCwsAdh1JJBvWC+9xkjGWBymVfmaOw2Hl+Snojpa8SDDbhw46Eb8S5kOabit
 yxWI+V6y+yfn4BmpXuGTf+H7+o5BVGYAmIY0FQVB87XCGuAzvh7YEVp/ryL6F+nApi1d8
 XnLq7cfKo5NsHY+ZsAaGqjk3I51+6NHWLoIJPQ1Us2ltQOrevL0no9lk1Mgg8fb5It1OJ
 ms0S/IZJi8lZEILoUKYKIoJhMbH+ejJcC9Vo0Zrxx94PiUt2vsK7vIVMn6Shg8xL83A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123643;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=nbRgiE18HzSdxiV698TAHSk4a3jUhzT7n/zri99PrAM=;
 b=K08db2qtbEBUCjVNEEhsCvp3QYyuFDxz0aHeQtZfwUN3ptx63doZiNhvH/gviprYKWuc
 FZgAMrC4CRkYjUPimYgQXBzTQdwycBOYSaN6fqYm4WIXHb6WrDU1BvoyHIszTc4Xb55SO
 29MyYTOedrE/+F1f34lhUz5CwJVI1ME0iHSEs/IcjjZuCKxPUATQcSlDT7H1mB2rxLIjo
 Vet7S5sasqxxCy0ANufU5szKNQv3jcXeXxSHDI2/o9rnWBw5B7aWbMNaB5PVsrbd7q2NI
 7L843lB6YnL/RRknL5CWOOokd/HigF9rmdouZwZISk6iBkdU+VrmmG9+4ilYtHaSrmA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=C54mVUmi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=C54mVUmi
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBCB040AF6
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123634; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=f++RdrsIOTK2TdNBfIQ/WAg/OHP/4UAZFXvgsv6thLuGT7pvcfNI/xVgI9w5WtzNfMHMlNrI+r+c1LAUENCiYYl9IDthdyblAJb1D+Ey7voJdeZWtMnDrj6pNIspuBDRs+kqp5cdZtwHleUL9tZxKX3tpabFh5EDdSO3NI4FolA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123634;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nbRgiE18HzSdxiV698TAHSk4a3jUhzT7n/zri99PrAM=; 
 b=grBQBBLgp8G48HEluTtjzPltY66Uq8bVFIArNWnXlxw3ZGDODWj2x3MSGhBNhZx1SbdDPO6lqmOwqjXViDE7uSNeD/7uKRybYZ9yPr0ygc8LrMEbeJ6hwD/hPDA7IUTySll/uCWkzd757DHOL21fMvJLtCCVcHHulK3HRPk3GgE=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123634; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=nbRgiE18HzSdxiV698TAHSk4a3jUhzT7n/zri99PrAM=;
 b=C54mVUmi2EytVesoOxSIjBEe6f9lMBqSCqH97xERBwMKXuBRuobmbYzwvG7Yjizt
 2nHjlD7azyY7HxBYRiiICOkDYPHW9edBFqQK0PItG86+kNae27ccpzuIm9FE9Ug+0mn
 9+sdQSFdbhUr9Q/OIWK9OBlOkVnA+5t+tNdpuQ20=
Received: by mx.zohomail.com with SMTPS id 1789123632423880.0549535815608;
 Fri, 11 Sep 2026 03:47:12 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 05/19] image: Define IH_ARCH_LOONGARCH
Date: Fri, 11 Sep 2026 10:45:50 +0000
Message-ID: <20260911104604.2910944-6-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Allocate the next value to IH_ARCH_LOONGARCH.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No functional changes since v1

 boot/image.c    | 1 +
 include/image.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/boot/image.c b/boot/image.c
index 185d52ba492f..fddbf01e04f2 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -86,6 +86,7 @@ static const table_entry_t uimage_arch[] = {
 	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
 	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
 	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
+	{	IH_ARCH_LOONGARCH,	"loongarch",	"LoongArch",	},
 	{	-1,			"",		"",		},
 };
 
diff --git a/include/image.h b/include/image.h
index 0a5b04d71ebc..e5d1cce7d67b 100644
--- a/include/image.h
+++ b/include/image.h
@@ -139,6 +139,7 @@ enum {
 	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
 	IH_ARCH_XTENSA,			/* Xtensa	*/
 	IH_ARCH_RISCV,			/* RISC-V */
+	IH_ARCH_LOONGARCH,		/* Loongson LoongArch */
 
 	IH_ARCH_COUNT,
 };
-- 
2.55.0

