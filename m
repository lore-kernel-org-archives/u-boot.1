Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52B4CD4F25
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 17:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B894836AC;
	Tue, 12 May 2026 19:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RicfAs2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E59C83E76; Tue, 12 May 2026 19:40:42 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746398341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ae6a0e523so711903f8f.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778607640; x=1779212440; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGG4nd1YAIYov5qTt5rE96b8JQO3OTkdN9hNK+VyXDI=;
 b=RicfAs2begcKdzepZ2aXbL38/nxMQjbWPJF/foPixPrFLmb5yHUtY6h+7eXlOpkeWs
 PsWfnOzQXmuapcH5gCeWWpHBTAp77t9FUox5UlBbmGrlC8GU4QMOodO4ueLfhk+s1qc+
 4T4i5bCiwh2W3Lu/0JF+kdHCuASZiq+eqTSd0NKUjNcj1QDM3fBplwr8sbwe/jARq73j
 LgVDR44jdkTcLdH2HJrw5bWEmSv5+ioGpcZUITGf4manqShpiOESY5PNiKDTp9BKeNzX
 9y/5GayQ/13MdzHg8tXtoGTcDJ2555oxLA/lwmSR4W2rZzpV+azb7IJUvfwrb9jYW9vA
 Hk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778607640; x=1779212440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vGG4nd1YAIYov5qTt5rE96b8JQO3OTkdN9hNK+VyXDI=;
 b=RC1OqevgWnP8SqraWif+B99EbXbiH8jPGRc7w0F3Szb0WWN5UvFzLvMy8oN5H5wfrT
 YiBSmbY03/UCxjfcvKP4ZsUtWpOn4JXH4VLUI3Um0cY6gjWo5pI44yeR6UhO3JbEOW5D
 92FjEdCo7VO3sXFYct8aprXZ8VqPm5viFO5b/pAurukxG6LOe2JjhcENfDcgNU6RgC2F
 Svgqqkj9kfetX1RUgntStQlR8C9FYywRgPcgvFDQ4i0q8YDAxcdN83LN7KMZkNE3eq5k
 R7RwXnhjaF9PLGDR4Dt5+sxnx7WYJ3Gnneqt5FCWoFSgaoOja0TkcPRgT2b3UI/ApCxE
 RtAg==
X-Gm-Message-State: AOJu0YzXjzs00yozYppOyxUHv5ZtEt908M7QbEIY1oN4jIxtNQcQ2Kky
 yPCE3mLhAIoC9b0HvA8MsdcKC3Da7I4dd56E8ZdpnoUuZf9XU7eCUADrP0lCpg==
X-Gm-Gg: Acq92OHMD41E+jK1+iv/inw4ThBaCNo4cb9gVzykuzgsOtXmKx12tylcsAL25Ry9tg9
 g+pY9tS6uiQekD8PbHPPvUuwdR+p+u9s1tsM/c7tGEWYej0dPTpg8TAEwxtAdzL3OeJaG+esLnl
 FPp1sbLnHs+BSI8xE88+zywMJU6TLcqb3Pcihp+cWn5vqNRCudHajI+vK2dw139KbD1bih16BHp
 6RSeEJtl+fEFPEsvyNIpGIOeIjwfQQttSz6sk6M1vBnvsH8J88ilBeqCWvotuOSv9idahZQ26w4
 R+AK4FM+x+BIDFzQkMMsgqZklxHP+Yxe077RjhLt1IjNqtOD7FRGThFrwzERnw89U97B0UsVdXP
 qL+nS1JOpV+YeYBHnTkgPsb+ktqi45fGu3kVRgDeJKY4rsAvC3Mqzm4q1veoCt6EiBCvVSYXb2X
 dhiFQt0Qt4nl3OjZwVaiIWoEFoaQhhxpxgc5XGXQ7wm9/KFRITevbK53gpGi3mFfAcrTDsiYBpN
 yw/WdjLC/elAt3QZg==
X-Received: by 2002:a5d:5f82:0:b0:44e:1984:5f3e with SMTP id
 ffacd0b85a97d-456a46e8db9mr22611150f8f.31.1778607639664; 
 Tue, 12 May 2026 10:40:39 -0700 (PDT)
Received: from jernej-laptop.localnet (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-458b3664e3esm18557218f8f.3.2026.05.12.10.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 10:40:39 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Chen-Yu Tsai <wens@kernel.org>,
 Paul Kocialkowski <contact@paulk.fr>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 5/5] sunxi: configs: OrangePi 4A: enable SPI
Date: Tue, 12 May 2026 19:40:38 +0200
Message-ID: <tA1cgZu-TL-SYDNUTTFndQ@gmail.com>
In-Reply-To: <20260511213713.15943-6-andre.przywara@arm.com>
References: <20260511213713.15943-1-andre.przywara@arm.com>
 <20260511213713.15943-6-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne ponedeljek, 11. maj 2026 ob 23:37:13 Srednjeevropski poletni =C4=8Das j=
e Andre Przywara napisal(a):
> The OrangePi 4A board ships with SPI NOR flash, so enable the SPI and
> flash drivers, also the SPL version, for SPI booting.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


