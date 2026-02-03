Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8BBE87834
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 15:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9922584563;
	Tue,  3 Feb 2026 16:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="D+INHyfU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dB9QDpm9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E81E38458B; Tue,  3 Feb 2026 16:10:28 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F1C584548
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 16:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f56Ny4pqfz9try;
 Tue,  3 Feb 2026 16:10:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770131426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lv0j1zpXfSXK7JOjOnHjyvNSzT6f+BzHH456laD1lkE=;
 b=D+INHyfUqebL6PjXSL35v1GoL+c2sKYJ/55JiSBCd5fRznfaChcDzxUNmwPOQoolBL5X9W
 sLIRoGX6wAyBlynA0FlLg1LW+rKzzHHp5mwungNNaH5VfOb+tGtVfNfXmb6lZj4UKywUSq
 QPbg7XvUMNuBDWAF8umyD1K18r7AdoX7loqLbdDBDZfDUYeUmWgaHLBqECRkuVy+h1t188
 KgFTgKFRtXUou0ZLdEArbohYz/A1cDFi69Vt2+gs3nUB4/19QJhwWmIL6lwyge9FkLd3me
 +wMvK69dXeEVklTaoZWmQ/tcxEUkss/5HEyJuA3VjSooOyvpEmG1eWRmSUvWBg==
Message-ID: <0097d26f-9e6a-4412-bd74-8c3a3bf19fa6@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770131424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lv0j1zpXfSXK7JOjOnHjyvNSzT6f+BzHH456laD1lkE=;
 b=dB9QDpm9lBnUmiuagmGsOmLMjyOKDaQUYR9xdHMX8kK68exIzD6IjP206fbbG5zX3a0a4/
 IBtV2C2fYGcqJ85MrcDaRFY/G8s+xcXBjyPxHQ7ulIO5362QrddH1XMCJxDAObJhL/xkSp
 m4eqRM+EDJegSEHG9HYzU0WODOqfH7vQDlrqebkcUldPhTCOzcVF7EAGceKgYtEgX5uirw
 4Fi/3C25kqMzipOSr9oKj95wIS+PEZcSaW4RDnPZCL69ETibNwz5XVLq/lFMJBKFUvhbci
 l8Dq3DSyBFUdM3UnOfS6uB/HTFDt+yoovxDmxWrtgV7u3JmI+w8K4EC3/Nm7yA==
Date: Tue, 3 Feb 2026 12:39:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] gpio: Introduce gpio-delay driver and enable it on
 Kria
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Anshul Dalal <anshuld@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>, Fabio Estevam
 <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nithish Kumar Naroju <nithishkumar.naroju@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Rohit Visavalia
 <rohit.visavalia@amd.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Tom Rini
 <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
References: <cover.1770105146.git.michal.simek@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <cover.1770105146.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: mfxiujawt539gc5enwhmdbqnogfd461c
X-MBO-RS-ID: 5df6a55dfb086c512dd
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

On 2/3/26 8:52 AM, Michal Simek wrote:
> Hi,
> 
> we need to wait more time for getting USB hub out of reset to be able to do
> initialiation over i2c that's why use gpio-delay driver instead of changing
> waiting time in usb hub driver. Waiting time depends on gpio wiring on the
> board which is in some of our case going via SLG programmable device.
Can you not use some regulator or make the reset assert/deassert time 
configurable via DT property ?
