Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06803606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=soAav1gj;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=srkk3yPY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D17280BE2;
	Thu, 29 Oct 2026 17:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sFYJ2OZ8-7xB; Thu, 29 Oct 2026 17:35:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD3A980AD3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793295357;
	b=XDPQEdRX7MmzGSvVNs7SpIWEfMTL76BAUsQPtMZxxubJUX4CD5GK0xEU2Xjlts5DWNoX
	 2gC9vCZwm/27l58mialtEdkky3B/B32Ge7uneiF1BDuKhY9PCI3t3mgM4Ayhxr+uWLYMt
	 RQxT7AiZdHmzJlZHZnejTzDqC+tUINgyDKaKiR387UqscC70cY6mcejXNOGE3TtGI0Hyb
	 f+2fITiBwwfyujlEvpciFdw+CQDUeEoNgD+ZNrFl+s4uLkSPe1iwd7Lar5D17wqfRtxmK
	 ZCuEpMApc2yIR4uU8uvfKj5lhu3V9JZeoBnFZqT8/0I+4xTgr9oupdHFf+N8lM1Draw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793295357;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8xrgwCOay5YDGZRNAxxCTtUpgZBuXEmmk3YWE8hcW9Y=;
	b=FwNclsnnNwNh4i4bLx55+nsTfqnM66L2u7Kb2RMoXAY4jPOSgw+Jkz1dTlY2AfBQF+xg
	 +Op4Jt2uk5p+d7cF6PQJxAmbzyt3yMPIxUxt52wdFnRpGjq4LL7fMyHlqm89JJzXi1sXo
	 i9pA5r1OQ8yCdX7nqGvIdQ9VErKYzM5tDlX1LhYuOJy/OXneqoH6iLX7gIUAghZEFcN7W
	 gfjW1ghVQM7XRuIA7eoR5HJY4Sbsk8Mmv9bXESujIOxcwf8/4BpGgewpptPCLYnAKvuQ8
	 ng7zjQgNd9XIrYYWARpz75C9Um/zZfqZSLFE2fuDRIrW8MT+4wvJfQ01y4Q4rV0NVeg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793295357;
	bh=8xrgwCOay5YDGZRNAxxCTtUpgZBuXEmmk3YWE8hcW9Y=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=soAav1gj0wGqD5M91LtEaMsJubBNHUE8kUshzMcBUp6CE50bT71qIYhNkohC1zVAk
	 1B9U1uT4Eifby0aOYhnpVzqakoTmjYt6rBKW2yAFOJVyyu3wV59oxGUJaIRRDN9RBP
	 xAwvcqF2/sQFJc2KadnMub0XIMtIcecGvC+Wqe9p2Ukj8sQBWMMLOStlCZ5uyr5pqQ
	 dgtZspNwumXYJ82sjkSjbzjbbdvj+1flk5DtFLos+Cn5FfN1OwoO8Oz3s1ZS4Yoa3p
	 CFQwOtNc9D967KMQS9hf0G1YfEW3IR7X3jn7KkU8tGmHRMYu2KEfvt2MF75Pthvsdr
	 FXJY4N7lllyuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD3A980AD3;
	Thu, 29 Oct 2026 17:35:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 90E032E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76F60400C7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:35:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0uKuOnsRV26m for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 17:35:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B53E340048
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793295355;
 b=YHB0QGSV3BtT3ooDoy9Wq1hUSMsEN7HLmi1O4NUIuhP0OzBlxplJq5GqyGlsd5R7pRD/
 Jv8XlyPLM2IHRBbngbZPf5XCp8MdPpucNcJdj69HrxwABKlDGVtVvqAdmuVXwhqqppLJl
 bDHk4DySSqJhGcd/WYh1zjYeqI0o/GyMMmXSFZzTumfmCgAZwlL5eRktArS7CDz+zUGBW
 5JUyhSxgXwyuLUPCQuFeRzFu2zMoDDseWy7juwFbSlA/oA986EhnB5EERndVMp3ZCf36+
 Q9VZLV0QkMifRMWhl6nW6lzYy15tOanEj3YfatEwR4ddLOBXlwl2UL79FD8jXajHbhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793295355;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Last-TLS-Session-Version;
 bh=8xrgwCOay5YDGZRNAxxCTtUpgZBuXEmmk3YWE8hcW9Y=;
 b=naTslWLfAjGJNcOQJ8alj9gqkhtz3julmnsBVjT5fVxDdC876dL5cpoHckMxj7o1eSTK
 x8nQSUJiryNCAc8KQy65EYgTj+I+8AdcwbNPeLLpvRv8cmHQ/ZpbBlZgDnxtMHv2BiS2O
 bnsRh+7lN9RJRQ6MUyaQhs3kxAhP7iZSn195Me4JrMZqtirDZVCbDQ/BelS7R5KwxuZgJ
 YS3n5CBNEz2YItaal3LL9QUNnaD5L0TfGBca5m87+XMEirKZOW6fUBdj8foggHCL3vhm4
 w/QXR+p2yNJ27Vko0uKffLSOEx6Kzv3gjnjfgSEoPqy0MmEmzzgJOMtx+svn9IJo//A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=srkk3yPY; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=srkk3yPY
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B53E340048
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 17:35:53 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 900621A13AA;
 Thu, 29 Oct 2026 17:35:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 606FE6076A;
 Thu, 29 Oct 2026 17:35:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EF9611032909B; Thu, 29 Oct 2026 18:35:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793295348; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=8xrgwCOay5YDGZRNAxxCTtUpgZBuXEmmk3YWE8hcW9Y=;
 b=srkk3yPY45gQ13D93fLS4eOM0APkd2z6jmftLzOahXtNOLY/9A+WrBFPX0fFtvlOSdIGKF
 XH4TXuf5m+GaXtk1pQ5nCO6RgoKA1S02MmqTQpLnppPUkBFyRF99kufhIz/kfcuR2IngUs
 QmtMt8yTM4Ew6iXgW/aThqBYfW1Ylj2ObzqEbffamyp5aC+qrBHwq8BAeYgt+fnR3R1k6U
 pH15lPw+JR63k6zJDYzncclFg4rJUGR+zJVDE/84YPuU3+hCaH1ZiwGLuxoiw8gsUhGXKa
 bHpXL8JBWtkznhnJeGapc2Una3s6mrDEmAi/dw3AkNkYO9Myf5bhqrpV7QQgxw==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v6 0/9] binman: add nxp_imx93cst etype for i.MX93 flash.bin
 signing
Date: Thu, 29 Oct 2026 18:35:23 +0100
Message-Id: <20261029-imx93-secureboot-v6-0-27b9c987e25f@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33Oy07DMBAF0F+pvMZoxo847or/QCz8CjWiMbLTq
 FWVf69dJChKxPKO7pyZKykhx1DIfnclOcyxxDTW0D3tiDuY8T3Q6GsmDFgHPQoaj2fNaQnulIN
 NaaJWowjKds7agdS1rxyGeL6Tr2/fuZzsR3BTc1rjEMuU8uV+c8bW+4efkQIFx53qgYEH/tLGn
 3F8dulI2oGZ/RIa2AbBKiG1UFYzI0GxNcEfCMQNgjdCMKO10twMsCbEA8FhgxCVGHTXG7QovJN
 rQv4QCLD1hayE18oHI9B6HP4Sy7LcADMozDPQAQAA
X-Change-ID: 20260814-imx93-secureboot-b914e7b6cbbf
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Lei Xu <lei.xu@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5813;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=976DbtYVylq9sW6ENQqlOTPjYU2XqrbX4uT3urLke7s=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBq44PsQIPGgIpmAumXQzQQcnKZ1mztAV0sWnZ3B
 luC/iLFDg2JAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCauOD7AAKCRArAF6gG1qP
 A6ZxD/9t1PMxXk+rODvB+vpHPRelEZBdyMP9Ap5ZGzmjUA56LQva0MVguDqf4X7ZeKSs8VSfkFp
 E98XXDS1hANV+6IBtcXzbY2JPbry0pXZRMA2cHcdh8XAY9YJq+/7LzIq9MjA5bXWif1LtoV2IKa
 +Su6FRxNtMZGI7CWoc7EluIsysHW+rpeBekwEdNDRxFAGE+VclEtJFc9P+a513na3uOaV+3o0Ru
 WOEmt/pWtVHP3Eb9wPklwH++Rr4kZZsXOjmUIGFCPFzXZvTiTthhutM3Bobjnqx+pB94DNB/KGc
 isWDrWnu3g9Fw0cpH0vJJqvtQWOW8XuBQHrUsAoQ08T3HZ1vOkKRuVNIRVzXNbTsJchS0PWIHNb
 xerqD9AhdUtzs65D6ayV1lrtWC938Au1alULsT4ZgyTTLh2SJTfXR2c1i6suC8/LWED7iRQAT6k
 YgTAZu2URTsuMfcmM4dg11f/D9zcigBKUMdjfMsPVDEPG37p30VMAocQlF2tMtfvVQHFj0W0WEg
 hr92+fq4FUu49UGiMAZaeGyiDlrC8i5LvUF/xWNi67e7ur2nrZd3TDGGxELiPC5/78ly5c65G01
 lMi6V5bRplWtMKK2V4la/hisrmxLragqpCKhkYzK31wvauzbuN5ZDYUIfw7SBtxOEjlXVdgWvDq
 LF6+LRBoe7dO1Tw==
X-Developer-Key: i=jeremie.dautheribes@bootlin.com; a=openpgp;
 fpr=FB14AD9086DBB842904804092B005EA01B5A8F03
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

This series adds support for signing i.MX93 images by leveraging binman
and CST, the NXP tool used for secure boot. This introduces a new binman
entry type (etype) for this purpose.

As the implementation is largely similar to the existing i.MX8M support,
this series also introduce a new common nxp_imxcst etype to share the
common functionnalities.

This procedure has been tested on the imx93-evk board, using both ECDSA
and RSA-PSS keys.

Patches 1-2: introduce the new common etype and convert the imx8cst one
Patch 3: introduces the new nxp_imx93cst etype
Patch 4: updates the imx93-u-boot.dtsi description to include the new
signing nodes
Patches 5-6: documentation
Patches 7-9: add test coverage

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
Changes in v6:
- patch 3: drop the redundant ReadEntries() call from ReadNode(), as it is
  already called by super.ReadNode(). Since that code rewrites the imageN 
  devicetree property in place, the second run no longer detected that 
  bl31.bin was missing and wrote it into the mkimage config, making the 
  build fail with:
    ././bl31.bin: Can't open: No such file or directory
  (see https://lore.kernel.org/u-boot/CAOMZO5CwR4Lh9eJ-xudFSRZu23c7sNT0LOP2EzqLQMksa76bdw@mail.gmail.com/)
- Link to v5: https://patch.msgid.link/20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com

Changes in v5:
- test: add short-input test instead of SetImagePos and delete
  nxp_imx93_csf_imagename.dts, which became useless after this change (as
  recommended by Simon Glass)
- test: factor the SPL container setup

- Link to v4: https://patch.msgid.link/20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com

Changes in v4:
- new patches: move the fake cst run_cmd() mock into a _MockCstRunCmd()
  helper and use it from the imx8m test
- binman: test: nxp_imx93cst coverage: check the CST configuration offsets
  generated in the missing-bintool case, reuse the new mock helper, and
  drop the unneeded force_missing_bintools='mkimage'
- doc: imx: ahab: fix the i.MX 9x diagram box characters, and reword the
  mx93 guide signing description (two signing nodes), key location and
  CST_DIR example
- Link to v3: https://patch.msgid.link/20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com

Changes in v3:
- doc: removed *.txt files wrongly introduced in the previous series
- doc: fixed some inconsistencies between what the doc states and CST
  v4.0.1
- doc: fixed broken bootflow diagrams

- Link to v2: https://patch.msgid.link/20260902-imx93-secureboot-v2-0-5947b92a5072@bootlin.com

Changes in v2:
- Following Simong Glass' feedback:
    - Created a new common class shared between the nxp_imx8mcst and the
    nxp_imx93cst etypes
    - rewrote the doc in reStructuredText and mention binman instead of
    imx-mkimage
    - took into account the other minor suggestions
- Link to v1: https://patch.msgid.link/20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com

To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Miquèl Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: "Jérémie Dautheribes (Schneider Electric)" <jeremie.dautheribes@bootlin.com>
Cc: Marek Vasut <marex@nabladev.com>
Cc: Denis Mukhin <dmukhin@ford.com>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Krzysztof Drobiński <krzysztof@kd-solutions.pl>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Simona Toaca <simona.toaca@nxp.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Christophe Guerreiro <christophe.guerreiro@non.se.com>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lei Xu <lei.xu@nxp.com>
Cc: Joseph Guo <qijian.guo@nxp.com>
Cc: Vincent Jardin <vjardin@free.fr>

---
Jérémie Dautheribes (Schneider Electric) (9):
      binman: add nxp_imxcst base etype for i.MX CST signing
      binman: nxp_imx8mcst: use the nxp_imxcst base etype
      binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
      imx93-u-boot: wrap SPL and U-Boot nodes in a CST node if AHAB_BOOT enabled
      doc: imx: ahab: add AHAB introduction
      doc: imx: ahab: add i.MX93 secure boot guide
      binman: test: add a helper to mock the cst bintool run_cmd()
      binman: test: use the cst mock helper in testNxpImx8mCSTSigned
      binman: test: add code coverage for nxp_imx93cst etype

 .gitignore                                 |   2 +
 arch/arm/dts/imx93-u-boot.dtsi             |  54 ++--
 doc/board/nxp/index.rst                    |   1 +
 doc/imx/ahab/guides/mx93_secure_boot.rst   | 297 +++++++++++++++++++
 doc/imx/ahab/introduction_ahab.rst         | 460 +++++++++++++++++++++++++++++
 doc/imx/index.rst                          |  14 +
 tools/binman/etype/nxp_imx8mcst.py         |  60 +---
 tools/binman/etype/nxp_imx93cst.py         | 111 +++++++
 tools/binman/etype/nxp_imxcst.py           | 120 ++++++++
 tools/binman/ftest.py                      | 125 +++++++-
 tools/binman/test/vendor/nxp_imx93_csf.dts |  18 ++
 11 files changed, 1182 insertions(+), 80 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20260814-imx93-secureboot-b914e7b6cbbf

Best regards,
--  
Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>

