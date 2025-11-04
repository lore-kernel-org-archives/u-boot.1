Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBC7CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 19:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26545838A5;
	Tue,  4 Nov 2025 20:26:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bryanhinton.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bryanhinton.com header.i=@bryanhinton.com header.b="R0Xgc+mL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15B258004F; Tue,  4 Nov 2025 20:23:49 +0100 (CET)
Received: from outbound.mr.icloud.com
 (p-west2-cluster2-host11-snip4-1.eps.apple.com [57.103.68.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DEA8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 20:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bryanhinton.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bryan@bryanhinton.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-4 (Postfix) with ESMTPS id
 7249118000AF; Tue,  4 Nov 2025 19:23:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bryanhinton.com; s=sig1;
 bh=WGEQPx5HMSX18qdqwHWiZJBs87O+a0Jwl/qLCagVcZQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=R0Xgc+mLSVskcm8OFYzzSwGgRoM5g/sXOFH3TGK8ltX2ICP2UYgkbDGTr8VH+hpUbQqSrXA73+pdFR2Asj3d0iF4ii7SqFxNtNG2Sb1c92AzjUXSpDIPXGza1yU59DUEbBKPCdU8mJVIkuq6qeeourS6vniw0xQ6bSNwIcnlEF5BwSiz+kzIJrcgmCQzYn95boivw5FYJBvtzExKycVA2PmZENEw6wx6jJd/xIsVV+nqw9EAE8gigX3w+IkGlIeo4t4Cy2YKisdne1W213ORmGJn+DS7IMgoTslaLpeOO8cOM2GTg/8DS5NG9/p/rYYHVm1Y/P+266bsDfOfPlRbdw==
mail-alias-created-date: 1643268037438
Received: from localhost (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-4 (Postfix) with ESMTPSA id
 A163F18001C0; Tue,  4 Nov 2025 19:23:42 +0000 (UTC)
From: Bryan Hinton <bryan@bryanhinton.com>
To: u-boot@lists.denx.de
Cc: bryan@bryanhinton.com,
	trini@konsulko.com
Subject: [PATCH v2 2/2] MAINTAINERS: Add entry for Radxa ROCK 5B+
Date: Tue,  4 Nov 2025 13:21:53 -0600
Message-ID: <20251104192354.2232191-3-bryan@bryanhinton.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104192354.2232191-1-bryan@bryanhinton.com>
References: <20251104192354.2232191-1-bryan@bryanhinton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0Ii0Ne4MPdQJOeXA7zyR2N98wkmFY38m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDE2MyBTYWx0ZWRfX8c6Q8bzIOAR1
 6Te+2IkopVcf37ulKuZWREH/jQ1b7DA2fmYxsINVUYw0EXk2q3tX+GrwzLg9S1y2SFkiWtUNqXG
 5UqDJ3kSfUuf3iFrr9pXU4e4hLx90BUoOlYDekIItsnFAKoW4tcp09RHFLXUfnTHEX0I0TK7N5g
 KsB/wC2pqY1pC8PIO76MSqJDyBsfJ6WbuoAtcfWcI8Vv2u/YRGqKtWUIIJ+NkB4Tha59RxepAH+
 d7WSCVXP0BySZreOed7wxw+OSPoCLhGZB62dXOJBN1d/hisQI0ah36TvESSW6R8oYCX2IssGg=
X-Proofpoint-ORIG-GUID: 0Ii0Ne4MPdQJOeXA7zyR2N98wkmFY38m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0 clxscore=1030 mlxlogscore=487 suspectscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2511040163
X-JNJ: AAAAAAABWOEWADBebGFIcKpS8PDKhRO8yYhvwNa09YtQv8FysJSYf5XepgaDI4o/yP0s+gl508yER9C9BB62C7G0pYiL7De4OEb59otcsG0Ft4NwbtMkHlEMP3yvyOw2MuGyE3oLeC7sQST/TgVm0iZJmt2+fdMVnROG5a/1wMgCHKp7TUOjpVie6HD3xbHZIc8iKL6xzX2bvqY+RM0UUtP/PK8eaE4imAY2SSC0CwteCpkFCDNIt0wLpjjAclZ131efP8F30NVptMPOH2moDplN5NEfa08cvET3IXxEB+9rAZ0TlWuHcvc+5NS+BLkIJwn2egXgLhUtg8BTMALaqiI48vhZlr72JCN2+nHF4hE5if/mBP7zPzpB94YK8MkSO2R/FyrL/smxNO16462hI4X4yTd/ay9oNiL8Hq/6jVNLOK9eZ9aC9PFvvDT3iOKvhvN0c1rJZzh7OsqnSeP4seOYrDfzbVd2iT9ji1oy/oZj2gAwcXe4qr3+KfdZRwXHFAF7nAo4oM+eUf5Pe8CU9aKKkE7lmhyV69ow5iHCQAzisFvq67B7zRBz8rgRHRWo+qaMDb1izvdiN7PrgwN+zlrZBr1u7dzH300nIFIyNWTusP5ygEVGIT9LbePW6r8KwNL9WCI4ZXrALPGfrjYUa0q6UjQ=
X-Mailman-Approved-At: Tue, 04 Nov 2025 20:26:02 +0100
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

Signed-off-by: Bryan Hinton <bryan@bryanhinton.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c7d0e0ab2f..bae65d7c651 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1974,3 +1974,8 @@ T:	git https://source.denx.de/u-boot/u-boot.git
 F:	configs/tools-only_defconfig
 F:	*
 F:	*/
+
+RADXA ROCK 5B+
+M:    Bryan Hinton <bryan@bryanhinton.com>
+S:    Maintained
+F:    configs/rock5b_plus-rk3588_defconfig
-- 
2.51.2

