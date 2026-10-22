Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A22606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jCqhQG07;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OFtLcyCQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A30B8409A5;
	Fri, 23 Oct 2026 00:13:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qD464YldjYaF; Fri, 23 Oct 2026 00:13:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6FB740979
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792714385;
	b=nHHGC1/qcRQ2JH4018l22EY1ydgJtHLXeDf/GAg6tl92h4ggfOQiefIn32cxCAOWJrO/
	 1FygsnhQMZuRumzFRrILafE6+2VRAZRaREkax5FaOvg+QsaRehBTWTDGros2CZD50hYCc
	 n6U95oKfOSLrkPhStGNUY99xXXCKdRVRCaI3gkZoHyhKojaV/hBe5+N4MqAiIVR2jSjvu
	 eaNpsQTNp2AiiQsBAbbmNUUtEXPRfBSrFH/XJx0Meun+iYzE6hlijmiF+rbSOjYA7tjb7
	 8zD4XxSblQcqjgpFvIH21QkXDVpR7OqdaepK3IXHJa6Oh+oES9EBs6MRv9mZxxeKdIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792714385;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5gkvoX9DP2FuuYt2XWerLlwyxwpARmt/oKIcLIVCMVI=;
	b=sSP1XjkAvy8mR33KnIoeC7ub74cAlZp8s9DhO9x3oCku5gAPdeM1nOmGk3FyPE3/9uJi
	 RwMXvpnGGdIWScjsTDpQcUm5zqMBoPpZYKSK42cQmw1XntYx1ghjcm/At7EKQz4QZAZyD
	 4/JVqLGjpgHyPs4hHyaGcO2DPGWSgaJTrHVkRvRZ6U9TghwB91Dgm1X8ee2wkVyPyLzQR
	 zMGAGZ7/KhVt/4uMmjb6BXzI5H/6YpZ138e3mP4FG5nvhQm7QwEnrpMYuU+s/5QfNqFc6
	 TVhtx1xckao4ssq8B/eh2d5SEu4NNwJFTOFK5BCeVhTGMrVdm7mZrIaJIZC/VO6829Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OFtLcyCQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792714385;
	bh=5gkvoX9DP2FuuYt2XWerLlwyxwpARmt/oKIcLIVCMVI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jCqhQG07nNTYBS1fw3LDjIm7vmgj1VEoHn5BDEyzKM4eYork1zjWTstwTWDtmmVZG
	 Q0LCJYOvZHssWLVNro1iHejtvfqXGhkn1j92+y9Cl6wnU3OTblCdU1hzChdhBA+efI
	 UznqCBpDUnDsNZhNOJflit3xexV4HXM24jooUJ7SXepRRYOLsMWkV0ji8SKzbo6EIf
	 jaxsyBn7KltJXmcLEQj0d+b0+I6EDj+EDchz/B/04C6m8nNylZUPOMZtmwTYANgxj7
	 79FKD0aYRvfYsMiVdbMUNSxksG8NtkKDeX4tDMRo2vYu2yaVi4B2+ABH7GHCMg3yxT
	 NI35XCJo1gNfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6FB740979;
	Fri, 23 Oct 2026 00:13:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D772191C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C91684077B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:44:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5k_gnRuSlcG2 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 21:44:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 19B38406CE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::729"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792705480;
 b=MwwwW1iHWs0znrkPZX5oz0R57o6sXb/EN4reYuiFNZh3EQ7INMr/tna9TvJrNjwDRtH0
 R6V0Y2mpBKLeJ/FhR9eElCHblHmhm0270NOIurmeBRVYtXhz5df8jGzffOGR+xM3K/R71
 JoZudjY9BytH9WOOHDxuYvB2LfW66FXAqnQ45mYhSdcKfV3Awe/gouFgzDiADcH1sBzno
 5I5rb/pXcAwu9/OtLJ2rh8IMwRCRpdJniHtxLi0T5MtHs07ehNYfHZzo9AtSMnsGb91LM
 FcJiVeDjYoQpuj/fEnsNyutjkiC+3vXgXT4gXvrt3x0w3QeyiVz2LIkLf8yRGjJj52Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792705480;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=5gkvoX9DP2FuuYt2XWerLlwyxwpARmt/oKIcLIVCMVI=;
 b=pe0hBwgWlJ3P5ewqYhG1MuWOnexa9iyDkvhb8BWmzt3lZFY1bcJpha7LmrIeSBcvdIY+
 k9I5clniVMGJnW2P3uUiKkUAzjrFgSbJiQkugBRphwLJAn0rw0wnYCABg4llLZTnXIdBb
 B5CXLQIC9UVOSo8ttg1kCoM+OJ6LLNCqnc4I/4UwqGmnn9k6AHfFeQeFjJmwZcX2LJezV
 t+xmBXWzMO+NwpAY4DhUgnfW0SJXABo/i/QPgs9grjlKOTGFyjw9AoonOvZHFL/vvSrH6
 reGilkcxXW550ww2q9ZA9QPUGsd35cImkOQi+HyWWhJVgYYDdrIpItaK1FWXdQiURNQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OFtLcyCQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::729"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::729; helo=mail-qk1-x729.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OFtLcyCQ
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19B38406CE
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 21:44:39 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-93efc0452b5so17726385a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792705478; x=1793310278;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5gkvoX9DP2FuuYt2XWerLlwyxwpARmt/oKIcLIVCMVI=;
 b=OFtLcyCQS/NI+Tv81JrvtMN6ojk/lHBtjluvKJTSJNxnTlQpVZYhSMQ5OuMmBzDRzF
 dEJPc8D+OSXc/CAYP9H47IRSCU+L5TZ9jp2qYAkQObUmiGPWtefD3HmQx6bDT/eRLYxq
 tM0hQ5ytEU0x3Pj2wVL+g9sErNsZdubRqh6n61eu2YiDdaWf+indC+X5CcIKV4cSSB0R
 DR9U+cz36GmiMTfbuHrHMb2xIAZMnhyMppyK991cJ/LL31vMzXaU6GmDVMt09QJL2Sa8
 40+hW18J6XLWlT4U31Dr7nhF/gmeRxMyUtRdL284OgsPWYUD+Iam+0ipPN/hAjDDpLNh
 l6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705478; x=1793310278;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5gkvoX9DP2FuuYt2XWerLlwyxwpARmt/oKIcLIVCMVI=;
 b=Wv+CNHr1bVWHW/x/zD1nktQgEIfMOTmagFpgQcABZWaGNwehah8w2an/Dtz7jF5ouv
 X2Tiwi5hxXGwZ0IQVX2cIoCg7OcwoqlydCsgkPe8ffSVVgGcpaWx9iDpzqBF9coKsdPJ
 eX8qdJs+TXcSStkIbhPAIJLNICnYOJ8mbU80nWq+59RATFkrTgLXceXxOHsgRrYsfC3Y
 RnLcD6bOBp5GteW8JZ0dTwDZ5YICAqS0ffJLAFhmWzO8o0zkt2kccTlC1/e39sM1jlvc
 KRXUiNY4sN2nkJIJV/Y476oPs9tMQRNO++HIU+EjYF8lcByn8sxjQYvL6bXXTlYPgjbL
 sKJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzViq80GQrHutBJ/6SKRw8K7BsWIWr2HwfHzDjoohSin/250Ws+mybNC4Lr4dA+xD2cr2flAS0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLD7jBW1hHL1IdTZ6VPEE4RH1VmG5Brv8KiYiUZyVQfvlo4wXO3
 O9QgmcXKk15ckPi1YKg+bXwjvmWyW9pZ3p+0EOBP0rk8nXCEDs8aCGnX
X-Gm-Gg: AYBFou2jfo/pLA/8fe6JWjf9H6sDX1Oki9V7PtiL6/mgn+oSj1wGLehu+bzJ1RXVTvh
 rZ4a3xDnItyC56/QRpOguoa32uNgWigNl0fScmkVa8c2qGNDHmQf29BrTIf7lAjYM0uD6UXuDHd
 u2hewgBH9rFigW2yZRgcy9vUGUFCPDWqAQ0q7PPyVk0p0QbNxgVRoRE4TtlpT13lFN7CU0hknch
 znaF3kI4FX60KpCuLaSx5a0PzvT82ePMlhvKLIgYmnJNyW3MIRzcmB0cCxbBDNsHsmnxYdhBr6B
 yFhnqrENTYGGOb5DTupP58fiTwPHNG+Jnhr9q2wx0U20BPtCWcOwvgRaZtheIfJ8WnG3LXLQwJt
 KQKuRC/SB6Dacwpj6H3M9WwAvXUtyXuFYm30D8x+pATUpYsGsZxDacR+A50Ip65w3qkCdz/DLpe
 mWFPmri5CsIJUmX2NDOvcuIGWDjNciguhSq+fj23iVY8Oq+dTZcLljHFcDNZR3ztETIDnRhZrml
 5/hnMofdXLsUxxWMIswSLHCQIbmhPSZtitBPrZLGyeVmOoaZEUuPW/E1R+zbHWRY5Uc3KNw4Eds
 z6Hrau91PgnxMyXtUqRC9paX
X-Received: by 2002:a05:620a:2787:b0:93f:11ee:ba1a with SMTP id
 af79cd13be357-93f6f99186emr130409085a.48.1792705478116; 
 Thu, 22 Oct 2026 14:44:38 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f70f6e1dcsm19014685a.25.2026.10.22.14.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:44:37 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>,
 u-boot@lists.u-boot-project.org, Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH] efi_loader: fix image and load_options leak on FDT load
 failure
Date: Thu, 22 Oct 2026 17:44:28 -0400
Message-ID: <20261022214433.93112-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 00:13:01 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When efi_bootmgr_run() attempts to load an FDT specified in the active
Boot#### option on non-ACPI platforms, load_fdt_from_load_option() may
fail (e.g. if the file is missing or unreadable).

In this failure path, efi_bootmgr_run() returns the error code immediately,
skipping the cleanup code at the end of the function. This leaks the loaded
image handle, allocated memory pages, loaded image protocol, and the
malloc'd load_options buffer.

Fix this by jumping to the cleanup label 'out' so that efi_unload_image()
and free(load_options) are called before returning.

Fixes: 39bac24a48b0 ("efi_loader: load device-tree specified in boot option")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 lib/efi_loader/efi_bootmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 51ecb6ec1f..934f0c4060 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1323,7 +1323,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 		if (!fdt) {
 			ret = load_fdt_from_load_option(&fdt_lo);
 			if (ret != EFI_SUCCESS)
-				return ret;
+				goto out;
 			if (fdt_lo)
 				fdt = fdt_lo;
 		}
@@ -1339,6 +1339,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	 */
 	ret = efi_install_fdt(fdt);
 
+out:
 	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
 		free(fdt_lo);
 		if (fdt_distro)
-- 
2.43.0

