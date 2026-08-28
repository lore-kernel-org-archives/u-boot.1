Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39232C61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 15:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D74240872;
	Fri, 28 Aug 2026 15:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lp2dyYr15KKu; Fri, 28 Aug 2026 15:50:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787932251;
	bh=R45DQBtYKMe+XIXX+JETfSpJQzgP1zVCGi6WAy3WuYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RjD+6lPOns/fwSUD/oCL3x9S2b4HRx0DTXX6I7FoGRRt84GjpkT3zDgQ9GJSWYwHp
	 jQCOuQ7nSCulPQMoP4OEIs707neevc1QGwiJz3zq5vI4d5GILYcaeDUQmFMgYhrS3q
	 9Ijyf5UtWbyzoekVeEM3m7PBtv3MpcFswmXIqjkJ2qytY94PANpZynNS7cwjOA76Zu
	 y3ivyV7rlRxzw0nNRvcxEdGrIyTsuMEplZxvzKfeipMQJWu2cLCMEo5xBR6t1boGhA
	 mNx0jGbadrYu0HZeg6D7lWydGxQdTUaNQbndAaXTCPecmUCoMARTR6nZ8Z2ntcNiEf
	 QCaOmQ6uxHA9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EEAE407FF;
	Fri, 28 Aug 2026 15:50:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FB46336
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 15:50:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 22449401A0
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 15:50:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4DikfSz5bZ50 for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 15:50:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=jBrP1IGl
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 18BD140070
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 15:50:48 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7eb6573bd52so1298337a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787932247; x=1788537047;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R45DQBtYKMe+XIXX+JETfSpJQzgP1zVCGi6WAy3WuYc=;
 b=jBrP1IGlb9PeTEkU6lm/Y7ZK+e1R98lzH5VitiR10p+lW8nPkXAumnlwaxIN6QGlRq
 AICRYBFNAZhT1lfd07knUTyiUYEdOxVzntxs6BgV09rOvwZ4P85CD7AyA2yQc3xMMLhm
 S1anfaf0U8dGMS3U1AJIAs3wG/YVhwOJspyCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787932247; x=1788537047;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R45DQBtYKMe+XIXX+JETfSpJQzgP1zVCGi6WAy3WuYc=;
 b=IVbQX4POxw59EIeYicE9y1sC0U7vgsAvHiP7zc9UUf8p2ZikdtA1+bcMFv5M5XFsVR
 6J5RztOehX7yrptBVGwib0R5rqHmrQEvzxeVl3idm/DAvdoCCDAOM/iD9Hjp6SW/Dvj2
 DqsjACRanSGURoaBDdet3ZW3uv4ngD3nv7vkrtqTmD6GHVza5z5II5RqtVAtR3LuPkQP
 7QLtWVl7PFP/zqZ0zscVdze221JDZ38wihf/2PI9hJZIdKuseUrGwJJBmbBOgGPL9xb8
 MdzIaNxVCkq2dEXPXloN8CmJFpvIaX2SPRioV2pH2bwRI6JgmW2JjVG8+inMqVReqxW8
 RGXA==
X-Gm-Message-State: AFuF++loHQQlnU7jSjoCxee/u02OBFERTIPIEw5ovaakogZgz++T1Ddc
 kv4eJXFus0Wz0sJuC7TJqXrweDkvnNOmj+7VgZ6h1e3OfQap6xqzMntfskrNlOpdLirqx1kMooG
 bPURhGwz6WgAU
X-Gm-Gg: AR+sD11A7mbLGX6iKR6gzwjl9p07hP7KHKLqbpKzYRcFhdcYzX5g2q/zI0x3XR66HHe
 imHU2y2eDW1pAy/AxOFWa0B8p4HwWe2ngNph0iq4sQpEXiWSFUDTofydhvsVekKnzjEgdPLtaho
 YFH8ItWbIOxCWKyHpUHIVKxjR8oPCYZSWFnWJLbnDfiovj8vRS6uPcGV6mDwlVMWHk/mDUb7j6T
 D0IhNbEsl7MrNJ6vpsxAcVRu7ClZHBBPDo0m7UxIbZI/iKWhUO9HGG559BKBZ/+D4ovv1D9XA7m
 COPa+VrHn3rAt+RLYWekLkSpyYuwvZgf6r/bvfsOZFK/oX4O+2Pn8pn4Kxf5FpO4ZIhKJBIUQpI
 oNZkA0h0ScFmfRiopWkHTDmGUwYn/6KJbOjgOOkdvSGHhK38t+V4gXczYjbwFxLx8Azs40AF1s+
 gBzizJyKALSrTv7eE2dsBOdi6jo+fXGQ6Ar4z6NFF29+c3TNf+ZyTVj2lOkhM2GHLlv3AfbHGid
 1NKxQa/usKWKX2zsMPioOOROreElpmiF7HjyQ9dkdij/miqgHv/dDuI8Nhgbmf8cEZzAJ6UNbRL
 8T1Qxv35SA==
X-Received: by 2002:a4a:e081:0:b0:6b1:4fe1:9464 with SMTP id
 006d021491bc7-6b1c66289ebmr5801547eaf.22.1787932246977; 
 Fri, 28 Aug 2026 08:50:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-468a354165fsm1767066fac.8.2026.08.28.08.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 08:50:46 -0700 (PDT)
Date: Fri, 28 Aug 2026 09:50:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.u-boot-project.org, Jacky Cao <Jacky.Cao@sony.com>,
 "nora.schiffer@ew.tq-group.com" <nora.schiffer@ew.tq-group.com>,
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: Re: [PATCH] include/env.h: use plain old #ifdef
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
Message-ID: <20260828155043.GI3959812@bill-the-cat>
References: <20260828150600.918158-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yUhQV1gv20XSzBIs"
Content-Disposition: inline
In-Reply-To: <20260828150600.918158-1-ravi@prevas.dk>
X-Clacks-Overhead: GNU Terry Pratchett
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


--yUhQV1gv20XSzBIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 05:06:00PM +0200, Rasmus Villemoes wrote:

> Commit 9f1807e57cb ("env: add env_set_runtime() helper") broke the use
> of "make envtools" to create the target fw_setenv/fw_printenv
> binaries. The problem is that the #include <config.h>, in addition to
> pulling in linux/kconfig.h to get the IS_ENABLED() helper, also ends
> up pulling in lots of architecture/board specific headers.
>=20
> Fix it by simply using an #ifdef.
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Thanks for picking this issue up.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--yUhQV1gv20XSzBIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapGuTAAKCRAr4qD1Cr/k
Ci0oAQDybR4K7MHqGRr3oKJmyCeXC13bzd4Rm4AMBR9ncijdggD+JIl4eGrJGlkV
hhWl3H+j5eP3rePJrYD76RVyuaMQggI=
=pgIk
-----END PGP SIGNATURE-----

--yUhQV1gv20XSzBIs--
