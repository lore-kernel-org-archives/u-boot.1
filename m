Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993D8CCF2CF
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58413606E3;
	Sat, 17 Oct 2026 13:01:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1YbLhC7nZDjK; Sat, 17 Oct 2026 13:01:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9DEF96072E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242096;
	b=ewHg6+K3/SwMATMN0ftkzARvknPW2ZskkayJFA/a8ui0RKCltRkVA9watfGD+n4bXBgY
	 5bJYdxKwcP5rYSn/VqIDIa4wr/Kuzl2Ryh4rdBVS04Pypb0QlfEQw94q+7Q2aS6LOyc34
	 9LMlCgHJA3mJA2GAZewMaTjs9Y599JCha0sd6yij++qv/zPMdLOqrWFYIxrol7cIdfZYQ
	 ROfM3//LO+vfaT3tSCgsl7f0bRC5hgfQZSJUsnClkIA+eHmC+BNwGcI0swQpBeZJcbJWJ
	 mwrFYBEqCTCBriis/e+JNtJnKslPqULMzMDYJ3skZ0avkhd1SGk/18uU5t8px6DX1Yw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242096;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=xhW1uZOvWxlku2IB52F/V0aMDZVIuDXUvQtlB3Ww/34=;
	b=GVHLXl9bs3lvr45pJzlY+dbaqsIF6B7O7Xy/Fik2hBEZgwdV7pI3GTzbC2jRmcepAbVZ
	 nOTKfVvdi3QfwstwiSulZKHcPFkX7N2BSBVIrtjTZCRU9HsuH/ellNWSeDWqTlhBf20Qx
	 IbnoSDn7tHEmtH8Q8n9N3IUzDrCkHsP/XGU9jhHfFBGdFEyOvyI16cU+Y5XVD0IshXTGN
	 bArfZxvNkR23yAwJ+/Ht1R3Knc08/fJMaNVbEjTXL5Oo+4ZISvvrBZLWW4S/wBBAnCurJ
	 VPaX/RHS7iwXhOpMlI1bEDMR26QBsw5m/2r85Ca6gTouj8dIQ78Ss38JX2h5CfCsQUA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=M3NnCXu4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242096;
	bh=xhW1uZOvWxlku2IB52F/V0aMDZVIuDXUvQtlB3Ww/34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=kPCyqg8NnHhLRBjxH0jRbHWrrmCOqfAL2hMhCMnkRZuDoOVnojILq9A/XlpDG/7/S
	 AVreTcsxloyR3onoIMvP5n5OVRcNJwkpdqkDL3R5VLSEni1IEdD+xl/tRj6+XWlsrv
	 wXpyBRWwSiXDI6C6SqaJxLv1BGnFFQqxfaMxB6lkRk1B79m+4wZsgpF9TrItHIR47F
	 noUZhnyK46EdzzHReFqBN/axI6zPc57BlhNWMiF/e00JmOB/ZKxV6V/v6LkA+cuRa2
	 9v3cxp0ibJmzpxXwByIo7ctJarYVO46FESnTrGEq8Q7aBWxxoxl3ER6LvkiPWLmjwe
	 NB0Ag3vUIne8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DEF96072E;
	Sat, 17 Oct 2026 13:01:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40263105
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 257AF6080C
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EvC-U6AQ32t2 for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 07:39:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6894F608BA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792222780;
 b=CLq3eYulJXfHCwHFNSoDtCCxLmIZXoW4R5Ibih1tqmMs71+ZBZ5uDyxjIluKr69eLWJo
 dSiryJzDOQma7fOlZn3I2g+EEebZSKmlfTFMC9TGj5uZlgHDayH/1H2UrwxsiNEofcqtt
 8XTAyJlXh+E6qGxOCS5dz6oXoVfNDyOUQsfhp9Z2SJEKVY4XlRO+M5+krLharfHAehvNh
 DxoaXAKvjqHTEd17nVmjaA4RDBAZoDm2Y9fUR7dc8otfOT8VpoY9++KZfJmAu1Se3o6/p
 t5Q82DUR9VCiLRVECJzugmBUwGoDVvsdetSIJUMLpG/c7uzs08dPuezYiL2xkQQmRwA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792222780;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=xhW1uZOvWxlku2IB52F/V0aMDZVIuDXUvQtlB3Ww/34=;
 b=cF/DBJcTsFTNFLRiYVCzTOdEZqGkwmnrG7TokZA/IU/9gmlmJ2AjSFPtF7/kVBespdmn
 We79TAUONG2r1h3sTrR1Fuk/gIcOrgEXcBEJCYyd6+YQIJqDve8X5v8ZMGM+sxOI3Ljia
 3avCDWbsFVZnJZnU9OOPaogTdthaexbw/rfdqto0o7MF2ku9AG0tl+mgGlmkxThouTHQL
 h1i+oTEdKvUEbXNMnK4c3xJew04aujGsTj2d/8aoZbwHhSmbn7rQTMwmHhwR1WzNy1aW2
 TaM12xaH0k2eao9cA7kILnJd/ZVxLdWBOgDq2HmK9K56tqFrUbku14KAR+GLsGwI+3Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=M3NnCXu4; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=M3NnCXu4
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6894F608BA
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 07:39:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5800160AA1;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DC9BC2BCFD;
 Sat, 17 Oct 2026 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792222778;
 bh=1IQnnmNowldiO8bX+1raMSexH1PNuxHK57YO+UXYFJM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=M3NnCXu4Sc7AnHXSUANCPWMJRPNfEEL1un1kUX70HzDmWqApSyXEKe4XxncKpfLtx
 ARbZV7eFuXQBTw6ij3DgjiQ7HQElXep01nLgyqb36iyvh0U25af/uGfzyy8n/McG0K
 0wg0Pb0YDJABwKQuaGoRlxGO1vXWnHDIsYbqq/2KeLRe8fW9pWkUlKjsVdlpr+1tWX
 84LfBL1M5Yq/RI3tMf2T4qq2jHxXZcr94EYfBeQAMPVx/mkPyga9KSH7NU/EVIhLPv
 Br7PnFKmedE2pRCU616oWVaFeMmxd4lCx5qZOxcyIA6C1AmUt+auZRoTBcQ/orqrtY
 qqyIT9dyW9cxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E0ED2CCA463;
 Sat, 17 Oct 2026 07:39:37 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 09:39:00 +0200
Subject: [PATCH v2 1/6] binman: Factor out the compression bintool lookup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-binman-fit-fdt-compression-v2-1-d7e290847543@protonmail.com>
References: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
In-Reply-To: <20261017-b4-binman-fit-fdt-compression-v2-0-d7e290847543@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Alexey Charkov <alchark@flipper.net>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792222776; l=1809;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=lDinsgehjNDmAwqHdKu/sh+Rx+4S/uawzdMkBiqzPdM=;
 b=9r43RYVP2Tbq/1EIj0Zvz5XnxqYacsrCsgMHsx96GNxtBcDudxmchc7goXMhMyAWxz0g6qeq3
 R+XccxMz6IeCmaS6Eh/MDrOQyShgrHXfgFOneEl5dbDngV3xpYVzMgr
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:25 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Move the compression-algorithm-to-bintool mapping out of
Entry.AddBintools() into get_comp_bintool_name() so that
it can be shared with other etypes.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 tools/binman/entry.py | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/binman/entry.py b/tools/binman/entry.py
index 9b39c711889..5eef1d57be9 100644
--- a/tools/binman/entry.py
+++ b/tools/binman/entry.py
@@ -1297,12 +1297,27 @@ features to produce new behaviours.
         """
         algo = self.compress
         if algo != 'none':
-            algos = ['bzip2', 'gzip', 'lz4', 'lzma', 'lzo', 'xz', 'zstd']
-            if algo not in algos:
-                raise ValueError("Unknown algorithm '%s'" % algo)
-            names = {'lzma': 'lzma_alone', 'lzo': 'lzop'}
-            name = names.get(self.compress, self.compress)
-            self.comp_bintool = self.AddBintool(btools, name)
+            self.comp_bintool = self.AddBintool(
+                btools, self.get_comp_bintool_name(algo))
+
+    @staticmethod
+    def get_comp_bintool_name(algo):
+        """Get the name of the bintool which handles a compression algorithm
+
+        Args:
+            algo (str): Compression algorithm, e.g. 'gzip'
+
+        Returns:
+            str: Name of bintool
+
+        Raises:
+            ValueError: if the algorithm is not supported
+        """
+        algos = ['bzip2', 'gzip', 'lz4', 'lzma', 'lzo', 'xz', 'zstd']
+        if algo not in algos:
+            raise ValueError("Unknown algorithm '%s'" % algo)
+        names = {'lzma': 'lzma_alone', 'lzo': 'lzop'}
+        return names.get(algo, algo)
 
     @classmethod
     def AddBintool(self, tools, name):

-- 
2.55.0


