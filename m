Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47030606A327
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QkTwXtfg;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=M2Eu8/Yr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AB736084E;
	Tue,  3 Nov 2026 13:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sa4vxhwMLNjp; Tue,  3 Nov 2026 13:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0F91C60834
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711106;
	b=V76RGVcqdo5ESbZNd7kZbxGi569RvD3OaTYOfHP5F+Wcf5RCd9OMycOSdEAD6vp8dCno
	 zmn9h1sVM2sbb+9wTYuNlOlqROYTigN552CpxiiqVNcxfT4W/3WluRP0LFB/YA/s1nkMX
	 qSS+NdEORyR+Hl430cykDLjO5no7CcS1doqhrTLF7bN9RdPcyLme3XZzZqPFe5UgTPL7p
	 8sA/Kp21Rn6dnGmfZxSuuuNcQSz+woERQji2AjPW+iZg/lQftDscS3xSAG0K+/U1ywGKG
	 yPoWvCsC1bqbrffacbVl0J822Apnq+VRKGlY1uIpkvBwP1iOIQ52CaE7FeE3u7D92UQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711106;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=M2rI8buELvRirkmifi5r4ori9TN7gexFdEQxEXsEMgU=;
	b=oQ8O8ujYLA0SZRnk9bdLcnUO3oHh52poWdpW+eNM3aCx0axZhFCyavXWXF0Z9gJeELTt
	 nWmvvwjaib3DhAK9CU6kCT8iWzaqwl5u/yKmzSiqMXZlT8KRO9t4cO4eWLCKe5fQ4r8lO
	 uZ2Xa6KhcqnjlUXP//VQlsQ24LPZtSYt/hm8yqW6CtZEcnIUrYRAzfZ/s2VHJKKQ7u6Ie
	 HuBr4BF8FZu/miuCe+dJfwiYqkXkOZwZ38aQqTd+S6gcjimq9icUkcyiWAv3PIKhE2/Lq
	 t85zrVBNJvz8W2zYclV3WVKiZnIkNMTsUEWlDPwxUvK6NkRMX5SqxfppCBZDCXbxUVQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711106;
	bh=M2rI8buELvRirkmifi5r4ori9TN7gexFdEQxEXsEMgU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QkTwXtfgBzUGYB+0fN0WUSCGsMWvjfSzGRT/iqWIe98aPF81lsMSWRE0q1+NKnctx
	 jIiov2vhkS8lprkX8LZMm2bgN+xzgYY1qUdpw3OKleVe9wjBgo2pf8/sshmj4XtBBK
	 pOsqfGY2yh9xIUXhk4dBUsrnj1dpPMr941uSWzT0iJ543Ulm97kNSRVUUkPegkIZXs
	 XfDTcekeLKSJD4NY9zcUTaosTOTtne2el9aZHaChNln5ZujJEcVVL688Y8ufpNQWRk
	 BSJdTSmLgIy1RljJGeoe87D9+JjfcWsO7zu2bW80b9zsKwuuKheEl9Rbuj3nZ+R7vM
	 j+wE3lgaK6aow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F91C60834;
	Tue,  3 Nov 2026 13:05:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B49A7235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A4B2405A7
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rcgTRA2hkBPh for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 09:58:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 91167405C9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793699915;
 b=hfuMKv/X3gTkwWmQM0r3+vmhimERwH/piLhRwijspTbbo1oOMoMwq3XI3miInYm+q7+s
 gByLvPORdXu++UR2wVWBfUzAz9kgr4QGBgqTs+rlwLoM+ywE3pJnmE9Y7b0Z3107/YM/i
 VO/FanaRlysLYTpicQptpYZf9Vl4G26GhOjzTnRAn809zoCNIp190L+haSQPO6Uz+12xL
 mH/5HhO+JkwxqdaUuxHRsl6EO4JFkQsRGeuUXP6/3j+TrKrCNDuS1UwTMom/vyrikN50P
 Ttoxz0D3VfbxA11xaWzgZKAn/c7hNcAeEtYO+ALybc/XLp5S4zGnhbcto2kJmKcd0sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793699915;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=M2rI8buELvRirkmifi5r4ori9TN7gexFdEQxEXsEMgU=;
 b=TYxbD/HTEVfeUD2WyGJkig6F+lRKui/nOO3GpKZp0WQsGv2ZIIA48O4w82/bJRYp1Xz6
 LqKH67VERwrnXxXxZyxoGZPcOsnJdFlAlY42ziIVto5VgPwq9Fy6zEcaz8aNMaEijOc3G
 /XikIpqZpu8EmZMF3ZyAU5avG63mhS0LSe6kodyUsc0zX9pAObYp3FcPznmTO7YOViio4
 7SeEeHcjvWy1diXjEfr+KIys5aW4xC50Y9kEL6h1Z224s9Hdr7IqhyDL0DF9yMdeso1vf
 zfQaM556wxhk+Li2Q4EmbxIsHXPuviyl5isydjv5u3PlX6pEWF9LqJyNMF3yk108mRw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="M2Eu8/Yr"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=M2Eu8/Yr
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91167405C9
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 09:58:33 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so33109715e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 01:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793699911; x=1794304711;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M2rI8buELvRirkmifi5r4ori9TN7gexFdEQxEXsEMgU=;
 b=M2Eu8/Yr8xy69zoWWahE0LsthGZYvQAEl6YVY5Xpj8g0Jhw47RAFzms7gSjDc0AjV/
 pEGdfy5V/Gh/wfHuyaBjBmI/PYBBJtE/P2lZHwv33YbBCQU+7j/Wmgj0L0rFlEP2VYOF
 bkcMlnfoy1MwqjCGO+O/5Mo+jYXM4o6IsoEo8LorFfc3mznEzgI6H30EqKeJmvtogMyZ
 pbAo9u3FlMYqKDeu41hCx2ptzpZqpW0DETVkG4Xtvi9han8sh6/SCb6NY1DMYVYGL4Ea
 VlQl/KFEe2OQYkUTztTKhOUnYxPE3Rxnt3yB5SnALthyWr0LTCwGZPkfW250uEeiImj9
 qcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699911; x=1794304711;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M2rI8buELvRirkmifi5r4ori9TN7gexFdEQxEXsEMgU=;
 b=zoPVVRu8iBI/cdPj28KeQ/u/my3msj+clwM+eBcGYdbxHro7VGpWXiRNgkiQre099n
 jBbNjbXPiQHjDca4sMY446bIAcwE/XkP4jQVU265H8UuoRN5IOTl9rO5Bf7nX8rBUiXF
 uJbvWHCz8r+VsA9/d5U63X/5WkE55EUHif6HdCwmHuUEcGLU9c9rZeakQxm3UQZIC/cm
 9z/hDSu2ljbAitGvpOH2UC3wlyOVx2HxdDdYVXuVR1tHstMfW6C0LpLASSM+FFTMlbin
 Pi6hGagyV/5+Um/B86MVtKo3+etbKDMHUm4aKrIZMwsduMvZddCn2Iom52qJzMU5D0Xk
 /ciA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPKUBub1PNI5OXOkifsF3E1unmKiIOWzC19CMuc/2HKqbX0zFV6imhZMdvEPCItFLd/U6u5X4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+oZMx2Z4UE0lkTn4xjdHGOXKx/FYNcFzIXoNNDqtNQQtpfZgbl
 SGJw6HXH0xKZCwYwHurgK8Pb+cpoW5lTsTxwWIxkhg9eK/A4sccIESXToYnLtfYGRcE=
X-Gm-Gg: AYBFou0gveAHjUZOWVo7LSWsfB179eoAixaEa54wic74GLb3wmfUzBk59tlskj4+wHa
 V1qkkKNheFavnvtbbxVtdK8tssFgWmRH/PC8eTp9r+q+e0zMqYiklueMNTJgVMqHO5p8qqbxBQ0
 im5ewZMfo7EIbYRckAL69iVWMa2v7mGr69c/Am/TP2d1LEF4zMKm31wsyJyWaCVTn+LpjbzeWwd
 d96/eKGFd50ydNCoSuGTSJd/uDzf52JCNym6utdrytPSm9wwxiqbeadcsDsgujIqgKTd0Qw8DnD
 U8OjDgAHGm3WFHQA44A1ECtvnO7i/QBFD45OnOkifnprnaxhWN43FmcBiRJ7HepDK5jy2ahvirb
 LZf0iyiWODl9wkChJ1LYZSiBI4c8MD0If6ex8axj/E5wa4hIPdEht7pNFdjERNN6aobEbdxQ+/w
 6hBgf4CpbraYWm1/5L5Kbv9gD+M6LqicXfux3ewGLmDstNVq5ARMUajY8vy+rH9b/Fv8tH8Bklv
 /iVpiR/FXelQrt78Te77JVW/qbfqYtTZZe0718G4rD2cq6kenzR3kuczAVyKOx9sDE396MvGpcx
 3bqQfLlDu1bzqy7CrIZXg/wDLg==
X-Received: by 2002:a05:600c:4454:b0:4a5:1cf1:b7bd with SMTP id
 5b1f17b1804b1-4ac1794032cmr293973175e9.16.1793699911265; 
 Tue, 03 Nov 2026 01:58:31 -0800 (PST)
Received: from localhost ([2001:4090:a244:81d0:2c16:1c4d:8a04:e0bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9faff90sm51730055e9.5.2026.11.03.01.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:58:30 -0800 (PST)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Tue, 03 Nov 2026 10:55:49 +0100
Subject: [PATCH v10 03/24] arm64: dts: ti: k3-am62a7-sk: Fix wkup R5F
 memory region size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-3-0b24ff0a4d6e@baylibre.com>
References: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
In-Reply-To: <20261103-topic-am62-ioddr-v2025-04-rc1-v10-0-0b24ff0a4d6e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.u-boot-project.org
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Stefano Radaelli <stefano.r@variscite.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Bin Liu <b-liu@ti.com>, u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2014; i=msp@baylibre.com;
 h=from:subject:message-id; bh=WdqTIZtMV5UkkoebNtk4oCSCJuf1RxqnQi3io/pe9dc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqyX67d55sxqf/ry7hLB4HXPN89MuPReWvtOluGq5ZM+z
 0uTtcg/3VHKwiDGxSArpsjSmRia9l9+57HkRcs2w8xhZQIZwsDFKQATCTZl+J87qaFG6LYDw7oF
 nSv1XYNOP5h3vWvNJXHOHw97rlrEvn/ByLDzuMt3fvEDNo5KQf0F+x6+2/CtZWLJnrd3n/kXXxF
 +LckLAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The wkup_r5fss0_core0_memory_region was reserved with only
0x0f00000 but the MCU SDK linker for the wkup R5F firmware on
AM62A defines the DM code/data DDR footprint differently:

    /* DDR for DM R5F code/data [ size 27 MiB + 364 KB ] */
    DDR                         : ORIGIN = 0x9CAA5000 LENGTH = 0x1B5B000

which results in an end at 0x9e600000. For this memory region which
starts at 0x9c900000 this means a length of:

    0x9e600000 - 0x9c900000 = 0x1d00000

AM62A additionally has a second DM firmware for edgeai whose highest
section end address reaches 0x9e700000, so the region should end there:

    0x9e700000 - 0x9c900000 = 0x1e00000

Link: https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62ax-sk/r5fss0-0_freertos/ti-arm-clang/linker.cmd
Fixes: 77c29ebe76d8 ("arm64: dts: ti: k3-am62a7-sk: Enable IPC with remote processors")
Reviewed-by: Bryan Brattlof <bb@ti.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
Link: https://patch.msgid.link/20260918-topic-am62a-ioddr-dt-v6-19-v9-3-40972ef1f663@baylibre.com
Signed-off-by: Nishanth Menon <nm@ti.com>

[ upstream commit: 8d36eb58c06b867f29a8df2f39f7fe6718c726af ]

(cherry picked from commit 6bf6147ea69e2951c1b6ba6c69888d8f17719d62)
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 dts/upstream/src/arm64/ti/k3-am62a7-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
index d3b3675e7a8f..6e5419de8e35 100644
--- a/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
+++ b/dts/upstream/src/arm64/ti/k3-am62a7-sk.dts
@@ -61,7 +61,7 @@
 
 		wkup_r5fss0_core0_memory_region: memory@9c900000 {
 			compatible = "shared-dma-pool";
-			reg = <0x00 0x9c900000 0x00 0xf00000>;
+			reg = <0x00 0x9c900000 0x00 0x1e00000>;
 			no-map;
 		};
 

-- 
2.55.0

