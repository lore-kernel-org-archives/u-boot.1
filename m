Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51D6C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E2B687760;
	Sat,  2 Dec 2023 19:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OHy4k0ZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48B2C87760; Sat,  2 Dec 2023 19:28:50 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 665B88773E
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54c64316a22so1960633a12.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541728; x=1702146528; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EA7n6MBaIOvh7BhJgTY/5xjqKqmjUfqfvaAfa+j90H8=;
 b=OHy4k0ZIH/S2J6nOpm03EsCV6m7Dlga7nNynVrdaeDPagugHHE3JB47cdz45RKj6Nq
 cWKfadxiNlv3D00a4NrHbZS819jI+XyIXJhKQ/9uAT90ok+FkRMO9d1rLlECkZWGX79c
 bPc5zdGOt4uC/F7U0ewHofk/AAB7qMiHw2TMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541728; x=1702146528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EA7n6MBaIOvh7BhJgTY/5xjqKqmjUfqfvaAfa+j90H8=;
 b=pLZsKP6RifAfelv8fD/uFt97RNIGd6D/QVJoD3sEPLI0fFu6B4lAe24Gy3Q6Yp3Oje
 VY/U8Yu3dyABqaPRbOH815e4RsrY5WV03/v/ZKVafXBn+lXke8I8rOUjEy4Y+if9kXPM
 i9bdROLHRetTW8ALYBhogvXHfM862WSDm0tcs6sVwT4egKLSqDHDok6hdwXXbO4oCbiC
 /aTjM4PyMj9uS63z9+j7GFs18yrwl4LvA/VbVG9Dn+okNj4HRHLf/uTrVdI3uqNnassc
 RSn5z+1gZsvIWeCzCcoYWAg/9RDiyJRq087v1MoOll9pdrHdmUN2GqfCqdTbuW4AlgN5
 d6mw==
X-Gm-Message-State: AOJu0Yz7xCp1g7rfdOVm/F3VCRspBvbHk2h9i6xf+QawCw1Qm2xZ/3X0
 h6AYAHbpuJxnTXCvvoOuJdnz4jZOVotgrTj5Hh9dDQ==
X-Google-Smtp-Source: AGHT+IEEN6gwT6XZLabnmK4WWAfr+X5Mzi62CM2epeTbBExYjdjE0lF36ULpNRHADV0ONTfYrqP677Bgp+/DeWd9tpU=
X-Received: by 2002:a17:907:515:b0:9fd:cc75:3393 with SMTP id
 wj21-20020a170907051500b009fdcc753393mr1881294ejb.20.1701541727717; Sat, 02
 Dec 2023 10:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-6-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-6-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:27:18 -0700
Message-ID: <CAPnjgZ0GN4h0f83vVBb4CfuaAh-640OSSovXJgT7uFPuyJaGaQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/18] bloblist: Access record hdr_size and tag via a
 function
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>,
 Qu Wenruo <wqu@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 27 Nov 2023 at 12:52, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> These values currently use a simple field. With spec v0.9 they have moved
> to a packed format. Convert most accesses to use functions, so this change
> can be accomodated.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  common/bloblist.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
