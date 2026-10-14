Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F51CC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 19:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 359ED40764;
	Wed, 14 Oct 2026 19:06:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YoBeqgoYK1SL; Wed, 14 Oct 2026 19:06:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 65A84404F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792004772;
	b=BK0NmbsXLzuudthjxUqKyl24lRfE6CCjoh8Ma1rZwR4fjdS0pJKHWgx8UfHJBTskREA5
	 YKR4tJH3+TMyNWfiIaka+8snyS/07+MmG+J2E4kdc4Ge8R1JzfBHirMoJoV37KdsWLKtm
	 w/TzBrcIkKa7zcvcFMtMjzB5V23npWBgFw/0RKAcjlKIbPVcIlwjE1MnbIgz2Uuptl3pA
	 15U6/lcrnD4qCI8J7swW7zmWKpHC9oWGD8syW8/W7R8z0NZc6S+DZXeVh0iE2kEYg9JCn
	 ka9e9Gmjg5NtHlgIxhfJy/eBKseqaO+UQjoa7m7ITnq8E+ZBpEZPMIL5WTd3glWHW+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792004772;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Hjro2u7eenwZJ3Sabt8zG1r/TaeUOIj3vV0EIlzAj48=;
	b=iAACZ7FHa52RgLpH9GV2BHVu74vFsg7FOscns8cy575dPTftg3keFgrGX/u2YLxWQCoE
	 3vHZaDTzFyXE5YTzBDTRo/8Nm0D7r/TnctvPOzRwKHdBn0GiAJlepZw5fEUNyHeC0H007
	 zPnPU2jCQQ+le2gK+2SBOFo5kJKIt9zR8xoOBa8Vj2ZtC3qVHSyKr6556+t9cXbgR9viT
	 yknESjJvUsTRaj7zTiwE6FZL+817eWNAElpKUAFVUyZlD4TsDcGmeofXkHaBNUB8JyTsZ
	 QP5oa92e+5xlrhiOn4oFaXdUHA3rGHR2EdlxVmT3DISmbJ2/FctMNMv6UGVLDZhMZDg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792004772;
	bh=Hjro2u7eenwZJ3Sabt8zG1r/TaeUOIj3vV0EIlzAj48=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ohprE54vthkIUiOpwN8lVEplHYcJjbTnLuYDuwHEARbPtZ6ciQ5kb6wELfugn3+Js
	 z+LGEGnwEje3+1IR3SJUD1wjNJJhHggTT1Qv8F9BTeazGmEn2PrBCbbwUBgtGjcyKV
	 hysiiSOWBTZvhZQyOqonamPYHATB/Y5JY/Rzp3Tr9wBM3K8gVskONb+KCd/tfvjzBb
	 MXrh97KieQlWVTPrPpS2LJNnd5Mmy6bc6xoGOV+CaLyQu6JdesdsgRJZc3khfyu5uA
	 HnMyimLAyAFS9XJXEjjKBDyZLfeqTO+KJpLurW68M+KzcpNsg5xxPvWbSC3rjuoRr3
	 FPwvT07ONSEEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65A84404F4;
	Wed, 14 Oct 2026 19:06:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1611F2E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0860480E58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rPRp3ZwE3O6W for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 19:06:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5BB7F80E57
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792004770;
 b=rHKq423eZ/DzbzzdNvT9O9/84oxDg/aRwaDE4JbHxdWdJmP8rWCzc3C2PSx+UX7bTmCO
 z5x5kcA6alEHx8F9DT5RJcjy2HCGllh2FYK4AnW6mgyNt7mdzH6ATJl1rOTbXvz+aJD5y
 YI+L1Dz1eTSmm8W8Tpanjgn7Uxs0Wy2kE+I6ZBGUXOTkCymvQ7/GD/wr2rmnIQDVls99U
 Y7mBGkyD2NTCbnEH0rDqzd4mEqKVoJRHe8YZAkowffj0yFWU+ZzWLQOcigszv1icaia7T
 KQeFogiOT7M9YzlGh4CnVrdnvJoGXnRO6uEHQdxc9O9G55ycro281ZavLA8phoQ7R+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792004770;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=Hjro2u7eenwZJ3Sabt8zG1r/TaeUOIj3vV0EIlzAj48=;
 b=ZqguD73A9WV1ENEHvHC71KMZAE/rhVQyAW9FlmLstgQtlc1reJPRqHoYDWlZmLJ6VrPE
 Xw4qT0Ba1i5BKwCfJBE/pD6a/SzbVHF7yAGxYwDf3y6YylTQ0+9xjvYOWH3usLcsv6M+c
 IKNLzVA6m9ySlbOCjCgxsQs/1SQ4Xj7AFuuIBARdUYifwAA9fomhM3ZSPxKNCJ3cl3LB6
 N/cNoe7+1tg+4IoxeZAd1nFTtjRYaGo3tK+NfSZ5wforB6dv28iWBGqoHH7R6ibtMmvCz
 UnT0FjEsBS6jxbixbu594f0roBhKpYbrW4cMD7mOZupQkAFRt4gfC9yXkhNNbmFrh7g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RivmKedk; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RivmKedk
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BB7F80E57
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:06:09 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso446345a91.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792004769; x=1792609569;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hjro2u7eenwZJ3Sabt8zG1r/TaeUOIj3vV0EIlzAj48=;
 b=RivmKedkd66jthZH3eakfdGqg7/dlKywxJrOj4vpfDKUajp3VUaN2bBpSUiQnawbuD
 oiMrHbQ5EPJUJ6fkauuuxbnALvVPGiDvwP2nn8byb5glXNSfQIsR4kozi0cbUmczTEWC
 rgRB0GkapCNfiqUiWoecEHKpHq6aEi/QkhvsUX8D2KwR2Ln6X4DVDuKLX5d7o6SYYtLn
 p+bw9lgOwQEFZFIlTFqZAJ2CwxC5UnmuRWDek7/KYAtbV/bMb5GvtJP+eolCX9bPo3RD
 yAuDYvcEEv77X2a9aAuMUkLY/CSnILBoWkt6SoFfhomhTjcl7rWv+YfrJIyl8+vZ5cPl
 r65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792004769; x=1792609569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hjro2u7eenwZJ3Sabt8zG1r/TaeUOIj3vV0EIlzAj48=;
 b=aPilAK+c5S1hc3kraRbj52VfxYRrdwHI5GZtmVkslqTH5dC9DP/Zq1M6CvqcX75YSb
 uVZYc9H9OMyjIE2yHD2d4TXaB638DkXAz0LFk5JhNaLQruBfqWHFwMJMx9Im6zLeANVe
 LhjSIj7sLsVFejLSgptChXvD3HHW+7YZL2VWpWKM5OaOYRMlMlIHuNEHlj98Y2Da0KiC
 fsERDgHuzN7LbUCGwe+8X6oQuJegZlbYamxgBL46DrlRXOak01exF4NCowUe4nzNT2fU
 QW/Z0wJ12WLrBAJTGrHTA0MM8tZBpBNiJuibEwE7JZsQZw/olbWCK08zWofcDLGnlHF/
 4I9Q==
X-Gm-Message-State: AFq9FYLm5U3dmIMzb3YUipdZ7wyU1gyPjdwlGalhuZPGkDK6xEn5MWfN
 CzxIha+M0gwqsxiFVgCogYl4m8YtzOX7uK1zN1eXY4QfHSgz8vTln+OAFToLrg==
X-Gm-Gg: AYBFou2L0G5VuI14rnABtFBUA/PuYdSYhjDwZXmuAEy8mrbWIrqTRhBYswrJCaW84Di
 xhWNP/sc6tZayiRNo3c9DzokCJzazFzRhlDUQtuxmuVpBai8PXIH/DMnuGAU5Jx4qySplO412C4
 aA+vaUaXtUf6Dakd+H06GzIMPJhkbLIztU1VhrKYkJ+37XdSemFmdgsVl/y1YEPs0wEh/LsqxeG
 Ptgs1gWJJTQwm2lSrSIO5NNH6Sl7hJJRoCIDP9i5GNQIBmy/BkZA1DU/ja7+vZtxlnXtZAH/DUL
 8NnrFSCyTzCkd8WWPJxQ20VUrf9/Nf5aWHHJc8LZ/MOxjQA+P3Ai0SpSqpGE4XWzDng94QIQ8vi
 Blvg0jerxZiKzGMAiB9FW1HlhmN/fXKVpfArASwviAjP1DdkEq9nfUMV1H2/dItLcdh/i2dETVb
 h5QvIUFCsoWANzLnveoXBveSyfq+RjbwZ8eps7Vj2IsqIlmvQs/h/pia1L56UYtxlKxBy5uiGtr
 6d9741rE9cZIgaZ+3ZxHPI6piYVDrkBgY8Wv7rmZtIDpGhLXnrZh0ahEQtF2Lfndset2bUwFt22
 WIN9hpBu0mO0qEZ1EjypT6pECOj17TLnm5YY0L6Hvludf4bRfvJHgivPEtgl8DrZ
X-Received: by 2002:a17:90b:53c6:b0:3ab:e588:c275 with SMTP id
 98e67ed59e1d1-3abe588f863mr8269225a91.20.1792004769099; 
 Wed, 14 Oct 2026 12:06:09 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac947dfa00sm573302a91.17.2026.10.14.12.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:06:08 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH] tpm: v2: Fix the size of the random data in tpm2_get_random()
Date: Thu, 15 Oct 2026 03:06:05 +0800
Message-ID: <20261014190605.2229511-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
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

tpm2_get_random() reads the size of the returned random bytes with the
"w" format of unpack_byte_string(), which stores a u16, but data_size
is a u32. Only its lower half is written, so its upper half keeps
whatever was on the stack, and the "data_size > this_bytes" check
fails with TPM_LIB_ERROR whenever that is not zero.

On qemu-riscv64_smode with a swtpm TPM, this breaks the kaslr-seed
fixup on every bootefi:

  tpm-rng tpm-rng: dm_rng_read failed: -1

Under gdb, data_size was 0xffffffff before the call and 0xffff0008
after it, for an 8-byte request. Whether it fails depends on the stack
contents, so unrelated changes can hide it.

The size field of a TPM2B is a UINT16, so declare data_size as u16.

Fixes: 06bea4980980 ("tpm: add TPM2_GetRandom command support")
Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 lib/tpm-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index f443b738f..4c7dfc556 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -977,7 +977,7 @@ u32 tpm2_get_random(struct udevice *dev, void *data, u32 count)
 	const size_t data_size_offset = 10;
 	const size_t data_offset = 12;
 	size_t response_length = sizeof(response);
-	u32 data_size;
+	u16 data_size;
 	u8 *out = data;
 
 	while (count > 0) {
-- 
2.43.0

