Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5DDC02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 17:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81F9680F10;
	Sun, 26 Jan 2025 18:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sJhBDVC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAFD980F10; Sun, 26 Jan 2025 18:29:11 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3483280EF4
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 18:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6dcdf23b4edso34574266d6.0
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737912548; x=1738517348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2nc2qGc/Rmz5zKmV1t6PESTIKOts65/yuOAhbDyJv8=;
 b=sJhBDVC5O93ge7aCUY+qqon/ODsUWXpyI2VrSD0hC2fRF6eFfdWgy438fXLomPAFeg
 MUDgkJx5ZACPPvd6UQ95U2Ou1lz74i6XKfrl/p3DyTMjFLy+cnaUOQIkS5bw3FSdLUC8
 WgBxXtHnJvky0t33/YfG4sDnagheYpqKfbENY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737912548; x=1738517348;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2nc2qGc/Rmz5zKmV1t6PESTIKOts65/yuOAhbDyJv8=;
 b=a6dco8lksNsgAkJ29T9hWH0VMDiLg97i/YqkwqsHDIImqVNxmrr8mYUGHPG6rNDuWm
 Pg3+967NnxRp6lBBFM5qnezBvlHLAxOBIG4cTFCbWyiwC9l0l4LQ1ONQci0Jq2NRbhEl
 xUikQ4Ky03KcmVkYACB0MU/eHmxefWDh5uq7CWHU4JwD59cBeRXqDn+MfUuqe1Y5iS5T
 H13F8tA83nrsqVYgtIpBngl96njxVbhnRwFzXh/qGPsiy/RZQh5JEHhKiCpY7M/CDkvS
 lSXvPrzB71Oi/uwRrsk6/cdrC2V7fpKmjBSBGCpwjH8s2mouIKsBqFyj5uNcL1DWSDG/
 Azjw==
X-Gm-Message-State: AOJu0Ywbe7niuxlOURuFB14Ns+9jA4vya/3Z4m2fb3GCmlgmL8rSKnxT
 3G9asMRGLGZOxvekv+VBPyWjMWgbeZzhcAdlioe2uEdMByU5GXyyI3hAcwpqvskP32PVmhqeW9O
 DhIeqNA==
X-Gm-Gg: ASbGncvrMwuabUFBBC3/Gpxq48PNlg6VAyfDzIRnIVfJpXw1h85Wbtpou6DBiJtkGes
 0opdRGmKcA6D7SoVAyhWCSgtOZ3ZkPKjXB1x5zT+C/grwKrs/WuyjqLIr+eKYV7l8RR+6dIs44t
 ALfTlJZQfca6V3g4t62b1DTYLPPCyYp9ziCinXAmwxSxJR9iFm8znC3RPieGqTkvmKdganV6QsI
 v2uwZrJXMwBME3IC5WxWidPPSfJdsu2vl2NRRVRpQcecsyz8jhlX6f8KzEujj7fSY30Fv/y3aQD
 oag=
X-Google-Smtp-Source: AGHT+IFPSj0EMRBfi8osZVAujLFJmuXPNyNRFLD8A8DVqaVfDphcw/bILN4uMGZXpU2iXIz1wAW1/Q==
X-Received: by 2002:a05:6214:400f:b0:6df:97ed:54d6 with SMTP id
 6a1803df08f44-6e1b2180604mr610905706d6.21.1737912547804; 
 Sun, 26 Jan 2025 09:29:07 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c2328sm27201416d6.95.2025.01.26.09.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 09:29:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <45b8506e-d2be-4a7d-9e59-056933b62755@gmx.de>
References: <45b8506e-d2be-4a7d-9e59-056933b62755@gmx.de>
Subject: Re: Pull request efi-2025-04-rc1-2
Message-Id: <173791254612.1335079.9815742367658330591.b4-ty@konsulko.com>
Date: Sun, 26 Jan 2025 11:29:06 -0600
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

On Sun, 26 Jan 2025 12:12:11 +0100, Heinrich Schuchardt wrote:

> The following changes since commit 292278d6828e6c8c6ae11bc8658586d1acc411d4:
> 
>    Merge patch series "gitlab: Fixes to get StarFive VisionFive2 into
> the sjg lab" (2025-01-25 16:28:27 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-04-rc1-2
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


