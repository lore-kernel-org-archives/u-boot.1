Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE9CC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 17:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 324F988BFA;
	Wed, 21 Aug 2024 19:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g/1XsolA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC53A88DFF; Wed, 21 Aug 2024 19:47:31 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9179588B94
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3db1657c0fdso4241553b6e.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724262448; x=1724867248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jHRS+FAh6rDpIne8DPGZmP7+8bgsn2ucIVfUpw8ARO0=;
 b=g/1XsolA6cCNClQUCHnmSkW2mv/S1f5FMq40UyrWEBrErbVf+zDfAIO8mQz5eO5+pg
 FsnzfJXtDGjRf8yJgwa8we/zQpz+v/0BK68DeHCgCe396dF3t00Q8kKZVYy726sh4LdW
 nu4fw756Rvk7l3Yb17CVPt5PaZrzwXrPP3XKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724262448; x=1724867248;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHRS+FAh6rDpIne8DPGZmP7+8bgsn2ucIVfUpw8ARO0=;
 b=MnyXE+9f0RIBxcL6/EQnA03zlcjSFa+onpU8b8thwz1I9iwt0JJGC3VBL/Oui808aB
 vauBH71WF/EbM94F/P9Wesx5wRYEZQN28DN62AMMPmLKHd+LiQAbVKKMd0ldW/Jy55/4
 qq8Mot50+Ws4gPrl3H2tg/YuSPYzHGgul5SkbCLBc5CMLTToymX2JM0w8BAGvuFoKNVx
 eJg80ypxE06MLYeRMOyH95IjKsn/s90B5wSOKpUapME0MVehspJ9jm3AbHyHqBkbPzhP
 SDP7hfHlupnyw1HLqmWygKsky+ri2+2X2oaPiHSlxXIPYeqEy+qys10CFcXQQRUjitvA
 TcFg==
X-Gm-Message-State: AOJu0YzzPimuqt7RW/MOzjIcoE/qTyjiljlW7B4xtnyCZZNR8RNU8y/Z
 O9nTUMsirnWgp5FE+X7qN6PndOYxi/UNxCVbGdtRl1T41KIjMfZzGe66I4zHaANOHZ9duM+HC4c
 u
X-Google-Smtp-Source: AGHT+IHXLysCNkMVi/suHcRSv15bGQrT0yZm8Ejn2PnZ/YM/5l7w9waprZpM2Z00WCbYLhzR+pdgKw==
X-Received: by 2002:a05:6808:f0d:b0:3de:2137:ed1a with SMTP id
 5614622812f47-3de2137eef9mr233712b6e.41.1724262448093; 
 Wed, 21 Aug 2024 10:47:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd33d879adsm3364766b6e.28.2024.08.21.10.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 10:47:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240819210719.71747-1-trini@konsulko.com>
References: <20240819210719.71747-1-trini@konsulko.com>
Subject: Re: [PATCH 1/2] pytest: requirements.txt: Resync with the rest of
 the project
Message-Id: <172426244724.1427850.5623579270807890373.b4-ty@konsulko.com>
Date: Wed, 21 Aug 2024 11:47:27 -0600
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

On Mon, 19 Aug 2024 15:07:18 -0600, Tom Rini wrote:

> In order to build the docker container, which contains a download cache
> of python modules, we need to have our versions be in sync in each
> requirements file. Update some of the cases where which are older than
> the rest of the project.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


