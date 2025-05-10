Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1353C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 327BF82AB1;
	Sat, 10 May 2025 13:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Au9F+QtL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061A982AE1; Sat, 10 May 2025 13:06:16 +0200 (CEST)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38E8082AAF
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x644.google.com with SMTP id
 a640c23a62f3a-ad243cdbe98so3065566b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875172; x=1747479972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOiix/NzHY4VQri9jzThFN1yX3c8/TQ0E7g8EIpfvqc=;
 b=Au9F+QtLKvAmTpsStPX3u3XskJ6Pk0YlDWnrE7TdFTMG4r4Gh7nA8vbYZQhs6SvAjS
 GviPido5NO/PAiDz998tOVaO8g0cQBOCMmRdthC8dlrU75ZLUfbKVjqJ0P8DeHCvWBZu
 lZxIW6VAi5lDk7ZZufD29IksCTgrhsf0OtRQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875172; x=1747479972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOiix/NzHY4VQri9jzThFN1yX3c8/TQ0E7g8EIpfvqc=;
 b=GSPcLoB5odjmxfKjhVGVUaZLtZaCEDv719HxJMRq3n353ClVxG2OWTHl/sl9pwCWlq
 uQUZEVl83QNXC5BWRuszvThT84aUJguDtTnyOVNW/uECEXLoXayNtORIZnnFED3zn506
 Dt1ntpF5SfULoLdc5s3njRXopsy9KOu5+3CprfEmVaXAN2BX77bj6hA2ivX9sFrBIWJE
 HUEYdQ+GBKTO2B6ZScANEU9m9g1VvpzDe0UZv/Eh1oxk4xLSPFodHlkY003xZytoQoO8
 6KKcb8rE0QDrZnU63dn5GPlOC+wYplMCvxciVaOZIDtoLeCA+WnETB8fhSpf63nKOQWF
 sDsA==
X-Gm-Message-State: AOJu0YyHM/uNGgy/gVKEWtAYcIx3es+ifXKyyNx2gCrT2Jor44RdLQzE
 SSUiXxVO1AQKz9jNWyIJyBNhtp+MuqAsLgTqQc5lMcyS7/nSLgKeGWOt680+ZyVOT+P4S3dDdM4
 vN63jo0XZOMTL
X-Gm-Gg: ASbGncs5tHdV/KVPrFn8QK8x+rXGen/cBtgkAjm85Fa2bM0Tizg13mxxD399XWcEzGq
 o0GS77qYert+8xh1Bn+D5hY5502i/8tlBHe5M9d3C1CzJR16t9ZYQsmd3u4c9djVFJFYUAbdPLL
 m0vpbMSx/3J+FreNrvXxH7LqvICvniD78U7uSAUBICSHah6TV1xp2CLs8wcwM7V+ElicbXDyeqW
 QvZ9FcV0y4hNs3Rh+uAGgek4rEFZ6yU2Ge2mgwFXHbOOjjqwftHAAQsa1mGmjAot4N4no5utvOl
 OLP2/LlQw9vjP4MnGHOQGP1xhttH7JhYg9uQ2ftT7+H6/39F2iooQzmIxQ==
X-Google-Smtp-Source: AGHT+IH/Lr3Vjlo1/VqC4UQZmdgaZyPUO6wlNIv2UstemiNLgoxjwA5r+dDsmlKetqkBPq3n/ZZfyA==
X-Received: by 2002:a17:907:7856:b0:ad2:1f65:8569 with SMTP id
 a640c23a62f3a-ad21f65877amr404290166b.28.1746875171451; 
 Sat, 10 May 2025 04:06:11 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/25] patman: Enhance patchwork interface to support Cseries
Date: Sat, 10 May 2025 13:05:06 +0200
Message-ID: <20250510110535.1453745-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

Add various new requests to the Patchwork class, so we can obtain the
required information. This includes cover letters and comments.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/patchwork.py | 428 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 424 insertions(+), 4 deletions(-)

diff --git a/tools/patman/patchwork.py b/tools/patman/patchwork.py
index afafb97ffed..d485648e467 100644
--- a/tools/patman/patchwork.py
+++ b/tools/patman/patchwork.py
@@ -9,8 +9,36 @@ import asyncio
 import re
 
 import aiohttp
+from collections import namedtuple
+
 from u_boot_pylib import terminal
 
+# Information passed to series_get_states()
+# link (str): Patchwork link for series
+# series_id (int): Series ID in database
+# series_name (str): Series name
+# version (int): Version number of series
+# show_comments (bool): True to show comments
+# show_cover_comments (bool): True to show cover-letter comments
+STATE_REQ = namedtuple(
+    'state_req',
+    'link,series_id,series_name,version,show_comments,show_cover_comments')
+
+# Responses from series_get_states()
+# int: ser_ver ID number
+# COVER: Cover-letter info
+# list of Patch: Information on each patch in the series
+# list of dict: patches, see get_series()['patches']
+STATE_RESP = namedtuple('state_resp', 'svid,cover,patches,patch_list')
+
+# Information about a cover-letter on patchwork
+# id (int): Patchwork ID of cover letter
+# state (str): Current state, e.g. 'accepted'
+# num_comments (int): Number of comments
+# name (str): Series name
+# comments (list of dict): Comments
+COVER = namedtuple('cover', 'id,num_comments,name,comments')
+
 # Number of retries
 RETRIES = 3
 
@@ -206,6 +234,165 @@ class Patchwork:
         pwork.fake_request = func
         return pwork
 
+    class _Stats:
+        def __init__(self, parent):
+            self.parent = parent
+            self.request_count = 0
+
+        def __enter__(self):
+            return self
+
+        def __exit__(self, exc_type, exc_val, exc_tb):
+            self.request_count = self.parent.request_count
+
+    def collect_stats(self):
+        """Context manager to count requests across a range of patchwork calls
+
+        Usage:
+            pwork = Patchwork(...)
+            with pwork.count_requests() as counter:
+                pwork.something()
+            print(f'{counter.count} requests')
+        """
+        self.request_count = 0
+        return self._Stats(self)
+
+    async def get_projects(self):
+        """Get a list of projects on the server
+
+        Returns:
+            list of dict, one for each project
+                'name' (str): Project name, e.g. 'U-Boot'
+                'id' (int): Project ID, e.g. 9
+                'link_name' (str): Project's link-name, e.g. 'uboot'
+        """
+        async with aiohttp.ClientSession() as client:
+            return await self._request(client, 'projects/')
+
+    async def _query_series(self, client, desc):
+        """Query series by name
+
+        Args:
+            client (aiohttp.ClientSession): Session to use
+            desc: String to search for
+
+        Return:
+            list of series matches, each a dict, see get_series()
+        """
+        query = desc.replace(' ', '+')
+        return await self._request(
+            client, f'series/?project={self.proj_id}&q={query}')
+
+    async def _find_series(self, client, svid, ser_id, version, ser):
+        """Find a series on the server
+
+        Args:
+            client (aiohttp.ClientSession): Session to use
+            svid (int): ser_ver ID
+            ser_id (int): series ID
+            version (int): Version number to search for
+            ser (Series): Contains description (cover-letter title)
+
+        Returns:
+            tuple:
+                int: ser_ver ID (as passed in)
+                int: series ID (as passed in)
+                str: Series link, or None if not found
+                list of dict, or None if found
+                    each dict is the server result from a possible series
+        """
+        desc = ser.desc
+        name_found = []
+
+        # Do a series query on the description
+        res = await self._query_series(client, desc)
+        for pws in res:
+            if pws['name'] == desc:
+                if int(pws['version']) == version:
+                    return svid, ser_id, pws['id'], None
+                name_found.append(pws)
+
+        # When there is no cover letter, patchwork uses the first patch as the
+        # series name
+        cmt = ser.commits[0]
+
+        res = await self._query_series(client, cmt.subject)
+        for pws in res:
+            patch = Patch(0)
+            patch.parse_subject(pws['name'])
+            if patch.subject == cmt.subject:
+                if int(pws['version']) == version:
+                    return svid, ser_id, pws['id'], None
+                name_found.append(pws)
+
+        return svid, ser_id, None, name_found or res
+
+    async def find_series(self, ser, version):
+        """Find a series based on its description and version
+
+        Args:
+            ser (Series): Contains description (cover-letter title)
+            version (int): Version number
+
+        Return: tuple:
+            tuple:
+                str: Series ID, or None if not found
+                list of dict, or None if found
+                    each dict is the server result from a possible series
+            int: number of server requests done
+        """
+        async with aiohttp.ClientSession() as client:
+            # We don't know the svid and it isn't needed, so use -1
+            _, _, link, options = await self._find_series(client, -1, -1,
+                                                          version, ser)
+        return link, options
+
+    async def find_series_list(self, to_find):
+        """Find the link for each series in a list
+
+        Args:
+            to_find (dict of svids to sync):
+                key (int): ser_ver ID
+                value (tuple):
+                    int: Series ID
+                    int: Series version
+                    str: Series link
+                    str: Series description
+
+        Return: tuple:
+            list of tuple, one for each item in to_find:
+                int: ser_ver_ID
+                int: series ID
+                int: Series version
+                str: Series link, or None if not found
+                list of dict, or None if found
+                    each dict is the server result from a possible series
+            int: number of server requests done
+        """
+        self.request_count = 0
+        async with aiohttp.ClientSession() as client:
+            tasks = [asyncio.create_task(
+                self._find_series(client, svid, ser_id, version, desc))
+                for svid, (ser_id, version, link, desc) in to_find.items()]
+            results = await asyncio.gather(*tasks)
+
+        return results, self.request_count
+
+    def project_set(self, project_id, link_name):
+        """Set the project ID
+
+        The patchwork server has multiple projects. This allows the ID and
+        link_name of the relevant project to be selected
+
+        This function is used for testing
+
+        Args:
+            project_id (int): Project ID to use, e.g. 6
+            link_name (str): Name to use for project URL links, e.g. 'uboot'
+        """
+        self.proj_id = project_id
+        self.link_name = link_name
+
     async def get_series(self, client, link):
         """Read information about a series
 
@@ -365,9 +552,220 @@ class Patchwork:
         """
         return await self._request(client, f'patches/{patch_id}/comments/')
 
-    async def get_patch_comments(self, patch_id):
+    async def get_cover(self, client, cover_id):
+        """Read information about a cover letter
+
+        Args:
+            client (aiohttp.ClientSession): Session to use
+            cover_id (int): Patchwork cover-letter ID
+
+        Returns: dict containing patchwork's cover-letter information:
+            id (int): series ID unique across patchwork instance, e.g. 3
+            url (str): Full URL, e.g. https://patchwork.ozlabs.org/project/uboot/list/?series=3
+            project (dict): project information (id, url, name, link_name,
+                list_id, list_email, etc.
+            url (str): Full URL, e.g. 'https://patchwork.ozlabs.org/api/1.2/covers/2054866/'
+            web_url (str): Full URL, e.g. 'https://patchwork.ozlabs.org/project/uboot/cover/20250304130947.109799-1-sjg@chromium.org/'
+            project (dict): project information (id, url, name, link_name,
+                list_id, list_email, etc.
+            msgid (str): Message ID, e.g. '20250304130947.109799-1-sjg@chromium.org>'
+            list_archive_url (?)
+            date (str): Date, e.g. '2017-08-27T08:00:51'
+            name (str): Series name, e.g. '[U-Boot] moveconfig: fix error'
+            submitter (dict): id, url, name, email, e.g.:
+                "id": 6170,
+                "url": "https://patchwork.ozlabs.org/api/1.2/people/6170/",
+                "name": "Simon Glass",
+                "email": "sjg@chromium.org"
+            mbox (str): URL to mailbox, e.g. 'https://patchwork.ozlabs.org/project/uboot/cover/20250304130947.109799-1-sjg@chromium.org/mbox/'
+            series (list of dict) each e.g.:
+                "id": 446956,
+                "url": "https://patchwork.ozlabs.org/api/1.2/series/446956/",
+                "web_url": "https://patchwork.ozlabs.org/project/uboot/list/?series=446956",
+                "date": "2025-03-04T13:09:37",
+                "name": "binman: Check code-coverage requirements",
+                "version": 1,
+                "mbox": "https://patchwork.ozlabs.org/series/446956/mbox/"
+            comments: Web URL to comments: 'https://patchwork.ozlabs.org/api/covers/2054866/comments/'
+            headers: dict: e.g.:
+                "Return-Path": "<u-boot-bounces@lists.denx.de>",
+                "X-Original-To": "incoming@patchwork.ozlabs.org",
+                "Delivered-To": "patchwork-incoming@legolas.ozlabs.org",
+                "Authentication-Results": [
+                    "legolas.ozlabs.org;
+\tdkim=pass (1024-bit key;
+ unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
+ header.s=google header.b=dG8yqtoK;
+\tdkim-atps=neutral",
+                    "legolas.ozlabs.org;
+ spf=pass (sender SPF authorized) smtp.mailfrom=lists.denx.de
+ (client-ip=85.214.62.61; helo=phobos.denx.de;
+ envelope-from=u-boot-bounces@lists.denx.de; receiver=patchwork.ozlabs.org)",
+                    "phobos.denx.de;
+ dmarc=pass (p=none dis=none) header.from=chromium.org",
+                    "phobos.denx.de;
+ spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de",
+                    "phobos.denx.de;
+\tdkim=pass (1024-bit key;
+ unprotected) header.d=chromium.org header.i=@chromium.org
+ header.b=\"dG8yqtoK\";
+\tdkim-atps=neutral",
+                    "phobos.denx.de;
+ dmarc=pass (p=none dis=none) header.from=chromium.org",
+                    "phobos.denx.de;
+ spf=pass smtp.mailfrom=sjg@chromium.org"
+                ],
+                "Received": [
+                    "from phobos.denx.de (phobos.denx.de [85.214.62.61])
+\t(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
+\t key-exchange X25519 server-signature ECDSA (secp384r1))
+\t(No client certificate requested)
+\tby legolas.ozlabs.org (Postfix) with ESMTPS id 4Z6bd50jLhz1yD0
+\tfor <incoming@patchwork.ozlabs.org>; Wed,  5 Mar 2025 00:10:00 +1100 (AEDT)",
+                    "from h2850616.stratoserver.net (localhost [IPv6:::1])
+\tby phobos.denx.de (Postfix) with ESMTP id 434E88144A;
+\tTue,  4 Mar 2025 14:09:58 +0100 (CET)",
+                    "by phobos.denx.de (Postfix, from userid 109)
+ id 8CBF98144A; Tue,  4 Mar 2025 14:09:57 +0100 (CET)",
+                    "from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
+ [IPv6:2607:f8b0:4864:20::d2e])
+ (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
+ (No client certificate requested)
+ by phobos.denx.de (Postfix) with ESMTPS id 48AE281426
+ for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:09:55 +0100 (CET)",
+                    "by mail-io1-xd2e.google.com with SMTP id
+ ca18e2360f4ac-85ae33109f6so128326139f.2
+ for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:09:55 -0800 (PST)",
+                    "from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
+ [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
+ ca18e2360f4ac-858753cd304sm287383839f.33.2025.03.04.05.09.49
+ (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
+ Tue, 04 Mar 2025 05:09:50 -0800 (PST)"
+                ],
+                "X-Spam-Checker-Version": "SpamAssassin 3.4.2 (2018-09-13) on phobos.denx.de",
+                "X-Spam-Level": "",
+                "X-Spam-Status": "No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
+ DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
+ RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
+ autolearn_force=no version=3.4.2",
+                "DKIM-Signature": "v=1; a=rsa-sha256; c=relaxed/relaxed;
+ d=chromium.org; s=google; t=1741093792; x=1741698592; darn=lists.denx.de;
+ h=content-transfer-encoding:mime-version:message-id:date:subject:cc
+ :to:from:from:to:cc:subject:date:message-id:reply-to;
+ bh=B2zsLws430/BEZfatNjeaNnrcxmYUstVjp1pSXgNQjc=;
+ b=dG8yqtoKpSy15RHagnPcppzR8KbFCRXa2OBwXfwGoyN6M15tOJsUu2tpCdBFYiL5Mk
+ hQz5iDLV8p0Bs+fP4XtNEx7KeYfTZhiqcRFvdCLwYtGray/IHtOZaNoHLajrstic/OgE
+ 01ymu6gOEboU32eQ8uC8pdCYQ4UCkfKJwmiiU=",
+                "X-Google-DKIM-Signature": "v=1; a=rsa-sha256; c=relaxed/relaxed;
+ d=1e100.net; s=20230601; t=1741093792; x=1741698592;
+ h=content-transfer-encoding:mime-version:message-id:date:subject:cc
+ :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
+ :reply-to;
+ bh=B2zsLws430/BEZfatNjeaNnrcxmYUstVjp1pSXgNQjc=;
+ b=eihzJf4i9gin9usvz4hnAvvbLV9/yB7hGPpwwW/amgnPUyWCeQstgvGL7WDLYYnukH
+ 161p4mt7+cCj7Hao/jSPvVZeuKiBNPkS4YCuP3QjXfdk2ziQ9IjloVmGarWZUOlYJ5iQ
+ dZnxypUkuFfLcEDSwUmRO1dvLi3nH8PDlae3yT2H87LeHaxhXWdzHxQdPc86rkYyCqCr
+ qBC2CTS31jqSuiaI+7qB3glvbJbSEXkunz0iDewTJDvZfmuloxTipWUjRJ1mg9UJcZt5
+ 9xIuTq1n9aYf1RcQlrEOQhdBAQ0/IJgvmZtzPZi9L+ppBva1ER/xm06nMA7GEUtyGwun
+ c6pA==",
+                "X-Gm-Message-State": "AOJu0Yybx3b1+yClf/IfIbQd9u8sxzK9ixPP2HimXF/dGZfSiS7Cb+O5
+ WrAkvtp7m3KPM/Mpv0sSZ5qrfTnKnb3WZyv6Oe5Q1iUjAftGNwbSxob5eJ/0y3cgrTdzE4sIWPE
+ =",
+                "X-Gm-Gg": "ASbGncu5gtgpXEPGrpbTRJulqFrFj1YPAAmKk4MiXA8/3J1A+25F0Uug2KeFUrZEjkG
+ KMdPg/C7e2emIvfM+Jl+mKv0ITBvhbyNCyY1q2U1s1cayZF05coZ9ewzGxXJGiEqLMG69uBmmIi
+ rBEvCnkXS+HVZobDQMtOsezpc+Ju8JRA7+y1R0WIlutl1mQARct6p0zTkuZp75QyB6dm/d0KYgd
+ iux/t/f0HC2CxstQlTlJYzKL6UJgkB5/UorY1lW/0NDRS6P1iemPQ7I3EPLJO8tM5ZrpJE7qgNP
+ xy0jXbUv44c48qJ1VszfY5USB8fRG7nwUYxNu6N1PXv9xWbl+z2xL68qNYUrFlHsB8ILTXAyzyr
+ Cdj+Sxg==",
+                "X-Google-Smtp-Source": "
+ AGHT+IFeVk5D4YEfJgPxOfg3ikO6Q7IhaDzABGkAPI6HA0ubK85OPhUHK08gV7enBQ8OdoE/ttqEjw==",
+                "X-Received": "by 2002:a05:6602:640f:b0:855:63c8:abb5 with SMTP id
+ ca18e2360f4ac-85881fdba3amr1839428939f.13.1741093792636;
+ Tue, 04 Mar 2025 05:09:52 -0800 (PST)",
+                "From": "Simon Glass <sjg@chromium.org>",
+                "To": "U-Boot Mailing List <u-boot@lists.denx.de>",
+                "Cc": "Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
+ Alper Nebi Yasak <alpernebiyasak@gmail.com>,
+ Brandon Maier <brandon.maier@collins.com>,
+ Jerome Forissier <jerome.forissier@linaro.org>,
+ Jiaxun Yang <jiaxun.yang@flygoat.com>,
+ Neha Malcom Francis <n-francis@ti.com>,
+ Patrick Rudolph <patrick.rudolph@9elements.com>,
+ Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
+ Philippe Reynes <philippe.reynes@softathome.com>,
+ Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
+ Tom Rini <trini@konsulko.com>",
+                "Subject": "[PATCH 0/7] binman: Check code-coverage requirements",
+                "Date": "Tue,  4 Mar 2025 06:09:37 -0700",
+                "Message-ID": "<20250304130947.109799-1-sjg@chromium.org>",
+                "X-Mailer": "git-send-email 2.43.0",
+                "MIME-Version": "1.0",
+                "Content-Transfer-Encoding": "8bit",
+                "X-BeenThere": "u-boot@lists.denx.de",
+                "X-Mailman-Version": "2.1.39",
+                "Precedence": "list",
+                "List-Id": "U-Boot discussion <u-boot.lists.denx.de>",
+                "List-Unsubscribe": "<https://lists.denx.de/options/u-boot>,
+ <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>",
+                "List-Archive": "<https://lists.denx.de/pipermail/u-boot/>",
+                "List-Post": "<mailto:u-boot@lists.denx.de>",
+                "List-Help": "<mailto:u-boot-request@lists.denx.de?subject=help>",
+                "List-Subscribe": "<https://lists.denx.de/listinfo/u-boot>,
+ <mailto:u-boot-request@lists.denx.de?subject=subscribe>",
+                "Errors-To": "u-boot-bounces@lists.denx.de",
+                "Sender": "\"U-Boot\" <u-boot-bounces@lists.denx.de>",
+                "X-Virus-Scanned": "clamav-milter 0.103.8 at phobos.denx.de",
+                "X-Virus-Status": "Clean"
+            content (str): Email content, e.g. 'This series adds a cover-coverage check to CI for Binman. The iMX8 tests
+are still not completed,...'
+        """
         async with aiohttp.ClientSession() as client:
-            return await self._get_patch_comments(client, patch_id)
+            return await self._request(client, f'covers/{cover_id}/')
+
+    async def get_cover_comments(self, client, cover_id):
+        """Read comments about a cover letter
+
+        Args:
+            client (aiohttp.ClientSession): Session to use
+            cover_id (str): Patchwork cover-letter ID
+
+        Returns: list of dict: list of comments, each:
+            id (int): series ID unique across patchwork instance, e.g. 3472068
+            web_url (str): Full URL, e.g. 'https://patchwork.ozlabs.org/comment/3472068/'
+            list_archive_url: (unknown?)
+
+            project (dict): project information (id, url, name, link_name,
+                list_id, list_email, etc.
+            url (str): Full URL, e.g. 'https://patchwork.ozlabs.org/api/1.2/covers/2054866/'
+            web_url (str): Full URL, e.g. 'https://patchwork.ozlabs.org/project/uboot/cover/20250304130947.109799-1-sjg@chromium.org/'
+            project (dict): project information (id, url, name, link_name,
+                list_id, list_email, etc.
+            date (str): Date, e.g. '2025-03-04T13:16:15'
+            subject (str): 'Re: [PATCH 0/7] binman: Check code-coverage requirements'
+            submitter (dict): id, url, name, email, e.g.:
+                "id": 6170,
+                "url": "https://patchwork.ozlabs.org/api/people/6170/",
+                "name": "Simon Glass",
+                "email": "sjg@chromium.org"
+            content (str): Email content, e.g. 'Hi,
+
+On Tue, 4 Mar 2025 at 06:09, Simon Glass <sjg@chromium.org> wrote:
+>
+> This '...
+            headers: dict: email headers, see get_cover() for an example
+        """
+        return await self._request(client, f'covers/{cover_id}/comments/')
+
+    async def get_series_url(self, link):
+        """Get the URL for a series
+
+        Args:
+            link (str): Patchwork series ID
+
+        Returns:
+            str: URL for the series page
+        """
+        return f'{self.url}/project/{self.link_name}/list/?series={link}&state=*&archive=both'
 
     async def _get_patch_status(self, client, patch_id):
         """Get the patch status
@@ -388,6 +786,26 @@ class Patchwork:
 
         return Patch(patch_id, state, data, comment_data)
 
+    async def get_series_cover(self, client, data):
+        """Get the cover information (including comments)
+
+        Args:
+            client (aiohttp.ClientSession): Session to use
+            data (dict): Return value from self.get_series()
+
+        Returns:
+            COVER object, or None if no cover letter
+        """
+        # Patchwork should always provide this, but use get() so that we don't
+        # have to provide it in our fake patchwork _fake_patchwork_cser()
+        cover = data.get('cover_letter')
+        cover_id = None
+        if cover:
+            cover_id = cover['id']
+            info = await self.get_cover_comments(client, cover_id)
+            cover = COVER(cover_id, len(info), cover['name'], info)
+        return cover
+
     async def series_get_state(self, client, link, read_comments,
                                read_cover_comments):
         """Sync the series information against patchwork, to find patch status
@@ -426,7 +844,9 @@ class Patchwork:
         if self._show_progress:
             terminal.print_clear()
 
-        # TODO: Implement this
-        cover = None
+        if read_cover_comments:
+            cover = await self.get_series_cover(client, data)
+        else:
+            cover = None
 
         return cover, patches
-- 
2.43.0

