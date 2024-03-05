Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765C3C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 16:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DAD0880C5;
	Tue,  5 Mar 2024 17:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jx0gkepW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4256788094; Tue,  5 Mar 2024 17:03:13 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B3C088098
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 17:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-788201e3a87so297285885a.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 08:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709654583; x=1710259383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oxH8t0sl/CVd34UjK7tc5ccdYZGCGUZuZo4NW8xz58I=;
 b=jx0gkepWI2WhqrBghgO4l6iM5ly2FtEKCy6EhvlAdPktnouFHl+a2ibZyCIYWOP9IK
 UFdV8+FqLezmHW+ZQ+WTo8FCb5dMYTsxlYAtRsGbVvW7UeJmdRMJJXjTi43P94S2/ZbY
 EU2Iu/zqP25+YeRV41xvv41+/4X0mfYjWn6yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709654583; x=1710259383;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oxH8t0sl/CVd34UjK7tc5ccdYZGCGUZuZo4NW8xz58I=;
 b=D/JPR0XRFDTrpJI49jYf07Pp2/jHf0c2VHYXYW0dxHatb8UXaMQu3PyDtckdAvaRyC
 FS25+WbRtm/KbN3hmHaE4BFCHRMfHLHosCIz61OCSgD1ZQZtgUT1i9jOJwsZVG2kMydR
 og3POC05JSL54eLakyNuHICse7KNH17zRmxPwQzMo+LcU0pvgFp7VAWzQUgJY5kCcMEO
 9y1N2hP5iVCV/35uaTt/qKCK2dGNm1GoElJGZgoRdGN3U53p2zWgavbxXItmm+1sHK8V
 jDJvMo/LFygvOy+6JCagdkVbcC/zl4bW+Jl06QE0BmjZqHiQ6yLr+o5GASxWzJhoj/EO
 nuog==
X-Gm-Message-State: AOJu0YzUDIpOXOTrQlfnhJ8LFpgqK6DHPpLY47s90nDzPcEyziTTMKYA
 yAx6UImCRfcYfiUQNl95C3bIF3bed+l51uFmNxYVaklR6XG7IVBkT+jfcP0TlcwmnFlr8+gADYJ
 s
X-Google-Smtp-Source: AGHT+IHove8giYozZvGeAGXh3Zezh7J7EAXQWT9v2ov1sq/pdPzgcGxKG+KF833uNcezjGWb7lbMpA==
X-Received: by 2002:ad4:4513:0:b0:68f:ddf5:abac with SMTP id
 k19-20020ad44513000000b0068fddf5abacmr2587345qvu.7.1709654581091; 
 Tue, 05 Mar 2024 08:03:01 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1000.res6.spectrum.com.
 [2603:6081:7b00:7f::1000]) by smtp.gmail.com with ESMTPSA id
 jh19-20020a0562141fd300b0068fef023e6esm6382512qvb.88.2024.03.05.08.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 08:03:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Romain Naour <romain.naour@smile.fr>
Cc: Romain Naour <romain.naour@skf.com>, Suman Anna <s-anna@ti.com>, 
 Andrew Davis <afd@ti.com>
In-Reply-To: <20240122103044.409748-1-romain.naour@smile.fr>
References: <20240122103044.409748-1-romain.naour@smile.fr>
Subject: Re: [PATCH] arch/arm/mach-omap2/omap5/fdt.c: ft_fixup_clocks: use
 clock-output-names property as fallback (kernel 5.19+)
Message-Id: <170965458046.2808800.14654466131198877647.b4-ty@konsulko.com>
Date: Tue, 05 Mar 2024 11:03:00 -0500
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

On Mon, 22 Jan 2024 11:30:44 +0100, Romain Naour wrote:

> Clock names has been updated in kernel 5.19+ with the removal of
> non-standard node names [1]. Due to this change, ft_opp_clock_fixups()
> doesn't work anymore since ft_fixup_clocks() is looking to the clock
> name and ft_opp_clock_fixups() error out with the following message:
> 
>   ft_fixup_clocks failed for DSP voltage domain: <valid offset/length>
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


