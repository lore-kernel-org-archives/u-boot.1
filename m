Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF86BD26D7A
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 17:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664B584379;
	Fri,  9 Jan 2026 18:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KdY08Xbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D4684379; Fri,  9 Jan 2026 18:29:11 +0100 (CET)
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60B484377
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 18:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc41.google.com with SMTP id
 006d021491bc7-659848c994bso2339854eaf.3
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767979747; x=1768584547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mqykWzuZiwE1ks/IzyeJb/3txTeB1JtLAZZjtyaLBkA=;
 b=KdY08XbnJz2JFol5QuE9oJ+Sp5+jMWsSbchSgyeHxgvU4HfI4E+XTLICma6nQxMfkS
 Q+T7QC2ZAO1ldXg/VTBEHoZEjHPZwJqn/gKf9PxAW27rLI80kT0xTzldhpiN7r+K1dhZ
 hBonub6cOE0MzxObQkV+XIzz/0LFjgnEx33OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767979747; x=1768584547;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mqykWzuZiwE1ks/IzyeJb/3txTeB1JtLAZZjtyaLBkA=;
 b=oYau8QUiDVTswu/ZZ02DWwTofGlr0M5aiY7G7CTUnpajuMbh4LZxWAyMGN4zfi5Ehz
 GRCojC/v1db10UXcEDcLNG00n98X+GNJgT7emZjLlLeDpsjNsTlqdJN6ksjv6IOdJL/H
 q9DMVH5lsTK2vLg7jFbMUQ77xPFmxrfUdecqXTGJxWjTqvFafDNoDKwBqFik/1/t/k7G
 jPtShGFBHzv/fAvYg2H2BsX7tGO+KZe6YGpdhxhGxSIQqfyXyZqtFH2b8fTyJHDEEwEB
 OOEPj06erywKS654GA8CQSXso8IGXsQO0jPhlPyDKbtaIPJl8hVYAsrJtmtKJ1hqKso/
 3icw==
X-Gm-Message-State: AOJu0YyAI0Wewt34mZRDe/YyABJgGL6rQL1rVu82pkZzF495nbLoXcLr
 JXBzx/voUwq82HbAkdcOLVNrm/VVcR3XGX4Q8RnTdrAve4NN+RDZX7NgKQhDZccWT8piIFwvkDx
 PGCP7DEs=
X-Gm-Gg: AY/fxX7oDIRi2KUJ/iWIAk49V7yvyL1RgIZjLYD83Jnkw1ROQ5whkrmU9e2iSahRbfW
 nBywc91u+Q50bU/S9YAjs1k4l5Xl2PZLbmnfB1DNh9Qmrj8nfH6AlR7lCKYNUIUQKaExUYHrbgJ
 ZubKWv34eHFw9IKoA8MNfeOnxrcA5Ju1CH7GkdySr7qku+XZBUXojMJeNkVL4SiD8inX5quuYYf
 QFQVn5fMrfMIk3cs2nySLPC70UwXqI2NIRx7QvOgsPbc3xNY0WIEBbNakG3/rAa/p+Jt4iNUfW7
 hITVxkcITWmJQqIimgpnG0SIk5YFp5jSWiu2c3clvQB92jhjFiL2Gr0evEbx72jR9kn0tcnDe9T
 FSl7qu1uz9OBdAHNZAY0NL1wNAOMjnTLDhj/FErEDxeTQU1NyYsdeFTJJ3lN1SxDwUpj8BIQ4eD
 SKwwMvX5uOS2WMpnKVgq1CBKtniFKAZjtq0H/6VYljIit5Z8IE+4vg0qAHb6+OTvqwUTUEtVCrn
 I2SCpVoVCE+SGSz9kLglovsmlZqn3y9qeNXFXcNLA==
X-Google-Smtp-Source: AGHT+IGVJ214c4UtswobutFplSEiQQBBGloSogO/lnhWPX1G6BSjBZiA1h5qr2LwcQyNNVXIfIC86w==
X-Received: by 2002:a05:6820:814:b0:65c:f17f:d740 with SMTP id
 006d021491bc7-65f54ed4041mr5036634eaf.13.1767979747601; 
 Fri, 09 Jan 2026 09:29:07 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48bbb3f1sm4471669eaf.4.2026.01.09.09.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 09:29:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: E Shattow <e@freeshell.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH] doc/develop/process.rst: Expand on the Custodian workflow
Date: Fri,  9 Jan 2026 11:29:05 -0600
Message-ID: <20260109172905.1446923-1-trini@konsulko.com>
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

As seen with a recent pull request, there have been implicit assumptions
about how much custodians can change patches before applying and merging
them. This has lead to an unfortunate situation with a contributor being
understandably upset about the changes.

To avoid this in the future, document a few things:
- Non-trivial changes to make something apply need to have at least
  [name: what] in the commit message.
- Only trivial and obviously correct changes can be made by the
  custodian, and ideally this is done in a merge commit and not the
  patch itself.
- It is the responsibility of the custodian to gather relevant tags that
  have been provided by the community.

Link: https://lore.kernel.org/u-boot/1faefbf2-e8b0-4c94-85f5-025355915e0d@gmx.de/
Signed-off-by: Tom Rini <trini@konsulko.com>
---
With this, Heinrich, per E Shattow's comment on IRC, can you please
revert the commit in question, then apply his patch as-is, and then your
changes as a new patch in order to show correct history?

And I realize at this point the subsection of this document is a bit
wordy. Maybe a follow-up of restructuring this part of the document
would be helpful? I'm not sure what would flow better however.

Cc: E Shattow <e@freeshell.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/develop/process.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/doc/develop/process.rst b/doc/develop/process.rst
index 4bfbf0eb9c63..84ab09132a0b 100644
--- a/doc/develop/process.rst
+++ b/doc/develop/process.rst
@@ -244,7 +244,12 @@ like this:
       custodian can also accept patches against older code.  It can be
       difficult to find the correct balance between putting too much work on
       the custodian or too much work on an individual submitting a patch when
-      something does not apply cleanly.
+      something does not apply cleanly. If non-trivial changes need to be made
+      for it to apply the custodian is expected to annotate the commit message
+      with ``[name: note about changes made]``. Furthermore, only trivial and
+      obviously correct changes can be made, no other changes should be made to
+      the patch itself. Ideally all of these changes will be in a merge commit,
+      and not the commit itself, but that is not always possible.
 
    #. Passes :doc:`ci_testing` as this checks for new warnings and other issues.
 
@@ -255,6 +260,8 @@ like this:
 
 #. Commits must show original author in the ``author`` field and include all of
    the ``Signed-off-by``, ``Reviewed-by``, etc, tags that have been submitted.
+   It is the responsibility of the custodian to gather these additional tags as
+   most tooling makes this easy.
 
 #. The final decision to accept or reject a patch comes down to the custodian
    in question.
-- 
2.43.0

