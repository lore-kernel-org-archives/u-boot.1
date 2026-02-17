Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05831E909A4
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 13:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4875B83D3D;
	Tue, 17 Feb 2026 14:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E37B783C32; Tue, 17 Feb 2026 14:30:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C8C7080325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 14:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kavin.gunasekara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55C581477;
 Tue, 17 Feb 2026 05:30:14 -0800 (PST)
Received: from e142508.manchester.arm.com (e142508.arm.com [10.33.11.66])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ADD63F632;
 Tue, 17 Feb 2026 05:30:19 -0800 (PST)
From: Kavin Gunasekara <kavin.gunasekara@arm.com>
To: u-boot@lists.denx.de
Cc: sughosh.ganu@linaro.org, xypron.glpk@gmx.de, bmeng.cn@gmail.com,
 trini@konsulko.com, sjg@chromium.org, kavin.gunasekara@arm.com,
 andre.przywara@arm.com
Subject: [PATCH 0/2] virtio: rng: Handle oversized return buffers
Date: Tue, 17 Feb 2026 13:29:34 +0000
Message-Id: <20260217132936.2736916-1-kavin.gunasekara@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 14:40:39 +0100
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

On Arm FVP platforms the virtio backend sometimes returns more bytes
than requested. The virtio spec does not forbid returning extra
bytes. U-Boot’s existing virtio-rng test treats such cases as errors
and the test checks if an error is returned, leading to test failures
on FVPs.

To prevent the test failing in such cases, U-Boot should properly
handle such cases. Patch 1 adjusts the test, while patch 2 relaxes
the error check in the rng code.

Kavin Gunasekara (2):
  test: dm: virtio_rng: Update virtio-rng test
  virtio: rng: Handle oversized return buffers

 drivers/virtio/virtio_rng.c |  2 +-
 test/dm/virtio_rng.c        | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.34.1

