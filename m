Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951FCC3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02095826B2;
	Tue, 29 Apr 2025 15:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eExisrKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A2182A25; Tue, 29 Apr 2025 15:24:36 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D8B828F8
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c1425fbfcso4878645a34.3
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933071; x=1746537871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJHedOEm6YXHs+fRGaz/q/2Qd6VLv2KPst2tiMdjG4M=;
 b=eExisrKmMhbogn0tdufEQtg8dxd8miIXR98R/6TrYmYlV8QRB6PyRZ9Zki2PKSMBxg
 1mYg4i54odrNSgk2GNIlZ7VJPNpYY4QbhtG0Egxwb+MHyuWZz6ahmCqZhZjOSGGPKlPT
 xjNmFNoo4oPqk1DMmcD9kvtlnkfMYDmXPlBaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933071; x=1746537871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJHedOEm6YXHs+fRGaz/q/2Qd6VLv2KPst2tiMdjG4M=;
 b=W0PGYxovSm1JwM/rnOr7++CbuU+fc3ekpImeqQvoOj/ced/4rcdjbRVuj+wtw8u7FH
 aIPUK1xH2/s0KKO7i/tzBSypgRzNpyw9LTp7+HH1HJO0qLRFMGyjpC7G6uuRyyVwWDDa
 5pw13sWcpXfWMWVPyLcN5hh+d8UyYlZWuAjqqouUclt4x8CvuSqpjrrXqGoMOjEFEZCR
 iaTpLNqz1YnUIxsxsgfCwgdEQ8up/A96h3E8dJAi94ZFx6IyIld9P3quIOmueZta9iep
 89Ah6sTCxEfV6TX7qtlPwJpN7Rlf5iLcPpO7qQ7oysbkNJ5/MtEjNZg3XHPJjfUXqwA4
 dj9g==
X-Gm-Message-State: AOJu0YxQZUiOjA24QMP+4YduIWzbOIyF7FHEigusGWzqKf4nhDN7CiN0
 tj06a3Y736s2qq9mHc8lJvXsaM4vf8pPGysXp/EHPsTBriUB5ZGRCEQOcRaz1F8AVITIyUuMpKw
 =
X-Gm-Gg: ASbGncs5LBmZ90H6v4yUVLBcchoE7hAl6QBmmVN2erFgtp/VES24lqYbnoYHO0FVvSp
 snoGdOLsEhuxeEWZDtXVmG52ywfuUM2FKm2P77CQFOb9oN6FtOLe7jEOU42OTQG/W97sGFAXpZX
 rWi/CG9xmTXtDZClrcZxEI15efeizDl5JEAxKvw9vh5CQzrl7Ajadz7f/KDWHdG/rcWMzh7z+re
 gJmZn3vPRIMCQmNwrK3gIGTYKLY8bIAozJyCgH9YCSdPuKiZWBLIbgxvdXZtlmEFohHb64OemX3
 m0Ga+4R3gvnCA3QzyZb5O6pJ3Beioyk4VxyFnHY8zeB1yzdjKjDqlwFTEtZ8Z/8HHc2fJI5N6t8
 8lw==
X-Google-Smtp-Source: AGHT+IEyR5dxE2vfREH+iahNUhbQQV3nQ4rfbO8qoVO0NcHZzjDqgagt1eLpD8LC+XyeipEqWp63cQ==
X-Received: by 2002:a05:6830:6619:b0:72c:320c:d898 with SMTP id
 46e09a7af769-73088c511f9mr2231389a34.22.1745933071472; 
 Tue, 29 Apr 2025 06:24:31 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:24:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/30] patman: Add reading of series and patch status
Date: Tue, 29 Apr 2025 07:22:15 -0600
Message-ID: <20250429132239.251756-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

Expand the patchwork module so that it can match the current
requirements of the 'patman status' command, i.e. reading the state of a
series and the patches associated with it.

Since the format of each patchwork response is a little tricky to
understand, add examples in comments at the top of each function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/patchwork.py | 218 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/tools/patman/patchwork.py b/tools/patman/patchwork.py
index bb3645455fe..e0adbdb6481 100644
--- a/tools/patman/patchwork.py
+++ b/tools/patman/patchwork.py
@@ -177,3 +177,221 @@ class Patchwork:
                 except aiohttp.client_exceptions.ServerDisconnectedError:
                     if i == RETRIES:
                         raise
+
+    async def get_series(self, client, link):
+        """Read information about a series
+
+        Args:
+            client (aiohttp.ClientSession): Session to use
+            link (str): Patchwork series ID
+
+        Returns: dict containing patchwork's series information
+            id (int): series ID unique across patchwork instance, e.g. 3
+            url (str): Full URL, e.g.
+                'https://patchwork.ozlabs.org/api/1.2/series/3/'
+            web_url (str): Full URL, e.g.
+                'https://patchwork.ozlabs.org/project/uboot/list/?series=3
+            project (dict): project information (id, url, name, link_name,
+                list_id, list_email, etc.
+            name (str): Series name, e.g. '[U-Boot] moveconfig: fix error'
+            date (str): Date, e.g. '2017-08-27T08:00:51'
+            submitter (dict): id, url, name, email, e.g.:
+                "id": 6125,
+                "url": "https://patchwork.ozlabs.org/api/1.2/people/6125/",
+                "name": "Chris Packham",
+                "email": "judge.packham@gmail.com"
+            version (int): Version number
+            total (int): Total number of patches based on subject
+            received_total (int): Total patches received by patchwork
+            received_all (bool): True if all patches were received
+            mbox (str): URL of mailbox, e.g.
+                'https://patchwork.ozlabs.org/series/3/mbox/'
+            cover_letter (dict) or None, e.g.:
+                "id": 806215,
+                "url": "https://patchwork.ozlabs.org/api/1.2/covers/806215/",
+                "web_url": "https://patchwork.ozlabs.org/project/uboot/cover/
+                    20170827094411.8583-1-judge.packham@gmail.com/",
+                "msgid": "<20170827094411.8583-1-judge.packham@gmail.com>",
+                "list_archive_url": null,
+                "date": "2017-08-27T09:44:07",
+                "name": "[U-Boot,v2,0/4] usb: net: Migrate USB Ethernet",
+                "mbox": "https://patchwork.ozlabs.org/project/uboot/cover/
+                    20170827094411.8583-1-judge.packham@gmail.com/mbox/"
+            patches (list of dict), each e.g.:
+                "id": 806202,
+                "url": "https://patchwork.ozlabs.org/api/1.2/patches/806202/",
+                "web_url": "https://patchwork.ozlabs.org/project/uboot/patch/
+                    20170827080051.816-1-judge.packham@gmail.com/",
+                "msgid": "<20170827080051.816-1-judge.packham@gmail.com>",
+                "list_archive_url": null,
+                "date": "2017-08-27T08:00:51",
+                "name": "[U-Boot] moveconfig: fix error message do_autoconf()",
+                "mbox": "https://patchwork.ozlabs.org/project/uboot/patch/
+                    20170827080051.816-1-judge.packham@gmail.com/mbox/"
+        """
+        return await self._request(client, f'series/{link}/')
+
+    async def get_patch(self, client, patch_id):
+        """Read information about a patch
+
+        Args:
+            client (aiohttp.ClientSession): Session to use
+            patch_id (str): Patchwork patch ID
+
+        Returns: dict containing patchwork's patch information
+            "id": 185,
+            "url": "https://patchwork.ozlabs.org/api/1.2/patches/185/",
+            "web_url": "https://patchwork.ozlabs.org/project/cbe-oss-dev/patch/
+                200809050416.27831.adetsch@br.ibm.com/",
+            project (dict): project information (id, url, name, link_name,
+                    list_id, list_email, etc.
+            "msgid": "<200809050416.27831.adetsch@br.ibm.com>",
+            "list_archive_url": null,
+            "date": "2008-09-05T07:16:27",
+            "name": "powerpc/spufs: Fix possible scheduling of a context",
+            "commit_ref": "b2e601d14deb2083e2a537b47869ab3895d23a28",
+            "pull_url": null,
+            "state": "accepted",
+            "archived": false,
+            "hash": "bc1c0b80d7cff66c0d1e5f3f8f4d10eb36176f0d",
+            "submitter": {
+                "id": 93,
+                "url": "https://patchwork.ozlabs.org/api/1.2/people/93/",
+                "name": "Andre Detsch",
+                "email": "adetsch@br.ibm.com"
+            },
+            "delegate": {
+                "id": 1,
+                "url": "https://patchwork.ozlabs.org/api/1.2/users/1/",
+                "username": "jk",
+                "first_name": "Jeremy",
+                "last_name": "Kerr",
+                "email": "jk@ozlabs.org"
+            },
+            "mbox": "https://patchwork.ozlabs.org/project/cbe-oss-dev/patch/
+                200809050416.27831.adetsch@br.ibm.com/mbox/",
+            "series": [],
+            "comments": "https://patchwork.ozlabs.org/api/patches/185/
+                comments/",
+            "check": "pending",
+            "checks": "https://patchwork.ozlabs.org/api/patches/185/checks/",
+            "tags": {},
+            "related": [],
+            "headers": {...}
+            "content": "We currently have a race when scheduling a context
+                after we have found a runnable context in spusched_tick, the
+                context may have been scheduled by spu_activate().
+
+                This may result in a panic if we try to unschedule a context
+                been freed in the meantime.
+
+                This change exits spu_schedule() if the context has already
+                scheduled, so we don't end up scheduling it twice.
+
+                Signed-off-by: Andre Detsch <adetsch@br.ibm.com>",
+            "diff": '''Index: spufs/arch/powerpc/platforms/cell/spufs/sched.c
+                =======================================================
+                --- spufs.orig/arch/powerpc/platforms/cell/spufs/sched.c
+                +++ spufs/arch/powerpc/platforms/cell/spufs/sched.c
+                @@ -727,7 +727,8 @@ static void spu_schedule(struct spu *spu
+                 \t/* not a candidate for interruptible because it's called
+                 \t   from the scheduler thread or from spu_deactivate */
+                 \tmutex_lock(&ctx->state_mutex);
+                -\t__spu_schedule(spu, ctx);
+                +\tif (ctx->state == SPU_STATE_SAVED)
+                +\t\t__spu_schedule(spu, ctx);
+                 \tspu_release(ctx);
+                 }
+                '''
+            "prefixes": ["3/3", ...]
+        """
+        return await self._request(client, f'patches/{patch_id}/')
+
+    async def _get_patch_comments(self, client, patch_id):
+        """Read comments about a patch
+
+        Args:
+            client (aiohttp.ClientSession): Session to use
+            patch_id (str): Patchwork patch ID
+
+        Returns: list of dict: list of comments:
+            id (int): series ID unique across patchwork instance, e.g. 3331924
+            web_url (str): Full URL, e.g.
+                'https://patchwork.ozlabs.org/comment/3331924/'
+            msgid (str): Message ID, e.g.
+                '<d2526c98-8198-4b8b-ab10-20bda0151da1@gmx.de>'
+            list_archive_url: (unknown?)
+            date (str): Date, e.g. '2024-06-20T13:38:03'
+            subject (str): email subject, e.g. 'Re: [PATCH 3/5] buildman:
+                Support building within a Python venv'
+            date (str): Date, e.g. '2017-08-27T08:00:51'
+            submitter (dict): id, url, name, email, e.g.:
+                "id": 61270,
+                "url": "https://patchwork.ozlabs.org/api/people/61270/",
+                "name": "Heinrich Schuchardt",
+                "email": "xypron.glpk@gmx.de"
+            content (str): Content of email, e.g. 'On 20.06.24 15:19,
+                Simon Glass wrote:
+                >...'
+            headers: dict: email headers, see get_cover() for an example
+        """
+        return await self._request(client, f'patches/{patch_id}/comments/')
+
+    async def get_patch_comments(self, patch_id):
+        async with aiohttp.ClientSession() as client:
+            return await self._get_patch_comments(client, patch_id)
+
+    async def _get_patch_status(self, client, patch_id):
+        """Get the patch status
+
+        Args:
+            client (aiohttp.ClientSession): Session to use
+            patch_id (int): Patch ID to look up in patchwork
+
+        Return:
+            PATCH: Patch information
+
+        Requests:
+            1 for patch, 1 for patch comments
+        """
+        data = await self.get_patch(client, patch_id)
+        state = data['state']
+        comment_data = await self._get_patch_comments(client, patch_id)
+
+        return Patch(patch_id, state, data, comment_data)
+
+    async def series_get_state(self, client, link, read_comments):
+        """Sync the series information against patchwork, to find patch status
+
+        Args:
+            client (aiohttp.ClientSession): Session to use
+            link (str): Patchwork series ID
+            read_comments (bool): True to read the comments on the patches
+
+        Return: tuple:
+            list of Patch objects
+        """
+        data = await self.get_series(client, link)
+        patch_list = list(data['patches'])
+
+        count = len(patch_list)
+        patches = []
+        if read_comments:
+            # Returns a list of Patch objects
+            tasks = [self._get_patch_status(client, patch_list[i]['id'])
+                                            for i in range(count)]
+
+            patch_status = await asyncio.gather(*tasks)
+            for patch_data, status in zip(patch_list, patch_status):
+                status.series_data = patch_data
+                patches.append(status)
+        else:
+            for i in range(count):
+                info = patch_list[i]
+                pat = Patch(info['id'], series_data=info)
+                pat.raw_subject = info['name']
+                patches.append(pat)
+        if self._show_progress:
+            terminal.print_clear()
+
+        return patches
-- 
2.43.0

