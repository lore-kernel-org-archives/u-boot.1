Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4797606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ihw1eDOu;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=Ll/vjD57
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72EBA81010;
	Thu, 29 Oct 2026 16:23:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AyLUVEstiYdW; Thu, 29 Oct 2026 16:23:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57C5381000
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291014;
	b=NZA6GRhF9xL9cANZfMHb21gxXUG25nCOb42NFElyJUWtMUEKOujZ7TQpxIdHuHsgwhpR
	 7wgCszfOOY+ui3biw/A3QMkhxH1gUZ2lES/8ZLJm0+L7IomNnbqhGS1qEfCHKw6DEKFHz
	 NPjkR5olxJzT44eOXt6cQa7o6tQb8O1QZhX7ddPUNfwfM7TGn1a//yr7BAJZ9pp9jt7PA
	 GEJAiwvGrOJ4xwoa1fRSv4h0G2n8DpatAtWSHj0N3ZYIYIPzrRDpFe7TWJSrO8YlSIWfD
	 LMWyTU8lfdt6RDQiQ3kykEur0Gey8lrYalpxqrAO8nUt1SNncSY8hbX2Sg40Ku7Hn4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291014;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LSSPK0E9ICXmitZst2sfo/ExFoxHmWbG2I6CdgFbxRY=;
	b=dA8x4eIcjbptc6cNt0IEBfddvkCDg1PUjVpzpyeAMSHr8vksvUWS6BrEHk7969wif30s
	 dVGLaVB2w0FYtj3nGPTsMpSPKZZLSD26vCagBDNQbvdN7afNAEGI3vNINfu9xdFBV5/0/
	 2AyIk3SqozflZNQ8To3xr58tfcdCzHKFB2OWXLCEn3I+D96D5aGYFfePvUWtMe2VPRtJT
	 FweXJgjBawQL4u1LFFPGv+C+RsFIRhTS0FFhkP5QpKHdh5E/m4Bc2JhuMqrY9lRZV06Ug
	 MNK5sYioWHwwZ885mrs7V4/ZojPSWda0QsxhJ930QWoHeJnVU+HTf5ghhxwQxWIPxvA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291014;
	bh=LSSPK0E9ICXmitZst2sfo/ExFoxHmWbG2I6CdgFbxRY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ihw1eDOu98C19HtdrKfxMWAsIZBPCH7FHVSVDK1For2uf2/riYOoffosDnyFFQLh6
	 MzripfQzNSFiNXn/PHKvzxdaVeVwy/oYRxzjniRkbDL9YEF58i0OBEKf2P/GDzeJ2R
	 1MlzkfrwRcC8eTPcqxhOA/HAHB+/u/OVMdUowADmdMZZL7LM8fLj0kQSf5GZxc4fyF
	 i6LLslJbuDQ6V3+XZH9pH6SCeJFhIB8qcFQxGT9wubpyVwU032RwSGc+ORtpDvCVnu
	 NAepmqsAgeqvqdYqNHtBUCHekKHLRj2E8WXSGa0aNcX6baayS194PTV3KF6NDeEEIa
	 1Kq4tpli+zazw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57C5381000;
	Thu, 29 Oct 2026 16:23:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FD7EDD7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 522A9605C9
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ysHSpXI-tJOc for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:23:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F0345606BB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291009;
 b=Qf2Qzlh1AItx4TR15k+OOUQTuMva3dqCXAj4gMUZJAjXRBnwvUvKKUqVdaAPZE6GTIB3
 rF9CI6CD7+xvp97lV+sRTZ4oDd45W+kzCEToTznZcD2HDFV9JD9JwRd6n8K3Lvhx7YsKb
 iLzUsuUjTRYPlBMdPjbdbH085zPb9pMkEj8hASm1Id8f//0N20W4/LPGINZ+WVSi/BG9x
 tJCV/OKZUmhtUe+S3BYtByxpcVLVB3vz8iht3f6jRsJAvxOW5BWask96jAf3aHV6g4Wks
 db0tOaO8EeEHdKsL+yKxDHAYE37KLWrvJ2r3HZP159JGx579sOwE27z0r24qzN+bMdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291009;
 h=Received-SPF:From:DKIM-Signature:Subject:Date:Message-Id:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=LSSPK0E9ICXmitZst2sfo/ExFoxHmWbG2I6CdgFbxRY=;
 b=qakqWZDJhoJIcHHq/v4TLFNH4rg9XMlMSaGa3R0actnKsKs8+TMKAtprvzlBMCL6lg5s
 1nlL7fdkFHjeqnfs84BiL+avA7xvpx+gby5D/Lb0KSFeJCU6hWtYccc8Xh0jDLfEpT9nN
 IUOFKz1ZebXO67Or7tsCHvQ0lJ4p3+9V0tD9N8KazyLslqi4dXOppwBOfUX7+y385VTsp
 Npp0LPNrUnjfD2LKkYM3B/MQvbltpoS0pwh8bok71y0cAYW/IgLVphf2gXciprEdtKkWN
 vKghdNQUt7kJ1p4dHdTYRVItvayYR1UzyMt9W1p73kTgdYR6smVtTKm8cQ+UbC64HgQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b="Ll/vjD57"; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=Ll/vjD57
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F0345606BB
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:27 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793291004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LSSPK0E9ICXmitZst2sfo/ExFoxHmWbG2I6CdgFbxRY=;
 b=Ll/vjD57oMXUmjDZfQNKTLsnY9R2M5Pw5cafdbpbDhBA9UiV5OctluzPD9rM73IJtnCZ7y
 +JJTKtO5e8d8ti68yclclu0doki5/cJik3sELxPvlIfwz77704bxu9PVaVW0L5SwIFjIa8
 BVQGENQwufGLTy4RmCuRvE2UUa+JjDDWE7Oz2ZygeoDGeu7LD5ZF4LZeSaK7CeyQb2/OqI
 qks7ciTRwoLKaZ+ROCzXJTQsqc3Ayh2797Ygv97r5W2s378+oOYdDPpqGUvy2JlejvOOX7
 vCVYm/d8hk5CZqLjmU9Z8o7HbDu+jSeEa7xmZ3Uphp2xC4EJSeAyj34WWiezYw==
Subject: [PATCH 00/10] bootstd: rauc: Fixes, partition name check and
 built-in boot command
Date: Thu, 29 Oct 2026 17:23:06 +0100
Message-Id: <20261029-main-v1-0-b5a878627107@kontron.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNL3dzEzDzdZONEC8ukVDND4xRTJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAMVqozhoAAAA
X-Change-ID: 20261029-main-c3a89be613d5
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3250;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=ajyeJ9WyFSgBGpgqXkQ6b0ZZ3WWN/g7rQsxI8YzrPdM=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetx0duIDskvrZKLp0sX7gxLeC6V+LhF7qdqTU3SAZmnb
 w7YndfpKGVhEONikBVTZJHit3htaxbrI3+sOgpmDisTyBAGLk4BmMgsPkaGPQfYV7NMt0swvseh
 N02nSshp/7469RbltTxbndRCGNY8ZGS4paXrlMf7ce+pozrCVa4R+TMa/rPuWCxr96Hb4kgvaz4
 HAA==
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
which was then passed to free() and aborted sandbox.

Patches 6 and 7 add two new options, both empty by default so that
nothing changes for existing users:

- CONFIG_BOOTMETH_RAUC_PART_NAMES sets the expected GPT names of the
  boot and root partitions of each slot. Without it, the bootmeth
  claims any MMC device whose partitions happen to fit the configured
  layout, such as a standard distro installed to eMMC, and writes its
  BOOT_ORDER and BOOT_x_LEFT variables to the environment. This allows
  to use BOOTMETH_RAUC safely alongside other bootmeths.

- CONFIG_BOOTMETH_RAUC_BOOTCMD sets a command built into U-Boot that
  boots the slot instead of running boot.scr from the boot partition.
  Nothing authenticates that partition, and signing the script is not
  a reliable fix, as the environment must stay writable for the RAUC
  variables and setting verify=no there skips all checks. With this
  option, U-Boot executes nothing from the boot partition.

Patches 8-10 add sandbox tests for both options. As partition names
need GPT, patch 8 adds GPT support to DiskHelper in fs_helper.py, which
the RAUC test image now uses.

checkpatch warns about the #ifdef in the tests in patches 9 and 10.
It is needed, as the string options do not exist without
CONFIG_BOOTMETH_RAUC and IS_ENABLED() cannot check a string.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Frieder Schrempf (10):
      bootstd: rauc: Initialise desc in distro_rauc_scan_parts()
      bootstd: rauc: Fix leak of the active slot name
      bootstd: rauc: Fix overflow of the BOOT_x_LEFT name buffer
      bootstd: rauc: Free the boot script of a failed boot attempt
      test: boot: Restore the bootdev order if the RAUC test fails
      bootstd: rauc: Optionally check the partition names
      bootstd: rauc: Optionally boot with a built-in command
      test: fs_helper: Support GPT in DiskHelper
      test: boot: Test the RAUC partition name check
      test: boot: Test the RAUC built-in boot command

 arch/sandbox/dts/test.dts    |   8 +++
 boot/Kconfig                 |  29 ++++++++
 boot/bootmeth_rauc.c         | 156 +++++++++++++++++++++++++++++++++++--------
 configs/sandbox_defconfig    |   3 +
 doc/develop/bootstd/rauc.rst |  15 +++++
 test/boot/bootflow.c         | 153 ++++++++++++++++++++++++++++++++++++++----
 test/py/tests/fs_helper.py   |  36 +++++++---
 test/py/tests/test_ut.py     |  26 +++++---
 8 files changed, 367 insertions(+), 59 deletions(-)
---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
change-id: 20261029-main-c3a89be613d5

Best regards,
--  
Frieder Schrempf <frieder.schrempf@kontron.de>

