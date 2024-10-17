Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4E4D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0628F89216;
	Fri, 18 Oct 2024 01:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MzLvc7jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95880891E2; Fri, 18 Oct 2024 01:24:50 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7435C890C2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a3b0247d67so5772255ab.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207487; x=1729812287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6IZkQOJQM87eXI3Y1Er2MNC7H9p7rOGpRJhs/NJUnA=;
 b=MzLvc7jfhb/HK2t+msj45JF6JkgsJqfn4zq3mZSEMuE375Cr7k76py3kU63mCsKRHy
 Ebs5/u41rIghit2vjroByIuBJA3EbYnlaZlVewQJuq1lazC/q3/SM1XzygW66xQbM7hB
 WFp5pS2nyRMucLKFPSrEdNLDHCIHY9baivg7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207487; x=1729812287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6IZkQOJQM87eXI3Y1Er2MNC7H9p7rOGpRJhs/NJUnA=;
 b=WBZD4DT/BYH6Wy+JXOrbn7+Ap+6RdBb6w7K+g5SPPyMlkKkTLmfVEkvL5aF5TFA/cy
 VFr1PqXZcXYRNA7KkXJAyCiKBHguoDgvIG7urkgMcT/zHJ+TbZEUJSlA5tqMucEJmGW9
 s0BBeyqh+ewbdjC4oIJzb6k8hnqeYdOjtgkDYjgS5Jzsn4/+Rmh3KYRTFCG5kJPlt6Sg
 icZMN9PPXBAGbtG4vwkNIoC2la0WszX/JB6ln6o3cugIzVs1bZAm3f0lQ85b0DrpE87D
 jlHju/EuLhHVOviOGi9hjcoqgWgWQZljMZKA/xIcNO0EKj1dhOVMatJVKQ1an3xQ7mC0
 ygLg==
X-Gm-Message-State: AOJu0YxuEgpsGoDaA05Q+sPxsgf0YF5vnOczEIAVlMxMJbH0Ec/iNFcF
 HIBxB+bJwX771U+D3xARNPUNR1f3xaHraotxXF9cptSSrNQLGEeqXM7obJBbIRtvoHmX6SYSCkc
 =
X-Google-Smtp-Source: AGHT+IFdfcbK+R9j1h/hFmpqTCrgZJkcHSLUS/PFt9Sr796Xez+YVJdB0i6BeccJ/JEbL7Pk0THhIQ==
X-Received: by 2002:a05:6e02:1a83:b0:3a3:b254:ca2c with SMTP id
 e9e14a558f8ab-3a3f40b5b9cmr3332875ab.25.1729207487056; 
 Thu, 17 Oct 2024 16:24:47 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:24:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 09/34] test: boot: Use a consistent name for the script
 bootmeth
Date: Thu, 17 Oct 2024 17:23:48 -0600
Message-Id: <20241017232413.724808-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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

In the bootflow tests the script bootmeth is bound with the name
bootmeth_script whereas the others have a name without the bootmeth_
prefix. Adjust it to be the same.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/bootflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 154dea70a59..8ea284098e7 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -542,7 +542,7 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
 	/* Enable the script bootmeth too */
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
 	ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_2script),
-				"bootmeth_script", 0, ofnode_null(), &dev));
+				"script", 0, ofnode_null(), &dev));
 
 	/* Enable the cros bootmeth if needed */
 	if (IS_ENABLED(CONFIG_BOOTMETH_CROS) && bind_cros_android) {
-- 
2.34.1

