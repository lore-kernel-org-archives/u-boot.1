Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62FDCCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 659FE84571;
	Thu,  9 Oct 2025 16:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QINa88ZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84EF68455C; Thu,  9 Oct 2025 16:19:05 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73EBB8453E
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7abbdf3c476so850820a34.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019542; x=1760624342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIZSjaGM8IDmKDCuAcu+m7H/FuavqhnoGZQd6F+7AIk=;
 b=QINa88ZV6nbXzHOF5qYmTIxhWYWthskkopd1cdAAE1RDpiPNnm9imG1g5IEDAlb8AD
 QuwGfQ/MHLF7d3Q055lAB3pGAAVxrnFrWjXLw8HM8SPgFwxdOItsZXBZz+pRJ2EH+McJ
 R1ZbhP0FZAdgvTREq38YyPPsemPaGgSPVwEPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019542; x=1760624342;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FIZSjaGM8IDmKDCuAcu+m7H/FuavqhnoGZQd6F+7AIk=;
 b=tnjuMJaGciVy+/p8hu6LegQTxOgjLOOvjBmj9++/spw6DiCj7WdWETDrEWV7VboC+S
 Fuqba8dMSrIs9d1J4SbLSAe5t0GTlqmVHOiS0ksXHPAuCCWAUx6/wFj7tyX+KLOp+aKl
 0wLePXGi9PEzJWDtSEzIvy3ImWAdj2CWdhOP1sGJpgn+/mj9+/svKixjL1x/7pYXUh7O
 h+KaErHwaeUof6ccX98fK6D0QihnZyoFLuqBFwhVZ1VCHanLcZ106Z1uVGCAqffpKbyd
 XVVdftE9c/OSXUWPXrql1fBQ766ivlEa43iKthrfTbfifk652Eka8YoH97nzbAz+koRI
 1Gwg==
X-Gm-Message-State: AOJu0YwfVY2djSteEbGWmr3cj1NIl5IlQZIP2OmlT+2uQlyyguO+NUiw
 X6vQ0cLCFUlUtwU9laoUlSsBUtnOnklYRvAs3aJxPUNwfjw8brkDPb6kThCzRxwjR8disoSaKPW
 2KUnvfko=
X-Gm-Gg: ASbGncsn2sDSEIbeYtXPO4hI2pwY0CdJT5lybu18mo1XD2geGvj87QuRnrMsda1yzoD
 u21lrBAls+M7t9Gcqmayp+QbeJhIHqduAUsbY80qD/cMXFbgrhTUmW9c9NTYPqaMyKJPsFi6sQc
 Xj44N1Y3/pCT6MYXRxbnMaeMKKHIqvbOOFdWYJ0Bodk3scVIsmwUG0LsfAsjbLCVF8/5n3QLCFI
 cY/Ajd4csqHM1Os9qD2Rb/xLzBZkvj9mSriYDTZBIwaCJwA3FV0KW/5v7vq3QDMlnFoGGGnHIFv
 dTomLsv9JgLfV5lOqEVe4eqJC59slJ/15ggzW6cmRzdek/pgvZovEASIloW2LV7AFrFAZZpN+RC
 pHe3MI0jgezWfSqIPBhWHlfPN1H96KyWmh0OTPzSvdpBENV75jZ/SvwEcH9nABiCSsrHZkeobNy
 gr0yY+AXZH
X-Google-Smtp-Source: AGHT+IFR2HDbsR8i+VZDerrwhAXemFLVcELSj18kYjKwxLbsXAgMHEydRdWEcVPYh/JTqchr80kjIw==
X-Received: by 2002:a05:6830:610c:b0:7bc:31fe:57a8 with SMTP id
 46e09a7af769-7c0df804445mr4412825a34.27.1760019542191; 
 Thu, 09 Oct 2025 07:19:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:19:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20250926153146.3680952-1-trini@konsulko.com>
References: <20250926153146.3680952-1-trini@konsulko.com>
Subject: Re: [PATCH] timer: Tighten CADENCE_TTC_TIMER dependencies
Message-Id: <176001954153.3159859.2631070891672959175.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:19:01 -0600
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

On Fri, 26 Sep 2025 09:31:46 -0600, Tom Rini wrote:

> This driver implements timer_get_boot_us() which is global namespace and
> can conflict with other implementations of the function for example in
> "allyesconfig". Start by limiting this driver to platforms which use it.
> 
> 

Applied to u-boot/master, thanks!

[1/1] timer: Tighten CADENCE_TTC_TIMER dependencies
      commit: 7c2e4487e449b4396531789f1df49ccb8c911952
-- 
Tom


