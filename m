Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DB7CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD61683A48;
	Thu, 14 Aug 2025 20:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kxeIDkV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A453B83A45; Thu, 14 Aug 2025 20:48:37 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90582839C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3e57056daecso5110905ab.3
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755197314; x=1755802114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sM/wJBgoiofdC2SdqX455qy/fe3uXzNMNRvaTdbWsaE=;
 b=kxeIDkV46iz7E9MF/kgHxr/9I3vyFYd0zTYhIFurm6j+V7leQdx37SIrajP7eQ1R/6
 M1Nb74CcwUsAZbGzSJK2QjxJecP0bEi9VzhDkN/6pmpQl3rmhG7TDc+UVzNYzKKZilDk
 UVINS+mIkNB6pSbeB0CDMJMu6E+WE7zvfb1mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755197314; x=1755802114;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sM/wJBgoiofdC2SdqX455qy/fe3uXzNMNRvaTdbWsaE=;
 b=jhO91LJj3C3g4PjcQcVr9ukkMfGZUTOyutOneyct05+PQhJTbozywI7Mwg3alIVPEL
 GW0DvBnugb3P4HJm53VCniJp4OLDlQy3cVe4qob8bkCXjFXaOtNZZuCbZ8OfJzZ8f7Oo
 N3SM3JuyE8VA9o2Oy62OaC0h1iy5MyxixutNpyL6vgp8qPCdm1434ST9SCNpC6asnZdR
 vCy+ccNdEBG26gAygE8PU6Rw73s6b1zVg5MRX4/cCzWkIOeUw0wyCt4X7CaOZ47zfWBp
 tr6nP/sd2X7Wh3EUuha4kytUFLyWw5bWZvmNkDL6tINRs5Bqy4I3sBSAXYCloVNeBbQC
 v3YA==
X-Gm-Message-State: AOJu0YzQl7qxn2lvqytjwkSOhVJFB+tWDpdS9+TOuS802Xpg4xN692tC
 jmVF5V0ZyRnop6EeLBmOcL3Uo0ef2W7Kr1GGv25028WAjn7Lkrf4sbvbJcGIPiZfd5w=
X-Gm-Gg: ASbGnctW0hGa5kOkBDJilNTRqm8N8NfbljMEeCpYX9Yoy4SSY8wuoLYHmy1uTmo0QkJ
 IiqIwFYA/6D76x/4A7tumP3DtKgBhtEim54bS3SUGc0mL8KB94bgOp3aPGknQrep7gTYTgb7/ky
 Du/ZRyAlRwYVMf9FVKnhGz0nUUYKhfQYA2esvF7Bdz7jfGmKCIDwEPVVY0aZeR23MIltPWjstoH
 oUuqwJd/p5gy5Rks4PxfKJFg2IIeBzwaNAcz6XZi7DHbvMwZShNHGHVDThyoHYm5vwgR3biM/S0
 FKHO1Qz8NUym5HwILrRgINuG0lwzX/x7oSvXqNgdZ550+8EgBzxwiNrKLNnLZlWt5Ldz9Ygetfz
 7Jc0MEgnIXW8NOdn390ab8f6u35jNXqpc1LLmuvtpWAe1qqyYYoQciYI=
X-Google-Smtp-Source: AGHT+IGY9PgxC+PZRVUu84LcWa0zFh8Sdpd1Ls/jMmX4AD2xvQLTu8UNcyEUk73M5y2MXtChJNI6eA==
X-Received: by 2002:a05:6e02:160e:b0:3e5:5937:e553 with SMTP id
 e9e14a558f8ab-3e57079cbf8mr76202975ab.10.1755197314241; 
 Thu, 14 Aug 2025 11:48:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50b3d6ff137sm1219762173.41.2025.08.14.11.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:48:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250804215253.1412420-1-trini@konsulko.com>
References: <20250804215253.1412420-1-trini@konsulko.com>
Subject: Re: [PATCH] pinctrl: Tighten some pinctrl driver dependencies
Message-Id: <175519731320.3600102.9209965894883370039.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 12:48:33 -0600
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

On Mon, 04 Aug 2025 15:52:53 -0600, Tom Rini wrote:

> A few pinctrl drivers cannot build without access to some platform
> specific header files. Express those requirements in Kconfig as well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] pinctrl: Tighten some pinctrl driver dependencies
      commit: e7a95ee2b575d7f0f44da3b3aeb951508eac1511
-- 
Tom


