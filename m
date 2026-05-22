Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F1ACD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB90A84844;
	Fri, 22 May 2026 15:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="gkfCzzHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5819846FA; Fri, 22 May 2026 14:31:58 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B21841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 14:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dea1272943so3540019a34.0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779453115; x=1780057915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VfF+Kp6Q8QzuobrbE9nD1wFazs3wkG52Jm/Qg0XBCs=;
 b=gkfCzzHJ8Gh1OO7uQyPvZWShtP+YLIIpBk65wKg92ureq+Zh8gxiFrQJ4V+hNZvI+P
 9rrEi1N/tfR6jqeuEyNxgkDTpMMywttkfIRGfz3BrWEuzk+uFWa2weiIHz73BPQDlvU5
 L/FMV70suY6FzAt7/McFJTso9rkudBpOH62ZeR5cpSwl0yY6g9IjqZm4Y759MuRnhGpt
 o6utAKmOZja4JcFJwPnwp7fa9SgyOr9L8EMzVjBHXMR6N4LxdTOAQeBigaJcxLFqXR6f
 4RBN9yr7JTcn9tl+xfEmdGXnMgEdUEKKQpPbT9NtGc0G3hXSJTAkqyExvYH+N5d8xCvm
 jnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779453115; x=1780057915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3VfF+Kp6Q8QzuobrbE9nD1wFazs3wkG52Jm/Qg0XBCs=;
 b=MMdBqf8Vponc8ZCWwYyviXHhMKfGAN6zAYpoqS8wKwp92037D0LgNhbg8BgNRZd9bl
 wxh/MpSKtfsRWYR60pGwXdH5WwNfUcWQg9TvFWwqeRQcO+/jvjBqLBuSuRhGfeDhF46+
 eVtATfJWajEJoJFAdT7vbLkhXzM6e36dDgiYcPY9vPlBR5nEuI7+Tf4iM5QmOCA0iAM6
 WfXHTjxULmGHumxIVPivPkofWiXRImwCiZdFNpz78qSHWyMncE2ge6dgGr+losxMupMk
 fnwcHRMHZF4W+C2jmF+V76TM6cfRvFOoa7SSuXqFshOvCJswFnhJhR/aPc6dMkBXilzz
 MfZg==
X-Gm-Message-State: AOJu0Yxi+JTlkCXEIWWhMRYIZ+xQXpmMo+gVu9p4fZc1BofgkgN5Z02+
 s6yi1S5TYAoW/+OtB985MRCcdufuO82baQMnaXeWqTfas+j+cE8ptv83ooftC3RlnGqn0takkeb
 hy2wq
X-Gm-Gg: Acq92OGeLjhqh0L/YyRjohunRJhw1CkY8F2XYxmVh3CsNMlAO01F6pE1RqisRwmQ7dy
 DARHs18eADqPLy+ZHQlkCpRVjn4qN+jYfIYQnLZ2oAMNURpebHZqVKYI93dog2VBDr0qilifpqi
 Dl3hIieiqZ/Gqew4dp4nT0TVEn2+c9pLhfkECmbQelD+/fxQGdg55ovq9yEozxcIPz06KxxJyth
 MiEgNVlyJAxHQ0YWEFZFyJkXyoBwlEHZx1s8BZL9sk8egBwfuEpo+/eoDtKxZqApMTqYZz0EphH
 y4CzzloTAUfp88is6mjE0xuoc6981sJi3vdQ0DQww0sgwXLWxnsP3TO1HKC4t0Y+NOEOa6oz3IL
 vdVJrc5Jt1/B7Z9jxcZ0Dey+v4TmEkRnDpL5pn7D2CTFuvGs1npgVtSu67F1ok8pZhFZrLTtDe9
 ade960QdyhAt9wTJkb3700kkjc5gOuC4zlwUKUbfiVkzdhiQ==
X-Received: by 2002:a05:6830:3c8c:b0:7dc:c620:aa0c with SMTP id
 46e09a7af769-7e5ff0b17abmr2117675a34.25.1779453114944; 
 Fri, 22 May 2026 05:31:54 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm4016553f8f.36.2026.05.22.05.31.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 May 2026 05:31:54 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	vr@binarly.io
Subject: [PATCH] image-fit: Check nesting depth in fdt_check_no_at()
Date: Fri, 22 May 2026 13:30:24 +0100
Message-ID: <20260522123024.6292-5-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522123024.6292-1-anton@binarly.io>
References: <20260522123024.6292-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 15:09:24 +0200
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

From: Binarly Vulnerability Research <vr@binarly.io>

The fdt_check_no_at(), located in boot/image-fit.c, is a helper
that guards against libfdt's unit-address ambiguity; it scans the
FIT tree and rejects any node whose name contains an '@':

	static int fdt_check_no_at(const void *fit, int parent)
	{
		const char *name;
		int node;
		int ret;

		name = fdt_get_name(fit, parent, NULL);
		if (!name || strchr(name, '@'))
			return -EADDRNOTAVAIL;

		fdt_for_each_subnode(node, fit, parent) {
			ret = fdt_check_no_at(fit, node);
			if (ret)
				return ret;
		}

		return 0;
	}

The function is recursive: for every subnode, it calls itself, and
its termination condition is "no more subnodes".

It is called from the fit_check_format() (boot/image-fit.c):

	int fit_check_format(const void *fit, ulong size)
	{
		int ret;

		/* A FIT image must be a valid FDT */
		ret = fdt_check_header(fit);
		if (ret) {
			log_debug("Wrong FIT format: not a flattened device tree (err=%d)\n",
				ret);
			return -ENOEXEC;
		}

		if (CONFIG_IS_ENABLED(FIT_FULL_CHECK)) {
			/*
			* If we are not given the size, make do with calculating it.
			* This is not as secure, so we should consider a flag to
			* control this.
			*/
			if (size == IMAGE_SIZE_INVAL)
				size = fdt_totalsize(fit);
			ret = fdt_check_full(fit, size);
			if (ret)
				ret = -EINVAL;

			/*
			* U-Boot stopped using unit addressed in 2017. Since libfdt
			* can match nodes ignoring any unit address, signature
			* verification can see the wrong node if one is inserted with
			* the same name as a valid node but with a unit address
			* attached. Protect against this by disallowing unit addresses.
			*/
			if (!ret && CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
				ret = fdt_check_no_at(fit, 0);
				...

The only guard executed prior to fdt_check_no_at() that validates
the nesting depth of the FIT tree is in fdt_check_full():

	case FDT_BEGIN_NODE:
		depth++;
		if (depth > INT_MAX)
			return -FDT_ERR_BADSTRUCTURE;

It is only checked that the depth does not exceed INT_MAX, which
means it is theoretically possible to create a FIT image with a
depth of 2147483647 (if the device has enough RAM to support it).
Each call to fdt_check_no_at() consumes 16 bytes of stack space
(one 'const char *' and two int local variables, and a return
address), while introducing a nested entry in the FIT requires 12
bytes (FDT_BEGIN_NODE -- 4 bytes, node name -- at least 4 bytes,
and FDT_END_NODE -- 4 bytes). The stack is therefore guaranteed to
be exhausted on any RAM size available.

Fix: Validate the nesting depth of the FIT tree.

Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
---
 boot/image-fit.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..0e225ecd0c2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -41,6 +41,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
+#include <fdt_region.h>
 #include <upl.h>
 #include <u-boot/crc.h>
 
@@ -1643,20 +1644,24 @@ int fit_image_check_comp(const void *fit, int noffset, uint8_t comp)
  *
  * @fit: FIT to check
  * @parent: Parent node to check
- * Return: 0 if OK, -EADDRNOTAVAIL is a node has a name containing '@'
+ * @depth: Current recursion depth
+ * Return: 0 if OK, or error value
  */
-static int fdt_check_no_at(const void *fit, int parent)
+static int fdt_check_no_at(const void *fit, int parent, int depth)
 {
 	const char *name;
 	int node;
 	int ret;
 
+	if (depth >= FDT_MAX_DEPTH)
+		return -FDT_ERR_BADSTRUCTURE;
+
 	name = fdt_get_name(fit, parent, NULL);
 	if (!name || strchr(name, '@'))
 		return -EADDRNOTAVAIL;
 
 	fdt_for_each_subnode(node, fit, parent) {
-		ret = fdt_check_no_at(fit, node);
+		ret = fdt_check_no_at(fit, node, depth + 1);
 		if (ret)
 			return ret;
 	}
@@ -1696,7 +1701,7 @@ int fit_check_format(const void *fit, ulong size)
 		 * attached. Protect against this by disallowing unit addresses.
 		 */
 		if (!ret && CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
-			ret = fdt_check_no_at(fit, 0);
+			ret = fdt_check_no_at(fit, 0, 0);
 
 			if (ret) {
 				log_debug("FIT check error %d\n", ret);
-- 
2.53.0

