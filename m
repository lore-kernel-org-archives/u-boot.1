Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5621BC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 03:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF7E788ADE;
	Fri, 16 Aug 2024 05:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ph664n5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6639C88B7F; Fri, 16 Aug 2024 05:47:34 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53E9D88A82
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 05:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5d5b22f97b7so1260086eaf.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 20:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723780050; x=1724384850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKkg1weeRFYmXNUWlDgfqohbAM1jhy2UfV0WnA+2wMk=;
 b=Ph664n5HZWznrkQh/8Q76eINLqc93JhL39QQxjpqfjlGhfY+hDjsdPak5C9bGPc7fD
 H7ZiXQTkpwTW+alVur9n5CPBR+XTANVat3p302DXFwZaR2a5z4MgqkcyJWRg+oprKmOY
 vypRy+oe+H51fH027VjtpOF+sr11BiMi9hsHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723780050; x=1724384850;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKkg1weeRFYmXNUWlDgfqohbAM1jhy2UfV0WnA+2wMk=;
 b=e+s/QerKJ+mpb/QpNzfaOKRND4mo5VvO0peOZ0fKhmOdrbqJJD93YNCktWM3fIIGHW
 zY0LpsWxvA76Vo+P1Tb6z+dQ0zJoAQU7tydXMJnwlVSwQymSZyimYUW8Ejd1tK5Cj0WC
 kWqIlPQUI1rFchxDqaNxewAI6YASRB1UZyIPLlcY7SpVt4hmNmKnJ69+eeJIkdLKMyNz
 HqDnb7D7Mp6vQ/Ymu2cRkG5qmFN+rOvX6EqdaMbHi37qq3qzVhB+2IJ6czhBQoo1c6oA
 m+1WMs1zAFl39M6IzttsnmzeEGCuN+mA36bcoY+0WPnkHJVcjSbdhWiNIVt8I9QMIWOd
 3bxw==
X-Gm-Message-State: AOJu0Yw7L9nxYa7iO+OZfWysmMhatfZEZnTZN2HqyaXBCUCkB0iB2QCC
 ZlPi5bM8LDNXUKQwUcz3bkrmf8LeiJD/1Ipt4wfDo50vPwvQorp+9cr4usUAqOA=
X-Google-Smtp-Source: AGHT+IG6AjNrB/8NBQwHmuVpYioRxlk0Q3z/TalKyln4+LwDzVkQQwjRI/iTGa/fj191QiOEUY+Mxw==
X-Received: by 2002:a05:6820:1b91:b0:5c6:5f2d:8430 with SMTP id
 006d021491bc7-5da97f21105mr2401776eaf.2.1723780050215; 
 Thu, 15 Aug 2024 20:47:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cd69811sm541522eaf.4.2024.08.15.20.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 20:47:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Richard Weinberger <richard@nod.at>
Cc: sjg@chromium.org, Jixiong.Hu@mediatek.com, 
 marek.vasut+renesas@mailbox.org, patrick.delaunay@foss.st.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, seanga2@gmail.com, 
 upstream+uboot@sigma-star.at
In-Reply-To: <20240809095430.3656-1-richard@nod.at>
References: <20240809095430.3656-1-richard@nod.at>
Subject: Re: [PATCH v2 1/3] ext4: Fix integer overflow in ext4fs_read_symlink()
Message-Id: <172378004914.3540666.1004667029738996969.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 21:47:29 -0600
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

On Fri, 09 Aug 2024 11:54:28 +0200, Richard Weinberger wrote:

> While zalloc() takes a size_t type, adding 1 to the le32 variable
> will overflow.
> A carefully crafted ext4 filesystem can exhibit an inode size of 0xffffffff
> and as consequence zalloc() will do a zero allocation.
> 
> Later in the function the inode size is again used for copying data.
> So an attacker can overwrite memory.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


