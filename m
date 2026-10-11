Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FEBCA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3841D80DC3;
	Sun, 11 Oct 2026 14:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y4iEck0UlCBg; Sun, 11 Oct 2026 14:39:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 29F9E80DB3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729570;
	b=LdOdgUwRtdMzPPvJ4bYG+R3AGl1H3dOuAU1PgDbP2/o4nkGJwiDcK/5Toa2xhVIp6H/r
	 sGAPl09htBazLa/fvfg6aOJ1OLJQkaJIP0tAidD18YPmrvggWkJ7DSGE7UWXVUD7FMQR6
	 jxyEqgd1RuvToNni5KBxFMOmRhZ5gyn7Qo5emU/G623kisDYER0mD+iEYapJWSFBaxU2V
	 pQeqH0H/4U9Q3iUgiOoKRbs+KeEFDgMBXkMmCkgAhgX3BQXCuUoXgRSYv0/1abK8owUEV
	 /XgG8TCZ0a5djCuLyns8IjNVoLO/5Kxjn2+2lueayR31bP/SYshDl8G/TgkAcsEyiKg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:X-Mailer:References:
	 In-Reply-To:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=a4/LoVHBs3fEAUda34sfy/UaUjyO+ac8RQzavAuyPNM=;
	b=gGvAXHC4xlntLdCA4Nq0JQmxvKsTcM/LCCqCHVH3PZIShOjnQGFGy/A83/1zf5slXmSk
	 JoN6k+Rqm8BsM1DSAH5jY4SIhoDiCQ+SHfF4pDjsA2ccogji1q1xDvhkS2LtRq4CjkwAm
	 76O3NwTNJy4d36nVWDod0Ou5y/+FjQQUVTQdjwDohkQTCbcCVTEOVyrA2EvD4/0IZm9lR
	 AQKRERMoojSYrQylrs17+BToWfJ8QmRjfrFEalCeWbiByIjsPub4L+wg33cVay+koLuVl
	 Vpa+opD1+Ugx70hlWeHsU9MbGa9TUfYTj0KJs+oNxdIPbUI9aOFOmK6BoHHX+jVOKjA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729570;
	bh=a4/LoVHBs3fEAUda34sfy/UaUjyO+ac8RQzavAuyPNM=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PS9Qn51pWVAsChiIwrCpgviCg3Ie3Yd0zx81QprEHGwBYnOf+Rjy/i7XlWDc8mUXA
	 0BqUnrERPvG9Hy5/kHLV4AwN2fE0Zj59/UZC8Z/yFZ82+0vFgUhq4qeTMyNghcLsQK
	 ZoktoUkS+C5rzTQK4bUm1I2kOacbFdloZSadS2n1lCkhM0/wx+WRGR7Nwkzc4pT2gf
	 F2LRlPk0HSJUILNvVzSKkoKr11aBYBhM26oIeuHdMZten6U8x7m714tNL2mhD8GgBz
	 vQzIAOALQrQ3tuo2gqz90dSrdxEMU4T97bE7BvluwiHD3oh3mWhfAjnkc6JjfoRPL3
	 LJusyyuyyGLlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29F9E80DB3;
	Sun, 11 Oct 2026 14:39:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F7339DF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E875E400D5
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:24:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tsf3YGDouENB for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 07:24:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D33A940042
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791703453;
 b=C7I+eQdIE0QDPGWnPmU5fBDziEetKFZs6F6n7xhM5WkuER0m+5Mj7e9CPocmwmPtVt6s
 tSp6OJvMa1WfEphrfUo0YU5C/r5R8JreQrs67eqdvdMF95aPgpTN+wj8M7kYXg6y8i8xi
 4s3OUFqwWg74Q6nLefyk96oTy3aT8v9HnV/6daElbvD6VNkgGbCP8UtKOW44UQcCMaYcu
 NcxBLBzXavSRfQZH6ufp0GYgu7/7OI8OnQh8WftUvI19wI8oT+LmZbOukmcFIl2OYpHFs
 ryLuDy6VDqsQpCjuIcN5tiXS3ZktTf/RLPghEQF6FWgRj6Sc89BWKPFUpdEPDaH6tcg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791703453;
 h=Received-SPF:DKIM-Signature:Received:Mime-Version:
 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
 From:X-Mailer:References:In-Reply-To:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=a4/LoVHBs3fEAUda34sfy/UaUjyO+ac8RQzavAuyPNM=;
 b=a6gtCX0VnxndWtUJxxGE8IE/jFQImx+9BQaSfwoDIpZvcr0ucGey0S+Bv2TMu+JQ5Pcr
 hxZfZtAzwMOKfBu4syI+Oe81rd8QY4+B5aloJ5j2AIxfluAxaAULUTfcdrB3yG9kod0uM
 bzfyF9r+GKLrGpGcd2spK1dE45k6iZ/mpi7GXh+5Hr4gB/aqa+zVzRkQxFz5VYud1tywp
 XH8tBdFMzrqK2XSL5eMtXZAC3Pn/afvsVxJtRVDRC94wLtHQmJ0Za+4x+3jkZPN6FUgDN
 9lCitvDJnyhk+2j59PlW0vZci2XFd12578OTYK33iapXsuubwYU/H9SNEhlpKj5wl9g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=zohomail.com;
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=TMjNdjr9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=TMjNdjr9
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D33A940042
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791703436; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=D652FESvDiUvEIe6zkKP+uJsku/T+RjaOz3Y4q47dOSbWlL8f1AsizU3T00nnf7PEOWgPrcGMT1FLBPDAsM2Tp/y1bygwdnZ8pudTfIxeJKj/LB6mOU1tjNkEPKkkLMnxgOEGfNEQLdXPr7Hjmp+apNNo4ZY/q0a5mMaaTXOS7E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791703436;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=a4/LoVHBs3fEAUda34sfy/UaUjyO+ac8RQzavAuyPNM=; 
 b=jjtHGwMNwnMeCStnS2c/yZOi4aNd61oUUVY3Xro1fxX6x3P5UNJ4s/Gzg7vtktFIOazbVb0vsYKthpV6RVSllgX+0ULSkpzKUBIRF0Q4AjY0Q2yCot2ZaAqoG3KtVr/baLrTxTk216aAM3XB4jtMnv8hcLvaB8OdAVT1LDmUvYE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791703436; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:To:To:Cc:Cc:Subject:Subject:From:From:In-Reply-To:Feedback-ID:Reply-To;
 bh=a4/LoVHBs3fEAUda34sfy/UaUjyO+ac8RQzavAuyPNM=;
 b=TMjNdjr9g2H7YwsF4tkG6e1lzULrjGz/jntt7YfP3JezsflnhC7A9iVysJX1lAjQ
 X+WqoSs2fSXS7rBQpTOocBSlgL1SFlL6d/QfuP51cy6M6Jc/nG46amJyPo72g/eWwnJ
 y5Vauw/LaLGwpYU1BZkYehT99oWrAdK7GFaJUUzA=
Received: by smtp.zohomail.com with SMTPS id 1791703434261459.63924928022277; 
 Sun, 11 Oct 2026 00:23:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 Oct 2026 15:23:43 +0800
Message-Id: <DM1TUTXQ9GD2.6SMWWXF2TI4A@zohomail.com>
To: "Hiago De Franco" <hfranco@baylibre.com>, "Yao Zi" <me@ziyao.cc>
Cc: "Leo Yu-Chi Liang" <leo.liang@sifive.com>,
 <u-boot@lists.u-boot-project.org>, "Tom Rini" <trini@konsulko.com>, "Tim
 Ouyang" <tim609@andestech.com>, "Zhuxu Ran" <zhuxu_ran@zohomail.com>,
 "Kongyang Liu" <seashell11234455@gmail.com>
Subject: Re: [PATCH 0/2] riscv: cv1800b: Milk-V Duo boot fixes
From: "Zhuxu Ran" <zhuxu_ran@zohomail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260930-256m-fixes-v1-0-69546876ff28@baylibre.com>
 <asa-S7LCji4uX4af@pie> <asj6OaDxcTTEUvm6@hiagonb>
In-Reply-To: <asj6OaDxcTTEUvm6@hiagonb>
Feedback-ID: zu08011227ae4163a3c6927aac2c3b32630000e864575342d608cc0e1f4464b39fa8e14e37e9260bfa60696d:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sun, 11 Oct 2026 14:39:24 +0000
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

Hi Hiago,

Thanks for testing this and for identifying the dependency. I also
reproduced the reserved-memory error on Milk-V Duo 64M with my v5 series.

I would prefer to wait for the next dts/upstream sync that includes
Andrei's two changes before the migration series is merged. Once the
sync lands, I will rebase the series as needed and retest the boards.

--=20
Best regards,
Zhuxu Ran

