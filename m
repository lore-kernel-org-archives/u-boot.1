Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7122CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 16:52:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D5A2801DD;
	Mon, 18 Aug 2025 18:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m2gzK3xm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5CB880548; Mon, 18 Aug 2025 18:52:10 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97FCF801BE
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 18:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-743749537caso4724918a34.0
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 09:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755535927; x=1756140727; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4MDQIQpP7HujBlMfVIEMlCVuJbOZhX8n83rZig/koA=;
 b=m2gzK3xmKJepjSB8HdiZ9fzDlCSOC8H4vkDHaF8j9n3lI5eYqn0CrF38NVorpJvhll
 hVuHoSkRfLuIZbIefux6PDQD1NoKLEsY7HSWNTM3IPlyEMb7wkwPa3zI0ZzbM36aqKhf
 TnjVKdni4+b6RMFo7TVh/mZzAHBKduMVofNsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755535927; x=1756140727;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P4MDQIQpP7HujBlMfVIEMlCVuJbOZhX8n83rZig/koA=;
 b=MD2Ad1eSz5tgDMw4GOMTPeGhld0MxBgeasLKtE687Pkx1hedku5J16nNcTBfDkXqgn
 +nsFZZG6I6wzFVHHb0P4hEbFmY/BThKY8oD0eikAZj1mEQGPPMBot5AbKSMaxBwWXCIy
 BXhjoInrHqxteA2Tuad0PC8/LDUhwxYVsXvVUufYPTdTnfkr9khVWq6PztT/m05AnRhn
 96bHrx+385HWYqt9fm8565883cTPO4jzOGKtj9mWgBtZLjA2NZ7GT4MHqne41dAuHpO2
 AyrzOr4gZpYkuMGoIHaBu9M8UEzjNxYl+wz2qA89QH4xTmpPfDW7ebQrBk2G7gqmJbJK
 +Wsg==
X-Gm-Message-State: AOJu0YzctFRHrLzxBnurXFXPMn3J806IQzF2I+Zt1hcb+llfJXSru7Rc
 QN0S23dymXIvryUb/HZdJl0Q/ctupenBKwJeKryump7yPGb2NlaSshtqRlcpgYPavaicmLo6WqA
 7jj6hIUA=
X-Gm-Gg: ASbGncuYwkCQJ7qlb/JjsxR96ZfwSBYK37pgMt3RGM7MavtyP9C5kAI/jsMe5b/Nnil
 KHtuWWcA6qh8kaMSJQuhPUf3+8WhFxeMvxH2LzYMMUCfRWM/F8wpEst68rqEi2mMfUM6CwM+Ca2
 WjuCQKer4/c4o5sLNrifSPpm/1YnsfM+xLZTKtq8oKOZSGNqgngDZJJuJQ2yMkg2gW2qUH1kvDK
 snCPiPFeY0Zeur2yh/9EMQEmfFk9GufTW5v5SpJ/SIbtwOcsAKfdAuOXCB5XwR6V/4NZms1UGTF
 d7/5mD7KGl4vJKc2JLfomWaJ4uBzhXLNf604J+X6HygIfI4WMTQTkMyRK2RqTZVP2Nk1StHkdCA
 wEKvxkbPyVQf1I78nj/FSs1XicbVZTdXn39CtjizSx8qXtnB1kGLtFx8=
X-Google-Smtp-Source: AGHT+IES7CSfZYbvPwT0w7lOl/7dgAOv/LBmBJoOy92g14VNlY7I32ZHcpmEI6EvdNkt/UhUiTjk4w==
X-Received: by 2002:a05:6830:6b4e:b0:741:a2b5:3c72 with SMTP id
 46e09a7af769-744df09b92amr151484a34.9.1755535927283; 
 Mon, 18 Aug 2025 09:52:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439204d28dsm1976204a34.35.2025.08.18.09.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:52:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20250817221035.196421-1-marek.vasut+renesas@mailbox.org>
References: <20250817221035.196421-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <175553592655.3194065.5429494069653211071.b4-ty@konsulko.com>
Date: Mon, 18 Aug 2025 10:52:06 -0600
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

On Mon, 18 Aug 2025 00:09:09 +0200, Marek Vasut wrote:

> Fixes for newer revision of Retronix R-Car V4H Sparrow Hawk and
> fixes for boards which enable POSITION_INDEPENDENT and also set
> non-zero CONFIG_TEXT_BASE .
> 
> The following changes since commit 0c558bbad9e7581808b358091d1fd979f860e8ac:
> 
>   bootstd: rauc: Change global method to check any partition (2025-08-14 09:18:43 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


