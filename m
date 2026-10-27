Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4790606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 00:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kQxANZnI;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=eGA9KWy/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 063646061D;
	Tue, 27 Oct 2026 00:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HoconBffrbJS; Tue, 27 Oct 2026 00:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 008CD605EA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793060585;
	b=Mp7CZFKWqB+1ux0ugyjXXsvxRJcfIrU+OiFlsWKhPV8d+p6ZO+xgtOGb8AEKF7n+hxoZ
	 7E4lCHDxYbxqgClEBrKJmhqgpQoZGuDdwLrN7YOphQybm0Q8H6m9GmLNzsL8vPVed575E
	 5rOfD9N4noHuINuSDd9I5HphGMiIZVe+/D34kwaoie6DjYrE7GKK06k2+OCxU64FfvB9t
	 4IxOqqOHa790jxw7NGheHbLFtKMyz9kXdR0ulffwWBNhT6+djjADFvCrmZpVFsnEMaxDQ
	 E3Ve+eKUe369cxBkSlHpIK6n46NfSKKeVPnJZa1hqeavppAkZ3Ns0u+vIIWMhrZ2QUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793060585;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fLXcrKInOmOgXIKw6+iXUgL+X5B+kQngmLzFpMDwWiA=;
	b=NtwQeP1I8pmUu6pgSjVC/01xRu2NQ9rClnUgLj4z1x70jEmopsJDC0mPfujI4cyrnDRR
	 pTJA7a0QgEhDSORyAwYPL8+s5n6Ks7Jda5z2zwW6L204JHk9Qamov0NDgFfGQmmTQqAVX
	 2QEadyVYNmrmPxpkY9j3P2WElDoBZVk8Qj2AKuF8tlzRDk4ojPSgboJ4fqQkR3mLPNBVS
	 sWjfBrJ1b8X44gall4pgdCuE+dzPpXVWGFOti3F0l+a+sXBQ+6ru0xGppvESby2qNoipt
	 ohZPq1kTB8j4O728IbFfAM/QYpHSK3ygts98fL8vgtU9VzKlRFIR/7SrF/NfOlO4+7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793060585;
	bh=fLXcrKInOmOgXIKw6+iXUgL+X5B+kQngmLzFpMDwWiA=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kQxANZnIJgp2rHWiNdOLHFhBjEFnfzvu4wTqtwk5CXUph4UxgknZrdiZgVnU87UGV
	 GoaZ00EtZwT5mNvnn6RXO/WX3B3erPl/2XcuLWa7CVC7TbP39k3k33L+s1+wbpi0LP
	 Q5tkUQCoRdiAk36mwjr88K8/nSkiixEAMDlwB4NDWUCu+0epj6wy1Lcu1hv0fg5Re7
	 TAIiQG5i1gpAl47fBaKyWd6MskCLe5aE8IEWYvCdMcvM/dySCFqAaZpQnDnp5fJhWz
	 ALdn7LLMzV0vT+4m5Da2KRPxdzJCe3eU9Is9jTIxdB7lYblbU+TMXLx7d/knVajksi
	 jg8f/uhVq/H6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 008CD605EA;
	Tue, 27 Oct 2026 00:23:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 176CD380
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F157280BCA
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rXGlSF7j8KZm for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 00:23:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 01D5080AC4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793060581;
 b=csDyJTWXHYLMeAigl64wrjiqBZPOjrDMcDjHcu0hl8tNeOW/f94tx5u3CQtvvmdSrM77
 SMWmbboS92T0ihzqkuD/monAa16vr1X9lujdly6w0/vHP6xb6N3R5/d1Pzhlsifned7oa
 tlURVGCa/HGhiuEntXT8ebI0H6lo30fzLtwI8YSQDUAiLf7TkfjJdU9JPm/5i+0Y3VYnx
 a8P0ZH4nUxOhbc5pF3DN2NMr++eJyIw7WUBNaV7sjdK6QSbFk44/az3mxzv2KQIw5C8js
 XyyoR2c9S8j7ggms4JX6v0J3EQdtRPK9ha4YCa0nIz2afcTAucg2lRFQcc5/UT4dThA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793060581;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
 bh=fLXcrKInOmOgXIKw6+iXUgL+X5B+kQngmLzFpMDwWiA=;
 b=jd/WmQCHQU44a1eEfAaMV5DvbMirc7KQ5nyxgSqi3EGdolXaotN32+PbnH7TQlzv2y2Y
 CK+RQ/T62/+0/PiDS5yXohhCTubRQxY1LHbpwL2XhWUPicUSEEhiPssYTGIIoW9N7JNM6
 Ji4iTMBdGwtswgVi0YnbD6cOdpBrRdCcE95BaVnCoprBMsv93QBtaUmr+HO/Rrn64Fnkd
 5G/LdVqnNXvUy7CGhOWCAylG9u/or8NgvrDEffGdKNj10G+BUUc29XnF7HgRADY7W6V78
 H4ccZWpnzoM2l1Ki0lVzO77uvWuLG2AEJtmgRinMYtdPA/egFD7nJFbMAAYJs9i4DbQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="eGA9KWy/"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::7;
 helo=mail-oi2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=eGA9KWy/
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01D5080AC4
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:23:00 +0000 (UTC)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4b39374fab5so1500843b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 17:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793060579; x=1793665379;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fLXcrKInOmOgXIKw6+iXUgL+X5B+kQngmLzFpMDwWiA=;
 b=eGA9KWy/wrCMisZZy0O/FalSc7sZcqlmyOgvT0Ow7t9Bpx4ACwkU1exhl2oBJMkLdm
 pbC69/Wwj42PDr5+3QOPkw33iId/lVGwdg0esgTBx/aZYU0Vspy/yIaK4O22IzyhgLCa
 DghQTdKBcTAAcUY5AgYnB8B4Jf8toFPQsUDrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793060579; x=1793665379;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fLXcrKInOmOgXIKw6+iXUgL+X5B+kQngmLzFpMDwWiA=;
 b=dXoc1iIOZq9ot/ZTJg+gYNgLK8h91fQXmxr0SI6+En2dHofuhn6i5eEzb5749FD7es
 zlcIjvfir3HPLFzG4OO4ap4tssN+iQ+HLp9laMifvb+EdLY0g1wIUujuuw60sZG6HOnG
 O9+YEkZJL5SKO6HpXuXc/Vbi6oONNHRIEkaprR/ZXbR1bcITUldnqUlRC1siqFfdcBIU
 OTZ0HsUchCbIMcxGpLJhGc+HuZ7h7d0nMLgtFbZKwVtVgen/77VQsek8ReawdAITEJmJ
 nTpK4EKxshHA64SeggY8FNnw8b9MjRYLRx1YVL3QEjBRwpynHJKBJCydLIy41aZKJhi2
 SmfQ==
X-Gm-Message-State: AFq9FYIktcbqEqnwJbB2PP6W2HLfZjJEXyw/MgmxCDOUhwnrxR16amZu
 1VPs8R9JEHmWgcWlWre0kE6P4FGqxjU78tWEvMFO6AfSzkWfi8dCPJEwnzb0ZP3u/ZQHtWUk+Js
 l1PFWMlv5VhNIuHU=
X-Gm-Gg: AYBFou0EOEQThz2WvkX7RFV9iqC1ZJ+LliGKbuHNRWAXlxs7di08Li6FZrlDNSZP7T+
 p9krGplTYCBpk7dT7gb+b6Avxrq92HhnHMPJWNmuJxYOAbGIL7Xry0+ah9Yisjby1Sd+EHsZxd3
 +u46M5Iol3r9aCKlBKcGyFUefVoaLS3iXQPewPhZcPpqo/ioVaV46E5RifziUYOBPEmf+oRApdq
 LnFViBCa372KYM5KFC94IZzNYu4HNU5stA4mexhZ+owKfe7eXBabI3a2tkPf6VsttStJ2MQHVam
 9dZbMF0huk6yubHGJAxVox+GD5bj7cNKxZCCXeYzFB9sB2s3j9/fg1hjK497PUoIHhsseDt5pBJ
 EODxSY1IfDrha+8NDq5uhGTqNDKeZZh2TlS5QVLQzWNmlnRPakQwAA9GFzTy6kmEcOLOJyznBg7
 /5yxyC6RJ3IoetOucBAT7eiFzhjBt+W229JBUbt1+6QgHhtUkkIh9YWnfXtX5d4ucTCoX4iK2Ki
 URPRZuwfzOp3SOWXj5+2DymFlGfgb67g0JaA/Tydja2T5rKwM7/u8HTWj41uFvjeYGcgZ/dYWoX
 N3UBw7OVRwN/Q3EtOJU7V/B0kqp7JvuDQtyKlKTrikdLy3dmKDKBlcELCM+tWwDOmw1SI+B1TC5
 6OhakNIHHeHug+q5SHNfBVbn+CyWsPhgxZ9GtGeOMYNFnvWSXbiwCVoMo9g==
X-Received: by 2002:a05:6808:14d2:b0:4f5:97bf:e56b with SMTP id
 5614622812f47-55c0020f4cbmr5646950b6e.17.1793060579577; 
 Mon, 26 Oct 2026 17:22:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c040806a7sm6598618b6e.2.2026.10.26.17.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 17:22:59 -0700 (PDT)
Date: Mon, 26 Oct 2026 18:22:57 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-custodians@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org
Subject: [ANN] U-Boot v2027.01-rc1 released
Message-ID: <20261027002257.GN646438@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8doyuBHv8gMpcBxy"
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--8doyuBHv8gMpcBxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out.

On the infrastructure side of things, as I noted with v2026.10, the
archives can be found at:
https://git.u-boot-project.org/u-boot/u-boot/-/releases/vRELEASE/downloads/=
u-boot-RELEASE.tar.bz2
and the .sig file as well. We can now add that we're also part of the
OSU OSL mirroring system and
https://u-boot.osuosl.org/u-boot-RELEASE.tar.bz2 (and .sig) also exist.
The mirror contains all of the old U-Boot releases from the DENX FTP
site as well. And if you need literal actual FTP, the above can be
accessed that way as well.

With that said, looking at outstanding patches, there are a few pull
requests I am expecting to get this week as well as a few more I am just
hopeful of. I think my own queue is in reasonable enough shape at the
moment, but there are a number of things that are close enough that I
might pull in before -rc2.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DNjh0Zm=
kzajgyNnZtM3FvMmM1azkzOTAxdXJfMjAyNjEwMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and since this is -rc1 we've changed links. The time of day is the same.
The meeting details itself are:
October 26th, 2026. 9am (GMT -06:00)

Video call link: https://meet.google.com/hir-pkrc-ngg
Dial: (US) +1 636-707-2454 PIN: 996 784 524#
More phone numbers: https://tel.meet/hir-pkrc-ngg?pin=3D1444832752708

In terms of a rough changelog:
- Lots of platform updates. This is always the case with -rc1 and I
  never know which ones to emphasize.
- Updated to the v7.3-dts tag for dts/upstream.
- Fixes in our USB, GPIO, DFU, bootstd, i2c, SPI, video, pylibfdt, MMC,
  optee, watchdog, EFI loader, UFS, TPM and networking subsystems /
  drivers.
- Resync some math headers with the linux kernel.
- A number of cleanups and improvements to the mkimage tool, for
  handling FIT images.
- Further work on merging the imagemap support that OpenWRT makes use
  of.

I continue to plan to do an rc release every two weeks and the final
release will be 04 January 2027.

Thanks all!

--=20
Tom

--8doyuBHv8gMpcBxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCat/u4AAKCRAr4qD1Cr/k
CtfyAQCOM5y7x4EJFRpc+WOixnTKu8Oto7isAhCBLWi1yDqsfgD/QM1mMZz7TqC3
Kdyz95KGA9Te0m9nAOrFq0KmUMT6gwY=
=U6f1
-----END PGP SIGNATURE-----

--8doyuBHv8gMpcBxy--
