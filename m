Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1024DC25B7C
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 12:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D274988361;
	Mon, 27 May 2024 14:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="csQyZVgh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E7AA87D74; Mon, 27 May 2024 10:58:05 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF447882AB
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-48a395d85d4so725240137.0
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 01:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716800281; x=1717405081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ktyWdAC3D+l+bJUVH07zDbe4ynXJnIzhMV+YLYti5Vo=;
 b=csQyZVghiD5PqvCfrh2+UIjylPYTHSpVfUIbe5I81zZz7Kx0PvJAaziSgHJzpl52Ms
 v17lkKUyy3ApwT2fOGunP/MC+ceLvXhEB2/uj690StXCKy/n/HqqVE9uOXb/o0xEzYkw
 Wr3w7RvXgfNZbEinRCDXMNdxAFZjZMdJFC9uqXJ6MILdcZ7HhyJf8uwA0Cu1GtN/Dxmn
 rQwon4Jg0rPfiESAx4wmJhwpjOYe0fcE+Ych9/i3m7AHcjSZ2uAjWaJ3xj8q5K7z79EC
 /Qa2+TQ/edA39lZ+xFRfFNdrKxhnyOSL1jU+mbqvJ6DE51K/lZ38iAhvaTFIiSYAet7P
 gP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716800281; x=1717405081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktyWdAC3D+l+bJUVH07zDbe4ynXJnIzhMV+YLYti5Vo=;
 b=pQsaL82CVGOJUzEnLd+8n5XHqN41JnZZdvMlkujynNzQZTXEJGPFW7aDcHTq/3db8k
 MaNLt998NAHQd5l1Arcr0cAspTM5MLHkrs7/zCDTQZN+PJsRM5oXsfkhkEmLaTi+y/6W
 6DPAlMiGjF0iRVz1HfqkxzOKDQKeZSdlSvZpg3lJTd07RV9+QCt3Y00njwInoa/l4udx
 xWVGYRhWma903kuZi3Npw6d01sNltZJ8zLQLBxsWox1qnOT82Ffh6gWaMZAvQUnRHfHt
 UZ/HSsqsmKQMYyzMh6Qs0x8AtUXbJpVkh08SdQyrXjNES4lepRfXU2e476K7+h89WB2T
 ap5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDxPdcjOG2jP75sSRU6WFY1a2eVGdmhz83mEfjAsKXRTZK5N4636xLJz7mJUYiNTVPw49wGcrJG8k3xD5+gZv4/jYxfA==
X-Gm-Message-State: AOJu0YyGJ6LGgDLe/dnfs2OPBgS9EShKnWl30DflvPbsGgfvp5IbK5P9
 jCHBZgl4BdUQaTXGw1LE+wVNosrAOg9Qh6Gvkw9bC8uJMfEF+Beb0g4BluZKdoNpYD308WHwkR4
 qkSndPTsjKF0+ZnKzAwS4uJPiwGo=
X-Google-Smtp-Source: AGHT+IHZjfiujgkMP8alWpGKCNjsmYXs8BedTXWeIQJnc4BWxXeiwRbtrgHwd2lb1MI5GzvujxHJ25Yop9vRbKUHAcY=
X-Received: by 2002:a05:6102:d89:b0:47b:620b:c2a3 with SMTP id
 ada2fe7eead31-48a64697b3cmr1390198137.32.1716800281561; Mon, 27 May 2024
 01:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240522165801.1871915-1-liujianfeng1994@gmail.com>
 <7e603c4d-bf76-4b38-894c-30d2cf128217@cherry.de>
 <CAFA6WYNZh4BH6y_h_BkkVgHi3rNvsWd++mC2BDwqOF-NB8eHtQ@mail.gmail.com>
In-Reply-To: <CAFA6WYNZh4BH6y_h_BkkVgHi3rNvsWd++mC2BDwqOF-NB8eHtQ@mail.gmail.com>
From: Jianfeng Liu <liujianfeng1994@gmail.com>
Date: Mon, 27 May 2024 16:57:51 +0800
Message-ID: <CACQ+3oZs6xt5d3aFCBB3vesMqj3ebOoAqxkg=26Z3JMX5dU-vg@mail.gmail.com>
Subject: Re: [PATCH v2] board: rockchip: add ArmSoM Sige7 Rk3588 board
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christopher Obbard <chris.obbard@collabora.com>,
 Elon Zhang <zhangzj@rock-chips.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki <jagan@edgeble.ai>, 
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sam Edwards <cfsworks@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tianling Shen <cnsztl@gmail.com>,
 Tom Rini <trini@konsulko.com>, Weizhao Ouyang <weizhao.ouyang@arm.com>
X-Mailman-Approved-At: Mon, 27 May 2024 14:47:49 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi all,
>However... it seems we'll likely need to also cherry-pick patches for
>the GPU (should probably be straightforward as nothing would be using
>the GPU anyway in U-Boot) and the USBDP PHY... but this one we would
>need to update all -u-boot.dtsi for rk3588(s) boards that have it
>already to make it use the new label/DT, make sure that the driver still
>works... etc. Maybe not a small feat, but someone will have to do it at
>some point anyway :)
Kernel v6.10-rc1 is released and now u-boot is not synced to v6.9.
What about syncing with this procedure:
1, Sync upstream dts to v6.9 with command update-dts-subtree.sh pull.
2, Cherrypick all commits of rk3588s.dtsi from v6.10-rc1.
3, Cherrypick all commits of rk3588*.dts* from v6.10-rc1, which will
include dts of new board armsom-sige7.
4, Add armsom-sige7 to u-boot.

Best regards,
Jianfeng
