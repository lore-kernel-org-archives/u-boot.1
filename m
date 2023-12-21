Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CA2C46CCD
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD14F878A1;
	Thu, 21 Dec 2023 17:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pn94RVuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F01878B0; Thu, 21 Dec 2023 17:51:46 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C10587864
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2041e117abaso596199fac.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703177502; x=1703782302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FicLDTIbafhUBQ+STzdyhDDFpiV0toQkCArcT5Gxotw=;
 b=pn94RVuBJFhV56EEzjZWQ54CGiAA1tLyniW4fCdDEkDRDDf2nyb/F1EIrI1sIwWqDQ
 NO46FPWifpF+2d6dOHuv5ZichMQgMijzolf9x0SgJWELJJZ2hptBw3mzkl7wHr4s23hv
 +Kp2S9nniFO9pbjhaPdtda98amsDoCpTYLie4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703177502; x=1703782302;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FicLDTIbafhUBQ+STzdyhDDFpiV0toQkCArcT5Gxotw=;
 b=HqanwmSVwfa/uwaJXJ6N2nJ2aM4VcoJzHMHvpMZ53Eitqr+lPQpstVK0dql90MCrqF
 3Vh81YE6cvXwc3HlW4mi8mneRywTsgm4p0W2xbnd9SX2wUEfHOBDjld3bGTCwUdTB7OX
 N3Fn7PV2iLtAIILW0/XESoiwyEOqbUotd46quUd/YcHkaukGzlIUT7tNy1fGEO7CxPZ5
 iIkUZZYv4qAhVJzUQHXpYkEZGrV/Mcpm3vpiEUPQm1umkDflT/r68fsJrO33Z2sfSuUd
 oXgjadAccLGzuKodRMLl1VujKj2U/ZuWWdnWig/Z8al1u799IgGRwsj+9p5mSgtsnq8T
 TQhQ==
X-Gm-Message-State: AOJu0Yzmjflu1WND3olG4qbrypUVjO2t/fSmxRcL4/Fz4soowo5xtUaS
 8eixqBibxbTseeJ6UfAyWjMsLNvPj1FwOUHTQmfJHg97wQE=
X-Google-Smtp-Source: AGHT+IF1kwJBnJiibvBrnlQFwU41RX7f7WgFsUGVNX1T/OOD8O/UkYMCOEf/jJ74FUs6YZz2Bae7oA==
X-Received: by 2002:a05:6871:6a0:b0:203:fd69:d65 with SMTP id
 l32-20020a05687106a000b00203fd690d65mr77943oao.71.1703177502296; 
 Thu, 21 Dec 2023 08:51:42 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a0cf8c1000000b0067f07683decsm740393qvo.99.2023.12.21.08.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 08:51:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231214121654.3042335-1-trini@konsulko.com>
References: <20231214121654.3042335-1-trini@konsulko.com>
Subject: Re: [PATCH] global: Restrict use of '#include <linux/kconfig.h>'
Message-Id: <170317750168.1616014.7548226727154136822.b4-ty@konsulko.com>
Date: Thu, 21 Dec 2023 11:51:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Thu, 14 Dec 2023 07:16:54 -0500, Tom Rini wrote:

> In general terms, we -include include/linux/kconfig.h and so normal
> U-Boot code does not need to also #include it. However, for code which
> is shared with userspace we may need to add it so that either our full
> config is available or so that macros such as CONFIG_IS_ENABLED() can be
> evaluated. In this case make sure that we guard these includes with a
> test for USE_HOSTCC so that it clear as to why we're doing this.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


