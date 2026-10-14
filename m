Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16860CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:20:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA90980EE4;
	Wed, 14 Oct 2026 16:20:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ig4Ti-VhDUSy; Wed, 14 Oct 2026 16:20:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28A7B80ED3
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791994808;
	b=OV5UysRmOfqXs0eShYZOVkiSvc0Kca4yCxrrQYB2qd0orz10RwEHsl9OZy39UIvMzFJU
	 lL31vb4Q/bS223ojHz1nI22XGSU+9Ovm0+TiOyh96Z+WwO3YMPzcHVLFC7wsF1jsVRJt7
	 Xq8CT8BBMWCYcsRHnxfkB+nzwjpO+R44fhtzEBRM/bGVnHt6/oxK9t17RN1KlTOFOs1dd
	 QGHcKhU0N9HYAdhTb2xKJBg9uMTpzK9LeU75EhrUUKGM6TMLVyJkqEx/JUj21qo3od8/d
	 JpHw4CiGOzuHCFDuqk3fS5gKS621iD+XMUkxbVxYgp4fr5EQ6PxdUcVRTFY1nS0dGNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994808;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
	 X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aTKrCe1pUt4yvHxcEf4zLnuRKRFDsj8ByAur1BZYfIU=;
	b=V8AU+i5Byr8AhHH7zFC2dXVSZBFGRI4SSTlt9gRaDk7uNU8jnEIn4B+4sfX/pSXzGprP
	 xpQl27uZPsoV1mM498B96ra5TF7bAEJetSnnkTGUr9R0+HErSMV4EgP7midUnwtV5p7ET
	 2OTG7XB4UgOdbAL/Lx+OBEYkT72pvJFgXcYIUJ01t1pkcPPEA05bzsQZf9iG/NO9NnpHf
	 Y3juqURvIBUNqIEmEAfx4VAxpXsfRvF5je0olWwRa3MMQwbMjoDYyjzflWZDU4BCsCLIL
	 fwVgzz0g6m+sH5CxoTv4xS+cM9Gkf083z+rsA36W9hZ0sKdrZZldkNxTAgwb5qr6J8A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=nic.cz;
	dkim=pass header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256 header.s=default header.b=R2chddOu;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994808;
	bh=aTKrCe1pUt4yvHxcEf4zLnuRKRFDsj8ByAur1BZYfIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r45LfMCUpp7zQvd44MtQ/7a6gcsli5IaY4qlK6KGdkm+jOcxg/QL1omn75wiL+2Wt
	 IkYi/BK4fngS5dn3RXkFFG7Fur34KK+o3LCnqegySgdfPa28jSgRMiUodADxvV0Qum
	 z66GIq3uYoDhOVHnfCUYMEVC00FEd+0bwmjORKJ5ErdOWI0+03x6s0pEK9XXxObkcK
	 oZvF4yxg9N1g/D/7L0ZXJ5mLdf1MKcnrfzHZQ5xPuTfmo4Te6ADWaXKeQqofHmh/Qo
	 h19OHTWOZniWgfItXPaO1/kd7e6+4yVbQdv8UhAd1/Q1HNve60KTKoLexWSJyw6iTI
	 oNlwcrIUSwnNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28A7B80ED3;
	Wed, 14 Oct 2026 16:20:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8970F769
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F7BF80ECF
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:20:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mhJNU23ctrlO for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:20:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A065A80ED3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1488:800:400::400"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791994805;
 b=BssAypEBHcQoJuM/Ti3MKKq4F4xQ8pGXSu+nbcgRe1It0egSUcC+lsVxXRFnClSqrriB
 /p7oBoN8rM3dyq2Fc2q1QW7bh+g+WXcoo0qNO7cUtw1BcryvhHqr7OATFkGMhbKRLO20t
 +1LBQ9UOSSy720cozIKLAYoEjH+tbUqQWTJUUYiiRc/KiHHUaDgSDo6uZ08AJxIKG/DvQ
 9sjmGcjm6/CZh/hHS4wv/7OjWNEKKrL/xa/m4DNEVGyh6t5Hlg6z0+Is7qIp6nFVgm6+0
 TieYr56ygPZXt0huDgwIKoujtvAYCbJWdpDHIKFcib2r14NaO5zi+HaZ2NFmpesAqFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994805;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
 X-Spam-Status:X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:
 X-Rspamd-Queue-Id;
 bh=aTKrCe1pUt4yvHxcEf4zLnuRKRFDsj8ByAur1BZYfIU=;
 b=h3yL58l0H976AXaMt8x/KUsvOC5PHoB7JBlUMYkyRzQXv9q/ibGOldQ3EOYRCHpyKHnt
 nCKk7mrM6FIGUaORSnxysIf6nuIYEub+1yftSQmruisNHkTMXF/sxsl7r57dUqyHvS7+o
 1ERqBFx3in4oB5vSGrZESvu6z8PlasyrP4xI2iINO8isQh7h6H/5/x7reNp7VcKU8HLh+
 4uNPPGHK/knkjMZg5oJTvpjpRC92hlScAJo6GXzfxD17Em3Rk/0mJ1rFAGvk8wCGDBI+o
 TLWvHgZLdWrKryXSnrXuI5/5sx8+NY9EK7wJfU02RcaEfRUGuqC9GlF3P8++uqjhsLQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nic.cz;
 dkim=pass header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=R2chddOu; 
 arc=none smtp.remote-ip="2001:1488:800:400::400"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1488:800:400::400; helo=mail.nic.cz;
 envelope-from=marek.mojik@nic.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=R2chddOu
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A065A80ED3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:20:05 +0000 (UTC)
Received: from marcharch.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:8:8f8a:daa8:a10e:7064])
 by mail.nic.cz (Postfix) with ESMTPSA id 7C1291C0607;
 Wed, 14 Oct 2026 18:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nic.cz; s=default;
 t=1791994799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTKrCe1pUt4yvHxcEf4zLnuRKRFDsj8ByAur1BZYfIU=;
 b=R2chddOuFuJwMzkc3lYCr3RPXn/IApFCmutGUyGLi/fYu52malFfP3Uus5Hjg5jh76rHX9
 tUpvSyXkkchb3qjdAMKld+eqA42yAEW7HdLCEa++oiBIw7U04yLgCU1nKa9LRYX+Z7/5u9
 7qYxt26hEOzYnC+Nf9EegTgiJOGvzh4=
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
Subject: Re: [PATCH next 13/13] board: CZ.NIC: turris_1x: Fix up MACs and
 serial number from OTP
Date: Wed, 14 Oct 2026 18:18:23 +0200
Message-ID: <20261014161829.28404-7-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260928110434.70686-14-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-14-pepe.schlehofer@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.10 / 100.00]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 WHITELISTED_IP(0.00)[2001:1488:fffe:8:8f8a:daa8:a10e:7064];
 ALIAS_RESOLVED(0.00)[]; LOCAL_OUTBOUND(0.00)[];
 DKIM_SIGNED(0.00)[nic.cz:s=default]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+]
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Action: no action
X-Spamd-Bar: /
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: 7C1291C0607
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

On Mon, Sep 28, 2026 at 01:04:34PM +0200, Josef Schlehofer wrote:

> When the environment is reset with "env default -a" before booting,
> the kernel device tree gets no /serial-number and keeps its all-zero
> MAC addresses, so Linux reports "Using random MAC address".
> misc_init_r() reads both values from the ATSHA204A into the environment
> at startup, and the device tree fixups take them from there, so the
> reset loses them.
> 
> Read the OTP again in ft_board_setup() and repeat these fixups, through
> a new weak hook in the shared P1/P2 RDB code next to
> p1_p2_rdb_pc_fix_fdt_model(). As in misc_init_r(), a valid MAC address
> or a 16-character serial# already in the environment is kept. An
> EVT_FT_FIXUP spy would not be called: without OFNODE_MULTI_TREE, which
> Turris 1.x does not enable, image_setup_libfdt() sends that event only
> for the control device tree.
> 
> Tested on CZ.NIC Turris 1.1 with the NOR and the SD card build after
> "env default -a".
> 
> Fixes: f41582035cf7 ("powerpc: Add support for CZ.NIC Turris 1.x routers")
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Marek Mojík <marek.mojik@nic.cz>
> Cc: Marek Behún <kabel@kernel.org>
> Cc: Priyanka Jain <priyanka.jain@nxp.com>

Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
