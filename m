Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AD5C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 09:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E800E87D57;
	Mon, 27 May 2024 11:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QZlLK3xy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 895FE87DCD; Mon, 27 May 2024 11:36:30 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AD2B87837
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 11:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e9819a630fso3100111fa.1
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716802588; x=1717407388; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fE9Owo6ncNgRR9kAQWkM4wy25q7n3HEgKtqszrIPuIs=;
 b=QZlLK3xyBM1PCOYK/GWt4910t0GX46ciL8o6MhMRZXxoP5PxAi7AX20XADdssic45Z
 93/gjJoQ84NPWnLC5zk1w1mABdLZ2BNJqACLE2SxefyGSeHc0fQ/g03QweK28OPeqAnF
 uC+ZAjWgnsJ0P7/tqq49rayTihWNiUNFLnO+CeCpBSf6FFKxnxdxo+xUA8LfhsTBgHG4
 DkUEyJ9jnkJ9FhRaY3TJ3GfF8tKPiwxSaUiZatvHgW67ivk9Gv8QNQbajVd11hmoHnoY
 jGxwvdpl21LfnZZ0od0B1DzFLsgp8NiQEmZl7HoYb1az+Pg5VlDp5cWdXabHfO6FbvTI
 qbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716802588; x=1717407388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fE9Owo6ncNgRR9kAQWkM4wy25q7n3HEgKtqszrIPuIs=;
 b=hOexOowVUGe4bZJ/ETyGZ8oMGLxbwbQ9eFYQretNhixtUGdC2XCN37XV3HQTAnAHCT
 K7k/LXxTQVYu8k2NbhnW2IArQKRpnO7WThi4U/U2Jxv5uNqgMjyoq9Szf+9fo4FArV0l
 j6c4lcRTCpokemToQa67+Yhlbc1goQ/6JWuY4ILoOZAOfG+gmMow9n52Wo/FcVxNPRng
 ZqXt8TL2BGOUwi0UwXgtyBVuQDRMJTFcvMCH+VtgD9S1OiNoHhCuzMGFMNbIdYElBgBI
 v8B3AugiOMHkFK1bD70mMt0blNe/rlwxS09T9RYIDawlJXmhvMZlaAdwUG1ap80NnO7v
 hjnA==
X-Gm-Message-State: AOJu0YwSY7cc+GX3c+9hwsT5c+CSK8YI9l0V8yBopu9MrHy0UbmWs80R
 lV4K8UoBzgXenZTqp3lJUZ2yfjfF9nO6Fch3IQB0ChNckbN4kTp0qzOSsSoSKiM=
X-Google-Smtp-Source: AGHT+IHhryp+UZn6CCKfb+lngjWpRfOhtifqME88MBc8+Tn0rTkUxZQVhD8zy6EbaG6WAFNCzSRDQA==
X-Received: by 2002:a2e:8788:0:b0:2e1:cb0f:4e1e with SMTP id
 38308e7fff4ca-2e95b0416d4mr71153401fa.2.1716802587651; 
 Mon, 27 May 2024 02:36:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c817b0asm473676766b.3.2024.05.27.02.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 02:36:27 -0700 (PDT)
Message-ID: <23a33323-35d8-4ece-b57b-cdfbc318d3c4@linaro.org>
Date: Mon, 27 May 2024 11:36:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Introduce the lwIP network stack
To: Francesco Dolcini <francesco@dolcini.it>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
 <20240527092301.GA7851@francesco-nb>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240527092301.GA7851@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Francesco,


On 5/27/24 11:23, Francesco Dolcini wrote:
> Hello Jerome,
> 
> On Fri, May 24, 2024 at 06:19:54PM +0200, Jerome Forissier wrote:
>> - Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
>> has some additional lwIP and Mbed TLS patches to do so. With that it
>> becomes possible to fetch and launch a distro installer such as Debian
>> etc. directly from the U-Boot shell.
> 
> Why this is enabling this use case? Or it is just that currently,
> without TLS, is not supposed to be something you should do?
> I am a little bit confused reading this sentence, since to me this is
> already possible using tftp.

You're correct. The point I am making is about using a secure
(authenticated) connection, and I should have clarified that. While using
HTTPS might not be critical on a local network, things are different when
downloading from the internet (think man-in-the-middle attacks). Also,
many web sites are switching off HTTP in favor of HTTPS so it could be
that your favorite distro becomes unavailable without it.

Thanks,
-- 
Jerome

> 
> Francesco
> 
