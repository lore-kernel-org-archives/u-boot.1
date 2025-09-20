Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17796CAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 16:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FE3882B07;
	Sat, 20 Sep 2025 18:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FoqmcIuq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5FC183211; Sat, 20 Sep 2025 18:01:35 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7DB08003E
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 18:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-746c06937c3so2242623a34.0
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 09:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758384092; x=1758988892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeZHbSWDDEZ9l6EuTYXmtBvMXJ5dBT0ZH9rKMBIRsj0=;
 b=FoqmcIuqnFTnz8EaMQ+pDuI2fw/hDr2J4dnl8MrM0AmDua0ryF002cEvxTssL9rz6K
 ptglaPLq1mZqVG6q0vHqOZseTB6dEpcplm1lV7zw0H3vNDZ6nQ2ng699tvcsk0lEfJfi
 t+voZyx1BVRiEpTFDFHui5RM1o2+zLMCCF1Og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758384092; x=1758988892;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zeZHbSWDDEZ9l6EuTYXmtBvMXJ5dBT0ZH9rKMBIRsj0=;
 b=Y4b/3Nz6zgLD2kv1t74d/iZGTK7ifsXzSHj6d6oFpi/YvUwvB7HsgmOvD3e+KVYx6+
 6rK22PiHAVYRNOUnca8bFuMYaH6+1Z5SQ8VZ8ZV8DMUqwZEzf8hg0sgeGPMdQgcRJ3eb
 ahJSOfgaPwwGq64VvKvR7vmWJYaNNL6DOg19BZNqo7gCRK6lphyArGKEW0ipjKKdydHc
 BsX7OVfa4CDVtqZhRwXh2SRXq0KQC+OKOR7opgiP3YgLeEwqAPi8eA76JWxKJguVLZe2
 xz5xeyf+Tgb3ZZ2jq2JQS2938nK5Htz+k/Iqn40h4Ie7v0LJ1uyvabr3/w31JtRZNiUJ
 DulA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU73br9PbyfFHqjrptZBE4O2tz2Ka1vIvbFV8RavWYnVP0RVGakovPOD6KMFyBhdJScbsscLA=@lists.denx.de
X-Gm-Message-State: AOJu0YxMtf4BVF12p6z35UXJ+FeZEQ7TZq781nMYZvbxXPbiN5pLepyr
 T6r8n23REnSTxC0lBWRUG3rYTrupzZ640UEnxpoOos2rzjfR5SQ1SbmgdgAqUPR0hYU=
X-Gm-Gg: ASbGncvLc3uKiidsv22c3mjqSiAmtv0ribbEfUUdsgOv0ObdZVGmZgJC6jX1UcCb13Y
 p7kXtdfst4XWJ1YWNZSrKPnwXo5L9U8zLUiczctVuOHQ/HHFjP3yu5SE8160UT0tsaDPiND9nqd
 EukG/oFggNgfYyt3uL84+UwgToOrSeuEBxh18qj5SSxU/Wfaz4grCXjLBIiwT9QDEu0FvgWxlNg
 +t/JKsCnd1dII6e++C3qx9DMaomOFywmalIRDKkgR69QgyCKyyNxpX6SYh6HpDU5gtTFBYL3t1i
 G5/NAPELaUFGwZLhbm+XCUO9xGDCxV/V+RBoKc3BpWhVAl8+2nW50cebVx7vzy8fgb1FGqTAzjL
 4Rl55HrsL4cfbLTrVMQxzWhzLFjGbn2omCRkN/Qvgz726K+/CBCCZnc6xhJkD+0ij5Q==
X-Google-Smtp-Source: AGHT+IHtVcYntPIk1tyCqO+rOQtkiC6ATJdjrKrTP02EDTo+fexteWc9sSiFM1TyaWxzd23WMX3MkA==
X-Received: by 2002:a05:6808:2294:b0:43d:20fc:2c43 with SMTP id
 5614622812f47-43d6b7e2618mr3849627b6e.14.1758384092344; 
 Sat, 20 Sep 2025 09:01:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-43d5c82396fsm3161060b6e.19.2025.09.20.09.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 09:01:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20250910071239.27198-1-heinrich.schuchardt@canonical.com>
References: <20250910071239.27198-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] lib: Tidy up comments for vsprintf functions
Message-Id: <175838409111.1266689.8601864004358194983.b4-ty@konsulko.com>
Date: Sat, 20 Sep 2025 10:01:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 10 Sep 2025 09:12:39 +0200, Heinrich Schuchardt wrote:

> Some of the functions in this file do not follow the normal style. Fix
> this so that things are more consistent.
> 
> 

Applied to u-boot/next, thanks!

[1/1] lib: Tidy up comments for vsprintf functions
      commit: ecced05f679e1920ffd3e1bd57334bd6442194c4
-- 
Tom


