Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0048DC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 06:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F081387FA0;
	Tue, 27 Feb 2024 07:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=lexina.in header.i=@lexina.in header.b="QPWK1k6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9321E87E3E; Tue, 27 Feb 2024 07:56:04 +0100 (CET)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 530BB87F3D
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 07:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=adeep@lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0B61B12F409; Tue, 27 Feb 2024 06:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
 t=1709016959; h=from:subject:date:message-id:to:mime-version:
 content-transfer-encoding; bh=qgrCfXuZ6pja7HVHgjnddHuR/6bmuAOHKTyxsDbUjuY=;
 b=QPWK1k6MEIn1ediXslHfd/hq2KsN1Wg7XWxGm+uiJCTnDCo938T2+vJ6ZLYQdrtQH9vmtd
 OoTzcINP4c/iwNdwF6E1xKLl6gs/gaodrlkM3xiD2m0scGx5hAfBPmO7uQOMmMEJniG+R5
 km5dnQ8mYXUHLTRY5Tm0vjRD4FleQy+KExEu75s4vnoWdQlldiLrCwlYgoPzcc0RSlMGmb
 QVf6qNXnai54ZEkki3TU9/IDogt49g9lK3v/05H8y2EKxJE+OzHNve2iLtCGexFseWQ6ye
 JTAK3wDXGcvSbehB/ITQtnHBZvOX1XynALb8Y06F5liS237stJtS3bzQq0BieA==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 0/3] board: amlogic: jethubj100: small updates
Date: Tue, 27 Feb 2024 09:54:03 +0300
Message-ID: <20240227065551.580199-1-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Update JetHub D1/D1+ board support files.

Viacheslav Bocharov (3):
  board: amlogic: jethubj100: fix common config header
  board: amlogic: jethubj100: update MAINTAINERS
  board: amlogic: jethubj100: update docs

 board/amlogic/jethub-j100/MAINTAINERS | 2 +-
 doc/board/amlogic/jethub-j100.rst     | 9 ++++++---
 include/configs/jethub.h              | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)


base-commit: d49fa3defa50c6d3f04acbb52fd486c13c14ab6a
-- 
2.43.2

