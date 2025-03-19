Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3386C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 11:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66915810F4;
	Wed, 19 Mar 2025 12:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742384532;
	bh=/GsaTog83JZ59IqVdj8qH5/N1ldpojwVV4uapwuXm+o=;
	h=From:In-Reply-To:References:Date:Cc:To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pmLaLiCjksn/+YztLjfTy2FdcFLpoSpmV6McrAdSOzBXdMtW1ne4CM9xNtnzoE9JX
	 FAam+5XFASkz+iR6lUz61cUfJl3qQM/v8RDIbpFUoMn7Drg/amS2T9mMYaor7rg9Ab
	 9fVEIXHk9e3w4lY24a7leSXdd3uCgIW/ULva6DxdYNVNdutP6gEeiaYDiNQIGJQNCk
	 RTqru/KmKuyJAo11rRIR4Dq2zqh2l636Hh7nsVjXvlYpH01HyTzDxj5LBe67SCda8o
	 tWQf3/CYyFz9rmsYkTEkQoFpzd1HKB4M3pM/uS+mS7EQ67VIXMdLqzoDfATD2JOvub
	 ix3aBsBuGk5og==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 209E181101; Wed, 19 Mar 2025 12:42:11 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 279C0810F2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 12:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=festevam@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="NqUIDx5W"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPA id 384F1101F639F; Wed, 19 Mar 2025 12:42:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742384527; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=/GsaTog83JZ59IqVdj8qH5/N1ldpojwVV4uapwuXm+o=;
 b=NqUIDx5WvfLkZ5r1MhERShL43f4SURuNevowwzN9yNdQU4/avYgQVL+RMKVXObV6XvhYQM
 7L0d4z63N58mPyZRRgk6VUWizoR1aicFROcQkbbEtHPvNfYDefeTP5xRjUWiTTPPIY2v5d
 yxJ22I1tj6k3jEgP85UFBE6+JXdRBXkmCbvYtJPiqScbWmpXJ20R1oXLebQUTrma2986UL
 rt0TTjq70V1LmvU501CpZrxZXVHOqAUVWN0Jz00X/MS5t7fAsQMcfQVbko8XdNWGN2QQKY
 xlyJ5zKKGYT5XtGbpCIw9bxQPmOwcuizJwVhUJwZ3MIBFSx/JvF7V96lGRvpbw==
From: "Fabio Estevam" <festevam@denx.de>
In-Reply-To: <e09f009d-4a00-45a7-9a33-dba22da6ca4b@denx.de>
Content-Type: text/plain; charset="utf-8"
References: <20250319031852.233537-1-marex@denx.de>
 <e09f009d-4a00-45a7-9a33-dba22da6ca4b@denx.de>
Date: Wed, 19 Mar 2025 12:42:05 +0100
Cc: u-boot@lists.denx.de,
 "Christoph Niedermaier" <cniedermaier@dh-electronics.com>,
 "Dong Aisheng" <aisheng.dong@nxp.com>, "Hou Zhiqiang" <Zhiqiang.Hou@nxp.com>,
 "Michael Trimarchi" <michael@amarulasolutions.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Tim Harvey" <tharvey@gateworks.com>,
 "Tom Rini" <trini@konsulko.com>, uboot-imx@nxp.com,
 "Fabio Estevam" <festevam@gmail.com>
To: "Marek Vasut" <marex@denx.de>
MIME-Version: 1.0
Message-ID: <132-67daad80-19-611b1e80@141681007>
Subject: =?utf-8?q?Re=3A?= [PATCH 00/24] =?utf-8?q?clk=3A?= Add 
 =?utf-8?q?clk=5Fresolve=5Fparent=5Fclk()?= and fix up iMX clock drivers
User-Agent: SOGoMail 5.11.2
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: None
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

On Wednesday, March 19, 2025 00:23 -03, Marek Vasut <marex@denx.de> wro=
te:

> Sigh, get maintainers missed Fabio, sorry, +CCed now.
>=20
> Fabio, do you want me to resend this with you on CC?

No need to resend.  I can get it via patchwork.

