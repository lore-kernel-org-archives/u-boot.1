Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CD1CA5FF5
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B489F40649;
	Mon,  5 Oct 2026 05:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lyF6_h9VlgKh; Mon,  5 Oct 2026 05:12:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CD36D4064A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177156;
	b=HEfH6xeWPpZkfqBp9fPCGF7QHzyKqUqFozZhRBVzaGdGvUHiL5GcpU6a6TodNCA6E6Ax
	 lLEdcoc9U0P3SLCQmcWaGO29Ep5kgLOY7nXLnChXJOJPSxPLSmqv0+SWn/9Ia3aTzgNv/
	 Bof4QUf7AW0ASB8z9Oyeddayy07HfYMXuzg7vFLfKpD0DhCSKArTG09YHToD8bPoxsSo8
	 R1CsDCoKPrO8FaccM1HkNtc+aiMLrD8Masm9PDmgtaJUm5Zq6DcCNM8M5UMKootzjIc7U
	 hUGr5OocMCgrwTcvfcXwvykEEgAes1HWY4KpMYwJWKwNUWmk0NdGd39T6rpoqwfSm+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177156;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZDoDPPP3UKxPWTjuofjxif6pGhAFCaLOyWNn0LkrnZg=;
	b=P8HcQKEGzEwOVPBbJBgAzdkEwMS5gSqJNYKdY3XDzBDCVNi9goV5KxTATYgzP/7twl5G
	 Qzkayyi8BdA0+vdPdoziQt/5YZtApopSZ/VmMXKf+gRmhEELSRAwlsFuGjqa70yi2kyDb
	 vwt7hC0zNavzOCEsdkgHVOrKwkFdt//WzWMDMR1Dgk/ihkli1r6IOHxiqk8MA3cR2JArJ
	 2yrGWFvAfYR18JOZzgXEXnmf9NL1DjTJZg6BhbGsiNvmMMwDbVqkkWh48XUjzdcpmMtNL
	 G6ze2C5ptaRD1rGhpeuiafja4OsjmKiUipeCReDdZIiQ3GqLSt0a9xn92EmEg/eyCSw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177155;
	bh=ZDoDPPP3UKxPWTjuofjxif6pGhAFCaLOyWNn0LkrnZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ba2lT0dvH3FSW0zxF1wRKA7JGXf7gX+8ZHAjQ+8xrrwyXA4PWsZPq9afUrq0pGK68
	 IXcD0fUYDbECzG5Uk2o8oPrQlQm4ivRYcbzVkRGawAr5pzqXdC4lTaFGCSszOty8n6
	 DKSPYigHp0UAXhYGafkBC+3kgrB+WW3KZX8WYLdLP01C+/mzP1KTz9aEeV/FaEe/s/
	 qkNjwBFc4yLrLHVbAl9rODhNwNIHaHR33LsCi3vyyik3PXybWAj7+Bx3kD71GuSXLz
	 bGc+JAce2tlQG18CJH0Wnv3iy5z1/2UQIdY33dqOrCrp+3Gyq0FDSyQ3i4h1L9PzDO
	 LBtHdpGAERbmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD36D4064A;
	Mon,  5 Oct 2026 05:12:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DA0E9335
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC07040068
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vEtc6Awidi2H for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 15:27:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B693F40049
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791127652;
 b=LyP98eV+Dp9K9tdGmBy9q6hklyk6GcLcPRpDUKfmxF7E5vKgXKJ9EwHXfJ6mmislJbuQ
 8mVFqCQTmQT4IOV0jPvDrs8cOWyD+3Hrr4U81hxWRJuvVLt7N89rkSVelUmzc5FBs10da
 lAaNGsMWfUBL3yl9MLCqWNF4n7Hysyv5InSzjV3CV0HHZpkditRTUUBFK11EMJTu0HOdF
 jxQLL/PqRAQP3rxWOtWpW1qHlTyZro0gKQLEw8NyduZZrJrP1IIsHauSy4Uu5ruS3QybM
 PvZhSFgagGDetuvcQO1v3GS3pshakE+Uh0n5hYg9xgR4Y3pcNZuPiaYfjS6KhWiuz/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791127652;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
 X-CM-SenderInfo;
 bh=ZDoDPPP3UKxPWTjuofjxif6pGhAFCaLOyWNn0LkrnZg=;
 b=lQohQfmcfS6glwSDQ0qeX78pRFTVE8zxL5H7WjD/VxLsDjma3DmPqwnpIBZHU1/Lz6Wq
 o894GdBOMF1bOeqVtr92U7p5aq/jrX8hnYmX/zU8W3kvvlnXF+ac3jMwfSgc7imy8GBYy
 FMNTEmLMN6wLsy+urWtI0Ug2gSO8R11P3gKni3PlUhn+8pYceTtr4RgXvyNZcZ36Un31U
 86wQr6qJu0N15SOX+YPA1gZA10PzYxkA2rI410u9kUb2Q7RrvVRyDHrEB9KCubVZjjEwO
 AtRGgfTGWvwiQRnIKuOV3R7UOvmgpdtJob3+qeLQbOuBtngy6SlL2uH9QL0AvzlYEww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=f6RHX899; 
 arc=none smtp.remote-ip=117.135.210.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.a=rsa-sha256 header.s=s110527 header.b=f6RHX899
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B693F40049
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZD
 oDPPP3UKxPWTjuofjxif6pGhAFCaLOyWNn0LkrnZg=; b=f6RHX899xckLHkBdcq
 kWQnh+TVRnxRz0E4UI97X4+U6Vb9lfHge4f8mIdRzK6PDcaBpV2RwZX753ux/46e
 q50CjHBKNX9ll4HcKS8rnNVRunoTN6LCvtsfPBNr5Uqyik0U1xtplIiwQ6smZ4q/
 JoWCWgURFCq3Qq8MxNYj4Wskc=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDXf95TcMJqQD0ECQ--.17534S6; 
 Sun, 04 Oct 2026 23:27:19 +0800 (CST)
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Xiaoyi Suo <18102059357@163.com>
Subject: [PATCH v3 4/5] lib: mbedtls: sha1: use memzero_explicit() for the
 HMAC key schedule
Date: Sun,  4 Oct 2026 23:27:13 +0800
Message-ID: <20261004152715.1574-5-18102059357@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004152715.1574-1-18102059357@163.com>
References: <20261004152715.1574-1-18102059357@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXf95TcMJqQD0ECQ--.17534S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWxtF1rXw4kuw4UJF18Zrb_yoWDtwb_u3
 WkAw1UKrW5Xws0yr43Ka1UXrn7Gay8ZF1DCry3tr4UZF15t3yDuryku395Xay3Gw4avFs2
 9rsrZrnIy3WSgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRX4SYDUUUUU==
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbC7hd8F2rCcFdz1AAA36
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:02 +0000
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

lib/mbedtls/sha1.c is U-Boot's own shim, not upstream mbedTLS code, and
its sha1_hmac() has the same four clears as lib/sha1.c. It is the
implementation used with CONFIG_SHA1_MBEDTLS, so it needs the same fix.

Cc: Tom Rini <trini@konsulko.com>
Signed-off-by: Xiaoyi Suo <18102059357@163.com>
---
 lib/mbedtls/sha1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/mbedtls/sha1.c b/lib/mbedtls/sha1.c
index 2aee50377..c6b92fbe7 100644
--- a/lib/mbedtls/sha1.c
+++ b/lib/mbedtls/sha1.c
@@ -92,8 +92,8 @@ void sha1_hmac(const unsigned char *key, int keylen,
 	sha1_update(&ctx, tmpbuf, sizeof(tmpbuf));
 	sha1_finish(&ctx, output);
 
-	memset(k_ipad, 0, sizeof(k_ipad));
-	memset(k_opad, 0, sizeof(k_opad));
-	memset(tmpbuf, 0, sizeof(tmpbuf));
-	memset(&ctx, 0, sizeof(sha1_context));
+	memzero_explicit(k_ipad, sizeof(k_ipad));
+	memzero_explicit(k_opad, sizeof(k_opad));
+	memzero_explicit(tmpbuf, sizeof(tmpbuf));
+	memzero_explicit(&ctx, sizeof(sha1_context));
 }
-- 
2.43.0

