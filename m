Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7E6C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FD1F87772;
	Sat,  2 Dec 2023 19:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z7Tsj7N+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95B4877A0; Sat,  2 Dec 2023 19:31:53 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1E38771E
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a1a0bc1e415so215292366b.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541908; x=1702146708; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BumfvX1wwjTql8E+psE/WV6ZXCND3Lakb52ZgzVW5jA=;
 b=Z7Tsj7N+yy2YPRZIMzYyRgS6ED21b75gxDEc1TxPlK0B5zsKomSFPUOzBUoJi4FEgt
 e/2pIOElv5YTlNp3A7LHdJBbsBzFj81tqUReajxHZY3xnLk0S5+eHDkke3+9WUvZJmCO
 DbFruWD0Qpk6/4ATkrFR7EdG5JPxQx9UeuDA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541908; x=1702146708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BumfvX1wwjTql8E+psE/WV6ZXCND3Lakb52ZgzVW5jA=;
 b=AP1PFmCErdWaAfO3HOuhPsDOsoYzLeKQLMUhO86mVJYz7qRZ+xgHwkMpxFDsHNsBFl
 D15r7Ydu0fO775wEHydyTJDP5qnRypeome8+vG5RIi94X+tzP5Lw1pmcxniV/y0abYY1
 gJJ1Ewmyz6IU2ttIKnK8MQ5E3oXPJUfMOFBRdqEQSHZatHpHoexEcxf2Al2Kajpn8Pjo
 MOvHj6J6IVaGhfbVJoagF1xh4z05AJKlKVy+3s9zjS+QaP3YYlz80fRi8WVigKgs0BmI
 1Ewx5qOfPhBF+nb+qgN/rqWtH/Cuxwgm8VSc87W+Wy+x9QTmmQS3cSh/Za1w4W/oGMxH
 6cJg==
X-Gm-Message-State: AOJu0YxCQYlwuaADqted/hPNCUW6AiplFcAlbHW18ML4i/DpTEJ4pz4k
 mlV4OMejbydeLv3etodXTyi1Sy8G2epMCB8uSCOSxw==
X-Google-Smtp-Source: AGHT+IEaxnHJzh351lo5MeVwMyj78TH9PS9T7+wmLNaQW7K1+E3pEd8pUPxOXTgsUfVaxEOMfOkmi1CbUbqsQ6fTyo0=
X-Received: by 2002:a17:906:5:b0:a17:95e6:d47e with SMTP id
 5-20020a170906000500b00a1795e6d47emr1717415eja.77.1701541908408; Sat, 02 Dec
 2023 10:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-5-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-5-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:25 -0700
Message-ID: <CAPnjgZ0novAPkxYpD6m=nnYGU0CYBg7rH9NgNO-COt7NH0MNBA@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] bloblist: Set version to 1
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
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
> The new bloblist for v0.9 has version 1 so update this value.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Update the bloblist alignment to align to FW handoff spec v0.9.
>
>  include/bloblist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
