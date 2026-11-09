Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014A606A325
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BgLjSDtf;
	dkim=pass (2048-bit key, unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=h1pIzY1v
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4733360725;
	Mon,  9 Nov 2026 17:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1GbFkLV7f7E; Mon,  9 Nov 2026 17:09:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 88DAC60690
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244149;
	b=rpMVHvom6/ou+z85K6+msQ3m5fL2r10MdelOVxpnsWSJabsgR10nSi91UoC264I4NwTX
	 DGeTplK1Giq6t/MrHF73zj/KrO/NveIYHxgU5WWs7ZjghLcpR4/Uwfid/PUtLqBX/YvR0
	 XcYWrrv6pYD30j4PputlFFxJqF21K1YTfhpPEhpRuSEAayYjjfxwBAOTg5aPi3zg8T/rO
	 bmEOF0S0TLS5Kw4xEkNjxTSgTVjONUhrrarazMsUtUiuDTd/O1BcLVXZkRZ7BTvMzi/oz
	 OvJyChnZbortPHIAvzTuraZMhe1ev72qaqacFjsvozVQiW6wpCtb1mkflHkv/vAt8/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:References:
	 In-Reply-To:Mime-Version:X-Mailer:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lqpCsZyyV+gEsfnOIuN2EggG4wRnjyXwqHbVyH53Wgs=;
	b=bjwsc98Ow8bG5pOiU68meJX7dYofH+b5bSnZbRedLcdupuSNghY/Pe8V66N6TyIgR5uH
	 EKH8ehHcNjCKWYIbkXUEDeON5yWtnL4UNR9gUrkhE4Yt2bgPFx1bkV49YjgqLJ4hdaWtc
	 zbjj1fRX5Kk9TkXyCnpq4b7ZPLbZeOUlLKfq4F8C/NNqDamBbUG9a+1y3TsoFm2jnCrHP
	 zlWcYFmVV+LZaEVogqK8My9wV174pA8A9UNr5kuvebuPwrieNlCLzaKBQJTQCzlaLS1F6
	 kzDa05XH/aNlhbcqjZCwyp83i8HUl07byVdvCnpKPGHMl5Tlz7jjCE+tgSfBON0hriw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=email.cz;
	dkim=pass header.d=email.cz header.i=@email.cz header.a=rsa-sha256 header.s=szn1 header.b=h1pIzY1v;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794244149;
	bh=lqpCsZyyV+gEsfnOIuN2EggG4wRnjyXwqHbVyH53Wgs=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BgLjSDtf+MJ3sgWgsn42PVu3bR/ECQzFU2ttkrNVtcYxGofRpmUHeIjvvU6w5yQIW
	 XC46jxOePsvToFAp8OBHr5ormG4tl+h+15yP+hd3oSgJkIzN6V2QpvAADqZKzuf2NX
	 0k1kNzQwqvLLPykKTz1tLAaiU8pwJ18wehCdBuyjev/wDO9IeZDBcOEXWQNHevttZk
	 WG8ipAnQmt+0J449e4TliZa091hLDEtwyEIYy9IrgMYXC9rmuMdXEjm1g7SqujvlOo
	 dYGd63aboY+oak7XunpI4zvM6faXjnXHhdipexhsYOpEHUoYYMRalIw4vJDGRJd7TP
	 5zJfoKKvb/fiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88DAC60690;
	Mon,  9 Nov 2026 17:09:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FC0F3AD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 358396067A
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gjnVAWZ_5zZd for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:09:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 35C806069A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a02:598:96:8a00::1200:5b5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:598:96:8a00::1200:5b5; helo=mxc-3-5b5.seznam.cz;
 envelope-from=tomaspaukrt@email.cz; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=email.cz header.i=@email.cz header.a=rsa-sha256
 header.s=szn1 header.b=h1pIzY1v
Received: from mxc-3-5b5.seznam.cz (mxc-3-5b5.seznam.cz
 [IPv6:2a02:598:96:8a00::1200:5b5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 35C806069A
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:09:04 +0000 (UTC)
Received: from email.seznam.cz by smtpc-mxc-7cbb46dc48-p5l2q
 (smtpc-mxc-7cbb46dc48-p5l2q [2a02:598:96:8a00::1200:5b5])
 id 462964b2b8ddd61846a7eaaa; Mon, 09 Nov 2026 18:08:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
 t=1794244139; bh=lqpCsZyyV+gEsfnOIuN2EggG4wRnjyXwqHbVyH53Wgs=;
 h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type:
 Content-Transfer-Encoding;
 b=h1pIzY1vg6tcHbd88Elgg7uAXXga+5xRNbs+/2SH6L824XiQ4zIu+JHkaX7D/inSn
 D2+c2FbiaslL/Npx0GV7iaIHH0+trbqSuuSRtiUsy2asuyF/dEMc1QPIXnQjPZXn0r
 YFG8RhGHnjSzBSiQS3Cj4ijIpXBwWiEa0Jr3ywMntVzMOLGH6R7Ul9JTcDeNsHRDRy
 r5RzOsMXz/fMh7FjPWdtMguCfvI0yoVlTl8lqWF23+flUXve0vgndbdkuZv9uIMCiD
 4oIatCLAhpSMg+R9C9jMx+DpLhiN8j9ntGy0uYcySWT1FoHH9xPRaZETohee9/EWOr
 2KhMRa/Usz0fA==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
 by email.seznam.cz (szn-email-ebox-5.1.30) with HTTP;
 Mon, 09 Nov 2026 18:08:56 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Peng Fan" <peng.fan@oss.nxp.com>
Cc: <u-boot@lists.u-boot-project.org>, "Tom Rini" <trini@konsulko.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Stefano Babic" <sbabic@nabladev.com>,
 "Fabio Estevam" <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, "Peng Fan" <peng.fan@nxp.com>,
 "Ye Li" <ye.li@nxp.com>, "Alice Guo" <alice.guo@nxp.com>
Subject: =?utf-8?q?Re=3A_=5BPATCH=5D_imx9=3A_soc=3A_read_the_SoC_informati?=
 =?utf-8?q?on_after_relocation_with_SKIP=5FEARLY=5FDM?=
Date: Mon, 09 Nov 2026 18:08:56 +0100 (CET)
Message-Id: <28e.ZqMa.4lWKGzoLH{7.1gyVue@seznam.cz>
References: <1Bx.ZqLe.4vhwbiJKX2M.1gy2pN@seznam.cz>
 <avFnfOtoqFJk75sV@nxa18884-linux-1.ap.freescale.net>
In-Reply-To: <avFnfOtoqFJk75sV@nxa18884-linux-1.ap.freescale.net>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (szn-mime-2.2.19)
X-Mailer: szn-email-ebox-5.1.30
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> If mmu/dcache is not enabled in SPL, there should not issue, right?
>
> Regards
> Peng

Hi Peng,

there is no issue in SPL because the data cache is disabled there. However=
, with CONFIG_SKIP_EARLY_DM enabled, imx9_probe_mu() is called for the fir=
st time in U-Boot proper after relocation, when the data cache is already =
active. That is why cache maintenance is required.

Best regards

Tomas
