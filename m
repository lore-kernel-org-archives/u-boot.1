Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97298C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 13:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E1DA88A67;
	Thu, 18 Jul 2024 15:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ic1r5P9U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D243288AA0; Thu, 18 Jul 2024 15:41:40 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E18F8874C
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 15:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-70368b53cc0so380304a34.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721310097; x=1721914897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RZW4XYmw+LZZHXfwZ0ZhGIMAXFtzhMu1Y5HnRcW77Qo=;
 b=Ic1r5P9UduThJiU1iMJf/pO/61khUr5IItkbCFpYkB7L7+YPWQDKl8a+Y9XQ4HSULh
 ZH+AgFc0c2V91aKLmQ7z9RhBauScLvE4SjcBBE7YgnvdL7FUgpng7vSFAUJWCqJlYkqU
 WIxlMSXMaIpWz1AJ6U/RhKH1cfLr7+afzoUC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721310097; x=1721914897;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RZW4XYmw+LZZHXfwZ0ZhGIMAXFtzhMu1Y5HnRcW77Qo=;
 b=fhYGUPmfwoDq9+dP5arcWcchEQLrrou3v94kMZ2v4HlVPCb3VXDF5GOb8BI0RGQhu5
 SINQL/M4wwv/WNSHyQWxUwykPsk61NZXJA9+ZE+CEaKplu4IJ76ybolrDpSj7n7l/9FT
 aQPOu90h4zUsu2632EzvfuulFMMd9PEH857XMQt8cniMCMVaQ/4+h7kkRhQYj/akkxEW
 GphkFIUl3+was59fOohdN99P7BtVzvciO2hbNGKMBOXHsT7CHtrnAfaNNf7a1E7xv4YL
 +hKwyJCjQJ30rgrMdMwPplgJUQhGLNVk28k5kuTl9WCcC6ke2kFqqb2RdckK4pc0LPUQ
 WiLA==
X-Gm-Message-State: AOJu0YxjgHxjRg1E5dO4KJo4tt+7F5iBjPW61CbFwQoWRQpWH/kxAcfZ
 Zfd8iV/6ZO3V/gx9Mm2knm9TERJcUSXVOC4UKUlDx5KLUzDUgoOm37udhobskdI=
X-Google-Smtp-Source: AGHT+IHidFBS1LiVx5dz7fXpqtC6TtNgocnoYhBjYTlZwVpKdZM31mxYtopKkWzEbbjJw+xaoJArzw==
X-Received: by 2002:a05:6870:c192:b0:254:7a82:cb3f with SMTP id
 586e51a60fabf-260ee83ab52mr2165560fac.25.1721310097355; 
 Thu, 18 Jul 2024 06:41:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260ee947f82sm355303fac.50.2024.07.18.06.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:41:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240709230709.2228061-1-trini@konsulko.com>
References: <20240709230709.2228061-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py/requirements.txt: Bump zipp to current release
Message-Id: <172131009677.1834634.713550091816592575.b4-ty@konsulko.com>
Date: Thu, 18 Jul 2024 07:41:36 -0600
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

On Tue, 09 Jul 2024 17:07:09 -0600, Tom Rini wrote:

> A security issue exists with zipp before v3.19.1, and the current
> release is now v3.19.2. While the change in versions numbers is large, a
> manual inspection of the changelog shows that it's not as big as might
> be implied.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


