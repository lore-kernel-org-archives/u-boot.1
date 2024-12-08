Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792F1E7717D
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 00:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EF3489405;
	Sun,  8 Dec 2024 01:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rg6pfSBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DAFA893DA; Sun,  8 Dec 2024 01:21:29 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B216B893DF
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 01:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71d4ba17cd2so1533925a34.3
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 16:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733617284; x=1734222084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M67afIA+ajXVHuic4rKlvMMufy/mz8Ysw12A4/NrA5E=;
 b=Rg6pfSBZle2BVPNE9VUGtmlpc9yF5jN7tlo1MI7ZH8dYF2lX1gqnzVKyNxqO7ukuGc
 vzDvn5GI9XFzOKZV95l0ZK68d/cmRNAbeUuiSYWkZx9K29rBoSO5MtcwXKuyDuHOrubZ
 cHqpM/m/NzGSpj2ni5zzuogyjlDZNsT6Z++gDXB2q650BLVB1sDd0A0KkkpjOiHgTta7
 19cIS6hGUsleHq0PJ/hsuwn6K0PqOyzBlxpJxTyLO1gqctsDqpjN0QB866DGzDHBfuY9
 VbZRMg80T2nscpan9OPZbPogsRK/LHNj2pG3r95ipfBHQoXKMf6xzJNRp0Zfl6JIG3f2
 f3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733617284; x=1734222084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M67afIA+ajXVHuic4rKlvMMufy/mz8Ysw12A4/NrA5E=;
 b=eBj6MPuB1V88sN6tOVkc3//9F/tOPkuY/LpvXPCnmQQd5PZ/13Dwst2xmveA6zxJnv
 02UyAzun5OUMg9uhk439RkTResaEWOaWlcjRmjX0fkY2ZxtM02djEADN5t19vGLh1CAI
 i1WRtaJ2cpKk+9sKb9Aw5qcG/RZT2tb8U+zSVOJ12ivXLQKa4sdU8y2NMyUw3HvcXWMP
 k9by42Bje9L1g+eY5empODTESkEIKIbFOKnODg6XLOFWjQEh0dJ65W+gSF2o0U5qX/NR
 EwPS2TVm4r9jgIm6AmvchE9Kw64njUWhmMAqA6QM6VWFrTyzjGNrnu8REZQkbvUqBd+D
 z4iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCngIRTCjn1jrbZ7/Whi7ZuMyXC3UF5f9IhsUs00Z3giYDgZIVr1/g0w54DMLnnGkfgpub1Kg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywi4vEajzcerUj1sEdM2z8IzIsUAENbhxscB5J/yLvN+eVMzZGS
 lK2pGNPjfdqWbBFn5ygaK/AW42FLo7mHyVTz677oX/9Xxy581DfF2/1SYiA09LsEY9ew8UkoAFE
 q6BE=
X-Gm-Gg: ASbGncv2q/Vw75mWf79MNz+hYlii9RvFL8bhWSU8rzomSAbYHgYQO2R5PG9o7dODqJm
 16h7eF4kZ0ZA1YRQGNdjVeSVqcUepJttYP9Y2T8u91kHLJdySfglW7kdXbyLxnye1A+iuNJ1U4/
 OKm6iHsrnW0lfLIVhVhms4NhY5gguLJtaXp4+vJZEdCoW+7DwR4W3LqxGLm/hHjmAQmkEz/aWGc
 QhSAB6czH1G/7l9enuht6d1qnX7viNS9RxSOiaC9CggOqdCsMFJAcU=
X-Google-Smtp-Source: AGHT+IGWTcMDH7XBy8ROvQm2/z/5dAI5R/GF+cWH6Q1OFwtvvI+vASJFvjrPOlE9xBMkZESuVrLaww==
X-Received: by 2002:a05:6830:3101:b0:71d:4105:405e with SMTP id
 46e09a7af769-71dcf4b43afmr5920685a34.1.1733617284498; 
 Sat, 07 Dec 2024 16:21:24 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc493b033sm1549371a34.8.2024.12.07.16.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 16:21:23 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH 1/6] lmb: Fix flags data type in lmb_add_region_flags()
Date: Sat,  7 Dec 2024 18:21:16 -0600
Message-Id: <20241208002121.31887-2-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208002121.31887-1-semen.protsenko@linaro.org>
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
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

rgnflags variable in lmb_add_region_flags() has incorrect type: it's
declared as phys_size_t when it should be enum lmb_flags. That
copy-paste mistake was firstly introduced in commit 59c0ea5df33f ("lmb:
Add support of flags for no-map properties"), and then copied further
into commit ed17a33fed29 ("lmb: make LMB memory map persistent and
global"). Fix it by using the correct type to match struct lmb_region
field.

No functional change.

Fixes: ed17a33fed29 ("lmb: make LMB memory map persistent and global")
Fixes: 59c0ea5df33f ("lmb: Add support of flags for no-map properties")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 lib/lmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index b03237bc06cb..713f072f75ee 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -200,7 +200,7 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 	for (i = 0; i < lmb_rgn_lst->count; i++) {
 		phys_addr_t rgnbase = rgn[i].base;
 		phys_size_t rgnsize = rgn[i].size;
-		phys_size_t rgnflags = rgn[i].flags;
+		enum lmb_flags rgnflags = rgn[i].flags;
 
 		ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
 		if (ret > 0) {
-- 
2.39.5

