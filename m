Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D96E77188
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 00:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A29A80379;
	Wed,  1 Jan 2025 01:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BgRqT6SJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D5008036B; Wed,  1 Jan 2025 01:59:10 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6632080196
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 01:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6dd1b895541so32487886d6.0
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 16:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735693147; x=1736297947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t/QsABP9wJwOXix8PaXNu1QD1H2Rq9A/p39SEDOzWxA=;
 b=BgRqT6SJ+uyvpJXy9B7DWChJoUJTakjFDg4rQMR3Z75uqHkNU8DfeZDUyceQj3Wn1f
 apg2TcnYx+KVDUQ1xzskRoslPEWKqrkFx6oooDU54Wf4je14kMiueoip46kh+YPHsECS
 iVZrO10FFU5wYRItDiNO2a2B0luTgDzrC/GcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735693147; x=1736297947;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/QsABP9wJwOXix8PaXNu1QD1H2Rq9A/p39SEDOzWxA=;
 b=IUc8LuakDBNspcNFxApDT5uP/2TBh/xsRKgi5FoM7WpQGAah5Fvr+xSq3d3NCOLwXj
 qckczBv6eETZD5LLKQPIgdoUUqhIgSQbyNVRgFlziYeBsknSqLGOthlOhXnKlmPcwaaR
 6RGYs2Roa4KEax9guHKY3oo14bEEqRf4CmdmBOKZqlKMJRXHrUvGv54g9UKwUT0Tya+0
 +qYcYIGgT+JrNXuSMOItX722WKciiyxOTCqmzAtv8SitLOlJeRy66+rZXk+zuVrPKW7F
 aD2j42elOwUXClBo/mjYf+heHnSOStEI4wgCz/52bUHRBQSCbh63kiVhkUyT20P5Q9LK
 tmTA==
X-Gm-Message-State: AOJu0YzLqpT3A5MN7qzwbNeFrqgYHqgNiPkpF7xKbc3UIByZXFU8yAB0
 qBjtbEg/bfiIJ9a/P1Q55qpQ4STUTFPGMvU9ZvHq7Pey862ExENgPHfrm4LZH3obxQ6CJHjV2Iv
 Wrhs=
X-Gm-Gg: ASbGnct3bAaDPNul4zs54fTZOih1U1eSoswxc0C1YTEMsAbuNlbb96xPvmQJjH8typZ
 KHTRzrtUvEQs0T/VMQVze/sr7ihFtni6xOu/yx4PqJjoLHJuOMj20W9lcv9/3keyWlSqJku+8fv
 MaM448RfchxU72TzrQ6h8K7EEpxOblsOCVQbhd51RBj0icymQFafruFaxi+H27NmjYJty4k28mF
 RSPlSkaiw6a2/zEkC806ia+lYHHLBJW7/yNctyjoY7Z+bG8sdXitjc8
X-Google-Smtp-Source: AGHT+IG4deyxgZQzKWM9s7tuE9b/zODq/573AxGfo9Ksbr7tYBHuC4/WEDmu01DKIikPL95UJ46Cog==
X-Received: by 2002:a05:6214:1249:b0:6d8:981d:529 with SMTP id
 6a1803df08f44-6dd233a320fmr706355086d6.48.1735693147161; 
 Tue, 31 Dec 2024 16:59:07 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180eacb8sm117147896d6.20.2024.12.31.16.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 16:59:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241210-am62px-hs-binman-v1-1-be44e98a29e7@ti.com>
References: <20241210-am62px-hs-binman-v1-1-be44e98a29e7@ti.com>
Subject: Re: [PATCH] arm: dts: k3-am62p-sk-binman: add SE security variant
 builds
Message-Id: <173569314556.1610380.1561917489437298308.b4-ty@konsulko.com>
Date: Tue, 31 Dec 2024 18:59:05 -0600
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

On Tue, 10 Dec 2024 15:43:30 -0600, Bryan Brattlof wrote:

> The Texas Instruments Foundational Security (TIFS) firmware must match
> the security level configured on the SoC. To boot Security Enforced (SE)
> variants of the AM62Px, add another tiboot3 build which packages the
> Security Enforced (SE) firmware variant for AM62Px SoCs.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


