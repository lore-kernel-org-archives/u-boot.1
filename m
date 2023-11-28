Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BF6C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 23:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16A0087753;
	Wed, 29 Nov 2023 00:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="MZeoNqE7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446DF875AF; Wed, 29 Nov 2023 00:17:51 +0100 (CET)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE90A86BDB
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 00:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
 :Date:subject:date:message-id:reply-to;
 bh=S/eXjZPvACMU1aLL1DiWcX5iM5taUUsmiWWQifkcaIU=; b=MZeoNqE7CYAtVufH0uWNLSxA9G
 i7nAbdbA0hQ85GA9wXPwhuLWRXrZZNFocu5XZQaxDo9bzuCmYh/Uv/UBsquIjxzEE1R97VWMJfy+N
 6S80xJxEbkP+I4jZGk4O5XlEJEI051t5Fp08sSniyJkUdhelFXDg8J8yJWSQOavQrVrc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55330
 helo=pettiford) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1r87Km-0008IT-GJ; Tue, 28 Nov 2023 18:17:42 -0500
Date: Tue, 28 Nov 2023 18:17:40 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: =?UTF-8?B?U3rFkWtlIEvDoWxtw6Fu?= Benjamin <egyszeregy@freemail.hu>
Cc: Fabio Estevam <festevam@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "otavio@ossystems.com.br"
 <otavio@ossystems.com.br>, "sbabic@denx.de" <sbabic@denx.de>
Message-Id: <20231128181740.7fea242b489d9efa261904d4@hugovil.com>
In-Reply-To: <A2E88A.1BiPC1JJI4ID.2cqy6ZTmX2YXIGOSvxV@freemail.hu>
References: <20231107221617.470-1-egyszeregy@freemail.hu>
 <CAOMZO5CkU7onGbWrMxHZGG66pqrnH+VZC1qJofm_kvJkkVHaeA@mail.gmail.com>
 <A2DhwQ.Xeo2UIDvnEkI.pVoDCCvBPts07YOet4CT@freemail.hu>
 <CAOMZO5Aret8v0cEVcgSwLfPgsDzrLgXjiWXj5ue+SRPmJsTieg@mail.gmail.com>
 <A2DjDg.wGjnlX0ebNwK.yufbtwx5fVnuqjyPJYK@freemail.hu>
 <CAOMZO5BHkjOC54dc7ciL7y-tYPux2KKXQ8mOv+uObZsin1fmNQ@mail.gmail.com>
 <A2Exnw.dlngtJ5tNi9C.BApoDl5aKB1m6k9BCYZC@freemail.hu>
 <CAOMZO5ApoA7+o_XOz04OLWpW-+hwhW-M9cROSbV1vADmDnydJw@mail.gmail.com>
 <A2E7RA.WAMpX3ekvN7A.ZZTk9ZUF8rABr6qdjSu@freemail.hu>
 <CAOMZO5AK3cxy_mOD_J9UPPCzFVfzoVw=OmACeh2+27k+4CkCnQ@mail.gmail.com>
 <A2E88A.1BiPC1JJI4ID.2cqy6ZTmX2YXIGOSvxV@freemail.hu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detect
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

On Mon, 27 Nov 2023 23:26:08 +0000 (GMT)
Szőke Kálmán Benjamin <egyszeregy@freemail.hu> wrote:

> It was absolutely conform, i supressed the potentional warning. Once again i say, i will not remove it, if you do not liket it you can remoce as a maintainer. My patch is ready and final. Let's do something to improve i.MX family as a maintainer. I am realy sad to see in last 2-3 years there was no any significats new features for boards since their initial commits.-------- Eredeti levél --------Feladó: Fabio Estevam <festevam@gmail.com>Dátum: 2023 november 27 21:39:19Tárgy: Re: [PATCH 1/1] pico-imx7d: add baseboard SD card boot detectCímzett: Szőke Kálmán Benjamin <egyszeregy@freemail.hu>On Mon, Nov 27, 2023 at 4:55 PM Szőke Kálmán Benjamin <egyszeregy@freemail.hu> wrote: > > Unused function parameters should be removed >
 https://rules.sonarsource.com/c/tag/based-on-misra/RSPEC-1172/  From
this same URL:  "Exceptions There are some cases when you want to have
an unused parameter (usually because the function has to conform to a
fixed prototype"  which is the case here with your patch, where you need to conform to: int board_mmc_get_env_dev(int devno) 

Hi,
please fix your mailer to wrap lines properly.

Hugo Villeneuve.
