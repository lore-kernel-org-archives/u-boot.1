Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83583D6DDCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 873B489693;
	Fri, 15 Nov 2024 05:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qsTJqqOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A77B896C2; Fri, 15 Nov 2024 05:27:51 +0100 (CET)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C48989326
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-50d2e71de18so674391e0c.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644868; x=1732249668; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ygDsqAJV9f+FwNa+CdPh9h98YMGFKiPhK11X6DCOsQ8=;
 b=qsTJqqOBVGi9ARXMCHkHRHR11mffqdaPTsEHK+Cmdf+AB1o/GIam1cQ/iH6Pb1Guj6
 /ppTH1Es/Gip4bUid6WmCeN5sQo6Wh6kYv8PNzzj+WmYT8e1OLzX9aeZmoVn6PTsEowA
 GeXkD/YH15rUwKX2Q1cfxTXIIMg+Sc694UMgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644868; x=1732249668;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ygDsqAJV9f+FwNa+CdPh9h98YMGFKiPhK11X6DCOsQ8=;
 b=GTWBQsoE6IYEvJp6Q6akecBAmirCc5gxNavGmgnmEtiaEnEeCqRznk0TThGBPQuS71
 uXbNrBgE1IPbgLuQWyY5z96KQquiDJpgvfZxiJp3EQQpxnxbR1xQS4NfpEFV4KXkCPOH
 LO6ftpvoqUtm5Ggl4QFoeTw9+nqPs2H0BNV/MuzxOGYnmKAb+w3Deb0UCm65A/ZxX3+q
 aWRHZfMEijTrcKrLX/Gkvil4K6rV3qq4Cza32VFSxMPpwgKG/tyikT163uhO0PZ7nALG
 MR4bKsuP7K/SeTRLTY9lbm6QFfpto4yFE4qjWuLk6nGwZGHIs6H/otfofusqIiCNQ4Af
 XDPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtKpZPFKYg+w2f+mRDZUmzFGV4uKnklO+CRwRI3r9sH8yFE84IP6jw9d9gvxLRw3GfJZTT67c=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0jtpMBkUlr6rbCH4ZsVsBEdyFKLf8gsOGmdSk9k3Opr0QuOfV
 X8ZekVUAymlX7lPZbZH9j+hzumuCTr8jW/v3X4Vgpg4WpLF4iUt0FwfV0/4zjNc=
X-Google-Smtp-Source: AGHT+IGP3BU5lq1J5dQPEPr8RGO8NShQ6tDVBeKlNgN+UujTB0NBV5pO12kipVv5tclHfbO856hAVg==
X-Received: by 2002:a05:6122:20a7:b0:50c:e37a:97e3 with SMTP id
 71dfb90a1353d-514786a44f0mr1686079e0c.11.1731644868175; 
 Thu, 14 Nov 2024 20:27:48 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.27.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:27:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
In-Reply-To: <20241102100836.103005-1-heinrich.schuchardt@canonical.com>
References: <20241102100836.103005-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 0/2] cmd: hash: correct parameter count check
Message-Id: <173164486592.1205089.7565345851837423186.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:27:45 -0600
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

On Sat, 02 Nov 2024 11:08:34 +0100, Heinrich Schuchardt wrote:

> Since commit 348ea878508d ("cmd: hash: fix param count check") the hash
> command cannot be used without the optional variable name parameter if
> CONFIG_HASH_VERIFY=y. 'hash sha1 $loadaddr $filesize' returns
> CMD_RET_USAGE.
> 
> The minimum number of arguments is four no matter if verification is
> enabled or not.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


