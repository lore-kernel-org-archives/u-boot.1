Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CFECA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CC5C4093F;
	Fri,  9 Oct 2026 17:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a6Sl9jgUydq3; Fri,  9 Oct 2026 17:13:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A32C04090C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791566015;
	b=RWUu4Di0K1EmtcuDodm8BP+0dPQyR4sPDXG7uflFeZNfznYZHIzlqTyu5qq5t62CBwUm
	 5GO+UrdKO10Ffz+Yb2MSxtT7uti8s2My4dSyEhjtbX2OdqXRYdO8e9KeTdN/T6Kz6YlWP
	 xWL1ZjidH2YOWLgxhsgzT7FcCTStIyMht98IIN6IRvk5lGin+m7f8i7RSm/DZUQwS7XIt
	 hczCDo+Qc0WA74D+UvBGma68jBVsP/8/8A59NbRdrs5MLxq7aeTTzklzfBwJkwfqxadzT
	 UAOkaBpdOvUyF1JroaXOt1JOqrmnF7qlinc+iqXyJz8PHHP1dJ8nRv27bhSdZ46zyNw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791566015;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5J1hQcmltZf0HgIOwl9aWVJtMzOD6MVQzPgyyRM7SwE=;
	b=ix0yjWMVyNGvQczVAhxgQ8E0wmYZ0W/CyGRIlNDIjsQgnOKZcGebtrWagKRqtIJuxGg+
	 Vne4TAVH+yxtpY387MfaxzpXzy1/drXBUsGMXOqV7tVQtuY3VmkJF8y9mBei5Cq9mF/kP
	 8qI6ZJyx1YuTW+TzGXKv1sJVMvlvgZNie3kVSM3ccWDfP5jPYWGSca9nh7TFq9VPTvh6Y
	 L50HoDNg/byBHvgFoBRl/XqAfP5G3dZXJSBP26svtG+zeg33TpAMyDgONkPpZNHqoqvdm
	 M7PQhfCL2d3cqYqlCJmB2yyhTXquuajCDy7jRni8ioN2mKhjk1m+5cXN8WJtO53rgYQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=m8MRM94E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791566015;
	bh=5J1hQcmltZf0HgIOwl9aWVJtMzOD6MVQzPgyyRM7SwE=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qjqqL/RzjgcTAT9h/uPU7NaVzBnRIwBnwqCy//gaUZ0LzmLj9bo9oONwq7or37/hc
	 5bBXlBdrYypSUDypl1zoDBh3PyLq7KXTsWEOWpRMhcb5Un0AcNfvXV1D4ky+xZzDd5
	 WiUp0S9VbjxYjzZ1TBxyP3GThw6Re0UN3F+Dty/4Ahyzcyj/4fqkOcQbvTyQuRxJmF
	 rjNPtlaBGLLGINICAAqXt/scpwYmnKEcV8dSSKfAm0vycNtNj4N6nRo/OuwhqU1WE3
	 Kbq1M5bHa9ZTGsdqzE8UjIUQ1rGpzH88QZj+kz80sawoQCd7zjdiRNJrxF0UViilOw
	 IQyA+atd8lGiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A32C04090C;
	Fri,  9 Oct 2026 17:13:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C0499317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A658D40902
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Po5j58y5_PMf for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:13:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 409AD408D7
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791566012;
 b=EuPhEmSnEh8gwrtdQyNQLKT7y6TRx+P8L8i9bCPbYidZs/Tl9L2QOQ9NoOKDrByJEgOU
 UX+scUVyWbTsQ4nFIf1r/nbx1aQ5uqC9gJnBOSLffU70obuO3iJb6QGgQBENwcqk3SiuS
 Z7oirFIo/xY8AtnSymKJRYCOc23X5C0c9HWIHEOdPjACD1uBwH7wpaoghyqRYuAYHiEAR
 4f/0Gd7B8dl2AkkLT7evFlBw/EmXuo8aWxxZBhzimPnhemB+pgKaIuixjUaaE4S4k5ar9
 3gCw/FXGFjuH+WoVgSMLetheZ7Yt51yb+oTrRKr0jRTAPYRP8UzwGLQsFeC0/Augqpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791566012;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=5J1hQcmltZf0HgIOwl9aWVJtMzOD6MVQzPgyyRM7SwE=;
 b=Y9eM+icMlXu5+K/JOo6E2cWAS7YQ5FAf80GLojU+vKAFEBcXSz7pKQ7xaeG/axMJsmYb
 TwHgTOMQy0QhmZDaSoFmN1y+rNTpBNCRxUzlqOBpdcPX0ZF0naEsWiEARPLbRc/PmmQYG
 UrDr4wCAYIrvc1NL42ReaNeYJLn70meR72QUOqj6b+6Q9Sjlrv7mUuJE04fp3buLuZfUJ
 dpSVAeCIqyc2clQ0TWbV6CUiRckxZw16D1GRZenvcO3TZVGDjgfu7GP9Sg4n+xUr8Cs2S
 W2D8kli4iKK4dT5qUOI6QS9EX/zQOf0QC8RaYBc3IshB3eHoH5/Tf70yXFpM0aUjL0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=m8MRM94E; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::9"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::9;
 helo=mail-oi2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=m8MRM94E
Received: from mail-oi2-x09.google.com (mail-oi2-x09.google.com
 [IPv6:2607:f8b0:4864:32::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 409AD408D7
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:13:31 +0000 (UTC)
Received: by mail-oi2-x09.google.com with SMTP id
 5614622812f47-4f6da9ae8b2so561b6e.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791566011; x=1792170811;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5J1hQcmltZf0HgIOwl9aWVJtMzOD6MVQzPgyyRM7SwE=;
 b=m8MRM94EZXHWfD7RUVH4QqwJIeghPikUkg/kpbPIF61xtlPc75Z2bTfK6xsc//DbGL
 xDqxm6QMXnlTWRHsBCbjlEcB1+VKzjc+g1h2I/YP9AO/V5ak2jdsPVuOUANN6u7y2qF3
 NokS0Fi3e7cFA8d+Ghqa0CMEGlUaZHnZQX930=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791566011; x=1792170811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5J1hQcmltZf0HgIOwl9aWVJtMzOD6MVQzPgyyRM7SwE=;
 b=S4pzjWDy+ggyrN9ok/7b+6qwbB6TIGmw7sqP2uVU2eNf0P4mto+4fXckNDi7RxxPQH
 AWO7CJlVGu0Vk9I/tVZeXS05oJoV2afjJOcjSrTD94D0q9NZKpPRTakbygYJIC8/RQR8
 xk53twBdIbMtkYJqDxhBKYCrogC43xE75khsmwhp1dVV3Gx2q/OvUh6Y68/A4evTRjNh
 KuULZzOLDamiqd6MQb9xOXOkFLwsJw7Wd9RasBOePOhwOug/IUi09Ua5JVisPij8Xcwg
 xYB0TYjgE/w2/imUEdA310NtnGa6874skHE+LasBlFy4XS8sISMv+LIFHWzgxsMEjnjp
 JQ5w==
X-Gm-Message-State: AFuF++mh3VrCY1WffYI29EW2EDmJ5l5Hm7MAJwK9V6ZUXaO7XzFE2Od+
 EXd1bsqIAQJF2j086+x/7x94azZgAfKMwYdKv/RjzNOxN2vaWifPQJ6T6S0jUY0qzmHmxdkQjPd
 OWqWIbQT9oe/IeAw=
X-Gm-Gg: AYBFou3eSur0GrKdfOUmDOq7ROr/vKOe50l8obAmCJlRmoyN15prtfqViLJn06V2fUb
 IHgh4++aFPZ9mGDPcxcXokSAOZ0H2z0mLbJNUKqvuw5tF/7VkJgE+8sG6f9IgKbyr1J7lAyJWxE
 GE6YYpPwnRzCNOzlDxBfoqvokOMp5+wrv+5vVPmBTIrOIuC+YgKf3ZKEDms26eadvN2QiWp/XYh
 Wh4IBROxgzlwAkPhZHDykfU5aMy1g7JruE4IhN2n2NgRazFagb+nxxp0AKbiUEZ8ZMq49yKb2Eu
 qW1nmE86DmCwYQLRxmbGyqV1MoHagnvjZumvclVzdiqxuNaBI7+3WjZcXCM2VHZ0UeHPoJpq5tB
 JGvo8wd4Cg5dtsxFMDnFH0D6V1KfgWclV/i7zp9RqofJU7xWxR/Bh8RyDGAZuDJTFsYU+kOWV3Z
 UQ5FUHJmihf0mfC8QryH8VGdcD29MZarPcnqKLI/hP8BjteexGyGiZTqqm5nT15PnpPQ4Wo5NNg
 vdx5UyV+8NYvPG1ZSgUpDPdM4vPDuIvhMKS5M4w3mDrLsfLTqXeWosmzhlmK5RU+nqQHTIlNmjv
 BbSojHsT51MRJZ/qRz7AwYvO7yRm+J6cMBIkqQ3am0uS
X-Received: by 2002:a05:6808:4fde:b0:4bc:fbd4:2a43 with SMTP id
 5614622812f47-50c56deebf1mr2365193b6e.41.1791566010706; 
 Fri, 09 Oct 2026 10:13:30 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c1815f03dsm2781005b6e.9.2026.10.09.10.13.29
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 10:13:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] labgrid-trini: Update for labgrid 26.0 support
Date: Fri,  9 Oct 2026 11:13:28 -0600
Message-ID: <20261009171328.2627684-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As part of the development for labgrid 26.0, the behavior was changed[1]
such that if you specify an environment file, all resources in it will
be locked on acquire, not just the named place. Given that power control
in this lab is not available in a supported regular driver, we must have
an environment file for that. So, change to having an environment file
per hardware device, which also means the environment file says the
location of the coordinator.

[1]: https://github.com/labgrid-project/labgrid/commit/a9b59e4e
Signed-off-by: Tom Rini <trini@konsulko.com>
---
This is a medium-term solution. The long term solution is replacing the
PDU with one that's fully supported in upstream labgrid, or being able
to move to a version of labgrid that's integrated full support for this
PDU. For the latter, https://github.com/labgrid-project/labgrid/pull/1789
---
 README.md                                |   4 +-
 bin/common.labgrid-trini                 |   5 -
 bin/sage/bbb-1-env.yaml                  |  29 ++++
 bin/sage/hb-1-env.yaml                   |  29 ++++
 bin/sage/labgrid-sage-env.yaml           | 175 -----------------------
 bin/sage/pine64-1-env.yaml               |  29 ++++
 bin/sage/rpi3-1-env.yaml                 |  29 ++++
 bin/sage/rpi4-1-env.yaml                 |  29 ++++
 bin/sage/sage-exporter-bbb-1-env.yaml    |  14 ++
 bin/sage/sage-exporter-hb-1-env.yaml     |  14 ++
 bin/sage/sage-exporter-pine64-1-env.yaml |  14 ++
 bin/sage/sage-exporter-rpi3-1-env.yaml   |  14 ++
 bin/sage/sage-exporter-rpi4-1-env.yaml   |  14 ++
 13 files changed, 217 insertions(+), 182 deletions(-)
 create mode 100644 bin/sage/bbb-1-env.yaml
 create mode 100644 bin/sage/hb-1-env.yaml
 delete mode 100644 bin/sage/labgrid-sage-env.yaml
 create mode 100644 bin/sage/pine64-1-env.yaml
 create mode 100644 bin/sage/rpi3-1-env.yaml
 create mode 100644 bin/sage/rpi4-1-env.yaml
 create mode 100644 bin/sage/sage-exporter-bbb-1-env.yaml
 create mode 100644 bin/sage/sage-exporter-hb-1-env.yaml
 create mode 100644 bin/sage/sage-exporter-pine64-1-env.yaml
 create mode 100644 bin/sage/sage-exporter-rpi3-1-env.yaml
 create mode 100644 bin/sage/sage-exporter-rpi4-1-env.yaml

diff --git a/README.md b/README.md
index 6171669228cf..9958e21bcf77 100644
--- a/README.md
+++ b/README.md
@@ -253,9 +253,9 @@ That should be all that is needed.
 An alternate implementation requires setting the following environment
 variables must be set as per your lab:
 
-- `LG_COORDINATOR` must point at the labgrid coordinator service.
 - `LG_PLACE` must point at the device under test.
-- `LG_ENV` must point at the labgrid yaml file that describes your lab.
+- `LG_ENV` must point at the labgrid yaml file that describes your lab
+  including the coordinator.
 
 In order for a given platform to be tested, it must be acquired before starting
 tests and then released once complete. See the bin/konsulko-labgrid directory
diff --git a/bin/common.labgrid-trini b/bin/common.labgrid-trini
index b3c7d07ca7f0..0fe5ffcf300a 100644
--- a/bin/common.labgrid-trini
+++ b/bin/common.labgrid-trini
@@ -19,11 +19,6 @@
 # DEALINGS IN THE SOFTWARE.
 
 # Ensure we have all environment variables set
-if [ -z "${LG_COORDINATOR}" ]; then
-	echo "LG_COORDINATOR is unset";
-	exit 1;
-fi
-
 if [ -z "${LG_PLACE}" ]; then
 	echo "LG_PLACE is unset";
 	exit 1;
diff --git a/bin/sage/bbb-1-env.yaml b/bin/sage/bbb-1-env.yaml
new file mode 100644
index 000000000000..9f79759b92ea
--- /dev/null
+++ b/bin/sage/bbb-1-env.yaml
@@ -0,0 +1,29 @@
+options:
+  coordinator_address: 192.168.1.10:20408
+targets:
+  bbb-1:
+    resources:
+      RemotePlace:
+        name: bbb-1
+    drivers:
+      power:
+        cls: ExternalPowerDriver
+        cmd_on: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.9 i 1
+        cmd_off: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.9 i 2
+      mux:
+        cls: USBSDMuxDriver
+      storage:
+        cls: USBStorageDriver
+      serial:
+        cls: SerialDriver
+      shell:
+        cls: ShellDriver
+        prompt: 'root@.*:~# '
+        login_prompt: 'login: '
+        username: root
+      uboot:
+        cls: UBootDriver
+        prompt: 'U-Boot> '
+        autoboot: Hit any key to stop autoboot
+      strategy:
+        cls: UBootStrategy
diff --git a/bin/sage/hb-1-env.yaml b/bin/sage/hb-1-env.yaml
new file mode 100644
index 000000000000..6858213d619c
--- /dev/null
+++ b/bin/sage/hb-1-env.yaml
@@ -0,0 +1,29 @@
+options:
+  coordinator_address: 192.168.1.10:20408
+targets:
+  hb-1:
+    resources:
+      RemotePlace:
+        name: hb-1
+    drivers:
+      power:
+        cls: ExternalPowerDriver
+        cmd_on: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.3 i 1
+        cmd_off: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.3 i 2
+      mux:
+        cls: USBSDMuxDriver
+      storage:
+        cls: USBStorageDriver
+      serial:
+        cls: SerialDriver
+      shell:
+        cls: ShellDriver
+        prompt: 'root@.*:~# '
+        login_prompt: 'login: '
+        username: root
+      uboot:
+        cls: UBootDriver
+        prompt: 'U-Boot> '
+        autoboot: Hit any key to stop autoboot
+      strategy:
+        cls: UBootStrategy
diff --git a/bin/sage/labgrid-sage-env.yaml b/bin/sage/labgrid-sage-env.yaml
deleted file mode 100644
index 8d3fe4ab53c3..000000000000
--- a/bin/sage/labgrid-sage-env.yaml
+++ /dev/null
@@ -1,175 +0,0 @@
-# Sage environment
-
-options:
-  coordinator_address: 172.17.0.1:20408
-
-targets:
-  rpi3-1:
-    resources:
-      RemotePlace:
-        name: rpi3-1
-    drivers:
-      power:
-        cls: NetworkPowerDriver
-      mux:
-        cls: USBSDMuxDriver
-      storage:
-        cls: USBStorageDriver
-      serial:
-        cls: SerialDriver
-      shell:
-        cls: ShellDriver
-        prompt: 'root@.*:~# '
-        login_prompt: 'login: '
-        username: 'root'
-      uboot:
-        cls: UBootDriver
-        prompt: 'U-Boot> '
-        autoboot: 'Hit any key to stop autoboot'
-      strategy:
-        cls: UBootStrategy
-  rpi4-1:
-    resources:
-      RemotePlace:
-        name: rpi4-1
-    drivers:
-      power:
-        cls: NetworkPowerDriver
-      mux:
-        cls: USBSDMuxDriver
-      storage:
-        cls: USBStorageDriver
-      serial:
-        cls: SerialDriver
-      shell:
-        cls: ShellDriver
-        prompt: 'root@.*:~# '
-        login_prompt: 'login: '
-        username: 'root'
-      uboot:
-        cls: UBootDriver
-        prompt: 'U-Boot> '
-        autoboot: 'Hit any key to stop autoboot'
-      strategy:
-        cls: UBootStrategy
-  hb-1:
-    resources:
-      RemotePlace:
-        name: hb-1
-    drivers:
-      power:
-        cls: NetworkPowerDriver
-      mux:
-        cls: USBSDMuxDriver
-      storage:
-        cls: USBStorageDriver
-      serial:
-        cls: SerialDriver
-      shell:
-        cls: ShellDriver
-        prompt: 'root@.*:~# '
-        login_prompt: 'login: '
-        username: 'root'
-      uboot:
-        cls: UBootDriver
-        prompt: 'U-Boot> '
-        autoboot: 'Hit any key to stop autoboot'
-      strategy:
-        cls: UBootStrategy
-  pine64-1:
-    resources:
-      RemotePlace:
-        name: pine64-1
-    drivers:
-      power:
-        cls: NetworkPowerDriver
-      mux:
-        cls: USBSDMuxDriver
-      storage:
-        cls: USBStorageDriver
-      serial:
-        cls: SerialDriver
-      shell:
-        cls: ShellDriver
-        prompt: 'root@.*:~# '
-        login_prompt: 'login: '
-        username: 'root'
-      uboot:
-        cls: UBootDriver
-        prompt: 'U-Boot> '
-        autoboot: 'Hit any key to stop autoboot'
-      strategy:
-        cls: UBootStrategy
-  bbb-1:
-    resources:
-      RemotePlace:
-        name: bbb-1
-    drivers:
-      power:
-        cls: ExternalPowerDriver
-        cmd_on: 'snmpset -v 2c -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.9 i 1'
-        cmd_off: 'snmpset -v 2c -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.9 i 2'
-      mux:
-        cls: USBSDMuxDriver
-      storage:
-        cls: USBStorageDriver
-      serial:
-        cls: SerialDriver
-      shell:
-        cls: ShellDriver
-        prompt: 'root@.*:~# '
-        login_prompt: 'login: '
-        username: 'root'
-      uboot:
-        cls: UBootDriver
-        prompt: 'U-Boot> '
-        autoboot: 'Hit any key to stop autoboot'
-      strategy:
-        cls: UBootStrategy
-  sage-exporter-rpi3-1:
-    resources:
-      RemotePlace:
-        name: sage-exporter-rpi3-1
-    drivers:
-      power:
-        cls: NetworkPowerDriver
-      ssh:
-        cls: SSHDriver
-  sage-exporter-rpi4-1:
-    resources:
-      RemotePlace:
-        name: sage-exporter-rpi4-1
-    drivers:
-      power:
-        cls: NetworkPowerDriver
-      ssh:
-        cls: SSHDriver
-  sage-exporter-hb-1:
-    resources:
-      RemotePlace:
-        name: sage-exporter-hb-1
-    drivers:
-      power:
-        cls: NetworkPowerDriver
-      ssh:
-        cls: SSHDriver
-  sage-exporter-pine64-1:
-    resources:
-      RemotePlace:
-        name: sage-exporter-pine64-1
-    drivers:
-      power:
-        cls: NetworkPowerDriver
-      ssh:
-        cls: SSHDriver
-  sage-exporter-bbb-1:
-    resources:
-      RemotePlace:
-        name: sage-exporter-bbb-1
-    drivers:
-      power:
-        cls: ExternalPowerDriver
-        cmd_on: 'snmpset -v 2c -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.13 i 1'
-        cmd_off: 'snmpset -v 2c -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.13 i 2'
-      ssh:
-        cls: SSHDriver
diff --git a/bin/sage/pine64-1-env.yaml b/bin/sage/pine64-1-env.yaml
new file mode 100644
index 000000000000..9ad5a56c6396
--- /dev/null
+++ b/bin/sage/pine64-1-env.yaml
@@ -0,0 +1,29 @@
+options:
+  coordinator_address: 192.168.1.10:20408
+targets:
+  pine64-1:
+    resources:
+      RemotePlace:
+        name: pine64-1
+    drivers:
+      power:
+        cls: ExternalPowerDriver
+        cmd_on: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.4 i 1
+        cmd_off: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.4 i 2
+      mux:
+        cls: USBSDMuxDriver
+      storage:
+        cls: USBStorageDriver
+      serial:
+        cls: SerialDriver
+      shell:
+        cls: ShellDriver
+        prompt: 'root@.*:~# '
+        login_prompt: 'login: '
+        username: root
+      uboot:
+        cls: UBootDriver
+        prompt: 'U-Boot> '
+        autoboot: Hit any key to stop autoboot
+      strategy:
+        cls: UBootStrategy
diff --git a/bin/sage/rpi3-1-env.yaml b/bin/sage/rpi3-1-env.yaml
new file mode 100644
index 000000000000..ced8c46b05b0
--- /dev/null
+++ b/bin/sage/rpi3-1-env.yaml
@@ -0,0 +1,29 @@
+options:
+  coordinator_address: 192.168.1.10:20408
+targets:
+  rpi3-1:
+    resources:
+      RemotePlace:
+        name: rpi3-1
+    drivers:
+      power:
+        cls: ExternalPowerDriver
+        cmd_on: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.1 i 1
+        cmd_off: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.1 i 2
+      mux:
+        cls: USBSDMuxDriver
+      storage:
+        cls: USBStorageDriver
+      serial:
+        cls: SerialDriver
+      shell:
+        cls: ShellDriver
+        prompt: 'root@.*:~# '
+        login_prompt: 'login: '
+        username: root
+      uboot:
+        cls: UBootDriver
+        prompt: 'U-Boot> '
+        autoboot: Hit any key to stop autoboot
+      strategy:
+        cls: UBootStrategy
diff --git a/bin/sage/rpi4-1-env.yaml b/bin/sage/rpi4-1-env.yaml
new file mode 100644
index 000000000000..24b81bc4571d
--- /dev/null
+++ b/bin/sage/rpi4-1-env.yaml
@@ -0,0 +1,29 @@
+options:
+  coordinator_address: 192.168.1.10:20408
+targets:
+  rpi4-1:
+    resources:
+      RemotePlace:
+        name: rpi4-1
+    drivers:
+      power:
+        cls: ExternalPowerDriver
+        cmd_on: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.2 i 1
+        cmd_off: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.2 i 2
+      mux:
+        cls: USBSDMuxDriver
+      storage:
+        cls: USBStorageDriver
+      serial:
+        cls: SerialDriver
+      shell:
+        cls: ShellDriver
+        prompt: 'root@.*:~# '
+        login_prompt: 'login: '
+        username: root
+      uboot:
+        cls: UBootDriver
+        prompt: 'U-Boot> '
+        autoboot: Hit any key to stop autoboot
+      strategy:
+        cls: UBootStrategy
diff --git a/bin/sage/sage-exporter-bbb-1-env.yaml b/bin/sage/sage-exporter-bbb-1-env.yaml
new file mode 100644
index 000000000000..be82a5e58bf5
--- /dev/null
+++ b/bin/sage/sage-exporter-bbb-1-env.yaml
@@ -0,0 +1,14 @@
+options:
+  coordinator_address: 192.168.1.10:20408
+targets:
+  sage-exporter-bbb-1:
+    resources:
+      RemotePlace:
+        name: sage-exporter-bbb-1
+    drivers:
+      power:
+        cls: ExternalPowerDriver
+        cmd_on: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.13 i 1
+        cmd_off: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.13 i 2
+      ssh:
+        cls: SSHDriver
diff --git a/bin/sage/sage-exporter-hb-1-env.yaml b/bin/sage/sage-exporter-hb-1-env.yaml
new file mode 100644
index 000000000000..1b5bd3f1c45e
--- /dev/null
+++ b/bin/sage/sage-exporter-hb-1-env.yaml
@@ -0,0 +1,14 @@
+options:
+  coordinator_address: 192.168.1.10:20408
+targets:
+  sage-exporter-hb-1:
+    resources:
+      RemotePlace:
+        name: sage-exporter-hb-1
+    drivers:
+      power:
+        cls: ExternalPowerDriver
+        cmd_on: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.7 i 1
+        cmd_off: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.7 i 2
+      ssh:
+        cls: SSHDriver
diff --git a/bin/sage/sage-exporter-pine64-1-env.yaml b/bin/sage/sage-exporter-pine64-1-env.yaml
new file mode 100644
index 000000000000..34b3409904b4
--- /dev/null
+++ b/bin/sage/sage-exporter-pine64-1-env.yaml
@@ -0,0 +1,14 @@
+options:
+  coordinator_address: 192.168.1.10:20408
+targets:
+  sage-exporter-pine64-1:
+    resources:
+      RemotePlace:
+        name: sage-exporter-pine64-1
+    drivers:
+      power:
+        cls: ExternalPowerDriver
+        cmd_on: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.8 i 1
+        cmd_off: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.8 i 2
+      ssh:
+        cls: SSHDriver
diff --git a/bin/sage/sage-exporter-rpi3-1-env.yaml b/bin/sage/sage-exporter-rpi3-1-env.yaml
new file mode 100644
index 000000000000..b6d1b0bd7e41
--- /dev/null
+++ b/bin/sage/sage-exporter-rpi3-1-env.yaml
@@ -0,0 +1,14 @@
+options:
+  coordinator_address: 192.168.1.10:20408
+targets:
+  sage-exporter-rpi3-1:
+    resources:
+      RemotePlace:
+        name: sage-exporter-rpi3-1
+    drivers:
+      power:
+        cls: ExternalPowerDriver
+        cmd_on: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.5 i 1
+        cmd_off: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.5 i 2
+      ssh:
+        cls: SSHDriver
diff --git a/bin/sage/sage-exporter-rpi4-1-env.yaml b/bin/sage/sage-exporter-rpi4-1-env.yaml
new file mode 100644
index 000000000000..79b4fb9d9c5c
--- /dev/null
+++ b/bin/sage/sage-exporter-rpi4-1-env.yaml
@@ -0,0 +1,14 @@
+options:
+  coordinator_address: 192.168.1.10:20408
+targets:
+  sage-exporter-rpi4-1:
+    resources:
+      RemotePlace:
+        name: sage-exporter-rpi4-1
+    drivers:
+      power:
+        cls: ExternalPowerDriver
+        cmd_on: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.6 i 1
+        cmd_off: snmpset -v1 -c private 192.168.1.254 .1.3.6.1.4.1.1718.3.2.3.1.11.1.1.6 i 2
+      ssh:
+        cls: SSHDriver
-- 
2.43.0

