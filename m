Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7F4C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 22:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0ABB24082E;
	Mon, 27 Jul 2026 22:49:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 42urLXskjL8b; Mon, 27 Jul 2026 22:49:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D46D84081E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785192569;
	bh=hEXEBXS6bQJ/YoiqCYS7dpPsChnCo3mV4nIvDYmzAMI=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pVM6c7MLQVLQ3dUx+ksxGOiETVEAAoTpPnSg232HJu1LLnkC7wdeTdbv3PVerBHmR
	 0na/Tk7fvv4yl2KS1D39Zfit0rUs/O6w2JQWRv+eJM53OIW9OP/pzxKHvi8GVhabAm
	 aDThwORTK/S9N+SpQ4+ZWIsg51AUZPqm8I+V171gy/DtI6PtVeKlu3XlkoWVN17p9X
	 jOWV6m0MwRdXjeKXDv7VdmUYD4VTsZskFSB2LUL29iXLmnLc3ZrWJA3F+ivzJEMTbO
	 ZiJMFsrXiGzcjPYBiH5z31NUt5c9J965aCTm7FhBVilJvOp5cV9iYIdkZwpPX+kutO
	 OKfzAkCRXVzow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D46D84081E;
	Mon, 27 Jul 2026 22:49:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E31FA47
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 22:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C32A80E44
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 22:49:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nx3q8--99zCF for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 22:49:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7EF4D80E43
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EF4D80E43
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EF4D80E43
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 22:49:26 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6aae019c09bso1883938eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 15:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785192565; x=1785797365;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hEXEBXS6bQJ/YoiqCYS7dpPsChnCo3mV4nIvDYmzAMI=;
 b=WrQPGcWhIzkGuqUc2qc8wGKkbjviJa7AJkFz0ENWtd/p8Ldt4sZsmahBd5gYIy0Fk4
 S5wk8SBlsOQ676csF/XQdRbEoAUN+gr0mStJxbkmvl+b20Ly6nJ6yCovQrN1cxzYFxCs
 flmle0ch/q1aVmn+KhQ9f1fDw8QolYnegPQZK6MDyomLYNHx1YU4HemrCXEZ/5urq+Sd
 4ch3wycbTs2cnZ+AF7Ebj2r+S3NsG/k9wFuDuW4an4NcKrvEaH0Fv+ze5jsXXhUpG2I+
 13ptpTuK8F3gwPYC+pGE2XI5Z9To1yfud/7XDG+5mfT7eLegF4LeH8QZpch8uYZOAgY/
 D5Mg==
X-Gm-Message-State: AOJu0YwmsEMGyHd6vJzqk29yV8XE1vu9jrD9DoyXn3o1rDEEYb4PxP7+
 Fntqui8HP9C9jdDaKvHsYthnBS7D+DM0fdB38wg+dl08DuEeQd2uRD4tjQ3Q6SbYyqoEWuWfA3D
 CdR1EQH4=
X-Gm-Gg: AR+sD137aUkQQXAktisKYfsMxFdlZs62Ok1wk9IXWahWbk8bzttGb+pm1VSRh1t2CfY
 UfoNJGOah4YWg31hJHSqSyrPNFgLTMPBbkBm3Nl7gRq4gFTigAfw42J1766yN5E7HtBQCAWwASF
 IiAWCe7QbHqRrarchWAeVgvYZqizDYHyk13WLgmyYsM76Ui8+g8Xch9VR3nNX7CxmWsdEY9avwO
 fvgFEmObhM2M2J1xqLM5wbD4TBZLT5HoHqd6vVFMk7FuwlARI50/zPaE0xYN4MEz4SYlOMG3JPk
 zTTvV6FK2mFAqau+xZkt00CwJ2JO2xmA+HAyiz2RYmLq4YC1Y4w37+/idCVkTB/6Q4XJi28kcm/
 exw2bc2UFvLUKKPuD6ScuKXrjKRihqm99cjbPNNyUjJCH9bEM1g6avjOfK9KOfMt5AqDFWWFyxZ
 pS6kbrb2K7U5OmPsm4Ht+9t1DgRMT5RGimlSqDQuCIA9bZpXHlStwtR72doE6XZ1eLagSCj13eu
 oZILZuYuj07RY+qgl7PqJeBFIKrpjzFcZmbkg==
X-Received: by 2002:a05:6820:2d9b:10b0:6a1:50eb:d526 with SMTP id
 006d021491bc7-6aaffaa4171mr6336388eaf.71.1785192565236; 
 Mon, 27 Jul 2026 15:49:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6aaf93b43efsm6034096eaf.8.2026.07.27.15.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 15:49:24 -0700 (PDT)
Date: Mon, 27 Jul 2026 16:49:22 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: u-boot-custodians@lists.u-boot-project.org,
 u-boot-board-maintainers@lists.u-boot-project.org
Subject: [ANN] U-Boot v2026.10-rc1 released
Message-ID: <20260727224922.GB1188@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z33PEUCi4yqLJPAW"
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785192565; x=1785797365;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hEXEBXS6bQJ/YoiqCYS7dpPsChnCo3mV4nIvDYmzAMI=;
 b=WTjeYAIYvNkVrsNsX9nZn4BFi5CBFGSShNijoXXyf3jE9fR20HBHvc97QwPqOLe92a
 Z1x+kFzLtx6d5t66S0DgrPhypbc+SjZ6S3E6CD8amLFCc5s3BSS+KNt4cOf+lsJhl3rG
 Fi6Z5gTlbrVzP7I2oToJd7ei5ZXQK4j2uLwss=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WTjeYAIY
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--z33PEUCi4yqLJPAW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out.

Talking about the big general things first. Our migration from
lists.denx.de to lists.u-boot-project.org is done. Our archives here are
stable and complete. Please make sure to update any aliases that you
have pointing at the old server as we will be turning off redirection at
some point in the future. Not immediately of course.

With that however, we've stumbled in to another problem. For the moment,
we're not being archived on lore.kernel.org. They're aware, we're on the
TODO list, but since we're not actual linux kernel infrastructure I
gather we've not yet made it to the top of the pile. Our patchwork was
out of sync for less than a day, and the backlog has been filled, with
hopefully no reviews dropped. But some may have. We are archived on
https://marc.info/ and I'm not sure there's much of a missed window
there. While that site does offer lookup via messagae-id, I've not been
able to make b4 work with it.

We've also at this point now, moved over to Gitlab being on
https://git.u-boot-project.org and we're now using the "main" branch.

And on this note, while the FTP server hasn't gone away yet, we're going
to try using releases in Gitlab. The source code as an archive can now
be found at https://git.u-boot-project.org/u-boot/u-boot/-/releases/

All of this means that from my own queue, there's probably a few more
things I need to bring in, that I haven't yet. I suspect other
custodians are in the same spot.

Oh, and we're still on v7.0-dts, and haven't moved to v7.1-dts. I will
be doing that finally, shortly. There were a few fixup patches I had to
do which I think are right, but never got a review on. I don't want to
hold things up forever on them however, so we'll get moving forward.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DZ2IwbH=
R2NjZhMzZkOThqNHJoc2sxZG04MzJfMjAyNjA3MjhUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
July 28th, 2025. 9am (GMT -06:00)

To join by phone:
Or dial: (US) +1 929-277-5781 PIN: 115 674 167
More phone numbers: https://tel.meet/jwj-pqka-bnj?pin=3D2145803234090

In terms of a rough changelog:
- Lots of platform updates. This is always the case with -rc1 and I
  never know which ones to emphasize.
- Fixes in our squashfs, USB, i3c, FIT image handling, EFI loader, MMC,
  BTRFS, i2c, UBI, PCI, DFU, Watchdog, and etworking subsystems /
  drivers.
- Assorted code cleanups and robustness in various commands.

I continue to plan to do an rc release every two weeks and the final
release will be 05 October 2026.

Thanks all!

--=20
Tom

--z33PEUCi4yqLJPAW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamfgcgAKCRAr4qD1Cr/k
CgDmAQDRtOjmfatttlPQQR+EwfAhJ89FlA7vB33Dr9QCqMZ13AD/ehRXps0Fnr7O
yPhw9Gg3pyA/MsDV1/h3or546gAaEw8=
=STQX
-----END PGP SIGNATURE-----

--z33PEUCi4yqLJPAW--
