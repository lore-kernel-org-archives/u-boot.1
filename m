Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84E3EB363C
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 22:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B01B83A1B;
	Mon,  2 Mar 2026 23:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l5daZG1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7566383A1B; Mon,  2 Mar 2026 23:10:30 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B13983F30
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 23:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d4c3484268so3864560a34.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 14:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772489426; x=1773094226; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5wM+HcNIQrSiaj0hScDBgOi4OaosF81F5dwEm5GgTSU=;
 b=l5daZG1P/2snawEJNC04sRQyCYj/TIM+xmPy0cBVZzRs6tPP6bd/dU8W3YnjwYJHZ6
 jf+iu0N9aYlo3/mOgZ+aPqPzr5m/hZBerGccOLlAvJwXvt5cObyrg3nbNYtRONFtg7t8
 kzkUZmE8Pv5/Iio6gQ+EL9hHYNMX2LSFsXT00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772489426; x=1773094226;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5wM+HcNIQrSiaj0hScDBgOi4OaosF81F5dwEm5GgTSU=;
 b=TKHKzolNhINPJM0GlPp1u9vMGbx4kE5icTDkOj6TeWBKVUM2JG9o9Ol/shkwBUb4Qd
 qUDd1yvJSmnJy79Si24sGou7Lv9UdJGBy8ifkYOaC2WLKylp8YncYXv7hYMaSusi/qBR
 Ri8wzM17eM3BvtN4XqFa1rgMVWztcNCog74AxO8cLzc2GF6niCHdCFZl9eMVeIE6UoTx
 7FqZHrOlYZOfsmGEtZDdfeOlDLs3PilJklJa7/GlV/fk9/q8n8F5NZeBAQxlffsHlKKX
 h3xALXKiyk0CxqHK0tb8V5L316ztMgE6/wREKUsOBspdpSzEgfA6wgZU8s2iCtqOuB4E
 VG7A==
X-Gm-Message-State: AOJu0YxQjg/8IGp/xl0MefF6txASbNThJuYvqNCm6pQy68VExpBW1tHh
 GhFHSkdXePfwhY/zjXPNrFrFRpffYsXgOqTM9k+ZYFL2PeKmndkckbCz77wE7eqd14c=
X-Gm-Gg: ATEYQzxzfXZ1qTt6un7sbP2tRHjH/xeCVoXfuI55w+kX/2QYECSYjkQfDgrWbos8XCt
 8I+Wmv552nGyi4Ky+Iibo+rxcnUkx9860YJJbRAc1wpsx6/znCOxPKaDn3hdbI6/8ajPyvrhS/b
 2MH54+gUT01nOzBXoXiBdeIKvgP6wdTA9P0NOvaMcEJBSkmfa98on7Xldzm7ICtpB/00VUYRcIH
 1UpqTTROKXYdEYmmQFersAcKWPs7FUwCgQXzam7XLK14LNitYax/kI/X9ZqZFzvIpDSU2Q74rwT
 ECuoQg1NRw93H7vafgl8kpsYESJOOp2ChcWIHk6F1v1NHpfl46d1n9pMwHNgL2/5OsfUqjFmgPt
 f2oQlCkCutfMd2+y8xbvvsmYD1Bg06RyZvt4ec2m5TDsSJjUu/wAZQJXkxqV13US/nzKatzbpJP
 Tax9qd0JNXXmE8qkvIDj5b3Lm5+fH+5+O+g7RUrhh7IzFT6W8i4p2UeGFnPfGg0VQD8wyYb1TQc
 +nh+nGI6pwaohKf5NlXzIutohysdCuqG0xmdV6X/DHAzn++HA==
X-Received: by 2002:a05:6830:6d05:b0:7d0:3a38:8fa2 with SMTP id
 46e09a7af769-7d591c1af77mr7851657a34.36.1772489426176; 
 Mon, 02 Mar 2026 14:10:26 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d586653f6asm12169132a34.19.2026.03.02.14.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:10:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, hs@nabladev.com, brian.ruley@gehealthcare.com, 
 emanuele.ghidoli@toradex.com, kory.maincent@bootlin.com, 
 peng.fan@oss.nxp.com, primoz.fiser@norik.com, 
 sebastien.szymanski@armadeus.com
In-Reply-To: <20260228220641.362277-1-festevam@gmail.com>
References: <20260228220641.362277-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20260228
Message-Id: <177248942492.3682483.38373118579273816.b4-ty@konsulko.com>
Date: Mon, 02 Mar 2026 16:10:24 -0600
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

On Sat, 28 Feb 2026 19:06:41 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit f6963fc232603007c661411fb31c57f1a9678a87:
> 
>   Merge tag 'mmc-next-2026-02-26' of https://source.denx.de/u-boot/custodians/u-boot-mmc into next (2026-02-26 10:23:12 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


