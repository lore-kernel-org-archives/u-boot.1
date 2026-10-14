Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07103CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 16:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E1A580E80;
	Wed, 14 Oct 2026 16:19:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 01MH6CE40qyY; Wed, 14 Oct 2026 16:19:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4805480E4F
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791994781;
	b=emQbD70g8oTMdqcp7pc2S7kC6woFf5145kypl7LZ23blEVMGHPxXGAWwv2ESlKMcrLZ0
	 Bxq4qa/FcudFfUVE4E2wS9ULl4Q6tUqmEztlL5qPLsH2+jN1dZwXRyRHj1PIITlkuhoLv
	 hhVV7cxfql89PAMNB41PusTwpQu6TA4IL4ikFYIBGb6ds1xcdNnt/bV6mGb1yDMh+Vy1k
	 zYuFG+oG275vsC6krVZUs+CDKmKPYjOQcGEyrRj9xBk0p2gM281vWo57b0p7bLoOZpgT0
	 gryZOzDZtM1ln4UkYKu0aAcKoDZs1ykNpR4rY+lRV62aP6/NJ8dRUrZMrIfP1FdMoKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791994781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Rspamd-Pre-Result:
	 X-Rspamd-Action:X-Spamd-Bar:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m13LBWhSnr3tORb2PbU42TS3M8IsiQTtaWUhQM9eAyo=;
	b=s4w8ktj3FIHGZMZ8LyW9KP9kjpt9JPvnHOHUH6XZhTKTtOkHKqmA3vdg9UjRyhVwh4Qi
	 reBucWjqxeCThX6UDf7L+ZE+cWOosCsKfwmPk76W/a+UFCURXd2XmdjIJVxxYvYYESLcC
	 w2cmy9OI268cE30oU6xeN2yVDqSQecM+ahxWdU8doe6ZYecmk3h3Ednwf1jpTbUFKHVZo
	 YLtAkoLwec2IF7fbnCaNaFE/1CcFz+7rf0uUClZdTlxbZHbqgNdCQXVU2/C4uaGQflmUl
	 ogNNlPE6xIGdpb2eJpOrFxfJFnCUhcaG8ovftEcZ3uGMkuohmjqndnuPe5dO8cMaM7g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791994781;
	bh=m13LBWhSnr3tORb2PbU42TS3M8IsiQTtaWUhQM9eAyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m+H+gi7oUssf/Y+tiGlwSYuYfNKt+LjOLopkI9adTX0GvhtCPx2dKAteacHbyJf1V
	 dMuWbe8UEpFfVYs2WsRL/4dKNJsUgW0sNDr990twFxf/agtqn5kV6kGUUetNbKoT6M
	 ARu+VxSvQTUvFRV5wlC2AyW3yrMwYUxzWEDYTY59DefemwVFrC19RLStM8kikIhaot
	 RaV8Vdij7GsuV54iQ9C78Rqp50E5pcCSD85ws+Ml4y1qV/8iwGTG3GSfn5BCTyY2ZJ
	 z7B6Y8zS46yvIROIDzSaDEyswUDCgxETk5D7GWwWMxVOlIgoPkkvqDl0TPzlMmbtL8
	 6czMAceCfwsuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4805480E4F;
	Wed, 14 Oct 2026 16:19:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F423E769
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D678940766
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hi7gt6aQlnkj for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 16:19:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2357740767
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1488:800:400::400"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791994778;
 b=CQ3csWVS2DJjh8MwX5k2zAOs4IBhbMWc1ibB0fZzsojYNHkm6WDOAsOaSANUieHmwDTG
 /XhxVjYWCHYGWhOp9TYKf8/pzzk+ffpjNKf53hjqGoi5Vzhxp8gw7V4L91QYx3f4kanLS
 jdqlDAQna6jacTo09M730oBH7vRYZpenMFb+RC8IRwsIU9FY8QMIMRcQydiQ9RvYRa6ii
 YMAU0wGx/Meaa2m4npX0ULJU5pKt7S++tptc8bEm8ecK/z5Zsqyn0a3u2YpawTq3WrUjw
 zMawVPyzNIAGHYtJJjptpMeE4qagl+BHlofKcDRp5v8L0BcLuordotYCGLDRPdTbt1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791994778;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:Content-Type:
 MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:
 X-Rspamd-Pre-Result:X-Spam-Status:X-Rspamd-Action:X-Spamd-Bar:
 X-Rspamd-Server:X-Rspamd-Queue-Id;
 bh=m13LBWhSnr3tORb2PbU42TS3M8IsiQTtaWUhQM9eAyo=;
 b=jiwIOG+O3l/TsUwcOr9I3vVZtHJ82m45ydaZfh5MwZu8EFQYiQ+TXwRAAS7BvF5iduvi
 lF2V0g9qxmOTKWRlAXigqI4PgIYLDipCsCgZjB/ESy7+5m0mEtsxTbTMsT3Q1gFwAidV8
 V9leHMvsAEMv9l0AI+nhU9Kn4kvHt1dRgmQH3ysVx37v4JeAz5Orv/MtukAuJgD0j4J2t
 Uz5pZ/KEKxlV7Q3KizxTeZBOqf/2YlPgzNM/lnWtbeeI59MKo5OW3e4uAhOkHRmTGKO09
 Je5EeuKvVpPn8d/eyZsFrbUREgm9l7RZtoEIpoqZ3HDpbKy4guBipNPa3+6jV3fiNQQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nic.cz;
 dkim=pass header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=KcPzDyso; 
 arc=none smtp.remote-ip="2001:1488:800:400::400"
X-Greylist: delayed 1078 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 14 Oct 2026 16:19:38 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=nic.cz header.i=@nic.cz header.a=rsa-sha256
 header.s=default header.b=KcPzDyso
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1488:800:400::400; helo=mail.nic.cz;
 envelope-from=marek.mojik@nic.cz; receiver=<UNKNOWN> 
Received: from mail.nic.cz (mail.nic.cz [IPv6:2001:1488:800:400::400])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2357740767
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 16:19:37 +0000 (UTC)
Received: from marcharch.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:8:8f8a:daa8:a10e:7064])
 by mail.nic.cz (Postfix) with ESMTPSA id 4CC371C063B;
 Wed, 14 Oct 2026 18:19:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nic.cz; s=default;
 t=1791994771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m13LBWhSnr3tORb2PbU42TS3M8IsiQTtaWUhQM9eAyo=;
 b=KcPzDysoQBxuoYh+582CgencQQMpKBnSBnwaKe7G4RlCdbic8M4Iq0TsbLkE0rDpDWWLud
 FIqxCnAnu2uAJnd5OdfS/DgzWDvl/CAGHLqAVBW3lMZ6Z/R3n0rB9jXIMTed6119KOHj+v
 ygolWTrAhlGoCWnkPW5db3mK3/yIaGc=
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
Subject: Re: [PATCH next 04/13] board: nxp: p1_p2_rdb_pc,
 p1010rdb: Drop unused SPL gd copy
Date: Wed, 14 Oct 2026 18:18:17 +0200
Message-ID: <20261014161829.28404-1-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260928110434.70686-5-pepe.schlehofer@gmail.com>
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-5-pepe.schlehofer@gmail.com>
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
X-Rspamd-Queue-Id: 4CC371C063B
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

On Mon, Sep 28, 2026 at 01:04:25PM +0200, Josef Schlehofer wrote:

> The SPL board_init_r() of these boards points its gd parameter, which
> shadows the global gd, at CONFIG_VAL(GD_ADDR), clears that area and
> stores bd, the full malloc flag and, in the NAND TPLs, the location of
> the loaded environment there. The SPL keeps running on the global data
> that cpu_init_early_f() set up in the initial RAM, so nothing reads
> this copy.
> 
> The next patch makes gd LTO safe, and gd can then no longer be the name
> of a parameter. Drop the copy and the stores to it instead of moving
> the global data to CONFIG_VAL(GD_ADDR): on the P1/P2 RDB SD card SPLs
> that address is 4 KiB below the stack top, and the 8 KiB environment
> buffer of env_mmc_load_singular() would overwrite it.
> 
> No functional change: the SPLs and TPLs lose only the stores to the
> copy.
> 
> Tested on CZ.NIC Turris 1.1 (SD boot, with the LTO build of this
> series).
> 
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Priyanka Jain <priyanka.jain@nxp.com>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Marek Behún <kabel@kernel.org>
> Cc: Marek Mojík <marek.mojik@nic.cz>

Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
