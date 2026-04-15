Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D99F9D0FB
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 00:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 305A18407D;
	Wed, 15 Apr 2026 02:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FNxuS6+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A94480433; Wed, 15 Apr 2026 02:40:12 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 875A180433
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 02:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-479554880bcso858299b6e.1
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 17:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776213607; x=1776818407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27QICOMUAimi95VOE4n7cwL/ygwfNcuFmp3GBYdPEKM=;
 b=FNxuS6+d3LnmTxRpvGIUznUXtwA9J+pPQccykFT6/auXIzQ8uXbrPKf6HwRzum6qXg
 ukG6ogsGBQ/D13BwQRYTWVSvOBpOPR3JNLDojsqrbSeDcSxEjlxC2SAbUXf9MOft4hrj
 Ilg9b9LOuH+zM7WZ60zue7k2Aaj/h7nmN4HTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776213607; x=1776818407;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=27QICOMUAimi95VOE4n7cwL/ygwfNcuFmp3GBYdPEKM=;
 b=BfqyuYulJwEVFSbJoEMR6GwLWa3LNYvHLrOv4qWgjWo7WhgrffKmFkrn/Wl+9Ef8LQ
 ZwCUylo2o+w7pqrhkWrnAwBIhhXpT415KcM697/e3BgzYukpFz51vQXZpolpFTkdgTMO
 Ihf6rJwpJgTN/8cmpXsrtSb6U9VD96TX6TQcAAhw0cIKf/q7hEcASf2qWDIRIa6fv7sq
 ZNflNpWU68cLejekg+A67zQRbAHUq5Xuysf0HLoBvGVEjOlzQhYlu0qObIdCd8pmZk93
 sb371zp/SOFXkNbj33G7VetRbx1y+qauAeA7sKEDIkZW1KRwZ1yJhPgyhsKwQsoeABws
 AVtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yJm+UbFUmaCLml4FUgkRfLv+QI+zTMBG4yYtsgrrkBsyd3b6jhBmKLB+wv/fjZV2lIs5bQrg=@lists.denx.de
X-Gm-Message-State: AOJu0YwN0u+n3v9JdJxsvLhfMG5LgANnj+hXk/yXH3m1/DfgfZpaKwNd
 m6zNNomThhRKGst8BLWqE8lr69QV2TOjVfx+in3dqdwvRz7f+zk60oRGPfY/NjqaRPlV58tdhUE
 85e143Zk=
X-Gm-Gg: AeBDietjX3j4aFAvUhnw6Nx8xo6KeuqSQpo4RTo2qV+cKtH0cScsVd5kDcppwYpugvf
 zqV6cRfJNy+9ekFT1tle1Fxl5cJqECj8lWZET9mnDjVaCW/8TFEdlC84KwarQ78Z0ua2bWXDqpl
 T1E1DTuZlPVV+f5v0SqqpSNFzao5HGLY5kjgxTYTVad1KySMTmj5HPuzQJ9dyM2vC7CGHGrk9tO
 I4SUMXOkJpc5igfg2DgvqSIK/K/iLQm8IVbrxuhOwn1fFFKlmWPwNKrEXVfn9PlAQuFXBeXArNH
 t8NNV7iTcJebWlOCSRKisfsRu9aHehPHTNIys+u8dhsycLWatLRQWmFRq1EPYA8uTSNstonuxRn
 vYbhRl37ixgR4sQvIv5/AArtxBJn3Y6iBCv9Dc8T9ePplMmBd3NhUQ9vQumqvqLTAztsfKHPw5r
 BRDnRpxoq1/isYvB3FvqG0afC9UDrqMLCxxfLjbxd0bMlcy5bA6cFImNw6jHvkXXBisdze7nYUU
 CtzHDaH/jkjotXuev5o2HFHIaHPNUD3uxPV7fCAGDrQ0eoM80FELy2oOnOP
X-Received: by 2002:a05:6808:2202:b0:450:4782:2b0e with SMTP id
 5614622812f47-4789d03fd6bmr9458207b6e.15.1776213607200; 
 Tue, 14 Apr 2026 17:40:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42666bcb977sm193085fac.6.2026.04.14.17.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 17:40:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jeremy Compostella <jeremy.compostella@intel.com>, u-boot@lists.denx.de
In-Reply-To: <20260225155050.73841-1-heinrich.schuchardt@canonical.com>
References: <20260225155050.73841-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] x86: there is no CONFIG_UBOOT_ROMSIZE_KB_12288
Message-Id: <177621360641.2899116.7161413383623150451.b4-ty@konsulko.com>
Date: Tue, 14 Apr 2026 18:40:06 -0600
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

On Wed, 25 Feb 2026 16:50:50 +0100, Heinrich Schuchardt wrote:

> Remove the reference to the non-existent symbol. As ROMs typically
> come as powers of two there seems no need for this value.
> 
> 

Applied to u-boot/master, thanks!

[1/1] x86: there is no CONFIG_UBOOT_ROMSIZE_KB_12288
      commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
-- 
Tom


