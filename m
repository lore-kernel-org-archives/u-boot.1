Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3D60A5BD5
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PD0TcP+E;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VCUU1eJb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72B57807FA;
	Tue,  3 Nov 2026 14:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M0aN-OTK8UEn; Tue,  3 Nov 2026 14:03:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 34FDD8111C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793714611;
	b=tRx8ET5O7nH5DrNbGV+s4kcgwiUo+DiVexwLjaiE+dn7ECbFeOdRrgXwyUB4CPu5MwgL
	 GKuYK41x2SuHYg1XPe+y072JaFyh2VcbFGnmYPkES4DD0OZcLr1TME5zUFsOGDDBDKSsD
	 66MQYpxNDEfTez/WN7w/mT208138KVsc/i9mjHB86decMx8GTy+pOhKr43+uVj2XtYpgp
	 Usrg5tAbh8l/OVQvD7S++/q5/uFyM9WLawvRgtCa+xYMJpTuR30mBpPRGPk/zeutGd/Y9
	 xK0rmSyDODCFoCoELOsyfL5A/4SQMJbeckcFRiqxKG1aY/qQLzk1qlDGB/mo2Aumngg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793714611;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cuUOYbIjyuDEFS0ACmVeuqHIGh7cxA0k/Lvdnw9gqkI=;
	b=nQBgHnv7NbBrlrDhMl9cAaWRZn4kTuefR/NwBVshxYIYFyK4gC3wWk+qCqEoRAGsKuGL
	 WEsLRcLAFxBDYV3nO0xgIzYPDoNLCpI+sDb2lGCl7poSNIZaZ3hl3GjSObT+7MvmSZe/S
	 FVoECaYbVu44FPBneT0XDQosRS/ShmCcPmkiG07sDEFlXF8B1LPPViSxOOFetN5UG4KOb
	 WLVHVGWXfHwWGjr7mR0XAOLwSkMz5yj4HIYnFTP0n+/zNbdL3psCTgxS+FzFB9lG0izUi
	 zLyGShpjOxOHmFOF5Y4uvfQdp+Sl1H2z5iVZORNmlKZu3+U2GSQ+Z0SDvk5NawTYhXQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793714611;
	bh=cuUOYbIjyuDEFS0ACmVeuqHIGh7cxA0k/Lvdnw9gqkI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PD0TcP+ESnsYeW6M99YWHz7ZT79XFd3et3PRdyyDAI+6Xm8rzCUV39w22ToqnCL2p
	 +dIe6H0cr4ZZRYrRz0rqvSb6RrvWvzWKOIvr7QPDdvosapqFIWTeg1j0rtDsa62DYz
	 JP2n25G80xo4SZXasQ4DkInssCUnUd9bq2uxVxVY6PqsYsy+QOjUag76dDdEOKxA0S
	 71Q3pvC3tKP/toEo8nQmQAYkJFy5bhQCSBVOpaCxmwexEFLpzbJF2A+SZOqSOIDV3E
	 v/MLXl5ygpf2Kac8WugjuKsgfh9GHqlpiv3NJeJ6JJWJLWijVtAmVa5R+hLQB4FuWl
	 ReVwrIXKImrtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34FDD8111C;
	Tue,  3 Nov 2026 14:03:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F3207D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:03:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0FD1400E0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:03:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XyTPbh58b9GZ for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:03:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CFB6A40068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793714609;
 b=m97YT2OWAAfqTC5tkkTVwEH5J0zuJuhBVi/Ye2nJ5/6yojlHse7+VfDI1yx/o+TMPrwr
 jXAmeeaesiHuQGfwDfFs5RC+OSYGIeoAYc4f+a1nAkOW3fqvnbq996u65D8UnMEhhC63t
 ceUGOttp9Xi14vnHC5x1i8v0NIN5QpxtLlPrR2i6e9n5Qg5kFgWF8w5HF35m6PGZhtRKo
 jmctDeCNcglHf51Iihlhb0tjIz4dGnxLngSH/JZKVqjAXwpWN+TuqFov3Exw9p7A4WlXJ
 9icfmHyivUDBt80TiiT4Yk/txXuZvBX8Y2TbS7umjGnGPleQbPwI44w6Jg4dWtkAF6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793714609;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=cuUOYbIjyuDEFS0ACmVeuqHIGh7cxA0k/Lvdnw9gqkI=;
 b=hrsNFe6X58pf1YKZNjDjgic49PetVw0WaMozfAtEVBC9loG9tV1HKp6RjhwetwKU76Ic
 ZZTBmYQcphOJzAPOCgYW6PJmPguree/Ng6GsvylJP3JVVIn/EuvQ6LlU+X0fJLIaaqD6g
 mC6OEempFBvUsmwLHsRdApgKEckeyN3dwTCCC/bWW5dPqmq795iIFeLi9JZN8HXozUSaO
 76IqYt9WwV39Ptn4VpUQk2ZTvfE7zdOxk5Sv09dYWOBW8U6suK2fLRdu96+XyAeDLmrG2
 N9Wca4I7dw/zPCSPzAniKMthHshSt8y6NTs6S3AG0ZuqBT7jBM/oqWEotOzWz1vvs/A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VCUU1eJb; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VCUU1eJb
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CFB6A40068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:03:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0503841A2C;
 Tue,  3 Nov 2026 14:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B6E1F0093A;
 Tue,  3 Nov 2026 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793714607;
 bh=cuUOYbIjyuDEFS0ACmVeuqHIGh7cxA0k/Lvdnw9gqkI=;
 h=From:To:Cc:Subject:Date;
 b=VCUU1eJbi0oe6msCi2WGu2okqHtw0kEK/KfigMDS4Z40q3Cacga8Hy5KcUxfcChIL
 wXrZ8L3nU7wcwBLud9Rmj3Ihbe8VvHQtN1I+ki/6ElBNGaCt2mtqq2Nno9aVvzvmUu
 gtNlFikJoYnemgbhvYmi5TMeCl+6tZva6qn0Kuiz4SNV92ScfepST8q85xI1TNEXWs
 DxFfVRHSlCvt0raKDHdBX/ML9lOjP7nJ0DjJQTJB5CvCzsg5A6BGvPLzpJKNDcgztV
 58Q8nrxvn0CtjtAkmTmSc9hsrUTfaquiexfOybpxExejUrCHLC/I1gNbgbz5Ppd+sx
 gC+oTMiwSbNzQ==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Tom Rini <trini@konsulko.com>,
	Bradley Morgan <brads@mainlining.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] MAINTAINERS: Update my email address
Date: Tue,  3 Nov 2026 15:03:07 +0100
Message-ID: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some people have reported christophe.leroy@csgroup.eu being stale
from time to time.

Change to use my Linux Kernel address chleroy@kernel.org

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 .mailmap               | 2 ++
 MAINTAINERS            | 2 +-
 board/cssi/MAINTAINERS | 2 +-
 doc/git-mailrc         | 3 ++-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 76ba0a7fea3..6685205a232 100644
--- a/.mailmap
+++ b/.mailmap
@@ -41,6 +41,8 @@ Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
 Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
+Christophe Leroy (CS GROUP) <chleroy@kernel.org> <christophe.leroy@csgroup.eu>
+Christophe Leroy (CS GROUP) <chleroy@kernel.org> <christophe.leroy@c-s.fr>
 Christopher Obbard <christopher.obbard@linaro.org> <chris.obbard@collabora.com>
 Dirk Behme <dirk.behme@googlemail.com>
 Durga Challa <durga.challa@amd.com> <vnsl.durga.challa@xilinx.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 45e9076de67..f0a6de9409e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1594,7 +1594,7 @@ S:	Orphan (Since 2022-10-21)
 F:	arch/powerpc/
 
 POWERPC MPC8XX
-M:	Christophe Leroy <christophe.leroy@csgroup.eu>
+M:	Christophe Leroy (CS GROUP) <chleroy@kernel.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-mpc8xx.git
 F:	arch/powerpc/cpu/mpc8xx/
diff --git a/board/cssi/MAINTAINERS b/board/cssi/MAINTAINERS
index f82dd3b789b..8fbbb94b953 100644
--- a/board/cssi/MAINTAINERS
+++ b/board/cssi/MAINTAINERS
@@ -1,5 +1,5 @@
 BOARDS from CS GROUP France
-M:	Christophe Leroy <christophe.leroy@csgroup.eu>
+M:	Christophe Leroy (CS GROUP) <chleroy@kernel.org>
 S:	Maintained
 F:	board/cssi/
 F:	include/configs/mcr3000.h
diff --git a/doc/git-mailrc b/doc/git-mailrc
index 65626d89eac..eb676b3ed85 100644
--- a/doc/git-mailrc
+++ b/doc/git-mailrc
@@ -20,6 +20,7 @@ alias alisonwang     Alison Wang <alison.wang@nxp.com>
 alias angelo_ts      Angelo Dureghello <angelo@sysam.it>
 alias apritzel       Andre Przywara <andre.przywara@arm.com>
 alias bmeng          Bin Meng <bmeng.cn@gmail.com>
+alias chleroy        Christophe Leroy (CS GROUP) <chleroy@kernel.org>
 alias danielschwierzeck Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
 alias dinh           Dinh Nguyen <dinguyen@kernel.org>
 alias ehristev       Eugen Hristev <eugen.hristev@linaro.org>
@@ -97,7 +98,7 @@ alias nios2          nios
 
 alias powerpc        uboot, afleming, stroese, wd, priyankajain, mariosix
 alias ppc            powerpc
-alias mpc8xx         uboot, wd, Christophe Leroy <christophe.leroy@csgroup.eu>
+alias mpc8xx         uboot, wd, chleroy
 alias mpc83xx        uboot, mariosix
 alias mpc85xx        uboot, afleming, priyankajain
 
-- 
2.54.0

