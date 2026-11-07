Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B6E606A32E
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GKrAsUGz;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=ZNKnTKAg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0488B812C8;
	Sat,  7 Nov 2026 14:32:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 51Dex4MqifJH; Sat,  7 Nov 2026 14:32:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D50880E98
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061973;
	b=E1Dz+Jv+7wfkX8F5joO3GCbCCH/jhqY27tnMnBGY7J63gkyM/GwvK8pzYGJAh1gnd2JH
	 zwV7uMZaHzIGCRwUwE81pTMPbV42VdCO+uaoNPUUOGg/V3AWdywLWXmQ7jOScsOdH2+13
	 0t0w376M2JOEmIIbJo8yiMZ3lW/GM1skKHxSqHemavi1NHN4cKJtXHeYFGUrxNnzBCi2i
	 AaUsK1ICtsuH4a7j3WzR80vOKbOJvp3GhFBkGVCsxD4EDZZWLbbLEL2BoDZHX54eD1qd5
	 QLOC0cq5i0auDAOlHu0/KpLDig4NlJ/uxOojeCREKBqMgXcn+v2bMRsXiL7gaqpQccQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Mkgq84RQfrxqxBlyOtivgcDiM67AKCDupGSzzOuAKyE=;
	b=ALfQ5lmw+jrYDsMqdBNZttFK/CYBkL1BHh3bdKwc05wx6D3KcaIE9kocGJ8J1tTpC/e+
	 7ebR/nZ105tB39cR+dvZgMpqfxhYC7bKvTzOwrC2SMbvjk46h4cdSFIo/xWI19do7e5Lo
	 fX1FrivHku2I/mgbg6hI6FZvzqQRnUduZcxwt6fUy+meS5k8d2uDc3bQZvO7ShtcAmrG8
	 IO20eFHIdzC8/JmUidXoNjrE7kmd9B8s5FIVUuUj/JTNn3v1urmYD8zZgW9qZLeLPCr+n
	 JMo92wPvDTADTZhUAzyQa5f+G5Fj5s9VIdu7NwtCkGE5Z0DHKbnAB/HFL8tVtbX5y3Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061973;
	bh=Mkgq84RQfrxqxBlyOtivgcDiM67AKCDupGSzzOuAKyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GKrAsUGzdBH1RLBVw8Brtjb/1xWb3pPzA3SKOsE0tAS1JPfFFGgCy1z7qR+w91c67
	 xbNdDutaf4i7f2jYMHVkR0QmJvHaA4RZa6rQWG1Y5EBImtGLBkQsf6KBDZ5h/Ml1Xt
	 qT+fLfSwc8YsD6wMOYr7Cy2Ysdh7RvEqNM31XFIMI2ELEnjOniGuEQGNWFH1rFU8cE
	 4YZWkMxWLPvVKXP/p+tTpk9B1AO6kywu3ud+B0zl6JyKMmdA84YQFxqdXlfv/1aoil
	 FSl21UDeKE8BZGJ/IEse91BWUcLRH+J+s8gjkzZD2w7suhUfQKtr6zYT8cp5gXWdS9
	 3J98Lw2C/2NhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D50880E98;
	Sat,  7 Nov 2026 14:32:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A8DB211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 640AF400E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id katVmFzNpPK7 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:32:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 59C264009B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=ZNKnTKAg
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59C264009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:49 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso1353802f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061967; x=1794666767;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mkgq84RQfrxqxBlyOtivgcDiM67AKCDupGSzzOuAKyE=;
 b=ZNKnTKAgU3mQti2w1g88aSqy3aY5S1xSf/ih49NDJm/tYWAVGlku2iePPxogMwO38I
 ySxdNzF1UUOK6eDl8TM0IKBeg6XEB+KqERrJ5Yd735g9cv/bjmtvhkBIP2Nh89OhbwEf
 Rzp0IdAs/5vsQq+RjPfnT2BzdUawVNp30Emas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061967; x=1794666767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mkgq84RQfrxqxBlyOtivgcDiM67AKCDupGSzzOuAKyE=;
 b=c3TfnMacJa69fcnypchJzvUp/SN6tGYejWJPBLfnbUMuaE8Hh5XkOk5XkEyaWGHUVG
 bTfVdx1ApqIIas+cWHU4rccWDPN92B9c96DojH51Ph8LLflepC90FkaZFmanXov7buYZ
 w71S+UtkfhBn7hCL/715GKZsgCZ0r0a5aP103Wen9G1n7kBLxtI1R79SqtkfvrDhYdCX
 rGTEiZHm3B+Aqu7wejOgCT2m1ITIO7FvbbMIAlQYZyytxO21SYssSBwtfV59QVzVOdFn
 ThzHyaaUggNcKIbMtWD2M3kJHHJ/2XnptlsG4EmppzC739LQPAuhPZo04iuJuMgJcdmO
 ie5w==
X-Forwarded-Encrypted: i=1;
 AL+hErFFnLVtXlyZ+izTvESHs4rBl04EiVEcHoidRyLkqxV5rHLcNMRQm2rbgcrz/NEmPC05GXN0GSs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z//ujGnHVqtLZMMKd2MkXD205dHWoV0xs1Fs6dQtqhZ73J9J9iZ
 QgirfwVhFpSsz2xj1EMLxmGlI37wRAlcORSxyN1TET0fagEf8KVTWrkbBztpPFrAdY4=
X-Gm-Gg: AYBFou2tBFBK3HZmmOBY/p/umYJXXZoKUnFmcVskR5RDbnezCeffqyc3TXZSs2Ttwtx
 KijfwLMy9fm56uKjlTY05O5hRB3MCe8zFsxCZz6VO5u1rOjpT8qo0vHVL/BLlYFmIpU75TFcZur
 DfRZXLlJ24SK0vPt5xFBIIJ44Ugi9nKnjO03hVQQkTf4chPEa4ZjXJR9JDXvl4pzdCsxDgxj516
 pWJQsnegAIxG54j0GwN3CSTKs8TTdNmFoYrdAZ2kJDameRzGv5EBPhbGECP2u0X7bKs4OpZOl9H
 EflFuBb/nNqOH/IL1t75R1tfd/uqpPYUglA78PdUVc5WWEJiPuEf2QtA17gqNxtBy2mAgHtAOeh
 EeRlUm+6UMEjrugnFDl/bR0jSh+FUFUMER2HNSyd2/JPFa0O8vpf2HFcuP44xMFV+t2NuOtSZZs
 2O1brmN13kpjV/+xAQotul9ctNVrCA/j4ge5U8hmD4jmIK71YfhInH0b8qXsVSWCeQqQ3Muw4Pu
 HLKc4BQS9Hzi9/MhuJ3R71IYwT9iEcK6zZh8kCxvpa881DTqJYuIVEquTct7lZCAah6gHVaPTj7
 9b2Ct2dIjxcjrrfohSTWJc4HICl3WvHz6YHxyArv2YtntmIFDpekOe4NI6SU0u8KoeHqQcYxnM3
 2mBSJVVgEl4w/1e4bgFW5N8lZ2LFHR46hFL6FL+ZyJHTrxSiPKTCNmtj/r6qiJgMHsW7auZF4Ym
 v89RDAmxdjq53mbaMheJvk7FXIzw==
X-Received: by 2002:a5d:5e86:0:b0:48f:ead0:631a with SMTP id
 ffacd0b85a97d-49277e91eb9mr10357655f8f.47.1794061967039; 
 Sat, 07 Nov 2026 06:32:47 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:32:46 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 01/35] dt-bindings: arm: stm32: support Engicam
 MicroGEA-STM32MP257D-RMM board
Date: Sat,  7 Nov 2026 15:31:51 +0100
Message-ID: <20261107143241.2236511-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add devicetree bindings for Engicam MicroGEA-STM32MP257D-RMM board based
on the Engicam MicroGEA-STM32MP257 SoM (System-on-Module).

The use of an enum for a single element is justified by the future
addition of other boards based on the same SoM.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: c673bc61ca926f664905c63f1455c7f95858a437 ]

(cherry picked from commit 6655c9d906a8aea1727ddf748c0e8ea05216d56e)
---

(no changes since v1)

 dts/upstream/Bindings/arm/stm32/stm32.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/dts/upstream/Bindings/arm/stm32/stm32.yaml b/dts/upstream/Bindings/arm/stm32/stm32.yaml
index c6af3a46364f..58a639f098b6 100644
--- a/dts/upstream/Bindings/arm/stm32/stm32.yaml
+++ b/dts/upstream/Bindings/arm/stm32/stm32.yaml
@@ -196,6 +196,13 @@ properties:
           - const: ultratronik,stm32mp157c-ultra-fly-sbc
           - const: st,stm32mp157
 
+      - description: Engicam MicroGEA STM32MP257 SoM based Boards
+        items:
+          - enum:
+              - engicam,microgea-stm32mp257d-rmm
+          - const: engicam,microgea-stm32mp257
+          - const: st,stm32mp257
+
       - description: ST STM32MP257 based Boards
         items:
           - enum:
-- 
2.43.0

