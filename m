Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AF606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p1PbPl5P;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ecTLflBj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B826540A74;
	Fri, 30 Oct 2026 12:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CX-isO-k9FTi; Fri, 30 Oct 2026 12:59:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 02A2840AE3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793365194;
	b=W4Li90j73DRWYWCKeLNy+Kycnb+3n3yE4o4zzWOFJ6eMLg4jF7JQ7qtHyNK0eqA8IQgj
	 9nFgU7LpJZoVPQyeOsnVrX7bDt4fyIV6j8eVwKx12SKzeCaaSwDl6BJ/nUCGELWHVi6Lf
	 9yz1V5UClzEwMCtaVrC/WA0rgUfCEBw0cKVJIi1cfFUhO6t58SSNvyGhmRleQTKlKWWLE
	 j6jRvqfsSNC1GvZ72igt3fXvnJNWKgPt+UrTPEVH3qQnIlbqTTVKTC5CATlbJv/W6IJ/d
	 Ucvp7Dt4LAOPjGBhG1kbYP1QNp09+nIH/zTJM1mGfhLb2fiI941jm1cyaq/4y7ptK/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793365194;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LPqhKknI75HlcUvgjBdxKMa5h+aQhKbnVQ4QPRrW22s=;
	b=aJvQB2kx9XbpSeOLovKfK1GojU0XKfNN3HO47ASX9FIpw1tg5kF8yVUEv2R/vA4uycA2
	 V+Bw8c/O6qsC/2sjmSZu4chzyJXj4QdeMN0RKqMe+SdOpdmPXhrx/Lj6FGgPdEpuuAS0W
	 HV3YQG6I+DO/AJ5nqAttWf+pLaroval4N5Y5NgiAIGW7fugXzHpue71vHsh0e9Q1agwLB
	 h7QWlzChB/Y/5Gy8qT3jGIRVopZem6hPKwgYF237Kk9rVJJq2HcMQoWQJPJFNvBy4zYxT
	 tndHcG7gmxxfENtQ8sjBS53d2XJ8Vw5xlCDSbiKSz0T39kJzNSE6/uq0eg90+MwA98w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793365194;
	bh=LPqhKknI75HlcUvgjBdxKMa5h+aQhKbnVQ4QPRrW22s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p1PbPl5PCYsAYd2e4TdIaP8Bisr0tBQx5vV26bs4TgThWTREl7N4XW9iMqLJ5fFbc
	 Zau0fh9P93sbx86vNqVU5QvmXNRDFFQrj4HKCRRNnx6Em6zv0ix/DwxFz8DUgbdqfX
	 yYALy5fylViLw1d9dj6aBypcXMds/AVwvoBd2DpA76ax59YW5Z82/NP9YNlmaRo2kI
	 3/tAdiJVL2rhdLGfEVdz1BQBZH8+rITGOwaidh3pT2xtw+yQmfxZkROjdaBGVdw2Lt
	 8lXqsXTRLI29LdEuJBnUqzDGZoAMMFEK/w7PXqolaKLq+NgVOsThKOqJXO7NoQORCN
	 RrE7ALKA3AJsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02A2840AE3;
	Fri, 30 Oct 2026 12:59:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D8B62380
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA8C740329
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RX3TYTdMcLa3 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 07:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 089F6402F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793345869;
 b=LexEuSkOIK+mA0naaWok4RH09m4s9yg3h4XGSqEK02q2heWruByv+bTX+o7uRDv2n9Tc
 jN3IlPkEuCUNtTO8cAAOzBXb2QY/PK82oABK6+U9DqIsY/6/VyOP3MOmb2fP9Kz1OsSaq
 CV6V1EdM6lpnm8WZ8BvyieX2uH1U84XYq9Ep0MAjzs8slMux/6xnEFMoDww9hvdxs/h9/
 8HfY4AcHiNiTel9EyvBvPh1ZSLnrUPsteHsOsFQ9fkZluUNPbphM5hyfndQSBuId5E3b3
 bs0lqy1LvFnBWJMe9pmGCuFWlRmdxTLyB3HDrMHMP2MlbQhSZIE4h55hLmiQQSgMSPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793345869;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=LPqhKknI75HlcUvgjBdxKMa5h+aQhKbnVQ4QPRrW22s=;
 b=ggUgCUHfJSn842eTIQhG17aTqRYlgjaM3Xa1LI4lY7Vo8kuRYL22ZFgEfPSXvfNODlf/
 1dp2bRb26qVlVwXa7YuED9+7oREJhZikKNjANFivbEbGeUBNTmnJnRAUFDf5aMqD5BpxQ
 PWa2Sq1GmxKwm5bGLUy6VPkzCKErgbEVlvyAaYNYYkUTLqJ8LjKUNpWvo31PdQUqSKYSS
 cSrUG+fx0Sg0TVrtG2zixaQkuc0xgbhztNt+QLynECD1HkckV5IG/YUWXoCAg1wLhXkkV
 RxjtLGYyDIMbDScGIDkeQG4bttm7Vzjysv6BsXSZR1YUD2YTDvX2EB0OGXDXSOSO0yg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ecTLflBj; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ylcncn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ecTLflBj
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 089F6402F6
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:37:48 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so3486155e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793345866; x=1793950666;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LPqhKknI75HlcUvgjBdxKMa5h+aQhKbnVQ4QPRrW22s=;
 b=ecTLflBjeVl475zNOitNOuY8j+C3xlDAEKkw2VNl8D1JXPYahkOb46dv6JbFH5Q/Z/
 LnUBtpxWlcnWETC09qDjEaepdQf6FvgFl8qkWsqF+XFPvZJXLK310DeLIALAr3k9h5Iq
 Olcd2JoOzdQUbL/gkABq3aRZsaIAP90wdtliunX8aZYLMcVCDOxSk/vFb59d8BcEn64T
 c+BHYXux4gYGYG80UTqH/vyR0QuKBAZHlXAHmj66CsjxXuCjkpxIvecJtIczhqIpNelV
 B1+XIwVuHpbhPGJWilO962hjlHsTbLou+V0Rngb7cfSeTFmaDhMhmZQaH7ymMh6b/7q6
 jGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793345866; x=1793950666;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LPqhKknI75HlcUvgjBdxKMa5h+aQhKbnVQ4QPRrW22s=;
 b=Kkt6R2uM6tcYHoitGecbkqGIL34nn4IIua3wFVy6u8jjLtuuwt3JWzQWhSOVHdwxTr
 gCCZa4dlaaujYlwlw5g9c0GXslltB96wbNECMJ4aZ0BviKkUGh2eYaE+Ulj8fCFzPlKl
 oCiNjSbnxf+DNVQCq92jclCxjMMJLoGy9AWGeHuQmnaF4ShQhx+XxNMgocvHjIIvmnhc
 S8Z+QrROeDu8QkyWcDiPeUeu6xosMYs6N1J3Xw5TqgsfpJEtSb4YyVtS27tMnY1xBNMb
 kkfAflUpX0C5cev5vyvwC3NnYGOfR8+Oph38Aqoq1ZGTu/LNuSzS3VGuuOHMdDCIPFnJ
 tJxA==
X-Gm-Message-State: AFq9FYJmepPm2HYuYBg3L/QeIaVYj74jmlJOwsKBuX5cbEMdGiicx27c
 R70CBnEPYrXe7jz1RPneaolXn6wFH8CMZq4SabSlOiAGk1YHnWbLMI5hcp3XCAf6q7c=
X-Gm-Gg: AYBFou3ktpoSaRxC43Q0v+QQEA5SrP7C6ty+blkD9xPI7vrcqXLHs2TcnJ8NP+Nvy7w
 MVvGNvw1o1jHFUaONjFsKPE0XaREu9pvj6jMXlWkfIQGZ9b9+q+10tn1Mx9gD6PQyYcaXZNUtji
 sp2vxXn5C1gnbw4UMrn78t/XHR5mIcBqrLtlYpIlFKIaXXAHuKVYvSD7lfS8y5ATP95D+2j197P
 jBRNLpAv6ErVx+Ia17Spksqb4s51h3ln5600/xzxOafsO9gtbRPAPA55o0dC3FlQRBFsfs6jnmD
 ig5ZJxCmCmW45U9A037cb5Q0PkmA8Eu9J7Nu9gYXgWea+0rfi+QeJvTufvteT/Ssotx4JJ/cATK
 7wmI473t/CB6G3toMFFbTyUCRfiiWNwKH1Xpjs+IVpHYoP8qvcReceBMw2EFWF4DOJqa4eCQkbU
 5zFUVBiF9WBa9LZXW1HuDvCRzhk5Xci/EHgCLyP545NYppBAHCtktWPWtiMEGhTithw1bSg0U3f
 omDb/gfo9QQQ9fDTM9orO3N3NCCOJvk/hqnyU3B4os5yYLU3yukGw91EC0CnKOFCHBcmc4Pr9g0
 DMegc/j/+59iGiCu8jN7f0KlXFRbiNDitbU=
X-Received: by 2002:a05:600c:a4d:b0:4a3:12fb:1ee7 with SMTP id
 5b1f17b1804b1-4ac18c7388dmr30449745e9.25.1793345866275; 
 Fri, 30 Oct 2026 00:37:46 -0700 (PDT)
Received: from thinkpad.hgw.local ([159.146.110.109])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a66caefsm29007475e9.5.2026.10.30.00.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 00:37:45 -0700 (PDT)
From: =?UTF-8?q?Yal=C3=A7=C4=B1n=20Can?= <ylcncn@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] arm: clang: use -mthumb when -mthumb-interwork is not
 supported
Date: Fri, 30 Oct 2026 10:37:38 +0300
Message-ID: <20261030073738.165179-1-ylcncn@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Oct 2026 12:59:41 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With SYS_THUMB_BUILD, config.mk asks for "-mthumb -mthumb-interwork" and
falls back to ARM code (-marm) if the compiler rejects the pair. Clang has
no -mthumb-interwork (interworking is always on), so clang builds come out
as ARM code, about 30 % larger than gcc's Thumb-2 build.

Try plain -mthumb before falling back to -marm.

Tested with clang 19 on mk808_defconfig: 467 KB instead of ~600 KB, boots
on an MK808B (RK3066); the interworking veneers around save_boot_params
were checked in the disassembly.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Yalçın Can <ylcncn@gmail.com>
---
 arch/arm/config.mk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index bce9a31e..b14c5590 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -48,9 +48,10 @@ ifeq ($(CONFIG_$(PHASE_)SYS_THUMB_BUILD),y)
 AFLAGS_IMPLICIT_IT	:= $(call as-option,-Wa$(comma)-mimplicit-it=always)
 PF_CPPFLAGS_ARM		:= $(AFLAGS_IMPLICIT_IT) \
 			$(call cc-option, -mthumb -mthumb-interwork,\
+			$(call cc-option, -mthumb,\
 			$(call cc-option,-marm,)\
 			$(call cc-option,-mno-thumb-interwork,)\
-		)
+		))
 else ifneq ($(CONFIG_ARM64),y)
 PF_CPPFLAGS_ARM := $(call cc-option,-marm,) \
 		$(call cc-option,-mno-thumb-interwork,)
-- 
2.47.3

