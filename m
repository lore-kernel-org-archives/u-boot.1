Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDA606A32C
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xFBjfYwS;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=m8bBdGU/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4783C81309;
	Fri,  6 Nov 2026 19:21:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ON_OjJXS_1UT; Fri,  6 Nov 2026 19:21:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 16BA1812CE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793992880;
	b=WBCAe9cqzfQA8eZIJDSA33Imt4MYdQzeodOZBbiML6P8fd8kq+s2s8lE/P6oI3ewyM9O
	 IgWNNaqtLOKkEHuh+9yl/jhAJX8y//LjIEbIdMhl9SrWyVaIEiXYyItlE0UqcxUe8njjZ
	 ld4R0psGKWL3MfdW7fPs4fP8xR4f0tR1ZXN6pvM38anaRqcy2IaXD4dfD4yWFYxAYH1ex
	 1iFsZPloFZcnI7GMNSRc8OpXUV5aR7B9hEQZCr626039/QlQBhR/+kFkrFgC8XpAZtHtM
	 SqgXecbUQ9l8O9+Z3O/kLX6ayJy39ELnDmiHnNPOCdhB9IGFPjftTEQFSLE97S/S4Ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793992880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1MrmNGj/0gVDbKFAVMkLPz+oSpY5q2cNY+pKXN55KvQ=;
	b=es4WaSK78PzQdohHqgpbijDsnzwjpmSjCzwC7/oCyXHgF7CCQr57Q/gSKjiSqzjTJWcA
	 c3230F1pFHTqx9tP61YaRROBKokmi0dnhmtfF83AQ7Pi6EvyTXfNUtQZYAPZeDFSqhl/b
	 aGAbhx0UgUA8S8IcNa+nkKu9OOCa8MuSzd0nws19LZdhA6Vu0jTcR4vSBxmii/CglmpgW
	 Ue1ISmIhtMYkMG1Wz/47rQE7KiKsQmvF//umhPue3bvnqBX30BuLj1jQmA53j4+7+90cE
	 L7gq7rk0qbqYcK0fLrnAfY8hIN/iLMH1stOf24DNB9Y9vUR0KNlG4W2zHYoCkszsetQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793992880;
	bh=1MrmNGj/0gVDbKFAVMkLPz+oSpY5q2cNY+pKXN55KvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xFBjfYwS7KncESY4ePX7lIPFMIDfH0e+DLoGBWb6Mx1SmD9ghyVjDfUONfofbIAXB
	 Eq4l/IlGUPLYUmCPSPqWvJnDQqPP2OboBNjBxU5Ab2Bzakao4nzonz+blkDYl3wWNS
	 vX/38hZq0EwVBim5Q1e1bXwXMYofGGGMaslJF+s7zl3nOJJasepMoQF5mKHVb19HpF
	 9GrP/OO/Z8ymTzrFTqGaNC9o/pQY62gBeQXDn+13Ulkd/7srmPLixnVqxOAYS7AXul
	 6Na0AxAoxxK78Ttls51YhKXT8LEOUAGvXXX+KnZ+dmq6HxdpcUgkyMzB3GOD1AIE15
	 QPoGJSRvpQCmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16BA1812CE;
	Fri,  6 Nov 2026 19:21:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 123EE235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:21:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC122403FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:21:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hc-bWKhfG16y for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 19:21:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DA562400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::9;
 helo=mail-oa2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=m8bBdGU/
Received: from mail-oa2-x09.google.com (mail-oa2-x09.google.com
 [IPv6:2607:f8b0:4864:30::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA562400A2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 19:21:17 +0000 (UTC)
Received: by mail-oa2-x09.google.com with SMTP id
 586e51a60fabf-4a9971eefa8so420035fac.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 11:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793992876; x=1794597676;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1MrmNGj/0gVDbKFAVMkLPz+oSpY5q2cNY+pKXN55KvQ=;
 b=m8bBdGU/HRo4cfJF/cu5h1VGmnI4SaQGe3+FD3V4WbQ7JSXYlI4tRLkMQ4J3yZ94Xh
 5bOtagDCxUAH+jWIJ1eFU75vLyr/t3GU4+I7Y7GuJYTDeO6AtZoKbtjpuxLaGyo9wJSv
 tpsWeqqLs4Lkmqmpzqqlboutzyb5kUdLKLn6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793992876; x=1794597676;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1MrmNGj/0gVDbKFAVMkLPz+oSpY5q2cNY+pKXN55KvQ=;
 b=lmIE1oZ35lqvORU2VtDZzNdZXVwP6y4/6ICT8Z2xqZS4o0ZADwHx7XW2Xt8a73Hc2y
 kJqoXVr0G1N+zcwonccqVDtZPue/ZHtWplCT75F2/ZoOKhhw/R1DfTxp0lgMf5x1pDJz
 /jr0f0sgKo/OdULEL82OFU30f8PHtRrT8GUP4eE8yxS9JO3UskWAgC2NY1AAgEMbIenr
 yh0dBQpIpiLPrCIuwN0OgsHDprzwSKZsmoxizdlJ0/qVCuKc8t2AUNMshsHya4n/zZv1
 3/wq88B21jmg9PqXO/jm0rqXId6FtlqsSlnvz5u+VVyUq+9lSDPKjPn1zyqQbpgU1Odk
 bocw==
X-Forwarded-Encrypted: i=1;
 AKwUvByS40Mg3qIwN2LHuCM5oVA0o4veGy+r3GJXHFpVIVzRX4tgD/IvY3BK++sYGlKW35mxopmY+iI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8X5r+Rp89eXS2u7efHJO/Oo9GB7Fwc+I7HlfTYKSWvnUOCjxBj
 c+bPHCUjS99xQ1Gf6jxo8hUXxrSY8YUWZ/oQGx0q8QQX/s3ZM/C+IVVrM3st5xCmyr7PI2609uD
 kX23u1IaF/p0H8uw=
X-Gm-Gg: AYBFou0vTLK0IJ12ncJXUCpbWvlywU1tF6mzTZi6EVxbhYCiNLSW0qrCVMBfHeC0iLn
 57bsp6EpKr9aZ0mJmgoDMgfDJcHsKiNgdH8PqWYZOg570xnzbukyY1hAIveqypmIdVkU79Gh+xg
 IfDig6v8IvkowxfieLUGCjiM02FmU2uRTvPGifCe8alYTyJ1K4gN+J8lBBZeI5VFRCJee4ybaxO
 XaJA2qJjb5PQN5fccV4W7A5PiEL8ZpzXA22XfvSfxVMIgtkMhXaBc3PIWCdDVaqZXYCSe7RhrO9
 XsbD/RwU2PbNlg90enp3E8tJR2oES465iQAmimBBvq1O4oOdhSBponoO7dqFYGeOngaOoGOhrfE
 wLf/oFDMKrgH39LfzCVTaTDfZu2AB46+Ix2IJ+uLODXZAIvMRzHYAhax8I2TFXxCDuYQhHyJVHQ
 D0AWUQZ3wArl0u6rrU/8gZh5Vlk44TiwdDBlMQmHU32fizNu720GMQePoDDdDpyRawWFCXxq/4O
 /6un6Fj2vgbg8r7Nr5FkMqjM7BhXTSFz37zOuXCnLNoN/vtGp8mDVXKc23Uvmhk5XWZL+U/pb0d
 mClOV6b8rWjv/7Bjebo0v/2XVP+guaMZ6yiSLMKfJcPv0Yzq0gWgG9XPjVNpB7SyyGSF6fyTcLl
 LCwp39YVHsr7TOskXFLLzpv6PgLhQwToH43RpDRGrOys5lmghvVrUn0RWnTbWPEiX7I9am/WtJG
 XWBQGcgYV/l8xYutlDg6aeq3tCagf69owWFVH+SB8VsL/t5eDDI30=
X-Received: by 2002:a05:6820:985:b0:716:e172:7f41 with SMTP id
 006d021491bc7-716e7ad70f7mr2225737eaf.85.1793992876288; 
 Fri, 06 Nov 2026 11:21:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4ad97a37725sm2765646fac.11.2026.11.06.11.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:21:15 -0800 (PST)
Date: Fri, 6 Nov 2026 13:21:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: E Shattow <e@freeshell.de>, iav@iav.lv,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 u-boot@lists.u-boot-project.org, nd@arm.com
Subject: Re: [PATCH 0/4] cmd: lwip: wget: write the download to a block device
Message-ID: <20261106192113.GA3741582@bill-the-cat>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
 <3bb5a9a4-ce05-45c8-9fc4-d4fe99b1b0c1@arm.com>
 <79fdb1d0-c777-43c4-a7ea-98455186e900@freeshell.de>
 <2b5d3f92-666f-4c0b-863e-c681674c611c@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u114+I2HO5OcUYco"
Content-Disposition: inline
In-Reply-To: <2b5d3f92-666f-4c0b-863e-c681674c611c@arm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--u114+I2HO5OcUYco
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 08:10:06PM +0100, Jerome Forissier wrote:
> Hi E,
>=20
> On 06/11/2026 19:40, E Shattow wrote:
> > Hi Jerome,
> >=20
> > On 11/6/26 10:07, Jerome Forissier wrote:
> >>> wget can write a disk image only after the whole file is in RAM. This
> >>> series lets lwIP wget write the download to a block device while it
> >>> arrives:
> >>>
> >>>   =3D> wget -o mmc 1 -b 400000 http://192.168.1.65/armbian.img
> >>>
> >>> The target is a whole device, a hardware partition, a partition by
> >>> number or name, and an optional byte offset into it.
> >>>
> >>> Patch 1 fixes the buffer size check for a reply without Content-Lengt=
h;
> >>> patch 4 sets that check to the target size, and without the fix such a
> >>> reply would be refused. Patch 2 lets a wget client take the data
> >>> through a callback, patch 3 adds the block device writer, and patch 4
> >>> adds the options to the command.
> >>>
> >>> Tested:
> >>> - ROCK Pi 4A: a 1862270976-byte image to the SD card in 3 min 16 s to
> >>>   3 min 35 s with a 4 MiB buffer; the first 1862270976 bytes of the
> >>>   card have the sha256 of the image, and the card boots. A
> >>>   2936012800-byte image, past the Content-Length limit below, took
> >>>   4 min 18 s and checks and boots the same way.
> >>> - QEMU arm64, virtio-blk: a 404 writes nothing; a file larger than the
> >>>   target is refused before any write with Content-Length, and at the
> >>>   end of the target without it.
> >>> - sandbox: ut lib lib_test_sink_blk; every patch builds on sandbox and
> >>>   sandbox64_lwip.
> >>>
> >>> Notes:
> >>> - lwIP's http_client.c reads Content-Length through an int, so from
> >>>   2 GiB on the length is unknown and a file that does not fit fails
> >>>   only at the end of the target.
> >>> - EFI HTTP, the other user of check_buffer_size, retries with the
> >>>   reported length when it exceeds the buffer (efi_net.c:1715), so a
> >>>   reply without Content-Length still ends in a 4 GiB allocation there;
> >>>   patch 1 does not change that.
> >>> - checkpatch asks for IS_ENABLED() at "#if defined(CONFIG_WGET_STREAM=
)"
> >>>   in cmd/lwip/wget.c; that #if picks lines of the help string, as the
> >>>   WGET_CACERT ones next to it do.
> >>>
> >>> gzip and zstd input follow in a separate series on top of this one.
> >>>
> >>> Signed-off-by: Igor Velkov <iav@iav.lv>
> >>> ---
> >>> Igor Velkov (4):
> >>>       net: lwip: wget: accept a reply without Content-Length in the s=
ize check
> >>>       net: lwip: wget: hand the payload to an optional sink
> >>>       lib: add a stream sink for block devices
> >>>       cmd: lwip: wget: write the download to a block device
> >>>
> >>>  cmd/Kconfig                      |   9 ++
> >>>  cmd/lwip/wget.c                  | 107 +++++++++++++++++++++-
> >>>  configs/sandbox64_lwip_defconfig |   1 +
> >>>  configs/sandbox_defconfig        |   1 +
> >>>  doc/usage/cmd/wget.rst           |  43 ++++++++-
> >>>  include/net-common.h             |   6 ++
> >>>  include/stream_sink.h            |  75 ++++++++++++++++
> >>>  lib/Kconfig                      |   8 ++
> >>>  lib/Makefile                     |   1 +
> >>>  lib/stream_sink.c                | 189 +++++++++++++++++++++++++++++=
++++++++++
> >>>  net/lwip/wget.c                  |  89 +++++++++++++++---
> >>>  test/lib/Makefile                |   3 +
> >>>  test/lib/stream_sink.c           | 137 ++++++++++++++++++++++++++++
> >>>  13 files changed, 655 insertions(+), 14 deletions(-)
> >>> ---
> >>> base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
> >>> change-id: 20261101-b4-wget-blk-r4-833f8a3d344e
> >>>
> >>> Best regards,
> >>
> >> Applied to u-boot-net branch for-main [1], thanks!
> >>
> >> [1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/comm=
its/for-main
> >>
> >> [1/4] net: lwip: wget: accept a reply without Content-Length in the si=
ze check
> >>       commit: 8498fbf8788eff07bc7fc59f9b15cf6c65025b10
> >>
> >> [2/4] net: lwip: wget: hand the payload to an optional sink
> >>       commit: 40611fe0277a7a8f9639aab02a6f1a1e0e897d57
> >>
> >> [3/4] lib: add a stream sink for block devices
> >>       commit: fdf4d9621c8b507f69fe0dd09fc53ebfe860fda5
> >>
> >> [4/4] cmd: lwip: wget: write the download to a block device
> >>       commit: f0870bb385cf923bfab0baddacc952151efa4c39
> >>
> >> Best regards,
> >=20
> > FYI stating my objection to making the wget command take these
> > arguments, it seems short sighted and not very U-Boot -like.
>=20
> Well the way U-Boot deals with command arguments is not its major
> strength if you ask me. I think options are much easier to use than
> positional arguments and can simplify the implementation too.
> That being said...
> > The functionality itself I have no objection to but including this
> > command line argument complexity now for 'wget' implies that scripts and
> > documentation will be built around this change and then we must maintain
> > that compatibility, which is a bad design choice in my opinion.
>=20
> ...I agree that compatibility is a must and that we should not
> introduce such a change lightly. Thanks for raising the point. Let's
> see what others think. I will drop this series if it is deemed unacceptab=
le
> or if we simply need more time to discuss it.

Lets have some more discussion around it please. It's not fitting inside
the general 2 weeks on the list for discussion and I see Heinrich is
commenting on other parts right now.

--=20
Tom

--u114+I2HO5OcUYco
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCau4opQAKCRAr4qD1Cr/k
CsPFAP9mC7oodn7r60ayxJkgugPamnvZ5AWybN25OU/dfB9U2AEAyfObDYjNbE/q
yI463aYSf1RAFkCe7l2aKiKf6o3pqAg=
=BgQD
-----END PGP SIGNATURE-----

--u114+I2HO5OcUYco--
