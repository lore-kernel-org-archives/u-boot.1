Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6BC606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hMKSCHJu;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=NkyEXPIQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B881181076;
	Tue, 24 Nov 2026 15:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6xn5li8auyzG; Tue, 24 Nov 2026 15:17:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 074E580FEF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795533449;
	b=OTbZKY9d5qrWLvF8Zq3Up3AinqsKWZTFyH3E+UcciptWh9LQVdCrMBOS855/90kT8uhp
	 2jVmfNVOMPS5RZqpsf0XKP/PGQlj9Ts+vQcKb2CrbzJvdpumy2EpehfZmNeT3yQkhlN3l
	 USkU3iGME7AXooscHr/73dd0DYIXqk27zN/VXRbXQkSTqQlbOjiqpr3OnQ23/7LGHsaRW
	 QOqAbGhYlLs8PjYkhYdn84SN7QcEn2JOFmS1vMa8qxtYhQsDD5nwedoj5nMO4Qy25cepy
	 tdvwykn6atZoU5I56uKvL5X2nL9UYaC9z9gsOzzZgJhZXZe23pJ4GE1DVuXHtk4PQLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795533449;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=B3Dy6LoLtfbWG8Yy/rXw3b3IglptgXtACUxCM28FE7k=;
	b=Xshxy57/JFG+DFACEAJuYD7bpgnReJ2RuReu9KmUfH8Gf/54dHZkiE0/4JOm4fhkByxb
	 xgHvOEwPDLwwxKdvRBMByofbOQUgosmVPyrlIIH+ZHA+dGeTAV3sMlFbXFZ+exYHs94Js
	 3gENW7a0xowudwMOauKrEpP9azKrcbSEn50MVHsZMNbByj2DHXL56aGb4ZEB7vjuxuXm+
	 suNKHPXgR1t+ajLOxSYzRrbho1I82hRWcqbOnza8DnIDybc5jixcfp9DtZmfe28WGOob8
	 dS+4ZljUPsnGyZWgOGm5Sb8m6yHUQXmfZlhr3FxOsjYOohUS7UprzQnO757PTNWDbdw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795533449;
	bh=B3Dy6LoLtfbWG8Yy/rXw3b3IglptgXtACUxCM28FE7k=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hMKSCHJuZMuGlbuRzoHy0drWuIXA0rZQk2UN+r+x8b9Ho1YXwai7nNrLwgx4dBKb5
	 ty48yi9V/hDZdr3p58W8gxBrYEfnPKitqb5+z9wolfF0G/G0Wo3LD5j1gffNXho9q7
	 Ph36CLIVEVkIgu0Y8TzXGVmiCslN+Qcl3ZuV7UMCBkaexUnpv1Q/s1ZKStTxWhD1ur
	 RO/VvF0WENDUF5sjXBgNv6p81sDSJfpjS5WnfX/HiZEmVkC/lSSm02dr/9D5YJ2UAj
	 6TeWJOkwkgRI+Berqq4xh3z4RN/9Cmkz5h9q49dDwfvvzgWo8ZdhsGFJmutgTaOA4y
	 6YlBohfLK3gpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 074E580FEF;
	Tue, 24 Nov 2026 15:17:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AE7E3C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3845140116
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:17:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aB3upVjk1QFW for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 15:17:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 469E9400AA
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=NkyEXPIQ
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 469E9400AA
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 15:17:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D039E10F275; Tue, 24 Nov 2026 16:17:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1795533439; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=B3Dy6LoLtfbWG8Yy/rXw3b3IglptgXtACUxCM28FE7k=;
 b=NkyEXPIQNq+XwyobQ/9yXhCtI+GPylaQhDWoG7SJd77KMhQd3c+gfkl0+giZMzB6RNbzOb
 ySzg6UYXUl1k27RZeK0JO7RnY8MK46awCgXxISiA/DMb1k7fz/XUGy/Cn/0sVTmURli/bj
 svzvx9XqyHjAq/akOAV2i+1xhwfExcm9fkAxRW6s12ZYyA/UMd/Ay1syKfsmE3s6tFiUMI
 JZ2CiptMvxQFo5aCaBsQUkBbaEbv17kP1f2gQj+amPGuBc1p9J7niQVGmMnrAGdMyKwvPj
 4c7DqbGWsyLZSPnGiR+VwO48GznKq7YsjAgXTYqlNb8MoRyZymj0pr9zfrWE/w==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: dts: imx: Enable CRC8 support Data Modul i.MX8M eDM SBC
Date: Tue, 24 Nov 2026 16:17:04 +0100
Message-ID: <20261124151716.36270-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable CRC8 support in hash command on Data Modul i.MX8M eDM SBC.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 configs/imx8m_data_modul.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul.config
index 468a3a77824..7915b7dbf17 100644
--- a/configs/imx8m_data_modul.config
+++ b/configs/imx8m_data_modul.config
@@ -113,6 +113,7 @@ CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_FSL_CAAM=y
 CONFIG_FSL_USDHC=y
 CONFIG_GPIO_HOG=y
+CONFIG_HASH_CRC8=y
 CONFIG_HASH_VERIFY=y
 CONFIG_HUSH_PARSER=y
 CONFIG_I2C_EEPROM=y
-- 
2.53.0

