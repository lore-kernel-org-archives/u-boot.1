Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B27BC47DA9
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 12:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9182F87D93;
	Sat, 27 Jan 2024 13:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dmqy+pUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61DAD87DB3; Sat, 27 Jan 2024 13:52:47 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4251C8773F
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 13:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5cfcf509fbdso286718a12.1
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 04:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706359963; x=1706964763; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07aYIa7h+2LhXngEvwflOk9iFgxvhkiIgUouVu2im5k=;
 b=Dmqy+pUu8NeXTBB+AyBXy/RNe3vWxQAQDV7iPfao0rROtJGNLav74am7JGz5t3zn9K
 6Yl+/kAPxuX47RIrRNYW63TY5CVu5B2kCgRuEbZVbdHgi/dzDFP8ZD0Ud6kEMhUDreA+
 FNjW6PKPp7lK3cwb1rfPs8Vx06Q8nGreNAwdr4oYO4hGPXeKLmIBBSPgOdDTFeS0DedG
 PAU8Os/z/HVsca8Kq5iQ94gSIqi9k86VcEdwiG7g8d0bFJIV6ZZR36UoJ6N9j5LuLJe1
 78n+5hBsOoJhbP4euNtKcgh20buykGVtDuMW9Ty4y32Qchby0qmsuML4mdyy+pTUKwvD
 rLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706359963; x=1706964763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07aYIa7h+2LhXngEvwflOk9iFgxvhkiIgUouVu2im5k=;
 b=Gc8GWUeXX1ZKY67nEtNLLvNjDHfNnJHBtHjsRbbZg8JxNtACriW8YpBkrmckdK3CXH
 a0qfuqmhHF2HMaOFacxnPW00tsUKZBCroRkwq9bIQPR/lW3ZUeG4ArANyi5ZRHXJan5J
 BhoHCpo0WlgBVbnsj1pDoUEGCUHPGye+Xr0dnqrdSmTv1TvP+RB8wt4L17D/tGd0AT+G
 ggOAhxE4CtOtOjzm+bQoCU2fQA649o+mWiclj9uTuqjL4iczN/nC5SGVlf/mjp6kKZTH
 vBXapBvCmVUb+jH5jO8Qtlygu14jCwwtL7QfjdltGOaS3tI1Gp0IBKW4oolnte3H6ExD
 K93Q==
X-Gm-Message-State: AOJu0Yy5flTLtofzaAB2hxL6BH57RnQSvZX0ixzcK2q5VDyHWAHjY5sL
 +XuiWRY9yUvcNK28yqYnykJS/0gk5ouKyew5gFhtqzjJPRmVP2taExvvOsXd5k7JkTJF4pwyyHr
 bZQJX7u5Fp34bhq4loUAoPi+MXyArcLVW
X-Google-Smtp-Source: AGHT+IGyHqfTRHloVNVZKBECuDaanNiCrydIPQAjYWHrToDNIWaRVfavNSH9ryXqOVP+OmDFn5sQQgRGvcDuN7a5Kqk=
X-Received: by 2002:a05:6a20:1444:b0:19c:a03d:d8a4 with SMTP id
 a4-20020a056a20144400b0019ca03dd8a4mr731577pzi.2.1706359963561; Sat, 27 Jan
 2024 04:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20240122145604.171415-1-marex@denx.de>
In-Reply-To: <20240122145604.171415-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 27 Jan 2024 09:52:33 -0300
Message-ID: <CAOMZO5C9B0KqF7PJkUik8Y2T6O8nDAnZ=CM20uADhM91kOEt+Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on Data Modul i.MX8M
 Mini/Plus eDM SBC
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jan 22, 2024 at 11:56=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> Linux 6.6.y with KASLR enabled would print the following message on boot:
> "
> KASLR disabled due to lack of seed
> "
> Enable the 'kaslrseed' command so a random number seed can be pulled
> from CAAM and inserted into the /chosen node 'kaslr-seed' property of
> Linux kernel DT before boot, thus letting KASLR work properly.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.
