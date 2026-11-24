Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262E1606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V/sJLc1X;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=BWLtTw1R
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F38896083B;
	Tue, 24 Nov 2026 18:42:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AOqcmmjUu_dk; Tue, 24 Nov 2026 18:42:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6615F6080E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795545764;
	b=XrLaVqgQ38UWTTy8yCFeuWFrw4wjPA7OXvzZi4lYdvvMdt7L4Q3Z2OEymIoKhhgTXwte
	 KF+Po3IOp9zgf84Y3JtVmvKnfB9Sgi5WDKO0SRpZPkm/ese628S5ggKD5fR+hHVqbz2Sp
	 dEyZM+Kswcn75B1nq79y0HQkenS7KwTOb+8Ot1XBEDaWfLBRhsTBX+xRz1bmQCQ1qhGr4
	 MN5oRgHhATIUfYGdaPOXTF2G7YQ5Liu3usfYzCzD9dWSQKZTAUqlH+SmVbReoDy5zqDEN
	 nmeGethPK7Yfii6RWokDNGlhrGmcSjSH138e3t0aQV+t7tc7YpAhvflrV3K8qCf/Plg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795545764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=smigstjracvXvraI2vbeswK0hv5dd+GJMR/pglFDPcE=;
	b=lg23a1awcy8468ZTzsvk8KnZCqniZFKKfRXiwziKqe5HRbPhoxtcnt7+JxMTjxCNKfXP
	 6dqdkS0y2IElw0AyA12WEXRHNcumoWxgOqgTiI2aOoUY/M2P1q6z4LEQLHOXcqFobA0di
	 BxT1n2EzIiZwoKMYoGXg/9R0h4fneY4VH5KpnWi0WTNnfaFCB8OFqunVBNkIzr62pA5gD
	 B+8JmPitsrNFEbVRddpqyB9MV3R5z1OsD9phnWBdtJxI/pC/Z1AsuSdlY7yh5yvY3TGmL
	 PgTncpO7sgKr3JDUiGzjk2vu3yQ7w47vq5PXPnjKq6JT+B7w52M2GZd4stEI/pBYkIw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795545764;
	bh=smigstjracvXvraI2vbeswK0hv5dd+GJMR/pglFDPcE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V/sJLc1XVEuiWg3gjbM2sC2unirb3Q6bCgLUMEJsmOyzxdUgv5prwjSIX0puz5ZkG
	 lz7XZ/0+G6qT7gXbsximJ+UTZ0VC9V7IptGDpmxfcf2gICofZEvP4IfE7swRroSqqF
	 8Nmz2qV0hBaWUPKlFC4h9jMRfCBT+b3ORW73dmRtnEfjZ8VlwMY6T5oq1TPs3lf1+u
	 v/gX+7a4Ajwoy7EZIIiTVHsgv3LCdFOKybp0xkIafVpEaIOnKP3cPVY+gah5gCWU+T
	 rMWPaSD9RfGpjTYfI15E34kyVo7qX05SUeR0ChqCv2lS/RaY/TZBRKY7Yjor6hZs/U
	 0DwGq0ltou2eA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6615F6080E;
	Tue, 24 Nov 2026 18:42:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 95C5B26D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:42:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B97980E71
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:42:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2XyjkJC7lOuA for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 18:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB47E80E5F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BWLtTw1R
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CB47E80E5F
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:42:41 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-8479f46ecd8so1976326a34.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795545760; x=1796150560;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=smigstjracvXvraI2vbeswK0hv5dd+GJMR/pglFDPcE=;
 b=BWLtTw1RSquLWZwIR7U5ZjX41xq50dmCna2AJiAeX8UktRaSyJfID4V6GkpE+xoK2r
 /JCIWiArlZuXQzXOeiAUsVU26whqdxSHal3n5RHllNYWCeFpff1MfXCatVNSgOccTFKx
 IsFLbChD4humKttlwTMKqskLheLQHB2z0KkWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795545760; x=1796150560;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=smigstjracvXvraI2vbeswK0hv5dd+GJMR/pglFDPcE=;
 b=HMdapCke9QZ23tvOMKxQbdttZI5CF2LtoHLLKd6DPs6hDdpaSxkQ/m8FTVWHLTlUUA
 DNzqOuiegHWpvo1qjq4Sorwp2AFiZ+TeSGNO4+P5Kt22wv8QUn61QfeW0kNH3KRUsRaU
 I4RM2xsErpwdszZ9UAndU0aQ7EGhbVxHAUbA8zzGJHcH2M5yorubhJMrvP+1jdk1OyXT
 ilYyDvuzOLq6Jem8KSck4h2wX0IW4Hr+zbWUK0netqGK8plx55TMyGkHjNRKhAvQE/GV
 ofoBwacTTKz8GFygscREoKQIGAuMmhFedtlFb7X5hUb017NbyS9RsX5l6nIIGv0eBM4g
 8q2A==
X-Forwarded-Encrypted: i=1;
 AL+hErFMfPTXZ/njiPpFBjBLbLJXo+xOgKYb8lHpmlaCd0OG+Xg4GYhJCiwZQYiMML3Uigh9C0Okxvw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8ucLL+fyTfkJ6bhynLdjMk8g/RiRMHQdi36uTBLyCWlbWGJT64
 TvFpAnLdGiwBbXW7Z+iPwrO1cNbJl7uqnk0hVsE22euYR/DMMQOGECFg+42AuJKUeh0qJuik82r
 SD7KjJKKSCyDn
X-Gm-Gg: AZFdTZc+RsObKXhd15lSgStLNPvcPTN0aAXi5DfDlbPxYtOAZBBcgpZWe3+tmw5Falc
 9uDBKn3eUbw1EH6q6QZrHmhp/A3FL1VufpgMWsnq5/WOSKNSmDtlJQWxAlm8dsihyXMpqSDrZ8M
 nOBXFLSUBlm5f8L5CZHJiMLsfAfVF6KDJDqOUfNGORNoG9OSh6tGQkhPUGDeQ7btqD/FmNODhH7
 qEN03JP7tmUeutZtxaj2sfLs3XXf+2BxGhkCVTYmioAjanvkL9Kf1ZmE4oKQbvxisEtZx6m3MRL
 X3V4L6gZ5/oFB7NlUq77aOZ38VhgPQycyQ6Z/6EHocXHvODAzsL0SYFr1AWcELpppSbxHaBHpdx
 2TA+l9fM6UtXvz0INGxU/EXLbi90QHITE8EpfyyTR2ZSjJhr6LubxTJrwel0wslZQnPM6/OQudV
 CMVb2pbzcvIeLTfmffGc1e8KdgG3jqL+XjY2vSTYXp2fRnXQZzE70fVv9GN+Zmv/tpdSVCM4gHa
 hPYRdfmUDOyLz5OkK6UurZnH7mzypN0viC+V0aQCeozqGI6YgFLR8R12UQ7zqROTMwE9TVRB6J3
 VUKvC669azG8x1CXrVk+ObpENzOt96EJBGEbQz8hbrDx+EYnaawoEqLNdJPkWjMof26+rOqdbYL
 SFnYUg/FTvQSNISqIF4cl/KXg3yIeH8GnRsmiiOFTGWgbUzlL4dQIs/IvvxD0jA60aem0uXcwra
 pC7WV/9Thau5dEt9+TThWWtXzSXXA7yg==
X-Received: by 2002:a05:6830:34aa:b0:862:b979:866e with SMTP id
 46e09a7af769-86315674ddfmr20520460a34.12.1795545760256; 
 Tue, 24 Nov 2026 10:42:40 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-863168f6d9asm12041735a34.17.2026.11.24.10.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:42:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>, Yixun Lan <dlan@kernel.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <awUF1tJS6-53BKGK@nxa18884-linux-1.ap.freescale.net>
References: <awUF1tJS6-53BKGK@nxa18884-linux-1.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc3 for master
Message-Id: <179554575951.1054793.5117646603457057591.b4-ty@konsulko.com>
Date: Tue, 24 Nov 2026 12:42:39 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

On Tue, 24 Nov 2026 11:34:46 +0800, Peng Fan wrote:

> Please pull fsl-qoriq-for-2027-01-rc3
> 
> ------------------------------------
> Fix SCMI reset domain ID for sandbox
> Constify scmi driver ops
> Fix ls1021aiot boot and enable FIT
> Add optional clock support in fspi
> ------------------------------------
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


