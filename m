Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5BC606A325
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D+p1Crdf;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=Yerw+Saq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 136FD80E48;
	Sun,  1 Nov 2026 15:31:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zk_Q5XP769Ia; Sun,  1 Nov 2026 15:31:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 62D9F80E26
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793547100;
	b=ndYJPq/Vd3wqxErsRKOFZKplNQNWNk+mvj607QHrqGL1Qo1K4IqYnOoSYnImRANPovuD
	 vSCbgaHO+jc2Vau5kQRMrRmTO0SmL/7zTf5JyEj4kpKJAT9pnexieperG4chbJuTVwDuc
	 kEEmnOt+QrmpR5dD+dRuFxzG3TLxuCwGuXySPOaSvieqLkHA1gAc0Rt4P8UsyP/Q1Wcvd
	 SKa1vyQQ3NGkrATlAQHppaFDLSSnJYY+6S01ZzZE6+4jzUCX0O5HQnF34YriwdefA8l0i
	 TBacSZ2MQ3ihjoWYnK4ZCuX/HQW9cJ6eG8b19YxF5Xm1xGLZEg10iIcIR3pU6VjAgqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793547100;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q79zKz+C7aV0XynWW2Us+1JZKTAzygxnfkiM9il3OP4=;
	b=dtmddHPqCLxa1f5ls4mZA2iyPghxFdUna2nMuIkRcV7mGRyN1EC+O1uH0P6Rtiq5PY+H
	 s/E7OnXSsUG5di+PIn/bgxQMIE4ZCaEZzwQ1tm+bBwFFjiv7KeO/GsbHoVi8DuqyTWSPL
	 y5P+xMNEZuXd4v94MZHoYF3+hpupBLd0LRRrWzfMOxwqs7tjTas+E9eZekrv3oAON/EB4
	 LNjcg3q3iCv7yrPkJ/pwXkSEyGW72HubLSasalON3Mc4zo3tYp89xN3C69usqTY/dZ7R5
	 T/LGqsU1XfIkVfxc0dIbnsOxxGTqWDo7Yvqy972nK6RV8L7dPo/LeKMEiiEXR546+jA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793547100;
	bh=q79zKz+C7aV0XynWW2Us+1JZKTAzygxnfkiM9il3OP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D+p1CrdfRsnn8+GTgnd4D4aop9RC3MjJgzZsiUcSTTn/ukclgpPJmgqS6HAXAohWB
	 yAjwIY0TIPUzCaaD+CLknIsHxlAAe2f+kl9NvWmd5cdNFYOKkorgfQEJRCUIxYW5Ek
	 fR2t+KjuxojetLeCsx/UeLTbngsdFdWBnS1T4MdowmoK2QwSugzBAKQCMcZIrEV7DP
	 ewE3k3kYtsz12H76p6vnY2G2BlEZ17f72UimeQTj7o0sf/l74WsEkf4KwoeHLnOrOB
	 mzSIAcCues8ScAYPOwgbJMDsHDCSjzh83QCcX30wDzPMX9LCnrf96WjifREpLH2hsl
	 /9czUPi4LcASQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62D9F80E26;
	Sun,  1 Nov 2026 15:31:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF67C2AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 15:31:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5176400AE
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 15:31:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MfC58x_2C0N1 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 15:31:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 101624004D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793547099;
 b=IjHaFFOb+NloVxc5X2T0DoBC8/usyvpXpRSiVkDFfaJisgSB368Sq7h0wCiG4VyUI/N7
 Crg4Niuxj8aeZ8W+4DpbqvQ6UWMWHUpyaIKg2pwrpk6TY83+oPHs9jnVP2lMEoQqWxMEL
 ywHlzRxRKXYnPO0X8nVoUJjGgEjmHDvwBjnUZ/BKDFQ4F+2MuRjuIvPcaobUv2S5LEPNQ
 Bs3YyPlA3SZbhxrwgDqSZNguB4nPgPm5XFrP6KvFGakNj6ySxDlWX9UdCJH/sPd76VvE9
 cuMlA6z5O3W5q3tApRqyKLMA+5Hg9VKDPk4xmGknykcgeJmRVs8ZAYI036bVRvmYrbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793547099;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=q79zKz+C7aV0XynWW2Us+1JZKTAzygxnfkiM9il3OP4=;
 b=ZramdY1xHgBjItEyRmi7xcH478oDtMKpHILesATMPWOxbI4cs2Q6MsRkUg5XWKnu9os2
 V3+rGOUm/hZNQQhuKihzIU06lqWrR8bj45ZngCSGrlvTmALKSUhNOpBbVuEg4XBViTWRf
 J5mtW9X451rtcVnpnHKKDaXNzTSH2rI19X+wWX7kypwvf3xmufWiPNl/AXQfQQsby9FSi
 /rTM0p1gSitJgw2jkCP/pVGil9E+jRG5IPeHblVHHcITTWzN84kzPiad/jmOsdi7wQf9K
 z1D4TGzS4ZBrgJF9tIhEPQgmbzSqgC0vG3EcMX5xqY711hQ+mfhzeL8pvSnHbMJ0N3g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=Yerw+Saq; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=Yerw+Saq
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 101624004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 15:31:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id A845DB0054E;
 Sun,  1 Nov 2026 16:31:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793547097;
 bh=YkhuNTaA2ffTdn+EUEXr+Eq8W2sqwRKrElDveezSngE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Yerw+SaqlNzYm5/rZxD+b1I5ouaamXOmrywToBUV2/4s1S8wSFHpDpwHP3JRMt1xv
 5z0GTUrgxh3vly1YD0DjUvpBLKypaPW2E56l7X8Zf+YDQIEtlucJstKxDyjdb/eA0K
 DpohcRz+kyVnGyIl1brDpOnYOc/wXjQ8HtM2HCGc/3kllQx40LWWe+OGeVXNVqr60S
 EZHBnLSPqntZb1DdWqzkhoVNRm72YpPfG/aUCWSw4JhMnm+8t/UQ05QOJUF2wUEftu
 e9h4T0VdIK0dwdA5iW8K8bGz9sy7gmBydl0vj2f1hGAXh4uDrzIEJJb3q6FfWHD5Gi
 KDjBNTU3M/4ZA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 2/2] configs: nbxv3: build lib/ for speed and zstd
 unminified
Date: Sun,  1 Nov 2026 16:30:59 +0100
Message-ID: <20261101153059.380205-3-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101153059.380205-1-vjardin@free.fr>
References: <20261101153059.380205-1-vjardin@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Despite it increases a bit the size, the benefit is a faster
boot time.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 configs/nbxv3_tfa_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index f1a6d9b62d6..3c2570095fc 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -103,5 +103,7 @@ CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_MAX_CONTROLLER_COUNT=2
 CONFIG_WDT=y
 CONFIG_WDT_SBSA=y
+CONFIG_CC_OPTIMIZE_LIBS_FOR_SPEED=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ZSTD=y
+# CONFIG_ZSTD_LIB_MINIFY is not set
-- 
2.43.0

