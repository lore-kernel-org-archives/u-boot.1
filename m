Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922E9D1358B
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 23:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B43648899C;
	Mon, 28 Oct 2024 00:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=khoahoang.com header.i=admin@khoahoang.com header.b="OAliiYFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBDD1888DD; Mon, 28 Oct 2024 00:15:05 +0100 (CET)
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com
 [136.143.188.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE89188730
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 00:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=khoahoang.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=admin@khoahoang.com
ARC-Seal: i=1; a=rsa-sha256; t=1730070894; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lm9EkrIPpsB7W4tjZfhSG6Ki7fP0gdLmfzSVJt4mEti4CncPSdJAjWSBv7fmU/XoF7pkv6ZOeNuCWA+V3l8oryaHUSbIEQRK9JMmt3zU8Zx0NnOHlM4BrwSbQbnRYg9L1AvEw2Q973NuAgdBuvLM/zBNilX8/dL/dinwvp7wfig=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1730070894;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BosYCdJSfKrKQLBsZ2U1dv5RqOr4tWv2S6hY04DGzvM=; 
 b=KvCyrzhH7dOvx+BoiBbIkFeTKsW+K90SOE9jGAAtNuzDNDjzspRA35qOI3H2T0Th/580zWgZd2qOxOmnOVRTU2ApQCZWF51CpezCLUct4Gm+Dq6uIRgZ6DFM5iDPClRlT71ZwJlCj0Pcwapu2HYIBKD5Qu90LLfTKHoUmMfPNyc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=khoahoang.com;
 spf=pass  smtp.mailfrom=admin@khoahoang.com;
 dmarc=pass header.from=<admin@khoahoang.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730070894; 
 s=zoho; d=khoahoang.com; i=admin@khoahoang.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=BosYCdJSfKrKQLBsZ2U1dv5RqOr4tWv2S6hY04DGzvM=;
 b=OAliiYFCA0pj8UBGsaGaC6Oie0EzF+c21u1iLrvGTVHW/GRp/WKaG8HL2l2GEmxD
 a1xJ+ws29gLRaDDlkwwvtDdSiK06FVg/MGEKzhDVAs9QoSdQfN1jTQNkiFDoGZdjLjc
 +beoq+66loeft13/9ibPceGmc0dvynlt6Y8Io0Z4=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 1730070892026200.16105660111248;
 Sun, 27 Oct 2024 16:14:52 -0700 (PDT)
Date: Sun, 27 Oct 2024 16:14:52 -0700
From: Khoa Hoang <admin@khoahoang.com>
To: "Marek Vasut" <marex@denx.de>
Cc: "u-boot" <u-boot@lists.denx.de>, "Tom Rini" <trini@konsulko.com>
Message-ID: <192d042cde3.be30af8c153741.7905134334586786560@khoahoang.com>
In-Reply-To: <45e7d331-f72a-40a2-8519-3c81ab00ec8d@denx.de>
References: <20241027051250.35627-1-admin@khoahoang.com>
 <20241027051250.35627-3-admin@khoahoang.com>
 <45e7d331-f72a-40a2-8519-3c81ab00ec8d@denx.de>
Subject: Re: [PATCH 2/2] eth: asix88179: Fix drop of large fragmented packets
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Mailman-Approved-At: Mon, 28 Oct 2024 00:55:44 +0100
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

---- On Sun, 27 Oct 2024 07:43:26 -0700 Marek Vasut  wrote ---

 > On 10/27/24 6:12 AM, Khoa Hoang wrote:=20
 > > When receiving large fragmented packets, the ASIX 88179A can drop=20
 > > packets due to an insufficient URB buffer size. This change adjusts=20
 > > the URB buffer size to match the configuration used in the Linux=20
 > > kernel, resolving packet drop issues observed when performing TFTP=20
 > > with a 16KB block size.=20
 > Is there a test case ? Can you please include it in the commit message ?=
=20
 > =20
 > Thank you=20
 >=20
To reproduce this issue, set the following configurations in the config fil=
e:

CONFIG_IP_DEFRAG=3Dy
CONFIG_TFTP_BLOCKSIZE=3D16352
CONFIG_TFTP_WINDOWSIZE=3D1468

Then, run tftpboot, and it will fail to load with a timeout error:
=3D> tftpboot zImage
Using axg0 device
TFTP from server 192.168.128.130; our IP address is 192.168.128.244
Filename 'zImage'.
Load address: 0x20000000
Loading: ##T T T T T T
Retry count exceeded; starting again

I=E2=80=99ll include this information in the commit message in the next ver=
sion.
