Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ECDCCF9E3
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 12:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9A68838CC;
	Thu, 30 Oct 2025 13:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rj00w9gB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B20583826; Thu, 30 Oct 2025 13:16:36 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5401E836F0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 13:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b6d5c59f2b6so248718766b.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 05:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761826593; x=1762431393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIERCMabJImDjIks5+75jccrDxSlpaCu1jMAb4QpM5I=;
 b=rj00w9gB7JhFjmmtXbIgwTtR5xHwbfdi/ooegy6Nme2UB4hlQZAGihWRC1/zwHHdCo
 AyVNCpZqa+jaUSw//HVy1RfN8trsWOWldRLcAE0EvW1wDLe6K8GWUyG2giD98zDnTVaU
 n8zJsQH4y7fyCMuSXSPgDEztUQ4hF/v7OgZcU1W5ZSDnmSDhKYM0BPikiaZ3VD7ajY5M
 YFEYRp0rXCro2dZat6Z8UESPwVoh9d9JYkL/jTbKjN7hjE3XsjbUhSjuc1ngH771UHMs
 omcjoM7zRb2lSaeT+iEQCusDlLiYGMcQankPfjRbfuNW0U789x9rgU+0a/aRJ15PF/xS
 U9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761826593; x=1762431393;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIERCMabJImDjIks5+75jccrDxSlpaCu1jMAb4QpM5I=;
 b=khVMIUm2+TARHDSrhCYDDT7L51IBXsy2pWztMHr8Uu8heFVhhyiqKIE6pK5fZMrqEv
 y4mmNneTVP5tFeC3GdX/8xhN7jETaC70aDm51VsuZjMein6ulhD3DMY0iNbOv2f1T9N9
 mXESwKuH7TVKIIkaNx94fWQdTXpaZU0tyGQUeaWDgAMgFpvImSKNEVgwAgrF3XgchSWr
 vb4mVpVWHqCMSzFbPyYOSJ5Kw8gwixBTQ8SrxBvD8+boagzRHphxmQi37dy9GYQm0vtc
 aCcyTmDk2xzazbY4AaX9uIwBTR3RekggtXp0yis9pUebXbg2ffbFA0eHCoU5itigDn/t
 iYWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNm00HooId9JlVm0BN6pVmTyNP1Kqnf+7W8ub6EvzSiJIfN1Mz+WDvuyi7oo67NF6z3C+ujGI=@lists.denx.de
X-Gm-Message-State: AOJu0YyGoNKmTj4cnkHv1ehG64wdM6ZEdNl5TASBWHho4y8nHNxJLXl7
 WlO68usK25xFD5Qh7STV7yFALTe9op0ArsjEg0gagwJiZZJXb3yxMXcyL93Njk+RUgx0EpqQkfY
 V0Q+wKVg=
X-Gm-Gg: ASbGncvRexLB3ICZz2IEYSZE0A0QwTAHwkosBZppIQ220xI7yrzNr9vFnUxUzJloVSR
 IkoOinLXry6cf/U7aF6tdsWKV/se3vesxX1EV+4DMsVZs3xkmhyw55nfmrF1FkQ543uvklem/GA
 hiNBvxtGBiVkS5Z8Uk5Kw71/4/k0gNPSNzFPuMyNx/yvjX4/Zz4EF4ZH7OC4y0fc7Mrg2i2fGOv
 li1Qh37IhT1iGFA6lt8/1xmKymsMCR9RuD+so9LmA+5/uGHYPWV0WcQK6Tb/8Lp7qJi/gE9yQmk
 qjS1pf7CSDvjosRt1UsCuiPu9Pc73qP5yv7ALNwr0JIlY/+kc/nA0mmx6R6+Yrdlivw4g7kuA42
 zmgpEvYOW45AnZHd7+M19GoS1VAgF2XjD3Px6Q49VguALXEd9S+k/SW0JYP2R7C0VhG/eyB1l8p
 zZw9FDuqadtps3Okygbv6qapleYuQwr/Kb1ySpomrdp23lfqoNgGf/qUU=
X-Google-Smtp-Source: AGHT+IEoq8C0AA8c0yv23POsJh8ucPjMtFKLrILuK0yyRuMzT0vwdYZvwYdqhOcEIQ1feuM0BVkj0Q==
X-Received: by 2002:a17:907:d8e:b0:b6d:7f07:c015 with SMTP id
 a640c23a62f3a-b703d314a99mr678493366b.21.1761826593424; 
 Thu, 30 Oct 2025 05:16:33 -0700 (PDT)
Received: from lion.localdomain (p5b29e67b.dip0.t-ipconnect.de.
 [91.41.230.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8548eda6sm1710123266b.75.2025.10.30.05.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 05:16:32 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
References: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
Subject: Re: [PATCH 0/5] Colorful mix of small fixes and UART improvements
 for Qualcomm
Message-Id: <176182659157.4111945.5255091374272484400.b4-ty@linaro.org>
Date: Thu, 30 Oct 2025 13:16:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-52d38
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


On Wed, 24 Sep 2025 13:30:06 +0200, Luca Weiss wrote:
> Various patches that do not really belong together, but sending them
> all separately also feels a bit much. Hope it's okay like this.
> 
> 

Applied, thanks!

[1/5] pinctrl: qcom: sc7280: Fix offset of UFS_RESET
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/e4b35d364e86
[2/5] clk/qcom: sm8250: Remove unused defines
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/43a2fc67d383
[3/5] serial: msm-geni: Update kconfig name for DEBUG_UART_MSM_GENI
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/beaabce9cc27
[4/5] doc: board/qualcomm: Clean up debug options for QUP UART
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/759646df3aed
[5/5] board/qualcomm: add debug config fragment for MSM8953
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/202f5975c2c8

Best regards,
-- 
// Caleb (they/them)


