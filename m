Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DDFD5E14E
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 10:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87D008902D;
	Fri,  8 Nov 2024 11:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y8aRD6kc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CF2F89080; Fri,  8 Nov 2024 11:11:50 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 694C08902D
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 11:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d538fe5f2so1333257f8f.2
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 02:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731060708; x=1731665508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZ0bgWeCbSkHzCltvI98cTC1Sr3lNHUXnvOtT/tVHic=;
 b=Y8aRD6kc6WNXymfWqMwVqss0ND+HHojkw5SiPqCkjDPYg+msPuSKjoZB57qUZrNagZ
 oql7TxHQANajyN5GtBjKyAftipUFM9BIfgPOLY5o+tBSPV2szdEoQuAogVjGYUkuxN9U
 8OwYDcjPadmTWJf2Hhyi1/NNf6AyPz+vKwA3ptJBKmcXqiDqQcLskVZvUN8M/EnqZTnR
 M21DyC62IqQV6DUc2EOxRmPRL2bxO0IWkOMxeJ/XcrYQyB1HnYnvTt/ysAQJiEGOFKPS
 qJeuIu6H+9I8s6uaciI0UadWIYhYgI1itqkDCgi8w93Vw5WckuuV81iJSgQJoBG0vBjk
 dPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731060708; x=1731665508;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZ0bgWeCbSkHzCltvI98cTC1Sr3lNHUXnvOtT/tVHic=;
 b=F54KuCnBFJJlH1veEKBTmOM6s7sXe0jsEmV5VHDXJ4Lz4VrBax552X2EFHYJDThVre
 2H5KZJaCjOgX1+jL0Vh/R7p2SoQS0qG+fU5nZHeBAteyFJPiQQecufPlShxCxkH2FxbP
 nRXi8FltEKFdnSnZ+smSa7w8Kx3cu6gl1aqDvmbQrkIdjfzUXFH1kfb2PXfKy/QlSVNx
 t04E262LM3NGFs7XDKnVCHVrxObLBZHcasshjA5UeDt5iK2ABAodKBkgZSjEcPLmoiHp
 T9MJ2TNrymrciAQBH044gJS3+/0h9av+nAzxmEys9cajZaIAUA2BvOJerWaOOScojIRM
 no4g==
X-Gm-Message-State: AOJu0Yx8kH4jai/LwGqwnpVPt1vKNGOfdkv+4zHS+aqznYXDvujxzMOX
 8UvjBeZ0+iiWTlMJ2ka+6pkY7y1mSz45CokwnrBCpb/FKI+Obx5z9ZF2Ay86TBg=
X-Google-Smtp-Source: AGHT+IE0N9MPCcPv2JgPP3p+yFAfb0Q4OdWnBmU2iH0Oq1rGcrkcDojwHAeZYQnUTy24HL7ER+SkaA==
X-Received: by 2002:a5d:6d06:0:b0:37d:354e:946a with SMTP id
 ffacd0b85a97d-381f183524cmr2032727f8f.50.1731060707837; 
 Fri, 08 Nov 2024 02:11:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381edc1104asm4152566f8f.88.2024.11.08.02.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 02:11:47 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com, 
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
In-Reply-To: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
Subject: Re: (subset) [PATCH 0/6] Add support of Android Boot Image version
 2 and non-AB image
Message-Id: <173106070708.3295577.5479637179760743078.b4-ty@linaro.org>
Date: Fri, 08 Nov 2024 11:11:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

Hi,

On Thu, 17 Oct 2024 18:10:24 +0200, Guillaume La Roque wrote:
> Actually bootmethod android only support android boot image version 4
> and with AB image, some old platform wtill use android boot image
> version 2 with AB or without AB slot.
> 
> This patchset add support of both version 2 and non-AB slot images.
> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[3/6] configs: khadas-vim3{l}: fix userdata size
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/895b54998e57a5d099c09915341dd9312e0ad7a7

-- 
Neil

