Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBC606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Bfct+FSL;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=iJGIblzU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F22C560DC0;
	Wed, 11 Nov 2026 21:26:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZ2m-erc8hV1; Wed, 11 Nov 2026 21:26:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3A9B960D97
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794432377;
	b=RdhNuDgM6yBBpbyGukhABD20AFQ/pvvEF+z+JA5XANgs557ANkU61p0n9AVi6eO5SjfX
	 7rBKML+SXNbkwvka8cvmGY7z2q+g3TgLn5WEUXIrHzrQoZHDitXCekIFR08AivPEnZEuG
	 TJaO2CfMVeULAaGhl/d6DXS5PTE2/dTM/gQF1jdN3cFbzOtp1JUWLxi4JCR6IiQyagKh+
	 BP4KVaNMP4OELQ7//Hb5Veyezt3foUmAAmDn2Yta6fUFWkpPYAcUOQ0TEGN/8+paWR4iM
	 bFgGMhJjeOrBbDFcivwKEU7k5u5YG0AHrx9MZ26wkL+1Pdprp8E1qpBYw40wCWL6Saw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794432377;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AKWDJBWz19UZIUyakZ3hIii09MP8zo3dxnu6dd+CET0=;
	b=mWa38sv/huThBTHiwpNgN9r5LxZntFhCkSfXEIwztJFPLuAdTH9hhLRNUPIobTtQpiUy
	 Rn0oxj9KiutkPlm+Ha6O1dyQyadwGO04cgjv/GpqUozDR+7L9i+N7YKyx58E4kq/J6634
	 9Jm49UP+rNJnxsGPIUw/ubcV36ig06XCd3EXk5XpUdVJ1/VG+YUwEita4osTy5ee29YVm
	 XYE+TJJkjbMwi8Bb9DgpBCebVYLMGx61uIPccCRcCrMMNg7xk1bayPSXLxHt/YT3yMFyB
	 4SYRMNPJMtP+O5wFQ+8RRcaXCgPgWg0dcAtsXNNBsT9IVoNR6s52iUWRfxX3PkNn+rg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794432377;
	bh=AKWDJBWz19UZIUyakZ3hIii09MP8zo3dxnu6dd+CET0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bfct+FSLXmLmdersdq57bhC8lOth+Bhpue86tdkjNNqYQcaIBfGmQ5tlOLds/JBlb
	 Y44ozvzIilUvf6OM/jwB1NT2rc6JW0U521iMj0PDStcOGYkuB4Kq1PeTDbrQV9KS2G
	 QlitjilZxRmxKqh6SZ+Esr7L3lBNY9evOclldgVbJlRHduiYhsGpdn7yDDj+0vItPm
	 GlYZJ0y3F7KxYiOG4bFBxfvWNH2mCf9WwzWKMAD50XDVIFCZuHKFfCCiqH+38bsqYE
	 dSE73U7ua29Ry60ImVQl8ZQhgrB6oAgaXxQMpZqgo/mH45YZH3asJcxR9ieSmtFm3E
	 Pjkq46sjEcmtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A9B960D97;
	Wed, 11 Nov 2026 21:26:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF4A931F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D0B898121A
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PpkBEN3KGaIX for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 21:26:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2586081213
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=iJGIblzU
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2586081213
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 21:26:10 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7f48c750afcso2330676a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794432369; x=1795037169;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AKWDJBWz19UZIUyakZ3hIii09MP8zo3dxnu6dd+CET0=;
 b=iJGIblzU3eSEdycJIRkv9UTNvjrT7fR1sV0QMKJsyXqD/W/a4v6oihC5z/Px7E/CgF
 nzWLABJSV3qsJ+FqryKBTO5Aa+dwUusibdfbn2Fo716iZuQp0NDnfnuQah06fLfAeer3
 XbayjXyJWigcAVK5ic7wFFL6A2JqpvgRpzgeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794432369; x=1795037169;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AKWDJBWz19UZIUyakZ3hIii09MP8zo3dxnu6dd+CET0=;
 b=1qutWmLWPqIrrrhkQPdRx5d1H8L1YLdboVG4efuvtDRFo/Z4VSV+JA5rJmqs2b6cOM
 jCh3cpq678tHOWHdKVReaIKnZDLX2HFPAy87d1OQDu484St7LgMN0UEkZj2sqJtfVd/w
 sy0AlXr6JHkeRdAdTooEowwL+ZBotPrQSWniuZ5QDZaSmprVz1mD9Ts5uGjGa/z5jBGy
 1wBz3BVw5npj/YFu76Q35QjxnYdaUDEnqjm/sgX34fw3fosZ5Xiruczb7HE/KgwQsfIS
 XKDYHxOT+5nyvdaPHfCxLUAZgVkfhkT7AphGUrpKJeSa7ZuixHf427QQGB+1wtA+EcHv
 f0Aw==
X-Forwarded-Encrypted: i=1;
 AL+hErGbwFrQ8EiRateVYYVCw17CZFSttPFkaJNf5FDquo0FGoMRte2UkXYOsaW+eFwJNuiUyQGLq88=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8ywECoaKUAInCdSe0eBzpN488Y0Z0QpiOe5dfNaytd3WhuEkoW
 I429MFiVJ6QG4gV5nvGVFoPdoA+lW6r+tgBrNdeCu29o9WWWkhK56wB51vJjJ2zYKZ7duaRNYvl
 JWma8gLIdHTBR
X-Gm-Gg: AYBFou3y/63Z1r/m3mMlWsuUJZCyabSNkrIJNc29shv1EVy2Mb/Cgb8Q/B5EYkGGKOt
 vY7qmsWUYN8IHj9ztUQedfP8kTEQxk7mQcXUjV5Cwgt3cmYbEQDO5t2z5pmiut9R7Eg8FDRqncY
 zynTI8x034S2djjmYeQ6PdZQgItPNRM4ETa6RiVHGpx/F+JfsD5OiD5yoYfIqKhwin5tJIh1uKn
 XKzpj6Ctpdmjh7ez803eNXBtMhqsAp7tP8WfPri3WTYy33JY07nH/HdaTiSma4qQ0Wvool5Se9I
 Xg35FiRvMkBov3jvVgCsXgDaZayR7FFaZY3l7rfpzUHcfidieldqWCkvwszf1kZAPE+SQsRJPEP
 GILA9xIqhzstrBYOwaRdILSP3Oihw/pZrFFx4g8f5kMxd0z/0zz0P0Heqgk7e/8UVrvH6Ab5aIH
 89BD35t/uOEPDUpIBOqMHmmSndJ0CfVnAgsAP8E3fnfVPIhu0bDPw83Jbq1qWZzF4DRlI4NzvXH
 wPjGTcmTbdQFcVdbMQckOruXEGfjYSxnwLkJXm3su+xHu1S1QZFBIsOKo3d+3mR6iGAV6iDIvLT
 nV6x/mSkabnOFGexM6vsrIYyqS159ubZVgBhWSriNjD2XiofFqiaQVYcXX6nBYfLTz9xQ76xxh7
 w9CDSOO7fv8u3BFH43gIHWe0FtZDwkW9snCQx4VJZadwH2Z21ZvjM71/I8er7EVrvmN4a3roXNA
 NKtalmZciNxqdDUeOeE7nFqT3mhl5K4w==
X-Received: by 2002:a05:6830:4408:b0:829:79df:f84a with SMTP id
 46e09a7af769-860f270a588mr3371736a34.10.1794432369573; 
 Wed, 11 Nov 2026 13:26:09 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860dcbbf1d6sm5205628a34.13.2026.11.11.13.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 13:26:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com, 
 Oscar Deschamps <odeschamps.mail@gmail.com>
Cc: miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261029153940.461197-1-odeschamps.mail@gmail.com>
References: <20261029153940.461197-1-odeschamps.mail@gmail.com>
Subject: Re: [PATCH] fs/squashfs: fix NULL dereference on empty-directory
 lookup
Message-Id: <179443236887.664252.59332909400265783.b4-ty@konsulko.com>
Date: Wed, 11 Nov 2026 15:26:08 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 16:39:40 +0100, Oscar Deschamps wrote:

> The three directory-search loops in sqfs.c use the local `ret` to tell
> whether the requested name was found. When the loop runs zero times
> `ret` keeps the 0 left by the preceding sqfs_opendir_nest(),
> so the "not found" check is skipped and the NULL dirs->entry
> is dereferenced (dirs->entry->inode_offset). A crafted or corrupted image
> can thus crash U-Boot (a NULL read) while resolving,
> reading or sizing a path.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] fs/squashfs: fix NULL dereference on empty-directory lookup
      commit: 106b3d678ee8e33fd1bfae4f2e831056c87f71e7
-- 
Tom


