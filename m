Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE7DE77179
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 01:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0F089434;
	Sat,  7 Dec 2024 02:03:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WoZ9ipN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F125895B5; Sat,  7 Dec 2024 02:03:21 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F3B89124
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 02:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4674c24f61aso1204751cf.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 17:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733533397; x=1734138197; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FbIVFVjhj133WzLhPa2gzmwvAjoQzosaY23822ZXws=;
 b=WoZ9ipN84GnW0YmRgTN1C0KzSQfDhFjTHMxtHFlByCUHLA0BD39Qc6i/ZuibojkXiM
 13an5ErgcjlpPGYNaR/JsqOHhr/eLGkRV/rvIE4OMKWIJfF2+5UQkPkpbghn4aIfslPi
 ZCZMvrfHArZnq2oHLWk8EaE4meYkLPabVz9Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733533397; x=1734138197;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3FbIVFVjhj133WzLhPa2gzmwvAjoQzosaY23822ZXws=;
 b=JQFiQ751PZaVzVXGWGA00FO6wBfs3ntpXWeVcbynNqqfDi2FMYjfQ3ANd5w5BENCYL
 VpIHKuxyyyRrJIjQjG4nBhxidpZA96MHXoLg69vgD1k3VpvqpAjJspeaLdTh3TcyrBWK
 lHlkz7wcEmCf+C+MMgwcAfvY3W5AYPLnYIkAH70VfwrTFEXicHoDfZQt7NIB6HsPiwKP
 UtTP6chsshOF86QdfGa/337BGk2sQRfQLeoFJCz8PgQ6RJcgiWeFbZ1GYigvSUja4rdf
 Si2LEyQ00D56DBUQVoh2gmEvdaeQoGqI5jLX1stC+OUVm4qGbHbf57w9mpHur41eUJek
 /F9A==
X-Gm-Message-State: AOJu0Yw98wmfIO5K/NITh1eTP3FYWDgdvdvEFVnXf7GIbgolVw883pT0
 JmYZsNbKlft3wYWGHuJMTnq9Y4V1xd32UJKH6g/YPgkzT2sCRd49uX/OUn4+0CTQap1wkdMmhav
 WrGM=
X-Gm-Gg: ASbGncsZPkrURGa8bBlH3iuwbCScQLyHAqmj3CoXawbNNd9szba9YR6lUDw/PRgknYU
 WAADnrxuGlCpd9qjxi9Il6AMdJJsDdp0G+SmNAh+5VlSAf80sZAGVAMrZNfjPGSc+YkdodlwG/H
 AqimrKlUuVibflWRcr+x6t1BItr9tu/I2UGYYmHoFObiSwxqCL3a9WUJ3YGoUiJG9jMiarZu8fg
 /t7fQ4ZHKW/zEXh335mY9u37ISu8FboXu/z/hfJcR0aeWtvDw==
X-Google-Smtp-Source: AGHT+IEOVClTxpIMxfclVg2cSYMOeVvARRlxFQya/lBBUJ+sKrvuSgKeYjI5zDQVJgtgUDg9xsA/2Q==
X-Received: by 2002:a05:622a:15c8:b0:463:648d:23 with SMTP id
 d75a77b69052e-46734cb51ebmr80814931cf.14.1733533396921; 
 Fri, 06 Dec 2024 17:03:16 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467297cd6a2sm26834331cf.84.2024.12.06.17.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 17:03:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Jan Kiszka <jan.kiszka@siemens.com>, 
 Baocheng Su <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>
In-Reply-To: <20241121-am65x-v1-0-fe87aff1b5fc@ti.com>
References: <20241121-am65x-v1-0-fe87aff1b5fc@ti.com>
Subject: Re: [PATCH 0/3] board: ti: k3-am65: covert last board to OF_UPSTREAM
Message-Id: <173353339489.3658905.4449124377864149785.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 19:03:14 -0600
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

On Thu, 21 Nov 2024 15:17:48 -0600, Bryan Brattlof wrote:

> This small series converts TI's AM65x reference board to use
> CONFIG_OF_UPSTREAM and removes the unused device tree files from
> arch/arm/dts.
> 
> Because it's the last board using a AM65x without enabling OF_UPSTREAM
> it allows us to also remove all the SoC FDT files as well and keep a
> single version of the SoC's DT files in the dts/upstream directory going
> forward.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


