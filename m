Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE73CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 16:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4B9684480;
	Thu, 27 Nov 2025 17:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P+VgILq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9917084380; Thu, 27 Nov 2025 17:55:53 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8795C8447D
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 17:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6579872f00dso418538eaf.1
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764262550; x=1764867350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nkNDm4jW8QyKjtucN0QnroXFJdiZ39jesn7FN2wRsuQ=;
 b=P+VgILq66T7Dx9nAiQUIHMH0K5oNdAq8f+hTBpaJBoCqKpUlWi9xHJXyFbCim3FdCW
 5RiTN9DFZfSpnBBD1p8l4UsG6XsYCjdMY9XBXqEJ8DVlBoufKNGmqh9g1LKsklanWmV1
 LBpluH2kvzdCUgj7a5JH08oBrISSjBm3Zpb38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764262550; x=1764867350;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nkNDm4jW8QyKjtucN0QnroXFJdiZ39jesn7FN2wRsuQ=;
 b=OT1mfcJrbUpEL2ea1GXxH4fClS88HtwuFeRrAwpPpDAqPjdPArp12QnNq3G5AA3eJ2
 8XVo6xoUTteNdcAB8tvR3l5o6OQNas92aCj/30wuH2PS433cMt/i1GohhVGepmaTtONy
 2FMhGoKyRckl9575a2zPW415vF4JBbN64ClxvO+60VUM6BtuhpHayyYdG4of01U5X+qs
 gLb2R0Et/5ODQTYsvomtZjJH8/7+LW4jyrFX8qOzkiAox3jf/E2vMoP/ruCyCOtlGmci
 GDokhorBupi7ai/eET1YftU50Bb6bHhuyAPUCtC9HRhwXIVqAhZrN9j7xZF5YA8khmhu
 qecw==
X-Gm-Message-State: AOJu0Yyj0hCFrXpELTtVXeEMEGL9DVERVAJtBiS9hjf0CY94r6RpBFYU
 /DHFMgG7N4krG0NhlGlMVP1Cp/wyJ6wuz4247UbFEml8Y82w/H0/LIEboGtrX9AWyHKiht4Wfgx
 87eJ3VMw=
X-Gm-Gg: ASbGnctgOoa/XWOhMkA41IQ/QLkU7NgnE+o2m+Lkhmybgv3HqM0+Nz87iJMBLe2t2YP
 bqfjiNKwXvPCHRQz3gqAWSdEwQicLva7/LhUKLAzDkp+iTt01PlAEBavZG7O016W3wFL2fqwdmP
 4L5s856fAi5d5ea10H+jQ40ZGmvY/2kQ3RhuRYCEzDRHM1bHuJXjGovt6t9lyYXxX4RQLtxWj/W
 lMKHjcfIDTtl/rXgxNY7qJv390CFJPBV4irf3ACTW/KPT9k0mTTUijEe09FjZr5Zkd3id7qgUz9
 04OzOtITmUen9Fb+N8q9XKE77mrawigJByq19BZlAXSnPtwSshAry9WSWE2Iz/+Bkh7P8+0Pucu
 BgzPTornojqqWtu1/8jHA4LeLCA3/OfdBcjSl9lGcF/ULmf8D1CJsURWfM2N+a+3aRKhFDF1Qaz
 GRMt4xkct0IeJoIfKNv6MPqfur5wEjdtpSJ28StUOD/u39fUsE
X-Google-Smtp-Source: AGHT+IFoaNTv1jqAeugD78WIVf8xWE1atiuEwlYkk2I/Fv9LkkS1YJbIslc3a60xuLVc/hBLN4TbaQ==
X-Received: by 2002:a05:6808:a60d:10b0:453:f62:de06 with SMTP id
 5614622812f47-4530f62f34amr1503572b6e.35.1764262550330; 
 Thu, 27 Nov 2025 08:55:50 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f0dd05e0afsm741584fac.20.2025.11.27.08.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 08:55:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Greg Malysa <malysagreg@gmail.com>
Cc: Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, adsp-linux@analog.com
In-Reply-To: <20251126195047.866-1-malysagreg@gmail.com>
References: <20251126195047.866-1-malysagreg@gmail.com>
Subject: Re: [PATCH] board: adi: Fix missing semicolon in nfsroot
Message-Id: <176426254936.4117678.5481533728564911601.b4-ty@konsulko.com>
Date: Thu, 27 Nov 2025 10:55:49 -0600
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

On Wed, 26 Nov 2025 14:50:31 -0500, Greg Malysa wrote:

> The nfsroot constructed as part of the default Analog Devices boot
> strategy is missing a semicolon between the server ip and the root path
> itself. This adds the missing semicolon.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: adi: Fix missing semicolon in nfsroot
      commit: 70ab39e2305f6ab9b7b1752e26b0e4293129009b
-- 
Tom


