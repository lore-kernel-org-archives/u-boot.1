Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7794C4452A
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 14:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9804846B4;
	Mon, 20 Jul 2026 16:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="MCXR+4r2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3A5983E76; Mon, 20 Jul 2026 16:10:55 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E4F80517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 16:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=william.bright@imd-tec.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so79963425e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 07:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1784556653; x=1785161453; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZG1B5gCUcY5y0qYVe/WEesmvIkgiIy2XG3A6TY9MdmE=;
 b=MCXR+4r2n3m7EnNW4euYLTKPAYFu5XX/n/g+9Msh9v1PdUkJsphSiy2tIve08TmL3N
 m0vygGz8IiM4NPlTwp2x1XGBtNrHEFpIP1gIbjMuv3WAX96iLKsxO9RrW5J2qy2oM7f0
 NRPQVPUgwa/coPHWL/75iQdQd0OBkVgt74ITdDSG2qwPQN/qCJiwBQCnFUy17KF6urTH
 nuqlQ4rwieeGZQYIN4J3CUsXM74wFSPJLRgak1IoBKJ31bGtw+Lc2OSVXokualpvs/MA
 8u/4GLhiJPo3SWZpEippMiPzghg3NCFvqWx2tMpCUSA7zE/m+wh226oDVwDtOuWqntTN
 tUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784556653; x=1785161453;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZG1B5gCUcY5y0qYVe/WEesmvIkgiIy2XG3A6TY9MdmE=;
 b=XfHFvLmcJ/ZdZEDAgH14lsyrU18nhgL20R50Nw/55+oYnujyMhDB7mZrJpO008A84e
 02kJIBXz5tFqiY9GM8JiAP3jKfEE2FgvtSrRMtph61Pn+Tw7XQKlXU1bI8tngRm1vlZ2
 lW3fwhRzgXUKKmydJnc5fTXV9wanXaLfvOvBX6bU9A1JNQ9WZV6X491MyQLFRbh6iZQd
 /xM0yaZoCEiUEdfDPqbDj2nCnT5KajIohE1r22XgEvNvA1QoK1+4ZpyX+oE1lRXiquV8
 qelHaNU+wBqQGTZfHkMjFhalla1jmRCqLZqkTHqEbWJVNMJsEIGu2SLQU+Ze77Uj/Waz
 nN/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOTT3qT6sjcukyyesZ/Hy9z5CIl0u/SCqDUOC3eEBToGHyV6W9MeelUkLUhg0vVAU8AvCaza4=@lists.denx.de
X-Gm-Message-State: AOJu0YxTREBdb/3Yfx7uqsoLySo+cH3YB0QJ6XHX6OlachflwzOM3CKr
 CTBdKmyM9wjUUUiK2VleUns3x0FwloBvGo/USDw3qoG8RbFvQJwsKjyPvksr9pLN6I4=
X-Gm-Gg: AfdE7ckRhKKyFC2W2TEAEIiqKA7A38VUvnelKJBtmesOeuvglVa9zyPExon3VzN7RqR
 qsVGZbUXtRihmxsnwNHjM7tnB3JB3c4q120zvPFM+TaDOyi1cFnPCEYaRVBeSkLggIqzBwCHk6/
 2J67MtP8qyIqm3YGEm49MQaXDPBRHXjkIeTVoFINX6V6e7/q+l6a0TcEIM18SyNXodzGFllgA9J
 3Y5IOp0sS/t0H27DJYToZa5ssJe9gSpomPsxrRTpoPvnNr13ndb75gKCKgzDW/3/br9qM2vvBOr
 jZoJD0+E/khIblectkDouMFK3befgAZOqXBOWVqXyre10lUgZ3mM5AkwhRhdrt/Ean4/4d/tWLT
 vn/mFlLowF400FVZCuzaxRHCo5RlUIXcfulJ9Kz1J5Kx9TE4Ku3LnYwckz24G6MzSD1a9jftgdv
 ttB2PSC/vaI4MKlVf02OGGKZ79rz6hNMNHlPwStS6OmPMmoaOn6MyFRpjlQMN0lF57RhRkSKaIY
 a/BZQvOzCKaGYS2
X-Received: by 2002:a05:600c:4585:b0:492:437a:a653 with SMTP id
 5b1f17b1804b1-4954a50b811mr151330015e9.26.1784556652957; 
 Mon, 20 Jul 2026 07:10:52 -0700 (PDT)
Received: from will-Legion-Slim-5-16APH8 ([82.71.135.85])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f6b85970esm24124319f8f.15.2026.07.20.07.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 07:10:52 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:10:50 +0100
From: William Bright <william.bright@imd-tec.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/3] doc: board: qualcomm: document SM8550/QCS8550
 building/flashing
Message-ID: <al4savp1b_c2EhFi@will-Legion-Slim-5-16APH8>
References: <20260720-sm8550-hdk-v1-0-84f077937303@imd-tec.com>
 <20260720-sm8550-hdk-v1-1-84f077937303@imd-tec.com>
 <9d437ed3-aacc-4e36-a49f-aa7f2931a468@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d437ed3-aacc-4e36-a49f-aa7f2931a468@linaro.org>
X-Mailman-Approved-At: Mon, 20 Jul 2026 16:32:59 +0200
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

On Mon, Jul 20, 2026 at 02:20:00PM +0100, Casey Connolly wrote:
> Do you think this could just be folded into dragonwing.rst? We're sorely
> missing some nice broader overview of the list of supported
> platforms/boards, but since there's a lot of overlap here I don't think we
> need to duplicate the instructions.
Hi Casey, since the SM8550 is marketed as a Snapdragon Gen 2 SoC, should
I still document it in dragonwing.rst? Maybe I can add a footnote like
the following?
  The SM8550 isn't considered a Dragonwing SoC due to the addition of
  the RF Modem but this documentation can still be followed. 
> Please also rebase this on qcom-next from
> https://source.denx.de/u-boot/custodians/u-boot-snapdragon and add
> CONFIG_QCOM_GENERATE_MBN=y to the defconfig (instead of CONFIG_REMAKE_ELF),
> that should actually spit out a ready to flash u-boot.mbn.
> 
> You should also be able to drop patch 2 since the memory map should be
> parsed from SMEM automatically.
> 
> Thanks,
> Casey
> 
Ack all of the above, I will rebase and test the SMEM changes populate
the memory node correctly.

Many thanks,
Will
