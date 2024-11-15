Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F94D6DDCE
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 04:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC24896CE;
	Fri, 15 Nov 2024 05:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f7HQSiSn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEF3389689; Fri, 15 Nov 2024 05:27:59 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C6AA89353
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-46094b68e30so9019271cf.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 20:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731644876; x=1732249676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqrVWcLM9yG5abj0S4XkGBeLC1uhOlEAwZbJj5PpPng=;
 b=f7HQSiSnF1J8L0xGB27SHQJwoLzX5cGoOUWhtMTmCjNlBo5cnXGtX0PQ8e17y7/Adu
 W2RLh16sNout3elkasDJoWkUbKwm+JsYgDEaMFYhmge9SJmFshj5G+/5WFuVTozKf0gZ
 ONRru6vKcDhRvpWhdSRqNJqbZKD7n9cPvgz3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731644876; x=1732249676;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqrVWcLM9yG5abj0S4XkGBeLC1uhOlEAwZbJj5PpPng=;
 b=Xtrf+Gab2YKvqqo00gvpIJDVF1k5T1Q/ioUR4v+guEqCGcryZF9n3uMqw1cU13CDn3
 ShL7lHmljnrMcQ1zeA9DzQgCXUrPGTirW+0Ag927pKGkWV5/g/zkMK2IDdqThAn1QG48
 B1pvyhyUDtihhEjuDHJMuXgW4u/ZdSVdz69qPziIFkmSrTWjRKPiyvHfKZw+ppXdxcg7
 M+ixgwaAYRlnBpQ43Sc2BKdpa7cK1AQMFCWoHUWugPAE3MP0s10JKQ2dXGLhbcok2laO
 5ujuJ8S13oRj4SzHurUSYPaC5dS/+nYLJDj0bqLHB+6rBK1HKJST81kpc33CZPFHkrpV
 oFrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqVfzlDQdC+7sGoas1jY8DICvQcnhBzCXbtfPk8bpyBBoh78B+3vTgt/aS5LJaG+OQs1YC+AQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyfonv2mAIt2Twzi++ZKGnK+w3Zt1+z73MW6hSrKxHKE3Lxtg+W
 BltUie7ghzOYcpc+xpeW3iHbYUugP5hDiXXrGsV8RR+R4GDySYmf3qmk55vKRmo=
X-Google-Smtp-Source: AGHT+IEOMc0KUBUd2S6ZZDQVddMvW4EA5iISABV63BtuZJ48PV1z6RqzPGop9CRff3JnWA2GRRsEMw==
X-Received: by 2002:a05:622a:2998:b0:460:97ec:3978 with SMTP id
 d75a77b69052e-46363de1c5dmr16132081cf.5.1731644876605; 
 Thu, 14 Nov 2024 20:27:56 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24bbcsm14415041cf.58.2024.11.14.20.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 20:27:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Alexander Gendin <agendin@matrox.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20241102154130.267948-1-heinrich.schuchardt@canonical.com>
References: <20241102154130.267948-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] test: cmd/mbr: pass correct buffer size to
 init_write_buffers
Message-Id: <173164487439.1205089.12835552936296578131.b4-ty@konsulko.com>
Date: Thu, 14 Nov 2024 22:27:54 -0600
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

On Sat, 02 Nov 2024 16:41:30 +0100, Heinrich Schuchardt wrote:

> We want to completely initialize the mbr and embr buffers. This requires
> passing the buffer size and not the size of a pointer to the buffer.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


