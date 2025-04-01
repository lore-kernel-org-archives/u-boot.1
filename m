Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0402C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 02:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2593981EDD;
	Tue,  1 Apr 2025 04:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I4XUvWWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ED9A81EDD; Tue,  1 Apr 2025 04:16:41 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D676817C4
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 04:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72c16e658f4so1468589a34.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 19:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743473798; x=1744078598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QCsj5Pwiu2rgD/vgA5gkANbzEYDMfLM5ecdSe3HGE24=;
 b=I4XUvWWFQdRI/nQWda3zk1cnnECdMzWE01qFIOVEg1HkY17jY9sfNTEdNrBOT3DHtC
 O8pB6L9gwN4asP7JtVcS1p2NUvz+Ea4HfgX3ltkPZhU2p1D3kRFBtYpPXduvINKqHVcG
 MjJqpmYtdcF8+loajvJB8ItKOQO/yfKEpGUbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743473798; x=1744078598;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QCsj5Pwiu2rgD/vgA5gkANbzEYDMfLM5ecdSe3HGE24=;
 b=qCOBcUUmfVSAB5pKsDeyEJADdJffM5AB5RjfWHvACDGQKMMVgB1zjoxEmPACnNnctk
 TWiVXSc9RSH0xs4cjxO54BnuLufMsNxQcuytEnA+wUU1X1mgiPQw0kSPG+8IkwYWP0Iz
 jeaaPpXqTtxEmxWxpyhqBqb8UtFfLs70EGUsxxjpoxDzbI/R2XkfJwGxf1EXZZtbybaX
 nwQDZaxHi9rMjfYWzLSIQqzYedsRtCv4p3fw8UsT/ghV6qOoDZ0fL34PKliwN1NZhnhr
 ceicsT/4l2q3MDK8RdDJ+NFDJY2BGnp67zPYlYlUtHLB4wMxPH2gXZTQyCxz1m5j84x4
 Bytg==
X-Gm-Message-State: AOJu0YyJt+IS3tX0afJalvzmN5b6EIchnoqGGderoPXBn6m1fjTFkmnS
 OiVGPV28Ph4A4zw8UnBGxFaqVNnT4mXc4Qxf7pzg318DtNxxqwxAENqa3J4XYInjlw3yVuS+PsZ
 V
X-Gm-Gg: ASbGncvTIlzLFofPahAOyaXANnrwKSfBmPnmtTz5Zg8w7IPPrxZnmSFrMKf3Zx0pe6U
 GPCCSbxfiQCA20abcrcyonR2lzb8LgVWCG/Mc23aYDwFG36z4arGFFAy/QCupzpfX8xznnGo85E
 gk0KTMeIwtF1IBu+/Mx+7MRDxRUV+Vxyk4YudnOagYcO0iS/ooB3Yri4kCCwizOwvNiSsB14eql
 XnbwcBDZ7L0GcgddNG0dbEe2UrIIjITuCY3832skqJy9WN/qCPiuZb7znPubXxNSoEin4IVpa/F
 nfQUBpijVHNS4B8e7KRCv/AGRcUtrSNRVB3EsCl3njI065Df1Nzx4VzWVRl4LH5SZssD6R5mrU3
 LxLS5
X-Google-Smtp-Source: AGHT+IHoi8gHDpSawEjas2IG3MOvTn5Iu2aLWv3R1xMQ8ocTAfmWmGqwnKD7E4pd3mFN4EdG8OuErg==
X-Received: by 2002:a05:6830:3499:b0:72b:81cd:e123 with SMTP id
 46e09a7af769-72c637bead3mr5434603a34.16.1743473797665; 
 Mon, 31 Mar 2025 19:16:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580b5401sm1704892a34.18.2025.03.31.19.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 19:16:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>, 
 Sukrut Bellary <sbellary@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>, 
 Andrew Davis <afd@ti.com>
In-Reply-To: <20250312065709.1434207-1-sbellary@baylibre.com>
References: <20250312065709.1434207-1-sbellary@baylibre.com>
Subject: Re: [PATCH] video: ti: am335x: Fix tilcdc clock names.
Message-Id: <174347379638.47384.728841134785436400.b4-ty@konsulko.com>
Date: Mon, 31 Mar 2025 20:16:36 -0600
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

On Tue, 11 Mar 2025 23:57:09 -0700, Sukrut Bellary wrote:

> The commit 211b3d726378 ("arm: dts: am3x: Non-functional changes sync
> with v6.3-rc6") changed the tilcdc clock names.
> Fix the tilcdc driver to use the new clock names.
> 
> 

Applied to u-boot/next, thanks!

[1/1] video: ti: am335x: Fix tilcdc clock names.
      commit: b565d7f20193113e01628ef8033103694be4dd46
-- 
Tom


