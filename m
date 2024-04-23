Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9363AC4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 11:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A05885A1;
	Tue, 23 Apr 2024 13:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rRdFJ4nQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6A7883B5; Tue, 23 Apr 2024 13:43:22 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8912588597
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 13:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a55bf737cecso193087166b.0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713872599; x=1714477399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Nl0aCQ9gHnvYQHjY+/mK6P8qUkVKldvGn7/aLJ96Tk=;
 b=rRdFJ4nQyp02XFtF6NGa3aCL5TYonASzadRVWRCEDuXDqdAdWyHlo48GUm5Jo2c9+J
 k3jaEKWvnTZl41VgnpXi8ggCZwk4wa2JOnkGw75A1R+rOl06CY/fYO/qmABnfW5TKEuq
 ugIQ6YDo5FJUGV+ioalx0PMpEwahwJ7HFWyOCbKW9zXNuTX02rB9OJbgYOyX8n2UP+23
 SmHf5ceqh7Bwm7962q75YbbFH2UmlFQFqYvrQd08sOAarEDEj1T2lH4cbLc3jy/9izpo
 Q/ZFzWdVm5/M+8PF8PmhrOaXa5crGQ3PdD7TqE9tKjZHHqU+U2O9poQEFXaFq0Q+2AgY
 jgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713872599; x=1714477399;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Nl0aCQ9gHnvYQHjY+/mK6P8qUkVKldvGn7/aLJ96Tk=;
 b=uqV/0ufAQFDWy6/HmqBNsnu1Xr1OYLyx/kt10rZANJjYlqBmh0oFSdHH45NON3CPBJ
 de0hmbxZyHdlFQw9I2U8ToSUDAop/xihJsbQJ7LnMRXR7KoDex4OPlsEJvyy4BPwBARH
 +xMjhwXfJ4EP4zaE3zLPctxEAx7WqH/dNCQklAw++iXgrRvfWt07QOm/OZty8kvRgy2t
 OOjlUh1lzLOhDyHN4p73nUtzBCd10m34tMGJ3sd6dliJSfYNHpYri3sgHxf/I4SG1cZV
 mko058aaAsky3z3aifCxuJkgqZmXsYV1COxJj8gTcJtfjurVnwSs/eB1bpheFXDongz2
 TKOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAwvii1ymuq2sH4aBg/0XGl0Ed2HNo103C4vGNiRAoIgU8Hrx5qe5wwbFe2fB376iJFPd+wtfHIXgbylk9E7f4f3u7+A==
X-Gm-Message-State: AOJu0YzplVJkmu/IyudeGX/1w7yVRpjpGcfNLz+TKVYV2Is1kHsdsqpW
 jalA3l4NbB7p4soFr7gBHtsD+pd9TSkp+SEA1xv0QvzRTPFqrdbZbKxkHgUpF/U=
X-Google-Smtp-Source: AGHT+IFD2pVb9RIwUqB7hFi4/9v8KOahfi4RF3tqa2uqF0C7VjhoAkCUIaBzOmeQP52gxW/qHU0djQ==
X-Received: by 2002:a17:906:d9cb:b0:a4d:f5e6:2e34 with SMTP id
 qk11-20020a170906d9cb00b00a4df5e62e34mr7384862ejb.19.1713872598994; 
 Tue, 23 Apr 2024 04:43:18 -0700 (PDT)
Received: from [192.168.0.114] ([2a02:8109:aa0d:be00::1795])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170906164400b00a55967a9038sm4507528ejd.95.2024.04.23.04.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 04:43:18 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: trini@konsulko.com, sumit.garg@linaro.org, sjg@chromium.org, 
 u-boot@lists.denx.de, Robert Marko <robert.marko@sartura.hr>
Cc: j.beck@linefinity.com
In-Reply-To: <20240418091727.18551-1-robert.marko@sartura.hr>
References: <20240418091727.18551-1-robert.marko@sartura.hr>
Subject: Re: [PATCH] arm: mach-ipq40xx: dont select SMEM by default
Message-Id: <171387259832.2280908.9543124319858231884.b4-ty@linaro.org>
Date: Tue, 23 Apr 2024 13:43:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Thu, 18 Apr 2024 11:17:00 +0200, Robert Marko wrote:
> IPQ40xx SoC-s dont have proper SMEM support like more modern Qualcomm
> SoC-s so there is no point in selecting the required drivers.
> 
> 

Applied, thanks!

[1/1] arm: mach-ipq40xx: dont select SMEM by default
      commit: c38dcb217c8be0aae7e8e1bb1fb3c31850fa89c3

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

