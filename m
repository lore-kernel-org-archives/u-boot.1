Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D47BC982D1
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 17:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BECF8309A;
	Fri, 16 Jan 2026 18:09:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DvkacYxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B3BF838BB; Fri, 16 Jan 2026 18:09:57 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A21582BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 18:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-64d02c01865so3839880a12.1
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768583394; x=1769188194; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LdP6mB0RcGji/aSDOyDLVL1CFMXWyNjG2HdQNliAbLU=;
 b=DvkacYxL1z/tWi3u+Ma1fFB8OlNNNToqSQxe976A0EMUTBSJ4t9kTD3CxkgHQyNhB3
 eCOC9RAuVRLtt97PRTYCZTLfaEHfOaPsV/uv4w+ZJ4ePbYCKduUrOkGXPWCDrepvLSdo
 PSiBopn3vSfZmhP1GabZn+h8RdpxwN/gWB9D2hBoMdY8pmzA0qJ5wQ0AgffbMtBvgGm2
 KpnLLSeehonEmA+ZH9vIyhNq4+Nx5gwnX3xI55Vo2SOj/H2XLuNZVERz9YcnPgpUqn6m
 S50gQJbUU/AKOzduDx8/J+s3+uXNn2vUCagOzxCLiI1zrNTwDjsCmfjL5fqwXL9GdTf0
 S5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768583394; x=1769188194;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdP6mB0RcGji/aSDOyDLVL1CFMXWyNjG2HdQNliAbLU=;
 b=v0aDxvmYWMv6C8rwndmq0psqB7sCooAXhWRbDbc0ui/hXVs/5CCLRCeqs0wVuwCa1O
 wcXgV/fPqpqVVo0E0C6z1MbU/udK4idsdaweXvb4D2zEbJ8aEl05N6eucHxwdcpUktVv
 bo2lPyoqkLLMA/MnmiRPhR6HJCS2KlnTYkdWrSOskjyia/NYi9+NOpCce/i+iIcC57jZ
 VGKW9vvPhLIkD/CrqEukZ2rv/vaBNRzP54BPX1Q7JZNvi+21IqEwnJ3Usjc9iSaoBByj
 g1Te47FfzDuKEx7u9Q754LXCz7CyPjU87d7bLEVoDvMxWsvz1aXVUW0jst7G4pjc+G6D
 VSfA==
X-Gm-Message-State: AOJu0Yx7Rx+QLE7vxwAiSK3PHSdwuW6LplO8AlYWFsg/IIv2oZVcOZno
 ZHyO6r4bcPtyAOdPyRYdQ0raOiqDPNzyOiFj0PicyMVPj2oFEXN1iYUx6ZB+qrGYgpA=
X-Gm-Gg: AY/fxX6md0BQ1uEKeMny2LkjZuQkD5enRByXD6nlKHCf6T1SbNLooc3KbP9jZVF9UeM
 oy5VHhzd3RCfu97IpnQj2RdZ6xywjvQBhrR90x4kVOHla6lMPOnORkgkLXESunUv1OlE7366gA9
 2uVC2ALmAcwSuvZTWvxtWKkQ2Flf+mfDwSm7ihBKbQTgL1PRJBj83DZJMcGSclqLA7pkYEoKgXW
 KxdsuUcXLIynnSMVMaXboKsz1LK+X24ns9Y2EEf6WQ+wMuNHrlmD1ZLox5rmQlkoV0PmnrV+gB0
 mmzGHJJreqehJ1fCsvDmbHaXkSzSz0Slp+WVT4c0hoBBVR6N+nNDXqNHY1KOmSf5MeSAcpe4tLT
 ktnKIcrLmadPhTTZu4siLK49CQWkvYI8e32vXFwkf/HZ3RAv/BiljLof0tjOwokvHuXqtvXwwLY
 oNqZ880aSPmfUxA3iZlpI11hOP3A1h9vbGAxs4+Q/DbWTx8pQNH8STTA==
X-Received: by 2002:a17:907:cd0d:b0:b83:a32f:8106 with SMTP id
 a640c23a62f3a-b8796b3746amr311229266b.46.1768583393950; 
 Fri, 16 Jan 2026 09:09:53 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795c38208sm294912666b.71.2026.01.16.09.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:09:53 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v2 0/2] usb: dwc3-generic: improve DT parsing and support
 qcom flat DT
Date: Fri, 16 Jan 2026 18:09:43 +0100
Message-Id: <20260116-casey-usb-role-switch-v2-0-83a1a6501a11@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdwamkC/4WNQQ6CMBBFr2K6dkxbSQmuvIdh0ZYBxhBqZgAlh
 LsLeACXL3n//UUJMqGo22lRjBMJpX4Dez6p2Pq+QaBqY2W1ddqYDKIXnGGUAJw6BHnTEFvwRcR
 rrn2sdFDb9sVY0+foPsofyxieGIc9thstyZB4Po4ns3v/PiYDGuqQe2dd5lwo7h31ntMlcaPKd
 V2/WfL03M0AAAA=
X-Change-ID: 20260114-casey-usb-role-switch-a9ce370acd0b
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=994;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=AK4xscDvGv3TZpxsz1i4G03x/pFtwvRPVw2rh2ARmcQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsysggeOecL54TEvA047Bb6duKhl5bqOFJ6Hf5POHPpf9
 XZBnY5wRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIgmhGhg2y+f5SM2PFrud5
 ha9sWGWUejpl70mTdftUF2dHP99QZMXIsPnXX3eeVf8vzjB29b9V33HhQjXP/rIL0msNryh7LbD
 6mwcA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Add support for the new flat DT format being adopted by Qualcomm boards,
this merges the dwc3 and glue nodes together.

Support the usb-role-switch and role-switch-default-mode properties so
that boards can express a preference when OTG is supported.

---
Changes in v2:
- Remove leftover LOG_DEBUG from testing
- Fix qscratch base address being wrong with flat DT
- Drop default dr_mode patch since another version is already on the
  list: https://lore.kernel.org/all/20260108-usb-dwc3-exynos7870-v3-1-343fa1e81e48@disroot.org/
- Link to v1: https://patch.msgid.link/20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org

---
Casey Connolly (2):
      usb: dwc3-generic: support Qualcomm flattened DT
      usb: dwc3-generic: respect role-switch-default-mode

 drivers/usb/dwc3/dwc3-generic.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)
---
base-commit: 03c01c69806d4265070f14e7a7cbf617fcbb8f6a

// Casey (she/they)

