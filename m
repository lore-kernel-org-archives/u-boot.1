Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAB1606A33F
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KB7H8vgR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYcmX67F
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 862D0811D3;
	Tue, 17 Nov 2026 15:04:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q2OLmotjFmNl; Tue, 17 Nov 2026 15:04:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 86F30811D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794927863;
	b=ZK66o7eX3Tbv3UgqnZVjGV5ZLOM+AyL6sNXnWQVF91i451hk+Z5lrQF6+32hY5BoAbq6
	 g6Io3sqC39pGTkJB993cS4QeafqWieNHUbCaLWcsTJvCERVQ3vMSxPAM92Ngq1x9P8Ubx
	 yXAKQ3Q1Z0UGTPiYYQMvZn1KzryJPWJsdN5aIqDk6XSur2LD11yngdNdFJN1J3yap17K4
	 PSQigrePwSBzAyVTeBU2gGLVIBvM6IUKYaRhVeHbPyuYLs2FlTS02TNuuqaAfV92cLWwL
	 LbXOcXI1Kou+UC17X0R0ejaLsewMHx5Tt7QPpLu70a7G9Cq8OYNyPsryqBiItwd2HPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794927863;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=W7a2m11rByFJb1eZMY/821zWA4wJwQakKw+0fi/JKBo=;
	b=HcGelGy2YcLMprqfyejOnbmiL+AyDemMoDCSkx0OdZlkgzBa2ZRUOTRPFFvLcCscfm/0
	 oHlE3wB2ND9r/LpBVmHZ5DwR37cytXGj9hEQaJ84RyMX+aKq3xhoxhbe+Phg0OCUO56MA
	 7oeSiH9p1RT9v16ccNrIBFUZBP3aS/jHREQnWLgJK5XgW9u7Qxn7xJUL6SQw6N1rwrdGS
	 h5VPtJN00bh8F4fwoKRyMIg5QNpscVGIfTJ5+egYwu9IEhxizPKI3Ou5sBwp3KVHAyPnM
	 UgSZmLZeuCQ12bSWGGgOSC48Cbio4CCs02P8xohgTiR8oviruL9bveD5P9vCatW+sQw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794927862;
	bh=W7a2m11rByFJb1eZMY/821zWA4wJwQakKw+0fi/JKBo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KB7H8vgRetmmjOuK2HjSo6mAV4+M49Jh7gOQw0+6kogOevifBTrPGo19sMnqlvtgo
	 ckctLF5Avs1I2UlmnUXXgdQ85L3DvIAt4p6iid9US7/i00Nzq2U23dR4UWnRHuC+wJ
	 dZ5yBEqEvteOXA+DvNkw0CrvmWy42FOXBrq2vmFo90sdocSUDd2k593+Abocz34Bth
	 460ErIZB/HTuMU8fgs69nGNZDJhxaM8EcMFQazUfhARaYCcBnrozDXw3EqYDXHJWYu
	 8OeOVf7UvspfxpYQWzxzM+TUvM3KYpkAZ1uuu2aXf90+ZGlbJyuYAl2rwDv6LQ/gMz
	 JSssZAm39E2cQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86F30811D8;
	Tue, 17 Nov 2026 15:04:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F23481A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFB7B408C3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ApJ4O1Oossi3 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:04:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5258840896
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=XYcmX67F
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5258840896
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:04:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE227410CB;
 Tue, 17 Nov 2026 15:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF621F000C7;
 Tue, 17 Nov 2026 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794927855;
 bh=W7a2m11rByFJb1eZMY/821zWA4wJwQakKw+0fi/JKBo=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=XYcmX67FORk7yJxQJqtHZ2xRGdMJGJQ71tCSLOCr3ewu2Vgl++Iqk4rup6Lt42Mbb
 JuD9du+/EXiKum1QbbC1YocHcRfU31P5edEG6bHp8YlEDWEclFY23JPmJl0mt3I+VE
 sn4gH1uikhIBmP3Ec+omniK1f8CJoaEcJQnEZB2kDEajTDDos3Df738gG6Q4JPlFHa
 YApE03DJn3dGvWdc+P3eNNl/BOp5h6iadlBNVeUCk0Iu4UI1pqAGvGHYDGm4smaOYY
 xSBanRWi+TJNv+rVTD1EtO7ropEr67Sel149HiCEc0Gx7YS+D3QUq+FmRH6iRbjlIW
 01SL0vYpn/nTw==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/6] usb: gadget: f_sdp: write report 2 data only
 within a download
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <7caa5a02-b6b5-4666-a1f1-7aa8fb3ce10f@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
 <7caa5a02-b6b5-4666-a1f1-7aa8fb3ce10f@gmail.com>
Date: Tue, 17 Nov 2026 16:04:03 +0100
Message-Id: <179492784366.252888.8353660885302562491.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=826;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=OoYmhWh/bAMbXU0kMlrWomoTmxXh+Si1s72wptQVu7Y=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/Gzo5VnZR6aihip6BI8h+BNgh6cJnPmqJkWMG
 JGBpjx348CJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCavxs6AAKCRAZDR20Zk4Z
 NRFbB/oDopmY1QCd0rdCoLkS4hvROxIZ+kApB511qPMW3V7Akq/IHDw5B7H13Lx/q+9o6V6kLIb
 GxBQ4HY/pxelObdKy6xE0wsntDw+bRpM1d+bOMr739c4wuaOpC7CEzkV+3d+62RBQFzTnSHg0Jg
 eKKCU0qLNbzLjkFQnyQN9dKsUWwLCRS4KYXCVv8Zwu2trpaMlud9Gtzu0uiXXBUxf3zkW6n0G79
 LaoFSATTXHBbCgaOYFo+DnBk45Zluw9XTcj5jNAMH7gBucErMBEkFAPFM5Wa7JS8jKcEEzS75Z1
 ItD+rCQ4SBLF/ZpaSJI8dZ41Su7uowMOR9dl0Lh/LmGKdIq2
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 07:18:07 +0000, Ana Bobillo <anabobillo3@gmail.com> wrote:
> sdp_setup() switches to SDP_STATE_RX_FILE_DATA_BUSY on every report 2
> SET_REPORT, whatever the state, and sdp_rx_data_complete() then copies
> the packet to dnl_address. Two things follow:
> 
> - a report 2 sent outside a download (after the previous WRITE_FILE
>   completed, or during a DCD_WRITE) is still copied to dnl_address,
>   where the last download ended, or wherever an earlier command left
>   it;
> - the last packet of a download is copied whole, padding included,
>   although dnl_bytes_remaining is clamped to zero: up to a packet past
>   the length the host announced in WRITE_FILE.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
