Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400E9606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pFgAFaNu;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=PppXvGBG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7BF080E37;
	Sat, 28 Nov 2026 13:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E9f5gdZXgMuH; Sat, 28 Nov 2026 13:11:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B35980BC0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871503;
	b=CFC4fEHNlCW0FbaMSDfdE4Z4sf5hW1HT1ibmRi+Igff11wx8HFdS14s0B2J6mjbdKGnl
	 UfMiUS7RCJxyPApV9ZR9napT6lY1AlVBsdMbKB7MC6+J85qraCFMfpJJ0dzewH76uHYnm
	 GnTYiQmTSitOF2znIVDNxab8sEwHSKoaTHjmtRwOSdSGIFbDQjaPDwtKjA1pVg22nJgQn
	 Eyu8AoklODcD+Atr0+FG9A6CUooCUhN4tElFNrxNnMGJZ5wFK8NoUWulCsLzJWvdRBQqH
	 XGgqX2CBy12a2/z7FZZq2Kicg0lM6x23SfEan3heQu+nWshSBhzZ4GqJj+VCX9/n6GQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871503;
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
	b=aSKWj3TbRmpkZdU3msWEwSBWtry5S5m8/MwhfgVoERh5t1VxrYTUjHSqZfGR3APrvD6n
	 swIe4Cv4ZDfwaBXK9dUXL/gt8NJsfgYXN6wIhRv7yeH/NLa+q9muHEVJDvKIQsBgXgH9y
	 5AFNOtQrhrRQLL/iexFUHUemENgqcq7pfGUrPU+95QZr6d2cc/92QpFOec0g6AkGf3GAe
	 4yisEt+9FdWUlbsmA1v0TRmC4AVCKZ70rRFFN1OhSG+j5Lf4nm8IqTKXLJkqHSQPU84m9
	 JvMcUChl7iL969gR5LPfXPYrs5KdlPLFc67HxP2GFbtXdRC3jEQgYFKrsa1muNpJ1SQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871503;
	bh=Mkgq84RQfrxqxBlyOtivgcDiM67AKCDupGSzzOuAKyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pFgAFaNuAnne0/vBcsNN+/mROm5casciyNgnTqjxtj/A5oK5pKKHYEOUzjkd3hUI7
	 IMyFHeEW6dgGsFJyqd2IMj/s9ecMxktWvw2IXJG9Nu+gVMqNwpFr2bHDiDrU+6PcdB
	 jpGM6o0GqO9XEYtUDeCnGiEexSt9ZQM2Vh1RNZjzUn/w5yXFxGmSbT1QI0dYCQ6tro
	 rn4bPUSqq5viwpzNOCKocPDB6xY6NgIlU9qh24o1Eu0O8i+RbPDFT1j0QEWqqHHu5U
	 8H/ohnxOPcW+uNQvy5IF6eyDvatVmQ9HVxnIwdDdb881cxDjx5PuzrFCw1ea3vc/DS
	 DJVPycaEeBv3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B35980BC0;
	Sat, 28 Nov 2026 13:11:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 644DB26D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 622F9400E0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7MMO7jezDJ2 for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5CD3C4005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=PppXvGBG
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CD3C4005D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:36 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bba5e17728so33753225e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871495; x=1796476295;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mkgq84RQfrxqxBlyOtivgcDiM67AKCDupGSzzOuAKyE=;
 b=PppXvGBGJSTNpHCKWWjQk7DVNvtqb1ZhsJOWkCkAeJJ6yrzFW2w2uMtjvgHxkrQHkF
 wrgfO7fw630Uaz0fdiraV+0Mth26mC0u+RhfwmD371Tv0wSGqAaFn0x8mI192EyxrMIy
 vhTYSnidoWcnYH3vOwo9TO3YEZ1XWlDmFTx4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871495; x=1796476295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mkgq84RQfrxqxBlyOtivgcDiM67AKCDupGSzzOuAKyE=;
 b=ybZ7HITcvmdMkRQjOS86go87MbISZhuwks1c7bvMNPnoFvrq3f285nDLnzx58goJc4
 5iESFFhfXd3Kx1DYNMdjWn8pDnKLEGiRbEUYq8AySgSZoMLMnMpwSC01TfZkNUUWv46K
 CsI8aDUtnBQy/x7wq11oA9JVc/sCB2zClx9r4ht4euHXkrKquw7LfgXGTN+kS1fJTqGL
 o1r1JChWiTshCfACEVS1NgQs3fo58vZp0NJiuKpG9CZ1/33H8HL6VChmAMZO8x5uJA+H
 +UzjpTAQ/bJ2kZmHf9PhSBeAVn33tYhtmhsV1+r/wUAbdJ83q9af8yBATEStIZZoSpjf
 WDBw==
X-Forwarded-Encrypted: i=1;
 AL+hErHpverC90M3yST0uxp3VW+ZlRtunQ+AQ+aOpVyQ1+MeUZUzrU5hKizWvZo0wShtkbWVE9GcsH0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Wp0/0/gr2s7IrRspV1IofI4U2vq7pc8EtsGnxI7Mq5WUyfpF1
 YI0XXQ4qwCVpxW9lKsb5qGPqPR0o6aHD3LIl5VVy+ogJii8WynVXcLfpY7drWZDwQxQ=
X-Gm-Gg: AZFdTZeJjvYe6AP1pjUY1McX0aLHRAbd/HnEFKlJ4x47J0SYuzRUxHu0xwsCc7EKZ28
 Y2REva3/hwBkuOvUOWmhglRJJz8ASodOA76tjW9nG6SY1vfWju39rYwz8GLDUtxu5AOH4J0Z3pD
 jSpRJZRSlYuhPHNkTsbt3ab0RDboOG/Rz7/XmpHpXPGDBZmd5hdmkCwWAqXozP0ph87VCHmzJhk
 A4ATrtGJyFtry7qXLmHf17dOtHzTc3oN880yEEUV6XRBvmYrF9PqO76MqxI6EOOyZIazt5Ra0/d
 4TueCKULB9Tmo3SyLXNdiLzefdguc0d4PSlcqAwg2/CvNjjr5jTHcr4TClwfBQqK9eQA6fsWHwo
 lLy4NgHqlSshzw5oFW9vQ1KzLZRcd0hYZpdTn3VyOnwCxvgS6awOJcE5gP021Kv0kyNqMxgLgh6
 4Tv4SznXt7CmBZoF1LZzwrj5eroIbN2z+WpcCaoh47xpplyECkkZt4cTRx4Nl9HI7I/5UCtON0i
 yTrwEn9NpL7wI1HM9eRxlUTw31UeITt4kK/q0CUjx7zYeHdbmSHjMah3RGAq1tfGHM2E73cVlAv
 rusjYWzZgGyUBL4SzH9JeVq/m0i5wiklr5j8agkbiC8nqUt64K2NqWp6rGoWbJFUZunjWdHbRC5
 DEIPXEnc9+4PCjM29neGTXBCRyfj4tnAwaCF/hP+0TxAvHCfrRCXj5s/AN6TKpj7HV/ufCse86n
 7dnflys6X9s60XhRWB3zAvur1pUg==
X-Received: by 2002:a05:600c:3b8a:b0:4a3:59c9:a754 with SMTP id
 5b1f17b1804b1-4bb8892da25mr552194575e9.22.1795871494501; 
 Sat, 28 Nov 2026 05:11:34 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:33 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 01/29] dt-bindings: arm: stm32: support Engicam
 MicroGEA-STM32MP257D-RMM board
Date: Sat, 28 Nov 2026 14:10:18 +0100
Message-ID: <20261128131125.2141352-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

