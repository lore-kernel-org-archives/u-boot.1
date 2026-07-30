Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5440C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 16:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6750F80F90;
	Thu, 30 Jul 2026 16:06:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3BeRRetw6B48; Thu, 30 Jul 2026 16:06:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9109E80F9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785427577;
	bh=pMb5AVz5oL12r/1TSPPXK+LoAH9deSEtCjw5Thpa7sg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a34eVY+yVrs6ELe/4pJLDN+Iv7CwzhsSIntwgijLFX8OOxoz2y6Kl9r0Loixqqq+X
	 vMWPOLaIhEYU761UtAyyQ468+M7yZG8jzC0Ajweh4l66zQhw+z3cAv2RPmd+lRylVB
	 zPFExMxmvh4yMKjDZ0+MVtojNeO1vhU8cM4JfTEOXsD0pa/w2FGvW2/bGFp4b0TWVm
	 xFEtpL3CF9oEXKEuubMTDRmbcbdyKevYq55wx32K4ONdI+cS0/IaQtU3Fbj0Pl5Y5t
	 w+CLvfSR+JSn8nCk7VbHaql9uyM5E7N23RSXzN9m3RGEqqFZbNwr4m8x8+lAVzDyzm
	 Akp24JbImYhYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9109E80F9E;
	Thu, 30 Jul 2026 16:06:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CE38C27C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:51:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0C1E810F8
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:51:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X_0M7aMrQFZU for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 15:51:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CBC5880E37
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CBC5880E37
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CBC5880E37
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:51:23 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49548e01d02so10696735e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785426682; x=1786031482;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pMb5AVz5oL12r/1TSPPXK+LoAH9deSEtCjw5Thpa7sg=;
 b=XLqo9OHMqxOkzRpM3pF/o1prh5c/hVjOdx5XvAT+Lnwhkz+gw0roD7u1wunhnS5I5I
 aClN7NFN0YWCBCx7708ku6p0wyNHLocftVMa71KRV4e3J5t4TXWCoJvJpqzRFO+9Pbsq
 mc4HJjEL7wyG4zSwmT1EAAqOAEwjfW5/vn9N/vOFR3tU5vAr2m1T3bJxbaicKK6xsctY
 uBJ9gCW2NGXExgudYfnZ9HquoZdaObkIAlfC8rV4ifvb7QpykLt77ZdajYREtMlsEKnZ
 YL/yE0/n6th+h3Gm/HA+yxShkMP+CIbuJymdnMTExFp0eri9rW2tv75DDspvEZRGaK0H
 btug==
X-Gm-Message-State: AOJu0Yz83gbb8OOwUSaTSblKGEIf6sU6F8pfsRlwOlrkOZccVOGjUQcg
 0mtgS/J+7TkSI2Zgo6I0U0ofXK4l7s9Jl9fDimXuYfguj9jOXszojuD7eYJPdQ==
X-Gm-Gg: AR+sD12trEkIAPK5lir4JhLBXieLd9eV7Hi68+8yYcUEfjdi5s+5kCJB3PWOg7mEnaf
 ac262WTAjkrL4uNlRU41NopuvbfRX3R62SJEQTtySSoO1mIqv1/XV6e4sza4oOS9Xscn8h6Aq6F
 /5x5zHrN83AJaUIhEe48hqPaDGU+kTxe+q03JYvY8jihv80LketfPC4Yf22vvGQaYInoxIpQobw
 Cd+88LLWgHOX6qSZzmDDylRR40tw2ntTxiitEXFnNNs7vrOqOO9R/ZTqY9rPXdtJPdEHkUeEKX3
 HE7962AZmUxvkbkrb6dtP+fZf45am+Xx+IE1KcGYt9PdCd+d0QAcVciL3vOG7VnzjAZwCpbURMf
 YYz1E/K/5d1G52W73QU4pn/WrOV1sH+CpTN7gnGsPl0X3+f7fRpIkJVYwvt4DGS0O78431zYAqs
 EL2FsM32Tt/NTL6TYEMrPz24o4ISA5CllMdCZ8tRIrrrs4pBhd+mFeQNdPLIWYz+FfDaY=
X-Received: by 2002:a05:600c:4445:b0:493:bb6b:5bb5 with SMTP id
 5b1f17b1804b1-49800e77b32mr43021045e9.13.1785426681470; 
 Thu, 30 Jul 2026 08:51:21 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496e8e06f7csm146871545e9.0.2026.07.30.08.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 08:51:20 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH 0/2] cmd: allow bootd without bootm
Date: Thu, 30 Jul 2026 17:51:17 +0200
Message-ID: <20260730155119.3328020-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 30 Jul 2026 16:06:15 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785426682; x=1786031482;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pMb5AVz5oL12r/1TSPPXK+LoAH9deSEtCjw5Thpa7sg=;
 b=AscwcHDFHqjrMG3YmNACU/A2byZUSC3SHwW5+U50Wohjl1W2hKJAwHw0jU8wpkdYe7
 +j7W6UfZhEoNd68AICTF6cFEz5bBfo5YCgd0kdFgGowqkvqKHuOwH5ojGsQpprXxSFaf
 LDCh97la0Rr8kIos2KZBgUxxlFFu5E/VptXv5MUr0xZ6sFGydUj4NcXDU1ceZGp04IDU
 DYYvn4bIim1H00liJmg6qxJ4wp0nMqIuru+vgZEn7HjQ7p/KaaWZVLjk84GCKBUQ0WUO
 WF5hMuOPxQ22NtOSU/Nc2Ak6uIwgFFbKOZY6tYCglqMzlqghmM3a+SiiD/tu/atV3TI+
 F2qw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=AscwcHDF
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The bootd command is a two line wrapper around run_command(env_get("bootcmd")),
but its code lives in cmd/bootm.c, so it only links when CMD_BOOTM is enabled.
Commit 1fd04cf46baf ("cmd: Correct dependencies for CMD_BOOTD") expressed that
in Kconfig as "depends on CMD_BOOTM". The build reason is real, but the
dependency reads as a functional one, and it leaves the boards that disable
CMD_BOOTM without "boot" or "bootd" even though the implementation works there.

Patch 1 moves the command into cmd/bootd.c and drops the dependency, keeping
the current default so that no board in tree changes. Patch 2 adds the test
that bootd never had.

While testing I noticed something unrelated that this series does not touch:
on sandbox the "avoid bootd recursion" guard in cmd_process() never fires, so
a bootcmd of "bootd" recurses until the stack is exhausted. That behaves
identically before and after this series.

Mehmet Fide (2):
  cmd: allow bootd without bootm
  test: cmd: add a test for bootd

 cmd/Kconfig       |  3 +--
 cmd/Makefile      |  1 +
 cmd/bootd.c       | 30 ++++++++++++++++++++++++++++++
 cmd/bootm.c       | 24 ------------------------
 test/cmd/Makefile |  3 +++
 test/cmd/bootd.c  | 35 +++++++++++++++++++++++++++++++++++
 6 files changed, 70 insertions(+), 26 deletions(-)
 create mode 100644 cmd/bootd.c
 create mode 100644 test/cmd/bootd.c


base-commit: 94b349bd902d9e38e1846c157fadd9054c34680a
-- 
2.54.0

