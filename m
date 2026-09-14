Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D91C88E73
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 20:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA2E4605DF;
	Mon, 14 Sep 2026 20:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pc0HU7QBZV1H; Mon, 14 Sep 2026 20:40:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 45B20605EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789418429;
	b=FwtrUalDeaNKhghvbFGugpGouXs57FAeTTswxHxcvxo/GYLPXvdDKCtJdvJBhuMmQlZJ
	 /72j+CUvryCpqjlqXsV7TXoYVaAFvvYZJckfRK5O2yxogZbBK4vBeSh3ZHU/CB0GXSyT6
	 R59Ms7rGafXYjpnjTdo3OEy7TCJUwGY6nN+KQErzpsTtdPCdY7F3I/EAXHzVxhowqoKBe
	 9pNDaHfCj5+hGt6nyDGfrWL3p/j56LUjCOLhdJm28qHBlqyqkg+2afLgBYU3u1spylobS
	 yg9aUA8tC58yDOvoaPupfVxRzuX3D1Wp7zDDsW1H6nDUUcqLGaQznUuBA/qt5i+7Exw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789418429;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K6vy0na1GC55OpOUiBVYU3e2IKDUjJ5n3UetIx42iDU=;
	b=e/VWXZyJ4YneJvIMepjbGt9jVQenJ8w5Wxp0HBfEIMzuGo1WObMAhcY4Wxxx5N0sV4q8
	 Nv0V8ssdJP4hG+VxcK//GR3kjhhSxaVvESQFw7xDPSGmHomDw0+n/v3n9HTgm0T83u6bU
	 qfvYaY2gxg3F71OYhEQHwFM/Xsj4nrO0NbQx1QJGtAWJdBBszuTpY/QOrEuoIQAyJXmmn
	 QHTLubPOnaosCchC7nIftTSGigMkPIYUb4yKnNgwWe+L2UORgPKAnIUtBmz90FqJgun9i
	 L1754WvhnxbUgf4ADsaKMRDpcP38JsF+VhgSMMCTaJeLrj4COUy3BZGbyoWywErJO0A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789418429;
	bh=K6vy0na1GC55OpOUiBVYU3e2IKDUjJ5n3UetIx42iDU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KIdeeeTR0N8IN3Chnj0NszxfyC7IVphpkDkwig6MmmQdWIJ8m62cFFH4b+i/RjVMQ
	 S7v4AdwzKeJB02nQ7Ryi58Z0CEKABiOLiKsi0H+a/qWEMWYFU7xOCTHeoUtSX9oWG+
	 B+k3qcC+iRHcUudZlukoj//6Wb/EyaTAfu6Sih6iWVXfvOlEFYfEWn7TXsfAIjv11p
	 bpttJDCwdVKnJJZlpMiXIE+RLnVn9WD3WtN8mnXLrWFYao1O02hw5d5SixS3s4/Hgt
	 dOwU+r5PZTqgQ4mLOxphP8UO2euizLCbqjDtZ3jbx6GWSyH09CfVGhz+CrPoUzcnA/
	 lLi9WXKjNLhHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45B20605EF;
	Mon, 14 Sep 2026 20:40:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2113C493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1293280AB2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oFqJ8puP_nGn for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:40:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 74F3D80AAA
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789418426;
 b=n7WBuq/+ydjdAsaPPPfAJJKO/dQS9hgJDSkxTi+idA97kaVoDTipOD9rKqgH+bYoAhmQ
 CsYYqjACUWVRmh1GCPqjEHN0xGovfuyLlsOnm9sP4LdxCpAWljJdTuhuyEwFBuLX6QHnY
 B4+vWWEFG7H6YRbFX1qH5o0eOFbLDR3HrUZJogQyApDIDb5r+xflPYim7+V1kvKGXr6OM
 umU/03wIjDbomp5dGUkrPD0rVNhkHu35xw2xY+xO5zwAXKumyVzZzSY0pqH0VFq8tw/d1
 pSotIhnASRke0ur3h2fpnrXlh+VYDct7dOIZlaC8izVX/gVPODAkYJjjdxr2uLi4cig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789418426;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:
 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=K6vy0na1GC55OpOUiBVYU3e2IKDUjJ5n3UetIx42iDU=;
 b=XyIZfAaanORO5y6Wkbo7t0MH4KW/VHxYEXS/b6yG2M2bUXSlRLOTVb9HvusCd4A1llQf
 R/0zjbfvxOa388eHbQrFn0dFXEL3ljIHorUeKcJx475UBnJYrW6ybWz2Nt9oftE+R9t1W
 sFMpWpId/RJQM250dencBk03GDStY/bpzhBVvatF6dVTVvxai/CVY3jXW82jonpDRuhvJ
 0j4qUaO9z+Cp1Aag5tt76aTNvWPh6WKJepzM2YZTtAyrr+WI88OtE49m+cqNHbyfGhYlU
 vs8W0GXVyDqVJPT2OE0mCYbT4mTFudVz3IGobzMontxEBPIaBwyC2kW9cq6hUAvvzDw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gCLZYhre; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=gCLZYhre
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74F3D80AAA
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:40:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 185AB6025B
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E081F00893
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789418423;
 bh=K6vy0na1GC55OpOUiBVYU3e2IKDUjJ5n3UetIx42iDU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=gCLZYhreJwcpOBvSiegsm6/NTPrpGwjWE4YK7FNV4s2ZPMqSBiyA/kerML2x48IN6
 WkgeycZdOmJa/bOLytyJEFnTSb5tcnMgMYjHc20JUBRdDLFpTSAy1tSDpSU37Bzd/m
 QLUysvnrrhHZ2x/BD0oJGH0tbbEZMSz5xBcTN4fE1h8mMaILBFYTTks5PA/khCwb62
 VV1c1c89VRNaYRGELSmwS+NbJaUtTx41LVjRHW2+Ca7Z1bSLk0WBUL8Ixxc1E8BMnD
 ahysuqoyn1N/V4LW9tawtFKZwOPK/ED/caDufWS5r/fqRcxIaWMN8e9NxdcE4y8euj
 OVj/oexz1Zryw==
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5b754cc3b6aso4123704e87.2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:40:23 -0700 (PDT)
X-Gm-Message-State: AFuF++naoOuoJH8/Pcea4YZKL0TCZHn+26i5iU40Ufg4uWpw+s7BwkCw
 Sm08U3muYTZ5UKH77nig9y/W0bcVpENx6vUwRbtZ6XiZ+Si5XpQI2he2hHgPNkJO0DGFlZieyXz
 F5FDr6xic1nm1uAdJ+SUItxd2q8qhLtU=
X-Received: by 2002:a05:6512:3d1d:b0:5b6:1a7c:aa14 with SMTP id
 2adb3069b0e04-5b8ae6b02bamr1084799e87.44.1789418422529; Mon, 14 Sep 2026
 13:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
 <20260914200914.GA625059@bill-the-cat>
In-Reply-To: <20260914200914.GA625059@bill-the-cat>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 22:40:07 +0200
X-Gmail-Original-Message-ID: <CAD++jLkfBaAvq7PySwyT41Syx6knHtbk1Ef=LYP1LN51pRPd2g@mail.gmail.com>
X-Gm-Features: AcwNN1XMiu3aYt3WaYdV4k8KCyED7m0bgffdxUbkpqHaNQgqEQBmP7agyBwh8qg
Message-ID: <CAD++jLkfBaAvq7PySwyT41Syx6knHtbk1Ef=LYP1LN51pRPd2g@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] arm: u8500: Enable upstream DT based SD card boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Sep 14, 2026 at 10:09=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:

> OK, so, the problem is that since they aren't in Linus' tree, they may
> get over-written with v7.3-dts once that exists and I do the import. Can
> those changes live in -u-boot.dtsi file(s) under arch/arm/... until they
> are available in devicetree-rebasing? Sorry for not catching this
> earlier.

We can just wait until they are upstream I guess? I'm not in
any particular hurry.

Could you just merge the driver patches 1-7?

That enables me to work a bit with some MMC throughput
improvements on top, right now it works but it's slow.

Yours,
Linus Walleij
