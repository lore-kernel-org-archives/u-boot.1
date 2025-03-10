Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40E1C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 11:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B31A8003E;
	Mon, 10 Mar 2025 12:50:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RIAsrLOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5415811B2; Mon, 10 Mar 2025 12:50:17 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89C3A80017
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 12:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so3002760276.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 04:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741607413; x=1742212213; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xRHtbyLrkCb2ijU+M1Fipt+IgGgek83+WaPv2UzaNOg=;
 b=RIAsrLOjPN4CzaI9Lavzq+zCfrhsWYUHQajnb9uaAFQe8Hwtpb4/GsLFrH9NIcK27P
 L0s6kw5pfRMGL+jh40rchECXvQY8Mjs4SQmS4Q0q6rIO38pFDg7sW+0mlbi1Xfao+Jja
 J400vuu1hrG/+EfJEZ9CdfHrKsLPU3XeO6Dl3O6Sl6rVZQeTHzf/vWUlbr5J2VnBzSV3
 gJ/GWeXvAthyqKf2bdalmG3PfP7fSUClARuh7PZx43GPrb74S+50P+6F2QZCBLNsMgwn
 SwMjOCMMUWWBqav2+wniGHgcIoZ6Zmz9rL6HNYNVS4jb3JqVWiAhJG2dcMPaS2n9vVPE
 73Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741607413; x=1742212213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xRHtbyLrkCb2ijU+M1Fipt+IgGgek83+WaPv2UzaNOg=;
 b=fsIp+FNG77htyYZHuH4g1EQBtPwzx8uaik/+FrnVVUgYWLjq2oUAi4XWKPS9EJ3R+n
 lgSrFMSYkkf6r0df7sXy5g9kNjW+K3BQZjZEGV/9LAulWiwuR7K7iEzPXtT0hTFDwCe/
 FbGr8ThvChVIrYzo8y7aGBPEP86j5YWbOhYM5KbQF68HSXDijGNFyzyDLaz90npw2uD9
 kYOt5hGl1J6qJmfDRwwvUN7K/IBGIEDTjqeNLI0RCMpiCBm4Vb7AkcWMJssc+oOpP78Q
 kSGrLYiLDsyNvl3L1lvNExz3N+HRD3AWUH8Y11Wpxqn0WB1fgwAS/CqrpG1uQN50aoRo
 IU7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNTDBY/3QomFk1eoeH8s/qmH/yL/jbeuw3ODlZf1AMn+U3l7yZEiv250mTPC2KTxSKS3VRRKk=@lists.denx.de
X-Gm-Message-State: AOJu0YyJbObemXxfM3uGiamHd7X/EswUt6N5+MpRiYxDb9Zy1AeYg179
 eqcFcB26mAybTuS2yOyI3jEOHQl1/JD2rIe73ACXlVhipJtwZtTwWjbARBxJSSx571d1MDOwDcd
 ph+GkUZ/fGZMU+bRZLlbc2gmRfB2A0MkiZlepEg==
X-Gm-Gg: ASbGnctpeyAEsiJGjKYyfbq2DaXVLbfoyfuAqWV32xJns/oDbWJxnGqRGDvBGLRw9ih
 MQn2LZobmWuK0ipK5galE1hjbvrFjzuNwwq4E0YCbf8XUkpNhRZZnMRvrf45gbCxdYbXTzKiQ1V
 DC6j9PFiZj4YkMiVyLWwAYur/AdiZUiTF3JsMLKw==
X-Google-Smtp-Source: AGHT+IECVab20AuHy7TNw9iSFsGhmdM8EylTBTlVNWOtIxTXQY8c+wfGWkUobrQLCVpIGVOZjsaPgihSCvkcFTrqx94=
X-Received: by 2002:a25:4cc9:0:b0:e63:7760:4849 with SMTP id
 3f1490d57ef6-e63776070dbmr7008800276.41.1741607413264; Mon, 10 Mar 2025
 04:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-2-jerome.forissier@linaro.org>
 <cb301142-b76a-45ff-ace4-39e58d9a8de7@gmx.de>
 <26ec5905-e96a-4ff2-bdea-652eb9031ee3@linaro.org>
 <CAC_iWjJ6p8+2vV38rNPq0vJcAwY9iED=U129sYJxH=DL20-8rQ@mail.gmail.com>
 <CAC_iWjJu+Skm-YQ_Ri56EVtywy=HRuMm2gmqm7DaKXtRmVje5A@mail.gmail.com>
 <176aa79c-fb7d-4fbc-9e1b-912617ea2538@linaro.org>
In-Reply-To: <176aa79c-fb7d-4fbc-9e1b-912617ea2538@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Mar 2025 13:49:37 +0200
X-Gm-Features: AQ5f1JomgKakBOhPJpO4M1DbCH7fGiR13M9l9wEqgYuhCdjdkXpYNplcvElWSRw
Message-ID: <CAC_iWjKdpnqHibmM2J+u8Bt59GxiD83aCt2NjD4pAvEMmA_c+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] net: lwip: extend wget to support CA (root)
 certificates
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, Michal Simek <michal.simek@amd.com>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
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

[...]

> >>>
> >>
> >> FWIW I think this still makes sense for peopke that don't want or can
> >> not add the cert in the u-boot binary, but can add a signed script to
> >> download it on the fly
> >>
> >> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > This still stands, but there are a few warning/errors on the entire
> > patchset. Can you address them and send a v3?
>
> Which warnings/errors? Which config? I see none with qemu_arm64_lwip_defconfig.

Ah my bad, it's checkpatch that has all that

Cheers
/Ilias
>
> Thanks,
> --
> Jerome
>
> >
> > Thanks
> > /Ilias
