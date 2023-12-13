Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24008C4167D
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A09F3807E2;
	Wed, 13 Dec 2023 21:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AkpzfZ9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 494F6877E6; Wed, 13 Dec 2023 21:07:33 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28FF8807E2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-28ab6f0944bso435784a91.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702498049; x=1703102849; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SOLJ8pBPCrLBqGRKxuryStu9KURNIy//374XuzwxMpk=;
 b=AkpzfZ9oGXPKPN72lUjQGwpQCOEYgF1jxlqnxPXm74GA/324YE18Raw81+JTa9sKMO
 eiVj+uJl4POApZFpZwHQn9UCjvAedp0c5HXOFOyaiBspr5cfONWkFeWuU0PZk1m0FMh3
 /I2f2u7J4QAxvOLYT3uE54Br7Vj5KgiA6PVSAzpRRfwRdErbWt06wRXn3gDUhu+gy62p
 oPuZ/Triaq0zWIvAQHyfQBCr2dOR462A23BzsoZ5sI+y2QILOh6bb7iHjiiL9kdzw7LL
 KMPrfF52shBf8mcb+yh78RGJItWO4YzWRAMQ13EQjx2SRk28bD6O+M6BkMA1D7BATyPd
 IYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702498049; x=1703102849;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SOLJ8pBPCrLBqGRKxuryStu9KURNIy//374XuzwxMpk=;
 b=qkPuNAYJ9bk3KQCSGufpmBH9NbHtoF/Gn8RVvdlZTpZ5FOqfaWtBBpYsVJAtQ5S6EC
 hG4djWyqWsi47Tnyha+xyep2PvPcU5r8XZNE8IJJ7Gshhf1rPrE8dCv//PA+AuL0kR7M
 pCCI3ABrfAY8r4iORPxwsDD3tFRhffTvjPyLKncWRJipVp9Twt5wKHze+QMb8ixFCo/J
 wd42nistCIeeDyPCbUMOJsQ6rsnmhX0iBQwiPz/5YxxHq6Pn6vBCM2MJAM05mcCGtdQH
 fWll4mV+fVPhgSI37E/Hi3zfMAC5xhABk6RYHGkKhR91kvRLfngDO33oeOrGVfCnuFg1
 DNrw==
X-Gm-Message-State: AOJu0YzOQmcrotA/BUcSxphBZBTIKQiy44nfxSKTq6MOO5h6qIUQ0pIF
 n6z1356G1xBeLgrVNnfHNyTqRKSSRN42Av/f8wQ=
X-Google-Smtp-Source: AGHT+IEBh2oCGpbIdI6YH1RAkDkG9tqGnj6nQgNcW80yS/Xwqn56bRQlueNHa7qeQ1VVqYexIjcQ7GCaLngfy+DklXg=
X-Received: by 2002:a17:90a:7046:b0:28a:f305:e7c0 with SMTP id
 f64-20020a17090a704600b0028af305e7c0mr1574357pjk.4.1702498049318; Wed, 13 Dec
 2023 12:07:29 -0800 (PST)
MIME-Version: 1.0
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 17:07:17 -0300
Message-ID: <CAOMZO5BwEDh9NvQB8ht4bPq0G1EkYxaKXJPgFk7xpe6cjD4V7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drivers: rtc: add pcf2131 rtc driver
To: Joy Zou <joy.zou@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, Chris Packham <judge.packham@gmail.com>,
 peng.fan@nxp.com, saproj@gmail.com, Stefano Babic <sbabic@denx.de>,
 Simon Glass <sjg@chromium.org>, 
 U-Boot-Denx <u-boot@lists.denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 Ye Li <ye.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Joy,

In Linux, the pcf2131 rtc is handled by the pcf2127 driver.

I suggest we do the same in U-Boot. Thanks
