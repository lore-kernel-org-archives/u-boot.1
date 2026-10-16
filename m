Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9BCCC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 875AA61073;
	Fri, 16 Oct 2026 13:24:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P9HQ3inCnrHP; Fri, 16 Oct 2026 13:24:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4173861084
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157042;
	b=VHJebCJAYaSRpLasrzdxBOV/CCjdTM3hMY7SvnaOPqZbkUYKywxBWTBHkqPFNDbnbY9z
	 tXprVnKtRAMoR6Rnyj/nEOA2sWRFX1bIr4Dfa94HU0pWFw05+KkAjUHswFMi33+nCWcX9
	 K+hiswrOD3w6bYIMHEXfI0K/pGyQ86H85dMA/5XnJwJx5QJaAQG192FeICHyF+2qS10cO
	 ZzKNQ7niOw5O7sHJHpMEu5mTHyLRdVvD/c/Oo9qFSRGKUsQNu7hBRCCRi9heiAKlyamdp
	 7HN/qEfBIGwKZ0J8fntj8yAGcI3f+F7GG64+u9xrLYY7xM0Ar2X57T/r5/D+D4t0dIQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9u83vPyAJGoeXGMR1yehMkS4L88L2E59vF3MfL+NYRs=;
	b=Xqyq6yRiJM1XNF2Y0mqGSAmBUsgPG1gKqPkbFpUfLtQuD0OeB3y2I8d15GbPVpAQ86sn
	 WE1rt9oJJjHppH8tdvnZe0uQ0dSa/p2P+YBXawNpc+GBzUeBQBIiM0x6Tj1q7/G+VJFK6
	 DhHnCe1x4M8RQA4MrVhMQOS0lzeHElUA+KzEQtqXUI9cFtjukHDe/JP/xrZuDLQEdLWd/
	 +XdYYkFJtlFgKF/kv20QKCe6zXEB+AbMXqj9j4r5sbCFFHHrNr078kgnVH+yylT7e6FLE
	 w9Ga/bbf/fZ7q59po+gc0pCx7cN8uUg4owxPzpxl8MPj6ymvj4kKkkE0qs/vZJ32y3A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157042;
	bh=9u83vPyAJGoeXGMR1yehMkS4L88L2E59vF3MfL+NYRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N6nK+8H7faxkWnsW9BX7emJGBjUbncIYDD9SV2zpTXMy0Rbfu7d1Qd98iZQI1jnWl
	 Cvw+7k7jugeqzqwe22SggeT497HhwHOzPWH7TH7KysmRefNnUTjF+LZBbmabEhlcgv
	 pTi9UbT7rQMIXGPF6DTx9huTSrbxafvGcPuEKMuupiioqZ6UzSWjxhaCVEVQRsuFT0
	 vWs5bTlTb+Km0zaGn3vQ2H5F3m3qDHDL5ArEfMXqDQOzxqF95i7QQFB/EEC1sX0PYE
	 VffBmvQn1R6+heHdlLvouPK6JB4ux4TKCgBB4oG1iIFRcrQ8ADOb4cSwmL3kPOtsa5
	 j8RrT0sGZ6JCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4173861084;
	Fri, 16 Oct 2026 13:24:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B8D11DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D75B813F2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VIrdO6S0JGpd for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:17:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F3725812C9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792138679;
 b=NnN1cgUamIfiqi96cLvttfpHRnM56yEosOXu/XpnttfHin9y6UHjKLLCKJ4c7hcuWKRO
 iEhG/W6MHA9fYe0pPe4cUyYq99VxkI9wH84eKAsVLUuLjHI6YVaPeAk8MeebQSNYuxfvd
 +CK9gxLfw1EPtl9cC/BEvNNkVbX7cqTEyWoG95cWXsvQvXCP+REBY+InNpirNm32uxfdz
 DaF8RFRKslAtTVMFUZQHj1hxjY8dbS+HDu7Log15gLtf3ZIgm1oqtUvN6WNtXAg065IxV
 36AvjDYokUca7VMPoU7xyrZH6RTUa1yWnrpk2hSRsmiV2dmys1QuFDkwnfyL2EUClcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792138679;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=9u83vPyAJGoeXGMR1yehMkS4L88L2E59vF3MfL+NYRs=;
 b=nf+0gMoX4fDx+AMTYghRze8buFEWjWoZ30mxZDHP7Ne8zELNYnnqpXHY03gjd49mi7wy
 a6adVMS6K5ujB383WF1aE1n4sawNMM4QgHKPHf9qzoVizwRuc5c+q3jILkizbdwR8Kwf4
 8tBBmJ92Qm3JEUePP23LqKrXQjQyJf1rL5+RJ3QON2S3q6Kjf5vOU9FJT9j6/H+V4sDxT
 619N/nDaNKocnzo7aElANDHU9cfKHnAxRuLoQTwHGxKJnlIXUjtnep3aFhw65QLa8HKr0
 C31YA7bMcViSldZ5ZUUhMzyQp5nw9vBRl9oyXjqz+w/gUPPtoCjMbn4g/61XT4+W/Pg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=RKi1nQS4; 
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=RKi1nQS4
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3725812C9
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:17:58 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D936840315
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792138675;
 bh=9u83vPyAJGoeXGMR1yehMkS4L88L2E59vF3MfL+NYRs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=RKi1nQS42AqtWkkxlwwMt35WehGTdV7es5MkxuhvjaASg61k+vfTET5Pvtp6EuWw+
 1CB2Fb7uyPje4P0Ia8asepdA5qAfhxaJs/iS5+tzlhf3WU/w5m2E5VMkCFfcRPzve9
 RJtC8tWFoV1g67o4oObC7NykEam0YKLyyzUjAaxpSATX5Rm7qdYwq/X3lwpmRTkD9f
 bjmdfNfG8+14Xrlh6p3SPE70XCcylSoxSLm3lmbrzfkQ4oh75wX8/3mbY5D74I66Y7
 2tZB1cEvgGw5owsefulmZgUhMhZjr1HeapNHlgEnSRtyrjKz6R1rffURHbvdQHTX2l
 sDLp5xU07pikhMT1Q2TgaWw/J0seWcQfqm/BkqQQRQprFNTMDDsPuHWP6HVE/JXvbE
 8rlhHU5kx6/6dGz/Om62gwB9nVIpNBxFQUrtuHrkSFpeLiXLudC75Lnxmau63AWN/z
 xwewffIVjfjYkGH53Sguy+c/IC8gGbtyxfwsoqmOnRVkNu6+ws15CwOZdmN430X4zO
 a0tsM3k9B5Re17SiZVbsjo4NvxXSOEVaJWpO6Fo8b8AjUmwIthSdQMtARZCf5E/FNo
 kdvdCO7z/TqJDkHPbxiVMmPwUs2jnSldLCH2X0JciHvp2/ENbfcioRzjYQBmNKUxNb
 C6WuVoLk9RhABgMZf4xASEfw=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39deda201bcso10737954a91.2
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 01:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792138674; x=1792743474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9u83vPyAJGoeXGMR1yehMkS4L88L2E59vF3MfL+NYRs=;
 b=sAbujYt1iEZ+rfyzmpD9luuyJisRBrS7O2G7sN0i8js7LK8vzo8QEJgGq+32gus2sJ
 2wkg6RuWAD5fj0quH0fZIDJJpaPoN+n6JtMjwcaH4d4K8DH6cuEfxDer7EwTuO5vhLe1
 PevbXbX0XkexL8nIXUUIpx6K5pJCtbXGb4anQ5aIfmJ4npRjHmvZxiW9TNdAnOihd6Xz
 3ZLgoP1Ikl+NJ/bZgP6FnF3KVdz6/xCuGpBlZ7fV+sh/whys8CfIboEDWeAS2POLn/Dh
 CmNFtGP0cxWzDwSIojhVH3Iom97UecI37jRmdY/e9QmmXKfj6qtC20eZky4Vh8rSqC5Q
 x1ng==
X-Gm-Message-State: AFq9FYJx7jFfTNZIjgUEt6TVLxsFTWAG+TglRk0qmiXwaDauU9efqtRr
 I+d33tlWfwI1YWWDmYivPWxDVw8WWNnLEOEDGH0lIcTpsac+DGVu1zwmRvofrcgmwaFJnAwZPzT
 zFuwZM2fmm7b3T1aKNYtBtA0MrH6BQQcN2DfHlAyTdcv6si9KDkbFv49dQgbevcI5qDd8MkrPBy
 3M6GgkWbFr06hXq7IjZQ==
X-Gm-Gg: AYBFou2rCxDPp9fU8LPz+8Em6isaCsdMynd+7WOrz/m+U9h8SS3YDdOV4vIu6pyfhoq
 B+nYVjh/xdruy2JmaJ0Ci8g8WfohKZaf5XNyAAPdlwEbDLwTQO9GYODriA76IzzA+eLhMxyq/7X
 BehwJUZAdN0LW09QNoBKcorfA83XDeWXNnVJQ4nlhF5dy1uAPKGLH4V5MvqJ00g/rRwUjHCqPIw
 lMGCxHccUDXRm7gJEbTAnzsrBIpIXeWtSiXDRTiNLREueqkSkcXSZMqDVWROdnPRk+V9kzZguwL
 KWsf9L8wf8cmJhmg6kpSklICid0jeVKeA0RVDUXig3lEnqjxbXI/zIBDmbJVvOwalh3PoHoUfxm
 yOJPeGHwLXsvCHrswvfgAE3MLBxwlyGwZSqWq3q104tpIckB11TcZKN4sC0t0XMX+vg==
X-Received: by 2002:a17:90b:2d07:b0:3ac:b145:8f4 with SMTP id
 98e67ed59e1d1-3acb1450acamr3454953a91.41.1792138674119; 
 Fri, 16 Oct 2026 01:17:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2d07:b0:3ac:b145:8f4 with SMTP id
 98e67ed59e1d1-3acb1450acamr3454936a91.41.1792138673733; 
 Fri, 16 Oct 2026 01:17:53 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9474b52fsm9149405a91.9.2026.10.16.01.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 01:17:52 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, anton@binarly.io,
 pranavkasthuri@gmail.com, Aristo Chen <aristo.chen@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Igor Grinberg <grinberg@compulab.co.il>,
 "tomas.melin@vaisala.com" <tomas.melin@vaisala.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH v2 2/5] image-fit: check the length of the external data
 properties
Date: Fri, 16 Oct 2026 08:16:24 +0000
Message-ID: <20261016081719.814357-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016081719.814357-1-aristo.chen@canonical.com>
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261016081719.814357-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
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

fit_image_get_data_offset(), fit_image_get_data_position() and
fit_image_get_data_size() pass NULL as fdt_getprop()'s length argument,
so they accept a property of any size and then dereference the first
four bytes of it. A property shorter than that is read past its end, and
the bytes that follow it in the FIT are returned to the caller. An empty
data-size, for example, is read as the structure tag that follows it, a
small number such as 2 or 3, and selects a few bytes of the external
data instead of failing.

Ask for the length and require it to be exactly one fdt32_t, as
commit c2b8eefd4e10 ("image-fit: check the length of the
data-size-unciphered property") does for data-size-unciphered. Every
caller already checks the return value and handles a failure like a
missing property.

Fixes: db1b79b886f0 ("splash: add support for loading splash from a FIT image")
Fixes: a1be94b65410 ("SPL: Add FIT data-position property support")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2: no code changes, collected Reviewed-by

 boot/image-fit.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 6ab6c6c7da9..fd625fe9a98 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -963,15 +963,20 @@ int fit_image_get_emb_data(const void *fit, int noffset, const void **data,
  * returns:
  *     0, on success
  *     -ENOENT if the property could not be found
+ *     -EINVAL if the property is not exactly one fdt32_t long
  */
 int fit_image_get_data_offset(const void *fit, int noffset, u32 *data_offset)
 {
 	const fdt32_t *val;
+	int len;
 
-	val = fdt_getprop(fit, noffset, FIT_DATA_OFFSET_PROP, NULL);
+	val = fdt_getprop(fit, noffset, FIT_DATA_OFFSET_PROP, &len);
 	if (!val)
 		return -ENOENT;
 
+	if (len != sizeof(*val))
+		return -EINVAL;
+
 	*data_offset = fdt32_to_cpu(*val);
 
 	return 0;
@@ -987,16 +992,21 @@ int fit_image_get_data_offset(const void *fit, int noffset, u32 *data_offset)
  * returns:
  *     0, on success
  *     -ENOENT if the property could not be found
+ *     -EINVAL if the property is not exactly one fdt32_t long
  */
 int fit_image_get_data_position(const void *fit, int noffset,
 				u32 *data_position)
 {
 	const fdt32_t *val;
+	int len;
 
-	val = fdt_getprop(fit, noffset, FIT_DATA_POSITION_PROP, NULL);
+	val = fdt_getprop(fit, noffset, FIT_DATA_POSITION_PROP, &len);
 	if (!val)
 		return -ENOENT;
 
+	if (len != sizeof(*val))
+		return -EINVAL;
+
 	*data_position = fdt32_to_cpu(*val);
 
 	return 0;
@@ -1012,15 +1022,20 @@ int fit_image_get_data_position(const void *fit, int noffset,
  * returns:
  *     0, on success
  *     -ENOENT if the property could not be found
+ *     -EINVAL if the property is not exactly one fdt32_t long
  */
 int fit_image_get_data_size(const void *fit, int noffset, u32 *data_size)
 {
 	const fdt32_t *val;
+	int len;
 
-	val = fdt_getprop(fit, noffset, FIT_DATA_SIZE_PROP, NULL);
+	val = fdt_getprop(fit, noffset, FIT_DATA_SIZE_PROP, &len);
 	if (!val)
 		return -ENOENT;
 
+	if (len != sizeof(*val))
+		return -EINVAL;
+
 	*data_size = fdt32_to_cpu(*val);
 
 	return 0;
-- 
2.43.0

