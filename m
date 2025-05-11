Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B81C3ABC3
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 22:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C69258091A;
	Mon, 12 May 2025 00:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hEBKWAg9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 300D580F03; Mon, 12 May 2025 00:31:23 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7DD2805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 00:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2d071fcd89bso1389014fac.3
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747002679; x=1747607479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvhv41M681ElNzI6CRhuP0ZTSKE/fogcQPnLSpkQ4V4=;
 b=hEBKWAg94B4Yvqfq7Nbjf5P1JlY5fPq9FcrB+T9vOTaBF6AbxVcx/fsQiqJ5bp1GST
 F6yYV0XYbfkZA1jqFNQ17muXhqvXmwBEGdHQIDA7+qWRnwqEkzDox91T/OI51iByAqNB
 yYHFgG7IyfHeSBhRLx4J3SgD+zQoD8NrhUoPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747002679; x=1747607479;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvhv41M681ElNzI6CRhuP0ZTSKE/fogcQPnLSpkQ4V4=;
 b=R1Q+EdPoSI5z+RaFmv9MCmFYswONE8GB8VFePbKQtp9e7Ed+ANWUdewTMjUPejTdQu
 uLtMROorPVzZF1896kbacGZHvqTQG9zZTGkhMPPy0aKaKZMXUxbddhe04ie0IV+AtURc
 ySlNv3o72JeNumHFt8Iuay2D/IFKcePSMOoRxIWRH+KMI4yD6L4rvgOwafFrJZRT2idp
 AxfZIBcbSxLiMKsd5WnF9TA+AYrTMSU9/XbI/Gzyc57lC++TXtciT0QgfLsdGtVYm+Si
 M1KamUKvHukemjeADF2xQPrubpBZ8c2Dbx960ToD+ZnN7pvZdHcX4rp93OEb+TEZB80E
 bhjQ==
X-Gm-Message-State: AOJu0Yyxk+NkS7Xu/GMYLZSs1WZI8Wev0jragZMl/IsNh+cbq0EXCuWv
 J6UanJOqc8ebvygECho+Y4JvcOhGOBbA+MtTPT4cN1DUqhZ0YF+ivX186AknT7c=
X-Gm-Gg: ASbGncscVeWhl0f6prmYcV38G3pj5TZSez6lNq63JtgRUdRNBlK9z1qP0msTXwoDWde
 i13ajQIiblS6F0oU4HaUIEOsu7YWBiD/vQIpKGappqPXWGrtDLhpsWLRFweLhD8qi2qYXOn8o1p
 lqe/kUl13ZzNK30PCi0Q3P0Le5aVGpY+t7VsfXG9QxM5fUXWI9jP/JMxNfUT30QuiTSiVr23w2e
 VmetnK0G+2feU/1EuxkQXNAsmwlj2JyBdl+x5TpuQXueUzi3dPJ3wXEfw/IzvX9qTd0g2adXvGW
 IKsQQWXdZy59cjCfzHNih4rBZCfwWfThyk3/TFnuYL6h3nyf5gm/sLNdonlqwZwTb2SsSlE75Cm
 ISCAA92w5U+U=
X-Google-Smtp-Source: AGHT+IGr9x+hoYjF+kE3sarovZwLdaA7Fop9jZ87oer1WFnoMu6RWSaPnSmtIMRDlestm0WJiNL/jA==
X-Received: by 2002:a05:6871:80d:b0:2d9:9c91:ccde with SMTP id
 586e51a60fabf-2dba435b230mr5054962fac.22.1747002679432; 
 Sun, 11 May 2025 15:31:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba06ff158sm1591210fac.19.2025.05.11.15.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 15:31:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Adriano Cordova Fedeli <adriano.cordova@canonical.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
In-Reply-To: <51013587-5ef3-46e5-9e7d-d045cca9c14f@gmx.de>
References: <51013587-5ef3-46e5-9e7d-d045cca9c14f@gmx.de>
Subject: Re: Pull-request efi-2025-07-rc3
Message-Id: <174700267789.1013542.14046763193757037343.b4-ty@konsulko.com>
Date: Sun, 11 May 2025 16:31:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sun, 11 May 2025 14:30:28 +0200, Heinrich Schuchardt wrote:

> The following changes since commit feb55165233623648cb0a74953735b00ec6e322e:
> 
>    board: ti: sec-cfg.yaml: Fix OTP write_host_id order (2025-05-09
> 15:10:33 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-07-rc3
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


