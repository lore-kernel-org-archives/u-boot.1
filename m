Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58295F433D6
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9D058423F;
	Fri, 17 Apr 2026 10:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MM5w8DGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 929A08422D; Fri, 17 Apr 2026 10:15:18 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B66178423F
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so222499f8f.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776413716; x=1777018516; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WqEKbwxbqtGB21Uu1wb7rSiQoCasfq4Ry2S3cwkU7IQ=;
 b=MM5w8DGrZiqgbjlTcxhJfELxZb8vDZ3sOe6+vIOwf6hTtVENvKVdYDRMF2qOC9xwmg
 63X8JBcW2trZ3Ea3XaHu59dZtl9f+4+GWt2yn0KwNE0XJpT5uJpw3YKwyD40ub+AJ9mv
 fG3rpFuLCiyT0PW0MJ2iVALGYrfIIYW+DWHW3joK81SwSdG2e3S8eCUFCyIn7FH4U826
 0smEFODHcKyx0kwhXGyxokblTf054dXFV56aVC4ZDKWhoJNWR7R8VdLbeeLp4gUvMl7h
 uIUb4uZqH6jy5MlWtrJ8zUMnX/L5q85c6XuOF0mXZybWT5UHqTLr+WHHERFjoaEFqbiP
 QVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776413716; x=1777018516;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WqEKbwxbqtGB21Uu1wb7rSiQoCasfq4Ry2S3cwkU7IQ=;
 b=eQOm0mRp2D6vgH64LZZ9Pywr0wUBZ2b3uN3aNKMdhna6uCvI165q5wz7bVt5TeSGoV
 pIu+0fbGYZQr0JKEdRiO5z3tVYDjrxte64W0s4u8TAt1X/QAQlS6q393toZbS7auKdvi
 /nEO59WPQEjXSdRbFCjIC7UcMvpZanMJVyslA7Vkb7dTzR/dVbqFQSGF5waSzExMySAp
 1wnzp01UARNieLdo6zcjnbkfKEJQWJ+Aj3aCi5qdMQSvjyo9fZ+x46hDnOZS1twJS5Zg
 T86dkipcP+eU149Qg6ouqOsY7NXsBeHaRSFaKigBA8JDqGTGf7m5i3iySemZ6NLedy/s
 sWKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9avUJji8hOar1Z4IXjm/I1OpfaPws1PhMDLCC26etDpa82rYF/fiPf1TRJYFs9VhsE2lhOwH4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzlc+6Uhxzlolac3DiSnSsTf2d/3r/aKl3IjrLvDLeaHiW5G7r9
 Qzy0mxPbttZ3TJWPdyps7PSWkYqPuh7MCh8E0tnSbVgY7xR9RJZhPekW
X-Gm-Gg: AeBDieukwuueXntjNAcBTvZ6JmbrtolcenNODu2OPs+A7VFMeIKf9Q5Ng0fMcKT2V6A
 9fkMLZf5zs1VWldttl6CWzrMJEQU4LkHI3zMTr4U8rC8QEP9+xuHDIJmFFmAWZ3aEBSEwVIGEQN
 vin+gA41z7yw3bvBRLfO1tfw3d7v2fwoHxZh056YyFM2UTHj24CYp/OTmR5Ml7DdKdRZpDsaM0x
 i8xvBsI9jKL+UfO5aJFXqGIpAtCyhywEfdd8hjRm1DywnW6LadrVzrvA/zGryp5LlXonHnoeAMV
 wBvwEuiMYDLHS+kkvgwODM/+4Juogya6HCBFbcJ2bap+HYA8UMohdio5CWCVnAaCMfI4bSoTABR
 5aJR44iF0HuIJRGl/MlFG9GU+gdcUqUNL8icfJQQLUBhzeJoL4DqX/9gKrv3KcQ1RJQxt3YM/Zg
 hugomo6qX5QCBDnp04CIfsj2oRFez9d11kDOm8H4hTm5qF+MkAFezBfgA4qQrM2l0TEm/jRl64m
 tNHz1JKJmHepkxMRfVe2p1jeao=
X-Received: by 2002:a5d:5d02:0:b0:43d:77c6:be6d with SMTP id
 ffacd0b85a97d-43fe3db39c6mr2476453f8f.7.1776413716044; 
 Fri, 17 Apr 2026 01:15:16 -0700 (PDT)
Received: from [192.168.1.3] (host-87-2-163-213.retail.telecomitalia.it.
 [87.2.163.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm2537984f8f.22.2026.04.17.01.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 01:15:15 -0700 (PDT)
Message-ID: <0747c1f1-5f49-42d2-a624-a6da6c47d2d9@gmail.com>
Date: Fri, 17 Apr 2026 10:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] toradex: tdx-cfg-block: add verdin imx95 0226,
 0227 and 0228 pid4
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20260417071546.1610330-1-ghidoliemanuele@gmail.com>
 <20260417071546.1610330-4-ghidoliemanuele@gmail.com>
Content-Language: en-US
In-Reply-To: <20260417071546.1610330-4-ghidoliemanuele@gmail.com>
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



On 4/17/26 09:13, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Apologies, I accidentally omitted this Reviewed-by tag.

Reviewed-by: Simon Glass <sjg@chromium.org>

