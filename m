Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87717CAC5AC
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 17:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E65A80107;
	Tue, 23 Sep 2025 19:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C6pPTStB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67D6F80C93; Tue, 23 Sep 2025 19:54:34 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A348800B6
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 19:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-42576a07eeeso21909055ab.0
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 10:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758650071; x=1759254871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NDxmdQfab9kb3drRFTjEw4NXSV78Dl0ykbUsJv7SCF0=;
 b=C6pPTStB5Kj75csy4qgh79DVV0kL1kTg/z6HLjNkSArbVtXYGhrkwcnW5vDwLABL7l
 Hzzo1KKXZC+sND50yqk1SO/aSamk5CrpZ8cYIOru3DKm/gY2C8aYheiCaegxXS5qYk1h
 Gl8PsmDiGEuCK0do444yqBBE/AU6zykuGe0Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758650071; x=1759254871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NDxmdQfab9kb3drRFTjEw4NXSV78Dl0ykbUsJv7SCF0=;
 b=e4oPENdlfHTxetQyHWiUL8qJ8Wj+sW+XxDIrU2ceqiYojCd9mOFOg9P4y9kS0ppmjM
 4VFwbibBVzuZmKJScf7ff4JBeJzmfvVV1skmeTIerujgPGC+g1PmDv1pdFEXa3zrNEDX
 DFLrpbbZbzO7qxDSDmhrZaYPI48b7UtCMWBHO/BIEmx8uIqZSyaWmP2V7lrXACOyeWcN
 dMen7hSzp1oT7MHQ0QNrXDaQt6FEfrjHMxOdf/BIKtg20ILKm8D2IvrYvvIt0eOkWiMl
 iTlmSgAxQNWzuVgyF2TDaGH6qhz5cE3eCRMSiNzjTTv4xnAA9wDbS1OwM8E7ihKRzzMg
 JZPA==
X-Gm-Message-State: AOJu0YzHBcTvyILHQM5Yx9WKFjK23SET6R4tZurTCB8dSbv4+g6/pdW2
 T/izsx8f9/0Te9EAr6jUb/ZDkx95WrECr9lgrLCkiS9Cv4h56Z4B9gVapw96cXfe6adDkZ6cD6Y
 3cbtPsjI=
X-Gm-Gg: ASbGncsSZqYrJTeyjhGHeRgJHQ1vJZVYeXBcT5ELUthZyOJ30e/H8SkNj+gZhc0KbS5
 opXU2lTxsP/5s43ddcZI0YUvDD3/J+arbjNnIKJj+y3UXRk1SvI7aBIXef41jZmnNQnbKVfWuqx
 UC6LsOeKH6AIPmq+QdLnVVmm4mgI899NG/C6Z1An6cn2x2zyqXm/Ii8hmECYWUpiPmdbju2LVwi
 EK/IAssfPezT6xLewa0HpLtA4o1zriJhYaxueVHt9XE1fhJxR4fHF+lLrHgvF1cESKRmH/nBwr+
 Wxtedp7jxySHlDPdW6f/0rPOxAvZj5U1VUezr0aoAho4eRkt3NVKFngGhdVQjY6D8v93BCi6g0H
 jhsM418QcylafBEebgTpLHRwER38Pnnh/bnPiJPssJJIEYkeUrarhOzwU84c=
X-Google-Smtp-Source: AGHT+IHNZivbKunbPLYVBNWdoFsM5sVv598YaCyrf1ONEpsSPgnddb0bKL/CirL9pe2xByRDpDRx+g==
X-Received: by 2002:a05:6e02:2169:b0:424:7f5a:9423 with SMTP id
 e9e14a558f8ab-42581e6f594mr50078875ab.19.1758650070927; 
 Tue, 23 Sep 2025 10:54:30 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-4244a493b40sm73443865ab.12.2025.09.23.10.54.30
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 10:54:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] doc: develop: process: Add note about asking for feedback
Date: Tue, 23 Sep 2025 11:54:29 -0600
Message-ID: <20250923175429.204668-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

It can be unclear to contributors what to do if they haven't gotten any
feedback on patches they have submitted. Add a sentence saying that if
they feel it's been too long without any comment, it's OK to reply
again.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/process.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 0c6fb31e87b9..4bfbf0eb9c63 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -139,7 +139,9 @@ comments). Even a "I have no time now, will look into it later"
 message is better than nothing. Also, if there are remarks to a
 patch, these should leave no doubt if they were just comments and the
 patch will be accepted anyway, or if the patch should be
-reworked/resubmitted, or if it was rejected.
+reworked/resubmitted, or if it was rejected. However, if a submitter
+feels it has been too long since posting their patch and not received
+any feedback, it is OK to follow-up and ask.
 
 Review Process, Git Tags
 ------------------------
-- 
2.43.0

