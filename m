Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D167ECCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 16:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A3880422;
	Wed, 22 Oct 2025 18:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Rlx9Mij2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 274FF8323A; Wed, 22 Oct 2025 18:03:01 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8FCF8003E
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 18:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6D2F33F853
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761148976;
 bh=BWODj2WO4F2ZEL4oayyExnwSHUjSQjAWKumYuxyz4Nc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=Rlx9Mij2mxLUOc7C4hZ4os2UtqIqj70CDdPCsfIFsZ39eAxarbINKrFbEW2wApKm3
 31qo7uExh1u13m8pB4l/b3sWMUQwaRGuq3GR6tcwSEvkEkcIBOlUHro9FLWPIRSTwf
 HF/JWpi6zd8VBYrhcV2qsTvNka0Q116oyMI62e3g+0+M0MsLV4yAIYI66QgC5XcmDj
 wdSqLUKXXCO3UsDtpHLgTckgWdWJjJOtzpjX98i8yOWr5aeSXvAdM0rtGrehnfSg5D
 vIfjKVycKZ/ggDvjVcBpxgiTFEnpI6w5cIRetoACvI98OTL9MEFAxszCM33sIhXTM5
 vKGJsGmPo/l6kzVZghcuh7MsWSAkl/4nfJsdq8kx1QtMWPSGrhn6Ez1LsY0suYRRfO
 oIAwcjxjLxB2q71z7Y5m1s+N/HRYcYZOiz87dpKMy8Me73CFaMQwP81vq/z+n0Y86e
 nTAz4LC+LvXrNmZH9zxvGpS7bUo1Q5nVG/m+tdB6gu0SenXqo1lfBNXLY4RFcmeLWB
 S1+KsbBBjsMvco78BX+qZ/HPPLFHIk2FicngjnU2xo616t7/qlzHE/RQfM0GEcLoiF
 sG3GRW9r1eoVyDA87h0jIUW+pYQBpSetM7uNwcPPaLH7NzENJsnpxqkpah8DSyliFq
 t7L9ouKXZWl6dFpg5hiq4AI8=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-428566218c6so556369f8f.0
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761148975; x=1761753775;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BWODj2WO4F2ZEL4oayyExnwSHUjSQjAWKumYuxyz4Nc=;
 b=F4M4eQlcUYtWGmT4k837cJ9B0dMzvvHyzFbDFHkZSlc0ffqdbfshiJ+092AzMu3Su5
 4VtzYTQsKKIPabD5IjkydN2ruLcjYqF2+ZSn5CijyGyTzTsZ9izo071MzZEpZwuGGlVX
 Ml4p1NTeRmS6xO8tm2WWNV/HAnHgZlQB+36faMIE93fFprFqGfN1i/CFML5/mLXdMhEW
 NMdB+ao0pJ3zOLOpxBw1QsAgrdwzamR/lHri3lnJU41QuVshuTMppWfRvS6dX8+8bDii
 wL3zD4AMz20LnuuOA1AlkpwjLzpaNOoxrZqU8gRz8KLWSxuLb6Tme930EO2N2qVc/YEp
 5rNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyj93xArvV7NirUNeUq0mRJttJue3sT1jvj25TkmUwVGOvkXyF96/oIldQu3yp63Ig/wCYoAY=@lists.denx.de
X-Gm-Message-State: AOJu0YwMzZ3n4qoslfHS9oESiTHC78Sup/JLrARjGv2qle4FqUjpoVcU
 FjMJ6CUTb8Qu5XZJtmJKF85Y8A6WogT1jEmjiXqzD9rHy8wieyQhLbXnReRY9i4AQeeA6s/mV80
 GVNH11bH1ZPTQ/uThR6+Iisae/EyCF4rojAOgM6q2w42oMmxcwL+QIyQm8DL3PDfYWLG0mu8=
X-Gm-Gg: ASbGncv/NNREgZuUb7VOgraCTMgcq5+dCYKIUFst3wfDDZp5tgQ1Z5l9taGwkumVHje
 ojryoQo0KulqABnkncC85nWs9EppsxPw0pcERgBOWdOqDwfKTz1TO9qqvPcC3jBL2myffFUFuo/
 42zARm/5xlrtbbQ70CnarNyYlmdL69NXbt6zEKMtq5rralf1I6H5iK+2QijBT5GZ90w35+D8EaU
 pBP1aLAfVRSHum+Rg+W0CBfjCbn6bLJoazyi6rrvailmC4hh7kFdLi5G7RBneImexQw4k6frL71
 N52bKjFpPyiVFLivLhw/Y2e/xg+iFCrjDfBjBnc+ajRLVw6ChuDr/N0ov5d862r16kddg+yjK9w
 HpDjdtZbVHC+FxpuZS3+Q2S7ZElc9YcW5cZwMIq4ysoDDcVywkiv32qAZmLkT+KQ=
X-Received: by 2002:a5d:5f46:0:b0:3ec:db87:e5f4 with SMTP id
 ffacd0b85a97d-42704d83588mr12678278f8f.7.1761148975237; 
 Wed, 22 Oct 2025 09:02:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe/Crei5oWP6+HoqM6XOaE07xhnIoY05Z67C66LSDF3YIWKGETtIJKifUARJO0zyAMm4nlYg==
X-Received: by 2002:a5d:5f46:0:b0:3ec:db87:e5f4 with SMTP id
 ffacd0b85a97d-42704d83588mr12678245f8f.7.1761148974818; 
 Wed, 22 Oct 2025 09:02:54 -0700 (PDT)
Received: from ?IPV6:2a00:2381:43b9:32:b9f2:94bb:a8e4:6606?
 ([2a00:2381:43b9:32:b9f2:94bb:a8e4:6606])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3affsm25539219f8f.12.2025.10.22.09.02.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 09:02:54 -0700 (PDT)
Message-ID: <96e01de7-25ca-42e6-acd8-43ee0065d05a@canonical.com>
Date: Wed, 22 Oct 2025 17:02:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] makefile: Fix recursive makes
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 trini@konsulko.com
References: <20251022122317.3943103-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251022122317.3943103-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 10/22/25 13:23, Ilias Apalodimas wrote:
> Since the Kbuild bump to 5.1 and specifically
> commit af1a9935708a ("kbuild: make -r/-R effective in top Makefile for old Make versions")
> the recursion rules have changed.
> 
> 'make O=/output/dir/' as well as './test/py/test.py --bd sandbox --build'
> is working fine but anything that recursively called the makefile was
> failing e.g 'make tests', 'make qcheck' etc, which calls a bash script
> that ends up calling the makefile again.
> 
> The reason is that the internal 'sub_make_done' variable of the makefile was set
> after the first pass and the output dir was never evaluated properly.
> Reset the variable value if we are executing any of these tests.
> 
> Fixes: commit af1a9935708a ("kbuild: make -r/-R effective in top Makefile for old Make versions")
> Reported-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thank you Ilias for resolving this.

Test-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   Makefile | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 2402f9313d8b..8cddee3c5a96 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2666,6 +2666,10 @@ help:
>   	@echo  'Execute "make" or "make all" to build all targets marked with [*] '
>   	@echo  'For further info see the ./README file'
>   
> +ifneq ($(filter tests pcheck qcheck tcheck,$(MAKECMDGOALS)),)
> +export sub_make_done := 0
> +endif
> +
>   tests check:
>   	$(srctree)/test/run
>   

