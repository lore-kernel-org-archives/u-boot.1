Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C65DCA5FBA
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 12:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 238FC60B05;
	Wed, 30 Sep 2026 12:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id od2VuKZgPXyq; Wed, 30 Sep 2026 12:18:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6B04160B0B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790770710;
	b=gRjBbC5PQHDKPh1aIqCxqojQSnTSTlz7lsgAa7gaeodnTw6T1SflUAwrWgzUzCgn9Txt
	 SJYsGS8sAYaIDDQbyPiSngVyGXjUH14ceFQ07FjYru1gBfTB/+ua3uhpV4xCXoyzvrqj2
	 oN2ASP22FOFW9hiGUrg4E52H7wUtapGASFlYf+nixeZm4JKLTEwnnxyTXpSCnOycvzbR9
	 128DR/u7gjPPZJAzPbWI7R8rQdtsVvj1Iaq0KpKBQFZeDf7ni7sRwRzyLyxTk+rZivuJ+
	 V4F7NApPBN+62abZNAYNWgW3LPlPSR0vQtClNSoB6oqXbxbLe78FjbcF0sfbRywzUcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790770710;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RmkeCyfRGO3iw9wVtp0hQPT21siLAaCalQW6o1wXCoQ=;
	b=R1R6d7gM1qPT5WkV+b5tQTU9A4hvhVaKeJimonvvdJi97REDvR622i9DZ0HeOqFSLpvw
	 ad/ysnCzjOgRp6raBhtAoNQ6f3WBx4tWbg82Sh3DSVqznQL2JvKul/SNAws9f6z9f5FM2
	 QHN4bIsUjRH8Kpwy1x3aIi00tPiLXnwID/vBli8RLqAbnQxiSguL/+p337o5ErM1Unojl
	 HZd/Q5G3gJwOc03fvrByV5Eyp1abAdBaIInw00EtF+VuLOGRlRXLiL/sOAlQ7JovJAiwr
	 nwsJUBBJ1dAVpdgmLkWY+0f5e/P+X4kEYcfHBNFvtP6Qzqq7I021M06lmCghe9wI02w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790770710;
	bh=RmkeCyfRGO3iw9wVtp0hQPT21siLAaCalQW6o1wXCoQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=elzX4zpjbOX+Nxq+hm3GP8rMaeGrrPYfXU0jt1chmUv4xvch79HVNqOSrtPpmKaq4
	 mgXkno62i/FpTNtRXyRbT2qQl4D8k71nBe3Q79Tk4Qn5ZdQDeZw9xhQ/WJ6FZV6VnF
	 e3sI+uCGWHdZKAduPuokXSlnAeGNarPFKaGn+mixCN3YO0H112wUs5b8GpXGgVMqAU
	 0yM/OEX2PlkJfXS8ozxGHg0Kbq3gY/+3PqVlAwDjqCUv0PvS8nHcOsZQhR2GTogBuY
	 ngkQzgJz8EJV+G8l4d/cABDwQajIcENvDwnSEtfwPBc4IUZS8XgQt2rhh/mfyQgpjf
	 IVOr0B1AkEyAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B04160B0B;
	Wed, 30 Sep 2026 12:18:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD90824E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:18:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B261140A9E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:18:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fCFkaAhK4_fG for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 12:18:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 584BF40A99
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:39::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790770708;
 b=SdIiTVR/yjW9GvD435eeLtV4v3DIQiuL3DrtBJ6AaP25sIBjDlBXEX/o9m3ddYryfj3p
 VuhENWSIcTEhmkzdDSpzCCt5EgtqWxdfiXauXjx5lieRTlUmFgSlfhOXVdr/MgkMTU/v1
 m4CbjfF1Ch8nw84q9AigKgNh+VOycmtAWD5ITwgAOCsWhcIlA0VPzarw+XD5J4D7ztGfI
 ZAR24xJbJI/Lb8DECbMouJXp5TtDRq8BMtm7c3vVkhHPlhNsZirHhA9xd180Qtp77xuIO
 rhJ234zMKUnJo0fqW76PGXHOlf7CihOlIGxoWHSEKCkYb+EIIm9cupvghg5UMfiZnYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790770708;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=RmkeCyfRGO3iw9wVtp0hQPT21siLAaCalQW6o1wXCoQ=;
 b=i+eCnuiub1IIkLdTQu0PGAlEmvMc34VNlpJ+dkLFe7qqcZaEBNQn+q1/YmMDdKDN3Z6x
 VLUIvD47btDZg83DeoL/QzK/Ksz9TMA1yu/266FCusug+8nmb8efLxXKi5CAY/WQlI6N3
 HDEa51EAOWJPYm0vNZn1OUJn+MSL+f+lVSCuYHwx2s7+oR2ObDmDWN58Hd6XcNANvy1ky
 0ds1otSrAxmPeMXaP1ZdAzqeDf49rNjKzgtStTz7ByniPH0CZ7WK0etCFLEpHF3wcXLhD
 DAu0HWcFZ2L5zSLqOLzX9Jbsri6OnEJ5z3kfij44CbyYc4x0w4epeKeDa/HASVmmj4w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=WzTsZwRp; 
 arc=none smtp.remote-ip="2a00:1450:4864:39::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:39::e;
 helo=mail-ua2-x0e.google.com; envelope-from=hfranco@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WzTsZwRp
Received: from mail-ua2-x0e.google.com (mail-ua2-x0e.google.com
 [IPv6:2a00:1450:4864:39::e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 584BF40A99
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 12:18:26 +0000 (UTC)
Received: by mail-ua2-x0e.google.com with SMTP id
 a1e0cc1a2514c-988ce00f22dso350080241.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 05:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790770705; x=1791375505;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RmkeCyfRGO3iw9wVtp0hQPT21siLAaCalQW6o1wXCoQ=;
 b=WzTsZwRpv7YUbyOJxgvcc7vXF5iw26IZ5fgC2Zjg/gius677jr4eBx/LLGg0djhyQT
 OwUzismzOkkw70y2CCDPebs3LQYbDEYAqMFhH1eO0FlQ8uPWxeXDhMkAe6p6vPkLj+E7
 /BjBwJf0CkTC8r0t1aFcLMKy5z6C/qLjzOFj3yoG1vu3YeFn4BQrbr1wu1+6bENXO4Dq
 HrGtsRu2u1VIgll4/KuX6+G7PkmMP7aKTHEk7sNGGmDuecqu9f0o1vJ6YOrc9BFPUSQo
 HLcRZcUIQYQyrB2zSgI8ZtDwVDfgsFQIcV/xYMsbDj+RZtJr+G49xM8O8nZ5/p4AF9LA
 vIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790770705; x=1791375505;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RmkeCyfRGO3iw9wVtp0hQPT21siLAaCalQW6o1wXCoQ=;
 b=Wzh3Vv/oTdbajOuyfnR5GZ65UOUKCg7Kf3ShI5q9CLcFRN0LfaBdQ4lYWQ2TkrEXln
 rTBboM2VV8KPUnluC8yEvNyHOD9T23vbKYbyG+/dObN26+xyPYKkPz9+FYRy8iou0h6+
 mDey8AJOktht7I/mYET4NMYwJkgqD3jD4dqKw6kUHm92nI/RQuzDr8uw2uIhPa9D6fGW
 roEaX0CkFcJJBGghDsrSrJOHdlJhrg2xXRDOKegs8oCKgfwnHSy9eoZxxN4WTvkRk++u
 zHH4NHVCo7Z9Vj17bUcGivGmEqsL1+W2exL/CeR/NPRxCtMwF2zL1nY+FLx7/L4igXqZ
 bF0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRj/8rIVNzqzx03sNZVwu3lDRqIiktgYU7hG6QltnaQ1Cs6UDMAzPQhFdlsWWWM6uiASrwk+4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKQAIZt2p9SarI5alLP4qxIQNbnX2VAYR7nVNMMaLyImWGvCmSO
 +BS2Gx7K2zr8Y0IC6hXo71wbwIOBPUWPTiwucGGFx5vsFq/NlRz+U6uLAxgBTe29lUs=
X-Gm-Gg: AYBFou2htOCGiEaZ0EgwV2s0PL4tOy80fq6jYO8jhom8b1s+Wqk76iS4Avu1yp0Rllr
 mh4Gi4G+TaHK26Ao5azG4vIfXe/KcVGbg2Oj2n5f3dM62dqtoQcfi4s7OcEyCrIpE5nupNyxtPP
 bjegsMErSetJTWX2A+9tsqHEhMhyrzEjFh+snqMaxw3ECcIhgPiBYZcmA2aRh36yppwoQJDPxsx
 QN3ZsjQb/HVQa6iPSv6VuMEYb0I1BdW8xRu9Fta+o7tUpgEZFDsS+wUfTWvklcqauON6X3/4aai
 uEi+HH0sJtcpis7eRWX8k7n0k3+lw2XjPDLgGwiiVcV0bmOjSXSJc7QJnvgjdvKbGY31z0F5EWr
 WBVl+xkJ41AnRuWiU7/SSxb8BkkzdpBe7ddGB5dXdcp+96mJ4bOSICSf/wP68wvlPmZsnH6Rqxj
 4UUN1OqHyOHZF5RgRIaZDBElmdilp7ndjEYYaEqJqD81s8U8MRDurYcpQa5it4y3gF0mlr99bxV
 CKE+zJdZvKACmIde4TeT3hoVT37sovSxvbTUA==
X-Received: by 2002:a05:6102:6a8f:b0:7a7:198a:c2c5 with SMTP id
 ada2fe7eead31-7be73c8b0aemr194036137.35.1790770705280; 
 Wed, 30 Sep 2026 05:18:25 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:9534::ddab])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7be14b3cfb9sm1298403137.12.2026.09.30.05.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 05:18:24 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Subject: [PATCH 0/2] riscv: cv1800b: Milk-V Duo boot fixes
Date: Wed, 30 Sep 2026 09:17:48 -0300
Message-Id: <20260930-256m-fixes-v1-0-69546876ff28@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WN227DIBAFf8XiuSux2ObiX6nywGVJaEucArYiR
 fn3kKRSH0c7e+bGKpVElS3DjRXaU03ruQN+DMyf7PlIkEJnJriQ3AgDYpYZYrpSBYNGce6tkiK
 y/nAp9Dp0//Pw5rq5L/LtufBnFPrdeqW9tf/IMrwSigvI6ed7h7CtsF1qK2QzhFbBzZOlMGH0E
 pd9fu45Wwn8mnNqyxA1uXGShtCi8so4Pik3xjBqS1pw0hqlRZzZ4X5/ADUo0YH4AAAA
X-Change-ID: 20260929-256m-fixes-919700ca762f
To: Leo Yu-Chi Liang <leo.liang@sifive.com>, 
 u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 Kongyang Liu <seashell11234455@gmail.com>
X-Mailer: b4 0.16.0
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

This series fixes two problems on the Sophgo CV1800B/SG2002 Milk-V Duo
boards.

Patch 1 fixes the fdtfile environment variable of the Milk-V Duo 256M.
CONFIG_DEFAULT_DEVICE_TREE is a quoted string, so the quotes ended up
in the environment.

Patch 2 keeps U-Boot out of the memory reserved for the coprocessor
firmware. The upstream devicetrees reserve the end of DRAM as a no-map
region, but U-Boot relocates to ram_top, which is the end of DRAM, so
it lands inside that region.

This was tested on both Milk-V Duo 64M and 256M (CV1800B and SG2002).

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
Hiago De Franco (2):
      board: sophgo: milkv_duo_256m: fix fdtfile quoting
      riscv: cpu: cv1800b: keep U-Boot out of reserved memory

 arch/riscv/cpu/cv1800b/dram.c                  | 25 +++++++++++++++++++++++++
 board/sophgo/milkv_duo_256m/milkv_duo_256m.env |  2 +-
 2 files changed, 26 insertions(+), 1 deletion(-)
---
base-commit: f8eb3469e1a17c79b047b3fd38ae820e8816a115
change-id: 20260929-256m-fixes-919700ca762f
prerequisite-change-id: 20260702-milkv-duo-upstream-dts-b54aed41fc61:v5
prerequisite-patch-id: b8e6815314b7881a02de0066232864d522c4a26c
prerequisite-patch-id: 0df1fa5db1b2bff402b429809796bad99a517483
prerequisite-patch-id: 49e1e8263cf0a5ba8d63c8b598b6382cde5284b2
prerequisite-patch-id: 86dd30e784f022f0a7bb6fbf125c9699467176d4
prerequisite-patch-id: 49070c05ecf58331ec519a57d1b82f8b2b835a89
prerequisite-patch-id: 6b6881e45cc6de6544aaa4509db21611158f4fa1
prerequisite-patch-id: 7198127d4602eeb14212087ce9bb694d84e71a4c
prerequisite-patch-id: 3a58bd8a061707ff27b8538d4897def3b595dc36
prerequisite-patch-id: 9055ea941b73e35d1e825787d7eca14ffceb8e8b
prerequisite-patch-id: 554c1487e8d596e0099677ca88eee0021b1ffbae

Best regards,
--  
Hiago

