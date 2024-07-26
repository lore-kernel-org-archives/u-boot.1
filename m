Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37780C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED37C8862E;
	Fri, 26 Jul 2024 14:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="gsiDpxM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86150884F1; Fri, 26 Jul 2024 14:07:34 +0200 (CEST)
Received: from smtp47.i.mail.ru (smtp47.i.mail.ru [95.163.41.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 901D48304A
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
 X-Cloud-Ids:Disposition-Notification-To;
 bh=huFUU7WjP/zT42uBZjr+WZVT6yLV+Bwyt6pHLtI2BFY=; t=1721995652; x=1722085652; 
 b=gsiDpxM9i1Ds3ufTAzW7SKER9Qm/qNo8HhQ6Pa5AQZDQhu3KjzYXEDFaj4sz133d2xw+UsP7NQK
 Zfzw95xuqOyi8p6C/NoOAkWNLZSlsm8cs6PBXxY4riu0Ymc3r6oGI3URz5Bgp4JI6y8ICBEHxzlHz
 UClo4AkTgqzRBlcE3QcT9jWgEUCb4aexelXSiw0ckhzX02EU0GiCfz+bIe4LdDmmHbD23q+LVbK1B
 Acr+Wh2SmAPaUp3uL/15LVSBNwadlIvJjaFSlzYdKwMVr0Ias/bnkxNbLKt9Cw0xrqD9pyQ3sNPl1
 gM69zERR1WyKJ/FUiwY+HdVhrFl/yiC8UJxw==;
Received: by exim-smtp-868bf69f6c-jmqbj with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1sXJjM-00000000SKj-3JST; Fri, 26 Jul 2024 15:07:29 +0300
From: Maxim Kochetkov <fido_max@inbox.ru>
To: u-boot@lists.denx.de, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com
Cc: Maxim Kochetkov <fido_max@inbox.ru>
Subject: [PATCH 1/1] riscv: define find_{first,next}_zero_bit in asm/bitops.h
Date: Fri, 26 Jul 2024 15:07:21 +0300
Message-ID: <20240726120721.150484-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-868bf69f6c-jmqbj;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C64F981000A099A673814E7FD5A941394E182A05F5380850406FEB11808CCA91CC3DE06ABAFEAF67059A07A756A89558385FE6BF42C7EEC79F77EA5CD51374AFCE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE782A779A89F7D69B2C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7F095E3787A950C88EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B043BF0FB74779F36DE22D8A5E8FA8375561BD3EA19457CBD1C4F90EADE3E438E1DF9E95F17B0083B26EA987F6312C9EC599709FD55CB46A62CC0D3CB04F14752D2E47CDBA5A96583C09775C1D3CA48CF4C82C86BFC697D19117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE7A6779F98BF527B7A9FA2833FD35BB23DF004C906525384302BEBFE083D3B9BA71A620F70A64A45A98AA50765F7900637A451E1E29F2EDBED6D1867E19FE1407978DA827A17800CE7649B83402744A6742DBA43225CD8A89FB26E97DCB74E625235872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A55C61AF4357F576225002B1117B3ED6962CE3D916DB564E1D484B8D70797403F6823CB91A9FED034534781492E4B8EEADB0A1B66E9F5C9ED4C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFB0B4B273E10E53B273D61898C608F9210EE761D87920FBD4045819CB047EB8F396A3CD8EA40B8F977D42B5C1564802C6A2241FF600A9E5A0FAD0744E3A7D614B548E503556A182319F49EEF1215E7BEC913E6812662D5F2A17D6C1CDD2003EB8E03787203701020945C72C348FB7EED3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojW5AakKLSukPT8RvPazbZig==
X-Mailru-Sender: 689FA8AB762F7393C6D0B12EA33CAA9BFCACA472F7AA889FA3CD8D69EDBCA94C82231978AE40DA2190DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Fri, 26 Jul 2024 14:43:57 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

These seem to be missing, and trying to build fastboot cmd without
them is causing errors due to these being missing.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 arch/riscv/include/asm/bitops.h | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index 35f1368b83..2f2994c4dd 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -138,6 +138,43 @@ static inline unsigned long ffz(unsigned long word)
 	return k;
 }
 
+static inline int find_next_zero_bit(void *addr, int size, int offset)
+{
+	unsigned long *p = ((unsigned long *)addr) + (offset / BITS_PER_LONG);
+	unsigned long result = offset & ~(BITS_PER_LONG - 1);
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset &= (BITS_PER_LONG - 1);
+	if (offset) {
+		tmp = *(p++);
+		tmp |= ~0UL >> (BITS_PER_LONG - offset);
+		if (size < BITS_PER_LONG)
+			goto found_first;
+		if (~tmp)
+			goto found_middle;
+		size -= BITS_PER_LONG;
+		result += BITS_PER_LONG;
+	}
+	while (size & ~(BITS_PER_LONG - 1)) {
+		tmp = *(p++);
+		if (~tmp)
+			goto found_middle;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
+	}
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp |= ~0UL << size;
+found_middle:
+	return result + ffz(tmp);
+}
+
 /*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
@@ -158,6 +195,9 @@ static inline unsigned long ffz(unsigned long word)
 #define hweight16(x) generic_hweight16(x)
 #define hweight8(x) generic_hweight8(x)
 
+#define find_first_zero_bit(addr, size) \
+	find_next_zero_bit((addr), (size), 0)
+
 #define test_and_set_bit		__test_and_set_bit
 #define test_and_clear_bit		__test_and_clear_bit
 
-- 
2.45.2

