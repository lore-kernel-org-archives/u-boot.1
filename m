Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1CEC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B77F82AFC;
	Fri,  6 Jun 2025 18:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r7rFciX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 302FF81F0D; Fri,  6 Jun 2025 18:47:05 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A3F807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 18:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4080548891fso893460b6e.3
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749228422; x=1749833222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEn1csrU0bnbbTGvUuHK2BOSBAVgPRoNYaukJSfGHh0=;
 b=r7rFciX4MKQUac0+10mcSDHUAHK3pGLOizRB8Ehcu2cjk8aoI6RHEp0vsVU7YHrNC9
 IPCKkLZHomd9MVCyUqIjPwsDT+Xo69VTln+DJHHxGd40b5H6BXRcvitwEnId57A+GFBg
 E1LvWwB0WOBIskOwQ6lzj9YYvwHByc1o2bb2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228422; x=1749833222;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEn1csrU0bnbbTGvUuHK2BOSBAVgPRoNYaukJSfGHh0=;
 b=i2tisYReFHb8YvN/VU8qIfq8zsA+VyMD5FRelgKG9AZYEvFfhQTen+GAhBazuI0iWq
 TXOFXfPdkRGXjjKvLHqGxzbUWcZok9VdCncrTMrBdbP4PfUbRM0HsoR8xcTHqIxoLbdK
 ABKpKE7ElajoFtltlC3VnF9QPbUkFzDMNeiCyWDPaqaynhGh06wV8bAhAM49hMShsSLu
 1LS0yNjJE0OiYxybc48h5x5E8ja2H/1Mdtc4+XqsRF04GKH1fljQvOCJALdJ0rm3LB03
 7klA8JIj7Mubv7T9C4QcYQugXElu+sha6a1DrL2Ioy2USRMOaou2kuZzuQnqQz7QCQb/
 We1g==
X-Gm-Message-State: AOJu0YxY9PjH+UcGFBKYJdDoQ2AdzQxXT1HBfo4DLVCkW2pbUSIN86aS
 Q8vuHjCoDoGqPHKDSr9TPD7uvpcUn8uRnmPe7nNsI9h0nue2NUi2cjGEcJOSKCCaqHQ=
X-Gm-Gg: ASbGnct10i/r4XP3KC0YIJPGthwKyc/lwC2c+ubYqbwgJCIhthaoPLlIbEvHxdhfPLG
 qlUUO79nZBS4Orny5lglR6imiO0HjkQN9XxIB7W+bxbGMj3jq/kXWvKoUwgg4Dn887B/NB3gaHM
 NciL12Q6HLL3jjGDHDVy+LXOCr5i1dWe2HQen4t7J5HVD6V40/f77i4xCUtPGwUMwCXFcSL6o1y
 CUkRYBRqS5d+JmIlHeO5oCYksLeonRc99EyD018W/UwYQtzufk71v2+dXuX1wC2Nq6SX0dfsV7b
 N3g/SZSpHxLbUhpgrAyrNVTTfErqOmQZRVO6/GPCh6H87bXEaNIir6YlEByNnGJsxBo+jZk+C6W
 ZiECBmZFcBqE=
X-Google-Smtp-Source: AGHT+IFSz0wni0crbSxx1iYlDvMbAJO04Q/tOGlmj90lzp0JmwKa6peubZr3lQiHI3fJkqjZbkKA6g==
X-Received: by 2002:a05:6808:80b3:b0:403:51ac:2400 with SMTP id
 5614622812f47-409050b0d2fmr3207111b6e.11.1749228421907; 
 Fri, 06 Jun 2025 09:47:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-409069418a9sm377808b6e.11.2025.06.06.09.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 09:47:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Heiko Thiery <heiko.thiery@gmail.com>
Cc: =?utf-8?q?Thomas_Sch=C3=A4fer?= <thomas.schaefer@kontron.com>, 
 Michael Walle <mwalle@kernel.org>, Bryan Brattlof <bb@ti.com>
In-Reply-To: <20250528090536.765499-1-heiko.thiery@gmail.com>
References: <20250528090536.765499-1-heiko.thiery@gmail.com>
Subject: Re: [PATCH] arm: dts: remove k3-serdes.h
Message-Id: <174922842100.3195369.3719203386236764407.b4-ty@konsulko.com>
Date: Fri, 06 Jun 2025 10:47:01 -0600
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

On Wed, 28 May 2025 11:05:37 +0200, Heiko Thiery wrote:

> This file is a duplicate and also comes with the sync of the linux
> mainline dts files. By removing this the one from the dts folder should
> be taken that is more up-to-date.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: dts: remove k3-serdes.h
      commit: a822b95da4b799bdc2a42c06923af4359238dc9e
-- 
Tom


