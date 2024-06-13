Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147AEC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065B38892A;
	Thu, 13 Jun 2024 17:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K9y9h4Yh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BF6A8892A; Thu, 13 Jun 2024 17:33:12 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD2648891D
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-24c0dbd2866so577042fac.0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718292788; x=1718897588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlShuohFkRuscHMjMrABZJYrsutNYVtwoFqGKc7a/8g=;
 b=K9y9h4YhVd0CHGppD6hbegY0Kbi04oDYFPiw3MeqGy1AnaaV3DG3IdXbv3/DPOuxJB
 CwGnbOACfd4NPOcAkxmyKh+DARL56ZK3LkXronHybTMTMD47Ruvk/iRHUAb+2hafF0Oi
 qHfiDC9idVwTOInMwtAt+Epo3vcspX51TLfj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718292788; x=1718897588;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QlShuohFkRuscHMjMrABZJYrsutNYVtwoFqGKc7a/8g=;
 b=U0Ba+NyZjaHmeKp5ydrAfaORuD+wdeBsZMRFEFCU6G2OADKTqolKPeMB05AvNM3/QP
 h6Fq1wVKmSzNJDR+XGGKkXHcd8/A6cnVpL63VWy24DWxceh2HkSFgiiQYkDiaUjCK6Vt
 uT/8uunv9PHBtC4wpajbi5BPqaF7DHuPBxbZOkCLQgxgPgt65yz9LG0wIGV8xU1oqZxd
 on30napPBghlBB811IwY0QpHbkYr0GJuy8duAZtbVQv9kvNk56nUDL6z5iXHlqO4jlh7
 lb7UDTYwYfP6BiRgAY/3kpQvK3MojT7y6p9EueUpPI83sTTzaPB9HrbrLGVIKUBWiJn6
 x1sg==
X-Gm-Message-State: AOJu0YzcZAkD6PqXkeCkhnpVHpSyMOwjNAq41o3auVBI3S3YoUDfPdbv
 qiwxObj9le+xqC/Ly/xPEns0r0Vf1IbaDjKl+tstekUq+yfnSxHLcjs3Hp5xYT/koY3ZW2I5KSH
 KSqc=
X-Google-Smtp-Source: AGHT+IEZby2Sj8Q96Tow4vJwAUPvOKEfelGjWjdQHjVU5TUzVLJn/CCDwlp1+AiH/kuyS7Rafpcrkg==
X-Received: by 2002:a05:6870:9a25:b0:254:9501:db80 with SMTP id
 586e51a60fabf-25514c03182mr5905729fac.14.1718292788493; 
 Thu, 13 Jun 2024 08:33:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5b84efb8sm250171a34.73.2024.06.13.08.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:33:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240608041244.7325-1-heinrich.schuchardt@canonical.com>
References: <20240608041244.7325-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] dm: typo prbing
Message-Id: <171829278781.618648.13738290603683752138.b4-ty@konsulko.com>
Date: Thu, 13 Jun 2024 09:33:07 -0600
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

On Sat, 08 Jun 2024 06:12:44 +0200, Heinrich Schuchardt wrote:

> %s/prbing/probing/
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


