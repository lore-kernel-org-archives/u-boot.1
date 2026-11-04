Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87B606A328
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wd2LJdsq;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Rl2EyrpL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77B4F810B7;
	Wed,  4 Nov 2026 09:41:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gz8RiPSBHD8u; Wed,  4 Nov 2026 09:41:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4892E8107E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785271;
	b=P/Wj2C6TyFvrp1swQKLNf6tz9b/3LB3jBO32jlplhpwfQ8Q46Wuh0EcWIeBxlWX56wiu
	 IltJCyS54z9q3Z5Q8HmFMkKwaOSrGKK0L8Nie/9KY+ool/1Xq+YleYqwuFRS1xrTTI1bI
	 L+5eBBvzmCnC4t7d8iqqPfMtJFLcxKEKzToMb7wrggD4wdoMUZ+2s1oRy/IBwvQMKi40c
	 fsoSmynZgyQDoEd8urAoqgNafj+IGNWDCB41M55RFxIWWaTvvrLhpZQBbM0EAnszYFo2o
	 O6f5drrM5TPz5NIpWVD5sOlH+Yt/Dhocb5Wcsul/0MNlEW/n2tUn31PvTwzz97qnSfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785271;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zgho7oK1RF1Ua4MsU5ZkVREW2Z/4/J7yxJsH8JQ3CkU=;
	b=SKoul+GCqOwWfVKbEccvXbHl0XHUOe8Kv36FHI6ErcDAMfr2dE2QZBrhYf83b8uf11we
	 6hcvL4lg5FCWzForGgTbkFr0yXXIXcy2607nD12TmryNB/4YwGPTQ58BDXXdekD7bvhgX
	 KbK+9Yq6U/TmzoMX1TolvOKqLT7G/isdPrvJvBIw/W0kOFaysThwSPV5m9BqyPBYJ2hZa
	 gyEWLOXZulftEVijny3BIfx4uuMG0W3t621oEamA1klVH8uqxC1E7V+1FEKukFULHK6B7
	 RXMVbfGZ8dCnZU8AnOl4w/W2tSB9Mbl2L7IYrMygx6gZsVjb2aTnQZYZ2B0lGT+uc3w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785271;
	bh=zgho7oK1RF1Ua4MsU5ZkVREW2Z/4/J7yxJsH8JQ3CkU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wd2LJdsqLTP44RK5/7+WmWoVdm/CSYLItrYzevKUNfgQeVwG0iOpOpvzwf5gnuAll
	 Ho8diXp063aY2g0wVApfWhd9IT2umkoAybi2gL75D7LyAn9RfVtSUT1xWmFOrMuQIa
	 v6UvKq4+ASbLcTKIWjhRPZLHoGekDZ2U+iJDWKHXNjFl2f3ngZlKZU4lEZiTIRh4py
	 S9DuPuGgqUhjJa1nuE7NbLFUZOijuazxTUzmma2g25tZQrQ1xydMeap249bzTbReIf
	 l/KLMP2/GBgHgihbGOP5ButQr+wYF8UjSy0LRWHE+zxurSHjfcEBzmzRW5hLQSVwik
	 sbeNZSBIL+SeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4892E8107E;
	Wed,  4 Nov 2026 09:41:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BCD932B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE9B1402C5
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:41:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id quXUBsCrU_Uj for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:41:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ADFD04004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785261;
 b=CFKvt2JKmVxqD3CgHzZXEEmCFArfx3D4lkYjktV2ziggH74QrdIBKlgivIFAxQOsojUN
 g7lIxXSwizcr89Pu1k/gDU7GLRJMsf9euFwqwZMZciDcCulumEMqLiDNXPh71mwviMN0k
 1fXD+NC1n+rsZTM1USD8y9EMhDwhWhdzdn7Ql5gTrOJXTl3q+XJBgixU/oMErvIsKfP0X
 WhzfdO6g+zQC0qsYK0GxabgvNbF1BeqWSp4sTfXPvoVSNqb9thISmL53iZtcLmqcjLAVt
 pe97Io/VHu4huKyXqCFK5j2gpcAPpjRI5VbPRKUHPTuLuDYpt+PZDhvNHoyFtoxR2bA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785261;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=zgho7oK1RF1Ua4MsU5ZkVREW2Z/4/J7yxJsH8JQ3CkU=;
 b=dTEeVuqxmQIlUinVIA2Pf5WbikICGrhimZ5HzJST031NF39YtkAKzWo/LzrFnzD9bgiZ
 vyj3U4sC2r90V5qjoBhGzuMIY18Jcv1c9Ivan5u8IYWJoyA6m/Mg94DbA+9KesJBaXRrq
 Y5Tt5NfMKNAjjuXZdl6L4iuwW41Pf/ecCyj8ovMe6VYssHWixbs4VI15/J8wrod0Sob8b
 G/AgLXPA0vSdDWNx3JpK6BGcAGEk95wc7nah2sM7CpY4Liu5gOOIvbggRg6lrpbNBWaQU
 4OaD62Yksv8zRLJzuqMHtId6X2P/DIcbHy0TIR+a2juDdETBOnTy5dMpyam71Wt/2KQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Rl2EyrpL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Rl2EyrpL
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADFD04004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:41:00 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a4dc547987so2175455e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785258; x=1794390058;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zgho7oK1RF1Ua4MsU5ZkVREW2Z/4/J7yxJsH8JQ3CkU=;
 b=Rl2EyrpLAqM3t4T4GQ/BokW2EoFzIYmxPjfCvjEr2m1/teSsqbLNBIx9CPhLFCOn0v
 bPBpWXH8GY+rdCIzXb0vOWKSTAf6Mq7G0nhPY4Z6vqOaSxTnyOMqRrsk4N0J4m136/dJ
 DtRJCLJSYZpWGpnXijOUOCywEDB+hkHXSX7cVtXAHPawbW55wXPWkGbsj6ZIY3DRZj19
 5oZngD7LuKBix/kyGoBjy+veeIodsdTAKdW28PVtFN83hrqEClCWQiPFl4j2jWottUI0
 uPNylKgFbsOwBKpSO4p0L4EkAF4Vtza10vp+Ku5Kxs4+cyTp+gAwTlK3Nq7kvCj0GKyF
 OFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785258; x=1794390058;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zgho7oK1RF1Ua4MsU5ZkVREW2Z/4/J7yxJsH8JQ3CkU=;
 b=k3I3IvljBpV+xKBqvReahH4gDiqiphz50gl0Z/wn6BNJNte1kAR989I29lxn2zE7S0
 syF+6QvwCOUKqGsEvqBc3CGsLusFLGKr83XODoZSOZYdAx0ig/2Eqe6v7dT5STbsg/ri
 aSQp3TKRq5DzmyG4gubnmWUgQcm737ajO5VGYs+TwGPAV5pACvaJTWI3t9Is3pEI3/Ky
 AeuWqAgvMywKsybsv+NNJpheP0kMI+P4WY+eBE+nXgx6Ij2uyPHJuovKmaHXa/ELzgbV
 R5UU8enx+dqZfzMJ+hgAjn4sZu3+MzvgAIO1S+pr5pGuGoAGJCtNV9zdpfQ6kQJvFV0j
 lwCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTAkoeLbVrVxE4bSeUVN1kYFBw7ND1tXV5MJdCsAMHYaghhFirGd/fAnPjL84tdmPhkK39TzU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/PoRxs7UoXo1fvJ/AJ2vmDLiG2u0PQ+qyIsdS9UAKZTuAn7bkc
 IubfLbXbhFY4CxNOUQ2hGQyyT7wI1f4iIcn7hIv4mgQkB1VUqjNo6JLTvOKmyn7M2O4=
X-Gm-Gg: AYBFou2IHW8SoRgw2vzI2hvEq4e+JaPhKshF4jH7SZbgJD8q1B6JskukP5WQmgx/Hxt
 TecOn14UXpuiSM7OlE5PkXdOea5gZSanSmdgdwAWYLfVMylceux3HOL7iWoVixuieCYjlnbbO2K
 xuIJCICw6tnoQmc4/cEd+1C4qHLkoWSxueOajnDrEHOVRsWyhPbA5SWxr4Q32yaLcqBiH2jz1NF
 xB2SrUkn3PJLyPMrVaBLNTvxAheMyZOMsODyjzUUHy+bkQ53c2/yY3h1yyiPItMMwvr20fSNB5B
 2rnnFdbKntZ/60cz8BMGQDU18LwbaaxLEeOq4Q9Rpv2GpiVmf+lszGNK6bsBskgRGyxZ27ZKcvL
 sYak+vIKy37YKQ4PxwvfbgXhmo1oLBaYq3EytcTe44WpKbel1IIuNGsucUcCUA+38qi3PJrEYpX
 CfehzrYgbYz1yAqyeFXl8PgHE0NC5EnfL9C+bQDHeuX+xpGtcPSy6hRvxy8ZUtgneYfX7qrW46w
 bMz7OTIS/dXP9NtOxHqDZSy9Dzmntf6Gk/N94fMmA1b/IEtIT0IC9WMQyx3MHvXa1al0KEaJW4I
 Giwz6YaNu735/YaBJVUgLlnoM7utEwevWwe3yvKqSkt2vnqiEYDb1utYEI7BEPcOdD2h8wHu7FI
 S3XL5k8VDTB7xOCoSfmP5ZUHUX0jjMHvzjjEhuiUU0BAj3w==
X-Received: by 2002:a05:600c:3547:b0:4a1:e69d:90e8 with SMTP id
 5b1f17b1804b1-4ac1889d442mr356596445e9.22.1793785258273; 
 Wed, 04 Nov 2026 01:40:58 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4527fed5bsm49856945e9.3.2026.11.04.01.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:40:57 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 04 Nov 2026 10:40:24 +0100
Subject: [PATCH v2 4/7] spl: ram: allow loading FIT images from a supplied
 buffer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ccaione-upstream-spl-fastboot-boot-v2-4-cf9781441ed5@baylibre.com>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
In-Reply-To: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
To: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 u-boot@lists.u-boot-project.org, Sebastian Siewior <bigeasy@linutronix.de>,
 Rob Herring <robh@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RAM FIT loading currently assumes a configured image address. Downloaded
images need the same loader with a caller-provided buffer and length so
reads cannot run beyond the received data.

Expose a reusable RAM FIT loader with header validation, bounded reads
and overlap-safe copying. Keep preloaded images working when their buffer
size is unknown. Add tests for embedded and external FIT data.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 MAINTAINERS           |  1 +
 common/spl/spl_ram.c  | 44 ++++++++++++++++++++++++++------------------
 include/spl.h         |  9 +++++++++
 test/image/Kconfig    |  9 +++++++++
 test/image/Makefile   |  1 +
 test/image/spl_load.c |  4 +++-
 test/image/spl_ram.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 97 insertions(+), 19 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ae3e9819d45..ad224d913ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1933,5 +1933,6 @@ Q:	http://patchwork.ozlabs.org/project/uboot/list/
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	configs/tools-only_defconfig
+F:	test/image/spl_ram.c
 F:	*
 F:	*/
diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 0c501cf02f2..22aa025fb5b 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -16,32 +16,42 @@
 #include <spl.h>
 #include <linux/libfdt.h>
 
+struct spl_ram_image {
+	const void *data;
+	size_t size;
+};
+
 static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
 			       ulong count, void *buf)
 {
-	ulong addr = 0;
+	struct spl_ram_image *image = load->priv;
 
 	debug("%s: sector %lx, count %lx, buf %lx\n",
 	      __func__, sector, count, (ulong)buf);
 
-	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
-		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
-				      CONFIG_SPL_LOAD_FIT_ADDRESS);
+	if (sector >= image->size)
+		return 0;
+	count = min_t(ulong, count, image->size - sector);
+	memmove(buf, image->data + sector, count);
+	return count;
+}
 
-#ifdef	CONFIG_SPL_PCI_DFU
-		if (spl_boot_device() == BOOT_DEVICE_PCIE)
-			addr = CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
-#endif
-	}
-	addr += sector;
-	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD))
-		addr += image_load_offset;
+int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size)
+{
+	struct spl_ram_image image = { .data = fit, .size = size };
+	struct spl_load_info load;
 
-	memcpy(buf, (void *)addr, count);
+	if (!CONFIG_IS_ENABLED(LOAD_FIT))
+		return -EOPNOTSUPP;
+	if (size < sizeof(struct fdt_header) || fdt_check_header(fit) ||
+	    fdt_totalsize(fit) > size)
+		return -EINVAL;
 
-	return count;
+	spl_load_init(&load, spl_ram_load_read, &image, 1);
+	return spl_load_simple_fit(spl_image, &load, 0, fit);
 }
 
+#if CONFIG_IS_ENABLED(RAM_SUPPORT)
 static int spl_ram_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
@@ -81,11 +91,8 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
 	    image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
 		debug("Found FIT\n");
-		spl_load_init(&load, spl_ram_load_read, NULL, 1);
-		ret = spl_load_simple_fit(spl_image, &load, 0, header);
+		ret = spl_ram_load_fit(spl_image, header, SIZE_MAX);
 	} else {
 		ulong u_boot_pos = spl_get_image_pos();
 
@@ -120,3 +127,4 @@ SPL_LOAD_IMAGE_METHOD("DFU", 0, BOOT_DEVICE_DFU, spl_ram_load_image);
 #if CONFIG_IS_ENABLED(PCI_DFU)
 SPL_LOAD_IMAGE_METHOD("PCIE", 0, BOOT_DEVICE_PCIE, spl_ram_load_image);
 #endif
+#endif
diff --git a/include/spl.h b/include/spl.h
index 390d18fd9d5..f884c24b85e 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -989,6 +989,15 @@ bool spl_was_boot_source(void);
  */
 int spl_dfu_cmd(int usbctrl, char *dfu_alt_info, char *interface, char *devstr);
 
+/**
+ * spl_ram_load_fit() - Load a FIT from a RAM buffer
+ * @spl_image: Receives the loaded image information
+ * @fit: FIT image, including any external data
+ * @size: Buffer size, or SIZE_MAX for a preloaded image of unknown size
+ * Return: 0 on success, or a negative error code
+ */
+int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size);
+
 /**
  * spl_mmc_clear_cache() - Clear cached MMC devices
  *
diff --git a/test/image/Kconfig b/test/image/Kconfig
index 45b6e8c52e6..1cb8337e0f4 100644
--- a/test/image/Kconfig
+++ b/test/image/Kconfig
@@ -41,6 +41,15 @@ config SPL_UT_LOAD_NET
 	help
 	  Test loading images over TFTP using the NET image load method.
 
+config SPL_UT_LOAD_RAM
+	bool "Test loading images from RAM"
+	depends on SANDBOX && SPL_LOAD_FIT
+	select SPL_RAM_SUPPORT
+	default y
+	help
+	  Test loading FIT images from a RAM buffer, including images with
+	  embedded and external payloads.
+
 config SPL_UT_LOAD_SPI
 	bool "Test loading from SPI Flash"
 	depends on SANDBOX && SPL_OF_REAL
diff --git a/test/image/Makefile b/test/image/Makefile
index 11ed25734e8..feca0611fcf 100644
--- a/test/image/Makefile
+++ b/test/image/Makefile
@@ -7,5 +7,6 @@ obj-$(CONFIG_SPL_UT_LOAD_FS) += spl_load_fs.o
 obj-$(CONFIG_SPL_UT_LOAD_NAND) += spl_load_nand.o
 obj-$(CONFIG_SPL_UT_LOAD_NET) += spl_load_net.o
 obj-$(CONFIG_SPL_NOR_SUPPORT) += spl_load_nor.o
+obj-$(CONFIG_SPL_UT_LOAD_RAM) += spl_ram.o
 obj-$(CONFIG_SPL_UT_LOAD_OS) += spl_load_os.o
 obj-$(CONFIG_SPL_UT_LOAD_SPI) += spl_load_spi.o
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 166cf331194..0e3bc0d6caa 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -163,7 +163,9 @@ static size_t start_fit(void *dst, size_t fit_size, size_t data_size,
 static size_t create_fit(void *dst, struct spl_image_info *spl_image,
 			 size_t *data_offset, bool external)
 {
-	size_t prop_size = 596, total_size = prop_size + spl_image->size;
+	/* Both the image and configuration have a description. */
+	size_t prop_size = ALIGN(596 + 2 * (strlen(spl_image->name) + 1), 4);
+	size_t total_size = prop_size + spl_image->size;
 	size_t off, size;
 
 	if (external) {
diff --git a/test/image/spl_ram.c b/test/image/spl_ram.c
new file mode 100644
index 00000000000..5874ac02a3a
--- /dev/null
+++ b/test/image/spl_ram.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com> */
+
+#include <image.h>
+#include <mapmem.h>
+#include <spl.h>
+#include <test/spl.h>
+#include <test/ut.h>
+
+static int check_ram_image(struct unit_test_state *uts, void *image, size_t size,
+			   struct spl_image_info *expected, const void *data)
+{
+	struct spl_image_info loaded = {};
+
+	ut_assertok(spl_ram_load_fit(&loaded, image, size));
+	ut_assertok(check_image_info(uts, expected, &loaded));
+	ut_asserteq_mem(data, map_sysmem(loaded.load_addr, loaded.size), loaded.size);
+	return 0;
+}
+
+static int spl_test_ram(struct unit_test_state *uts, const char *name,
+			enum spl_test_image type)
+{
+	struct spl_image_info info = { .name = name, .size = SPL_TEST_DATA_SIZE };
+	size_t size, offset;
+	void *image;
+	int ret;
+
+	size = create_image(NULL, type, &info, &offset);
+	ut_assert(size);
+	image = calloc(1, size);
+	ut_assertnonnull(image);
+	generate_data(image + offset, info.size, name);
+	if (create_image(image, type, &info, NULL) != size) {
+		free(image);
+		return -EINVAL;
+	}
+	if (type == FIT_INTERNAL)
+		size = fdt_totalsize(image);
+	ret = check_ram_image(uts, image, size, &info, image + offset);
+	if (!ret)
+		ret = check_ram_image(uts, image, SIZE_MAX, &info, image + offset);
+	free(image);
+	return ret;
+}
+
+SPL_IMG_TEST(spl_test_ram, FIT_INTERNAL, 0);
+SPL_IMG_TEST(spl_test_ram, FIT_EXTERNAL, 0);

-- 
2.56.0

