Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09178C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 03:16:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B725B811D0;
	Fri, 18 Sep 2026 03:16:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6tuzHrm1C8u2; Fri, 18 Sep 2026 03:16:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 10C3A811AD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789701405;
	b=UpGFr3Wn32eGq9YAOQ+gTdnYJCDD8ej4o3QYBTe7R2IIquUfxL7x4IEB5aOwbJ9SRay3
	 bAvjB6SSnMK61i0bEHuFN+bAyg/cHjQMyvKhqG5dZqyhsHK2ZwS1jc+kguj7rJD1WNSFp
	 TNCP5Ov5Y3wsHD2Rbh9UYC3vqC8l/oqpxg3rlFyw0Pu3TVlP8Nnty+IJOEXrgw+AwYcn1
	 gYI9puGHsjvTaHlyfnxM/g7c8wGPClhd6IALZrg59Bdslj5nljO/Upf3uUltC2r3ve08N
	 ggu/v+hg0arDDE2CuwgbhteWHygeZ2B6gN30HJ7mif/y1gcgfy7ew6a8jSXMmxsh+Kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789701405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vS78AgmfACh/bT8lSFnqPuczN/4MLZkDZAJYN/3QHes=;
	b=rNFPPAQXGJOafdf3lA1R7S83U+4PN3z1axkC30nUhtzbdalmoDhYBHydq+VohoF6T0Dp
	 lJfFl4RYDkXGhAfQDN5MDCuNgIvDwi69OJ5g3zUGkc5ZTm0LnUDpE00JXr03E5YSvDTNI
	 KvCN1AfAUlaQi+r3Gr5hPb98Mm/LBkq2MbyB0H0SDFoh49a8JqCyrzxZ9pXL7br8JbZAF
	 FMT+sTYPELxSPxPb8QT2n47mMc+OyeV1XdPAP2ppIrmcknGnFvskJJudAvUzkrzbrihWM
	 YSDNFYVsD+W735bxDdv+nqNRqZyV4vqotBWmGS6VzgfYJOocvkRIjGfGk3Idei0s+aA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789701405;
	bh=vS78AgmfACh/bT8lSFnqPuczN/4MLZkDZAJYN/3QHes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GOCPkGc5jmySZ51DLRhfQkt/mrh0oRavcAKLPRwJ2VyesoWRMZ6MrCeoIhurgxRaD
	 oTPM49rtZd+m3OkXBCLDrnkFHARZYZRx5LhnEK5uuGstwfHc2LAICG/KDkAWBHILaf
	 IibJeVcZAcnkAOo7h0oos2FMTJqcXAf6ztUNgg10thXU0qqdZglgP61a+9J9oDR2QU
	 UEam6zB65ldhHD3lk/edEK7casBv4VEigGIRztGyBlMDSB41GrNlVXTZx9/XaA9sPd
	 hR2r91v909bQL71mnclJs0mAbwS6p/PsJpUxccNzBcih+evkPQNUsh3/7O943vENjh
	 x8VwwtkjL2r3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10C3A811AD;
	Fri, 18 Sep 2026 03:16:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 959B5422
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76CFA40492
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DsL3RwyUG3F8 for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 03:16:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E57DE4008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789701403;
 b=ODR4+IWkGY4bP9xkS6NHlMZPPkbPvSo7HqAzMa5/w5tjtb2QbKYMthn1pXIQD+DZS5N2
 bQ70DHbpcguLJWCyBk60gP7Q+OU7zrkJsMx/PtWWwhoLtCvlHawayZ2HUeIPCQ2n8mMaV
 V3H/PuE2YVdOv1A1uv/XM8RMfNtLSsgCv/4W4m2ThVGEk3q2PUP2yGUa5J35lDffTjExk
 5sCZ4F3PiHu3rH6paD+gFdnoBFL9dRNAKV7fX/dpVbBGGI9xNbbk05EHboVZ/s2QuTvl+
 D+gKPuXewq0TrybnLzjnanIgUhpql+KKjiKnSRRSCcoJE7wAhKq+l7wrgTv7w8jL8Rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789701403;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=vS78AgmfACh/bT8lSFnqPuczN/4MLZkDZAJYN/3QHes=;
 b=E9sF33x1vnj1jvX33OFJq3L96KyzL64eL2AX8Y/HOBjOAuWSO699OsUsGzepva0aFSfA
 MvJXXzifeFQG67ldZBllFUVBLxxoO8Akq7jIqmVtAQv+qrfu15iOhy0pmlVzxktmOmCpl
 yaC+aMd2LLLlCajJ9UQDouIxShjU0D7h3JSNhVxii8o8DPuAJRTjOBxklvYJCqGVilQhG
 0aoPZAd3msreKJc3tDmJgAZy44Z6zb+f3RNgd3OM6Z1AKC1RRS1h9cUNmhrHpgsPAuLBc
 QA4nqo3fnroWdWjc0WOJcLem81H8sfgC1tK4DwozOChtReYMapGWa5HhbEM2O+JXWiw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sxeEBrhR; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::e;
 helo=mail-pj2-x0e.google.com; envelope-from=jim.t90615@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=sxeEBrhR
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com
 [IPv6:2607:f8b0:4864:39::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E57DE4008E
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 03:16:42 +0000 (UTC)
Received: by mail-pj2-x0e.google.com with SMTP id
 d9443c01a7336-2ddb44ad1c1so1778565ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 20:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789701402; x=1790306202;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vS78AgmfACh/bT8lSFnqPuczN/4MLZkDZAJYN/3QHes=;
 b=sxeEBrhR2N4t1d5tAimGNoEyzhEAwuqP5vuu6E/4peXePwZ8XpLn5LsuOHWpLVY+6+
 HrwSFvtwbz5UwYJeGVIQjiTU4e1Ih7NzVgdQhwBuzfRAsCbnvMJmkl7g0eIdKg/qVwR9
 m6SAMpFmjem9btEL+kmHoem8FAfuBslUOOFo9Iy4A0M6ejstmpoRxfvXepA1hl/dZsUj
 /Z5cHLw242E/9qBoEzdzu4E0mBCjcc+GTHO7i0IdU4mgOc8qFjJwk8zIEOw6xzrtM6iB
 Kq1KNbG6kuaSBzOXvHCgQlDDQ0AB+NkFrcbdaTCj3m5tepf+ga90s+INZEWSGucSR6q1
 b6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701402; x=1790306202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vS78AgmfACh/bT8lSFnqPuczN/4MLZkDZAJYN/3QHes=;
 b=EPU/8lytmotN+HN3qZ0O0gQ01dkVuY+DNmkKBAF3IVBiVMLe019B0MIFkbrYyQbing
 kc/0oESAYHMCZz8GAxj0Sey/dFrp2fUWGJ6iaZhecIWuYzW8A+lGq3iAmgn0zh/eMalz
 8bkQyHY3CUIbZ9ZaZmIo3R5lT21mW3YZtrqOiWCKzJGZhqwZtziazyuH/GeYZ2hm+4Us
 21bxCbrrBG0ykSPIvdaV9QSWiGtSImSB+lWwidEB/QZmRe9DmT6m59cGa7IuA+EgutjQ
 cLfujEl4PgLSFP7jLDrniQesoYyEiaGImB2bfbFAmXHLOFSS6OYoG2wQI5VvSCYLTdqO
 6tiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxL9upB40JBwsyorJo58RMyfP5G8OZlCj2DNQ6RAVDkZy+4Fmbf9EiLTyxgnNPkxiY84kuVir4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lmPjw8x5pDru55E44OlIsojpc85cDzBJCM1EuFdrD1H0Uf6JhO
 2xUW0xQnMDYBqQndGAnXRTswAsS0qDu0pq/4xeVCH/Huzh2SpbJF6mTB
X-Gm-Gg: AYBFou1cUh34JsZS4xpE3s5kKcKm+5XK/PP0nnzrB60BKWCwMtjJmO/oIwPxdbqHL1R
 u+rzdWPh3uIgG7buo/h2TS9Y416TJrEgkNLF2h8VBZQEtGMVj047XTHbhMHpPVBzi+ZJS57lwZH
 5gvF9K0Zdhi2TZTx/dJTjbw60wIoUDNpErAslBqaPQB5zfc/zjP/5QbYDKFfU89u9CMN04pUBFR
 JEoQEXtJT9zBa9/yfFcllspdv3BYHdqJzwj3Hb7xYazmlvxZ1C7OIvhgLIeQ05f2g3aD6UDRM4m
 wj/4HMz1LGNP5sh20a8INFclth6osSwHL85bNtQkKUgatOHQHCHHk8wf+a7SzR8y7+c/JB4QiDk
 jPSzXGdFEFdRTNt7pU5PCKJpCEKnpFw9aK/Nm+Qj7IeMs9KbfmHX5bLRffWs826AgLVexkSaeOl
 PoFxZdmtXXQN8Ai95cdDMsw1MpKoxjIKDxsG63OAVowpiNUEcYEHDoSGLGUgxgpL/aCDHkLNrVi
 r054A/VUC2r8VN2F5E=
X-Received: by 2002:a17:903:98b:b0:2d6:df31:5bd0 with SMTP id
 d9443c01a7336-2ddb1aeea6cmr21111005ad.10.1789701401914; 
 Thu, 17 Sep 2026 20:16:41 -0700 (PDT)
Received: from cs20-buildserver.. ([2402:7500:500:6259:4c39:1ad1:29eb:e47f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb75b53fesm874505ad.59.2026.09.17.20.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:16:41 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, trini@konsulko.com,
 dhphadke@microsoft.com
Cc: u-boot@lists.denx.de,
	u-boot@lists.u-boot-project.org
Subject: [PATCH v1 5/6] configs: arbel: add network timeout and watchdog stop
 env settings
Date: Fri, 18 Sep 2026 11:15:53 +0800
Message-Id: <20260918031554.1855939-6-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
References: <20260918031554.1855939-1-JJLIU0@nuvoton.com>
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

Add the following default environment variables for the NPCM845 EVB:

 - tftptimeout / tftptimeoutcountmax: relax the TFTP timeout so that
   large images can still be fetched over a slow or congested link
   instead of aborting early.
 - bootpretryperiod: extend the BOOTP/DHCP retry period accordingly.
 - stopwdt: convenience command to stop the watchdog that the boot
   ROM leaves running, so the board does not reset while sitting at
   the U-Boot prompt.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 include/configs/arbel.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/configs/arbel.h b/include/configs/arbel.h
index 63112baf9b2..95f6c365539 100644
--- a/include/configs/arbel.h
+++ b/include/configs/arbel.h
@@ -33,6 +33,10 @@
 		"console=ttyS0,115200n8\0" \
 		"common_bootargs=setenv bootargs earlycon=${earlycon} root=/dev/ram " \
 		"console=${console} ramdisk_size=48000\0" \
+		"tftptimeout=1000\0" \
+		"tftptimeoutcountmax=50\0" \
+		"bootpretryperiod=60000\0" \
+		"stopwdt=wdt dev watchdog@901c; wdt stop\0" \
 		"\0"
 
 #endif
-- 
2.34.1

