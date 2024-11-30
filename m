Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EA5D73606
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 17:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CA9C89628;
	Sat, 30 Nov 2024 18:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KgqlOTCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BC7889921; Sat, 30 Nov 2024 18:25:17 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 323C0898B9
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 18:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-46101120e70so24698881cf.1
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 09:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732987512; x=1733592312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhSXEol0T4f8P8wbZUFPs3MYF6zBKm9RIctXG0WJ4S0=;
 b=KgqlOTCI+UOPrYFOtZ1KoB2RcXF9xx7CQJDKz8L9ImcfhKhryBeU6fQ9K3M3Pq+4b9
 0bh5vec7kD9oR0vQp1melz1TYm5z1Mb8pCU343oZpxL39ciRTxek4+VJuJOdiwmypkyT
 G0vM2c8X0r2nMeTvdCFblOCot1dnzqAinCuvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732987512; x=1733592312;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhSXEol0T4f8P8wbZUFPs3MYF6zBKm9RIctXG0WJ4S0=;
 b=coY48KifmpnZ4UFNiEeorUG/Z/d5oApdYQtHks344eS9Vp56B7oIOVgMbIIDtviC8g
 GpuIFBq6drbZ+etiAEd05HH/GHiR/3pUa2mQJLqzxZINtSo/St9RfWQLY+bfcUqN1KTy
 dvo+wf7S0cOZhFwLDdIBrINZy4/Ps0VxG5x4ow2hbDvVve3FxPbllQDnsYmrIOrgQzHf
 ojXEmpIdKAH7+bsERGGAvQ4EWh3c6J4lma4D0Lw7nRB623qN78EPfp7dJ2YJc7YBCI33
 5jJopCzzom/qrwYXwpgy7yzc9gibyWkPvgCLW7IUw7fPOpA1MexHidMTZUA2edGKAe10
 dH/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUamwX7zIJVlcUDSwcJ5AMzal+qaxekTlxgh6TZjODw1+wvu9axy+0IVAv+Tkn1ZltHVZHWbU=@lists.denx.de
X-Gm-Message-State: AOJu0YxTXei2XlKBdJPC6yItC0Y6Am51KTuOdfA6NG6kjwP3uJUf6TeI
 bH4KkjVPXRuZQ8FdXu25CpJN2fCfetivxx84W6XULDY7e7ql+R+6iec7TQBt+74=
X-Gm-Gg: ASbGnctJ5j2y0b1tN36felsQSnIoYQxLqOeEUAfCoyUm0SbfrrK5xzi4c2/CzmsqEsd
 PvRixTH8VaQW3sLfuG+zPq3qcTMYjcCS8Vz/eHlUx2/5doxv3QCmYJ3UXTDkHz7k8Wvm+l8G8+D
 zB9oeCR/Ni/FSE3N6qx8WaSxaBOFhBnlyPMhRYzmKkaIYQrX2j1QzWXZz7zGLddZSvnXdYH+hmY
 UCXJbcdWuQoS6fX8vmN/A/3G1zwxCT6VoqrjzoK0/6EXo33
X-Google-Smtp-Source: AGHT+IGrZXLjeighDaq9FGnPmv/voBbxOHPj7wVyZWtenAsg4XDNloqMgkQjVNASrO8yt+fCRvaxIA==
X-Received: by 2002:ac8:59d6:0:b0:466:8616:2553 with SMTP id
 d75a77b69052e-466b36b839dmr260791281cf.48.1732987512139; 
 Sat, 30 Nov 2024 09:25:12 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c407d882sm29218731cf.47.2024.11.30.09.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 09:25:11 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, Love Kumar <love.kumar@amd.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20241123212922.304316-1-heinrich.schuchardt@canonical.com>
References: <20241123212922.304316-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/2] test: add command to 'Lab failure' timeout message
Message-Id: <173298751123.2255080.14317438512199681114.b4-ty@konsulko.com>
Date: Sat, 30 Nov 2024 11:25:11 -0600
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

On Sat, 23 Nov 2024 22:29:21 +0100, Heinrich Schuchardt wrote:

> When a timeout occurs while executing a command a 'Lab failure' message is
> written and testing is stopped. The user is left in the dark about the
> failure cause.
> 
>     ! _pytest.outcomes.Exit: Lab failure: Marking connection bad - no other tests will run !
> 
> Add the word 'Timeout' and the executed command to the message.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


