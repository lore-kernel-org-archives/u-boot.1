Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B09FE83827
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 19:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B6183E36;
	Mon, 16 Feb 2026 20:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hxez/NZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF21380325; Mon, 16 Feb 2026 20:39:13 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4E2883CB5
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 20:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d18c654458so1425609a34.3
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771270746; x=1771875546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmh10d82taAhB8V9AyCr+Ugjqr4wCSqDd/HILxUu8+c=;
 b=Hxez/NZ4rcnm0rjdsigb4pYrjx1UJiK3o4gYF2/H+lHhQVuzb0bw5j3nSrg8LUzJlQ
 47QANU/7U9H599m5OaPaWFfcVYecWU/tE3idbG8mWAYsssuABQCA4OdJTK6JtipAh5J5
 HHJB28CDdxBdqm9+fF8pUqViuPmTG4ryCJ8fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771270746; x=1771875546;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qmh10d82taAhB8V9AyCr+Ugjqr4wCSqDd/HILxUu8+c=;
 b=DZ+ftXIlRpdq5ITaOTtge5k+YuNfpjb7oTBh9/UPWN995+m0w8sVRRsU04+Yj9bF+O
 5imiKCIXcPUCfkCw+VzR9y50taGIxBM5fJrqT2yPRjfZkHHEiGv2JV6RRV75jUaVTtin
 vMs0beXdTcnBsolNDFW99xyQuKj+4WaKR4csrUrM2kOBXh4WmVtO1jBgiRTvyBbZ47YJ
 QHmdT9fbAofZQTnMqElQ6r9RPdJ+p+doPCLTv4fvWdApg5xnfau6Gds6e/xIPKuZU8+P
 KkLNNkk9aJOP3TX7PS06L2hQNzi8ysC1U5wmSR0adyg9iPuEwCJXQiTWvo//ZBtRn9Rt
 bdYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGMmeIQR6BJCWi6ijy2L7Vi9TEqxPqOZz/Ke0SvUIrApsFVW6EbACPN1wf3HBQMQPgRrPO2Vs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5+0ZFYVdWSpvwdKUebZRttEJ1yFNYesYfAHUzU86F4a3U98/t
 GTfpiHHeXQCNdIAzmFDzN5f5uM8cbIFk0LQbAQX+XvOC/uNZf744zsrS0wNkgEE41Sc=
X-Gm-Gg: AZuq6aJu6Qf4obkxTRjTieVlssQHrEk3AeHRVK7NjCI1MIGcbYagK9FIFqNpJBocbiT
 ZeHZoTWiMw+NXhjafXA2pgv6hjCMkEjokrVBac7C4CevAArv/Iqw/w1XX49nC3zqCeN24YS1wYd
 omsy4Xctnrerclnv40JjNoslxBhXgtGB4XpIY2QKjA0ENCIsgN97mA+niwlvAuPizIbqhmvyKHo
 +X+3fboLKOmMfHUBjitj3xTXFg3AN9Yc9jnnGavLxyWGkpNfFe6BtL/by9P8njGOCMBcOsmxrd0
 JHlX8LJEg/ATPqSUVAU3K6CDCelqWTAyGIaq+RLGZiV/+255Ihoqkwcl/MEd5tOLgSdhiIlcAJS
 L9+kKrDWlzSk2pmic6tOEd+OsgjoBdCPuGEfuPMgj3M/Hv7HBr+Y74X/OJftb8+/Xe1npqkYVRK
 epPM7m9MtO8KvJV/i9Z2dKg3jrqjp3tLyMOsZQCm/a95Nax0BDnWkge9ZaAAtlLtD6+SRSjNHhu
 9bZyLOBnq9Yvo2uOftqZC47p0VR/lRntt5H80NFpun400uv92Q2QJM8f9f0
X-Received: by 2002:a05:6830:7199:b0:7cf:d1b7:96ca with SMTP id
 46e09a7af769-7d4c4a0b026mr7802240a34.6.1771270741777; 
 Mon, 16 Feb 2026 11:39:01 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f9483sm14142543a34.20.2026.02.16.11.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 11:39:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Leonard Anderweit <l.anderweit@phytec.de>, u-boot@lists.denx.de, 
 Martin Schwan <m.schwan@phytec.de>
Cc: Simon Glass <sjg@chromium.org>, Andreas Pretzsch <apr@cn-eng.de>, 
 Francois Berder <fberder@outlook.fr>
In-Reply-To: <20260211-wip-bootmeth-rauc-part-info-nullaccess-v1-1-d0606be8a33f@phytec.de>
References: <20260211-wip-bootmeth-rauc-part-info-nullaccess-v1-1-d0606be8a33f@phytec.de>
Subject: Re: [PATCH] bootstd: rauc: Fix null pointer access while checking
 root part
Message-Id: <177127074100.2634449.2382077084128843461.b4-ty@konsulko.com>
Date: Mon, 16 Feb 2026 13:39:01 -0600
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

On Wed, 11 Feb 2026 09:36:22 +0100, Martin Schwan wrote:

> Fix a segmentation fault caused by a null pointer access during root
> partition checking. The function part_get_info() was falsely given null
> for the disk_partition struct, which later resulted in accessing a null
> pointer and thus undefined behavior.
> 
> 

Applied to u-boot/master, thanks!

[1/1] bootstd: rauc: Fix null pointer access while checking root part
      commit: c3538f788dbac291df24171ae1eeb1563ab8af53
-- 
Tom


