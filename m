Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFE6C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 22:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D4DE60706;
	Mon, 21 Sep 2026 22:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hYE18b_fxQf6; Mon, 21 Sep 2026 22:13:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9D6D360611
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790028812;
	b=pU5peJpjS44G247WnHcZCCsVuxe2aGZSXQIkp87BxL67X7JfotiyxsGP6XlzI3X1Ie1J
	 8sOfBuPuGhe2JpPlsXMAMBNMc4AWmILy8oezocCN/reEJLP86Gx11ARA5uHh+KtGXiybO
	 wNH187CbMypmZSubRWh1TqRI8n9i7LrXknVi4MD/SflfCDCn83wJLRwlU44YC8wvNgQBA
	 /nQkFz3yjxxuhhw+bKQkUO90uArQoAikrG23vHVDZItmzqLvWVfW+TcJKknVo06IHJfXc
	 jGdQf6+F5PVa9Splvwjt3qBlH77YKCSH8Uxjmy2YJXgpncsGf3jTPTxQOpl7kERXGjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790028812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eOubEpAzpcom3hGpy7uIYRZ7AF8jX+ucoVg6IbrsSpA=;
	b=ZhoUO3NakJQu1uIU1irW5AZ5TCUjVnEGQ74T81u4uXAYby0siDJJX+LMHwHMkbnsxtsO
	 MqBd3oSwHsPAQUPUn0er3o8DHeq8WMyjC82ojKArz56xr0F8hgwqYxLxEaDPAyAq6dbxt
	 fani2UDqpoT4I8/TpiVTrf8bz2fBhS76iYU7Z1dGxWwQZOaike1C3Vvs51QYI4U2HAiOT
	 Fle3YZlPaLbuMvkExM4pYTVH1tVOtKay39wUj/XcyLJhPdAN3bHPz5gDM7pwM/vD5trEm
	 jhdiN01W9yTmLELcT4TsCzt19ugKAL62ArWzAww/9Voj+WabLGQEduDUu1gtiCWCscA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790028812;
	bh=eOubEpAzpcom3hGpy7uIYRZ7AF8jX+ucoVg6IbrsSpA=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VUFEyG5rtYXvtzQcMwCVuHXPukaO5Ww9TT0VNvYs4Y2fsow2UqLIVZg30Ut9ncN6Z
	 /rlp5lHFKbY+xf95d7E2f9qzaUwa1f8sUxEbHk5sQ9lW4kwHPCk1UP6BIleGZHzlRF
	 psnFk61gJwcsasKs+G6ilxdaMPH/hDpbEX9OaRG0A9qudr1fyMtEmWlAFbJNqiVyFS
	 jx1ZQHZgc0cjToApS0Jba1i8XDnbmZXkPNQpspaJ1Eu6kA+7QxzYuaFCtDAoyEzywL
	 7xc3VXzkVyVtveUu+mr9g/zH45a8eFUJCDw1FCG/jsmKdhzSgvZfxgHbtgjxOdpIoa
	 i6Gq+gvbl3xvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D6D360611;
	Mon, 21 Sep 2026 22:13:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 45FF99CA
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 22:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 369BA80DB9
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 22:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QDZp4n6ayx_w for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 22:13:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 56A4B80DB4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790028809;
 b=IbSqGgcKGhUSb0hjIvd4al4OPt7jajSIC/i60G6IqbZdstmATNOWNWHztXQuX/eAHrO8
 XEiNkuIjCb0kh0W5UBEDSNJTV3r3HZHSWlNuBs8fCKQIjuVjcGSMOkfsshGW2+iLIOTnt
 +7j7UVaNEwTF3028KVJ+g9W9DaY467QaVQUQVrDSBtjLOilXrYn23ZPBxeNTs21xbni1d
 J6Eby98gMGEtE+ji3y3XNrbkt1RQQYiiJxBisHm/1tiSMv7OqwK0HK+Z1NvKlH+QocX/E
 /Sn4NTbOv98rDl57StdZdMXa5pzphN7BNQCU6B15enIyhssEClSrTcsptSKWluRydaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790028809;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
 bh=eOubEpAzpcom3hGpy7uIYRZ7AF8jX+ucoVg6IbrsSpA=;
 b=mkZi/l7hTMqaqIQBQDto5zbhFeghZynRLBzSwGkb80P9/DLaGIWqN1clOPJZpQOM+4PS
 Wb2LNktJ6x2wh7fJp+DIT7C8aRqNAwHE44tl00ARm/cGlLMlgQS00YgWlA3eA29yRe5ox
 LOT1xlkdeePUiZIijCsO7BE2w8Tu9LGVHNFMkC/wLK2Wco4k+YVcyFv6XyPvJfbwkKLug
 krRjoTN8yOOl2KrqLXUDdNZ/hjofYwdlBva6f3HTydP/pzk4RfTNmFHUouXY3TM8mch5s
 jIbXp2tcze20RB2NSgSLRfERFK6GvvXSvhQZ2foRo0R0DFgnmF2rBTvPyreTrUfnLjQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pRRWi2LT; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::2;
 helo=mail-oi2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=pRRWi2LT
Received: from mail-oi2-x02.google.com (mail-oi2-x02.google.com
 [IPv6:2607:f8b0:4864:32::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 56A4B80DB4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 22:13:28 +0000 (UTC)
Received: by mail-oi2-x02.google.com with SMTP id
 5614622812f47-4ab2d8e7e4cso1356539b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 15:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790028808; x=1790633608;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eOubEpAzpcom3hGpy7uIYRZ7AF8jX+ucoVg6IbrsSpA=;
 b=pRRWi2LTMvbKFMAkziHBMwLfKxVsjTWNyJPAI+dt4XFW50RTGmVXF3QREx6FozGn6V
 onvcXd2nzwvDuw4Vo71N0Ww0h+zJ0PkO5faNUn4IGq2HOA8ApWTCKJBsnJLhZvdqkEC5
 gbfzJDWR1DpUTmlFEbAjjb6Tf4NL50WMw4plw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790028808; x=1790633608;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eOubEpAzpcom3hGpy7uIYRZ7AF8jX+ucoVg6IbrsSpA=;
 b=gDF2D0e3Av4ld40f+Hc3QUQvqqF9K4DqFKf/cxQUT/m8x6SwwAUB144Fk3ZUIawf8y
 jNcwDtRp/kI5elL+H8xZfkkuXp5tKoAt8LKeKWPI73t6rtfckn7LOCY8GUTCbkEeI7C1
 /ObuOcRZuVY2SCE/5VpFJvW6Z9rLNyday1puEt0at379lTvpNPoKKX3y/5IKZfVPHn76
 /xbYKcS9H6Gxi7hqd62/XXoGcdDcYCr19lKHUwo6FVsFUyZPVigENe29JqRhhu1hpv8Q
 NOmfGdUr9Ex0Wl4p8+XE4u9mbdphidsrPn0fOV/qe91fmojuxhWGk7JuL+jsiZLBR7ng
 wFxg==
X-Gm-Message-State: AFuF++mJ7DzFboBuRAM16zVvK2NT+nb3430zd4sOb/2yjew0beaBIT8R
 VQeIZTwCD+pAPIbCL63GuJV2cv96ecEQC4pUGwEnvtWiJUrxMxrXJ7zLZrmI8VbiebKLbsbxxe0
 Bx3LfiJNidETofns=
X-Gm-Gg: AYBFou0ok9Bj1PLyzQ4K//TUh42UX1Wy/RCtcdsh+MURC14KwdrLl6aYo/nOgdMRNbT
 By39ez8akrEJSFdLWY+y12ALqRpSJ9C7F2MlNEAgZvM4u8fXtt8bVM2BbSVdxdBCPjUP0X4eyAf
 Dmi2JGNKSONC8spbe+TqRt9olw5inrNop/LYqWhhiWDVrD0HTNw7yD00r+K2xVa23tpTgWxrtDv
 mz3xxFHc8rxA8L+087VsXXODaAVeOJDP5t9iwqShGMdy7Cqbehr2EMyT9Z4gtyr0NTuSIiMclll
 bPQhqXDfOBaXnea4LvwsRdifoSxAslaGUrKrUsmzuld1pRpvsCfKZslp3BgFPs+KsQ9xKKRiVhL
 cdkjbSMYSIVOR19h2S1casiqD0ezyHPhlpeFwsxxi4AjJWWyeuIinntMGGBJiJfButy0xRm1oB2
 PeJnkNNngizkihfEGOD5hUUjOLIAIABrTwpq4bqM3ZmfsjVhrcr52E56DbcuF4xc92nqnLys/My
 5IlRiesthR2qYedVteEhS0YL9d7RdUSSu2a/UlFtvrBl+mTcoQDT4kD8T/9GVll1qPKusCAZUHP
 xdTxpjpI5RhbCcFLDS4=
X-Received: by 2002:a05:6808:c18b:b0:4a3:3108:866a with SMTP id
 5614622812f47-4ccf6b742dbmr12905867b6e.17.1790028807928; 
 Mon, 21 Sep 2026 15:13:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4d486d0f627sm183242b6e.2.2026.09.21.15.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 15:13:27 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:13:25 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-custodians@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org
Subject: [ANN] U-Boot v2026.10-rc5 released
Message-ID: <20260921221325.GF858934@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B1AFG6wR4SVH0JBP"
Content-Disposition: inline
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


--B1AFG6wR4SVH0JBP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Once again  it's release day and I have tagged and pushed things out.

Things seem to be working well on our new infrastructure but if anyone
has found issues please bring them up.

I believe overall things are looking on track for the v2026.10 release
itself, and things are moving along in the next branch at the moment.

So, the git tag has been pushed to
https://git.u-boot-project.org/u-boot/u-boot and the release itself is
also under https://git.u-boot-project.org/u-boot/u-boot/-/releases/

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DZ2IwbH=
R2NjZhMzZkOThqNHJoc2sxZG04MzJfMjAyNjA3MjhUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/jwj-pqka-bnj
September 22nd, 2026. 9am (GMT -06:00)

To join by phone:
Or dial: (US) +1 929-277-5781 PIN: 115 674 167
More phone numbers: https://tel.meet/jwj-pqka-bnj?pin=3D2145803234090

In terms of a rough changelog:
- Platform updates for Renesas R-Carand STM32
- Fixes in our NVMe, PCI, networking and DFU subsystems / drivers.
- A few other assorted bug fixes / hardenings.

We should have one final rc release in two week, prior to the final
release on 05 October 2026.

Thanks all!

--=20
Tom

--B1AFG6wR4SVH0JBP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarGsBAAKCRAr4qD1Cr/k
Cso0AP0Ycqpl7eyHjlZXVozyKtOk5TwXsKRtGQ7PVYql3klBLQEAiNHLgaoRpk22
o+DEWPrhmVdbmpcjleSl8LtqU6/5Wgk=
=Auxg
-----END PGP SIGNATURE-----

--B1AFG6wR4SVH0JBP--
