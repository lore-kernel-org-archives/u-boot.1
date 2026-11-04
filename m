Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45D4606A336
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=e9AXHtV0;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=D0PWHCVn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCE9D4070E;
	Wed,  4 Nov 2026 08:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dxxw3ucCQAS5; Wed,  4 Nov 2026 08:51:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D706A4070F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782266;
	b=XrM4O5tKl7gkcXimU8dw+pIaGi2XpuBlpFXRy7FVy7W4rbU1FMunivOxNP1aArU3A+15
	 cEcfKFsQiAfhh0la5kdAMpWdKCkYr3LdhWGDEpy8LyNI8mzJ0Pj5kXZbEI3m3N1cJj/F6
	 exln8ihDWV10tCkKReZ297bD39QIyaXChgBcc4KmwacDb1Mle3Er3wgiZzUbO3qRIbedr
	 JaZVBa5zbVYReXsJnHBh8UL+GjTGQ+X+q0yh8LijvMBC0VhGTknpZrOkOWD8IQbq0X9ey
	 El5YR8EdmFwLHVaoDS5Ik6RYv5uXfARzdNBWuD8hWNLsQUcWCgwpkyYZ89KMbzqjVGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782266;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=sjYyfbjjlWThAJHKsB/T6oDZBgR8uNsl0MkYvJZgPtk=;
	b=sJSLtQ3wiDsojADbluR+9e7IdqGTMdsljqeDiso5fMXzWlvkbUlt6Ln0EUEz2WkgLBow
	 mH4LHuHUXO6LnWb8AiPLPmQ+3VpuzmOjh/0+SMVrTjhODImStutFqGveUVQjMzTWqGkyc
	 gS8z+ye1hzRLYN54ESo8NVsmMfDlhBj0gtM5TGjxXSYl7QJCmfgR4bu18gP9FVayInzC3
	 2JbbYyPWfupsnkPgZ8R5cwaHa8crK3CY/+ENP7ClQx9xhMuC3/sNu1TqxBhyEO/m8aZt5
	 cJc5WXCv060uiPMiuwrCLytswjbRQnj+rgDHd98PROK1H1Nfq+X0oYommNtnWxYx9yA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782266;
	bh=sjYyfbjjlWThAJHKsB/T6oDZBgR8uNsl0MkYvJZgPtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e9AXHtV0W3zhBoZSXiHjNzj5TmhBTGpFMPpmx/+S9navt70TWH2+Gt4RE1YLuSLrX
	 02D7ANNtTIVSvlCbcxyojzgDMSJGV0AzoTOL08xErMBX3Ry+QfhP5alsD/Hygb0Esc
	 +VGPfkTNyCSKxhcWJ5XGzg/9ycyGmyPxkw4Gsy9DPrzAB+lnrY/GaC1O9fGX3hP2Fh
	 Z6gmXkG3BCCKNwbWqAoNLhBA8qfj8Bn44MAIKsA5JA4KRkLH3Ax79n1SOhc1FRzndj
	 jOw8/6hfB5yzVj8rs+BD/JyGt8YHs1QY5Wh/g8D4o3yYkHS66iKNH33Xaq2IUp3MaC
	 QpyK2f0xeEuvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D706A4070F;
	Wed,  4 Nov 2026 08:51:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A99D3A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96AC9401FD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ACLwiXxMjb4 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 908B84004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782260;
 b=eDIB4MGzVkb6NkYnXTfB0RVVjvLTAf1idSPCOd5sSdfpxRYiQmhL/6KCOqG8QIZNRNRB
 VTKJk1FsdYTngeutrEL7SiwToSo/4YdjBxo2GsX+Vm/phprgpGd4rRFjnozgGoET7XA8C
 69HBZTcCXVYBZSJ9lhWdMlJqcjWtpyx2a2l2/4VleGNnC8VUzmTkJHQVSOk1P13aOn5pT
 Pfecv4oymaqyn9tgys8lZiS6+cZ7pP5i42tXwUxqIMbBcrsifGvD+xFBRDamRgz/yl7kf
 2iCKlK/+UUQNm6imUZMr6pvK8BPrhfWh0B8B08VXdJvhXZd8TNhmQcV8JIwvr98mhpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782260;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=sjYyfbjjlWThAJHKsB/T6oDZBgR8uNsl0MkYvJZgPtk=;
 b=iuYgziNmrMBH4pjI8vYR390N4iztItiw9mR6Cv2FkbAVSDOUhQ90UhKQdZXA05OjVTS6
 cT0RBzrx62VS0mqdh61Rl0s5Mr8Bq2uZNQ7UT8tS9Dde9JF5gc60cMXrsXiVzMINwTyAX
 rlwyymNXYe+JYaJUoVBgYs2MXd2pu82CPm4gdW+w8xhhe4BnWviCsTX3yIeKFItgJBr6E
 vfnhSI0syOfsYIVu//RmjyPlLzXYpXC9W/z1jyc7xfsDpWBtc0tJ1v5l8vwk1xMZ00vRt
 RLFDAOONZLojQqHGurtBrEO4zVASUo+IbPAhKaH7p8x+Y7UD/L2t6uyVHQyOMrOUF1Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=D0PWHCVn; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=D0PWHCVn
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 908B84004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:50:59 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso2743635e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782258; x=1794387058;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sjYyfbjjlWThAJHKsB/T6oDZBgR8uNsl0MkYvJZgPtk=;
 b=D0PWHCVnDto58KXwT+3g1HIfRpZBDxHb4g2u4av5626NdJp0QDp1xErUAtRua2wrmN
 7PxA9TKItWWRN4/qD+hINCk2iRvgwgeRPmBQvMAPk3r7WxjLdEgDHG0HuktXyohevenf
 anIUpL0xpF0YRJxwmUw9Hw3qsX2IdMapcgSRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782258; x=1794387058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sjYyfbjjlWThAJHKsB/T6oDZBgR8uNsl0MkYvJZgPtk=;
 b=j/4qRB2RPYcnTo1M1e/kmsU6jP332lIv2yUlkStnPWpyhE34VdP8i9I/puXYScXxzu
 Pxua8cxdf0JorwHg8SyogLhOv7gmuoDVL0/H3IVkkqqtf+/NrQQ6Yb2Fj1U0pnyhg99q
 oFnGXDgaCoXUeeDXMIeh2bDsLEiSwbjDtirx8qS5ZqTC75RKGcyDnsOjEKDr4bGcX/GL
 NIP8Vyj+O8E/wYuowNQOTW5Rlaf2fynH7eK7Pn5Rov08Nx0QAVaS63353RXsJDdqDvdV
 6qt8jZUoyrtcmlBc6Fh/+OnZbkG39kHYn4nuDpVH6JveaxaYLRbIVz1UwZTD0FW5V1zP
 OARQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByUUUM9wdHXJuHDslN4yKPDKUOjEbugIe2hdfeWpfpQGg8yNA09MAJErgtcvMhVT9EDFEhdSps=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z83OMUym9UTQWec0LK2rshmJ+lIgz4PXpsp/DN4q/iqsZwNAZm5
 94BSBcM13NBcXLzGMCizDk+qPAkIY4qPZBZN1PS57veqiS7o18esR66vKBMlFodBlP8=
X-Gm-Gg: AYBFou10H2oFoFa3Cg0JKUZ0+9K5EE2Cpv5/Tiu0yg3+tfwiDMMHBMNl3z0gCDPQqhj
 dGj3iK9avMJSNEmJfgLv6gSbYk6kvd68FPWz/OuMph4wUaSpeB7InX4n0+EnNa7BRqvAWq3t3Dc
 NJXAyoojukepleSevNGFZp6R3XyZ+LAsXLCEohdY+VfL5rDrf62kVTQdP2ZM37DhWUQC5MDd0WJ
 C+7qDVAQbuptXXsb3ov7X8FVn3TNybBmzJdfbnUgCGcuBh3IZJBAYUpi+VwWccWVpXWVHbZ7j7v
 4nc3+A1ugIB74Au7sgvzEmn+SPZGQZN5uksdqtgE0kHXQkyyk0EF4jlaQnfWsQ1umccsYKjI70W
 EagJ/J98hiY+L8+1I0QwPyDjWCHd8PmSqsAkC60G/rT59MRDVIAEvk1WH6zUjEedKD8dMRhk2Wf
 1WbIpQGJ1cMDDzxw+4T5KEpnrh+HyujtFxVkNCD1KGzNQLvw/rC+FE67ikZE8gGik6pyeS5UGJJ
 cmkF61OnDEipMRzz83tjRRA/NtMLSNSlpaJSD9E312rVAujl7bUwyzDUXOBxZ76nkDlO+Ru6PX+
 yo/q2RUa5WpdrBJUJzNrpN8g/QYPaPp0eGI8WCy8dqJK/bHZW/FfcxykD5rviOEbq9s2kTisDAI
 YFR7mUCa5PSNcceZLM511FdLQx2c=
X-Received: by 2002:a05:600c:a4e:b0:4a1:e57b:667c with SMTP id
 5b1f17b1804b1-4ac183d1edamr353179425e9.26.1793782257655; 
 Wed, 04 Nov 2026 00:50:57 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:50:56 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 03/33] arm64: dts: st: add power-domains to sdmmc1 on
 stm32mp251
Date: Wed,  4 Nov 2026 09:49:36 +0100
Message-ID: <20261104085036.4012238-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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

The sdmmc1 node was introduced early in the SoC bring-up before power
domains were systematically mapped. Add the missing power-domains
property to align it with the rest of the peripheral nodes.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-4-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 4f454e51290d072fef58eca653c65dc1fa8c7d70 ]

(cherry picked from commit 188b75b85a9f6dd4dc25cc4d6b7298d01ebf5efa)
---

 dts/upstream/src/arm64/st/stm32mp251.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp251.dtsi b/dts/upstream/src/arm64/st/stm32mp251.dtsi
index 9c63fdb5a885..ae36d703532c 100644
--- a/dts/upstream/src/arm64/st/stm32mp251.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp251.dtsi
@@ -1664,6 +1664,7 @@
 				cap-mmc-highspeed;
 				max-frequency = <120000000>;
 				access-controllers = <&rifsc 76>;
+				power-domains = <&CLUSTER_PD>;
 				status = "disabled";
 			};
 
-- 
2.43.0

