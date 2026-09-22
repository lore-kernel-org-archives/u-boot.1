Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CB5C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 09:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE55E80DEB;
	Tue, 22 Sep 2026 09:15:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cE9fvXKc9B_Y; Tue, 22 Sep 2026 09:15:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4906680DB4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790068525;
	b=TaI2P7BtGCYqNORcKuiy80Qy/6A4+8LaZzgBDlKYb/jIEGZFbGim7HC7OolAr26RqhTo
	 5NBw1nkoPeVVZPjyL+noZXcS/UztOskInQ+MiqCYhNmpUbAjUkM787+a7pZuOHvm3S43D
	 nK0jTqpCFEgTYDr5QvzavDbSNLDu2mA7+KHY58bsbk0Z+IyvzD2bYXzgRRTJtvtxu8R07
	 aEgOHQqWfNPi7XyFpnX0B5Wd5OvP/bq+IK79hsBDEF8SgPfH0f/sWCCZeFZ//mWrDgYHq
	 4dYfXD4czWQp0tlqkwgTN9N6VcIa47qpJuTXHVajOYdLsf6l2aJrEm/ma5LKQA0Px6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790068525;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qXDKvHXe96ydaqMWXM9p2Uwj665nxxmdE44Nv7PAoQQ=;
	b=Ivd6nXjvMKK28fzjeX5SfdWRLhEKJJS+9GdFwx2k8aCc2s41MErBp7KNPWMFkePeh6tb
	 JmEVTxZDmdWAuBNrCVWCH58wokp3OG7JWE5j7D4ObJZiZLL62PgOGDn/q9wU03miSpp83
	 tOFSiQ9rAsDev9XF0Vq62DpKMqh69ZdUHDEBOq1WQw2NPUg/PNF8bviLAQBPp3XOF6E0b
	 2y3FkBXA/+cw6YojVUoBpN5J7UdOt+BJs5DkA3IQ3ypTRAn5+w0DW8A0ArJcGCbcqsaN2
	 8M7qiGzuu+pFNMMvMLodjOjIKe3OQGWLmIuJOCg1IgKbTYx023czZZTEGj0hAvA+vkQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790068525;
	bh=qXDKvHXe96ydaqMWXM9p2Uwj665nxxmdE44Nv7PAoQQ=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KN8Gd/U+nr+1sUe8ZOyygz+pElxA0ifZjrMpPfLafGQic+H22lEXPhKB7476t1s9a
	 2/JfB0KIMmJigOQAT5MskrMqhnO06k/AmZUcnj7+wGpUJAKxbg3AunFRR2XJ/cONl8
	 I3YmKql77c/ap2JvppU/bsl1Zh+/MJVblIbVXz0bEpptiQAjmQxCQKGG6J9c/vNd1a
	 cu1hAjBbsQ7tGNnIkH8m4v9VR+LrsSFGWcA4mL58t3YLagE6Qgr5EQtqa5bhN1S+VI
	 hbRQLght7MLt3fnWQu6W5r1k+uJGuFGmgAPLrKhB7tGFRBzDkMQ5JB8uq7SsFnazFU
	 18+ye1tMEcg/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4906680DB4;
	Tue, 22 Sep 2026 09:15:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 86EADA20
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7933F60628
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:15:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pTT36zrHcoSw for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 09:15:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6A8F16061C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790068522;
 b=JgoKJg4NIvnQOU0px5/y8u2fXgYvJ1+lryCwJZbpo/GL8QONXrs9LV5zhUPjzs2uzd5P
 Iprh7BDACEtDq9qjRhewqzJOMiE3IQH9yXsx605xBRr6V3KPF1qbEyfA4izIUjoWuiADF
 hRbxqbaKea3NIEuwn+FDO/d4ckq1t1brAO1A54CD6We65OO276JT+xpqAi4kWgPYQx+vC
 aLLSfOJ+Faedg1hn7euFO2YbfojaSPwXIDSC4YYBQuKPoHbET6lKjuATuHg+h9pybjqZs
 Uo3vGXlQLVqDP+yoqs7Sr4ipRdsPykflhu2092lgPbMyDZPQ2Yj+JT7DQbJN+bf3frw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790068522;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=qXDKvHXe96ydaqMWXM9p2Uwj665nxxmdE44Nv7PAoQQ=;
 b=fxM8rVGP5Qv9xUeZ59T0ltS3TD68LXW6RJ/L3wf9zDjQnGvQ5jt27yAmyVJyz0pIvXPt
 CMM5LdplumvbE0nDYthpEEgRiQMOmGh0G4ce7WbFra8RFJDL6q2my5Wqvbevn5Y7h4UcL
 SA6yruOZIEHoDjUZVKNYd2wikK0VsuhR5DG0+QEm2X2fCvpwcVkXxm7Om0A487k28LaME
 sT1LbKS+Ori9Y29v3lDlEsQYMieWhfT1e8ixz/YC/1TZHIwDeLsR/QC5RYT4ECUgv/ojd
 ArEYutiu4XzoAKJ7XQ2qwzy0uoz6Fts8fA62Qa5s310qj+FsDwKzjUSRT25/xDdbBWQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=N7+46L3p; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=N7+46L3p
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A8F16061C
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:15:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA4E61576;
 Tue, 22 Sep 2026 02:15:16 -0700 (PDT)
Received: from [127.0.1.1] (X72Y076X74-2.nice.Arm.com [10.34.111.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B789D3F9A2;
 Tue, 22 Sep 2026 02:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790068520; bh=ImGRMm37ufZZPGOBzeTiNoj78XbXLYAQVkNeyTQwSHc=;
 h=From:Subject:Date:In-Reply-To:References:To:Cc:From;
 b=N7+46L3p6eR6G3rcQz6dIyDeef8vRR75hBQOFU9r60ghvswQ9GQAcDAw0zC4ugo8G
 O/vEPu6Aw8LQb5Jt+EVoBU0ft5vk+ezkZQujuiCnUVf4ZW68IkL80h6xyHzq2+kGsG
 Xn1xaYpJKi/Y41pICEhtQ8EbouPAgUnH+l/6Qxd0=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 0/2] efi: fix and test hii string table reallocations
Date: Tue, 22 Sep 2026 11:15:15 +0200
Message-Id: <20260922-ptr-v2-0-58817a31c67f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNQQ7CIBQFr9L8tRjABqwr72G6KPC1mLQ0gETTc
 HcB43KSefN2COgtBrh0O3hMNli3FuCHDvQ8rQ8k1hQGTrmgAxNki54ISRXK3mhlTlDMzePdvlv
 lNv44vNQTdazTasw2ROc/7Sax6v2LshUTI4xII6ihUp37Aa+TX47aLTDmnL/CZsEXpgAAAA==
X-Change-ID: 20260916-ptr-670be74dcbd3
In-Reply-To: <20260917-ptr-v1-1-7d60d07b849e@arm.com>
References: <20260917-ptr-v1-1-7d60d07b849e@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, 
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=ImGRMm37ufZZPGOBzeTiNoj78XbXLYAQVkNeyTQwSHc=;
 b=owEBbQGS/pANAwAKActJ+FZ2owaUAcsmYgBqskcm/6WGxpLkf9ZzPOki+nfLP6ciSEoPhYqZN
 QF3P/lso3GJATMEAAEKAB0WIQTXYBSgjlpQEXB4KmzLSfhWdqMGlAUCarJHJgAKCRDLSfhWdqMG
 lIjLB/9atOgv5nZ56Zbf9VOPxIvR3ICasgi4+BFxslly0t+s05ct4HLVQE+4q/cEPkVSHjmJ0Gl
 ocGZTQKhDho2zuyHLFtpkoYAfxv4Zvedw1I1wAyl+uoBpPPvOv190LRXYrECKwS1vpB466joM5s
 sNhp0r8gkgJVcADWQWgZzyIN09c4zrBSsa0miezeKPQXpb/aIFsgLrxEsygEeZEAKo6MR7G+zxp
 qMc8oLz1i8Qje/hfUDXUd7rswE2FIx6Z9vV8CR0zOOh28pB7vUtKvnLjR5dIBaYBSl3F7PhHNow
 ankzVZxXYLaA5bU/8qQhIfH0I4lw/y8z5Wwz2OmwwsSSysOM
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
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

Here is a couple of patches to:

- Fix the string table reallocations paths in the HII string protocol
  new_string() and set_string() functions.
- Enhance the HII database protocols selftest to cause reallocation with
  set_string().

Further testing can be done by forcing stbl->strings = NULL, just after
calling realloc(stbl->strings, ...).

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
---
Changes in v2:
- Enhance the HII unit test to cause reallocation with set_string()
  (suggested by Heinrich).
- Link to v1: https://patch.msgid.link/20260917-ptr-v1-1-7d60d07b849e@arm.com

---
Vincent Stehlé (2):
      efi_loader: fix string table reallocations
      efi_selftest: test set_string() HII string table realloc

 lib/efi_loader/efi_hii.c                 | 64 ++++++++++++++++++--------------
 lib/efi_selftest/efi_selftest_hii.c      | 44 ++++++++++++++++++++++
 lib/efi_selftest/efi_selftest_hii_data.c | 53 ++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 28 deletions(-)
---
base-commit: a06e89ab05eaa2b8344d521319399333cd760ae5
change-id: 20260916-ptr-670be74dcbd3

Best regards,
--  
Vincent.

