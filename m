Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94540C5DF9C
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 00:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57F3180AC8;
	Tue, 25 Aug 2026 00:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 65sfnRWU_bVn; Tue, 25 Aug 2026 00:49:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787618964;
	bh=+wEriLEvSbGVi+CxSmnYe/AuPW/kCTiyXC6IWcbEcjs=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UlZNkcRgndgNm/l7dD0umd5kZqJOA1B+qIC+R2WuNNL/DedhGWU3ITBV1hTMrGxba
	 ybt0UHDOPUy3ETBsj3jiolqaUa/lKvEkvb+XTxpbvFMgFfXgdGjjnncaZyXNa+HAU0
	 KlL3pbrVre5ze/Jp7XbUH/zFOHToeVAohmTUnBHXn/6sqQvGZUcdId3Lvva3eY1iiz
	 thMwcP+aDau/8yL+4caSisJvW7V+yaNG8vn2LXAKMdTM3NLOK09cJ5mwu6D+hM1hKV
	 0NM45Xp5RaBJCj6S1EzE47LtuSluQ2+hJkFkktOR3T6vzZf3zKm75yDo+b41TLZ8oq
	 8YpsoqqPQwhSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6414080B00;
	Tue, 25 Aug 2026 00:49:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2FA59279
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21779400D1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:49:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4uoeW-AWrH7N for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 00:49:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=sVLKMV45
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2022C40050
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 00:49:20 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-4569f25c19dso1454219fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 17:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787618959; x=1788223759;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+wEriLEvSbGVi+CxSmnYe/AuPW/kCTiyXC6IWcbEcjs=;
 b=sVLKMV45Gg/y4nTENRVt7I2wr+iCPuA9syAZWilD9ms/abRrsiviS1CrHQo78SC/2Z
 uX/Jy5N/e9NDZlhKO02EGvD+iYaQJcRxTKHucIWbc4tNOs+BDSIUPqUi3ZSyjT5JFJec
 0JlKeNVm/VIECEDGPCWIuSLGqsbeXqGqpvkYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787618959; x=1788223759;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+wEriLEvSbGVi+CxSmnYe/AuPW/kCTiyXC6IWcbEcjs=;
 b=MYhZrBhvlgxwX+fCNJynRNJsUmRG+kusdTryESNpObbfdZcYCCgxrjyWj8vTFtNYfh
 JMkXswKBImGuRVFihMMWMiCzIDmUCs7QmDjVYVFAW1zB/sm3akkyOrykare+6yx9z698
 bhGF2RhGGthvkGO7+qNY+LNR1ywFWjnXrmdzuYAVNs4LkDWCL7X/Scx7ekM6zXhn3pWw
 ggtPfvVrGD+odi3v7YjbokollbCBD7nuRSEr+zMMNco/5utZ9HUq/rKHfElh61kWrOxP
 cXF3sh0QCIfvq4fcIQdypmIIzSxT5q0On+00E+/EVLHcIGFFmUYlDLzqhEdUBeC+5eLC
 alGA==
X-Gm-Message-State: AFuF++kRdvG/O3QduKlceLYPcDWq39eLptZtGq4TT1MvchuafqO29xzn
 jGhcZ/7o1BlCk2d/FQtL2RM8QypwAFVmC7a9dBTaxLCIeiCSJ+ZcqzVcYmO77wNHgatVTBj3Rym
 y1UVcfksE5xF50SY=
X-Gm-Gg: AR+sD102u79+GV4bDPnw/AA+FIIwPe0JSWFiylc5TKu8MhM6kQrQMZvdmO+t6lkHpbD
 c/figf7lPbNSAapgpBJFiS2jLGvb6Ag/Pf0OzyaZl1CZBEcr3D1bjAqqFirapbodJd+RRPBxB6j
 ODQUdg+3VGSvvmnM8pGb9dioMhzZHZy3eml5/Y/R41ZCNRtek1mbAcbZCEtD8jyFUDbweqTlIpD
 GUKzFleTNbhAwWggvrEo4cRg5pJbDndWdD043DITMx6YJmS9ElqIiOy7V9ZMI0kcZWQkbAISnNg
 +drYiBvMM7wMERse/5vrZfmDQpjRwbp2f9EM/62JI2un+k08MKvIdssGtyspuuT7SnZxkl/CIYO
 /G6cr7LIgvEV53xvOCRIJII69X11UKoL8onXzkI7hfS/ZV8mo1zh9mb9rwOxGy1oaB/2zFIP96T
 DIczsjjx7lgMkfhN2Xtt6AROv/XNGiBJKlRaiBixt0siZLA/tQ5mSZTmO763JqJiaNcVd3lMf93
 nhMowT0lWUireTZcV/BsvMvskDRSd+xgYn+ihHGlbee4dsDn6FvselPvwXnKE9iUJ1dcVd46KHW
 tzFo7oBPwbnXdJe4xmWR
X-Received: by 2002:a05:6820:161f:b0:6b1:3ec0:6090 with SMTP id
 006d021491bc7-6b19038590dmr2085634eaf.11.1787618959429; 
 Mon, 24 Aug 2026 17:49:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-463835bcdcbsm6281693fac.18.2026.08.24.17.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:49:18 -0700 (PDT)
Date: Mon, 24 Aug 2026 18:49:16 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-custodians@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org
Subject: [ANN] U-Boot v2026.10-rc3 released
Message-ID: <20260825004916.GP523975@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qVXxgcWEzUODZ7MG"
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


--qVXxgcWEzUODZ7MG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out.

We're now up to -rc3 and I'll be testing merging that to -next and
updating it shortly. Since -rc2 we've had a few more DMARC/DKIM things
fixed for the mailing lists and I think we really should have everything
on-par with how they were on the old server now, thanks for your
patience. And again, our gitlab has moved so, the git tag has been
pushed to
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
August 25th, 2026. 9am (GMT -06:00)

To join by phone:
Or dial: (US) +1 929-277-5781 PIN: 115 674 167
More phone numbers: https://tel.meet/jwj-pqka-bnj?pin=3D2145803234090

In terms of a rough changelog:
- Platform updates for sc59x, Renesas R-Car, Rockchip, Xilinx and QorIQ.
- Fixes in our DFU and Networking subsystems.
- Fixes for the spurious ERROR messages when booting on some platforms,
  with respect to reserved memory areas. If you're still seeing this
  regression please reach out.
- Fixes for a corner-case with gunzip that caused random CI failures.

I continue to plan to do an rc release every two weeks and the final
release will be 05 October 2026.

Thanks all!

--=20
Tom

--qVXxgcWEzUODZ7MG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaozmjAAKCRAr4qD1Cr/k
ChCjAQDZ+JXEoKP43tkGjWVM+T3ZZUJHd8qqliwJhPSMc5zqYQD/edVVSADV+6Og
XsmDxwMT2HM/EPR5DzsKfxonPEO6lgA=
=IbQd
-----END PGP SIGNATURE-----

--qVXxgcWEzUODZ7MG--
