Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A7606A31D
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WgJ+hyNW;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Gm0RNSmi
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEBCF6084F;
	Tue, 20 Oct 2026 15:07:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9iZofFPqZSf2; Tue, 20 Oct 2026 15:07:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC3936082D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792508877;
	b=qiBrtfrNNlpN06KsCzqULsiGtJenPviWH3AQMMtitnvlxsiQb1vnRgQcRrK9dMvmoxXj
	 qt5grh80AReXoXach6cMi/SE+BUESpfEbutZKGHfWBCnsG7SsJ/TXX2bklQGl27LwYi44
	 Sx5/xRu+pc+OPB+Q9GaWonJTVHRerL2ZZVjCBY++FWeqJnxDBw9OBCF2Sh2UigYRhFots
	 dU2bFNuDdvH96WXb5VkzPBij1so+Inf2VTze15UmeiPNZEy4HwtuRPXXXRV9v/KgGq9Ff
	 Hu4C0w73WnwOmQoRc1R71vC3EhSo2EKQ9UGsO38zuBbnPY6qJH4GhX48qmIXPryTMww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792508877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EpGtOu9utZc+dlp9ZVeiu2fN9Tbtg5nQIBfY3jCyFCM=;
	b=UUxRJ6BVXauSr3Uj27oI7+2XJIUOhIYMVI1boj6VVJNicl4AD4OqVinlB+7awkT5UPVy
	 jPlCwR9lBCJk/wo8/B5ii+KU+Dwu85cBfSICDovfln81CNGVwAdf1F1kxbIvRbk6zy8UB
	 MCQ/q11q77zvNfZp0PCM9UtPycjdlOqbR1n/R+ByCNFw9piZYmGBmDIG/c0xW+IgHfYRf
	 5xpDulYwI/jdqyPnze++YPPr7iA/3e4EZ48aSYl/xbVdfum9l0xoc+63ybqpuFbFPm8yh
	 WNbIpqr+qhSQ1mwSW/95HnHHAUb9J1LdTuMbpgNF+JR83Tp0zw8H27fwuwD2WEA2AZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Gm0RNSmi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792508877;
	bh=EpGtOu9utZc+dlp9ZVeiu2fN9Tbtg5nQIBfY3jCyFCM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WgJ+hyNWEuwe94V6QA0xT3cPPq3X9gyKjn/3O7/hkykmFvgC+e6apAJ5xGegugSwr
	 pJLS5DcJaaXztrq+h1YHsabHvE6ICO6wxueqMkX2RTcIeuTZAbYE1ZxfCTbc0i3Z/y
	 QBGIitMbYf9Imd8AeAO0KSGSpa5rH6JZAadQADBHEInN9R88UWjnQTIM7inT4KpoZ8
	 3sJGQerS5gg1+XL1F+HU3nz1ojl938uk+yKlPugp3JiAerKoXXD/WNENLKxK608bHP
	 PGzdGxKOn7SPSoEWjbcc1piglCZ75+I++9lTWsCiYAOTvMXXFYlCrxovFF8o34UU75
	 J+qsSvvqEFQ0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC3936082D;
	Tue, 20 Oct 2026 15:07:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 363E811CD
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27DE06082D
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:07:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jlZk8bjozKgU for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 15:07:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A027D607ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792508872;
 b=CILNDSwGCOFBTX2uNmU+EL6wFGV18BEtn9rd2AMnjz+Mvf5RLzTmTNSy7FxTpi9+BxQQ
 QpTWE4LzquQjA/Wg563l/Fo8DUEndaI67EsrrKrOFRuMXhw70+f02EJg/EPjzHenWwLf7
 rNgjwEkAKrepJB03D28LaPA1LckRumgMp+e1AIk26p0XlzRjS4bmjpQf4mfWyHptXQtWz
 2/K09Zdx97B5bEEYVqHViapihptp/C+cxdZ7cb6PEDIvgAzLClq7L0CI85hh2QK6RZdNq
 0rLW0G8CSvOhlQpyezYULERM0wWuyfnoMi3PSxygrM7H0hDoKQc9i8Z92tphV7nWDXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792508872;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=EpGtOu9utZc+dlp9ZVeiu2fN9Tbtg5nQIBfY3jCyFCM=;
 b=ScLCdG/aUd0hq7Z8Rmo5ppEZRHv4WdJzWAeIZqx4wwBdMmInJNADh1qPRb+yxLiVAqp0
 NIZXW6Cgl56sX9gwv9FnUO3DcSlWEq132IN5NB6HTxsVxq/EA0qCsEJFBi8NINyhI/2Bw
 0YQCRH/Z6l3odKI94/P2z6B1+d2Act3xvQyTeW85MyCZbDhGpp3ektREELyWIBZ2GgAcS
 oNHjhnbnMqNan/ej/Yk5PmnxRwIPlzUpmYKogAY9TYiZdOWeu6ZQPa3W2VKeT0M14Pk1I
 91q5cB8/1FIKQC+7vNZBAkI7n5kFlhY06aTxeIH9LCUvgr99S8BVH1FrZdU+OIwo2pA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Gm0RNSmi; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Gm0RNSmi
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A027D607ED
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 15:07:50 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so2840816f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792508869; x=1793113669;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EpGtOu9utZc+dlp9ZVeiu2fN9Tbtg5nQIBfY3jCyFCM=;
 b=Gm0RNSminiM0XJL9qt/0sJpK/SZe7Ipoj2Ckvm1zbdtt+QNbpDycGKkX9qGfz/97XY
 JRSwVnGQZdd5Pl8ypcgKc14JLyWFso2REcCAaZB7wdZeQjb+7+X0nrWfhGa1tYDL7+en
 Ce/frt5+kNEV6NOsXzfNasrjqan7iw9ju689iL2CDd0VFdcu+YItuD9B14pzUdivt1Jy
 BPhzwVpAe62OF5JnRsqHyUxwtw1Y4TfYNWz70ijOoAPJGsvjuMgfmI0VIEg7doCcXPmX
 tjzQOHJQMWgjztW3C5pQf4nDf8KDHl8z/0FnqDi9hgElqWo9UwjYjrhdYr8PJ9VJl0Hx
 tKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508869; x=1793113669;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EpGtOu9utZc+dlp9ZVeiu2fN9Tbtg5nQIBfY3jCyFCM=;
 b=w1/UQ2ImWBml1eXXyFJeci/HXw0OaT/FqZyHNkLowycmdirEEQSkWNj13+jtqJqfJt
 f05nToMMQJkgzIt5i+Q4/pK75xcbaHMWCHB1xOn07H5Snl2Co+FIFvqFmJYLoZ7AquB/
 yt4zs61Uo4/EXFPZikcYdc1mT3GoGO+y0sFhcCWoIXFGAmhMETUHPKFCh8cUMaYftlMI
 dNnBydNNVX9I9EbUHdIKYF9LVxypvPw6/rttVzAj/GVhbBQIG5m5KKluatq6mxKFhxrl
 kQtssQM2Pgd3VoGugI1aG3EhtbJCMuVJqbAmSR23yk6HW/t57tSr9iRH3gMqLkMWbBik
 Roow==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYzPuVpd4tqPMXtys5SC7bdiTf20VxU6bf5mh2i9+nVcW3LuOlJVDmVPjCIBm16m4jQNpvrD0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKXLFYTWefjpx/yjQdT6BctPDJ8leDW8ee5hrPP7vlhMlSP8GiB
 UBjBZbDimk87CNSb53hBEW+webApwBjytGA4Vu/HSab4Ley2+gbbeN6abt2xpk/f0NjIQzPTC/s
 iFNfZ
X-Gm-Gg: AYBFou1tftwdswPxfaZVMGsCgaS0/teT9lw89aKDIBlf7jo+UUTM8xIqsjonHKneqVF
 yiZ/i0kifmuo9AOpvFLw7wWKNXW5eEUHU0KoBMvpk8PxsmpqXNoSVu+sXOsPGJslekUoixh3l8N
 erwgRzlYypl5QeROO0I4MNTF+qo3eOZ27zBuBhjVCpjpsRy/OkXquLJ6ktahXyrF9G54i3Z79N7
 DaVSMjK8kp/XnzCikSPX5yxexc8kyBtrMwwXuMChVcftUqlJTH5juZIa4qjBOeSmSFxjWIt88Ab
 2bEs7MR4eww7ZDkQslidzNWBry4cYtycZT+MadxC2+F3l7tcA/15S/Ub49plM92G05D73HGbF0H
 MbJJH2vkNMEyc6j3Mvg4p6AJX6b7hiEppsG7azTuhcNhiDC+sNejXoXlWdLrQwLxg5xCGXppegU
 qRvzs3ng/ePSH72pgNT58F42d/eWfiwGXdtZTbU0hr4B7S1e9i6tj174EW7wD99PSBBRXpswmJE
 O0Rd9ykkY4rGkqG6xVj
X-Received: by 2002:a05:6000:4a0b:b0:48d:f5ba:fb02 with SMTP id
 ffacd0b85a97d-48e07fb05b5mr23505569f8f.49.1792508867908; 
 Tue, 20 Oct 2026 08:07:47 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8214cbsm6581816f8f.43.2026.10.20.08.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:07:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 05/10] test/py: android: Add create_gpt_image() for
 image creation
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
In-Reply-To: <20261020-test-avb-fixes-v2-5-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-5-997f8f04fd3f@kernel.org>
Date: Tue, 20 Oct 2026 17:07:42 +0200
Message-Id: <179250886243.3573513.9903551154853491203.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792508867; l=5395;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=MNJI57hvJVoyD3Y4YEyu9YB3nmiZe7CN401BJeTMbOk=;
 b=YKP8x5jymNqPDB8bkrUReb8brLVW5F4u9N56HSf8/bZje6fLm1ZrFey0KWmKfQGb2VqTyGPEv
 FqSeLEmc7OpAd6CBeMUqylKMSihU6J6IU8MgCst7qPDX75nkhvW5h8L
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> There is quite some code duplication between the image creation for
> mmc7.img and mmc8.img. If we want to add more images, this will be even
> more duplication.
> 
> Add a common function, create_gpt_image() which removes all the code
> duplication.
> 
> Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
> diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
> index 14dfd26fffd8..b5fede8ebf0b 100644
> --- a/test/py/tests/test_android/android_image.py
> +++ b/test/py/tests/test_android/android_image.py
> @@ -7,13 +7,12 @@ import os
>  import utils
>  from test_android import test_abootimg
>  
> -def setup_android_image(ubman):
> +Partition = collections.namedtuple('part', 'start,size,name')
> +
> +def create_gpt_image(ubman, mmc_dev, required_parts, images):
>      """Create a 20MB disk image with Android partitions"""
> -    Partition = collections.namedtuple('part', 'start,size,name')
>      parts = {}
>      disk_data = None
> -
> -    mmc_dev = 7
>      fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
>      utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
>      utils.run_and_log(ubman, f'cgpt create {fname}')
> @@ -24,14 +23,6 @@ def setup_android_image(ubman):
>      sect_size = 512
>      sect_1mb = (1 << 20) // sect_size
>  
> -    required_parts = [
> -        {'num': 1, 'label':'misc', 'size': '1M'},
> -        {'num': 2, 'label':'boot_a', 'size': '4M'},
> -        {'num': 3, 'label':'boot_b', 'size': '4M'},
> -        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
> -        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
> -    ]
> -
>      for part in required_parts:
>          size_str = part['size']
>          if 'M' in size_str:
> @@ -54,10 +45,6 @@ def setup_android_image(ubman):
>      with open(fname, 'rb') as inf:
>          disk_data = inf.read()
>  
> -    images = [
> -        (2, 'bootv4.img', test_abootimg.boot_img_hex),
> -        (4, 'vendor_boot.img', test_abootimg.vboot_img_hex),
> -    ]
>      for partnum, img_name, hex_data in images:
>          test_abootimg.AbootimgTestDiskImage(ubman, img_name, hex_data)
>          img_path = os.path.join(ubman.config.result_dir, img_name)
> @@ -69,55 +56,28 @@ def setup_android_image(ubman):
>      with open(fname, 'wb') as outf:
>          outf.write(disk_data)
>  
> -    mmc_dev = 8
> -    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
> -    utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
> -    utils.run_and_log(ubman, f'cgpt create {fname}')
> -
> -    ptr = 40
> -
> -    # Number of sectors in 1MB
> -    sect_size = 512
> -    sect_1mb = (1 << 20) // sect_size
> -
> +def setup_android_image(ubman):
> +    mmc_dev = 7
>      required_parts = [
>          {'num': 1, 'label':'misc', 'size': '1M'},
>          {'num': 2, 'label':'boot_a', 'size': '4M'},
>          {'num': 3, 'label':'boot_b', 'size': '4M'},
> +        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
> +        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
>      ]
> +    images = [
> +        (2, 'bootv4.img', test_abootimg.boot_img_hex),
> +        (4, 'vendor_boot.img', test_abootimg.vboot_img_hex),
> +    ]
> +    create_gpt_image(ubman, mmc_dev, required_parts, images)
>  
> -    for part in required_parts:
> -        size_str = part['size']
> -        if 'M' in size_str:
> -            size = int(size_str[:-1]) * sect_1mb
> -        else:
> -            size = int(size_str)
> -        utils.run_and_log(
> -            ubman,
> -            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
> -        ptr += size
> -
> -    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
> -    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
> -
> -    # Create a dict (indexed by partition number) containing the above info
> -    for line in out.splitlines():
> -        start, size, num, name = line.split(maxsplit=3)
> -        parts[int(num)] = Partition(int(start), int(size), name)
> -
> -    with open(fname, 'rb') as inf:
> -        disk_data = inf.read()
> -
> +    mmc_dev = 8
> +    required_parts = [
> +        {'num': 1, 'label':'misc', 'size': '1M'},
> +        {'num': 2, 'label':'boot_a', 'size': '4M'},
> +        {'num': 3, 'label':'boot_b', 'size': '4M'},
> +    ]
>      images = [
>          (2, 'boot.img', test_abootimg.img_hex),
>      ]
> -    for partnum, img_name, hex_data in images:
> -        test_abootimg.AbootimgTestDiskImage(ubman, img_name, hex_data)
> -        img_path = os.path.join(ubman.config.result_dir, img_name)
> -        with open(img_path, 'rb') as inf:
> -            data = inf.read()
> -        start = parts[partnum].start * sect_size
> -        disk_data = disk_data[:start] + data + disk_data[start + len(data):]
> -
> -    with open(fname, 'wb') as outf:
> -        outf.write(disk_data)
> +    create_gpt_image(ubman, mmc_dev, required_parts, images)

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
