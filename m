Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6377BCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 16:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5426D8426E;
	Fri, 10 Oct 2025 18:14:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k5X4id5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F0783FF9; Fri, 10 Oct 2025 18:14:44 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B2184229
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 18:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-43f696ebf8eso620326b6e.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760112881; x=1760717681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HU5AIZ+wiNBrUOBbFM7xryOzlZArOcMbyeUaAH0FWoQ=;
 b=k5X4id5eCydiOB2A4x+t0EbW6hPPXqaQqQ6eZDa9YLku+bkvbxiqWbCfuM63DJI0GG
 Hd002XAp1j0FUyGfubdRxGXhibIUyHyzb/OqBpD/+6US24u+hz24qktpKoS3jfKoG9BD
 E4Ol/i4thn2tkk6SCbmiELS79GiOxUELk7JsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760112881; x=1760717681;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HU5AIZ+wiNBrUOBbFM7xryOzlZArOcMbyeUaAH0FWoQ=;
 b=MJxK7Oqax5k6UpVFLOKubWYx/uZBt9ea3QMQToqxA2ytu3JN41Eqzp//y+iaBKbBfk
 OQtmlJI+LO/J2Dnp8dD5rQtitgLWyL3glH2nQo5hPGD41+F8WH0hRliCKhs5gfXmS0LY
 rqtFKKzd8KxSPk0xGLkMZ/DzEkWPHy8qCA2bsdgEKjJ9JdMCsNZXoA14jizBdUbm/hhA
 8TNObDAmUNNMQW+5gbWhBNY6C/vGRyETHwheIVw7nUVEdJJ/oRWwIXx5/EOL+nnXJRPy
 R7AOddBKXzouz24km+dPkOVrfQBSx3e7wds8MUL0H3Muky3+VocbuNZBDFG4DxgTyP/M
 GrQA==
X-Gm-Message-State: AOJu0Yxin0N40jNPqSvTuPVP8Dky48pWeDKfIza+g1XFD6vBcCFq+rwW
 /jOl4MSNK+hiELy9ey/Ni6Dmw/z7qFcj14xA7+b2z+icVzblh41pf3xL+lWV3lsLEb6Q3QzAp1F
 K91jiQP8=
X-Gm-Gg: ASbGncsdBaMRvzCdhdVhXNrJYJCq63EJov8hO8MculgLUceoh5QeSoTsWODm/Ff0Msq
 O/InwQCDeZf/RYJ565rkLtu2M6W4hAwAxo1Cs+AJZTCYR1wc6JihFFCB+zYpjwl3gdoHwT6dJlX
 MHvXw5wVkipiNCEpwiSaDtGSgQ8pfEOpQac2nspQ24IWRbsX5B3tuDG8FDq3BelYd5mTSC9DLd7
 XdoL9NDQvHuHlaJ9/iUp3HQC1JskIiKOyv0tplS8wnbwqWjGfD8DFIR4+/UT3DXkJwLcuNACoNj
 ARaknKaAvGlYxUzD+95pwC96RdKxS1NzSVfuo9wuXqEJLSsfgveBWOjVfkMoiQ+1D3MU1qvjTGT
 aAh1uEOMq85f2IkGJyPK5SZQYm/HyMwWDKPSn58AEIgZ+ivC862VBdNBwrWA3w2BmHGXayJccV2
 9MOiE=
X-Google-Smtp-Source: AGHT+IGRKhGsV2hvWpy7/JDUYfEGmpY3dD604WOwEK+D0IcmtQDMtvlVNNejBijNr6ZnefTn+ksiKA==
X-Received: by 2002:a05:6808:180a:b0:43f:9caf:6455 with SMTP id
 5614622812f47-4417b43fa6amr4924124b6e.33.1760112881000; 
 Fri, 10 Oct 2025 09:14:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419889cb7dsm716496b6e.8.2025.10.10.09.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 09:14:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251010055047.GB17199@nxa18884-linux.ap.freescale.net>
References: <20251010055047.GB17199@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] please pull fsl-qoriq-master-2025-10-10
Message-Id: <176011288038.1158309.16236038136641939999.b4-ty@konsulko.com>
Date: Fri, 10 Oct 2025 10:14:40 -0600
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

On Fri, 10 Oct 2025 13:50:47 +0800, Peng Fan wrote:

> please pull fsl-qoriq-master-2025-10-10
> -------------------------------------------------------
> crypto/rng: double the entropy delay interval for retry
> Make RAMBOOT_PBL only be valid for PowerPC or ls1021A
> -------------------------------------------------------
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/27882
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


