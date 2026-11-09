Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5A606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OU8diq1m;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=GXMha/fg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53E83608CD;
	Mon,  9 Nov 2026 17:29:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hvPFO1rWt47y; Mon,  9 Nov 2026 17:29:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3070960A40
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245397;
	b=cBuM8Qpj7cMkZHcCuakCie7bMOhRcexknUhStzYyZHhN0VYKqTOIbY0u0BnI5UwGlsnA
	 rYjqiC/3pRzR8OxJ5TcJzkkIc/1EahgBCcIsnM0UbYEiqBU4g8PVjzu4lbDHf/vGjqHoc
	 nh+Ccetd1anQsLgEkh0c8vpRm7zMVh277E6vBd9WFqtcAqK/rSeG9pNbXQSBCwZk8z2WD
	 pZflM8kbaLR2uHwP0mY62dP+Ky3WIiIvwo32w3mLSrXBb2dirM71AIuNHAGrbjfKjP5C+
	 KZGsJLnZs+LhM7EwUeGMVrIejoXed5ITyBcwC1vig4Jsjjrt6fXTEdKJEHdJRhV5Ahg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9vHgXM8nPn9af7fJYNfYSYFBBelVlcthgfE83LiaNMs=;
	b=hYRX1RPNw6dRb/3MvXFrDSLA4o3bCJqif5Pzusit2UxSc3E4PR5edrm7ddGaI27SkeT6
	 /HdXglXuP/wXXbIh0UQpctSfBTUYmedO5x2KyFx5YurGxOMrNe/v43M8oN7PcTG/fqwpA
	 F0lIY5FXl0K+ykHeLYpxEgi0gR7rxVZ7YY7oE7lbWdNRftuXVAxeMEgFZRlMXlZB0LStt
	 2JWE8eGZdbZ8j8sYPS45VR1+EJufMTTVvVQ4krU9jl0CxWUW4gBw8agVVTCl056SDF+ku
	 PGUOQwurAiqke3GGs2fVmBSIQknMU0VHfzaAv8ZyiKoQFcBvorAPpxFpigKr9AZrxEg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245397;
	bh=9vHgXM8nPn9af7fJYNfYSYFBBelVlcthgfE83LiaNMs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OU8diq1mOJ73HDjtNnw0V7VWBfkcSFndR73DqNYXUqonU3TrKZyl/aKOoov8uuTkv
	 wkjE+Z07gZ1zPnLXqGba4/09w9ZCbwOk6/PKj+heoh7PlAPi69RFFp/JJtht4FSqlf
	 lM7Ch6/kkpUsK5hpZGeq1/QivBiCXIfYhGyGO4T8orTUjeWsBPnjGOV0xC6+LPgVmu
	 vwzqoTc36rBJ4Dj0c3rf+HyinG66VLUEP/oH1KLd5rX+OHoI2giefkhwjAlOTstkEw
	 RXuG0Yz8BD6gAAVIJGzDfX30K1UrYtHilTRj96v+TnJtoi2TA6EYFI/yjoQtMkNf82
	 c6R81UlM2OVVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3070960A40;
	Mon,  9 Nov 2026 17:29:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9261928C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 83559810DE
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FFk41UA4i4BA for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9DA2E80FB5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=GXMha/fg
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DA2E80FB5
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:52 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8217177c5daso331406a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794245392; x=1794850192;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9vHgXM8nPn9af7fJYNfYSYFBBelVlcthgfE83LiaNMs=;
 b=GXMha/fgxpSGyyLlDiZoTOgAIl4D9mjLFGR6GMnD5TUzgqhq82BQrSZlU787Q3NYeS
 B6E6eOZU8VNXXXzz5ryDA04YunBzhTPBxUeROkZ4raUxJIAcCKbHV/UkQ9KFI3EKjMFK
 SlPDHpyqgQ8XRd9ATgs1BQ5gApX1yqRdNl4Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245392; x=1794850192;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9vHgXM8nPn9af7fJYNfYSYFBBelVlcthgfE83LiaNMs=;
 b=atpquSDSaS6x/i8QW9Ha+aIP2yJpRD9tdb0+IOgttwZ0LWJH8IE0qAdDH2FQqypW7u
 KKMm4s/UNTp0ar9rA1qhVIwkp7IjfvF3ALhYCD2CF9bwt09b3wmo5TT3osWqNcBCdFvx
 MfUY0iFIZOeQKfEbGJCzHwU4oF6ew9r5m8hAoXZ5dz+brqaYmKcJPKLbK2o1tJ88FjKS
 NQP8OZjQ7t5CcBNmZ8PM/M2KnYq8f4eYU2wSUizdK2NJQmt0G9ZEuh3Bv4I5s6Hqg6zI
 e+ufztyj3nIAMcPo7S01LHaC98uzXYWO6gF1vQ7cd1cfzPhSsxuCaayTiUF39+YJQv4N
 dr7w==
X-Gm-Message-State: APuU4Z/74vOR7ToonBfGt8OOsF7c5J1GopjK0DEZDYBtJInbnIJpablF
 N8ppvFFlUahxLHuYBUn76YDe+UUizothReKP8Hj1oTNFIvsqNVjyBptmNOoKb4PanWldXQPvfMr
 U9EqfJxhrOd/ToWk=
X-Gm-Gg: AYBFou0y+qTRkYVKBs69zugq63tEm2S+4gwXY4bpQyiX9PXZcQDlYTdbIBdr/NwP814
 tSA3udHNAdK1ud+fV+wcZP4HQvNzvPwU/xV8KST6LPvm6cE8NXDPWB4D6xow2v/k2LmIZNf5vAJ
 +Asw80a01Pw2nxzHWz5s/whqGOdoHEMODEGVi6LmilHPxI0g2S34d5N0gSfF53xVjF7q6xIXIKg
 EV6IZCET7lTVE0/40Qf7ObHBH5NoqZ7OL0yduep5aHysX2UwkU4caDdQyDmNGyK0o332D0Lvqbk
 O1xfxwpM1UK1K2g4g1GR3P0Q6yThzscSJmOer/uSBZsHiuZ/31P/aclZtQJNyQKLlxBUD+EyG7J
 stEDCBXylI9nrpitX48NImWRaPTtpe87oOPrwOEBNDBC8sC1/fW/oIUZe0qesQvDsq5+jRsjDUO
 gIVNJpvqna7DcFm+ElQErhG/u283oD8sdlRlb+C+DcMY3Yttox29SmmCO8nTNmtBVv7BtW2O1YT
 w+4mJ+m/ZkiAiTUU/Ue0Jcu1pS3ORH7nC26/tE5ZoHLIo4n63ntYUWtNeFHipfkkJce2p4Cjepb
 pptqKBuIgXPnh1myJ3x/63IyzZdSZ9JMRkcNXQPHnz+snMx5ulF3BNFBYluoXwvu3qxvwcnzgCh
 +qHEAG4YGEt7rMG+YqtTTujkvnFyOZSJOUaHGBBFDFtzzMPMG6j2VEVvHdc3RjDvWek926Trt9M
 Tyz1Te8jYVdjM63v8yTrFEPKPTbXY7Fw==
X-Received: by 2002:a05:6830:2e01:b0:829:8a9b:de79 with SMTP id
 46e09a7af769-85f50597b41mr3294368a34.4.1794245391626; 
 Mon, 09 Nov 2026 09:29:51 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860db8481d7sm200546a34.15.2026.11.09.09.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:29:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: tkirchner@emlix.com
In-Reply-To: <20261109082458.847569-1-ilias.apalodimas@linaro.org>
References: <20261109082458.847569-1-ilias.apalodimas@linaro.org>
Subject: Re: Pull request for tpm-next-06112026
Message-Id: <179424539110.2040456.6698678701533260068.b4-ty@konsulko.com>
Date: Mon, 09 Nov 2026 11:29:51 -0600
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 10:24:58 +0200, Ilias Apalodimas wrote:

> The following changes since commit ed869863c7e2aca50d57a05d843830dd843138c4:
> 
>   Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm.git tags/tpm-next-06112026
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


