Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F373E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:28:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDAB58022B;
	Wed, 18 Dec 2024 13:28:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rLeU9FIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFBA680243; Wed, 18 Dec 2024 13:28:27 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D460F80214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 13:28:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso42881835e9.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 04:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734524905; x=1735129705; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5VAb2nhpe/UPOIGKe1GS8o0hcq7S3Zkjyy5dDnnVHVc=;
 b=rLeU9FIjXPiS73DWUA/mI8AHjrb9gDM9c6txAiY0P6x5zWOLDEzdYc/HHViX1Xl6nd
 QqZArKYlSGgsAA4ClHqx63DP6Ylmc8LxJA+zRp8EDko1DqdZhBN0qWIyJ1Wg1YYFXCjn
 IEKFHPAQxmUY3mjLPVKsb3jkd47kWfAdGosvdTJnE9g5HpO9hrMca4tsrfwOVP+55frm
 Aaa0K1g6yMvK7okt6nK/TNlBXt3vTrOwP1H3Xqv1VxIQJ+jb66QTOIM4bUFlY9MlBkSl
 fmTf/4PVLcDuEme+bf0wYzCI9NE02kopyGzuqyjhEd99HzG5gs7AN6v8yB0Tm0gd+8FR
 DCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734524905; x=1735129705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5VAb2nhpe/UPOIGKe1GS8o0hcq7S3Zkjyy5dDnnVHVc=;
 b=Gq+1Wau9x3QrNkGLEwANfG/Fd05HINpYHCpAVhioujfRovVSbcQJ1asZsz2uZgTDL+
 GHDmCb5O0n8nMQ+IrF/RjOLyP3chn3im0/88CYs4mQ5Y/SCVdUekCpuk3OvwBc/68tYX
 8W5QnaslWR8btSy5Jx8J1xS4zANqCggr7LWZKoJ8xTDX5tmXPDV9L5wNq66J2teivDFE
 TjN+MH/G5YdpGljzmPo6h7g5bFhPWnrpSwpFBzdthOJJ3GyrFVV+V90ehmfl4YELq2hR
 2fWQPtbCtAx5y2DOii7C9+CEx4y30iXRiBs/yFVPVFr/nhZIhSIcqpIxSdQaOv45cJ7x
 v4cg==
X-Gm-Message-State: AOJu0YzShvvfkCDlsTnRQABf+AbfEmkVOjWQ4DTCGKu+gBcqBuxc4rzt
 UqMyQdcFx6TiOktz4s9tMfOToFLlenVQHG+TkUn4owuT7wKK9R4v2nH37wI8YNm9Eo17TamfK7j
 3sGw=
X-Gm-Gg: ASbGncvcrkRUL76mx8Pr0I1AyzHnGYo+sOM6nZA2ov6r99tFZ1mUWSO8yafrKI6IOUc
 A1LveTuN1X+MmnGI6PQDlEbLuAFDkDhC39HUuzCzER2vW6uILtMqYDQwbzDBGUh4M1mcDS1zfPf
 IMesz3bXCUmZMOG6N+Kc+1Yll0ZAQauIFpxACzOC5p4x8PBARht4F7mRfLyYvVY4Nj/ppEBBVkU
 ITVmG/NmOsP0g89nUvO5+64qGYHiZeYn0dGqszydx/tTxg7bSjb9YNmTUi92myzvDSR5sXl4le7
 LvFWUQwbLJEu966Nx+EqlaMO0bWtDKDbxmQl
X-Google-Smtp-Source: AGHT+IG+ZcfvbzGjWo0i1NG+Se6wihTxUZXSA2oS/p79SmBgHsPeH5AC8t27cwO+I6mRMhRg2WwJ0Q==
X-Received: by 2002:a05:600c:4f11:b0:434:a802:e9b2 with SMTP id
 5b1f17b1804b1-43655347900mr21811925e9.4.1734524905198; 
 Wed, 18 Dec 2024 04:28:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7a7b:97ce:b355:53a9?
 ([2a01:e0a:3cb:7bb0:7a7b:97ce:b355:53a9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c806086dsm13820845f8f.91.2024.12.18.04.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 04:28:24 -0800 (PST)
Message-ID: <6c3823aa-43bb-4e37-84f2-4a8c5d2991d5@linaro.org>
Date: Wed, 18 Dec 2024 13:28:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] common: board: Simplify array with function pointers
 with CONFIG_IS_ENABLED
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
References: <cover.1734448827.git.jerome.forissier@linaro.org>
 <73f839b31900ffadcea27a6d58bd9ac5d65a9f1c.1734448827.git.jerome.forissier@linaro.org>
 <CAC_iWjJvjS7rNx+owtGPJ8cg6kQrP-spnzTSz9TjVYbErPCx4g@mail.gmail.com>
 <CAC_iWj++BP3XPfGE=Cr+S+SMQJcopNRHS1NVbFsUASTvR+FsPA@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj++BP3XPfGE=Cr+S+SMQJcopNRHS1NVbFsUASTvR+FsPA@mail.gmail.com>
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



On 12/18/24 13:15, Ilias Apalodimas wrote:
> On Wed, 18 Dec 2024 at 14:03, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Jerome,
>>
>>
>> This doesn't apply on -master, can you rebase it? OR was it meant for -next?
> 
> nvm it's on -next
> 
>>
>> Thanks
>> /Ilias
>>
>> On Tue, 17 Dec 2024 at 18:00, Jerome Forissier
>> <jerome.forissier@linaro.org> wrote:
>>>
>>> From: Michal Simek <michal.simek@amd.com>
>>>
>>> Convert all simple cases where current ifdef is used with using
>>> CONFIG_IS_ENABLED.
>>> The change doesn't have impact on code size and it is only cleaning up
>>> description.
>>>
>>> Checkpatch is reporting issue:
>>> space required after that ',' (ctx:VxB)
>>>
>>> When space is there another warning is coming up:
>>> space prohibited before that close parenthesis ')'
>>>
>>> but there is no way how to fix it that's why leave it like it is.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> Reviewed-by: Tom Rini <trini@konsulko.com>
>>> [jf: s/Simply/Simplify/ in subject]
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>> ---
>>>  common/board_f.c |  49 +++++-------------
>>>  common/board_r.c | 128 ++++++++++++-----------------------------------
>>>  2 files changed, 46 insertions(+), 131 deletions(-)
>>>
>>> diff --git a/common/board_f.c b/common/board_f.c
>>> index 54c48d42ee9..a4d8850cb7d 100644
>>> --- a/common/board_f.c
>>> +++ b/common/board_f.c
>>> @@ -872,12 +872,8 @@ static int initf_upl(void)
>>>
>>>  static const init_fnc_t init_sequence_f[] = {
>>>         setup_mon_len,
>>> -#ifdef CONFIG_OF_CONTROL
>>> -       fdtdec_setup,
>>> -#endif
>>> -#ifdef CONFIG_TRACE_EARLY
>>> -       trace_early_init,
>>> -#endif
>>> +       CONFIG_IS_ENABLED(OF_CONTROL, (fdtdec_setup,))
>>> +       CONFIG_IS_ENABLED(TRACE_EARLY, (trace_early_init,))
> 
> This looks fine and I am nitpicking but the last comma seems
> unnecessary. Can we remove it, or that's just CONFIG_IS_ENABLED()
> works?

The latter. We're building a list so the comma has to be part of
the output.

Thanks,
-- 
Jerome

> 
> 
>>>         initf_malloc,
>>>         initf_upl,
>>>         log_init,
>>> @@ -885,16 +881,12 @@ static const init_fnc_t init_sequence_f[] = {
>>>         event_init,
>>>         bloblist_maybe_init,
>>>         setup_spl_handoff,
>>
> 
> [...]
> 
> Thanks
> /Ilias
