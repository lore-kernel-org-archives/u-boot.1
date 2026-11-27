Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21886606A323
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nbZydBD/;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=eT1S7RGT
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFFEE811EA;
	Fri, 27 Nov 2026 12:56:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gVNTsIl7uU5T; Fri, 27 Nov 2026 12:56:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 04EA8811D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784197;
	b=CRb4ZLVjV9F44eiA/OmhJxbtqmwDEslljWJLiL5CNqTyiYfvghsIZ/RF6cTfz/INp4li
	 uYgHmY+ycgLWH9XFcpyFPSO8RvdPCfXTfyP54F7iMT+OaMFzZBLgvSDCM8z2lRmplodZq
	 cJYREzoQPkbnLLDNDUw5fJiIn7ygAHfLq/+h4KTkJYR2OMgfvscFiosCwIF/YO3Qzp3TX
	 FfswOK3zAUpaY69dApKYPJgaVMKaUngH7KnLNOviwcehwEJQUO6N2VSEoWd+rUvpvyktt
	 XhiRz25YRoc/1REI9HqS10LUcl9f7/uTipA2vcw+r3/IJ3uOmcnsvyNpiB41LeOFOvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/qoWeG7F7c2WX1jppdu98mVB/a0KAWLz3xyLRZ4Ft40=;
	b=UA9WwaMxxtkkxxvIwwrjk5t/BjuSb69HPL/mIBs8KJ7ohAWWidLhEyT4FWedb1Q6frj6
	 kupD18R9GnnCuPOczwifEgG3U861F/EEwmvDam4o1QQYb2ZWSuda9ifD+CaHhuw1ByFag
	 HTGyWB+sMMkWF86D/h3TpTMSoTniC4KQIUnUtENBPeiI5KqntYvC3H86Demjxw9E3R2SR
	 q0qd9YeZKOCcwgwozzbanjPlk9qCESs154BIeTRAbN2HlzxfdD+XG6OwGuZuzQDLIxoCn
	 yPDTZ7zc60X53vwo9XBLPRST4Wc8YAGviE7VPFMM7te9dZY5FFSvhYplElk+eGjQXtQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784197;
	bh=/qoWeG7F7c2WX1jppdu98mVB/a0KAWLz3xyLRZ4Ft40=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nbZydBD/MOTmdvxeoqupPBZ1i+geZC0v92Gyco3UoAqYSjnLWNLhOZmzTJlOuEPVs
	 k1p5rocWo/EbobD1BmxyXYlkBAHEmv9LXyZbaC79hgxH+9anwy+YQcEAsHTYJAKeOJ
	 vXG3+JaWQSArKlynGwxb4wEVimIki5aYBdh1Y78WyGv/OJmB4bdpY7qNAAnZBunIQt
	 wY/iaLQGHACl/zpalonAXoTKR71y3j2IFqxgl9lVGyLuVr9808Jr3cCzdZ5NsnYz3K
	 I6c887BW5nnvo93+Yn0DP94Gqx74lozmxK2euMI6Zh7jcfI9PqEmK9IuI1unp+majC
	 nLXw69RKwKuJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04EA8811D8;
	Fri, 27 Nov 2026 12:56:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D3D0926D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C63914004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6zn_RTJxJFVD for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 12:56:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 66B61400F5
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=eT1S7RGT
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66B61400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
 bh=/qoWeG7F7c2WX1jppdu98mVB/a0KAWLz3xyLRZ4Ft40=; b=eT1S7RGTJgBAPeBqR76H2aPwXA
 G8CdOaEs3CyQALjpiuYAD/6gmfjqQ0641SqMK9d/VKHgqQbwiAxY1YjnXJhGbtPpRoBQzD63G7i7T
 QyqS6RN6GoMBIDdJ2HyZ7qI7tYOJEhFiU6ED1KkzJpnCG/UYQbAOfX0vTD1ZzQNA1XYTBypMM34rJ
 LR/edJZjoJ1u1aipslFXmFFBMffyoCw4jRX+iR0GqyQB9HZ/Q6UwgyHe/yAnoga5H/mxUpNHIdYbi
 hOICyCU/VwXpPKzYISLSQQpgIcicqCkY7I7c0+QYOLEJ1RBWEnpR4yF7xfbA+vT6V8xXAQaqwnS5/
 ySMsmlkg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWvV2-0006E2-0T; Fri, 27 Nov 2026 13:56:24 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWvV1-0003Uw-1U; Fri, 27 Nov 2026 13:56:23 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH v2 0/6] board: tqma6: uses SPL
Date: Fri, 27 Nov 2026 13:56:20 +0100
Message-Id: <20261127-update-tqma6-v2-0-3465ac0d32eb@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMQQ6CMBCF4auQWTuEqVqqK+9hWAxQoAtoaQtqC
 He3snf5v+R9GwTtjQ5wzzbwejXB2CmFOGXQDDz1Gk2bGkQhJJGQuLiWo8Y4jyyRmjN3rSpvdKk
 hXZzXnXkf3LNKPZgQrf8c+kq/9Q+0EhbIVFy55lIpqR76lccZe28Xlzd2hGrf9y/WRWn+rgAAA
 A==
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
Changes in v2:
- Only the commit messages have been modified.
  - The descriptions within the commit messages have been improved,
    and consistent use of the imperative mood has been ensured.
- Link to v1: https://lore.kernel.org/r/20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com

---
Markus Niebel (1):
      board: tqma6: add support for variants with i.MX6DP/QP CPU

Max Merchel (5):
      configs: tqma6: rename .defconfig to .config
      configs: tqma6: add memtest config
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
base-commit: b4f02a150c8a614097fdf88893ddfeb39e0042ab
change-id: 20261126-update-tqma6-1c3afd87914b

Best regards,
-- 
Max Merchel <Max.Merchel@ew.tq-group.com>

