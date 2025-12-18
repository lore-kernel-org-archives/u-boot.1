Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53874D6E2AD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 16:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE2583DEE;
	Thu, 18 Dec 2025 17:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ORv+oAeC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55B1E83E0E; Thu, 18 Dec 2025 17:22:58 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8390283DE4
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 17:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so654596f8f.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 08:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766074975; x=1766679775; darn=lists.denx.de;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iqSlKXi6acI7jAGOtBjufl8cO1dUGd47Z3YftKzcEA=;
 b=ORv+oAeCasw0Ohp16CWvh3bAn1plRD5GZ9chm6h7P4KnaLiaaWBqQOP4m2QUVNpmo6
 LVM6lxML77TOR25Ey4YNpbK95ZKPZYmFD41Zxh23k2rufit+Gqjc2BQlvNni1P2wnapf
 WcPX3h9gzYuDav8aLvL24IiTLVX86EUXbZSvbq0EFmHjdqjR7MAx1x6vsWIa/+jNwBDo
 pk0/RTMeky0G6nZPqVUQhoSESIkjn8RhbWWG86dPfLBZEsa51n4pZkBEvl94r8SsBWGb
 1k/0YffBH3JZnjP/CzAAL/l0nLUtvKb58tgDVRLl6hvxbtErZ9B+nBqv97Jl3/CRP6qY
 xtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766074975; x=1766679775;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1iqSlKXi6acI7jAGOtBjufl8cO1dUGd47Z3YftKzcEA=;
 b=qXxEJleQZ6IJnIAXz/SpuaWySvjl8+Irwh7HusEBUm0G078J27I9ZSAxnYbZtlOA+O
 4SksvHnYEfNz2dakYYfzMw5ivWe+T2vir9O6P1i8HRpB9YRx5w2+JUlsmnL0HEuS3It2
 wmdUTmYNQUGgbqtxKopepGjrPKxYaZQMgLArYcbv+II5M6M2DC/XVjCt/6LgKJ8+ogCm
 xCjJhz+f3LkX19rZA94sTxbq40X+ACDC6XJx/pyxmiJ4XDd0tb5Cvmv5LPqe1hrZI4XO
 0PcooyWjAkcXX0Afc7I296QZASFkgVOXb8iKhpMMcVPxCdag5KEjFsNuf1TroXIHdkru
 FcMA==
X-Gm-Message-State: AOJu0YyzK+pyhpdmc1wKgw6iXNbGcABSa5SnS/RIkPR2h8cx+ApuRe+0
 cpCAQBJe89qgaixmO49d871aq2wwMrPDdj2eHmyrMoocY4oF6MCN5MKjf12Ff+P5R+g=
X-Gm-Gg: AY/fxX4pYtv5O6ZFVxltjClDjYreUtVDpBj7bqpRDrqAtmBWlWd08dlDWqM5Eiq2WaV
 kEIwDz3KgCcXnOn776T0jvrkkfUge/r6BlQiLB/Z5zDxiYrLrpaFx0YP/Fs5HYOcRr6yo+K3V4T
 6rdfv3VbNMNAKOOjVJXsn0Ryx68didhQaBvpzKk6At1VGz8fGExzC8Q+Xt7TL6/ghaL03wrSTFZ
 jnWSk7jbfTs0niAjOzJTiBaJRkSwBTPlHEqOmTRqEX5dYemNeYs22IWFKeip7EnjgUTI60JL+iF
 11aGccNYOy+HrS61637J+9ihr3P1UbYUkT2Dxq8CsrkCXYv5oRVbAjK9bQDjQxcAXfWlmdmBtYP
 X4h2xGyiiVMIqFc3O/rAYS5wif3jf+DYXht7jWSppxU/UVUTjmp4+ZgPCGvxzPGkM6P29R+9baM
 Gr/XtL9VXyvNwXSCJtRrW0AbYay7+S0bY9ijYbM5rFG3bNpbiLpx7gDam/b+Fd1fJylw==
X-Google-Smtp-Source: AGHT+IFFXx3oo+oyOfs/6mtNj6wzcc0nAZt7pMr4Ny472+tECeCvBtrwd28eUg2UlqCKImU7/8HR2g==
X-Received: by 2002:a05:6000:2890:b0:430:f65d:c0df with SMTP id
 ffacd0b85a97d-4324e7090d2mr30637f8f.56.1766074974887; 
 Thu, 18 Dec 2025 08:22:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:cf83:fadc:3e6e:2b4e?
 ([2a01:e0a:3cb:7bb0:cf83:fadc:3e6e:2b4e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43244999258sm5873418f8f.37.2025.12.18.08.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 08:22:54 -0800 (PST)
Message-ID: <8fd28ccb-9122-40ad-a434-b18db0f26e1e@linaro.org>
Date: Thu, 18 Dec 2025 17:22:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Jerome Forissier <jerome.forissier@linaro.org>
Subject: Please pull net-20251218
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 18 Dec 2025 17:23:48 +0100
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

Hi Tom,

The following changes since commit 47b50fb1125c539d80ed3e7f739c02c6486e1b52:

  cmd: part: Fix part argument description for `part number` (2025-12-16 11:14:53 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-20251218

for you to fetch changes up to a8a81af848b88d7ecee64d98a08f6415630305b3:

  cmd: lwip/wget: avoid NULL dereference in _set_cacert() (2025-12-18 16:27:15 +0100)

----------------------------------------------------------------
Pull request net-20251218.

net-lwip:
- Avoid NULL dereference in _set_cacert()
- Fix filename handling in TFTP

----------------------------------------------------------------
Andrew Goodbody (1):
      net: lwip: tftp: Fix filename handling

Heinrich Schuchardt (1):
      cmd: lwip/wget: avoid NULL dereference in _set_cacert()

 cmd/lwip/wget.c | 3 ++-
 net/lwip/tftp.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

CI link: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/28786

Thanks,
-- 
Jerome
