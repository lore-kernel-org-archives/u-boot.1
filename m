Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC550C00523
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 15:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0355863DE;
	Wed, 20 Sep 2023 17:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="llZwY5R+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7530E866D0; Wed, 20 Sep 2023 17:30:20 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59EB6807BC
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 17:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68fb98745c1so5315724b3a.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695223817; x=1695828617; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AWmsDHNz5KVPyQcrDC9AVH9USqnmsvsPIzAmth3ADiQ=;
 b=llZwY5R+8af6vrJ7bXNEmIZQJq5zcQp3ibhoGniDvz9h43Y0Iw8DVSLeeo4XaVLSwD
 ENIugWx91tSEnUL/WRiLs27KIMjfOJ05Yf43HkXBNELCDwvY8ZvMSpoKykD8oEorvIOi
 JcLv0Cs/DXoyRG/5pVPgPGG5LRgVfu4gmITDjwujSOC1aKBXksyR72Hib2Onqmz2vslC
 ERYIGXKxgJ9blsJgnED0E31jEeaWtn0SwvLK8/qUD77XbWeBKF8UnJy5FjZJ/kV+fJ1b
 Y+YD8p64Xf1KjBxqZmkUPzyDyzEuSrQZ09oMN32OvKDDpapMwMFp/fRT7hq3fo80BTc3
 DkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695223817; x=1695828617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AWmsDHNz5KVPyQcrDC9AVH9USqnmsvsPIzAmth3ADiQ=;
 b=w0NzjdcbLhn+PN/LyOXmUhgWGZP3hT7inOXTH5NRacxaUjivGWzZmONnhMxOFVfjeL
 0OI1dqUWJuLWYFCXyHyOOAUbQjYNs1CXFaeMmYCMjMq35ftkuIoGlqOJZp0vJLZzvN9H
 boB2xx+TbnkOrabyi2FB0WTwoRCUs9yPVEV4sjPcF80xt4SQZ2RYw/TQK3s/1PsUlFM/
 PenN2wufIco/7ePp4RobzHSAslx7hYlgBGu9Dr5Tgf73hxVdALdNe+SmOfVo6zxM91lK
 sIAa+Yv+LGlPBSZhRDGELrU26yD+9l1aQ3zhaLaXP5UclbxHYD7LsxveDYLn54js7LV+
 uYyA==
X-Gm-Message-State: AOJu0YwP0KW258fmATTFUjaNYq1QCAsziuqTSL4FhPeQHQTsxrFUTwzu
 kr+TiX5kWX9o0VmV0zPQ3e3/20VkPzHwLvA0KKFzrw==
X-Google-Smtp-Source: AGHT+IFdAMeKQjk51naz3yvfrn/EkfE633eAeo4eZqt0b90XbStES5X9qedQJJJDL3FBM2nVq5j+/83TTlJCl+hX+ws=
X-Received: by 2002:a05:6a20:258b:b0:135:4df7:f165 with SMTP id
 k11-20020a056a20258b00b001354df7f165mr3234550pzd.21.1695223816663; Wed, 20
 Sep 2023 08:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230920084121.1248590-1-masahisa.kojima@linaro.org>
In-Reply-To: <20230920084121.1248590-1-masahisa.kojima@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 20 Sep 2023 17:30:05 +0200
Message-ID: <CAEfUkUKpNyU9h0Y16u0NnfJzSWcFVHAsiE_HdCQt+O7X8h65Rg@mail.gmail.com>
Subject: Re: [PATCH v11] Boot var automatic management for removable medias
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Masahisa,

Thanks for spending time on this test failure! I am not sure why this
cannot be reproduced in my end, but I totally agree with the rationale you
analyzed - my previous patch will just add boot options whenever a media is
probed.
Thanks for adding the changes into the pytest.

Regards,
Raymond
