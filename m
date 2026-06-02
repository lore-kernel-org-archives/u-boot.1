Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54953CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 08:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96788848B9;
	Tue,  2 Jun 2026 10:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="kcw7SPsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 060948489D; Tue,  2 Jun 2026 09:42:21 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E364284881
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 09:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lorenz@sigma-star.at
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45fd45e596cso1253955f8f.1
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1780386137; x=1780990937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vNdJ5PA7VjO45L8jDhdS3h7fRWudZu7C1LcROrF3mvc=;
 b=kcw7SPsjdXQWnzYr41xrf+Du03B/IAsmTMQ5PlfuPK5d3LUBsnttidGNv1V4FCY9GP
 Nx0qy2bOW4H4zdsXs4UfuGDUt9yD2zeB5z44i0cGmW9fLMaw4svu0xG/5G0dCVCEfb+6
 d2C/AdyjjCg4IV4Ogaup4eD0qNSZ+FcvjLzOvLP+577DmY7i3Q0qBGcfEru0R3qrg3TW
 xD1vI0oFxnt830W2Wvfdu5P1P/rIZaaspPihLeCJCjrEORynJuT19EHGP0pRRLFStePn
 r/jZsad8+iqBJTZXrGsqA5mo48iusT1SpbAvC3X1+CU3b2UkepdDZ1Ju7JDjF/DH3Sqw
 dSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780386137; x=1780990937;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNdJ5PA7VjO45L8jDhdS3h7fRWudZu7C1LcROrF3mvc=;
 b=mtDIEfhj5T4ZWlxzfIGypyuzBxgy8abasNo+qLaobBEp1qOP9DqopiZaCSeVM08t1G
 kpCUyoKi4fHFS3k9WcfdokwTZmWf94BD0QDywAuLPQIZTNyegTAq40R3HWHJEI+2FkH6
 UfxdOpPUziFoqz2C2TozRvcESfYfRSx8alm6opO7O+cm2ZJPVUdoMUgJpajFaWR7rE8z
 ftfRQB/mmhgxHomeRBH0q/7vtMb+B5JQcjqP+kO0mIpSx+utNP7foEhh5mCJPIOSHBNN
 zKwDN65RrDOsOa5/nQShPkn6ORRmEtNdDyJG8RwZgeHpEbJxoohdiJ2kYuHUz+zFGnSA
 Iu7g==
X-Gm-Message-State: AOJu0YxxRywv+ISV58mLDyCE8uy66NgO0m8MwR0P7Y9EY4q5QGHnmuK4
 QtjEJXWON6HIjvZDV4C2Z2nEZBug7k8rI3VxNb0XIRvBwy6FLD7e1lM3EJhpZWqKmKYiaj85VT6
 B0ndvYIsW6Q==
X-Gm-Gg: Acq92OGsFgguT2mGdGCumepA8w3hDgdme3+R5NyAcsjW5inB7ItXZ2uu+qxdr5WKFJr
 XGLbgBlSG9iXJk+PVl/QiDNUOUTDN3M7lcnwb/rzhYdOdHl/iZBloh625QtWySzX3DDujhXC0sc
 FH13f3vXrjTP1F72E8tzxpyL0pu5rBTgb+/I5cZtlWKuBfnMLSaMBpYtyUAY4DhjG1JBkKU00a8
 8S4SYP9YlXie16KBVH2iLnBt3d2X7r6wr0cw7J+/g06Iy90ByBANPvYGpzfjfL63tI/gliLTcnV
 eUA2kMwxpqOxkoKS0vQeYpypnOrLEQU0P8/+IF4uZGSG3Alj33dvVUDLT9i6cxhhEvHrh3KPNNq
 +1eY7U6hV5RyBKQVy3rPPfj2HJSr/nDkYxz3RJtScnBK1g30gPSkQn9AUTkIA7Uz2hPsDCSWI0D
 BOU7h0PnuR/lUGx1lR3sdUxKzE/Y15BG4Ge8M/z6BOyP9MQw==
X-Received: by 2002:a05:600c:c492:b0:490:9d1b:f088 with SMTP id
 5b1f17b1804b1-490a29e4383mr251461265e9.2.1780386137571; 
 Tue, 02 Jun 2026 00:42:17 -0700 (PDT)
Received: from mimir.fritz.box ([2a04:9546:1c18:5b01:cab3:2478:20a6:2fb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354b5bdsm30239748f8f.21.2026.06.02.00.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 00:42:17 -0700 (PDT)
From: Lorenz Kofler <lorenz@sigma-star.at>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 upstream+uboot@sigma-star.at, Bruce Monroe <bruce.monroe@intel.com>,
 Arie Haenel <arie.haenel@intel.com>,
 Julien Lenoir <julien.lenoir@intel.com>,
 Lorenz Kofler <lorenz@sigma-star.at>
Subject: [RFC PATCH 0/3] boot/fit: fix CVE-2021-27138 while keeping '@' node
 names
Date: Tue,  2 Jun 2026 09:43:32 +0200
Message-ID: <20260602074335.3965312-1-lorenz@sigma-star.at>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 02 Jun 2026 10:00:24 +0200
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

CVE-2021-27138 was fixed by rejecting any FIT node whose name contains '@'.
That stops libfdt's unit-address matching from resolving a reference such
as "kernel" to a node named "kernel@1".

Rejecting '@' outright, however, is a regression. We have a customer with
signed FIT images deployed in the field that use '@' in node names, and
with signature verification enabled those images are now rejected and fail
to boot.

Such names are admittedly not ideal. The devicetree specification only
allows a unit address when the node has a matching 'reg' property, and
newer dtc versions warn about violations. New FIT images should therefore
avoid such names, but existing deployed images still need to keep working.

This series fixes CVE-2021-27138 without that regression. The root cause is
not the '@' character itself, but accepting a non-exact node-name match
when resolving a FIT reference. Patch 1 hardens the lookups so the
requested name and the resolved node name must match exactly: an inserted
"kernel@1" can no longer stand in for the "kernel" node. Patches 2 and 3
then drop the now-redundant blanket '@' rejection.

Review is welcome, especially on whether I missed any place that looks up a
FIT node by name.

Lorenz Kofler (3):
  boot/fit: require exact subnode matches for FIT references
  boot/fit: stop rejecting '@' during image and config verification
  boot/fit: stop rejecting '@' during FIT format checking

 boot/image-fit-sig.c        | 21 +-----------
 boot/image-fit.c            | 65 +++----------------------------------
 common/spl/spl_fit.c        |  4 +--
 include/image.h             | 28 ++++++++++++++++
 test/py/tests/test_vboot.py |  7 ++--
 5 files changed, 39 insertions(+), 86 deletions(-)

-- 
2.54.0

