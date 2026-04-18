Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5B1F99C66
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 07:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D8983BC8;
	Sat, 18 Apr 2026 09:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="uuaMkjb1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B5B83FF5; Sat, 18 Apr 2026 09:43:16 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A779C83015
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 09:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net
 [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id 90B7C1F947;
 Sat, 18 Apr 2026 09:43:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1776498193;
 bh=FmF5e5gKF8gAyosmOJLqr8NExjd2R/AKT3fsFfVi5NM=; h=From:To:Subject;
 b=uuaMkjb1l0ZOmQkjzyUvm1AiV9bboq6EtMx665KXp86qQJZNVaGItL5r/pqXxygQj
 +W5UJkSyUpnZIyYeEH2SQM3sRsn5+e1+XnMTg4vDw0hGI6nf5NWlO2Z/CtcLQRIxOP
 PRk/rwHT/BhkYxcQWzHIR9byZI+RTnFk6Ak5AqRzf64027ozqBAt087Jbf8qpVQBTF
 YsuOKOhTKOM67+19ghAFsbaqZEvvy1HTudvOdOOfOn2+O4807Mi6LHeRgbTsmupbwy
 TfNr6G1c3A4GhNc42wd4K4xrozsw9yjOGmg18e9oJHMFjmg4lRZERlXlqiQOhY395E
 bdYgIRpx5OM/A==
Date: Sat, 18 Apr 2026 09:43:09 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Apurva Nandan <a-nandan@ti.com>, Vitor Soares <vitor.soares@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: Re: [PATCH 0/2] k3-am69-aquila: Migrate to OF_UPSTREAM and add
 remoteproc FW pre-loading
Message-ID: <20260418074309.GA10271@francesco-nb>
References: <20260417-elb-6911-aquila69-ofupstr-v1-0-400d93db3747@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417-elb-6911-aquila69-ofupstr-v1-0-400d93db3747@toradex.com>
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

On Fri, Apr 17, 2026 at 03:42:02PM +0200, Ernest Van Hoecke wrote:
> This patch series migrates the Aquila AM69 to OF_UPSTREAM to receive
> automatic device tree updates. It also adds remoteproc firmware
> pre-loading to the environment.

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

