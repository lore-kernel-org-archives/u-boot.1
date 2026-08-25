Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B444C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 17:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2B15401DD;
	Tue, 25 Aug 2026 17:00:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tXhaaec7oZ8k; Tue, 25 Aug 2026 17:00:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787677217;
	bh=0XXnMQujMYh42WmzEC/Ixtf+seUqwFo5rRcOu1yYMXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XUX2Oe1EaEwgRzMrVvEW5epqd6cs78HwvbjEzAu0GxDPlX5OoLKq6Pq1TNYWO1+Vb
	 0QtqoL5QfekSvrQzRJ73vApe/YRcB4CBWkYE9z66/vyYaN+vSpZIiYq+J8giFLlaA5
	 Zt0n6XW7b24FLKRbJKsrhKEDhuwO25Afy0ScAUSjYAuYirCL2G5ucevGVrXqVwhDAt
	 H8vTAqQEq+t5pbe9SbnEk7wzLFSjXnY6un5ox4IagMGh9b0I0eAg8YzlPyBp/DwIIu
	 EnDQnSfEOgDbXvVgMOjgNMSxULrwdpyDLXxCJNukxcRMx0q+yugwBkbNwUU2rJpPSz
	 tv6abpBjeUoKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEDD0401DE;
	Tue, 25 Aug 2026 17:00:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 337F335E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2596A80550
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LBd4wOAaRT4X for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 17:00:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::42ad; helo=smtp-42ad.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=IpBQhQSM
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::42ad])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 390D880542
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 17:00:11 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hTv0k0JnLzj4X;
 Tue, 25 Aug 2026 18:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1787676629;
 bh=0XXnMQujMYh42WmzEC/Ixtf+seUqwFo5rRcOu1yYMXQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IpBQhQSMJreM6v/FCO+0kylyVL3et8aaJbBKpckGRH5wECgiiLIUn3OFD1gux/14g
 IJw5DdYtTQGvdGZSwk3TdA5A1aZuq4fBM+xjCxaQPQ6v4o1/CaebOVU1zu5yZzbLy6
 6Nq+AiPU02ks6vRWMEJS9qGeQGHBr3HnPXrPvK9wQwBHBoaVtVLzNXcYXnFu6guGjO
 qlu9HvGAGmwPlAfU+gdsTjg6iOdcVdp0CRKUAikuYQgcK3QzU2jPFaev5TpcSDgDr9
 Qes4YFuAl78tDuPIRm0X0sMTKb/4sjt+cA9lZcyy4cbWPbKLv+yDCP4S9bHGENr9N7
 uOPi4QTQchRgA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hTv0h3cPWzYd6; Tue, 25 Aug 2026 18:50:28 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 25 Aug 2026 18:49:55 +0200
Subject: [PATCH next 18/45] doc: arch/sh: remove squatted URL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-linkcheck-v1-18-ee7573fe3a4a@cherry.de>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The KPIT GNU tools URL redirects to some totally unrelated garbage, so
let's remove it.

The other URL in the git diff is left as-is even though no server
currently answers for that URL.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/arch/sh.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/doc/arch/sh.rst b/doc/arch/sh.rst
index 3e3759d68b20..87ccab237c48 100644
--- a/doc/arch/sh.rst
+++ b/doc/arch/sh.rst
@@ -73,7 +73,6 @@ Compiler
 --------
 You can use the following of u-boot to compile.
    - `SuperH Linux Open site <http://www.superh-linux.org/>`_
-   - `KPIT GNU tools <http://www.kpitgnutools.com/>`_
 
 Future
 ------

-- 
2.55.0

