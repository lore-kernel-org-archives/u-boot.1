Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FECEC624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 22:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9D7D40BF8;
	Fri,  4 Sep 2026 22:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EVClJ2ougIci; Fri,  4 Sep 2026 22:51:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0D3A240AC0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788562263;
	b=ZXfflV4fIgGdLBLmAM35Fi4BDaeFI2PWuekLrnhqMox147bvKcnQYqQoyHOPCsCj6pcl
	 5dlPWd0pYiTrezGCj4GdOXFCD4tEz56dQ0vZpfF/BUGZTsaheZutLYgdnXBfSp/OlfxWm
	 JfSymr93nacjTrqfR0u+z4h80tXfJMljEDz48J7AHIICRPHrMmLvuwmnAvy3m36xSsK+M
	 LTeiHEMc1MZEOUlMtaaBlEaXAqan4+ygH5I2s6GuqmMcwlRkaa2GnSipfpKxQdUWe3d0l
	 21WM0hyhKc3IDopsIrcAZbcV00NW1ayhi3l0sw/HwFVFsCHkjk3pQ/E8VcNp6UPwazQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788562263;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jHeFCuKHxoScwFAKC4eqRHvT5cdqaAaGxlPMOEAZDvo=;
	b=SAn2ssGZosur8V+BlKdOwNq6hHGQA1HngzHzO2obIx9+w+KphiJZrG9hGcWPHklf7AYe
	 YrDiIgr4Cxq3xGm2fKHr1KiaDbFT2GDYfZaKq7IRHKVMBXKb1+Bm6R09lhFTlGS0fcZnB
	 qqTIoeK5RFse1ay3ut4mGzXmJ3d68yfM42SZjgvqHA7xcR+qxLthz44GFgsJ2AGQ+WLiP
	 xxu+FVqUFTSaWJiqj2K1X3xSAAnk6HKE2yG7vyC/cCXzBdhfspyRzyjpblujJ75vuu5C4
	 DyhsZlrgdvCS2O0b7IJ/5B2EMFAO20EWKYenwawFyjjqY/bWMP4RLZGKblSu82Yicig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788562263;
	bh=jHeFCuKHxoScwFAKC4eqRHvT5cdqaAaGxlPMOEAZDvo=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gV7AzSnDlFBz7W3fvrn8NoMmpyr9Rq6ZLbol4d98VnibGDDs8Un2Ayp5AfFM5GWiy
	 bwfbLIxNTKBn+f0UydSd3cePrLXG20dR3GwOU1jsLizTEAvBB0Hjqy9JJYR0upmyxJ
	 /R53pAcAxA1StdS8ETd1PXXF6S3PI4XGc8eZxWfwm3J2EOyKr7ehZkorzMqA3a2mh1
	 ZfoW+fpL6fZF+EHu+RsA3uj2V2YbQ2yFx/J88g+RBbvHrOG+Jcu7RtAEUTwvJO8pKh
	 o7RxDjyv3kNvMR2RzfbKixtrao5w+BG8q/IUe578RH1jEQylLr1jwS8BgzEGMGfgEw
	 MHqyyzRkv4Pvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D3A240AC0;
	Fri,  4 Sep 2026 22:51:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AE509388
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 22:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93DA460BD1
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 22:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IFK3PsacIii3 for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 22:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B691260BC1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788562260;
 b=nxRK7aCcWJShujZEyEbXbsD+AWHipHLm3Rh9nTgtvRlnj0zmoFKt15+5qaG9tDwwTb6H
 ppNwZbDbg65/C5qUsIguiaS1V8/7fFzBQUo4wVzBh58GikvU/l/J0aCObd8rsZEthemvH
 hh7zSbWIh3ESJoIoweD8X2wWxBPj7StYusYfI5sYs0OFiJwvKLpXeyoO2gyy0x0WsvxHB
 1/qv3OKnyL0/p+LcrkKzHdCwRn5CZH5pZPxjXvgR97YeYM0pRuPoLMNiuSXlO49I1Wcsp
 YenajwiO6mQHoENHw4ky/U+Q0hc6lDyTZgnEeMtK524crbjEOfloV6s5zwTw+nNsE8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788562260;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=jHeFCuKHxoScwFAKC4eqRHvT5cdqaAaGxlPMOEAZDvo=;
 b=aShRj9FEzLZqcvFnd+UgO4xCMNJDioZQZONs7o42LGqPJ2ZlXMYHORUcq8VYeHN9JgV1
 PZ8g/B7kriZFpRFz61RSVjUC+9aJIS39yHb/ZnaPFWWRCgopCKK+ABWKdNsiS4EJl3iH4
 Rtz2QozIAhFJpeLfmrwsv3x74OFT9laximSX85O+s2IwhF5iAcVrfEtWkd3+4oVufK3Mr
 UV1SeiOIrI0TP4ATuRxSB67Y4rSHYnY8BsH6gEczoX6vuGTuj/XXtNQB4qwHrlNkZoK2D
 Rvt25uemNZhsmyZEGVdGN9Vqmn5xOtLP/WWfvLAjVvU5pYYPu81NC+sLPWLE6UUtNGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Ou0uSKUQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Ou0uSKUQ
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B691260BC1
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 22:51:00 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7f4b94d72acso1569202a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 15:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788562259; x=1789167059;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jHeFCuKHxoScwFAKC4eqRHvT5cdqaAaGxlPMOEAZDvo=;
 b=Ou0uSKUQH81WA+Ae4pSpS+rO1j8E2gcr8fCV8Zfx8QNMQwY+7+yW5bZKXdOBUUPR/3
 +D0iiLccvxTMiHVV2osDhOw2r5mdS5V3kbDTJyt6m2KAjzKzAzBb7JhxYlCZ1nuso07y
 bfEWE6WNng7bS/5akUFJUZ2cxNrlzlQsFy5yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788562259; x=1789167059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jHeFCuKHxoScwFAKC4eqRHvT5cdqaAaGxlPMOEAZDvo=;
 b=HFOujNoaLsjctN9eC9A8r30OjI4BtU2qDsG9t75+sfmwaThFTnoo8AhuR0AKTOEsRz
 fIo7sE+UfG2q2TIniG9+uB6EGlQmId5g+SBGWNXnT0QsmweUzIswabRYoqL7E+shrS+Q
 v0o2jaaa/4AczczgakRjCcyXnSB+2H8K8aZla+owkxzqD+KsyCOWtw0XHh/U4JdFnk98
 0kvKwCTfmxPgjKae9kTE0hDLY3cU2w8lpbt/f3VFSCd01gZCgDV9pmonIuTZqeuSbb/B
 C5Vty/EsQlMfCIeEwdmq11yhqokIxQPk26t521uQ8A36w7fiidlbPnApDpdhKdFeA3SF
 w+jQ==
X-Gm-Message-State: AFuF++l4yrf58pEtsxtZ+hlRvbfcwmT1HBjEIXDEU9/YG2GnvrmMreNm
 DCvwgTNFVb+IQLu2+TIQhUJsLB67YiU9QnRxwYOi8Qm2zCjMLHvS54Ip5ZVSoElYlgpLbon4a/C
 xMUf/F0tP14uR
X-Gm-Gg: AYBFou0Ckc9CqqMrBqcm/7P/vEIQT72NNjKqkZkd4UmMKuGWWpin9nn9TiayfXESAcF
 +ESI2nj46urTDmbG0LIxQ41PAjtsB06uSoQkI42Ce91Udd1ZAmVJbOsT+zIHGJSCmfM+drRQcW2
 s/ESBKsWBADEbBpoTStcLkuouBel6fZRS1TaVlovya1Pd4X+yIpI7q9WU7ecCMjVLxBTrqpcXN7
 ZIa1+iIKl616aEtLU+LtH6LWJ2aznvHhJOoJrqbXIcdEhvEphntT/gmai5spG0U/ydGcI5tASdg
 qH3Wj0IuGixtphfc3izbxmyhrJcHiiLLNbkcwmUPZNCv+0xbkD+XFgv26cbgpw9Z9p+yyIj8gYH
 kpkUCfmskyoO5NLdL+2w0AUVxCCMdkRj8Eafzij424Ou43QWxEIoP9B3R7vUxM9YM6IomGgAXVy
 0NDwxAGHaol+4Lv165OCwGAnahKF8hXCDuAZL26irC0oT44MvsW+Bw7wtrSFdv9RyyISEkTeJih
 jNyvduQ8v1J2dJxEiZEzCkNVBp4OLjyCJi0mSn7N8ICz1jMvqP/VmfzARU3nf1ksUrSqxI7sjiS
 1F5O3XS3xaC2p0gPY3X6Fv46Qmnb4SrEfUs4VhhZPFiC
X-Received: by 2002:a05:6830:83b7:b0:7f4:bd7e:1394 with SMTP id
 46e09a7af769-7fa1e1b786bmr8114340a34.1.1788562259124; 
 Fri, 04 Sep 2026 15:50:59 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7fa642bc562sm3650836a34.16.2026.09.04.15.50.56
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 15:50:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] board: tqma6ul: Add missing include
Date: Fri,  4 Sep 2026 16:50:55 -0600
Message-ID: <20260904225055.3069347-1-trini@konsulko.com>
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

This file requires <asm/arch/imx-regs.h> to know what IOMUXC_BASE_ADDR
is, and had been getting this via an indirect include path. Correct
this, so we can fix other bugs which happen to expose this indirect
inclusion.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 board/tq/tqma6ul/tqma6ul_mba6ul.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/tq/tqma6ul/tqma6ul_mba6ul.c b/board/tq/tqma6ul/tqma6ul_mba6ul.c
index be78060cbdae..7c10b7a1d3bd 100644
--- a/board/tq/tqma6ul/tqma6ul_mba6ul.c
+++ b/board/tq/tqma6ul/tqma6ul_mba6ul.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <malloc.h>
 #include <asm/arch/clock.h>
+#include <asm/arch/imx-regs.h>
 #include <asm/arch/iomux.h>
 #include <asm/arch/mx6-pins.h>
 #include <asm/mach-imx/sys_proto.h>
-- 
2.43.0

