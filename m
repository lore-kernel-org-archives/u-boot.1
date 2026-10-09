Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB45CA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 09:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2288581499;
	Fri,  9 Oct 2026 09:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3Y0IWhKygmV; Fri,  9 Oct 2026 09:16:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4AD1E81495
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791537405;
	b=kvxW/Qjgn6Omxb219s3K5vh5MlgYe4gSJ88urz68APnfTmTwPhwhWDW8QqA6+xTUtd3f
	 pOJWZtHn+/ZOUSzPfXq7Mu8cCvq5sNt2WuOw/KvNetrlyqZEn5xzUWpjyG+/C/rGippS8
	 i/0z68KYX3AikImOMxV/GWElj+AtZ1bw2IfiwN4ltYsbKcY8MU7qkWlsUalagC4FCKumV
	 PRScjY+ZRUj6Gg5ffhc14DNxtI+2uNRfmRkyUbS1727+yw79ZuX+sS1dlRKJZ7jX65+dK
	 VHEpzI3pwQusrgddAY33orAJga+boOjEMyIUuoSPDG1RPKIy5FbjCDj3SaicSt/zCQA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791537405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=V2tJMTNV05+gKszuIOyhvrUSh05Y/+LH403b8CxjGX0=;
	b=TEvrpPlsT/FqwvYiZ1PdoH3OYgxMTfKUCnWcmEhA8gAq4aQCtmrLS1soJ+Gh/pgdJHjA
	 ozYN/6WRgvzQvefJPamp/ldBoFDNQNo9WtyLJrv8idU3xiu8FMRbdFNOOfbecSvEtr0Gi
	 NKeuHJOkBCIT/6H60Um/dlVUa6+zc5PTsYNcM/LbGJ6OaMyBX1qXJssVbm3cjkH5B891g
	 honONXbVDulaPl9sL283E6NRUHbOj8t9DoEnGIhEO98bzABAo8rUc4d8h8a/SK/7f6ovF
	 AuDYJcjE5mSCXQDVln0ya1EnMZCd5P58A45pUI3AHRweE/bBjuYMZ4aoMRlGxMCXy6Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791537405;
	bh=V2tJMTNV05+gKszuIOyhvrUSh05Y/+LH403b8CxjGX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eyHmvEWDh09oFFXSwURYPOYIbx6SsS8JVqz6ItmIeyt90LZkjqH9cBNLCy89OG7aS
	 PgTZqRFi6H8SbzvJwCMisptdE0Lw66xY8G2wy4Dw8Wt1Wn1uB9Dtv7+YbsMFcJBDCA
	 jZ8/Tuoq/55W3DhYuhj/8zVXpJYUoFtx5L/iSJpVodsgmiApVXyvaBYBHyRTMFai/k
	 FJRgseee4Ob0gJSVyyHUNPJzJ29W90auvFfJ4UGEy3IZUVHaTZn0dmFrAxvrXYM2cs
	 B7JmLLwv8jbjjZlfB9uxsmDD3hcSjg0mD5PLHXc2IcJy4Lby1JGO7RixAoT3DgQaJD
	 GDn3dk8IRTCIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AD1E81495;
	Fri,  9 Oct 2026 09:16:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8139F75
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7309E400B7
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UijLExOvG94n for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 08:53:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3135340061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791536006;
 b=jsp8yMZKzY6DlDV5qn3P4dPjmJjy/gJ9VJH8atMwMT0JVwlsOh2/xQCMKL2GKgQ1uz7w
 OALj3b0yqknQy0fwLKdyss6MV46ra2Pmsz12G+PbedhgINKxt6hOOMLCTOxEk/5lWLvl4
 SaOJizMu2c9PKBhf8Y3e3Kdqzc+kYQ62yVHDHxo2CX/3ZQ2NIpHCHCsUm6aeojZYPDgxU
 82rTz4Ns7KK4dQjW5KGvmRoKLF5rslR69WPWth+jllc2PVb9JRQKnqZvEbSyjXiMGt8Tm
 SDOCroZPiDLDmVlIDGCHWxWFzMlpnafXPhe1wNdxvUotM+8RsCmw2dbu1cELhdhz4DA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791536006;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=V2tJMTNV05+gKszuIOyhvrUSh05Y/+LH403b8CxjGX0=;
 b=HgFW/qa6LEt4qdRaycDsZumO7gbfsGVo1Rx6IU79zYDWbL2GqcT4SU/MHi3J1EcB4kEj
 2/+LclUjRufbahFGg4bLjl42s71JoHHUtl44zha9kKvt/dMQwuw5t4ZCOvx3kjWCZwjBn
 DJA/N0WH8tYxtn0wsDRQZ26IT8iEZIJILT2gdV+9n2KJ4aHF8QstolJkGBrTiIp+OdIdU
 q/BNtgC5D/oeSEjdSGyaEvbRK2n5Tw7hpu2DLPEHzW3StRxJfoBBW2gr86Gxa2BixO3Kw
 sJCY2zsaD7gNcVag2PDqBJReSaPfqnv4SwreUjGXa1dhnMws1fbbXVsNTCitFkry5DA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=E2wXwf1E; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=E2wXwf1E
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3135340061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:53:25 +0000 (UTC)
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9ECD63F98B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 08:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791536003;
 bh=V2tJMTNV05+gKszuIOyhvrUSh05Y/+LH403b8CxjGX0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=E2wXwf1EEGKq/yb++tUPnbdLYdQoK7KnSstTHLkHNI2O7Es4QQ3MpN0j0qXEww0Fs
 sOlphlEsPHI67Cpu+10CZZToIaYef0H/iqLoZ4xpBssWjbS7JaFUEHj4oRZya6DQr8
 cYDm1NhHMKZyR2Yg3bJfDQVHEPtwDLseCxRUHswvESZIdFutYJt3kXd6Kx9Ftb1ty2
 CqmBlY7CfqXVPHShpkcN+Ow5azOQ1X7ZzOCo4aLVTnRstzto7b4Gs8cLMYDV7xScLE
 MJJtnIPw5ACh6b1plCg7kk+PmWboW/coVygkG2uijzw1tw0vcGQ9CNG7B6Z/o/CPei
 hXEp65Nas1B6NXTnbqtgy5PjPOeNbYUbCV5NxOxsOZLmnpTURm4pWvPF5oaxGEhMHH
 q5iDPNcZP93TZia+JMFkzffcQ8lTOIKSitsNXNUgvpmtXQHFf9PMnbjAZkSNhdqaua
 17o6UH2FEjdn1xlQDzn694rjVJwPDU5G4GRVvtXq6eqVFvQbJgdjf+khRPMDaQTOuz
 pKC4J5ocTRF4xWLS8FIOlHJ0f6B7r5bfzNfKE6/0CLmTbBML5D7mKVlFF5hCX7ngx8
 RfwWVMQcO+1M+Gcv5Tiw3q2r2HL51KC/4r2p3v5tkubyfwM1KVF8euXmbZycJST908
 3A8caM2MC5R/b+j4lKkYCLoE=
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-155a75f91e1so4981437c88.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 01:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791536002; x=1792140802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V2tJMTNV05+gKszuIOyhvrUSh05Y/+LH403b8CxjGX0=;
 b=s2udsKOHaEcYbD6ju13AlEJhgUU8kpbhSSfjl9JTbL40VeXJd5WViZpv/wqTi5kQ3g
 ZybveXccLjYWtAf2SSVt8PBqO4+emcnrHsOrByh0AjEc4RHPWsoe91sPRMg0rh6hVWkz
 vheQEb24q7Xzj5YIKUtNYvOnIbx5cm3pPfHbkPbhdN78RoIhSP2/jZEs/y5ViIIrqTEj
 64RKM9lkGnIpADa92JBD3dtERL8ss5ehQw/FZkB/MbHRk37q8gigzhh0ccvecp8Gx89e
 0X+fdK8/ZANtTCS0XuIXr6OmeQgWn/NGQMq4hQ8ZvQS9nxfj6Y/cwr3Qnny83focXDep
 e2bA==
X-Gm-Message-State: AFuF++lzw57k9j/mRbgMHQUBsqiRHBHEryF+7ASdnnGbJCdsDSLktFIG
 CX92YRC/HvyzAdUY7amuDvM7Ycs3Q+wrHKAjwyYDgi44AdCBqo0k5CV90kKnFMcs24GeoWDtxqg
 Npc217kvXpZcYsmxyBgl5x+UeamHSL15JGEiU8dQ65RUIKnlr7F2Ufz6AjaE4jjanf5vSXe7X+l
 2sA/tmyvSJt7cDQA9bvA==
X-Gm-Gg: AYBFou2Jrj2eaczZj4b/bi81OMI65cIx1nhEh4Inh8KSDn9WLKtg6CYkQ0x2tmu1Lj+
 i5N8ErvPCYMjwVcflkZBFojGeg+7mrgsG4GLUbV8m3mb24ckifrZ5SXFbvjqtVmdu+w5k+B6aJ+
 cUMlucmnJOIL6qPBPstA6oxv3f+MOpYS4ua1IU8p+ugLySGfzh7eAV0wvQPSulOstsrf1GJVcvz
 DSoXT7JEtye6wZ02FwKbqmngoB6wD5u1pR+5prLwAwDy3vQREdpbtiumH6iXvZImDLYRj1FrVRC
 437rJnzOrJmLbp17yh6LDESn/wCKFTrYfgA+pmcW4SdJXuVa7UywwbyFWSVjygXq81pCp7HFm1V
 x5VjdgNfo98CiZjsCfqr/mZUoiBDNZJJpLisDB7dcLQb+r7P+delaV2UOV51rQAxY0w==
X-Received: by 2002:a05:701b:230f:b0:14e:37c7:2b20 with SMTP id
 a92af1059eb24-16a5e77ca9emr1760022c88.20.1791536001940; 
 Fri, 09 Oct 2026 01:53:21 -0700 (PDT)
X-Received: by 2002:a05:701b:230f:b0:14e:37c7:2b20 with SMTP id
 a92af1059eb24-16a5e77ca9emr1759998c88.20.1791536001424; 
 Fri, 09 Oct 2026 01:53:21 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a32eb7ebsm5765591c88.12.2026.10.09.01.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 01:53:20 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Daniel Golle <daniel@makrotopia.org>,
 Pranav Rajendran <pranavkasthuri@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH v2 2/2] fit: use FIT_DATA_SIZE_UNCIPHERED_PROP for
 data-size-unciphered
Date: Fri,  9 Oct 2026 08:51:15 +0000
Message-ID: <20261009085250.331110-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009085250.331110-1-aristo.chen@canonical.com>
References: <20261008070116.328864-1-aristo.chen@canonical.com>
 <20261009085250.331110-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 09:16:36 +0000
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

Commit 195f273b6c86 ("tools: mkimage: resolve image-data references
between FIT images") added FIT_DATA_SIZE_UNCIPHERED_PROP but did not
convert the existing code that spells the property name out:
fit_image_get_data_size_unciphered() on the boot side, and in mkimage
fit_image_write_cipher(), which adds the property, and
fit_image_cipher_data(), which checks for it to avoid encrypting the
data twice. Use the constant there as well, and in the fit_cipher unit
test that creates the property.

No functional change intended.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2: also convert the two literals in test/boot/fit_cipher.c, as
suggested by Simon, no other changes, Reviewed-by kept

 boot/image-fit.c       | 2 +-
 test/boot/fit_cipher.c | 4 ++--
 tools/image-host.c     | 6 ++++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index e173108033b..cf435329e44 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1044,7 +1044,7 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
 	const fdt32_t *val;
 	int len;
 
-	val = fdt_getprop(fit, noffset, "data-size-unciphered", &len);
+	val = fdt_getprop(fit, noffset, FIT_DATA_SIZE_UNCIPHERED_PROP, &len);
 	if (!val)
 		return -ENOENT;
 
diff --git a/test/boot/fit_cipher.c b/test/boot/fit_cipher.c
index b98c69fcb0b..3bb73ccaebf 100644
--- a/test/boot/fit_cipher.c
+++ b/test/boot/fit_cipher.c
@@ -96,14 +96,14 @@ static int fit_cipher_test_data_size_unciphered_len(struct unit_test_state *uts)
 
 	img = fdt_add_subnode(fit, images, "kernel");
 	ut_assert(img >= 0);
-	ut_assertok(fdt_setprop(fit, img, "data-size-unciphered",
+	ut_assertok(fdt_setprop(fit, img, FIT_DATA_SIZE_UNCIPHERED_PROP,
 				&truncated, sizeof(truncated)));
 
 	ret = fit_image_get_data_size_unciphered(fit, img, &data_size);
 	ut_asserteq(-EINVAL, ret);
 
 	/* a correctly sized property still works */
-	ut_assertok(fdt_setprop(fit, img, "data-size-unciphered",
+	ut_assertok(fdt_setprop(fit, img, FIT_DATA_SIZE_UNCIPHERED_PROP,
 				&valid, sizeof(valid)));
 	ut_assertok(fit_image_get_data_size_unciphered(fit, img, &data_size));
 	ut_asserteq(0x100, data_size);
diff --git a/tools/image-host.c b/tools/image-host.c
index 7718d8f678a..4774c1743c5 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -529,7 +529,8 @@ int fit_image_write_cipher(void *fit, int image_noffset, int noffset,
 	}
 
 	/* add non ciphered data size */
-	ret = fdt_setprop_u32(fit, image_noffset, "data-size-unciphered", size);
+	ret = fdt_setprop_u32(fit, image_noffset,
+			      FIT_DATA_SIZE_UNCIPHERED_PROP, size);
 	if (ret == -FDT_ERR_NOSPACE) {
 		ret = -ENOSPC;
 		goto out;
@@ -623,7 +624,8 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
 	 * image is already encrypted. This is important as 'mkimage -F' can be
 	 * run multiple times on a FIT image.
 	 */
-	if (fdt_getprop(fit, image_noffset, "data-size-unciphered", &len))
+	if (fdt_getprop(fit, image_noffset,
+			FIT_DATA_SIZE_UNCIPHERED_PROP, &len))
 		return 0;
 	if (len != -FDT_ERR_NOTFOUND) {
 		fprintf(stderr, "Failure testing for data-size-unciphered\n");
-- 
2.43.0

