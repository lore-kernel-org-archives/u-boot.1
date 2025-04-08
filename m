Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511F1C36010
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 21:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8FFD82604;
	Tue,  8 Apr 2025 23:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i4rZXzzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ACF38346A; Tue,  8 Apr 2025 23:07:37 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 253D582160
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 23:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6044db4b55cso741991eaf.2
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744146454; x=1744751254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBmSVla5DS1eCr7HuGhvHGOL7p3pChBiLB0KCqBL3jU=;
 b=i4rZXzzg6OaEkukt+13ugxTaLIQPdnoIyirLOudnrQx8eIUCyVlnHXJutplW8qN2CR
 sy8OqYzWrsykffdI3PO8EFtmYps9eFV+GRczw9Jrvqbg2bN5pnT0Tpvdu29Whp+o3yx0
 Qk5f41xKV6uQvInNj2ykeubBdBWlITiS8/NOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744146454; x=1744751254;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tBmSVla5DS1eCr7HuGhvHGOL7p3pChBiLB0KCqBL3jU=;
 b=u3sSRI7/Xbarvcgd3L+DIq7i4MqMmP4OqPyQN/iUDRFdu+8B54Nw2Gdpt+pOfibE57
 dpC4sE6btdFByPZJF8qXXmn8BSTg/QxJ6N7qLXyHMwDdFv+hBW0G+KnUNZv+vHZV7SRg
 XhrSV/xvyMdfYcmc1NDaYRVj9mfruYvydDInUU1Ml8PXjCacmIaitZ1ws4iyPHBEVqzv
 zC3KoRAT07Xh1rUkDJCOcTo/7SmnNQVgaT/dxY16cHilNMneWE0MOu0G5P2hs6drQ7Rz
 0mofya0anqtXEOHYhEvnh0IaE2gnchqXFDHxIg1n/qtFEy4IsK1u/6iXy5mmAvfXcJ0v
 nFqg==
X-Gm-Message-State: AOJu0Yye351Tb+yZi4gONl0XvcalTRuePq6jd/MKNdy3OCWqZBgK2CYe
 q/yEgifbLLwwVKvDDQ0k+BdPfQamK3/b2tNpA5Cfd0CVsld81Ieqfe/JjQrNUcBS57GCx1Dg2Qp
 c
X-Gm-Gg: ASbGncuNEUu0Mcgehj2llgNPvy/TSnNC60VuexEk5bURDe9qW1WqOO3QdQAzzbJzxgg
 k2FjEYj9cne0UPTt7Ng74az0MfaXAUnJzRAP2PCbCm14BsRw/GZx8BDoyt7H35R88QnKjCRm3AB
 UQeSAzO4GSOnuaoGxrnbNElYWPAU6I/oZSmBFXlMRxFH4fnVAXa2NxbVqSnMW1Zc6V8TrWxP2wA
 4n1E/a1kQ6xCFqMAiU8DnviyVefnjMLo545E7FniNxvCB6HBFk/uGv9Y9lOlae+vtJNCiWxw8Ds
 epcJJX4955IYJ9ghNddOlMq4PWomBREPk/V6mBNINtvNkzi9Ml1xYmPx1AFf8n6QxYAhdCUWo0k
 WkfJw
X-Google-Smtp-Source: AGHT+IGxwq1ZYCpjexdQKSDVqGxcht83bvPLgw/0fKZ2/+n80693xIJwdwvyw3pcBkDFUrU8qM8HOQ==
X-Received: by 2002:a05:6870:4e0c:b0:29e:671b:6019 with SMTP id
 586e51a60fabf-2d08df95249mr364032fac.31.1744146453815; 
 Tue, 08 Apr 2025 14:07:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc845ca326sm2736321fac.15.2025.04.08.14.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 14:07:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-amarula@amarulasolutions.com
In-Reply-To: <20250408062847.1520368-1-dario.binacchi@amarulasolutions.com>
References: <20250408062847.1520368-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH] doc: release_cycle: fix next release version
Message-Id: <174414645288.1438641.1301451232366280649.b4-ty@konsulko.com>
Date: Tue, 08 Apr 2025 15:07:32 -0600
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

On Tue, 08 Apr 2025 08:28:28 +0200, Dario Binacchi wrote:

> The release commit for version v2025.04 forgot to update the next
> version (i. e. v2025.07) in the section where information about the
> merge window is provided.
> 
> 

Applied to u-boot/master, thanks!

[1/1] doc: release_cycle: fix next release version
      commit: d4c3359570a698679058fc4e7d422bfa108fcbfb
-- 
Tom


