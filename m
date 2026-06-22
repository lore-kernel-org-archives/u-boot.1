Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09519CDB46F
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 22:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69004849C5;
	Tue, 23 Jun 2026 00:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gi1FxPhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513CF849CE; Tue, 23 Jun 2026 00:23:32 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD4CA848EB
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 00:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a0b1edbe32so3925778eaf.1
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782167008; x=1782771808; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nhQ8Uf27nhVc5IaW2NHfYylbjpAM4vbI0ObBMIEriuU=;
 b=gi1FxPhjKsPIB0RByGyIKjGfG/bMCXKuE0D630AM01JTi0ZW9gR9YUDuzNaezeJxCL
 eNmb2gn4WYkHQU+2s7TKkwwDxAZZ+xCLYADCA8RURHq5VPL3zKn0NUW2vYpsqx7MRpIo
 VIgS0mj9rY32SRzCY8sB8RqwXu6SkZouPiWQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167008; x=1782771808;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nhQ8Uf27nhVc5IaW2NHfYylbjpAM4vbI0ObBMIEriuU=;
 b=n4KhDt2pMYkSW+n+xQnTeiFfxYReKOuwUcL7SWlNaP95d4q6TjVZRIy47pqjPnVXAR
 9mNfr6e0v9BiAlgPipw68qpy1qP4Q329jjgmNg3xdS1jmzpUop4ArBQSV+c/xMWX+LwK
 xuZ5tqDATNnGi70iG2ylu57dZ+ja7fAS97KWyOm3+imGKbG+Sn+aIRVihPyfnmIRxoGR
 85v8/hk3+HMDuvHHJ8+7cDKCNxaPIabJPu7S6stCT5ZAAvZw9E0br8nLCq/xbKgmG2+0
 5krJAf70c7ohWJXypmKx1h0MpNcHco/kyQWySNF8xISNiyNCm71mABVkmSmk2sblF0Np
 Aqgw==
X-Gm-Message-State: AOJu0YxMn/iLS1fTLMzm0J+YfQAzxP/qn0uQd0MXzum4HgEmhHKN66we
 8Hq5lyj9Xys156f9RdBG5/C37qJ+r+umLpVQvM53ckX0h5m4WwlvaTKsVSu9RzDjyN5+Yff7O0L
 ai67w2HA=
X-Gm-Gg: AfdE7clMEwOLFyaOgQeayAUD2GEDSZEvwscV4cubkwP9CkZ1X/6Hk5uglJS7kX6TKoa
 iRLaBO2+V76cXXLDUP03Ch3iDbAH5+a2Tu+vgt14czl9O9KBOVq/7VifvYqjiztQSAMVGc3o1sp
 R6WQuAwcFk4vccxai9Qz/07AX+XRi106qISVTtMVuAQLuaAC4601tvQ5Oi5NdbTsULzWiY6PuG1
 RwWBfjbIsuMDdWx3nZ6ovoCe6xUN8kb8y9dGR/a/UUmmWkKuVt3zTepcdKZfg+IsRWRzugsCeG+
 7al0ZKh6l0CF2iEVPqATpuBGyTrUPbTcBj5pP3KL6XG6so6hIKvuxAQxrPsJ82+kTyowXysGdKp
 q1lzr6sydZWRk6jYs2SMMdwpoBgvuVy6YDz2R5d21GzcL/qdkeRqlxfTqo385Zcvmp+KlQks3st
 O5fKS+tU97luj0ty00zFp90Dn/HJiV2DI0CYXcsVBuTUwZFbpW6E/lEAYmiTWxy2tqzpvUe3Al3
 G40jDuGmBKNq8uvoZbFLyV25XNX0UM3tdU=
X-Received: by 2002:a05:6820:4b93:b0:69e:158c:8998 with SMTP id
 006d021491bc7-6a114c71b35mr360047eaf.38.1782167008633; 
 Mon, 22 Jun 2026 15:23:28 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-245.totalplay.net.
 [187.191.8.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0ea0c378csm5443910eaf.10.2026.06.22.15.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:23:28 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:23:26 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.07-rc5 released
Message-ID: <20260622222326.GE382693@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Legz1ZRVcM1neoX0"
Content-Disposition: inline
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


--Legz1ZRVcM1neoX0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out.

As I've said in the last few -rc emails, we're working with OSU OSL to
migrate our existing infrastructure. At this point I want to announce
that https://lists.u-boot-project.org/mailman/listinfo is up with a test
migration. Subscribers have been moved, archives are re-created. We
expect to announce a cut-over period this week. That will mean a short
pause in emails as we stop the current instance, archive and copy it
over, then start the new one. There's coordination to be done, and more
details will be provided once we know them.

Once again, the delta between -rc4 and -rc5 overall is fine, even if
diffstat says it's much larger. This is because we've pulled in a few
isolated but large changes.  If there are fixes people know to be
outstanding and haven't been applied yet, please reach out and let me
know. We are running out of time.

To repeat what I said in rc2 (and will keep repeating) is that it might
really be time to retire support for running our tools on Windows under
MSYS, rather than something like WSL. The move to support more modern
OpenSSL versions has hit a lack of support problem in MSYS[2].

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMHYzYz=
Q1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/yyx-dsaj-iwr
June 23rd, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/yyx-dsaj-iwr?pin=3D7760044274127&hs=3D1

In terms of a rough changelog:
- Platform fixes for Rockchip, Microchip, TI K3, Qualcomm, Renesas,
  i.MX and x86 Edison.
- Fixes in our documentation, EFI Loader and USB subsystems.

We now have one final RC, in two weeks time, before the final release on
06 July 2026.

Thanks all!

[1]: https://lore.kernel.org/u-boot/20260511174116.GJ1858239@bill-the-cat/
[2]: https://lore.kernel.org/u-boot/ae_KfGqNrsWZ1rfQ@daedalus/

--=20
Tom

--Legz1ZRVcM1neoX0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajm13QAKCRAr4qD1Cr/k
Crh9AQCQf1Ib3hSlJTs5dqoGWAV0Q8slv46m3uWUQjVBy60SLQEA2yS8TwsThovL
JPiveGMwpMCPb+UVEBgjAGl1NnpiIg0=
=UfoO
-----END PGP SIGNATURE-----

--Legz1ZRVcM1neoX0--
