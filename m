Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC8EC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 15:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BAD487801;
	Wed, 13 Dec 2023 16:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="kNTD8Aj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4130587801; Wed, 13 Dec 2023 16:00:36 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 842BE87804
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 16:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1702479629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7S2fkaPvjNH8uNKnGpGQAkrq34scZlI+RKoh8eVYdY=;
 b=kNTD8Aj2W/s10uAAPHwFf3Mc/R2Q3K2Lcp/1+Q83Bk5QPh43Ic3CjghyAVl5qpNpofDbqZ
 96zuGIDCd/9ekFQeebGY0OOtZfMqMpYCGZNPMS7nCCjd+WldGUECX04Wq87atTtlHq2MpB
 iNUuCeyUA55eKUTl/jwOP7HN3uDNMs739nMDFoJhmcDd/gBGFRMxASUcnu56ZmRCVsnX+p
 Xhf7OBPezmw10+rnSu6JkrtCTg8DQX4YIYbrsUtCc/IzLlsCSR7OTnfjdInzCC7JDZwbTU
 MvC3KTxCCuOictND/MUzhX3pkYk6UHQhyJe/7CKiK7clV0rN47BwZIv4OcamUA==
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Terry Lv <terry.lv@nxp.com>, Marek Vasut <marex@denx.de>
Subject: Re: =?UTF-8?B?5Zue5aSNOg==?= Build failed when CONFIG_TOOLS_LIBCRYPTO
 is disabled on latest u-boot
Date: Wed, 13 Dec 2023 16:00:29 +0100
Message-ID: <2370209.ElGaqSPkdT@ada-pc>
In-Reply-To: <GVXPR04MB995027625009662BDCDB81948FBDA@GVXPR04MB9950.eurprd04.prod.outlook.com>
References: <AM6PR04MB61521B84F78571B282FE1D828FD5A@AM6PR04MB6152.eurprd04.prod.outlook.com>
 <GVXPR04MB995027625009662BDCDB81948FBDA@GVXPR04MB9950.eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
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

Hello,

Am Montag, 27. November 2023, 03:53:49 CET schrieb Terry Lv:
> Hi Experts,
>=20
>   Any feedback on this?

Bitten by the same problem again, I did a quick search on lore and found=20
these:

1. Patch from 2021:

   https://lore.kernel.org/u-boot/20211021093304.25399-1-pali@kernel.org/

   I carried that patch up to 2022.04, but it does not solve the whole prob=
lem=20
in recent U-Boot anymore.

2. Another patch tackling the same issue from early 2022:

   https://lore.kernel.org/u-boot/20220111153120.1276641-1-marex@denx.de/

3. Discussion from mid 2022:=20

   https://lore.kernel.org/u-boot/1884029.XjOfZupGQm@ada/

4. Patch series from earlier this year:

   https://lore.kernel.org/u-boot/20230121154743.667253-1-paulerwan.rio@gma=
il.com/

As far as I can tell none of the proposed patches got applied.  I'm going t=
o=20
test those now which I was not aware of yet.

Greets
Alex

>=20
>   Thanks!
>=20
> Regards
> Terry
> ________________________________
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Terry Lv
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2023=E5=B9=B410=E6=9C=8818=E6=97=A5=
 12:03
> =E6=94=B6=E4=BB=B6=E4=BA=BA: u-boot@lists.denx.de <u-boot@lists.denx.de>
> =E4=B8=BB=E9=A2=98: Build failed when CONFIG_TOOLS_LIBCRYPTO is disabled =
on latest u-boot
>=20
> Hi Experts,
>=20
>   We need to disable CONFIG_TOOLS_LIBCRYPTO in our u-boot.
>=20
>   But when I disable CONFIG_TOOLS_LIBCRYPTO from menuconfig, my u-boot bu=
ild
> fails.
=20
> Logs:
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
lin
> ux/usr/bin/ld: tools/image-host.o: in function `read_pub_key':
> image-host.c:(.text+0x8f): undefined reference to `PEM_read_X509'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: image-host.c:(.text+0x9e): undefined reference to
> `X509_get_pubkey'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: image-host.c:(.text+0xae): undefined reference to
> `i2d_PublicKey'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: image-host.c:(.text+0xc1): undefined reference to
> `X509_free'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: tools/kwbimage.o: in function `openssl_err':
> kwbimage.c:(.text+0xbb): undefined reference to `ERR_get_error'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
lin
> ux/usr/bin/ld: kwbimage.c:(.text+0xd7): undefined reference to
> `ERR_error_string'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: tools/kwbimage.o: in function `kwb_load_rsa_key':
> kwbimage.c:(.text+0x19d): undefined reference to `PEM_read_RSAPrivateKey'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: tools/kwbimage.o: in function `kwb_compute_pubkey_hash':
> kwbimage.c:(.text+0x278): undefined reference to `EVP_MD_CTX_new'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x28c): undefined reference to
> `EVP_MD_CTX_reset'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x291): undefined reference to
> `EVP_sha256'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x29c): undefined reference to
> `EVP_DigestInit'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x2b6): undefined reference to
> `EVP_DigestUpdate'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x2ca): undefined reference to
> `EVP_DigestFinal'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x2d9): undefined reference to
> `EVP_MD_CTX_reset'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x2e1): undefined reference to
> `EVP_MD_CTX_free'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: tools/kwbimage.o: in function `kwb_export_pubkey':
> kwbimage.c:(.text+0x3b2): undefined reference to `RSA_get0_key'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
lin
> ux/usr/bin/ld: kwbimage.c:(.text+0x3c3): undefined reference to
> `RSA_get0_key'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x3f5): undefined reference to
> `BN_num_bits'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x408): undefined reference to
> `BN_num_bits'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x47e): undefined reference to `BN_bn2b=
in'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x49f): undefined reference to `BN_bn2b=
in'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: tools/kwbimage.o: in function `kwb_verify':
> kwbimage.c:(.text+0x66f): undefined reference to `EVP_PKEY_new'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
lin
> ux/usr/bin/ld: kwbimage.c:(.text+0x686): undefined reference to
> `EVP_PKEY_set1_RSA'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x696): undefined reference to
> `EVP_PKEY_size'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x6a6): undefined reference to
> `EVP_MD_CTX_new'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x6ba): undefined reference to
> `EVP_MD_CTX_reset'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x6bf): undefined reference to
> `EVP_sha256'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x6ca): undefined reference to
> `EVP_DigestInit'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x6e2): undefined reference to
> `EVP_DigestUpdate'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x6fd): undefined reference to
> `EVP_VerifyFinal'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x71d): undefined reference to
> `EVP_MD_CTX_free'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x73b): undefined reference to
> `EVP_PKEY_free'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x807): undefined reference to
> `EVP_MD_CTX_reset'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x80f): undefined reference to
> `EVP_MD_CTX_free'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x817): undefined reference to
> `EVP_PKEY_free'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: tools/kwbimage.o: in function `kwb_sign_and_verify':
> kwbimage.c:(.text+0x84e): undefined reference to `EVP_PKEY_new'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
lin
> ux/usr/bin/ld: kwbimage.c:(.text+0x865): undefined reference to
> `EVP_PKEY_set1_RSA'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x875): undefined reference to
> `EVP_PKEY_size'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x885): undefined reference to
> `EVP_MD_CTX_new'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x89a): undefined reference to
> `EVP_MD_CTX_reset'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x89f): undefined reference to
> `EVP_sha256'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x8ae): undefined reference to
> `EVP_DigestInit'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x8cc): undefined reference to
> `EVP_DigestUpdate'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x8ef): undefined reference to
> `EVP_SignFinal'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x907): undefined reference to
> `EVP_MD_CTX_reset'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x913): undefined reference to
> `EVP_MD_CTX_free'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x91b): undefined reference to
> `EVP_PKEY_free'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x93b): undefined reference to
> `EVP_PKEY_free'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: kwbimage.c:(.text+0x9ed): undefined reference to
> `EVP_MD_CTX_free'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: tools/kwbimage.o: in function `kwbimage_set_header':
> kwbimage.c:(.text+0x26aa): undefined reference to `d2i_RSAPublicKey'
> /opt/samba/nxa08304/gcc_cross_toolchain/5.4-zeus/sysroots/x86_64-pokysdk-=
li
> nux/usr/bin/ld: tools/kwbimage.o: in function `EVP_MD_CTX_cleanup':
> kwbimage.c:(.text+0x4aa5): undefined reference to `EVP_MD_CTX_reset'
> collect2: error: ld returned 1 exit status
> make[1]: *** [scripts/Makefile.host:104: tools/dumpimage] Error 1
> make[1]: *** Waiting for unfinished jobs....
>=20
>   Do you know whether there is a patch to fix the issue?
>=20
>   Thanks!
>=20
> Regards
> Terry




