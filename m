Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2023C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 15:43:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3214D82E08;
	Thu, 26 Jun 2025 17:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z5wUYoga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B328382E05; Thu, 26 Jun 2025 17:43:16 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20FA082063
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 17:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-735a8be4ea9so205434a34.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750952590; x=1751557390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S55CTznoDhbtvSak0Idv44w2Xj4NA5h9w3DYWotKXRk=;
 b=Z5wUYogagEX4hexb3KZMYbxS55KpR/eVxnXs8OFHBFdr9YzxEMMMwq10lEAqEtjyKz
 +ckV9gKMFtj7KNa6PiPGdZg2j8pRai9hm8/pHSq42RXgexdF653W2Bp4qfijs4ajdnFE
 2l2OaH/vKQTsdjqmyX7TVKy4hhngfVtANA/EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750952590; x=1751557390;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S55CTznoDhbtvSak0Idv44w2Xj4NA5h9w3DYWotKXRk=;
 b=Ic5iW/rEb+VogLmGA871A6RQFDMIKDHXc6CqprwjIbRWEh0TqQ4tVCp5j1BtWau4pB
 QAElvHKNNYfs/G3LgM1R6OzLzffGlph9GdJyOy6kY9OnBFZLELHFHQ2Txj2/BmysQJCZ
 YFZbcr7ArHC4bTGSBI41OA8T+XEslFcwfS1cfvfZ4xoYPtBRHMIujFgDpAovrgomHopy
 BOj6V53oOeJmWqe4vWoYkxvLJorVfteIRLxlPl5KgvH0qtt/NzZgb2+/VTEuKmAGmfrB
 nDhn6RtLXA1DDQfkJeXMr4pKLlkE3Xp5CMfvTvGbJWT5Z1hjyDU+6MY3eOx2gC8rtP8b
 Bl7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRHpGezwgT/ojNdOdE0hfngDgpNYoRjkawbDQrL+evfqZ7/+rzhp0c60CiPiPXBDBo0IwSmks=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9uKAp8Z129clhba3nCTSL3QGMrylNuLlLvCZh7vqetZdgGWEb
 A9RVpkkyjpOXDwjnbsqF/dXofbpXDTvxMfb3rAHugSEg0HoT8HC93ZfeS6FsNyXjw5k=
X-Gm-Gg: ASbGncvWEyEMq88FBNgAb+WTJIZGKqXvfrVCpZi3wFHY4QE72BYk5Rwb4EQ/LwK9PgW
 aed0wWutL5kk2QQuk14rfnFKYnRTeE4SzJrT6j1UaGAzhUJqxbWu93Oa0lTb1fY/ObFDxykkA4k
 15F6Z07/+R3RiyfwKmbCqNTjEb09dlHYmM6a5iEH6emzvCeFNFjN5jR3o/SRhss2jJeRyq8yRzo
 jBo0IZPAG7Dd7L4qdbrsp58ixot8i/3VAqK7oGOBduZ1WvHLuUrKAlNZKuV285xMoqsfn1xlnlA
 OsDhey7nByqv1uBOWGHkUTv5vvFqIJ6yRnT416dfoukE8ugIWuiY8W+SbpHK+OaQT8+QO+9SB39
 Iwt37iuJIk/pXMEPs6+GcjQ==
X-Google-Smtp-Source: AGHT+IH8guuFC8TnMPMXBrzY3g9yRik/QiraXlyLOZ9ou3BcklKUsKoiS6arY0bfNMLbY5YJLhXivw==
X-Received: by 2002:a05:6830:668d:b0:731:e808:be5f with SMTP id
 46e09a7af769-73adc8f52c0mr5045406a34.28.1750952589756; 
 Thu, 26 Jun 2025 08:43:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afaff2429sm20316a34.7.2025.06.26.08.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 08:43:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
References: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
Subject: Re: (subset) [PATCH v2 0/3] net: consolidate PXE processor
 architecture type Kconfig
Message-Id: <175095258839.1712035.13071879747495961141.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 09:43:08 -0600
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

On Sun, 08 Jun 2025 09:42:25 +0200, Heinrich Schuchardt wrote:

> DHCP and DHCPv6 use the same value defined in
> https://www.iana.org/assignments/dhcpv6-parameters#processor-architecture
> to encode the processor architecture type. We should only use a single
> Kconfig symbol for both protocols.
> 
> Furthermore we should make the value customizable. This allows for instance
> to choose between "x86 BIOS" or "x64 UEFI".
> 
> [...]

Applied to u-boot/next, thanks!

[2/3] cmd: remove duplicate DHCPv6 Kconfig definitions
      commit: 14480c84dcdbdb5d7861fc1e1100900a8cd16e87
[3/3] net: consolidate PXE processor architecture type Kconfig
      commit: 092f0c45f4663d03340e50a4752ad56cfd8994b4
-- 
Tom


