Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67036C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 17:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E3D803CC;
	Wed, 30 Jul 2025 19:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aTdre+tR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C0A8304F; Wed, 30 Jul 2025 19:18:43 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3BA782BCD
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 19:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-30799a41109so52644fac.2
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753895920; x=1754500720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xC/IB2MgBZT2IFnEmGFFn1MSswTdmtke33h+rzMpk0Q=;
 b=aTdre+tRweURhZZ/mdyWslA7naxjZE31Jlm10wu8L2XSOUZyQvPcO5C7HO0IQjNNlc
 diGi1FoN3iuGJeOHHIErMCu2CCoCgnpx8/61NI+zs7bjbtYF2RlagxUNzky6juqVvRLU
 0qXdn9t42iuC+cGKF3dsuB57R10YA8qGCS1FA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753895920; x=1754500720;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xC/IB2MgBZT2IFnEmGFFn1MSswTdmtke33h+rzMpk0Q=;
 b=Q6LGW9oHb9tN+Whbage4aS7C9gl0EIcX6suejN19EmBFQcj9WMgfbTG5n5+gv4BPu8
 IuIm1hWSPDXOzeObthI+E89B/XjF20SQVDjccllkpN1VQ4phatxf+g/f6SGnZR4TR7au
 UNY5MkDJqayEysxBjHBFfRI3obVJG/iAXa2uHJkHF/FwbXqBQMUxdTSZoQ0DezdGtS6z
 Giyc7fY36gQLs1h448nPtdlKUzarhgR4uwBkudN1jgDUgcUzDMJxVeQwre9tNrNdYr2H
 Ncscbhy9fo+JeIrosv5nPY2W2pD4FdqI0x6uHVsTqRoJ6mRG0YrszhyQ3Wt5cUVdU3v6
 6aOA==
X-Gm-Message-State: AOJu0YxWcksVkcIyJ8qWHNZpf79+SkTDmGW1qY8thXj2IeiDl0YwdJLI
 U7YxWo2RtATqa7tO9YPs1+V5WQW+s6Pg5Qy6PChcwwMJhZFa6KLDlDcZyUVdbhCyRICTnC42mbk
 aKS9o7Ow=
X-Gm-Gg: ASbGncsI2xv3k8GcKFLzb5r3XP+lNB+h3vyD3JqJaC4/LHLAWLF3qHJxs/XgzEQSeSd
 63AXPF+n82Tv/Ito90cPtC+BNwwFyuoEs0j6jsmFU22FCe8MiHtobOi4l2sYItCYWFsb8I1IQxv
 aAfY7fuTxsezJSmUZkw4xsd6gel5pa32OviD24/PFwGlTEDtlmUvmYCthtElfm/+771NnmeZ/Vo
 hYnq4UKl/fJ7Enh/oCOC4TKPE1lq77+3CA9fb6SkgMSptqb7dfy65KZp7pjHrlO4tfOZqHEaT+c
 /QDLBbLfjlvPlZ6/7Sxr4/hVv2BlVpU/uSwG+X7N9gvbLyddPlJW9Cfh+KfNAk3iq9DyY4dOit9
 sXF20MKgEZijBTKAnEOfnPUvDQd6Q/D9NCrUaypjMbM2BnHrY8fc0SNM=
X-Google-Smtp-Source: AGHT+IEKGO8VPMMSttZD01l+VYxlpHy+Zs22O2QYxIaIHysrjQARiJgVjwRZAWdlVDV1yI9p4Ls9lg==
X-Received: by 2002:a05:6871:28f:b0:306:c53a:f904 with SMTP id
 586e51a60fabf-30785ae72admr2863589fac.9.1753895920463; 
 Wed, 30 Jul 2025 10:18:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3071323a99csm3016751fac.12.2025.07.30.10.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 10:18:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot mailing list <u-boot@lists.denx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20250724091342.59902-1-jerome.forissier@linaro.org>
References: <20250724091342.59902-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH v3 0/2] bintool fixes
Message-Id: <175389591864.3621398.1578086026432528894.b4-ty@konsulko.com>
Date: Wed, 30 Jul 2025 11:18:38 -0600
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

On Thu, 24 Jul 2025 11:12:39 +0200, Jerome Forissier wrote:

> Two small fixes for binman (bintool). The first patch avoids a warning,
> the second one makes sure the APT package list is up-to-date when
> running apt_install(). That one fixes a CI issue I encountered.
> 
> Changes in v3:
> - Really use apt-get instead of apt
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] binman: bintool: use apt-get instead of apt
      commit: 2babd34eacfb12f799f8d52a8729139041a18680
[2/2] binman: bintool: run 'apt-get update -y' on first invocation of apt_install()
      commit: 252a2b2750e2df890e044d42e0a530a3e629c9b0
-- 
Tom


