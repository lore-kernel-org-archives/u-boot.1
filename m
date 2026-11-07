Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE6606A332
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nVJOfMwj;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=CS/YdhL2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06F6F8190B;
	Sat,  7 Nov 2026 14:34:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bDCM1Z6zaUpS; Sat,  7 Nov 2026 14:34:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D901481947
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062041;
	b=iLTj0BtCketzp7RRqD0zmddi+NAGkkiBLsBqEsdnxnF7v7woPUXsqnHCDUcMBk4G1cBQ
	 /wEc6vHrqEo5wjt3kwD1XIzVOIYdnONR7LepcdFwk5fYSt09qZDlF+ctRpERqR6hzkemv
	 aIN/wLdEeisMTExPdQMJvb41yQJK/Qbazzet99GoCVKI4CI6lYLQ/JItR4utqjsswWu0W
	 V7FHsmNQXqpy/smx4NeJsLc33bIxFB86iTUhnbLwrfGSA8i4+O1LxpSamJKOItsTMpxj/
	 BoxBl2R9jjdrEayi5DCRZ53K60HyZUVBeicqqj/iXlyQCDkzUiQZtYyLRh7aSWGxA6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062041;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nhUt6kKb9TBLQIVvKxk/BxLHQjlwHQGvC24ybZRv3c4=;
	b=fJS3Yvy+XFyrS2GwowpGOLV3TPDlrU0NnZZOR6IiC6jHPWtu9uYkgdSqSjdjikhdwNld
	 tlOuafHMTnZcvVYqbnqpuwk+SADZaLpK2MNWmFbwkmcoH4cTXHjQ4zlw4QryYKN1yglUd
	 2bjz/1CVl6veO/4b/4HHyoP9SDAfI+RlSXtBSyPwLPFB0H93gaaqOzjNWViSc3m3Chpiw
	 YIbHKopkEt658cEqmP+cCzf619zV9WJbJXNILo9RKhdb2r5eVSVhFqSGP4S48ZGqdF63t
	 AP55Vd49Thel3dlMYHZzF0obQdY2YEQcbanMWje0GPPNX25szXDhst/MbDpvffd0HnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062041;
	bh=nhUt6kKb9TBLQIVvKxk/BxLHQjlwHQGvC24ybZRv3c4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nVJOfMwjzvgaZWjiB6yx89APiBgarYWQvnBzXY8ZCKDgOAXIMcJwEyaznb5kDJLHl
	 O5kdeVZRpaBnUPCCXouaM2I+eXZzt5AuOfPdxjU1YQ2FVDOCkRqhhZhoMCToZkoxe7
	 neYcMHOW96wzL4aGOkzcDTrNBrL4M17uzFH+ADCEaZs8g8r2tBa2POgOVE7ZhGYZyg
	 nYthN2hxY4XM35Pon+f5z9kx7tOVOgts5IqXXf7PunN/oMra3aSXiOynm6pdFKJMha
	 hnvHbe+wfw2OxDAdFpHcaBXHxueai0576rJvZYSa0v7qOvTA2tKbfvaQUKRIwOp2BH
	 0eY73ou7+YrGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D901481947;
	Sat,  7 Nov 2026 14:34:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6301C1E3
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 492B04075F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V9MbkuRJh2ie for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5A3BB40757
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=CS/YdhL2
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A3BB40757
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:37 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-492f563d1c6so414238f8f.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062016; x=1794666816;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nhUt6kKb9TBLQIVvKxk/BxLHQjlwHQGvC24ybZRv3c4=;
 b=CS/YdhL2tlQ5taurY3JpCJ8z1lKPlp1pGuVPK2one8TYT/ybh6HtVzypW/QWqKFOzX
 RZafq4vLDFz6tclK3HmgTtXu9YkWzq/JJF/RhYTJJM9CQ8vyfo2HRNXXJm/Pc0sIDA9w
 K22GkmU1b4128E0LrH5eSMWpVp0EhSQTFd8CA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062016; x=1794666816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nhUt6kKb9TBLQIVvKxk/BxLHQjlwHQGvC24ybZRv3c4=;
 b=uEUnKUkDfH6fgBZv4x42Jj0Lx/AKk6COBOlIoD/nTjEevo1hHCfZ2VnTfxtOKeSYP2
 7Y2mFC/CKN9+Mh4IArPcWmqAEwAReLTwbMVS9ggas6UnabeZVr7PFm61wfbLZhJ4Qs1I
 RfM58E8GiA+6G9PTiEl/R5csFY3ezH2gqKbvqu7y0xSYFzEbjYvgUWaSnCkk9nFcXkDR
 o4zh05jiUYxhixjuaToxf+u4XmOKmSqbH3sZw/ClUHuoxZ6Xny5ImoCZ5vcihEqGpGUg
 0RWYPWrEPjQ1kwATPhZgRG2Ueo4HCWI79wjS4uS5GM5UrjyrWJmx+Fivp46S0RpGb2yE
 8k9Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEvfS7DzqZNpDTlR7N/ugydkA4BdeJVw4Jw/x5P8IbZc+NlyRauu1VlJpnNsed4GADLGyAdVbQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z83F/qpFBiSAVLOFT6ZEZy2l83Oge+xwCJZg4UyL9pz2EV1pP8U
 xiijSqGkQilypGELDh5cpyHgPcBIbLWtaO51GaIN86BK1o5CcAqbEVJlmpvhdCiY/vQ=
X-Gm-Gg: AYBFou144MajujRZ92S6wkwOaMe0a02rbw2Ft845ud2ey5sq2EzbgWuKlY1jUweJKtG
 mHBsfPP8yrmd8pdwGfQ0Tf261dtaN64PkgAQlLfYINTu1Sj/3Bn8Igu4zDWWx/r5BCkUd6GndAb
 H6p/g9ua5AarBbb/Q/9lVxdT5Xl8Gza2Wur4PrpKHaQCUTNT8ANcNcMMiiiF+7auf6YFWTSnz8a
 hhWvo1SpVh3lmUeOo512Y/Unm//QNy8vbKasrIeloJnXu8lpEXlU7McJqzyaUg6ggirZpj6pyfz
 TGsbrNLkxpyQUpYkOg/p7VswG4akVHXYHrij9xYkj0TaUi2I0GrfDn+EvZ6AJX1IHNy3Dn1HGcL
 hTK7znpKSvXmg8p10xJWpUzjNApD4qZSL8eCm2vWI4iK43v3w/B+5d4KcPYWvpORPRBZf+jFzur
 a+e7CVhAwKhn+9cv2sRaIcJ8WtZMhjgxJSvBRDrm+yQbyej5JTHARoDYCL5HtD10URdu52inDHc
 hfHtthiMCnr5rsE6k6YNA0bbKg2jD49N4jO6ZdtMJmd1KmiA3jW/0IE0ReG4jE1aDHowszfj5UR
 iswWKePAP/S2JIBzTCxjBk3HdI41/GTnPoRkaGT539bMSK3lM5eP966xCk5LCrgUKrPeQYtlfrG
 mrWg532R8eSXOM1o9DRg2+HtuUqRmvS0KpEGCcaPKjFqSSWRK47OQoEjz97NbiSbanOIQuwTYWQ
 OokiW2tg5xTouHM6EzFHm+0+Fi2Q==
X-Received: by 2002:a05:6000:460c:b0:48f:bb92:c5a7 with SMTP id
 ffacd0b85a97d-49275373a03mr9905496f8f.9.1794062016137; 
 Sat, 07 Nov 2026 06:33:36 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:35 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 25/35] splash: make splash_video_logo_load() available to
 boards
Date: Sat,  7 Nov 2026 15:32:15 +0100
Message-ID: <20261107143241.2236511-26-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
Reviewed-by: Tom Rini <trini@konsulko.com>

---

Changes in v2:
- Add Reviewed-by tag

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

