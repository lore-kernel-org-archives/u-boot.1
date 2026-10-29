Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE782606A31E
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J9cr+tix;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBiN4IFV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 117FE80F8D;
	Thu, 29 Oct 2026 10:29:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id avLJh6RGyxmh; Thu, 29 Oct 2026 10:29:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B4F380F71
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793269757;
	b=hs9L+LK1GxdeuYpFT+NnvUEYRhwx6jjlU8FEMijfbUpbPXZOLnFiq83xylOSHYgFY318
	 l7ldTomk/Kx495UlalxdlpKub92k+uO2TQgsWnzQqRp9b50imep4M0e/aJGmL1jEoyriM
	 HB/8qgpHAS6cIVSEp6d2vGRIaXc4ZULFBU2N1m/v0HiCcsCXw+Z/lOnNqRqWpXe6XC78r
	 QvlJSd4esEM5y3T4QJi5K9k5OQpipysqa/meSsxtO8VLsGbOTDS9V/DRkfE2s8hbF3D5G
	 mcxpuRpdYCP7IzbSxtw75jxfIiXUQQBoJ2oyGJE8RDO7+fYkuw1Phd5sFBQnMLI+9ig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793269757;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gfLWibE0s1vokhBNKfErRTc3P6eltkgRZSPVp12dP2g=;
	b=KkNxfVFsoBLjtO3YOn2M69Gxi48Ej/6an1ojkwJ0WGz0dHU8QOKDjTnJWqDff3q46I6l
	 6jSfhZefxgzLxF6cDJKmapIOYW880jn8mtmY8FWKdApfyITxYisp0geBy+jbUYYI2mvsl
	 giCyF24l2prk6IbYZNyd0U/+38PunbXl32mtrP3w1MlFxE/w1I1w0bIVCar8xA0ZSvffZ
	 DboNOXxX9j5Gnrw3WJsXdl9nAztnZevZPljkDHDUjQZqi3TbhgNtdQHMOXP2ZE5eghMx6
	 L6uTIu5rBCKOD1MiLjFedyOAajC6Squkcna7sDAUBGuvo3jvf2nekdMKVcPx0O6+blg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793269757;
	bh=gfLWibE0s1vokhBNKfErRTc3P6eltkgRZSPVp12dP2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J9cr+tix5KlccCktDm0vhQNpCVG9TbA7m5e5iVZIwB9HMebTxp+Uzs9CZS1bNEpzp
	 k1cHcfaIl5d5uzlj2fOtf2b+HtLtbumDwG2FGNSITLOIelhkL7/OeoMjYJdtB+BvAJ
	 cmXjvnU4xHVvSQ4hP/hzKA+kKB9J4SliY1CXcNTdgiqyRS4ffIum6GeN9qdCJ0E3IF
	 SjYkXXfHeErJBRLHSm+4UGS+3M5hiilAbGDoHwPRnwh+w6vxNK0XT8ubgcqvZXl01C
	 p8YFtp/XiJIfC6sKEzB8dyex5OjBzCIJ5J5cHcE1gee2Dmr7LM8nB30oKORdOLekWi
	 l9VOAwnI4pZuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2B4F380F71;
	Thu, 29 Oct 2026 10:29:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D26F120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8393D40764
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:29:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xz8MmKSyurDJ for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:29:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A541440763
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793269754;
 b=YW0v4lHLXAFSEMziOR+Q9NDsWc4mkYM83mesbrQRT+q0yuwuB5gKm/YDxhsrfBh5TBm5
 8yuvsWaINVh8ZyDoCcuTgMXwSwHCc2miM9FXzduvvO6BzDYEtljfVCufd5YwVLtt1SE6C
 /SRy6d3Jl2x0ATHDW/913jUZR92bySPfzZ4qf100hLGEFJEURmbiyJakUepI/I1QHzuvu
 Ian4ANQhTOWnWxx+lVxMdHSkI9/Kx+9b9O4cdZQ7rf9jwdSBYMRJE9HqR2CMDFqsgrJA9
 TLuqlQDXSHU0uxlW37z2GX4aTbjr1+9qkpLZrX3CGJvBDCbJ64jR5Zvphz6C9sp+6lg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793269754;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=gfLWibE0s1vokhBNKfErRTc3P6eltkgRZSPVp12dP2g=;
 b=IMO+MhHdxNDLw/MRAGu/PyCdpMOtIwk3lbwrA+CadWNsBgOJXdqkO2NUKwYlJksESibk
 yrPFlej8HEIqAFb2FZXxVOwRBTPCTMl1KVSveiSai7rswjNKQtHvXL4di3RHMCxztGdjC
 iclXuzlcLR11zuA2cN66yDzKj3KsIwriSfYu7pDK86GpGH/cN/8RZarG5NyuAAUlAPsoJ
 5kgmFOF4kenZMJ24oimlTHo/z0NWB0fGGAmO2jVcpJvO4NztKz+UY/wz7nblwcvYYLWE4
 IiH9JwCL64pMEYJlXGbpMXC21buDwJUBD0PKRntL+eQMi/3OMQ2DxRmbWm1qW6e+2Vw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bBiN4IFV; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=bBiN4IFV
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A541440763
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:29:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0545D600DA;
 Thu, 29 Oct 2026 10:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0C21F01829;
 Thu, 29 Oct 2026 10:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793269751;
 bh=gfLWibE0s1vokhBNKfErRTc3P6eltkgRZSPVp12dP2g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=bBiN4IFVI6IFTQvUN13aGEEgAX6NhTbQrbS1qmkazkHuG5SkXXYwfeF/QlIL0Vtzh
 vVNIUyUdYMZmUStnIGeM13iIlAHjKcRltcuxjRAibuMvRlNkm61/RsySca2vPtRRWg
 eFAKx1Bbb/eXJuNJssNLlVQeVIpgqag4kLRejdn/8orKD9wQjF8ecdH3sKRjPIh3UO
 OZiHPtQDIFOG3kpjHDGMSelxf+XNWQOgQ+g3R58+cAODxN0zrJ/l8JDX6LH16URZA9
 Z75UZhRcNnnxc9TPkgyp5wt6llvOXx85ErqBLAqUJaM0TLNYP9C8CwvC5JFjPZsYMN
 umRvPvxsxpDDA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Dmitrii Merkurev <dimorinny@google.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, Guillaume La Roque
 <glaroque@baylibre.com>
Subject: Re: [PATCH] net: fastboot_tcp: implement the download data phase
In-Reply-To: <CAPzfCAYNK_eBe9kXtq29TopWK4=7XwdtSk5F5k8eJ7=5k=c1jA@mail.gmail.com>
References: <20261022-upstream-fastboot_tcp_b4-v1-1-466a9f181ac1@oss.qualcomm.com>
 <179275512301.1510420.5223585191999112458.b4-review@b4>
 <CAPzfCAYNK_eBe9kXtq29TopWK4=7XwdtSk5F5k8eJ7=5k=c1jA@mail.gmail.com>
Date: Thu, 29 Oct 2026 11:29:09 +0100
Message-ID: <xhkdb33to3imi.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 11:46, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>=
 wrote:

> Hi all,
>
> On Fri, Oct 23, 2026 at 1:32=E2=80=AFPM Guillaume La Roque
> <glaroque@baylibre.com> wrote:
>>
>> On Thu, 22 Oct 2026 14:17:00 +0200, Igor Opaniuk <igor.opaniuk@oss.qualc=
omm.com> wrote:
>>
>> Hi Igor,
>>
>> Thanks for your multiple fix in fastboot.
>>
>> >
>> > diff --git a/net/fastboot_tcp.c b/net/fastboot_tcp.c
>> > index 3ea25c997fcc..ed32e5311b45 100644
>> > --- a/net/fastboot_tcp.c
>> > +++ b/net/fastboot_tcp.c
>> > @@ -16,17 +17,95 @@ static const uchar *handshake =3D "FB01";
>> > [ ... skip 37 lines ... ]
>> > + */
>> > +static int dl_consume(const char *buf, int len)
>> > +{
>> > +     int left =3D len;
>> > +
>> > +     while (left && fastboot_data_remaining()) {
>>
>> varaible use in fastboot_data_remaining was properly reset after a succe=
full
>> download(fastboot_data_complete) but if download stop in middle or error
>> i don't see any reset, do you test this scenario ?
>> initiate download , stop it from host or unplug cable , relaunch a
>> download, if i understand properly while loop still use in
>> fastboot_data_remaining value from previous download.
>
> We've had a pm discussion with Guillaume, and pointed to Carlos' patch se=
ries:
> https://lore.kernel.org/all/20261014-ccaione-upstream-spl-fastboot-boot-v=
1-2-d29df15fb9b8@baylibre.com/
>
> It looks like he's addressing a similar issue with reset, but in the
> common fastboot code.
> I'll wait for his patches to land, then rebase my changes on top,
> re-use his reset
> implementation in tcp fb code and send out v2.

Sounds good. I have not reviewed Carlo's series yet but I'll eventually
get to it.

Thanks for the update
Mattijs

>>
>> --
>> Guillaume La Roque <glaroque@baylibre.com>
