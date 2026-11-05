Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F982606A332
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EtvN7KzH;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OSsvehi6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32AE440829;
	Thu,  5 Nov 2026 19:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pxDHw6CPFDRt; Thu,  5 Nov 2026 19:59:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 365F140818
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793908752;
	b=AaRoUJ3vFNEKmWIwtiX/L/Y2Wbrl3zccepy7XiQH5jqvAiotQdLPWiET0qfBOt45crHR
	 Cp/7HxsQA47LLInUQqxPYZEoZCFhenydIxFoFISNKNjL1m9RJRreXXZeK8LzvUjj+7NGx
	 1y74sEDwYWIvW3WTQqt8a1YxNJw8s/PZeaOdPUbrlMowd+or4ZVkmT+ksFl8+0iSyJvX9
	 RI98gaiSEfdktdq6fsG+rjGRw/qNmtj7ka2lnUY4x+X51o7ov5iOdDAKea7Vgig6hm6RB
	 je9HFD83F0dZyvsLs/O3Dy73TSLyuDijptS/EZEa4qcKNVkKKr4hNCKDVaAjAqR+zLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793908752;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=f1j4WQ59x/ZLKnjaxu2BbduePnjL+7k9fTZtSBZZkCg=;
	b=OO5DiqxJcNUOm9s2X4Nv3R+VXErMqqfcwqoTqzFGaaPLmg/jIcyNXz50//YgG77sWcrI
	 jteD8uzpnSTv880DHgCwhxAvpWM/i1OfuJsjkto9eCM4z4r5hXTbSPAcnZwE76FPZYBHS
	 tUPmEU5X0aqahtdgXeAa2ft1SPfwU+Dz/sOB6G+K2YgCINkVsmdGrGBEiR0rkocpGsUqD
	 VuGxQGMcxrRxjwTRAuq1RfLMVBYTXfUbDBNN8Jb8XvJ3dfrs+lFZccOjcLqxCMqL2KXUL
	 /7Kl+zJ3POixr6n4go4ma0DHc0Un6xyT+AG4ItUzQpLczEgI7YURBsJw1wO5QKyNcsg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793908752;
	bh=f1j4WQ59x/ZLKnjaxu2BbduePnjL+7k9fTZtSBZZkCg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EtvN7KzHPn23GBSxfhGWX4/Emn+6SXJzV/yQ4a2qUWa9iqhUX2o08g3CDmS2NS+Bl
	 coQ4qt1fShzxEheUNl+rF/I+hoQ3sm0yjb4wn/J+lxu1ibrVAgWpqIn664zHTInn6R
	 3kUPnug+2KF1tnFTTs0DyNP0ma7vRULNAv9Q7YA3kc64YgZ5z/ECUTEfcRVeTu/Ltc
	 qY0BGqLw29z4W1Wgv/HTMoruMlWC8Cfl/ODnO5Y14nxQQH4EKR9/yU3Lmg4OPQuJFd
	 vyM9CeEsj0St1ox/w24Yzg6fmDFfNdT0ofAIgm+oHvJUVROlVu+bRwq+gUsboRM7cA
	 qZvwvUEFqUSqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 365F140818;
	Thu,  5 Nov 2026 19:59:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E473B00
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F72C6085F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:59:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jgOExtnUTs2U for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 19:59:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 778B460615
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=OSsvehi6
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 778B460615
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 19:59:08 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-83bbcfba0ffso1587518a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793908748; x=1794513548;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=f1j4WQ59x/ZLKnjaxu2BbduePnjL+7k9fTZtSBZZkCg=;
 b=OSsvehi6k6enAFRMyEwyjM/Hj9VFmh2kjGExSxz9nOsAJ8BhtEls9wcn2CvKQ9JGN5
 dIFdbHY8KnHCMDRuoCn5TZwAi9qijB5wTTIvvZEASMDDmrT7cXSTBuOB0SRIzSMlscXE
 LLj34ykL351YNEJQKjZ5CzM1zpWwEelG2jkZoVY0a3ZILzRjMY74ADZQAnq7qOYgVTV8
 39J/50Ig/J3pbphtfwHs/8BjqO8JPB0YBUo6guYe0HVDS0DlbVTRm9WtsdtJA/w/W0Zn
 kf2PBeO0BGpYOvW+DFH2TSroDLdgyUABymirBW/AV/Mw3WUQkeGJqt/rr3hs7Ry0jTTY
 rcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908748; x=1794513548;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f1j4WQ59x/ZLKnjaxu2BbduePnjL+7k9fTZtSBZZkCg=;
 b=I7/EaVVYrKVmFeQsRf/utN1k0OEMvsrexx4m0S9ONuYrI/WbVLoKl9i4Jwc5jHrcNe
 jb97OyQUcvTD3oFVi6rAPbuuzK7xc86vzg5g7rKFlUjAbhc8U31YUTxVp+//HtLlyiIe
 cDS6lDqRkk3YgcRoH+IoajdWprbmcjiVVt+z7tMg631IJk1n9dF5OcDVCSqKfNQb7AP1
 D5HyI78A6l/1EB7aXPs8Uigpsx2czIUa71dmFSC2wbvvAcokNukQNk7+XmJf9q9tKwBL
 tRWTKp471Ca2NwTYjQnKAKthuBNESBSlH+HzqIXh/MpBJ2P0TSpVX8/IP3n5YCLv/Dh6
 jUow==
X-Forwarded-Encrypted: i=1;
 AKwUvBy57X+FRhr1lPBsmfFjrVprdAig8wmMQe1JOq74huT/SDtKk2kZ13SsIuJ0aD5Ge+FPEhd1rwo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9norwrTGX1C4JfbnPxBz8cgcdN03SOIEm16/pApW0tqDYAeCGg
 N78utmGk49MbbIfB2Vs75r7bALIVF6VFmBNPDY++UUHHLR5H25tBZtu1K8WaJ5oh0odl4kHM+nl
 KYtbR4jgB5AYG83NHHvklAeovHex+kh9z7gLidFv1mR+j
X-Gm-Gg: AYBFou3Fdqig3aISm2wfCVdSDgvQ1MXdJgMgvojtd/G6+7z3Kx/DO/Oirqifvhh0PXI
 3UgBjiApCGUmxCLZgMWwZKK6Mu0SF99bxYGjHjRHVpc8fYEvoFvGwbHfEWlsey1UU8gs7C0v0tC
 YuMxWzUxof6d5HaqHWFoTXUEFrv0ByE8j55gAlsnNxMTGQ7dK84cMEWRsUG8X8QjSavwaMQrgg5
 Wa6PP3jLh6Kkn8NJj6PzWHmIymYErerUF3hA2HHro0ueVu8F6FLO4ZGAbmIuctSv6QUNfC/ptdR
 dwhxBJBzu84oK5NB6hi1JwLtdt9C7IH5d6INhsL5ncmzdhOYaQiZlg12yB0nFIdUf9vCP/bXKk7
 hRyNm3lpaVjionKY8NQvVJVfmDyUx6zN230ZSDg==
X-Received: by 2002:a05:6808:1310:b0:53e:42e4:47c with SMTP id
 5614622812f47-567e150410dmr156840b6e.34.1793908747897; Thu, 05 Nov 2026
 11:59:07 -0800 (PST)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Nov 2026 11:59:06 -0800
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Nov 2026 11:59:06 -0800
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <20261105131601.1854572-1-odeschamps.mail@gmail.com>
References: <20261105131601.1854572-1-odeschamps.mail@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Nov 2026 11:59:06 -0800
X-Gm-Features: AclHuK-uVdjlFZb50HAbQqbUgl219Ljbg-7t78nmm16kQHQl1mGTdkoCeKWXRFw
Message-ID: <CAJnxHsjmgEOscHkzGO_tgh4_Qu4Pc-wQQ_==PZ0hLD8OPD_fzw@mail.gmail.com>
Subject: Re: [PATCH] fs: ext4: bound extent-tree depth in
 ext4fs_get_extent_block()
To: Oscar Deschamps <odeschamps.mail@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Oscar,

On Thu, 5 Nov 2026 at 14:16, Oscar Deschamps wrote:
> A valid extent tree has strictly decreasing depth down to the leaves, so
> require eh_depth to decrease at every step and reject the image otherwise.

This loop is already handled by patch 1/6 of my series "fs: ext4: check
on-disk indices before using them" (v2, 28 October, all six patches
Reviewed-by Simon Glass):

https://patchwork.ozlabs.org/project/uboot/list/?series=530226

Its ext4fs_check_extent_header() requires the depth to drop by exactly
one at each level and to be at most 5, as Linux __ext4_ext_check() and
ext4_find_extent() do, so an index node pointing back at itself, or at
any node that is not one level below it, is rejected. It also checks
eh_entries against eh_max and against what fits in the node, since the
index scan in the same loop otherwise reads past the end of the node.
Patch 6/6 has a test for your case, test_fs_ext_oob_extent_loop: an
index node that points at itself.

The two patches change the same lines, so whichever is applied second
does not apply. With git am -3 they merge without a conflict, but the
result has two depth variables in the loop and the header check reads
the inner one before it is set, so they should not both go in.

Thanks,
Ana
