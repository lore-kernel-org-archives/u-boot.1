Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3D606A334
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mGnuUq/+;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Hq5FbyEb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86A278085A;
	Tue, 17 Nov 2026 20:03:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8xoKrm7kMetA; Tue, 17 Nov 2026 20:03:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB66880C9A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794945794;
	b=DP/orWzMrfBCfkGM/t2EGO2vqRHwiOUvL/GFA9gg2mCOXiS0Fy9Z7keiioeZ5NfnUW/e
	 Hsd5yTFw9+iVfeRZKhlZmmeb8WImfZOyS0JkW9qbjHzK3U96b9wK8gExiPgTjIDzWR8bl
	 gpfwFgCqoTuPk1R88br9nRevBIzUtd+nHnh07pribMBqentvBjW7S5QNpTZZkKPh1UaWX
	 5ss+Q/3C284Du7dx14sGmlL9/0AELIgV3/mLH7rQ3CxLBzQMi2Sx4+Occwi0SoDKqaYc/
	 mr/im+V7hYw4YoMcU/3yZeh7a6hjXarVd0eIHS9O/boxR1xWWnAM35ejQkm+SEDIzew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794945794;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wX5C6xZ204aQEr3BinBMp9ed1ATorBlzEKW0exXBt5k=;
	b=S38kDJUvZHYQUe4k+ZDWk42IWqf1F2iNYPZVNJnLdpHKtgvXmTtVJPyeUe+pPcVwvCPG
	 R6A4KGLGm7Zp5qjAiHzARrhxgn4kMqb7HBW6ZsV1Youz/V8U9TSC3NPYEFp5kXjuwSDUt
	 RYOnNhQWBz2vvuCZTLE1mFSfTcn3ciJGpgaHbjERfeI1lkL1wYs5aRZSExYpukW2GkCUj
	 Ja/yl2ezkoaYnT1e7S1ggC0DRM0zDaGDtIDtCFglau49m5McplJ9Cm5NyLGTAjRNpfcY2
	 iYpn5piiD9pgkHFJTULzvr3q4s2cQZkoVg9I9+1li8amgw+tT3JO52h9o3QEWtTc5SQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Hq5FbyEb;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794945794;
	bh=wX5C6xZ204aQEr3BinBMp9ed1ATorBlzEKW0exXBt5k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mGnuUq/+MRIw/23AzwRpU8oyFnATpwVxjpdI/9St80RIDxVKn2ABUPwP723hq55e7
	 q+0timXnUiedDzVU4z47/YabgR+97HNpXF3XZ3zaxXyRY469dgznPil4Z0rKQX5nPY
	 FQWHx+gCznIlqt6rtd+v8hf/z7RYugWrBkxN1Q9FEU+fV0svT0+maBYpBREMUJYrKZ
	 PgZw1p7q+Kdi0xoYuPVcLG5gvnPaJdx5A7sp7cdjTb3Wcr2T/v62l+t6hX+4GUPvtr
	 vS0nbz8IUgWnsEzjGZsFRPrN5x2G4BrL+k1s05MI84vB3jNsL6AADUW0QYNf18z06f
	 dl87q39Wkwdcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB66880C9A;
	Tue, 17 Nov 2026 20:03:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB40C9F8
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B1A1F80BCF
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jkz-UiDQSovn for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 20:03:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 139D781196
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Hq5FbyEb
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 139D781196
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:08 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-4aff682aadeso124722fac.3
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794945787; x=1795550587;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wX5C6xZ204aQEr3BinBMp9ed1ATorBlzEKW0exXBt5k=;
 b=Hq5FbyEbJc73rrnZ0NDsdxCRHLO96wa9TDxCY0jngdiXbqQgUgoolHC5tC0fErqGcx
 03my+2lYwW/qaJWRn6sqUDuTRcts+Lx55+8Z5nxljTJofP8aqmdLjg/Gd7UoSTNnt+Ql
 M5XDezKDWhaN5zm0UDY6nW8qdMu79v4j+ogWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794945787; x=1795550587;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wX5C6xZ204aQEr3BinBMp9ed1ATorBlzEKW0exXBt5k=;
 b=Osx97Us+LSfFEW7PGQAxSmdbPvUa2jmY25A8JQDO5RzXfznOn3QHkWV0qKkreTp8eK
 HS4m/NT7H9P9XUgEZ9gBCijPGpefAPKAkjFBNk0ofEJgEi30Vx96/9cKSoE4MmP8viJZ
 vpb/ZCv0M8tj0ND7kh6MrHBV2XLwXlpHjo31rdu15+oVnoKJRu+zwV21hQAcRGvMjJCf
 tf01olEvZCXlp3ZyZEBmr7xnEEz6WLDnUzoktmTul7NAcsloaES4bkn1s7EcqAsC3cGH
 04CuxtDA2NCCG8cWArJINTxFBDXBsLwQuGLYfzfTgcrokwLRhzJ3/nHLxFEITLmFQAq3
 8fwQ==
X-Gm-Message-State: APuU4Z/lYA5NeNlIfD6ThRte9rxvAxaqYH1+Lqx68Csuil9SvSONOfzQ
 1mf7xWXfedYd4ZnLMKpUA86oze27butBX7E4MV354oV6gel0PnwHMC+LY1ESLyqZU9yPEyvtCtl
 x/oSJErdGDQ==
X-Gm-Gg: AYBFou23+efauawWSxA5/N8fd2/JjjYArduGr/W7wHbKRIoPjqfJRSx1D4Vz7wQNfBT
 lhgjSfWgtOzjhdqSmUlaW5+wtBihkneWh0vOZtQ1ZTLJhQ+hAhmGbb/lXFcpBZRM2g7FV3tI/RB
 yfdFd5bfUwCgRnIPd+QxhM4j3etE2LdlNKkvVdWUlHcU2XUXMd5BvpbpG1NwuGAB3HKA5BsC5Fj
 Jldct4cjQOrkShDdLhPt+f5sC94uUubZJ2L/NVqtS5sVOO+hVtLxqRv5/n1zwgcsKrFtbhfAMLy
 blzppIZtwBVJpV40B1XT+9IwqDWAyzJ0DchJ8DaIMvNQv8ZQbowomfZ6rGZ6LOQCs0bFMV2gUDa
 Lpdyol5Ck0/wAdKcXe/THid/XBI1cpEetZEt5oBauKKN2ijpkTHwNV7Jwev42rjD0pZW81d9JD6
 QcT8XdISvnwM6AyJXRZ/4BG1moGfKxC5BEtTu9Uj8bcBmBSGLOnpRWQ3Wcu3qUggOjPq5Ld6Nko
 /7mUw9Zt1F++ZmPqjDM2KI1Ts9HDIomozJekSE0y5pFeN4iUFhn9yF6/08bWvMZWzGL3OZExvEd
 CvmB0cs8zuC8a5R0GNWWQHlZdFoMDRpnM62sJGDkLFGseyuhND47/o5EKY17UMaGv1cjeL0XKxf
 Vm45Poz8VbeGSBShhZZ7UXo/G3uhEVkS/dtiz0o9C1qC7URpeB7wPquCsYVnRTuF8oqBL1XKt7l
 +D25AadnyGrP3JkBagJx/GFq8x64w9SA==
X-Received: by 2002:a05:6870:2041:b0:4b6:d712:630e with SMTP id
 586e51a60fabf-4b75dc54c01mr136026fac.23.1794945787134; 
 Tue, 17 Nov 2026 12:03:07 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74372cb0esm248119fac.3.2026.11.17.12.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 12:03:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261113154837.1214404-1-trini@konsulko.com>
References: <20261113154837.1214404-1-trini@konsulko.com>
Subject: Re: [PATCH] sandbox: Take over maintainership
Message-Id: <179494578608.2846501.11642403676311965989.b4-ty@konsulko.com>
Date: Tue, 17 Nov 2026 14:03:06 -0600
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

On Fri, 13 Nov 2026 09:48:37 -0600, Tom Rini wrote:

> Take over the maintainer record for the sandbox platforms from Simon
> Glass.
> 
> 

Applied to u-boot/main, thanks!

[1/1] sandbox: Take over maintainership
      commit: f8cc5a5b9c2d84766a1dc2ea886ebe27e0dd836e
-- 
Tom


