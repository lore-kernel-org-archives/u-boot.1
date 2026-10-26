Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABBF606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uEu79Wpw;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=XK1GvOT+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E054606EE;
	Mon, 26 Oct 2026 08:43:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Y0d4lXhK_uW; Mon, 26 Oct 2026 08:43:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52594606C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793004225;
	b=XfRUQhwpQuTR88Spg2w/mDppbdyAXywVH5WKahFD5VC+HzpYglPS37S9dQ5SHrA78xh4
	 W5CNEbeVdzDcKsrksc4uukeccDen5JROfvbWS9T26tyDFrxOwID8ThHZLWEBLFCHGLQzS
	 UznUrhQY0tsHaLj5OXC0TGASc2mqSH1nB21s27fdpz/jPSjYeOG5egwUTyJLeU7KF9saP
	 42foECJg/u2sK50r0RQCuccRjkCu2pdkE5M/Q8HwE4tv6ArOHKgZhe6B7Q0bS1l1t5dwV
	 X5LMNGcSeaCI6EZWylF1n5fxLnIsavqVMat9masHw7FN6vxlNpYfoV2FYcbPeUoqwNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793004225;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pDeDpfz8u52h5w47AkhOYzKnxSq6OjX9ymrP1rEFRAY=;
	b=VQes+Q8bObPODNX9x7t7q057MdpF7KRekOhv6z02Ux3ygmgQY3qudw1fAtXSPAhWq72z
	 G+OJgGYYaLMYJgJSBtz8U7R6kOcaHQD4LOTnweA8rBbQig+UCT/YCbmEgGvgIKY6lOc9S
	 CjKtMKmtlwHzUkMiHZ6+EX0jKJoY6QyPRHITFG6u4usqkaU8JrzTo2kRcigsrCCezPEsL
	 WKyaPlIsbHGMPA/pzgvLXzB5c8K14ZXZ8M5ubuWeTD/Qi7yHmm3y4QcpMksxVbLIju50D
	 ZCXl0JFU8qomOWMDBZpkXyZUDYnmog1gnV2zaBmFPXPhCciFn+MQAywcJ28ffY14dWg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793004225;
	bh=pDeDpfz8u52h5w47AkhOYzKnxSq6OjX9ymrP1rEFRAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uEu79WpwwZJd+3WEswXwTQLFYZfnfwdXWzRBdzvo1/bkRRKEMKCFZGnmTe4M3ngOz
	 isFBvWm5I2CRnTQDbdNJyZAJDWuiCkGleEJld0MNbeZWatYS7BYeyz4bXD9Yq6okKa
	 BBdhKV7teE98lJQhRgADRhTKwHcM1joUjtYcLfvs4m/pHJIDXDR2cHxlTmnpQtdlKs
	 ACQS3ggg4HIgYwq61IKatti9hNGutF8XzFshVFmVk0qrgZdb02/GI1m/nHF4hN9PVN
	 /yT+TSW9rflfiZQba8NmsDhKoTZJjgk/gsSl/DMu3X5neOyu1ETLyJsKo0eq4xrJHu
	 bss9ZEPhdI92A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52594606C2;
	Mon, 26 Oct 2026 08:43:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14A88380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE40C405F1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:43:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CsR5-lIhWIXk for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:43:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F678405EE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::14"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793004222;
 b=kvlRLNZiZZLOV/UsXxr7z5TfvxcbLPOFvI/wmq1boLeamKPUFAwca1iptT8obxhOCwuV
 CAaKZtBw9IVxW4/os65mcuOPDOfrBbphA2cQZ9uffDnkdEO66nia4jrx2c/5bDAmV5FUR
 E+mbVXnRdEC36SU9Pi8PpmCs3ROrkzLeg32dI4yTt8zNfLAjXdJ75VYFNlxjbjkBqXk71
 5Y9OfTzIuGnHew7IZLbpRFeBmHY0n2wrFXj+BfQalBdX4UEWQcCAT/Cr/PkfMyoM+RoHV
 2l6fRplltaWJS62LPXz1IgjF5trsyO9OHXPrmzyWAitGh+i9fV2SE7MQ1uOAmQ6AEjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793004222;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=pDeDpfz8u52h5w47AkhOYzKnxSq6OjX9ymrP1rEFRAY=;
 b=j1ZES8PXYlhm22csxyQ40E7cYUpGpAAjNyoGFIbdqZfEHwgXSTWRfJt/kv6hTK039ZXO
 iGA8UNAbiTXwYjz/VTxymykdgnY2DfYAP0olk9VcFIMRO/IPOjgBraGpgliysHjBOxvx5
 N07AKzBo/uE5p6zFQSY/fcREIWvuVYSVmZIZ5km2dQmc9dN0QpPGsvmbIFT5kN39j8nzA
 ICSDhPS1GVRY+HvWvMZx7+WY9GMRFp/khqZavM+Llevq3EO0l10tNfP81dgDsy76ZQc6u
 KNprO9OISQNRO7Fn8CYVdi+CKzSXa78nrkTN8V8pOTwFBimNWWizIP7wqaGlpKfskKQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=XK1GvOT+; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::14"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::14;
 helo=smtp5-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=XK1GvOT+
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F678405EE
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:43:41 +0000 (UTC)
Received: from L30177.local (unknown
 [IPv6:2a01:e0a:ac2:22b0:d97f:b2c2:f90b:121e])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id A53F25FFBA;
 Mon, 26 Oct 2026 09:43:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793004220;
 bh=kzXLW40TmIg9KQZaKIh+FYDPutTh71hWZ5pohVKN2po=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XK1GvOT+75eAseS2v9xC7MIDH+ooN9Qt1M2Wmk96ciV9LiRvSiuYjrM0PA5z2SLIG
 5cvK4DsWSRN6+6IhT4I86kG3r64UWQsNjnj0jjSbMpIUdHRG2DCPSz965YfzO4Zqtr
 DMQWDVz7FdMJiOLd/4rRkJoF0Dvd4QbrOcX4y8Gxzm1iE2zcAAOmHmtLX+jmg1pO/g
 pJ74ZheGB44k2cykjvEHA2J4EXbShaDyJX2r5TLsfUKYmpJ4m3Ue9dTggSVVU4b5mr
 TqB+fCpTeDjvkOKTkBRjBuD3Es4EkSJ4SIxS76MSrCKwLHeSdW1zSQlOfpOFdzK8aF
 ZSE50ISi5xBWg==
Date: Mon, 26 Oct 2026 09:43:32 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Bradley Morgan <brads@mainlining.org>,
 Sinan Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Message-ID: <at8StA3lzLMDbcrR@L30177.local>
References: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
 <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peng,

Thank you for applying the the lx2160a series and the other patches.

If the powerpc removals need more time after Sinan's remark and Tom's
request to wait for the board maintainers:
  https://lore.kernel.org/u-boot/20261022014554.GN3275858@bill-the-cat/
would a pull limited to the first 20 commits be an option for rc1 ?
They are below Bradley's series, up to the commit
e7fbf8d2233 ("board: nbxv3: apply sd1 hwconfig before MC starts")
so the SCMI, fsl_espi, pmbus, ICID and SerDes patches would not change.

Whatever you prefer is fine with me, I only want to make sure the
question is asked before rc1 and we do not miss the merge window.

Thank you,
  Vincent
