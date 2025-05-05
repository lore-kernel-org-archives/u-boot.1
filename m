Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89289C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210B08212B;
	Mon,  5 May 2025 15:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sH++qWGk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E4782161; Mon,  5 May 2025 15:53:05 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B6C6801BE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so27938855e9.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746453183; x=1747057983; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GeRLDSpqrkQfexUXPq/BUa7c5pcomdC44kCDlM6uGPY=;
 b=sH++qWGkKeLScF7Vx4L02MNIqJmFeYLeAnOayHleZfbdImt6DXTaF6FG0ffFhmtbBq
 ccKPBvGygpNs1vlxqpbxaL5iyX3V8S51BaBN0Ei8akmkXJGPwfd1PRysVHKbeoQRysrR
 HzyM5POR25xkz5cvXO3RIZMtjt2VuLCZeknGoiJiUk6eTyqUSB+q96rL+YrGrJgxIKHK
 ufwz651HTh0jZjvlPb+tVn/vgyRbOFtHsjjS8HPs5tLw2wKZoe1z2B3tFTYMcSmxFShs
 9UVlUYmBdhjPL0IPRzD+rTHKUKCQHdpzCn3mvSiiEPVpCLdPPLcPzFPHKy/j1fTiL/x2
 hDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746453183; x=1747057983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GeRLDSpqrkQfexUXPq/BUa7c5pcomdC44kCDlM6uGPY=;
 b=VmIRHGLrrJ0kUySWmLiI9O8uncZmedfnbjfskmYnZUgnRLQz4tSlC79z84SfbyMjBK
 Z0FWuMMi8/QvlX4rdZUNdmGDOZ7oidR8/R/kAsFaoiCwhVCBpRjV41kng9+EJjaxFnL8
 AyH+ZDGX/+avHBIIUiyUODFeSYghEkYFMzhdTeJ/h1GT98C58Srq78h8WHVt6IHUMazu
 R+t4Kgx8CpCGED3p4jZZ3O2Mk5b0Fn7Pc+ia25dSpIzqYzfI6MEff2L9gXI2zqR2RB0m
 415VgapMhnrWr5PIcXi3/M5Ts7aBBttIiw8rda9QNQRTbuzMo/AsOXYNmsJFHou46B0X
 y/qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmoV6Ss+jdhu2xCmuLxq4xd4YC8y6unI125AorlXS48amE8TyO6gk2AHZvgDu+RR5rSp35ufg=@lists.denx.de
X-Gm-Message-State: AOJu0YyJ3gL8DWVlQGvWFd1fOYy4gqqfNLk36mieoVBo6MS3P4M3hmbL
 Fbv8Wai9RqA+KhH3MH0l+NH7ymlKwdW3kZ/8oVRbOcrnLLZj4mXuXfYMCH0dtLY=
X-Gm-Gg: ASbGncsefC1nXZp/007Y3bAkTbKo2amygPYhjImWivOXmaMH4/byKwoi+diKj7PjACg
 vK8K2YVLOS50XH90GQaq1O21ETuweuGdTIGQ+5+QTknh8Tpweh5S7JYebzayOPe0Xwc8VV76fiZ
 WsQPcVzBLy4vhC0/Z9Oktx6kVjGO4UKlQiFO8g9NQB+s02gaDeUGekwFwPS4gNY18w2tsaPwYeP
 +XnBq97pskrM9+tKkJQJg0OEpg2LmD7rmgoyytw0CiY0iSd9nrnlG3vKubJtF47rnLbcRcbiJPv
 OvE4BySv8utSA+2kgBdocUcPwRE+kaSH7bak3RaOeaeHAM5WDcbi7rL831DwaWBLfO4ffKKhfzJ
 zwLNL0GdmOA0Cs/44IV0RD9l8CAcj
X-Google-Smtp-Source: AGHT+IHvop42Po9rbgQyuxAnw+MVmHojCza2iIwdrViuxT6Lm6QrcUlbNHqGFazTE69/bnCfHxQSQA==
X-Received: by 2002:a05:600c:1c8f:b0:439:4c1e:d810 with SMTP id
 5b1f17b1804b1-441bb856814mr90538485e9.9.1746453182943; 
 Mon, 05 May 2025 06:53:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7c51:fa5:e32d:b024?
 ([2a01:e0a:3cb:7bb0:7c51:fa5:e32d:b024])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441ad870ae0sm123789105e9.2.2025.05.05.06.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 06:53:02 -0700 (PDT)
Message-ID: <acc2176c-a150-454c-ad46-c118c97f12ad@linaro.org>
Date: Mon, 5 May 2025 15:53:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] test: allow multiple config options in buildconfigspec
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20250503133155.55412-1-heinrich.schuchardt@canonical.com>
 <20250503133155.55412-2-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250503133155.55412-2-heinrich.schuchardt@canonical.com>
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
> In some cases we have alternative configuration options that supply the
> same functionality, e.g CONFIG_NET and CONFIG_NET_LWIP.
> 
> Allow to specify all of them as arguments for buildconfigspec() and execute
> the text if any of these is fulfilled, e.g.
> 
>     @pytest.mark.buildconfigspec('net', 'net_lwip')
> 
> Update the documentation.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/develop/py_testing.rst | 24 ++++++++++++++++++++++++
>  test/py/conftest.py        | 10 +++++++---
>  2 files changed, 31 insertions(+), 3 deletions(-)
[...]

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
