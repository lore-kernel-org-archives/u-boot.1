Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E4CCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 21:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C98B840B0;
	Wed,  8 Oct 2025 22:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QxDvjJ0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB92840CF; Wed,  8 Oct 2025 22:59:51 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78A8C83948
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7b97ce4fc60so101882a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759957188; x=1760561988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oo0mDCCalKy5DFgZg3QJUBt/Yj00cvy44nlCTwKZE0Y=;
 b=QxDvjJ0dcf9geWyEmNF5Uy9uITeFIXlCfeQZRNMD9NEhHXJyNCnS3fYAteK3cjj2IW
 0nuSyyN5euXnfn1Ktk51OpampA6G/KLFXBcBS8q6iQatw052AOil81IrLGy8GqNzUbvw
 v7keIjJvTnM3Uy82SvnSNC9dVStSI/m/v6GOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759957188; x=1760561988;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oo0mDCCalKy5DFgZg3QJUBt/Yj00cvy44nlCTwKZE0Y=;
 b=mLC38uVRc++HuiDhJd7ZGxcQuoF1o/3byIL1w8og8tKoYQkFN0dFPe++c+OxiCCDlK
 tsgW9u0qL7O9FgN4LVqXjpMG2Ndb8DD5PHR5rj1Tmke9vRyUh6CXihjkGn/Th+Md3rIu
 zr8aUOumey8A5N59JgnObUSnLYYIZoVhWCMvmellZU6qwOoMq1rv13JbQVNMpLWGPv4o
 uyPNsFExPg+MWo5XX39NRcIndKK8dM3esI68zjXApoJnzpYEKDLZemQyFOU9EsmAtdFO
 Kvp/wPS1YrbbfnBS9Zbszn6h3PCV3JV1W5edPwrRmeUxkTKcSFjisNXExCsBMSD6iquj
 psLQ==
X-Gm-Message-State: AOJu0Yyvk+gXylzJGi30me1Ogk3OdigJON6dCcXjT1QSl130unGs9xfh
 xOzxcDLeRQHfmJL7wS9vpWCb27lQQ9lE+fglUwJvBuZoAbh7ictliq8i6uCF3GKt5es=
X-Gm-Gg: ASbGnctC4wZZhTo9iFVDoclAJuDpm8WU7iZbpP1NuQFgf+iw/rzqR9IB6ZX9BXPBgAW
 xzpx2FjfdaExaXFs2pZZafwvOKuYYzFCm76a4PamkpCAAJnDKgBeazqYAeixrDACtUy8bX6U7B8
 kNZUC6kOS9LgVIw245EX0z+ERRGXhA0iHFYRhVri1CMa6lU7XUM+ePZ50D/8L3g980vwKLsbJO/
 XYNtTnXHC1A5tnHmYM9Iiv9kUW1S5/RbSkjSOfYqkGgXGAahbH6fpVWvz7DZqtYrTiPj3pLqr0o
 Z2466OcmdmW6H3jTqcy/yui1A2dcng7X4+ExHHaGuIW13nGzUNcRg4Q9AH5a9TbDo0Iudoh4qV9
 4zxV1XRYD62lOAFMZFUm7WfpJkPcHgc5Wi/U4Erq3y1OiA89TPs2JA3QfQZ8TM6uDtqUxxI4ZQP
 6my5p8nQzLbiv03s59F30=
X-Google-Smtp-Source: AGHT+IEuFuFz20j10gs3gzDSCDRNEv1gy1vFwOAvdAByE0UisuDrmlbP2nZuRQhu5eMBJf3v1/bOhw==
X-Received: by 2002:a05:6808:17a8:b0:43d:43a5:ccaf with SMTP id
 5614622812f47-4417b47098bmr2122924b6e.43.1759957188243; 
 Wed, 08 Oct 2025 13:59:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44189a67d27sm226052b6e.23.2025.10.08.13.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 13:59:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Adam Ford <aford173@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 David Zang <davidzangcs@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Mathieu Othacehe <othacehe@gnu.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>, 
 Ye Li <ye.li@nxp.com>
In-Reply-To: <20250906000609.284902-1-marek.vasut+renesas@mailbox.org>
References: <20250906000609.284902-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] thermal: Convert .get_temp() return value to millicelsius
Message-Id: <175995718691.3059512.8029181022233775258.b4-ty@konsulko.com>
Date: Wed, 08 Oct 2025 14:59:46 -0600
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

On Sat, 06 Sep 2025 02:05:33 +0200, Marek Vasut wrote:

> Linux kernel .get_temp() callback reports values in millicelsius,
> U-Boot currently reports them in celsius. Align the two and report
> in millicelsius. Update drivers accordingly. Update callsites that
> use thermal_get_temp() as well.
> 
> The 'temperature' command now reports temperature in millicelsius
> as well, with additional accuracy. This changes command line ABI
> slightly.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] thermal: Convert .get_temp() return value to millicelsius
      commit: 0ee639ff5af33342c6c2f4579e210d707abc9bc2
-- 
Tom


