Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A155BC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 14:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9E7B87536;
	Tue, 19 Dec 2023 15:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="phE4L8di";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 233F887508; Tue, 19 Dec 2023 15:55:14 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD6687536
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 15:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5d7a47d06eeso38265087b3.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 06:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702997710; x=1703602510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LW+c8b1BaRYKfVH2VzmPzX3aYYOD7VDCZ9Y1NQjdHpQ=;
 b=phE4L8diNPYbrLqRwvVNPLctB+nboaTeujcgcUc8iIXgmL7MSU72cqNOhYniOkNxiy
 GeaT788zro/IX51AehLuPPzXsHD/Ja1O7Lw7V5DxPPM1IYD/9w+jSYFImkALjQskYgGK
 7EpOYcWxdwsXzoY6rx7/MrrGZNPAlf3q9Tk0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702997710; x=1703602510;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LW+c8b1BaRYKfVH2VzmPzX3aYYOD7VDCZ9Y1NQjdHpQ=;
 b=JztEgH/IuTZ5kN9BpAI1wxYw+tvMeVdxD7h07bA55ayawODkO2I+rhaZdDTgjPNQZQ
 Ul9aQrLLDMSMP1B5WbYqtciatmBOAYsS/jeK4VBYXo1i5/Kvkyi3JFQ0LBatYedSMneP
 QHrldvdc8E1XMr70KOVwxmCLl+8pwhf/2OObeDuUE6dMu+WDQXOSbaQ5i4nX03ZeyygT
 CMMko3yFdxyd6g6bMuJyZjuct2tZ59DpR54O2Xl5LdNpFllSeK8E7vWNMlzLLcyLBcRC
 0gK1y/VgkDOkpTwn/UnD45ZVtg/Ku+YcnXQ1UVZiELdegJtTBvWw5dysGXhkEQZiDeXV
 xJDA==
X-Gm-Message-State: AOJu0Yy6RduA3DmjfBCRmLLt6Oi0gcyEKXGwzfQYZu/MJe7Uv8P13/4T
 3gnkhQazFq1OoUQ3hurvaEpYHw==
X-Google-Smtp-Source: AGHT+IHUzOaTMpaKDmj8b2ur7glYK0Vy0j1lca9wwBvZRFDU9G56itVDyGQawn/ifGvX0XMEWcLxzA==
X-Received: by 2002:a81:4a55:0:b0:5d7:1940:f3d5 with SMTP id
 x82-20020a814a55000000b005d71940f3d5mr13381358ywa.61.1702997709939; 
 Tue, 19 Dec 2023 06:55:09 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a0df504000000b005d746ac7f6bsm9657580ywf.69.2023.12.19.06.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 06:55:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20231122225711.96464-1-pbrobinson@gmail.com>
References: <20231122225711.96464-1-pbrobinson@gmail.com>
Subject: Re: [PATCH] doc: Remove README.sha1 file
Message-Id: <170299770907.2342388.11742238175739453147.b4-ty@konsulko.com>
Date: Tue, 19 Dec 2023 09:55:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 22 Nov 2023 22:57:07 +0000, Peter Robinson wrote:

> The contents of README.sha1 only refer to process around verification
> of the pcs440ep board firmware in flash. The device was removed in
> commit 242836a893ae ("powerpc: ppc4xx: remove pcs440ep support") in
> 2015 so this readme isn't really relevant anymore so can be removed.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


