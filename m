Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1298CE6FE23
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 16:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7183684120;
	Tue, 23 Dec 2025 17:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lu+3suVu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83F0384142; Tue, 23 Dec 2025 17:55:53 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6E5583CB9
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 17:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dbLjx4T05z9t8N;
 Tue, 23 Dec 2025 17:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766508949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ulO/JpeiUWmh4K/9uWpCB3VRXZNKK8OCvxjPodzeVo=;
 b=lu+3suVupbkIvO0K8rl6z/bgt6TlTVmcQ/Ar9/tdaybPv4G0PA6gtGzDfOrO5uPbDohVgf
 r1rgo2OSxBTi2SGdlWq6nqLWA8kO8oDAnNrqO6CiQkPv4xfwtamElvsb/BhTwHJawLmnst
 t8gNp2+MlAgF7mr5pgClfiwyDvizuRuNBwYk2FzZqq1xbCLXz4SCna+DeqXCZJFjFfhwHC
 owm8YR5JCDR2BYXb+YAtwc7B6+BOK2zhqzSZh2oeNKGcRrL6T+gPnPaoD10NUW6Q+CySCQ
 PL6y+EVg2NCI97OCk552Xh0ceD1UQShwJcWI10REHkmRy0MXTERe0b7SszngQA==
Message-ID: <3f4e4ff4-d2cc-40af-95a8-eda95250f9b0@mailbox.org>
Date: Tue, 23 Dec 2025 17:55:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: ravb: Configure CXR31 and CXR35 on rzg2l
To: Mathieu Othacehe <othacehe@gnu.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
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
X-MBO-RS-ID: 17fec72e564a426bca8
X-MBO-RS-META: sxg8ja3gq9o3cchmkb9he3cqjeoodp1h
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
Applied and scheduled for 2026.01 , thanks !
