Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649DBCAC582
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 18:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5B8183252;
	Tue,  9 Sep 2025 20:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cc1AUeiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D5D98318E; Tue,  9 Sep 2025 20:31:45 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D133831EA
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 20:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-406ec5934caso14189115ab.3
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 11:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757442699; x=1758047499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Ys4OTStjDoFI8O17X3fuEDlM1HJk9aFkMVngOeVZaM=;
 b=Cc1AUeiEIAGtUga047byhZkWpb8dKdoaa4YTfTo3aTG4GXdbwUnirf6ifuADwlfx0M
 GJRfsHhHP68ww4lxR8UVL6moAkeOKSS1wAL7yl9yp08uRD/vf8ecfppcGHQVnqqy0Efs
 atq3ASRb3LwVAg5fgVm7yBzR12Rpq1qtk5aPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757442699; x=1758047499;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Ys4OTStjDoFI8O17X3fuEDlM1HJk9aFkMVngOeVZaM=;
 b=fsLJIihKn5+dZMTsuZLsgGWh1tD6PI0J6+gYZKLIntuFWWy0ZX3K6ZaJ44XXXstCMd
 /47/JzYifMDdKctad0MbGZVh+37J6CsJ75cVRfQNMLCUmeVpN7B1ZUN9AalJJi6Zl0u7
 oQq5pHCwCW+IgZPY2lJFUovGWIDuunyFxImgLR/GMaRV9Jw99CoaJan0yvPXXuq51bgG
 Yc5hIGqFFqEpdxYSW455hPTEP3ix4Tq2fBW4t93iCmvIZLoUEXEmUd84P+B20izkC6jb
 6hO8QpBtAbvmTyiwYlhKteCyqY9vWAV/VBnz9wejqMaSvuLpTblz8w56t9vfDCXxv8NB
 +G+g==
X-Gm-Message-State: AOJu0YyAWFt3m5Jo/haDHzqB99lWwjg+PHG7YmgNvuvyVKc1xDTVp0oa
 9tt47XLrN6Qs1E/e9vrFn1EJw19zOZZ2K9N+dVfu+9UEG8XlqUC1+ORB0nj0EExgzJA=
X-Gm-Gg: ASbGncuQxyPV/Lmqp9pnQIhdz9gdcH5krh/Tyk6uKhhyivslNSpaGo+LM/kC+jbnZRZ
 4qo3DmX/o8wV+iMwNvuGU/F1pRsyb15Og97xyKst+Ja6bjWNPjAdHB93S/u+AbBPmwNCKbIPsTC
 qgKWwVN1osXKix/OX1BAL14A/8K5CBqGv57u7yf+txpQvP2Wx3pX1pLq2B5VcANqb7iIhOpZy1m
 6UUPmE8P+bMF2YSBkIY4Ff02CnV8R50/7ErbbWaVOLNhDTEGtgA98LyLIgr3vvX1QVYw6E5g/UA
 V56RB42J0o8kjj74PEqdbCvoj/Ek/jUI4q+kXbS+QGOnI0KXoeR4J06+WIRsXYnDoSs8Y5CeRPB
 fts7hvfFEwcuSmUQ4MmtOT8ewjd7BVV2BGk0wKuUr40vCnTjC9Tgbs1kPN3m2PQ8LsQ==
X-Google-Smtp-Source: AGHT+IHlFvHnYWJ+rOj4wCn2I7GKphg8b75Lc6N3rnapy0nZw9cvIOUyRfJi1t5DpPVfMP1Y4YjKZg==
X-Received: by 2002:a05:6e02:1a2e:b0:3f6:5f12:2905 with SMTP id
 e9e14a558f8ab-3fd8672ce38mr161908315ab.23.1757442699223; 
 Tue, 09 Sep 2025 11:31:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-403c8eb8884sm32715295ab.33.2025.09.09.11.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 11:31:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
In-Reply-To: <20250820150654.1398992-1-jeremie.dautheribes@bootlin.com>
References: <20250820150654.1398992-1-jeremie.dautheribes@bootlin.com>
Subject: Re: [PATCH] binman: blob_dtb: improve error message when SPL is
 not found
Message-Id: <175744269837.1809471.4162834140070687038.b4-ty@konsulko.com>
Date: Tue, 09 Sep 2025 12:31:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Wed, 20 Aug 2025 17:06:54 +0200, Jérémie Dautheribes wrote:

> When using binman with the '-a spl-dtb=y' flag, if the SPL blob is not
> found, binman throws a cryptic error message:
> binman: 'NoneType' object has no attribute 'startswith'
> 
> Let's improve the error message to explicitly state which SPL blob is
> missing.
> This is particularly useful when binman is used as a standalone tool
> outside the U-Boot source tree.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] binman: blob_dtb: improve error message when SPL is not found
      (no commit info)
-- 
Tom


