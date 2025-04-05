Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F1DC36018
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 19:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F89782AC2;
	Sat,  5 Apr 2025 21:06:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743879982;
	bh=KXf0vFG6bjO/2iFb22iDsHgsYVTvK+jpE2xbM6ID7XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I2Pzcx+jsvEMgNgbGdLEAQ8W3mYd9T69wfZRI/mfvcdrN/nwuEtyRoQoUFezD5CRK
	 HxmkclUldj72Oc6HZgg6MDDIroLfpd3Ro6KiyToJm9leqsJvTNUBAC8hUoU+lCU35x
	 oc7/bqsCctmnlfTHIDDBr9kGwC+fkmwdPYS+QnRnkxy3syn4R0c+FhedMEiP6iVnxf
	 HxbifRbqe5bzovl2Nf8cDb1xcB7/s8F7FQ1/T87oPMBOhngVg56RLdVGbt4ZVMkySP
	 uJvoPRLor8MDB63Eu6KKWOaXwNK+l0hUbdaV986KXR18N01k/s+OvQplOs5P2u23bH
	 GgJ052ZLdjUWg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81BE481F45; Sat,  5 Apr 2025 21:06:20 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A85BB82B27
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 21:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SsIBacbU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0201910252EF9; 
 Sat,  5 Apr 2025 21:06:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743879977; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=KXf0vFG6bjO/2iFb22iDsHgsYVTvK+jpE2xbM6ID7XY=;
 b=SsIBacbUZdhEsH0xCE+P2rpuDNSx9pzIH00T00HmGrSHCDA/qih66JK9am4Kkqzc5ysvZF
 pGt9nmJ5O26eKhviB3pIziCKR1CA4tJ8KKdANi2TP3hj5XpMewTkCo1WhpAzGAc+AprKrt
 rNzaprc5dUqwpuqbPfgaToLPhnP+LcSJITzg/ry1RVFgdRUbKbKPS7nUcw2Vs818UWiV8z
 UkRn1eE5RSzgePR6yXwcgskAHVHTYFZsRZSvcvp9Z/DxPAqeTKyYcWuAwqq4ukMHrEHTRF
 dQclUcG+1sidIf0b5WyEIeHD+0Ee7Q+6FJDuzcMx8Ny2fBo4oLz7fzztGljsWQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 8/8] scripts: add helper for getting infos from your
 patchwork ToDo list
Date: Sat,  5 Apr 2025 21:06:00 +0200
Message-Id: <20250405190600.24081-9-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250405190600.24081-1-hs@denx.de>
References: <20250405190600.24081-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Heiko Schocher <hs@nabladev.com>

The new script scripts/getpatchlist.py list for all patches in your
Patchworks ToDo list the PATCH ID and MESSAGE ID.

With that script you can eaysy do in your current U-Boot tree:

    MIL=$(scripts/getpatchlist.py <your username> <your patchwork password> | cut -d " " -f 2)
    for m in $MIL;do
        rm -rf mbox
        wget http://patchwork.ozlabs.org/project/uboot/patch/$m/mbox
        scripts/checkpatch.pl mbox
        git am -3 --whitespace=strip mbox
    done

And you have all your patches from your ToDo list downloaded,
checked with the checkpatch.pl script and applied to your current
branch.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

(no changes since v1)

 MAINTAINERS             |   1 +
 scripts/getpatchlist.py | 126 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100755 scripts/getpatchlist.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 90a54deedb..24238a8f5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1678,6 +1678,7 @@ F:	cmd/broadcom/chimp_handshake.c
 TBOTTEST
 M:	Heiko Schocher <hs@nabladev.com>
 S:	Maintained
+F:	scripts/getpatchlist.py
 F:	tbottesting/*
 
 TDA19988 HDMI ENCODER
diff --git a/scripts/getpatchlist.py b/scripts/getpatchlist.py
new file mode 100755
index 0000000000..3df483b1da
--- /dev/null
+++ b/scripts/getpatchlist.py
@@ -0,0 +1,126 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0+
+
+import requests
+import argparse
+from bs4 import BeautifulSoup
+
+# URLs
+LOGIN_URL = "https://patchwork.ozlabs.org/user/login/"
+TODO_LIST_URL = "https://patchwork.ozlabs.org/user/todo/uboot/"
+
+def login_and_get_cookies(username, password):
+    # Start a session to maintain cookies
+    session = requests.Session()
+
+    # Get the CSRF token by sending a GET request to the login page
+    response = session.get(LOGIN_URL)
+
+    # Check if the response is successful
+    if response.status_code != 200:
+        print(f"Error fetching login page: {response.status_code}")
+        return None, None
+
+    # Extract CSRF token from cookies or HTML
+    csrf_token = response.cookies.get('csrftoken')
+    if not csrf_token:
+        # If not found in cookies, extract it from the HTML form
+        soup = BeautifulSoup(response.text, "html.parser")
+        csrf_token = soup.find("input", {"name": "csrfmiddlewaretoken"})["value"]
+
+    #print(f"CSRF Token: {csrf_token}")
+
+    # Prepare login data
+    login_data = {
+        'username': username,
+        'password': password,
+        'csrfmiddlewaretoken': csrf_token,
+    }
+
+    # Send POST request to login
+    headers = {
+        'User-Agent': 'Mozilla/5.0',  # Common user-agent string
+        'Referer': LOGIN_URL  # Set Referer header to avoid potential issues
+    }
+
+    # Perform login
+    login_response = session.post(LOGIN_URL, data=login_data, headers=headers)
+
+    # If login is successful, extract session ID from cookies
+    if login_response.status_code == 200:
+        session_id = session.cookies.get('sessionid')  # Get session ID from cookies
+        #print(f"Session ID: {session_id}")
+        return session, session_id
+    else:
+        print(f"Login failed: {login_response.status_code}")
+        return None, None
+
+def get_todo_patch_and_message_ids(session):
+    response = session.get(TODO_LIST_URL)
+
+    if response.status_code != 200:
+        print(f"Error fetching todo list: {response.status_code}")
+        return []
+
+    soup = BeautifulSoup(response.text, "html.parser")
+
+    patch_data = []
+    for row in soup.select("tr[id^='patch_row']"):  # Identify all patch rows
+        # Extract the Patch ID from the 'id' attribute
+        patch_id = row.get("id").split(":")[1]
+
+        # Extract the Message ID from the patch URL
+        msg_id_tag = row.select_one('a[href^="/project/uboot/patch/"]')  # Look for the patch URL
+        if msg_id_tag:
+            msg_id = msg_id_tag["href"].split("/")[4]  # Extract the Message ID
+
+            patch_data.append((patch_id, msg_id))
+
+    return patch_data
+
+def main():
+    """
+    Get a list of your patches in your patchworks ToDo list. List for each patch the
+    PATCH ID and MESSAGE ID, so you can use them for example with the pwclient.py tool.
+
+    Or you can do in your current U-Boot tree:
+
+    MIL=$(scripts/getpatchlist.py <your username> <your patchwork password> | cut -d " " -f 2)
+    for m in $MIL;do
+        rm -rf mbox
+        wget http://patchwork.ozlabs.org/project/uboot/patch/$m/mbox
+        scripts/checkpatch.pl mbox
+        git am -3 --whitespace=strip mbox
+    done
+
+    And you have all your patches from your ToDo list downloaded, checked with the
+    checkpatch.pl script and applied to your current branch.
+    """
+    # Set up argument parser
+    parser = argparse.ArgumentParser(description="Login to Patchwork and get Todo list patches.")
+    parser.add_argument("username", help="Your Patchwork username")
+    parser.add_argument("password", help="Your Patchwork password")
+
+    # Parse arguments
+    args = parser.parse_args()
+
+    # Step 1: Login and get session
+    session, session_id = login_and_get_cookies(args.username, args.password)
+
+    if session:
+        # Step 2: Get patch IDs and message IDs
+        patches = get_todo_patch_and_message_ids(session)
+
+        if patches:
+            # print("Found Patch IDs and Message IDs:")
+            for patch_id, msg_id in patches:
+                print(f"{patch_id} {msg_id}")
+        else:
+            print("No patches found. Check the HTML structure!")
+            exit (1)
+    else:
+        print("Unable to login. Exiting.")
+        exit (2)
+
+if __name__ == "__main__":
+    main()
-- 
2.20.1

