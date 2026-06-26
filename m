Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02B5C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 14:48:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CB778498B;
	Fri, 26 Jun 2026 16:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ei7FDX+u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F0F5849BA; Fri, 26 Jun 2026 16:48:19 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5826684894
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 16:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B96B1E7D;
 Fri, 26 Jun 2026 07:48:12 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.Arm.com [10.34.111.142])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABDE93F905;
 Fri, 26 Jun 2026 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782485296; bh=VSI6vrW1i2zJ6o4ayPgEa3SIB3MWpf/yVXK0W+ZlN50=;
 h=From:Subject:Date:In-Reply-To:References:To:Cc:From;
 b=ei7FDX+uhM2VgNx21wEKDRkgaH+UjlWf7uXfolOzKodLcAB06/gmF4Z5cX09IlfXG
 HjuZOfUxv/VgqXH4ibE0KIHrhbmeEIsima9W4giAy/XrPitkv9KHnVi8UiroP9O9Fs
 CIHWU1zD0J0aRt+7t/qcEqDtdsFlgTxu3rVJFTyY=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 0/2] efi_selftest: block io protocol verifications
Date: Fri, 26 Jun 2026 16:47:57 +0200
Message-Id: <20260626-rev-v3-0-12a0c0fc0965@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB2RPmoC/03MzQ6CMBAE4Fche7ZmuwoUT76H8dCfrfQAmNY0G
 sK7WzBGjzOZb2ZIHAMnOFUzRM4hhWks4bCrwPZ6vLEIrmQgpAYbVKKMRNuSY2cMeaehLO+RfXh
 uL5dryX1Ijym+ttMs1/bru81nKVCgtZpr49Hb+qzjsLfTAKvO9Cfo+BEkpGiUYaOwU53UP7Esy
 xuD9hYBxgAAAA==
X-Change-ID: 20260608-rev-772dedbb2fda
In-Reply-To: <20260624-rev-v2-1-68beb809891a@arm.com>
References: <20260624-rev-v2-1-68beb809891a@arm.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=VSI6vrW1i2zJ6o4ayPgEa3SIB3MWpf/yVXK0W+ZlN50=;
 b=owGbwMvMwMV42vNHWNlitimMp9WSGLLsJurPbf3FWpyptl689uu2qau2KX2Sy7yT3Olb8FzJn
 lvnxC71TkZjFgZGLgZZMUWW6wkiC/qiAgQLKrRyYAaxMoFMYeDiFICJ5FlxMGzsOLm860N86yWx
 76x8GSZ/P9a0FjlzTco4eDF3uo2bLMdv04y2X00aCy01/wYkz/ljcsxLM6Z7knuL7G3fqS6eYZ1
 C8Sc3rHdr7nvNwrPIP8bDvVRONsCOcdX7Pz1nLJSfWhkcNTwn72xz8eO/lAWOjnctzp6SPvh6c8
 3tgxpzJ19zOnzjf33dLBvDgxpaZf3Ligw1lrIuVjgtvMhf5m6MsI9mV4L7JOFsYcMF5580hvFsj
 6qaZvY4j9m8bnlT35ov67unv36Spuy9qVpFNOBSdP36R3EpU6Ok1u2eyLn88AXRq9PEO1Z8si1i
 P3t01baYjZ+XeyS57Ix39wkq3Z38jSvyMFfETTnul1FvAQ==
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

The first patch of this series makes sure in the block device selftest to
free a remaining handles buffer during teardown().
This allows to simplify error handling in the second patch, without fear of
leaking memory.

The second patch's main intent is to test the revision field of all the
block io protocol structures.
This is the test corresponding to the fix in commit 62d7a49c4db6
("lib/efi_loader: fix block io revision").
While we are at it, let's verify the protocol's pointers as well (as
suggested by Heinrich).

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
---
Changes for v2:
- Deal gracefully with no block io protocol found.
- Print revision with %u in case of error as it is unsigned.

---
Changes for v3:
- Introduce a preliminary patch to make handles pointer global and free it
  also in teardown(), to simplify error handling.
- Verify handles number and pointer on the normal path.
- Treat block io protocol not found as an error; we installed one during
  setup() therefore we expect at least one.
- Simplify error handling and return in case of error in the loop rather
  than breaking.
- Verify all block io pointers as well.
- Remove leading `lib/' from commit title.

---
Vincent Stehlé (2):
      efi_selftest: free handles on teardown()
      efi_selftest: test block io revision and pointers

 lib/efi_selftest/efi_selftest_block_device.c | 77 +++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)
---
base-commit: 6902fb4c17faa375003124c451c2550deab5463d
change-id: 20260608-rev-772dedbb2fda

Best regards,
-- 
Vincent.

