Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ADDF506D2
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 13:52:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD648407D;
	Mon, 16 Mar 2026 14:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dLJRJYfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36B228407E; Mon, 16 Mar 2026 14:52:07 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5299A8407B
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 14:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=QIOfMl9VihKD5AFrRU/KjF5QUkguDbpOvYN3FG+SVXc=; b=dLJRJYfZoHsahpNeC/bQE5Qed3
 +aZn2kMmxc1z6jo90Y+GiVgtnbVM2GVQT0LNuYXK2aoz+HJwzXowFWilVbF7AiOvUB+7W1QyM9dPr
 WW2QXEMENYUV9CXgnGfVqejaDMRhA1CYD/ibW8g4sTPkZy3JCEY4ab8eIc+WQvSR9osb2oRINcfTb
 g4VMd1M7WamqnktXoy/sAjzZXuC12guZlpzeYvJZ0YfWEv9h6ojDmQ2yg49/577o0yN0NNPENpvIi
 aUe38yCVy203teVGN9YQ3kkcfn6eJiXARZUYzZt0NczRQqdE3g3RcyunImcKKHeFtVbnitcpIgGVK
 5ypsLTlw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1w28MR-000Ker-2C; Mon, 16 Mar 2026 14:51:59 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1w28MQ-0007rd-1g; Mon, 16 Mar 2026 14:51:59 +0100
Message-ID: <4781fdd8-9467-43b7-8f06-b73f972f78e0@ew.tq-group.com>
Date: Mon, 16 Mar 2026 14:51:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] board: tqma7: add code for u-boot with spl
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260312143118.1677859-1-Alexander.Feilke@ew.tq-group.com>
 <20260312143118.1677859-7-Alexander.Feilke@ew.tq-group.com>
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <20260312143118.1677859-7-Alexander.Feilke@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

 > struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;

One note on this cast here: It seems weird to cast fsl_esdhc_priv to
fsl_esdhc_cfg here. This is done in many i.MX boards though. Just want 
to make
sure if this is the correct and intended way to access the sdhc_base 
address.

Thanks
