Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0D3CF8552
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 02:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9815189028;
	Thu,  3 Oct 2024 04:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pzuqdU9L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C54C890E4; Thu,  3 Oct 2024 04:52:46 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FA2C8912F
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 04:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cb2aac40faso12565116d6.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 19:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727923963; x=1728528763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7+zTgSmTZG18xhk37aa7JlH60c/dgNGv0FtZo6dIV8Y=;
 b=pzuqdU9LlXDgpJ1MvrPoLeTZA56r8IFZO+fULXMkZP80e0LXfQq3a4S/r2o4PVw+0i
 jVOa6kUU8Srn3/GwiPmQMWJoi/RNY8o2HnjSlWVij8iB56wo85DFhYbuhio/Cp+CKE0E
 ndxjULHZYKxtSedNDJNWGkQpQc6XZbZkKRIsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727923963; x=1728528763;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+zTgSmTZG18xhk37aa7JlH60c/dgNGv0FtZo6dIV8Y=;
 b=QBflJ5i2NGgOn/9tIHM/Of5IWlPsiLMz2zOXSyonPpx/J+wH/Z2j6riAt3ITUNlTlF
 UBbNBE9Jy02c1y40br6rCJz4lWO2fniDzQy1jwQTytUd1pCC8hXvnpc3c45Tt9M8ohSp
 UQt609ZZUa4nXkDCF4WdY16NJE0r2qvevOCfk7Cg28RLBX7dFzLcsGgysyYtdNCDLbYD
 KZZy6tn9i/Tlhm6hyiDC1H5mYc/d0+3ianOOxhr2XeMtSlOohJq/ekPNiitAxPyW9uo1
 fND+5sHKvZSHw9uJHaw4+j6b1qSrjdwEX41WBf9xLPl24vhUg07NUX5TO3OUdSzeQZYZ
 8r2g==
X-Gm-Message-State: AOJu0Ywf1Zgo+tNK8WxjT/lhN6FpK/a0+KQhNvRs7+B4qK8giuLY1bAJ
 LLctUUyMMIDOs6gZkr22/Oqus4NU6UHRj0CjEMIqbPnkOcPEsaEBBz0564HlEvmHYXf6zz1navQ
 wP+Q=
X-Google-Smtp-Source: AGHT+IGKEa3n1fhhlcZtMyz561udchXuVsENmNtJ8kNimABaFrM9tvNGG9DaRT5biOGsswOrfhFbLw==
X-Received: by 2002:a05:6214:5bc8:b0:6cb:81ba:8ac1 with SMTP id
 6a1803df08f44-6cb8fdd3624mr34589966d6.0.1727923963220; 
 Wed, 02 Oct 2024 19:52:43 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb938211f0sm1606826d6.142.2024.10.02.19.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 19:52:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, al.kochet@gmail.com
In-Reply-To: <20240919161042.3423-1-al.kochet@gmail.com>
References: <20240919161042.3423-1-al.kochet@gmail.com>
Subject: Re: [PATCHv2 0/1] Makefile: pass external DTB provided by make
 variable EXT_DTB to binman
Message-Id: <172792396144.1516896.17957881620701136176.b4-ty@konsulko.com>
Date: Wed, 02 Oct 2024 20:52:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 19 Sep 2024 19:10:41 +0300, al.kochet@gmail.com wrote:

> From: Alexander Kochetkov <al.kochet@gmail.com>
> 
> Changes in v2:
> - fix syntax errors in the description
> - impelement handling multiple DTB files in the EXT_DTB
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


