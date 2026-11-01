Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D80F606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ReeCIEc5;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=nitBeRsB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36B8E80DEE;
	Sun,  1 Nov 2026 15:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KV2OygFpHzFh; Sun,  1 Nov 2026 15:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B6E180DF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793547086;
	b=F0GoLrLzMgoeSsOFd/w3TjDyjWVRD1TRVuStF4A5Z3/tH47GE9Pcq/swc8DcJOQ+gyfP
	 dNVBrc+6+W4wCoOX1H2mLOc2s0CKn0oJSrfOJZQkRUIfnnnZvSn2AMdo+pkE+bEmSWoaZ
	 vX3PBbnaht1227rXomUKDi9eI/AFA62ltVeVTM4IHZlhdO24UW996oetcODRZqS8TpHjB
	 GuFmil1ZYt/KCNfr43kWJn6cRu+eF5yFrgSUfFOB692z8TR/4MWutifk8TGiTAXM5D99G
	 IbbPsDD9g512gpF3XgxZQFQEiaDn3bWCoPtZv/vHJ02LV5/wylz/kkIHpC8ufbzzScw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793547086;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HY2WnxhDTQIGW1tKHMpI2uHVJRIhFgFqINGkOWKSZYU=;
	b=F77Gq+qzwfoX9MY4u6pspT75SS9JfKS+qMLd12uQJ99tsjYhNvnR1Wx5ueDu5wYE+cJq
	 Q1MnXbV90ogwspAfQUHiR33UKI4WVcSHxPo7ERfh/I9FbpRmZUKQQoSc+XvhrDYss3EEF
	 BqRrHxSVLc81UDvKi9jYDjBVx2OSn+8ekRCiPcnuiwSER7lLMVBrcYCdAqsN0FXiOzoMM
	 0PXTPBdiVtv1jqss8iseL0V2oUuX0jeAH2XxkZ+Fmq83hQmOBaB78aiuZPEU5g0iS4XXZ
	 t/aJWkzNnznvo7J+6rqdyIe1PxOT9G+JqjVCLoNR86u0FT0XBRoxiBe2k1HtFx5gB3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793547086;
	bh=HY2WnxhDTQIGW1tKHMpI2uHVJRIhFgFqINGkOWKSZYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ReeCIEc536WbJRNU9sv4oXP7l3Ae8h3Sf486/eb/7QnfD0dvovs4C7vrnR0dThe4x
	 61SJpx1vmpMvq2k3jw6Lj/EbRuLUdvdoVCcQt1opuAr9s5b9/8Z7t4ZYzdNpGEicIu
	 s4Ly9YDEpfPGR9at0m4aMY4DsNUlpRoc2CpMuhW9LSMYi1F3YmwlLOlq9L2LmUBSSf
	 f1GE2lkun74Tzj3ObSvlpM90DhjHY4bTVRHRMc0BCy+HhZbpN1zpZvwT2tIwBU+JNQ
	 /HskNCvjWs5buLUKfuTyiQ2ahS8abf9s/Gzo1Dg1T7hXtsNHIVzzZLigNkkEUe4N97
	 4rKD4ZhMJ+gLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B6E180DF3;
	Sun,  1 Nov 2026 15:31:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C01F34B7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 15:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1F88606CF
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 15:31:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s1Am--FbCtVY for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 15:31:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1AD0F60684
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=212.27.42.1
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793547085;
 b=bKkpIAVk4MftVqjlLox1vHItt5WaRZEXzpJHID8HexOuZ3AMRPifwrBy0nNNpSROgA0D
 LQUjmT76VY+kvDnNBcIuiKpRqoC2RPrLUSn22YAFbnBdekjrDen8+vXP2j4LtJ0RKbL4G
 mvwI4cJk54XpvpqIUxRjB2JLIstEVR/PfhtW6uBpdB7BGO/aadb38RTMmtp7umprJ++x8
 fep1zExgkX50GITUuefQ+Tb2t49GuMI0kaA5DZZ1Js32HkQ25rxIKfCvbDf4CfDQ6t1BP
 oxuKAS7EgZEOI4f5aVK+7SCpuwmVhgLLxdQ3fG7iRmAkfjzCcj30NB7teR8Rm/yUclQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793547085;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=HY2WnxhDTQIGW1tKHMpI2uHVJRIhFgFqINGkOWKSZYU=;
 b=HF/gpTsCjbTs6fgCTpOQtL/jZOmeWgMIFMZpw+OMEjwEcY2nI1bzMu/dcYz4cDOrBosa
 jQgb8qZIg+oQTAzohQrUT03fVgCvACEx7bJuj5mt4CTxMOICGG0J3sUoU1+IhN3yHMtrJ
 kMQuC5I6L7xb4LE92XXa7DcqbUgtNIEFLBtnXsqXnYPbOhCRyvqmet6yNmA6VP+pSTI0m
 jmTAe12tX5wjmOwfQoPPzTGavntEyINLvi4Z9Y0RxHtvG0+VsIxAdGIx530LNZ+p2lxJN
 yzntMzq6BlUJkH5dvBbzL0uui6pqU/hLFlmkW66E1iJco3nPlfWBmM7Y5+ypyTa7N9g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=nitBeRsB; 
 arc=none smtp.remote-ip=212.27.42.1
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=nitBeRsB
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AD0F60684
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8A864B0055A;
 Sun,  1 Nov 2026 16:31:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793547083;
 bh=YMIRhiUonRYDK7thR7f3oQATNjLv4u/Pxz4dYFYyywc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nitBeRsB+MaCAuj41FuOTkvpf95fh92/WkJrc+PxJ2uXor1SWTiha6EpaZAE44EgJ
 9WWvIzz5bVRceUbq3mONhGQ18bnsqMv1MUPEzctAVaxL5M1F1hRV32VJ6/nz7OrfuA
 V6NaT6EBdh1wn+MJky7nk6LsHbFqHeOxhMthxaLHUX3hSP+MNxTo1U6pqQ5P5rWaJp
 ZOlW8ZetPgYtl673EJFPgfjzHSLOOnYkfdJiKz3htzuGYt6bJswwGiZ8u/THp8jcWK
 hM1fqQHaU5nyzljc5fQmmRkZ2ElkQWBY9EsvWVp/wR7Q63iKH4inPPBgNYQ7oaAPuX
 DE2/gKTAcxosA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 1/2] configs: nbxv3: enable SPI_FLASH_SFDP_SUPPORT
Date: Sun,  1 Nov 2026 16:30:58 +0100
Message-ID: <20261101153059.380205-2-vjardin@free.fr>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The board's SPI NOR GD55LB02GF has a SFDP, let's leverage it.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 configs/nbxv3_tfa_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index bc90bb0594c..f1a6d9b62d6 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -81,6 +81,7 @@ CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_FSL_ESDHC=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_REALTEK=y
-- 
2.43.0

