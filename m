Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C08EECE58B
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 22:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32CD38913B;
	Wed, 11 Sep 2024 00:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ribEVSdx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6045D8914C; Wed, 11 Sep 2024 00:38:47 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F9EB8913B
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:38:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a99e8ad977so368927885a.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726007924; x=1726612724; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwy9im2XhTZKwkZNcD3dDpOZLh+CDYRQ/JnoglJQEV4=;
 b=ribEVSdx6KXqML/TKtlUjVX6o/ANwsncmtM9GgW7m454+7MOdrkT8ai0X1QdQjNHHj
 1Fl6Tj1wuOHE8euaTGT4IBA9rOv8XfWsQvVuXQ3G62uHxPRwluVkRcA8jsdZltBAqNMJ
 qyF5nNSxOW7ZoaRvPGX1Hzad+D5uaFnqFCjLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726007924; x=1726612724;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hwy9im2XhTZKwkZNcD3dDpOZLh+CDYRQ/JnoglJQEV4=;
 b=Q1bk/DUCtdC+eTpQVGHNGtwuGMO8BHWdf18tlorU0Lap9sR+1mWeOveDQy0SFqVG+W
 OOkQ7kPcwT4Ng6ksfm+AckEYAdnwh+9WukP4ByBi0IeL38NkGglIFgN2MRJ9UbJj7la8
 oouTUpl6F8J6skUDtx9GR6S+CFhhK6GFB3/0HZ1mSziM0bCA3e38t5Qxdd1WNKYcD+qs
 eD03O+uLbi40EIi0tPSCayo4t1YLszjmpgrBcLsb0Hu1+vyhkFlG0/CbJPPLDHI05L9A
 bk8NQTN437uscWMjM7eFlCLsDL031ap5BuTI0/aqVZzce5YTF08vYpXfYNjXDLxqc9+I
 XwTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfladax4NwKtdLF3nD4R6PDoTmucvV8iGwhN9xOec+6tYE6rSZfB8Thks2r6GDyHvcL3yO7fk=@lists.denx.de
X-Gm-Message-State: AOJu0YzjNkiK7mF2bYRXbgA9IXw/vMySrLN+jhi92Gz0F09Z74qL8PIa
 Mu5pHVEiRoh3s43axC5b4n8vG0h9HGuApbEqG+fUlFDjwP7vkUi09eV2Z8c6A1Gvg2LN6sEGE0c
 CGpM=
X-Google-Smtp-Source: AGHT+IGU4iyMzCVMV5C4g+b6I74tDJbQ2aBJLKmyWj4S1BaWcffkhdd69LYI3SjoNbBxhDBGjPqAaQ==
X-Received: by 2002:a05:620a:4610:b0:7a6:68fc:ac5f with SMTP id
 af79cd13be357-7a9a38ebc06mr1719311785a.44.1726007924057; 
 Tue, 10 Sep 2024 15:38:44 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e63873sm34009611cf.7.2024.09.10.15.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:38:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: w.egorov@phytec.de, joe.hershberger@ni.com, u-boot@lists.denx.de, 
 Daniel Schultz <d.schultz@phytec.de>
Cc: upstream@lists.phytec.de
In-Reply-To: <20240830090940.2592157-1-d.schultz@phytec.de>
References: <20240830090940.2592157-1-d.schultz@phytec.de>
Subject: Re: [PATCH 00/13] phycore-am62/4: Add more boot sources
Message-Id: <172600792288.367866.12307630100869051671.b4-ty@konsulko.com>
Date: Tue, 10 Sep 2024 16:38:42 -0600
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

On Fri, 30 Aug 2024 02:09:27 -0700, Daniel Schultz wrote:

> This patch stack extends the phyCORE-AM62x/AM64x U-Boot by following boot
> sources:
> 
>   - Load U-Boot with USB DFU
>   - Load a Linux and initramfs from OSPI/QSPI NOR flash
>   - Load a Linux and rootfs from Network
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


