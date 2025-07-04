Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6398AC83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A17382F8E;
	Fri,  4 Jul 2025 15:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NjZKhPhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62577806D8; Fri,  4 Jul 2025 15:42:47 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F89382F8E
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4a58f79d6e9so11107521cf.2
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751636564; x=1752241364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3NYDvl1ecRP8RriTKDv5K7j1gyZ15o//u4xpP6FKUQ=;
 b=NjZKhPhQH9iaDSNfSfzaD5SVQc8mwOmiEWx3EKULxGOEpoUobBshxNjBoKx0D2nxjx
 KwDKBab0nvjynfiOVV2IbXtv5ejy8WdxPKqw0p/sZAAFy/1F3MzxLUIrSghQVashW9bG
 KztTNqjBx118rXFdgcJYCX0pfvc89EyDtQ+wuAdMumMRxBb/etRYDz5Z8zFmkFNxAPA5
 aMA/wT7MRXJnr/zrl9p2a4IUMvZSGx7k+PagmJeY2wdAn3VASoEyRysN80OILoDLoRrR
 cezd7zJFmHh9o9aCqNoRc7UZWw6Z5BCHnCgygh8qRaFyuzSvSj2W5H9WUTZ1dHwmJx0e
 8LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751636564; x=1752241364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3NYDvl1ecRP8RriTKDv5K7j1gyZ15o//u4xpP6FKUQ=;
 b=Fj6bJXDjk3D9t4UOHBMb8CzGCFBPhhRpmKTuk7PiKC/culC/Jah+ga8wjWqqUH6d5D
 u41g7GF02ukuE165qTzXl8t8AikMDLyRLFfSlXIvG6RSB6KWq8oP0+cPFX73urb66wYI
 YqonCctlPP8tACTWglupY1V1Xoi6P7JAhEXZDLtp3tA+LSx0hUoq+3EtYS7PIlUmEco7
 bDjIruw3eK8uevOotLD3erdsQI0KITDudI3SzzpZl65EcBg5KUslGBLcf5y3l+gk8GqC
 gwOMeJ+PpA9hbcHTGsQNkP3PcIWk/86LqTCv85ErIKlq2OthQ8qdliqWgTWclhY7Tdwx
 uCIw==
X-Gm-Message-State: AOJu0Yyn51/UonX+n/aRD7HYXLmRyyyFt+NIdEYqzCbExITXappzZXp1
 1PdU7DY3Tbh/+AyXXoE0zh7VTbRmc53HpcdE8ISyWjUhiJ0KR91zgT8FBP+JcJXaHsYIBTSZFrI
 kKbHP
X-Gm-Gg: ASbGncs2K2xbwkQfe0mbMabefV6yJbDIFlj1blBqGipMRgIJrEIbzbTa2b2pUvcpvNk
 dcWpmoaTD61R7c7B77KRbZ3YxH4oEvIizpzNJPCiRkZIcbMXzxSOUr3+GYlFCPWH4L9VTR5uz/f
 1eUOkLCtlPCHNmnPwwVGN0+xeqetcjqmnLWXfP4LmhzzcURESP0gMNYcfk9jyYP8/V7EFSSuiXR
 bubuy+/hj3aWMPoPzHmz+3KZyIrZH9tCKfDVfeB9NK2hkHp3RAyYMgHIekx1SZJfr4JW8n+eQY5
 tHErNMcXTzStTRmTcU5w1D1z4PDF4JoJhrSCjMKwyu79wDWMVcRM8N32Sf/QPVPVK5qJdPEBVdw
 ktf/0Hl0RYJjmlnbJ383cB2Ina37vqTTD5d2sLE6tXE5+9D4=
X-Google-Smtp-Source: AGHT+IFbdhSpCnhptfzWXBwfdMW35gNmUEKEkUXY2niPl1brVe8kJ6hjuUFiCab9xPtVaoSPcl8YBQ==
X-Received: by 2002:a05:622a:355:b0:4a9:7812:aef5 with SMTP id
 d75a77b69052e-4a996421885mr32335471cf.9.1751636563826; 
 Fri, 04 Jul 2025 06:42:43 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a79606sm14071051cf.37.2025.07.04.06.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 06:42:43 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 3/6] bloblist: fix a potential negative size for memmove
Date: Fri,  4 Jul 2025 06:42:02 -0700
Message-Id: <20250704134208.2895595-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250704134208.2895595-1-raymond.mao@linaro.org>
References: <20250704134208.2895595-1-raymond.mao@linaro.org>
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

It causes a panic when blob is shrunk and 'new_alloced' is less than
'next_ofs'. The data area that needs to be moved should end up at
'hdr->used_size'.

Fixes: 1fe59375498f ("bloblist: Support resizing a blob")
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- None.

 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 488908f605e..550c0c78ffc 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -335,7 +335,7 @@ static int bloblist_resize_rec(struct bloblist_hdr *hdr,
 	next_ofs = bloblist_blob_end_ofs(hdr, rec);
 	if (next_ofs != hdr->used_size) {
 		memmove((void *)hdr + next_ofs + expand_by,
-			(void *)hdr + next_ofs, new_alloced - next_ofs);
+			(void *)hdr + next_ofs, hdr->used_size - next_ofs);
 	}
 	hdr->used_size = new_alloced;
 
-- 
2.25.1

