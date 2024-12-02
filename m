Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27426E69E8D
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 19:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930A08957F;
	Mon,  2 Dec 2024 20:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fndjtzzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DB36894E5; Mon,  2 Dec 2024 20:58:55 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 592D98953C
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 20:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-46686a258c2so42469011cf.2
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 11:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733169532; x=1733774332; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpJWMb2/NQHHWmIBZliUlmt/pO6iGoGiKDTGIt5ouYc=;
 b=fndjtzzgYLz+uF4LNceQzRvYJjPTczfoCI9p/hNLA1qhdocW2HsrXxN+527TE3ED2E
 z2YkVmOBUJkOK/nNE3uNZDILH+Vwy8kdTMSaAE8OD8GJI/pSlcdmDRHnwcnAbN9EC6v2
 uuBlSwnwQn1/2bPiQWjaLtOtaV7DcNCCi58ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733169532; x=1733774332;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UpJWMb2/NQHHWmIBZliUlmt/pO6iGoGiKDTGIt5ouYc=;
 b=KrIqB+hIPK9IVhZPFDSvqf7L+GnsP2VUkfG0KssIy4h+8XM4Pmx9tEVVeGSl3pH7zi
 amnpemXG8aWNCufNKzjj3ZlvaeToQrwZn6Iv5fnHUBAY0FpRZ6H4gvB+L2eE3ekX61EP
 +wkfqOg8v3ibcG6dlCDw4iOimRAAAtWpXU++Loz87zgnNkO8N+iegC+EHFbJcUAigFBK
 zNTzpag9sHwvJ5vt9xLW2uCnijeROsIr3Zccq56DChIX7UX3w4ArPEJvM+YeVKo1A4Hq
 KA6MD0Wt5aikApsjA5bzQzUBSTqDq/CqqUf0XQLMCoXEMBrEOTN2WWjB0y2ypLFNatCS
 J1bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtvxELGwOQePEq92lXNmhWATo8v1HhQ2L7nrZAWIBVv0bqaSu0voEnF8YY6idiB27Uk1N9v0g=@lists.denx.de
X-Gm-Message-State: AOJu0YxWLMmAH/WogplAUZazJE2AxBIfPWmGBya3H+c6USoVle9rnPYu
 ZZrFfTmQJPmSikeqLuMsU9hDA/bF0gBj3bvXkOFkcsT4hAJGGH1HvoFoWWd2uq8qliG3+AGbzHx
 jZGA=
X-Gm-Gg: ASbGncsgv+HLx7jpkbJeqZQQ12BZRfHreb8H4IBV3L+GRhPMlU2hb4Yt0LjGi58InwL
 rl8TS9nYZmtOr/eTQzAiE9wLa3zktirVnoblVneJ75T1PR0rJvEex/OKa2arlt9w679gRR3+AdQ
 rIP0lLVasojjWi1auwE3B8I/IkHS1bKem5HA2WwPnwJfK3T6C8Yx6buychqjC/+tnoIa5DFwamQ
 PlyUmkfsZ3BngRZOtMYNZ8bFLAM2Fd73lo9iHn3SBctGnAd
X-Google-Smtp-Source: AGHT+IEtxbQkaCq0Oak6PwsmaDoA7Azof5MvnwX7C13y7UW9nNNG/vxfPzZN/pJmJj3AnpLH1/b5Ig==
X-Received: by 2002:a05:622a:14cd:b0:462:c4b7:6b9 with SMTP id
 d75a77b69052e-466b359e3d6mr369454521cf.33.1733169532271; 
 Mon, 02 Dec 2024 11:58:52 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c424a31bsm52870641cf.82.2024.12.02.11.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 11:58:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: kernel@salutedevices.com, evgen89bachinin@gmail.com, u-boot@lists.denx.de
In-Reply-To: <20241125-of_embed_fdt_blob_garbage-v1-1-faa78e2e1ee9@salutedevices.com>
References: <20241125-of_embed_fdt_blob_garbage-v1-1-faa78e2e1ee9@salutedevices.com>
Subject: Re: [PATCH] common: relocate fdt_blob in global_data for
 FDTSRC_EMBED case
Message-Id: <173316953053.3421598.2300644339113237843.b4-ty@konsulko.com>
Date: Mon, 02 Dec 2024 13:58:50 -0600
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

On Mon, 25 Nov 2024 12:15:07 +0300, Evgeny Bachinin wrote:

> Patch resolves two kind of bugs, one of which is vulnerability related
> to KASLR.
> 
> === Issue briefly ===
> 
>   Working with FDT (via non-relocated gd::fdt_blob) from inside bootm
> command may lead to the reading the garbage instead of FDT nodes. And
> this can result in various side-effects depending on DTS nodes, being
> parsed during bootm.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


