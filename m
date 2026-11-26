Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CAE606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qcrs74OX;
	dkim=pass (2048-bit key, unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=GmIOXPxz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 46DF860A3C;
	Thu, 26 Nov 2026 10:46:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DAzjOx_CGYYd; Thu, 26 Nov 2026 10:46:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7370A608E9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690018;
	b=mSqgDK9+z4Boa9ZKP2HitTPiNeGaIKFSl7Dzt0rtTAU7b0SRxPSICQ0A3yA1FLFOAY8X
	 XUNdp9cXnX2VkmooovAaXisXWEZfXp/7gjdsFFTp+OFBp4MFZ58KvnAECXVJZf9VcX+Lu
	 hyj/OKGyeT4aOG37X2a3aNYU5ZjKMvKqePr9/yRtjxnXyahJlI42gL30VigH/Brp/TvAQ
	 6CFUoztugTdk26D1d9eWCzc6pn6a1F84yEvkq7sCQZiwB79RLp7ZtTeJj0Vy49JkFHW0/
	 0pWOrysz9v5s9+hR8vkizEHh3HbiDqDysC9t7cWlznIcG3Pp8lG8lWPrzfEYcyKrqtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690018;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SA0ZAQb0NmV/ekl3VbHniOkzv9kaayRfZaLONrjcsTc=;
	b=nA4v7wGzUGxev2j3q5KqgjSa4sHfcBolfKumS63nIKc9B7JIDEZRBuJ1vt4FC4XbOVsQ
	 +U45qDgpwdVLl6/zGG5bO9kYY0ydNG+3bqf9V++hkVfp2gZtRIb9jB+le/UzQsK3IpGUc
	 aVt8Uq7aOrllhw95dP9lTKuuuSmLdE0ph9Svk9REjzpBaKOzviOlllsHKHv2D+8nDJAWy
	 jksKtG/N9FL8v/JqnhaWOimChlzyFaC4wYiZoafce5sI3djpvS9IL71HDS05Cn70S6je9
	 8W36OnWOrxJwLAYyemimF+yi4twTBodrxNll4BTyyzDrteB4cDkL62z4ZQBDEgQ7n/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690018;
	bh=SA0ZAQb0NmV/ekl3VbHniOkzv9kaayRfZaLONrjcsTc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qcrs74OXC9i9wt53sI/zxEoUyK88cOH0UakPYP9B79CuUtr4sozN5lQxVkLJu7N/z
	 q8qnznJv+pa+uxT40VugJk5hEPpTUlJiC98PVuuPNfmaOUod3Fr+DR6szxqYJ0eCpb
	 s9n34klKp0gehLARnGZJ+EplixJnDAF6HQkIc7/5zNAWXHTP5t5BGnYcTMvPvisSOw
	 4+b/0PlWQByQIxN1HETMO+q06H/O76S1IajNWs1DDSR+/ddE9EgOmJgYQRg+Q3zzmE
	 IDvk+jjFblFrPmKY9nlztu4OsoGxmj3vQhbgIpvCVuk1kLJJ0smPml6g66k9aLAyTO
	 uo0L5TGYDL+Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7370A608E9;
	Thu, 26 Nov 2026 10:46:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A93D4325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8ED5940277
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 61hPHfDRdEyo for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:46:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5C40F401CD
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=GmIOXPxz
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C40F401CD
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
 bh=SA0ZAQb0NmV/ekl3VbHniOkzv9kaayRfZaLONrjcsTc=; b=GmIOXPxz8jmV+MzUGzaOoHf/ZI
 SwWQkmb55l25k781erdHtogXB2y+T7DGQZ/XJpTO/bVIGFjsae6ujWKWGj3XRdfGiW6d2/8xk6HLu
 92+38hpTe8h/Fiv3yMkOQyqwaSleaO/EscNhoDrHRT54eCiN72LERVZkgY7Hjg35m1P5k+rmujO13
 FU+7YT8stf6adU0bv2wr8EAPJOI41ROLZuuLm8OYNCmkmQYtpFuhfKZx7wYn07a2AOlFLTUbB6Qse
 Nfq6ZbA1XWJgm1UJPmopAEQHZf9gUk8nR/XHxa89/ShzKJls1+1orrB5hgQupyLeLclw0HhSQnkk6
 eqjihOLg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWX05-000Nto-0g; Thu, 26 Nov 2026 11:46:49 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWX04-0002PX-0V; Thu, 26 Nov 2026 11:46:48 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 0/6] board: tqma6: uses SPL
Date: Thu, 26 Nov 2026 11:46:45 +0100
Message-Id: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyMz3dKClMSSVN2SwtxEM13DZOPEtBQLc0tDkyQloJaCotS0zAqwcdG
 xtbUAKfIBUl4AAAA=
X-Change-ID: 20261126-update-tqma6-1c3afd87914b
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Adam Ford <aford173@gmail.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.14.3
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
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

In this series, the TQMa6 uses SPL.
The number of defconfigs is reduced.
Support is added for the TQMa6DP/QP (with i-MX6DP/QP CPU) with
1 GB or 2 GB of RAM.
RAM timings for 2 GB of RAM on the TQMa6D/Q are added.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
Markus Niebel (1):
      board: tqma6: add support for variants with i.MX6DP/QP CPU

Max Merchel (5):
      configs: tqma6: rename .defconfig to .config
      configs: tqma6: add memtest
      board: tqma6: add SPL support
      board: tqma6: unify mmc and spi configs
      board: tqma6: add support for TQMa6 with 2GiB DRAM

 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi              |   7 +
 arch/arm/dts/imx6qp-mba6b-u-boot.dtsi              |   8 +
 arch/arm/mach-imx/mx6/Kconfig                      |   6 +
 board/tq/tqma6/Kconfig                             |  38 ++--
 board/tq/tqma6/Makefile                            |   9 +
 board/tq/tqma6/clocks.cfg                          |  26 ---
 board/tq/tqma6/spl_mba6.c                          | 187 ++++++++++++++++++++
 board/tq/tqma6/spl_tqma6.c                         | 180 +++++++++++++++++++
 board/tq/tqma6/spl_tqma6dl_ram.c                   | 194 +++++++++++++++++++++
 board/tq/tqma6/spl_tqma6q_ram.c                    | 193 ++++++++++++++++++++
 board/tq/tqma6/spl_tqma6qp_ram.c                   | 148 ++++++++++++++++
 board/tq/tqma6/spl_tqma6s_ram.c                    | 145 +++++++++++++++
 board/tq/tqma6/tqma6.c                             | 123 ++++++++-----
 board/tq/tqma6/tqma6.h                             |   4 +
 board/tq/tqma6/tqma6_mba6.c                        | 139 ++++++++-------
 board/tq/tqma6/tqma6dl.cfg                         | 125 -------------
 board/tq/tqma6/tqma6q.cfg                          | 126 -------------
 board/tq/tqma6/tqma6s.cfg                          | 126 -------------
 ...6_common.defconfig => tqma6_mba6_common.config} |  44 ++++-
 configs/tqma6_mba6_mmc.defconfig                   |   3 -
 configs/tqma6_mba6_spi.defconfig                   |   6 -
 configs/tqma6dl_mba6_defconfig                     |   6 +
 configs/tqma6dl_mba6_mmc_defconfig                 |   5 -
 configs/tqma6dl_mba6_spi_defconfig                 |   5 -
 configs/tqma6q_mba6_defconfig                      |   6 +
 configs/tqma6q_mba6_mmc_defconfig                  |   5 -
 configs/tqma6q_mba6_spi_defconfig                  |   5 -
 configs/tqma6qp_mba6_defconfig                     |   6 +
 configs/tqma6qp_mba6_uuu_defconfig                 |   2 +
 configs/tqma6s_mba6_defconfig                      |   6 +
 configs/tqma6s_mba6_mmc_defconfig                  |   5 -
 configs/tqma6s_mba6_spi_defconfig                  |   5 -
 32 files changed, 1306 insertions(+), 587 deletions(-)
---
base-commit: a1ce46a6689641dd83d725edbfc3f5719abf3a94
change-id: 20261126-update-tqma6-1c3afd87914b

Best regards,
-- 
Max Merchel <Max.Merchel@ew.tq-group.com>

