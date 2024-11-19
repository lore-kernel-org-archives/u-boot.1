Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DE7D6C2B4
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 21:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AB9E895C8;
	Tue, 19 Nov 2024 22:50:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=vodafonemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=vodafonemail.de header.i=@vodafonemail.de header.b="ktDwPYvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF6FD892FB; Tue, 19 Nov 2024 22:16:29 +0100 (CET)
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0EB7884B0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 22:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=vodafonemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
 s=vfde-mb-mr2-23sep; t=1732050987;
 bh=dY4ad/e6wSLKSE/slZF4YH91ursdIzChW/MBePSPyW8=;
 h=Date:From:To:Subject:Message-ID:References:Content-Type:
 In-Reply-To:From;
 b=ktDwPYvf3JJHyRojNe6s+fUrgdglNVbyoTw8tjL/53jrjUcZOncki6GGlTgCIieRS
 7bHpf8e+ngOw1wuZds0jSXVn6sJRYiP9dPz9ynbAiTEE/dijVW5/ZRPrI1XApPVeka
 UnV40vaKSzALhGp3WZguotNisZ8Sd4g58l9pLo/U=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr6.vodafonemail.de (Postfix) with ESMTPS id 4XtHNq5yHSz1xqn;
 Tue, 19 Nov 2024 21:16:27 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4XtHNh48tRz8sYd;
 Tue, 19 Nov 2024 21:16:17 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id 3B6AA2E01AA; Tue, 19 Nov 2024 22:16:17 +0100 (CET)
Date: Tue, 19 Nov 2024 22:16:17 +0100
From: Yuri Zaporozhets <yuriz@vodafonemail.de>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: BUG: SiFive Unmatched: BAR0 on video card is never initialized
Message-ID: <Zz0AIflHxn4dmbK1@vodafonemail.de>
References: <Zzz483tW7ODsig6u@vodafonemail.de>
 <6A65FCCE-4A7C-4558-9753-66E0563C62E5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6A65FCCE-4A7C-4558-9753-66E0563C62E5@gmx.de>
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 583
X-purgate-ID: 155817::1732050983-5A03D463-E3FECCED/0/0
X-Mailman-Approved-At: Tue, 19 Nov 2024 22:50:44 +0100
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

Hi Heinrich,

On Tue, Nov 19, 2024 at 10:03:45PM +0100, Heinrich Schuchardt wrote:

> Hello Yuri,
>
> Thank you for sharing your investigation results. Could you, please, send a patch?
>

Sure. Already did.

> Were you able to show output on HDMI?

Oh, not that fast -- I'm working on it :-) . Currently, I have my 1992 Hitachi CRT
monitor hooked to GT710's VGA output, and I'm very much determined to get the text
mode ("VGA mode 3") working on it -- it's my favorite mode of OS kernel development.
After that, perhaps, I'll try HDMI too ;-)

-- 
Regards,
Yuri
