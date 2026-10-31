Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E56606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WufWxaIq;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WbPfVdQy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8821C40B5C;
	Sat, 31 Oct 2026 14:06:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DBQ4tgegQgDc; Sat, 31 Oct 2026 14:06:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC2C640B6F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455581;
	b=HCxtQ8MrSRCjjyaZ/tc3fcsXlgsvE3Z53jM1XbhvJqbiO2M+hsfUrOcPvEH9KPylWGQY
	 aNp1zS+hyeQ1dZTVaxTUlEfe+R8FrlfZ/ROILgfgz1v7hMgo88urwUz62CVYpt3FnB4Ke
	 J9KZ8bkpGJaM0qLUq3hIm+4ptEHUOU3NMGpXSQm7ChGnnXyXdy28K9Vutm36A3K3r5bdw
	 8oaErN9peFP2UFBNF4xRd/szBP64BSfHk+LJxgcOKm00oglp9t8hxudxm6GrjRFgkHgcM
	 z17pELQRxZ5NsQfablMHM+g0J54sI+GhXaDk9ejs7D42p/KsR2vhYO4EMK+bae94AAw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455581;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Llex+Oxo1L7pfJU0Lub/+vxHpIqPusz72NcllSfDTV4=;
	b=iN/ufRKWUjiMkvBy+jh7gcHqItzYz3PcyDsbbAZxZfjnrniIPTV8oiz3LyZM3dmyL720
	 06zIpy77aAf29LDHA8YHpWie2ZX2CVs52rudqL2F2ublfoZACavvLF+vmM//ofkin540Z
	 Y0VS6amUDm2iytnRL0zXCUsg2SnakZ1Kt3UcwtsYNOJk7cWbDXDS16MbYXnUiDjVPdsep
	 q7q8zXR1RKDFvF59tb7cdx1TNbtP8FmGCLhstOkiqXQRTrDclG+TU1KFaQi77PbRLfeyH
	 Gjdmc/ElUeEj744Qgm+xBD26gfK3iSqMHLCOIhn0bXpIqO/tfBEas41EOicxUR+3wlA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455581;
	bh=Llex+Oxo1L7pfJU0Lub/+vxHpIqPusz72NcllSfDTV4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WufWxaIqlnPI9/TkyWGctckRFZlja7TjCtL4TUrX2sJwSmQvsREvUAF9J6zQXQ/Gy
	 mJFLbl1YNP0EwhYtAqB9mBobmaqilDSvIaWVP3CAU4t6/zrrW0rdMtSU2kzGS0kN6q
	 zLiSxHUT71R/o6XE86g1DbZYGoGm7JRbMdHomKXrg2mj4cDkv+hAWjyHvkRWaBJyaR
	 9lRugqb+euzdTHB/xlcrbovMWK5a2Gl/9tnYLNz+o6GsDPyxivaihWLXYm5s1Lycno
	 046IVE+4IpiQP2/yRD0WI1WSf1wyCojr/LluzCPVkC8YxYLO4rKkEM0gywTxBLyDHp
	 rORrRE6kOohLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC2C640B6F;
	Sat, 31 Oct 2026 14:06:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CFCA1DE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22D156061B
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qXOH01y5TPMQ for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:06:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 357E960634
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455578;
 b=F4ZZ/R6PiooCqB2rW1C4wYWOKFjTG+WH0TySz5U0k4iEEM7olQZ7bxofSLkwHR6vgjLg
 VJ/6irQaWeCdPtNnbb91M9M1CAu4oxDd/YDj3cuxQp/G7LpGK5LT/QKep8yrjlGffnsHQ
 Xce0e0EV2lJ0/imYLeKgjBw2Z7saOkzQXH4SV+15fH3RaD1ecWlK/qT5+do/21O3U1Efu
 YcIYlW6CBjWvlnGNUTXY6vXoiu5H9S7NJfbXC2otJ7bqehc2EZzFfb/nKr3zDn45Ei9XD
 07cVJHSEaTSQJpepXDjedHm23u4ZecEGhI6qaDMYRDE0BZJzryjZ74BlBVR5WkG2BWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455578;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Llex+Oxo1L7pfJU0Lub/+vxHpIqPusz72NcllSfDTV4=;
 b=Pwinnt0VuIiQn8ELJnu9wpylO8DBn7CQYWBqHL9tFMmGbQ4FB352StQpPfHlDIJbQdGl
 /1JGM8oPRyqeRQDFasmATKqcmCrZf5z89Bm6pzyuG9OZhdP4uiibdSfmfvzbK6eD6t2V1
 VSpKmRbzUgNPRFNt9+5SFUgnGP9RzFu9qjNDoGbspybrtuD64a0DWmUrbpY5WgMr1CrRO
 eUy6Y3ME7qoHie4CRMRxwon/vya5moOR1I02rUNmQA/snMTbMNqXkA09we68usC69+/+S
 ZHxTiEkRnPofhVmv59iBQo2TQgQLVH0mnPnZ/4cXT34EC4nY+4cfyPskQut0/uwDqfw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=WbPfVdQy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=WbPfVdQy
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 357E960634
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:06:17 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso2381898a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455576; cv=none;
 d=google.com; s=arc-20260327;
 b=GWFk68PvRiLxccF89qQQXZcnphfHm2X7ZklwK/xC5NT8Ev6ngjiRD+mDqQUAbhquUF
 VgJFiUx04jHo2mayzvQlp1gHfKq4q91NKHKM0XCL1uRmvhKSiO7bX9IbGIQNfxzsjhFF
 DQK3K8HLnImnDf69Ni9escAj1IHzib9RKqrL+XWjqYtGqxpPclqLJpyAiYrsvYn0VDr/
 dl3uQ04tkdpBERqTgLL7ojA42rjScH8WvdbV+6I09teOMETBdEf9OeM9mT8cCw7IlDiw
 +YT2aTOk75BzWxHxb/kWiAPl//MIwHlvsBQbU/j8Et5CTd5vn5Oah/6juUfC4S1RLj8u
 h9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=Llex+Oxo1L7pfJU0Lub/+vxHpIqPusz72NcllSfDTV4=;
 fh=RQj58fFzwr9pSs6IB3nvRQ9BqjBTpzYPHpG0Ox4GyMI=;
 b=lONNOyYIrVgrN2zixBJaeWE1w+DYrrlQuoMfIgIbgqi8cdbr++UAhMug0mu3T13KSn
 rdfCmPe1RLYUArBfYmY/6JQ083NPl8DUDAvJGGV5l75xJ4WYuww6DIUcsj/xkXicelKF
 ZHFwV10iZZvuXW1buOqfFTiPh0f9Bi+owF0tUFMMhK+Ug0CbR3OV0aVWGgePEJGpov7G
 QW1hstfJYKBQDKM3NSevyFfkTbJv6oj44hx+v2idcw89j/uM58S0GlEkaorq3xtdLDYS
 8rQj9294NWNVvcixte5fs5BlXm9vfD7NTNCmbT2NpZOOSlRuqTQfqw7qUZOySRkpiCrw
 dGQw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455576; x=1794060376;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Llex+Oxo1L7pfJU0Lub/+vxHpIqPusz72NcllSfDTV4=;
 b=WbPfVdQyWayX4Vq+aVpXGfd/5KYBldRedY3Oyg/KFAiunJYp65YMb1qOZgeFL6iK4c
 kbPTAN9DsPU8yOjQad4dKev8Ht4ghx1jfjJuIW9Ot502Dkv88F4WBSpBrb0IKXeJNmuy
 D+PM9N/DFwcuaGIfytNE7K834V+YCh8inQUmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455576; x=1794060376;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Llex+Oxo1L7pfJU0Lub/+vxHpIqPusz72NcllSfDTV4=;
 b=WQ23WoSd3WeTrurK1WONtaJ7VloLixz+vSkWDkpF/fcajxd2EooGHNv0UCUrrMyHGj
 W6wNnmHk6/iifRM52OUhEPt/hcfsoiWGctxn83FkEMq1jkNF8LqGewHZTbWu87j55Cjx
 ZXqgPuOyZjqMLc+9C1lINCZq/8hednHgGc9rvnlbqfD2uPiaj2BEW0wPyvyMrIX/WmIj
 mLZBpPYs4eiXYpCr7k68GHhbwmIBOhmuEJ/tuvvVZhMxbpV6Emb2IXWtEeKiouXpf0RI
 86y8Rvv4p5syT+4Z/ecpra7l+QEUN+Q/A3MrpGt9+ojTODK4e/vCGSn8PfVstjUMQHxk
 QJ4g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGfhtqiAPGVBKUIwsLAQv7KPbAyOp3aZ/Ac+btwxXS4cr5xTFI7jZqnyGTY3kP8QSkh3EJYVI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJup0jBYiqIafv9lbn3FI7QuiRgYTYIUl29shYBbOa3cKG2JaFi
 Wlbpn1MIFbx90iFp41PNzDucjf6t1+ukc12DyyVU90R0opUbY0/VioCqPSwVsOcmIrBQiMtB/ok
 MOzPvml149FsUxGQPUIMyycXcdTU5XZUs+5lq7CuH
X-Gm-Gg: AYBFou1mPo/hKxr47ttflQ6qmOg0R7v8uR3oYgGliaKwIYLZ4RLS3ukMFKx7/VR/0W0
 yq5oz9DUf9XTsGgmxh9ElpIUVQso/nziCyom56OKcWV3i6vX+uphKSyZ62nss4aJniw8tz4NMRG
 wcdYR0dbuKE3kFlvhgJo9ILUflMy9oiYKiwrlH50Kk0VrVOVuV9hghAnZlI8ynIAxdO6g+Q0gWV
 Lt0JwSoDtMPZUEmxwFo3ZnC0hzO1MY/KHUFGNmrtGg2vqF+OsA1vxpGarYwPJsUSurnKPqOahLZ
 eGqL/s/gDQM8Z8O/OBuFXEE7rr5pbdLfgbkyP0R0u/pAXE1gAaPrWhcra6A6O+NyTYp5d2g/KQY
 FXmatDRLazLf9C5ypTsVcKf3qKiRcnyyKNOQF/4bnHDhD7lIjYHhaLGzg3kV1Eu2RqoIOgYo=
X-Received: by 2002:a05:6402:8da:b0:6b3:cfa0:77cb with SMTP id
 4fb4d7f45d1cf-6b4b0bc4ad3mr4629477a12.10.1793455575773; Sat, 31 Oct 2026
 07:06:15 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 10:06:14 -0400
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 06:14:38 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029-main-v1-8-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <20261029-main-v1-8-b5a878627107@kontron.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 10:06:14 -0400
X-Gm-Features: AclHuK-AemhvgvYOgjGL_9JkaiSyXAj-ZWF6O4hTJeIkU2Ir-gqwNLjl--kdsXk
Message-ID: <CAFLszTgpVRvzHM9RyoSHMu6sC-UYaZF=Ek42tGpYh2af5_KDcg@mail.gmail.com>
Subject: Re: [PATCH 08/10] test: fs_helper: Support GPT in DiskHelper
To: frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Alexey Charkov <alchark@flipper.net>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> test: fs_helper: Support GPT in DiskHelper
>
> DiskHelper can only create disk images with an MBR partition table, so
> tests that need partition names cannot use it.
>
> Add a gpt option to create a GPT partition table instead, and a name
> argument to add_fs() to name a partition. With GPT, the 'bootable' flag
> is set as the LegacyBIOSBootable attribute, which U-Boot reads as
> bootable, and 1MB is reserved at the end of the disk for the backup
> GPT.
>
> Assisted-by: LLM
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>  test/py/tests/fs_helper.py | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
