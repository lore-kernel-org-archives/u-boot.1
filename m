Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF28CD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D74847AF;
	Sat, 23 May 2026 14:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="kJMalKJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1036384843; Sat, 23 May 2026 14:18:04 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0E3883E81
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8C002272E8;
 Sat, 23 May 2026 14:18:00 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ei2Y3d5jWoAZ; Sat, 23 May 2026 14:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779538680; bh=LE/aIPBwJs+ALsWL1vuFfJXTUb5eqeeuPMF1Sk5Cbws=;
 h=From:To:Cc:Subject:Date;
 b=kJMalKJNOWFQLGK1Sj0bcEe5R8yJOLM5EsmGV7ce42c+5h988TP8XkEv89VtnorYK
 gMcdP5AHzZGXBOY9Hl7lsEfLzkCaXGhspAZvcG7EDkpStY6Z8BgyKLpYNu21/dPRhy
 3dJP8ps18FlN6apopP4+8aQ+kJtzg8WbpiD/dZ8ReswPwT7bMSuCpGbZhwiIFWs88/
 vTBMlAWD27JY8hrtNo3hQnaSTOcU/2L+gkUdcNtS1G8cnsMpaukXSPzYXfIe5UwBP0
 da1mLB3RkMisKVzma5ZZkl1tC60rxtJiabfBrIbREfyG5aIjcFu7QKNuNt1q714st+
 6rXLMEzSKxf4g==
From: Josh Law <josh2@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/1] armv8: sec_firmware: validate loadables string list
Date: Sat, 23 May 2026 12:17:59 +0000
Message-ID: <20260523121801.9235-1-josh2@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi folks,

sec_firmware_check_copy_loadable() reads the loadables property with
fdt_getprop(), then walks it with strchr(). That works when the FIT is
well formed. If the property is malformed and the last string is missing
its trailing NUL, the walk can go past the property while looking for
the end of the entry.

The fix is to use the libfdt string list helpers for the walk. Missing
loadables still means there is nothing to copy. A malformed loadables
list now fails before any entry is used.

To check the bad case, I put a three byte loadables value with no
trailing NUL at the end of a readable page and ran the old strchr()
loop. It faults when strchr() crosses into the guard page. I also
checked the patched file still builds with:

  make O=/tmp/u-boot-sec-fw-build CROSS_COMPILE=aarch64-linux-gnu- \
       -j$(nproc) arch/arm/cpu/armv8/sec_firmware.o

I did not add the reproducer as a new test file. I couldn't find an
existing sec_firmware test harness, and adding one file for this single
case felt like churn. This is the standalone patch I used to check the
old loop. Save this as testbug.c:

  // SPDX-License-Identifier: GPL-2.0+
  #define _GNU_SOURCE
  #include <string.h>
  #include <sys/mman.h>
  #include <unistd.h>
  
  int main(void)
  {
  	const char *str;
  	long page;
  	char *area;
  	char *name;
  	int len = 3;
  
  	page = sysconf(_SC_PAGESIZE);
  	if (page <= 0)
  		return 1;
  
  	area = mmap(NULL, page * 2, PROT_READ | PROT_WRITE,
  		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  	if (area == MAP_FAILED)
  		return 1;
  	if (mprotect(area + page, page, PROT_NONE))
  		return 1;
  
  	name = area + page - len;
  	memcpy(name, "tee", len);
  
  	for (str = name; str && ((str - name) < len);
  	     str = strchr(str, '\0') + 1) {
  	}
  
  	return 0;
  }

Josh Law (1):
  armv8: sec_firmware: validate loadables string list

 arch/arm/cpu/armv8/sec_firmware.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

-- 
2.47.3
