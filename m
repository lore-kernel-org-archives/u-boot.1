Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA01ECCF2C7
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 09:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D68888148B;
	Sat, 17 Oct 2026 09:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l7xn7mLLCzOY; Sat, 17 Oct 2026 09:57:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E3FA81488
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792231031;
	b=es1KIuLEN585y4v5YKz27M0VPniXIfyZed+sscRYkiI+CWjUbgR6z+FSaumE97tI1DuQ
	 aBVa/vPPu+ZaOHT1YNPFcTygqDAPb9DVNxGJV/wQ8Y6B8fcFbnIM3omTenOlsFuTPUkYd
	 aZnKov559NjYbwgumExgZuLwpxcV2BQsiy//mqKnPuOC10foptjSKDbHIALGYQyeSAnfE
	 QMv/lDNJ/XQOTRgI3G7FHjnmHq15lYpQJnlltcxOL90i33b/KztFepem/Ww1a600JxgTb
	 nz6QVSc57mKYNfQ0WuQBTM0uezJErHGseX3+rud/531+wfYzHasoJ0tA4Mo1aXMcUug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792231031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Content-Type:Content-Transfer-Encoding:From:
	 Mime-Version:Subject:Date:Message-Id:References:Cc:In-Reply-To:To:
	 X-Mailer:X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=bst+xc15cEtq+hTpVKWE2TJuBu39cvWWd3RJNjXK+eo=;
	b=X+1usMZLFInIbplW9paEGSw79rufMq4xmlR0ZxX7OivsOBF+yZZpP6sdJ53l+X++8sMs
	 FoL/eqPJ2z7D/QMAi5RoPITkkBVvzIHy+J2FW36347fEvMz+pH4FYUuh1KSR7KiYVSnk/
	 U4DHMc1kkD8YxS7fMtMxatoZQ39VqxdGL3h6hestVnm2JH4XNWpNKArxQRcbd/RLtpi2F
	 0cv8b7Ua8ZDJTp6pPT3R0V66ZEsi0Q8QrDHvKDsztr2obRrOgqmfL7BcdHENkyHWsAh5/
	 PE99DTWAwUKeGOiQE3q2SzCOpfk4+erDSqgmzpNdXzRPUjm4qrpVl0T/ZCm6WinSvxA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792231031;
	bh=bst+xc15cEtq+hTpVKWE2TJuBu39cvWWd3RJNjXK+eo=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NcCe3CeTZ6w7b885Cv73ho1zDNHh3k1VEpv6KQa9nOIg9pxud8dJQVy3UNLJjAMUu
	 +/rsvspkrnM96uf7iUhTBTJv3wCpW9Ta8PAPquYBmLu9pZM6VtT2Mu3G4vqKnBG2MD
	 TKM0oxpHuhKQWPU/Av6s89/PtQ78v4g2tgUAuLw+8WDBMdEY4r9cYLYzaNplm5/7Ad
	 oGRmQyMbgdRxAx05M40OskUs2G1fraH06qu6rRrTxWDCNQHSDAkY5t0i61kF8i42vN
	 CE5vMLBkChKee+3210lJ9nbfpSHG8yFlCncftXI4SrpqhBbueN/V+SGyLNY2SCIMAL
	 86iOy8BK62WkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E3FA81488;
	Sat, 17 Oct 2026 09:57:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 69D7F1DE
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C326606F1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:57:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L-wJCXfoh-7W for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:57:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FB5D606B9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792231028;
 b=kY9qHmKFQhGOQhF1U8mp5MV1If+v9KwE+YeCAQWAeuPK39UfBYIk9OH6cJJQyIKV7gdm
 cP+j24X1Gz3zGFzZAxNRVST/cWz3cFkquuRMLY3JW+A0vB/nnxPv//hSy5IgY2DvXkWj8
 JwAomm0ENgtO6Q9KSj1aeps/nv4/oYKn8S3xvtFcOxovs8KDNYDsSIt7DPid29Ggm9AWI
 dMARR3XnWazjUGZqTfgWPsg0qU7c4vr+ORyMRGWyHNMT1NHlTkw1Hx76Ras+DCwFZy+i2
 9R8L3ghxxB0B3mjT23W8ndXQ6Kpg3YqLew3MotqUbcA5hVIyaY6bY3zyI7BM27zsOjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792231028;
 h=Received-SPF:DKIM-Signature:Received:Content-Type:
 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
 References:Cc:In-Reply-To:To:X-Mailer:X-CM-TRANSID:
 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
 bh=bst+xc15cEtq+hTpVKWE2TJuBu39cvWWd3RJNjXK+eo=;
 b=LAdoPGdPhOH4uhNfPPRgUkXViBDyCSkkdH8ESzOrPYccLdppH2Foy9Luvek9bmcBAnNk
 LqUZMHJOC1TP1EbN1aqImNokUOQcxXhXQDQRWu123DgcziDNvyqexF5A4gY2zK3PpK42G
 tdhTB8J1ECq3OgrhrB0hdL/VT2/Li2Y8LkEMrpyxkgiRugrz0QzT+kroUiAXZv/oXFTo5
 badLFCjkL/3X1BbKMxFIsnDpgs4Br6z/GxlQISIaCrE8Boyn5D6MO0/xLx2S8Kf5sgC+q
 IfUcazUEUbOMvZkGP2Gk5LA+ukHLzmiZBFr3Q4nPL+zmTBFz6fmc4eH5jtTRQt9Ynvw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=qBLbA02a; 
 arc=none smtp.remote-ip=220.197.31.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.2;
 helo=m16.mail.163.com; envelope-from=qianqiang.liu@163.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=qBLbA02a
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0FB5D606B9
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Content-Type:From:Mime-Version:Subject:Date:
 Message-Id:To; bh=bst+xc15cEtq+hTpVKWE2TJuBu39cvWWd3RJNjXK+eo=;
 b=qBLbA02aWF1DMfNWME0u6IC3T/sJKwp4Kc9+9Pv+d40+75OuUVQUUbOTP8w+5v
 /9euFTZPudO8vuvVqRCr/GiaFf9QwpEleaEP9hqeiFndLi5OFoXnAY62z9SBaPzU
 D8tbACnjaQudvMKBqsHj3cISJen6cy1AX62QSWimdBvvQ=
Received: from smtpclient.apple (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wD3d39kRtNqL0LNAQ--.62784S2; 
 Sat, 17 Oct 2026 17:56:52 +0800 (CST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Qianqiang Liu <qianqiang.liu@163.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] cmd: nand: add .part suffix to dump command and
 refactor parsing
Date: Sat, 17 Oct 2026 17:56:41 +0800
Message-Id: <07E97ED1-E0C8-4DB7-92EB-3BFDF082B985@163.com>
References: <20260930232223.23506-2-qianqiang.liu@163.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260930232223.23506-2-qianqiang.liu@163.com>
To: trini@konsulko.com
X-Mailer: iPhone Mail (23H30)
X-CM-TRANSID: _____wD3d39kRtNqL0LNAQ--.62784S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr13uFyfJr4rJFWfKryDKFg_yoW5XF1xpr
 Z5uay5t3yDtF17Aayay3WDZrZ5GrZrXryfXF9xX348ZFn5Jr10q3WFgFWSk3WUWrWfua45
 ZF4YgFy3Ca1qvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRcAw3UUUUU=
X-Originating-IP: [2409:8931:4ac:7585:5c:f316:5245:9db3]
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/xtbCzgQ6pGrTRmQjMgAA3e
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

Hi Tom,

Could you please review this patch?

=E2=80=94
Best,
Qianqiang Liu

> 10.1.2026=EF=BC=8C07:22=EF=BC=8CQianqiang Liu <qianqiang.liu@163.com> wrot=
e=EF=BC=9A
>=20
> =EF=BB=BFCurrently, the 'nand dump' command requires a raw hex offset. Whe=
n
> inspecting partition headers or magic numbers, users must manually
> look up the physical offset via 'mtdparts' first. Furthermore, the
> command's suffix parsing (.oob, .ecc) relies on exhaustive strcmp()
> permutations, which is fragile and scales poorly when adding new flags.
>=20
> This patch introduces the '.part' suffix (e.g., 'nand dump.part <part>'),
> leveraging mtd_arg_off_size() to resolve the partition name to its
> physical offset to dump its first page.
>=20
> Additionally, the suffix parsing is refactored to use strstr(). This
> cleanly eliminates the hardcoded strcmp() combinations and inherently
> supports arbitrary ordering of suffixes (e.g., 'dump.part.oob',
> 'dump.ecc.part').
>=20
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>=20
> Changes in v2:
> - Fix the checkpatch.pl warnings
>=20
> cmd/nand.c | 20 +++++++++++++-------
> 1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/cmd/nand.c b/cmd/nand.c
> index b5678b0a008..be8e614b93b 100644
> --- a/cmd/nand.c
> +++ b/cmd/nand.c
> @@ -700,18 +700,24 @@ static int do_nand(struct cmd_tbl *cmdtp, int flag, i=
nt argc,
>    }
>=20
>    if (strncmp(cmd, "dump", 4) =3D=3D 0) {
> -        int only_oob, ecc;
> +        int only_oob, ecc, part;
>=20
>        if (argc < 3)
>            goto usage;
>=20
> -        only_oob =3D !strcmp(&cmd[4], ".oob") || !strcmp(&cmd[4], ".ecc.o=
ob") ||
> -            !strcmp(&cmd[4], ".oob.ecc");
> +        only_oob =3D !!strstr(&cmd[4], ".oob");
> +        ecc =3D !!strstr(&cmd[4], ".ecc");
> +        part =3D !!strstr(&cmd[4], ".part");
>=20
> -        ecc =3D !strcmp(&cmd[4], ".ecc") || !strcmp(&cmd[4], ".ecc.oob") |=
|
> -            !strcmp(&cmd[4], ".oob.ecc");
> +        if (part) {
> +            if (mtd_arg_off_size(argc - 2, argv + 2, &dev, &off, &size,
> +                         &maxsize, MTD_DEV_TYPE_NAND,
> +                         mtd->size) !=3D 0)
> +                return 1;
> +        } else {
> +            off =3D (int)hextoul(argv[2], NULL);
> +        }
>=20
> -        off =3D (int)hextoul(argv[2], NULL);
>        ret =3D nand_dump(mtd, off, only_oob, ecc, repeat);
>=20
>        return ret =3D=3D 0 ? 1 : 0;
> @@ -1042,7 +1048,7 @@ U_BOOT_LONGHELP(nand,
>    "nand erase.part [clean] partition - erase entire mtd partition'\n"
>    "nand erase.chip [clean] - erase entire chip'\n"
>    "nand bad - show bad blocks\n"
> -    "nand dump[.oob][.ecc] off - dump raw (default) or ecc corrected page=
 at offset\n"
> +    "nand dump[.oob][.ecc][.part] off|partition - dump raw (default) or e=
cc corrected page at offset or partition\n"
> #ifdef CONFIG_CMD_NAND_WATCH
>    "nand watch <off> <size> - check an area for bitflips\n"
>    "nand watch.part <part> - check a partition for bitflips\n"
> --
> 2.55.0

