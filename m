Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB071C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 11:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC79587D83;
	Thu, 21 Mar 2024 12:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=essensium.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=essensium.com header.i=@essensium.com header.b="iH2nfkOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7969A87D91; Thu, 21 Mar 2024 12:22:39 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48DC08785E
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 12:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=essensium.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hugo.cornelis@essensium.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d485886545so15705921fa.2
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 04:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium.com; s=google; t=1711020156; x=1711624956; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpUYPtVdfgU7oYZXBgUCI8VoDMOi7n8qSmMvBrl318s=;
 b=iH2nfkOUqeDK5DpGm72mBJtRnKnChcQM6vuJQCYHuEeNX+FU147/8YhUOKr3OME3NU
 VHhl4ZWVpygBKwLXCo4Xpno7jw3ECKbQGmBVod6QqCTEgeUt1KRgJRYEBJkPd7REXRQp
 dD0nklR+VdnsYnv0hvoYeIDws9RY0xwV8TI93P1J7UCorhqsMW4QT3gUtllS30o2akaP
 6EvKOXhIQ8TVS261JCk/tBTstFH32EtPS5bkNQalbv6iPk52thBTUddHtQf0LQtx7L5U
 VtnJpZWqxKvEpx+7rrCTVnRiYkBmk+buLIMURMcV823bsRdDZvcz2Cu4m1UBuHh7owom
 AkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711020156; x=1711624956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpUYPtVdfgU7oYZXBgUCI8VoDMOi7n8qSmMvBrl318s=;
 b=ng4py+URGNitrDyvkkhRIAFvd7MLOg7ogwdxyaA4J09lSCbsrWIiZLHOf+FPjHRHeZ
 KIlYhYeoJGlFbJkwcMdShqsGym45wW1pvWvSl8Vj0uBFA6tIUyenGrxf9sHHu7MwBMgJ
 Na+7vvykgymmbLWT+lw1nq5SVVhJ+7JJ3BLd7okf9t/vAXkgxKg5K/o906HzU7cwBF/U
 O4NuISszjvwZiHLTSQPXro8/n/lnn4WLN8AlO1LXekFTGdn5TlK6TurVQjP9H/2oT5iB
 EIC8kbgC0Xmy6JVyVqYbWkG/zBFbiP6/UIxEfJn1ai27ItK6SbUNJU64sZ5YgQxRnUqP
 x5og==
X-Gm-Message-State: AOJu0YzqNVDF1BZxQJYTLYQSTu7xq/uaZXaXBhATNuVjFV/hGz2MhfsD
 eC44H4PpH55ufVAtohS95peMeXOMXxDr7BSTZCt7gR/PUnvgCPPXTVGKOBafOjbBGZMTuEuEDH1
 B
X-Google-Smtp-Source: AGHT+IHKpaRO7cUSYmGAILGozdUqk1BIp8AVSc/wWJ+9GT5zd74eIhbYyIl7KBvWUIngUuZY9wFd4Q==
X-Received: by 2002:a05:651c:104d:b0:2d4:6973:a335 with SMTP id
 x13-20020a05651c104d00b002d46973a335mr1567261ljm.29.1711020156309; 
 Thu, 21 Mar 2024 04:22:36 -0700 (PDT)
Received: from hugo-IdeaPad-3-15ALC6.. (ip-188-118-3-185.reverse.destiny.be.
 [188.118.3.185]) by smtp.gmail.com with ESMTPSA id
 k18-20020a05600c1c9200b00413f25d9104sm5255602wms.40.2024.03.21.04.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 04:22:35 -0700 (PDT)
From: Hugo Cornelis <hugo.cornelis@essensium.com>
To: u-boot@lists.denx.de
Cc: Hugo Cornelis <hugo.cornelis@essensium.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>
Subject: [PATCH] image-host: Fix error value paths and emit error messages to
 stderr.
Date: Thu, 21 Mar 2024 12:22:22 +0100
Message-Id: <20240321112222.237341-1-hugo.cornelis@essensium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <dac04f9a-6657-4727-ac9f-c94793b2c07a@gmx.de>
References: <dac04f9a-6657-4727-ac9f-c94793b2c07a@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

A recent refactoring in image-host.c messed up the return values of
the function that reads the encryptiong keys.  This patch fixes this
and also makes sure that error output goes to stderr instead of to
stdout.

Signed-off-by: Hugo Cornelis <hugo.cornelis@essensium.com>
---
 tools/image-host.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index b2a0f2e6d1..7bfc0cb6b1 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -346,17 +346,17 @@ static int fit_image_read_key_iv_data(const char *keydir, const char *key_iv_nam
 				      unsigned char *key_iv_data, int expected_size)
 {
 	char filename[PATH_MAX];
-	int ret = -1;
+	int ret;
 
 	ret = snprintf(filename, sizeof(filename), "%s/%s%s",
 		       keydir, key_iv_name, ".bin");
 	if (ret >= sizeof(filename)) {
-		printf("Can't format the key or IV filename when setting up the cipher: insufficient buffer space\n");
-		ret = -1;
+		fprintf(stderr, "Can't format the key or IV filename when setting up the cipher: insufficient buffer space\n");
+		return -1;
 	}
 	if (ret < 0) {
-		printf("Can't format the key or IV filename when setting up the cipher: snprintf error\n");
-		ret = -1;
+		fprintf(stderr, "Can't format the key or IV filename when setting up the cipher: snprintf error\n");
+		return -1;
 	}
 
 	ret = fit_image_read_data(filename, key_iv_data, expected_size);
-- 
2.34.1

