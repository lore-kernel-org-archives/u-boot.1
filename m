Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352A606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=txEcx1tj;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=inVUgSUB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBEB740707;
	Mon, 26 Oct 2026 16:19:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ISNQxyR3EkRp; Mon, 26 Oct 2026 16:19:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1675740708
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031574;
	b=EaFUnFgLhtTIUutfKd7GmN9a2wuFlPsA62q1JfB7/GRZRGFzMylEHqY3vN4LB+eItmCp
	 jUAbJ+DT4NUHOgUdo80bWKBOpv8sOjX0/GIQSDRLVAF46H04/jRLJI2rKuPw4Vzj3jPrE
	 pXmuAeX5P3778TOvUICOEtX/HoWNpmvOjijKc7LyP5rDk72Sm6n5ZybajJF/+Z7hkpb8H
	 qmjO/9uxksmouhHX3tNdr9FMvjTNnLHsIc7PZVdEfyjsXg88k3pC+4LFoHk8MlZpqqdEg
	 kJDwPWYIOy/Zm5rg49Kei+wNlE0iX9jbcaGtFHjRuHWyckpxXS9Za6e2VYxUIO0okHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gJPDhhUNl7adnueVyEs16GGeDBXP5f6EJDvQzv9p+Tg=;
	b=IM9K0GebG1v8beofbc3B8lFxyxZNr2F9DjsUDb7R0dXDA4XfEZ6M9NczRrlFocDvDqXK
	 KbXd+WPMW0NQCJjum6mrQ9my6cwKNHnrKHiBA6qzS9tG3orUIYRgdiNbRRhdlHfd535ug
	 aH0FkUM4On53daDeZOQSmi5aDcdj0UlpZq0P3iWKR9FhiNRTGYtYIt0V+QF4ioSxiaOTJ
	 mzAXYMfoDDA3/uyH4bA6LI5UaB0vBpGZUERhihc8IDi3HMOQTJPe9MT9lcDsBIY8BXU6j
	 c2nOeb0RVbqCfw/ptcbSEQQ/+77gg9ltVc5ntxkvpY3Mu0wb1Msf62RVODmQxdGQZ6Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=inVUgSUB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793031574;
	bh=gJPDhhUNl7adnueVyEs16GGeDBXP5f6EJDvQzv9p+Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=txEcx1tj9u9xkqeFSx0jx9zu6yIOOgmWiaObx0LAF0Hu8cTp5Tyx+qRMaWiYrK1wb
	 RhhKRPqGzqvDmDOYrdYl+kt1evE6pFHUQ1LHS5klnLr80cKpUrEN2hddva6bsfQXWa
	 ZX9Ff7+YeVcaggYrDK48Wq3YlqRFBxR6TNqtH3ju5z0Qb4WBvW2VYfIBFuOR3fKw9c
	 1qxqT4aqyshsnRAp00HeL17s16aPeF3rKXlV8GUna9pGMnaeRimBgtg5VoCAjyuCkO
	 CStOeG279mZjwGgFTjw5oICJR5u1KMosomvGUOlfUPQ21swE3Lls2xfRRsHBvEcPOY
	 1VddpeJ3n14RA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1675740708;
	Mon, 26 Oct 2026 16:19:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60FA2235
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:19:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FA7140703
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:19:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G7p1PY9bsfNs for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:19:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B910240707
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::12"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793031572;
 b=jxCw6j4X4nxsnzq1F83KF+5oQnoKLPDgtkP9iodM+2RxmrM3CKKbzUgmh10h6Yr01+3c
 5MDcJJLA9v1ALLTk4eeMFrX0o49NeYGBsacmypQlbWURv1EPEe6TypRY1cJpbBydPGiSN
 mpXAmazkT8+G88f7zq4/vjJHEMZsOt16/vnsI8yEU8Ri6XLnSpLx6b2YwYQCyOxc4b/eH
 5WMnGhu3fKIOd+yu/aubbUqGP7bcdaxls7CPwq6RUsvq0HxZMph4c+ody/pa+WhpIXtWw
 4/fR+hkd2E65HQ+VjR1R7GWgS29qMAah148MlcLTGg0/xSxgig69blOYZalbR/zl7Cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793031572;
 h=Received-SPF:Received:DKIM-Signature:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To;
 bh=gJPDhhUNl7adnueVyEs16GGeDBXP5f6EJDvQzv9p+Tg=;
 b=qNXgWLfkAVFOIooPCvR1ktron77f1+x+UhXAt+tnsk2shWAcLmVj3Sb2fdgm3/DJ6Weo
 PojdJq8yWLTA1go7gpeSqXTRPr/eu1K4mZnASxHnVuECbKmTRMp+1AvjMyGqR48cDA13c
 4BwYZxF9MRrX0/w9Q5WVqST+ezUHnsxVYSea9QU5uyqxZmiIDver8kvmLF9gONeEViP1X
 FzxiqgAzrWIP/GS+9tNlEYUkx8x4HTfJ4/0/58SHIscOWnTMMoSTc50K0qnwF8ifah1a+
 PZpJsjb70WwfMYtyB8FHqxvwRRhZHxWBXbZPeYKYeTeoTAc53wqP00kIDlb+R4ZsNMQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=inVUgSUB; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::12"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::12;
 helo=smtp3-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=inVUgSUB
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B910240707
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:19:30 +0000 (UTC)
Received: from l3017728.home (unknown
 [IPv6:2a01:e0a:ac2:22b0:6170:71ad:118e:d0f0])
 (Authenticated sender: vjardin@free.fr)
 by smtp3-g21.free.fr (Postfix) with ESMTPSA id 07D0913F8B9;
 Mon, 26 Oct 2026 17:19:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793031568;
 bh=FFwHUx7zCxGNUGXaq+vb42fR/dWGWLxaanQP5ZO52oA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=inVUgSUBSNGpilrJ/tpFRapyU3g80TEw2ICkA4eFK7q8KqF7oY9tkxAPPuu0u2/Tf
 XfEe9LORhtfyYwW18Xl1oTvzFqDMSawixUOwI67DNN+/UD11HoXjb7MGTZ9gGMrQH4
 s6cvr4LyIMNdEqA7YnIu+NCXrkDVrSNwcYco/A5Y8WeisXgqMJ9fbsIGrfjoRQrYSB
 DjZedEf/eCUDlPP0rKJrDvPRe+jhlmxeXe/LSE/7smkInGdK7E0t0t6YbXdgOfKf18
 LVxfQ2EFKTZs/Qp6wV84d23pGX2YBZyFSZLuDZtfEfXZFjK6vwp33pROYs4L3YK/Xj
 +idbJW4AjHjBQ==
Date: Mon, 26 Oct 2026 17:19:20 +0100
From: Vincent Jardin <vjardin@free.fr>
To: Bradley Morgan <brads@mainlining.org>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@oss.nxp.com>,
 u-boot@lists.u-boot-project.org, Sinan Akman <sinan@writeme.com>,
 Bryan Brattlof <bb@ti.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Message-ID: <at99iCtY7_bTF85U@l3017728.home>
References: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
 <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
 <at8StA3lzLMDbcrR@L30177.local>
 <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
 <20261026142023.GA624796@bill-the-cat>
 <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
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

Hi,

> Isn't that a double edged sword?
> 
> I mean, since PowerPC is SO inactive that like nobody will respond, and
> it'll be limbo limbo limbo, just to merge say 24 removals and a
>  maintainers patch, especially the maintainers patch, that has nothing to do with the removals and that'll get all stuck up with the removals I think unless you have other plans, which is annoyance, because it is "oh so inactive"
> 
> And I also made a additional maintainers patch that IDK where it will go!!
> Either to my custodian tree (p,s: maintainers patch isn't merged yet!!)
> 
> Or to another tree, yeah, odd, hm?
> 
> (Sorry, I had a small vent, :c)

I would not drop PPCs so quickly ; there are still many systems running PPCs
even if folks are more in "don't touch things that work", I feel it'll change
withint the upcoming months because of the scale of CVEs of those old systems
and some new regulations in EU. Let's wait/watch, maybe one more year,
before dropping.

It seems long, but looking backward EU regulations will start to be effective only
by end of 2027 and LLM -> explode of new CVEs are just starting...
so the mindset of "don't touch, it works", it'll have to change.

my 2 cents,
  Vincent
