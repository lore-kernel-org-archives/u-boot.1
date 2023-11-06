Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB6CC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 10:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500F886B02;
	Mon,  6 Nov 2023 11:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="xr2F1nXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE5D86FFE; Mon,  6 Nov 2023 11:12:30 +0100 (CET)
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1174C86611
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 11:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.behun@nic.cz
Received: from dellmb (unknown [IPv6:2001:1488:fffe:6:8747:7254:5571:3010])
 by mail.nic.cz (Postfix) with ESMTPSA id 5F8B21C118E;
 Mon,  6 Nov 2023 11:12:27 +0100 (CET)
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.behun@nic.cz smtp.mailfrom=marek.behun@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1699265547; bh=lo/YlMETMC05hjY1IfDyBXNqkcG3oiToaq52raQ16Z4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From:Reply-To:
 Subject:To:Cc;
 b=xr2F1nXopkPaBUMzEa0tEffEB/FP3+L598FaDlKg5jCy4Zp5Ig65C+MBEU0Khu1Fr
 +mUEllbyWyzbHxiC6V7m3Weu8a+HtcrzfphdWEDRIKMWFrIWXZUZuD3oISbZjkim8C
 F6DFwA2HMzIPI4NOxnXHwFUJ8OkIgJJ+FBup0d00=
Date: Mon, 6 Nov 2023 11:12:26 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>
To: Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v6 00/25] spl: Use common function for loading/parsing
 images
Message-ID: <20231106111226.09664f61@dellmb>
In-Reply-To: <20231106074905.pgrdj6zhsgy66a2e@pali>
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106074905.pgrdj6zhsgy66a2e@pali>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: 5F8B21C118E
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.10 / 20.00]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
 WHITELISTED_IP(0.00)[2001:1488:fffe:6:8747:7254:5571:3010];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ]
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Action: no action
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

On Mon, 6 Nov 2023 08:49:05 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> What you are doing is the worst thing in the world. You have been
> ignoring all my changes which I have been sending for one year, then you
> wrote me that I'm not competent to do any kind of programming, later you
> wrote that you would ignore all my requests and stop responding to any
> questions, then you have removed all my code from u-boot and showed me
> as the worst person in the world.

I am sorry this happened the way it did. I personally do not think that
you're not a competent programmer. On the contrary, I think that you're
a very good programmer, and that what happened has more to do with
an escalation of misunderstandings and relevant people being too busy at
unfortunate times. This naturally led to frustrations and harsh
language, which led to this unfortunate situation.

Just wanted to let you know that I am sorry about how this whole thing
played out, and that I feel partially responsible for a little bit of
it, since I also made you some promises ages ago which still are not
fulfilled :-(

I have finally managed to recruit two newbie kernel hackers into our
team. I am currently tutoring them, and one of the projects I have
in the tutoring plan is getting the work you did out into the open. It
will take some time, but my hopes are that it will be done.

Again, I am sorry. I hope you are doing well.

Marek
