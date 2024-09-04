Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3899ACD37B5
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 00:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9377088C1C;
	Wed,  4 Sep 2024 02:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eU6iptIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 315B488C60; Wed,  4 Sep 2024 02:20:40 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0470B88C30
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 02:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e164caa76e4so5782248276.1
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 17:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725409237; x=1726014037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUzyZ855jX2Le6ig7cgB4dCI1Ce/sR66ziNYgW3clnc=;
 b=eU6iptImNc4WXvMZdnenmVq/mqjny4vhio+zp4zS4VAugE74gigN7/Zg9T87cgjglS
 9pgJIvq/1vIe001nxEN0ncQOmtnUEh8/uXCrZnZZ/0D4j+ZXnqPAEfoFPZTABm84d8QZ
 8FfxBOIub25TP+3C/92s84rDDOGmTpOcJXufg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725409237; x=1726014037;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUzyZ855jX2Le6ig7cgB4dCI1Ce/sR66ziNYgW3clnc=;
 b=WneUo4a0gYtsVTN3L+J5JR8rkUHmbK1uwqmUecdj0eUJiLn2AAjpwPhxgQfDOhApzs
 vwyNWZ2PsvBhhCSlXgSBNs7z0PPDrVii4S8OViNoLkhp/2tqavacryb31igxblhzb2sv
 wXQUFXF7pwEiJW1CtrPgJ5o56u9S3wcqHAG5gLZwaNlrZZSydcXYtoiXW/MfS7heYeN7
 /7kv1coPHkDfzc8kqsfgLMCrm6aBGl+xCQw6tbugrt0qWwh0rwlZoWYhhWKfjXvDO5EH
 CoSAyK8/48EufG/mjCE3OW1k08rz+XqPUOUF4r+iUoMbDUyuVuKcDsgllHbOCWu7jb3a
 +xAg==
X-Gm-Message-State: AOJu0YwFFcwS43h1bXcLo5omfRPntggyLpsLsKYpeFojvmfVXTdzfvMK
 u8du1EbMsDUaNEw+FQ3hJHUjAXoTnC/DRX0FalD7I4UUXDT4OwkZnW53X4qi620=
X-Google-Smtp-Source: AGHT+IFmWEMpw9R27OGaaGZhz5h1V08rvxcvWba0MMkkGuDhNAKPPykEZdXhUi3Vd8/4beljULQ9xw==
X-Received: by 2002:a05:6902:992:b0:e1d:d1b:d4eb with SMTP id
 3f1490d57ef6-e1d0d1bd650mr1244688276.34.1725409236624; 
 Tue, 03 Sep 2024 17:20:36 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c50fc858ebsm12858146d6.123.2024.09.03.17.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 17:20:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
In-Reply-To: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 00/27] Make LMB memory map global and persistent
Message-Id: <172540923389.1623463.12874854723990764858.b4-ty@konsulko.com>
Date: Tue, 03 Sep 2024 18:20:33 -0600
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

On Mon, 26 Aug 2024 17:29:13 +0530, Sughosh Ganu wrote:

> This is a follow-up from an earlier RFC series [1] for making the LMB
> and EFI memory allocations work together. This is a non-rfc version
> with only the LMB part of the patches, for making the LMB memory map
> global and persistent.
> 
> This is part one of a set of patches which aim to have the LMB and EFI
> memory allocations work together. This requires making the LMB memory
> map global and persistent, instead of having local, caller specific
> maps. This is being done keeping in mind the usage of LMB memory by
> platforms where the same memory region can be used to load multiple
> different images. What is not allowed is to overwrite memory that has
> been allocated by the other module, currently the EFI memory
> module. This is being achieved by introducing a new flag,
> LMB_NOOVERWRITE, which represents memory which cannot be re-requested
> once allocated.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


