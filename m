Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C7E1077608
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 19:00:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5157483A1B;
	Wed, 18 Mar 2026 19:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tZ4fTB6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61924807C0; Wed, 18 Mar 2026 19:59:47 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6983805D7
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 19:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d773a4af0aso102176a34.0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773860383; x=1774465183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPT6G/1DNfZw00jrJhu5T7LB2RdJn+d+le4YOQA99uk=;
 b=tZ4fTB6sgo7ZpNbLd5TD1LMRc9ncLOPh+PNAipu5xN+YguDqMa8bBlpCvt4cyvKc/Q
 86RyDei6JJu2ZYKXAOrVVErG/UMhjMwIbP+WU/cdLXC9XDzCWqndjtR6xfGT4mIMqDG3
 +yHelvU/iRTb7nTiHEsW07+SXuy8neKsLWva0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773860383; x=1774465183;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HPT6G/1DNfZw00jrJhu5T7LB2RdJn+d+le4YOQA99uk=;
 b=jATDnwDuYuguc4npDjUvVdcgQd1m+NEX+UC8B0ID0di3i2ECghOjKSIeivOBVF+cT6
 8zzYJChs7u3/trx7e2Dn4cgE2bDNV7SmolFJ1YYTa4fwNuMIzNKHP7+4eRNj7YcQ96cm
 SRVqeXhsdfQ5BTRBsOyWyMcYMmufM4r4bZ2gDVcEIcZmgTJEbQ6bwETyM+MTZYCm9XqZ
 Z5sW+quMFLiL7kfNWvbQnwXde3rKNMFdm+vPsxCBHF/aPHAQx8fdcCpEDO9QyJUpdlIO
 x565Of/qGa2zvUXF370UynsmAQbHKGJoy/n5YJARR8ERMoAnXeQyrkjWxjda5XEURRAp
 JqEw==
X-Gm-Message-State: AOJu0YzzVa4f+qbJ1eGs9iuUBZ8gp1PzuaEuycQ3AVhKmfw7Z5eqktnr
 5+eBMWk+VmpAysiqrxxY7cmKOQQkhKiH6I4y4mH6SASB4v7ytVgx3d7ZyxbLzQvPvBIHatUjftO
 26wJVjQc=
X-Gm-Gg: ATEYQzwDP77lro58vcbTIdMye6W6mDQVIKkDZVt5W6f3vYZSZhD/uYfY0IKvREyioix
 kkNMe56fXqcYu9E8/rUqbqO7Q/HRxBFIxIOM87AvE+ZbaVcs+62qr/5AFf4XoccEIktfl3k1MQy
 ijILAmYgfgVqIS4zgtS1aEGPH8N1l8/Jc/ZvOHeb5gMOKozpBwfqdvCmhlTp+6ukwDN0w/Ljksn
 8KXh9vFrk8GanOEi4Nlto1AH0YSDijoLr1Rckhm12llIf86iCYm7Tvan1zNM/VaJQ87b8Ll5QCc
 jU3tYF1JePMTc+yuPZVQVBOZ9cn1LsZIx3Kg7UlBSCLOQZ3xpvjWX7lRfdKZWpLAaNwwDNBN+4u
 Q4iHJb1ZykHZn34xidmmLcH0jk+Bp9gLe9SH1dF3YsmPfH9kVpd4b5eiWsYUdPq3F0ju9oGC+7g
 LcBaLWUU8Yrru3A/h8zJrHqUtJVim6w1Jf95wvydfdTnj+8ZdjAIhPlnSI0xAuwcqI45NAN//OC
 mYSDthQreZxmLuN02yLnULtm1OqhDIdHa+rKb77v3+cUkU=
X-Received: by 2002:a05:6830:3590:b0:7d7:40c1:ef58 with SMTP id
 46e09a7af769-7d7ca53a8eamr2935314a34.3.1773860383386; 
 Wed, 18 Mar 2026 11:59:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9985c1dsm2807715a34.11.2026.03.18.11.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 11:59:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20260317230020.903607-1-dlechner@baylibre.com>
References: <20260317230020.903607-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-master-2026-03-17 into master
Message-Id: <177386038275.1227559.6440073315209833571.b4-ty@konsulko.com>
Date: Wed, 18 Mar 2026 12:59:42 -0600
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

On Tue, 17 Mar 2026 17:59:51 -0500, David Lechner wrote:

> The following changes since commit ba7bf918dafcd093ad733b07ba490baeb20cf5da:
> 
>   Prepare v2026.04-rc4 (2026-03-09 13:52:04 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-master-2026-03-17
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


