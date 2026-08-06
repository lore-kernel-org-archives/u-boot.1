Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DEDC56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 707A980DC7;
	Thu,  6 Aug 2026 13:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LvwxUHAxqJUN; Thu,  6 Aug 2026 13:37:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB9FF80DBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786023452;
	bh=FIFoksZ4mTBe175yvcaNvrByy5Md8O0NUTW2AtUkzK8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iyZfWJctf9tYEKTm0ZYTSqDBfkLZzIPuZxnp6TzvoxHCqDU7wkxTXpNlIv25HFHFa
	 xACgLj+ThHply4zfDEyhh+fLZygH7nULHEZu0jLIF/wJoNHyA8Jz7JoOqhwsI6s9Is
	 PTQo8qwygteNsy7kU2EDOfTDKpsy8as0dDhN6HhwUn0BqHy+r8r9hoCTwTc20at1Kw
	 q8tG2Po6O/u/FgFD8O4YxmigvUnPGl/vBTu9tIP+NsvXCB4MP2j6cXPehvpOz0kdM5
	 ih+IxoTfjwY2/G6Q9KPPYcRugXtXqGa7kjhp4/0gPNe0eQhH52g/c8SFPPmjVGmJZT
	 /frMoWYkrjKBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB9FF80DBF;
	Thu,  6 Aug 2026 13:37:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CDD628C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7FB7880DBF
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:37:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YJbLsp9xKGgn for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:37:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8D04B80DBD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D04B80DBD
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D04B80DBD
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:37:29 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-496b7622a83so18733455e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786023447; x=1786628247;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FIFoksZ4mTBe175yvcaNvrByy5Md8O0NUTW2AtUkzK8=;
 b=UCV1jKeQsU/c6KA1kiuxv0llT2sjyRQyyr8viP9GkLJF/0KGG7oddVvseFZY+1xRN0
 /l5HP9Ck0XkN3JgjYxjEGZeQe97TG209xyDVZxisu56lvfeaFZVOBggoCNRKoyxrHSgr
 ETPu71ncIEeGR0DsPvqyHjvCAspnZpQlsBHXI4c23VGU/8/kZlte0HNNwQuTIXjghfGj
 yHtiNxI4d5hXFcSwrZdTcKucugkbHAkIuVjOhNkS3pwKdOaznzjmv7uCJjTFcmuSFW/I
 8ibS7PP/zgJGLCBSpYTkdFBfgi4iI3Y3R+qwbSJaxGRaXZc4QCYyrvx9PDYZa4AbG51F
 dE3A==
X-Gm-Message-State: AOJu0Yz6gHM9XfmWQ1bL8n9t2LLG/02DcHhFUEpOSfa75wMNPnUVLolu
 6IZvmm4RW2k2LDRY6Q5QxOPWAZSB8WL2qAop4UgAYX/AYSWM+lJyeghqX+uBwg==
X-Gm-Gg: AR+sD11qlBvvk34zX4wCr349In56qT4+8HghQ0NvRXgoO6iUamkmi225vkvpvDRdiUV
 51SjqjtouVmf4i6ruyYvQjyw6pddFaM4HPDjRPcgB9p5UNx4IOvbe6aZadduet1dmA78q558jIx
 TmxTDUa0mo3cgAJ+Z4fbHFF7Xltu2Q54qHpqltak+wn05qCeVnRmhQtIX/v4hLnAyoPFBAuqrT3
 J5vnjZPojXTbNUIylEGcrZMeSigE58iteKEzHCwFSeQ1jvka/+2bphGd/p2gg1rLcc1erPSaxnB
 oaVn6X+QKH8uyujVtCiDbv7jXSp3eWg8QwhmLZ01ze0yuQLh9Ok5JMy1TfRhvls/ZEa33mybWb6
 +BKXuSbhcPiNK/0Uon1V4Tgh+/uyvNB+fhAKc05XjZnu2dWb/3cN7JC8svY9oaos3fF5ho2jKFR
 QVRysoOPEvOZMnAbdkYKrHmr6/atJkJjTz9PblrzRw87P8hjOtAJCWZweSeatbVRccpQs=
X-Received: by 2002:a05:600d:8492:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4994e7baa73mr140987865e9.11.1786023447061; 
 Thu, 06 Aug 2026 06:37:27 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e52d819sm91691585e9.1.2026.08.06.06.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:37:26 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: [PATCH v2 0/2] cmd: allow bootd without bootm
Date: Thu,  6 Aug 2026 15:37:22 +0200
Message-ID: <20260806133724.336755-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786023447; x=1786628247;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FIFoksZ4mTBe175yvcaNvrByy5Md8O0NUTW2AtUkzK8=;
 b=pH+l4iEdjFMZNAprcPgX7DA1hJCELglqhz1oPUEuB1B4b3Tt6YxG9e7gZZj+xS+ULf
 ZmTeHw59eh9V8LGLDYoaa6puI9zKyQWocv9wVvFIizi5zjW/YMXRmRKD6z8fW+5EXXBI
 q0feCjKJnF/yOqcFNjHCJlfbt+doN62lY+SlNXNrpQcDUffa4fWvAefKRYVMB2ZaJ1zg
 Q7+invt6cuenm5bju0Oj0td1QV6Io1IYyWqI1U6snpf1omBP1XqNVpq/PmEQazRRfXii
 vrd51tswtTRzdFzBwq9GiZ1VzFDGTRkozfwXdrohci5IPztXvZ28Vs0I7/dq57FY9zGR
 JsdQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pH+l4iEd
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

do_bootd() only runs the bootcmd environment variable, but it lives in
cmd/bootm.c, which made CMD_BOOTD depend on CMD_BOOTM. The four boards
that disable bootm therefore have no "boot" or "bootd" command even
though the implementation would work for them. Move the code to its own
file and drop the dependency.

Changes in v2, all in patch 2/2 and all from Simon's review:
- drop the CONFIG_CONSOLE_RECORD ifdef around the test object and put the
  entry next to the bdinfo line; UTF_CONSOLE already makes the runner
  skip the test when console recording is unavailable
- do not depend on the shell for the return value leg: 'false' is a
  builtin of the modern hush only, and sandbox_defconfig selects the old
  one, so the leg passed for the wrong reason. Use an unknown command,
  which fails in either parser, and match only the start of the
  complaint because the two parsers word it differently
- save bootcmd with env_get() and restore it at the end, so test
  ordering cannot be affected
- assert the recursion guard, as suggested. Doing it needs a note: with
  CONFIG_HUSH_PARSER, run_command() hands the string to the parser and
  drops its flag argument, so CMD_FLAG_BOOTD never reaches cmd_process()
  and the guard cannot be reached that way. Calling do_bootd() directly
  does not reach it either, since the guard sits in cmd_process(). The
  test therefore calls cmd_process() with the flag, and sets bootcmd to
  an echo that would show up if the guard ever let it through

Patch 1/2 is unchanged and carries Tom's Reviewed-by.

Both patches are on top of baa64b2f892. "ut cmd" on sandbox runs 14 tests
with no failures, the new one included.

checkpatch reports two things I left as they are: no MAINTAINERS entry
covers cmd/bootm.c, so the new cmd/bootd.c does not need one either, and
"Possible new command - make sure you add a test" is what 2/2 does.

Mehmet Fide (2):
  cmd: allow bootd without bootm
  test: cmd: add a test for bootd

 cmd/Kconfig       |  3 +--
 cmd/Makefile      |  1 +
 cmd/bootd.c       | 30 +++++++++++++++++++++
 cmd/bootm.c       | 24 -----------------
 test/cmd/Makefile |  1 +
 test/cmd/bootd.c  | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 99 insertions(+), 26 deletions(-)
 create mode 100644 cmd/bootd.c
 create mode 100644 test/cmd/bootd.c

-- 
2.54.0

