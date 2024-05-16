Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B461C25B77
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 12:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBBE88837B;
	Thu, 16 May 2024 14:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="TR+kqr81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489B787F65; Thu, 16 May 2024 12:43:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CB5488258
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 12:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715856187; x=1716460987; i=fiona.klute@gmx.de;
 bh=8KOvOwHVKwbDuTyMEGLqicUZIERVzh4qIxNB/lis0F0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=TR+kqr813qBezrIbkQJPNlM3d8lhEv31hetLOpr2UGmUChUE0USrlb2witUvmEMK
 D4TRJIb2rMRTzk9YWJbRr701cetQJlXD1Ufy+Lybjki/dpACgIjKRygtupTf4o7Kc
 qm7lMCcDfHjKHJf2M4XbUOE9pv4z49GLC2NLAvpZYGhCGzBPLTsujsAmjw5QKcED7
 RbS2BnRtbFGQsG8QQ+SAu1+XpdJUbg34A8dzazV9GqeqS3vxIQrt/qxgwLN/bb5oe
 qnlMP7e1sJnGVMrVb2kOFcOIz/J7R054mUIJIEqxMfHU35tiId6bZVtIjqXl1xCXA
 1dpDo5LyrwhT1tUyFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.121.157]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1shAJF1PH8-00ZvVa; Thu, 16
 May 2024 12:43:07 +0200
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: mibodhi@gmail.com,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH v2 2/2] doc: Update netconsole examples, mention stderr
Date: Thu, 16 May 2024 12:42:45 +0200
Message-ID: <20240516104245.2075748-2-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240516104245.2075748-1-fiona.klute@gmx.de>
References: <20240516104245.2075748-1-fiona.klute@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uq34CTjh1CNUZKTK/DMOku80wuS1wwMWUZ8LaC7GX+pan7nMiBH
 PlSxYN/wSynSDcRVU9xqbh3ETpq24qqKa2H6hKL3SaD8BYGZHMzH0XUQhH4+tUhSBelAN0/
 oV1IWZvIuw6fSgLp+YzXxsFClhci/e3FGdxJ+tdj/z2L8xrUg3ugeVVdbJJSdOwW1J7zUAx
 y2wsxx3Tan+eWs87iAF5g==
UI-OutboundReport: notjunk:1;M01:P0:7T/bJHfm0zo=;mlkxskOMvtMxUN6zqKYCo+JO+dz
 cbtZN3FDaMWroLJbD9pEsWjlxWdoqNrzrr8jhP86ERWxFIVlHRi8mqQS51dwxV8VwWmIln3pL
 O4bSx0P2DY64RiVyIrPB5hyqvr8cZgkCKfDQStrVXgSMMB7t7U/GV6iGstHXz7KA63WnE3+5C
 tACIJIqZbMgOdSm6B9Wz5e+lT30ZV78vRIdzBODp0qeZXPgu0xeINbl/fbjGk3ihIrkUHOm6D
 qjDt4j/v7h0ouaZyxzLoSRNAFwH2fP/CFLx1z0ux7AX8vRufXyHUwKbNoWbKjAUKcz59we1ZY
 plfBzQ5CtJVGlf2m/43hkFhChRXIwzQDOJLvldGlKEGuL+ioFTdqQIrXRCjlHx2GddAcpAVxd
 gZehR57nN/S7gS+RcL8glA/bFm8QZHrmVArdM+HiLMXY2uIgyZwZrxyhTLBcJHA4fn5vEA/6j
 4njf81TJEYqqKJVhw0C1DP24L/K9kJ6o5ZAYp8tcUHltSxwobwX44DJDneiGtj6odJeBoTkJP
 rOOF5S3bekJOOzaoOmYnd812VaX4k2UfL4kzzWZvV4wXcRnG2D8jLMsSeIVKZcln6pEL173Cl
 gVOETRn70fBwqlKPPJLwSjxjhv2k+oJ+foDFo1It3dtX3LsJd9EpiFkcpGYrF/Xz+WdQ4kfIp
 mmRxr80FGSF0qsl8CMo6HU7vnXaYlxUHFMB4Zxn0W8S9u6x0W5Ah5pZZlu1Al2UtFxGRI24pQ
 +sntws0MioCNc8JWFpQGN6WxQoqr9EHxENCcM1cxUxigla+WY08HVscKeJffHJw3pOk35LWTk
 E2BZzHjoRIqYeOWxfmhfE4Kuoo0rNufDABU2gk/6eYFEk=
X-Mailman-Approved-At: Thu, 16 May 2024 14:50:16 +0200
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

Stderr was missing from the initial description and example.

As I understand the env command documentation the subcommand style is
preferred, though the old format is still fully supported.

Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
Changes in v2:
* Mention stderr redirection
* Use 4 spaces instead of tabs for code block to avoid overflowing
  lines

 doc/usage/netconsole.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/usage/netconsole.rst b/doc/usage/netconsole.rst
index 647f0c220b..f745615d9a 100644
=2D-- a/doc/usage/netconsole.rst
+++ b/doc/usage/netconsole.rst
@@ -3,10 +3,10 @@ Network console

 In U-Boot, we implemented the networked console via the standard
 "devices" mechanism, which means that you can switch between the
-serial and network input/output devices by adjusting the 'stdin' and
-'stdout' environment variables. To switch to the networked console,
-set either of these variables to "nc". Input and output can be
-switched independently.
+serial and network input/output devices by adjusting the 'stdin',
+'stdout', and 'stderr' environment variables. To switch to the
+networked console, set either of these variables to "nc". Input and
+output can be switched independently.

 The default buffer size can be overridden by setting
 CFG_NETCONSOLE_BUFFER_SIZE.
@@ -24,10 +24,10 @@ can be used for network console.

 For example, if your server IP is 192.168.1.1, you could use::

-	=3D> setenv nc 'setenv stdout nc;setenv stdin nc'
-	=3D> setenv ncip 192.168.1.1
-	=3D> saveenv
-	=3D> run nc
+    =3D> env set nc 'env set stdout nc; env set stderr nc; env set stdin =
nc'
+    =3D> env set ncip 192.168.1.1
+    =3D> env save
+    =3D> run nc

 On the host side, please use this script to access the console

=2D-
2.43.0

