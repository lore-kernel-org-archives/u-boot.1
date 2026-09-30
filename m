Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A8FCA5FBA
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 10:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC34D81045;
	Wed, 30 Sep 2026 10:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M3nyBI5gVa2Z; Wed, 30 Sep 2026 10:56:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A955380FF9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790765799;
	b=cp3HtlFcgQSECc+8XwcCM6GLI6DgJeQwMeyYgOWrwyqG6TJgXB746zIBHwhc4Zo32zSu
	 s/88Tz1WnxuBhs7sZRd30WxCm8+m63Rc+S7OTH/9XScDc2XveQnXNtA6H7UTbJtxu45vy
	 gFWnxOJHZLKkmGcMGowxTPL+zeZR+HtJsVOeRO2Q4lsprQwVjX1JCqmFHZznj+kgOWPIM
	 irqIL2QTpReXBTgBufdFEyoP7NFKFSBpbInCjSX+5aK1ttJU7aBYxALo+hwhjI1O9HEFv
	 97AVZoLgGq94S+gZKcpNub+oh6h0KeordY3HCoYyNyQX03uFHdktvrCfUTyewZcekzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790765799;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TUNfRNZOc5VhTFBwJUCwlypK5IEPc5xhCAOKLHykYV8=;
	b=dYIVuqgO8Z9flJ2zmSe2K9v9tRh/6pBelkI7axJDhJCpSY3h5Fl2o5QatPieASVcPYJd
	 GjLVc0c/A7lngFf/TTvYmFVAjDS7V7qzYp0/AgIwdYQbz7RU5Ky1eMmrmv8sk4yo1+cIQ
	 9FAFSjdaGcBoDFQhL1UY6ZGyZWDg/9m1pL34pkPSFnqveS1MxUuofgwpl7QTxYTWWg6ck
	 pVu2hWbvQ+qTG+mwcnbo3jYNR62WBmi82XLMX+raQ1qp2BCjD5sioOr6QGnmXkuO2MrE/
	 b9Yt5xwqLEdMtUlzN6H28Ie0hMW3zQCa5ao34RYayn76GMecOtlS5qoyRaJpIimZ8Sw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790765799;
	bh=TUNfRNZOc5VhTFBwJUCwlypK5IEPc5xhCAOKLHykYV8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pHCmV6CxKDQZbZ2e6d+rmZnrGbUhaaFQrJT8HcgFFjiajwt/ZN5vebpngmpIhdHNS
	 aEP9Z38F870DVvZHQvnqKtYld1yuvzQBf7VbE3AqvYFFaPQJ2i47XGGlA3q0jg9o+J
	 +lWf1MbEDA3Uy2oaL+83wvP0bVM1LYv8FXX/X3k4DoQUV/DsFeROQgeyAj1jPugBvb
	 yQ92owBXVVnF+xDWFvCxk6YxYkzD7ja8YRC3Jj9zjvvZSPZGpYjEKZMAyUA+YCqO7Q
	 oNFpCGyWaIhvAZLpkeSIiwPRnRS8tQiNKroN+Yyl78IDktIi3bWaFkW6+mue+8t33i
	 cBrLlJJ4Kvihw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A955380FF9;
	Wed, 30 Sep 2026 10:56:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5632380
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 958BB60814
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:56:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zA0nYhun9Lht for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 10:56:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5A3C8607BB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790765797;
 b=Xmgl5ie2e0zKh4hsfoEvmJoEW9xsio6qVKrvKpdUAR/0DfHs6310MjRLms2PZTjI+H8Q
 qYiOZQJysjNdyz6xo0JaIeZOqcTuses+qGD9qiM2c0y67mNRzdz8FlXVE4/cj9pTHToxd
 mD+NId514RhrTdim3aiWTEhihg+eUZgRCN+md8O7nkPxWdYegrnrBYIQ+p/PZ8X7HEo1j
 ZUD8crobBJmKF6Np6AtNsruKxdA9Yr4xjYNOW2NkXXlNNHI+k0PRkdd5w/Vzd7L4jr26G
 3x+KXg44XUpBdLyPi/G+kYHZTueoNyb37KdmgZOIp3NqUcWABZkyYOAqZtF7irJMgMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790765797;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=TUNfRNZOc5VhTFBwJUCwlypK5IEPc5xhCAOKLHykYV8=;
 b=M4N9xzeAVkkQVhivgM76NrL/0Z1ix4zmax/7MEl2/MWTpa7GWaqx8jvBwnPqUGD/Al+9
 PSognWMV3BsVHtClq7mAjIbHUzqbmDOKumfEt01vs9Er/3cfHsHP1RHuwIE7mO/LsK3bh
 7uScGB368elOSYFAb7sUNgnQEmVoHRWp4Bj3xtJaUgkbO+1PxLMfMLB3q0rjymNR1YJql
 0IDHpXquAdv4bPmfIcd4pIMos5YBqHHP+p9BZLmEK9ROHTzamcydhHSasykZI9qHa/d9W
 aBI3ir5AeJsoFJL4xaGoM9Y8neMZVmXkJDHZKr5jjp6mF2CGISHMTDHzrGx9QcIMrJw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=W+8CA9RN; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=W+8CA9RN
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A3C8607BB
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:56:34 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so39325185e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 03:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790765793; x=1791370593;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TUNfRNZOc5VhTFBwJUCwlypK5IEPc5xhCAOKLHykYV8=;
 b=W+8CA9RNUFso2M8C3/rfT879u8usQ6pdrt7bwtLhCQROyJOv2aKkRb5xMTpyedXfRl
 MWpcozAzXzBF/G8LmXmG09ByWhz2XeHElmyYy55CP/9/25+0U3QnQeprvx4mYf3wuoTi
 7JThqm/7IjKqqKSbe3o3EDVf7XaLYgtfQRPOKpHTa13OJH25Vq63FcXOP+WEArM5tiyO
 dBBw4d5baXIMRjSXb739sGD6B0rxuhyMw3tmVGnCOAeWnMqFvaUT1I41T3ossiFlWwfj
 kGDjSFMdGTUb/LnG6xn+xvx3IsbcLzVX0vL6GS5Aplvn3AbtmNzZ4+0fSJ3VJ/KCXoma
 OpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790765793; x=1791370593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TUNfRNZOc5VhTFBwJUCwlypK5IEPc5xhCAOKLHykYV8=;
 b=uh1J8uvNRhEcesDlpmwCjm+NeHiCU7yA30QSRez7zKLUV7TSIBYPsOry8YcjepRfKm
 pbRsNKi3006v/nYYYeAVfI4EewZQ1wpaPt7e7YL+x95Q6p1cjxF6aJ+LXQ45n4BSB/GO
 7dZjpDI8L2B5kIAcl212DGOM9Y6D6tB6d2G6LVh8cwNhdg0pUi81J93vafbRRmJj8kX2
 WVAGmisAPTNeMwntgDUtfjA86Kms/AuPyc6w57G4QpKL+J5xotXlySTffl+hN7MrqDoG
 0zCdi1AWP6T8Apb7VEMBVDbWSCw5p95aAlx+i4UTZXRb9dnPRqs98YsgvdKY9Qscvs40
 Z7cw==
X-Gm-Message-State: AFuF++nWGe5dXr24jtQxGuulsUanmKPNkDJxhPdS7+f7yv1pmOQHieJO
 /4QFAyLJtP6WH6kzklSssCnSADdBPnoawJUmsMbuQLe9EDL7sZ2fz5CxSyIlyx4WffkNbsOl/HG
 X0ZOf2Zo=
X-Gm-Gg: AYBFou0SZBB3P72dC1ZLHnpqic4eg3wR7EK1KireApnye+CY+JINJx65M+51Jtz34Ue
 wflxEXJKVqbWakmboNvKPAIAxIywDIwyGs17zPajBHGynfegVQXeXBiQsyabmk+rO6Jj7JqLG9O
 wGiKCYGXeQ/WFsWcQqCUPofeSjgGsjcsQeuRM9QEnUlGVmr0rXN6lxjAQYsN9mOyDwvTxzZWFPH
 4fAy/VUPhqstRCCmBmNkikp+/HapSP+4Qyn6/xeUAuCl0IqGZUiVdxZVF6CFC/BV28nRhu915uD
 W4ZkGisKDoGLupWBX0N3JsQeRhPlPWWedcqcwt0xN5bs7NlA8FXRI4X/6UrZZco16jRTUIu2m7U
 /n4ky8FRhsjzO6b4LjiTgWZ8c2J+M3BYtlTra+vvgQ6VDUBwIK5T3kK8jgS1Q8lWyl1pv9/kMAn
 fB+UGygrs91Lk/v32vq/Q5gv3UkgYPFxHdw6la72njR04xN/R40v1DKTohuD9fN/q/lpDSOV9eV
 x9WZVXxtcKxlgjkuLyoLXez5pvGo895rOxchsmc6z/+oL1jEaGwKxq0AoiYZIA5QlPIDC7MQFWV
 V3D5afOX0ihm348XEHcLWxiYRCflMs80PyM9VbcwzCoMeADlYQvZYnE5IP3URixlVHXdMZWqO3V
 qpj3jB5/RE7LFqRlpSOId5xCBG4FNARVmKjB06El79NkuPe37DgC7krQv19d7rzer5TRVIZYBvX
 38yQbEpRuRBgnpgKVcTdc2TXuSDtVbXt2yk0Ka5toi7R08Ff8topNrdG3LaHBd6P18gPpRlApsv
 w5vU0h8Md6aRAYBVN5kDRXBR+8bBNWbATf+Ajpip7Xq6QP5BLt1bvaMt/PlxMZxyjNEgs1X
X-Received: by 2002:a05:600c:3152:b0:49c:fc6c:be19 with SMTP id
 5b1f17b1804b1-4a01b12603amr16753555e9.31.1790765792654; 
 Wed, 30 Sep 2026 03:56:32 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01771cf9fsm48614685e9.14.2026.09.30.03.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 03:56:32 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.u-boot-project.org,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org,
	jan.kiszka@siemens.com,
	ravi@prevas.dk
Subject: Pull request for optee-next-30092026
Date: Wed, 30 Sep 2026 13:56:22 +0300
Message-ID: <20260930105622.3740163-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The following changes since commit ad2b0f0ef2a2a6bae1896e493e98734e37a3f1eb:

  Merge patch series "dm: gpio: read GPIOs in of_to_plat(), request them in probe()" (2026-09-29 10:36:18 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm.git tags/optee-next-30092026

for you to fetch changes up to 0871cc74cbd97c00f96bd50b483f102316ea2f29:

  cmd: optee_rpmb: make it usable by scripts (2026-09-30 12:23:09 +0300)

The CI seems to agree https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/pipelines/1411

Please pull!
/Ilias

----------------------------------------------------------------
Jan added support for the new PTA_CMD_GET_DEVICES_RPMB (introduced in OP-TEE 4.4.0).
OP-TEE exposes devices as 'services' on a TEE bus. Prior to that version all services
that depended on the supplicant where added on the bus by PTA_CMD_GET_DEVICES_SUPP.
commit f0c8431568eede ("optee: probe RPMB device using RPMB subsystem") in the linux
kernel explains the reasoning for adding an RPMB specific command. In short the kernel can
nowadays short circuit the device accesses directly via the RPMB subsystem and doesn't
need the supplicant.

Although in U-Boot the supplicant is always present and the RPMB device will eventually
be probed during a read or a write the new command is needed to discover and add the
services on the discoverable TEE bus (e.g an fTPM). The PTA_CMD_GET_DEVICES_SUPP
doesn't expose it anymore unless OP-TEE is compiled with CFG_RPMB_ANNOUNCE_PROBE_CAP=n.
But doing that will force the linux kernel to go via the supplicant.

Rasmus updated the cmd line interface for accessing an RPMB via OP-TEE
making it easier and saner to fetch stored values. That involves an
update to OP-TEE which is already merged upstream.

----------------------------------------------------------------
Jan Kiszka (6):
      tee: optee: Factor out service enumeration and binding functions
      tee: optee: Avoid binding a service twice
      tee: optee: Add support for enumerating services that only need RPMB
      tee: optee: Do not warn about TEE_ERROR_STORAGE_NOT_AVAILABLE
      mmc: Call back to optee after a successful mmc_init
      mmc: Make "MMC Device not found" a debug output

Rasmus Villemoes (5):
      cmd: optee_rpmb: sanitize TEE_ERROR -> E* translations
      optee_ta_avb.h: add TA_AVB_CMD_READ_PERSIST_VALUE2 define
      tee: sandbox: support new TA_AVB_CMD_READ_PERSIST_VALUE2
      cmd: optee_rpmb: allocate large enough buffer when reading persistent value
      cmd: optee_rpmb: make it usable by scripts

 cmd/optee_rpmb.c                  | 70 +++++++++++++++++++++++++++------------
 drivers/mmc/mmc-uclass.c          |  2 +-
 drivers/mmc/mmc.c                 |  4 +++
 drivers/mmc/mmc_legacy.c          |  2 +-
 drivers/tee/optee/core.c          | 64 ++++++++++++++++++-----------------
 drivers/tee/optee/optee_private.h | 24 ++++++++++++++
 drivers/tee/optee/rpmb.c          | 20 +++++++++++
 drivers/tee/sandbox.c             | 20 +++++++++--
 include/tee/optee.h               |  6 ++++
 include/tee/optee_ta_avb.h        | 12 +++++++
 10 files changed, 169 insertions(+), 55 deletions(-)
