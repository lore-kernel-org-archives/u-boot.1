Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92540C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C0D740808;
	Thu, 10 Sep 2026 12:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-qDYEMEOUnt; Thu, 10 Sep 2026 12:14:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 958464083F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789042449;
	b=ULRc3uNVFbJsI6Qo+caVwQDuemvXVd3kh3z1mwHDdqsGANv9ypU532TtcyR5GneZkjOT
	 b1vlpm2Q0BZMGqE8KQulZ6EwHy1nt9hs7macWN0cT/uggTNNMwybSHwMxBaXvDgcKXKmI
	 ZRKHHbf1pVxEK6B1VVTKvd81SBdLG3+Fdvjk/uK1tUp9kR/Uf058HOAM9+Ymy3qhnISEl
	 bfpYUqcYpqqwyBT8XKx8Ay3zQAZMruKNEh0cnCRmjRWbpeZ4jLSFtaUfOS4xhMH05l1VV
	 HX1p9WEyAqMboXmET1UaP7N/pssFQ19+saiz4qFeFguNV55zhJhy8Xv0TYGlZbHcQKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789042449;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mEncM0RmeNjn4zkTXMf0QHdB9khe1Mhqy7Phq037WmU=;
	b=NKoFg8O4YuTSJ7Hvx8V8F9KqqwPCx+r62pv/dlPmYO3tp0SX5y/18j9WSnXOOM+rCCmw
	 CuV9nF/7RHxVnDGvm09tBo4Rl9VfhOGqrw6gIiZGwaBFMpOdGRNRcNjt6n7E816SFKi5G
	 x0+Qpp0KB+gkODZdtXFwONU+t0k2cvdGgZCXUoOUV9/GgCBv79SeQ1r7hDl4IwmhW86EX
	 exGcWFFg6K3sRl4Fp0E9KvcDCrMyKQpNpDwLpXkmXXaukN/eCT+EZP/arxOnCol/iP4ja
	 Hd9IM64IPYRK+olNrUtFUCZGgTibE9qgO6nSHo5SnkLTYZkljHpDqer/WKT8WDphsfA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789042449;
	bh=mEncM0RmeNjn4zkTXMf0QHdB9khe1Mhqy7Phq037WmU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gF6N5mdzieYeDlZqoklZbSlWn/dhncYBTl8Pef/GXDcF2u53OjgWJIpMcIqCyIzYi
	 GMqOawvG7Gsl4Xzvh86KDb+3AuV9WyWIAvBVLgRuau/14zBVs1LUga5pFYYvnCN7g1
	 05bDkag67Mb4MhZxOVNW9G5pIM3B93yAKWlcFzGQ67xg026tfoEu8mkoTmYrBB0j7D
	 fZxxWokkWuR0bOhqW4f21d8Dz3THuM2HjsLzP2tqIRnMH2qT0LReJBfGVded8tv17u
	 dqWeWnGqM0rwgz1foPUW2Okayink2vTqdwXve5BF003SZ8jz0LTctOT0L1pXDmWlWI
	 /pfcNcZ/PbPPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 958464083F;
	Thu, 10 Sep 2026 12:14:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B19113AF
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9762A80FDD
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iYf0JiascteL for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 09:53:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0995380F7D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789034033;
 b=NJBYP2fOEcJa01aS1nRiHyQuoDZ/u7UVuxo7A4uVMlp7VBXgS1Nh8rYK2/XFQ/0sDrA0
 +gFUtmYdyEocao82nQjrSV9QbAfmU/Ehe7TngtYfqbpV3vsCFErWiVjh9OuPBJQz3oFvJ
 LfON0Zdf4rRVosNJQP3fReGofeApfWAhY3vIpfS1KGK7wDWEefwYjT8AJfmsX4iO5ZI8R
 +njLR3GrIWa7zHmR0+OEWgSmDNJNa9qcxri5SUb7nLbPslYaKMEztSXxtjomYeweQ2HjQ
 q2Nuzt7YWwpm1thW9xriZw9PEFfJjaMPQ2XgJ8ez9Hd28nhmM+ALxKSWImS6JmgTWKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789034033;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=mEncM0RmeNjn4zkTXMf0QHdB9khe1Mhqy7Phq037WmU=;
 b=fbIrJaRP7yCz5LaUNSoSkfcJQZFszyyNgII/mdVNGYe+4TcyqYDHRp7KNLICxiFJb3wx
 AS4w22qXd0TIFZpz6vYTl2ta3pm78Rf05LafcyG60bNMm5/dwDaWD3gzoRVcqZ+c6H85t
 plAR2a0GC93fO/fqretRcuXhMQw+C/zwWNeQSQGxSf10yXdz8yfaVP738FMGGAQUBsOg2
 XNgThAokvz0knSTAWfHFPG2dCc1334xnEcPIDJr+FRoH4EGWg05Nzbi5tyO/6+5vI4dGf
 q+CtW1VP2kqN6garaDRV/nxeVM1bh/EtHpJ4JM0YJeFFi1HEBn3+5fEWZVTXd1Girvw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=g4sBudEi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=g4sBudEi
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com
 [IPv6:2607:f8b0:4864:3b::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0995380F7D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:53:51 +0000 (UTC)
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4ae61629fso521644a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789034031; x=1789638831;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mEncM0RmeNjn4zkTXMf0QHdB9khe1Mhqy7Phq037WmU=;
 b=g4sBudEi/UhjS/jw1BfIho2ObzdpyspqtGU42jocz5OjcXn8nKOuQPVkoevmi0RpxX
 Yd7Nm0BfobLu18ks14UmrZPvDvlOhtI46yYcldKSUzDWOqs6NC1IPZsU/2uIXIfTqENj
 n+XeZLetQM/aRBSHFsVsFe4oRgVavMsC27ZrEvFILV9Jv+MdqqKWg75NeQM3rCWlhTaH
 nuBExI2L4fQ2mfJql6k7WofZyx7f/unV+1hMN9P7xUKj41zV+UWvRqaEK7yphnsfGYB/
 ujafEnAfJqPadfQ+ElL2/S/VJ8Znl2yIvSDQn4Eu8vfKQpXyfF/P1e3sJCJeQVk+dJD+
 k0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789034031; x=1789638831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mEncM0RmeNjn4zkTXMf0QHdB9khe1Mhqy7Phq037WmU=;
 b=Xe3qwy+SJkc4gh8r05vDcjLQZo6QQCTC2L1nc99Uj4IxdWRoygnBprr8HAz3ka4bWp
 2F40+alGz8wSWYtB6FRlrO0sj6KsFkOkdS4ex/yA5nKVaCUQD3Z4c3913mRxZHhQ0Wsh
 SuXessgcs1RvcpgxvlyUnO4kiW29dcLt7J5vCE/Cx9bSDtD2yr5aUWjMk8tClDIR4tNv
 NWzxm38vP/VevbV8oXsUC3vqapCy3GX9OZlHSWBrjeHBxdfl7j/G0zPTK4vNBYUwFbk+
 Qd35kP+1gjJOQxSXvHSKi1t4lVSOmRD6pHUqSWAcL7mrm2jc7tDy0nMZw/LOOpync2PO
 l+BA==
X-Gm-Message-State: AFuF++neBA70z5znA+6+MdMq7eSLUQwpYgXOgeVDVF63pMcigwI3rHIu
 mM/QSazRIRIT0BuMwYwXTGb7U6lofgq+5HmI4B2v88/l9bSgeqn7lNcUbj9B+Q==
X-Gm-Gg: AYBFou2lemVjcs/2Bn0pXETxHljo1pTCbpfFUCwD7WfPTzU8mx8bdzAilJ+w+agWMC7
 gv096lewjYLeqNPjfJ8bG5Q+UdtEt0ucrUIc7QbBkpw1t9egA3vuxXzAYXWBVRvCnJGjjc4OMmn
 XrdTPcNB0QFaMa6BT45CivIgNrIFdR5U4XgtsCW4zvhCyP4B9qCpxslbzWbbNauGetHQKxJ2FYP
 il6RkIrlHpLNuiEksy/jA0ZYHfpQ4qWKC6PCNSbdl9XFMJN++XQG9ZhPd6LMVXDnicGzmuOJBS2
 5RcCTiJont0vFsGck4V1oD6j2vACj8O0XT+/bvuTQNiqw5CnNmQIMnQ55GYNmGJWX7415C62ANj
 ZL+89BQk5XTeG6zTAwVBLHyzHM0Q+KS6bCZ1WeoeAGg5RRvqLUKeUnX5YzRYfiKFca/Es2kGoMe
 qV9GB35FxQnDwKxt7MHF9mxnMwvCEKrWc6CDwKoiDeeJneWe5zOlUiq4WIXk0zBA==
X-Received: by 2002:a17:90b:35cb:b0:398:a486:81ec with SMTP id
 98e67ed59e1d1-39d70a91ffamr10424498a91.11.1789034031225; 
 Thu, 10 Sep 2026 02:53:51 -0700 (PDT)
Received: from thefoxflat ([2404:c0:7029:b3c6:7b99:50ff:b405:5c31])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d7e77498csm3849455a91.3.2026.09.10.02.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 02:53:50 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Reza Kurniawan <imkyufie@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH 0/4] Add preliminary support for MSM8917
Date: Thu, 10 Sep 2026 09:41:43 +0000
Message-ID: <20260910095339.110427-1-imkyufie@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 12:14:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This patch series adds preliminary support for booting MSM8917. It adds two
new drivers (GCC and pinctrl driver). A change is also done to the core
qcom clock code to account for the poll register offset difference between
this platform and the existing ones.


Reza Kurniawan (4):
  mach-snapdragon: Carve out reserved memory at init for MSM8917
  pinctrl: qcom: Add pinctrl driver for MSM8917
  clk: qcom: Add an option to poll for GDSCR GDSC_POWER_ON bit
  clk: qcom: Add Global Clock Controller (GCC) driver for MSM8917

 arch/arm/mach-snapdragon/mem_map.c     |   3 +-
 configs/qcom_defconfig                 |   1 +
 drivers/clk/qcom/Kconfig               |   8 +
 drivers/clk/qcom/Makefile              |   1 +
 drivers/clk/qcom/clock-msm8917.c       | 196 ++++++++
 drivers/clk/qcom/clock-qcom.c          |  24 +-
 drivers/clk/qcom/clock-qcom.h          |   1 +
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-msm8917.c | 642 +++++++++++++++++++++++++
 10 files changed, 873 insertions(+), 12 deletions(-)
 create mode 100644 drivers/clk/qcom/clock-msm8917.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-msm8917.c

-- 
2.55.0

base-commit: d4152edb50356338af994d1c0483f65b717b4c15
branch: msm8917
