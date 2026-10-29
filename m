Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE5C606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Px3DYrtJ;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=QKqDnZc6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BABF80F7F;
	Thu, 29 Oct 2026 09:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BU1tmkUDJ8sv; Thu, 29 Oct 2026 09:31:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB8E880F24
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793266262;
	b=bP4M7kq0P0AmFUQYDTkV4uLMmbdJaa28tMjx58db74jAEIhr1cHNJUGNWKALU2c139Y6
	 BXhmYBEcvlUCWdjG6H7fgw3doR7KMjf41gbJDIm8zuoPvxNd5DSGwB5rd254JF/oZ0TNc
	 j31Z2t89tyfzZun6HXMJMOKyesKR73/lGp5CN+AF6/LaXOAkA2dc7RJDaaPuZo8p8SPmQ
	 tfsI37mYAAorivuBaq4Z4iCy7ZYEIfIZAtNIy/crm4jlDN9hfTgIGlfvVxoHCl5Skt1tY
	 UvM9erGmsulUqjfSy8nYZBeX4JbpiLedxArrrjHRJgYagIhRoKWuDyo8XBJ1x5JYBvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793266262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HYSBDmJwqYVgsBzS2kfFtUyKOYUdo/AZGBJo435PppI=;
	b=B8FNApcEe1WLfjbKVez8X5gwRuMCHObw6lm+jlEUrizQQ0/qBY4oKSvgWXF2W6cOTcQr
	 8NkQO2TAM9iEXbkLNJWRvA+QAGXuiNzccR7LG+hx0BmSqxc05AGnHe1i1uephgj+d7h5s
	 R8t3CvMwYmClLThRIoOAoSo7COSPRrYk61PyR8wS822/YGGMwFNHVS8QlFnxhLE9ppHMN
	 Bu8MuxjsAXGKKhH4YIPKvpip9HZ5QU1fqEUDy+iHutLkwfwVIeaw68Hwld3AqEuN0ZJBY
	 9qbiUt/PkjkxFSFvdJgHaHDfpeAUY9IVtNtkRXMFWQxzqB4/lcq3qiKZ0U2CfgSAUPw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793266261;
	bh=HYSBDmJwqYVgsBzS2kfFtUyKOYUdo/AZGBJo435PppI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Px3DYrtJ5FoGggPf7PHnvGZIT8x/l7IuguNE2lomwy2gtwDgaUQXZ6n0N8BLaz2PU
	 8eec1yBs4kvqrNuq9kT6kWzES9nJuJA8/4oK0bnhsi+Y1u98JhPOGD1wfsXTZIAOai
	 VIIqaITxJKO1uPsm0B/sORxqnj/RjkZYh3tFs5XUZi3BJRlFB7mBIkh2U+I4oR3mlF
	 jAJQo0j/tQ8xIR9SL/fJiX9QuBGcEdRTzKt4WDHQwFZLUwK3EoRI3xRoKl4Oc5dW5Q
	 x/aaXgcdRd756ks6Gi/JFR3ZTXrNpMs9O+onUSWIaaQdhCG0cFhk4O/hmwiwlQwmgh
	 0utVnOyvU31ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB8E880F24;
	Thu, 29 Oct 2026 09:31:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EADCC356
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DD0AB4032E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:30:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0k72PBPWCJgN for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 09:30:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5028C40024
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=84.16.66.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793266259;
 b=LEIfl7slJ3KpA+/VMN1JOOD3aBg0A2Uaub/kVS4vNDEHIYzQwrwv/bW6E39EEqAz9Bl3
 fTmgxznpMcLne70jAg6OM88Z8AEgn1XxVyQ1fCh/EQTpx+JnLAbxykrSLFAoQUayvxH6p
 zA8sVpf2/ycCIw3lwLRnc+SgNy5L8m1ZGdRTIm7EPtx3hHAilu3lAo93wlJQqJh79aYhq
 ydNLcJRZJlhJLhVpo2DnNoEiE/6EVBdfJ5fneY85wD92BkFaXpeQuII9aW8ZhM8DlQCAx
 lW+xXRE0J8PEzzSmhuclqVC2guhds4rAVqAKWm3wOwe/KmAj3SsBcna5DkfoA/UsmpQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793266259;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Infomaniak-Routing;
 bh=HYSBDmJwqYVgsBzS2kfFtUyKOYUdo/AZGBJo435PppI=;
 b=JFF2M4qhLQbrZDIlMBhkneys3wqOGChv8TflE5LG45DvQbv7sjGfxzoMZmyCpa0Mby68
 8eryUGMyFtd4SD3fQhTupYVW5qAlnh4h8yK1wrsQIHrK8B5en9XGsLP8U6hhprsxal5bI
 7eMsO0nusqCmGGQdvCYLWhdu1DWVq47GqpE3XDe3+nTwp3BZ65kKSoO2nbRuJKf/oh0Mm
 jmp2gsr2xstm7dU79OtDySuJotvl1F+JqU++vr1W8KW1Rpd2giI3JMiR6DS/3uh8YXHzy
 map74vLtYi2m+/uzGf82O1N9V6Fz9ncj32pSCZH48ANxOtzID7jqzuaNcSTAYP3Vwaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=QKqDnZc6; 
 arc=none smtp.remote-ip=84.16.66.172
X-Greylist: delayed 337 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 29 Oct 2026 09:30:58 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=QKqDnZc6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.172;
 helo=smtp-42ac.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [84.16.66.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5028C40024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:30:57 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jFf9W4kCsz2fk9;
 Thu, 29 Oct 2026 10:30:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793266255;
 bh=HYSBDmJwqYVgsBzS2kfFtUyKOYUdo/AZGBJo435PppI=;
 h=From:Date:Subject:To:Cc:From;
 b=QKqDnZc611QCq5I3/cF9GYSFF5a3E+bcTi0O2TBklW2zpz4PvRC7KuSOEkvOXRavv
 WIZzYACkNcjsTU2i15wbB7Z1GYOXTqwEinMsI8xKzOJgox+xAWhSpY8JSeLAoWEC2K
 TMr7EG5XoE/SZC27oQa0FKhw3+yuuFwzaZd0/HSHtYWAD4ikUjowCpen5TZgY2pSNZ
 Lm363AYrjZeFQ2OGcig61KjHqr1qVu8WodD0WC8vLgbstGCJSvRVX1+eZJWboogkJ1
 9c9/VqVqldvTOjSejeoRBUUn2nAWOgFysMUCN1PEjXCESNV816vAtNZyRSMzmLm5ze
 xHqEq470mAg1A==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jFf9V4952zxgV; Thu, 29 Oct 2026 10:30:54 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 29 Oct 2026 10:30:45 +0100
Subject: [PATCH] doc: imx: mxs: remove link to Denx's mirror for elftosb
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-denx-de-elftosb-v1-1-4e07964ae377@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqDMBCE4VeRPRuIS622ryIeahx1RaJktQjiu
 zfay8B3mP8gRRAovZODAr6iMvuILE3IDR/fw0gbTWz5mVl+mRZ+j2MwdeusjXlYlzMXllE6iq8
 loJP9Llb137o1I9x6Zeg8fz+smTNzAAAA
X-Change-ID: 20261029-denx-de-elftosb-40c522702e8c
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

Commit 904c31fe9f08 ("imx: mxs: Fix location for the elftosb tool")
update the wget command but forgot to remove the FTP link right before
that paragraph, fix this oversight.

Fixes: 904c31fe9f08 ("imx: mxs: Fix location for the elftosb tool")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/imx/common/mxs.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/doc/imx/common/mxs.txt b/doc/imx/common/mxs.txt
index 372062c0eaf4..a177d75affe5 100644
--- a/doc/imx/common/mxs.txt
+++ b/doc/imx/common/mxs.txt
@@ -48,10 +48,6 @@ NOTE: The "elftosb" tool distributed by Freescale Semiconductor is no
       otherwise continue to section 2). The installation procedure of
       the "elftosb" is outlined below:
 
-Firstly, obtain the elftosb archive from the following location:
-
-	ftp://ftp.denx.de/pub/tools/elftosb-10.12.01.tar.gz
-
 We use a $VER variable here to denote the current version. At the time of
 writing of this document, that is "10.12.01". To obtain the file from command
 line, use:

---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
change-id: 20261029-denx-de-elftosb-40c522702e8c

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

