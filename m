Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACABC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 17:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62FB2805C3;
	Mon, 24 Mar 2025 18:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="AbeWFmm6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A9A806FC; Mon, 24 Mar 2025 18:35:52 +0100 (CET)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A846680548
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 18:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4ZM0ZQ2Byyz9w96;
 Mon, 24 Mar 2025 17:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1742837745; bh=yvReoRB4inQozCeqWT7sihKS1ONlB6s49fW7uLbtq7k=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=AbeWFmm6JG058lTKJ3OfS+BoMYadu2NAg5N7ajsIYvlmOLMK2k5cUjxUnuN9CEWE6
 lVhhw9oHixxiAFedRI+3gsxoewMy0cZl6E9jte9aMRS5Cpo4K47bA3fP5oKIMniVdG
 cp+cZXbpE78ex0Kc8XuOn1VO0QgnFPbSDFhZw5qM=
X-Riseup-User-ID: D46C4BD68AB579E059EBD231F9543C870DD1437A61177391186C52C4518B447E
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZM0ZP2gNlzJp9R;
 Mon, 24 Mar 2025 17:35:41 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
To: u-boot@lists.denx.de, Maciej Pijanowski <maciej.pijanowski@3mdeb.com>
Subject: Re: [PATCH v2 00/11] Rockchip VOP2 support
Date: Mon, 24 Mar 2025 17:35:30 +0000
Message-ID: <17212036.uLZWGnKmhe@melttower>
In-Reply-To: <b8f68653-1d3a-4198-9c75-c8e0405e553c@3mdeb.com>
References: <b8f68653-1d3a-4198-9c75-c8e0405e553c@3mdeb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi Maciej,

On Monday, March 24, 2025 3:46:12=E2=80=AFPM UTC Maciej Pijanowski wrote:
> Hello,
>=20
> First of all, thanks for your work on this Rockchip upstream code. We have
> tested your patches on RK3566 board (Radxa CM3 IO) and HDMI output in
> U-Boot works great. We didn't have success with MIPI yet so far, though.
>=20
>=20
>  > HDMI should work flawlessly but there's still some timings issue with
>  > DW MIPI DSI, perhaps that's something to look into later.
>=20
>=20
> I wanted to confirm whether you have had success with the MIPI as well,
> and what exactly do you mean by these issues?
Try not to plug in the HDMI cable and see if MIPI works. You'll also need a=
=20
panel driver.=20

As for the timing issue (which I'm not sure if it is), I don't know how to=
=20
explain it so here's an image of how text rendering looks like on my device=
=20
(notice the word "Bus" in the image):
https://0x0.st/8j__.jpg
>=20
> Thanks,
>=20
> --=20
> Maciej Pijanowski
> Engineering Manager
> GPG: 9963C36AAC3B2B46
> https://3mdeb.com | @3mdeb_com
>=20

Best regards,
Dang



