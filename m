Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D410606A31A
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IawTfEKT;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=U6kUt+Ra
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E80FD60765;
	Mon, 19 Oct 2026 17:25:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wN6PBeZRV0K8; Mon, 19 Oct 2026 17:25:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 126FE60761
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792430747;
	b=mPozL9sLfcuPuS/yH52qHDHHWBZftV71BXXyFhi421oyGgaQjizjwZ2VuCaSrh4eWCB/
	 zRwnWohwSqCt4gE/ifu0kUsRGySBNY9/Pd+B2ojJikz4kTR1jvJNwOnNIPFjLpMiyGSDB
	 QvuLJhlI1JLfsJznwgTIYKCtgI+QCk/PFz5ivBylUEx9YsBI/MCOsZsoTnyphe6if3LOp
	 8UJrD13TvYkkbodEjLFZHxLQ4W6EDLFqnjpFyWqvJhxpwCyMEbyNgMTK4lPLzIEFrBjrE
	 oj3bT6hIAnG5tFbUoojTXp9Dh57O3bZ6pgIgMmjavudMs9IwHsEq1dEu+0V5v+1Os7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792430747;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=MhAYafGzsqUBSfiEbDRuEOj1dff4ryNky2HmfXkl/QQ=;
	b=GzDJQU7q38eVoRExOVPOrE9OMB+Q621xZHlOYEuMB8PAjXwK1DPzX/U2DRTdkwg8EUus
	 2gOyoP/aoVymWna1YooWteDgybyKtkrAcAJeUJRat631gXyBBPdGvxpBuJz172+IsQX+y
	 v3Ic2XoMxtlv3b2f5izr8kSB3JPy0fZEmbk8FIBJQrWjsh2zMnAdLUcxHezEldfdFarPf
	 Tvdk48uOPaKHcmzYjYRL1izY0QgkmXS7HLjdYTh4K52jssxG36dSwaj9W4ECfS+/WLBkE
	 XdyXvZ5iqJOtedoT3JP0d+g6Zzlg1V7HQT/UHJmIHcK3PZlp8JHyHDFfrS7n0MpKquQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792430747;
	bh=MhAYafGzsqUBSfiEbDRuEOj1dff4ryNky2HmfXkl/QQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IawTfEKTdzw82itBmZfewjD/VZ4MI361VJef4v5D9jMvhQSKmJlxCY46puHpSeTqM
	 zTywfbY/i11/wHRUNEdcmyW6XlF3maJIgp72jvy1I2EiHzjHKTY1wdA5xqlBK68LTZ
	 r+w9ca85tLQhUU5Uh88hcAGzzJq+96lK7qgu6KkA3SzVF1MM+PwYycLRuAP2PtjyWy
	 OkSVMEqvwoxF5AnVAGE4AF0s5brwx6BP5CVGOIK4AOeP9/prkPJMjY+EDcrgkqk0Cp
	 QYDxBeCzgiGrAfwCLlJ8wB6jPZ/oL2/poKaatufjvQ8NSHkhc4CQg4Wx9zFKwGHwht
	 Kv0FvkhRKmynw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 126FE60761;
	Mon, 19 Oct 2026 17:25:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 99DA81AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80318400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:25:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ceqsAuPvYLK for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:25:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8165D4008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792430741;
 b=kWg0r4F8jrWcqMbv4B4sCVj5IjNGiP35KZok9t2EO0kjH+LV/6EIUKTOpwIGlzjbDJW7
 05t1nWGl5JXX4fqcgm8qOZqlsoZs3p3PTweVTRW3qXUV760phTg9tRHpp2pB5dRaKlQP4
 NTwhiJbjCKFvUDUHCeTouoJnLKMWvc0qKcAxvZ5RnOVAHND7lDTTKilpSFBZLfR1CvG9P
 YlyKFjY/aJql4Iw5T06lop5ty7dvA6zc8cdCe6vASPGA53Y/TS/YvBCWzpCWE4Tj/s41C
 eDGK67rrqGRVxBHJQuhqrVXaWpv2m779Kk2O7F51RUrTBE+IVLraf5rFe4CQA3q4bNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792430741;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=MhAYafGzsqUBSfiEbDRuEOj1dff4ryNky2HmfXkl/QQ=;
 b=JFGcNteCJEG27GQLikp5Ef4AZt1Lishv80vXF4RWWbfNv3/SseJdujlFpLz6/MJG5Zyu
 4R8fjK7NeUASVEU5/HHAeMk749tNg8ejgqyWXgZfuRJJzYgmokohA8k5G5pIhh2X5Zos+
 HtDZ9VW7iiBb7KNG+ucn14Wf8MessqOjlu/nicIzLbbZYUH9S0DCQOAcK1UIHhOOoWbEc
 mvGubZFd74jT+jvaVmxk0KXymKqatpX3QUTeOazrFu3SwaKjwU3I9v8UYfii01DtqA+IO
 C6eTebRgKQ0P9A226SbDDmq3ohtE3+sasp+NtzpnZEju5zzQcIoQvi1JpGrtxLpRWFQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=U6kUt+Ra; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::3;
 helo=mail-oo2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=U6kUt+Ra
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8165D4008C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:25:41 +0000 (UTC)
Received: by mail-oo2-x03.google.com with SMTP id
 46e09a7af769-8459f7bc7c0so1035370a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792430740; x=1793035540;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MhAYafGzsqUBSfiEbDRuEOj1dff4ryNky2HmfXkl/QQ=;
 b=U6kUt+RaKb7IUPS7CPsDU1+iAPsk+HppMzrCij43gVB4kL5/F0mYnoEPWDrfdxqDam
 fXllZ+3C3ChvDvpQxjbPKJG7C/p4f70nS93uNTFuZY7gCyrUlDGkbq18UxHsiZWZaOMa
 6OjKTuulAtXt77AKx52YRX/PytVmlg1YlTSEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792430740; x=1793035540;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MhAYafGzsqUBSfiEbDRuEOj1dff4ryNky2HmfXkl/QQ=;
 b=k/t+G9zBEdOJsKVP2FM9MRqYyi2VKLDHJaNcW4c2EEHCbNASfhuCG6rx1W5sYYJUK2
 M521ndMuvVqVorUnPzvisfveYg1CUXEgBRays6LN24sCjLNMb52WkFxOdfQ+p6l+Cl1F
 69c1HEyZvHiDFiyOqTfmaRNVn6u9lzqebkbQ318RKzuKUSCsWzxT19uHENbGsCrfi6JL
 BqpGnEsVVS3LDqVV+UBeBZVA48CxREvrGrasTf6m3Y2v/qiNDUDbLngfdLdst0zc4MGD
 EbvRTMnMLW95LYAtnE22psEVIDUiKIIXlHs1/waqCUCCEQsVeDgQpXOcicAdJPPIasYw
 dV/A==
X-Gm-Message-State: AFq9FYJs4v+Q7LVKme8ABWU2mXU2vWXXGLKLdoGXQp7ssfMNZhRehMpe
 AEqRfjRJuQiHOKPDuqdgB4SjNDgHXBVEvsMRpSPpT/Vjia6xPGvZWu0wHY6xhs3RQhmDTYiK+/c
 hPkCAF75sL0Qxnvg=
X-Gm-Gg: AYBFou3iMFn+S2cpBWIryCfKAavkO26svn5FKZ6iyfZdJaxHvGIlXFigXrcgaJ3Rlq5
 OJpL4OEeVEAVN7IXRazF83lO1o/AojvLV+zUPdxBi+oX9LjwnyDFbOiS5fYwluFW2H2pvO9gVBZ
 VYtQ3XczJzjTZFuI7ks2FZROkT4Qq/1Y/YCNyqwNW9wA7npvwFjG2EC/sgER5RIyFMV1RsJ7a5x
 u6/H8KCO6zGlapCykmzct9OTShuSGfDYCWhUj95WjtnSZGnhMi/t6L0W1KVfNE6ooxb5yaThBhu
 bjsFODU1jnyqT15lqGnxd3rApCJoWYM+B0bnnF09C8vv16xaUsZ91xFC7m9Lmy4dvIlxmn82HeQ
 I78kSVNBDVJNcxWU34dFxhpQDGR9IwQNFUKJKdTz/a9IHaQRpJCmMLjs+6uRBDqG2kxBsAik1cy
 1UqepKRmKo3wPs9Rab1faWBkSTgnJopKGSGmgvely1KQkkqzXQIaXyFXmflmfArWunXklhSI2jX
 +f9NNzddNKgERMSau07F2xVS5L6vmddrJn1C7gSzI3TqIAfdwgf8RdoGp4xCvBy9oO9MPOa4F8f
 mq2ymUYdWQQKBrG+1+baVE6FfmtG
X-Received: by 2002:a05:6830:6d2a:b0:834:b015:ae9e with SMTP id
 46e09a7af769-844fe973548mr7176400a34.12.1792430740126; 
 Mon, 19 Oct 2026 10:25:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-845b9e280dbsm6947094a34.19.2026.10.19.10.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:25:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, alexander.stein@ew.tq-group.com, 
 aristo.chen@canonical.com, mehmet.fide@screeningeagle.com, ye.li@nxp.com
In-Reply-To: <20261017161801.9045-1-festevam@gmail.com>
References: <20261017161801.9045-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-main-20261017
Message-Id: <179243073935.723589.5865055068014753212.b4-ty@konsulko.com>
Date: Mon, 19 Oct 2026 11:25:39 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 17 Oct 2026 13:18:01 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/main, thanks.
> 
> The following changes since commit 65a7532545336e4b73e049a69436e255da7df961:
> 
>   Merge tag 'mbedtls-2027-01-rc1-101426' of https://git.u-boot-project.org/u-boot/custodians/raymo200915/u-boot-mbedtls (2026-10-14 13:54:12 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


