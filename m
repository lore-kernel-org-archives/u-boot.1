Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1980CD98CC
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 01:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32CB68484C;
	Fri, 12 Jun 2026 03:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DGk+RTkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3539184841; Fri, 12 Jun 2026 03:59:14 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 198528005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 03:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-48670d35a87so1110900b6e.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 18:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781229551; x=1781834351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8goOdcYY1+HJIx74R1LziAFw81xIvewCF6Mkp+D2iQ=;
 b=DGk+RTkkPn0Hx2K0N2M6OeVbxL3POy6CuvY/KGPwEnTyHfqiQsVaY9uTzs4aiwBcUI
 PIOJQa9SLwiWE0ZGzdwwZYlx6l60WT1Wb1Kh3GGXVSd5y3EW5VFlutRYbdaktKYcef4v
 EwxX9ODLUOZkmACSvpobeHoGQmDTkZ2gyfLkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781229551; x=1781834351;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m8goOdcYY1+HJIx74R1LziAFw81xIvewCF6Mkp+D2iQ=;
 b=KDR7HVMEOVUz7YZVIs0R408rntzf0W12NIlhOe8Uwc0pKsDQSXPQy4heRKXnM5B3gB
 TbvEscO+iv5su76iIKbihBAnq2K8X4B4xHAqK41lTH35WtXwexbQlpetG7tOsDZfgtXu
 pF0kOUN2aLHTsjAgC2xfnx1ycz0GUAFd8CiZyHD7+dO6ZEsZKQfQUBQkgRgFmU5doiC5
 PHerGJQhPFsf+7xVP1rz5fossteDmzbR/ImxVPztyNC65XopbcXLH9UVkQBjPt8oVHO1
 ie7lnHwMFTyUN3k2er9ctujbcsSXSMTuASNNehz5eF/0xu1EBI1EmpmUOmYI7DSm2vW5
 7+rg==
X-Gm-Message-State: AOJu0YxHp2J9xRyK3u2FYQZBS49MI+o5pLYNRSs3p7xQjyk9w6htAfcw
 o9Sf0MGaj7IJwQcEX45/Qv4d+ELN/rdBAOhgzFnNDprv/MJRA3AyzmvavQXfMNVuDQc=
X-Gm-Gg: Acq92OGeWbG7kyD711NBkzWFr+hjxypJk5Vn2Z1zjRtwbuktfcKEDupCHpJ9Px8gGUU
 pADr2D8ad045WpJU66apS7SVNGi8uyv/Ez722A3pYI6hcNLhZmUHLXGKAcNNPhTnSdBzNnLZkHM
 tDTAfsmAN43gT5GYYFYXsyamU+CKC0Fq8i1w9XzAL8aiuOqKlx2BQ6cxUBJoUmV2iwJ5D4K/7xZ
 c7TxrkIvyK+XAU/gx5HnmyUjAAxMu4AtYGscGpHF4YRR9W2zceTvd5Mwe9yk+TQjiLK84Pi/N2B
 PUBx6LSmDnDUCGZZQtm7W9Xd/pBIji9cm9DZdLeeo7cmaXFT70RoCFh+WcimBXjIzrkf9AxYCnn
 ZkdXBAd5mmNFOqE5PxfmB0xHVwp5ZkWzg5QmFM7yi4WcH3ZYGd0ZvExyx1Vtc5QjSXBPBKAPQbV
 R64ZCUPAZTyU+i189xlsZmjTu7mh1vJZ573KliAaka+/GX+wP92pypkwBMVKC8QYVSUamwuRgEo
 HW161Z/mjgDw+XcNqqHE48A+S50c8rpo4jJV3vlsXmnr6juIl9PqjpdAA==
X-Received: by 2002:a05:6808:384e:b0:473:f3c1:250e with SMTP id
 5614622812f47-4872df27e0cmr723950b6e.17.1781229550820; 
 Thu, 11 Jun 2026 18:59:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426abf184asm534734fac.5.2026.06.11.18.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 18:59:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jie Zhang <jzhang918@gmail.com>
Cc: Jie Zhang <jie.zhang@analog.com>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Caleb Ethridge <caleb.ethridge@analog.com>, 
 Ozan Durgut <ozan.durgut@analog.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, linux@analog.com
In-Reply-To: <20260402171330.165754-2-jzhang918@gmail.com>
References: <20260402171330.165754-1-jzhang918@gmail.com>
 <20260402171330.165754-2-jzhang918@gmail.com>
Subject: Re: [PATCH 1/1] arm: dts: add/fix I2C controllers for sc5xx
Message-Id: <178122954934.605671.572000340555333041.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 19:59:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 02 Apr 2026 13:13:16 -0400, Jie Zhang wrote:

> sc59x processors have 6 I2C controllers, but their devicetrees
> currently have only 3. The length of its register block should
> be 0x100 instead of 0x1000. All I2C nodes should be disabled in
> sc5xx.dtsi. They can be enabled in board devicetree files if
> they are used on the boards. Add missing I2C controllers and
> fix the above issues.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: dts: add/fix I2C controllers for sc5xx
      commit: 38c49e01a01d444c78ce3d94fbf0d1a6bf3779ff
-- 
Tom


