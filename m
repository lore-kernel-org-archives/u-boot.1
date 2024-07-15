Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F32C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 23:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22CFC8892E;
	Tue, 16 Jul 2024 01:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gCKYQw4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1112388937; Tue, 16 Jul 2024 01:11:38 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC2BF88925
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 01:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5cce7626c87so1405110eaf.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721085094; x=1721689894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4VT1TVqoocQ4WIZeZa50Hh02V43rJFABDp6b7qICMk=;
 b=gCKYQw4usdgmloQIoYhsZVIsKZ3ZJ4Y4eyvGh4KQ22Y62z33E5j/5sudSpg1kVBU1E
 hG3SAUtMu1Iin5TVYygCck7f5TiAz8LmFMdIg2gXugCUDu9O/kyAOTJ12vXHbabGOccc
 ckeX80mLLtYhJXVGfk6Z+U6JQI+85WuY3wh0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721085094; x=1721689894;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y4VT1TVqoocQ4WIZeZa50Hh02V43rJFABDp6b7qICMk=;
 b=EYK0CR0yjABA2Lk7JCn6wIiuf1udw86WUInclfMUy9CdWkZRkrPieBELpCffHVXn17
 oVvtBmt3eotXb/SxVhzmIN/hSQ8KOq0QNa0yCYBA3X7Mx5WjkLKvo7CJomNsos+fjfTi
 OysCOjFKjOTAAp2UFtpTmWWpvgc2bMsZj/01hlmM99LXWaUY4oENjWoH0nyCSF5mVOVQ
 uXtaZuqRkDmyaHjDVZmCuIQ0SKwI0wpZEUmNf9IUdFCD3rnVNXBX2WD5TRI5cgZEmbEy
 puIKMV8dU6azvfW2ALHTw/7FrLE1qGYUEzXtxONXq8+huLJZAeUDxHoh/D9C0BMMTxD6
 nmvw==
X-Gm-Message-State: AOJu0YzYyfZmJEUD8GTvuWywREGAeylTTrT3WeFe39dQ+PIcUKkRPV2n
 oSPNnUbqNhZ1wRCSdMLMR9htzlvDw5eiWOVL339j4EaVY9yYj7mf2VnWzWKOyZU=
X-Google-Smtp-Source: AGHT+IGR/AqdAVlcMSX7uV7ehX1qYkp0k0nYQ2ex8K7+Fyf4LuzpIxaLI1uz0yzNhEDdnzshaTvlzA==
X-Received: by 2002:a05:6820:99c:b0:5c4:57d:691e with SMTP id
 006d021491bc7-5d288c6483amr681492eaf.2.1721085094539; 
 Mon, 15 Jul 2024 16:11:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ce758a36cfsm932954eaf.25.2024.07.15.16.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 16:11:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 01/45] api: Remove duplicate newlines
Message-Id: <172108509389.579757.8273689189158768172.b4-ty@konsulko.com>
Date: Mon, 15 Jul 2024 17:11:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sat, 13 Jul 2024 15:18:52 +0200, Marek Vasut wrote:

> Drop all duplicate newlines. No functional change.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


