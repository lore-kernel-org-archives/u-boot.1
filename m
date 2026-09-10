Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AE6C88E40
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 06:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E2F240A4C;
	Thu, 10 Sep 2026 06:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K8qIMDQXLo_8; Thu, 10 Sep 2026 06:57:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 96F4740A4B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789023464;
	b=qiZUGTU16qKvSAz4vGARxyz7H/hp6rnVSpSfeaMrP936OnhN0Sq6vAJI24qEyv5WeiGZ
	 MxR2GuGzaCSbt9L7+rdZ9/PEu/z1W31vOrpWe5XIvYdRFulWG7ZrIEgTARPK2hEdMDz+0
	 +/4nqUyjHfJ0jJPw9byyzyhmaVeubbme9ICs/2DNJgQO7mkFGUgnmI2JPUmfVSE26QKd3
	 JTNGQbHnV1quRF8fQ0CfcVH4kK7cLSjEVF5vHZEFnYphlWki1tTQ7P+YOxuh9mrWbQIY/
	 uedFUJXpAk4Z6oSFiOo7CUKyaJ0ovNPpdhY+LI+IstzzbpciK6WH/lcrvvbaqilJulw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789023464;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZxsQkFby1vVHreBpcvnA7Ak9h/chh5hvBOQPFvzHtwE=;
	b=rwZ+7iwJKhoOBZSCn6acR2vwIhu3ew8KkvX873kANE8sSWvJTZ0qMJM8F6KNsfYjzgMY
	 mnIPvTCGt89zs0b1f5D9VffpzkqJugXyPIiFYmG+b3lYOPT0E9SUntD3JpjRMfWnm5Mhl
	 UuR/RjqMOCGix6IcgZ0qBrJx7pkp/KRQGhFmEkjKtm3OmjoQiI7DOSvmQv9oCGZMeo4u+
	 C3va0SdhuSjAol+NZQdAOB2QkL6qr9FMqeRyfAXFAmCHNnkib5R1LhMmXldDRa3KBJiw3
	 qyFzESJurEaksbMYSgbXvNN4GiC2oDzKxtJICphTXLrxyKqg3GkXccySVrmZpNr4ruA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789023464;
	bh=ZxsQkFby1vVHreBpcvnA7Ak9h/chh5hvBOQPFvzHtwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xeLgHzAF0KLRDQeKMGHmUmGse2xr0cDeaQYHXUiuAkoZjboMy5TScPZZr5iEaCBR4
	 WlNf7aXiiPiLFFqTwUYYoYzEhxMoMgTJpqv9cLwvEJm56k5uKuBv8IUHMC46JCCFmM
	 MZNSJb/aMdyr3HrPf6DWygreTLiO1eIq35gQrjPmqBjIkUJFRbk+gyZwZKXBkCGTlq
	 iDdu3ggNx23M82W/KDSmCmvFUfzovZx1kM267Q7dU2jbMjAeEe831nqnTcEABosIvY
	 ovr+vezkD4tb/IfTyOoo2TwgUpX096nvPeTj2HFdcvVUEvv8Zp5jxO8i0fPFkYmBOm
	 mksXyq0+0PMCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96F4740A4B;
	Thu, 10 Sep 2026 06:57:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D56BF1EA0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C765180F00
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ffxq1VVYo9TD for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 06:57:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 387DF80F04
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789023451;
 b=joO/BgRc8Tav7X9Q3PhDELFoslsr3i0YOc1VE14e6+CyDi1LpN1eitUrw28uCNM+kQtp
 RJpfN+QuUXGzYLZTNKVKRIYLKocgjWO47EagTMQbRk/v7fvpTHvvo9SmjX/6mgTr8FoiH
 8vgxz5t9PWcXMyVtjOrdHkoyczm7o0R7ncR1NEyiCmLmujXJPrxn5YUrHDJHpTRHSE+kn
 wYJhsQwBGh5/YATj/WwhJjRH6a0y+xfceEbBsjiIVrWXzdNHrfWhVjghLmDh7tB4I1DRm
 wM9n/Cymgho58L+3/uHoPzkhp0VlXDibBHxp0yf74B+XeWxjZlepgvtyM1bbUnQF/wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789023451;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=ZxsQkFby1vVHreBpcvnA7Ak9h/chh5hvBOQPFvzHtwE=;
 b=Cr+rGBrtcsnOQfYKGtFYph6H8IIxoHVUxy59R3Pc6lCAA+1zXWmSRQjY+iM95F0zIlw9
 HOoV60sw98zMxYDe6FyS8+Feo1ENW96ZnsCSsnMr11X6tdXfxUury2B87OhrXC2sjd3b2
 GEyao47NV53P8uAE08pqmz9GjRD/bsPIacovD3vlAyvAe2z0cfTQsf89I0HUk6IGZzM8N
 Z/CWgx4FFDbf6PB1CkseQT0ZgBNI1OPQc+ETIKAZ1YK8JHLn9gI2R56TPg8g/my5tk2+D
 zjc+eJd+0Ygct9ouwzPWgRzsCFCn5yYcO9+siKjCF+R+co0Xkcw9ghFiTDCOwtde6QA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=jz6VNuNm; 
 arc=none smtp.remote-ip=185.136.65.225
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 06:57:29 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm1 header.b=jz6VNuNm
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.225;
 helo=mta-65-225.siemens.flowmailer.net;
 envelope-from=fm-294854-20260910065622e27b5118a3000207aa-gp33mo@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 387DF80F04
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 06:57:29 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20260910065622e27b5118a3000207aa
 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 08:56:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZxsQkFby1vVHreBpcvnA7Ak9h/chh5hvBOQPFvzHtwE=;
 b=jz6VNuNmd+I9ghzT06tWfqXxB76mPADivPpJIIiEWGmkmtCUvZ/dNidNeITi6Vrf29R0yI
 ulU37X4VHYjfDkQ/P4vhCmCahtHzuMh0vQqYNkclO+t7DCiD7OOD848WPbbCKxWCDpTqkLm+
 /HGyKwnntRWFEVqiQTU+3DwCDqqyT5iB+FTX79vPQQ2ZxcQCDR4BWvI2eBqLYCzlLILMluMf
 iQKgJL84gfh4kBPhkA1r0z3c2PEWgPIjT3kj1bEKIumtKthf49WfjRpuavIbhWtQasMy5yAB
 Rl5tXSdnwrqmSPGi4gBAi6s1vy0032cin9CQ5IwCLFY5ypK0OYufI/Sw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v4 2/6] tee: optee: Avoid binding a service twice
Date: Thu, 10 Sep 2026 08:56:17 +0200
Message-ID: <35c5f18e0eece2d7a8e1cc82d3557a0ab4b4304b.1789023381.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1789023381.git.jan.kiszka@siemens.com>
References: <cover.1789023381.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

In case optee_bind_services is invoked more than once successfully, make
sure that already bound services are not rebound, creating multiple
instances of themselves. When introducing RPMB-driven service scanning
this scenario could pop up.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/tee/optee/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2871760a7b7..e8ba8f6cddd 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -83,6 +83,7 @@ static int bind_service_list(struct udevice *dev, struct tee_shm *service_list,
 {
 	const struct tee_optee_ta_uuid *service_uuid = (const void *)service_list->addr;
 	struct optee_service *service;
+	struct udevice *service_dev;
 	size_t idx;
 	int ret;
 
@@ -91,6 +92,11 @@ static int bind_service_list(struct udevice *dev, struct tee_shm *service_list,
 		if (!service)
 			continue;
 
+		ret = device_find_child_by_name(dev, service->driver_name,
+						&service_dev);
+		if (!ret && dev_get_flags(service_dev) & DM_FLAG_BOUND)
+			continue;
+
 		ret = device_bind_driver_to_node(dev, service->driver_name, service->driver_name,
 						 dev_ofnode(dev), NULL);
 		if (ret) {
-- 
2.47.3

