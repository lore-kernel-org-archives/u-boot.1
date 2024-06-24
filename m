Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2771AC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 19:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11416883BA;
	Mon, 24 Jun 2024 21:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="RJTk15iu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3622688387; Mon, 24 Jun 2024 19:00:47 +0200 (CEST)
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 451F9883B1
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 19:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=bage@debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org; 
 s=smtpauto.stravinsky;
 h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=GQWbYXEALvJSlRXbTNuGcBBbXUNvkFldaKQZ3Yijilk=; b=RJTk15iu/DUlAYCZv1IRXUfAx/
 18eWFWUkf54lZIVXpxIs+oGBWsw9fz763q8X6PUoJBv108tfE+9WqsGE1vA/QErbMg8AcEc4WXVzN
 9kIAvZQkHr2ZSE10cpcqmqPUHUWuwwN9t9V5IoBGbjMMrbdW5ZCOFOkipnUwb8KQ3Rzu2rwst/qu9
 wbm0E28xGacxsccbM3EvvrZ8kCUnQRJY7Q5rsSdUK9RAfSYl15kElbUvCXto6YpFtqec6bDkku64s
 IEhQG4GGr1W3H33sieCPXcTXSQEQ9SOx2eUh4FM/qVESXnZKPWY3LfGHZnxBBw1OwAioJ/5lvTMR0
 aj+cA2qA==;
Received: from authenticated user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2) (envelope-from <bage@debian.org>)
 id 1sLn3c-000viT-GC; Mon, 24 Jun 2024 17:00:44 +0000
From: Bastian Germann <bage@debian.org>
To: u-boot@lists.denx.de
Cc: Bastian Germann <bage@debian.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH] doc: fit: Make data-size a conditionally mandatory property
Date: Mon, 24 Jun 2024 19:00:38 +0200
Message-ID: <20240624170041.1024-1-bage@debian.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: bage
X-Mailman-Approved-At: Mon, 24 Jun 2024 21:08:32 +0200
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

Before 9d0750064e (doc: Move external FIT docs into the main body), the
FIT property data-size was not a mandatory property and still it is not
expected to be set alongside the data property.

Move the data-size property to the "Conditionally mandatory property"
section, where it actually belongs.

Signed-off-by: Bastian Germann <bage@debian.org>
---
 doc/usage/fit/source_file_format.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/usage/fit/source_file_format.rst b/doc/usage/fit/source_file_format.rst
index 7727ab77c5..15990e3ff5 100644
--- a/doc/usage/fit/source_file_format.rst
+++ b/doc/usage/fit/source_file_format.rst
@@ -254,9 +254,6 @@ compression
     zstd                  zstd compressed
     ====================  ==================
 
-data-size
-    size of the data in bytes
-
 
 Conditionally mandatory property
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -276,6 +273,9 @@ data-position
     not relative to the loading of the FIT. This is mandatory if external data
     used with a fixed address.
 
+data-size
+    Size of the data in bytes. This is mandatory if external data is used.
+
 os
     OS name, mandatory for types "kernel". Valid OS names are:
 
-- 
2.45.2

