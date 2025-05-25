Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF2FC54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 13:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0452A82B54;
	Sun, 25 May 2025 15:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ILtKkYf5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 434A182B70; Sun, 25 May 2025 15:35:43 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10EB682B37
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 15:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b50Jq1204z9s11;
 Sun, 25 May 2025 15:35:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1748180139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MxuouXKX0NMWbdgqQbwd/04Xwc+eHvxbEPtZtUlw6A=;
 b=ILtKkYf5yy/2X1sxXmX7xRwE2VjemWkAUi8EuNRzqxCm8zxvfiZ997LDEq9v0gCmi32GrB
 q4A5DOXVSg55P7kMNgFqGTfWd7yMEEi1k7rBM5nuzlAkoy055vIelIpMdyt5lFeRh/LPJi
 d+UGgP9dqB9A0rW2XvAu4CpI67HouMFz1HTIQwfsLon1dtlyGZf3c4GYLFAVjn3Xq2/7tB
 Pv6jhO7MOn46Xsc9BVmViDsg/LZMnDcc93q6KU782+/zx84TtMX/CtU0abF458YH78oelY
 Z94JjfP+J9k6v5wfMHD1GT7nZPk6cjmb3hwwf1pbkxFcj+iExJCaT60LW+MEaQ==
Message-ID: <213103d3-8cc2-4223-a276-a08bd14a3876@mailbox.org>
Date: Sun, 25 May 2025 15:35:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] board: rzg2l: Drop myself to reviewer for RZ/G2L boards
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul@pbarker.dev>, u-boot@lists.denx.de
References: <20250519133208.6352-1-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250519133208.6352-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: xgchjk7464qpokf6f6ns7qp99kt16bgz
X-MBO-RS-ID: 65cc77702538e10300f
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

On 5/19/25 3:32 PM, Paul Barker wrote:
> I still intend to review patches, and will be using my own email address
> going forward.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Applied.

Thank you for all your hard work !
