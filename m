Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC18C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 13:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE8C88A2F;
	Fri,  9 Aug 2024 15:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d3u8BTnM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A086388A2F; Fri,  9 Aug 2024 15:31:27 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA9A88A0E
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 15:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-44ff132ff9cso11295551cf.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723210284; x=1723815084; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NxB1CH1w4QWyXcUgNUIndxjtQ6DwGTVIFy9hzNvDAg8=;
 b=d3u8BTnMePxgV5lli84XKZhiw+FPNOFmC7mirpjs1Dc2rtwypHjyqxu8ZOaTz3ckGc
 y1ENkr+s1kjp+JIGXwOarIOctDmUOvM8tAwXXk9fS0rmmqtw3cnP/ZfXVw5jEGjco4Ku
 NAIWAlzr5Z1bypp7w2Y4sLV0xFYoGVCaT4w8dE/T63sMhjMSIpIVM47kHnujVfVyZqGh
 NG7FuBcUjoDNUHvt0jbkTkIXrx7APPjFnh7MFlunCFl/AvP+XCT+UmyS/R9Y2RmoFKlv
 nLYm0hw5Vj4N4HTHswJrvcwFdFuh6GvVA3orze4gJ9kTvy/pWmhuxTlW/1avlm2WHvn1
 kaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723210284; x=1723815084;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NxB1CH1w4QWyXcUgNUIndxjtQ6DwGTVIFy9hzNvDAg8=;
 b=O65+HwSVUykzrMMJT8LQOz/wrhOFQ6eSOMFG7tdTCEFFCBrwjluXBI636P3FC6PYUK
 iSBzKru7zb74ODxzhFNwEafwb7BdxsxfRVfXNTdcB55jHgvW0gH/9qmfTlfaco0BZtco
 fxgAoAIfskO3wY8j5RPkLJRP+R0cx1bT57JtUXGTVIAVmN3N6YvBVqA9JALN4xw6ft2W
 mUIRs5kgPVwIAO0qEnPQw+JQaUIsk5iSidleGb1HCeMxJi2ryk/NcLz1ktIeQZYYAbbr
 mEVHMAHnVK6ICU3UfKBZYWS4SNqxUK+t9JrR0eXxTgnjFh1a1evbBEzFgNODWtDy2J38
 GKug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBuQBtwdl6ZBemL4rm2Je78rtqNN6agccenYQwyxBm3Qz4UN+h3xilTIwd3dFAXWhlM1eViQokjqOOWAmzfKEGWI6t2w==
X-Gm-Message-State: AOJu0Yzpv+2hD2xxaw20WizTurPJGciC/5t79OKPbrr5wJZj+4uLtQEP
 4O5NLTgLTzzXqNTjSQ9GlwAx6mwqelbbVlprGPMKik50A/2W3Oyt
X-Google-Smtp-Source: AGHT+IHy2wvR3Waqizt7l9SDNYZCX9E4uDpZs+tWHtiJMiI5RrIIQdu14ipCQJqEX2raszg9y2PEEw==
X-Received: by 2002:a05:622a:4011:b0:44f:e9df:2a24 with SMTP id
 d75a77b69052e-453125c9da5mr20805361cf.32.1723210284026; 
 Fri, 09 Aug 2024 06:31:24 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-451c87ffa80sm21633861cf.86.2024.08.09.06.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 06:31:23 -0700 (PDT)
Message-ID: <d2d39b09-6070-002c-0e74-54f5311009f5@gmail.com>
Date: Fri, 9 Aug 2024 09:31:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: pinctrl warning on sandbox
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAFLszTj5oQwuMDbd_AXbYFsuQ=Yt+MzWeEOvcbqTuws2D2CPOQ@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAFLszTj5oQwuMDbd_AXbYFsuQ=Yt+MzWeEOvcbqTuws2D2CPOQ@mail.gmail.com>
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

Hi Simon,

On 8/7/24 19:17, Simon Glass wrote:
> Hi Sean,
> 
> I was looking at [1] and bisected the message to this commit:
> 
> 7f0f1806e3a (refs/bisect/bad) test: pinmux: Add test for pin muxing
> 
> I'm not quite sure what is going on, but could you please take a look?
> 
> Regards,
> Simon
> 
> [1] https://source.denx.de/u-boot/u-boot/-/issues/2

That test run is pretty old. Does the error always occur during EFI tests?
You said in IRC it occurs on current master; can you send a link?

--Sean
