Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9D5FF886D
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 19:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFCE58407E;
	Mon, 27 Apr 2026 21:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ozpOg14H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BFB0805D7; Mon, 27 Apr 2026 21:42:35 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73DC78407E
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 21:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso8904425a34.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777318950; x=1777923750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vb29o2a1z56s2/J/xZvVW3VvGP6oCnzkFXwJq2N3bKk=;
 b=ozpOg14HSZBhR35hETKG064j8W73Qm+5FTmdAAA5t78zTavU00Unm5G4sTaF7yXtkx
 1v6EKBsL4Xdc3tOlnvGCj18W3UvdQhxD8T5wDvxJn2pilzVQ5xo5/4i9W2wPOEroyWci
 Ena6vj8OpyVEsKNGmRCUT73ZfHM9KedLs8dvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777318950; x=1777923750;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vb29o2a1z56s2/J/xZvVW3VvGP6oCnzkFXwJq2N3bKk=;
 b=avtbU5I70Ae45O/Jy4bMWpnivEVytoMFjc0/AUGEtRqFyUPR2OO5FG1aDzme97avYw
 85TtuAduMGR1Wh4/nRzJF7SSC5qLC964V/y6IPRRfeDIxzwux1D3BkvJ5Vy49px4KYMO
 zY0n4Ea56uYgPplYEKCxwcXn9nrkivkZK5ESbrcckteG43/RJuEo59SsJCApUYjcuFpY
 JrzF7M9vY//ntKlQCo1KX/J+cd1str8WHzgBEwdsvwSIao8CiQWjJak1IpU20hXHvSDG
 nCsZwLI2PQ7elCZ1sLzuFy3mL+4MDiUS0yD5EqplagarmeUlxG5iwWaDgwur7idSX3Dt
 Tuhg==
X-Gm-Message-State: AOJu0Yzdl4x7lXZDoBX919HtbhOEOq9CDKSV4DC4baAv1cwU2pgl2YpQ
 LGQNxdRN7F4M1mwlzOGpaBAhnqEn1rbElmz1HMwjZuCqM06gi170KrZT4+TzKT3F91c=
X-Gm-Gg: AeBDieu+wbBUr8HrSK8Fg4W2g2O01cbXnlU61+xTCNhu2eeENz9XFM8/npw5apYR0/t
 mabHuzeD4KqkKZp3Z190oUHmMUHMIvZcF/ibOD1hJ+tU8tZq4tTeovQrqmVkJbASWX8wj7J550t
 rGQSj/1R+m2VOXSyAybmM6foIr2ZUVf2ExvdV0H9UZRco1tVC8lOX9q6k+Zio1PMLHdJRt0dS7j
 E8ChTWMs7/HZJKV//CVqfysCD0eQZMOCHSykFdgCnXy8LvAp5Uvw+QE1oljvTC0aFE8RsVT+22P
 KrtzahgdRLK8KzUmezpLNfYZa1ww5Mvc8mzDQVNX8RGWbq2uh8DTAzOci6W2iVN8Z+MxeolphkH
 FbYbzkINMjnxn876W4Ee4ODvQll7hHFReeCSQrjxF75PzVfe9BXPPHrEiuJ1UKOSXinD4Mqf9gn
 vSm+Jacnqps7HoeO6EJKgb/vhmNl3FExuysFzTX5dW0V+MhUJ969AmTNEzAY1MghoMDfNwv5KUf
 ADxLParC4VqlbRquk01cwiyU+nvymDnRhCyhGz5B0E8u+sgfGbx3z2CclBZhQ/7VculYM8=
X-Received: by 2002:a05:6820:81cc:b0:694:9156:9b97 with SMTP id
 006d021491bc7-6965b935c7amr250395eaf.22.1777318950222; 
 Mon, 27 Apr 2026 12:42:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6965b94aa0esm187247eaf.6.2026.04.27.12.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:42:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Apurva Nandan <a-nandan@ti.com>, Vitor Soares <vitor.soares@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
In-Reply-To: <20260417-elb-6911-aquila69-ofupstr-v1-0-400d93db3747@toradex.com>
References: <20260417-elb-6911-aquila69-ofupstr-v1-0-400d93db3747@toradex.com>
Subject: Re: [PATCH 0/2] k3-am69-aquila: Migrate to OF_UPSTREAM and add
 remoteproc FW pre-loading
Message-Id: <177731894948.3526444.17041699596998946768.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 13:42:29 -0600
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

On Fri, 17 Apr 2026 15:42:02 +0200, Ernest Van Hoecke wrote:

> This patch series migrates the Aquila AM69 to OF_UPSTREAM to receive
> automatic device tree updates. It also adds remoteproc firmware
> pre-loading to the environment.
> 
> 

Applied to u-boot/master, thanks!

[1/2] arm: dts: k3-am69-aquila: migrate to OF_UPSTREAM
      commit: 26b52c083eff8728663d0b5f7c1c7832a6972190
[2/2] board: toradex: aquila-am69: add remoteproc firmware pre-loading
      commit: cf8bb114418e7b96f1d18d4e38418ccf8eec957f
-- 
Tom


