Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD4BE6F093
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 14:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05A6B83FFA;
	Tue, 23 Dec 2025 15:20:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="va3ufbQO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aSGE/yix";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C9EB840CC; Tue, 23 Dec 2025 15:20:22 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9139B83FD4
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 15:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dbHGV46Nyz9sqW;
 Tue, 23 Dec 2025 15:20:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766499618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNbQBKoK3OPYMdASqve7f91RVjRTbMWBvhTR1WbwvsE=;
 b=va3ufbQOfgvCktWky57SdIUoMgE/CUWEJ+D/C3PFDaE8X+kGWZAjOnpn0Hlmn4f3mi/TjN
 R9aBe4/A717Daue25rpjiuTImcpr8n/qQssmD6sNHwi81xAkQkbJfU0isJEGr9o+sbe+6j
 fKd+zyP1QWQC75I/1PKjnMHxCqoHNYBb6EwH/fMhWoZin7yxjk2LlJxTT94kMEuBHFVBsY
 xL8XtbA+tlAdUDC3wKJm/ddt8LIFOuN48ekXySjfcMYixi6OWQW81agTHmuyD2fsSgrWZW
 Y3mmMoz5/yz1mmNuUE4kt2HfOqgVFvtDC3ZTaJVIMB8/dHkGEDtVJ1qmghy92w==
Message-ID: <73c4c418-c538-49fd-a441-4769e60b6e5b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766499616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNbQBKoK3OPYMdASqve7f91RVjRTbMWBvhTR1WbwvsE=;
 b=aSGE/yixbhMteelWSsnBaBgMe4VUHDkT2WcdIG5ZdoZc2ZLI9CKd9mJquxXj5ssBgZmqm+
 H9ih6NLvGJD7GKpSTGRBn6F8hmUna7+RkjVPEq7/P+LpQ8w01cjVJYXMrlbMNaG3+4M7hx
 YzVSbSuFOQcn3qevM3HNIL5PdOz/Yl53+ShjnDG+F/gxdJWRE3tfQ+sEMKOANvyX3MXXUe
 3lc7hKmi1DQCZ/ckh4nukIb38Yr5OKpeYHqN2qQBXSBkvv64Nx1Q9KA8T02m1CxLk/35lJ
 HiDNfsJMI5qLLSXpUQEQCRT8NHh5MxSeBHz4LuazkYQYFzxt9wuAPvwuiJ+x9w==
Date: Tue, 23 Dec 2025 15:20:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: ravb: Configure CXR31 and CXR35 on rzg2l
To: Mathieu Othacehe <othacehe@gnu.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: anton.reding@landisgyr.com
References: <20251210141706.32760-1-othacehe@gnu.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251210141706.32760-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d7c9bea63d064f87d25
X-MBO-RS-META: dua47a11p6t8i4sg4e1pskshahoz9yp9
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/10/25 3:17 PM, Mathieu Othacehe wrote:
> As in Linux with d78c0ced60 ("net: ravb: Make write access to CXR35 first
> before accessing other EMAC register"), configure CXR31 and CXR35 correctly
> on rzg2. MII mode does not work correctly unless those registers are
> properly configured.
> 
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you.
