Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99558606A335
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 03:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GM26rtFD;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kL8szI5D
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E11EC40D44;
	Fri, 13 Nov 2026 03:16:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jeBYzEhz99wk; Fri, 13 Nov 2026 03:16:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39ED2409BB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794539781;
	b=mNy93ZemWF7wyGA/fyeUjZbbavGJKGy81zFQfdjjuDgEz4o9oZ87V8V7DwSDki/Q2q/i
	 JvARU5qNTjBuIgx50I4yB8knMY3nFtaojVIGc2s/+Cxs7EJXCI1H6kGIpS/3Gwvy3syAu
	 /xGhLCMfZunvz7AeA10ZBeJeTimr0XFfiVCJVu4tEnOOWLXe6BB789kuq9rGa05hsgIW7
	 Ib2Y5SVlwykGQpQruU+83UvIITE6hwkJ6J7ZZbVHhfRRlhKHH1F2rRA6vgBJSuzhidhJ7
	 WJLgeI69WGQirL9HeuEaQ881f/ms5kZuHWh8eDpgOVrbbOFgp7ESx/XyCsunh2FSN3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794539781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xwOJvQQ+V3SQpR26IT5ZPLLsD7Q+QVLvaH18TUhYiX4=;
	b=Tb2Qzl3vzs60ldB9PyK8XH3uJ7GRirgca0wXf49N2kEcWPFlCQO3SWdEU7uUv5EVZXO+
	 tMpm66tfchYbMDNl7e76r2Ha95/vTiDx7iKYXs53SCD6/d4qKmwOCBGoKWQ/f+uNMcSa6
	 ipfF/sqC+j+zl0/6tLgt7/kuH0tbEh6rw9FI/VAkxProhEJfQKmv1rDSUOg3+/K2oExY0
	 hqyHTev0A/P7rpTq2FfH6elh8UB6FPWrk3LdPMTgWTOEzBdVdzThySJBwxcdvWB215oXX
	 Z1Y5us2uaoROwTTnVSejEYIXsUHJpknNSlZMO1huG7dAWztTLCrtgIECJfry1Un5u8A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794539781;
	bh=xwOJvQQ+V3SQpR26IT5ZPLLsD7Q+QVLvaH18TUhYiX4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GM26rtFDffGrfk72X4dzuOhhL4pTmjpFLqZJ+G8urfeFOGoWU7p0mMc78/scdgJAT
	 CFAbS5vSCfKA2TA3IJTS5GfKQymz7H4W6Nw7OAsrI6TEfjmDrE8Dkwbt3L314Sg1lA
	 FTtwEMlTiHEZF00H36em7VTzvliNKOynY0lpiSBqO6lRi1Tm5kKsCz0WOh5M01Bsr4
	 JjqnOy6xxAUYuoBC92Xcjhen1mFMYjlJDr+E3f8Hj/P9IIQB3Qop8YsHgihPVdFkpO
	 9YgkD56JDYrvsj2ueWDxecZOF6/tPLNOGYDjFDRtJ53H5NpMlgufGz5eR8GpwqmvFZ
	 ORSLx24HVfMbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39ED2409BB;
	Fri, 13 Nov 2026 03:16:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E6FBF46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 03:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BA41606CF
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 03:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UPvD7s8PT6zm for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 03:16:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 54B13606BA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=kL8szI5D
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54B13606BA
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 03:16:18 +0000 (UTC)
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-36dbde64409so833642eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 19:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794539778; x=1795144578;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xwOJvQQ+V3SQpR26IT5ZPLLsD7Q+QVLvaH18TUhYiX4=;
 b=kL8szI5DRqaimcAjAEOmQJwr23ZB1GxH/fevHL7Z9NF86S+T2lJZCkIRj4xeeXorbQ
 w2aCNeHPqsBu1p9hVriEjE2xnFjhVIlsTOHATq2Myt3oy8F7t4ZRSYHUX6HxTe/LZoN/
 H/MnIFq6zUy8zCU2l4eTilFlGPP6z/ZR64ggG/UwrQFYEbXqPUK8voAUFAWWOtyrJXI/
 IR3qdODgfmKcZ7L/c6jbfQby78opzwp5APJCwE8HLtv8Cr2Qko+wY3DO+eGLu8D890bo
 vII+Lx+FZRnHj3i+EnbNi/2YHvrLxDsl+3Nhy6R8yVYyd2ACBOZEyxTTtaqeyiTdnLM4
 gSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794539778; x=1795144578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xwOJvQQ+V3SQpR26IT5ZPLLsD7Q+QVLvaH18TUhYiX4=;
 b=lIjSo8FLQ5LBnNwSEUmtti/bWMnKViIlmc1JgK+GOu69RGN6jHV0kdE+8fHzbd1QSm
 KWYVN+BDImrNATuqvccesWAA7Q3Vxq7pNDfUJjmJSUVozL07+xNyqmmW0Qscwq7rkaoH
 FOVpUyuEqK7P1AXDmrH3Q+ayf8/EDkfi5e2mpSVIOq9yYxIHbQkBdzh0QCHz7dwGAeAu
 04JjjfanRHLOSEo2ox2VpWqFryCdEyTk1EdOl61HPk/AxD+z1f2FAhiao/80drk+Tz6F
 3kD0fCw9N1xRH09FhEqrNS9YEIYe7Gp41AsyxaX5xf25RRlLzmRcm3yaMb2LZL6orMtc
 3ScA==
X-Forwarded-Encrypted: i=1;
 AL+hErEYO4Wo8pA2Fb2srw94R1cj0kHJOOeEIdA+fr0ZDpj98McrbIQf0373HZIJRcZQOlspp0TZz30=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8j6L/yRKI96PnISyT0zNLlnS3025nfcWJpV9SXaMCPWDmAxDNz
 STNgiteCwmiCMSDD4eOz/syFNb4ZPcchXkbVEaLEnczycdlD7aXgXYT6nbIlRg==
X-Gm-Gg: AYBFou1p54L3Y0IBXferuXzF1UuShgTrzGKJkl5SjMLaCygemyeVxg+m9cD78RnmKgR
 CrgW0J03qWzM2zKWOtGzllvu5ilpOzB9AcbPWzMlFN2A/BK6+j8YpMg8LqR8Gy1vJ37bPh9v9cc
 xzV6RBXMidEo48koszL/wqy7UtpmaRbBCLDRQ6RPYiBOgYSnnVKQZ0as0Gt/ok5DUus7OYki+CA
 bkiFMv+v/wDFKBygMPwRD62sQeWKHPvyw9l1NDqNexWCg8aCCNl787HWcrT1GJ/4aGmbaYkOvBz
 AURYIpjA7tQSvmk67i3ppJBytc064zXGeTb1IdrdjELxn8z5QS4uPQYc0KAFzNhhkwgJsXmWTxu
 HGp3oo+863kGznpAWiKxzJJWSG+saiu5ewwXAT9QrGmWLZxgfokFhgQCquq0kbvUvQNU0Zk0caU
 LarbHOxk6VEs0RXPXoHBKm5ICwmUmcg7DhI5xXTeUtcG1hzeEwcaQZ7akUX0WmCG9O/X0OzVOer
 RGaB3GRy5t2f/R94dNqghVK+HnwuZ5M9WXu+Vs3HRV+k3oNZmGdIDhQ3aSYylz+9qiZRkIc1Zbq
 nbVPms2s8wDmDkm337wqiIjh/3Kk6v3TbuPJNL8roPLPsZOKN7XenHOOFjGG4qiS0B++WKU5VFY
 S5mmSv5UNk30/cyBslyBbgQpKfmQIGiVWaQPIVkFABCsvrlKcHLhc9aszBY86S8EO88zAXSPQlD
 /IDzedn/6WVRmqL7xl8WCHPBssZPzUYw==
X-Received: by 2002:a05:701b:4504:10b0:15c:1679:1cc7 with SMTP id
 a92af1059eb24-1b50313d80bmr1265607c88.37.1794539777662; 
 Thu, 12 Nov 2026 19:16:17 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b50313d990sm3864579c88.4.2026.11.12.19.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 19:16:17 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>, Alexey Charkov <alchark@flipper.net>,
 Guodong Xu <docular.xu@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 0/2] usb: onboard-hub: VL817 support for SpacemiT K1 boards
Date: Fri, 13 Nov 2026 11:16:11 +0800
Message-ID: <20261113031613.435429-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Milk-V Jupiter and the Banana Pi BPI-F3 put a VIA Labs VL817 hub in
front of all their USB ports. Its supply and reset are GPIOs, so
`usb start` only finds the root hub until someone powers the hub by
hand.

This adds the VL817 to the onboard hub driver and enables it for K1.

Tested on a Milk-V Jupiter, cold boot from SD: `usb start` finds both
VL817 hubs and a USB 3 stick at 5 Gb/s, with no manual GPIO setup.
That test capped DRAM at 4 GiB to avoid the K1 DRAM sizing bug, which
is now fixed in main by commit e6308cc14 ("spacemit: k1: drop the CS1
DRAM map on single-rank boards").

Changes in v2:
- Rebased on main.
- Added Zixian's Tested-by to 1/2.

v1: <20261026092432.769146-1-alan.tseng.cs@gmail.com>

Hung-Chun Tseng (2):
  usb: onboard-hub: Add support for VIA Labs VL817
  configs: spacemit_k1: Enable onboard USB hub support

 common/usb_onboard_hub.c      | 14 +++++++++++++-
 configs/spacemit_k1_defconfig |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.56.1

