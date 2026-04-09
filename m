Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A51F364A6
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 18:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65938841D6;
	Thu,  9 Apr 2026 20:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pIu4JHGN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 605F484099; Thu,  9 Apr 2026 18:47:04 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B6A83CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 18:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebasjosue84@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-66b2d49ffb0so1369361a12.3
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 09:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775753221; cv=none;
 d=google.com; s=arc-20240605;
 b=dPqarxQ5gjxezrjJVx4j9dPO+YaZwVpQYPjPUb+gZsNdM/vuvdCwpeOcbEWEKBOGSP
 FTycvuGpPhOWbHMcVc/0JHQBCqJjz8TREm+roLbscCnr6QWFEoelM+asH7CSZjgO+Lav
 mzY5du059XV8I3BkB8CaZ4c9ZwN+0EI49tOuSiRJTNk5j3BWmb4+kNkk+K174+/2zra/
 v5vqWuDs4x1hQU7uCY+Se5EUxPtYs3IzU3p0Rl/jUXBZZC5gBGL/PHZRuqCPPErWv2OU
 eCmvKBY8ueqSbUCSUbpN0GaFmJsxUmqtv0dNfwh/SPM7rMadPuRZi7LD5e/aAeSzkuW0
 K/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4YKriN/qUrxr/lC/saxAsM+b57w8AKhn+XY+NEK2kwM=;
 fh=upTKAT7q3qb37b2lFx9UZdg1JSjdO+3XIDFEzChD0/U=;
 b=FvnBlHENk3xrmGwirBELXMVlUpxN144llX/2/LXA6cUJE+L88vlpGGL2db3GDaCdXE
 MNdP/o+4x+qFOfgvIn+zTnhV+GSNLGjXEPmIooQlgTj3VOMken2DLGnEDLfO2hl1d+0M
 l6JFdwQdyAVYq5JVxjYGLE2qa25VMRRJN+xBiSF5aq2B469qHw8bfgjisFE4t7n2DT9q
 U0+S7C9hs0Q2eyEUkI5pofcBEWaul+FgskZ/BfQiQSLEKlvT1k66FPgZX5kTjQTe1C8v
 p+RY4onL7DgQt1M54YDcUixUoDpqX9LQuI4+dXpTZi8XQ55NaZhEY3t9OIGwVsbG79V1
 WZXA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775753221; x=1776358021; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4YKriN/qUrxr/lC/saxAsM+b57w8AKhn+XY+NEK2kwM=;
 b=pIu4JHGNS8SrrxVkrRzkrN0p996DTB8rTYGJ7+eDDyMv+hzHYKnln+qYSS22P7puC5
 2LEZBkQYICfQzM2RbHesadsp5jekw9CrIq1Sb0hRVdWW5FIflV8aGSHtGPEqNZKog06I
 h+x8I5uyEFhecqJhNx0nq2TzPzLXRplHpMeI8OI/Yl4aH1uh+TP6875zkjmJS71SmvCJ
 Uyrci88Qc/nrWVlK2NbddVam2eEPWbxN3CG6jdubD985Wm8kwi1EgXISrQG9sm7LgXxb
 wmoTE7+dMD66xCbGksddElom+iF1mGFOUdWYEPKa15ATzV7M99VCRKLwx6FjSKzw8/As
 QE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775753221; x=1776358021;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YKriN/qUrxr/lC/saxAsM+b57w8AKhn+XY+NEK2kwM=;
 b=BefYBxRVIJgWlUF8t7HHmxT48ymsN2wgjdd0EgNkXvmoLI1fOFMkigi0YNcD3OpynX
 roulxp4M6g2bmuUjY07A+RvcGqdpIvDVQXkd/k81y/uqwsiiBOL74/udyjU3nxwQXnBX
 vWJZkDouMwBAaq69hrgODGRO2Rkzdj0cEjVUTXLhZYWNP/fw07d8UZSUJACEiWMLTXNb
 Pa4/kxdSqnWkbaIOw/4pI+zehOFG6/QP2fsN4XwjNduGASDdG+kJoAD3YD/Gy/TqBPoM
 nfCGWK6pW8tKyTIO021p8oBsc1OG4gqjH/6J6W5pghzCWltY+duQB49i/3O+K8enDv78
 Pp8w==
X-Gm-Message-State: AOJu0Yztz3HSELVd0uRqRCaNjFkub1wTsnQcPHmRGVe9bOiRM/yZmzNL
 l89QPQIFPUKEk0cPTKVYbGQkNpvER/2ouPM5iE9eKGjcJErnK0fljuJOv4B86A4CxT/8OzzFJvj
 Eye3h3wjnO5O1Rxme/avhcTgE1bcGY4E=
X-Gm-Gg: AeBDiesRAChkdi6ZFef3f8nF7zV3Dfl5R1ciKEiM1laU8tLhz04AEYMF9m9atRoGbUY
 xi+E+m9I+nhb+nu1KVcRyc2060tjPQn09jf1SycC8+p6mcSiSsT5cOiqFdMeX257JR0rAm+EZ66
 TJJ8tbqFIkZAj9OVYUTAAUEs2OclgExAGNzuTYeSiNtjO/YjC1aqaxqItoOy/ngRbDhjpbMlrgs
 bR355sDPNs0bHh7Sk1vHw8DplNWcu4IO7bc6Z5660B4Ruq5h0Uh36Uo4lfi0rnvH8xcnJhW5xc8
 7FBNLmiD
X-Received: by 2002:a17:907:d40f:b0:b97:b379:b3fa with SMTP id
 a640c23a62f3a-b9c679f62d8mr1557470166b.39.1775753220774; Thu, 09 Apr 2026
 09:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD=UNd17V=anGd6C=jM8YzV10uTwEewae+CD1YGym5=JGeuiw@mail.gmail.com>
 <20260409154035.GM41863@bill-the-cat>
In-Reply-To: <20260409154035.GM41863@bill-the-cat>
From: =?UTF-8?Q?Sebasti=C3=A1n_Alba?= <sebasjosue84@gmail.com>
Date: Thu, 9 Apr 2026 10:46:48 -0600
X-Gm-Features: AQROBzDdevBh-w0a708h_fPIrRTDLIQzK1CP09kCJcdU-alPCJYKE1AiARnTReY
Message-ID: <CAJD=UNf1V2ErvyfUqqJmhtRNJ6Gwb9=wG1hMApWuDAfTL-ZUDw@mail.gmail.com>
Subject: Re: [SECURITY] net: nfs: buffer overflow in nfs_readlink_reply() in
 legacy NFS path (nfs-common.c) , incomplete fix
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, jerome.forissier@arm.com
X-Mailman-Approved-At: Thu, 09 Apr 2026 20:12:28 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Thank you for the quick response. I have submitted the patch to the mailing
list:

  Message-ID: <20260409164440.323405-1-sebasjosue84@gmail.com>
  Subject: [PATCH] net: nfs: fix buffer overflow in nfs_readlink_reply()
  To: u-boot@lists.denx.de
  Cc: trini@konsulko.com, jerome.forissier@linaro.org,
stable@vger.kernel.org

Regarding the CVE, I will request one directly via cveform.mitre.org as you
suggested.

Please let me know if any changes are needed.

El jue, 9 abr 2026 a las 9:40, Tom Rini (<trini@konsulko.com>) escribi=C3=
=B3:

> On Wed, Apr 08, 2026 at 10:56:59PM -0600, Sebasti=C3=A1n Alba wrote:
> > Hi Jerome, Tom, and U-Boot security list,
> >
> > I would like to report a buffer overflow vulnerability in
> > net/nfs-common.c:nfs_readlink_reply()
> > that was not addressed by the recent fix in commit fd6e3d34097f ("net:
> > lwip: nfs: fix buffer
> > overflow when using symlinks").
> >
> >
> > *=3D=3D Vulnerability =3D=3D*
> > File: net/nfs-common.c | Function: nfs_readlink_reply() | Lines: ~667-6=
85
> >
> > The `rlen` field from a server READLINK reply is validated only against
> the
> > incoming packet
> > length (check inherited from CVE-2019-14195), but NOT against the
> > destination buffer
> > nfs_path_buff[2048]:
> >
> >     rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
> >
> >     /* validates rlen against packet size only */
> >     if (((uchar *)&rpc_pkt.u.reply.data[0] - (uchar *)(&rpc_pkt) + rlen=
)
> >
> > len)
> >         return -NFS_RPC_DROP;
> >
> >     /* MISSING: check that pathlen + rlen < sizeof(nfs_path_buff) */
> >     pathlen =3D strlen(nfs_path);
> >     memcpy(nfs_path + pathlen, data, rlen);   /* BSS overflow */
> >     nfs_path[pathlen + rlen] =3D 0;             /* OOB write */
> >
> > An attacker controlling an NFS server can send a syntactically valid
> > READLINK reply
> > (rlen <=3D packet_size) where pathlen + rlen exceeds sizeof(nfs_path_bu=
ff)
> =3D
> > 2048,
> > overflowing the BSS buffer into adjacent memory.
> >
> >
> > *=3D=3D Relationship to Existing Fixes =3D=3D*
> > - CVE-2019-14195 (cf3a4f1e86): added a packet-size check for rlen only =
=E2=80=94
> > does not bound the copy against nfs_path_buff.
> > - fd6e3d34097f ("net: lwip: nfs: fix buffer overflow when using
> symlinks"):
> > fixed the same overflow class in net/lwip/nfs.c only; net/nfs-common.c
> > (legacy NFS path) was not addressed.
> >
> >
> > *=3D=3D Impact =3D=3D*
> > CWE-120 | CVSS 8.8 (AV:A/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H)
> > Affects any U-Boot client booting via NFS when symlinks are present on
> the
> > server.
> >
> >
> > *=3D=3D Suggested Fix =3D=3D*
> > --- a/net/nfs-common.c
> > +++ b/net/nfs-common.c
> >      pathlen =3D strlen(nfs_path);
> > +    if (pathlen + rlen >=3D sizeof(nfs_path_buff))
> > +        return -NFS_RPC_DROP;
> >      memcpy(nfs_path + pathlen, data, rlen);
> >      nfs_path[pathlen + rlen] =3D 0;
> >
> > Also required for the absolute path branch (~L683):
> > +    if (rlen >=3D sizeof(nfs_path_buff))
> > +        return -NFS_RPC_DROP;
> >      memcpy(nfs_path, data, rlen);
> >      nfs_path[rlen] =3D 0;
> >
> >
> >
> > I would appreciate if the project could request a CVE identifier throug=
h
> > the appropriate CNA, crediting me as the reporter.
>
> Thanks for the report. Please see
> https://docs.u-boot.org/en/latest/develop/sending_patches.html for how
> to submit a patch we can apply. With respect to a CVE, that's up to the
> submitter to request, from whatever service they usually work with for
> one, currently.
>
> --
> Tom
>


--=20
Sebasti=C3=A1n Alba
