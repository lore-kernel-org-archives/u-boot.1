Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71397606ABAA
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=F3LL5XKD;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=fcjnsL+q
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40EC781139;
	Mon,  2 Nov 2026 16:21:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hKlpwToo9R10; Mon,  2 Nov 2026 16:21:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0AB548111E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636464;
	b=VOLdQ/hZjmiKkav4lKDoW5nsr0mgqEG8bgoGFGv1Y63+J6qsJgsgZMfnQkrl8IDvShKC
	 vKGaI22Gsli2he/Gd18TFFsPraVFzChFjvQfIu2K82QVCHZ836wAHEJg+eAKe+4g/x+hO
	 OAw24RIslblx1bm33e1i3IgaKD1FleKEpfkgwcZfGMCVnTUrZ3JMNFoQw/ViB9GqC54a2
	 fv0eGLrLWr0kzE7areYNt+tAHCDQms4sfwOFCkrwfiC6QLh8SJ/h2SKKmcUWM4AAiQTxT
	 +LXUnqc7U3wnCSid9JC14+Y6AoA+Tqn7Q8E/V6WA9NC0AELDj9y9hFvVg+U+Ox3kf8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636464;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qKL8aX9h/eLOD/40/z/mulc3BYMkpKB20vj04TBh5BA=;
	b=sQ2NP5CBqmXZcRnDl3BPohVq7Gkxf+VJFIzRtbUZHWp6z7G4fu0GLzWeMlCvJwL903+f
	 PyroTy3ocnvkdeKPqOh614vd6+DnB1O9x6TDSiA17qOJmSPmyJ+1u7WTcY8XpLQwiTP2R
	 ru6HlrmGkh2Kpn19MRlJSKt5m6Zry2V80z+aG0/YBPWl2Pmhsf6z0OJeeJc2k6HmedB34
	 /egOQQ2jWq3GccGL2rsskRohKYuW9dSkzP3211MT+XvxTcm4OOUWnFtmPsju4Qf5zNu6g
	 zvKZ6gXAvdU/n7iQQ9YLLJ8JfV4Y+S2ZcATtlNj3xtyeagnn64XBRyYjQvoyMGx6ciQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636464;
	bh=qKL8aX9h/eLOD/40/z/mulc3BYMkpKB20vj04TBh5BA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F3LL5XKDQ3rva0IhXn9r7LdaHU9DRvC3zB4dQU3FW/r7DZ4P8A5BVgMV3dX5ULdYE
	 V64l8C403WbwRe1YvSAuBsHOf4ExGomTlPDd5eFXyEHofpb7UGpiFzHAgW/KZeZhWB
	 pbozuux7R5ZygwDGcw+uxiiRklV9n43RG2U1FVwc+XlfVpGHcqFierdhTDS/W+SNrA
	 WggMfPupVxVAIqTqIin2oBkAlMeDyVUmAXLGcho/pmQgWLLUaJM8YPr44Kazb7Rgh/
	 3Qc1fSu8PKwLIvSj6WFRg5E0iBKLI42nWemM6laA7HaBNuY7e9mwHBqM6YkldJ7xxp
	 fRzsfNBkYcHLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AB548111E;
	Mon,  2 Nov 2026 16:21:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B7043411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8B894007E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rzwi4NSJhEng for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F145F4009E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636452;
 b=rYaxa3AfI4iF4orK9qwtxd0nTzpl8cWhweAQ3g5WdMsG9qm16ezZxyzRW425GHn62LGB
 MNQ8HtBLGm2QhMUJPrljCZLBbrJPeagaaN0peZuwTBOv1ws1ap8lL1xfpHPJfCFMmcyuc
 yEd6Xm+pHLskJTjNBL6sGYUEdJHw7JCZOAB6gTXKim07amnhZ8MnlcYJZDgDwPZNUO+Wj
 uKU5qodl/IkguFX4wf7/kc45OZdAmMXD4V5jmBKwm1xPMfVVG3Ios3F9+yrs10fVcxxgf
 bPi3PTSaVu6CLiKo7OmTI+H3EY1D/GRemd0AvZsoTcCiyGfZhGwJOvzGQbvaxOBEI8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636452;
 h=Received-SPF:From:DKIM-Signature:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=qKL8aX9h/eLOD/40/z/mulc3BYMkpKB20vj04TBh5BA=;
 b=hiWt2fotwE152pV8/TOF36rfDZHW1q7QpuhovLNruUDUEfihG2D/WZUxJhHv0PZoE3Je
 HOQWUktfoYS3/DHRG5mBfqcv9vpDp3dgDExaN3obSvq7u1EtPVvFxqHJXzB4JMkKMS+y6
 MSoZozuTGJi2Z6jMO8bRx6QH/o7UAV2ICorX8bhlnBio5YhAZiJDlhKv2Ucb9ZpNo2LjX
 J/YLAyzc0/BESxRIkUXTjtujTssuU8/Y4qGbwiOU0D5pMJvMXOH25exeywzLhKQ+v3Bhv
 oSCggBLreCH/ELPmTTZBMz1gVCwkDrFqIpQ5d6SSVOcrgo0PAVI+hz5hQzeq8BwUzqQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=fcjnsL+q; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=fcjnsL+q
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F145F4009E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:50 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qKL8aX9h/eLOD/40/z/mulc3BYMkpKB20vj04TBh5BA=;
 b=fcjnsL+qLfKui1I3PHwa2B2ULsVemR28HVF6RjdNjH+s78+vBvZ8vRerFVgBOGU2Ro7/g8
 ZdmH3XeFNN/3PliDii5a8/e7Vmm1kHkUX37Zl9sEF/Pa15KyPf0URjEcM9twM2q9GDGirc
 zEyIEzfTC2RKGckLM04xJpaIL179I0XEh4zME1JmPXY9Xt8bw+jLnwrZkNvRhdXL3BMsur
 DdIf8Mk8cRxB4vXY7UrybYmLphbEz9v6VqbwbDvLiOJvpx/iUExlPa2EbdKuy4MK2J30BL
 sa+UNyO1xrL+36a3q0tF1Yg8CEWC5HXShCUDd2Asr0hG3HZbAFOuGa8aqI8xxA==
Subject: [PATCH v2 00/12] bootstd: rauc: Fixes, partition names and
 built-in boot command
Date: Mon, 02 Nov 2026 17:20:17 +0100
Message-Id: <20261102-main-v2-0-4537bcb19d66@kontron.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQ7CIBAFf6XZsxigaWk9+R+mB0pXuxqhASSah
 n+X1pvHSebNWyGgJwxwqlbwmCiQswXkoQIza3tDRlNhkFy2gsuePTVZZmrd9SO2op4aKOri8Ur
 vPXMZfhxe4x1N3LabMVOIzn/2nyQ27y+ZBONsbHSnulYqwdX54Wz0zh4nhCHn/AX+cGs5qwAAA
 A==
X-Change-ID: 20261029-main-c3a89be613d5
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5677;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=obVA2lQxxyMNRqLH4x3XepZTmC7Rbc6UO5mRdllppAE=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjmAfjq3aEZ733+cfNVntvdE4brLlXCVJdVt9feej/
 qlbAyd0lLIwiHExyIopskjxW7y2NYv1kT9WHQUzh5UJZAgDF6cATCTmOCPDlMAky0/fPRPOuXRc
 cItZ0Ohp/cJwn30mr6hVR8Zyqcw8hn+2Sxacye56dCb5at13ayZLzexdEz5wx5hPbWvd3JxRfZw
 FAA==
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes some issues in the RAUC bootmeth and adds two
options to make it safer to use on real devices, together with tests.

Patches 1-4 fix bugs in bootmeth_rauc.c: an uninitialised pointer when
a bootflow has no block device, a leak of the active slot name, a stack
buffer overflow with long slot names in BOOT_ORDER, and a leak of the
boot script when a boot attempt fails and is retried.

Patch 5 makes the RAUC test restore the bootdev order also if it fails.
Before, a failing check left a static array in std->bootdev_order,
which was then passed to free() and aborted sandbox. Patch 6 adds a
test that boots the same RAUC bootflow twice.

Patch 7 makes the bootmeth set its BOOT_ORDER and BOOT_x_LEFT variables
only for a device with a RAUC system, instead of for every MMC device it
scans.

Patches 8 and 9 make the bootmeth safer to use on real devices, without
changing anything for existing users:

- CONFIG_BOOTMETH_RAUC_PARTITIONS can give the partitions by their GPT
  names instead of their numbers. The bootmeth then only claims a
  device which has the partitions of all slots. With numbers, it claims
  any MMC device whose partitions happen to fit the configured layout,
  such as a standard distro installed to eMMC, and writes its variables
  to the environment. This allows to use BOOTMETH_RAUC safely alongside
  other bootmeths.

- The new option CONFIG_BOOTMETH_RAUC_BOOTCMD, empty by default, sets a
  command built into U-Boot that boots the slot instead of running
  boot.scr from the boot partition.
  Nothing authenticates that partition, and signing the script is not
  a reliable fix, as the environment must stay writable for the RAUC
  variables and setting verify=no there skips all checks. With this
  option, U-Boot executes nothing from the boot partition.

The bootmeth keeps both options in its platform data, which is set
from Kconfig when it is bound. The tests in patches 11 and 12 change
them at runtime, so sandbox_defconfig keeps the default configuration
and all tests run on it. As partition names need GPT, patch 10 adds
GPT support to DiskHelper in fs_helper.py for a second RAUC test image.

---
Changes in v2:
- Patches 1, 5 and 10: Add Reviewed-by tag from Simon.
- Patch 2: Look up the slot in find_active_slot() and return it
  instead of a strdup() copy of its name (Simon). This also catches an
  unknown slot in BOOT_ORDER before its BOOT_x_LEFT counter is
  decremented.
- Patch 3: Print an error for a too long slot name in
  CONFIG_BOOTMETH_RAUC_BOOT_ORDER, document the 32-character limit and
  pass on the return value of boot_left_name() (Simon). Rebase on the
  changes in patch 2.
- Patch 4: Reset the bootflow state before loading the script again
  and move freeing the image list into bootflow_free_images() in
  bootflow.c, used by bootflow_free() as well (Simon).
- New patch 6: Test booting the same bootflow twice (Simon).
- New patch 7: Set BOOT_ORDER and BOOT_x_LEFT only for a device with a
  RAUC system (Simon).
- Patch 8: Give the partition names in CONFIG_BOOTMETH_RAUC_PARTITIONS
  instead of the new option CONFIG_BOOTMETH_RAUC_PART_NAMES (Bastien),
  and only use a device which has the partitions of all slots (Simon).
  Renamed from "Optionally check the partition names".
- Patches 8 and 9: Keep the options in the platform data of the
  bootmeth, set from Kconfig when it is bound, so that tests can change
  them at runtime. The boot script code is now always built (Simon).
- Patches 11 and 12: Set the options in the tests instead of
  sandbox_defconfig, so that the default configuration is still tested,
  and drop the #ifdefs. Keep the RAUC test image (mmc10) on MBR with a
  boot script and use a second GPT image (mmc13) for partition names.
  Also check matching names, a slot with missing partitions, that MBR
  is rejected and that no variables are set for an unused device
  (Simon). Patch 11 is renamed from "Test the RAUC partition name
  check".
- Link to v1: https://patch.msgid.link/20261029-main-v1-0-b5a878627107@kontron.de

---
Frieder Schrempf (12):
      bootstd: rauc: Initialise desc in distro_rauc_scan_parts()
      bootstd: rauc: Fix leak of the active slot name
      bootstd: rauc: Fix overflow of the BOOT_x_LEFT name buffer
      bootstd: rauc: Free the boot script of a failed boot attempt
      test: boot: Restore the bootdev order if the RAUC test fails
      test: boot: Test booting a RAUC bootflow twice
      bootstd: rauc: Only set the RAUC variables for a RAUC device
      bootstd: rauc: Optionally find the partitions by name
      bootstd: rauc: Optionally boot with a built-in command
      test: fs_helper: Support GPT in DiskHelper
      test: boot: Test finding the RAUC partitions by name
      test: boot: Test the RAUC built-in boot command

 MAINTAINERS                  |   1 +
 arch/sandbox/dts/test.dts    |   8 ++
 boot/Kconfig                 |  24 ++++
 boot/bootflow.c              |  13 +-
 boot/bootmeth_rauc.c         | 284 ++++++++++++++++++++++++++++++----------
 configs/sandbox_defconfig    |   1 +
 doc/develop/bootstd/rauc.rst |  15 +++
 include/bootflow.h           |  10 ++
 include/bootmeth_rauc.h      |  25 ++++
 test/boot/bootflow.c         | 301 +++++++++++++++++++++++++++++++++++++++++--
 test/py/tests/fs_helper.py   |  36 ++++--
 test/py/tests/test_ut.py     |  30 +++--
 12 files changed, 644 insertions(+), 104 deletions(-)
---
base-commit: ee9fc27f2a2a43f253a6fe18d7a6f7c4eb0cda3b
change-id: 20261029-main-c3a89be613d5

Best regards,
--  
Frieder Schrempf <frieder.schrempf@kontron.de>

