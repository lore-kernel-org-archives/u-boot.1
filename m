Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A0CC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 23:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA1D82E52;
	Tue, 15 Jul 2025 01:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oZmGEfmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F7982F00; Tue, 15 Jul 2025 01:29:09 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7BD782E37
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 01:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-613b02e801aso2463505eaf.2
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752535745; x=1753140545; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c48r+zr5rW8M0i2R3tr/EH/YmRUsnJ/owlk1VeQft8E=;
 b=oZmGEfmVV37eBktifAoIA84/u6kjOYWLukA5c2xyKVJ3YdQz6tg5YCCNS2xc6N8eRs
 XFwU1fX3mmz2deYEf1heLdo3Csd8OCV3IrXTAImdbZzltf0UFVfg9s3/lqo5XKxjE4lg
 KR+pIuWEa/rRYTLrr041thVpAOSkeDg9D5/5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752535745; x=1753140545;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c48r+zr5rW8M0i2R3tr/EH/YmRUsnJ/owlk1VeQft8E=;
 b=oip30ksBKDj/VgFNyMMFxQWjI4xgu682lpqVK3A9wM9MyC2lV00dDxdKQxXsQy5WUn
 H9UfWAUU6OtLJccqebwK0BlsiJV7k0EWl174BUxWRVAnS41ck1M1GweYtyyJB3RhSPYp
 pb/JraMo0UAQjA00X7fVN0dkw+oN5w+cwHb2QNctPQlQW4volRLM8HWnl9cxGgRrSNMQ
 5kKd5u+F9wrZLNKbJNqvG4XUJcN+M7v0tkdcf94xobG/jF1EH60LqY8gPLqpG1IRuP+o
 TVzYCzCgFsFRJ0f+UikVlRji2iGOysKhBxWhP2yUGX+UfjOPj6JFzo5fKdJBRDRdakNL
 XHVg==
X-Gm-Message-State: AOJu0YxBtT/f4mjOkQQ2pOExH+iNCmeeZZNfyR9pIo1nStUAyd02XLPT
 QPc45jQLNY1VFBHN2Cg8F3zJ/+OWpe0T9fAAlpecuRpOxTBPDBYhn+u/9jTN5GXuj6APAjuCL4C
 +U8oVBVA=
X-Gm-Gg: ASbGnctGnwoWwyD5kpVur2zkZVuYJAD0FNV7iPC7wu9OEVwGGSNow2Fv5JYNDoLJNJ0
 wOWdnoHYpWffMyCZVLj1ByaJp/oz+Il39PCeya5vWmRkotXaCuBc5ZxHZV8F4n6OVbZSqBBpQqT
 BlcxvOkCyV97M34UB/i0YAH0r3p/TGuzFVOdqQooE2jApzE3ovbkp5TGO5kh1tZ7ofqMfYixV6X
 RXJ1CqLcASPF3VQPB30+PhxNPAWtKGEzIhtoRwuKAxUDKNKUa9jAQYq3TnTvfCfTd417WEPRTor
 VMlM5HTCJF197X6UqEmNiHNYrBs9Fl8dsKLCkABGdvvsBNz1aLw7zKXL0gbRADIQ6lv8tuhWybd
 14U1m7ohdJdIZBPoynmarfGqW7/+RNlbcRXfa/z1Vm7TKCpkIuOsUmuJ5
X-Google-Smtp-Source: AGHT+IG4EWM6EdomsTd7nalTSGFi88vU5yZnCfGkAXbIt04wM7XWlMqdthw9NbN0ZmCUB6N4SFdpfg==
X-Received: by 2002:a05:6820:310a:b0:615:83d3:7269 with SMTP id
 006d021491bc7-61583d37c0cmr3479222eaf.8.1752535745357; 
 Mon, 14 Jul 2025 16:29:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf1064e90sm1757889a34.9.2025.07.14.16.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:29:04 -0700 (PDT)
Date: Mon, 14 Jul 2025 17:29:02 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20250714232902.GB193579@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bcApRyx8AF0F+/D7"
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
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


--bcApRyx8AF0F+/D7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's the latest report from Coverity. Good news is closing 5 existing
issues (overlap with smatch I think) but 3 new ones. Or maybe it's
related to Rasmus' cleanup series? I can only run one report a day I
think so I don't have granular breakdown on which changes today brought
these up.

---------- Forwarded message ---------
=46rom: <scan-admin@coverity.com>
Date: Mon, Jul 14, 2025 at 5:23=E2=80=AFPM
Subject: New Defects reported by Coverity Scan for Das U-Boot
To: <tom.rini@gmail.com>


Hi,

Please find the latest report on new defect(s) introduced to *Das U-Boot*
found with Coverity Scan.

   - *New Defects Found:* 3
   - 5 defect(s), reported by Coverity Scan earlier, were marked fixed in
   the recent build analyzed by Coverity Scan.
   - *Defects Shown:* Showing 3 of 3 defect(s)

Defect Details

** CID 573150:       Integer handling issues  (INTEGER_OVERFLOW)
/drivers/pci/pci-uclass.c: 1531           in dm_pci_map_ea_virt()


___________________________________________________________________________=
__________________
*** CID 573150:         Integer handling issues  (INTEGER_OVERFLOW)
/drivers/pci/pci-uclass.c: 1531             in dm_pci_map_ea_virt()
1525     		if (ea_entry & PCI_EA_IS_64) {
1526     			/* MaxOffset 2nd DW */
1527     			dm_pci_read_config32(dev, ea_off + 16, &ea_entry);
1528     			sz |=3D ((u64)ea_entry) << 32;
1529     		}
1530
>>>     CID 573150:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "sz + 1UL", where "sz" is known to be equal to 184467440=
73709551615, overflows the type of "sz + 1UL", which is type "unsigned long=
".
1531     		addr =3D (pdata->virtid - 1) * (sz + 1);
1532     	}
1533
1534     	return addr;
1535     }
1536

** CID 573149:       Integer handling issues  (CONSTANT_EXPRESSION_RESULT)
/lib/efi_loader/efi_file.c: 594           in efi_file_read_int()


___________________________________________________________________________=
__________________
*** CID 573149:         Integer handling issues  (CONSTANT_EXPRESSION_RESUL=
T)
/lib/efi_loader/efi_file.c: 594             in efi_file_read_int()
588
589     	bs =3D *buffer_size;
590     	if (fh->isdir)
591     		ret =3D dir_read(fh, &bs, buffer);
592     	else
593     		ret =3D file_read(fh, &bs, buffer);
>>>     CID 573149:         Integer handling issues  (CONSTANT_EXPRESSION_R=
ESULT)
>>>     "bs <=3D 18446744073709551615ULL /* 9223372036854775807LL * 2ULL + =
1ULL */" is always true regardless of the values of its operands. This occu=
rs as the logical operand of "if".
594     	if (bs <=3D SIZE_MAX)
595     		*buffer_size =3D bs;
596     	else
597     		*buffer_size =3D SIZE_MAX;
598
599     	return ret;

** CID 573148:       Integer handling issues  (INTEGER_OVERFLOW)
/drivers/pci/pci-uclass.c: 1581           in dm_pci_map_ea_bar()


___________________________________________________________________________=
__________________
*** CID 573148:         Integer handling issues  (INTEGER_OVERFLOW)
/drivers/pci/pci-uclass.c: 1581             in dm_pci_map_ea_bar()
1575     			addr |=3D ((u64)ea_entry) << 32;
1576     		}
1577
1578     		if (IS_ENABLED(CONFIG_PCI_SRIOV))
1579     			addr +=3D dm_pci_map_ea_virt(dev, ea_off, pdata);
1580
>>>     CID 573148:         Integer handling issues  (INTEGER_OVERFLOW)
>>>     Expression "4294967295U - addr", where "addr" is known to be equal =
to 4294967292, underflows the type of "4294967295U - addr", which is type "=
unsigned int".
1581     		if (~((phys_addr_t)0) - addr < offset)
1582     			return NULL;
1583
1584     		/* size ignored for now */
1585     		return map_physmem(addr + offset, len, MAP_NOCACHE);
1586     	}



View Defects in Coverity Scan
<https://scan.coverity.com/projects/das-u-boot?tab=3Doverview>

Best regards,

The Coverity Scan Admin Team

----- End forwarded message -----

--=20
Tom

--bcApRyx8AF0F+/D7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh1kroACgkQFHw5/5Y0
tyycyQv/b37fxtF4823UO6NhLYaTHTOeMT5IS1FdhHygV3JYHle1Uadup19YICMe
CyPVuGml3IS15tkuHp6N+al9bztj67W/YbOxbrED/R8whsHHBA1vBYTCmr1DyjnI
LRRluQZuouEM+ix6KpHDrWDEpb9Ao9vWBgunmV5sP+c13Yg8fPtZUv5+bdhwgYwj
DlPql6oym89JWtNexPwV5iIbJcPO1QuIQDIpXw8WhpPYTJik/IxE5auunXY8a8aj
DmzhoY0ZT87lFqtaYqV0yWIajh+gCul3mv8O7KAKEQG3/pDXA1qaePBk7cmkbP3Z
gEdAzqtrLboc2eIMiYqheFxyfZ9r8YPM/njPqpuL640UQ9pMpkOk7UMdz5I/1usv
tqsn4I6RvrvKH10c4s1kJsExg3GBveAjl+/Q2eHiA//ZkrNz9wGroGbexlM6Xn2y
LQ63BRvvuNF5Flj7QwZuOTERtwnbYGnLAc4xNAhjrZjIiE2MRNJlIw4YmAlqxZ8i
yqrr3g4D
=SO+y
-----END PGP SIGNATURE-----

--bcApRyx8AF0F+/D7--
