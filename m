Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF219C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 19:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0A4D805D7;
	Tue,  4 Feb 2025 20:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fiwT2rbC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D76A807D9; Tue,  4 Feb 2025 20:43:31 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF8A805D7
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 20:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3f314ff6ffdso3375162b6e.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 11:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738698208; x=1739303008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B0p2ZYGI+CllaA9O2RhD7K9izo7J913qAVpzjmUjXwo=;
 b=fiwT2rbCEoAMmFQmooYWjwjDJzo2K82cUdNi4HWzJ86Agc00iKAl+KTm9H35SNBY5w
 pudo7IoItS2r6ANPCmT4VsOu2Lqwnd/Kx5zcPUrqOe1OnCb6ORBJpKnoNJh3eNYAnaRF
 PhWZMomn3MKLH1Qofm1LuVEskl35eQt5WXB5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738698208; x=1739303008;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0p2ZYGI+CllaA9O2RhD7K9izo7J913qAVpzjmUjXwo=;
 b=ahfTYgjrGHAvWPm2lnpjKTaQ74isfLOO3gJxuVFGSmdko/MgWFaeJMj/5w1WXdqmCG
 WPK0B2jaSOPrO0Pf+KuwCu6pHAYl2ldkyEYqZewV8oQKWJbEft0cDG1ppAUcWd8m/Aw8
 E0rqt+k5B+kYUKG+zpG+4Qf9cCCuu8M+aVx2PqK8fZj61D6dQcnVgH8pI8VjP2HCZeaw
 EYAcuY0K3VoX8kBIGQIYd4Fn/9gXXf6MqT/7FNsClIpcu9S2c+hWUT7xJOqQPxDj/uBO
 a8L84VYEDMJQVTapDcv6nmSibqFXTA6PFkOx8Wc51048jLlA/OlPv5XnuUsDgGL1Cbg6
 RPCg==
X-Gm-Message-State: AOJu0YzSU3Ti8l2+NhSbRj75xWMhJ1gnSZxVJ40nmwA2z7Wj57e0p+8i
 cRCrqLhZi1zEAZL4Rrs8es1Nhg1UxoHCKyrRO+vbU6RjMChVvQsVSikQg52xCiUOEQ44j7HfLgI
 9q3o=
X-Gm-Gg: ASbGncvEnc5ZSHfooFr371jKe1Vq4796hPRRMw9NIqaG8GXritcFXFwiE60jOMummDX
 bHWFmWilRuPCePN2W6bJXBINBA8mqINmc1PM0xO0O8RcJ1xXnowg4rcjddm6rDykpi6e6W6tZfD
 XEaTSF/cjcnJ0EaWH/kK01/Zf9E9dQES1jNUzTxTS2hWsTOy2hYq3rwRdG1mcjT0Cp2xQZP1Jal
 26EEaJqAuQTGXyIZky5WcH9U9q5b4SR/wKzMdOshFq7RcJKRYjMJAQitK3bVja2vYjVBktMgWxY
 MJY7KxrFawzGUA==
X-Google-Smtp-Source: AGHT+IEErPW5lcYzQsCLhl71rmMDyG8qCmd/NUOtE4BILepf1HhR8HCcKv2xffUteeeoTkVzQVBQkw==
X-Received: by 2002:a05:6808:1b90:b0:3f3:3240:5b92 with SMTP id
 5614622812f47-3f332405dcfmr15316582b6e.29.1738698207807; 
 Tue, 04 Feb 2025 11:43:27 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333690ba9sm3160867b6e.49.2025.02.04.11.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 11:43:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250129204712.2170920-1-trini@konsulko.com>
References: <20250129204712.2170920-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab: Add results.xml to the list of artifacts as well.
Message-Id: <173869820648.637016.15342748424805564017.b4-ty@konsulko.com>
Date: Tue, 04 Feb 2025 13:43:26 -0600
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

On Wed, 29 Jan 2025 14:47:12 -0600, Tom Rini wrote:

> Whereas with Azure the JUnit results file is available for download,
> Gitlab doesn't default to including it as an artifact to download and
> only makes it available via its own JUnit parser. Fix this by listing it
> as an artifact to save as well.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


