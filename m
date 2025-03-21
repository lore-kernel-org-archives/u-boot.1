Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6034AC36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 17:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A73EB806D8;
	Fri, 21 Mar 2025 18:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="deE+864d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE40807D7; Fri, 21 Mar 2025 18:32:25 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 756A2803DF
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 18:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223fb0f619dso49604995ad.1
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742578341; x=1743183141; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zUz8VECFz5GU23/xIqeabzYfRcCy2AEiOsDmCFV1mUc=;
 b=deE+864dCGECgYWZcNuJHEfyILAHga51o/b+CoFc6vVBxjEv5C9eaOG4nb0ON0guA6
 d4Us5pGJ1aX+CCEmsw4muZMOk/yEy/sSg0XAl9VgSALpLOM8LBK3JVDnnkWmdJETE2Bu
 o4PaXjj0sOj18DriAoVvtTIF0kvwPWQYAgJsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742578341; x=1743183141;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zUz8VECFz5GU23/xIqeabzYfRcCy2AEiOsDmCFV1mUc=;
 b=AADTtyoyldJGzlUnghWJ+HrkGcseRYIAHnkMXxTrVmcUj3pUA5+h+V/ZyK7sU/PEWE
 MiGnlIgFfUeXhNiet6Be9AyLWNlnwreUVCJTfpMZmY4LgcZ9ihArlLCHyCgR/hFvcE1H
 DFhWTyYzcv7WZtOii0Iioi9xNbfw3aIoiWVB8hlM3WbeAZ7DbXIS+NPkeODuO5xlSReM
 OpdxStklwyVnosSS5LWhNQyPH1znosfXXaagEiX8HLdatdODLeAIW8ZMVP18vh0oZ5oO
 oC67co/0b1I6WVKKQmHPv5QvoFhAvD42dmzhIbmybTwon8//O+QiSUK9E8n1bjKi3nEc
 XyXA==
X-Gm-Message-State: AOJu0Yy6elxKYKBHODyjLlx03XwSYKS4/Httat2qg57h4sv4LUuYjOXA
 2Bp+fHMGkTucoIbEDH5Fjj+WVur3ZV3zJoHfTAVb4vZ+S5X9C0TlPWA8NNJalit9HgCXVmK0LJE
 t
X-Gm-Gg: ASbGncuEsZgRN7VivpzaqXZqXcg5ev61dqcbNV6QulnJkv8w4Z5saC8lAXnJrmFBJ9k
 txWypODXleB/87SLl3mAPTQVpShmHNsFIl+l7lRTMBlHEgyDLGqB7MznVpTCj4iiPzHtON09QE9
 Gj5bXCwzz7G222zUn1a5AoPDSfZ9Xeg2rxv62iliM8kxUbqPhSaxZl7iigFwC8lDL/VhJoRZZ8R
 TdR6/rUTsxIUiriAw53BZuPWBHN7wbX4doXy9w+qrgj0c8JRuwrcUWjTsIcUl/Chk6U0wXje3SS
 +DH9clzygcm+J90oAXbDonYPi8BdlutBscIAEhiDZAUP
X-Google-Smtp-Source: AGHT+IHnUggU8xyMp+H7I946WEN7CFWUo05khDkv7/lzRAyBJQO2FGAjCudf8l5eUR+mCdTVsyxS1w==
X-Received: by 2002:a05:6a00:23c2:b0:736:a82a:58ad with SMTP id
 d2e1a72fcca58-739059ffb47mr6109788b3a.15.1742578341314; 
 Fri, 21 Mar 2025 10:32:21 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73905fab7c0sm2232869b3a.7.2025.03.21.10.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 10:32:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250321122947.26401-1-festevam@gmail.com>
References: <20250321122947.26401-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20250321
Message-Id: <174257833977.2184847.5845976662902855833.b4-ty@konsulko.com>
Date: Fri, 21 Mar 2025 11:32:19 -0600
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

On Fri, 21 Mar 2025 09:29:47 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit 8bc3542384e3a1219e5ffb62b79d16dddc1b1fb9:
> 
>   Merge patch series "pxe: Precursor series for supporting read_all() in extlinux / PXE" (2025-03-18 13:12:51 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


