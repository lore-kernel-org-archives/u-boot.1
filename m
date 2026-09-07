Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6877CC79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 10:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F26AF80C77;
	Mon,  7 Sep 2026 10:41:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-v2131ojAkE; Mon,  7 Sep 2026 10:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0D8D780C79
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788777715;
	b=N/YbutanqZtPs/9xv6zxclE8+94U0EfPHFlfaq5Sreyxy/fqp+NiOrM/wQQanFggxLWO
	 1kskqexBSTA6qOj5UiXNEsoDLJDNvi3np/qtfFN48AZlmitmk00VhXsXWq0bMy/MULT5w
	 BmwxmiZcj4HtsnstYwi9llXPVk5slhdT9sZA4ucl1Pltx/A/dof4sMN/4m4Y7skB5+HYD
	 LOQM2911/23OU+xK7u/8cGOnbKOb2z0RFSEOFcnhPBN80shIEzzVOgm4uMXLN3PLgzU1N
	 HjaEUa/++fuiugufTwCDksYeD30dNaoXfpWMGFGxOeCbGG05e8tu3ZcuuhXOn7lCoDQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788777715;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=K5kcJruOKknshQNjBEkBGXDZj7JNdVWYPY/G+7TGqGI=;
	b=GWUblG0ITGQZiBk05KCrYKHOfOTk2d9q/tENRcoHbS0H/TR+DAvGvhRViEJYtj+VKFi3
	 EljmIkk5SpslvCZGHyMDVmF/9ofU5bbQu2hUTUzcaT5IR+SNeuIah2lkMmbqaXL4n6LrC
	 vGiDqtZvg8atmXCuTp/jZHFLyIYskz2zYdmX1elmRo4DzVUQE7HYoCZ88yJYHWtuRSvS6
	 bF56uSHXPEAvMAUUXa0kcRz5tSaPGO//WwkomH6x/w7SNkAWotemeyhnCfJGAuMrfOAiM
	 qyMCv0BKdbaMLSZK9UP5bcLypl/h/imiB26JPiNm4oEWk0dslNirooBtbVBgn1AhQ/g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788777715;
	bh=K5kcJruOKknshQNjBEkBGXDZj7JNdVWYPY/G+7TGqGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jir0JaOP5wvqe3/ay83Cq/E67gk0nr8tvDVHCbWgo+wWsnzmgsKKEkMqJz/vP8eu1
	 Qo98M7DVZxbtgmtH0PGBuX3zmHqUaWd5AZ8EyJqNsP6ScL/0d+HNJ6pmpsUCNpmm88
	 SRsgurUWRX3j48Ark1rsCOj5OIitG08WnVTC0XBFkvvaTwZh4s9+VCzkz5GHQJIC1i
	 woYJe8V+sfmGew7m5Pns+yOiRlwLeSvEU1kBPTQzi/R8V2VROt9VZF+Un0jq7SnW9O
	 ElwNuIpsuWVXFshTbv2SBneVmh9jKcIml8WorJG0AfVYi27HhNNhBy6Fqh4dtodGM8
	 0LQ7wdkcBIaJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D8D780C79;
	Mon,  7 Sep 2026 10:41:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 118FC49D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 10:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 021EE6067B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 10:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mUiPOSpoonIK for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 10:41:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AC02B60631
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b133"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788777713;
 b=cAYVcszEVutPuNGK9YtxEPvsbdrzhiWXTJAvngnbT4Q8w69tVFO7SniSlDJPbwvpaODl
 lhxd4Gzjk0oLYwa7Uxrm4t96g2AVC/f55Swh5aSuQwV5bcV3wE0uByO16dLC/pI9QOW97
 Gd5R76LytoW9KC0sW4TYdfTH1ulNnQAJZ6qHXWw2CFPXPwfZRIKpVEZEo5IbwpbMJpMQU
 aQAzfsNOIy/7d3N/FGCDyMJbAGN9Au8HAWXtq6SwZBzwjZ4df+Ib7n1HLQ4yv7uD38b7B
 +hRlTgGxr8u9qt5Jl5LWjepD47OSDg2VXF9gixds5WYWFLpyvS0H3wa83nmukfATTxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788777713;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=K5kcJruOKknshQNjBEkBGXDZj7JNdVWYPY/G+7TGqGI=;
 b=X5FABlTbu9341WCPjyt3Pz1Jyapr/kBhhWAcHNIvd0HQs+O3aEDvTdXAK6aG3xkFaAxt
 dDLGwgTuCb4XN3xctIPAt65anMK1Y00xRTa/bIx3jH2fWUl7DCRumS0p5J4BDs9W8lq95
 oDCO5Rqj0GK2W1XB9WNp1GW93EnZBLQmoOPMT5vzMMZYyOn2XQruQm6e3E+TJxZ7rsmn4
 29ddQ4RoabWCe4cAmWYwJmjMIymshkHu0VWL59bVCvsoAflQBrwp32U+WVE650KrTOSbV
 vJrsnGETBea+ERa15waF7JzRQ3vwxIjlP/YYOkrFtdL7MnyGPxcvMARQyPytQUHx8kQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=NnmX7zy2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=NnmX7zy2
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC02B60631
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 10:41:51 +0000 (UTC)
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66fca0709caso1093018d50.1
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 03:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788777711; cv=none;
 d=google.com; s=arc-20260327;
 b=oP989Rsk6EE8QjT1OVk9uPHkq+pfDg9aNvOe8s7nR6cYmBrR21ulQnoLkI+GveYNjt
 BJkr7Q1Ct7W8eD9CVjeW0lUEExW1nZTvdgogTf+LGbYaGmpj2RlkeoL9wA8Baj6YF4g6
 SftGewtjOJCu9RlUBJ9S2Ja9K190UBGZTqmf3iPvOqS2V7O3YGeuPhxOSIdoE+m6Ltug
 AV/hBDFWstdtJmPJrKm7fkpWD3ywQTykG02XcYtV3vBD3EhqESbMdjzzSkffgYV4oU72
 FWBBZM7qGneUxxDph0a6W1ltZzmxxhNIy3AtdOhcX91UTnq5ddfmlxtEibf0jfiNuYFI
 KMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K5kcJruOKknshQNjBEkBGXDZj7JNdVWYPY/G+7TGqGI=;
 fh=KOHScgS57aWppvWk57f2AZd6dlIGFfLL7hQjSQnvDIo=;
 b=Oa3L9DmI7BQlYvZIohgjmgiJBKAjB6GtVj+NC3wvnv3fajsO+I8V7t5dPjHV+NKAh3
 bX4miFNoH+FRPa1+ymBhj7nj485dnDijrb/4Bfjj8w9zaxvnAe4VaRZIlDw3XzHTvCTh
 VN4vvknY9tPZjC5wvjugV/znlqIkYuQbXUV59s2vg3ykuAZLf+pKpNrRWUrdAdNtfDc8
 TsoWVs2Y7fpBb/HSGJxQ+RUFN7KldmLt/hr7HStFRBKoRgsm+qV6FXTwIHUonj0sKOx2
 94xmynDaWG3HvdHAOJVeQrGQH36SplKeJqE3KkmHFkXrEpT1NdeBk3NsWAKjBTfsHz7F
 sz5Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788777711; x=1789382511;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K5kcJruOKknshQNjBEkBGXDZj7JNdVWYPY/G+7TGqGI=;
 b=NnmX7zy2djD1V0tIsCjTjF19NDt1FxX0qMFIFnYpuuRZw/MYlWbCnnB4mgKK9EbNhj
 7m28Suy2GoJlf1aLGr/thn7TKw3Nd+wIR9JPSbfMAnBJjHXXxBmmRqJVInOlGcVN8P5g
 FWHWLjmEs0wRSVA7VwcGYZnVTGALpJrV+F63mxuc2qxWAmTJ5G/2cifUeSfcLZylMpkg
 heTfa9G1+gumWEfLDToGBuwNzfEOwJCRjeP/1l1mx3Wz2LZwQq5qnVansXpVy0JtMbmj
 dkmxyZzhznDIssGJ8GUckBL4G9ajX95l7H9ujvKiRoOzXILk66w6nyVvDopV57oqsuJc
 fecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788777711; x=1789382511;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K5kcJruOKknshQNjBEkBGXDZj7JNdVWYPY/G+7TGqGI=;
 b=dRsEPO+CgQ4+SOk1FV8pNge6zKwYFkDcm33TCnkVJohpDMJdd0jDH1sQEX28OZwxcn
 qubaIgl1uA35eu8sAFmaW2HFRO/4FXi3J643aO4yGdyUq/iElyLsa2twWdR4Vt1/vc6I
 0f1VVWkd8SqdTEf+hSSdN+tMTWEXWA8nbujiTuB1HUMIDzJSM/DoJ8FrQ6qbWb/P8lbc
 LEbSM+TlRoBQhlBRA6zAIh0jornLCEGEIiAuoal94jWCqt3edpFKmEnsFnpLj0hS9V0s
 iyi3gfHegIN7RAo0aLMJocS4Y/OeV1sZYWE4ACbVCwgWMnYHHwbr7PifQny5ctesEnIv
 7qpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRLahoQLb/lyMeqo2ata5o8tyuS+uYQf3XsPBVG1EcI2bvExwShChm0mPcc3pDPBPPnZDz888=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mW3Fvj/hlotTYI1GXTSi884Ej2+kQdounoobtY/Tu3DXnFD9E5
 f9/bXCp0K4A/blamV/ShqrrzEIlRbod5JyQBBXTst+E/gaUfLzBFGWUgqOLCjxNC3kIQ40CArKG
 HQHyCBC5zEL4tpwfXfQYRvVTO1vq4IiXdVkKgXt5Ogw==
X-Gm-Gg: AYBFou27G3MOCy8P7YROQ5Hx0/B280htwEYptCVfv36nMTuGlfgKU0VQDAFMxOpfZGF
 3LwYgiJm4bgUIhYkzjxhREpyrnMHlpF98eLQoazOTr6QlVLuqs3Dsj7n+yCpm1SRtfsEDIAi4/B
 Wcdpk00yZwsYyd31krDt0+aXHz6iU7lh2pH4mDItE3GEHcxD0Rn02+2QNG7KLUqDb4cTqOifNtc
 RjDMYWnD9S36Fkd3Z4ipUImfe6J/AqTvYdeTQznVil71gwJsv2fEWdc+DMfFZ//6HHFz7XS7QVt
 AbIm0ay1DvaWnDhrke+1Lfb698l5+8xfpy/lahoJkPbyFPSzkDwpB6J0rMlwGs7lkRSLBsxRr0I
 Rc/hZDWObjzVyzxnawYPlVhIpU0wRe+dzzTXu7oqL832Evdvh9AKXPSteuUbsS/GvQzXGPlfNSJ
 5kP7P4DWNQEj604EMrLmEYJCJXLBAFb+m4bRv93srrWTJcKbgKm1JUcpgvQCgQQ9amM0O2pe0mZ
 HyN9TpNP2zNiptzRTZ7xPqNGBfBAjgvxOfJO9RkMbMiSR0DQ7rf4EjVZIKOLIOLLJ/l6or2VzCV
 uaJTpz4B4oXrZrsxxmHkUzyR3IMGbBrP66RsM1c+9BOZ7PWRMd2zcC9AqMonLq4QNubtoBOcbW7
 EIh73xuz4F3DdgqGtU48h1Sl45kI3U3FvMzlFA0M2Hl4=
X-Received: by 2002:a05:690e:191a:b0:66c:5045:d9aa with SMTP id
 956f58d0204a3-66fb5a6f8e8mr6868934d50.29.1788777710547; Mon, 07 Sep 2026
 03:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260827121108.1775123-1-suraj.hanumantkakade@amd.com>
 <20260827121108.1775123-3-suraj.hanumantkakade@amd.com>
 <CAC_iWj+WXkNAZPyRup4w09jSyr6TbkjLgZRyDxKzCQdFaK8-4Q@mail.gmail.com>
 <20260827163731.GE3959812@bill-the-cat>
 <IA1PR12MB952914F6FB38C8B02761B6C189B22@IA1PR12MB9529.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB952914F6FB38C8B02761B6C189B22@IA1PR12MB9529.namprd12.prod.outlook.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 7 Sep 2026 13:41:14 +0300
X-Gm-Features: AcwNN1UWIfUsh3lI6mw9qg0Z0cCjL5xzTgGYBXeuyQ6uQ4gfvu_zW8AM2xVpJGM
Message-ID: <CAC_iWj+EvSRi+O3fH2CsTT59vk8u8RyAcYNdEm28Vhq7acxRfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Makefile: drop GNU Make < 4.0 compatibility code
To: "Hanumant Kakade, Suraj" <Suraj.HanumantKakade@amd.com>
Cc: Tom Rini <trini@konsulko.com>,
 "mark.kettenis@xs4all.nl" <mark.kettenis@xs4all.nl>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, "Simek,
 Michal" <michal.simek@amd.com>, 
 "git (AMD-Xilinx)" <git@amd.com>, "Begari, Padmarao" <Padmarao.Begari@amd.com>,
 Simon Glass <sjg@chromium.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Borislav Petkov <bp@suse.de>, Michal Marek <mmarek@suse.cz>, 
 "Belsare, Akshay" <akshay.belsare@amd.com>, "Kummari,
 Prasad" <Prasad.Kummari@amd.com>
Content-Type: multipart/alternative; boundary="00000000000005070b065ae244e4"
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

--00000000000005070b065ae244e4
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Sept 2026 at 08:24, Hanumant Kakade, Suraj <
Suraj.HanumantKakade@amd.com> wrote:

> AMD General
>
> Hi @Ilias Apalodimas <ilias.apalodimas@linaro.org>,
>
> I do not have access to a macOS machine, so I cannot check whether the
> host tools still build with this change. If you have macOS or access to the
> macOS CI jobs, could you please look at that?
>

The tests run as part of the github pipeline. If you open a PR there you'd
be able to test it

Cheers
/Ilias

>
> @mark.kettenis@xs4all.nl <mark.kettenis@xs4all.nl>, would you be able to
> test this on BSD and let me know if you run into any issues with the GNU
> Make 4.0 requirement?
>
> Thanks,
> Suraj Kakade
>
> ------------------------------
> *From:* Tom Rini
> *Sent:* Thursday, August 27, 2026 10:07 PM
> *To:* Ilias Apalodimas
> *Cc:* Hanumant Kakade, Suraj; u-boot@lists.u-boot-project.org; Simek,
> Michal; git (AMD-Xilinx); Begari, Padmarao; Simon Glass; Markus
> Schneider-Pargmann (TI); Borislav Petkov; Michal Marek
> *Subject:* Re: [PATCH 2/2] Makefile: drop GNU Make < 4.0 compatibility
> code
>
> On Thu, Aug 27, 2026 at 04:29:29PM +0300, Ilias Apalodimas wrote:
> > Hi Suraj
> >
> > On Thu, 27 Aug 2026 at 15:11, Suraj Kakade <suraj.hanumantkakade@amd.com>
> wrote:
> > >
> > > RHEL/CentOS 7, a popular distribution that installs GNU Make 3.82,
> > > reached EOM/EOL on June 30, 2024. While you may get extended support,
> > > it is a good time to raise the minimum GNU Make version.
> > >
> > > The new requirement, GNU Make 4.0, was released in October, 2013.
> > >
> > > Raise the enforced minimum GNU Make version to 4.0 and drop the
> > > now-unreachable compatibility code for older versions:
> > >
> > > - Add an explicit "GNU Make >= 4.0 is required" version-check gate.
> > > - Simplify the "make -s" (silent mode) detection to a single
> > >   unconditional check instead of branching on make-4 vs make-3.8x.
> > > - Drop the GNU Make 3.x sub-make workaround, which is now dead code.
> >
> > Overall I agree on bumnping the minimum requirements to 4.0. In fact,
> > I think I did that when I did the Makefile bump to 5.x. However, the
> > macOS tools stopped compiling. We need to check the CI for that before
> > merging this.
> >
> > >
> > > Fixes: ffe29ebc0701 ("kbuild: sync top Makefile with Linux 3.18-rc1")
> > > Fixes: 5f520875bdf0 ("kbuild: Bump the build system to 5.1")
> > > Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> >
> > Why do we need fixes tags?
>
> Yes, the kernel didn't enforce this requirement as the minimum until
> around v6.10 or so.
>
> --
> Tom
>

--00000000000005070b065ae244e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif"><br></div></div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 7 Sept 2=
026 at 08:24, Hanumant Kakade, Suraj &lt;<a href=3D"mailto:Suraj.HanumantKa=
kade@amd.com">Suraj.HanumantKakade@amd.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div class=3D"msg-260954884333892=
075">




<div dir=3D"ltr">
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<div>
<div style=3D"font-family:Calibri;text-align:left;color:rgb(0,0,255);margin=
-left:5pt;font-size:10pt">
AMD General</div>
<br>
</div>
Hi <a href=3D"mailto:ilias.apalodimas@linaro.org" id=3D"m_-2609548843338920=
75OWAAM452375" target=3D"_blank">
@Ilias Apalodimas</a>,</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
I do not have access to a macOS machine, so I cannot check whether the host=
 tools still build with this change. If you have macOS or access to the mac=
OS CI jobs, could you please look at that?</div></div></div></blockquote><d=
iv><br></div><div class=3D"gmail_default" style=3D"font-family:arial,sans-s=
erif">The tests run as part of the github pipeline. If you open a PR there =
you&#39;d be able to test it</div><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif"><br></div><div class=3D"gmail_default" style=3D"=
font-family:arial,sans-serif">Cheers</div><div class=3D"gmail_default" styl=
e=3D"font-family:arial,sans-serif">/Ilias</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><div class=3D"msg-260954884333892075"><div dir=3D"ltr=
">
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"line-height:20px;font-family:Aptos,Aptos_EmbeddedFont,Aptos_M=
SFontService,Calibri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<a href=3D"mailto:mark.kettenis@xs4all.nl" id=3D"m_-260954884333892075OWAAM=
843157" target=3D"_blank">@mark.kettenis@xs4all.nl</a>, would you be able t=
o test this on BSD and let me know if you run into any issues with the GNU =
Make 4.0 requirement?</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">
Thanks,<br>
Suraj Kakade</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<hr style=3D"display:inline-block;width:98%">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<b>From:</b> Tom Rini<br>
<b>Sent:</b> Thursday, August 27, 2026 10:07 PM<br>
<b>To:</b> Ilias Apalodimas<br>
<b>Cc:</b> Hanumant Kakade, Suraj; <a href=3D"mailto:u-boot@lists.u-boot-pr=
oject.org" target=3D"_blank">u-boot@lists.u-boot-project.org</a>; Simek, Mi=
chal; git (AMD-Xilinx); Begari, Padmarao; Simon Glass; Markus Schneider-Par=
gmann (TI); Borislav Petkov; Michal Marek<br>
<b>Subject:</b> Re: [PATCH 2/2] Makefile: drop GNU Make &lt; 4.0 compatibil=
ity code </div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-size:11pt">On Thu, Aug 27, 2026 at 04:29:29PM +0300, Ili=
as Apalodimas wrote:<br>
&gt; Hi Suraj<br>
&gt;<br>
&gt; On Thu, 27 Aug 2026 at 15:11, Suraj Kakade &lt;<a href=3D"mailto:suraj=
.hanumantkakade@amd.com" target=3D"_blank">suraj.hanumantkakade@amd.com</a>=
&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; RHEL/CentOS 7, a popular distribution that installs GNU Make 3.82=
,<br>
&gt; &gt; reached EOM/EOL on June 30, 2024. While you may get extended supp=
ort,<br>
&gt; &gt; it is a good time to raise the minimum GNU Make version.<br>
&gt; &gt;<br>
&gt; &gt; The new requirement, GNU Make 4.0, was released in October, 2013.=
<br>
&gt; &gt;<br>
&gt; &gt; Raise the enforced minimum GNU Make version to 4.0 and drop the<b=
r>
&gt; &gt; now-unreachable compatibility code for older versions:<br>
&gt; &gt;<br>
&gt; &gt; - Add an explicit &quot;GNU Make &gt;=3D 4.0 is required&quot; ve=
rsion-check gate.<br>
&gt; &gt; - Simplify the &quot;make -s&quot; (silent mode) detection to a s=
ingle<br>
&gt; &gt;=C2=A0=C2=A0 unconditional check instead of branching on make-4 vs=
 make-3.8x.<br>
&gt; &gt; - Drop the GNU Make 3.x sub-make workaround, which is now dead co=
de.<br>
&gt;<br>
&gt; Overall I agree on bumnping the minimum requirements to 4.0. In fact,<=
br>
&gt; I think I did that when I did the Makefile bump to 5.x. However, the<b=
r>
&gt; macOS tools stopped compiling. We need to check the CI for that before=
<br>
&gt; merging this.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Fixes: ffe29ebc0701 (&quot;kbuild: sync top Makefile with Linux 3=
.18-rc1&quot;)<br>
&gt; &gt; Fixes: 5f520875bdf0 (&quot;kbuild: Bump the build system to 5.1&q=
uot;)<br>
&gt; &gt; Signed-off-by: Suraj Kakade &lt;<a href=3D"mailto:suraj.hanumantk=
akade@amd.com" target=3D"_blank">suraj.hanumantkakade@amd.com</a>&gt;<br>
&gt;<br>
&gt; Why do we need fixes tags?<br>
<br>
Yes, the kernel didn&#39;t enforce this requirement as the minimum until<br=
>
around v6.10 or so.<br>
<br>
--<br>
Tom<br>
</div>
</div>

</div></blockquote></div></div>

--00000000000005070b065ae244e4--
