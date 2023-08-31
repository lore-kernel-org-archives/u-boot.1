Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA0AC83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 16:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B24A86689;
	Thu, 31 Aug 2023 18:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BcYMHb8d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA5E086682; Thu, 31 Aug 2023 18:51:52 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3DC98666B
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6bdacc5ed66so532938a34.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 09:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693500707; x=1694105507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mujuCgbKXEagRFF4hWe8NRMKTbM1Xh+FJIb3R1vBomQ=;
 b=BcYMHb8dxThujVBzzhTQMUCZ9NGh3vPDB2SvQchecEs9gh8ft1ZzgQ6kXrCRmEmYAw
 vZPp49jGYoK0kZ6vbevKhHv0KNG5qEa7EB/0PArxhhvq0GeRXxwMuVKPVMPb+eQn788e
 4hnOHvjFkNwy20ysCON4dHw8bw9wM8kvMmjX2ica97mfz1/0qErpSMkf2A+2P7gJflEi
 BwS2UbtNXVZRHj+sWTOVbrJ+wyYVRXk71dHdTJwRRrWvwOl+ajFNLbjGyLERoPlrYyH4
 UbpJIPn57UtjJA5XIXugTeF4NhSmHAl/bbMScJz5BLJdqe8KSZ5sit4hJy+sELB91WW8
 ckUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693500707; x=1694105507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mujuCgbKXEagRFF4hWe8NRMKTbM1Xh+FJIb3R1vBomQ=;
 b=kLIoYRIJKp+Ly5szTNGtCXNijRBDOMi0edZrU/MJDEIvYWeFjDBGPAIoKrmnwmwZrm
 yQwrnZPLVTUTJzUuqVzDLz55IwlSDMRumaUOR/xK7TZsFeCPKpIJetiootI03HGZBIyf
 98tg+TdvVay8SlJKj9qvJZVGTD8YzNf7y1z2udDKx2rU4EPeVepkczi5TETmYi86gWMD
 KDMATygBbiVGt40+cilze+n8gz0JQuAJpENLe/0LXqONRPowLzH4WiVOS16U/BUaw8Vc
 bmMVWj6CouMcM7tQcOAQj1kCW6EMu2scqio8cTczft440bGWQdRSbkl2pGyGzRZkMJ02
 iT4Q==
X-Gm-Message-State: AOJu0Yx8cfuziH9WNtclPF5oQ+tyxAECYjvjeN/I0f499BxRj7C5QNPt
 UGFESdbnKJ5nVWs4lyRPpq4X7ljkxbw=
X-Google-Smtp-Source: AGHT+IHWwHO2VLy+1LTw/2Cekq7kyWO9aFhikVKcQLiE5dLjflb2Ys2UWC13C15jPbBFq6vItxHkAw==
X-Received: by 2002:a05:6830:2b1e:b0:6bd:9fe2:a62a with SMTP id
 l30-20020a0568302b1e00b006bd9fe2a62amr2219035otv.7.1693500707431; 
 Thu, 31 Aug 2023 09:51:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::b66b])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a9d6b8f000000b006bb334880d8sm867020otq.81.2023.08.31.09.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 09:51:46 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: u-boot@lists.denx.de
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v5 0/8] cmd: gpt: GPT manipulation improvements
Date: Thu, 31 Aug 2023 10:51:33 -0600
Message-Id: <20230831165144.592820-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828215623.3727536-1-JPEWhacker@gmail.com>
References: <20230828215623.3727536-1-JPEWhacker@gmail.com>
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

Adds several improvements and additions to the gpt command processing,
specifically (although not exclusively) for the purpose of supporting
"ping-pong" booting when doing A/B boot partitions with u-boot itself.

In this mechanism, u-boot must boot up, and then check if the correct
boot partition is active, and if not switch the GPT partition table to
the other boot partition and reboot to activate the other u-boot.

In order to facilitate this, the gpt command needs to be better at
preserving entry attributes when manipulating the partition table. It
also learns two new commands, one which can swap the order of partitions
in the table, and another that lets it change which partitions have the
bootable flag.

V2: Add documentation and tests
V3: Review Feedback
V4: More review feedback. Fixed 'gpt swap-position' to work with
    missing partition indexes.
V5: Rename 'gpt swap-position' -> 'gpt transpose', taking inspiration
    from `sgdisk --transpose`

Joshua Watt (8):
  cmd: gpt: Remove confusing help text
  doc: Add gpt command documentation
  tests: gpt: Remove test order dependency
  cmd: gpt: Add gpt_partition_bootable variable
  cmd: gpt: Add command to set bootable flags
  cmd: gpt: Preserve type GUID if enabled
  cmd: gpt: Preserve bootable flag
  cmd: gpt: Add command to swap partition order

 cmd/gpt.c                 | 156 ++++++++++++++++++++++++--
 doc/usage/cmd/gpt.rst     | 226 ++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst       |   1 +
 test/py/tests/test_gpt.py | 160 +++++++++++++++++++++++++--
 4 files changed, 524 insertions(+), 19 deletions(-)
 create mode 100644 doc/usage/cmd/gpt.rst

-- 
2.34.1

