Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5C7E7E652
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 16:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9265F86BE7;
	Tue, 26 Sep 2023 18:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HOw6GiMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC078648C; Tue, 26 Sep 2023 18:46:09 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 360E186DAD
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 18:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53406799540so5690374a12.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695746767; x=1696351567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mhBOOmvQg6w0qRVjBa3gs9U45cRsPABcRh1/kwD64nI=;
 b=HOw6GiMcxKP1rtS2xCLqgBrhCM11AXzqJ8L5NI4bqjpTxCCnFMqFeyaNVJfGOVRP1k
 AzZQa6WQiVP+QdagyZ1ILh0AhH7O972AI9SnnLR0VkqdC/OTkF0LAit5xjKy9FyXyBzP
 8U/ZkXX+Njmm5/n4FIRr/crD8FiTxTiYgfdGZYZ8OGegm4USgRyXuCg0jVIPw2nhjeeQ
 Ydveok55g5XAq+VpFIIZZtPLu0tWoNaOc/B1iwejltmBS64PyIIhI4A4pL+n4RGhTCxK
 8hyXYQ3Lw3ufXjoZh9HZV1JJmu4OgcJ9+Bed6wmVQERGBnRc672mIbTU3Go2YlQhEbtg
 VJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695746767; x=1696351567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mhBOOmvQg6w0qRVjBa3gs9U45cRsPABcRh1/kwD64nI=;
 b=YW+5uamNlDFcHvSP4fmuvzdF7nWDl+iGOeuZagXOFILNasFQcySHoDq6TV2HYghPdR
 381hfDnsWj4nNZyAZpulilcfCdw1RRnnyUto8rYa9UJHoIY8K8oFH5TONd9cgvXYOVRU
 BH53QeuRs+JmzWOe/lqpkFxXTB/wc+jxed2rgw030f8zHkYdQsqJdTXMtQu8b7dXugj/
 Sq2isKg75Ix2L4spB0oV5Nirq0HljXmtAltE2WUq0ZSg0as7Y9K6x8RS5KWc9pEAUKgZ
 E5CTkzQ8ey9/R1nSMeir23/8wUTsF6PPy65kr/WpOTnPziv0Y6UzGCINmvn0eFqecy3R
 vVow==
X-Gm-Message-State: AOJu0YxFHWWH05Iov1j/YeOgXwipMZ1hfxw59eBWsCgJ/a4rqFFNNPTI
 FYrt0WCa1yspk+Dzk1qfK43zPSn8wLu8hhnWbs8=
X-Google-Smtp-Source: AGHT+IFjrDQtLDakJpXbE/QOdIxdfA/iIHApdzW91EIKRsF+Nu+pf5yTuC8Dbo25X7SeMCd74F2mQwqvCz+rbqLIe9A=
X-Received: by 2002:a05:6402:1c8e:b0:534:77a5:84cb with SMTP id
 cy14-20020a0564021c8e00b0053477a584cbmr971824edb.36.1695746766572; Tue, 26
 Sep 2023 09:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230925202935.118652-1-seanedmond@linux.microsoft.com>
In-Reply-To: <20230925202935.118652-1-seanedmond@linux.microsoft.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 26 Sep 2023 17:45:55 +0100
Message-ID: <CALeDE9OAdJ0cidcKNprH=Ghteafmb1fWksW3m5bc6zw+cocegQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] BOOTP/DHCPv4 enhancements
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
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

Hi Sean,

> In our datacenter application, a single DHCP server is servicing 36000+ clients.
> Improvements are required to the DHCPv4 retransmission behavior to align with
> RFC and ensure less pressure is exerted on the server:
> - retransmission backoff interval maximum is configurable
>   (environment variable bootpretransmitperiodmax)
> - initial retransmission backoff interval is configurable
>   (environment variable bootpretransmitperiodinit)
> - transaction ID is kept the same for each BOOTP/DHCPv4 request
>   (not recreated on each retry)

Might be also worth looking at the series adding LWIP support [1] and
see what impact that may have on this too.

Peter

[1] https://lists.denx.de/pipermail/u-boot/2023-September/531716.html

> For our application we'll use:
> - bootpretransmitperiodmax=16000
> - bootpretransmitperiodinit=2000
>
> A new configuration BOOTP_RANDOM_XID has been added to enable a randomized
> BOOTP/DHCPv4 transaction ID.
>
> Add functionality for DHCPv4 sending/parsing option 209 (PXE config file).
> Enabled with Kconfig BOOTP_PXE_DHCP_OPTION.  Note, this patch was
> submitted previously but this latest version has been enhanced to
> avoid a possible double free().
>
> Sean Edmond (3):
>   net: Get pxe config file from dhcp option 209
>   net: bootp: BOOTP/DHCPv4 retransmission improvements
>   net: bootp: add config option BOOTP_RANDOM_XID
>
>  cmd/Kconfig | 11 +++++++
>  cmd/pxe.c   | 10 +++++++
>  net/bootp.c | 85 +++++++++++++++++++++++++++++++++++++++++++----------
>  3 files changed, 91 insertions(+), 15 deletions(-)
>
> --
> 2.40.0
>
