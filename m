Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633E5C9832A
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 15:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7DD280F4E;
	Tue, 29 Sep 2026 15:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7IbOxSB4FY-N; Tue, 29 Sep 2026 15:59:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 19ACB80F2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790697582;
	b=F/MoQgN+UXMoW6oZdwAgFu6rguvFoGaE14Mfp+QcQfnkdgEQZMGiDnEah21KOccSgjql
	 rxT/riBjAn8dKa+1iNJvL1MmRiO44i/qD3fm12qcH9QTwQwuo/2KtWFPTUa3hSdJ8QGyp
	 0WWv6tzpfQMMjxV1b05u7X23CW1iWfyRCKDuC6+nvsXxoRfQF+S6O0LZ8YevWR0oYso8K
	 dvgsK8erpwqtvS9tRFjSGPZVBr7vtE9X8CmsGh3Qhw469z60GLX00lb1eTM+FSTgsuycG
	 XGtdaGmshI9G43xT/VzlUTSm009l5F+OoiLSIVZa0l6Sy56fpeXTYnm60Hj5DKY50Zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790697582;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GmUFKpEZBAJJRG/mzYsD5OsqEpYdEazSOC71Z/B6fow=;
	b=MIs5m4Lgx42Np56Wpo/IS3LKPlpcPT6nekpb3OczfkQY+ZR3k6XoCuUE0texJZX5bxz/
	 jmAYRzF1qV+A92eL/0b9v6ZgKmBeFt0IKp+AHL5RQsTK2S4I/92CM7MyEemZo2XG7gGeP
	 ncKk65hx2meJGqn2ZyFjbG03IXvCn2FBOXQ886kXskFTFhY+rotB+PAhocqD2j0hUzrSW
	 FwD3uw+3tIt9yGrJnSPjh8DrfA39eS+LvTTuo64Eslg7HRzy28sJjrnAqyBXsucCGeehD
	 /sJBZEtvsz3uinMgrOZMmQND/PIvwHAQXf/HGFFeYsKqEGNVBKjmwA4DqxEo4mLy1hA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Miw1b2eN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790697582;
	bh=GmUFKpEZBAJJRG/mzYsD5OsqEpYdEazSOC71Z/B6fow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TXLnyEbQ6FT7sPGhpvU4Pc7TCN1K9rIZmzKEqZBxtn0ldgba0zcwCtS8M5c90iPZO
	 SMjH5j8cFQ2JDdj80ESRYl+9jn5D1fW2WF0Pr/cUPoRXd26cCiVNbBNU+/Iszodkyx
	 MsPBUrDrWViwQnr4QzMewmTsOQ2cBu2a7kYsV6qwIVOkfNp1gfQXAifIW9U77Rya3B
	 B2BiewU8V/1NIcusv0l9HG/Tk1I7inR+05RLLsvi5dm4pLVoTV0gFoAog/gBCU4lIB
	 TmGwaHgubxDCLKnLz73LXneP1ytdSziA9tv/tqwVfkym+KMjJgkJ7S2L6bt6fQNNO5
	 b78D0S1BoxaOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19ACB80F2C;
	Tue, 29 Sep 2026 15:59:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CBA734E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A23C80F23
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:59:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0hpbXC46deYO for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 15:59:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4E7C380F1B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790697578;
 b=g3XYbjAjHZ1SDwA1b7YsbM54N1lUF5yvefAbAxqDN4uBNBKTnrjXHKMXdO25OBFNeo0T
 ftZCjs8ADDwO54n4Zq/3xHZBPjZ8x9qnq7O8NppKuegJrsS9IwljuDFqATh/bXf2p44oJ
 ZLecGEbGWWxzNe9FGJJUZMolmsbDRa1WJWkNlo2WBiXE/0bRVDCds3aP/ZkCrFK8it16m
 uyHRYQJ3RQElBn1JcMkkrfNnZGt9fl3RxHHWzkt4B2xPyTvIDXsPi6yOkjWPo1xFl93Z9
 /kJpHCC2SpgyvnLFVIIRJuvg2j6SO1hXGfj5pTdZUF8nlOUNc7lKGpDAJXehzshSkPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790697578;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=GmUFKpEZBAJJRG/mzYsD5OsqEpYdEazSOC71Z/B6fow=;
 b=DVVMIDK8jLeJZLuECE8zPQvtrcqZUQeGA5BpGIOcZzhBZIxH/fbVBxVgn9hZjxXc89XD
 kiCsJmnXacDYq4gFgUanFtVaWH0nxSBhNWZvlFLdS8xp4KWyzI4dVThlbGFtENdYQO9Rg
 as/Y4rovh9yAF3FrtPn+9wKIChMCi5il/arYNrIq7ycjaOuDpuxmHklHgvCwBvP7pKbu5
 C2xY6FzOL6qPGaa64QYR+oQIbQGVzVZPn+ovWDP+o8V1u0NoPkD9Pf/42FChlEmP0gphZ
 S159VhVkvGGE9CmvsMjINII/2PQLQ1ltwR+W3JzIayVW4Aj7fbb5J/uZDjL3SO7VvRw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Miw1b2eN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:31::2b; helo=mail-oo2-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Miw1b2eN
Received: from mail-oo2-x2b.google.com (mail-oo2-x2b.google.com
 [IPv6:2607:f8b0:4864:31::2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E7C380F1B
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:59:37 +0000 (UTC)
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6c72bd8a017so2649716eaf.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790697576; x=1791302376;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GmUFKpEZBAJJRG/mzYsD5OsqEpYdEazSOC71Z/B6fow=;
 b=Miw1b2eNqynj2U0sY2/aI5FjahZrM8HcPbalgDwax5XcpbTwNhbdikXNi9q2H7X39G
 34z1IsSX2Y5cMjTbzleSjJqyLz//OhoYJZbTwZ3JpyMCp1n9FXQAOzg2Rn5OUTf9VOa+
 QqdK8vZ8gmktajDB52BNb4s3NzewHUfL5ggY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697576; x=1791302376;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GmUFKpEZBAJJRG/mzYsD5OsqEpYdEazSOC71Z/B6fow=;
 b=J7iRoA6CbWDpoW15Da/lWhKoSCQJGJ51+s1/bcmJNyqS5j/obM6GYELXopIXWb8MKG
 n5k16H4z0pPNeZJcyybmG9a6JXKfDcl0tvNvfftYgV/0+3vqLmkUepW7jIthdO7H1UeI
 V4SB7iYckRuteSBYoLNQLJVMa3O1RB7HDUbIRHHCxtoawYHvsXYDA6rRIJ8FIUOl8DH/
 2g9p6nBV+FpkgMKDfxJUkkxVtLWXF34jbd+h2a4g+pK+WEGLo91xIgmnmQJ8AO2oVozI
 rXozJKkH4S6ylRPPxHmSo0KfJn+J6xH9UmMYc8LbjKrqHkcn/aAbsiK41lPAjKo4xZky
 Tbqg==
X-Gm-Message-State: AFuF++kRWJ0UjPvkdbT950GX/Tj8BeKevhB2SYbF+ySCEaqZHNnIcyhc
 PiIkda1VpRX0AAtciDnw67Qggrs0e9qVUbkhtxmNNV9CQSimHW2zZSpIVejejVbHQMo=
X-Gm-Gg: AYBFou1AJauuFwGaj8k8gt0y25YSYix2mKwtvQ8tzCKGZF93Z7AXfQWDvHMgU6Eflgz
 8JdvxYYzUZqBLCqQ6H/OfjDBvEh7aHuhi8w6w0T+g3DBMQv2gtr3+vEiRuFpV4ne9Pndx9AFMis
 KBXKCyukaMmchJVdO0XkuSkuZ+DjRfSR70ZBflcWhxJMpAFysbfgVlPsRIENk+2SLWnrQo3fiwG
 NNoA3ft4J0jOBHrUGOCAGL2ScxVWmrDQL5TeiQyz51+2+oM1PjZrjvVNx/RAjcsmSrOiAdpZOKP
 bq0KajTZo6Co0O2x3PjQEP4nLlNs7P1Jr39J30ZWG4TFqm5sUWpz50696RxLMs7SdQQAyXEoWYC
 SDTw2dmRdPwaQHAs00AtL0aenxTdmi7b2qwyOKgeXXWrO2ZJvv7dk4sLPmdva0qdF4VpjjjtXl1
 zcB0Qrv5j8YcdT3ehJLnBubigoEYbT7RiKnv0un2NC5yY0gc2LA+2zjEa+WaWqHIFJafqnuA68/
 /oB0fkiOUIFHAtoQH/iU0i2OQktr9ywNnbZrOn8TTzd5jbdOTJO/ZVeYqpMW1eq/SDz0iaO5R6S
 1Uc9fJV29LNEoBCASw==
X-Received: by 2002:a05:6820:16ab:b0:6be:731b:5544 with SMTP id
 006d021491bc7-6d43f7a5cb9mr15966259eaf.37.1790697576411; 
 Tue, 29 Sep 2026 08:59:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dc4483b07asm225971eaf.3.2026.09.29.08.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:59:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 =?utf-8?q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>, 
 Priyanka Jain <priyanka.jain@nxp.com>, Heiko Schocher <hs@nabladev.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Christophe Leroy <chleroy@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>
In-Reply-To: <20260928083820.62352-1-pepe.schlehofer@gmail.com>
References: <20260928083820.62352-1-pepe.schlehofer@gmail.com>
Subject: Re: [PATCH 0/3] fsl, powerpc: Fix SPD read and appended DTB alignment
Message-Id: <179069757506.148043.8286659923931745710.b4-ty@konsulko.com>
Date: Tue, 29 Sep 2026 09:59:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 28 Sep 2026 10:38:17 +0200, Josef Schlehofer wrote:

> Three generic fixes found while bringing up mainline U-Boot on a
> CZ.NIC Turris 1.1. Patch 1 fixes the DDR code used by NXP boards that
> read SPD over legacy I2C. Patches 2 and 3 fix linker scripts for
> mpc85xx and the two CS GROUP boards.
> 
> Patch 1 restores the legacy I2C SPD read that commit 98dfa70f84f0
> ("fsl: mxc: Drop legacy I2c") turned into a stub. Boards using this
> path otherwise get an all-zero SPD and either fail with "Error: No
> valid SPD detected." or fall back to built-in timings.
> 
> [...]

Applied to u-boot/main, thanks!

[1/3] ddr: fsl: Fix SPD read when legacy I2C is used
      commit: 0384dd3d2ec30d910b6138b78fc0f41950b1b52c
[2/3] powerpc: mpc85xx: Move alignment padding into __u_boot_list section
      commit: b9cefbcab172d735d53d82e36b8b26d76a77f12e
[3/3] board: cssi: Move alignment padding into __u_boot_list section
      commit: dbe089661477b379e26a82335f31003d68ea9c61
-- 
Tom


