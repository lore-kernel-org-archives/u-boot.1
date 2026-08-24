Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9FCC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3EF20406C9;
	Mon, 24 Aug 2026 08:44:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SAGxshTYSjC5; Mon, 24 Aug 2026 08:44:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561076;
	bh=NxX/jq5N/7gUFyiyVBPd1k1A4YIOWlYNJjNIgmF990o=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DT3fOh+lTFOQULuBJWplpgnaX60sdaQYt0HFX4Pi+CiFIyQ4/Qxzdym3tNoBnZpY3
	 Iw/97DUeBQ6VFKXeO1Ebx82wZ+mxD/hGAeubqMBI4iDiYEHLrMfFNdvo1kzl3qLVWD
	 GbQccVUgpEglyGoGU+LuhzBvL8F+SjZQWtUhPNTb/r9YsylQpXWq39Nb+XUOIAzjdG
	 UYy/z11ZFjH+NNHx154D0ICtIlVNVcaQagNlufKstzvIIuOKWsezYkFD/iomGxLaoR
	 nC8Xb/9x1Kxb+zzwuE5xCsElrZp2yxcZvFuinPbkGF/FBFmFz/f3caERU91Kxf+R58
	 XDj1h1C3xalnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CFF5406BF;
	Mon, 24 Aug 2026 08:44:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C0015230
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B22F46060A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqzuJgCo4jSK for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:44:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bS3eFJHQ
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 63C87605F9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:27 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so14541855e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787561065; x=1788165865;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NxX/jq5N/7gUFyiyVBPd1k1A4YIOWlYNJjNIgmF990o=;
 b=bS3eFJHQ+/CKcf0pBnTN+7CU92kf4Mmb/Z2ssrs1KygxOcW64Cj0yFaW6v3aOG+kGM
 PXs7OfX6N5QQk8oBH0oM7vlOaWWHXl0GOeDj2rhBl464PgMb9COVEfztudfd3RrrxbvF
 G/2kFyb2cg5P7OI0TfhP4lLOKkIZnzr/yWMuPiOMhhi2RRmTJ8RR/mafHLJsrWklW8Y3
 inNFlCEtY0oMdfQGOhxSjditbAy63jaMGY52cWU0JeWhtUSZe0UdlJUwLWpp6IzUe4W3
 hrEocUnUSWf9SIqgmgVbilgaZ8mlHW1A40Xw9F5WdNU6KpqKRTdj17nvKFNRbBvop3AZ
 6WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561065; x=1788165865;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NxX/jq5N/7gUFyiyVBPd1k1A4YIOWlYNJjNIgmF990o=;
 b=aZKDLvh2lITRp1fHH1DRqSkZBuPnUxc6Iwew+kPEh8evyu9HOXhfeXT/76omxJxnqG
 xM0tubGzLCLNfW6u9vTrUzLDWGEqffUCIY1zxloAVlbIp9ZG4emUXGs1nU+tRX6EXm6p
 OV1eJcJ8VAOPK0qO7wx4iRpelFW+51YpKsAuvgoCDxhP+l813wlyoqtIlg8LF7y4cZp2
 LFErIm+NUPu+7J24MYULQOV2KdcQqz3LzIlFoKbMDcg3FPoRMvF/Ok3SWauqPpec9YzZ
 3mAiEiitD2/QZPQLbZjr0Ij9GrDQy9fyZMlp9JvE98Y1ZmZbMTnZWdEaneLg5J1HuY9H
 COcg==
X-Gm-Message-State: AFuF++mFjLfsnTsLgRTmIclT5ZdWHJ9UDHC2KUaVYYisyrfhNGHVxiqE
 xPmG9UbzjsPTeAB7ZggTzQ2g9VHq9qaKIs64fVP80szaurNYwnUXRWOqmoSXJrUiHKQ=
X-Gm-Gg: AR+sD12R3o5gZg0Qr3YQtDpH3NYXI/685tN99EurSHYnwvd4nEI+jnea7uErpuMVAiO
 Ppvdv4awJ7IH5o2piE1eVFFzuZyw+1ekCyw/YmyrElk3jTfpDXcKp3FmqPDax/RiH8eu/CdvbBT
 TyC2tWJ+65S5hM76HtUTNYfLL7BQ14IOP63G4PWdaEe3hJHi6AId2bybEvbLk80V9cNyDmzPj29
 WKcexIAdXJNdahUtTWauchoUfMNRvupTwR3USoy7HW4027nMhyJGmeB8qtl7EpqyHijPJhivojQ
 ToYDIt1Ws/LBgwLUz6SB9aRVusV2vSn7QOUAFaYn8MUM8VnqGf+v/pZjHd/Bgs33bBttW1KDuJi
 5W/or0megelidPNj6Hn5WoVxO9S2JwTQODo6r4P8uCCQiRfjKrbBS/sSNyjnJtXUnS9G5HwYt55
 eW2ifLkkWbWGFMXAxxNrmiGvfOdFV8BdTkwDKZ46M4QS9wMS8WmnxqcoDdoYkBAlhg1Gjh4UAsF
 t6aOqnZzYk3rOXeX+MXXf6pbyW2HQGv/6id3MuFJ7BzYVZk5PGYMIerEqvO+XpoMETvlzNAxA/0
 e5YNOa+fiyBL6QM1tlQmWVLaekuuV1u0qr+ErNp7kiLPcQ==
X-Received: by 2002:a05:600c:3544:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-499b8301874mr260465015e9.7.1787561065176; 
 Mon, 24 Aug 2026 01:44:25 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c35a1aeasm79788475e9.12.2026.08.24.01.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:44:24 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/3] Improve logging on missing uclass
Date: Mon, 24 Aug 2026 10:44:15 +0200
Message-Id: <20260824-improve-logging-on-missing-uclass-v2-0-4bee2cdff72b@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOQQ6DIBREr2JY9zdoKZqueo/GBSLgb1QMX0mN8
 e4Ve4Lu5iWTN7MxMgENsUe2sWAiEvrxgOKSMd2p0RnA9mBW8ELyikvAYQo+Gui9czg68CMMSJT
 iontFBKqUWkilrcpv7PBMwVj8nBuv+se0NG+j5yROjQ5p9mE9T8Q89f7ZizlwaEVZWs7vworq2
 ai1xyaYq/YDq/d9/wKug/Ry5wAAAA==
X-Change-ID: 20260806-improve-logging-on-missing-uclass-a76c46acfa13
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, dlechner@baylibre.com
X-Mailer: b4 0.15.2
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

While writing a MISC driver, I forgot to enable CONFIG_MISC. The only thing
I got at boot was the following obscure error, with no hint about the root
cause:

  initcall_run_r(): initcall initr_dm() failed
  ### ERROR ### Please RESET the board ###

Commit 3346c87625b8 ("dm: Improve handling of a missing uclass") already
tried to improve this case by returning a strange error code and adding a
debug message. But since neither the debug message nor the return code are
displayed by default, it was not very helpful in practice.

This series improves the situation in a few ways:
 - a new dm_err() helper logs driver model errors at ERROR level, and the
   boolean DM_WARN option becomes a per-stage log verbosity choice
   (DM_NONE / DM_ERR / DM_WARN) with errors emitted by default. Note that
   a disabled level is not removed entirely but degraded to DEBUG level,
   which is compiled out by default, so even DM_NONE can still emit these
   messages as debug output when debug logging is enabled;
 - the missing-uclass message now uses dm_err(), so it shows up by default,
   with a shorter string to limit the code-size overhead;
 - the initcall failure now prints the actual error code (and its string
   when ERRNO_STR is enabled), for both INITCALL() and INITCALL_EVT().

The existing DM_DEBUG option is left as-is for now: it works differently
(it adds -DDEBUG to drivers/core/ via the Makefile and is not phase-aware).
Unifying it into the new choice, along with converting the DM core debug()
statements to log() as suggested in the "To Do" section of
doc/develop/logging.rst, could be a follow-up series.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- dm: replace the boolean DM_WARN option with a per-stage log verbosity
  choice (DM_NONE / DM_ERR / DM_WARN) and add a dm_err() helper, rather
  than logging the missing-uclass message with a hardcoded log() call
  (suggested by Simon)
- dm: de-duplicate the util.h helpers to only select the log level
  (suggested by Simon)
- dm: split the change into the generic mechanism and its user in uclass.c
- dm: shorten the missing-uclass message to limit the SPL/TPL size overhead
- initcall: use the %dE format so no dangling ": " is printed when
  ERRNO_STR is disabled, and give INITCALL_EVT() the same treatment
- Link to v1: https://patch.msgid.link/20260806-improve-logging-on-missing-uclass-v1-0-d477f0054f48@baylibre.com

To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>

---
Julien Stephan (3):
      dm: add dm_err() and a driver model log verbosity choice
      dm: uclass: use dm_err() for a missing uclass
      initcall: initcall_evt: display error code on error

 drivers/core/Kconfig  | 75 ++++++++++++++++++++++++++++++++++++++++++---------
 drivers/core/uclass.c |  3 +--
 include/dm/util.h     | 19 +++++++++++--
 include/initcall.h    | 14 +++++-----
 4 files changed, 88 insertions(+), 23 deletions(-)
---
base-commit: f562ed02aa7ae4dc2775d90d2e6c40bab82e2715
change-id: 20260806-improve-logging-on-missing-uclass-a76c46acfa13

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

