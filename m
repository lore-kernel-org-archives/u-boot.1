Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7E0D4662B
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A1F83623;
	Thu, 15 Jan 2026 23:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="POeSMua6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B1183623; Thu, 15 Jan 2026 23:28:38 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB8A880077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7cfd95f77a3so687263a34.0
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 14:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768516114; x=1769120914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1nyMJDc1yZvduSuJRy+rv6D9sCMinpMuubJ21p4kJR8=;
 b=POeSMua6yhh6pyGi8dSpGMXIgQ/DQ0PWM2S51tjI49nhh3pr7fjfP0K1yCiaj5NsGv
 gdfoIALmthEisUKeRcSvhH+k94S5+EgVzg5F9dtICM885uRmh0cWa7mX4lM9C3xaPTEi
 OcIv+U7mfO/0/XyAzXiwl79u16pIIP1bTegV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516114; x=1769120914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nyMJDc1yZvduSuJRy+rv6D9sCMinpMuubJ21p4kJR8=;
 b=EjZKpjy6HfD3ICkXqCfIVU38tJbgBOb7fwtv5whBfzMtP+bYhVw622DXLq85oOlFUH
 Ns+jaMOZ3VXMVv+jtlDH1yVDLI3DT3ZP7SH1a+YDCsT3D2nlM54Inu6+BzPDu+jCCclR
 qVFcGzR8EwI5pysR8slmIJYqabwff8AoGE6YZci3DyLLhMli3dwkdNGwyxUZypR91tEu
 MicNukEKzZs3Yc1akQNvro+akHTskcuSea+CBu051xOCvtvBPYWZRNW3CCZQBaWbVQFc
 A55j842n/mQlty9/gyVrVxKzODhqkmAs9dnuIknGoK+h+LtRKHcYOtd+RWLu6+3ZGjWp
 +t4Q==
X-Gm-Message-State: AOJu0Yz5ebpouOhboDdgTuCc5zeg+NB995bURgIsPyReSuJ5aBsbNVg/
 ty4hb7kPcDhXflL4nxl5P78vVGVVC3GaqTUAmj3LokQbUF+mQsdgAXP5wl4NncXn4Y8VRSrGdCH
 FezjCXgE=
X-Gm-Gg: AY/fxX4zukzq9etFPelhHW9KndmPcPklK4wnh64o1gokSzAgrjXHXl0K9V+jrKZ7krl
 xfEVqGJmDkhE/Nu6iG2+DTvMd52LsxAGrNS6tTBsL5WdVQnw0P4SoLxOG0xomtH9yxKXCd5dBRq
 7e3oPlQ6VcOOT2sUHmOpG1TGXkeXFZ6Th0NQYB5JmNkkHcXh/zF9MAk/tXa1/O+Y6+V+qsYNrAd
 t3t8+k0KvjZkB4wHuHt4unFT1Kf9D+nP7ZLnWdoAsUV/U+QX28Z3QHn8GpgaHMFc+MgzDJ+9VMO
 BcUNYBItjUwDfVk7LaHX20GmtNNjHZrLX6E80yauL+j8+ozxUe7Wb7iWJLG4EvX65XJyDFVZcvz
 vcn4bcgduBkFpj9onlJnWqATvfiTb3PQxGXiL+hzwfF52erHmcx244YHV5IOLu96SpWEa15y3tg
 6saXr5wvEMy2/J9Re12Vvens0vM4AnF2Cgbo3VDvjm0Vy+kB9+wwCrlQMy9Xy9pkMpa1T/YAx/l
 SbIxjCKQS9sCnikBGZcyAah/Ss=
X-Received: by 2002:a05:6830:440c:b0:7c7:591a:7e91 with SMTP id
 46e09a7af769-7cfdfe21eb3mr345524a34.7.1768516114626; 
 Thu, 15 Jan 2026 14:28:34 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2b5aaesm544074a34.31.2026.01.15.14.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:28:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>
Subject: [PATCH 00/10] Update linker scripts to ensure appended device tree is
 correctly aligned
Date: Thu, 15 Jan 2026 16:19:30 -0600
Message-ID: <20260115222828.3931345-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Hey all,

This series builds on top of what Beleswar Padhi did in [1]. While
there's still discussion about the mkimage related parts, the linker
portion appears to the reliable path forward. An alternative that I had
mentioned before, and was part of previous discussions on this topic[2]
is in the end I believe not reliable enough. While we can take an output
file and pad it to where we think it needs to be, ultimately the linker
needs to place the symbol where we want it and if that isn't where we
pad to, we have a different problem. So what this series does (but each
commit message elaborates on the arch-specific linker scripts being
inconsistent) is make sure the linker script will place the required
symbol at 8-byte alignment, and then also use an ASSERT to fail the
build if this would not be true due to some unforseen event.

Given the number of platforms which have failure to run right now, I'd
like to pick up at least 2/2 of Beleswar's series as well as this series
early next week.

[1]: https://lore.kernel.org/u-boot/20260112101102.1417970-1-b-padhi@ti.com/
[2]: https://source.denx.de/u-boot/u-boot/-/issues/30

-- 
Tom

