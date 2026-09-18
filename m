Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19347C982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C34A760C34;
	Fri, 18 Sep 2026 20:44:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fWiYNBIcWIyg; Fri, 18 Sep 2026 20:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D76EA60BFF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764244;
	b=RT8m04fEZmhSTcxIpVUR2ZW/Vh+RAx891ERGNVOjoxtLXMqR2HD0P+v8mW/Sy4qQhckU
	 SF94jhvdw+iQ20MO5wqMJcjYY3a4RTJU0AtH/e+okIhM+F8Gq0Czkn4I4Wex5/4RsmWNq
	 tk//mO4ipxZqCbumYzp7JxQKMLiQ0mi96IjGoGOvrq8w5hLjIURpPp1oLX3HouIrbRsTF
	 HmTF7xsb2rDCu9SIP77eCpGaZPTiiIEMtpQ0dYwG5gRomiLCjFfr+EeVpINQyhAGWGqZ1
	 okfENfPyPC8J5w+3tumS1133rczk6PpEGeZgn/dE8SOQOqu7wH1PyDkt6oNDj7uw1Bw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789764244;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=50ITs++jPFS56qcWEW8rW11RhUivNTqHauSXzl02k48=;
	b=W1+9BtZnGOYNqeNChjWcm/RF/H3hCCM3QWnSGsiMJYCHYv87+Go5qRTnK8APBDepf1Em
	 0EsADRi5mMF0H5Pb/jfOMDprdVwnsxWhq9UnQTy5O9vB2rO8vOn5L+BIxHFGEd7XchqIO
	 dSYb6PwZn56WgFANc7c3DH3ooZaV/3MFSNeB3XWT1mkhqX9SLjP7Xvai/HrBg3BqSH4LG
	 ZruqO3xL06lc9dPWMjMkUR81wGspA/tDSwe7pMvlefhbW/JTjvuOAE3YP07tPbAZvedUm
	 0n1tKyJwmFpGpH4mK+ZJLY223lgNCX4XyaKD31eY+Vvp/72zrnIcW6O9KuMlOZih4eg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789764244;
	bh=50ITs++jPFS56qcWEW8rW11RhUivNTqHauSXzl02k48=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lvIEJ4dfD1CxyWHP1e0+7EdJ+CSKVfjTk30GqmRTfYLjIRL9c4cNlzXzofULvcJKX
	 ex7lGTbAAuDfCG7y40jxsEsSOAbVZSB8Nyw4OEDCmt0do3TA+G9eo949Gd2GifCQNy
	 ceFUqFYYwiLCmDjx71YWzZJvFbHe3Dp1oZbayEM4Or9w+SyqodbC5wViVp3Cn6jAGH
	 J9RSC7HC/5HYR2GTNU818LzLDIRq2KTWFnoOykeYUxjuVgAFDUL/ETtNykZgrQcnPD
	 FAkpfeL3ZGbN37CaxhVkG47a93JwohjUy4LMD9ZPmopPGSQB65k3IaTmwZuzJZP7EF
	 n3imViI8S0Rrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D76EA60BFF;
	Fri, 18 Sep 2026 20:44:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 245C125B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 14F974006F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iRlXp7p6FjMq for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:44:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0B69240022
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764241;
 b=U5dLeD+RD74N+5p7gzO0fhhknQchu4jFv4wnZ/o2a9GkmpkSnkchylXeD4hupDyJKbG9
 biekgDMq6fXOJqm/aI+fsjcUZjGgsuxt55iMjUKWgykf89OxxmBGQ6jK2y4yfosKePlS2
 Hjc7Kf2v7f0Z6/iSiT0APIwL7wnVUuU9fjuL2DIz8/CNVy0U6I9jRe36wtEN7n1Uv0O68
 m27rbVa+oJmrayrLtHBRhk0OKqagWprCgQrRtLrqBy8gACBwXCMajbEi6SjK3luMRKfdz
 oOhkABWrngiMytb8QvdboaDmxJ8P5zxlmXpRqI7+tfE2cg1/IgrgsLvMhAbE9Q7mHHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789764241;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=50ITs++jPFS56qcWEW8rW11RhUivNTqHauSXzl02k48=;
 b=AQ3AT2NvBG6UEok2PyTSUP9/WkeDpUc92oL0NP/QPX6Xpge30QRxajBwNbS9ny8TgELS
 NwPYzfyCZQtE6DvjOhzsIJGmZ9N1NxK6cMbQux0/yLI1/ilomki8suJFjGOAm3a1uvxXH
 6lNbpJjcFijYKI/LqkF+qfDqY0f/u0ykCyiGwgIDW3jgHHVYIK4JgLo5Yfu6bndAuZKOz
 7fgmpbvoSgq7YKTFirBAywehS99at/FDfV8fT4CLryqGCE/RK/8SbNEVZTqL82Xhf+Otb
 fCx4MPydlU0SkskLZnsgB3TaSUsb8jEQNKq93Jw7fn6G/+IfpypxYePC+Z684JwBunA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=U3yKk+E3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=U3yKk+E3
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B69240022
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:44:00 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a6056c2064so1494734a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789764238; cv=none;
 d=google.com; s=arc-20260327;
 b=OkmXchZHERUgfW5uwLd0ne1uvZXkJuP3+Lm/Xdf4tvOKk7Jz9alpBvqahIElPt+mTm
 Hb+4tdXa5P6z7dvoyCGADJdm9hiaAEydlGyq4Lf/PmSZhvxQpMsIn1S2+Qg3ryq6wUF3
 r4CLKtd+3kPZcE9EbXYmm+czd7AKCYYINNPBqSKwzwHs0B4kZvy6/+GWRtqraqIU4kvx
 AeB9JWH56cxHTQs08Ng1foWITvu7wbyICtMCO4HMZcZJktdgat+CvjR4n6gYy7c14n/U
 madiaHhpZci2jkw/yWF/InWTYH8hMaYM7K4L5FcX0SXjTkO4ZleSB7/mMnq2KDKyIV9N
 ETTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=50ITs++jPFS56qcWEW8rW11RhUivNTqHauSXzl02k48=;
 fh=Cmjo5ehg42OouXuEVZygPD4p3XFIPQRhs6t+vdZ7Zes=;
 b=BR6abarRAVMKJOB61ktvlxTLERCB7YsIbd/wHbmrHVhVlLX4wILFg+vY23PWPo+r08
 vSuBveu/VHWnYdUAepn5zHPtkQMZFojQrLRNNBlw0lzA9ZMPa355cInk65rVnTpg2uzJ
 DGXdh6qPAWzU3PoOUamVj/+yLXaz5thJ12x9u7Q0fP+th/y2XOKJgLrEuLmCa0c5kIdD
 Twwk1tq67qNNi0iTcRytkyuUdev5gBrD/ilIF9lJ9+kCGT6gqAuzfKQBaXUNM7QYBk7v
 xZxnQWGnsYfAQayr0ojNCU78ATSqI7dUn486lubWFiRzixU4VBJS+18w0IL3gsRz0CF4
 sl2A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789764238; x=1790369038;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=50ITs++jPFS56qcWEW8rW11RhUivNTqHauSXzl02k48=;
 b=U3yKk+E3VHCOnMtXRQCAr9O40gz2AI8mAM6obK0I+nWk/lqytmDjCP+OgUQJfrFLpm
 ocVqDeHfuyFAD/443bvlQfQ1QOa3+yIb4oCqbp2NfV/n43TXWx+MX1buQTHAsotb1PZR
 SnGzzovL/JXnGe9QKvyXMN4LqB+twvdR7gc8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789764238; x=1790369038;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=50ITs++jPFS56qcWEW8rW11RhUivNTqHauSXzl02k48=;
 b=SeZxEk/Wce+gRN1Oc9ExP0rXK0QUtcJtRzbMbpT7ghGrgqJO01wSPbQ6tf7Z+tk9C4
 Xt8l4sD3KCZfbK3EpjqoMe3aip9qFGGiY9dDuVVrkCWUjpHiOX48fhcpGcUgeubbpVhc
 lb6Kg8HvC/KzgHXl4UKr7GUgNqLHxGxsjoFIPtSSFtt9cijp6xYJHsUv8+SnBd+/9BJc
 fEvhgrdH5PXk13SRcU2xISF3akKcuueXKqVsHR5CyZuHJo9cbyv8lLYF86USy9f1AtJq
 1lgaLaoR03/YwpP9yn6Qk1Vmem9Q+zm9xcXJ/YK7EsXoZQx/++1HasHRL0hrALc0IiX/
 TwSw==
X-Gm-Message-State: AFuF++kg878Duj3dppZZ/1qytM8GCL1Nlb/QozUvb+yVdosziR70E9u9
 oNjxq2ByZjwyySD/CAjHvui82ePCY0TKan9G9HxTzMMYyafor8XYlJpq2kbw3rg7/eJUfylWQeR
 fDxDzCSGrwBuvB0nTfj2uNuTsjAtkikMCwie0D/PKH7QMNr9u39QGU7GFQ84=
X-Gm-Gg: AYBFou2PvpG1SXVvRdwIm6OCO2Uea6f9nmt4AUh3qVUYUVILOyimSlG4VLwITReyVn4
 yorYYEGJTZujFfEcQIMJ+rzRg23+Lt6UlS6PwU0bOzhweNyKqUlXbsQjrew17RKBZ/ysHspTsOU
 eQIe3riaEwk2MyzOUGcVxCCyRqvzudUHYznB1YnB9Bcn+BG0I6CML/Mx5S28n0F5TirL27pfHfS
 Z4PoXt9sFSIEnAbqjIt/Gp1f3REcCIZ4dUyPlSh0DWpV4ANX/vNGUdUooZNQL2Pmoxq4j+lrwQ0
 wM78DTXv9zqr/zvSW8H1AGC+7TjulZtz8Tp10chShXOB912sDJSdF4UOZw==
X-Received: by 2002:a05:6402:a0c4:b0:6aa:4865:55df with SMTP id
 4fb4d7f45d1cf-6aa5637bc93mr2411300a12.26.1789764238529; Fri, 18 Sep 2026
 13:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260912124454.13578-1-aristo.chen@canonical.com>
In-Reply-To: <20260912124454.13578-1-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Sep 2026 15:43:45 -0500
X-Gm-Features: AcwNN1Xx-5OtGviTX6J0CbIT4Dmc0A6H7Fqy4TSz84PV0V_2vkC7uX78ZwtfIp0
Message-ID: <CAFLszThi6tJ+aCJvEkOkf1J3BNjzvKtmEoRETm74bdgS5rCnEQ@mail.gmail.com>
Subject: Re: [v1,0/5] tools: mkimage: support shared image data through the
 image-data property
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Aristo,

On 2026-09-12T12:44:46, Aristo Chen <aristo.chen@canonical.com> wrote:

> The 'Shared image data' section of the Flat Image Tree specification [1]
> defines an image-data property [...]

Thanks for the thorough cover letter and the hardware numbers. Also
for taking this on while I am on a patch holiday :-)

Please add user-facing documentation under doc/usage/fit/ describing
image-data. A short section (either in multi.rst, since this lands
most naturally in multi-configuration FITs, or a new file) covering
what the property means, the resolved form mkimage produces, the
encrypted-sharing rules and a pointer to the external spec. Right now
someone trying to shrink a multi-board FIT has no way to discover this
from the U-Boot docs.

Also we have example files and this feels like a case where a new
example would help - see doc/usage/fit/

Just to check - patch 4 is closing a validation gap opened by patch 2
rather than fixing a pre-existing bug, since data-less images did not
exist before image-data was introduced. Would folding it into patch 2
make things easier to follow? Either way is fine.

Regards,
Simon
