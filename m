Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6898CD3B7D1
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 16:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B25CD839E4;
	Sat,  6 Dec 2025 17:50:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WEBghUhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6002F839F1; Sat,  6 Dec 2025 17:50:40 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4341C837F2
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 17:50:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-657c68a08a7so1620676eaf.1
 for <u-boot@lists.denx.de>; Sat, 06 Dec 2025 08:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765039837; x=1765644637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HIjwa47F0U311i+SAPHb10UJajmJohT1FBuTRoyaelE=;
 b=WEBghUheCYY9eeyPa44nieE+E45r/PFYlt6rhR2jW/tNETGoPsycBCK51CpQJRjX+d
 6ga45xzgbB05q3vnzj3dD9xkUa0B7P980j/hq69btSQ4nwlrUXwL50IhmVCfOR0LMDp0
 GZAH8sST74YNxjdqcMhm1IZyJ/FCfOzhgJcy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765039837; x=1765644637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIjwa47F0U311i+SAPHb10UJajmJohT1FBuTRoyaelE=;
 b=kjA8vEsI/gX63f+m1wBWOXVVtvD5QtxkTZ7wXOqt0Oo6Itl8fiF7Q2ytFUqm/xrChN
 WXasvlPVmXORiOVry5s1dk19+4q3euyz2jUWG5CgLvNRpKUnbg/+4RBj2M/C658Ds7eK
 XWJJzZUH1XD+dR5KrbxujFQ+7xYNEFl4mdmGQ/1ELg0eexSH3iypQIxI3Gw1AbXMFIS6
 sZ5lZ2h221b7f6vGA+syiGYq4aPbPND+VqgC+maKWwlSPM5rXKG+phvTDS93mRvCp6Jv
 yFU/Yf7kgxwMc+Q2hip1Qn1cxXWK/BEFTY+K1uPHWhSEBW1DONtm5NvEadNhRqnerI07
 1JlQ==
X-Gm-Message-State: AOJu0YxUXJMHEhDDsGrEDPHhUmvPk99nwPBdjihuGXDqOx47QcHEhbe2
 hbaCManW2ySxlP22Hx95FmSykwzsRVjuKODz8KKQCpDDMDb6WC0ENdadFcNd03pC50INTQkGP8i
 wPIG988U=
X-Gm-Gg: ASbGncuGCW6/VS8Nnihb2cWrNtDemu9Bofan+tWJx+MKSrCwYVYT9ZEiYpRAUS9eKCh
 o9hHjJ6g+59igq+VDA8o1KCgfMh7MELyGf8orLYPqfIpL7dgVXHcQGJzvFltrzAXWLxmmTR1Y7a
 VIbEcvc0IG8l/7qpl4qlGoD3rM4EzrxaLVu+TpUj+9+sgn/yhLzHQt4pRB31BoYblPbbGJ9hNeg
 xEENpFjLAxSzN2M/7STQ7zoYCUrQPugAyAsJiH5t86ofEnYK5kzMbzIBieqlZyyptQ0NPqux7fX
 CUj+byAmFKrbb9LcgTai5jT4Q041xGriFSUd9FSh8hEeRDYer4wROliELQEWtzxM2myoYnxoWgt
 ZE23H3FiiojhzgnmWWr0QpcgVMoktPpr6OISlNUuslHuSxPa15Kp7vrQyJdYLRDXrTVlsFK72Ci
 I3Qg5dTPZ+WZL40AitJoRcLBIsGmnZZMCkEQlOi6BqS4ouuZVBNqEI
X-Google-Smtp-Source: AGHT+IGjQm1cCUSVOIkDvF6LDx0E426iv3tzwIMUJG4Y06sfYmJAyqvTfyv6H75ifMgyNFhXoyOCkw==
X-Received: by 2002:a05:6820:2299:b0:659:9a49:8f54 with SMTP id
 006d021491bc7-6599a905cfbmr1171456eaf.25.1765039837013; 
 Sat, 06 Dec 2025 08:50:37 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ef31fcbsm3536661eaf.14.2025.12.06.08.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 08:50:36 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] doc: Update urllib3 version for building
Date: Sat,  6 Dec 2025 10:50:34 -0600
Message-ID: <20251206165034.2621363-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The GitHub dependabot tool has reported two "high" priority bugs with
this package. Update to the patched version.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/sphinx/requirements.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
index 8572c15ef68f..dd433e2bb156 100644
--- a/doc/sphinx/requirements.txt
+++ b/doc/sphinx/requirements.txt
@@ -24,4 +24,4 @@ sphinxcontrib-jquery==4.1
 sphinxcontrib-jsmath==1.0.1
 sphinxcontrib-qthelp==2.0.0
 sphinxcontrib-serializinghtml==2.0.0
-urllib3==2.5.0
+urllib3==2.6.0
-- 
2.43.0

