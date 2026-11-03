Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8DC606A32E
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BjNDtiW5;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bkX7q6nF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1585C60855;
	Tue,  3 Nov 2026 16:13:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iYopHQyt4X-A; Tue,  3 Nov 2026 16:13:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3BBFC6083A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793722382;
	b=HCQu5yMMMAaMlvpwhHGY2digNUrPyEl8Osd3SiQ7E8gbEhIkPb4Ar5PHSB56qm5g+wy+
	 jw/b3Hr16NOtvd0NwKcVT4KyZTIW1hp41q5B5qo5e7vKvP+pOPWCK6PiBzvBXOEVhokCS
	 SjUGXTpz8nZSog3yiB/Xasjejmf7YJwl2hjjpxpI0I/h4ZZ8l5BJieSH09fxfi6YMvEkX
	 r0z+9OFNK7zSPKWACjlDk73rhnAWG0epKtJcfApW/YEAkx3u8ScTsGNLQJtr6cmuCKWpV
	 mPRmwUSzepQmkxFJUkcJdehN3GTc/2GDGHPbpFQsm4ppdYY8l1ZJubVMh8qcHZ04LCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722382;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qsiNf2BCfURgsvL5wnBrL2rgsP8pPWxh/JvLc2/WQXQ=;
	b=A/zJ2sOEABVQPLbqCqOHjVIZ/YeIn0Zr5tQFwbZgKCHQs0R5QCvBvMcHgS4foKs3vKmS
	 NdaMbO0MZUb0XVVjBx6iFQmIdXbAMRrSAFfwGcDBj2I0E/sOGogbV8x2EW2Aop8k/2Yv6
	 oxngAZQ/PBunbE3YrPzD7iRVzREphLzFVOzK5t0pEmz1InZHnR1EE3OMDXolhF4ZtGk/6
	 5cArxH/ZCKz0RkevLE1h+B0ttxK2LNYZ/KsCE91E9RHIbYsjkJ8k5xetQZDk010RjV9q+
	 26JlsIELHuyfq5/1muSBUMuaLiQnBw4fR6LBrMJrjKPpIMBTdYAW2ibIJ1lNH6IFXVw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793722382;
	bh=qsiNf2BCfURgsvL5wnBrL2rgsP8pPWxh/JvLc2/WQXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BjNDtiW5x5e/DCGKTMr2psw2G8qi0FpzHqYRvn/BvDaAQemoZ5zMBTOws3iY/13Nt
	 geFBvp22N3rjc970lnLZoLz8P0Y0oo3Q6QN7mLYMyjpCR8ZgYymvjAXOVMNr2787QR
	 dvMi9/DV1rW+80gvlq3oUIpfgsImSJo69Sp196B8PWyRtgASRQfWVi0VRCIj9d7RbT
	 ygcMqTcNBwtoyNIO19UYFwnRYsouPc8AP2+dWNhnNrcjTrhrWaWpTzyCED/Wi6gplO
	 IqJKZAecsZhXdBqjbp5nFxgO7GgCe7/e3qdPsKI7iaJ7d+sfpxZqKph65C73gcJPG7
	 xwKgThbIjBnIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BBFC6083A;
	Tue,  3 Nov 2026 16:13:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80E39A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6662040718
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Covi3agvfWCG for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:12:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6EAA4406FA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793722379;
 b=ZVCfq7H2Fync0sYvLmoHLZYzkBVFXIhCxLA8hSjzbXzN/x+1Burdmrc491IJFZo/E+N9
 xFQ1YO+xmaAsuFCuw5NupUvBL4CrOsujCJze0TDjrSHGHIIud6iDlGXy09sCk9Pp7b+wK
 dm7Oqx07zjjSZDNs7eUN4ec5txSXnk5i7tLW3vWHa+WgFnyjJQhmFnIhHAA5+c2rFdM+v
 ntsuatg90jB7mDKQLWUh4gIom4MGTjJqWEqMwaVEg4lt4GZf8hquOzRptkX9cs0/EaStz
 biZ/8JY0kfUJIPCwWsAmLSIGrOvxJt3V2r0f0asLNI2Mr9SW0/hMEIQi3ypvJqFCpkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793722379;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=qsiNf2BCfURgsvL5wnBrL2rgsP8pPWxh/JvLc2/WQXQ=;
 b=HkFSGuO5Wm5D5PPY/3uN2QcTF7B+rS2CA/F/yAB7l1yEmjml7jVoOy49kyQuctUmOF/t
 rZgAGqfydZlR506kaITJ34uGTAQAg6ESmCBKVaZjsrATKbo5C6Zsf+6HKHVYfbjW0TNDq
 IAZNo/h89d9vTxhZ6Kac63W7sOTRXJyHibY9U+MJVkGhMa0z94gqmMWDoM5weTmWBfh9q
 BvL9Sw7rn/lsq7gzrFEdS1nSRML9yrUpoE9d7zL1oHwz5ikdNR98R9e/1t0JqxIrA3OZ8
 z9xriihjx/ztJbc2u5aOvZ1buR+PFnK2QxWa3XH/U3M6CCj8+k5mAlBKJr/ocw0kdPw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=bkX7q6nF; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=bkX7q6nF
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6EAA4406FA
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:12:58 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so9009705e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793722377; x=1794327177;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qsiNf2BCfURgsvL5wnBrL2rgsP8pPWxh/JvLc2/WQXQ=;
 b=bkX7q6nFdFT3XANM5M7Ps9oysYfXHRuoJlZEKEsUObEZpWNONB+HYa609CPBbm44b7
 HuzK3t7VjEHCqIxZDhn1p4Ve7Pthgv0tsKAJbgMwHBfVLgzVu8/TzudoR4PfTqbVTYEd
 /DZ45rKzWTOYxpnwAZNfNxvOGDr56dnJqLaYyTDGaZ2TVFDFjy/AussAuZK/SvGUq+Pn
 LncTel6no9Ms5R9GPncxFyZR73ZQyR4m4daS3Lrh8Fm3TuAbusmIqcf3AbZBCZRbkQnI
 Fyegq0gplilGm3bZzjZ+8B92XUTf4UssxekdoQ2Vfd1nknndqInBPhgAhpySzn8gAWIo
 61Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793722377; x=1794327177;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qsiNf2BCfURgsvL5wnBrL2rgsP8pPWxh/JvLc2/WQXQ=;
 b=gNBR2mvjBHiJAy4OKUoWuU+oHG7n4/WUSS9Ol9PikjCCtgf6fngNMsmQ6C/rfSLTQd
 g/vW6DyNjlJyzGg34HIN08MuwyIZkAmUti+6aekbYPyQgnWr3y6bwA45qkExlgExgawC
 F+gJkplfCJVMAjJZ5q7sMbMkcPk596PotHRmcuQWZHhWj5h/N+s/tM4ghDi1cAF4nHLn
 Ei0fLTTcuX07BQZICSE3iQheeTFWuioVB3ifrz/o3TfALR9+Ek268k/qcx2NB5a7qCrG
 jXE2FIWEuMsCYTZetn58B/xXQa89t7Mr27AswWRne6fLuE5KEMqWCvq9HE2LfLKNUS2o
 kCYg==
X-Gm-Message-State: APuU4Z8ux9j/JZtLKjmxodhv9atylknAbx6JJrFxOkyX4AYTw424Fr7b
 ufPrqmlac16/SE2OV3lEas9170RZqO4cYIRUjwtyeOK8gXryhpU4cHTNz3fIlkB5z1VFLEQI
X-Gm-Gg: AYBFou0L4yKGs30PIN3Ve5SobmU4QzhKiH5J0amttdL6HUZF6+hX4xqkBBO03Y4GKZg
 S5HTTEb7xi/PcMSB9GSPo61534mWpWocOJq5577yQtDtdFUGtRlKUirqwgV9EhdJX1tVzUS3wTD
 qWNTH96rkhxZZR4e5uRvC2DAWMdTcfa1U1k5dcMHqcg05n3OV+5DeDiX8XE5IBQ6UEI9w76HWnB
 s/ZHHEUwxrVFAGKBbUEZ3LCrmoH2IbEmcZyk16/H4O1QgPeJCSnRsVKS7o42RFK1/RglXvodGOP
 dl1MLm2JHdc9WHAP5uQkTfYHBtY4p5iDqAIwb+KzyKYGKFSEZtFbVBYSXg1/hwCjA6gYP2Q6vzO
 946ir5+PKESY7rT4xdGml1lk7L4oRw50z9snV1dvvS5qHkOq1pQqsvvBv/AwRexBR26KBzJ0IEo
 kJvVkaFf0quyYrMbGYXVRS/bGzyv5dTVL4/XXUTCUArbOi66tXWV2oEoFvVaBnIyJpZmBzke72C
 sETXy2DASFjFTmd3aIGkZj0AiJtgujrK9FB5O+3ciQxv52h3as/Lze0Y7ana44uRkVaYZDH6j9c
 Z8JQCslc0MGAnFJgxDuVMH1k35vG6tE=
X-Received: by 2002:a05:600c:1387:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4ac1793e81cmr327598665e9.13.1793722376550; 
 Tue, 03 Nov 2026 08:12:56 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a879f401sm64884805e9.5.2026.11.03.08.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:12:56 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 03/11] efi_loader: reject a PE section whose end wraps
 around
Date: Tue, 03 Nov 2026 16:12:55 +0000
Message-ID: <e33ec5d3-3f6b-46f1-acb0-c45cad9cb99d@gmail.com>
In-Reply-To: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
References: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_load_pe() computes the end of each section as the sum of its
VirtualAddress and its size, both u32, so the sum wraps around before it
is widened to unsigned long. A section near 4 GiB then yields a small
virt_size, and the memset() and memcpy() of the section write far past
the allocated image.

Relative virtual addresses are 32 bit, so reject a section whose end
does not fit into 32 bits. barebox, whose EFI loader is based on this
file, fixed the same in b6598389d46d ("efi: loader: fix integer overflow
in PE virt_size calculation").

This runs before the image is rejected when Secure Boot fails to verify
it.

Fixes: cb149c66342c ("efi_loader: Add PE image loader")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_image_loader.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 7be5b6f2a9b..f81ccd62ab1 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -1048,9 +1048,21 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 	/* Calculate upper virtual address boundary */
 	for (i = num_sections - 1; i >= 0; i--) {
 		IMAGE_SECTION_HEADER *sec = &sections[i];
+		u32 end;
 
-		virt_size = max_t(unsigned long, virt_size,
-				  sec->VirtualAddress + section_size(sec));
+		/*
+		 * VirtualAddress and section_size() are both u32, so their sum
+		 * wraps around at 4 GiB, on 64bit systems too. A wrapped end
+		 * would make virt_size too small for the memset() and memcpy()
+		 * below.
+		 */
+		if (__builtin_add_overflow(sec->VirtualAddress,
+					   section_size(sec), &end)) {
+			log_err("Section %d virtual address overflow\n", i);
+			return EFI_LOAD_ERROR;
+		}
+
+		virt_size = max_t(unsigned long, virt_size, end);
 	}
 
 	/* Read 32/64bit specific header bits */
