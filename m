Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4ACAFF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BEC48483F;
	Wed, 29 Apr 2026 10:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HBym5zYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE188482F; Wed, 29 Apr 2026 10:50:37 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEE384840
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ad135063so111833135e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777452634; x=1778057434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGM7jTMdiZvshLZ8M3KyCCF2RR9pPetfR27OfhuJkmY=;
 b=HBym5zYNMcnmOHSqt1TzprQGh+XVSgxX6meXzQ0nUehGZS7orRoKBB11o61oOk5pdl
 6++Rq0QFo3bkkWKgK1smvUTdwunidkXRvz/8qR2kgoSp5WA4gt5diaD67RkpzvBJlbOB
 tithpYq9SRBH8ujQFYoZqhS/In0pwOO2K7XXhFETOcy6ROBZyV669Jw4KSo5d4/Ksv2d
 nTZk/xPrafVlpURJanM7tyQGLrqAuTmArBF/JaZseUU5zbW0Woz6I6IIHdAyZSvuWBxZ
 KEUy8bZjezhTRjEaJ8F46l6sJywWz5QW6uKNgj/MkTgobPp4+fl4NBEdoUglj5VTI9q8
 MR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452634; x=1778057434;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TGM7jTMdiZvshLZ8M3KyCCF2RR9pPetfR27OfhuJkmY=;
 b=ea/FZpCH3b2wHWB5AZTbXb77Qp2sXPtep4gvC7qE7lPGsZgzvh3Uc375iLVGSECzGY
 OOQLworzZtqjhpqZWBvGlfAJkJL8UH6/JwAU97xcNMcj+UOHh3oMrqY77YS+rf2MpjZ4
 wVYRSoJ1TivK2n9eUCMZnE/iVX/rpRiwucpAURTKeFiZATFWHisWEQP3H8fLlemzazZA
 FdZzB1TiO8liDlwPizyyyHctVUjFzmC8Pd7rAsdnSKgvfwCRWuDlHTYNwQxPCKLWSUTK
 UXTzq9W/HC/BQVgKF7v5rJO27ctpLu+PU1ECeCtLoYPEamgWEL5oJXFjvUMkeqPXAUCt
 RsuQ==
X-Gm-Message-State: AOJu0YycXSw2JOOAT7DYrAdgJmvvMRegxG2j38RZKocTQUjv4SIHHqGb
 ZXinEsT7Nkn7s712+R+ek2eqgJf9DHjltji6UChSnF53YZJf/4F36phhpBAOjQkc7jQ=
X-Gm-Gg: AeBDieuJS8gX2MEwwS6i6CQyoV6a22rPjV2XpVkuttx5DvuWrE5OJ2NPIbGxh+NTAGo
 asNcbPCUabREpXRs52nCPCt5UR9qNudy80uTihTaJmyE6FfH4xk4bS6/xBe9swoSFX214ZhWSwa
 O8TBDyNgpquh2nI+JGDgY245GRM9w2mjMJALX34BhOi4yA5C3x4fkOK3KThBAqJTLgPeDGQfNni
 ixaXfbBCunVydA1wUZQIN3uemSUZ/pRHFO5DTCrqN9ZzNl/B4gJ+fwf4c1jBpcGCWHzdMXQYF+O
 Q48Bu6dv4sEmGNAOMORYyY32d8+0KDjniuXV/BQAyiWFOxGCbwyYtrsm7/t3XO8igGw4tvZyulL
 S34gDr4D/LCG8G0H6NS3Kcj3zhaD++nOKGbHSqb7ncpqCtSDty4qvhIoG57VF6JDVHqDjnzI115
 t/iNcIqezUBbEDZIClG3scAHoVRjAx/zALlh0oEZt8kOjJEYtYJ5MRvz/iIiOCKCUeV/6eQPjHE
 sss1/I=
X-Received: by 2002:a05:600c:3f14:b0:488:af7f:775f with SMTP id
 5b1f17b1804b1-48a7b535a0dmr45719125e9.18.1777452633857; 
 Wed, 29 Apr 2026 01:50:33 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7bc80310sm37545395e9.12.2026.04.29.01.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:50:33 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Ajit Singh <blfizzyy@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
In-Reply-To: <20260226193217.82657-1-blfizzyy@gmail.com>
References: <20260226193217.82657-1-blfizzyy@gmail.com>
Subject: Re: [PATCH] clk: qcom: sc7280: add missing SDCC1 clocks
Message-Id: <177745262536.126665.8834334087489413826.b4-ty@b4>
Date: Wed, 29 Apr 2026 10:50:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=529;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=8h3ySeCs+9gT0gJ47nceRXsjLHLEoY816Q23xWG4inw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyPxyKcd1k7+V6Z15sVXsaYqPG3qcpI3mtZ9cvn3xrax
 a6mljR1lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIlc+sXwi+nhxRVX70YYL7i/
 33fmhe2pys9rmsxazl/IO3g0d/Ll168Z/udmPHq+zmk1T9e0bo3jEWKrlMPkIlsTDO1viP0J9P7
 afgkA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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


On Fri, 27 Feb 2026 01:02:17 +0530, Ajit Singh wrote:
> clk: qcom: sc7280: add missing SDCC1 clocks

Applied, thanks!

First and last time I use b4 review, the commit shas are wrong but you can find the patches in https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/casey/qcom-main-13Apr2026?ref_type=heads

Apologies


[1/1] clk: qcom: sc7280: add missing SDCC1 clocks
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/e3da8a860343

Best regards,
-- 
// Casey (she/they)


