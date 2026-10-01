Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACCCCA5FCE
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 20:51:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0E308121E;
	Thu,  1 Oct 2026 20:51:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_4_6BKfR5G5; Thu,  1 Oct 2026 20:51:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2529A81216
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790887869;
	b=Sc8U432a6DUARiiJxmjDHSNDEXtwGIwoGiy6URE/ODPxIEh090EB6JusOfsUdZ3Cmlrn
	 x9U2dt+A95YoZp6apU2f5N05hPPMr7WMz8xZv0rW8gmjukAKq+L5qy0y9Ca4xQuA/K5Gi
	 SRTdF3u58f3w7FPkPQDiF324t5K4Nse+ZqCXlIE2NnGqTuB7IYm3mXB0OVF2iHyCG86M0
	 KJxs0LEUxj10ddwBuh0IEpElR9Of8QYwLeBWy/a5Tw3rR0KyV6SyHiNqb9ud5kbItjSWY
	 Y9xBMd8gkEaV6sw0kr1bcPVxra9RA1iyzJ9QTFi2tqazWKZsTyL8jUF5FYrD14i53uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790887869;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MRe+0Yx7B4iQ6IllEJCrWQPT2pPn99CcjMIBwbNIoeI=;
	b=T7e4LcZBI0dxq/8SXa1r/9yhh/9USMN5AYmYFI/lv8D6JJfILQMu5U+iQ5Ki1/c6Sk5i
	 Twn8lI2hw4bvobnDI6eH0lHdexJ4SZw7oso0JT/nXsQzfuC8FXPVyLbmsCOZ1LSiQfCoE
	 OafD9n5Nw5DZO1sSjuYSHNCddPBfym6bAtDO/MdeuuLue/BtCEEaE1zndRnK7FZ7aC//z
	 B0M4cUlfdgmMUgPT3qTH1rz+k4C2umB5KYfCDx/Fhg0HG1BypEJrZLw3Ju0aofJ5249UM
	 5BwQWfg/QOQu7RLq7dExmFNtPJvC2TqsuoSYE4znXWMYJjpCkC9Ynh1VlXTaiZAHj2g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790887869;
	bh=MRe+0Yx7B4iQ6IllEJCrWQPT2pPn99CcjMIBwbNIoeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DfaplqZOMGszkLWgkMLEQNpxYMAafzU6DvEFmXMBafc7AikncBcqw6heEXgJhOk10
	 3jq+VtL1HT0h8zg5/1COepG6ifDcuYgFnf+uIpIJR/OVWkeAxQO2plTTavbAVqxD6V
	 ZeDSqsULC9bb6QlFFAbgTew7BMZEorELGJ/fxlemECJ4CyniafOs+WViK/HHR+qTZ+
	 SdAhBlTDpxkfNzIOuQ+x4pVP9G+m2I2xJKMrEM8MjPUNJ5r6cPP+GG4yTaz0KWYXSo
	 3ejmG89r2r3r+44hPp9FbhQ+Fgtvqa749vCSaCFBpYpb041LhpWgSznKYOt+W2As6P
	 7k6qhK3TmTjow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2529A81216;
	Thu,  1 Oct 2026 20:51:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CE56D22B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B454140062
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:51:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 348kVTuvIoxV for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 20:51:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DDCFF40022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790887865;
 b=sgmWLZaJS3fwgS6jBdSbKZowVUKqyKu+3TUXcL9fUc2Vslr8ks+6JajBBDS/Xecklstn
 x6ezTz35zhOrrUvGtH5S769AJCz54MeBhVMvrq0FAUhY6cIp2dGaG5gUBfX1jTi+Sohw1
 v7Q6SYAfC9mzBMc0LXC+banOv+yRge6oJlTxTI+BPSiXS+n9dnPB+iJ89nubzhNyshpK9
 yxag18VDHTcO3EjiTBjE6tzSfZp86lOGmg0hq56K1pyi38JifTvlvuedVIgO8Zomw0ztO
 UbB8aMySgi3hj+yngR6zgLGL2njhvlRvW4V1GEG/nY0c0wA5XItzHQrWvZis7YW6oTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790887865;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=MRe+0Yx7B4iQ6IllEJCrWQPT2pPn99CcjMIBwbNIoeI=;
 b=HdEf3TmoDSxREOvr1h4tZMbReeRIC3sL3eRGtmHFHDUPNx/SVfK9Imyt0JI7mylmS4UR
 lIdDePT7m5m0QOY0naSLH/rwX4cRI14M1gGE5OJBYKEzt/8Yz5jPIvbETEIqSHEHwh/aS
 PLMUpwQNTVYlbxCA2QA2DplEReH8zRtQDRQaBRut6LEPb5om01XYuy7uAqljFtrXcJZSn
 j8LX68yX3kJ2amfNyx94L8qNUCy4ky3JVUsgJfpq6MyqI1rlF/zqr8/+p3FBwuTz0NcnM
 YNu1zmCug53WDDuZDaaZvJrfC2GmTlVyFW7ME0XDdX/nVdIYiQUQn64nqD1XJYSuxug==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=free.fr; 
 dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=JvDA33Fn; 
 arc=none smtp.remote-ip="2a01:e0c:1:1599::10"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=JvDA33Fn
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDCFF40022
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 20:51:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 15F65B0055A;
 Thu,  1 Oct 2026 22:50:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1790887862;
 bh=E2cu517V9owwKqqa1bzYqnWqeRiGHmEmEMdcYaygTrE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JvDA33FniuD9LYU2HLrf63G/AONw0skSFAJxtFhXYGL5SxN2nDjTjvVczwojEQYqx
 PpPjbqJp9Os4JoPJ3Syu9lTdCKj/sCHPwIMfP51WkJB2+/qXeQQ1Iusk8PQQc9pAQv
 d6JNhfHgEBX6daEc3TFDEx1m9CH7Bywj2u27lUv5H8G50ugLO7GKknGEtxekmvUG7K
 0Khq6IJFIVkrjYFRF3bpZYp7+wHyLU+OXlopQopkcnyvOcmlJt6sar/oRt1jLU1FJD
 8kb2PhR8ogiwk+870nIWAepMkKZFna4dxNDzY+mXAk0oZ2gIwmfi0axSob4Jb7kxVA
 gXOqC5YUAa9dw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v6 09/13] board: lx2160a: serdes: enter a SD1 mode through the
 mode it starts from
Date: Thu,  1 Oct 2026 22:47:26 +0200
Message-ID: <20261001204731.1774613-10-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001204731.1774613-1-vjardin@free.fr>
References: <20261001204731.1774613-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

So far a mode is entered only when SD1 already is in the mode it
starts from.

The next mode, 40g4x10g, splits the second 40GE port into 4x XFI:
it starts from 2x40g.

Protocol 20 boots in 2x40g, but protocol 13 boots in 2x100g, which has
to be made 2x40g first.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

(no changes since v5)

Changes in v5:
- New patch, split out of "set SD1 with a table"

 board/nxp/lx2160a/serdes_split.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
index 0107e8636a6..41208ca79ab 100644
--- a/board/nxp/lx2160a/serdes_split.c
+++ b/board/nxp/lx2160a/serdes_split.c
@@ -614,7 +614,8 @@ static void sd1_print_pcc(unsigned long base)
 	       in_le32((void __iomem *)SRDS_PCCE(base)));
 }
 
-static int sd1_enter(const struct sd1_mode *mode)
+static int sd1_enter(const struct sd1_mode *mode,
+		     const struct sd1_mode *target, int depth)
 {
 	unsigned long base = srds_base(FSL_SRDS_1);
 	const struct sd1_mode *from = NULL;
@@ -623,17 +624,23 @@ static int sd1_enter(const struct sd1_mode *mode)
 	if (mode->is_active(base))
 		return 0;
 
-	if (mode->from)
-		from = sd1_mode_find(mode->from, strlen(mode->from));
-
-	if (!mode->enter || !from || !from->is_active(base)) {
+	if (!mode->enter) {
 		printf("lx2160a serdes: serdes1:%s needs SD1 to be %s, it is not (",
-		       mode->name, from ? from->desc : mode->desc);
+		       target->name, mode->desc);
 		sd1_print_pcc(base);
 		printf("), refusing\n");
 		return -EINVAL;
 	}
 
+	if (mode->from)
+		from = sd1_mode_find(mode->from, strlen(mode->from));
+	if (!from || depth >= ARRAY_SIZE(sd1_modes))
+		return -EINVAL;
+
+	ret = sd1_enter(from, target, depth + 1);
+	if (ret)
+		return ret;
+
 	ret = mode->enter(base);
 	if (!mode->is_active(base)) {
 		printf("lx2160a serdes: SD1 is not %s (", mode->desc);
@@ -679,7 +686,7 @@ void lx2160a_serdes_apply_hwconfig(void)
 		return;
 	}
 
-	sd1_enter(mode);
+	sd1_enter(mode, mode, 0);
 }
 
 #endif /* CONFIG_ARCH_LX2160A */
-- 
2.43.0

