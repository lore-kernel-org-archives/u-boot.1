Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439ACC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 10:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9177E87732;
	Wed, 27 Dec 2023 11:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tGNRb1YW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F1388796A; Wed, 27 Dec 2023 11:17:43 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73DC487732
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 11:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50e7abe4be4so2137994e87.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 02:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703672261; x=1704277061; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FfqlfsCeaHtZa83w2TPhjjfDtOFzBk2Z9HfYUN8iYYY=;
 b=tGNRb1YWup5Vg+muDQGXlAAcrXcABcMPq94NBMQbvgtaGWDNJPVhSGReay8gW9JaBI
 u4/DKYGBI3AW1K0CM/PCsmHBTW3XqLcb7CD6okyvYJ97Fa/8LLmNAZf4HkU8CiziLhJH
 inCuRohAeclVB/lqyP9+p5EUxTg+Q1lWLc33C1ma3BQEKXxzJ9WS5qvjGFelQ6Z3mrGb
 WLzPBuw/nMLIh3SqoO/YwruVG10KHOXtOHt5Illj0ZKA8RZiHMrmb7Pa1CiNFuBRu3Qv
 XboITVELlYU32v/FmR9Tr4IMO8hrLjYJDJMcr0s0cIZwjUI/XWuCo/4lgUCaxDE8fNKE
 Clsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703672261; x=1704277061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FfqlfsCeaHtZa83w2TPhjjfDtOFzBk2Z9HfYUN8iYYY=;
 b=UHTyen6ybL30dcYF7N6OKHbsQb0yRzb52jNgA4GrUsvP1KCEJBbUE/HG4NqTKKOwGR
 li9Zk/832My2w/0t8Zp74TgJXgHza1DHmWIOr4ytujQ21ea3PflMW/KARLDLB5OcPMgh
 lGvTFCvr0feABgsMaThhpz/NcqboE84aoDdXn7XddN2i4hPXvS1C83xPYti+1a9hniyt
 lcjhdwR16y/8CQ44tFOVovxtTJ+GyBskwB7j0ZMDgHmrShZJMCHy3k15Fgyyfc8Gu/9w
 RNoXttYUEGaVqx5Aj5RWKxNo8+PHDjpZ06H2+9QflfnRbCUgTPhtpIXLC+3pFfxxHxM9
 iAMQ==
X-Gm-Message-State: AOJu0Yzdk1rWbPieLz9MDdcj7oI+mfzvZWEROyfJ8ZXGY61hf5smrncZ
 i3H6fs1KDtcL8q4l0LyLiv02LZCV6m2HRQ==
X-Google-Smtp-Source: AGHT+IFc+zgUVknfkW5Zfj7FOExxQR7oa7a5jpgIDwK7mUiMhkesCBKKv2TF8W+F5eRD4nXtz0kYpQ==
X-Received: by 2002:ac2:4553:0:b0:50e:1870:1ef4 with SMTP id
 j19-20020ac24553000000b0050e18701ef4mr3110770lfm.48.1703672260219; 
 Wed, 27 Dec 2023 02:17:40 -0800 (PST)
Received: from hera (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 fw22-20020a170907501600b00a26b44ac54dsm5195021ejc.68.2023.12.27.02.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 02:17:39 -0800 (PST)
Date: Wed, 27 Dec 2023 12:17:37 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
Subject: Re: [PATCH v3 11/14] bloblist: Adjust the bloblist header
Message-ID: <ZYv5wc_D1VgRcQKw@hera>
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-12-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218181901.337515-12-raymond.mao@linaro.org>
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


[...]

> - * @chksum: checksum for the entire bloblist allocated area. Since any of the
> - *	blobs can be altered after being created, this checksum is only valid
> - *	when the bloblist is finalised before jumping to the next stage of boot.
> - *	This is the value needed to make all checksummed bytes sum to 0
>   */
>  struct bloblist_hdr {
>  	u32 magic;
> -	u32 version;
> -	u32 hdr_size;
> -	u32 flags;
> -
> -	u32 size;
> +	u8 chksum;
> +	u8 version;
> +	u8 hdr_size;
> +	u8 align_log2;
>  	u32 alloced;
> +	u32 size;
> +	u32 flags;
>  	u32 spare;
> -	u32 chksum;
>  };
>

Aren't fields still missing from the current version?
e.g max_size and reserved?

>  /**
> diff --git a/test/bloblist.c b/test/bloblist.c
> index e6070041d3..a083259d0c 100644
> --- a/test/bloblist.c
> +++ b/test/bloblist.c
> @@ -78,7 +78,7 @@ static int bloblist_test_init(struct unit_test_state *uts)
>  	ut_asserteq(-EPROTONOSUPPORT, bloblist_check(TEST_ADDR,
>  						     TEST_BLOBLIST_SIZE));
>
> -	ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0x10, 0));
> +	ut_asserteq(-ENOSPC, bloblist_new(TEST_ADDR, 0xc, 0));
>  	ut_asserteq(-EFAULT, bloblist_new(1, TEST_BLOBLIST_SIZE, 0));
>  	ut_assertok(bloblist_new(TEST_ADDR, TEST_BLOBLIST_SIZE, 0));
>
> @@ -272,8 +272,8 @@ static int bloblist_test_cmd_info(struct unit_test_state *uts)
>  	run_command("bloblist info", 0);
>  	ut_assert_nextline("base:     %lx", (ulong)map_to_sysmem(hdr));
>  	ut_assert_nextline("size:     400    1 KiB");
> -	ut_assert_nextline("alloced:  58     88 Bytes");
> -	ut_assert_nextline("free:     3a8    936 Bytes");
> +	ut_assert_nextline("alloced:  50     80 Bytes");
> +	ut_assert_nextline("free:     3b0    944 Bytes");
>  	ut_assert_console_end();
>  	ut_unsilence_console(uts);
>
> --
> 2.25.1
>
