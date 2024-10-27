Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC6FD1356D
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E57489068;
	Sun, 27 Oct 2024 17:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZT/J61t/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dAH+bYeM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD9C82BA7; Sun, 27 Oct 2024 17:32:18 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24B0F88B1F
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Xc29Q6FDsz9sTc;
 Sun, 27 Oct 2024 17:32:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JR5PFptNB20DdHYz1Xeew7nN8DLJiBj40JARHoz+YF0=;
 b=ZT/J61t/PsmrYrlODAGXFzWb+0D8p3OCHvNNOuZ17lTYg9LJSkclrrt142CiSTlMEHZnSs
 mGbKmqjLlx/i7unIyzn4OQm0/4C4ghCNe/+Guo6HaBiTn/hqNyT78gEAaPcYYmHlXbdaGl
 XFD3qWNwv3qqZqy0/ZHCcZy7Cdvaqkprb85DHs7IlN/WGq/4/nsOqHVxFwQC0ROcIvB1DF
 FMfO+I5gUARyb0y4uLJn2qSqT8u/3h5rA01IadGVdT46I0pa0NPAUg4Vk0qKcfgVDRcJ5I
 +L250ybg/pjl1HIrzR/REuLcviIa0nCKKmecX4bNWjYTX6r3ibmBdAK1Te3ccA==
Message-ID: <8ccae47d-17cf-45d3-8233-f4381adc4272@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JR5PFptNB20DdHYz1Xeew7nN8DLJiBj40JARHoz+YF0=;
 b=dAH+bYeMrP7RneHJiAVOCPsyD7D2jKQOKfm/i3UsNG/RxZFFuu4EUpIOCEXBU4ZkqYlaqF
 zcccjNAP4OQpCp1212SvHm/qtByhmoQSv46trS50HZpqvJ8UdE7OXrf+ZpEPzuuX7CTPV6
 zztSNnZ71qB2Q1ZxU5x14lEmJ8LsvoG6CFUqBigrFtWAiWel72legBQyIeYkIhbE0eTYGw
 5M0PhU1RIbqGkCd958qohtBJQZZd+MKM2+e2BAOEzeAiKp/8Fvy9ZhADsjLr/71z3WhCBQ
 HGcKAG1Nj9sxW3TiZs5/1cC+cZYcVV4rTAmy0iHff5Sl6YPu4rtFNdjV9oHQ2Q==
Date: Sun, 27 Oct 2024 17:25:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 01/14] clk: rzg2l: Ignore enable for core clocks
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-2-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241024152448.102-2-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ebpcu635oygyteehf7ypr6937pnku4i4
X-MBO-RS-ID: 3434d82621d32e40fe3
X-Rspamd-Queue-Id: 4Xc29Q6FDsz9sTc
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

On 10/24/24 5:24 PM, Paul Barker wrote:
> In the RZ/G2L family, core clocks are always on and can't be disabled.
> However, drivers which are shared with other SoCs may call clk_enable()
> or clk_enable_bulk() for a clock referenced in the device tree which
> happens to be a core clock on the RZ/G2L. To avoid the need for
> conditionals in these drivers, simply ignore attempts to enable a core
> clock.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
