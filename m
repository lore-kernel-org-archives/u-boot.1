Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC87CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:15:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 825EF80F23;
	Mon, 19 Oct 2026 13:15:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qCJlXuiYhfY3; Mon, 19 Oct 2026 13:15:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91FC580F27
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415729;
	b=rYxy+lux5NKX9RWfeo8a1caARPLSMX9Tba2E8AyoJKfDxKNY1t1W2MMm7aw/6sGJSHMg
	 YMPu9Vd4ZFY6slLEoIXJwTmeE/cEA0s85BU6seEPynpE/0rduvlF18IeYRtnK8zElncLU
	 I0BWjN4b07mJCQnCKZucFIW1blwnaLmskiEIP9Lt2y4okKj8nbZ4AiFwbasMObmwf/CWa
	 W7B51fOjQi3K6e6IXgBrf1p3yNyOTo3O9KaQJfkfWPDiHpRrrDJ1YzP5hCRVspGIx/up8
	 /NGbDpAv/7Rksf/f1VRVQfM1fO+0YtxPexRnKB6zsv8e/0WuyraR0GJVbPcYaph54Ng==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792415729;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Fl/KSelGy7uLwncy6cVURMGn08mO67EZQGkohQwxVEY=;
	b=tWdxehbV1oWPTG25pgzNY1vMXRe0fFgnSs9LcSZ4qJ4chhdaNy3hl7MSeuHEuPEysaJx
	 NJgHtz9Z0ctyPT2cQWIKZHA7bbQbXZadn0PrJtQf7XvL43GwsRf9Vy9U82aLZzjcUpZsa
	 B/njwvyxjPz/4CC/4grHKweb0Rw2loSX5HB9HMc6M80QJ5e0TD85ztXpRBx4rzP7F/oHP
	 +mVK02r0OSABmF6g7EYh3tHgoojHwOU3BGtECPBwT98QEnCpxmb3ymlNx97m3+upepFet
	 ZjIyP77LdX0yuDFiz0SMfBmjLLJvb6mHEDkThU6ywonMUaBJhO2TlWi9un9U9JoMmJg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ltgX6U2G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792415729;
	bh=Fl/KSelGy7uLwncy6cVURMGn08mO67EZQGkohQwxVEY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X9EQSvD6bl8MRJgSZvKhAfQtI8XbzAlzs2VbLiLnXzSTxIUA1UzRy5lgf8iFzfVCa
	 gGmW28ajm9TJpCKHSN7//TJIow9wzBZdUMHW3WW7Yv3fyrTMFEDATuBF2KWpT7NrjX
	 3P5FkH1vR/ZbAoMi4PqQSBqJkkqH+PmOQAB0qWsshdSNNRi2ec7OAZfsjvdxBnvM1r
	 TUOrRLCIbqsDP+ud0yKuUipTsjVn6vkwg4S4LVpukwFSyvHi04lWdQjy5bMpI4H+d7
	 J/Z0fScsQ+ft88xgNxInGSVHLWr3+OZdFBy2P9y6LCc7rRg+u8g4ByBg/HbgnUHs0J
	 SIxbvbrBlfdOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91FC580F27;
	Mon, 19 Oct 2026 13:15:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5363123A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62F2280D5B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtHUelGBLCS7 for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:15:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76F7780BFF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792415722;
 b=E6VogWBbgIfmgSNvGuNt54JQhnsl6uQTThDTt+qV/Y8K1u08FM4J0SqJ65Hf9Kq602gy
 O/xWn0WeVw2fZxrv0aiZJtpIo1aQSBCjasZzWuOR4ujWJ2LM+K+9/ss04rgw2i8ElNBTy
 dHjwlhxDUHIBf/RGQLvZk7GhaXE4YeuwtknHFQJGgweEGkXuC9CHMUUyqEhRHToI7aanc
 JaM7DeRpaM+MwPwplwVJDUfD5duXxCQdeNfV0lvPb7tPz8/uGdQkq93zT9ZT6JYZEDQXG
 41iVONDIN2HHk9hvW/itl/flFcBp+I/8lvFjI0c2zANPA63gXild9NkEO0Yz3Mus9wA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792415722;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Fl/KSelGy7uLwncy6cVURMGn08mO67EZQGkohQwxVEY=;
 b=PRIhJWyrKl0SWjMUhNtxljsVcFXEFnGphQJS4U/6dLlPm6oU1iB0C+PfCN2DpLc+LZxS
 fSKgP2EkUA4iYXfY/oWqLHAv171wiK13dsm0Eyo4p+pAJ7tDffj/HAWqdJ2sPtEG7SwmH
 DEcgszp2f5au4gmmVxfe3GHsVYzyjifQy0xEY1hgQLeDNDQ74CJD/e6xiBostfpRRLuPJ
 BvBAlXKLLRvMH/sO1fmtZF448QZE8ZXR0slqYKzSVKRjnJYVW8k5h4k/ihUptHrzjFW4E
 ZJBBdiB8EeLRSUcaw/r9Yo6jDO7atTpVZU5ds9vATV5tUff7KX6+DxlQhpVK6kFZFBQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=ltgX6U2G; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=ltgX6U2G
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76F7780BFF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:15:22 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so2790462a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:15:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792415720; cv=none;
 d=google.com; s=arc-20260327;
 b=dTsVPCkIxMPb2Ekp5LkZPNCuPjPzpVMDDffEuzfzU4uKDJjB7sDYIrxOqt+p9y/72W
 3/+WWGhuoY3VEj5NZc9cttQ+/rWTZAwdYXYJykGHg7vOObZU7X/mu5jrwfV0EUxVv8bc
 7V6N6wLiZN88MiJO4ly3b0pd/WEVcwOO2HAW8tlqXXQQiwGGVaXmLnFHv1eg2gprCuUq
 mg3Bn05LyEeYBx6kROgPHjjEg1J9n246TzMhHO922xbYNjsm604T0GCWnXpbPSgeS/70
 6O1J+zITILBYaJltb3tll3W1egLOB6Bj6gz66OvDGjLi1Gxs1wRu1217bL2QnUCD2LMm
 2hxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Fl/KSelGy7uLwncy6cVURMGn08mO67EZQGkohQwxVEY=;
 fh=l9cAHj1sTpx8/nfW+MIwpcL3JtMoUhNTwoF60Vu+x/0=;
 b=GAM34hzQZKJYH1PRVpTJ/eW1x0wSiKVugCkzZcpY2S7ASiAgBZ+JklF5yVdTPbQhkd
 yOT1g12abf5fPyKUsOyIPthRA/1ZPo3ulHxPREsLKmHfrNyDS3hcmGV+MqouhZAP9nYs
 3j/JEjH3TrICCkykVh0hp5ntznHc3vsC8muDq4eL60fBLYErNhRcfq/3nWSKrGk4sr8L
 5yk2XNOMXWv48Pzkf24nv6MjAwSO4VUxi7ChckSa2tsVgCDY+NX50hlAx1++9EtkvF+/
 T0LlctZTaP79bP17r31E7bI8RUR+bZcYRXWOEneQYjrTD5pY85OGgiK3AT/TIj5g1Nbs
 POng==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792415720; x=1793020520;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Fl/KSelGy7uLwncy6cVURMGn08mO67EZQGkohQwxVEY=;
 b=ltgX6U2G8hfEivIW/5LTb00byiX3RQDg8R2T5FI/qjfezM9oOza5StPy60/0mqXcZ4
 3otVi+x1JBSj2AmmaxPRacAIEUTesxKrxWIA8befFbt2NKLxKTgba00oyWMOh/ACoECT
 bKcmm8eVFsEJfQ2XExdQG6cjCPcgSkvVjHOAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415720; x=1793020520;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Fl/KSelGy7uLwncy6cVURMGn08mO67EZQGkohQwxVEY=;
 b=Wecw3OqEtJEQydYGdPAHUrkU0Y6uM+08oT1g/k6pUPXlJlCmGKOXcxalqiB9Ds26B0
 Osi6CFE+0jiaUF08z7h5Iv+heK/1iB2nGrSyEOP5QT31g+/6vrjozYW1xY5zOkXoGyDx
 jaGlaYbp4x9Hk6hgniG9+6JvzhnLoPMNSgdfNUh0vvkp/ndYN7qpY5/6lQVcCCfWsGO+
 qk2OMfGNVuU85dcdiCMfsyTcn+md45dmT032ubxvtTqR81uFsezNw0Xcenam9CWoK7H2
 w523/w1EaKVRcRrhyhHN6sZHzLLTLlnqsafAQjN98U/LpLHkPuT8CLfkeiv3nwPbMulZ
 bvyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBynWJWXaYlPNKgMKya8M3BrNT0H5aT0nnGaDuIHQqe0W3Fm3RfO2Ev0BvzX0dt1cKqjS8GR3Eg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKry3hYS8uxBRShpW9jEZqyJPyYKUgAE/sj9JGmz8tkYOhFYC4k
 hCD7MYiSN8l4CLyyH7302oIxYFurjIpjIwIiiUbBzzF3/BoPpuFXXr01EUeFajHr52yvftldHHO
 Wb6CsgcZ7QhIB6dQ0mnHngtsGSj9YpqZJ2gmhuO6k
X-Gm-Gg: AYBFou1q/HBWQhW/T9dG0HC1Xw+mznO6l6Wm7PBArUCIXq6bDwzgOuWR4vKy9BWjLNF
 aQAnpRfOlt4WEQ1hQYPE73fgklna60Z/C8dMNzeeK04ps4J92qafnEYnH//r65ScxzLhjg11fiK
 iQmc8IZ2Nr9nMNPNz9CGA5nL+QMErbzGpXUCUh/q9dlP19G4kHG0zhaF6f/gZv4sccC+jIJHUVm
 Pc13l4LWz0hcaUuclcqvXBo1eyi7Q6w/+9YVST/s+s2YtMYTFzVkpvoM60EU4sWHI8k8Vhnhm4g
 ASYoxrftQOW0UDhxNJ7dfhN8j0rJptukIGoGV1j6H3XQPI420NYpOxJUEPd1Xly2
X-Received: by 2002:a05:6402:3605:b0:6b1:ef16:1855 with SMTP id
 4fb4d7f45d1cf-6b3a818ebdcmr4871163a12.18.1792415720098; Mon, 19 Oct 2026
 06:15:20 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 15:15:17 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 04:54:45 -0700
MIME-Version: 1.0
In-Reply-To: <20261016065500.137544-15-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-15-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 15:15:17 +0200
X-Gm-Features: AclHuK--VeJFJJ8Z38J0sAQafafQi-82OyLQfN2Td5rZOBX35-t7RBuacNEwuvM
Message-ID: <CAFLszTgb87s4B-5jVss9NQ6R-gBwtofvihOgB+qHG_Na2Vp0uQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/20] timer: Add loongarch_timer driver
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
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

On 2026-10-16T06:54:41, Yao Zi <me@ziyao.cc> wrote:
> timer: Add loongarch_timer driver
>
> Implement a timer driver for LoongArch architecture timer. It's synced
> in hardware for every core in a system, and frequency information can be
> gathered from CPUCFG instruction.
>
> It is not described in fdt, thus a DRVINFO is declared for it. During
> probing, stability of the timer frequency is checked through CPUCFG, and
> the probing would fail if it isn't constant.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  drivers/timer/Kconfig           |   8 +++
>  drivers/timer/Makefile          |   1 +
>  drivers/timer/loongarch_timer.c | 132 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 141 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
