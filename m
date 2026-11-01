Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D263E606A326
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y8b36Xk4;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=CdLu7FUL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99BD9405BA;
	Sun,  1 Nov 2026 20:12:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ADN9d8WlsTQ6; Sun,  1 Nov 2026 20:12:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A944D405B7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793563933;
	b=Y0GHbZ2OT64XOCCjptFzO8x6UTtD+UWM3JkC+ZJw8NytYQg/C9XYPTJjzUQxbodTw7EW
	 F5C3c4Jxm2yH5TcQanI4u+CdST+vS0fajTG/4ZzVpLm5vI+CNBK3UpWQG7hTe0ByMHP8V
	 jwNH3cVOsspiEYfklSLSm2Ud4OFdXTAFw5/MVHBFXAso78AqI+dc03N14RGOk0xCgqxOh
	 U/8uMBbLUkdG4JscWGlGqK+nSowxtTJXv0IgRJGxT81KEBCDwAvzKxr9g28c4n0MgPqGV
	 NICY6961dkIPd4PoXv/saiMpPVKNu0T0opTMzM/npZ6n0uaX5O8gNkChzvZ0UEYTKxA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793563933;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SAF+08cLcQlh/qVxcMNKOVce3undqBbVppFVbQSh8sE=;
	b=fbaR/4N93zY1aXoM4C+D+g6p4IflNywkew+uNdCuTxk7UQK8znsHhZbh7Tcx5VWLwKxg
	 zzsskyNQvV+fQu2JGrkC6mkkbAtnYQzBWcLXkLvArmyqeYGG3l8CZUH8u/qtQb1Nh2Hbu
	 kGr+ebHtfhip5nQR6Mbt+GgFBQxHae5257kKtB6MQAyNEwS0x3OQH5KGFGBSHbue8XO/o
	 anP0qXGuEdig5118WoAQNQrM4XJQsg3yUrIO3ZpsNjUNiixd/JddU79QFJx/zt1MvS7Xs
	 xGkZSokJ1X+2Y+HkwLg/eCGASFFBqWCNIXGa3Lq1TZG8Ye81Pelw7egOotGfRUYj/Fw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793563933;
	bh=SAF+08cLcQlh/qVxcMNKOVce3undqBbVppFVbQSh8sE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=y8b36Xk45IAO88ArN5M7xYh84r4i62ZDWt+xZb1YkFuJ/gn/9+6s9wjuhKaeF6bNo
	 pojiyc8gy4KuZnHU27TKMIxsnjKKFZYmc+1+NSRIYtIKfZsMJmxJPaCGepyA9m4Pg1
	 0NQ13tfCJbs6n+rCVEtmbolMX8S2pPZBs2okREybWfVDSn8ACOM2UmKqQeW+3AWBTk
	 kPHYSe6UEEm0m4QdcVZeDvqFchpdEVNNaMZ0dg96gPRPENPPK7NNCp/PZPzX3vOz53
	 Vs1avxrOSLtXmzQzeTmDUeQzwmWFAnYfHavUVxin0pzSZNHRzjUG028lDqxsZ8J+Qk
	 iQYNezaZiQKGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A944D405B7;
	Sun,  1 Nov 2026 20:12:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A991435
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 20:12:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07ECF400A8
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 20:12:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vo0v5uKfgDrP for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 20:12:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E52314004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793563931;
 b=oByGLHbPbEq4hZ0eP3Y2XcNB/zL4h64WFLUMHonuUh3DSR1qD+xVz/n3oQsZwJfIpVzG
 21lAo/xe10uKN3HDrAd10v+B/e7i7so9lA/nVEHKeFBvbcR5mWTBEJLANThstlrdBeO2T
 jaMqewOB1F4KdcyyR/ZAtJAAQJtLaz/mOqYZ61Z1TIyWocRrp5jP00AFlcgoYL0XJLa8E
 tR6IWgv79FoJ0SwH8mJ2CZvreb8c2gdSorAEne6dfQUlrefySphmbFf1t5nTXOgvrmZYW
 twKI2ub3MIe5hoOpWELgZyiKIWx2mhqU40FUEyeEa3ZigJyPnBWSTZI+cP3NIDS+m6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793563931;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=SAF+08cLcQlh/qVxcMNKOVce3undqBbVppFVbQSh8sE=;
 b=Ini30ZQFtqoZB4rhWCEuw9vI8jizA/l4iC3uSijbmm204s+PA5if7dNkKyRaLbVw47BW
 ytk25e7gqgdwfmE0YfNZOLtS9+CCKPiJ7DUdPuOBPMYGb0xQZAPho8RCtLczTVRTbGlji
 LI9NBNbWKbIUef/0tNplU+2CqO7uLByVHbPp5w2FgW43mm76iO4hVSLRIf3cWhH8vYQoQ
 OPqGzNsnRK9ZTokkNSjcMe6iXSkR/M4Rv8cxd3t/+9/AUvJyQ/eaZZewdHqSo/VO4peua
 BOPfLfXoZ7d8b1TUO4AdKYaEVScDEHPmX9pQSR9H/+gGpuTpBD2AU98oW6H8ZXeeEvQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=free.fr;
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=CdLu7FUL; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=CdLu7FUL
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E52314004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 71F26B00535;
 Sun,  1 Nov 2026 21:12:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793563928;
 bh=V+9BNTs11FTEeMLgMSi95ITcHGwekHdw0B0k8H0ZOxU=;
 h=From:To:Cc:Subject:Date:From;
 b=CdLu7FUL33w3shUV3YFQV/K3Nleg56N6ZbY6w8TEkHoTul2uoB3YT8bg8gVEwMJqQ
 sCQ7hUlF9ARpQIZnJOvQG4jZc1WpPx0iFPxqK1JVuCItQih8yVm+smf/XcFXc8CFHT
 kcEmjtcGrAPItoSSTe3pDDGL5QcmpmuQCo4MJ/4pu4dkXZcXn1oDfQgzvFe3CGjo/v
 eHlUBA+94MxLe1VMbctaU5yWJKVnLy/zzyPw8whEVYh+Wf7NBdtTFqcOSFgWZni8+7
 NGBjg0nQhFf5oU/UKPvFbCrH3Bu4Bdk68GrheYgA9XxJU5HyKqbYfVks2l6FsH6VGu
 7FjwMkTzEm3dA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 0/2] doc: board: nxp: convert two NXP READMEs to RST
Date: Sun,  1 Nov 2026 21:11:18 +0100
Message-ID: <20261101201126.426751-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert doc/README.fsl-hwconfig and
arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc to RST, per Tom request
during the review of the LX2160A serdes 1 series:
  https://lore.kernel.org/u-boot/20260928191412.GN858934@bill-the-cat/

The content is unchanged, the references to both files are updated.


Vincent Jardin (2):
  doc: board: nxp: convert README.fsl-hwconfig to RST
  doc: board: nxp: convert the Layerscape SoC README to RST

 MAINTAINERS                                   |   2 +
 .../cpu/armv8/fsl-layerscape/doc/README.soc   | 444 ---------------
 board/nxp/ls1012afrdm/README                  |   2 +-
 board/nxp/ls1012aqds/README                   |   2 +-
 board/nxp/ls1012ardb/README                   |   2 +-
 board/nxp/ls1028a/README                      |   2 +-
 board/nxp/ls1043aqds/README                   |   2 +-
 board/nxp/ls1043ardb/README                   |   2 +-
 board/nxp/ls1046afrwy/README                  |   2 +-
 board/nxp/ls1046aqds/README                   |   2 +-
 board/nxp/ls1088a/README                      |   2 +-
 board/nxp/ls2080aqds/README                   |   2 +-
 board/nxp/ls2080ardb/README                   |   2 +-
 board/nxp/lx2160a/README                      |   4 +-
 doc/README.fsl-hwconfig                       | 116 ----
 doc/board/nxp/hwconfig.rst                    | 133 +++++
 doc/board/nxp/index.rst                       |   2 +
 doc/board/nxp/layerscape.rst                  | 517 ++++++++++++++++++
 doc/board/nxp/ls1046ardb.rst                  |   2 +-
 doc/board/nxp/nbxv3.rst                       |   2 +-
 20 files changed, 669 insertions(+), 575 deletions(-)
 delete mode 100644 arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
 delete mode 100644 doc/README.fsl-hwconfig
 create mode 100644 doc/board/nxp/hwconfig.rst
 create mode 100644 doc/board/nxp/layerscape.rst

---
base-commit: 3401e006432abcbf7d73d7210f10df157f990ed3
branch: for-upstream/doc-nxp-hwconfig-soc-rst-v1

-- 
2.43.0

