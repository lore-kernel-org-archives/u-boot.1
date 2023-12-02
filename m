Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C791C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40900877BE;
	Sat,  2 Dec 2023 19:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aRbag0/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76CA86E82; Sat,  2 Dec 2023 19:32:16 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD184876FF
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1a496a73ceso230175866b.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541934; x=1702146734; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Yme1vJjtA1NPPLCFxEoTSmgo6rqOcHni6QLPmkZCcs=;
 b=aRbag0/8NUhpcncpLO0x0LtGMOscTLqzMkplFd1POjHSBXGBRkDpl06p2nyQaao4Vm
 1gqU/fV/jqGbzbMWYnYI9YMKvnvkYs0eh4Mc8FoEbTJST1i0d6c/p0FqqxqjaYpLs9os
 2/U0GrZOmsBD+fAqKLZUO/qQrAbPL6thbk2z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541934; x=1702146734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Yme1vJjtA1NPPLCFxEoTSmgo6rqOcHni6QLPmkZCcs=;
 b=rtMZ3kicv5hIhPP1S/tGLOsiwbQd60TFZR8wtVw+E91AjgwzBXsr3CiSL98l6nnT2s
 oVNKWooLDymEjmObh9w6sBnmq6zz69nrE6E/v6bIMmv23r9Ye7drB8csaJyv685K8lJ7
 FoJor+4HT73YkAhutWgdEITASfM2FpUuIQPJCKX4h+N4ukcxfuzltdcB2kGipcXq38PQ
 lzUvfigIB7QZQ+AfX8sWVaRayIGQ0jgusail3rtCa4O80U3NJqvS0HbU3d3wyiMdSTpH
 PzP/JYVb0ZPYAcnGG+t4A3D1L6cOnYjEWWFr0aFZ0m6/NrrhbYMuHwIOfYS2R+WlOaOc
 d6hw==
X-Gm-Message-State: AOJu0YyyZt/hZOnYGH3Fhj+qToGGPDi/hp12jiBc2fmsbCv+9RLHPU9l
 hby73zPF7IWnpc/qz1AvqTuvW4Oqms7drlLC6yZwBQ==
X-Google-Smtp-Source: AGHT+IGoQWfmKtclfAlkEsb08YXan2E5JpCykWCiqlpF2MjNXWXg9aQjmiAhi7ThLP8Gd4aQ//b9S5q0rd1mgQsT5GI=
X-Received: by 2002:a17:906:224c:b0:a19:a19b:78a9 with SMTP id
 12-20020a170906224c00b00a19a19b78a9mr1487717ejr.108.1701541934171; Sat, 02
 Dec 2023 10:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-15-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-15-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:39 -0700
Message-ID: <CAPnjgZ3OBDMR56HdTDadMDQShX1_v_5rC8dFodr_0ZtUPj1UZQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] bloblist: Update documentation and header comment
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
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

On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Align the documentation with the v0.9 spec.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  doc/develop/bloblist.rst | 4 +++-
>  include/bloblist.h       | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
