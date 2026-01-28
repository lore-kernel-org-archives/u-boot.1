Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245BCD3F062
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 272A783F50;
	Wed, 28 Jan 2026 15:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i7+JP84K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1621083CEA; Wed, 28 Jan 2026 15:02:36 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5A183E57
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-45c838069e5so4210403b6e.0
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769608952; x=1770213752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWsTc/+qgmBDsXT0kOjuP6rjAwpiP90mdbVbix07OTQ=;
 b=i7+JP84Ky5TrzdQYN7sK2kL/RPLlhN7TNO5RMldUJm8zlmy3uO/7mwY4zFzm+718KW
 FVZD0YLije9s0i2xG5Y2e3fRF4Yjw/GeWtOleEwjRfITPZXBs63AaFPypoE6gMTyNYWN
 BulQwUmQPTR5kBa1Tthr61x9zV115qUPueZXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769608952; x=1770213752;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zWsTc/+qgmBDsXT0kOjuP6rjAwpiP90mdbVbix07OTQ=;
 b=TEHgrd4JNAZ7ya87tzIwOIBGm+Lf6caMPAMNbV2rPhQ51t8ox51QkYE3BcqmV2kkIC
 M/0pxywoaqxLz3Pt3KUDf3Y2n/weVkRjChz9CVwofYavBbmMDkKFTH5nSM+ZyNYTEkUC
 OrILuDoBUMvi3y+PPcD+rG3+LaMs1tQlYhzelInj68AUqaXZwJik0kCevytdTt0qXNso
 p+LUyIIVSBuXr/L6OodkmENA3H7OChmJ3NOQwS43sbIcdyU/9oUmts8q0Nt7zdoUncDA
 mL4E0HzL3+Cr7WH0shv9oaZJgcWTwz8DnRWvSb88Ab5JB8Uz4t4cra3QAZnCUf3g7qAy
 Ye6w==
X-Gm-Message-State: AOJu0YxV605Xf4B2vVj2JilSZLLIwJ0+L8hazf7KfMfnDME9Tz2AauUd
 NUOZoQK4/1Ry4j5ivbiXlm6IeXNQpr6no+Rh/1atEYeJmQYmC0W//9nYcmUIPzaKWM/tBFu07tO
 Rx1EL/ek=
X-Gm-Gg: AZuq6aLBoeOmZHceUY8oJHzhF9NdlITBZczP2r2HuU7sttBm0i/YWgvTXFdis0slV/4
 CZeKJRTyoDonwEMy9WWvEoh/c4RZodAss6vApMHOJ5qBQPJqihAt+UTcaMUtjCON6wXLgj8fVOK
 1+8uvV5V2fu8uvapYGC1Svjfl4V9NwZcpzPMiYhEslS2YcszYSWwAJ4ML8qRNPiGpFdgz1BH3UC
 2c+fqlfPxlFMONBKokrku6zQLpdZL40Kupny6Uz50Z8f7JDCPpwQ57oaFrz3GdU130uH/oGB9IF
 fqzDAJU/+C/RG9qByyBR7ktrF7+AwoOuTX79cSvmrqzzJCnoGq5oZR29xQnXle1M/Jc6uycu6qI
 /oJh8Yyd0aPxvbVN/2hZx4J1Sv2GF0mXO1q8QcKUMFQYNiFAao1i90vfzZedpa5IsZt1KQq0eFz
 yYBbTyQ1tkMdc6KBoSz6FNEdVNn0zw74Oofn9Y6WHsQvTDPyKkjxmyXrk+So7jfbEXRkhce6BM3
 ymXiMZ/qavjbtvWDgVh+2EVBp0P6ItrUowjyA==
X-Received: by 2002:a05:6808:3507:b0:44f:6a19:433e with SMTP id
 5614622812f47-45efc5945fbmr3413519b6e.15.1769608952471; 
 Wed, 28 Jan 2026 06:02:32 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095749f332sm1751438fac.11.2026.01.28.06.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:02:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev
In-Reply-To: <20260116-apple-defconfig-smbios-v2-1-861d707b466a@jannau.net>
References: <20260116-apple-defconfig-smbios-v2-1-861d707b466a@jannau.net>
Subject: Re: [PATCH v2] configs: apple: Enable SMBIOS / sysinfo
Message-Id: <176960895173.1640006.12564542066569295472.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 08:02:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 16 Jan 2026 14:44:46 +0100, Janne Grunau wrote:

> Enable verbose SMBIOS table generation so that user space applications
> can use the SMBIOS table to provide details about the system. The
> desired information is chassis-type to determine whether the system is
> laptop.
> Adding the chassis-type property is proposed for the upstream device
> trees in the Linux kernel in [1].
> Enable CMD_SMBIOS as debugging aid as the platform can easily deal with
> large u-boot binaries.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: apple: Enable SMBIOS / sysinfo
      commit: b0c6b5f4214ed1b76e3dc9efc6873ec441a860e7
-- 
Tom


