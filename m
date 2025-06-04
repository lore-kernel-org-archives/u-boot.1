Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19A5C5B552
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 09:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D11882103;
	Wed,  4 Jun 2025 11:15:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RGlsmU6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F299382B07; Wed,  4 Jun 2025 11:15:17 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C2081FEE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 11:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-602c4eae8d5so1445398a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749028515; x=1749633315; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AOf0NCXCI2K1CXgqzoHDUfvzKfE1JktPC8o1XJP7zXg=;
 b=RGlsmU6cqNvaT830eZqAuJC5XYyNMIxYubAKcy/75K7dCBgRIUwGkx3l+fjNrNiw4j
 qUNJiO87npnreS7XT63B+fhh3peQ8asTKPXSoXeFyKIicINxtjoBFu2XbmlhobiExtJb
 s7yQLozcYkRSXjchHfkFyyI192Un6och4pNM9pWCLBffaBQtiBoho7BQ8RYCxLjzCaro
 7B5PGddZulnqDgne8bLIe5krEx7sxDyuKZOpY88hTxZC3aE80X4M7JgPn/tbgchBCUbq
 j8klXJ1Nyjsy9uDoCdqzHk1COj3/cw/ECepLlATouZSz3XKW6c/qPi3hTjeegFbOu9uN
 5fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749028515; x=1749633315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOf0NCXCI2K1CXgqzoHDUfvzKfE1JktPC8o1XJP7zXg=;
 b=ewLgOP6D4iY+U9Rt53E37qSQrGJzNZwLnH4KsUY8RllkqDVwkl4SsGDM23pehlUb2I
 KBV+BxSXmseui7nEs+4mDJEZqRYLN9KdM7xIy42xXcY0CpbAe+TWyBJH6Ks97rSz0dIr
 NURybI1chQlPQ2UOR923NR1dfokPeKAOf7QyuMkiUXR2ZQYmSG5jXerfDh+8rSK/76Gp
 z6hjYxwxawSQWYUi3IAQe+x0WMYS6PZOqdxuTQt7C765BcktHMNpACHnBvlB9tu8bPRZ
 vUHDrmOFARjERzldTrZrm93OIYziUV6zgMZm3yTbt1+vbVMhuhwF7zHl4nGPFToG9Qlc
 eyTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWra+54Oolm288/sZwYtbdVqwx8yBodFLCAozFYXh1nhIpswaiwLDhSSXXauu8B3GlCvLBTCWA=@lists.denx.de
X-Gm-Message-State: AOJu0YzL1i7VFu2Jc3rskiBeEAgaTUgNQWbLKNKp8LX5FaO6W8Ymsaya
 ICTHLrpy0FQUoEtem+bqHhfb6jN63oCi7B4rfx2s99Uw9VYafs6kYhNVTW6LIlga46s=
X-Gm-Gg: ASbGncteOgqlviMlbTH6lF8/y5j4W5Wkbof0VE2ou1d7pRERAhqqRKzZpd2xhTs4OqX
 /6HV3+fv2SnT8g5kHyVM1EFAYgYhMpd5/XiVWcTHTp6UoaHKpIWbLpeGcv6eys2Q1QxCZfI2kjO
 pVvfa1QVtZhCpU74OfhS9RzyfinY2ob2bj1d5n28K/NycUlQD0OBZbbptCjEcOr0PIbR3E7Y1Er
 pbAZQqVqns3BR3Amo6vXOy6Ez7SKLzRREVtbioREALqWQQdaJepDgCh+CKH31ILHg7L2/PnyDzW
 ROLXFZjycxxse/WRIvdJz5By2gcQSpM8KAV+Xbjk2unzbs9CyXSkUghbZXnClg==
X-Google-Smtp-Source: AGHT+IFpBc4lrjh/dhFsHLJBTf0O6TL87vhcF2xrtUZAiMgaJyRIT+wtKqPnO7N8+lVgNaHOoeNCHA==
X-Received: by 2002:a05:6402:2745:b0:604:efcc:bf5c with SMTP id
 4fb4d7f45d1cf-606af9e2d1bmr6392385a12.1.1749028515533; 
 Wed, 04 Jun 2025 02:15:15 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:68f5:c95:7678:409b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c74cdfsm8817252a12.42.2025.06.04.02.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 02:15:15 -0700 (PDT)
Date: Wed, 4 Jun 2025 11:15:13 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/7] tools: add mkmbn tool for Qualcomm
Message-ID: <aEAOoYg_wFvkI66Y@linaro.org>
References: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
 <20250602-b4-qcom-tooling-improvements-v2-3-c7d19c0d4a8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-b4-qcom-tooling-improvements-v2-3-c7d19c0d4a8b@linaro.org>
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

On Mon, Jun 02, 2025 at 06:10:54PM +0200, Casey Connolly wrote:
> This is a fork of qtestsign[1] with modifications to integrate with the
> U-Boot build system.

I think it would be good if the "library" part of qtestsign (cert.py,
elf.py, hashseg.py) would stay unmodified if possible, and you only add
a new frontend on top (mkmbn.py). This would simplify syncing upstream
changes in the future, e.g. should the v7 support get introduced at some
point.

Have you changed anything meaningful inside these three files? Copying
the original files back in I mostly see re-formatting at the moment,
which makes it hard to see what is different.

Thanks,
Stephan
