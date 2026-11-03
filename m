Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97922606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YWXZavfb;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=flvVyuys
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6ED476071A;
	Tue,  3 Nov 2026 16:50:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lp_T913Mw-Fh; Tue,  3 Nov 2026 16:50:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 98B1260778
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793724620;
	b=Ws7DXXZHLH34FLHfw1vYl8vbzfD9+abNJvJX6V44GXoB8HwYivw+JwLGEk7aSw5OO8Nv
	 +UUcM/vzmaw5Fua5t2s0B/bi3LPISZaTX0NTKOeuMq6mmAZKkfdxPG+2/ldsbIC70YpK3
	 ibZMcBYET7K759YNhlFPD7etCnSodbCzkeR2TtEUGgfZ2bMh7EfwIYcCI7kWlFk9fmCPH
	 yagzAdfUo2bxmE8gFEHHke1fCKlRSouQtL/SEqoZL59bh412Y64CYnFdh/oHFYXN9H3GD
	 Sx0Fz8i2XN2JmvNa5rTMqMBRhgSSPoyKnG90pGit90QvnA3kWXSGb41fWdTNxTPQq3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793724620;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=nsNcj/GK53qcG3F1GHrCUO2UppTMRHQJ178SXSZa4rY=;
	b=OJv2REUFEyAuLpDV52Nvgm9BiyGCPBGXTs5gFCpAUxoEdOB/nILJ3+e7ZPInqIQqTLJZ
	 Mi1Zem1PXkQAcC5w5SqOO33g1l+0VJdxYr7Wr87nQtHOUEjpwzf7WNSziLFJ58cHEFVPv
	 ok3KFM8zfMVioU0sDhdFF5kULCf1OzTCHWM58v9p2Sz2WboUrIAIobwFdUDjm2LeJgD8h
	 tknVVF6w3rv6aOzbCNXA3oguNgdw5Pvx6zTiN3F/PHN1j1cqYj8yAPV9WAT5svZrVkCEX
	 kUczqu1VRJL4/5ahZSsyXdulsbvTxa1H83psbVtUxedCy4L5xwNV1/jNmCOYizlT7aQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793724620;
	bh=nsNcj/GK53qcG3F1GHrCUO2UppTMRHQJ178SXSZa4rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YWXZavfbcT2YZLB+7Pevxkhdug+MrvQixBRYH+gzgqhJMpxU9rL1VF1V60b5l14eU
	 hEZ11PX3rb9/oWaY5xlQNBP9cIlysJcxW9ZMDy5Fa/wogZXUoqC4lLmJPacpkpp2lk
	 fkgY8eJJuBUXt+oL2LiZdK3iYoAz08oIazStQxvoi5dS81ErJf5w0gQaDXsDxCCh9f
	 r6SA4amInTMhazJCPRVz2Om8BGmWhgWGj9IrYk3oQ0cbKDAMYrwnNs7xrOEJfCIxh4
	 GLoa8Ad1JfWzR+TClJwlRCgXio2eOp0hm2ZYwkKeOsFUxFHasy+3xCLiL1a9c/fwNl
	 nPg9SMdkDiWgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98B1260778;
	Tue,  3 Nov 2026 16:50:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 33C9C4BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2596A40660
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qie_eM-BAVxn for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:50:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 290E740653
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793724617;
 b=emRSVIFsyJqVMIQIspkZ+zjtTEpt7L7n8PEm9vl3a9uvBCxDRUm6mZTOA7jZN5Tl24ob
 A0o1d+NOW1V1B04G5L5k+Qn9Ip7HCam8LAJl9TcvSkVVuwnMG6P83pJPM3x3a+vB3XXIY
 SfITRuEhHWPu+3ttaWkZVCOpRMWN2tZWo4jodOaDmntwaaKLUO9v/wBd2LPDBbJjr5U0H
 TLwsl8ySJGP0nbbJEXRNzt8BVhJXkB0I5YPV+nsjVT1XsyM+2V0fHu6IV5yfuFqSFFfvq
 Wsm9kUEg1cOZ4owrCUBoP+MidB/2tZ/Fwb+phdAYNENSvPq+9dMKoeTnHi7qL5gHRJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793724617;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned:X-Virus-Status;
 bh=nsNcj/GK53qcG3F1GHrCUO2UppTMRHQJ178SXSZa4rY=;
 b=Dn6+YL/ENttZIqhzbZh+0DEiXa+byctF1ysfNjqCxxw+LOiEINiwiopPng6BEN1TE3yB
 9iTBo/Qz5LraCKz93bIzWPCHuiO9k7nmHOVMCKi98KZ+XgnOQ0M0V6el75/CW4vJ4RF6r
 TeRY5v3jKeqABLn9kYq/EeERXiZwKL3Zc4JqzUHqNOGEgsrk7WX7IhXyssv7F4KqqAyJl
 u+c7xzHpr2g6swZRD+3Hm9hOs+QTuuT9w6slHM5FiNtJtJMkZ+h2uNvZN4r3czF4UfGKV
 iZTK4MHcizCbbDaTqWU1MRf+qjbIVHIRp2r5YtdHKP99qeXoXsJ4t3EXcHwGrHpiaOA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=flvVyuys; 
 arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=wpopov@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=flvVyuys
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 290E740653
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:50:17 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D8DE84820; Tue,  3 Nov 2026 17:50:15 +0100 (CET)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49FED8480F
 for <u-boot@lists.denx.de>; Tue,  3 Nov 2026 17:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wpopov@gmail.com
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6774639a8a4so3349832d50.0
 for <u-boot@lists.denx.de>; Tue, 03 Nov 2026 08:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793724607; x=1794329407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nsNcj/GK53qcG3F1GHrCUO2UppTMRHQJ178SXSZa4rY=;
 b=flvVyuys6Y6jwBJnR06Q0CFVH285y2fh0S9G4Dqz70zK/21tUDjzDpYONnfHcHTH/x
 i+CqqPyDC1kIE4E3QqLtlIoD5wnFlzmpdVc39199o2jnCWlBo8R1eKCk3/Emn28TE8xy
 sIwPKAVRkgaFmOt71IC+IV58hN2TYO1Jlt+HhCrJ9mB5RkiFkE4K07x0Q3fgDHrsgILi
 b7KEHWHkBV8SLuAUclhUTzYqohaJuRSht5Ca7uBcx4EbVK4wa8ERjdCisoV3wlfo47mW
 sA8PyhZ7vvfUbMbbPS+0L8O5S7uLOwDsuyo/D+sTKo1sIwf58CZFqXZZutbzxkyrawdW
 3SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724607; x=1794329407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nsNcj/GK53qcG3F1GHrCUO2UppTMRHQJ178SXSZa4rY=;
 b=SCzvuvWvvcVULo/c+Cqcqq70ciHTJ5cr7sTzvsK9ZOHcgWTUj5pYY/VU+GQhprv0Hv
 KPw4GiN837Ia+KYHefQOfrruaiEp61nrW7Fz4q7WW2Pi+SKujiOBGrPKxxbhtNeFSDGS
 z2Fd0CHxxVJaRvGNkiK2X4SgzTrEHAvLCGnJUJdLoFldxgoaE1YNCS69sbApzW0C5LJA
 8uVcniFrSWBiBdfSazWn2memcUqZFyeX39ndw1DnVSJYbTZZ1ti6RyvQDjuzwgw5uSc3
 yja6FWvmmKL8SKyuSB4kEEhh3boIgqIZyEuAmimXhpJgwiNFk8Kq25nDbE3OZbtYpI6g
 WZuw==
X-Gm-Message-State: APuU4Z8lbHER7A9t7nYvgCXXHBDpdPpouv1Oe/EW4CwbmPOV/g35xw20
 3G1ImLr2bQyHH35iTnBgy19rXtkH/0YpF0/gfmlrW9nONhi24+x2bs3azGeYbq/f
X-Gm-Gg: AYBFou3w6jHY3hKDL3XqvB19xIRu1RwyVfVaRTCLs6pBVI4N/rnv3Ap+fb7HQFwNmR4
 rLviF81lhwJuAtuD0Nob6gQZ6C2IhhFlNmiwJCTXC1fpgMUrQKaORW/tH0kSCtjQoqqsVYxl6RR
 Tuv7RmDW3nAClJ4c6N64GiNR9rdpRxfWIKZDv1lweJ1GjJOXPqN4166hOo9mEeYHhz2G4FkizS0
 z7x2ztbplYo878YqfeKcCozrlSx+y0TU98WuRzSUZvGD//9+63t4lbs1OCZjL9u/ZhrcibRnqVi
 eyqVKuhFR/Gkm7AnMyLXPWDVjBUceK6e2r20vS5/oYb0VLzcr9JtxQSIxhbd6zrvtgcbTkSYZ8+
 /lVKvJsA0owjgqukP2sb8Wrfml4gtSIopdGV2VUN8Df7i/vrYKTQYWNDA6perybzSZXiKSemYQE
 oWB05hN6kEKk21JLMVdTpP5LDuFwca1uWCaw7gyVWF+/Bg00AJVXGBJPiKh1Snr8Chude5Tf9aB
 IUVv1FKHXqkD44s9TBFAnRF9zoNmDGjM5EKmJju7aW/5/iOLhOPEE6J6JAk7mL/xIHv94kmWvtZ
 NALfqkqZpFkW7gV7MUMynkdD+4TAburhH/A2QPqc951rX42utuG0aeQRLTs=
X-Received: by 2002:a53:b4d2:0:b0:675:d561:1eca with SMTP id
 956f58d0204a3-67ba4fdbc98mr5592876d50.72.1793724607007; 
 Tue, 03 Nov 2026 08:50:07 -0800 (PST)
Received: from ABELHA2618-VM-UBUNTU.autotrac.corp ([177.174.221.194])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67be800b325sm440329d50.0.2026.11.03.08.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:50:06 -0800 (PST)
From: Wagner Popov dos Santos <wpopov@gmail.com>
To: u-boot@lists.denx.de
Cc: wpopov@gmail.com
Subject: [PATCH 3/7] fs: jffs2: resolve symlink targets safely
Date: Tue,  3 Nov 2026 13:49:49 -0300
Message-ID: <e2e278b9dcf7849e56f079835a59dad3a0f16f94.1793724561.git.wpopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793724561.git.wpopov@gmail.com>
References: <cover.1793724561.git.wpopov@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The symlink resolver stops at the first matching inode fragment even
when fragment sorting is enabled, potentially selecting an older target.

Continue through sorted fragments so the last matching version supplies
the target, while retaining the early exit for unsorted lists. Filter
unrelated fragments by their cached inode number before reading flash,
and advance the list when skipping them.

Reject targets that do not fit in the local buffer before copying them.
Initialize the buffer so that a missing or unreadable target does not
pass uninitialized stack data to pathname lookup.

Signed-off-by: Wagner Popov dos Santos <wpopov@gmail.com>
---
 fs/jffs2/jffs2_1pass.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c
index 6dedecfe741..f32846442d9 100644
--- a/fs/jffs2/jffs2_1pass.c
+++ b/fs/jffs2/jffs2_1pass.c
@@ -1132,7 +1132,7 @@ jffs2_1pass_resolve_inode(struct b_lists * pL, u32 ino)
 	u8 jDirFoundType = 0;
 	u32 jDirFoundIno = 0;
 	u32 jDirFoundPino = 0;
-	char tmp[256];
+	char tmp[256] = { 0 };
 	u32 version = 0;
 	u32 pino;
 	unsigned char *src;
@@ -1174,6 +1174,10 @@ jffs2_1pass_resolve_inode(struct b_lists * pL, u32 ino)
 	/* it's a soft link so we follow it again. */
 	b2 = pL->frag.listHead;
 	while (b2) {
+		if (b2->ino != jDirFoundIno) {
+			b2 = b2->next;
+			continue;
+		}
 		jNode = (struct jffs2_raw_inode *) get_node_mem(b2->offset,
 								pL->readbuf);
 		if (!jNode) {
@@ -1191,10 +1195,20 @@ jffs2_1pass_resolve_inode(struct b_lists * pL, u32 ino)
 			putnstr(src, jNode->dsize);
 			putstr("\r\n");
 #endif
+			if (jNode->dsize >= sizeof(tmp)) {
+				printf("%s: soft link target too long: dsize = %u\n",
+				       __func__, jNode->dsize);
+				put_fl_mem(jNode, pL->readbuf);
+				return 0;
+			}
+
 			strncpy(tmp, (char *)src, jNode->dsize);
 			tmp[jNode->dsize] = '\0';
+#ifndef CONFIG_SYS_JFFS2_SORT_FRAGMENTS
+			/* don't search for a newer soft link target */
 			put_fl_mem(jNode, pL->readbuf);
 			break;
+#endif
 		}
 		b2 = b2->next;
 		put_fl_mem(jNode, pL->readbuf);
-- 
2.43.0

