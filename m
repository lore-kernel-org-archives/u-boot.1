Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475CFCD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DDD1848BC;
	Tue,  9 Jun 2026 14:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KGKPZm2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18EF0848D1; Tue,  9 Jun 2026 14:49:29 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89EE84881
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-68d23430690so10889692a12.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781009366; x=1781614166; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBmAD+4F5XOSurgFFprqruH58qGyuSFcqjxo4Qkwc2Q=;
 b=KGKPZm2F1xD6dwwTv5IGsuVd+eIkL46FKs4qqJIlGlO8AVY85c+NeOCTNgLwiGcXQg
 Q2kYACTmHDG4La81E7+0Nzr1euixz/1WD0gRRaNxkO2ec8F12ytgr/slhfvKpF/Jivo9
 DK4ty5+pgO7/3s328KKQMYtclnMe+qjJfmA+zGRwSXk7toYCQ9X5igI+2NJlUWLixh0I
 QaAca9CCvTjf23R5ESVkZyVdx9egQfoipHeEypc4Xx+l5B64GJ8qdhpnNQT9+PrC9SSB
 5WcxYvjlFfWnEFSaoiM4R09gyLgJJf5DJq/kl5PKQsD+TW47GHwpjdvtfXlSD48I1TVo
 q0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009366; x=1781614166;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pBmAD+4F5XOSurgFFprqruH58qGyuSFcqjxo4Qkwc2Q=;
 b=cPb8qWyFAUF51WDFsD/vOOMxKUu+sAHVAfMcQQpukkVJEMFHdgflDdQnfaaFwgE73e
 +Wf19tuLvfrsK+zGwJ8QbyxqY1RGVQDt0qzlmqL76OheE3D3fifhlkTBUww3jmFx1TaN
 bbg+tmWmOHRf+HZmMkgSqLLCWFoDTu2pmI8L482Nf5MRheeVcH1JS9W36aen/XVRMnSQ
 /ozaeJmVRTc3SSPiJjfSZ9Fdb2uxDj2gVUrK51kD+Ib7Zb59pz0v7PfYczfPT9kvXL/1
 7lJCk/rlJBs9E8jf6gxW8Qg7DGz6BN0z1NTWr6Ps+vqVe5h/bmJIwx2tcHDtLGc/zocV
 EoKg==
X-Gm-Message-State: AOJu0YxjYvecJJfS4T38wqWMmOrj5y8kw7x8PPmkp08RpulNUv0N8yKr
 xHrvTHWZO1Of916CGpnNefItGJcyegbj0vI2IJBSjrkJbqAxbiAa5ZtO9b0VndXZPs8=
X-Gm-Gg: Acq92OGo4aoJ0TnHtup8zj8alXhVIvZbT64Kkh6jeALsfmqfY1r+M6QXdLYk0K1ALnk
 ps8u/Y5spZYYAA2iG7c32TGvVr5sMI9lzSliPMgaoataEiB01/7SK0u2yaP46K4JzT6N2OC3pav
 mk3YHLGSJisrZE1FRXYN/0Z5XGKzHD1oG0tJSmzjDTTa7++NPDkYYgzo28gGSYtFJOzZnHhyA00
 SpYEvkl9T/jCIud6fsqx262kfb/AOUugABhGStChzlTLbPF4NYLWYX1aKzPEclKf/jxHJivjzzn
 vv0kLWWgbpbmagw44F2mC2A3trC/DMNa9kB8Nk/CyG/C5kT8dZiJXcSGis0CuwDs5a3Wu0Us31y
 YDUpGamPAFzyY5Oxfqrx9MMlZSU8YsuMwmhyUAyZZpxhg/ETVsUrRW48iGR1s2nmV0KSuY853Hr
 i3vLmCqGF0/YMU4+LWG4zezgs3VuMai/DrXdEOKb7lidlKTrqjQMAe9tXa1uzNg1u5x/4jqTiRH
 YzHBkV6pRWTtKU=
X-Received: by 2002:a05:6402:518c:b0:68c:627d:fc2b with SMTP id
 4fb4d7f45d1cf-68fa5039e51mr8988857a12.16.1781009366339; 
 Tue, 09 Jun 2026 05:49:26 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b55d81sm8689526a12.27.2026.06.09.05.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:49:25 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>
Cc: neil.armstrong@linaro.org, trini@konsulko.com, 
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>
In-Reply-To: <20260424104237.968195-1-sumit.garg@kernel.org>
References: <20260424104237.968195-1-sumit.garg@kernel.org>
Subject: Re: [PATCH v2] dts: lemans-evk-u-boot: add override dtsi
Message-Id: <178100936512.3342853.16379987639580699595.b4-ty@b4>
Date: Tue, 09 Jun 2026 14:49:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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


On Fri, 24 Apr 2026 16:12:37 +0530, Sumit Garg wrote:
> Add initial support for the lemans EVK platform based on lemans SoC.
> Define memory layout statically.

Applied, thanks!

[1/1] dts: lemans-evk-u-boot: add override dtsi
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/f8cc5cccd5b1

Best regards,
-- 
// Casey (she/they)


