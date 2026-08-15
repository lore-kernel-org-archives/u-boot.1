Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0C9C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 20:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01CED4076D;
	Sat, 15 Aug 2026 20:08:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X1ywYpefnMnw; Sat, 15 Aug 2026 20:08:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E8954077C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786824515;
	bh=w2mzd4vHm1OdE6S9Yh+0jdV2ujAdQ8SXj7/7ah27bkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xFjwArz0qTK0TdNNRoTjQrJxZ6ee2+8KoUTbrW9gGvoEWR9a2VvuGoBlxkJ2xeSG/
	 E3DVD54c/eEdRCjORZ1HISOvPT3MmVOcCSrQdDZLO5g3FD0WACvDy6EKu4OwIVEzRr
	 xshuw0x7Juqts03TEMwRgtgPQxUEWrd1j+PPRUfMicNDRbEfk+Zl8H0wtqE3iEZ5QI
	 S9YMOiPElxXp9E4nTeM1Is05/zSU6y7TnPFPfcCLtL4qBaO/kt/UXoMXQaVAf1asXy
	 IJlggY+/65cRruGp3AmF4BFCkU496nzaqhmEU0/tr9cwr5btq29JjwBYOi63gaTcP4
	 N8wBuTa8vbqFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E8954077C;
	Sat, 15 Aug 2026 20:08:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AF02C336
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 20:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A0EA680E8D
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 20:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hd40hRkcOREH for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 20:08:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2f; helo=mail-oa1-x2f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DD13580E90
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD13580E90
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=atx61WBs
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD13580E90
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 20:08:31 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4472500e25fso1295896fac.1
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786824510; x=1787429310;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w2mzd4vHm1OdE6S9Yh+0jdV2ujAdQ8SXj7/7ah27bkY=;
 b=atx61WBsHdXU7ney0uw4+ZWzzNxwE+5EBy4VoTWRiJvqzFH4iUXfT3NxNeaYey/jS/
 Vqwk8C/H9qSYT7PHg0eWhuZpPwcnjfftuGzUq6QL8XUzTi8Pl/0P1t9BtVQJgZj/0aV2
 ztonN8xILD2H9T1f4DK1zSLmOA5LlPzkxH3tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786824510; x=1787429310;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w2mzd4vHm1OdE6S9Yh+0jdV2ujAdQ8SXj7/7ah27bkY=;
 b=DQtt/EiDXtcEUPXrbjnrySai3X1Dsq8ojpTiHRCi3pt8uuBmXcxviLT/F+htaHZryH
 sU563DYXWmVF/s5yYlttLWM827sj9ITYKbqWHKl4wjTeFRek4md4W46HU2cH8RrTWYNJ
 PxR+d9gk1mY5jB4LQJ2/WgtzbuyiKVYEEkRuMulqx6GR2X3DfDmHn3LNRM0sq5gYAN3s
 d21OqzcL1EIl1mdxlFEYuDLTddhXFWYLxSLXVjvgDyn3Q024qZ3BVhy97/lxku7OMUhb
 YieOkZXhpdTODNxe6+DEaHAuiAZUhiOvzOSpKvjBEOuo95UwkozVMCC+xq939HAp9hx0
 QIBw==
X-Gm-Message-State: AOJu0YyH7dquPgwRNxx9vOBp3326C7ZfYmaMeVQKTOfTVRZvX7yPXR06
 4WuD6lRGZxPXSGWyFQyuOlL4AMELZfHQNMH9BGmLE0b9EWxsZgN38G2uGWzMvzbx9NbORqScna7
 royOdpr8=
X-Gm-Gg: AR+sD11g8KZWdtV1QEEJQ2jKD2M8JESP4Wto0+Zih9kjfG7dw+ewpqljHrwE4VYc4kU
 2fVgm3MhhhSvpXVzoOMzGqHXdt4mMAHDXPbs7U7MltiDPTi3v86U4GXT6mrrNcCFNC2XmRdCCSP
 SFHF0JYlCQUtXgcNdpNQaBC2n41lxs2z2EFBidvPLhTg54CPQI8q2gyk2iOHMUIomkhl1HnyK6c
 b4ibEz72uIseoogvkY0M7ynG+tPz+dwnpNwzACBqAGj5D1FPRTrGcYTpKalQo1ourO2Fe5/JFcN
 SXM5EoVTpmJgU/nh+ZJjktkpAfocYsf+G0xJiQvFAjO4yNuPTGJzea0nncYFHW7swcq5fTAqpyt
 D2fzORBUVthY/Bw1JQSw8lH0U5VijbP3mIz77+/lrAXVc+ohihIttePt2JhMEPgYkJpJa4T7pc2
 AoCqw5nr3b4RWiZ0cWUF4mzY/bHFxyn3X3Ga6IYXESZe6HFE1VGJIFZmPjsxMLu6EFWb/CcVJ5N
 P7NpAaKbFsGSOAvli8kBT2TQwfK9U2iBnW5Nnb07qZk34L20ETmuPevP8GEWLid6hWLJfqFJxz4
 /pn+9vEynA==
X-Received: by 2002:a05:6871:200c:b0:447:24bf:ec47 with SMTP id
 586e51a60fabf-45e92353f37mr13167189fac.10.1786824510050; 
 Sat, 15 Aug 2026 13:08:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45e8f976bfesm5760564fac.8.2026.08.15.13.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:08:29 -0700 (PDT)
Date: Sat, 15 Aug 2026 14:08:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Pranav R <pranavkasthuri@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [SECURITY] Five vulnerabilities in FIT cipher, squashfs, and
 BOOTP/DHCP handling (mainline, VERSION 2026.07 dev)
Message-ID: <20260815200827.GO3297518@bill-the-cat>
References: <CANMPf=M9ZsryW_doxe7Vrvd4atYpFgctR4e_aE6xjRZWDa3LYw@mail.gmail.com>
 <CANMPf=M-XLJuw4OM9C+xFCB03DByWvyin+_iFOMyrrSXSjqYfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HRIKLHUuIZTUhHQJ"
Content-Disposition: inline
In-Reply-To: <CANMPf=M-XLJuw4OM9C+xFCB03DByWvyin+_iFOMyrrSXSjqYfw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--HRIKLHUuIZTUhHQJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 08:44:34PM +0100, Pranav R wrote:
> Hello Team,
>=20
> I am writing to follow up on the security vulnerability report I submitted
> on July 23, 2026, regarding the five memory-safety findings in the FIT
> cipher, squashfs, and BOOTP/DHCP components.
>=20
> Could you please provide an update on your team's verification progress f=
or
> these findings? I would also appreciate any visibility you can share
> regarding the remediation timeline or planned target dates for deploying
> the corresponding patches.
>=20
> Thank you for your time and continued coordination.

I don't see the original report around, I wonder where it went.
Regardless, please see
https://docs.u-boot.org/en/latest/develop/sending_patches.html for how
to submit fixes. Thanks!

>=20
> Regards,
> Pranav Rajendran
>=20
>=20
> On Thu, Jul 23, 2026 at 11:56=E2=80=AFPM Pranav R <pranavkasthuri@gmail.c=
om> wrote:
>=20
> > Hello Team,
> > I am reporting five memory-safety vulnerabilities found during a source
> > review of the current U-Boot mainline (VERSION 2026.07, development tre=
e =E2=80=94
> > happy to confirm against a specific commit if that's useful; my checkout
> > doesn't carry git metadata).
> > All are static-analysis findings, traced end-to-end from
> > attacker-controlled input to the vulnerable operation; none have been
> > exploited against real hardware. Detailed reports with reproduction ste=
ps
> > and remediation suggestions are attached as PDFs.
> > Summary of Findings
> > *1. Heap buffer overflow (write) in FIT image AES-CBC decrypt*
> >
> >    - *Location:* lib/aes/aes-decrypt.c, lib/aes.c =E2=80=94 CONFIG_FIT_=
CIPHER
> >    - *Description:* A destination buffer is allocated to the exact
> >    ciphertext length, but the decrypt loop writes a block-size-rounded-=
up
> >    length with no alignment check, overflowing by up to 15 bytes on
> >    non-block-aligned FIT image data.
> >    - *Severity:* CVSS 3.1: 8.1 (High)
> >    - *Attachment:* U-Boot-FIT-AES-CBC-Heap-Overflow-Report.pdf
> >
> > *2. Heap out-of-bounds read via forged FIT data-size-unciphered*
> >
> >    - *Location:* boot/image-fit.c, boot/image-cipher.c =E2=80=94 CONFIG=
_FIT_CIPHER
> >    - *Description:* The post-decryption size is read from a FIT property
> >    outside the coverage of per-image hash/signature verification, and i=
s never
> >    checked against the real decrypt-buffer size.
> >    - *Severity:* CVSS 3.1: 6.8 (Medium)
> >    - *Attachment:*
> >    U-Boot-FIT-Cipher-DataSizeUnciphered-OOB-Read-Report.pdf
> >
> > *3. Heap out-of-bounds reads in squashfs sqfs_frag_lookup()*
> >
> >    - *Location:* fs/squashfs/sqfs.c =E2=80=94 CONFIG_FS_SQUASHFS
> >    - *Description:* Two independent unchecked-index issues in the same
> >    function: a fragment-table index derived from an attacker-controlled
> >    superblock field with no bound against the actual allocation, and a
> >    metadata copy bounded by a fixed constant rather than the real buffe=
r size.
> >    - *Severity:* CVSS 3.1: 7.1 (High)
> >    - *Attachment:* U-Boot-Squashfs-FragLookup-OOB-Read-Report.pdf
> >
> > *4. Heap out-of-bounds read via unchecked index in sqfs_dir_offset()*
> >
> >    - *Location:* fs/squashfs/sqfs_dir.c, fs/squashfs/sqfs.c =E2=80=94
> >    CONFIG_FS_SQUASHFS
> >    - *Description:* The function can return a negative error code or an
> >    unbounded offset; all three call sites use the return value directly=
 as an
> >    array index with no validation, including a negative-index heap unde=
rflow
> >    path.
> >    - *Severity:* CVSS 3.1: 7.1 (High)
> >    - *Attachment:* U-Boot-Squashfs-DirOffset-OOB-Read-Report.pdf
> >
> > *5. BOOTP/DHCP option parser scan window ignores received length*
> >
> >    - *Location:* net/bootp.c =E2=80=94 CONFIG_CMD_DHCP
> >    - *Description:* dhcp_packet_process_options() scans a fixed 548-byte
> >    window regardless of the actual received packet length, which is only
> >    validated down to 236 bytes. A minimal-length crafted DHCP reply cau=
ses
> >    stale receive-buffer content to be parsed as option data.
> >    - *Severity:* CVSS 3.1: 5.5 (Medium)
> >    - *Attachment:* U-Boot-BOOTP-DHCP-OptionScan-InfoLeak-Report.pdf
> >
> > Technical Context
> > Each PDF includes exact file:line anchors, the full exploit chain,
> > deterministic reproduction steps, a per-metric CVSS justification, CWE
> > mapping, and a minimal remediation suggestion.
> > I understand the project doesn't operate under NDA; I'm glad to coordin=
ate
> > on timing before any public write-up and to answer questions on any of =
the
> > above. Let me know if a different reporting channel or additional
> > recipients would be more appropriate for any of these.
> > Regards,
> > Pranav Rajendran
> >

--=20
Tom

--HRIKLHUuIZTUhHQJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaoDHNwAKCRAr4qD1Cr/k
CrPvAQCxQ+m1wBeBsqWkgq3PF2ErCFmK4RI5VXitgBUXRu8OJAEAlzYO80pa01zk
9lN6faqeLKD+TbjYmu5sAr10/NPKTgM=
=YhB6
-----END PGP SIGNATURE-----

--HRIKLHUuIZTUhHQJ--
