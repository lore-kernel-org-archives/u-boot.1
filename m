Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B58EC3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEBDD829CD;
	Mon,  5 May 2025 15:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TwvKT4Jm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D27282A1C; Mon,  5 May 2025 15:53:49 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65562801BE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so26263515e9.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746453227; x=1747058027; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xew3Vx/utN7QHTzIBS0EDP8VFC0gsHRRf2JZ1UCHt6s=;
 b=TwvKT4JmWHGUHiwKcTwTmCcwbPFkj46vX+/zo+bxlWBogtC8mnsuFc0Z8G4tiX25f5
 rwsZlkEdALR6wUFScGAh4mc7eH98GIJcnW+nYP21D6/vztkBb7OWJzNa+0MoER2IasH8
 jeg+sHJjuHYx0RIKdSxRoWfjZm4HbF40aWYwb6yGZiWsAfuzxl0iEJBTeHssvqP+gus5
 lLefc03nq3bDauCtZpg+udddx1sSSu3kGGRI0+4i7OncfURI18TI6KMCjYuMZknNfhFL
 UoaaPvjudrejgFC4NCnSGKM/ETO8nKkQYzh9uxxv4atcZFbRBvt8bAkAdOO64X270S1x
 GZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746453227; x=1747058027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xew3Vx/utN7QHTzIBS0EDP8VFC0gsHRRf2JZ1UCHt6s=;
 b=vXz/qiNiqBHHuiANWJEnlrGvyDm9cpuMWA1pAYVt1pzUHKxuBHxGWkHo5IF89mmKse
 NxnKfJ36VAW7/cdI9uHrqQMbNYSgZLA2AUVGllNMQR9J5i7U8GVO+rZ28VasnoV7do9z
 /eI+FZxfwCsqnGgf1MRJ9+iiLoyHmov8JJIr92Syj9RptomjXflnGviSRJbHzZPo+Xch
 H5bQdfy3pU7fFMszVApdm3MYfNPnqaJaiWQk0Q0xr9FJFeosQi+09unv7VHcoke+VdBR
 NNTurRuzNeIcMftnoD8D1AvjNVZpk7GzZ4O445SmtyX1SCewtO6lcgy0E/U0lDQcboVk
 UMJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMWzXUidxaJunz4j1O6V0cLd59YF/cZOi4GI0GI5AhMAbCLinH2CVwiLzf0HXDtd6sFhDvYPU=@lists.denx.de
X-Gm-Message-State: AOJu0YyFsrAVjiivuYvQQL68BeBC3LfVtcAfmCYnFrjb+8LTuH/YG9pf
 aBil3FzacE9btB3x14B3kIqwOzPZpd88375Wnjt8ZfIAD6ouACSmc7y23M192A0=
X-Gm-Gg: ASbGncu2spGxWy7dzvfJkx+wmapW5tThl8vd9lboekulpCA+WlwHDlWW4+GrCxmVdMe
 c8ja4UJ5vOe5g9//0eqQwfWyc1iEGu3HVWS6qLEIV4Z15Z3jmMCWl/sa+7Jt89EH/k//CB/nZTa
 lM9NRIn60iLEBqOMYPswOQ9e86816VtsTQaO4j8MpyGKVV/GvojXpyVvTf7po0gmGKMO8sQwttn
 dFWDmybf/WAyBVmfswdqXp8lxzEvtv8cHjPNht+jzSv5wZnlUV0U57wx8EVAWqkzD8qK2AUyoak
 Bkwy5cSbBi98hazdndGhG+bIG0G6L1MUSmsI14uF91vVAK44WIIG3zaofuSF9fl7UZqWW/3AvZx
 iO/GeeszDYvaW5rFXzw==
X-Google-Smtp-Source: AGHT+IHcu/WuS3aHUE87JjJIZH25+8yjdrndJAszBRaZtivC3XdQS99/mPvjTE51TPuouKbUj7FHzA==
X-Received: by 2002:a05:600c:500b:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-441c48bdfb7mr56247535e9.11.1746453226676; 
 Mon, 05 May 2025 06:53:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7c51:fa5:e32d:b024?
 ([2a01:e0a:3cb:7bb0:7c51:fa5:e32d:b024])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8992b4csm137757735e9.0.2025.05.05.06.53.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 06:53:46 -0700 (PDT)
Message-ID: <775e5d16-bd61-490b-a418-161ab0999677@linaro.org>
Date: Mon, 5 May 2025 15:53:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] test: allow testing with NET_LWIP=y
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20250503133155.55412-1-heinrich.schuchardt@canonical.com>
 <20250503133155.55412-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250503133155.55412-3-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
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



On 5/3/25 15:31, Heinrich Schuchardt wrote:
> Adjust network tests to run with CONFIG_NET_LWIP=y.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/py/tests/test_efi_loader.py | 2 +-
>  test/py/tests/test_fpga.py       | 4 ++--
>  test/py/tests/test_net.py        | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
[...]

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks, 
-- 
Jerome
