Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030EDC88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC38F40831;
	Thu, 17 Sep 2026 13:41:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id broUnQ2iRqRJ; Thu, 17 Sep 2026 13:41:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 468B340806
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789652492;
	b=n6D6+Y0FhS96HbpGEnvehCKP7w5nlyfl5cyANTBoOMvsz+lS7JEwlcBlRbunOK/VK5n5
	 nj8h0+Tthr52Wo35xiUskXBB5oN+dEaaRioFmRqKeXEj5+efyhJEVuFRE9PYBH9Y/+cB6
	 WKgW0vJzTCiPUM8VeTxEQHWuWVt7qRG+ra1G/H57mrdJpjwJkDkxYe2JVH9vs18oW4v1S
	 U21Vc6QTYgPiOnDYbkAoM+Gc+G6rwpM3UZkZKf7HUSQWAyBGkNXqHxgJuTE68lxOJUeWK
	 qbE1NkXg46Ax0e+RKvEcR8cmwDNj1F/iz0NYsc13APRGR2hRH/qV+/mn9KhkmsCUHIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789652492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Envelope-From:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MeAKHexJSvZHotFf9ikOr7CmZ9atly5PI9zmfGgv3Io=;
	b=BMC6T7r/ukiaugtsHeAW2PFSYxoaZt0ewmfNIrUrOwVNaW5l2w3yXdc9A+qXFhxXbUvT
	 OHBAvaNTgWYUmo4xAOpX0syd1XllpzVn8/aIzDd2kI36jjmDHTBX0ORsRRGfyVkLRloSj
	 tJvDhl7DXPCBbN07WcABkL6Nd/kRF4aHuPYXxpMpwRF0O6wr1+lgKDokdoXs9GBiYs6db
	 0by8BAc7jeoC1oGJbiZPzSj9RYRBQLGoUhWV+kMSVwhfeLKv7fQtjCF/6gwek3XdPAyai
	 17CHv5OQ0jGxC0TG/UDnYdcqgrtfauwvZ1Jxix67offsAGEixds/rxvdgf/N0WuUCEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789652492;
	bh=MeAKHexJSvZHotFf9ikOr7CmZ9atly5PI9zmfGgv3Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mK9ruhKlRlvu50r3ZYVqDky77tDgmAVDqyTHvvxjGew9UrU3mjgopoH/QnJvJIYin
	 XVqqbcKnkC9+YG8v9CDwT8/YIoB84iXv5RUXQXPuafF+pHmZHI2lv1btRrw21Y36uN
	 JiaxthasL8UtS4KqmDjtDQISxXPcs0THSfSGbWCreA6Eu7gEnT8K9UPYc/1bfP7NmB
	 qH58s+eJBct1Ff5PYTyMUbdA8Kkeqik1atLmYGk5KHX2jyqRL5D3cWrdCHIj8MibUJ
	 t3zKdneomqEdo/RI1NyXR8TBfiB2txhbgPsMuNh/8hbgfKevhqppJLigvpZcQoLm4A
	 CRjh6JykUqmQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 468B340806;
	Thu, 17 Sep 2026 13:41:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 839E8422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7494780F26
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:06:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BPPhuWSWrAgg for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 11:06:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B992980E2A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=63.250.43.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789643205;
 b=JPgIyGwSxFaWQIVbLT6oHLIoDLJn9Xqn7KOUedAsfPWczGTaJbw6oc3bTfTJ6uyTcKaN
 vyTwcACHTu2++S4I/snZHxLT/I0fsuLpePFe6zA3+/VcQdJTYlnraALznnU9aqZYUW74o
 YB1OqYupB7FHm4L/x2SZsy0zyvL87kwqNYSF1tSDC/3yRTuDDaHNolL9K5Oesiy2esIGL
 mTLtGCGdaDGcko5PsUkea8SlIHRpXMY+sQ88gOEx4daAl3KFOurEnyu28i2jdWp4FcF5J
 qyErR0+dmOWfWbdpHEuI1ogAymzzNMWE8TrGQGEvbY2pR8/S2ONPI8j2aqj9MvH8tIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789643205;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
 X-Mailer:Content-Transfer-Encoding:X-Envelope-From;
 bh=MeAKHexJSvZHotFf9ikOr7CmZ9atly5PI9zmfGgv3Io=;
 b=lZdOt7d5mDBBjD0BTLoYLC6RNRnQb4oDiHIscyDbbFdGe0Zi09vHiWhOOTo2u6A/QM7I
 uhONHbqXOrR7rJSvelrOPIsIjDPkJJQ1k1gMqPa1Kvqfg1BwMzsG2vKFc/1wIOHkHesQ0
 oTxRtVyX2nhJ+KHhELSucQbq3nOjS2eVi7CKlqYm9Ey515BCOPVs6N28sHmrxnAR5p87x
 Plx1bEpRekOin5Dl1tODPp0o6+nUKR6HJrrBZlQL7CIRq0HQGA3JXQim6U3VK5MV8TED2
 Zk0kHVwnd5CGXhjLmFvUke7R/gB9LSYAgSw35/LZnWB8wY3KPkidUN758T6+u9shcww==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=machinesoul.in; 
 dkim=pass header.d=machinesoul.in header.i=@machinesoul.in header.a=rsa-sha256
 header.s=spacemail header.b=I7rLnMvm; 
 arc=none smtp.remote-ip=63.250.43.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.250.43.116;
 helo=out-2uec-a116.jellyfish.systems;
 envelope-from=siddharth.menon@machinesoul.in; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=machinesoul.in
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=machinesoul.in header.i=@machinesoul.in
 header.a=rsa-sha256 header.s=spacemail header.b=I7rLnMvm
Received: from out-2uec-a116.jellyfish.systems
 (out-2uec-a116.jellyfish.systems [63.250.43.116])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B992980E2A
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [223.181.11.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.spacemail.com (Postfix) with ESMTPSA id 4hlt9X5y8Mz8sWS;
 Thu, 17 Sep 2026 11:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=machinesoul.in;
 s=spacemail; t=1789642902;
 bh=MeAKHexJSvZHotFf9ikOr7CmZ9atly5PI9zmfGgv3Io=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I7rLnMvm4vucaplpTnje6eurEf70J+3Qu/NvnH+qVJCs0DYGvmqFlxZrlT3nP4YP4
 qDi+BvYprrK3TYSUKRbT9dScoFKjd6wbeUSc441R5fg61i7ndUtJquHeNsuqmeTQMc
 +BLaImV3Dpbj5nZQFqM+OLW/l1ElT2EOpARP/asZDdenIGv+th2EDlrVqFRKvN29eD
 SsiMEKrVw3fJ6/jgIhedYQpNl6cfjkK74GOCA+sTiPNaoYOcpnyvyxu6y3wCZQ1Oen
 dTc5gfh6OEdj4bVHTrIKE/5HYY33+bXwklMugt31WOFw5zjFsYsClhjM5Vv8I02Wc9
 RRlPBDuLTKW2g==
From: Siddharth Menon <siddharth.menon@machinesoul.in>
To: u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Siddharth Menon <siddharth.menon@machinesoul.in>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v2 2/2] imx8mp/mq_evk: enable SNVS power button
Date: Thu, 17 Sep 2026 16:29:22 +0530
Message-ID: <20260917-snvs-pwrkey-v2-2-15b41002385f@machinesoul.in>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917-snvs-pwrkey-v2-0-15b41002385f@machinesoul.in>
References: <20260917-snvs-pwrkey-v2-0-15b41002385f@machinesoul.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
X-Envelope-From: siddharth.menon@machinesoul.in
X-Mailman-Approved-At: Thu, 17 Sep 2026 13:41:10 +0000
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

Enable Kconfig options for the SNVS power key driver on
imx8mp_evk and imx8mq_evk defconfigs.

Signed-off-by: Siddharth Menon <siddharth.menon@machinesoul.in>
---
 configs/imx8mp_evk_defconfig | 2 ++
 configs/imx8mq_evk_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 12dcf3d14353091dba94bea760b85ae5b962105a..cfe5d2535311a572bc9f571673faea12dc699b05 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -86,6 +86,8 @@ CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_SNVS_PWRKEY=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MP=y
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index cc40e7b9bf317f82b0d11d0c5a109c9630f30137..b871a3d7fede564df41b3a03c8fa51558cf6a4cb 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -79,6 +79,8 @@ CONFIG_ENV_MMC_DEVICE_INDEX=1
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_SPL_DM=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_SNVS_PWRKEY=y
 CONFIG_SAVED_DRAM_TIMING_BASE=0x40000000
 CONFIG_DFU_MMC=y
 CONFIG_MXC_GPIO=y

-- 
2.47.3

