Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEE4C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 16:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8948B80107;
	Fri, 16 May 2025 18:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NLV/T59a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3868E8059D; Fri, 16 May 2025 18:20:25 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C498006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 18:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2db2149ffceso317433fac.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 09:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747412422; x=1748017222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z6ZgS5xGNDEmdtOpjxVYwKM2IYLmg+nSNzzxJAeGwic=;
 b=NLV/T59agCxm0kcBUiVtax5y4EW807rClqrVfP9vwTBHiCNIUvKcdAG7iiGEXwsxnZ
 wEvVXTT/DbbzbSH2o/5wOura8lx44bj0UeVIfJePsDiSwFMFPSi7JuTUPNBYBS5lYm/u
 8/faedtLbv3+8fBHUlaKZh5Q3E4zfS4JV1S3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747412422; x=1748017222;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6ZgS5xGNDEmdtOpjxVYwKM2IYLmg+nSNzzxJAeGwic=;
 b=HgkhOTSJk1XwtMIyzQ4RjGW5BmdfIpc0yVGskvH/YOr3PghlNWKXMnodXBt3DOS3sf
 QK3Upv27F1gMNBprpvU0C4tCdtwqM0vkoYRduAF5awAhDI4Bt9h2EShq3u58ix9LyETx
 yTNE8ftIo5COY92/XS00K/zmhCms4bZTR3E8a0cWmGhG1Mxfu3pteRr1HzB4tOsmtMgs
 nhSYhQgu1G3MQxKYgqJhKIwCUUb9MA2yIlO+kS2Q70f6cAJgZwRVvpm8wG2aLnGDEz/c
 Jmbh0f9MrhqiYN6LU2bcHFgtlKmzoAK2MZSBZWh5pi8jFdKwRVkuxsrH9CHLGNrAKjxl
 7ZRw==
X-Gm-Message-State: AOJu0YxGj3rELwSe6ZS+lXJYPkO9lpSDbHrU4wAZcNuxh2dZie6MgDFW
 4iLTSfuYMODCBtFQ/ygjiiLdmnRnSJjsrtaROA9jDX0lDQzCSZli1Re3+noacfjlx41cY0b5GIx
 L7uI4hlk=
X-Gm-Gg: ASbGncvRaa1Q/rbskrG6KM16wFnO+j3Snqa6cNgGtadGMpcVEylBFlqWceLPyruHj9o
 u+h/qTZ0G1k9qUu0F3NJRG1y/VmeXOvG4PfoNQM7K68zaQnMt0OYck6jXjH2FiquC8dudZzscJj
 VdKlIGL/IH++v5IHMVEtnxeHKmHvoPXJlWmekMu4ME/G+xxxwmziOYaAm53Qs5OaBbx9zxVJ/0N
 B8AkzIWdqbjqGYhMiQ2vGagPM4RvBFEh4ne7BgVvkpWOxuI3UsFHbqs2PnTy8C2K6rnIqDuggFM
 alIHjPbONBLbl0hn8juKYA+ckS60LN1qkTqNyJcY3L8W3HPqNANiKnlqz1JjNpW5g+AZBth9+nQ
 Y3++jHivprjk=
X-Google-Smtp-Source: AGHT+IEH5souiheSPPc7eS2cxlk1isljgAGYGUvCEnt3czBJIlcuR55+CjoADOxFWeMw2J602ogwQw==
X-Received: by 2002:a05:6870:ce93:b0:2bc:918c:ee04 with SMTP id
 586e51a60fabf-2e3c1c3578emr2643192fac.14.1747412420718; 
 Fri, 16 May 2025 09:20:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0a9be41sm502420fac.40.2025.05.16.09.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 09:20:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>
In-Reply-To: <6e0b4e17-34c8-42f3-8f62-3e822e37fd4c@denx.de>
References: <6e0b4e17-34c8-42f3-8f62-3e822e37fd4c@denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-Id: <174741241997.2939066.16050681492219330763.b4-ty@konsulko.com>
Date: Fri, 16 May 2025 10:20:19 -0600
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

On Fri, 16 May 2025 13:42:02 +0200, Stefan Roese wrote:

> please pull this next batch of mostly Marvell related patches:
> 
> ----------------------------------------------------------------
> - mvebu_espressobin_ultra-88f3720_defconfig: enable hwrng
> - kirkwood: Convert to DM_SERIAL for Kirkwood boards
> - kirkwood: Convert to DM_SERIAL for Synology DS109 board
> - cmd: tlv_eeprom: return after successful read from EEPROM
> ----------------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


