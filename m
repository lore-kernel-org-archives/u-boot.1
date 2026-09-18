Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D919C982DD
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 20:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D50A260D6A;
	Fri, 18 Sep 2026 20:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hd-SoqaD01Ej; Fri, 18 Sep 2026 20:41:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 266DD60DB6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764066;
	b=bTprwXqTR38MytPgh9HKlbduBz6hbDYC9EhLpwvdNgRuhWSOcfOlFs6Foy12D3UIo7dQ
	 KIJaQ2n7nGAT1IUnrwnEX+VFqpYHeEvXig614RSP4dEg3rjtzJn1r0GsdHfD1IuKmbbWu
	 wVV7kQXTaEJKt+Tzj370zaYn4yQANrUjzBjwETXj/UulTMJIUaVZDZ85nnps8F0l+h1Nh
	 zBSRBQ6BXU7Eia8dcWqQ7oMsXjtzp1daKCYCs94hc8OwbccgiIO2ch5KoAHf25Stzaeso
	 Ss2OuWFS+HT/kdWLSK4sLFf6/mKcYMxG8zJ5fdPpEyfqOQku8r37oIP20WSCQuGdfpA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789764066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LLhYrYzOEyC36DGnA+Gd9bJpBayIbuDwdRbWBZOL3vo=;
	b=TEojYlu8fNL/aGYsi7fq9Wa0pov1PLtqOWxbq+KFPqyJ1GdFovPTlav19sCmDQsGApSu
	 x7wx3F33BgDoOovPehp11leZp0J3LEUct4RDth1FacZ4+WQT7KNHad446astFWCc2XJU8
	 lQLi0TLpdRy4nN5eBH098U2NyDsUBfSdHEoCl+1PXjJR86IGBadrlzAh02Y4bAXf463iZ
	 OvVTHvcixfdAhe5C+aRGzZHOh54s8geUtd99NvcdnxH6lROYnIkMjpc/z6JmMRKfgSp5T
	 uGKbhlKcz4SwDMQ6hPeOpWQYywe+VttstEWbE9cpy3qOUED9dEwhgjFVSfX4rTd9HnA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="XL9EH/zj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789764066;
	bh=LLhYrYzOEyC36DGnA+Gd9bJpBayIbuDwdRbWBZOL3vo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QbMNTYZhtKmf7FUFvgO5rn0mrRgQJ7jFgeYvHkWohgH3yEJyVVehwNVu4BxK/71gm
	 X+/Tv5iabmJssEAzWNr9phAygBIFRp/V7KOhEQL0J/f++yHnHHvbbiLP3Q0S9Az1ou
	 54+OWyuaD8dwBTq1Tv3lxudsTgmiCFqyV4Mqm5AHnu35y0OD+QYrdU5BOuw7EZWMHk
	 VX2WQNN6GetzCyN18UVkhbSRySGwsReN5T9F6qkz0pFvpYPpiatq6JaS+FM1jfV4Xr
	 3iBlLTdPPzx7e2AEHA9ATFTDY2WYleF6QFLH0+/ctFTnCsUMcL4uDTSht0mTZd/M7g
	 5p7kdbWmvGSYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 266DD60DB6;
	Fri, 18 Sep 2026 20:41:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E20F2362
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D442E60DB6
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:41:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RRALdwfC24PX for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 20:41:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E603660D6A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789764063;
 b=IYM1/fKKpLlkfs5CrzdvVjYXH0Isoe5EEyBfJmy+xxLKGihw7KjAWcQxxLmkfgzzAEY1
 gAsN/ilyBMDmIoVVSnBYPBmnCB56h+BgzcHTlfbMi4X4aLNcNrb4KipmDHw/pMmuqf2Fa
 Nn8mMdRAEsgU43ZP5QOmG4sQg+uXbGKBYsauD8XI23W75R6bGPjiVR8keN3hbp2SKS8v8
 gmEtaFfzZShy3xM+zSmhmftXUwa5LJJQ29FAcfyQUkTnSP1CCbVD2GRdjgyQQ6HOhLBTO
 AvVPIGtT07g15FpaprtfiMJQhEQon+KtVeMRavLhDzwfRMxTNPFb5CGcyJpB9Hsf1+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789764063;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=LLhYrYzOEyC36DGnA+Gd9bJpBayIbuDwdRbWBZOL3vo=;
 b=hgCcvuRlthNrT5220cFcdJrf3ZzSxMX65wIo2pASw4iBZmZw38dD1LIOzAlD34RShgdE
 otpgh3K8B+ai89uzjxtQBGNf8xX/H5KxrTewJ2eRIAILMuuv1oZVPAJ9gGKFCOWtvcUh7
 lu/R9GT3nptMxok/usNZ06b8SI6MG23/4n8RAxv8BlFKF4Hs8F5ayFYuAKQv5lkRZyS85
 LaDP22JJIojL3IaH0vhG/1kPe+0zhA5RG0Ge6UnE3B30Inh2hg8Kxb0btaWDdR4MIKwzB
 Sh5a0zFyzlq7oTTEj8nJb6Nb4+02nasukXk6G0wQvHyatn6savB2Z9qYhuxzzrpF6PA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="XL9EH/zj"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=XL9EH/zj
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E603660D6A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 20:41:02 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a6056be4d2so944066a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 13:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789764060; cv=none;
 d=google.com; s=arc-20260327;
 b=MyEwMQKjbw9jYabl88+MFNzHaExBaYc3cwVZ2hwGcNyAVVplI48YEhxg1VEn+BDCt7
 ShNnuL/iO+xhMNErAS55mum8HcVAYIUyhc//ZAnHoSV00qA5uYCTX0ccnm0ZmM1MpcrT
 bUyDvwcEm3L6STPdNbdxYgl0hLKDGpHQotpQrVHlROeWcOmI0Rxd6g1cuXMCCyufCzL4
 4xhZzZwd3B2LjxVJtOJ0onx1cpts+NgIXCqcD0DTn0yHOYBdbDybjJGc77gAtXMHXgqe
 5GC2ResjM9i2uoHtC7gdLnRvkxm8MywOsDbyIUh6+r41ksRKYG7x31CQ+mc1We9H7J7o
 Jkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LLhYrYzOEyC36DGnA+Gd9bJpBayIbuDwdRbWBZOL3vo=;
 fh=hMnzCCESv5iutVaH6AX1PrbYoVsPb+wpOEI00M227js=;
 b=OzPvH+0WHqxUiyMuytErJY4a41ODbZ1lPqxPeg90f0QbDoOKCBzHNe3bSXQLCSmWiZ
 fbQSW5LuBSdl2EHbUu5gU8+OFaFMnl64gW+sus43jC5icJjwKCz7nPWmx8X4d51UDqj3
 YuehYiqCSrn+j2PhpoVRmjDCVu6l/w8okHyLy4cx/fUmQccGjtBVYl1CulyyQJ51wBIC
 a1b48fl6sK5ZeYP12HWwJpF5KvTTve8aE+m7ofNSi6+dwjT2tcVm5NCvFpDPvkXyUmlv
 +KgHlYg2lIyPlnHFAqUbMpL6CPX8TT++RPb3u/zz8O0vkaIUnWbZqdvpvaK6HknFTnFp
 f71Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789764060; x=1790368860;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LLhYrYzOEyC36DGnA+Gd9bJpBayIbuDwdRbWBZOL3vo=;
 b=XL9EH/zjbL1Fr7x68GmROp+DxeKyaVA4rwuKqmCzMg+VV/EUFryTTTE5C81bQgZv1p
 iMEb/Lyq6W6HV5yM9FmH9blO8IsO9MA8pXoDSN4cfNjYZu9w5OnppxLoIHA6HK+9rIGZ
 yJFHPqZxK/DWwuftMVveH0ygYU7s9Cfqz2zy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789764060; x=1790368860;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LLhYrYzOEyC36DGnA+Gd9bJpBayIbuDwdRbWBZOL3vo=;
 b=OMC0nxXZb41652HKIyuvvK8TOl3/yA945zB+wkQBetj+8O71S99AJvmodcFJ450YY5
 y8LNoWt/1a+kHz+RjcCdViEJDA3b2ZNr4BdQkLyFoPuZ1OlPKfPHde/KjfaMYxRXNoM1
 MxFGqpc6vcW3oSEthu3QTMAbZQjanp8ckZwqCX5fin6gYQXO3UU/QyD2zuZVwDmIRKFy
 lzItsRm4mF1nkjSsDgpKt0wnp8apaXzI6FP203q29hd4oKu8p3v3Gq17vWd4rSSRa32d
 OofrsQInB34s1bsqJhqDx9Q6PKDhI+lq/bIeoJNuS1Q+sz8gMwI5YnEEu2dDpf347zfp
 /sUg==
X-Gm-Message-State: AFuF++lmPqPimTc5uBuM3jPmhcWFdhLnT6XvVrfC3/ubQbu2gVut/WeS
 GNkmUG0PxKskFlWMsogBpyY73ctm9U6XU/ojdIHavjgxda55I6yBjwQT25zYFZG5otE7FI7EYKr
 5ew3wUl8jaLTL+FLe7ieJXNftYO6vngQw3FgYnvgq
X-Gm-Gg: AYBFou0NTDetueJEl5/Ovn+HbxRjrIAL5oNq3WYFMfDt+p66R5ZyTMfBxJGxJYe1fRl
 MHKMI9wRPZQSQh+AhwuoxZi0k+tUW5YFMLJxL7xaQ16nu6EuK8hAtPudfTeSecjh51TzNtf5eUM
 EuGvIZmikY5o+5QSml2dG7QTz1MTLs4bWMoVqQPYfLum1nXFR8C/PvlhQNXz7sT6H7WBnGxtSu8
 s4hVD+Qy23tPp+AUp32g1RCvlBoKssTO6KIhjenysnSgse5Ikb3NxS7YcIFJW7l9LBTaAs3OXqN
 Ill1Wh6hgFpWXUWqTa5qdj4xBbuS3PGdZMT++vDTX6nWqrXisuIz9+jL
X-Received: by 2002:a05:6402:541a:b0:6a9:9ac3:aa13 with SMTP id
 4fb4d7f45d1cf-6aa4f9c6b70mr2797552a12.7.1789764060462; Fri, 18 Sep 2026
 13:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260912124454.13578-1-aristo.chen@canonical.com>
 <20260912124454.13578-5-aristo.chen@canonical.com>
In-Reply-To: <20260912124454.13578-5-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Sep 2026 15:40:45 -0500
X-Gm-Features: AcwNN1UvEB63TP1uoB4zAvrSRvZ3XKrrr7wdSbhQWFyxPUESyXag-Bis94pgp5Q
Message-ID: <CAFLszTg6G76GHPtROkQWFUmqox4OyYtU153DHVeUygk3FNz1hg@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] tools: mkimage: include image-data sharers in the
 load overlap check
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>
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

On 2026-09-12T12:44:46, Aristo Chen <aristo.chen@canonical.com> wrote:
> tools: mkimage: include image-data sharers in the load overlap check
>
> The overlap check at the end of fit_import_data() sizes each referenced
> image from its data property and skips images without data, since such
> images are never copied anywhere. That assumption no longer holds for
> an image that shares another image's data through image-data: the
> reference is resolved only after the import, so the image has no data
> yet when the check runs and escaped it entirely, leaving its load
> region unvalidated even though the resolved image is loaded like any
> other.
>
> Size such images from their target's data instead. References that do
> not resolve are left alone here; fit_resolve_image_data() rejects them
> right after the import.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> tools/fit_image.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
