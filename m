Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B483606EE82
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XkZwQVpc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=GApp9yak
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F7A981119;
	Tue,  3 Nov 2026 13:31:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oU-6klbmdtvJ; Tue,  3 Nov 2026 13:31:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 179818110A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793712682;
	b=WSwU75LgKdJqdVEapIB62Ejit/rGjC3kVGJMiFOJwUG5HwNZdSUxbeYSXGEgB+mmpchP
	 7IPW8rWc+O4HnUG5Xi79kQ7ZNvgxaOV+YQWu1CY80iOSFrcBN9p3anA0VjM8Rfs9DbEb+
	 9cydEqJeoHDLh3h+iTmW3admnfXlE6luUhhReUabPQuCcgJOOYRrs6di5TlxUGbA3tI0c
	 F5gaA28jO2unwI5EWLlBlvTxzgr08MP6DrrxYf9QztvcByB4yCvNOISvpugOGSCp5L3NA
	 rK1c089AfZdqX7al381msKJprUGFaEm0Y3il0bagO3oi8aL33Zt2M3gfMdItcxKBzEA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793712682;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dYwLoedIbLn/imy0ADFpTNjabPEtCBsJ4sw93e8CbRs=;
	b=JKN+2WgVP+k8B4Rs2xTRm66Sa5oANXSzhr43sIUe/XnnngWbRoaPJ91UKHWiNyo/OhWH
	 4KflLcFS+qCA28Cno/bzqbhwGAxaeY/3ATm3rr1GN3bbHRTiz86dKgAYSy6Rxl2cCHkYL
	 k5xftjcHP0f9kcpmeSHPRl50yX+xirtlnSIFR6fRyhLvH6KTRTBuOeLIMHXp/43saeSZT
	 iUwfUes/1JXB4x3nySE+sNOHj0Bf8k+NmL5Sd735IZ9GDS+6X/TiDkd6s/ICdjiWmxKq6
	 267k+lxV+DTFKBX1f8IFvz2l320MXAZ7liSgA0XusYgm5l1lKgiQdokofr0OUk7e1FQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793712682;
	bh=dYwLoedIbLn/imy0ADFpTNjabPEtCBsJ4sw93e8CbRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XkZwQVpc7D3nGc8eMzI9d1A2Yg/buWf7MNryagDw8/8VtBaqpY7Oef8VSgiBSxht+
	 kcn1uuOJOQAGEqS5fyghtDcVVorsLOdvTNQzt+9EBUPfxrLH5FVPBCgyalZb0Ma54+
	 8+C61yamkAfD2ItHIqMy/9VZltiDchVhy6S39pJhInlvy/i22spFMNgjazkx/NBGqr
	 E+3mo5yApi7mSvO0bRdkQEPOTmavbNSCq+Icwx8mosv28alNQgfRnPs1ulLi9Um0FG
	 FaaPtVQ4uPIRfTxzIXteF9Cdjh8mCDkArnboGhUb6smaeJZLqkAKRGlvXqRBmdPtmm
	 I8biOoNhSnSww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 179818110A;
	Tue,  3 Nov 2026 13:31:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 700FED3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5597D40070
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:31:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WrqPfP96QrLG for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:31:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5D65B40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793712679;
 b=QpXg0VS61Fkcr6cxDvIHLBlca8YR2tzdC8zfK0s3gYIRCrSaiU8Pi9z/+S2TN2SM3EKw
 Ihfbn9R78HKWKZlLgqRtLjUqEgHk+pInbrmNU9anbG/Qu86mhQtKxB2eEKU0d/cQc7ToN
 uNUhoMki4Kif6TU1p1ksiDuq4LLA+A0PqNitofOQiik+Hfg+CvFjYiSMHsVffee+aIHp9
 G4IQqWM6lGqTFxNQsNZ9hGL0pt62TxWMZFJTRA2yhXVdf9VT/19o5/4rN9JP33YpIiNFX
 kObG1JO/KX9B9b4yYJx5g76iZDKCCYfNmvkV5aVmzT8TuzSfuC/go6eoSoJ6YWigSWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793712679;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-Virus-Scanned:
 X-Virus-Status;
 bh=dYwLoedIbLn/imy0ADFpTNjabPEtCBsJ4sw93e8CbRs=;
 b=QN6S3SZRKK5hozBwNbPpGB9AYXy/g+zt52WrRWOgcjXGMDLu+4PZsS4mGXn8cgwS0dny
 w2tL+g+VsqUIrExRssMxL0UVwOILzUF42Zdimq3NbRgTAr9p5tHCzJVEoueimeFq9EWwV
 L28cKoorfxA9xl61JpNn7U49cNcPxMHXZAWfxxYGKjCz2oqi6mQrf+4pjBnGYkqq6OBxP
 uQBi4B8cP33vXBjJSuiMDUesOg8ZalYSxKMuaP2OSLblhydeQsroy04TQ2FCXFUnKHhdO
 HszUASTGNRLjmmkgYqJaHhAVb6WEvNkGIgi/NkMoRj+StfWf5Oueht5SBqBR+2yhUOg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 spf=fail smtp.mailfrom=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=GApp9yak; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=GApp9yak
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D65B40068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:31:17 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E7DF84814; Tue,  3 Nov 2026 14:31:16 +0100 (CET)
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D4908404D
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 14:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1793712663; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nkSVsr1PVjRH0qDeBVf/oSiiGDo2GapQOWhZcIte9Bqcp/sf4WpxPIa7zeryyPJXZ1IVLjtAvtIAL2esmXHBfkmm5T0QhHKDuUIHaAGUTIq199sy/MpTZ6mD0nibUXMBh91Xen9NbXMyYz3Y1WqRbXUedPzrbsXaDfv/tikdCNg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793712663;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dYwLoedIbLn/imy0ADFpTNjabPEtCBsJ4sw93e8CbRs=; 
 b=fuNhev9YsAa6wmC3lGdgil0sCOEjcKgaz8EwB0Aqbwi3ZpO15iOd2nFHmzp5UyCyFHvbMNG/hTrfFs53j3qNZ1CO9GNZIiot3nUQW7uKDmLFgQUKHT5+Rd2kBkgmPao0rD+e7Q0ngsqnlDZLwe7BkqfsM+rdNXLK8MOuuj9fWBk=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=GApp9yakkeBDQYQgns0GVFxEPzTOIUfIJIROKK7KWzAwdya1f+8CTIH/mwRRv8kxkr/+yQCERTOEF2r5soy/YntHwUlIytBZ6RbRtOUHttjmQbr3umc9LCEuVYZOmjcdq2Ek5num5IAdTxAhltZ3sNkiyURmUrxnAI+4qR2qG2o=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=dYwLoedIbLn/imy0ADFpTNjabPEtCBsJ4sw93e8CbRs=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793712662028656.0760192355091;
 Tue, 3 Nov 2026 05:31:02 -0800 (PST)
Date: Tue, 3 Nov 2026 13:30:45 +0000
From: Yao Zi <me@ziyao.cc>
To: Thomas Perrot <thomas.perrot@bootlin.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>
Subject: Re: [PATCH 0/3] riscv: Add support for the BeagleBoard.org
 BeagleV-Ahead
Message-ID: <auniBY7vN13FsebY@pie>
References: <20261017-dev-tprrt-beaglev-ahead-spl-v1-0-f9dfdff50f59@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017-dev-tprrt-beaglev-ahead-spl-v1-0-f9dfdff50f59@bootlin.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.698.2
X-ZohoMailClient: External
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_FAIL,
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 17, 2026 at 07:41:20PM +0200, Thomas Perrot wrote:
> This series adds support for the BeagleBoard.org BeagleV-Ahead, a single
> board computer built around the T-Head TH1520 SoC (4x Xuantie C910) with
> 4 GB of LPDDR4X and 16 GB of eMMC.
> 
> Most of the work is already upstream: the TH1520 SoC support added for the
> Lichee Pi 4A (SPL, DDR controller, clock and pinctrl drivers, binman FIT
> generation) and the BeagleV-Ahead devicetree, which is available through
> OF_UPSTREAM. The board therefore only needs a small board directory, a
> U-Boot specific devicetree include and a defconfig.
> 
> The one missing piece is in the DDR controller driver, which only accepts
> the dual rank firmware and fails with -EINVAL on the BeagleV-Ahead. The
> first patch makes it program the rank configuration and the address map
> from the number of ranks described by the firmware.
> 
> As on the Lichee Pi 4A, u-boot-with-spl.bin contains the SPL, the DDR
> firmware, OpenSBI and U-Boot proper, and is loaded into SRAM through
> fastboot.
> 
> The BeagleV-Ahead has a single rank of LPDDR4X, so the DDR firmware has to
> be generated from lpddr4x-3733-singlerank.lua, which is already provided by
> https://github.com/ziyao233/th1520-firmware, instead of the dual rank
> configuration used by the Lichee Pi 4A. This is described in the
> documentation added by the third patch.
> 
> Testing: the series builds with the Bootlin riscv64 glibc toolchain
> (2026.08-1) together with OpenSBI v1.9, and produces a u-boot-with-spl.bin
> holding the SPL, the DDR firmware and the FIT image.
> 
> The image was loaded into SRAM through the BROM fastboot interface on a
> BeagleV-Ahead. Without the first patch the SPL stops with "failed to
> initialize DDR controller: -22". With it, the DDR is initialized with the
> single rank firmware, OpenSBI and U-Boot proper start, and the console
> reports "Model: BeagleV Ahead", "DRAM:  4 GiB", both MMC controllers and
> the Ethernet device. The Ethernet link, the eMMC and microSD accesses and
> writing U-Boot to the eMMC were not tested. The dual rank behavior is
> unchanged by the first patch, but I could not test it on a Lichee Pi 4A.
> 
> Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>

lists.denx.de has been down for some time, and U-Boot has switched
to u-boot@lists.u-boot-project.org for development, please update your
Git tree.

Please re-send the series to the available address, so there's a public
copy available to everyone, and I'll continue to review, thanks for your
patch.

Regards,
Yao Zi

