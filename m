Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7343DC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 13:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF89382A8B;
	Mon, 26 May 2025 15:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BSF5C7Ti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408F582CF8; Mon, 26 May 2025 15:35:26 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD1C81FFC
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 15:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2341e1fddb8so18154545ad.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748266522; x=1748871322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a4RWG/8K3cQcrPIzqSDaHtu/4v7FygI+i6QVE9dVpK8=;
 b=BSF5C7TiiUQy6JwOrsDSLSlOnJWtCJzHoMTVq807obeuHqpJ3tAzspvxPBb/masZ9T
 X5jWw4HAg7+y2yP4kDt/3rf6+URx2dnkjuJeAtWEM4QWS2pUhypuUUCmbBOQA/9ws8Xu
 iKUqPwX2xeI91PM+tMBAyzcrM4qL6cy/wMQV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748266522; x=1748871322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a4RWG/8K3cQcrPIzqSDaHtu/4v7FygI+i6QVE9dVpK8=;
 b=GA3zvGuGGWY9RXZwVGIR1KuOym4WB5mvqv75JqVk4teWNW0JVOvS6c2LfQWyzZGkmo
 j77SgzqjV7joVIqL1PtU6i/IhQ8AxWdWTyNpg3IhQIlaNo2K3YTU8ckUMYG/3BPR7d9V
 iMFgUK14Xx1nPFsIDUn2rVL12Ydlzf5MM9ECz8Q8Fm+q6mu13SXLs7DMIdq2tmcOJhFw
 UumuMGw/eLYPaEkjXmanzrlaR2Gxw0Wl7dFNx2CpMDqyYKVwJN7ggkhYxOd47Oa9reJ+
 TgKgxlHD1wKVGB5rL7rrR/ERpUd3ge03I7on6KgVKasyv/PE316nrT5mirk48HpHeoiz
 WChg==
X-Gm-Message-State: AOJu0YwttCTWnwKyDKxK0VYriUkDAzdqU3leDHAdLW6HsvxYnDXcfriZ
 W09icoBbsNTEE8B3lyEjTTEYg+ZiUV+/TdMxxYcIBjPJUkXWsfGVjm4I7N36jyyuWLr5f065cd2
 5lwl3lYE=
X-Gm-Gg: ASbGncuLukO3ILe0DFQRS1cdAPHfvP6bFLPfGLbvO4HFAJGXV8QMQZ4cfEO6k9x8AIP
 CWUzxL3JvNSvlx2enlPqKhQL8ys8kczJHW+AmtZckpgFB6opKRetqRicycC6Ee1Ur2o+fnAFCju
 BBwZ2xrZExVX4DbKZcu4Evq4S+Wj3wb6Mk9CCyTykkUGIZ6H3bE1bKVeFXv9usConxILg1wfMQ5
 utgdt3hVKOd9SNlvkx13LSmVsdNzVWBjL/l7Qo0GZHHJhQnUXAkEhjiQtJLErmNxTmCkXrsLjgI
 SGyVyf8jDlovKeFzCEomC0r4m6t4ISTo0/NmNhp09YEU6Wxi8DNNdqMvgBObxMZiphStvNnlxoF
 qYsMd0kFU12r7qxcH6DJy0LD3pQ==
X-Google-Smtp-Source: AGHT+IHl7XpylrH4wJthl6Z0A8KzXkXng4A6bJV9y00nG5kInEoAsGhuqbmcQ87ZBVcWVO4b4Ip5XA==
X-Received: by 2002:a05:6830:2aa7:b0:72b:8ec6:e533 with SMTP id
 46e09a7af769-7355d06b02amr5539515a34.7.1748266512288; 
 Mon, 26 May 2025 06:35:12 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734fa986d42sm3881596a34.12.2025.05.26.06.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 06:35:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] scripts/setlocalversion: sync with linux v6.15
Date: Mon, 26 May 2025 07:35:10 -0600
Message-ID: <20250526133510.2689220-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The changes upstream since the last sync at commit 5c02350fa03d
("scripts/setlocalversion: sync with linux v6.9") are

e2ff1219a554 setlocalversion: add -e option
523f3dbc187a setlocalversion: work around "git describe" performance

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 scripts/setlocalversion | 58 +++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index dbe048210d6c..9ed3f56bebf9 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -10,6 +10,8 @@
 #
 #
 
+set -e
+
 usage() {
 	echo "Usage: $0 [--no-local] [srctree]" >&2
 	exit 1
@@ -30,6 +32,29 @@ if test $# -gt 0 -o ! -d "$srctree"; then
 	usage
 fi
 
+try_tag() {
+	tag="$1"
+
+	# Is $tag an annotated tag?
+	if [ "$(git cat-file -t "$tag" 2> /dev/null)" != tag ]; then
+		 return
+	fi
+
+	# Is it an ancestor of HEAD, and if so, how many commits are in $tag..HEAD?
+	# shellcheck disable=SC2046 # word splitting is the point here
+	set -- $(git rev-list --count --left-right "$tag"...HEAD 2> /dev/null)
+
+	# $1 is 0 if and only if $tag is an ancestor of HEAD. Use
+	# string comparison, because $1 is empty if the 'git rev-list'
+	# command somehow failed.
+	if [ "$1" != 0 ]; then
+		return
+	fi
+
+	# $2 is the number of commits in the range $tag..HEAD, possibly 0.
+	count="$2"
+}
+
 scm_version()
 {
 	local short=false
@@ -61,33 +86,33 @@ scm_version()
 	# stable kernel:    6.1.7      ->  v6.1.7
 	version_tag=v$(echo "${KERNELVERSION}" | sed -E 's/^([0-9]+\.[0-9]+)\.0(.*)$/\1\2/')
 
+	# try_tag initializes count if the tag is usable.
+	count=
+
 	# If a localversion* file exists, and the corresponding
 	# annotated tag exists and is an ancestor of HEAD, use
 	# it. This is the case in linux-next.
-	tag=${file_localversion#-}
-	desc=
-	if [ -n "${tag}" ]; then
-		desc=$(git describe --match=$tag 2>/dev/null)
+	if [ -n "${file_localversion#-}" ] ; then
+		try_tag "${file_localversion#-}"
 	fi
 
 	# Otherwise, if a localversion* file exists, and the tag
 	# obtained by appending it to the tag derived from
 	# KERNELVERSION exists and is an ancestor of HEAD, use
 	# it. This is e.g. the case in linux-rt.
-	if [ -z "${desc}" ] && [ -n "${file_localversion}" ]; then
-		tag="${version_tag}${file_localversion}"
-		desc=$(git describe --match=$tag 2>/dev/null)
+	if [ -z "${count}" ] && [ -n "${file_localversion}" ]; then
+		try_tag "${version_tag}${file_localversion}"
 	fi
 
 	# Otherwise, default to the annotated tag derived from KERNELVERSION.
-	if [ -z "${desc}" ]; then
-		tag="${version_tag}"
-		desc=$(git describe --match=$tag 2>/dev/null)
+	if [ -z "${count}" ]; then
+		try_tag "${version_tag}"
 	fi
 
-	# If we are at the tagged commit, we ignore it because the version is
-	# well-defined.
-	if [ "${tag}" != "${desc}" ]; then
+	# If we are at the tagged commit, we ignore it because the
+	# version is well-defined. If none of the attempted tags exist
+	# or were usable, $count is still empty.
+	if [ -z "${count}" ] || [ "${count}" -gt 0 ]; then
 
 		# If only the short version is requested, don't bother
 		# running further git commands
@@ -95,14 +120,15 @@ scm_version()
 			echo "+"
 			return
 		fi
+
 		# If we are past the tagged commit, we pretty print it.
 		# (like 6.1.0-14595-g292a089d78d3)
-		if [ -n "${desc}" ]; then
-			echo "${desc}" | awk -F- '{printf("-%05d", $(NF-1))}'
+		if [ -n "${count}" ]; then
+			printf "%s%05d" "-" "${count}"
 		fi
 
 		# Add -g and exactly 12 hex chars.
-		printf '%s%s' -g "$(echo $head | cut -c1-12)"
+		printf '%s%.12s' -g "$head"
 	fi
 
 	if ${no_dirty}; then
-- 
2.43.0

