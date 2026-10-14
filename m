Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651D6CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:19:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABE034076A;
	Wed, 14 Oct 2026 16:19:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gbReo-DYMVTk; Wed, 14 Oct 2026 16:19:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0316140767
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791994790;
	b=TIj7fKFnuRoMg/MKTlj3h5eXWksbJ6rxVGyo6pn67M/LcQkOLa23RSZk0zrMZgkVZsQF
	 OKfBIuywRhTXV1GdfovlAWxNWT6pVVd3nMFfO+kObqYxqHUtrRgm1UP37BqbSHT88vq1E
	 h+LwHSJfBG9b5mdVHPJxUesyaCYDz9poXugBnVAM80qQXeWTyzSU3q0vuZfIT40Tc7uY7
	 jcauGjfBqYUzDMRDgrV48wG7lJx+YrxKtoOD1AS/TC3r3P5OzsKLqsRb9TZZbbjehN/Aq
	 RzJ4d/vafiRdpRDBUoZ4+GybpDx+En/j1Dev9HPwgIn1ipigZx6+Yj/uj8Q5OpJ1yhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994790;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
	 X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Va+AP8F4IzfutapRdK6X/+mF72T5xC4kziVHbod7kDA=;
	b=fvOefAR4zNo7C/tnmEAPOcLTO7vQyAT1h3xh5riWwWLNEArSoQoA84myB5lbyq8kxahe
	 327Jb9rBjfgxb8BzY4qyzK72S6qfjW76hEER/1uGPmJ4e8H7YHp9Ct/5ojN4IQ9lMnTU9
	 p4Gf44MPVvJ1f+tUgn9WUxQunu49yue/lD//jgERmjWRuatsLbgK+7gIMzHplIaHV15i3
	 w/7fR33eJR3p+q9j0wJW55HLLyOY7lAY6CEWrJ4fx/xydiuguDJ943KB0u0+u2DWnF87e
	 ys1feHeSCUYlqSmMsbZubIu9RHA3U9NEp6O42ndJzLu67yl1NipfvqWsj6oqNLHAkKg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=nic.cz;
	dkim=pass header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256 header.s=default header.b=pPupQaId;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994790;
	bh=Va+AP8F4IzfutapRdK6X/+mF72T5xC4kziVHbod7kDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nKyzJTBt7M2FfReXqGqLFvlAoItvNsd68JRzrQ8Lp3xmAdAiMJ7k2i0GXRuDHCY+8
	 PXNVqallV+2ijaf8vwzl5a/1lJiIhqZyljNSq/TAArLk6Uo/5mnpPs5CAIWwRxzdeK
	 3dZ2Maa+/gy6V5218TOOJ+GcTZdBK/cyxpaqR0hndn3ApzJ2NXEPig0FdqcWlrW8JX
	 NhY+btMsJ3LaBM8rD4C1j+iPpXbOMtgUBq6p7w/aO/TWNcVQWX3RH4Kms1tg1mCmYj
	 t84N3GU0xpL/TGviB9f0mOcsZFql2XqXZhN22tHi+GNdjdLbFKkOpPfFlGZKJP2Wyu
	 Y3hBUtAIDJc9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0316140767;
	Wed, 14 Oct 2026 16:19:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9905A1DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8AB3140767
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PiEyJJhrfu4J for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:19:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D21BF40766
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1488:800:400::400"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791994788;
 b=qJpNj5gSlWXTdLc9SmITJxvsNZfaHx+A2/QfN61KPf8J7QmtUeX7toJeiyJsdJGVcGa0
 6iuQbrOlAD/np/AXtFy2x1JqfWnsKmKxhKVijeFE6mrGh5EYttmDRQnDmwdiOJn6x8MyC
 Elyws2kiXf0OuchTRYzNZO+5XQnSNqOQmCMtBQ19332XgT3vgcacwD4sF649i3mnia9Mv
 jSXM7HsKASJwA+VIyEcSRQ4R6ggIQB6QiVgM/UMNiTmLElPlzX27z/dHaKpPrNnGKFhbO
 FLoQIqAgerQjsmYjXLqPLYqycNN705YVuBQ8QupBfbSIH3aatiEvUGMOOJDyGS5AOKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994788;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
 X-Spam-Status:X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:
 X-Rspamd-Queue-Id;
 bh=Va+AP8F4IzfutapRdK6X/+mF72T5xC4kziVHbod7kDA=;
 b=ofn5gaOgyGOE6o9490e+eq+ovbJYgwP0B+3qwoBCSgCQ74C4UPdH44EZrfluuIKmfKrx
 gU6ABmQ9qOkb/GOxklrMyQHDeWvo8oO+nPl6hb9XheFOVKJtus8lxlfF5nU8Fxzqa70UG
 9VS5rNs00Vc7SCtf2xS5p6lZNeztNHWNtRIBKhz5vm3m93xptsMq5z6fwhB8tuc/Q2T+P
 5mN821038aj7ZVMo/EH8AGgj/o0w4z7tPXAbx9tyStC+KuEfLo0iIHtSVztb7Zl8kDNx/
 NEyltHUomUMsC6iyiYxCYqvOP9+9oD/Q8v6Abr8VebhBNVJKLQfTeB38XO8Y6GPt0Ww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nic.cz;
 dkim=pass header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=pPupQaId; 
 arc=none smtp.remote-ip="2001:1488:800:400::400"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1488:800:400::400; helo=mail.nic.cz;
 envelope-from=marek.mojik@nic.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=pPupQaId
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D21BF40766
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:45 +0000 (UTC)
Received: from marcharch.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:8:8f8a:daa8:a10e:7064])
 by mail.nic.cz (Postfix) with ESMTPSA id 39D141C063B;
 Wed, 14 Oct 2026 18:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nic.cz; s=default;
 t=1791994782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Va+AP8F4IzfutapRdK6X/+mF72T5xC4kziVHbod7kDA=;
 b=pPupQaId2gvhHvjYbY6xKjlaKZSNfgIL0Cdil9GHvJwE+0O309FvU485n1CABSK0nnwzBM
 H/omdUs5ItnNDPTaLhB+D6OtzaUBR+fOqDBNHmaA66YJRD8i7hb0wGWdMqjkzg23bdr8Lq
 oxlBzZvpefrIS6wlil8jXHf/OFS7FUI=
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
Subject: Re: [PATCH next 05/13] powerpc: Make the global data pointer LTO safe
Date: Wed, 14 Oct 2026 18:18:18 +0200
Message-ID: <20261014161829.28404-2-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260928110434.70686-6-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-6-pepe.schlehofer@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.10 / 100.00]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+];
 WHITELISTED_IP(0.00)[2001:1488:fffe:8:8f8a:daa8:a10e:7064];
 DKIM_SIGNED(0.00)[nic.cz:s=default]; ALIAS_RESOLVED(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 LOCAL_OUTBOUND(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FREEMAIL_TO(0.00)[gmail.com]
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
X-Rspamd-Action: no action
X-Spamd-Bar: /
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: 39D141C063B
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

On Mon, Sep 28, 2026 at 01:04:26PM +0200, Josef Schlehofer wrote:

> The register variable form of gd cannot be used with LTO (GCC bug
> 68384); the LTO link fails with "multiple definition of `r2'". In LTO
> builds define gd through inline assembly accessors that read and write
> r2, following ARM and RISC-V. Other builds keep the register variable,
> and set_gd() assigns it.
> 
> Every assignment to gd has to go through set_gd() for that to work, so
> convert all PowerPC ones, including those in common code, and give
> PowerPC its own arch_setup_gd() in the new arch/powerpc/lib/gd.c
> instead of the weak one, which assigns gd. Rename the gd parameter of
> the SPL board_init_r() functions, which the gd macro would otherwise
> replace.
> 
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Marek Behún <kabel@kernel.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Priyanka Jain <priyanka.jain@nxp.com>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Shengzhou Liu <Shengzhou.Liu@nxp.com>
> Cc: Marek Mojík <marek.mojik@nic.cz>

Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
