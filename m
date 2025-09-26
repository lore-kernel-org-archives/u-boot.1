Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A38CAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E08B583824;
	Fri, 26 Sep 2025 18:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bOmJKKDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9527B82AE1; Fri, 26 Sep 2025 11:45:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 769FB8206E
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 11:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=berrange@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758879953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1L2qQdiXKKoZYlfqnE9/O2TMWQOqYfCEHskQIRSKBXk=;
 b=bOmJKKDYyANCmXmCPczvd1uD2pqRAgzmkvBgDwMrA06wefIeCnFMLwTDucZaLQfaHA/kdy
 Bo8mbYO9HgPEZY+AArj/bDyKS+Xs1zkBqb2FL0zV3V+xb8K0LFnK3NRx5vb8cR74HspFcP
 9tZWz+6a+E6bTmpPQSKMxawBYfc7l74=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-YuTocouJOoKcwl059ZjjDQ-1; Fri,
 26 Sep 2025 05:45:51 -0400
X-MC-Unique: YuTocouJOoKcwl059ZjjDQ-1
X-Mimecast-MFC-AGG-ID: YuTocouJOoKcwl059ZjjDQ_1758879950
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A7381800562
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 09:45:50 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CD7819560A2; Fri, 26 Sep 2025 09:45:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] Add symlink from gpl-2.0.txt to a COPYING file
Date: Fri, 26 Sep 2025 10:45:46 +0100
Message-ID: <20250926094546.1904854-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qFoiHJEm7XhKf9ZqoIAvn9zn0drxio0x3pq90mhk0Cc_1758879950
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Sep 2025 18:05:48 +0200
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

While it is good that the "Licenses/" directory contains the text
for all licenses that are applicable to u-boot code, it is harder
to determine at a glance what the default and/or preferred license
is. While humans can look at the Licenses/README file, this is not
machine parseable, making it tricky for license detection tools to
automatically determine/report on the overall / aggregate u-boot
license.

The project previously had a top level COPYING file containing a
short blurb, followed by the GPL license text. This was removed
back in commit eca3aeb352c964bdb28b8e191d6326370245e03f when
the "Licenses/" directory was introduced. For the benefit of
automated tools, it is helpful to retain a top level COPYING
file in the repository. Rather than duplicate the license text,
however, a symlink from the Licenses/gpl-2.0.txt file should
suffice.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

Some further context. This desire for a COPYING (or LICENSE)
file originates in the context of the QEMU project, which
maintains mirrors of both current upstream u-boot, and an
old fork of u-boot.

QEMU is hosted on gitlab.com and relies on GitLab's Open Source
Program which grants the project free access to the full range
of GitLab's otherwise pay-for features & resources. They have
introduced a new process for their OSS Program applications
which automatically checks if the overall license reported by
every repository is OSI approved.

Since u-boot lacks a top level COPYING or LICENSE file, GitLab
fails to identify u-boots overall license. As a result QEMU was
unable to apply for the OSS Program until removing the u-boot
mirrors, but we'd like to reinstate them.

I am somewhat uncomfortable asking u-boot maintainers to
accept this change just to work around limitations of the
commercial GitLab service. None the less the presence of a
top level COPYING / LICENSE file is a broadly accepted OSS
standard, so it is understandable that GitLab relied on
that. Using a symlink bridges between that standard and
u-boot's current Licenses dir approach in a low overhead
manner.

From a purely cosmetic view, if looking at any u-boot mirror
on either GitLab or GitHub, AFAICS, neither are identifying
& reporting the project license, and this ought to resolve
that minor cosmetic issue.

 COPYING | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 COPYING

diff --git a/COPYING b/COPYING
new file mode 120000
index 00000000000..1ed3ba6a13c
--- /dev/null
+++ b/COPYING
@@ -0,0 +1 @@
+Licenses/gpl-2.0.txt
\ No newline at end of file
-- 
2.50.1

