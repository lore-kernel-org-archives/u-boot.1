Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E4606D802
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I16nBPcI;
	dkim=pass (1024-bit key, unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=JbmiXWWf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD03860778;
	Tue,  3 Nov 2026 09:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1swIX2XSjj0Y; Tue,  3 Nov 2026 09:53:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ADC1F606E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793699629;
	b=rkB71rvUVV4GPEjV5Rxer12hNcIpU/1S0HmBkMTMMvr3W0iJbALEZ21QsmWEKHFBBkBS
	 jwHQNe68B2bHxkuhp4mZ0iNOdqvfezJazYy6ZSBcTY+60RV0Tf2m1lAgfgFBq0bSaJlEF
	 En/SW8FADjfet6asDepJJaURNxwQy17AcmFkk4bub/Cy6uGuOVcbxZFe5kx0mQZ8QdYR8
	 8FHLIM9M/cMNF5lTBhZ1Mn92REmiF4JVBWNtVVHzbxtfIkOEiMuXaUYZfLw8LRjSp+kKR
	 6f9Gr1vI3Rr+Xz2RKbsvvyfaZ+FrJ3aLo+G4flncwi5GxZDlQ0YPE3FGBaEQouRNE3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793699629;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:X-Yandex-Fwd:DKIM-Signature:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=w7YF7FRhmWlLWlmdAvZMV4YWUds2sTQ/llVF2XxQMjQ=;
	b=PbLgzsrvEqlD2SDQWzKGMXVeh1NFEbts8X/FKm4GMkNN5XWZzj+5IthGZcimG2l/jxSK
	 A8DhryJ4Oruw0spY/u/Hl/UIcmnEBivouCR5LqPLB4Pbm2DtmU1SuJKIABxaElYjJvrde
	 9UzDXqEZ9kN4WrCxySRK7znvu9VfvBUKRQr1KWl6FgXDpnSER5f1fFyg3KBBLorbsk1Ym
	 IgiSI71BPIQGj497B2Oa/zcQ+cLBZi/FNfMDXPu0f/V0DzIUZ8+UHoER15OjCea8W5Wsp
	 dYjR+wd3m5j8n23Lc9osuRQghzksmQU0EhnWV69it20qnxNrg59vJwhPOO/OF8KqzJA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=maquefel.me;
	dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256 header.s=mail header.b=JbmiXWWf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793699629;
	bh=w7YF7FRhmWlLWlmdAvZMV4YWUds2sTQ/llVF2XxQMjQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I16nBPcIrZBjHTCepYCbpVnp3JS/GEsgolWC0rDhDd3g6qK8GoqMVBlbaoXhPbBQh
	 SWRYVQxkuvQ6JNIzZn3KVL76ZOnmFt+3lsHMUg+5bxcp9HUb672ObxajiyRk/3QUzC
	 BSckXdjQQ8rxz8IkpjHBb8qD5NqQ7ekZ7QcaLjvWJctB7NNMlxfjRXGERuwJehkPOh
	 Jz79AYJ8c8EaT+WpxlwCh9AoQXeqy7AZJ7e7mJWaS4OpxYY+q9iFUOF8DhE4o5HIvZ
	 mhVlHmngqEVQ3LEogNTttthgLWcHP4W8P0ROgMwp3OahjLocXCDPSymValDM2uuSuA
	 due90xkRY/KMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADC1F606E9;
	Tue,  3 Nov 2026 09:53:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F0013D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0EE8606E9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AjSNpAqKjEzp for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:53:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A4C9E606A2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.154.239.218
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699623;
 b=cq73GNWRU7sVIkD96Utl5RaknkaCCKUOzA+4r7f56+E/fdbaKIifLdnwwa6wbthfWCJ1
 jvJmwXjgKVJRWCYh1QxZOEUhT1NTL5A9CSJiacxTUsjR2LWvM9otxGGPz2CQIzM5UuPLr
 vKBM+1SWWnQVOy9Kuy4LZLsOm+04nyg4idS+XrjGMHUaYD50OlxSjvRv+6ie5oDBXhMR7
 PiayPLnv7rLRbB4GrhZOKS4l+9GjdgjfQ0KpuAA6bu5BQVRbr0lBervpw9VCR9SrIPOXi
 N8v/6CFVTJXmtFox+zz3PzmxAwpOmIsJkxDikwFhCRKU7/I+uvdzFfjEQopubBVAQ/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699623;
 h=Received-SPF:Received:Received:Received:X-Yandex-Fwd:DKIM-Signature:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=w7YF7FRhmWlLWlmdAvZMV4YWUds2sTQ/llVF2XxQMjQ=;
 b=FzlbqhRlrbYI+Owms9xxeZRD2IkInUf2gV0TCCb9ZAMfd10SKSg5NPwXeP5N1EBHdOIn
 tgWOe+UsYaXk1UYJuKBT6LqT+BulTFOkSp+mEYvSn6o4/udxznM+gkbz6NS4zqzcHfl7q
 tXF/4/6CURDzzB74jGmPLm3jgjGt0gClSnK/zAd0bTjyokuWeXIxx9tcGMAb5Em50kXOa
 MhxHnnJLsX0tLSOwPZe8c55ZGMIrPWtIvOPWOO+KfTWg2uff5NFqlevyD34FRhLbK/VM6
 ZzSBZTb3GKHXxlJhXcbhO4g8QW9f1b0uUWWYUHVptliIamvtLTZcWukBaOo9/xol20Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=maquefel.me;
 dkim=pass header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=JbmiXWWf; 
 arc=none smtp.remote-ip=178.154.239.218
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.154.239.218;
 helo=forward203d.mail.yandex.net; envelope-from=nikita.shubin@maquefel.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me
 header.a=rsa-sha256 header.s=mail header.b=JbmiXWWf
Received: from forward203d.mail.yandex.net (forward203d.mail.yandex.net
 [178.154.239.218])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4C9E606A2
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:53:43 +0000 (UTC)
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
 by forward203d.mail.yandex.net (postfix) with ESMTPS id 9024C8C84A
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 12:53:38 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-70
 (mail-nwsmtp-smtp-production-main-70.yp-c.yandex.net)
 by forward101d.mail.yandex.net (postfix) with ESMTPS id 8315EC00B7;
 Tue, 03 Nov 2026 12:53:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70 with ESMTPSA id
 OrH94I7pRiE0-qcw3BcOk; Tue, 03 Nov 2026 12:53:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1793699605; bh=w7YF7FRhmWlLWlmdAvZMV4YWUds2sTQ/llVF2XxQMjQ=;
 h=Cc:To:Message-Id:Date:Subject:From;
 b=JbmiXWWfB66eTPAMlGktigyxeJwn89Ubzh0Js2lm3jxc7GhyOvrDKVxTfsI9BSn88
 Iu1IQZEtPoSQjCjSiW2x0V4bcRgGiB6l6XjHC9BNDrqLdWDPPlihPKQt0RpunHYBmt
 10XaLx2APmCmWmibhbmMV6RErjhqD2OQuOEzKsTE=
Authentication-Results: mail-nwsmtp-smtp-production-main-70;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
Subject: [PATCH v3 0/6] RISC-V SPL: fix OpenSBI FULL FIT loading
Date: Tue, 03 Nov 2026 12:52:59 +0300
Message-Id: <20261103-riscv-full-fit-support-v3-0-e1dcdc9638e5@maquefel.me>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNOQ7CMBQFr4JcY+QlkJiKeyAK43wTo2x4EyjK3
 bGTAlGkHOm9mQk5sAYcOu8mZCEaZ4Y+Ad/vkGpk/wBs6sSIEXYiJafYGqci1qFtsTYeuzCOg/W
 YM1LzSlecUkDpPFrQ5r2Ir7eVXbg/Qflsy4vGOD/Yz1KONO/WSEXKrUikmGBGJS90KRQ/kksnX
 wE0tIcOUM5E9hMJwjZFLIkKwUGQQlIm4F80z/MXpjnRyRkBAAA=
X-Change-ID: 20260731-riscv-full-fit-support-320d38f8311e
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793699606; l=4799;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=YcUFk+/UCF00r0cxO5hJUVl42OTr0xb2XqPkE5iC3+A=;
 b=wVMPInjvwe3jLTM/WtDnlWJJaccc8p5gu7Op5HfmdH11VtgLDpzxrTGRlx/S0T+B9AUIJf1d5
 juf1xD3m2u1CnKh7va9AoF+XLJoCXk/WnHqSdBbAnxr6n3zLJLp3VH3
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
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
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

This series improves CONFIG_SPL_LOAD_FIT_FULL support on RISC-V, primarily to enable loading OpenSBI as firmware and recording loadable images (e.g., U-Boot) into the FDT passed to the next boot stage. This aligns spl_load_fit_image() with the behaviour already present in spl_load_simple_fit().

Patch summary:

1/6: Allow IH_OS_OPENSBI in fit_image_load() so OpenSBI firmware can be loaded without error.

2/6: Enable spl_load_fit_image() for RAM boot when CONFIG_SPL_LOAD_FIT_FULL is selected.

3/6: Use map_sysmem() for FDT address handling to keep the code sandbox‑friendly.

4/6: Initialize spl_image_info in spl_test_load()/spl_test_load_fit_full().

5/6: Record loadables into spl_image->fdt_addr during FIT load, providing the entry addresses needed by subsequent stages (e.g., OpenSBI).

6/6: Add a unit test to verify that loadables are correctly recorded in the FDT.

Tested with provided sandbox test with a grafted FIT image containing OpenSBI (firmware), U‑Boot (loadable) and a DTB.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Changes in v3:
Rebased onto v2027.01-rc1.

Addressed review comments from Simon Glass:

- Patch 2/6: common: spl: ram: Add LOAD_FIT_FULL support:
  - Dropped the local 'ret' that shadowed the outer one and could make
    spl_ram_load_image() report success after both loaders failed
  - Return 0 straight away when the full loader succeeds

- Patch 4/6: test: spl: Zero spl_image_info:
  - Explained in the commit message why zeroing is needed (the next patch
    checks spl_image->fdt_addr)
  - Used memset(), as board_init_r() does
  - "inited" -> "initialised"

- Patch 5/6: spl: fit: Record loadables to spl_image->fdt_addr:
  - Wrapped lines over 80 columns
  - Added a comment for fit_record_loadable()
  - Dropped the "record_loadable:" prefix, log_debug() shows the function
  - Kept the error message on one line and added the error code

- Collected Reviewed-by from Simon Glass for patch 6/6

Other changes:

- Patch 6/6: spl: fit: Add test to check loadables:
  - Fixed argument alignment of create_firmware_fit() call reported by
    checkpatch

- Link to v2: https://lore.kernel.org/r/20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me

Changes in v2:

Addressed all review comments from Simon Glass:

- Patch 2/6: common: spl: ram: Add LOAD_FIT_FULL support:
  - Reworded commit message to explain that FULL parser is needed for full image verification (CONFIG_SPL_FIT_FULL_CHECK)
  - Added fallback: if spl_load_fit_image() fails, try spl_load_simple_fit()
  - Mentioned fallback behavior in commit message
 
- Patch 4/6: test: spl: Zero spl_image_info:
  - New patch added to zero-initialize spl_image_info structures in tests

- Patch 5/6: spl: fit: Record loadables to spl_image->fdt_addr
  - Fixed typo: "lodable" → "loadable" (subject, commit message, code)
  - Replaced -1 with FDT_ERROR (from image.h) for missing entry point
  - Moved FDT size adjustment before loop: use fdt_shrink_to_minimum() once instead of fdt_increase_size() per iteration
  - Extracted duplicated code into helper function fit_record_loadable()
  - Replaced debug() with log_debug()
  - Removed backslashes from debug string concatenation
  - Added note about gd->fdt_blob limitation in commit message
 
- Patch 6/6: spl: fit: Add test to check loadables
  - Fixed typo: "lodables" → "loadables" (subject, commit message)
  - Removed unused variables (uname, str)
  - Added FDT size fix after fdt_finish() to prevent external data offset drift
  - Replaced #address-cells = 2 with ADDRESS_CELLS macro
  - Replaced fdt_property_u64() with fdt_property_addr() for entry/load properties
  - Extracted duplicated image node creation into helper append_fit_node()
  - Fixed assertion: ut_assert(noffset > 0) instead of ut_assert(noffset)

- Link to v1: https://patch.msgid.link/20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me

---
Nikita Shubin (6):
      image: fit: allow IH_OS_OPENSBI in fit_image_load()
      common: spl: ram: Add LOAD_FIT_FULL support
      spl: fit: Use map_sysmem() with buffers for fdt address
      test: spl: Zero spl_image_info
      spl: fit: Record loadables to spl_image->fdt_addr
      spl: fit: Add test to check loadables

 boot/image-fit.c         |   1 +
 common/spl/spl_fit.c     |  84 ++++++++++++++++-----
 common/spl/spl_ram.c     |   7 ++
 test/image/spl_load.c    | 185 +++++++++++++++++++++++++++++++++++++++++++++++
 test/image/spl_load_os.c |   2 +
 5 files changed, 261 insertions(+), 18 deletions(-)
---
base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
change-id: 20260731-riscv-full-fit-support-320d38f8311e

Best regards,
-- 
Nikita Shubin

