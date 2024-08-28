Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32602C636EE
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 18:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF4D88AA4;
	Wed, 28 Aug 2024 20:27:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PmwP5JaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CECDD88A5A; Wed, 28 Aug 2024 20:27:04 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E696288AAA
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 20:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6bf7a2035d9so9055916d6.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724869619; x=1725474419; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1FvJn/6JNr1wsNngzHmvzMyJR1fvcKVud5RImkS0wM=;
 b=PmwP5JaNkBSVQnDjPdDdnqcHDdVgkI1J9R2lZYp/CtxCnKDJhE9gquRaLM4AtMm7Rz
 IITVTnCiD7ifwu6pbdjPrhGOBxtU6M2LYMlhGTWlEcw7Y1z5sLhkki1rvF8gkaWy1de6
 EkoC16B50VWMBcPy8aoxpxuekSFkvgHVkInLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724869619; x=1725474419;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1FvJn/6JNr1wsNngzHmvzMyJR1fvcKVud5RImkS0wM=;
 b=mmui3nCR3oIXuf36s4EgwSg/mdAPUdRM+SrthjChQNB1pY3KeOq7k7w2UIWtLhXkKv
 kLEPMppcP2Yfzd0b/Ifztenkm15N4D3gS5e+MOnerGN/dLNgRuDCoirslT21wRoPaRu0
 OGMvwijvzvO2TL5BLlBOeZhsZf6CiEr13MF8J34SDBIOh7jynLnwsNUHkfZgXCJoNz6Z
 6viK4dAhFnxc4hJp1rTGZgMJvQvC9EDjm8A+1V+09xiFGMiD6nAxN1YI3SwSU1idxkfc
 zm1jfFSGy2/cY7AC+2MLHHUBD58SQVA5raHs0afzb6e2AMMbzD03XZ76kXeD47fSzcVf
 fLjg==
X-Gm-Message-State: AOJu0Yy3+F9fRv97MmFPBqmzFwLl7YkWRGlAdBE1dHNN9KOzPyuzbi29
 FwwFtVzGK3m929LcFXAo105P4iizIAHfvwau52FU6YqIPZPtlwxjEhOp6+flinPhMauGximQrZr
 jLjDspw==
X-Google-Smtp-Source: AGHT+IFEaQmwAroBDby10eyEG6ZmIITZ1kbMG5625J1lCnmMab62nv70ksZwj+xy/YnLsVc+To86Ew==
X-Received: by 2002:a05:6214:29e5:b0:6b5:fb9:4899 with SMTP id
 6a1803df08f44-6c33f3259e8mr1104966d6.3.1724869618784; 
 Wed, 28 Aug 2024 11:26:58 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162dcddadsm67835536d6.121.2024.08.28.11.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 11:26:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Franco Venturi <fventuri@comcast.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20240731130913.487121-1-fventuri@comcast.net>
References: <20240731130913.487121-1-fventuri@comcast.net>
Subject: Re: [PATCH v2] mmc: fix signed vs unsigned compare in read check
 in _spl_load()
Message-Id: <172486961749.3064792.4380164569809780009.b4-ty@konsulko.com>
Date: Wed, 28 Aug 2024 12:26:57 -0600
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

On Wed, 31 Jul 2024 09:09:00 -0400, Franco Venturi wrote:

> Fix signed vs unsigned compare in read check in _spl_load()
> 
> Issue: when info->read() returns a negative value because of an error,
>        the comparison of 'read' (signed) with 'sizeof(*header)'
>        (unsigned silently converts the negative value into a very
>        large unsigned value and the check on the error condition
>        always return false, i.e. the error is not detected
> Symptoms: if spl_load_image_fat() is unable to find the file 'uImage',
>           the SPL phase of the boot process just hangs after displaying
>           the following line:
>           Trying to boot from MMC1
> Fix: cast 'sizeof(*header)' to int so the compare is now between
>      signed types
> Reference: https://stackoverflow.com/questions/17293749/sizeof-operator-in-if-statement
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


