Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF58BE7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 23:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3ED89591;
	Fri,  6 Dec 2024 00:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DEVfRe38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97E748907B; Thu,  5 Dec 2024 19:35:39 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01087894ED
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 19:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 118FCA43EBB;
 Thu,  5 Dec 2024 18:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8174C4CEDC;
 Thu,  5 Dec 2024 18:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733423735;
 bh=FLMoYPLrT4BoJjTb7VoQtDzoSGgeJ4qZDFyu2p1HBBw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=DEVfRe38P0pTaCuBJkXaLtRKlqGyUl18X4BbMV0qv+Dx0TRGrBOX904FsIAbJkVj3
 8FGlV8luqVavFGU3M0VhoFnaRSBRQf1V+qZtP53JaWsiS7JqCDGSVwutLowhI0DhGr
 EgyEstbZQjcJyWG2iISZ/ZMDY3RaEyGNsVZ6TQeGMHmdjaIrcJGVh3iME+9PBBxSF5
 9YYOHUpgkh+qaNe7BxXlGjugFDcfuIuHg8o7GkhlA547v6XHyJrTlRHGj1uenzclh8
 eZrAvADLSe+x7jugI4lDD7KVYfIi3V82NjPARfq6psf3trTeI7tKoV6tJVOu8THLeT
 IvX5AvK39wcHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AFAE5E77170;
 Thu,  5 Dec 2024 18:35:35 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Thu, 05 Dec 2024 19:35:35 +0100
Subject: [PATCH 3/3] cmd: ufetch: Show CPU architecture under "CPU"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-ufetch-v1-3-df861318bd49@posteo.net>
References: <20241205-ufetch-v1-0-df861318bd49@posteo.net>
In-Reply-To: <20241205-ufetch-v1-0-df861318bd49@posteo.net>
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733423734; l=910;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=crIjf2A+enP0K5Ya091QaL8E4S7xMtCUK2fAhsq3hj0=;
 b=npMmM+rb2AfEIp7GbBkLxClvhAYuTtj+R14rGIT8xGO0Z7I5pgVmTsXJ1qLRzF9zdlJLylI35
 WMeBJ6OA3vpCPkpYEm2Pd63HAKppIw9TIl9MAtsL3j8IsoN2S/Bplml
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailman-Approved-At: Fri, 06 Dec 2024 00:38:21 +0100
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

When looking at ufetch output it isn't immediately obvious which CPU
architecture the presented board has. This patch therefore adds the CPU
architecture string (for example "powerpc") to the "CPU:" line.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
 cmd/ufetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index 7aed0b447bda104b837d37c6adcbb21b80237aba..0ee50bfb606aa2223072c63cd46b3a70ef5449fd 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -188,7 +188,7 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 				if (ofnode_name_eq(np, "cpu"))
 					n_cpus++;
 			}
-			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
+			printf("CPU: " RESET CONFIG_SYS_ARCH ", %d (1 in use)\n", n_cpus);
 			break;
 		case MEMORY:
 			for (int j = 0; j < CONFIG_NR_DRAM_BANKS && gd->bd->bi_dram[j].size; j++)

-- 
2.45.2


