Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FBAC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 13:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E90B88280;
	Wed,  5 Jun 2024 15:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i4P8FaCi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF37B88280; Wed,  5 Jun 2024 15:40:53 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACDA288373
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 15:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wjq.sec@gmail.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-250aa4e8306so2189620fac.0
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717594850; x=1718199650; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=07WmRbc7VuIHPqsU5zSsAHoqaxuG0iJE4o/V/V0g5Ps=;
 b=i4P8FaCii3yldySQDPTpKqbI7dptAun+doXPNfOMVAoafJI7UjH1uga/HmcKUSWLAt
 OO6RvMiD2blc+mtz+DJNUrPJgK9+CcjFRKpmE2FWi1zJwdk5Oo+8m9H16Uw5uQ9JbrS4
 o1f9EfBot61yxICz8iZ34mDCAFLdBvjRxbXwd8PkVx7Ytphx/QbQFjG6Orgc8k9cEEe1
 6dS3FE7z3yJctgR2SsTQOv7v+Z3jtDIm4GZsvH+Fe49rbe9yuV82086U/PIQrOL+fZ7H
 ERo1lR4q4nihfT2e7nbYByLawJ3IegtCrDictaDfTRvZOfu8NT079LyaB/86bxlrQq5H
 rxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717594850; x=1718199650;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=07WmRbc7VuIHPqsU5zSsAHoqaxuG0iJE4o/V/V0g5Ps=;
 b=hT/H/LYvkz4Xd/lG8j7Sm79Gwrb1WN+0pHdM7/084kEb97xj5QTKeT2LTd6NLfEMBh
 e6Yvcs1YDKUf0OLtsSll4z0djxvKsruZbzWiCd6xFquPQLa+kYyH+PWzhqr1m5WMfv1M
 gQIPOosBSXMqMAmof9sVVEkJHfNyizjs6oNfCoUl97mD95NIQyMgiicb1dKP8/txFkD8
 Izg2ayZTCnJfsHPrwhWxgx5FfKfZ6Aem7EDRa3uzlmiRTrLl/KpvS8TaXq2CD43jYEbs
 LWsQVLhPttXRcJqbKsvuNE0zpPORvL6bRDq/hjknuSXg7UgSbUHxkbd3p1KAb1MgaGsJ
 01Og==
X-Gm-Message-State: AOJu0YzKaXl1ZJelv6qrbR0qz1FMn2h4ib7+nXQV0ZkPEMu2BT+IQMgm
 i0gLTJvWTLSLb/0lFdN1g702p+vvvycdyAX5ZX8GZknrk2/VKfk8KfD688ugP/RIzO5qooTCnkg
 dYUEnYxuzTiaQSvWX+XvoVbMoQ++6dGhn
X-Google-Smtp-Source: AGHT+IGgDMEzAiIel7gOwPk28UlVQcpqhTK93Hy1kR0oYfly3o7QkK0EHlWSbVg/Dn9Y4QrLu4LwStg/4bxijubJYes=
X-Received: by 2002:a05:6870:b24e:b0:24f:e5c9:a5ec with SMTP id
 586e51a60fabf-25121c81680mr3056101fac.10.1717594849100; Wed, 05 Jun 2024
 06:40:49 -0700 (PDT)
MIME-Version: 1.0
From: jianqiang wang <wjq.sec@gmail.com>
Date: Wed, 5 Jun 2024 15:40:36 +0200
Message-ID: <CAMn3X6ODsCzBdpJC-PYAA_Y9WrK4eN84KatHGe-aEQB0yG=fZg@mail.gmail.com>
Subject: Needs a check in the device tree
To: u-boot@lists.denx.de
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

Dear Das U-Boot developers,

I found that the u-boot device tree implementation lacks a check for the
off_dt_struct field in the device tree.

In file scripts\dtc\libfdt\libfdt_internal.h, fdt_offset_ptr_ returns the
dt struct address. It calculates the address by adding the header address,
fdt offset, and a specified offset. However, the fdt offset is read from
the device tree and lacks a proper check. The returned pointer can even
point to any address, leading to arbitrary read or write.

Could you please confirm it is a vulnerability?

best regards
Jianqiang
