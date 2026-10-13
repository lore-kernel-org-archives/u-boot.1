Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455FACC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 08:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01CD6406F5;
	Tue, 13 Oct 2026 08:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DIMRd3gYkDRz; Tue, 13 Oct 2026 08:45:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3319F406D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791881105;
	b=Kez5dxKkllQQrJ8HUFKXlUVShLt0tBGHD84ob7PwyE++FvUtJUzBs34/ZsJVqYeWwUOF
	 B9WNrsxE/Wna3KXgj3l1YjojBIUQwtAzhfGMzRmm5tLOLDxuu50xmBmbGDZt92HRoh5EU
	 MIyBaB+20HHxEArVgaJoLYJ8R7Ddm9ltSjFRTVP13a2lcw+QLgvPadjJgQ4+TWT+ITZV0
	 og7RzCs1NYqlbXt5wItwNOuxcOV2fnqAkb8aWK40PN7DuWaV6lGYCZNSDGFsiXOualJ7k
	 9UEX1m3FxOSSc4cWzlZBLFW+sHH/gBjhrdVkcj9MxaszmwiM8H9s/dxMWvl73CRnbXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791881105;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ef8MTpEw9lz884LW51+k0d+aGK/3kbdndM94JNA4KII=;
	b=O/6k7ycxWn1fVTkEEfH0E3N8rSlJXrcrwyLosJblLkEvrjRqABTIIe9/Spn5kPa6UL7G
	 LqY18Ysp+oFFnLEi/I1MKHOPPEGMFE55N2lRZtQfqRM6buboGIrG2G89gfrOPYCF1Nel2
	 8vU4QvKm0KtAy9RZAyT3nNdM4ZRALXfT6V6/VWX+SoophJMCDXrmJQIeeKu5qizdX22Kl
	 FeAjEN2w3pu9QZhPOxx2ekEnKXR4QhbRWzdwOGC0HSi9nKcqoxIUPk3Q3CZS5lfjAdude
	 n+cKat3iwGn2krq1fIWtlqpcVCdIfGFo6X8H8aEaTuMb7mV4/wyFwFB7+47NPzssoJw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wAUhCFSf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791881105;
	bh=ef8MTpEw9lz884LW51+k0d+aGK/3kbdndM94JNA4KII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CSmhxAkSeDyDmdihhgYmIr5hqDScvYHBL4HQhsm/fNhev/REBzg8qpf6dRksU80yQ
	 UnixOLiI6DcK0Gs930LG+LAP57FWn48Qu0n1oBiNCiSuTYVVyFuqxp5smSPAcdFpps
	 3Zqewoaadj9L+dTJ2UMFXEhzeZS/pPg6NAizKNx265KqxpH7v7M2ix8knW7DH/lVMf
	 QS+Gs7TdbJcVEmEY0GgtzrjN7mOAR7J9SPdazTqDCQo5v9Q95prAUWIn+P98eXa9oK
	 iXZ07djtW98bTAmva6hU+zEPJwleC7W60VDUKxfTARQODOwCqbn9vB8QgwY/ebxPym
	 rjNkpC5FzqggA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3319F406D9;
	Tue, 13 Oct 2026 08:45:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C8C8DE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4BE41406E6
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:45:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R1Xwpqgm2LQR for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 08:45:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EAD8C406EC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791881102;
 b=XjU+aGbLYHPgL0lp+zJp5c/y19EQhDGLbShQ89fM0MX5XHornl//5ydv6dg3RNGR4o8+
 uMPb5ZzPS7YESnqlr5Ssny3aAx79NaKQDAjFEfvQlIFwYtoNLvkjBcvmf8FhzVUNHqN2w
 p6pPcg6qVrw5e5OKgE2X+GCxf5H9i9jYGJ0lWdcoRxBul1G1II2+M5dLMoK7KK5Jqjas8
 ojP6uENYounz8ffjtbsT0xxABAIvhw1lxFuCUf5l3meqaOe3g+dvNRrINPCqGy1y+DxmP
 WPDUcVExLhznKuwkVHLj4S0Ou1IwVbUBEDz0LNy/1pwwDfCHbsKN3deli4+VQ60JJ4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791881102;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Last-TLS-Session-Version;
 bh=ef8MTpEw9lz884LW51+k0d+aGK/3kbdndM94JNA4KII=;
 b=SMw6o/CALwpdsKPQFqtSVJk0D4FJyYOFHoi56HT4gA7n8QWcjDUJFRTsb8gtz3WHA+En
 JKpU0TOY+8Sh+eR583S99LAwApVi5T1tpph7dPTxPqcHPcyGwtluSwn/D2cykUSo5sXEZ
 g/G0oqiG29Yhe+FNrtDW716kVl4fuUAdBVyd3YtQFAdulztrmaYEgySl4uYK5kXQhZJcq
 1KmMJ5ekc8JB7PcQDrFSZwodmamsxAth5ZyhQS/iON35BzUBHluVNLWugjCTOu0C2oBl5
 KSBvmNQIPrdzyTzQjDmOSh16vpIPaLeE6HMk7Wh0WsZ9FND9Yhx/fmceNmp56AKvJuQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=wAUhCFSf; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=benoit.monin@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=wAUhCFSf
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAD8C406EC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:44:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8E0C11A11F3;
 Tue, 13 Oct 2026 08:44:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5ABDB60362;
 Tue, 13 Oct 2026 08:44:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 967EB11D703F8; 
 Tue, 13 Oct 2026 10:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1791881095; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ef8MTpEw9lz884LW51+k0d+aGK/3kbdndM94JNA4KII=;
 b=wAUhCFSfWIjMfIWCX7L+H2vjl7tI0lQYB2tCNz7ncFQbjHIG77psiKJtb/72MTajcj5fpo
 Ls+FjonC5mFpav9iRCmKHX/I7u800yqM/hdYPvGDo+XSRodhIYovFB7++xzeo9MjjsRP2y
 l/EbAEchd3A5KB7uh0hdSFN4aWHxtxwusWt8BVKEd17+8zFvK3Sfh+cZHbgeCOOnnAuC4/
 M1mZhA9J+g07gRjJstEljxvifF7p36Z8qZCnmG3loTjHq6ggk9bUkqToHDN24mh1yoz5XI
 D6iAeJ1EOQbOuqPoMl/5wDmSKbG2cU5kUMfKM43lyPEv5UNlWhdAAPjwdznaNw==
From: =?UTF-8?B?QmVub8OudA==?= Monin <benoit.monin@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Torsten Duwe <duwe@suse.de>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Guodong Xu <guodong@riscstar.com>,
 Alexey Charkov <alchark@flipper.net>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Jun Chang <jun.chang@metanoia-comm.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bin Liu <b-liu@ti.com>, Hiago De Franco <hfranco@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Chris Packham <judge.packham@gmail.com>,
 Randolph Sheng-Kai =?UTF-8?B?TGluKOael+iBluWHsSk=?= <randolph@andestech.com>
Subject: Re: [PATCH 01/10] iopoll: Add readw_poll_sleep_timeout
Date: Tue, 13 Oct 2026 10:44:43 +0200
Message-ID: <nBD6dl75TDC_DlOXVRYkBA@bootlin.com>
In-Reply-To: <20261002152557.GS858934@bill-the-cat>
References: <20261002-mt2824-v1-0-bc44cf0e0289@bootlin.com>
 <20261002-mt2824-v1-1-bc44cf0e0289@bootlin.com>
 <20261002152557.GS858934@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3
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

On Friday, 2 October 2026 at 17:25:57 CEST, Tom Rini wrote:
> On Fri, Oct 02, 2026 at 03:02:19PM +0200, Beno=C3=AEt Monin wrote:
>=20
> > The readl poll API with sleep and timeout support was introduced by
> > commit ce786ae3913f ("iopoll: Add readl_poll_sleep_timeout"), add the
> > 16-bit variant.
>=20
> Please be clearer that you're referring to the linux kernel commit this
> came from.
>=20
Yes I will clarify the commit message, as ce786ae3913f is a u-boot commit
and it refers to kernel commit 5f5323a14cad.

=2D-=20
Beno=C3=AEt



