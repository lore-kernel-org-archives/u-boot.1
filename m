Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F37606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EoXgLDRt;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAx9Jh7X
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E25C940A53;
	Sat, 28 Nov 2026 08:01:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mT5qVDUidBUl; Sat, 28 Nov 2026 08:00:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E824F406C0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795852859;
	b=I82+g6o9Embhnav1XR/yp9MytU1x3zlhajAodOs52uxlsrbFk2A42x/FgF+xozaNUuLL
	 4srhPpfMWtFiCEQEaofM3vniyCqRpRhlxc2GufQeh9FaHiAJ982dk61FocaDFxJwqHtVV
	 GinYJlSlYGoVE/U71FcRj0/mqmf1uoxafAlCyjdXwMHFeUnX4oQ3Es3xzJU5j+tuiThPT
	 IYcJt1MOlQ1VZIGWtStz4Dp4eHbbl25JOIh1VfClC+HnKaOhx5LIPcTHHAEexqGH79MpZ
	 jl39Ql3z5jgBbRrZo9rKTN0vNiDh4+UfLlSBoTNpijJAhYHkg3pc7PldAVIO3jKyXLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795852859;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IjWj16py+dk8G4LoZ74C/C9ON8TTsiducw5fVlVjiGs=;
	b=IWpJJosl2erw5jFxuKhCx061Mw1mSaZHEI2aS0Gn2OYn62vClxyB30UO7G98PoMWuXLw
	 k2NAnQWCUyXO3/0Dlp3mBch6VEterwuswLHZBTOhrZq4/OEOJ0paD5+YsLqhFUY2hpYfL
	 +8PIYHrpPNvfpYPFvqmmgQ9kuTlV2qza8lnk6QOTzzkTFNibpAbas+e+2dWiHJxfu6tAu
	 u3w1oi1K/WT0Rq7msd8ej8ff/SikPSoKP5yRkGXAZ8LyVYZgXUuQCI7vW55qXDqb8tJcT
	 Qj2Kyryd7X4aHGbkcBsnnY63+RDzdkDHgO0io95Vc3yYS/CVojcH3ODVB3LnZXb+qbA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAx9Jh7X;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795852859;
	bh=IjWj16py+dk8G4LoZ74C/C9ON8TTsiducw5fVlVjiGs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EoXgLDRtLPH8HWHe/nYWaEnu8jd+UXet7fQPoG4b8YxH35eF0loyy0DKGDNkewdcZ
	 G2uWbO6W+du+9BLP7DyX/8G/p7ugPx4tH3ykjPkeryx8nQa+75OmYuFW8Q+yWZVLNf
	 hAo+cZxbPNAcWQGUpghB+Qeoh3wQBcoWpvT+9XQZ9qSi/p8R92uRw2HVwbwV+2MThU
	 E6Z6u/81nLjaDBcdCn90HnACwQBdWhui/oRZSgYAulwCcKB+zqS18jrNJSuLPgsctw
	 eTmU3jL2JLmZFaMwntXeRJQMcCiyEI2o11hE5BVsrnO9vkJ5t4ZVjP5R+7z3JyTAal
	 dv8Jlivm8pACw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E824F406C0;
	Sat, 28 Nov 2026 08:00:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 45D6326D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 08:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C80B406C0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 08:00:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d9vzmTq_bO-Q for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 08:00:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4D91740659
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RAx9Jh7X
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D91740659
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 08:00:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC60F401BF;
 Sat, 28 Nov 2026 08:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E0A1F00893;
 Sat, 28 Nov 2026 08:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795852855;
 bh=IjWj16py+dk8G4LoZ74C/C9ON8TTsiducw5fVlVjiGs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=RAx9Jh7XQ0CorvuYDXobCpGwDzF62BJY6aSiNpIXNjJ1AjQhv7w9haIqYMFf/jH/R
 3RSUy2Vo0bOnD1zA09reJ4TVvOsJvhsA9nDBT0BT6syvN/M3fRA/w/uYT0HXsu6GEs
 XBF7Jo0S0/h6ElDESfP4oySjr7ZFHPTWFzGGCy6Tg0z51ExvLAa+r2ATAnM43lZzuh
 QCU4B8Ru+sFvN1DRxIGJsAfPVSR/L5gOYNgDPAmfwBcque+5gkFLX9OG4/kQeZEOpT
 /7BaVMmVw097bak2jDuWwjwHgD0A1Ax9v4cgci62P36jpBgtceH3nuW5An+oA/AoHR
 0YN2bsiG97y7Q==
Message-ID: <7f5d2a0b-9130-48b6-8123-6b7e13aeed51@kernel.org>
Date: Sat, 28 Nov 2026 09:00:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: mpc8xx: prevent DPRAM overlap with SPI descriptors
To: Bradley Morgan <bradley.morgan@linux.dev>, Jaeyeong Lee <lee@jaeyeong.cc>
Cc: u-boot@lists.u-boot-project.org, Heiko Schocher <hs@nabladev.com>,
 Tom Rini <trini@konsulko.com>
References: <179024275173.70674.16356876476594066413@proton.me>
 <179579209485.3201180.9953622119991566579.u-boot@jaeyeong.cc>
 <f917b336-db53-4bfa-9caf-11827755ff03@kernel.org>
 <FF2851D9-8090-4FEA-913C-6C5F45FC133D@linux.dev>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <FF2851D9-8090-4FEA-913C-6C5F45FC133D@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 27/11/2026 à 18:09, Bradley Morgan a écrit :
>>>
>>> Link:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fu-boot%2F179024275173.70674.16356876476594066413%40proton.me%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C300baad17d124fa815b808df4ca95947%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639313962410005122%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=qZvYyy84460lltAnoAvqOYpclpCa9IKMWkbaL59SfMU%3D&reserved=0
> 
> Uhh, your mail client is not doing good things Christophe :(.
> 

Yeah, not my client (That's thunderdird), but the email service from 
Microsoft M365 which is used by my company.

Christophe
