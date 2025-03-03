Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E6BC282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 17:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D229811C1;
	Mon,  3 Mar 2025 18:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UU4rnB08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA43981269; Mon,  3 Mar 2025 18:18:22 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F0148118B
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 18:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-390ec7c2cd8so2216316f8f.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 09:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741022299; x=1741627099; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/NJOjMSA9TKHnjPW46PH7bulszvv5PE7bcHePAvxL6s=;
 b=UU4rnB08ZXgfrd/qzcl3WCkbY2wYDkaPoXNXrOAPUoi2cSEv9yK+GyPnQomjrA9475
 4ygJGd9TulSFpWEAcNJEk3dOuZkswJXc7fknCnvfktYPICmGG322wpFK9MkrcyU4Uv+Z
 xB2Li/PfZqLk3M/Ijc9UVB9imJBvoIhMrE88/SguZRRtXgzRdJnAI5slXNZm7tXuM98+
 fkRYBpaXoLHhcwdg43f9SGmkaGv78i7K7lkZ6vpUMjjZFjAIwyMtmjhR1mpU3bX4RT3T
 SE+nun9EFtBt3F5s+J18kMu9jbM10c/sxervh0vgrkQBSvdHFIeE21ZBN2bpZqOYOrwZ
 L9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741022299; x=1741627099;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/NJOjMSA9TKHnjPW46PH7bulszvv5PE7bcHePAvxL6s=;
 b=szEl6GJr3Ef+HTnSGBA8OCb6gbUUOKoHwtBsHWmkvgrmW0wdz1aAdxogyhsMNwYtqG
 7Moipn4ukTw4D8WG+5oXZgcpAF1bstSl++L2xurLs1EWpj9ggb4O6uYXI/tlUzAXAz1V
 9+X5jO2ZvoZ6lLRP1M5q+g3HaB10JnuD4KB9u4OROsOqMoD5IteyJAavlf+6eRFpEdPf
 ALLZxwGLm6nSJQZ9TL8Rm/PwR8eMz+9pdefgUPEnNxXYPg1xARDOe/Ij/kSWIJuxMhSW
 vCIZ3nJtV5D3vh6ydKuVVup3KaGxpjRoGJ3A/ksJBQcEMPGXpYrD+1sS+UA4Q6IRmepU
 jxiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfKOXL00HC3AA7VncHGge6HAdPCmaDo+n9feIv5K4edqWcuNoU4WgfjSwpgm9A996F0v8FOlQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwGNwo0R4nCWvP8ectuK7+fpjXLLFFnHY0iMHIbucLLMEzCGR0Q
 pN+gav84z4Ch2bL4DrgG/se4cF4yeoGr47PIQ1/Przq37ud7Gz1zJIywYCQhDBFJ9UGMVlNZzY/
 9+YdR7suDu6wrvwyx0gcOlDNu8t4=
X-Gm-Gg: ASbGncv7CRIh3fDwJ8cFDiBSWtKxc6S8UDJ51o15Om0aiXkOxzt2IxvCK8QhDSxOTf3
 WY/AXA2eQfMjpKdWZG/FTb9BK9Wp7dlZQ4CXKKM+ksA6bF31/JzHnAsNBrVNJL1CAMrDz/wTGCk
 UxPIAwiDP8lShQNsBysJfpmaYCSWg=
X-Google-Smtp-Source: AGHT+IGHC6FBcOf+nvNPSRf/LFtfir2VTsQ9JDWi7Wz3/AkM2War6L7IatHDB8c/fjSMP02NpY0IZSJyr2VIxK2vkVw=
X-Received: by 2002:a5d:47c3:0:b0:38f:260f:b319 with SMTP id
 ffacd0b85a97d-390eca480e4mr13843858f8f.44.1741022299609; Mon, 03 Mar 2025
 09:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
In-Reply-To: <20250303170640.GS2640854@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 3 Mar 2025 19:18:08 +0200
X-Gm-Features: AQ5f1JqAvF6Fxuj6NMK-51MNKM4iIJ3wsRBdF3jWPPcL3ObRccTHlBRBHnft-Xg
Message-ID: <CAPVz0n2cUpr8Z5xab5B263usyvFZ6prAEaZPubMxdZp5zhKFOQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Mario Six <mario.six@gdsys.cc>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
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

You may try this if you wish to simplify your uclass wrapper

https://source.denx.de/u-boot/custodians/u-boot-tegra/-/commits/graph?ref_type=heads
