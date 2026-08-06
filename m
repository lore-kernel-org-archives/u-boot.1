Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE83C5AC7A
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 234856084F;
	Thu,  6 Aug 2026 21:16:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id arPL2wp-HZBp; Thu,  6 Aug 2026 21:16:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 428146083F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050990;
	bh=KX16Bc/JelbZ7sem5okcPufspG/buUuOlkfjoczhV8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z6+AXEnv1KEQONJln7zGi5X3jsrBGBkwYeHraWKTFLnaAHgG+pmvJNRTZ6vbLjC84
	 NRoVuoKI6lz+M3d7ERkQMOkW9H4p3XC13PxHmmMf0gvPjOUUwFE9X4lG1lZnTAKcok
	 +Z2t94Sjet9ifuT7WKMitPgY9feIKBebBhwxVdqd7hzd+eURKGmnqDglB6lQduDwgb
	 Tvh5/dXjfyXjulX4np4yGnmeyus2+6w4XVFRueIp1o/mmCxquN90xaN4o59juCKysk
	 VDZHZn5eo0x95/q4epnL4upRmK/vagsaa+UfssPKCHEcDUF6+GJ/cxLDPoB4LD5nE+
	 wxdzoPFC6/JUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 428146083F;
	Thu,  6 Aug 2026 21:16:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00D05198
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E72B96083F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-jcFFUSS0M9 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:16:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E8FEB6083E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8FEB6083E
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E8FEB6083E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:16:27 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7f0167e59a3so1520685a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050987; x=1786655787;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KX16Bc/JelbZ7sem5okcPufspG/buUuOlkfjoczhV8M=;
 b=dDvinMTzEIvVOI3p/G9ZyXH2ELFnfLL22NiFYlNR2brS633skKEAscFv9zlCRMWgQ9
 VGA+PCQd2jliwsKBmY+fIUWLhxCHPFveZ11U1ESiYuN98VlBFSxwvj9bwGpG/6ierIYl
 X5WR0ln2ke9Om0drhMVUWhjL40R2ecGGSdN/ZijybO66d9ilVo0pwo7uT1jU9s3gC7uc
 5WwKFrqpjKNwIXrnfnIJ27voQkoA0Oydy59vxRTo2ADS1DDfU50BqVvLZUnkDxKlKsXw
 V3XKEUr62OFUyjesm8xvd72Mof+SXnh4keJusCPAsHQcdOMckCFnrzfT/rtud2QN9lNW
 nqsQ==
X-Gm-Message-State: AOJu0Ywbye5+DbKWFyqUTCDzNdG1mnV/HJEcS25XMt14sVTbKAJHTwh8
 bKtlc9SNb5AtmwyPXcAb9Y6wpGxsRtJLJx/+X6N9hqZo5fFYD5E9bizzExcsyjHdGwM=
X-Gm-Gg: AR+sD10GP03PkBevdaTkaXaPuvznK/2HmMSBnp7/N+v2sQW8i0HAtBu+jebl6b78OYr
 8UeAdADDuB/qe0g3otV4g/FFKHKyljPLQCpNgCM0J1/Txq8IJafZ2t3aU42Su1UXQgVRe2uQ/4P
 fYXI46JXv6MiLXP+DmWI+1fD0HQdpq50FCfzrjDnx8p8eC3/QW+70OI+BxVT+GBDATdyR3JDwtX
 0M28ofgq5be2vTA7JQJXikNoH76EVJWx41up0knRi2afOOg/wNXNmKbpWVhXksPW69vtL/RRa5m
 8cOcreCa0/TBZ7pQyFb7m4fecUr6mkn8XXyqN5W1kZydqhtFVsmcr6b+oL0mTE+n0orZS5PvoLH
 gB9ImLC50BsRPaN7hm6Opx+D+3C146ja21LB8POofUojyAEkcLbmD0/NJe3JDqMYpipe0jLa6oS
 qyRL6jBAjc1QYCKe+pXE+gbtk0YTBAV8cr4EJX6ekAnTccbHKeTn4WhoySQMu2t/km54ElIJ59N
 1Zw6bVBhobeis2jI+t3vFPCe2J+NQlq2xFMyCq+061+yi2CS4duVB8i3wDjv6hQaIuKj6pIHfJH
 vy/cdTXtxA==
X-Received: by 2002:a05:6830:6102:b0:7e6:cfd0:42de with SMTP id
 46e09a7af769-7f1e5ee5d2dmr12122679a34.15.1786050986745; 
 Thu, 06 Aug 2026 14:16:26 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f1df30117dsm5076427a34.1.2026.08.06.14.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 14:16:25 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:16:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Esteban Alba <estebancalba@gmail.com>
Cc: u-boot@lists.u-boot-project.org, jerome.forissier@arm.com
Subject: Re: [SECURITY] U-Boot: unvalidated IPv6 UDP length in
 net_ip6_handler() yields pre-auth OOB write / RCE via the DHCPv6 client
 (net/net6.c, net/dhcpv6.c)
Message-ID: <20260806211624.GB180789@bill-the-cat>
References: <CAADTiPDyp85-3jKCgReF=asuzcE9557n38YK_Opi9Y=YeAzJPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E+WKr+gnzBpIra/k"
Content-Disposition: inline
In-Reply-To: <CAADTiPDyp85-3jKCgReF=asuzcE9557n38YK_Opi9Y=YeAzJPA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786050987; x=1786655787;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KX16Bc/JelbZ7sem5okcPufspG/buUuOlkfjoczhV8M=;
 b=OG8zPjqPrsBZ270+j1kHi8Aw9keC9DqlzzgElnMpEHeNAYyD1bvLCdy13tSz1eCl7q
 1HH7czJXYkfRh6ZNCAhGZl2S2tbgF9cENTkGcEEKB5Yh0LImJsruHr58jI4V/2fmNNRf
 nOgA7p2Xz2CdRaM97sqKMjGnSL8OTF/UlV4Gs=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OG8zPjqP
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


--E+WKr+gnzBpIra/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2026 at 05:22:32PM -0500, Esteban Alba wrote:

> Hi,
>=20
> There is a pre-authentication out-of-bounds write in the IPv6 receive
> path, reachable from a single link-local DHCPv6 ADVERTISE.
> net_ip6_handler() (net/net6.c:426, :442) passes the wire-supplied UDP
> length to the DHCPv6 client without checking it against the number of
> bytes actually received.
> The client then acts on that length: dhcp6_send_request_packet()
> (net/dhcpv6.c:244) copies an attacker-declared number of bytes past
> the net_pkt_buf transmit buffer.
> When the copy overruns onto the push_packet function pointer
> (net/net.c:1201), U-Boot calls it on the next received frame, which
> runs that frame's bytes as a command line via run_command().
> The result is pre-authentication remote code execution in the bootloader.
> CVSS 3.1: AV:A/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H (8.8).
>=20
> I reproduced this two ways:
>   - QEMU qemu_arm64 over virtio-net: an injected command (e.g. "echo
> ...") runs and prints on the console.
>   - Physical Raspberry Pi 4 (bcmgenet): the same ADVERTISE redirects
> the program counter to the planted run_command address. The
> Synchronous-Abort elr equals the injected value.
>=20
> A device that netboots over DHCPv6 is reached over the network alone,
> with no credentials and no user interaction.
> The IPv4 path already does the length reconciliation the IPv6 path is
> missing (net/net.c:1303, :1379). The fix is to port those checks to
> net_ip6_handler(); a suggested patch is in the attached write-up.
>=20
> Attached is a self-contained proof of concept: build and run
> instructions, the exploit, the controls, and console transcripts.
> (AI was used to automate the identification of this vuln, but I've
> confirmed the results manually)

As I just replied to someone else, it's much more valuable to work on
addressing the issue and following
https://docs.u-boot.org/en/latest/develop/sending_patches.html to submit
the fix, than it is to just generate a report, thanks.

--=20
Tom

--E+WKr+gnzBpIra/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanT5pwAKCRAr4qD1Cr/k
CohiAPwMLBVcESwzmX6vuR2P1fAOe5z2u6z8Z/zA95ZSqz4LjQD/fUyUMz++wbIa
/ZHT5dU3vkuCQ8qW67/DtP9vz1lexQ0=
=HA74
-----END PGP SIGNATURE-----

--E+WKr+gnzBpIra/k--
