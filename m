Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39560C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4862640A47;
	Wed,  2 Sep 2026 13:36:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KVyC1BIYVZ4d; Wed,  2 Sep 2026 13:36:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788356178;
	bh=gWIzqBPavdQxT0SgX4BqWpvVG+QivgPTD7kYEVY7Ws0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wjiaQn5q4RUEds7OwhCYz/BMEYw8bJsDh1SL4NMZawYUFleg2hWe0h5aF69JnVZuG
	 dn+Pbtpn6zdC8GqzBqXpYdvhy8l/JH/rHBbXEx3Utxf8xMQ6YfU9hYYElDjAay1C5o
	 VlKJEgE2Owhdnjca82lMilebxSkc+JX6IuG0f6tqCfVBrDVCKsORBFmzokq60SI51t
	 xyjFoOyBrMXX0Fz33zxyuoDjKZl3lnkh6x5sDxHhX1dbJkcRfQM1zrVL7D1I+95z/j
	 GbqUEO5BBtTZeR9whuxV5Ndv2S540ZaN6FlDQ7UCNv4TRh7dTEzf1BQ6JIeNB+7dd5
	 6wJLN62FVZs9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 232A540834;
	Wed,  2 Sep 2026 13:36:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22FEA1D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0949D40834
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:36:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H8xAXPn_2F-K for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:36:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=i6GZEAIp
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDEC740821
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:36:14 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5b4a0e5aefeso1051461e87.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 06:36:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788356172; cv=none;
 d=google.com; s=arc-20260327;
 b=fMw65P8+aEDN0qSn5YCuru1bGJpYJdnx0BcNjtK+P12EI5Qgia95S6APO8AnDI38fM
 9rRe0wYL1WSqozzHXw92xAowl4DdZSde/zVysvjQsis6mRpS0OFE7edcexfpoyZ6DCNc
 axib/yps5KFmL859hzttEOkf61NeXg3BCLc9fBAhfGB++uTXeHHwliIPDRzDByUjAAfx
 9yccQpq2tsY9oQx/WuN9zH7eINhAVKcm1qpJOQTC2CsT+D3Ealu6dciYYke7jX/Ry4gZ
 DKeEeqK7A3FfwVO+5k6RGRj2M/CTGnpykEdaZ2VKA236uJc7ncmtE/IFMQRtarumxP9N
 HDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gWIzqBPavdQxT0SgX4BqWpvVG+QivgPTD7kYEVY7Ws0=;
 fh=zNeyBnjrAysbtUfZgFOB4wi+2OEqssRe0T1kOhGUqqQ=;
 b=rduonPIikHX58tchwoaXdJ/UmHqfGzSwKGuc/i6hsoQTiCLaruJ3CiWe32uUO5s0iQ
 zVMmcywlTxOK4NJidZv++LJFepKO2rWiYekAFaGqO7lEtAnDTFwPd7rhA8/KkndLQZYv
 Doa8LnyG1+m9bOOXAua54gb30aTcGy7wOrL+oTEQ1+P7S3l+1SvhAmXABCQeEVPUlG62
 xwDj0gLXIO8Dbh7bD9KCz+WvewbXq1E6iexaByd8O80QfNN+BXbMbh9SD7Liq31r2IGB
 dmy1Vx5qWZBXcTzPM60saNhoUYtNMo/zy/fQpiRgAxW+yLzoQGY2/WDA7iww6LJGVGRT
 zASQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788356172; x=1788960972;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gWIzqBPavdQxT0SgX4BqWpvVG+QivgPTD7kYEVY7Ws0=;
 b=i6GZEAIpUDRtO2WFxmltiVCcCry2p+HfdHMsXocm7uauiZa6w9XUrDn5mnOspy8P1A
 pGG1hsijq+8x9s3RwKbqM8/3gQB/86fupYcDPOttNUumXvwJpekC8O6qW5yZvxlLEZ51
 f6HI1Q9QxF1SjVrfgtx0x1Y3F+LgK+Tox/4BHxv6mxi3UDzzXyVQXbbcNm5CAHqaePWw
 EjK+X8+MY2l/lYBkyh5vKH/8ELXevu0pFn+rMcy3OERAo0lNa6wZKABTWnW9EtCSox52
 Utpm1KEZAajToskDrRHgTvQFQ0xexiFJyjkNxilg3rVA9vkB9nT5+9sWi9UJRQ/NBnYW
 3Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788356172; x=1788960972;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gWIzqBPavdQxT0SgX4BqWpvVG+QivgPTD7kYEVY7Ws0=;
 b=cKytLkcKjuf/fsfdhb2RibOmdbkhfF8vMCWxXDw06yIKfcA6eTpSC9STJ8Q7XubE5k
 eyWqqT+Dq1W3m02/rV5xq6Z72L4X2ra5S9rWloeRY+xyRi9SbPLe1i3G2JuU3C3IYN09
 oUOb4g4CybJghA0StS9HZzVhzGdE/YQjOhMhPS5LVcz7LajfIPyKULrrMdJmKajlJS5J
 u0xsM/WVRbAHaX6oDSeqjWL60ZJBEaGXWxnjYJErnghtxKO5cu/Eqbm0juE4KwPGVtQb
 apkq6+N/VHgiiJPsud9ychvU4tT7bbhQNUNQ3E6BU2F4d+LzHUpyi7KbfjlG9MKdOy7I
 tMqg==
X-Gm-Message-State: AFuF++mFwWTSKBAZxOkJ8L5Dsei0VyERcDtXBqdQQC5+Z/0eskUIMf54
 +efEdE9rPB9RQ/b/V94V1j5M5Q4J8ru7Kt/XeSz4bwwBXdErsfNOIkPAV88K6auCnBwNS2E8HEp
 OKb7UIZJD//zHUjIO/qcEhyht7OJHN+iQbtG3
X-Gm-Gg: AYBFou2Qor3SsBk/z1ZalvEfXD5hYnoTOtoq7oPW1ehbpKj7Ue1yRRQBQHq75YzD2Ob
 N/OvArEane/TxwajI18kCEsN+xA+G5S/FTvsJ3eRI+g/5CnmQd27DHr38sayIaasDWiyi58dmgI
 t/IjGC1QP5KdYWpzF0hVXYvjJ0DmfdDPRGc7bW6JM+I5Qn+gtG/5mDUAOEN35PYv3aLXRVB5FvI
 POubnLcLWnqWPpZsblvXUFcvh9FWQb823z8ZGkxOmJS00Cysl3+1/Br8/TsGYaQGDlwWuxZzIqc
 kxGeVx3288rBvWc7fx8/z7bm/CUVijpdfvOlk47LYZlK6s7ZcqqTX2e3H8FofdyQVS2tNR2rRM5
 OssNs0hCR+Gp+6gnwtT6Js5GgkEsIgU2e
X-Received: by 2002:a05:6512:4010:b0:5b6:4ae:5b83 with SMTP id
 2adb3069b0e04-5b6087f12ecmr1575886e87.33.1788356171869; Wed, 02 Sep 2026
 06:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <PA1PR10MB9387AE5B8B61E648D45512C7B7B72@PA1PR10MB9387.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <PA1PR10MB9387AE5B8B61E648D45512C7B7B72@PA1PR10MB9387.EURPRD10.PROD.OUTLOOK.COM>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 2 Sep 2026 10:36:00 -0300
X-Gm-Features: AcwNN1V7iRzrUp06jfAOJMZmT0tstHQIPsYQQ9jhA3XioZrYLDodxkO75zuzYPk
Message-ID: <CAOMZO5AXvzB9qEwD7Y5NjbEOwpJ36GRxz26Uwvriqt=pEuf_cg@mail.gmail.com>
Subject: Re: Bug 32bit truncation in mmc_get_env_addr()
To: Torsten Rupp <torsten.rupp@8tronix.de>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Torsten,

On Wed, Sep 2, 2026 at 10:10=E2=80=AFAM Torsten Rupp <torsten.rupp@8tronix.=
de> wrote:
>
> Dear U-boot developers,
>
> I found a bug in mmc_get_env_addr(). The internal calculated offset is OK=
, because that is a 64bit value. But the returned env_addr value is only 32=
bit, thus it may be truncated. If the offset for the environment memory is =
beyond 4GB as in my case (Raspberry compute module 4 with 8GB flash and the=
 environment is located in a small partition at the end) the value is trunc=
ated and the environment data is read and written from/to some other locati=
on which very likely will override some essential data there (in my case pa=
rt of the root file system).
>
> To fix this the signature of mmc_get_env_addr() have to be:
>
> int mmc_get_env_addr(struct mmc *mmc, int copy, u64 *env_addr);
>
> and in all usages of this function the type of the return value have to b=
e change to 64bit, too.

Please submit a patch:
https://docs.u-boot.org/en/v2024.07/develop/sending_patches.html

Thanks
