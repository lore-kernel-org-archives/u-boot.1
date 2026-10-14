Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47279CC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 121B740834;
	Wed, 14 Oct 2026 20:03:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ItBHLk-ZC5Ps; Wed, 14 Oct 2026 20:03:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6CA67406FA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008233;
	b=GdApB7Z3SbKmfRaD6rdS8a5wQC/89aF8EZytW/gMKTheMIlEywitE7+STub1FTljEpjG
	 V2W9lSCGvikC5Z9NLubs6fgjD9Qxr6bKbnv6dmVuRi4aE2sb5U4yHn5XA9KgpuzR5/swW
	 urzJgPAeYAS/CA14Q7H9MrFdrb5DhQPGVCwW9+dTPTffG29lVf2KtszoFM32wn8Iyqxcl
	 EYFkmUUYKPBatQgeYMlcP9ZoTJxrxqkONUqeEPvu+z9iglNYeZ/1TqniKWPeWZCJcpNra
	 yTFHt/RyEFZeugABimIRImkeMZUq0j7FByIMmb7oTpqLOGrDO6EenpG/MH0r4OcRYTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008233;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lCc/Ut2/exfbyzJGmsBnYjjuH1EKQesYbOb9CRddloA=;
	b=UlnLiR2Jqwg+y5ljuU0T6imAKZkJZS4h+OpZl3ZDsOKivUc+wvpH6WRJNuiEWU+exhHY
	 5LbD8j0+1zQPmNAAtsXKWrVo0ol4k2Dlzg6KNGezWEcAWgrf85izM1dK0phuGYz85M6b9
	 KoSTfhdCKLF1P4N0yO2HAHz5nl3MXeGh7ZdQ2rh6SYnKwUkL0FgqnmMR4ml04KCm3aJAJ
	 rnLO+AjL2gtvEM8KCw7IYqUDB4i506XQ4kai/+0kivQMIb0a33su7vyN2a+4NhazpEXDo
	 z3MgldJSfveLjCbfNNRPNE25WShE+XUKJFllpuJttMQi5xBzMbzKSE1mNibklMNC3IA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008233;
	bh=lCc/Ut2/exfbyzJGmsBnYjjuH1EKQesYbOb9CRddloA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q1tvnzNVkx+tqik92Cxa515Cuak9uf7rGhmQ486my8l1cX5K13rpAFaVVf3orZwaZ
	 eXorXXJ85+KtKEuPBQgSFNJ0adhMVzlaOWb3qj7MtkT2VeWFjGlMsMlTuzEaiZolFU
	 HZckHKXt4VhZvgfnEKScxo4X2Zn5nC0l2xXpBv99z5cUofiIzNwyRRWYujRbylWcT5
	 Vb2LQZYxdsZI2jAiFafvRIBqV/Usx6A9odA/j79ha2MqMxTO2IO5lD9xhaPRdvlxTX
	 ua/VGwA9gEROmsbyT8mH/TBgRKWURLCKq2p2RvceAiR4quVgK0YEY8lQmw7yNcFpsY
	 kIPrt37zsaM3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CA67406FA;
	Wed, 14 Oct 2026 20:03:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E0132AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4FDCA4009D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZeiCsGrdBke for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 78B3E40191
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002220;
 b=gVgA+1Kr+0zDR4yCaZe17LSxhMRBfbcheNCPVNFA8moMwM3mja0I5a+zMA/bL75ITV+n
 iTl7b393wheDlCU+N9CAwk3dyoO4QKOIwViqbXuVh3HSJUkcRD7gWEIbw3o/J0ya51sdg
 sQXcgtD/xCvcEs7PNSXAVSW3h38t3z+NwzwdfVrd/hyI2gg8HDy//Ksog+cybAKmWS1gE
 iSOd1PnPpw21exRhDLW7H455xvWhDzbTlLsnB8nPhG2dKc9nplLZP3cNgxrLLVVR1et6l
 6YfFBw7hoDOLDCIvDe/1kd85do0qi7GYjvLlp/FYKC7HF9YmGNKcGBYXYDug2mrKGmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002220;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=lCc/Ut2/exfbyzJGmsBnYjjuH1EKQesYbOb9CRddloA=;
 b=dx1XuJlefCzWXKd+NCUK1OBldzh/ZWxnc2I0iBlIiyYYDuj/yDBegBuDDvZHKcT5F57J
 LF8VUXFn95QXq5vsvuGpx5C68AGg7reUtV061SRYHZXEZMlNyXvsM2Yd2T01/hpkwpzjq
 DInmPE77Xq6RB/UH8ogE+DWeIfPypYmTxGrRk0SI73MfpJ1OwWwOolobGmGqH+p2jPlS/
 mVffpqJHKYG7oMhtBXuW8p1oxCxeVcI8M66gvZdqPgW5EZyJdSOdGTrv6vQxmi36qO07v
 gzhKfxIJZw1WuGWCDyY+33Wnr4CzDxcmU5vqJjFfTGk99aTdIPh5RmheOpUquBfrsww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=fnXvy30x; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=fnXvy30x
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78B3E40191
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE72F153B;
 Wed, 14 Oct 2026 11:23:35 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABC973F871;
 Wed, 14 Oct 2026 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002219; bh=JLfYVRSgb9s1J8NREgbmfU9RFQLErYj4nHkbMong1Cc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fnXvy30xK+TFfmoD5P+kztagG7HNFl8hgwAgFosy68D1nYR+XuIlwb4rz7nRmhMTa
 nHBg4a/dxvgIaISmDiwquTUhS0EA1LDIMmpYHIHL8ukG5HtpVw2kg3Tcwl/Oc1iSh2
 glxVXB5S86tFrp3Hkt3qPA+Wyd5PIsYV6j0AZeGQ=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 17/22] charset: mark u16_strsize() as __efi_runtime
Date: Wed, 14 Oct 2026 19:22:57 +0100
Message-ID: <ee4b6c97e1063c2836397c6025003920bcf25e7f.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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
2.43.0

