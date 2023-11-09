Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A99C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 01:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D715F87128;
	Thu,  9 Nov 2023 02:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LJXwR60G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77A3C870DD; Thu,  9 Nov 2023 02:15:40 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4550487033
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 02:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso392187a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 17:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699492534; x=1700097334; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EqJqv9lzHcISmEBZwdmPPbbwoER9UKKyFb/pCXFnGtU=;
 b=LJXwR60G0GO9NQ8wTVOSz1n5iy1afA4yWTRWaFrqBWlJ5O/SFB6Hkhz2glbjbNvURZ
 mgCJGGs60+2B/Wv+Gb6h04l1FiFKIAotR86sa00FnJ48dDX2jkfsR8W5gRdolu0AxHhT
 3flKMig4bKpW97iRH8ugxfwKd1yt/uW3rvDOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699492534; x=1700097334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EqJqv9lzHcISmEBZwdmPPbbwoER9UKKyFb/pCXFnGtU=;
 b=k3iAD9bq/f0c6rQqCxcSWTnuRtjxW0MGVNU06wyLOriZdgFAU9KiEsRi/Le9ml2Rz3
 22hnnb1w2t/mxh+VM3kDlgh/3RtSszXu8sSeucY1mrJzJpMAI9YBgxqWP+QzvCNs9irI
 YaapxL5krq3C4KyQvvwj5rwuqOPN7CtLvKlk8b6GA8S8sBIeEppf0hTw5VE6dftqwGSQ
 v6RCgv5fG6xgTZ+rFyXz9Zk2fM2/9m94KbB/k9B4Er683UCFBx0y7ZpE4+AEsvTWrV/y
 /O5K3iLDdK/zZn5hIUqQXLywAS2tTe5UgXvCTdzroXWUBEI6AFpkHzzQmvvtcO23BElh
 icNQ==
X-Gm-Message-State: AOJu0YzRiRTHI67gXpdedB9QmOFDmkakQrlwp++tK571IrY98b7JXJh1
 Q7CuwjNzUWOFccfACBiwozOJR/S1GpeBwE049RAO3w==
X-Google-Smtp-Source: AGHT+IGC8yfCdGJqtc0NvMuhTeU55wtKgGJcwHEQYhesuwJowc+wxmEDbJffQZfIA3tNLBXXOVVmIA8gcrFO+JOkXOk=
X-Received: by 2002:a50:9550:0:b0:543:7478:64db with SMTP id
 v16-20020a509550000000b00543747864dbmr3113239eda.15.1699492534203; Wed, 08
 Nov 2023 17:15:34 -0800 (PST)
MIME-Version: 1.0
References: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
 <20231108110637.3691441-3-masahisa.kojima@linaro.org>
In-Reply-To: <20231108110637.3691441-3-masahisa.kojima@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Nov 2023 18:15:22 -0700
Message-ID: <CAPnjgZ0dgv5vRsMP4FHffhY1Mhi7ZLqwU8HNzVnZ0nuDS2AZOw@mail.gmail.com>
Subject: Re: [PATCH v11 2/9] net: wget: add wget with dns utility function
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>
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

On Wed, 8 Nov 2023 at 04:07, Masahisa Kojima <masahisa.kojima@linaro.org> wrote:
>
> Current wget takes the target uri in this format:
>  "<http server ip>:<file path>"  e.g.) 192.168.1.1:/bar
> The http server ip address must be resolved before
> calling wget.
>
> This commit adds the utility function runs wget with dhs.
> User can call wget with the uri like "http://foo/bar".
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> ---
>  include/net.h |  9 +++++++++
>  net/wget.c    | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
