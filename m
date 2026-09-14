Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B2DC88E75
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AC5B809C4;
	Mon, 14 Sep 2026 14:17:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JHhbIynrxF-5; Mon, 14 Sep 2026 14:17:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 512E680E05
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395471;
	b=HUbbvvMxekxdOrJwAb0IAlSRMOavZfjkrxHAXHqtfBTNneno2lGTs8DlQCNJQrpVUPlN
	 PuvmXyntrBNbCfajsFbBzkOO2yxGzUQm+7bhtWp2GnF8vyKqM0qgcbhvWjJ1yeDFKH2Un
	 DZvnRnnGogrwfJHUDH2JQDe/AuqcatSaHcisfh1ilkKKwr/1giSMb2Ut5GvsNADZTTBc6
	 NdTm7pBmgKPhIcRFgwYUAfrqp34gF5UMyMlcLZD2ivuIEJDwcNqtLTP9lpkDloUWpuYcC
	 Wg9R0NiCUigxEOLQ+qnWPlzMvff9V4k55YCcGDQUNN/xbFa20rqfXW2r1b5+tg3Nbgg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395471;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+pn3SjT6sgKHpjkPXgQDg+kyMuGJKanUc2Cf8Qfjv4Y=;
	b=FXpk9pgjPNZsWU7jhyVUj35sLZ92NE0KAfSMqE2JnBz/gU1PkzGBUX7dlVWp2oO+CMgH
	 FZiZKHGMiImwZTZ7MVMAp2zVpqDFIzBOd6SBlxPuhce8fyo3Ibz8m24abWGn7+JyRLFrp
	 9cEMB/z4CKtCYcfb/ielG8qDXOTpnkqYSjh23FehOG+TZ7uSUYVvZnnmsrEp4lhM+UiHu
	 AXz2srn56UP/ENCi7pj9i9+w1x8aeLOKRQBR4/kcYGqld4dwSixeNoAR2+6uDmh68eD6S
	 /Z5QAjiK2dBNmswQwjvqoQrRU+OMNcOSGo0a5SPZ/hs78Pxyib5boHVIlUjclvup9Eg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395471;
	bh=+pn3SjT6sgKHpjkPXgQDg+kyMuGJKanUc2Cf8Qfjv4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxbVAXDQHQ8BkCSf7YR3WBGTJ0gjEHY28Wg1EYpbxVKjZIFAuZ/Dp2wKt9YqupGgU
	 8dM6GwKvH6JVUzUGyleUqeRrMd0wT2ps6R7YKddeqURBHZe/g47VjTfUldOH2n2uIS
	 Ksx0ggkTtV/MGFMgaj8EzJEZagbxZHTCH2F7mwgRx0bYufZpAfM3kcaAqz5mAuLYkR
	 JvpBHv1uHwRxqFOwb4rgSmWUOBS1Ze2AUlIdE5feenxNHiMyHpS8ZUUYyV7rFHvo6d
	 FjJcvUu1JBsnivd8axKLXIp+cNSA7LC/eg3AoeDAKVj1ghpSoRnIry4etk8Txl2zCJ
	 XGgmboePrrhxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 512E680E05;
	Mon, 14 Sep 2026 14:17:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BD73224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47C2D40119
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JyhQu-glL1YG for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 78A844011A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=dKFDXEhCkiPuAfOmHq5CuR540cMmmkS7wEBdpZAtNWFFr9M9IAqSEPgRp3b3wwDf8d/q
 FuNwwuK7KLGAQ4oNwvs+yTEErImW5Uui4+T59IniyWS0mROf14joPVhBm74NHpdYXqY0o
 06pUX1N/S5loQcUt1cWw+TclvGe/xL7VXW6Ps3SeErjIc6qfjwvFjmKw3a+BNoZg1fsGx
 ypoghrU4VhVRHhfuPke66xYNHJ5ezTXwKtGKaaW7dsKZaM4UX5Bv6fV/esTtyb9mQ3lXL
 ra+hJNXI9Y7BBM6MbTiFQC/4euooBw8b1y4+yS7dp9FaoKes3mM9+PMltlOMy7lSAcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=+pn3SjT6sgKHpjkPXgQDg+kyMuGJKanUc2Cf8Qfjv4Y=;
 b=JdoFqgXhgDF4Ho1iN+AmiZhOW858XPIn3TmaP7VLbw7DdvuUsuI4TJcbbTMT7klQBtiD
 Ubl3LOuat7o6J58NosHSwAB7oRZXUvh5H9Q3DTqZtkeQBN6AdJqr15u9Zbi7NibH2Ids1
 ezn48ssM0qYmGP9vWiX1wLiEvTt22ssgmGP8mcUopJkVkzlbGF+EkEZ2MCZr1FXf2iK3q
 RIkI1wcr7YOpQ7c6fJk0WLnLmtkVUgVh4c9n6WSltvoT2YQoqDXa2aLl8gVfHy717WiHE
 CMTyzwj66p4wOXAzLQifzuwafvNjMcyqaUDZ+NFyNVw81h+ZzB2VNLxVeyah4xjtspQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=i4ueqwyd; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=i4ueqwyd
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78A844011A
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D061B2008;
 Mon, 14 Sep 2026 04:01:53 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0315E3F86F;
 Mon, 14 Sep 2026 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383717; bh=HQOob1BMR1piQStqfSkEMAfs1vFIwEJXi11pktCriPk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i4ueqwyddgVfcbyLyt/3ChKXhOfDVgKu9MbRAMH+zUgajlAAGjUy+pDSS29UT+bAa
 5Nr4g4AKJiQDqWyuEKyaJJdQIFYlXggB0dDEIvOmeypX+XcsFPdOQUzx14ixTpHGTV
 AwIjaUkmHdhD+uTRaqkHbr4BWtVL7US8+lsXUA1s=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 17/22] charset: mark u16_strsize() as __efi_runtime
Date: Mon, 14 Sep 2026 12:01:01 +0100
Message-Id: <20260914110106.1974894-18-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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

Mark u16_strsize() as __efi_runtime so it can be called from the EFI
runtime variable paths added for FF-A/MM communication after
ExitBootServices().

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v2:

Simon:

- Split the `u16_strsize()` runtime annotation to a separate patch
---
 lib/charset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/charset.c b/lib/charset.c
index 182c92a50c4..738ad1352de 100644
--- a/lib/charset.c
+++ b/lib/charset.c
@@ -407,7 +407,7 @@ size_t __efi_runtime u16_strnlen(const u16 *in, size_t count)
 	return i;
 }
 
-size_t u16_strsize(const void *in)
+size_t __efi_runtime u16_strsize(const void *in)
 {
 	return (u16_strlen(in) + 1) * sizeof(u16);
 }
-- 
2.34.1

