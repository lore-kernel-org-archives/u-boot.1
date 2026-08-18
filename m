Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE827C5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 14:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B8CD810E2;
	Tue, 18 Aug 2026 14:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wR1AWnJZUwMN; Tue, 18 Aug 2026 14:04:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB99F810DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787061845;
	bh=gfjSylMBB4m3+bJD37ZMs1bt0wK9rSv92pCVpUYeiIc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ggdIq4UlFCsWIqcwG5Nkj7TEZtciPJ9AD/Rp7M9TD36NCpRTgg3QRy2B/P2SHIeRI
	 870FhapBJU6DCQM1od8w0D7DOBjW8czJh35qs/u70nvkQ3OY9qwvDd7YE/zrsM7nh2
	 vLH+W66MmmGJUSrWjUrYkoOzwXjxDeWYJaJagN+NLA6vXU5V07wszuRr/2YWg7hweC
	 KkAsUSyPpbtVUnvthBJAyogaaz7DhOjuE8Og94ImaBJQgwwZeTkFGnP7Z6Pkpua/i/
	 OWgrE9hPOHs5WnZ5OJGo8IEHXHnvoB0P3uID4VR0Lg0RfW8Qlxn7yI3x1bV3tCP/VW
	 tsOgv/dthhKNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB99F810DE;
	Tue, 18 Aug 2026 14:04:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9443A2EF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91962608D2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:04:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vGpTIREn7Z4h for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 14:04:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D046E60889
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D046E60889
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=j4bFSQAH
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D046E60889
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 14:04:02 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4b21f09ec76so2480047b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787061842; x=1787666642;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gfjSylMBB4m3+bJD37ZMs1bt0wK9rSv92pCVpUYeiIc=;
 b=j4bFSQAHuTU3/w6UTiPxE5ie19ezTFkNlhL1QYYEKet2lgvYU+KTWl4hHa1WE4HkZS
 6inEppyucMgglC7bTu33tDKZx2FYMvomMHW9v+Gq2tMr03jxULPcsR2PebYRufhNlC+q
 bYtW219Fdhna9uHXpqGUzxqOfVShc5ZHqyrHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787061842; x=1787666642;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gfjSylMBB4m3+bJD37ZMs1bt0wK9rSv92pCVpUYeiIc=;
 b=T8f57QuzLVy5hyXSTAXaWqIUN96T4ixZ/KOy37k/Lz307RCyryAzbPgEvJjXivlRJL
 J+ho8viUWrtLZl0gH7MSD4c+rxgS0xArtF2YJkdPGewbBtxUtnRhz4ibd/Z5UUgvmhrP
 dNo8PSoU8k0VTDo8BLcQKQ6GovrZTN0t4O5a+9aXt2L9FfkmKqUOijUduT/br+zM+wF9
 sz9wWH6KALrRRt4JYYAOtPLEqd488yOeC+yMqOvYQZLdadcaaqHlySiXXY8g7oIT99AH
 N1mliSo1WlxvtcXhbiR5j0O2jZ4ATf0bdoPiEkn2AQTgRPgnCduJGcHj35KwaVniPG3E
 q7TA==
X-Gm-Message-State: AOJu0YwgjQKeI26AkhxDokdBnTsoZvKdl02C6Qt4hpJpwvRLZXsCUhvj
 TUfn9Z0lsVuzDP6qDNWyjX0KoX/cNPEwgTsQr0s8iAUDZLA1riw1qg2QBCbJRyZbWB8=
X-Gm-Gg: AR+sD10FYNNs3EZPqSgtuBbDbfJx0a/fDJjR92Q7KQh9vvwagzG/0wU2fGgEN2q0In0
 ZITst1gdvBIilfW9kOyzlE7GNwXitTW24xLkDRQVBI5/jgz8DLftSfrAs4SNjN59dt1DAfqfrR1
 SbhnDTxaXOxpc6M/oRxwA20cfyuaFtGaE4dN3NFKhdhLterlPn4WJ6iJw2DjKrO6Oj7eucU85nq
 c51eEM/u+JqyNL2ETnu6SF/8gmGL/fTeTQHrKVTMxrYt1icO5+61TxWookHwV9XbZPQ6KLcioxG
 jCwqqFcwtNpl7FGgo/Qg4qKV6MCUB32DA8C2PzqCuzEwD5jRu4Okx2K9nJD+PBttnUo2QXiJSe2
 HJCVu2h70PmF9dLhMURh2Jz/4y0B5gDGoogze5tTlozi6iZ/RynhiyR9XXSySAkIbLXiToZ2r+i
 dLjPy+dx3zCjT4RHhDjwsysZG3SQEaBONadM3JOR7MlJrBfJNpg+1VNm1wc9Vf2kaPWz1C0RC+2
 RaObWgwygzfejQEDm/aZ3W0hpu50ZfkWw0sUij9DANlH3ev/KfknBipPPntGwdX91L/VHv2nfXD
 G3VIubVm
X-Received: by 2002:a05:6808:1307:b0:4a4:c12:46f6 with SMTP id
 5614622812f47-4b2412a4419mr33827254b6e.2.1787061841604; 
 Tue, 18 Aug 2026 07:04:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b296049275sm3388222b6e.12.2026.08.18.07.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 07:04:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260806122957.101125-1-me@ziyao.cc>
References: <20260806122957.101125-1-me@ziyao.cc>
Subject: Re: [PATCH v2] buildman: Differentiate 32-bit and 64-bit LoongArch
 variants
Message-Id: <178706184079.660775.6620434530383993211.b4-ty@konsulko.com>
Date: Tue, 18 Aug 2026 08:04:00 -0600
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

On Thu, 06 Aug 2026 12:29:57 +0000, Yao Zi wrote:

> Similar to RISC-V and ARM, 32-bit and 64-bit LoongArch cannot be
> distinguished solely by CONFIG_SYS_ARCH, but require different
> toolchains if multilib is disabled in compiler, which is the case of
> toolchain provided by kernel.org.
> 
> Override the parsed arch parameter for LoongArch configs based on
> CONFIG_ARCH_LA64 Kconfig symbol.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] buildman: Differentiate 32-bit and 64-bit LoongArch variants
      commit: d2b6f7d9c4b42ce48c83593cdec7ae9780a31057
-- 
Tom


