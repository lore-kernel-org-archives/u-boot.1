Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66AFC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 23:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CCAA87D06;
	Tue,  5 Mar 2024 00:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B7O3tOdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D64871C7; Tue,  5 Mar 2024 00:43:47 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C4787FB1
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 00:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7d698a8d93cso2778019241.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 15:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709595824; x=1710200624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEJuP0oovS68y5qNLM7ViB4+9COy4tDaI8gCMc54DrQ=;
 b=B7O3tOdYNxPi/kxtLsi7xMJXsaQdN/Vq1TgDjUHVD+RyINk7wOVynkV3GWa3zm6sRQ
 PI4fqvjjp+BvAuMTS5oaS6GtrU097gFx0wz0FAnpvpiVI7kDen4KBUB5i95/09harbjh
 95cZzgQyH7ID+hNjHOqtg6hNwLjoZG5OxwGm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709595824; x=1710200624;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEJuP0oovS68y5qNLM7ViB4+9COy4tDaI8gCMc54DrQ=;
 b=GUKxr+nbF97iRaLZ+oOwhw2QvtG4ke39+SQ0BNfHNnbiW+ABtz/ovwqToiHxkhanMf
 OZ9QlRgLWSy5UQrBI9MOkdsx4bNaiQZ4Ssv9y+znT2oF/ADJQ++J9cLAo023uX/QIKRz
 orpHA9sxzJezR7XTX2gAL98Iib/XY1LcxWCQgwdBQ/8fCpbaNOqkzKUi8UcXAqQJ19xJ
 uzaVIre/na7qJ2tl1p3W3aAntoixP7Wab0t267V6PNVJG3mMI1AsUuaJQ3p+irAS/NYJ
 gycQvXWTy8NkQ5SWZaBpJDa6PyTWI1aDCp2fkKrIl8PObC56bKtG6vsBCzJm1LTLaE2L
 GJ+w==
X-Gm-Message-State: AOJu0YzpgUIHqQknlBjuf71YJ9py40u5j250ak4E1G3AMq8eVIv3VfBS
 7nJznwC08qAbpPmqX9X7i3h3CFj6iheeaV9LCrBZZ2yENR+wMlqvKCYim4TGqoU=
X-Google-Smtp-Source: AGHT+IHhBYTaATuNVhoZjEXImjcil7BolkGXhNrc4uKbytyXjJqaKCDUgvcWWqfIHKBPX/tXxX9bQg==
X-Received: by 2002:a05:6122:128f:b0:4cb:56c5:5816 with SMTP id
 i15-20020a056122128f00b004cb56c55816mr235062vkp.12.1709595824372; 
 Mon, 04 Mar 2024 15:43:44 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 fu32-20020a05622a5da000b0042ee44418e3sm2173101qtb.94.2024.03.04.15.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 15:43:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240220183952.3614252-1-nm@ti.com>
References: <20240220183952.3614252-1-nm@ti.com>
Subject: Re: [PATCH V2 0/5] board: beagle: Enable 32k and debounce
 configuration and fixups
Message-Id: <170959582360.2422760.4485410745026401090.b4-ty@konsulko.com>
Date: Mon, 04 Mar 2024 18:43:43 -0500
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

On Tue, 20 Feb 2024 12:39:47 -0600, Nishanth Menon wrote:

> Rev 2 of the series.
> 
> This is a follow up from [1] - Without the 32k crystal configuration,
> wlan doesn't work. Debounce is needed for HDMI Hot plug detect(hpd)
> gpio interrupt not storming.
> 
> At least the 32k configuration has been done for toradex and phytec
> boards, follow similar model of programming.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


