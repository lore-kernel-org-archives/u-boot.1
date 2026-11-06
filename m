Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ACC606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 04:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F+7pwJhY;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNboDvye
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6DB0814C2;
	Sat,  7 Nov 2026 04:42:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PWtkv8Q3JYVm; Sat,  7 Nov 2026 04:42:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4FD9810E7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794026576;
	b=EHiKAQ4mInERGET6IprBQuLPCZBsuj6NrvNKIOmwZ9t+TVt2taihOaQv1VNovAjy1M/p
	 hep5vlN7Ev2/TFGRYFKy9SGMjpZZvzK3jIeVMWBe8BZTuhwfuEkjdU8zW6H2jihCMBomA
	 Ta5LQ8UUXPHdJThtgbPuY6Uh8ZQ5YNwclPQhee77+mv5HoiK8t4nvOcBOzlvR3WkMQXA0
	 iRPqNuk9RNQI2zh6HUUl5PIuWJPimciL21xusaooI1R+6Qwgh91UNvOrPUCEGgf8BU1BL
	 0UQ66Bid2sOEGlRbXPqOKxA+RN59l4JHG2EF8Jh0Y5S3chwiCu/le/9/0gNmL5WhxxQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794026576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p1tKjotx/fZV0G3+pHlJ+khHHjZohEloIwdmGXFqpD0=;
	b=POIYgjW0q82NtlinInYStX4LME6H7dqHu1u2itS+gRKDtug1piuH6DhacOf3J/LhxQhG
	 zWh/1JxN7GIsM9yMTSzMP7m+iWdLlA6PYL+aZPcmWu/nN90KrkIOL8m80g8qDk1X+hBWO
	 6tlfYfp2R2R75vgIJkEJNeEez8eQUP/du/owao3Gu49jgCtHrX2gSIqACzDfqEc9gi8nd
	 ptJC+/D3R5sW4D5XHeSbqYF8TV4GQU469wq3NdgPDSz6ymYdqWp98Lm8fFRHM+3R/Bhni
	 zC18085UzNikwQwyQOauSYSiJRgnXJSniD8G+KoTn6paFbs2CrQZRJ/yr0hovzLcC1g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794026576;
	bh=p1tKjotx/fZV0G3+pHlJ+khHHjZohEloIwdmGXFqpD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F+7pwJhYNRIpQqhItKFY43zkLt7so0/c7R0iNQ26ods2qgHS7rA6uoU8/vYNXT/AV
	 HhUWV7vwGXVKXjUYP1BavQMt9QVwA6I7NdoGebeCRYACVsn3eHSx/5Xr4+H/P5mf/P
	 QROBSd5I22AhFeKHH6KCBjDrqClaezxQP5OszD1iHdYh+5W4oegEIeH2+emWFbqQ9x
	 AZhHwOYB4M8RYc+ItGX/4rUfMXNjTSt1XjhDk9OTf6ZiI+IgDma8eIZzwx786ZXIAk
	 z+Ecuh+rAqJovOEwRiO1NJDslbzLrPq9TmSaVKzqn816KvnUL3I421onA3oVfZnxL+
	 tdJuRK7w24HrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4FD9810E7;
	Sat,  7 Nov 2026 04:42:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C20112E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 23:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A7C71608D1
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 23:19:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nNpv2kKcWqqX for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 23:19:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE1C2608D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=FNboDvye
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE1C2608D0
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 23:19:57 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-3acd304b5fbso7701191fa.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 15:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794007195; x=1794611995;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p1tKjotx/fZV0G3+pHlJ+khHHjZohEloIwdmGXFqpD0=;
 b=FNboDvyeD6U0+b3s0FNOPPsqrkIJ/3nqiMG+TZlvyhXYKigjDaFQzSYUKKP2skreWb
 W8JkLh4tUVXnkZ4AKhYmFxmMUw1bOlYOMs0ljtCrLLbx5la48dViOhzZjtrNg/RsdJvA
 b5KUsW+079h+KREqAV4DQyvkkexBk3Asd096yZ9QZtTP5xPvmrp8Dt6Mu4HqO9b2JGig
 wq2GOjny+3GDfJOW9FxkbCavQZqPOI4QJwPfymNbXUsS5/Tw7N+/8J3XZJBZW6SysMJV
 TCOwaq0eHkvlvzDYHKuGuh6DJTURk55WSn3vAwPdTRv0c3TXPPFaieCNxnqrSWdeWkTu
 4b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007195; x=1794611995;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p1tKjotx/fZV0G3+pHlJ+khHHjZohEloIwdmGXFqpD0=;
 b=MzOrXL9XlECzrjPsIvD1Olr/ipboyAzOtVKTq6vOGD0CI67uPca7DI+JnTDJqpCZBQ
 NX9xc+9q4uTGDuC2FQWAOMkFPDj1ggPiK/00Q3ubS5+eXUfwTzLPUvrFl340uJ52aHvs
 MWLOKLbFXqvvMocY4J1vSEbBKK92pvLE32nhwa6Lv7PLlhfQM28kACWajB8QavU3wUMX
 0UMQ8vqnmZbanNbLV7Kd5aCdnbdlLJ7PJaK9mI9zISB4cSCdUFmXq4ANy4DQcZpvdIn0
 1ceckvuQVTVObsA3JZQOb96K1gDmcv+Mrpv9sF+8wFq1DDZV7MxVvmRHS9BLholNJt/g
 PMVg==
X-Forwarded-Encrypted: i=1;
 AL+hErElHJTtaulhyo21pyAphceSckcI/5ocosj63Uez6ybuJllWzxEO1sa65iPyB9OqUk405IVgY88=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9p2qCDRMygrRcnIieIS7x+0vYxgAxcKxXffwXGVN4DYNE8ap0Q
 Yq6AGFuQ5neR67uWL6yUE7+C/dGYkQGMWLA3wZVPhu5EfCwiSdR60gBdEwZkPqSI+EGCPPVXDlF
 sOlvel8rB5R9WfwkeAJfsdtY5quAC7Yo=
X-Gm-Gg: AYBFou38lGFZqkemBJsV4yFm6CE/C+AZWvn3qAZmHD7ppTNzYk0mLMwuYZ8DWPbQxgu
 cy51h4gv+pbJBp10xpTcSryV+gVL+7ZguMopWOoDgBaEMQVKh+hn24oc/p9vYHzv50fyMrydwi8
 NtiRVgCSAsCpNrAVaDXvYSkiFsj5n9+CVDdkAqukfm5vtnlI8R1NmY4XgimbFcgUsqm599+xkfe
 pQjelGQ6DM/1kkUBBXoLY1J5HukedJSdYM7Zw57Gb9oOkr8jNerdG4pSaTdg+fOKsQN1+yoMX/F
 o1tEM4trCDAN/ORzQZqQfriIxQok+yOUpXRTALtSsXt8LY92lqQ2wSCfjN+c5UDE9vX2HgcULFS
 OHxR0aFx8587xfXmGQOayBirrVvs0FV9835+r4A==
X-Received: by 2002:a05:651c:b2b:b0:3ab:690f:82ab with SMTP id
 38308e7fff4ca-3acf3e3908amr8698821fa.28.1794007194430; Fri, 06 Nov 2026
 15:19:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106194621.510146-1-oss.patchbox@gmail.com>
 <20261106205608.GF3741582@bill-the-cat>
In-Reply-To: <20261106205608.GF3741582@bill-the-cat>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Fri, 6 Nov 2026 18:19:43 -0500
X-Gm-Features: AclHuK_dz_9KExqlIY1jMj6RCHIlHdPoFdEywyaU0SDzS8-m_z4G1U07RPSKWmc
Message-ID: <CAGG=RgD_G2Ottv+0=JOBYyP8MsdDGGUhCB0R2BAHWa8mS2ECcg@mail.gmail.com>
Subject: Re: [PATCH 0/6] usb: musb-new: Free the controller if the host probe
 fails
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stephan Gerhold <stephan@gerhold.net>, 
 Linus Walleij <linusw@kernel.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, linux@analog.com, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 07 Nov 2026 04:42:41 +0000
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

On Fri, 6 Nov 2026 at 15:56, Tom Rini <trini@konsulko.com> wrote:
>
> How are you finding and investigating these issues, exactly? To cut to
> the chase, this series (and the other two patches) sure seem like what
> happens when someone sends an LLM to look for resource leaks. Which are
> not great. But the bigger concern is if we handle the error case
> correctly. Thanks.

Thanks for the review.
The bugs were found as part of ongoing static analysis research on
configuration-dependent resource management bug patterns.
I used an LLM to help verify the bugs.

The patches only fix the memory leak. They do not restore the
hardware state on the error path. Would you want patches that
restore all of the hardware state on these error paths instead?

Thanks.
