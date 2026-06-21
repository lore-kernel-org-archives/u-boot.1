Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA594CD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 18:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3235D84119;
	Sun, 21 Jun 2026 20:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KvgqVcsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1A2884844; Sun, 21 Jun 2026 20:37:45 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EAB284105
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 20:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4864a8e80bbso1713250b6e.0
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782067062; x=1782671862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1z6z27aGiXnQSDGYjG/G3oZmnLEGaXF9obhbfk6oE4=;
 b=KvgqVcsh8PeMaNSdFmtS/CVnMqK0JtIULyfWJhspyOAIZJwxjbBgdaMjmXLQC6AKVI
 2NsVog0lDc2Hw/QoZZK8eoYiaToMyXrpFRZ787IPRoM3BdrtmYZPirI//EjGvDiZRPTI
 hyVW1bikOMZpP1EoUjut72UHMxx/f7svbWyoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782067062; x=1782671862;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B1z6z27aGiXnQSDGYjG/G3oZmnLEGaXF9obhbfk6oE4=;
 b=P2b/lWcsEnMD2Z6TLk/Gbh+vMU8UdPUqyJ45df4x0PL3GfqYNqhEB4APs0AVub7gPZ
 P1JwPUh2nUweIIY0s2L1CeX6SC/d/Df0auoew6Xon2ZtSXOdfBj1Fr2bsj742Kox1b+y
 mC8Bzu2to3ddvWfXvW717RtzHEpLfVowvsNBWown6fhphAiYenDlenSUqcjHu6uFcLCi
 VYyGzYd9O8DQfGsSAUJwrrZBCcy1xylO+wpRYVMUd+NBFV+P5MKAlET3ALxjZDHx9i6g
 3cWdjTPylYsgN7aHoA6idymRl2SsmI34Eo2ofYS+U/gxsF6eIfP4adEiltSfbuDi+DQG
 Uf3A==
X-Gm-Message-State: AOJu0Yw9LB8Wgp79rfW1nmwuGK/B1rbeUIUsr4tIFTVg6qB1UVva9xre
 m5XCUyOZDrG1i7/CXpfcevUXRH0ZpN5J18SR6XOrD41njkqfP1TT9AeintDabZ2EEUg=
X-Gm-Gg: AfdE7cmBhxTV6Oa9dYCe7kB0Kify8tqhpoH/HURNPKgH1iKIA3OZUjfRtu3HIuORWjr
 fukmJ5MCcrrsrm+/M1saJ5RKhxnZv8dQMA3IPyCrzKJJyh9qPySLxOFjgcLdFuRIdKjMx4u+HwG
 +PBZIXF5KRiHQm+Mdzezy6Z9Ll9OpYTscq6oNGyeBboKxJAVsOSoRo4hsYjer1ynLGZXd7uOR2p
 jY5KlkDu4FKQD6i6fntLrnKuyw4VjdQahcT+ZosJD4gfgqJ6pJjqgQsti2vNZO8vAJwesCQ8Z3u
 d9hLTI6x7jlLTL7Y+Ro+NWWP59CJrbkHM1fJt/brgmKwEU9JgK4L46xPcsAbgdioDfmqqBrAtvA
 ir/6UBgn2iJsM8HAQOa5IHA++DQPvfldrUI2EiHfUMj4pCfJE7eUA7lI75Hat7jYUkGS19oPjSy
 cIJ7jfRjqJrL/cbEc0r/5CqndMqFVJodSoRd8EQ7HSuLXnIvtvwgJckl37MAUPSl9fXodWFo5I0
 AdoCwYxlHU0u/aBC/md60PNuY2ic4ABxrDQMDc=
X-Received: by 2002:a05:6808:13c4:b0:48a:3f80:ee5c with SMTP id
 5614622812f47-48a3f80fb5fmr6899535b6e.23.1782067062248; 
 Sun, 21 Jun 2026 11:37:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-189-154-245.totalplay.net.
 [187.189.154.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48aec0ddd7bsm3210170b6e.7.2026.06.21.11.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 11:37:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Denis Mukhin <dmukhin@ford.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
In-Reply-To: <aaa976b5-693b-48db-bd26-6be981757413@gmx.de>
References: <aaa976b5-693b-48db-bd26-6be981757413@gmx.de>
Subject: Re: Pull request efi-2026-07-rc6
Message-Id: <178206706089.4100406.8962840667735740961.b4-ty@konsulko.com>
Date: Sun, 21 Jun 2026 12:37:40 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Sun, 21 Jun 2026 11:59:38 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 922cf29dd8045f7348ce0f20145f46e8235faf21:
> 
>    Merge branch 'master' of git://source.denx.de/u-boot-usb (2026-06-18
> 11:41:22 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-07-rc6
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


