Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1925ED0E6D8
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E17E84042;
	Tue, 25 Nov 2025 14:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="C3CFKQzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB5938406D; Tue, 25 Nov 2025 14:02:48 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6584583FFE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dG2sk1p84z9tlc;
 Tue, 25 Nov 2025 14:02:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764075754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Wl1w2VtLfxSNRpAYkHu7BRfuq2A+23W+gglIllLFxc=;
 b=C3CFKQzLi7wBdc+pNB0RthHTTCZ0dmyDBOoAjFu8cTdPh22k2kphzpxxxjP+mc7A2uLy4e
 O56qwWaPMUEdD4yplY2dkzGc6n6jovpjD+j/5Ep/EPa9HMQ3m1Q5dlz/wYcnaSzfpyWLaA
 DhVIbJVj2oDpQmD1cPU6VoPmWkLRC7wpW7qEiwcb+8TITb3+cAbzakzJzS53ASmfSm5HHN
 dPI52EB3MQfme5CJBN6QACTM7OJQkyX+90J4utnCIK1KgM1up/+KzzIyg49QnF+2RSHtHj
 GRiopmBih+ZNYpAHn8zc+9XyInWUtS3VoszP/DL1DKpGFSgL76+MDjn8oyKHPA==
Message-ID: <9a806a26-9a43-4e7d-bf55-663f178db4dc@mailbox.org>
Date: Tue, 25 Nov 2025 13:23:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/8] configs: cyclone5: Enable random MAC address
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-4-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251125081316.17329-4-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f1a5c8fedc9a9c42027
X-MBO-RS-META: 5qurobb4xxq9ykufbqudwi9hwxxybqkw
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

On 11/25/25 9:13 AM, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> 
> Allow random MAC address assigned for ethernet initialization in CycloneV
Why ? The commit message should always explain the WHY .
