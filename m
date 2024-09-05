Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C355CD5BC7
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 13:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3407088BF2;
	Thu,  5 Sep 2024 15:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b3+ajYSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C84B188C47; Thu,  5 Sep 2024 12:47:18 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C3A88549
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 12:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=benjamin.albert.hernandez@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-206aee40676so5906995ad.0
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 03:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725533234; x=1726138034; darn=lists.denx.de;
 h=mime-version:content-language:accept-language:message-id:date
 :thread-index:thread-topic:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=810IC+M04B696G0qnj+yWXUYYDyRShsBnPzMPcjcS/g=;
 b=b3+ajYSC6DIOHjAo7ZMmwoqpj8Ro80MbjHlBPRJHDTMkvR5BDr4c5BVQKjTMLu+AEH
 z1A6TLZY5oUjesycQdXQFQB5ZCQ9IPNn82ifSaRzlIWGoyfmJfSiXPqtEjJEaooe5KAY
 ffd+PYS+/xX3xt6duvMl5h3+G+Bimbp9D7mEJoDhKCbFmrv1s+IarGi3c0kgT75aRa/L
 PXV/S0snRwIQ77XSLEuxUg8nCK9CrhYm/pyLL3d8sxMgxbulzVUSAwKNBhVVoEWutvYT
 hVJONBfsF8fxSHz1tZj1PXNEvIR01bE63PPQmoyhEWQ8soIxsmmqtW65b55xWnsAOy2M
 OSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725533234; x=1726138034;
 h=mime-version:content-language:accept-language:message-id:date
 :thread-index:thread-topic:subject:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=810IC+M04B696G0qnj+yWXUYYDyRShsBnPzMPcjcS/g=;
 b=G1Y+dZG8hzozEyqBP/dS64W802eeaaioFRc1rbpy8ttnqHB0r6cD2mukmMM2OJhuG0
 JOXH18JQx3dcE2KcfeIpCxOgDXqPvOoxdKDHYCfWdeqW7qvWsy8qST/kcA+kxybRagWP
 BUFiFE2Gngm0ICj8YQX4GLaR4thPpK79zZH+dRzz5CxNWPQf+5ABspfRQJGiIaIen5oo
 gPf70SGfyCLLUzKF68fsq/Sye2rz/W0A6ibD6BP9XkJLzMERX5PXIkLhHMY39ZUaaa0/
 4sOETtmtaeJIOn3piur61DJRDWpWkxCgpGBlx7AJnorBEOy/X7KZvUfL1CJMMMsqc4oi
 8YRA==
X-Gm-Message-State: AOJu0Yw5tvKjHO6KU+ZzAGKBEYhnVleBDzCaOWxPJPPxZDGvcmUXeJWx
 ameNRKUbbghq4vHUuVE5QL4klNhTVhOGSO1gFDbn9LxuNYHievw0eWosqw==
X-Google-Smtp-Source: AGHT+IFc5lSqyHnE7rjHmUhSKJY1Qc4px+iGH8gbZKMWY9W4dJA6porpXKAa4yVUQQEyTSPj+RdhCA==
X-Received: by 2002:a17:902:fc84:b0:206:a935:2f8 with SMTP id
 d9443c01a7336-206a93506f2mr83865415ad.2.1725533232388; 
 Thu, 05 Sep 2024 03:47:12 -0700 (PDT)
Received: from CY4PR0501MB3795.namprd05.prod.outlook.com
 ([2603:1036:906:8c::5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea768aasm26473135ad.309.2024.09.05.03.47.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 03:47:11 -0700 (PDT)
From: Ben Hernandez <benjamin.albert.hernandez@gmail.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [U-Boot] [PATCH 10/37] Blackfin: bf548-ezkit: video: convert from
 old style MMR macros
Thread-Topic: [U-Boot] [PATCH 10/37] Blackfin: bf548-ezkit: video: convert
 from 	old style MMR macros
Thread-Index: AQHa/4DucjLpZUarHUCUnACG/Qj/FA==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Thu, 5 Sep 2024 10:47:10 +0000
Message-ID: <CY4PR0501MB3795223F9706D8A6CE2B6095A99D2@CY4PR0501MB3795.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 05 Sep 2024 15:17:52 +0200
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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



Sent from my T-Mobile 5G Device
Get Outlook for Android<https://aka.ms/AAb9ysg>
