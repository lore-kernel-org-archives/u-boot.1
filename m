Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22424606A31E
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Cd7+bTUW;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GnojvPdh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E60580E8E;
	Tue, 20 Oct 2026 10:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CpyW3EU36gWb; Tue, 20 Oct 2026 10:43:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66AF980E09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792493034;
	b=Jkln1Z5bUEiDLTKdrLWQ+maak3NrOeTZP3MFqigPeOenOKRiBcjoRqp1wLvMMqPt9glj
	 7EcGPGlRpU5C+jL6YdLyBJIC5Y/sF3nZUatEzAGGds9vSwCn4rHXLe/p1u7jqu60mFCp+
	 SnLRvzFbJaLh5PkYG7zsKczPZPevvEuO2g0Yc3V30+2GL4IRSQTlnpuSBpnu7LqckVPnP
	 saKqyGoPW/SPvF7axf4YPBD2/Jz0PbODqKOnJ6hBsNsojJ8UPt+0FuBWhVJ+jUitsZgjv
	 ezueUvXqMHJxwAr6YRnn2xkXpTi3xsR3pcRM4umsyEWrLR0lq+0miEO99IzSFsoEz1w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792493034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K3VT1WIvhuIttDjELYcSBbIRg9igWg0uITYjXBe4418=;
	b=iDwnol4ULdxxM3u/e/+4HzsqlPT7VT69GQmHhzNF6rCnJgNy5aDgAZp1gJuBxqZurps8
	 vKPevagbOWmRWgN6v1M1bHp4qSQiU87Ig/7fn+FjVRox3y/zQaW/o7dDsDNNkddlykAzk
	 3Ulb+O5cwMQGwP4gfJSNY5FeWVsuTnNJl1DeqGkwMw8zybK295lRV630t+PkJ9UStvrlc
	 Kyy+lmfCBOCyguK45Sd/oo1dRUjOVn+IYG/DfL6DiOIFjkFSaTYAYBtmX4IUXNEaon7JL
	 ITPt/VrWgptv54S3jQKNqFab6s+3hUcXMbIsFIFPLhd+jDZrTtV34Ts9TpBG8cPK2uw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GnojvPdh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792493034;
	bh=K3VT1WIvhuIttDjELYcSBbIRg9igWg0uITYjXBe4418=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cd7+bTUWb+swB+7zbINeL8shqVvIX2xt953sUK/GsgAYHv/jBNFoI1nzA4wFtVdqb
	 jkcuadmH/IbOsZcuyB9PU2ayz53LMox93HX+BJF4L2d/wzCaXCt+c7A3pBwAM0Ap5B
	 ORBgPyYiwWnouNEM4aNo2++ksCinAm0WENV/2R8AZo0+PcxCgDXMYMUSlZLFVsinb+
	 wJlCaC/a5IbdxwSeCqw6xPlWw2E/56dun8xZG3m1LXYEJpo9rtNCqV3HBlhnwNy20j
	 O2kiWtdQxHvG+xtQKSYXzUZ92X6tpZFZM2nkBZQaTxbfFeHy9DGz57JKfGmxEwg9Yf
	 f9oXptmRJaX2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66AF980E09;
	Tue, 20 Oct 2026 10:43:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 663A51E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C1C880E09
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:43:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SH78dL12ef0a for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 10:43:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D39D380DF7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792493032;
 b=Xjt7odZZeE+QH+1iyQLyj8TeHV5t4u22TTG0dTRqz7/CJoTcUiO2jZ+hq+Ujn0P2qyJU
 Wit0zPt0cU2ijV123ECw38xjfxvtThFKuSPXqqxBrpO9pVzD5w5baUS+S5DAeihh1/wIS
 YD7zEYY4/vLVLrqiODKxRrO7a6N+1avvNVY5iQyCGap/YXgJupHrlw/Bl+S1kmcj8HSW9
 OnEauhEXvVaUSEL8v1xZoPZTjNW2v32VXLqtg9ngoqh+TNcEvfBvF218hnOK5+ik3+BN4
 Y4zNyFggEcQZ0wZf7MX7WzfCGhW6riFyjoOb8oRcsUlwuAtxnPuZwuJ5SvJ4RF3g37A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792493032;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=K3VT1WIvhuIttDjELYcSBbIRg9igWg0uITYjXBe4418=;
 b=f152q7KpKRBKK94wqbmthofBLqr21lGBpZCwSdVVOQngkgW53NPCcfwv87T99apwYBIf
 6YcbsF5si1+rDfByJ/LN13fpcxUbquJQ1gdNtWxhmCwBumAcMR9opYYxUZTwJ2l+kHcmj
 C6TQp84V4FprwjMgHGE5bK+NPW9zXA63ZTNsW3zerqI7HN1kTYEBPpcQqvs4BifFH1NGU
 Bi3wo7h0etOgib8RLBEeXC9UwT2P94ojH6gkKfjUuoP1qteMLS5lttQ55Dobx6NbCXLZ1
 Fh/nWNurnNUTLwkQQY+QUMWH0lsDUeooFmEbHn4/7nsJCjqyGeT3+RhmkjCcTXatVow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GnojvPdh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=GnojvPdh
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D39D380DF7
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:43:51 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b06c0794cfso26595567b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 03:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792493030; cv=none;
 d=google.com; s=arc-20260327;
 b=qIyGQguf5tCr6/nUmyVTFueOfDDpQt/o5Oymxb4RoqMQdSavr32v4OYFaqm8nB3Aop
 LSx/mdHsKcF48VDYY/8rJVj+0qxgZNHF2GoBuyZleleHG3d1vJujz3565Z7xLb0CH7DU
 qeDL7d95429jUSLSprYYvu8lSxJfpd7c3Gf6yoVe7GbHuMiDWYke4w1kUXBIaKowQpHt
 0BGncdRd0cMe3BZEOIjvToqkfNiKqJIqVwTS2SdR92OSLI8XoUPbbGjnAGuP4GfiRRMh
 Lj8Acey+TJaHGoO4s7zyVtH4qgfUrFVVhOu6V2ofJwYR8iWao5qGDy0eEmEY84kqjhRF
 1sKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K3VT1WIvhuIttDjELYcSBbIRg9igWg0uITYjXBe4418=;
 fh=xxmaI1B1xQTLT6ZO2XHycapbeE9zxPzU4PcuCeyaB0A=;
 b=RS8kDtXfB4q978h7DKIByfjuMj2TRInlkP+S2K2GBsXjoEVqpS8ls1nXR6uAto5Kfo
 Ic5pSBDssKIIgWB4NdoMsZOS87F1I9ejfe85gPIegie1zcdewbiVzgIQGbEP+f5Bb0if
 ItMhonEPWm/x1uwhPn0af2E+1zbaTHHG+C8+IS2OiovYpZaAaAQg+dkE64iZa6xuTI5N
 wMjmdpGRcznJAJ8pbK608osi7iDU7aIxui9JSvqbLdWZgIU0PjO4/2R7bvD6L49UTTB8
 YRXm+dEkTmjUVAUhP329nBSctDGlZptnoeNFpK9JMm6HKnf66eW77Evwj3xpkWSeZSB+
 GCOw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493030; x=1793097830;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K3VT1WIvhuIttDjELYcSBbIRg9igWg0uITYjXBe4418=;
 b=GnojvPdhTfTIX3vlvQEsThVtRLOmbnp3+StIaIRzl7L/2YatrQGFBws0B4ghHKI+uc
 HmqO8nEqM4V9aDbYmjN0Rf6lvcmMNg+IwxcqY+pyqZP292wYlSl17BqA6JWa8foZSdlh
 ct5F7AzjKrcLv1qgn7ZDdbWiz7HcfOuQO8tih89c6FOuDnOOEMY3ZJKyECcb86Petp1m
 Soj5op1YjTLvMf4wuYG0gWevVH+EHlaW2eNjF9hTFgS+K+b7l9OU+ybKgIZZ2GU6yMBO
 2G9ObZPAv4ElDdpVf0fSsiNXEM9SZ0vCpdef3RHYoxt3v3SaPQUiHI7rBhcxA181o1n+
 RUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493030; x=1793097830;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K3VT1WIvhuIttDjELYcSBbIRg9igWg0uITYjXBe4418=;
 b=G3zD5bEqKFA6n9SXzFg95I4cc993AABHPRLqf2GV5059X6ag3PmSbmGCmgz9NiQhL2
 9zKmTKI2d65OYToeW1GlBjrbyaAjfArsaUCgM3oHXmecSPsUVl/oFPqyalAbiC7DRza6
 NiyA4+gR/Ng51b7lzaAkixTbfAUGY/gHGmplfPDFoYdkNYk7TOV+M5PsgRnZSLXMFSTB
 DNTDi21OqLBjMN8VtDJa+YgTPnrvjlnwHSPLZcklh6nITmN6F8rPQDJamMvYOsiui9nv
 tfKDtSXxRhdBvzd8Y1E63yb53ZxgOmdV/M+q0atsjC3sp5q3QZAPjeJjzH/qfsvFlcSD
 yXuA==
X-Gm-Message-State: AFq9FYJpC9/myAQZ7u6EFy7iZ4XmUZ+p18w3g6Kp0eGR19Ep2oPRZjX1
 aqK2a9z9uj+pWNZni393SKxFt5qKFOZ1o/KiCiWbLAwkEdsLLlD/O8JeYvRols7/BZ3flrqiSRj
 DBKYq04QnG1H2K45oBMxim1aFQDff5v0+oZmmSHpoWQ==
X-Gm-Gg: AYBFou2B2SXn0zYyEByE+u8OIuli6M+BJ3Au2FcO8M72lcJIP2xwWjQnr0FkhdVK3XW
 q4MBE73AXMBzwRfG8mjAFR+KbNXrssrP8jCL8VmQXQ1DhKG/x+LpyfHmImmIS2zMqqBzOrkgte/
 QRqOfoj4XV4+atFilhyVuDlVBSnHYDFNZC+Xl7bX6YrWylj2DOwzQYT5ebQz/yXzCpwwlw8xsUh
 JOt6xBHwNW4Ztl11BNZ3uBaEIoI4SXAPSy6HKaHiXBM6sTuu/PmhI2/We4SFa24MGrvXeIIGMIt
 98qMAuVNRFid+jrPJXDp/9cNBwYTuUZ5JZvMdoeySyWjpvlPQIf58h7bqGNGXjPaUnAPMwQkTHQ
 Esn4q1YCKt26WEGF8LkwrcNVUxNCswDrVkbxxz2eoa8Lz4js7qqVxE3l596FplOSnGsgnifYaGd
 AxhNSnAHfgUcos1rgINRq/+fBAMToCrhBZmHxLPqBs3oGgjzhqItuXJpWZmJ9sFAFEqwcAdh6Qj
 Z505G7HvDWvejDNTSVxRknqOFiEpAZFCcl0mwPScaBUonpQBbGo4+wjODM4Ghe8JNpWswHQ77k5
 xzEm1OMJmYm0vPn0gpMoxP2mC+ez5ZiRMUh7wd5I9h5TN/k12ofHp50wd6S98zo9awL+pk7+BPk
 5+hh8IanOc3zlqX9sj2xcSrr76IrfpCid0WG8kHTX5WqoeR6Lm//Idw==
X-Received: by 2002:a05:690c:e3cb:b0:8b1:ce5:be52 with SMTP id
 00721157ae682-8b10ce5d859mr17533457b3.31.1792493029968; Tue, 20 Oct 2026
 03:43:49 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-qcom-capsule-dynamic-fw-images-v2-0-3824f7a66e1e@oss.qualcomm.com>
 <20261020-qcom-capsule-dynamic-fw-images-v2-1-3824f7a66e1e@oss.qualcomm.com>
In-Reply-To: <20261020-qcom-capsule-dynamic-fw-images-v2-1-3824f7a66e1e@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 20 Oct 2026 13:43:14 +0300
X-Gm-Features: AclHuK_kFmXHHM2dgX3HF-a4UAp0VGGImP7tyIjwfsBna783xXBx84Rss3EDrmM
Message-ID: <CAC_iWjK7ZCgDFSW4N9y7ynZQ7inPu2UdwDEZmqDsWAmWNoxW_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi_loader: capsule: allow platforms to map a
 capsule to an image index
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hem Parekh <hemparekh1596@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Balaji,

There's a a few tests failing on the CI [0] with this applied

[0] https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/jobs/117623

Thanks
/Ilias
On Tue, 20 Oct 2026 at 10:02, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> efi_capsule_update_firmware() passes the UpdateImageIndex from the
> capsule to efi_fmp_find() and set_image(). This only works if the
> platform's image_index values are fixed when the capsule is built.
>
> Add a weak efi_capsule_resolve_image_index() that returns the index to
> use, defaulting to the one in the capsule. A platform that discovers
> its images at run time can override it to find the image by type GUID.
> The lookup happens before efi_fmp_find().
>
> Add a sandbox override and a signed capsule test whose image index
> doesn't match any fw_images entry.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Added newly in v2
> ---
>  arch/sandbox/dts/sandbox_capsule.dtsi              | 15 ++++++++++++
>  board/sandbox/sandbox.c                            | 13 +++++++++++
>  doc/develop/uefi/uefi.rst                          |  5 ++++
>  include/efi_loader.h                               | 14 +++++++++++
>  lib/efi_loader/efi_capsule.c                       | 14 +++++++++--
>  .../test_capsule_firmware_signed_raw.py            | 27 ++++++++++++++++++++++
>  6 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sandbox/dts/sandbox_capsule.dtsi b/arch/sandbox/dts/sandbox_capsule.dtsi
> index 34d29916b30..cb85bd99b68 100644
> --- a/arch/sandbox/dts/sandbox_capsule.dtsi
> +++ b/arch/sandbox/dts/sandbox_capsule.dtsi
> @@ -104,6 +104,21 @@
>                 };
>         };
>
> +       capsule7a {
> +               filename = "Test13";
> +               efi-capsule {
> +                       image-index = <0x7>;
> +                       image-guid = SANDBOX_UBOOT_IMAGE_GUID;
> +                       private-key = CAPSULE_PRIV_KEY;
> +                       public-key-cert = CAPSULE_PUB_KEY;
> +                       monotonic-count = <0x1>;
> +
> +                       text {
> +                               text = "u-boot:New";
> +                       };
> +               };
> +       };
> +
>         capsule8 {
>                 filename = "Test12";
>                 efi-capsule {
> diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
> index 13006a0ffc2..8844f59e4c5 100644
> --- a/board/sandbox/sandbox.c
> +++ b/board/sandbox/sandbox.c
> @@ -57,6 +57,19 @@ struct efi_capsule_update_info update_info = {
>         .images = fw_images,
>  };
>
> +u8 efi_capsule_resolve_image_index(const efi_guid_t *image_type,
> +                                  u8 capsule_index)
> +{
> +       int i;
> +
> +       for (i = 0; i < update_info.num_images; i++) {
> +               if (!guidcmp(&update_info.images[i].image_type_id, image_type))
> +                       return update_info.images[i].image_index;
> +       }
> +
> +       return capsule_index;
> +}
> +
>  #endif /* EFI_HAVE_CAPSULE_SUPPORT */
>
>  #if !CONFIG_IS_ENABLED(OF_PLATDATA)
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 94ddf690440..0e1641122dd 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -503,6 +503,11 @@ on the FWU Multi Bank Update feature, please refer to
>  When using the FMP for FIT images, the image index value needs to be
>  set to 1.
>
> +A platform that builds fw_images at run time can override
> +efi_capsule_resolve_image_index() to map the capsule's image type GUID to
> +the image_index of the matching fw_images entry. By default the
> +UpdateImageIndex from the capsule is used as is.
> +
>  Finally, the capsule update can be initiated by rebooting the board.
>
>  An example of setting the values in the struct efi_fw_image and
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index ef25124fd84..10030af8954 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1235,6 +1235,20 @@ efi_status_t efi_ecpt_register(void);
>  efi_status_t efi_esrt_populate(void);
>  efi_status_t efi_load_capsule_drivers(void);
>
> +/**
> + * efi_capsule_resolve_image_index() - get the FMP image index for a capsule
> + * @image_type:                image type GUID from the capsule
> + * @capsule_index:     image index from the capsule
> + *
> + * The default returns @capsule_index. A platform whose image indices are
> + * not fixed at build time can override this to look the image up by
> + * @image_type.
> + *
> + * Return:             image index to pass to efi_fmp_find() and set_image()
> + */
> +u8 efi_capsule_resolve_image_index(const efi_guid_t *image_type,
> +                                  u8 capsule_index);
> +
>  efi_status_t platform_get_eventlog(struct udevice *dev, u64 *addr, u32 *sz);
>
>  efi_status_t efi_locate_handle_buffer_int(enum efi_locate_search_type search_type,
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index a77810fa15c..f5f4cab3613 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -517,6 +517,12 @@ static __maybe_unused efi_status_t fwu_post_update_process(bool fw_accept_os)
>         return ret;
>  }
>
> +u8 __weak efi_capsule_resolve_image_index(const efi_guid_t *image_type,
> +                                         u8 capsule_index)
> +{
> +       return capsule_index;
> +}
> +
>  /**
>   * efi_capsule_update_firmware - update firmware from capsule
>   * @capsule_data:      Capsule
> @@ -543,6 +549,7 @@ static efi_status_t efi_capsule_update_firmware(
>         int status;
>         uint update_index;
>         bool fw_accept_os;
> +       u8 image_index;
>
>         if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
>                 if (fwu_empty_capsule(capsule_data)) {
> @@ -615,9 +622,12 @@ static efi_status_t efi_capsule_update_firmware(
>                         goto out;
>                 }
>
> +               image_index = efi_capsule_resolve_image_index(&image->update_image_type_id,
> +                                                             image->update_image_index);
> +
>                 /* find a device for update firmware */
>                 fmp = efi_fmp_find(&image->update_image_type_id,
> -                                  image->update_image_index,
> +                                  image_index,
>                                    image->update_hardware_instance,
>                                    handles, no_handles);
>                 if (!fmp) {
> @@ -650,7 +660,7 @@ static efi_status_t efi_capsule_update_firmware(
>                 }
>
>                 abort_reason = NULL;
> -               ret = EFI_CALL(fmp->set_image(fmp, image->update_image_index,
> +               ret = EFI_CALL(fmp->set_image(fmp, image_index,
>                                               image_binary,
>                                               image_binary_size,
>                                               vendor_code, NULL,
> diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
> index a500c499bb9..005fcd7ef0e 100644
> --- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
> +++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
> @@ -190,3 +190,30 @@ class TestEfiCapsuleFirmwareSignedRaw():
>              check_file_removed(ubman, disk_img, capsule_files)
>
>              verify_content(ubman, '100000', 'u-boot:Old')
> +
> +    def test_efi_capsule_auth6(
> +            self, u_boot_config, ubman, efi_capsule_data):
> +        """Test Case 6 - Update U-Boot on SPI Flash, raw image format
> +        0x100000-0x150000: U-Boot binary (but dummy)
> +
> +        The capsule image index does not match any fw_images entry.
> +        The image is found by its GUID and the firmware is updated.
> +        """
> +        disk_img = efi_capsule_data
> +        capsule_files = ['Test13']
> +        with ubman.log.section('Test Case 6-a, before reboot'):
> +            capsule_setup(ubman, disk_img, '0x0000000000000004')
> +            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
> +            place_capsule_file(ubman, capsule_files)
> +
> +        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
> +
> +        capsule_early = u_boot_config.buildconfig.get(
> +            'config_efi_capsule_on_disk_early')
> +        with ubman.log.section('Test Case 6-b, after reboot'):
> +            if not capsule_early:
> +                exec_manual_update(ubman, disk_img, capsule_files)
> +
> +            check_file_removed(ubman, disk_img, capsule_files)
> +
> +            verify_content(ubman, '100000', 'u-boot:New')
>
> --
> 2.34.1
>
