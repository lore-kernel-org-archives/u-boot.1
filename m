Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A2606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tDJEQvRK;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=YhHAL7V/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5A13407E5;
	Wed,  4 Nov 2026 08:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7WkXWq8oY1yC; Wed,  4 Nov 2026 08:52:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 18D7640726
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782335;
	b=Au2FyGh6ac2y3Yrluvd+Cswp+95wMIeIcmNLF/qwBWjWGB7KmkBO3drNPZ9GV8Ma+Zox
	 DdOUAGzOig11h6bXz3INzlsR3PQ6f6zX7+a6l3ayObaqfpalJ0fhL/EAV1AjmCQ2YKh83
	 tbnrGQvJZUZBSE3c7dzM9GJcqrq9tfqRbUD3mEgKuBMRbdM6F0bNlzDOV08ia7Ee0yMTI
	 IYuE6iqbe/VT0WPxncpN7fMRFvZrCiyN5UKadfYlU5toD2MhVxEypF5laiieUIoabOcMX
	 J52J9ZeKn4QpxuHRMRJqQy5cfMwz41r+N6hOebozVIT/0y5iv5lV411JhBzuYchAWpg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3Yirr5G0vLh5bWPfoNilqEJT5XaAexLT2Sk4ItQ963Y=;
	b=HIfQZSi/2KUvgvIlarHvt3SejJLvsWEBPiUYUcsK4mSQ3exDdCEENGRkOzCJaRBQwzz2
	 oWQuQnzH5maSudRORid0lkjqb0L/Kf+ZFMzWbu4mA/NnFXqv4HIVknCFaUxUybGhFUUjP
	 7zM7azePkiXOMzVk4aXf4r7lq8W/FO6NzCRNsQElW10mYRt+qtvsHJ429hZiDEhy5kJi+
	 7OmmcGISe2/MmS0C7kzr8iu5h58lFk6NrAFSzU7/tHYbSY9aN/xGJUTBxYgX8Zgju8elf
	 42xb5/ycI2B1gUgCX+lsfT9p9INlWvGrBggAtO7HlB351xui+g2/ssW1djgrmzWayvg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782335;
	bh=3Yirr5G0vLh5bWPfoNilqEJT5XaAexLT2Sk4ItQ963Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tDJEQvRKlN2uLgqsRpxPgaVhq/MPkwS99WUT1z1REX5xCL+N8h9QCdgnQImyb7vGO
	 TIZejv7Ij8CvHeHh6hCoY8e6mRgSLfFWXs/W1xvXk/82Rkg9ZlXfJHuIWuojP2JTWn
	 tKMKBcn+FpcM3+xF56MGZV7uc64VIB6mAGQUjzefvBLCtfX2cxdNeVi3KEJQRoOsMQ
	 k9bjhie/9jsZtcmla1ryhjw3MEaCGuzVgpzY0/KYiN+YEykIWkS713WAwHYvKs3o19
	 wHC/o0puZHgvInuHVlXpvkhTOmnyQwL47jTe0nDYlglnbDlnqbHoGh6XJseT529Iz+
	 S/lP4fVXuERUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18D7640726;
	Wed,  4 Nov 2026 08:52:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F303A2AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D807A810D7
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GValuC_f19vT for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 03B9180F44
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782330;
 b=Kx27USzHS+zg2AAG+Mhh67x5/R3KFIRp6zQzH2vkm7gzYXua5ro8TxAsCYMJvsaMWGxr
 bkHmjToe91vSYyGJChOafDg5dSsDPn/wXhODmF4wUhcvuMXrWOUno4lJWNJCm+3ymsTie
 litBIDNZTI5XqOe4+kVgvXBJHV8VYC0mnSr6Ov38jV4T7qGZGouK9zlqhkUA6DHJB03fV
 T0HYI3M3rlPODa38DBAi373UXG4jOk3WyRFV40vCBlvu9sjRYJZuefkIgmHilr8WdxEFw
 HpWpzgmjgjJfzf4MSKi1GL8wXJUaG+6oIS7O6M0+GVLmxLYJue8/bLNESa486JjLR9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782330;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=3Yirr5G0vLh5bWPfoNilqEJT5XaAexLT2Sk4ItQ963Y=;
 b=gGQpdty3AzVVF7M7g3un0ixN/Vv3dOU2QBkcgOzlcUXBK0HioH09oxDHDfAZ+Fq+mOpB
 XpqZeTbKHZc5FgzLa9DYl8rFQaOPf4pHD4jqAPgSTaz0CBxM1OAnO1JThEg38tSw2LArQ
 QdkTdwgp5e+Lya5UoIP9eKnwWLfxn9xCDy3Xnhu8xfPO9LPJfFH10mZygCBqbieCDq2cy
 11boqb3AzHpu5NEUhTHE5wzNM6Ti/zTitQyBiXHvyqAJqJJKcQotWLaSrAJ+3JUru3kSo
 IPEjTDlWWfA9eaYMcdNIi6swhZrij9zLP0Ba0wQ1oUdvGro9SCHrGW0LKmv5FY5y/VA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b="YhHAL7V/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=YhHAL7V/
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03B9180F44
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:09 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so2347325e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782328; x=1794387128;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Yirr5G0vLh5bWPfoNilqEJT5XaAexLT2Sk4ItQ963Y=;
 b=YhHAL7V/XwqwGuznozfCqb6ZIiVhYxDKQyeWjXEkj/LKhlmZYR+FI7Hny8KU7WlucB
 JvkWxp10KxkQOO7V5NIZJgIFguk43Al5pLKGV0i9+TbN16qZWfWZ/zXoRUf19es7OYpa
 JTyKaxGYJx472JHn9z80B8s7cjrp/ZsRgHJZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782328; x=1794387128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Yirr5G0vLh5bWPfoNilqEJT5XaAexLT2Sk4ItQ963Y=;
 b=p96gYbHExOxRkHV0dOtFeljn0EKh0H6SNxyKvPqsCryPPouJMg3Cu+lvKRihxTJtmB
 znwLzBWqHVSoztH5jxw0uVqrkNsghLWdXaPBEaMa1+93DHFMxqdqB07hNUt5AJa1Osu9
 pkQqZysYsDoRy9nfZPwoyc24NsJxnZjrGg44QL05COqt86EBe8UkewicZ1aZVWiK5SLY
 dFNbru4GXPY8fWQkcRcTLCdB5wmpMd0o2YiQQql+8hlSbFbRXO6qKUA3iUr3xYvlKiGB
 el/eysTsfQeO5fZ++DFZncZfwACDDKOqYHfQsFqRTrqct7ODxWevWLQCOGO9fTr73u52
 yOFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxm03x1Nsr1mEmBc9SFKDegMl9kX5nZJFfF4yYtCNQch7rLv9LmXLlo/vG3OD2r5TXwUTN9OHU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/FzeXdX+j/q7hdrtiFwVj1Vk3xlzGyAruJvCcXuUv6ZMJRCbmy
 cBu+R0WhBbNC3a9e/ZuhyNBioP3HD1OivhLIOkJinmKvnUHVdfamGT8YaP63lDcMzCk=
X-Gm-Gg: AYBFou3fRucDDZ+S/BLqIaCUOt3kguyCV/M45GEGUagDxz6tFTZUMljRqc6fHGeNkio
 dZRvYAIaL5qIhMKW0W5J4QP+Qv26MgzBxF9Ueu0rXZAM41qrHsHkKtRon/FWtwJsXDp8aX4CCeJ
 BffbizqeSjhtFKYxzG9HyXksMeUSYKS0OVHUizCQvGAZL5+hcTjCUktDqjorD0c0t906rjCWwS4
 aU5Cp/wWmqXpIJpoDr6HcnvGssa3s2a+g4maV+42/isdn2CR0N7oTm61ZhYhRM852H70DAIwOXc
 7jl4BWBiSj88/1ChNb1gDUYcPkME94uGF9vNIz9gW7RmdIZeTxXu9fMe5maWJr1j3R2X/QFKT/E
 Nfs3G5teqH5J/HDIahHTf0kFx1WcfjSoDCGPZzqedV3hhtd/adv7VAxA0/AOvr0eZkw/rs6FpBE
 gSvJ+mhy4hHdO9deBQeRPvOSxEeFV7GOYZZgT5egeH+soErh2vnts/1CIez9wS256Hy2OkSD6lk
 T3OLLojbelHqnSzU2BfNgWRy5OWwNnEdHwjdM+UwE1BwOXL5Us2Chmioz3UaZi0cLjofEoiAnAj
 bklBoPE8EV1V/kK/MJgz8TdW7oGYD/b18sRs6fis38SeKjEA62JvjeA35XATIoEgxClNb8EVQMa
 iiEwW3Ba4Sym6mA0XO6wp2itc57sdUnu40hhNk3tLsD2XndzY
X-Received: by 2002:a05:600c:4e50:b0:4a1:7d9b:d4ae with SMTP id
 5b1f17b1804b1-4ac16fa3523mr365357535e9.5.1793782327842; 
 Wed, 04 Nov 2026 00:52:07 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:52:07 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 24/33] splash: make splash_video_logo_load() available to
 boards
Date: Wed,  4 Nov 2026 09:49:57 +0100
Message-ID: <20261104085036.4012238-25-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Boards providing their own splash_screen_prepare() to load the splash
image from a board specific location have no way to fall back to the
built-in logo when that image is missing.

Export splash_video_logo_load(), which copies the built-in logo to
the "splashimage" address, so that they can use it as fallback.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 common/splash.c  | 4 +---
 include/splash.h | 9 +++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/common/splash.c b/common/splash.c
index 8a65ae597771..5502b4f5452f 100644
--- a/common/splash.c
+++ b/common/splash.c
@@ -70,7 +70,7 @@ static struct splash_location default_splash_locations[] = {
 
 #include <bmp_logo_data.h>
 
-static int splash_video_logo_load(void)
+int splash_video_logo_load(void)
 {
 	char *splashimage;
 	ulong bmp_load_addr;
@@ -90,8 +90,6 @@ static int splash_video_logo_load(void)
 
 	return 0;
 }
-#else
-static inline int splash_video_logo_load(void) { return -ENOSYS; }
 #endif
 
 __weak int splash_screen_prepare(void)
diff --git a/include/splash.h b/include/splash.h
index 7671bd7e9c44..0a3ea0346030 100644
--- a/include/splash.h
+++ b/include/splash.h
@@ -61,6 +61,15 @@ static inline int splash_source_load(struct splash_location *locations,
 }
 #endif
 
+#if IS_ENABLED(CONFIG_VIDEO_LOGO)
+int splash_video_logo_load(void);
+#else
+static inline int splash_video_logo_load(void)
+{
+	return -ENOSYS;
+}
+#endif
+
 int splash_screen_prepare(void);
 void splash_get_pos(int *x, int *y);
 int splash_display(void);
-- 
2.43.0

