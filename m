Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E026CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 17:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5FE287D37;
	Wed,  1 Nov 2023 18:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B8KPsDNX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BDD387D5F; Wed,  1 Nov 2023 18:18:04 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF59876E1
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 18:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7a694a365d9so268159739f.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698859077; x=1699463877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6tYLQTbqJgr62TAm8CCgJE3qm33z0JIr3VJOUs1ce/k=;
 b=B8KPsDNXwRG3r5GvbkzskdGBDhRAU7+GKP+WF3lPbr/Z7YIytrj+Tp+DxQ0FV+WmxJ
 R01NuwMxTLkiI4i4JRRd6FlA+8tv4VCsHfWFRtyzznazOaxOjdmNMRPBZhlCwQy67CHG
 Bpm/8I3Y+swYF45i6UPbOYPnZC6gmCyUqdMkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698859077; x=1699463877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6tYLQTbqJgr62TAm8CCgJE3qm33z0JIr3VJOUs1ce/k=;
 b=aYmupBd0egFYBJQ9vLHdKcoYNLgdMczvFOJXyaYU2gHoBgp9OhD81HgXQda0mMqf2x
 Q/hVBEpA2oFGGHSY6SFdZxjTEsC12yFVRjL/xQrfVM+/NC+DS9d/i6j8QZ3sggxeW6h+
 u56alSi6M7BI0G+UKYic/FgzEL40IAlFMTlmPGotBeULnzgNZ/VeG9rZhy/F1P1jISzM
 /vBdTE7J2qZEvb3uDwYN9ZSkToWxAvpZ+5fDPJfyY93qYv1Dt1+HyFeAG+Qwbve7w8qg
 iS5Ltg4sOe2xfR9FTQ5oppudE+LX68DEo3E/XiZzLzWy8Oaip/wOcHstXWhJ9xoZO0Vc
 MUnQ==
X-Gm-Message-State: AOJu0YwKIzoDHKvoyRyBDq+AfcGOE0ZYcHTfd3rdGfoFGhCuQKP0sZiw
 KSz1lHQTsPYvCsoKVQHvTJQVOI81owtXn91j/QuamA==
X-Google-Smtp-Source: AGHT+IFzPCOQDZWfZx3B70KUHNePBEpwd2Yu0PwPLIiSyTTvbtt9zXkYEjBfxSc8HP+VBZkloLfDtw==
X-Received: by 2002:a05:6602:2e8b:b0:7a9:b1ad:dddd with SMTP id
 m11-20020a0566022e8b00b007a9b1adddddmr20148092iow.12.1698859077530; 
 Wed, 01 Nov 2023 10:17:57 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:1e5:3cc7:2119:ada8])
 by smtp.gmail.com with ESMTPSA id
 f29-20020a056638329d00b0042b1061c6a8sm1029401jav.84.2023.11.01.10.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 10:17:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] u_boot_pylib: Ensure subprocess is closed down
Date: Wed,  1 Nov 2023 11:17:50 -0600
Message-ID: <20231101171753.88754-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
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

It isn't clear why we need to have two different paths for closing down
the pipe. Unify them and use the Python to avoid this warning:

  subprocess.py:1127: ResourceWarning: subprocess 83531 is still running

Note that this code appears to originally have come from [1] and was
committed into the ChromeOS chromiumos/platform/crosutils repo in the
bin/cros_image_to_target.py file. The addition of the extra code path
came later, so that is chosen for the fixes tag.

[1] https://codereview.chromium.org/3391008

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: a10fd93cbc patman: Make command methods return a CommandResult
---

 tools/u_boot_pylib/command.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/u_boot_pylib/command.py b/tools/u_boot_pylib/command.py
index 9bbfc5bdd83..bbe95d86122 100644
--- a/tools/u_boot_pylib/command.py
+++ b/tools/u_boot_pylib/command.py
@@ -105,9 +105,7 @@ def run_pipe(pipe_list, infile=None, outfile=None,
                 last_pipe.communicate_filter(output_func))
         if result.stdout and oneline:
             result.output = result.stdout.rstrip(b'\r\n')
-        result.return_code = last_pipe.wait()
-    else:
-        result.return_code = os.waitpid(last_pipe.pid, 0)[1]
+    result.return_code = last_pipe.wait()
     if raise_on_error and result.return_code:
         raise Exception("Error running '%s'" % user_pipestr)
     return result.to_output(binary)
-- 
2.42.0.820.g83a721a137-goog

