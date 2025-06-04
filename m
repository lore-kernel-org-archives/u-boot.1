Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAADEC5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 09:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E194D81FEE;
	Wed,  4 Jun 2025 11:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ym9zDscu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B05C482D18; Wed,  4 Jun 2025 11:08:05 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35BC281F0D
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 11:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60497d07279so2393342a12.3
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 02:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749028083; x=1749632883; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ILGVBsb4TJ9MHe73ETienrNAdYWLICNvKnhnj+PI4Yg=;
 b=ym9zDscu6DVkLX470k2ksvwILRecp+CUPn++lWO8zdFU3CGYaBfsI11A4QA0WPY4yT
 ShInm2jbyYGVHcmgyWiTIC1Uj+jG8gI4iFmAQLtWWXZttVKJVZxSoVbhuKxkePU8RIHV
 WCN+gVJdyLrm7LQGFcsD3AgXukd0bzyhUOjKojVpOCT5i8uAoHsl1k5PyPA4GctLwKzq
 gwaBNMRXOSJrm4uMch+bt0dlyLm8cqkBtA9JKL0r05i8nU41qgi2G+I5wIZ8eBqOSGlU
 Z/rpLXY15c9vLxTby7VceBinNl1R6vvOpmjN8Cy/hjN6pzdwYJZ4bzSYpNZ5Pq+MJ4wC
 AnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749028083; x=1749632883;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ILGVBsb4TJ9MHe73ETienrNAdYWLICNvKnhnj+PI4Yg=;
 b=UnlJl67G9MLa/+dGWOqH/6NKh5BGCKXSubeF7lyber9dg2V37og1SA4I/A/LW6J0qi
 D3onKTFdMYW9Vo8COIAiVAUtClcGunPrRL/lyXJosJM/4gsgy5c9jO6+lZnHsfK27ASz
 KvN4qXZdBWOtZJ6RaOQkS2VgHogQNkowH5kp+Z/C2W6ruk/m0F3HYNMdZcr79l5Xo6tr
 LhivDDxFV+cTlY7rpcV49Lu1sbarddKtRBTDKK4Y26Y8KaczeiBkTbj8dbFPa0cFoQ1f
 0ipoIvd35zi/Nm8i4HdR0jlOpio8OrcT+Tb6KTWNaLe/mwcEgzr0Kf8nFTqMfLkrWwuD
 yhtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULbF2pkC77czkBLxjU4/cmHWlUSM7uERkN+prXI9vnwxc4AylqiJJPM+ShrJJe/yVZpJA7i4U=@lists.denx.de
X-Gm-Message-State: AOJu0YxWky/PFJaMuc9zo3QKAZEUyd9j34/xtqzzCExj6i84IPc0+0vp
 /eYi04iqq4vIhJdaX0zEcihuQL/D11i3wz8ImZa5CEe56Gd+hPtCO8ltuLkqtIbzuPw=
X-Gm-Gg: ASbGncvKMpgcBxGia3yhHQe87jufR9XF8+yVpvBGlLVHw2n/5LoxubCy44uzcbAi5Yh
 n2WrJ4tmBBINsJbhwrS9pZf1xvKnak5LSna2hiWzxAoitmA6bCF8cfUMv7cDHGlCilSXrWMOf/0
 x3ipdMM8G3h7poj7n+CTWM9O5zH+LGpYk441lLFJm2HzZ9lLaWUvn6S1N9wgcbF4YdjzWUB92//
 BlY9NaCIsYAe9qRALF/Q9l0Ys9yY5vFDqhoPh4FqnjQK3TLCu7yVyNk7zDaStlLGUCdInyxfsdo
 Rk4ERT1L4/qRL9cojEoMyB69qDKnld8NP1DVCQr6YeydRMNPVKqiHwkyIRCH1A==
X-Google-Smtp-Source: AGHT+IGnkeNNXRxO42ctWYw01N5B0vXXxdOjh7ekgvQMMSsjyPRT+uwFFOZnMtaduz3fQEV9dKGN3w==
X-Received: by 2002:a17:907:5ce:b0:ad8:9ff4:c047 with SMTP id
 a640c23a62f3a-addf8ebb2d1mr161058266b.35.1749028082530; 
 Wed, 04 Jun 2025 02:08:02 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:68f5:c95:7678:409b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82eee2sm1069096666b.73.2025.06.04.02.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 02:08:02 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:07:57 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/7] Qualcomm: teach the build system to emit signed
 ELF images
Message-ID: <aEAM7dMRe82n5Enj@linaro.org>
References: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
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

On Mon, Jun 02, 2025 at 06:10:51PM +0200, Casey Connolly wrote:
> With several new Qualcomm platforms appearing on the mailing list, all
> of which build U-Boot as an ELF, sign it, and then flash it to some
> partition on the board, we're getting a lot of defconfigs which just
> contain a debug UART and a TEXT_BASE address. This leads to needless
> rebuilds in CI of effectively the same image, and needless duplication
> of build instructions.
> 
> To address this, let's introduce a new tool "mkmbn.py", this is based
> on the existing qtestsign[1] tool but is (currently) hardcoded to
> only handle the Dragonwing and IPQ boards which use MBN header v6.

It doesn't feel right to limit the use of this tool to v6 boards, given
that qtestsign supports v3 boards such as the DragonBoard 410c as well,
which is also using the CONFIG_REMAKE_ELF functionality right now.

Which changes are needed to make this work for DB410c as well? Looking
more at the diff in v2, I think the hardcoding of v6 is actually already
gone(?), since there are entries for qcom,apq8016/qcom,msm8916 now. What
else is needed to use this for DB410c?

I'm happy to test on DB410c if needed, just ping me in the chat.

Thanks,
Stephan
