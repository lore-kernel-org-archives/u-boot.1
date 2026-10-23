Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807E606A32A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vwJRVJDS;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EZ+Ts+Av
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD9194090C;
	Fri, 23 Oct 2026 10:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SKOzY2VZz8YT; Fri, 23 Oct 2026 10:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E79A840828
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792750217;
	b=j9SpkfIMQjHrOSxwN5KsOZpZaDTn994mTmDzUAgbjfZ7WYbGvuoh2P8t2m8Hrzpe7cY8
	 1vWrZRQZMW++e7FtIs0UPhD5/XWnJjRRC6flWaecROjWf/9C7VsTUfeGroq7OvoFWijGj
	 Rf/+ctilDw+z6hLLhOajUS368zN8rbRhwAq8OUjm8IwJuTWh7g1L8YNJ8w9kPA7I26Dbg
	 aSJ66o1vkcbyDU8CjjmUS4HTjKx0QEKAWMgQQn49cIr/yjV8H7jjfExVDitc1PUKK8MDE
	 91AGzg99yJzpabmixrE2K0C7lslmGcMl2G5HhMID1Klsg7p5Sigz1rcVzW/OsrVGG3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792750217;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xY0Rc6rkhlt71FjwyisV7O9Cv/7pbw3WEgXUz2MquQM=;
	b=DC7tkXdPzwTIHonapcGudB8r8NTRtIGRjYLvqlZBq2+g5i0ajSXxlu/8I2mcnihUUt2t
	 Ez1gmhobfo7uwOB2bntXKql+8dQdaZTXv1FnPeW9Q/BOWKW2U3KXMV2ZMCNAWotVQlRDE
	 ebF3By8xQL46R5HkMf/+F6llPB0JXaqFW7Vj1nl93boSO/6fzV/GvUTKhm4jVV091LQU4
	 6T88DBnStKhTFq3zpsJY38vpUDLIH4Oo9ONtX6Gk1Q+kJR6X9eJDOM0jItpuLvJrP9DWS
	 2sDPVtnUy9g+Zli1jXmF/bE/3RPEhaomJmd2dRWYc2xJCiF4UXORzMYNPM7TDAey+HA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792750217;
	bh=xY0Rc6rkhlt71FjwyisV7O9Cv/7pbw3WEgXUz2MquQM=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vwJRVJDSOR7WXlrlseoQ6wPx/9poTe8U0JS+MYBjO9k4puifuerEVufblbETOKVtA
	 qWDJNTIW6s4EeRQK3GYm/UhiMQo0tOJ44LT+N1qZTZkNpzfHajCB9FUNYpJX1H/M6C
	 M45qIdVIPxe8HJgMRVrXUFRJOuU4Nzozyl9oIrdlOy2fgL2KQQM+59IHHRvr/96OI8
	 q/2yjJt4WB5ZFltOnNs+raDCiNQE7oFL0OiAh6gJM3fD+/r7X1bvesmE40Y1OktG0i
	 TY0Styd4Wx8XGtu7Xd5kHGS3gcLsU5zWAFmWsaaI0gtBukT38hzOl98IRYK8H7rG1D
	 jV/68scSx2WdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E79A840828;
	Fri, 23 Oct 2026 10:10:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E8D8E3C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA685811AD
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gs_WTJgKU1V9 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 10:10:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B239D80FA3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792750214;
 b=tMIHg7yjhI0tWH1x8MKfzhE008Olcbs8toILhiwUHbRH36xKi3btALV4RTCSa/gwn/ba
 js9m4dut1MQxyzK5i08c/4fCtO7J3nhPMTtf6cwUbsqq7KOtaMueq2+W18u4b7oRplEtC
 MotUVetZkU2UCzgTeJJb3/n3veV9LI8hTcXWS13HfwtVTRlTzQct+TbHyKvG3+QVYjZKq
 3tXveKrPjsWp5k9fDEIuiMZqm0a6P0CZ+KclZHFRjkyHaBXxfAfivMMU6/woUHCoMC4Fp
 1d1juRqlJWOSA8Y6FVTAZL39+trY3TYVHXlPle8EO5o0Qqbe5GwHd7qPIjiARmku00g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792750214;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
 bh=xY0Rc6rkhlt71FjwyisV7O9Cv/7pbw3WEgXUz2MquQM=;
 b=IiOgQbU83FJxCteWy8MYvoaouOJQyFrgFaZn6jr+wValfozWUTe0v5ibd55+CpNw1Wm+
 oB4yatd7XVhAsP6woJyNoQY88++UzenFO8X4gy1rx09CkKm7/g7X2RfgOZzwSsqQ/slmW
 t7eY2Vb9/2yZrayZLrDfoY3pW+aa0PfOm8agyyelQtnjUWUSObay3fKzl18NWPrw6kVp7
 M2F6puGjdENFBywqyZWAhpDHj7onm5RkbkA580CeiXwu3CSWR1n7WoNEmJvxgPk/ynv1e
 Se61l31hSKJ2F4kZuoBoCbHljZKXgzUyp6NMWtZ/mPsTEB56u0nD+wqRdoINOqNq7FA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=EZ+Ts+Av; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=bastien.curutchet@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=EZ+Ts+Av
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B239D80FA3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:10:13 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 83FE24E412DD
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:10:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5291C60398;
 Fri, 23 Oct 2026 10:10:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4103E10328E83; 
 Fri, 23 Oct 2026 12:10:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792750210; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=xY0Rc6rkhlt71FjwyisV7O9Cv/7pbw3WEgXUz2MquQM=;
 b=EZ+Ts+AvoCYcxuSSkAs1AgVlP2awoU0Ybn6LOD4+xKMa715gxjLjUiN2GoVCi01M/r13r3
 ny+IYnSGbyeUe4qyBCOGFnMyptYmQjPW1vXG3U0mUDhvHXO+HhwBRz+Gj7Wx+G615ZvuYE
 W3FtLu1dsqO69GqLRa510d7Ciz+c6CgoaszKPlM0ns4bS48Kt9cuwixxaOSlccP9G9AF1a
 KQNhPoiPfJUxFGyn1SZCsHOXr9PyDKUXjGO2UMslMklOFRJ8odekXkfqDlCvTSSnDCoL1C
 5iNUavQy2/xEGzx4quLlQM2vFyQpzoRLwhVKy+JqaFDk/Z5fGHrH2VoKuY0G8g==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 0/2] omap4-var-som: extract MAC address from EEPROM
Date: Fri, 23 Oct 2026 12:10:07 +0200
Message-Id: <20261023-mac-eeprom-v1-0-f7a5817d455b@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNj3dzEZN3U1IKi/FxdI4PUFHOzlBSDtKREJaCGgqLUtMwKsGHRsbW
 1ACdW4UdcAAAA
X-Change-ID: 20261023-mac-eeprom-20ed76dd0fba
To: u-boot@lists.u-boot-project.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

The MAC address of the OMAP4-VAR-SOM is located in the SOM's EEPROM
under a Variscite-specific format.

This series add support for extracting this MAC address and fowarding it
to Linux through the device-tree.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (2):
      omap4_var_som: extract MAC address from EEPROM
      omap4-var-som: forward MAC address to Linux

 arch/arm/dts/omap4-var-stk-om44-u-boot.dtsi       |  7 ++++
 board/variscite/omap4_var_som/omap4_var_som.c     | 44 +++++++++++++++++++++++
 board/variscite/omap4_var_som/omap4_var_som_mux.h |  2 ++
 configs/omap4_var_som_defconfig                   |  5 +++
 4 files changed, 58 insertions(+)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261023-mac-eeprom-20ed76dd0fba

Best regards,
-- 
Bastien Curutchet <bastien.curutchet@bootlin.com>

