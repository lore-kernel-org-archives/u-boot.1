Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BCBCC6B29
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3ACA080CA2;
	Wed, 14 Oct 2026 16:19:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6CAY3gU7V83j; Wed, 14 Oct 2026 16:19:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9621480EA8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791994792;
	b=K6C1DvrW5egXNfrk1lpnEsN8aXyz25pv1OCjiKy6JNBYCGKiGmpjyzdaR83JCWDD/jTZ
	 8CIrbz2/XfjJKnDUdvTo/JFsmp+HcXMdkQ9QY+xiohVHfXOuqcfIJ3JUl0s8NSFlzNjxU
	 otPW8UNCvcRdeR4caSyiAnHOZx+B03657NjB18zHvs+AgooEcpNPyvZGy349STF7piNw1
	 sbMNqU9sBFJe/lO/zsRPs4sWPsbpo/NuIQdCpsN57IHOwE4KaIaWKir6BLgAIxk+z+ocC
	 bIvgHE6KnGqZ3+pCXr9s1+Ly8TWYhFokQHIm1uSqGBTusvdCamZP1k86KEhJ0iKXvpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994792;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
	 X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KCTa/gub17IVxE92x03dDBf7PNFZKcBDmLjSb2tfoxg=;
	b=qtviZSczPHJ7hOGTzWkicAfUj90KG9hG/sr3PuUAlU+lOQx4UdRkOYIc1lm07HXV3VYU
	 kEJTNcku/5G7xtkfV1eqdmgf0aVdbZ85F/kOTkBeSgoitUXVSoFe8dK1/1xVouGHWEG6i
	 gjHrQm7Tab2INoEuXkjmxr+Q9HHcFTily1pZNpPjzAe9d3HE4ybt4GXgn4CKZELX3JgnN
	 C5zKqnOlnU40i1hD/FNN9SqtyDaCb/rZKzXFCx33YFm27csmH7tfnKAsOhCw4RYVu1C3S
	 X1LWgNdHDCgu0QQxXEEePCMP5b6GtXaWZ2zJs20QeD2iqykASkuj/xiOXDoyXtvqQOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994792;
	bh=KCTa/gub17IVxE92x03dDBf7PNFZKcBDmLjSb2tfoxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KwHIxZ9nGCH9JrZLuITZZtLAZNjXYecNyMRhpLjv2mxr/mDZLJak0GaFS+l3jcw9j
	 kqwFiNSuHDDp2N0OisyrptguyaddCKSRbQpQj+K1zdDBm+kAaTBkwe0cfoyC5MhJrQ
	 dkqJCNjSq+kymz5NBkdGRqiQU3hn75ZfMpB13Cc+M0Dav+ZfTAn4Vcf4GOaR7buDoR
	 6DG5je1v9IGpbkCRSIC4XUQQ3dNB80L0aBXtADsek7mSLu4VkjiNv5J3pmrA/MQB9B
	 Fq+/JX5dOccUfFrcE77g7lT1QyQyhvD3ud2EYt3tSMA1StGVIG9vwDETV/Z8qmmJx4
	 oFS7P4QUxA1yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9621480EA8;
	Wed, 14 Oct 2026 16:19:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6797AE4D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5984F40189
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lv-KvIbX0qMt for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:19:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6BE624008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1488:800:400::400"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791994790;
 b=FsjRvzu9LCOgMrYyoXbprPputkbzZ9m5Pq+eHqy80PTfehAF4zvX6iy6Pu+wzFLRBaX+
 A8AijoTbNuc+6hokToGFm7G/4rIdCHM2fwF0OgyXgwDHwdQ6v3LZe6GsQDsg0Nb5uneET
 qc8+LVvgaX7vkH9Ab4BPmhuXHgkF1KOKHjGntcrLFdg7nnMp9bXnEl1NqbeIAdi4cKrR4
 MSeW/MLEFK/sYYU1IrWiz8Vl74aWNjCr+8ValBsftmJRpVA9TVJR5M40KdeyBzn234Ssh
 lL6AqjhMH9xhfbEqdzTT1Xc09ctP6o4dQR9vvC41PQjA0LUozZtwDGoO6CnHElN6T3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994790;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
 X-Spam-Status:X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:
 X-Rspamd-Queue-Id;
 bh=KCTa/gub17IVxE92x03dDBf7PNFZKcBDmLjSb2tfoxg=;
 b=F7Akg34hwm53m+KnDeOIOf0ZzUTW4QgZfOwGVdSYlTF8V2pXKxEbTB7E+eJYXDkqN3KM
 EPf65WgHCJneki9yIAPOvuICX7nZyTeEYH+RynaJcK8Hh1KOsLgN+4Z21HjZR18wWo4YD
 Uc/s06x4XSVncfDRGe0NrJZZtKSbWZXJSf+g2E107ZeX4ttXg2w+LjNytjloVhpIyb8c4
 ibL9prSoHdiIV9Hfkoz/gN9D4iwuzhp4kjk/ZNIndsMVyiiv8jrGicEu6ApdHlZ6z6Kf4
 wuUZdJGypPyKiwpgmX5vS2p4fIS79+r5FrJc5z5M+LLYHOXXAuio97Dp6tCFXYmz2rw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nic.cz;
 dkim=pass header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=Wmn0SZim; 
 arc=none smtp.remote-ip="2001:1488:800:400::400"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1488:800:400::400; helo=mail.nic.cz;
 envelope-from=marek.mojik@nic.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=Wmn0SZim
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BE624008C
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:49 +0000 (UTC)
Received: from marcharch.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:8:8f8a:daa8:a10e:7064])
 by mail.nic.cz (Postfix) with ESMTPSA id 4961F1C070B;
 Wed, 14 Oct 2026 18:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nic.cz; s=default;
 t=1791994784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCTa/gub17IVxE92x03dDBf7PNFZKcBDmLjSb2tfoxg=;
 b=Wmn0SZim9WQSUcUcLZlqBk1lonFCpwYSv8rCJYKnclN6PChGruQgO4wMJl+D0BJZEquIRP
 vj07DJVJgb5WNOGiIqAu8n2HH3zfDU9l9mC5S0uwZ3hqtsUxi1EZtpl0RmybKFuMfvnMwy
 SyReCLTEt7F3yn7mBsFMjMhlMI8EtWQ=
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.mojik@nic.cz smtp.mailfrom=marek.mojik@nic.cz
From: =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Marek =?utf-8?q?Beh=C3=BAn?= <kabel@kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: Re: [PATCH next 09/13] configs: turris_1x: Enable LTO
Date: Wed, 14 Oct 2026 18:18:19 +0200
Message-ID: <20261014161829.28404-3-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260928110434.70686-10-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-10-pepe.schlehofer@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.10 / 100.00]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[nic.cz:s=default];
 FREEMAIL_TO(0.00)[gmail.com]; ARC_NA(0.00)[];
 LOCAL_OUTBOUND(0.00)[];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 ALIAS_RESOLVED(0.00)[];
 WHITELISTED_IP(0.00)[2001:1488:fffe:8:8f8a:daa8:a10e:7064];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Action: no action
X-Spamd-Bar: /
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: 4961F1C070B
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, Sep 28, 2026 at 01:04:30PM +0200, Josef Schlehofer wrote:

> Enable LTO in both Turris 1.x builds. The NOR build needs the space for
> the ubi command next to the BCH code, and the SD card build needs it for
> the BCH code: its u-boot.bin is otherwise within 1 KiB of the 1 MiB its
> SPL loads from the card.
> 
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Marek Mojík <marek.mojik@nic.cz>

Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
