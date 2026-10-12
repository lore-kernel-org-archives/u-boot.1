Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82192CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56E0860675;
	Mon, 12 Oct 2026 14:01:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b3xH27El6920; Mon, 12 Oct 2026 14:01:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 936A160690
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813693;
	b=r6Vn+/KpQUply7Bed8PPKwIZXN4pAKvy8eQKA2nUoHHOjUOC0Hnr4ovzeYMonZte1tp4
	 0oB9l0uG1HpkkocsIRVRodsZ/AMKhtWFsa1YLdFQdMG1ZM5zvPaDOY6R3SxadhDqhvQdW
	 cOZodZ9cpyEyQrzb7UhyPEp3YafcVojlw6ogNNMdddOEv29iXbCKu+RLzxkSYoiVd0JKD
	 zkKL2EHre/h82CDiThDK5GeMdhJqYnhMLdsluNeuAFsbc3GcScTHUWunYqjyF5OQnTUdT
	 y57m0Awop/0tee7uId1d5kJVJAde4E/LALp3u3J8pBHKPq54cBx6jzp4WATgTB5ZnUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4J9yr73r6ct5cWEU22m05yeks1AqwUzhiTbfVukubqk=;
	b=nUWhspD7F2cb+1ulBxecoaGaN209wVpaTY6b94R15OvO6npieBaxbHLC4xMU/FEyj+Vn
	 zkHccXcVo04T979r0cm9NbHDD7d61bFY63OSC7m/CBgqprHvG7PTiKJEuD8w6zXDdX94A
	 LfhCayrTcGz7rLF+HlF7uUvMlwYcrJCuG2CHAHUdJkycdnv57pkcFngjV2E/+u7KSXLMO
	 fEwUeQaZn9EnVwt1Y9bdX6kfLG2T3YZq7M70P2CalfzMBsRsGACSAb9cLHnSSaz7p2Zzu
	 B7MGtnNGNoAXG2TNpP9bOzyFh5ttkfPTQBJ0i6jD8Q94gy33YDMKCE73ufDI0AEB7Cw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=tV3l3Q8d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813693;
	bh=4J9yr73r6ct5cWEU22m05yeks1AqwUzhiTbfVukubqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vhR+qeYfVfzKqUDY3OE4Gvdkw7lwgg0mh0F7NIL37/aFIdyZdQAUarBJGpr76oDGY
	 tesqCszSe3d5Px25dns/BUnDL8mFGJ5cyEFUT5aQVF1dhlp4bAVijp9BtMxXVxzTQh
	 LPW3izZ/phEIKvffUa99VuLH6TTLG84+RHXUeDKOztvOyvRo+njMrJ6vQWuMCZPbQK
	 ZsUBgZsKv3rB6BhnSsWRCv9Yg8YkTGCVLNCNnTDTnLbuMSHB17aaw5AODZt7hD3FjA
	 La0wfl/DS/U1HWbIcwVjS+JTkZLM+UAf1N9Vo6hQ4hKE4m/Qy5NrMl+HzvattH2gMo
	 BN3/t4VGZlWRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 936A160690;
	Mon, 12 Oct 2026 14:01:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BD34179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C6EF6066D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pFJaU8LdKbDm for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:01:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 989656067D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791813688;
 b=UZwPXzSw9rUvbNqEgDAeyr+7327xl6DmzqFRDk0ZfZyRjOr5FHTFtGhCmZOAG214i32Y
 IvDO0W2/1fUPEi0BQfw9AOZMR3rfeTh6Y1i9dqUhuKtCfsQQ/yX/I+qDSf7mhe5Xnda42
 JQhQYD/hMIjXpCaElcLxI3q+1BkB5cKl0PE4niNT+4+n+I9NnnRESr7ioWHfEbHRoja3b
 vZmXjKBVfKalFvSmY4lA7i5W2+KKVgw5t7I8wS3WkwpTqIlNk81m72jfHpRwcjlHeefgF
 bcGT/vPsO3ivH9336EOP10YXt45kEdzlz0lBF7Wr67NiHPYLbaw0xnFRy6y5862852g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813688;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=4J9yr73r6ct5cWEU22m05yeks1AqwUzhiTbfVukubqk=;
 b=InI5FCb3wHTDYg3pvKYt6iBUY/3s20iwDtndIeF2fYQcsYOHiNLT0Gb5vtqBZLd1QuQa
 fiUpKDePjrCR55uCeGTTR66Wk4xKRunXo1xqIlax3Vmyx1TLwfQOk4C4hyRyOiHg6+7O/
 hVRceYpixgjpOYF6PkMrAxoVyIS8V+aJ+GGCepdHa0YLtvQvJw4d4AsQPHEF6KlRqiRuM
 jdMjtCk1wwphLQddgrXPv5jpHfGQx0friVV94oniOsR+NrQZheHnYFq7DyRnZ1iPZxWPr
 Jh5HkOUxMzf7SwHeptUeQOLPmAJllpj0unWM4tYtqrYOOTPRXw3mL+DGySv4qvqcwng==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=tV3l3Q8d; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=tV3l3Q8d
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 989656067D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:27 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6BA573F2A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1791813686;
 bh=4J9yr73r6ct5cWEU22m05yeks1AqwUzhiTbfVukubqk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=tV3l3Q8d8TQH/4TPen9fgtWlSbFOM/C3pH+4EYQnnji2a8y2zXQBt0IiRXE6mct1F
 pkjqEwTLWsSo7twuojVeDVVB7iDZb1A6KANEtp2uH7JoVP/islWRPmtQNyM6YNrwUy
 nMOfysVwF1uhglj1IauB0GTCxibyDk+oEe2gYg64FgnalNCVb3JIQJqVaYtLMuTAfs
 Cpt1KHrCa7vFJ5DCAXM9anvQat3VJ7OvHx5c7fedXej73a8xLlDDwZap3jeN5mJz0a
 cuV6/kQZSkPXRJ8eXwds+4Zapwg5NErzHVK/TUhmgv74P6X/wxGnq5mn3NstSXDGdD
 Kaz8tDoC09Q0p1GBMh8HWCQhMWuYRt3ceY52r07QHiXl6QPYzrO0jTjAdL3BQ4HjHi
 zJyoOfzB4Q4OR7F8dHf4Px9/6K/S/PO46u6G5NbSs9buhM2Un9IgXvm2z8dyKRVJCL
 BaqxWutejKav23cG2m427+dUFhsRsMAt0iUDBwtpFN36UMnf8KuNAGPRbs/uSYgPHz
 ii1tElYNiVY496fQqsitioDD4jzMFoUjdwes200I4GAAtGfQDfN/WwI2/8mr4IHpLO
 O4CRCmIKuczx8742BlTehYyhKTK+NZoowHbsic70R8UHWAeSnld/YGCRwE0G3yxqfh
 zrSwFJE2BnRWnxLeJyFtc9M4=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a01b112fa2so28788775e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813686; x=1792418486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4J9yr73r6ct5cWEU22m05yeks1AqwUzhiTbfVukubqk=;
 b=yEfmwG1BB7yEELHlM840+Gi1yKW8z5hoH8cjQ+TLSXIq+afEpjk+Z7y4MzK1/uT8ep
 7Edv4oDvnK6mlnZVxvbpl7bCbqeINqrq8iEdBguIBU3vJwkamjP14xL/zNuBcni7v2aS
 0fLtElH0TbkKwZC45MzfQ18m6krtMb6wuttuiCgRnUdYP/o7Yao18rTHx2WFq3gJP4m3
 uI/yrYB/dGJW7EOIiBzOiLYABLGKPWIA08DSi16UBU3+E3ghor6S5S/SfQerSFJkGioW
 MLXYnTf5uTJkmBnWeYp/nON9KTmDkkB5MsmtqUVcRyY6CArnXWQ3z4YAw7aNAV1lwdNx
 /waw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPbkxfFwwfpCLGnV6MGC4TJkWl+nrAKYlHyAzQTlKulhR89dLwdHseLLuOUiwDwx5arPE2pj0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJNklFDQC9NxK/Gt1Ht1TzdTFVxl0gcTLbHOfKnXXjk/c8afB0W
 IVdJN6vMxzwM2T8Uun+pCG9lGJqow9Nxp6MmQ1ui9vypcFerBDnpIdplKxKwP106mqihmupfq1Q
 237Uk0yqaQIb4IiYPa4kA1w3YWGsS19x+QUQo0VIYoReeVJWisfsCVywr7lWJ3v5IbdbITmP5GA
 JKomsxvx2B4A==
X-Gm-Gg: AYBFou2elHRxBhfLB69j6WozIqItmC2ZkIMMPB8bgL8WAv5j6x3azXDbmTTsFNp1ojw
 06xupQkMkCkfas2KuxPR41t2QCi01/XVNVUbd+8Z3Kxe2Bm8nkvT2oealBtvQskEUUHx4FlJvWk
 OCnVWNQKyGNPMaKK7WKMtp2hCTGy/QvI0suXwZ4t+zGbn+r6R8wBSoIgiolXSYgYXJeuE+BWPwt
 D5Ac8Bszlpe+y3A8VyQRjUmBG54Nu8h+l4A0/2X+esryZudR/Jy7qSxlU2uZTVOw7C17G9u1XaN
 74KxTvuOT5lRiMwNQGr9TAO3Tk0fEpPBBYpKbFaQs4ob1ekPzDXSt50VFetdXFXh/A76t7tIqxx
 PKuTggJF/pwEjv7/Y8+7vHoISNLhGR0WGSlL/5/XuZXdyB02SM1e4ldg=
X-Received: by 2002:a05:600c:3144:b0:4a1:70b2:8dbb with SMTP id
 5b1f17b1804b1-4a18e4b0347mr172750575e9.19.1791813685874; 
 Mon, 12 Oct 2026 07:01:25 -0700 (PDT)
X-Received: by 2002:a05:600c:3144:b0:4a1:70b2:8dbb with SMTP id
 5b1f17b1804b1-4a18e4b0347mr172749945e9.19.1791813685349; 
 Mon, 12 Oct 2026 07:01:25 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:468d:767c:32e6:22fa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm284551015e9.6.2026.10.12.07.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:01:24 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Daniel Munic <v-dmunic@microsoft.com>, Tony Dinh <mibodhi@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 joaomarcos.costa@bootlin.com, Aristo Chen <aristo.chen@canonical.com>,
 u-boot@lists.u-boot-project.org, linux-erofs@lists.ozlabs.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 9/9] test: test_erofs: adjust expected ls output
Date: Mon, 12 Oct 2026 16:00:48 +0200
Message-ID: <20261012140048.214059-10-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

With the addition of the date field the space between columns in the ls
output has been reduced. Reflect this in the expected lines of the erofs
test.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_fs/test_erofs.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/py/tests/test_fs/test_erofs.py b/test/py/tests/test_fs/test_erofs.py
index cec803256ac..7e7af9c6bf6 100644
--- a/test/py/tests/test_fs/test_erofs.py
+++ b/test/py/tests/test_fs/test_erofs.py
@@ -65,8 +65,8 @@ def erofs_ls_at_root(ubman):
     slash = ubman.run_command('erofsls host 0 /')
     assert no_slash == slash
 
-    expected_lines = ['./', '../', '4096   f4096', '7812   f7812', 'subdir/',
-                      '<SYM>   symdir', '<SYM>   symfile', '4 file(s), 3 dir(s)']
+    expected_lines = ['./', '../', '4096 f4096', '7812 f7812', 'subdir/',
+                      '<SYM> symdir', '<SYM> symfile', '4 file(s), 3 dir(s)']
 
     output = ubman.run_command('erofsls host 0')
     for line in expected_lines:
@@ -76,7 +76,7 @@ def erofs_ls_at_subdir(ubman):
     """
     Test if the path resolution works.
     """
-    expected_lines = ['./', '../', '100   subdir-file', '1 file(s), 2 dir(s)']
+    expected_lines = ['./', '../', '100 subdir-file', '1 file(s), 2 dir(s)']
     output = ubman.run_command('erofsls host 0 subdir')
     for line in expected_lines:
         assert line in output
@@ -89,7 +89,7 @@ def erofs_ls_at_symlink(ubman):
     output_subdir = ubman.run_command('erofsls host 0 subdir')
     assert output == output_subdir
 
-    expected_lines = ['./', '../', '100   subdir-file', '1 file(s), 2 dir(s)']
+    expected_lines = ['./', '../', '100 subdir-file', '1 file(s), 2 dir(s)']
     for line in expected_lines:
         assert line in output
 
-- 
2.55.0

