Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B227606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sohxbPOo;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0HwiJnM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0686B60A86;
	Fri, 23 Oct 2026 22:18:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nUbZgZWnw69M; Fri, 23 Oct 2026 22:18:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 003946065A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792793933;
	b=Qs+SvB07QPHIenaX44jR8oih8OH/zXfHrOEI18W1AdhlbLKZitFb0y9FX+MUrXloRMp5
	 rqdmYRD8J9/dX3hKe+1GHL0VMJ0csHDDfAI/jSjhAiJGm27b3GxNrq85BBWs2Ya2BGirU
	 jfbCRDk8mnx72d3BzlZC6CiCvTyX8fkYivS2hJKdHR8s1wgH5NmUHQn7pqrUruUai9JHA
	 DsgJOBJe0BiUP6GL1HrB1ku79H1n0K8v0xA9A45mqIVLO+G7OHcCcGm69kNWSgs1MiGYX
	 FvEu2MuRMBy9roWbsSn5CrbSDZSsOO7o6DDWC3LvCWVjw0pbZuOyOANwDcHihD8e9tA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792793933;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=4kRi0bL91YBGoOmf3sMWVcJWC27EraxjLVjP/RKci+E=;
	b=X7V4Pxkj6gfqkWXb0TTSr7J/GvGIZuquzXen6uA6ayajU6Vpsoi8jnTgFBf/GnQGbwvD
	 Jdd9MpLmdgmS25qdPzGWyU2/nnh56zHXyLk7sM/BxaifXktNctwuPlIzfbSxxKKKGAK6z
	 r7K9Imvd4HjCrtN2PiNZAP0l5bhjE0tEZpw2X8l4CZ6V+jP0vkY8jYq1TLoZX88j3JI8d
	 jqQnVrecFKYpvzfOKV6ywu4f4HhiVS6TbszZHxMMp+4DQVvI1ezYIQNxPiD1RK/0SbzxM
	 QD+QEHfbMdAT1lOxauT23Y70q6wDGTCpeP2ty5an7VpRG+gv9rxX/LHdrPkFGCGQB3w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L0HwiJnM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792793933;
	bh=4kRi0bL91YBGoOmf3sMWVcJWC27EraxjLVjP/RKci+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sohxbPOos3WqCy5cNrFC5jDs3pfM6EzUl5n16Wqvqrw7r2vxiektEKGQs9FnlTh95
	 X6VXy+BpgHvxFagxWAfhTiDZXIOlsjafiv0P1D+qZky+DyqO98vTxTmf8hBRzVt5h4
	 OmrD0QyRo8bld8LAScCQF1TzFbxbyy68NYu35ASqpJUFe0OMZ2ZYFFsZaMWr0a4uDo
	 ++RYGI5k6F9WAPvFq3OH8HiG8plEANQhQQ+0w9AUs9OUg0ZdhZ+glNiv8t2SnpusUj
	 tvNa2pdaOYv2ppprr4CSmRzu9gEsOfitYGZgBU0wwYJs7RcIJSnMgjt8yP4T083kYR
	 bHlT5YkfIBqSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 003946065A;
	Fri, 23 Oct 2026 22:18:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA4D93D9
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DBDD560A5C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HhjiXSsW6edX for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 22:18:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D018960A83
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792793927;
 b=aUIuJjS0yA0ysQUiQtxzKHUbz8XVien0cnQ/URBmYqDynfRnwQzlNuNyUVwKc6jQDalo
 1ZQ4xlMhczAY4/aOaR5Lbwj7lY38E/j6NOFKyATbF1niCY61p+MNRjao9YW1/EA3PXOYy
 QBHfDMqFFFnaP6QVaHmkKFXvZqVZFC9UE2ZWyOy9u+Vrp9BF5nLq8oOB/1PCU4hMOeCf4
 FkiZ2uK8CI+p/0lwdw7VZrYhAhSajDwLyxVRUQvXPDZvXmX+DWxVS3n0M6vY51gQSqAQh
 tX8KEd+6yo8sLVx2FvSaSoi1uGaxOD47DpblDgV8cEWLgdBR7jTSr3fk7D/Bgqec3OQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792793927;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=4kRi0bL91YBGoOmf3sMWVcJWC27EraxjLVjP/RKci+E=;
 b=aifUBji7SaddQ/1hVta9Q9e72ezDSK6geX0l29XTnuho2Q3QCubfESQFmNS/5j50TfHm
 FkMV+6Rs0YtZ+lBYbeNdYOjc+Den/pB0HJPeI1LUrAjGmzsKXaPzTWNmEkfMrSWHAPEuz
 5I1Vn3MJQAGL/hKenaIC124TM8sZQuw1jLvtiF9XnMUNPz7GDgsyQbJQaRlJXNW8ieyEI
 DxSxwxOYmPmYoG5ohLkAQLkVSX7JkB2L5ZiI28UUSss2zOOe/23udyucHbW2VojoNI8fz
 Msf1uxaiSd00qIWb10l4T6tBOycRqJVW5LKH/lrMn3LW5NJwDdrh6KpHNb4I/oOUnhA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=L0HwiJnM; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=L0HwiJnM
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D018960A83
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 22:18:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A47916020F;
 Fri, 23 Oct 2026 22:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B8B1F01825;
 Fri, 23 Oct 2026 22:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792793925;
 bh=4kRi0bL91YBGoOmf3sMWVcJWC27EraxjLVjP/RKci+E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=L0HwiJnMpa5UMqPYt8wyPSTRjEZsGcC2zntsCHfWDgGNvniQh+vmZGfhvaEhkLoY0
 vfxBPcZSbqcQlNk6kdaLR99dSdGX2TgSKqyHKW1VccCyF7GqmVnytnclrHaI10gMis
 GjfuC4eaxCfqw2pJuldybIsT6LW4+mfF6KRzecn/cobdETK+292D0dc1ACdVdMIVMo
 E/S7YjBiN1ihowdJ1S290+leaXZGEsyA3QvH8GzXwKvJNfWu8VX/5urNcU9LZ0gfeH
 o5IDuFMjxQLIJnOQ4ThStBN1oKmyaj/LK5zTid9JQqziEqIzsmXNxijzsQIfAunfKT
 hVpJ3E+nCQcSQ==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 24 Oct 2026 00:18:33 +0200
Subject: [PATCH v8 6/8] ARM: dts: ux500: Make panel regulators have unique
 names
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-ux500-external-sdcard-v8-6-badcdf6db2ea@kernel.org>
References: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
In-Reply-To: <20261024-ux500-external-sdcard-v8-0-badcdf6db2ea@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

U-Boot is not happy about regulators with the same name though
Linux can deal with it. Make the names unique, it's more elegant.

Link: https://lore.kernel.org/u-boot/20260817-ux500-external-sdcard-v2-8-ca9a110bd9c6@kernel.org/
Signed-off-by: Linus Walleij <linusw@kernel.org>

[ upstream commit: a2dd0d9654e9e68b901fe63fe60cab8f4b4aa039 ]
---
 dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts b/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
index f736888474e7..d4f364ec8685 100644
--- a/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
+++ b/dts/upstream/src/arm/st/ste-ux500-samsung-golden.dts
@@ -510,7 +510,7 @@
 	panel_reg_1v8: regulator-panel-1v8 {
 		compatible = "regulator-fixed";
 
-		regulator-name = "panel-fixed-supply";
+		regulator-name = "panel-fixed-supply-1v8";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		/* GPIO219 */
@@ -527,7 +527,7 @@
 	panel_reg_3v0: regulator-panel-3v0 {
 		compatible = "regulator-fixed";
 
-		regulator-name = "panel-fixed-supply";
+		regulator-name = "panel-fixed-supply-3v0";
 		regulator-min-microvolt = <3000000>;
 		regulator-max-microvolt = <3000000>;
 		/* GPIO219 */

-- 
2.56.0

