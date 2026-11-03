Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D7606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VGGjF0/m;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ygDXcm9R
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88A584072B;
	Tue,  3 Nov 2026 13:04:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Brb-1jEU8XKs; Tue,  3 Nov 2026 13:04:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD46E4071F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711091;
	b=hWGf5FNm06nTnr9+Jjrox0R2lKZOjhW3WRgY4HKd0hgWvyAcuAsn3Z6qOEyf5Sgim3eZ
	 6Ed+tINa/qCqsre67izXFmAKm2x3SEtWifYPXbMTemoIWClfyxwgvEvkwm5gC/sBnH1ic
	 uPCQ5/XaRu0m3MeCXbLsQm6pa6nXfR3tzLDZac99c1+DnA0DAuVpgS+lsOSRmONYXUncg
	 EHMQ+fcOuqc3N4tWDGN8p2LDQ1yccoGocLbfazvHFu52QXQXt3gx9HpilwryMxPPEqcJg
	 ycn+lV7ZeVmB6t7dymrYdNepjIOaGecBGV1m248aU1xPjOX64lqg6JLaFkdt10iDpwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/9MnCc4+jEZ+DwVscl9PRhjwSlZI3xfDHmnUL8ltTXg=;
	b=C6HUtomZW9esrRW7XluedWhHVqoEQEHuCkbhZClKCwMs1BHsOZAN+wSBwKQK8WN02blZ
	 rcTRTq1Wv+MrUjN2u9n/+f9MZcIPFcUAKN+ZQtBaR7FrUbfrHU1VBy4qBkegIT/d5Oe/c
	 YHQyg1ouPogsNQa+reF7ED46V5xdbDZW+o6xxQMiOHjoEYwmk1NTE2tHGPEWVL2VGPaGO
	 IEnrbmxHt0VMO96RYzKw2yH1erZhlFKpabuVoexpj2r7MXoOGxCEgWOUDCyYLTyr8grPh
	 U14ash3VOIs0v2uuIo3WfxJ2c54P+ftQPcFpJwqAgCH8bBq7F+zwwuOaXpnUvRw4DQA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711091;
	bh=/9MnCc4+jEZ+DwVscl9PRhjwSlZI3xfDHmnUL8ltTXg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VGGjF0/m3W3T8fI3rIehU4fcKONi2K67ERf8asyGt/WFfKH/1pS2q1i38XduLPk9e
	 Lf3RmbtkBjUyrkYyll/2I0EigctUBtkhcBaIg6NOZwVnFwJm2AgQfGsruRNru1rQ2M
	 ZKQSD2YfixZlzcHEswBUgPU0qWY6Q0ewFjiKJPa77fHeX6BzQmrnpEH1nP/24jcWAR
	 Dp7gLL5EiiCWWupwzNxTKSzrgVl80uZ+rJMhbzvOoHr+qCBvl9B3EjUBMeecu0HObs
	 QUR1FpBJgPXtepuZRkyoFid/IzC/t3Jy+ZxbO18NLczBpBg3KIHTZaWN8rrcdKgonm
	 UOuI5/nSTWC2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD46E4071F;
	Tue,  3 Nov 2026 13:04:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C311A15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78F5040218
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2K44qs1IUv-C for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:00:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D088540080
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1233"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793696437;
 b=otIhz5EU615ARuLlqf3Tm61e+FSvOH9t/IR5nZK1BJQ/Ib488mZf8AzPuNpLFakZrJwC
 IDKza9mZrMUL+qzijjxGMaFCajjI9Sf9y3J6NBCtHxnWaieNBXpckZRwQF7F6xIIpJY6t
 LF9M7wLivWPstPponX5EZ6MF/XikszqPAiIrZ9ehmEYowJU/hqfIqOOvu2XXB+I8l7q3C
 w3MmPqrhHmzR8AcA4gmv4vSLQ4nQr5plUsdI+DAd72X8T32LZtZj5cvN23XZH19UMb/NJ
 5qUEpGJ+lztypxc4ZfAhxY/H4ZYLuWQCIIcBSFPbI+QpWcvlqnVZ7rTDxdu+/YFIx/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793696437;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=/9MnCc4+jEZ+DwVscl9PRhjwSlZI3xfDHmnUL8ltTXg=;
 b=rqkd8icBeWeALhM5d2gW729o4IbyI22SdB3FKaxGOEJccM1U3H+USbXXAJGMu5YHXFnx
 yvineDZnCBZdOwfDpWF6RlsX+opXMVYhtVMk7trcy3lheRrFDwD+OW3HVrJEjdxph7u5a
 a3ELBqHsEy32l2VYeilkGnZ0M6jG8nUE+MKZo2GfYEReLPwtkE6axEiP8KW0FYPLeQzHD
 Uv5fkCq/a3c17CJH8ZRpBx+JwloMZyuf7rBT4zgCtjtg8sl/xGV5s0gUJwu0xtzwCCRFy
 J2NFep2tEb7F30BmpbIPbiLno/31WxB2ReSj2AornVQ7bdBfvwka6CpVzwU+SfCPYoA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ygDXcm9R; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com;
 envelope-from=atul.akella@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ygDXcm9R
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D088540080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:00:36 +0000 (UTC)
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-15943c9c005so2698830c88.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793696435; x=1794301235;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/9MnCc4+jEZ+DwVscl9PRhjwSlZI3xfDHmnUL8ltTXg=;
 b=ygDXcm9R48x+OYpmPW0KM6w7yLvg3rjqK6vp4XtQymiowEdKjabs56K/eobPu134tE
 +L+IRAJpkoCxfItcwsZ84cYFv/40ywfQDvDy3vjleU9gaY20oPxzsAE+wd75LnFlWwF9
 nNHuMrcS6hyoRaRBEHzdQVlp6SVopVF8J+xyO9+e+Wk6vvtfFDvaaPACnQxqLufEv0cD
 84yDzGoVAhv1/J8HJq1Nc655hybZ4zs4650BdRLUzlBcvevHpwy0TROMA0HTRMaBPGMD
 O+nU9RF7FdRENNrVjpSk9KdE6got1MimaRto2gTqmA4mntReETEAgTVrE1XbKasAqYyD
 zP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793696435; x=1794301235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/9MnCc4+jEZ+DwVscl9PRhjwSlZI3xfDHmnUL8ltTXg=;
 b=erbtjDV65bNdy3VWRmBS0JZknzAihQqiFKfng2c1r4k1AFR6LbX8HstswfJWNn11VY
 H6LJLiLf/z3tvINo7kcuVVU1O7AAysfZhWpjAZ7PWUj3s8Z6CFkpahx4PLuxWOXJK8uE
 ZOman+kLS+qSiFYtesSDALrHSpZrudpwT/+kLaaTYc0o8n/yc+J2St9RfDc3UcM5W+mF
 BW+z8cy8fqGmti+aHSYecB7hhMOIq/cNaYXykXh8bUf0yte8dVqPtUFdYYNzHxucnwe4
 G6P3ybpf2BnEhlYPCCwSrCT+8nJWlbVjPA4NmC7fscP5yMlDl7jtWt3rLmuTC7ZSNuWh
 xMFg==
X-Forwarded-Encrypted: i=1;
 AKwUvByn9F0HiXmufK5cqFqctaStkW4C/YDDtkBgXqL3LJYLZo+rmVMBJhqbg5r7nJlcZuHG9Q2fpYI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/svBQ6yDErGJzBOt4xcE1Bd9pRIu2cqD2RZOmTpFBuJRiFv36r
 75WCVRwO/5Ob8bEUBPWdVfridG7wRWkKnvSgISDBTwLyyRtP7ozH38kd
X-Gm-Gg: AYBFou29o/v9UAlW2YNCgthREt3jRpZtYu/6mskOwlcKAz8G0V0naz6YkPStPyr+T0z
 WYUpqtl1FJP+C0eJ7HDwpRGIhaAq1wYtLC1YK8Txr30trBuzo65J9eIoIvEfIr9S6EE2tG+wGG1
 CDPgoniVXomSAOj293jmzriOC3YqvZeieaDJuqNG+RLQ15vIzatrhgmlTRb+g99ZNiZSAb7MwuH
 D5xMi5O9f0Y6RNBeg/oJiSDIwaekgIt7ggub+L1hRzDbwSRl2btkGKqks0Zmlfsg6uU2n4ZKnBT
 1cSMA4Co2S5xXNtxSPjpUlbN56pO7L45ck8i6nFhKwaoaaneMwzokUBTLf2nbQA+emwkSc/9DVK
 Vapx3wU2Zs0/qEEdqrMJLjrlCggLZBDvGSD2MTCUkHXyYPMK0/Arw9rOor4YdT9RBJPjFrLV5QK
 dEKkqVPa/sb/jj59mPbasUxvlM0awdYeSFFDCtJ3dFSlR3dR6x/OGGK9puZnCzfteHMgARe1t7d
 Hnhvcf6+9XQvyd4OC/cR8ZCpCVVo7SkvOIX8MfVUoybrGEWD7Qqy677F6PlJpQI8s/OVp6l8wQw
 /j6imux2gUTh1ukMzsaRTfb2tHNNsN6SRw==
X-Received: by 2002:a05:7022:e807:b0:1b2:4188:840b with SMTP id
 a92af1059eb24-1b2418884a4mr1291343c88.25.1793696434942; 
 Tue, 03 Nov 2026 01:00:34 -0800 (PST)
Received: from JMD ([220.158.183.16]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac19c6b969sm40032288c88.14.2026.11.03.01.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:00:34 -0800 (PST)
From: Atul Akella <atul.akella@gmail.com>
To: sbabic@nabladev.com
Cc: festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 peng.fan@nxp.com, u-boot@lists.u-boot-project.org,
 Atul Akella <atul.akella@gmail.com>
Subject: [PATCH] remoteproc: imx_rproc: make bounds check overflow-safe
Date: Tue,  3 Nov 2026 14:30:22 +0530
Message-ID: <20261103090022.1887-1-atul.akella@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The i.MX address translation code checks the requested range
using addition based comparisons, da + len < att->da + att->size.

Both additions can overflow, letting an out of range device
address or length pass the bounds check. The strict less than
comparison also rejects a valid range that ends exactly at the
end of the translation region.

offset is also stored in an unsigned int, while da and att->da
are both u64. The 64 bit subtraction can get truncated on
assignment, giving a wrong offset instead of failing.

Reject underflow before calculating the offset, then do the
remaining bounds check using subtraction instead of addition.
Store offset as u64 so it cannot truncate. This keeps the
arithmetic overflow safe and allows ranges that end exactly at
the region boundary.

Signed-off-by: Atul Akella <atul.akella@gmail.com>
---
 drivers/remoteproc/imx_rproc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 3f8cea127ec..570d22b6e51 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -248,10 +248,13 @@ static int imx_rproc_da_to_sys(struct udevice *dev, u64 da, size_t len, u64 *sys
 	/* parse address translation table */
 	for (i = 0; i < dcfg->att_size; i++) {
 		const struct imx_rproc_att *att = &dcfg->att[i];
+		u64 offset;
 
-		if (da >= att->da && da + len < att->da + att->size) {
-			unsigned int offset = da - att->da;
+		if (da < att->da)
+			continue;
 
+		offset = da - att->da;
+		if (offset <= att->size && len <= att->size - offset) {
 			*sys = att->sa + offset;
 
 			if (is_iomem)
-- 
2.43.0

