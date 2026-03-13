Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42F3107BCEA
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 23:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F4C84348;
	Sat, 14 Mar 2026 00:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OxRbL6mp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1791A84324; Sat, 14 Mar 2026 00:39:58 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF7A8439E
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 00:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d73ccee442so2900946a34.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773445193; x=1774049993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gn7FQiiJJGWX9lDJ+2RLs+XbgjA/E2G+ukx1NvN2y8A=;
 b=OxRbL6mpzjFULXHv7adi+c+Kx5iUVoMAuNUvKTMMAyyMCzKn3YVqUnRVpqHuDCEnkK
 dkQJU4ZnYKXR4sT4ZDL5vKKbqdbqugJMHyaMaaOfYx1BC6EQMPPSwSXHX17HZrjq4Cvc
 XkCIeu8INNUF6j70jFjL38rKgAR6aZkIITU5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773445193; x=1774049993;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gn7FQiiJJGWX9lDJ+2RLs+XbgjA/E2G+ukx1NvN2y8A=;
 b=cmh1LHz0qoXy/PVATuBut20fdonhFJwBdJH+hP0cYZGS0bPk61yt3MU2zO5Z6v3Mlo
 QjzO848pEpPXB4nOQOIftrTrEEqyAcjvfaoKn8o0+1fMcK4lB8TyU4HQTZUfiwWLx3Mq
 QPP2dQ3jVGofNzVBXKFwYeDb0oS/oDI5YUmS7boRIp972drKeUl+G6rsOMdLJLA0H+ZE
 gG6U9KzJ+GTDH5v1NfSgAxEiLuozMC7eoJbLk5cNJZYEG11QcOmy1CVJWB8lQEz/ljN8
 Sw2q1FtgUN3aUOQDONi4DjUPt6Apu8lPGioZgPbJHxJahRqL+BozrdAO2T7YRBpOumnQ
 SoEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2CqktHb8KW87TxxiQYmzyAGAhL7wWSY4EMKthZhpBNYLT9oXsJal7/ydP/iuKz02C/grzyrs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8dGooFs5QsvD4PBw3ragDM14pamDGU/mfMOe8eJckD21gNUT8
 XGba/3B74bDQPnhqr/xTDX7Vszn8p0o3ZoyaXO4rywowvC3pQWDdpFpcsa4fkvuZmKtouU9tl/0
 2a/DB1CI=
X-Gm-Gg: ATEYQzzL6qpS9sS4BY/FznGMEdoni5uphajQlctn8ICy2lte8eTE3R8uuFNSG68Sene
 KCzjW4ypauaTWmhuA1F0ygO2ZRHnmLjwqyb2N2AD/sMreg/1JQ/QbO9WodihstPrUdpcfbSN7/n
 736X37p/C7z5FvOWe/irhkRM+Auc12kZa362jfLvcV1bVBaytvmMKiM0uvJbYGSmfcnEU2QrYcU
 NJuXs0gYTlcXJw0yy7D03bUX1qOmu/bIYZ09+YOTbfdW3w94qNC7ldVWO4U2cdufow57w7Ro2c0
 Mg0qdXdhslXvCAqhYQwnR+QFHu6Kbl6XUmQABYwpZyfUFRx2r8qzWym89ocwVnsOS6TiEwr/oN+
 VlBupL3y28Wusgw+tdFBijrrWXQyJASi35F2WFTrGM5qyOW3nyR+S/0BxYoHKaFq+nXrXh7YNK/
 90Mkoa7tYCxG87xfUi0v+SJuKWub+KH7QvURwqcmrJez0GXG1HGdH4VWdMCn9V1prgwTXeMjlxR
 dOPTVNBO3bLBQ5RwmtIkkM/GUUVTH1uggZDJPpO8A8hkaM=
X-Received: by 2002:a05:6830:3698:b0:7d7:4d85:eb05 with SMTP id
 46e09a7af769-7d7825188cfmr3420545a34.22.1773445192788; 
 Fri, 13 Mar 2026 16:39:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76aec4c8bsm8096892a34.25.2026.03.13.16.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 16:39:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dominik Haller <d.haller@phytec.de>
Cc: upstream@lists.phytec.de, u-boot@lists.denx.de
In-Reply-To: <20260227014202.332157-1-d.haller@phytec.de>
References: <20260227014202.332157-1-d.haller@phytec.de>
Subject: Re: [PATCH 1/2] arm: dts: k3-am68-r5-phycore-som: Add PMIC ESM
 node
Message-Id: <177344519189.1178192.7561493999409624420.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 17:39:51 -0600
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

On Thu, 26 Feb 2026 17:41:59 -0800, Dominik Haller wrote:

> Add the PMIC ESM node which is responsible for triggering the PMIC
> reset.
> 
> 

Applied to u-boot/next, thanks!

[1/2] arm: dts: k3-am68-r5-phycore-som: Add PMIC ESM node
      commit: 965764975e8e174d1094e5b83bc1fabba66e782a
[2/2] configs: phycore_am68x_r5_defconfig: Add ESM and AVS configs
      commit: 1fc549959f98b71d43d6193b94b8ff5c4c2b4685
-- 
Tom


