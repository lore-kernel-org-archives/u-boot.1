Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA00CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:23:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E88AD61052;
	Fri, 16 Oct 2026 13:23:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wOu2Y5BnhdV0; Fri, 16 Oct 2026 13:23:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EE03A60FD9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157038;
	b=rNi00MnnBHXN1OPGV7Yzp3VrSwLyguoxY7P5k7O2EAHeP20dWcf+uyrj2sE2ijy9VQyL
	 kdD2Od91J8iLYB6OioSTBT0cN314exv+4HF981sCSg9LaOggch4+jPDiJRrXF4MnK0Xx7
	 gSAdyqKTc7rGlhW2Rr56AMTDXQk7m8VS2p5aIHkh6TIOSZQ/G/TaBMVeCJ54mxa+Lmgin
	 QUhLYAOIuz2ukJEjaKbMTNmOzzsqzdeSiusXwIssIPWLszMznyjW0TWAOAUo4d3g1wUYf
	 Jx/Y+nEGWsFYv0z2Uqm/G3VzcGahnGh1XhSTNdqgY4eXyod20mWF2RM5PBmRjlWlHUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157038;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tGsepWl/MR8JxwAUrbeGYDDHtsVjfTwIJxDj9mFOeMY=;
	b=WMXVNxbuxWHXC3Cd4pTDkPa1iPyojt0OUPN64qyFcFEJ78VSuH9I/GsVrqXZPZr9Z4YK
	 z3DPRH/leO9Cq/vTZ4eDIEdBtsaCIi6uT4/YaCthvwl2Lh4/5onGwllDShNdi8OjYqK9Y
	 O83cxaD37IITyh9/05Uk3vpH/wTg6Vv0jEuMv4/DV9WIi8zlbkMcxRFKnji38iIXabATY
	 iWoEEmfH0EGEjM/xzAJx6NKR/vNbrN48LblGzrrtfLWgkz4W+fcllPgq0ebOSvBsOFowh
	 o+OAP1Oxs4m8ioMIarg8D9cHINg2Yw2dwBPMXACPaTwlzc7Ka8A0Oee7q+0czRirePw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=otDPcX02;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157038;
	bh=tGsepWl/MR8JxwAUrbeGYDDHtsVjfTwIJxDj9mFOeMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ClV69zTK1qiQaakGu4Ak9yEr/eGc8EXgj+a4xYj9zz5mEJqKLhOc3QCLOeAu2GbDX
	 0v7gjVi5lhFHe4WLIDMENdFUb6W6aYJcm3GC4hIcN1IZ1pmxg9JIgaH/P1yaQDM9Ih
	 7bmXjDST5J5tUviLPqHquM4v5KrKHJWwatlBMak0CMJSiVhNideCty/t+PRK9r6HWP
	 BrLKBkrgTrwBwmgcd+JX+tARnaVm+cW2W2Y+qijAtVDsgCbAnN+UZ2p3HAS4sWaBDq
	 chhoeO1S7JEIEQ2wiE5pVSUydoJ9EKZF0sA1NRl04IFccOSyOn+2S/TNhHHlRfnh67
	 V0quP6M1BojlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE03A60FD9;
	Fri, 16 Oct 2026 13:23:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EDDD31DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D33B760A9A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqNHVjRqFCIy for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:17:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 855EC6079B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792138673;
 b=fJRdKfwhPN3eWQEy72+GGfAFM+aN5sr4uYQV2o8o5LtXGIyHDwWYrMKKlRaWzqzXF7ni
 EEeQfBFkRhKBcPn6y8YIJm7wK28hABXss9mITsw5XtfcC1ld/w0D5Gdb9ii/GqbIJNxBg
 NMXZbEfgzcSzc+FLzhbsZ1j9WJkX0Z6hiBl0+EWmCq94cjKJ3ZG97eUId0EpjEWHlpoJw
 /bb/0XCMhEZJPdoEalbWQ/+f6ZqDd/TFwBKS6/me9HbnSPQdzQ4VWx8panh3k6SjJAqyj
 iLPx3Y/3AGl729UMbpb5t3NvwN57wBQSznMYPHR0K7SWsw+d9inzwPUOUO5RCExngtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792138673;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=tGsepWl/MR8JxwAUrbeGYDDHtsVjfTwIJxDj9mFOeMY=;
 b=jQWgmvPBX9+AKVBNF/AwT7FcDdQA9YCQXUoCcLPlRbgDiM9B93NQe4oAc/ftECFIWSKg
 IWy4JrdxoPBuPTBkNb3Y4lLel4szUtVFEO5mAD0o6QoeJK3zKlWPc9I0PHDwFX5YbvtfT
 4PYncw4oM3IQSqOu5TJJL21Xjt3WI1drZktMdKNNq3m7IHAXdf95pnqA6EtFM1Ngn4nCy
 n3omI9Rti4+Z8DvyI1PdrRuiqXK/2kF7FRDSExQ5l99exGO7FHkk5VTLK8DAWD2yVoaIV
 H6efkdlMBry4OLJCKJW9sUzep9RCZKUNWhaAAWcjQ2PFZwSDLxl0c24ruEQobfpIZUg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=otDPcX02; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=otDPcX02
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 855EC6079B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:17:51 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 78BCF4103B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792138668;
 bh=tGsepWl/MR8JxwAUrbeGYDDHtsVjfTwIJxDj9mFOeMY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=otDPcX02uIgp21Mw52b5VKbjbjff+DFJXxLtKt7naLW/IOtcLxvaGIVTlQAylMTkU
 sd9eKWyE5VRZ8hvBPAinf0FtSE25qnvn/1fITUOeu/iw9eT3IRsXFU1bBL0NLMBZRo
 LQgXWYT3knQGwvl4GrVKRmXGDVQh/KZg+wyQ7XdOabkF8fksxADIO3GD9H81rzMpK/
 bQy9fSjTL1Kwnx2DjOUO7zYS/SHZGlKaAscGmGy6CdnVpjPRrLzpzwOfX3WPgZakrk
 vPB3+mzN6Y8/82b00TYtc6JyhXoSkJ364yM14YQAPLCf1NQc/mOz80Z3TofeAQ22w0
 IE0HPabZ64NIcnEdC8Ir1EfXmMZCPDGUs6rYKjTu0f70cloB0bWKpMqJ5QHGM7QhWz
 b8QMRw5NDJ77vhGrfsYvuoRrhQpEcF5b1aFnXFomiaEqk4gfLeOKXDNOvyKWUvBR83
 T0eHVM1Ou2bK+Ipwj2oQP/kje6GOssYYPFHM1e6eJrUCaFWE32awvYLiYQQ41KMVMQ
 4OFxObXDqmzjvDADMYAbfqL0R/fjLQy4FnAcqw9WoRBZmBt40cViwsQqPZ5hxZV35Z
 QL22PtPHGQ7TU6ZRh9z/77MKf9aWrYM8c5MleneTPRf4lTCYcEl/+nQA0dR23553ME
 BU7MK6ETwNPxCAtOLDyw6XqY=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab9850456aso3651127a91.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792138667; x=1792743467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tGsepWl/MR8JxwAUrbeGYDDHtsVjfTwIJxDj9mFOeMY=;
 b=sv3SyO6xI/4okYsXNzIpuedAk+jxjhum2y3mKvbxad9/uZ6K65aw7PJTAgY/Py2hob
 L5wPDueLSuR3Jjy7OnrVPt7woHxqHiImhC8dFh1JFG9pZILZpF90JEaOrAaOEw2gvl/S
 OJNzfllXBL3J5LMR4giEJl/14UouYDkyic+uUiBI+PYqFuTxkgNgULdaWl4VAFJ3Hucf
 nTkTHgtB/f1w0/+SCnUTEENpDyQSetReyv0eoz7i2exSoO0dDiCghuVa6rZYJZ7LhAM3
 JXKI4qNLEcdD97AxgbqdghB2rr9K+K5Qvj7HNlj3rHtXp3qL5hjra5CWOlyGFdmar0YL
 3pHw==
X-Gm-Message-State: AFq9FYJrwkS31rFt45dc1eoxBuU78V2OMmJ3gosILirWT4dZKRYoYFJm
 9Ize6e5UgXAzpTGGvLTixRw6N2n/cJZmXbQmX/xMoPPkgm/1Pi9nLkwfIv7HtMVEWINSIrjgbcG
 9+X1WBhPjQDXW6M0s+VLSgu02fIEHqL9lxGqDA4Dv6WVAr11dmyXCMyoIV+Jbnfztk1YaFu34mD
 96PlIIjeoDHgOXDWhdmg==
X-Gm-Gg: AYBFou0SDywqNTZGhOZfG0Y++zz/jfQgpB+TUrHrd11JrheSkSS+aa1Iiwp2NtHKoky
 9qeQdF487D5gDS9g84zBU9ZkVYTkxu+c2uUqVT4fg5yL2ie5dNyqaIx+u3tkWLZY8q/tiftB264
 QKXEPDv57mTjIVGy1aDPDa/cymynV0aQeRhSo1C3axCyKe4kuMFuMVEaxIphhbtiOZ9KaBeIUAI
 eTcXEzm8Be9LreHZXxO6EeEmuX3zGQWzxbdBu/NAE/liCOfTMC2x3ad0JeRkA/747mL4j2t5H2e
 ZuP5wS33cfejTKlj9diu840Ylqs/Zcgw6iDmT8+Bm4PlvZBBYsAsrXuiCoLuItPXhytxUdDjO7E
 Q+ipIeY2tMITtLOO1+zeAda0NsdiE6shx0X5BQvRiiq0FWPyknc+VA4IHBPoekNX4qA==
X-Received: by 2002:a17:90b:5343:b0:3a8:9d0d:ca50 with SMTP id
 98e67ed59e1d1-3ab3a956dd3mr19065554a91.10.1792138666578; 
 Fri, 16 Oct 2026 01:17:46 -0700 (PDT)
X-Received: by 2002:a17:90b:5343:b0:3a8:9d0d:ca50 with SMTP id
 98e67ed59e1d1-3ab3a956dd3mr19065539a91.10.1792138666012; 
 Fri, 16 Oct 2026 01:17:46 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9474b52fsm9149405a91.9.2026.10.16.01.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:17:44 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, anton@binarly.io,
 pranavkasthuri@gmail.com, Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/5] tools: mkimage: bound external data reads in
 fit_import_data()
Date: Fri, 16 Oct 2026 08:16:22 +0000
Message-ID: <20261016081719.814357-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011152235.8842-1-aristo.chen@canonical.com>
References: <20261011152235.8842-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
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

fit_import_data() reads each image's external data at the offset and
size the FIT declares, without checking them against the file. An
offset past the end of the file makes mkimage -F segfault, and a size
running past it silently imports whatever memory follows. U-Boot proper
and SPL already bound these properties since the series linked below;
this series adds the same check to mkimage.

Patch 2 makes the data-offset, data-position and data-size accessors
reject a property that is not exactly one cell, as was already done for
data-size-unciphered. This also affects U-Boot proper and SPL, and adds
60 bytes to the pine64_plus SPL. Patch 4 switches fit_import_data() to
these accessors and adds the bounds check. Patch 1 keeps an existing
test meaningful once the check is in place, and patches 3 and 5 add the
new tests.

Link: https://lore.kernel.org/u-boot/20260902-b4-fit-ext-data-hardening-v4-0-a884a5de96ea@binarly.io/

Link to v1:
https://lore.kernel.org/r/20261011152235.8842-1-aristo.chen@canonical.com

Changes in v2:
- Patch 5: also cover a data-offset and data-size of two cells, which
  the import used to take from their first cell, rename the test to
  test_fit_import_data_prop_len and reword its comment and the commit
  message accordingly (Simon)
- Patch 5: no longer claim that the hashing stage reports a skipped
  image (mkimage stops earlier, in the cipher pass), also in the
  comment of the existing test_fit_import_data_missing_offset()
- Collected Simon's Reviewed-by on patches 1-4, which are unchanged
- Rebased on current main

The shared helper Simon suggested for the single-cell accessors will
follow as a separate patch.

Aristo Chen (5):
  test: py: keep the external payload when editing a FIT with fdtput
  image-fit: check the length of the external data properties
  test: boot: check the length of the external data properties
  tools: mkimage: bound external data reads in fit_import_data()
  test: py: cover invalid external data properties in fit_import_data()

 boot/image-fit.c                      |  21 ++++-
 test/boot/image.c                     |  44 +++++++++
 test/py/tests/test_fit_import_data.py | 126 +++++++++++++++++++++++++-
 tools/fit_image.c                     |  41 ++++++---
 4 files changed, 213 insertions(+), 19 deletions(-)

-- 
2.43.0

