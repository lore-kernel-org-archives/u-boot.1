Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87752606A330
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gaVKr4+D;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=JusItmor
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 647BB60689;
	Wed, 18 Nov 2026 21:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j3lyeMB4XABL; Wed, 18 Nov 2026 21:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 948676069A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795036229;
	b=ETYnxuFn5yZExYyOtVaI4bHcbSCYNmEdgPtLD8CpOLTgyHzCX2/jN+MsmyHcaoXOkM4i
	 NRiBjfcD/57hLd09nemLsiVW/m43/I/yFQarbcCnsKhy8WW6P8sOYMl/ndc6hZ/69rzV6
	 pqsdDCYUT2fEknta/R1R1IeAqUzdWQRSt1BDRllqFeaXDyGW4jDDbm3LNbQw6dQbXV0XM
	 EuHZO/X+LpEupZNWMln3Bb8o/Itwl6GNvMU/RmSd6ZyqSUI5nkqI/iTETdifjj+qaoVLz
	 seZUVIh3XV0NpjIFulpVYe87adYr7q/83BQmRR+HUXOw1Xb4apSfdx6mVD6VUqUdZQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795036229;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fSZTgO2lUtRDYPzDsrabZgvGY++eVYVE3vsRHfFJn8Y=;
	b=FXFgx1VilAHF0Mb9VmlFh2gJDu2DHFWKOnJe5bSvNEVDmrMhaN3aMctWLcj+s2i7j0vF
	 eDYhSBQbin3IGo61cC27vcNJVwDPHh4cl3FzgrTeH4D5gOND7cMZ/UGRUeoEL05YBr5rM
	 NE6CutL5BrqPxFzOjPoHyBvLsqRXti4B+PVfaIiKwGXJiAeTzZZTDfALkBgNtQiJa9gUW
	 m1MRNOyFmoLVm4vXcSTq3m60Wa1nhlMlyYZooyfp2A78t2PhD/lRwXUcEXj1Ihlz1l/yr
	 JSfrnq6WTtg1H8QUXXehl4aeMThs8yf0wHjkXqtWpBXmZto1LAFbgqU86peCJ/kRoJQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795036229;
	bh=fSZTgO2lUtRDYPzDsrabZgvGY++eVYVE3vsRHfFJn8Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gaVKr4+DsZMFHQIC66HM2VdoQo4sX6ssLhfcKwe7vspwTWxU7GXfjxt7dHrncnf+n
	 ISx1Vz6y/JkoBKxEEtNyhotuWPzPcXpnSrV5ho3nYZWXHs2rVHlQDp0yQI4LRKO6cg
	 4hRqk0l/TnqN8llVK7SatB4ANOaubRvgrxAwYRAa6nrP0Zy1/yo22oHBQQo7eIseqE
	 gHqS+zpfmTYIhGhHbmLKs/LYEaMFPqMw01mOIr3VP6K37hG/AYDT7GUVtmMwYwutUr
	 dw9hjGlamWtIdbSZtuYA5Vb8Tkbqb2WBKcuRqsIswH3bsXCJd697IxiK/PhSpFnm7D
	 5FVxoe2Ig00IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 948676069A;
	Wed, 18 Nov 2026 21:10:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9153079D
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:10:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 832FF40606
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CprKUGzhvj5G for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:10:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE84640580
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JusItmor
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE84640580
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:10:25 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-71ad099391dso852587eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795036224; x=1795641024;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fSZTgO2lUtRDYPzDsrabZgvGY++eVYVE3vsRHfFJn8Y=;
 b=JusItmorXgapmHe6+tf0IK31a70XF8fDVe/k222H6+CQaNTfpG7fUDmXZQcWL4idqU
 d9cfFtXCYzcq+glxVc/SCIKcuTmPepFg4fur73+Zo4oH3gMpnrO9I7j00W9Bb3aPQqBU
 TXv/364SmqhdPvLgBz+ikOlJtbC76CWelVQ5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795036224; x=1795641024;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fSZTgO2lUtRDYPzDsrabZgvGY++eVYVE3vsRHfFJn8Y=;
 b=WYFKGTpzq/0RO4QdV9JEtrMYfweZza7YSNGOkMS/AISulV+Ed7/Nd8czQQfKjHSwea
 0BNqY+Y/JBjkZFdR7pVV50H45If3Zo+W7PwJedbqW+JZ3lGmZIAY7F8YhBY0EYmDzGIx
 G+3E7KtCAOvHxkn3WhMTU6oixE99c2d7rmOLKBjZS00iwk6bnMggV0Tl3VKoE50j+s0A
 iNncWs658AOKOsLPV7kuf4wf34zyp5lQY9uxsLJjq3A/ba6odDsnz4EEFgapfM5odgKy
 RSBTayi/7VSLheuh44pGLnl4p1YHhYzL/CxJ6zlWyYI1JjWiuoUmVbQXETmosFhFek7I
 cfNg==
X-Gm-Message-State: APuU4Z9wGeWb2LYxNMCZR3DZhwZ2Blw/hDrX0+ORdrzNNxrsVwcddw9Z
 xrwQ4JPFcezO2t0sj4T4NMJAMuZ2ugMieMJHK25sDjZRpxT0ZXPg1IFJMZ8CYfelhe0bimD4N8Y
 iKajdWDtgeg==
X-Gm-Gg: AYBFou3qc57PUDB7TuGyLsuAK8WV1/ggE9On3gGvll1nr7aDLnHmhv4vz3tDsPS1KXU
 v+rTPngq3iKRhOm3BBKOq/b/mZu2MUr/BXG5fvnup5zMFPTzeqkVUl2m+PJtwy1QyZwwE5O0ZH9
 DWWci7GjKOoP1qRHwqtFiXnOMGScRwu/nxTjALQDidiAt7LnaB3tiM4u1G1eWQ8PFamNKLScKJA
 i1EeP57KeTNGJ/kpSZwTHiGbERX9+VE//dBlA6ahO+2YTfMq4pd2PRUyAW6bwbxAIHrQ4KNAes3
 e4wiiU88GEjcP8ZzFuYJg2DcxrHy3bpjH4rIVic4Pe2IpKQn9/b5g8Etfyc+IFmFceyLkIZuWhw
 YLkpuKJ24HU2f7dAiYENyio4caSlyIbkitwN7jCjzciaFYEQ+yMGedv3aI52Rs6WAa8LenHZgT4
 eTYC3KsoySBySmfn4SH7R7GeAMd2V4b2mUXf1sAreazGranRURKZI9W0NCSR4Zc2ogv6Nwrf1F6
 +RC4NczwvUnjnEk8cruPJYfwh+7XWcq9xBkgcpnI1aPAp51n8z4tcPrKJ5Tyj8ioEJdyoDYXWVx
 ys84H6bamrM5Kp+jlM6YYrfzcIcifUGofXu0hH8TJC9yA/oFCGYp/4CJV0vHdRijlZJPG2c00LM
 zIFBCypXyfZRGIUOWkZXtk9sWQIU28Cpso5fNMThHMb7GoHpDOz3nJygNDKHHsKh/X27emBk+e1
 0YtQanI8hhzMYT3z+2YJ1Okwwwe2gvWA==
X-Received: by 2002:a05:6820:1501:b0:716:e855:5002 with SMTP id
 006d021491bc7-71b296a9e95mr914863eaf.55.1795036224499; 
 Wed, 18 Nov 2026 13:10:24 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71b1955599asm2953033eaf.12.2026.11.18.13.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:10:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Vignesh R <vigneshr@ti.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Vincent Jardin <vjardin@free.fr>, Fabio Estevam <festevam@nabladev.com>, 
 Eugen Hristev <ehristev@kernel.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20261109-split-sfdp-id-v3-v4-0-7270c9d82fd3@infineon.com>
References: <20261109-split-sfdp-id-v3-v4-0-7270c9d82fd3@infineon.com>
Subject: Re: [PATCH v4 0/5] mtd: spi-nor: split SFDP, ID database, and fixups
Message-Id: <179503622368.3175094.15314815155800729231.b4-ty@b4>
Date: Wed, 18 Nov 2026 15:10:23 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026 18:39:40 +0900, Takahiro Kuwano wrote:

> The spi-nor-core.c contains optional logics like SFDP and manufcaturer
> specific fixups. The spi-nor-ids.c has single large ID database. There
> are many #ifdef directives in those files and that negatively affects
> readability and maintainability.
> 
> This series, as the first step of cleanup, move SFDP logic, IDs, and
> fixups to newly source files. Reworking, renaming, and reformating
> existing code is not a scope of this series and further cleanup will be
> taken place in follow-up patches.
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] mtd: spi-nor: move SFDP logic out of the core
      commit: 0359eebb0875c86e23eab722a7d5b8df50d626e2
[2/5] mtd: spi-nor: import manufacturer driver concept from Linux
      commit: e98f01858a9bce58a119d3cf5e307dafb524af57
[3/5] mtd: spi-nor: move flash info entries to manufacturer drivers
      commit: 556d6c72ade740fa3f6c6c481eb7b951a93191c4
[4/5] mtd: spi-nor: move fixups to manufacturer drivers
      commit: 6136d01535fd95b0850b36e8d720e26bc1020f9f
[5/5] mtd: spi-nor: remove page_size from struct flash_info
      commit: a821b0b2697f54ffd33fc40f4d16cbf7f8dfc584
-- 
Tom


