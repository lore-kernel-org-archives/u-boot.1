Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F68EC5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 19:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D4B9833CA;
	Fri, 30 May 2025 21:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ifZoqb6T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E281833F6; Fri, 30 May 2025 21:39:15 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77FD782B72
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 21:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4067ac8f6cdso852064b6e.2
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 12:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748633952; x=1749238752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+MurqSH7m2mPGSkussEvMD1l064EYxX5bhp5RSr+Flg=;
 b=ifZoqb6T6Tmo48KbkyTngOZNTfA7A+nCUKyx8RJRjCrZ3U6a85MyW8vQHaU7H1WFXj
 hMwShqnVtgd/q/4jBWTpZoB0fF1lGjEu6wYOK9U/T2RU6sGDaxQOR/4FYNnQi826lhpb
 UtShR3sj/+XP+JQ6xVNyTHo9cRcpOHRxP605M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748633952; x=1749238752;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MurqSH7m2mPGSkussEvMD1l064EYxX5bhp5RSr+Flg=;
 b=VlyAqKOAe+7GqSRE1CdQSDdzcru9fRe3jzw3lPR10wZq4to5JBnYeWKHEgqRpKIsSN
 C2qcgbTyyHfu602YcuTMKAFSBqFLDjykVq0pgXfbSVY5UfF76LjeKG5TuLr18SGDKg/E
 CQm4SUmIFk4fKTyiyXmfUgbDWiCP84EjfrHrg8eq0DY1Jsy7mxqPfgbsZUxIXatVxT09
 fe1aexqnvF9od/PZM8iTEtjZUze91CST6O4K6PoMA+vGHcZy9R96QifdD88vSB6qqYM6
 PASK1snM9GymArNA+us2KMe1+potSvwteRreMWV5GpEGRrmUY/HPf3Go1mj0aqINI55q
 wA4g==
X-Gm-Message-State: AOJu0Yz8Pwz8gRx1A0QBpCwTiziQBvspJIWd5w1/rDXRbX7mMrNXK8RI
 kRAkQwKUvV//zO1bEJDiTbsUKXQ58rnODte252L1YcRy3GmXd5r4Xiw8vm6Jp1/8lU1izLTGqF/
 AvP3aVws=
X-Gm-Gg: ASbGncvUVwErlJIYLGSYNDzCNXUiSVtmJ1gUdKCtDQQMv+X27KXh1wQ9Y1f4fG3bMs/
 iRKiuJBIqU/1cZNgXHhPCrHPSk7kQlC2Dae86u53dX44OnYXgV0Oh96E425Jr1335Zuw6I9igUt
 9pugYFUcFIBsrdl4c+UXksAWA4PMtWo1ulZyd4LzGznC5BCYikX7QB71BF7cUdZAgf65SJCBj/v
 gI1ziIWUHDR/PtP4azogEWTuQ5t2xXFplx8406xaFWpuJZ36Wvb9t9WJ/ajCzcXSMOfhLJtVW7P
 arCxfDODOEBfVHZZsme/Ly3iBYlAilLZGmPkYvv2MHNo0th3EETBoJ7UBLJwdWeWqEuJT7hXLSi
 t/DtsVtEj90w=
X-Google-Smtp-Source: AGHT+IHaak6qY4jE2kWCZsJcjTL3zyc0YdMYyBYdTUnuS3zj7JB4jy801jeTuy1mJ+LAVSlJ+h1YtA==
X-Received: by 2002:a05:6808:384c:b0:403:31a4:f403 with SMTP id
 5614622812f47-406797368e9mr2931873b6e.22.1748633952226; 
 Fri, 30 May 2025 12:39:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678ce8267sm491805b6e.37.2025.05.30.12.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 12:39:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250502201226.1369013-1-trini@konsulko.com>
References: <20250502201226.1369013-1-trini@konsulko.com>
Subject: Re: [PATCH 0/2] Almost complete DM_SERIAL migration
Message-Id: <174863395136.4062885.5941227090538671615.b4-ty@konsulko.com>
Date: Fri, 30 May 2025 13:39:11 -0600
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

On Fri, 02 May 2025 14:07:38 -0600, Tom Rini wrote:

> In a private thread, Simon asked about what's needed to get PowerPC
> migrated to DM_SERIAL. I went and took a look, and to complete the
> entire DM_SERIAL migration (excluding SPL/TPL) we're actually nearly
> there. This series first migrates PowerPC (and some NXP Layerscape
> boards that share history more clearly with PowerPC parts), with the
> biggest change being to make sure we still use the correct legacy
> drivers in SPL/TPL (where SPL is extremely constrained). With that out
> of the way, I looked at what was left. With two exceptions, it's
> platforms which can be trivially enabled for conversion, and so we do
> that.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] PowerPC / Layerscape: Finish migration to DM_SERIAL
      commit: 191b10ac70d7acfa9d5eda5bd5d3cb12f6c576fc
[2/2] global: Convert almost all remaining non-DM_SERIAL users
      commit: b5321da5cc345049487ffce91bf1e6f3f10fdbfc
-- 
Tom


