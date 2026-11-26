Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713EB606A32D
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Wc7gheof;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l40YhD1P
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37BE8408D1;
	Thu, 26 Nov 2026 11:19:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TwaeM3X2ieWz; Thu, 26 Nov 2026 11:19:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 640DC408E4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795691951;
	b=K4yHv5NO4Eu9+NNxgg+Lli6Z9pvdp/p9r9ORXOBcy1SPwXynwKixpDueVqnL7z2nuyhU
	 1FNzSdDlYl1PTyMJcJmNxzzgJxqXP8TGTPxbS71k5kro3v4scOUsA0qoX8UzuIwUjB2MJ
	 TANlUCTsu6Zn5T+kNp6deltDDhVzddw3fyp3DHh8uM25lciv3zs+4TvDpze3pwPsGKuBu
	 p9IYGrx2MRmEIuaU3JkbaFk0LFzH8vEoMdf9025NvQWs3NS+q3l+9bIy0GeZ07OUf2U3/
	 OZN0iOAyTFbousst1Ej3tPHdF890tGYOjhE1GdijFeDSCMivbxesKaFm8D22PWNiGpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795691951;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PxtECYSOz0tWK+VqWDvN/0doaoe2TO6gP/keheY8/p4=;
	b=WSPUVzsE+HoleEuG4jQDNIb9YC1e/BZuvkcdymCDxjUsYq2I9/CnBcclceCGCDT98m/P
	 VGKi9WbxqmW1ThLXWG5/Zw3wuW52EA6vSzW1vKHLbvJBYocPpgIbQXPU2Tc/ArCOcRfdT
	 Mzvrf85OSbLIDg3uzMnkSaPohKqW7TruDJUILEabZNVlBGn+vys2Xj76WQbzh6ZFDMTPy
	 b+n0+TOYuec4mppy3mFhilDPJX24kO6uBFHyl20M2uZU+bdGb2TIw0pWKqZxkJU3seMOi
	 KOdspefAgygZu91Enr9hMtLNWp954MTcYEd3e7Img0zARKl30iq4mR5n3EqGfkz8tpQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795691951;
	bh=PxtECYSOz0tWK+VqWDvN/0doaoe2TO6gP/keheY8/p4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Wc7gheofI1lrAuKrNXZ4Zc5GKDRPMNSYlTVCO0DHD4Jh47werQy+CQjpvULwwHOBD
	 pSgaGwKY40N+wOkuJSgZNJVa/1CxxXp4UDa9w0BMG4iuZcafPOwQsSDnx/hfRrs03i
	 65aJVg962wDxTNhvEncAL/l3usKBhwh6eBU49ogTPKdydsjveMIFGx43SrdgxOMMNo
	 rbkBhmUff41IYjALAuH01Gdb1P53g2uCoJKnQb7gWiLz8knOqweKZG/yhGye00gfL0
	 +q/aNEf8yld/IwpyVGvwMpsqc4hV5YBDpyx8rzIR5kw9e0r1b1zVFsJLW3YIh83b7B
	 u+A73ZL0EkgOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 640DC408E4;
	Thu, 26 Nov 2026 11:19:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9A93260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B255B608C0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mDVDTbsmQdpS for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 11:19:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C98B26065F
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=l40YhD1P
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C98B26065F
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 11:19:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2ED7245FC7;
 Thu, 26 Nov 2026 11:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683B41F000C6;
 Thu, 26 Nov 2026 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795691947;
 bh=PxtECYSOz0tWK+VqWDvN/0doaoe2TO6gP/keheY8/p4=;
 h=From:Date:Subject:To:Cc;
 b=l40YhD1PpNmGBFmAi+XK4VC6xh900QJDVX1zR7iNkOr9FhkG+GXpsHVEo3TLjXcwu
 ol2zB3B64VXQnMdFEf9lKBgrlxLbapL/AVJQKhs8oAz0L2DNrBxaxNp5R/Ug9THKB+
 w77aBpB8VY9bfbz73ONm4LsYYqt11WvjrJY5ckyD+QMNgGnVjIBX1ny8LPJpjtQceE
 lBFmk55GBmp+jOEfUT58FIEul+QHgp1J9n8CxN/e8h9VK0GUY0+XoFZ8Ezlvfuz5Hl
 TZSX6qLsiHw8LUTE8JhkaGxYgyF7rktHAGryt5mb+FzlJxG1hRtOUVPt3eC244edjD
 xRyXSwZ2zV5pg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 26 Nov 2026 12:19:01 +0100
Subject: [PATCH] MAINTAINERS: Add lib/image-sparse to FASTBOOT entry
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-libsparse-fastboot-v1-1-fa1f13f5cb95@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMwQoCIRAG4FeR/7xCDmTiq0QHXceaiHVxLIJl3
 z2q43f5Nih3YUU0Gzq/RKUtiMZNBvMtLVe2UhAN6EDeOfL2IVnX1JVtTTpya8OGY6FA+RSqL5g
 M1s5V3r/0fPlbn/nO8/hO2PcP38l4uXYAAAA=
X-Change-ID: 20261126-libsparse-fastboot-85d282b78f6d
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=W9L2zb8LwDm5Nof1W+ZvFInKjIULYfQDftOQnDAMpM4=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBrCBWpuf4me0C7VpHyJQP8VdNuzHlRC4cqBmH6d
 jWtKixEZB6JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCawgVqQAKCRAZDR20Zk4Z
 NW8uB/9F00r5PnFbsgWgGVWjS/mTjs0RdsT1ljNxLTTtNs+PsV6wwNKYvYIpxa+6nbYGsHTXNcz
 U5VrWP2oC/aWmtqvMOfj2jNPSkPMu/11UewwRGfnSBdJad74ZSQEQu+zeFsERK67zkBcARwCWE/
 9E54QzzK+mI3T6Zgt6l/A12iZJj/4MGhw3fwkeP6Ct0d2UHgR3QoBWHGFozQMttGzM7c5XWZdeF
 tXbIpWaayJ5MdACBYqsjn6PAtxj4LewGzPK0/S//+vj+zBmlGkU4ElrK30NcwVQWWD9BD0S46yi
 0Y/t0NqENv5l3t8x8NcToalcJr4lqNACPZdflP1Y7gbnTeJW
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

lib/image-sparse is mostly used by fastboot commands and I'm getting
assigned on patchwork on reviews for this already.

Add image-sparse to FASTBOOT to make sure that I receive patches
for this topic

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
Note: this generates the following checkpatch warning:
checkpatch.pl: :1037: WARNING: A patch subject line should describe the change not the tool that found it

I believe it's an invalid warning, because checkpatch looks
for 'sparse' in the commit title.
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6edf740a9ceb..5e02730e1821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1038,10 +1038,12 @@ F:	cmd/fastboot.c
 F:	doc/android/fastboot*.rst
 F:	include/fastboot.h
 F:	include/fastboot-internal.h
+F:	include/image-sparse.h
 F:	include/net/fastboot_tcp.h
 F:	include/net/fastboot_udp.h
 F:	drivers/fastboot/
 F:	drivers/usb/gadget/f_fastboot.c
+F:	lib/image-sparse.c
 F:	net/fastboot_tcp.c
 F:	net/fastboot_udp.c
 F:	test/dm/fastboot.c

---
base-commit: 9d67454e920b3908529c9fc642a8c911db040896
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git u-boot-dfu
change-id: 20261126-libsparse-fastboot-85d282b78f6d

Best regards,
--  
Mattijs Korpershoek <mkorpershoek@kernel.org>

