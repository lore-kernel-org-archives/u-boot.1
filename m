Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F63BC79FA0
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 20:10:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B314C40526;
	Mon,  7 Sep 2026 20:10:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VHS_KMGfhADz; Mon,  7 Sep 2026 20:10:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A738940518
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788811849;
	b=HfzZXm2YBN0UwiljYJZoV8iPjwf4BJZWNv6nigKsd25AUGgYJZtapiFY3HdngIuhGHuM
	 8rQLG7no9+KaxE32rkagtZa4y03/sjY4KWTWw3bcPvg7X4rStMdQLDzNLsWp6SlmqC8zS
	 0tYpftYhHWrSC8DFBaK42hTHu/aYN0isxw5Jtku5LtYoDYBPattyHFznR3UbiQ+gy3n2o
	 XkNJSClauGQQUz3EJs7m/nnOaSRMGg2ULLoZ5qpqJuJPEYZWfEhzKWOFt6X5JfMG43BPe
	 v0sU1Xvj08AqoxPJ2Q6Xl1J/4B44DBmDBsvKMhLif8DnfBv0DiQCxSIhp2iQE1OlkyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788811849;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ly+gCrrb7lW/Xc6s1+yogmMAUcZYzSbzHXb8M0ObqBs=;
	b=FN0P9owtC9jfYLl58mZkx6NwC4h/aN1VZ8eEsqp5IGMDTy1mZwFAslFvi/oV4OraMg2s
	 lP9gI9xoGPBUVQVswxqJgnPKFXMbNK6nBNJc8uegmfqDePb3EBIZT1gD0WpMnpxvKGyvy
	 nv0dNodHzg3/A2aZwCSoXWOz5Zebp59y39NQcBCngSnQgfRnAV6PUHJFhinSeWL41pWj/
	 jBygvqxJHmwOs+VbIFprLVOPpAnqIu7wevhH4DH+c3mU+Cr3qknCC5XsiIcJKBEVqxC1C
	 BE/twgNiUCokvRqArwS/RlFF/IfSVmK2W0IbpBPSBg4HktpZs3OvJOQkCBhZG+QIywg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788811849;
	bh=Ly+gCrrb7lW/Xc6s1+yogmMAUcZYzSbzHXb8M0ObqBs=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NbCvJAhOjUxzc5XO4SeCVc+DesCnMv1sgtW/RoKg4gSNxV3KeB+3EypkFcqJojFtH
	 GZ25kjo2CZRsVowwnN11kYMUnlidDnD0z3qXe+DmcMUNgr97InjA49Y45y1gnj03t2
	 fjnYzj73H2AU2johzpcTgvmxI5pfJPnUcRpzDEQZLCPtcYudsU+XvHd2N9Ues4vvS2
	 FGTvOrRroUnR7Z9yAykSHkn35ZHpBSi60WnTwJ6G4+7MsHm8ddR5knNMA7fFn5JWQ2
	 GlDIwZGMuv7kG9jnndlfb1SrEMSizkzfcMVTcnHHxuXUNYszy9bpSOmhHqqFYRWttf
	 iSJ6TYzUWvZhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A738940518;
	Mon,  7 Sep 2026 20:10:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A243634E
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 20:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 87F0960675
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 20:10:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wh6KKIaenaHB for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 20:10:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8ADDB60662
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788811847;
 b=HokAnP3aYvZH5cteOl15kGAbm+08sDypvcN8ThCc14U4VR5Q/JsPru9xSG6AzTE55HLM
 o4vfcJkI4qNZVC71WHcxf2wxwBGlUShIPmeQC1u422gKAvXV9zysguw72uiQCSgTScPMk
 JzVizxRb/8dF5RDlT9jC7I9EFKjO+h6Cal3DMRnVh0TuD3cdRXpQgY4yUgr2lMLdvkNSf
 Ixmr8Lb3wu1PAjhbP+iJrkaiuaIBnkWwKlkKDkbTbI7eYMkXE0EyuWjv1qi+V3IX3pU0U
 IdNSVr34AfbMyFno2s00dL8Yu4FjHFJi9aU+ye0GyS+FCSsonJNzC7LVds9NLc3l+BA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788811847;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
 bh=Ly+gCrrb7lW/Xc6s1+yogmMAUcZYzSbzHXb8M0ObqBs=;
 b=IMqHB6XfoeLsVdmaBxgVK5Z7fGFbqjMWLSsEmNkcd/ywXbqEd6FQP7rBNcL2aTvwWN6I
 k2dMeh+ozsgrN0ATZ2NteI0bPbybn4ymQ4dygTtGtcwjLfGCxchkqGfxCJ2IQviWQBcbN
 HUakgJamxxJuMKKVfaDUx2DFjHsWDNgB9gUqYulGO0bQ7ab2lRUWXNOrEynEYDPf+xbRG
 Q5preygYhJjda7xzPXQYqVoaaIF1Dn8GOfEfsA6ZyNd7MnJECtDayYlg557Kn5i4HtzTg
 I8Dpx+9EtfhDLMKOuiwgYjEhgiKggZKZYxRXtVdgcaOCLdZAb4YhlOFK54nMsijT7zw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dl0nXhNs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=dl0nXhNs
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8ADDB60662
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 20:10:47 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-7edccf768b0so1059521a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788811846; x=1789416646;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ly+gCrrb7lW/Xc6s1+yogmMAUcZYzSbzHXb8M0ObqBs=;
 b=dl0nXhNs+DqamIm03C0Xn+VCR1voMZrjI8F0BHPqaq9yn8MZLKsi1ddLwC1ntMdgve
 KyVVLFzZVX4NWG9a+8hGqmOscf2EaiDhEc69Scgx1eiNuHMrU8zBKObnpqC/fksMauDb
 PA2+P1u9Wp0KKog0eRam9Xc5IU0t3CdUy88fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788811846; x=1789416646;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ly+gCrrb7lW/Xc6s1+yogmMAUcZYzSbzHXb8M0ObqBs=;
 b=Ezt9SP4tQCimHvSoamA+ZJmgF5ZRqIA3b8W2LF8HC6PoUChZttciFGAXGuyP6LEJBk
 h0yWJH3XWpLsfmwN4uL+siuRx4tzspZMrPDvYOKsKnDWOCaUeVcVH7/wPTtrngLcSYGz
 gO0882LiV+c+IvY7WM6Abl6N8EE8WFqO4sHtNfUZYenoYlJzwrQZA1sh+7TIfvUhDJwe
 5js85RzdVGWE+kwUkbFVHzC+QC5b4DAfK4Uyi6T1E2qXwodiUYGb0Zc3ee5K2EMMosji
 j+nJ9jMobo0ufLLI4FmTk1iudtkJR1/fJFjzvuoZeQ/CE7D0HRHBC7efR9T7kMqSDrxT
 r+Bw==
X-Gm-Message-State: AFuF++n1f7gZgN//JWo2Pl/ci3fB1J4l+hiPdsZR/t0wfcZVeKTkRWq8
 Im+zh9z3t65keQljgY9r5ahoDzICh1gthypDq03wvrRmUBHJ3kedZDZReayewwPtT93wzfqNzYa
 BH6RLt2c/zusI0kc=
X-Gm-Gg: AYBFou2x5TVmaY8AuxcZmFpVB8jxNVaSPFatjHvF8JnAjMqoWRXBUyR7gGKoPRFfyzn
 gY57emqR4VoZEmzt7Q7B9usdv2S/D/fqtOaboLSnuQpWX9RIGvntZCe++daYdaSmOCB12gK4yJG
 Fj3Dl5z5nwqCmH3mbzuQkpAJYHvzyOWtwuc7GKXX49TKgZKqRNjKN4QmsJAJjROgLeAu06qTiLh
 hEkeRidIReLIleK0NJ1+SIQR97pJVBpIXn+uEwK5aFJterIPPmw5EYjV8iD+9QIgOWf7nOaQHPF
 cggtSLj+Dixbs5mbwRh3TthZxGEe061l+meoaIy97iOrF9UngKalgQccn2XoKEf9WEEf1DK6rWo
 Vp73vF9aeREVyZCG33P8yImMOHnq2mQIBpRaPJeEWPZYoT4fLAeQyBpQgSUFlHWsS8AvhwiNGha
 G4GBcHhH6WMwpFYkeP837f9OHehvI7u5mKbPv+AyboU/M2+DtVR4hPzqHs9PjzBYrY7fdnKZC+0
 v/U/NNHMi+jXOmCikD35FQxHRz+AT1r8Vo21UlwzCIrDDvWe47DuyWdfhKnV1XmcwY8rdOtuPFl
 TqKGdz0bdSU=
X-Received: by 2002:a05:6820:2229:b0:6b1:a11a:eeaf with SMTP id
 006d021491bc7-6b6fb7d60b9mr14708640eaf.13.1788811846030; 
 Mon, 07 Sep 2026 13:10:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475543fcaa9sm9543715fac.7.2026.09.07.13.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:10:45 -0700 (PDT)
Date: Mon, 7 Sep 2026 14:10:43 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-custodians@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org
Subject: [ANN] U-Boot v2026.10-rc4 released
Message-ID: <20260907201043.GB1764417@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/M5/d2q/vm/Bvg8V"
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


--/M5/d2q/vm/Bvg8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out.

First up, the next stage of the infrastructure migration is in progress.
We've shut down the old lists.denx.de server (and thanks again to
everyone involved in keeping that up for so long). We also now have
https://source.denx.de/u-boot redirecting to
https://git.u-boot-project.org/u-boot. If you still need a user account
on the new server, and don't have one yet, please sign up soon, we
should be moving from open registration to closed registration (there's
already a few spam signups in the pending queue). And please note that
you don't need an account general access and at this time we are not
planning to move to a web pull request model for changes.

So, the git tag has been pushed to
https://git.u-boot-project.org/u-boot/u-boot and the release itself is
also under https://git.u-boot-project.org/u-boot/u-boot/-/releases/

At this point, the next branch is now also open.

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
September 8th, 2026. 9am (GMT -06:00)

To join by phone:
Or dial: (US) +1 929-277-5781 PIN: 115 674 167
More phone numbers: https://tel.meet/jwj-pqka-bnj?pin=3D2145803234090

In terms of a rough changelog:
- Platform updates for Marvell, NXP Layerscape/QorIQ, i.MX, AMD/Xilinx,
  Renesas R-Car, Rockchip and STM32.
- Fixes in our Documentation, EFI Loader, FPGA, DFU and Networking
  subsystems / drivers.
- A few other assorted bug fixes / hardenings.

We should have one final rc release in two week, prior to the final
release on 05 October 2026.

Thanks all!

--=20
Tom

--/M5/d2q/vm/Bvg8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCap8aQgAKCRAr4qD1Cr/k
CmC5AP9wCmENJoNCIkDhZra7JLJ8VY8Ov/823h5/hU97+fkwAQEA7zlNw6Pbqmku
x+EQeRuLSLzDve9F3s1627vhW3tQ8go=
=oW3y
-----END PGP SIGNATURE-----

--/M5/d2q/vm/Bvg8V--
