Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC7B606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AujdysnC;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hzl4P8iU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B13260AB1;
	Fri, 30 Oct 2026 20:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6RrN3dv6jNUZ; Fri, 30 Oct 2026 20:30:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A327D60AA2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793392229;
	b=RBLxZu7TqSiX7MQ+DA3zIXTASKFDGcjYI0bpVeuESEkFn1bmcyQL7+S4+ey0glff87Rm
	 z4atj/AcCixWjZnDeYXWoXlBr3Z6Lz3xMvLMswloB2dzTwh/iIWAAjKXnXatk5Dhb0uSM
	 JNN8SMorEkHT7cLjXGgYaYBK4dAzRU3m90qD0uSVMI7Yt9zuzoJTfGOh534Nl862mKrnH
	 kYzY17z1QJnYr6FAIxz4JQInG4Np3pWLJDpgpNPtsIiYDE3YX5pcSshRVaWlnnyzhGFgT
	 G5RjmNEVHg8+m2NujNUCRw7q62YNg0kN7LMGbacCRup4B3hZqvlAmaXxxjbtIN9190Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793392229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=af0I6JPQWHYAQ2zJrYlubxQbbhFByNcviQN3EeFpWzk=;
	b=FQ8bTSpgzqHKux9wO900OiuNCq8ex4y5bBHO8QbAHfrJ3zoyqb69CTF1ocFUACbmR7bv
	 t/Dlevnus9l6Wwpakqgp24YO3NR6AAHhw7ppiK3vWIEFStUCDFIW5Il5jCszwI29iVA5r
	 nWwGWy3g8Y7xh01wQP4cWGEXyrIVZVIaeRcxNkM0k1YOMBv8RdOCFEOKeVnQeHWvak241
	 tYoOI4eY4NliOHX4iOrCoYxhJqnQD70ZDwAmz1lTpUtfsdmmvClCi/NtGAsbeYRoZeRGi
	 3DRM3OCek6wHdhG4NH0t5nIwzlroL5Kbbuc5gUb+xYm3NRCTvEfcfPi2K0/7hszrE9Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hzl4P8iU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793392229;
	bh=af0I6JPQWHYAQ2zJrYlubxQbbhFByNcviQN3EeFpWzk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AujdysnC9DhgfA7aS/npxsger4Zd3WSlnbvQKoX60m5VkzmPCQhmRPOPvoDC6AptA
	 lbdTVSRQloHmpOm4iPv65ZTVe+nFMlEHkUkLGLKs7ojZCfSmF7awcZymr56tM8722r
	 SCltVRpy3Hv7z8k8EqjiCyGMbSK95Nz3IUXEW4GTPWx8xTsvQC0l4F2lIJ6uhAzg1m
	 VtgNd/FwxJflDMvjSvQKAwCnQrFk3ccKShUccWJCWye61wICb/k3rXomU8VP5irO/u
	 uQk9wc6/R9KN1giGh9SduqVCO5lus3CBKBo4WY/oNRX7lcsx7TwsS98l5VzLB6GGP4
	 qMgFRaLQ4b1zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A327D60AA2;
	Fri, 30 Oct 2026 20:30:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C3D4F362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 20:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A9DF860AA2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 20:30:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zdoETT5kavnj for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 20:30:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BB8A4608FE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793392228;
 b=bm4DL0h21oUOgFViiv7m1b5Vs1+9lwAwVbdGsQ+ndGMnHXbKDBURoV8RrkHcwXzEDGHX
 TGhXUB+l/AoB0SCbAZUMt1Dxk2YbF8Qkb9rwDajbFTUR2vstA7ZOH1wiaF6nO71GQuJJo
 hTex9akhAGMeJxUo6SDWJzJffKd4rmItcu6Ezx5l0040xcs6Tjyz/QsvwP7bv0WxgdSvH
 i55ARFoNcCmRFDvnp+NDQQweAee5JlAyuEPilLmtGh1z4X/mlvIjrynneAZng15xwfn9k
 Xso0smlbPc7OEoP+tl9kuYG3VJbwTR97SiERIbO0h31E9cqxv8/7UZQ8jvxDAsfmpbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793392228;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=af0I6JPQWHYAQ2zJrYlubxQbbhFByNcviQN3EeFpWzk=;
 b=nWd7IaxJ2MCo9dHsm954aaPv7dTNcJdxthFEz1+iYPBFigieZCvaMfSlJ6ZMP4xVBC92
 TtvDGKNobm75Ia6OJA6jenJMGBY3fuFfpq4lVyXP/nkMx1UNqtKHTU/aAMiEjirlVekB9
 HmJqVy9lAUKrivbSgPeWoBJfa0I0ko6T8I/xV9dP+XX996OX/shXLmg487GsUoITjqKvT
 7xs4Wj5BEYmAkjODrRKdhEvpTDvTpX694lPZE16jFiIuh/bl56q0V6E95zfNfIk3VYQZL
 FBl1zfT0Xqqv64f7NRrsgyJLXGSx/7yIyHONAr54pcTEVn9ilW8V6fYlSYOpgcAv/uw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hzl4P8iU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hzl4P8iU
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB8A4608FE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 20:30:27 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-91c905d7b6bso11947066d6.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793392226; x=1793997026;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=af0I6JPQWHYAQ2zJrYlubxQbbhFByNcviQN3EeFpWzk=;
 b=hzl4P8iURiZB7dpMF/oGB1EvPW645jNEsSW3zfmXNe0TdwehClzvmaTGtIAlE5WArl
 noBC2jUsfA3+yTgvPE8Kayo1wEQPUJPQ8IDzw0yGvHJXTI044MY2t8W35kY9eaJOOvwz
 nqATf1x9Be3F3e1jg/rKanhKiyuefFV2uIWc/cMbUaqw3MwbPs39WbOMQtSv4C8CV6yn
 KEgkPwtLBRUZwLsWqemKjhhNyBhHgtZbzvgy09ciN/9AtW0X3NuhquLLAMqR2R9K1TLw
 7BnMhH4zQlwNEsQWfPP+JXotlEf0JNeQlOVvkvGRLG5pyBgrtJkq7u4LadE34Spkkbbv
 iInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793392226; x=1793997026;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=af0I6JPQWHYAQ2zJrYlubxQbbhFByNcviQN3EeFpWzk=;
 b=KzmY0t87eOZ08Iw4LjD0qiZDoU3vNG6/ZEtEIy+3EizvRJU9i0+s2rPe5qdCqWgd3M
 72H9whW3C1bz/3+zSgACgO64kd8VTls6XHE9m2vhO3oNG6gokr8tXkG7vI9wJqLrFipZ
 3jqq29LRfcgGIcx9u/OUhSr0YfkCDh79Sb1D+RXps0Y+Llkpe0Xq9IGyYaGg5x3f3oIK
 Hq/Lpvq3RMs0ajZc3c5CLCi7cLQqmbRy5XEFs5C2ddp2/XH/WNRwQMm5UhhsZuBpP4JZ
 hgTOUvltdNwRQRdOn/79NjgEGf62rmIR+QxXenSzx4xyxpwldalp/SwxJJeEds1DYZUB
 d46w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmcOlg9MXAB5J5CSxSmQ/hpXRwIaUg5f6bbYVRa34rYnEyGlUfcNomYFieILu2bQdW4g4MHVg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIe2XtSmKSScmwIrGMgElmAttbFe1dcvf7ewN7QAWwBxGEHpRRz
 NPt0Y90nesjRZSPhgQCCf22NE/p7L2VhvAWGWEPyk4lWjCZi7KjGKcMN/wiGhlVzBfw=
X-Gm-Gg: AYBFou3AVMcRtxOZ860mUvw7JysSR+zMh+HcaXF42TWmdiSrZo6z4QMxv4uiFH4PR/S
 IgyV1AkXPTLT8QGyrzTJIWzjxiFDVh5fAiHLneN26sKxxrdSQ8Nrej+ebgURqDIXBcGxjz77qTx
 SPIT2BsaPw+tIm9meq8xW0/vQ/QcxP2+WcW3mRsawM6cF1WUdfZwco6yl2JOS+tkKsdxjJ4I34W
 hmEvXNw7OttI7NYqWDjNX0cH+vbcJB8CA5dRv7EgRorNmwrr7LZZu7cZjmnne2xT5ZCC5avHSBt
 xq4TZbDpqT0uEgj9367zCJHeCHrDDOVL2oOO3WDtrNyP4mVZ0+gzTYJW2Pt0Nf9z1pH1Rtn9mCy
 geX09vzvKa4wCVLDiK/eMj3UKZlZT0Qdkw6nViX2RqQ8EjKvpSf7NvMcraPbVr4RZ3IEZAdX+g6
 5hgrWL8CgPxOV5HnsdZDm4S6lM6KBXXJtnaEkvIRITFtK9wtcIQ4JVePGcbWMJcOpwMn6CRkFH2
 7DHilsyshmBy7+67fWe/hiXUsJzEXpc+zrs4iDyQ9Aw7R4UdWsO67+qXjPENU75BfNqmUrNHfME
 wZAYTMMzcaUlkgkqQ9lOt1nf+29YQp+q/+6DnIbtXriqzPn8ebadF6Vn/i6RnZF2qxgG2Mh4KyE
 KRqwavgSDjMzuWRTZ3JWGDGtzdMGUrSrHdAhNaR+XNpusxQ==
X-Received: by 2002:a05:6214:230e:b0:91c:996a:7fda with SMTP id
 6a1803df08f44-91ca4b684acmr55380106d6.38.1793392225647; 
 Fri, 30 Oct 2026 13:30:25 -0700 (PDT)
Received: from maple.netwinder.org ([204.244.107.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca804ee76sm24606686d6.26.2026.10.30.13.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 13:30:25 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 30 Oct 2026 16:30:21 -0400
Subject: [PATCH] mtd: rawnand: nand_base: fix pr_warn text
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-nand-fix-config-symbol-v1-1-b2849880108b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFz+5GoC/yXMQQqDQAyF4atI1g1kVKT0KqULnYk2YjNlYosi3
 r1TXX7w3r+BcRI2uBUbJP6KSdQMdynAP1sdGCVkQ0ll46gi1FYD9rKgj9rLgLa+ujjhtWq8qyn
 UTAz5/E6cR0f4/jhtn25kP/9rsO8/8zk64XoAAAA=
X-Change-ID: 20261030-nand-fix-config-symbol-836c140d4e0e
To: Heiko Schocher <hs@nabladev.com>, u-boot@lists.u-boot-project.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tom Rini <trini@konsulko.com>, Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1793392224; l=1068;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=Q+IsUj8HxWyuDIg/vWHt8KOmQSC0DjEByRrBhS39fn8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDmgmkcwUd6XugFG60aPHat0rZFpROK4rqojaaOxQkc2TsBKbdFWcGYY+qe+tZSn4/JcjRYVwKX
 5FUNE7/YYNQw=
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

