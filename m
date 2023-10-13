Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1701ECDB47E
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 01:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8563886EC4;
	Sat, 14 Oct 2023 02:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZS98cK9E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7CEE86F9E; Sat, 14 Oct 2023 00:07:03 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E33C86F98
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a82c2eb50cso10611007b3.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234460; x=1697839260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YdzIO78G3ZUTix+aB042OEXI4zZ6gKzjqt6bbVo37pE=;
 b=ZS98cK9EGOo0x6Z8HvUvIVhDZvgX765j507r581i/Xc+w3B4biJVMc3nk2idEsEYYO
 PgXAxBppbupDvFNFdbpfvSntLo/zeVRxD//9WbMKF1Mphp+MYgb27IQjTfxd4jIdmM4j
 XZS4KDdxGBtvm4PmaPfc+6MYE8fCGn70jCTbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234460; x=1697839260;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YdzIO78G3ZUTix+aB042OEXI4zZ6gKzjqt6bbVo37pE=;
 b=Q7NZ9t7U0MkapggVRNXTGOCib3S/Icr5WrdzSRoehdLxqE0hsaOT/vHCi7PiemiyuO
 esaTlick/AdFDP5DYqUwLYaLCUXfl4jeSbe4g4SVUSpbsQ9V+rEQO7jigqSZeaPRO6Wj
 0xTCI9TFRtyV+QvMApfRIaEGBOfd57JV+Rrf2qSzBka9ivnrVdVjKKd7G2s5la53SFCg
 uzPcjG12JDLUooT9uR6MRE4d305NG9UUHqrtmJfXCD0M00BhvTSZjMSXj+0A++7uF3Ye
 0mw53sL89sCDFgDXeuOm6I47ehh8VTlreXyrMtntQOCyrD81c2EDYnVzrZ+eEXYTE249
 F4lA==
X-Gm-Message-State: AOJu0YynlLI4pmBFAsqNI7V0vCe0hKIPjN102qOX8BJ51uMATghfGK2t
 TDvMwpFmVqbVj2SJZtB/Yt64BaieCMsPGm/KaipH5g==
X-Google-Smtp-Source: AGHT+IHFNUGedL+KmfzQ9lDXcFBK8FSYYO2/1tUecrqv0IhcXcipamBKFdSSufgt5NrbesZtpQJOLGkQuJNQHbBpDO4=
X-Received: by 2002:a25:80c2:0:b0:d91:c3e8:34d9 with SMTP id
 c2-20020a2580c2000000b00d91c3e834d9mr24202685ybm.19.1697234460396; Fri, 13
 Oct 2023 15:01:00 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 17:00:50 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ3c9PQzXEt8nFDNa=Htq98mM=Zzx4yjq5cYrPUn27FNwQ@mail.gmail.com>
References: <CAPnjgZ3c9PQzXEt8nFDNa=Htq98mM=Zzx4yjq5cYrPUn27FNwQ@mail.gmail.com>
 <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
Date: Fri, 13 Oct 2023 17:00:50 -0500
X-Google-Sender-Auth: dtkLn8liKk1Ii2ieALYHL9EAk5A
Message-ID: <CAPnjgZ3mxAFOSnvCX8WhAVC-9162Rb6X6oX_9Q3MiAB8FH0ycA@mail.gmail.com>
Subject: Re: [PATCH 1/5] core: fix doc comments of dev_read_addr*() and
 related functions
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
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

On Wed, 27 Sept 2023 at 07:34, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> - The dev_read_addr_name*() family of functions has no "index" argument,
>   doc comments should refer to "name"
> - Specify the error return for several devfdt_get_addr*() functions
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  include/dm/fdtaddr.h | 12 ++++++------
>  include/dm/read.h    |  6 +++---
>  2 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
