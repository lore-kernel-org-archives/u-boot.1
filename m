Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5259C5AC7C
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 712E860823;
	Thu,  6 Aug 2026 13:05:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tJx9w90cGSUc; Thu,  6 Aug 2026 13:05:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 97AD16081D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021526;
	bh=/DUa9g+4prD/Bu7uL5np+nErLIqTz2mTpbV5e195wik=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1C3PE34NRyv1/EAcfC2bjJ1r1lB/uYJCdgsZfmAwBnK5XYs/gH71cdd8aFImsXpFG
	 Ui1jiy9FrzlU3szzp78QtUa1nibOO2ji4xCiz5Q7EXKHEif+1Rx1U+Uh+R17qzM7R2
	 N+6h6weVHldMZZO1vry7508/S2Dnpj2TdfiZSR2/CLiEo05VwTTy39rpHv8MbqyC3O
	 l3i3vxkxwyWF51jqWaslXuyZenkUY0ShRzDHqRW1IEY20bA+ZSXOTCAleQq7D68WSF
	 3EJlUUDARau7xcVpPXTLRKFWwJxQzZTnD4MhoUt0oSLu0nJa5CODVzJObryQm8HLO+
	 w0NS/PgCpHWSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97AD16081D;
	Thu,  6 Aug 2026 13:05:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 278233F9
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 017AE407D2
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:05:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wr-l_20_2cgr for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:05:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C8CD940799
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8CD940799
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C8CD940799
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:05:21 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so13375535e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786021519; x=1786626319;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/DUa9g+4prD/Bu7uL5np+nErLIqTz2mTpbV5e195wik=;
 b=dQwt4j3+bVuST+gYMqwoflrAJeTmitGZNslUUsOdUTQxoOg6Fes2QFj30OjiZX/FNS
 DsDyxnONzaCLRaxEeOd5Xua5wCqtzKai/Q1lV7XUorqTsJEMLC+6A2MOpDDX98W5KY7X
 Dv75oUTgVrNHIBDOQJ54b3pa6ieitAAY3GhqK2lTWOI0Pp4AVAIjktWWrLITQMgYsuAG
 2aQ2i+63a+l0CRk6ddESTf0kgm+jkzb/2CQp/Gsh9O7X/cOmGwA5mZ75z2WfwL6vBtde
 IYuyzGPtlBVnoPIqaUcqTXpL++ipFJ1q1S3djUJLBduat3IxHoCPwZ0xUBAIH1s/AQ1u
 5dYw==
X-Gm-Message-State: AOJu0Yz/7JyVNc77lFpBbAJjVxk2mTANuHNz1yJVUvlFID9a/pAPGy7U
 +Z2HKLhcsrVZACchwB7U1fFGjpD4ElQ4U0YtBPisH4N5C+Jmq54lOdsLT+Q+9T9KabE=
X-Gm-Gg: AR+sD12/5DgePF4eSTdIXiOlKXk4Ns5Uo0gnVM48Ix2vQdR66pzgvsewR8x7dcG1rhq
 LG+kYWXFlvqMSOV7UNQq1VV8nWvmdBykfRgIaoQBm3KIufU5e0KKtmnxdt6hehtQoAvT5zp5/8N
 msZpDQ4Vf/Qe2wBNjaLfrpgLcVusWSGMcuY9bxSBnBrfZLOVbhqg9Hi+4AZhw+R3GBi6nGAuCdS
 ogcB2CBARoVA2P82512+7hoB7eNOZD8ZWe6yU7YRY2AqqiUA9CD6O0HH3g8jLhUdhY8FZzvpJnl
 WhYAkOtv5lRguT/evte+Di2fzwVg7CbW/HkIbF2z/haifObK5F3vIGGsLF/ohqn2PMy+siielsL
 p1rtKOmTVB2u/2eMLrG1TfzBmoScjPeJnMP3Oeqf/zebP3dEwYK6f/duTrshbeD0ijaHSvWjdo5
 fMbY3uWsHMta/qPtPd5g7GIHplSWDs3nC0gZNSYXchtz4haKMPCRUrIjD5IeSch4sSHOAxtdf6Y
 ITKe8pZ7iL5QCsxmp6+lQgINN+2bQPcW+qcwE1aS7GqtHHXJD5yXWlCI251xlLdRt6wvGTlGEsG
 1ki4viYOrLrZv8KxSza/2OPIF7DhFeI41xdD0eL4EAqlLrQdv/1MtUNU
X-Received: by 2002:a05:600c:1c21:b0:493:e460:1f6 with SMTP id
 5b1f17b1804b1-4994e6fe377mr189010995e9.0.1786021519259; 
 Thu, 06 Aug 2026 06:05:19 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542241c4sm58739975e9.11.2026.08.06.06.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:05:18 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/2] Improve logging on missing uclass
Date: Thu, 06 Aug 2026 15:05:18 +0200
Message-Id: <20260806-improve-logging-on-missing-uclass-v1-0-d477f0054f48@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CQAyF4auQrm0yoBmNVzEuai1jDcyQKRATw
 t0dYPe+zf8WMMkqBvdqgSyzmqZYUJ8q4A/FIKjvYmhc493NedR+yGkW7FIIGgOmiL2abXPijsy
 Qrp4vnril+gylM2Rp9bd/PJ6HbXp9hcctDOv6BzffFESFAAAA
X-Change-ID: 20260806-improve-logging-on-missing-uclass-a76c46acfa13
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Stephan <jstephan@baylibre.com>, dlechner@baylibre.com
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786021519; x=1786626319;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/DUa9g+4prD/Bu7uL5np+nErLIqTz2mTpbV5e195wik=;
 b=S2tKwDzBKIO4WZF8o8XmAocBKKuDHrnGBQHPxjkDyAsKuN3JLjhxG8+W6OTWb16II3
 V7Li+WToRUJlMQVDBd6Fuoag3k9d1gIA2CkaZxmIVUzz7EwOHMx7VLyQzHijXyexvUNK
 wEfiAm1oPXW5bZQSnnt3ZBLlB6NNK3bOLC1sOWzADreUnPVBOqOu/PJ1yFjvynFIGzii
 GrbEPHfsZMhe1ROpcwHC0WjWidc8n7fSI9K8MbZ58IwWPS1G/8AaUOhLw5imF131SUgT
 6VVk+cb57KqB41AI8gwLt67/22EkYzDJ0RCEEswXGrAfC5m4ud2Jqrh9LJln4OfaSU+o
 Yfqg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=S2tKwDzB
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

While writing a MISC driver, I forgot to enable CONFIG_MISC. The only thing
I got at boot was the following obscure error, with no hint about the root
cause:

  initcall_run_r(): initcall initr_dm() failed
  ### ERROR ### Please RESET the board ###

Commit 3346c87625b8 ("dm: Improve handling of a missing uclass") already
tried to improve this case by returning a strange error code and adding a
debug message. But since neither the debug message nor the return code are
displayed by default, it was not very helpful in practice.

This series improves the situation in two ways:
 - the missing uclass message is now logged at ERROR level, so it shows up
   by default;
 - the initcall failure now prints the actual error code (and its string
   when ERRNO_STR is enabled), making the root cause easier to track down.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (2):
      dm: improve logging for missing uclass
      initcall: display error code on error

 drivers/core/uclass.c | 5 +++--
 include/initcall.h    | 8 +++++---
 2 files changed, 8 insertions(+), 5 deletions(-)
---
base-commit: f562ed02aa7ae4dc2775d90d2e6c40bab82e2715
change-id: 20260806-improve-logging-on-missing-uclass-a76c46acfa13

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

