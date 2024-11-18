Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80A5D49225
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D1738947B;
	Mon, 18 Nov 2024 15:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uMd1/mVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE30789456; Mon, 18 Nov 2024 15:19:44 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CB8A89456
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-460d1145cd8so21575141cf.3
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731939581; x=1732544381; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NI1O7wyjgH+8u4yBJAoLhSQkgDubXG4dlU5VSJm6VE=;
 b=uMd1/mVfYKbolWO5jfQVEd5KcqavOMSpiy2PDc0NR2p7B6Aw1d8sYWwY7rzz/61fyq
 a+htpD0ZDE+re8lWCRQC1mW46l8tePs7wuCyW5ZfGr1N4T0zEXkzWSn37YRWl8DbUr1n
 ntFe78UMAqaB9Mx5VRCjX9uNcAcbcK6316lco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731939581; x=1732544381;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NI1O7wyjgH+8u4yBJAoLhSQkgDubXG4dlU5VSJm6VE=;
 b=c6kTjkRJQkOPTuco5QZXJUYVFauqGyYy3KSYiIUhxSbqczVd2NTxbQ+sBxV+8uGl5M
 Yl1gPNFwAX6Jbkk3bM/jhbtT3rVo7buMBE8046jb5/CJlk59V0iFFhTySuzvrHSbljKE
 ih0Drul4LnuXF6yNe7wwoH+z4UEZjeyE2uHnr/2MEf6ss8utJPwfr2QwOwpl+8QULoNg
 eddMOJnTLrWiovzY+zEpY8o9J8GsEidRS7dpO8ZcK6O8xuVlmDkrjDarYlwfT1Lm2sgX
 T/mU1DypaOkOrFuMtIofXMaXRTqxPg2m3bS+mwTLrQAy7NjpvbqPFZxNrbzm7BhqZptK
 GmqA==
X-Gm-Message-State: AOJu0YwcSDJQ3FmFwwkOXmS65Udi5BOjDSNaJEtINE5wfR5FcyS3sPhP
 dtJPbgvz3IQuqUV4IrywAOZt7xf+ialUsUnUXSH/y1U3Yk3+o+v1kmNHRgMGerM=
X-Google-Smtp-Source: AGHT+IFVYENgljxHNNR61l3Eisxqgvq/XsnBYxgFnXm9wWdgoNFHsJ+eBdxCC3MXNuXSuO+wHUs9xQ==
X-Received: by 2002:a05:622a:2a19:b0:461:1361:eb14 with SMTP id
 d75a77b69052e-46363de1a9amr183529901cf.2.1731939581081; 
 Mon, 18 Nov 2024 06:19:41 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24e44sm59075981cf.59.2024.11.18.06.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:19:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Love Kumar <love.kumar@amd.com>
Cc: michal.simek@amd.com, git@xilinx.com
In-Reply-To: <885b2f4019dd9a4d76a6ed9b8393bd99bf813392.1731401816.git.love.kumar@amd.com>
References: <885b2f4019dd9a4d76a6ed9b8393bd99bf813392.1731401816.git.love.kumar@amd.com>
Subject: Re: [PATCH] test/py: mmc: Add support for different mmc modes
Message-Id: <173193958012.3366111.17703622431370987088.b4-ty@konsulko.com>
Date: Mon, 18 Nov 2024 08:19:40 -0600
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

On Tue, 12 Nov 2024 14:27:56 +0530, Love Kumar wrote:

> Currently, MMC test runs on default mmc modes, adding a provision to
> support multiple mmc modes through user defined parameters.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


