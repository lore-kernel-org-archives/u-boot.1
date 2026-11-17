Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61705606A32A
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SN+En7og;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AoJoHSPF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AB9180DB8;
	Tue, 17 Nov 2026 17:19:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vCAA8MS3bQFK; Tue, 17 Nov 2026 17:19:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F9A9811E6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794935995;
	b=JrEWGLuGEiWmDAXEj/ufDpbFigh5muTdV99AIzwZkkkwvPg5ZNZkei27vuVfi5ZzgLRP
	 29ESyZRJ9K+ugTlZQ1Jj7OkijiUrjYWBAhYhEXoyD4ElMLzYT/Vr6re3bJjr9mW3VeHI2
	 qWhMdRbE8tCNaTtVEqAtUZ3yo9zsVmVlVSTxprv1v+7E5xgIEsJg76e5VYbJ9LwqiYDlY
	 gG3rYqjOyZ2Fu63QC5pRwtPzHopsFcvUBA9YgawwNQraX0BeQ+XJ+OLEgq34bOv+s+GcT
	 wd1+vcVEQ4ckyL5EeOz/h6pM8Sns2s0SzsS990tl3AH7kJVyvknBJIbLA8T16IgSSwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794935995;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K8wnpTH1nMrGErigShulRXCPGdlWe7in6ejye7fYl2k=;
	b=YI6Avpe9N6Nxl2TsMvFoycfE3DxqvZRs1hu5iumjkPQ+nMxDT3FfEfaY0EzdM5XR2Tmq
	 M4xbFvCI6WlBinJ95ffBslOJnYcBPixOcW8VLRsVp+iREhiX0gQDlZNT3lrm8PbLcsfjj
	 H4EZyJWxSsRxqCgQssZTMHw1sJwKIB1sZvpPJjPIn238ZMdZ2L8e7OouRYS03un4sQrL8
	 WKEc+TRURMn0oGQrm1WhYVF/5I6oasBr7RyWizHILXP2ePi1Xtsi1QPEbQmD+epy5gg9m
	 wNC9oPMo0ADmW0NzWvgPNDz7AK5HcifEn1z46t5DWXPc5imeXzHKU+6U7a4BnxvyWKg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794935995;
	bh=K8wnpTH1nMrGErigShulRXCPGdlWe7in6ejye7fYl2k=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SN+En7ogKE4yzBjuhWKfddf6lqipyOzJgllutAa2CkLm3M8Om5EyiTfeRUnkOZTMp
	 aHwOS+M5v8vr0EYV9YIn74DamTqe1u40CAh7Ar3dCy9lvr77XVEgG66DYi3I3RfNbp
	 5CAJfjmi8oPQIsFxWIlqzcq1fBXATW+DC3J6odW2jMj1qEe2SP4aO8zSZvMI4dmbs6
	 hwqy1sC+y6fMkp32AO41n1Nkw3keFvnCN8egZIOq0h9hyXjOwx6sBbR7+2h8ztGOaq
	 FS8hfCARORyAzHrVeRoWQ4iAjFVnj04MyLgcaLtqTKvrss+gMD9oCZZGC6PZp3L4SU
	 W5pSUrsvLTFLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F9A9811E6;
	Tue, 17 Nov 2026 17:19:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ED2EA105
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DECDC40897
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:19:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sg8YfefVTn03 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 17:19:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EE25B4082F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2d; helo=mail-vs1-xe2d.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=AoJoHSPF
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com
 [IPv6:2607:f8b0:4864:20::e2d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE25B4082F
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 17:19:53 +0000 (UTC)
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-7d2ccd3c7a2so3430137.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794935992; x=1795540792;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K8wnpTH1nMrGErigShulRXCPGdlWe7in6ejye7fYl2k=;
 b=AoJoHSPFny4aQtBwpGg9jNJ+bwDwCX1uC0cknrr+uw79wHlf2Xqtokc3hC2PCEcrei
 5qYxc2hZ3z97tYJ7aWSSLLt6B9ryiaxHyavV+LF01ETmw0U5/EyDppBUy+dPkedX9Ynz
 SZiFaWYbJzgVJGV/Wy4RKbrIh+FRrWSGL2skMZlyu4K+jX2JmLWXGMyT2A8S+zZSMLyC
 U4wSI3AqqHNKaKWvp45HaPvPzBW0uW9pymkkqK+Fb+GNEItopNyyskBgu/qMJygb8PKN
 53hestWpg757nsgFsRx7fq0fOzz4iagl04ycNVEGZTOexuJMriaEZAe84GmGiz1x65aP
 ayKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794935992; x=1795540792;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K8wnpTH1nMrGErigShulRXCPGdlWe7in6ejye7fYl2k=;
 b=QnjKj8AgtDl8ScNqwLfTf+Zqip7fNvTePiJasO/U1lvFGxo9OKr+Vj9wRdSa1GZTQH
 9sujG+q79Bpidp/QiWZ9/CDDhJXZ/nKvqgza+Fogt930Z+c1+NXWfZJDemYLBUdc6My+
 h0D2qfzxH4pdlP8ZQANTnHYOd82RZ7Co64CB3aZFlbzIj4QSTUf7ARyojI+EtulXLuUM
 ZEL5sqhbej+xBP9eZtseq2sf5n96+tDUHigOPUKfbgp4eMZS4py2HaF0VjMJdMLLGkHE
 3W1y6h3lhEAz3kheWn06qQBrmrRPnHDHpvc9bhkwcI0MMdp5eL7xjCNyYCN/x5hW5GQM
 nnbg==
X-Forwarded-Encrypted: i=1;
 AL+hErGTYZU4HOkr51RvsKd0CfJIkUjQ8CWdoFlT2eaCJti4anx/1v5Xty783fWyYHtEVf97tWNsfPg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/EnHu0y5YWtGaV7LzQR3TayaXWVRWZXG20zuuJmTezxcXcDsNv
 x/7zXNUDGuaB6X86IE7aj2AvPh0z3OHpatabAPryRwwX3E8aSyrxv+i51oZDfvdKFPQ=
X-Gm-Gg: AYBFou3Jxny4s0RFA3SuYOBqFONWOlSMUpFDda1V5Mvlf9oByEdPf01dD6XhIEU3T12
 MxAwvSuKqsha1nAo63sZ2h89A0GTpxuBhNz+joguFJDJBj8SuaZRM7Ig44hwp5a6kNdHf5fCdxc
 N0C9m+yBIvdx/oKIOB5ZxsNFm55Zf0Qzd55PHgkXf8J9Sc7n7WGo5ggkC4MmsKZYoxPMjlryeAW
 SFUc7HINHR8pZi+id/X1Od6OpxcUYYoLTg4y8uauXrrXKJxvbaF91MTXjWJqq25FPtVKj6YHyjQ
 6WPOj2Myfdk8/zW7IhjiP9mmTpv29A9PQPr55wYbJtZlh4e66ffefM6OOmOZN7+o7RYLK3GgmXw
 09QWZW5VnOnMTZj9VeM6GiQ7OOiSJADvLkec6p6aVwtJr1HHNVlzwzSYUJ1JPTsFAodBLmylWLd
 tS7htK7k6/JG5XDYk4g9PlloZea4DryKt6frGq0KvTGgjxQm0uscGmK3VRDyJPe2Wh9aNL3n+Iu
 CqQLT5MFmtMG2U+F//SWgEHxRzeuuWsh6eGbkSz8hNvD922qpZiUy9fj3ORVv9yiq5jVnlur3fh
 4bN1XtDlMmmxAREcxKoxaeFa2LHBJQDw/Y+JmrrMlVAC/qxLmhgMnYHCmmI25tIk3ooVEREfJcA
 IAQE3fSlSy4Su6f+RD7fKfmuezCAOQTK+y6FyW4LMDlW1SJ74TjLpSNHAxIJ5
X-Received: by 2002:a05:6102:418d:b0:7d0:5688:f511 with SMTP id
 ada2fe7eead31-7d64d756ecdmr4145603137.16.1794935991912; 
 Tue, 17 Nov 2026 09:19:51 -0800 (PST)
Received: from maple.netwinder.org ([204.244.107.52])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99e4a1cb543sm176415241.5.2026.11.17.09.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:19:51 -0800 (PST)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Tue, 17 Nov 2026 12:19:46 -0500
Subject: [PATCH RESEND] mtd: rawnand: nand_base: fix pr_warn text
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-nand-fix-config-symbol-v1-1-666cc78678f7@linaro.org>
To: Heiko Schocher <hs@nabladev.com>, u-boot@lists.u-boot-project.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1794935990; l=1413;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=KDr4Um/1Kake5hvul0fskSafU5yW1PrxHFLtFQVk5n0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLEiaMUl6oM0jukyHDWXBhyv1DeAC0HL2ixuiSIf9SXo0wS2XD4a1NOUvnJ4ZbeV3Vaoe5zD8BY
 NjwO9HnOgUww=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The config symbol CONFIG_MTD_NAND_ECC_BCH does not exist now, and it
also did not exist in u-boot 2014.10 when this line was added.

Change it to CONFIG_NAND_ECC_BCH.

Fixes: 4e67c5712529 ("mtd,ubi,ubifs: sync with linux v3.15")
Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/mtd/nand/raw/nand_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 48e3685d995..7271b6989da 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5070,7 +5070,7 @@ int nand_scan_tail(struct mtd_info *mtd)
 
 	case NAND_ECC_SOFT_BCH:
 		if (!mtd_nand_has_bch()) {
-			pr_warn("CONFIG_MTD_NAND_ECC_BCH not enabled\n");
+			pr_warn("CONFIG_NAND_ECC_BCH not enabled\n");
 			BUG();
 		}
 		ecc->calculate = nand_bch_calculate_ecc;

---
base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
change-id: 20261030-nand-fix-config-symbol-836c140d4e0e

Best regards,
--
Ralph Siemsen <ralph.siemsen@linaro.org>
-----BEGIN SSH SIGNATURE-----
U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4p
AiwvPQ/tR3mihuAFYAAAADZ2l0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5
AAAAQDLc9M+y+4NvgJ2jo/cZy7FV9LED6KUQkZltMoVosipiHn+hEovGoSBcKIXZmioe5q
VMZ7PKy3tG5GVlQfJwlQw=
-----END SSH SIGNATURE-----
-- 
Ralph Siemsen <ralph.siemsen@linaro.org>

