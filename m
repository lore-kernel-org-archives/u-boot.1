Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76157606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CrCsemRw;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=WtFYSkpV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D4DC406CC;
	Tue, 10 Nov 2026 08:03:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Omq4WI2GwS8O; Tue, 10 Nov 2026 08:03:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7EF81406D8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794297807;
	b=KfPsUb5hjnG0jIchhveE1F8dgFadxp8pPAWHTt0b7XKjAg0UnjdhZBYAbPRmaidf8kRO
	 SEH8v1XVffATklysB/cS4AIftUrkWfXfZVioq6JhWxNt5HZCk7pbLdCKBvYD6AkhCZSjD
	 nHO920sIOEalkzW3vlQ7UBv9+gNVwg/dEuFbuXjs5nXt5CYywfwSHRmvxa8ErG8oBJTG/
	 Ve81zzz4YVqnWg6TnO0wUGbWWxJ7zs+ThePFVw1Di8DXtp/8lkhe3a40AV2t/u+iFvf9Z
	 EM+3fOHiLh6YfboVI7VRBKMAhbd1F5nRz6skh97XHbuVauO6ZaVBi9AJlISS3/5tdBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794297807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YGUk7KmhDxQGTq3Yb+BdyHqZ456875QJRsNent/rc5Y=;
	b=KNzSlQExYC4R3xJLM8pyy5MpOr3kz+xUBWfT1/S4219bmFy6osUg+uY+Cb56a3OBl2jn
	 vBrjYx9PCu6/HFq+AYp/cHuNHgCtPHB4SWKOA2AIE2Pan1ootGsAcIerUPYXLFOliiRFM
	 iZ5dU0ZwwShCWWhcZLIAQCZgAbSRabVTwyrqDugRbO9KabW+MYNvJXNBPZFfY0RuJoEmL
	 dbUmv6J0lXvfAMGJUWDU2tXtFJwGX6S5Nzcq59noBwW1ZKtJdIUF1DDDMLEWg6diKWJoe
	 S5lW4bxL1KuoV5ISUo8PXO8t5xEsXomyoE3NOkhInqEqDSiWquFCVWBKkskRg0ZRodw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=WtFYSkpV;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794297807;
	bh=YGUk7KmhDxQGTq3Yb+BdyHqZ456875QJRsNent/rc5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CrCsemRwjmJrWFDvnTvtf0U8bftu78vc4oi7Vie1xzVSCe3dqIT9gQeoPZKYMbGMR
	 A5dQh4JFYd3c04n324eTHBod/abreNRcadDOrpYfxFh1UBJN5MG4mf2C3OdOAF99Iq
	 V/CEihJma6RhmywCsjA90jn5Jh0Oyvz0+ZqvmsUNyVtmeHcROWl+LgaYUoEFgPGMHe
	 T91Wyh8jzfSe4CWUgvmFCWAU37kk6dCVOs9bW8W/UpX9O3CAIOMplzcjAvwCr8uP/G
	 DEH0GUWYBlpYyV6kN0C42yMliIzQLoUnyLJJQxnLyFFeIgdzV0bobaHNCsKAO8811A
	 USc8+iC8stHrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EF81406D8;
	Tue, 10 Nov 2026 08:03:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5233631F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37ADB406D8
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PXXj4xi_4d8N for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 08:03:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 07DE8406CC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.27.42.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.6;
 helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=WtFYSkpV
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07DE8406CC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:03:23 +0000 (UTC)
Received: from l3017729.home (unknown
 [IPv6:2a01:e0a:ac2:22b0:465:ee79:21f5:acc4])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 0F75F78035B;
 Tue, 10 Nov 2026 09:03:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1794297801;
 bh=MtqtizMyasV9W91bpuxNekawwvLivkHZI4Ydjdbb90g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WtFYSkpVPwRh1tswmJpZKXZcOfRXbU+AFlWXt7OfNjYK4YCyMfML4AjtMhWPaZuuI
 /sH/Xl6cK0tj5apy1gN2ewUvGnJhFnZTO9I5jlupb/fioCRNi6GkU0tOaCiJVU37V0
 jlFlT59NbfgTo9Pgfw5b/fbrxR5+qhLQHnemRTdfhmNk5inxyWSq12XMJcR0GSKIz0
 XKlY2Pt29G8+Q19z0jUNmbgt9OFgfGtH+Ksp3q9iBZSH58H37/P+ul7wLyu12Z98yv
 5t1i9pXXO09mAHVxJbSJPdk/KtLhuGSpfkYeNVM8PPP4bThd/pXWD4BgY7aZ+jvw0T
 B+1yuYmJwdSZw==
Date: Tue, 10 Nov 2026 09:03:11 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Tom Rini <trini@konsulko.com>
Cc: E Shattow <e@freeshell.de>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Denis Mukhin <dmukhin@ford.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Suraj Kakade <suraj.hanumantkakade@amd.com>
Subject: Re: [PATCH v1 0/3] dts: build the DTS from a directory outside the
 tree
Message-ID: <avLPv24pc3fZ42nj@l3017729.home>
References: <20261108155019.1485598-1-vjardin@free.fr>
 <avIBHFyUj8mDk6PQ@l3017727.home>
 <20261109191330.GW3741582@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109191330.GW3741582@bill-the-cat>
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
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le 09/11/26 20:13, Tom Rini a écrit :
> It's a fine line to walk. Vendors who are trying to do the right thing
> should be encouraged and so not walk in to "walls" that block progress.
> Vendors that don't care about doing the right thing will just patch over
> whatever check we add. Probably that first option is enough, it can be
> set in metadata that builds U-Boot as needed.

big thanks.

I did post a v2 with some cosmetics: control.rst
It states the option for a board that is not in the tree yet, and states that a
board sent upstream shall still come with its devicetree source:

  https://lore.kernel.org/u-boot/20261110075256.1800130-1-vjardin@free.fr/

best regards,
  Vincent
