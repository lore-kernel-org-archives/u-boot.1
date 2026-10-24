Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35B606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=duBIq7QR;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ke7SeGWc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C97440AFA;
	Sat, 24 Oct 2026 00:10:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ppqMccWW4He9; Sat, 24 Oct 2026 00:10:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 13D7240AF6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792800621;
	b=DXeRu0MqqvexcGGexM2LbmeZ02dKP274c2Ykkt28B4ETdwV9EuFA+t690P31HcjqhOQj
	 2C6OCLuPxDF0PvavCWEGMV7bgYkyq+86n+lc0/YJHZAqnQbATyQEBeJUdBiGn1ALflAqG
	 m3two0wPxkQjb7XXSsyTQyHOFQ+lFieAwucaNeJAdjjuhfNmGojGMEVqfRrGOO9omC6IN
	 AaGQ//TG0FreeyXZz96k/4IJ+2g6zRfJ0Bch9TBLjiQM2RGcaYsOVJZ4Mo28h8Opjg8bW
	 m55pvfnuZ1sTj6a3ww5e1OhfGdh/C1zXG+pqBnNV7VpWtPqzvn0anpW9O960lxbWX6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792800621;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U1zS0mU+2S/qhOZEadnVcGfZbMZ/lN1Z7BfkHwKa9Dk=;
	b=WrFrdGz0zUR59d+OxPOopZjG4UzGvoDv2lgBvMlojNYHg2EYUyFm/0IZsUKS5cPo6mQ1
	 BgDGVcP/nRKqqJGir8xR8Px7sJhtsQs7Cjqt0T6A5utZiQQc0XHeVB3mVJnKYz5dgRzjG
	 qCXylBRPYc08v1SPsNcwnBwtw2h+hAZo9oVXI2qAiUKytF7/1bvHupJTYDKBWqCrrNdTJ
	 0ZijEc2aMv6ecHxQM1QwymtiwsXop63Daozu1PnOKv7MBrCRLjZW/N8PxkW6GcP8NMuAT
	 M7gNGDLAH71PE9qOJj2Yvm+aSc42cE5BAjZOglyindXGcOg27b3MkKZGsAUCTNojqig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=ke7SeGWc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792800621;
	bh=U1zS0mU+2S/qhOZEadnVcGfZbMZ/lN1Z7BfkHwKa9Dk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=duBIq7QRiJlU7sWq6lxx6gRtWl3++RDU1yamAXobWr7KBFYMh5kvqlnbJ01f3BeNW
	 VCInunqxqrj52vw/7ke0HVjJvzkOM+gF+yemhe/7Ukdl3tPSX+sfXIKpjAdrQ7pCYF
	 S2si5UBJOsj5y+e0VTCeD63O4QEO8L4RcKOZ8yOWfJqfcb9d3hPqbK6s8Zmb+/Gqd3
	 x5A1Bb1EKMuFe3YFC3I7kGZ+7E3hOYUepZpmMRnXCZTv181oI+9B9f/zaVGzvnw2QO
	 pVh4ETBEPfeXtENEpX3r4sGh5YnBd+b6x+aBcILRLeby0Pzz7FspXusDs1aEqMRDVC
	 u/90zuDkWulgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13D7240AF6;
	Sat, 24 Oct 2026 00:10:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F9B43D9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9028440ACD
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8vydJ6y70R5r for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 00:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BDD2F40A30
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792800617;
 b=WyPl5imycGaWXGpqf8snNBOG6aFeZPKBAqklfrdHI+kvG+DCHg3KULZdLakz54uvMYdX
 3qfNJRt2nVLRAoW30F4MUtNYgNw7Q/VvtlGah7cDVGS4FEBHuIGKI5QOjC/RY/xm8p+mQ
 0Bt9L56SVNpj/ym9+AwEslBQXKJFjNSENRWtqabBRaxLsikkCp+kw7H4V/7Rf86EwSgia
 A/tUhX3aFRBGMDEIp4fxURaBVAcuO0QpavEzUfABrk0ZLfSYFQq7SmmCxfK1PZv1eAyiy
 Qo2Z7DEehgdf0sObsLr2pYqX45x0asiFwrOI8CGLIYmqe4k9z6t4xizqYzuorQ4WpaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792800617;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=U1zS0mU+2S/qhOZEadnVcGfZbMZ/lN1Z7BfkHwKa9Dk=;
 b=gjAn4yM5pVr+Xrvy8Smxk2BlHfIw9kgzjOC0lPoEvFGU+h42pWlKZ1EoQts4y+P+fmSa
 cLxUQwYRwCOJyP2squTNFKPvAqgfxRGa16EooX9y44lZ98k5Swk/nsyylkY8XWI3OtdA1
 JxBapVX+zoLZFi2VbiNZDN8XJZfvYlkHXmK5Hhh8cI8kHE9MIlU1ZcVeZl0RGHFtSBSiU
 /MFgtac2C4bxM/8HD9yJRF6Ah4rvWkveh1zp+B3T2lU7sMwN5+mjOI4ATm4xvqADc/+l8
 +EScKYpmk2VvGfPOkwEoDcnaK3DGOyfd96ofwyTt/irOMliJ1CYV9x/J9EuxyJEQwqA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=ke7SeGWc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::332; helo=mail-ot1-x332.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ke7SeGWc
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BDD2F40A30
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:10:16 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-82109f51565so595586a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792800615; x=1793405415;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U1zS0mU+2S/qhOZEadnVcGfZbMZ/lN1Z7BfkHwKa9Dk=;
 b=ke7SeGWcOFMxsewlSIQaLQeOte1aZW3nLMt04xukDit6N2Oy7hCijvUvVm4WYj0sYi
 /gWRpDJQGH3O4Msbm+s/pVSLMJzJxumhOyvJvT8/o7iirSTHaw4FqXZfOjrJaOeJ4Oct
 nP9T66kcuv+YbPBThomMtu1zoxY2X/Jf5+QzkCsBfbCqE3EKGpWUeH4oVEiEEKUbZdIv
 80zss2Tynwdv2Cfm6zJCsFGxcdh4DjDgySkYTCCkxWmEWQzXiGLJcMoWBSHIrbDn20ZU
 3kLkCH8gm8EJGgLcN9jluyqRNCMzPMxWn9YidDwilsHwJNhvB8+Ad5pBgy0jbJfyeCDw
 agvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792800615; x=1793405415;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U1zS0mU+2S/qhOZEadnVcGfZbMZ/lN1Z7BfkHwKa9Dk=;
 b=NNksgLsm3PMNRBaLzkO7v9oSbkAtwJcm6ExTkUeL8ac/5APL1OrUy9uCYNsgBxWYuJ
 rFXPhmorLeR4lUUj3dKjVz1XCgnKSFqG3eGHWtNqnH+lVqV5ALKKBX5vjkJZG2+2jBjB
 6xH6ILVBVDNpbLoOGssSbLg9bes1hZ/q+yTenIHR4YC1x5vz2+yTYmTbeKmrro7FTI1C
 Q9rRc1c4OG/VIbxcmXqz7Rgi73DUWRMbbq96PoNvLfGnZ4vQ2PTdvcpAu9G7QtmnC0Ji
 HzOxTUVL3hmkMN5BoED4l8Fwr82Pzr+A5eELyQn6g6S8xhhXsGN+M1gEoMsNE4hoAK84
 ehSw==
X-Gm-Message-State: AFq9FYKWWcQp6QzseCP9OSzL6JcPHqUx83BOaIvZ4pgfmEV3lESFaLk+
 qbMbz27/L1WdSYZLGztIbd//BUVDGTszNuFZuseJ+uLyy1VZfhYXSE2FmC+pbWcudBc=
X-Gm-Gg: AYBFou1t1BMbFP6P+Pxe5w9E+CQ5JnGwUXnJW87TMa3pmzymn0rTZUI5kMrSKuQyFFO
 W6pYc2ZI/TqSZfVzdK1TBr17EiLFylZqXxGfU0q9nZuBr6z2jKPmbdkVNKapNgkh8v+LxGA9AFW
 fGjuIMQFRSCJjs9eB0RzFj5z2KFoQ1zw9eps14Vqpj0uRSfV2CEjf2IVGIK9R6G7YnHVstAAITV
 CuECTd68dG7Xhpbkso+eveyt1A3+cz0y2mPj468/YVZmONMXF9YYeSj26zjefuxAhOqQC8Jr9ql
 EVvWFn+hdVejGjs65bKTRc9Jvw+bemkSscYyvRIFB6jK8GLnjo2rQWi9De0/92wnj611RMUQak5
 j74sdkB2a8Pzq2kaIAUHQPpusAbO2WPc6sF5PT/8IuB1yyr5fTZu2H7ChLBYwM5lAOal4/hRL1r
 7E2lTcnGRieSsnGukmZ7i8Fil14SpEiAFdPKc9BD7Vz9PU9L0xYWDt0oDPNm0Hx7rNbP0EYE62R
 7BbHKDYYS04FPwNzFoRRW9dbIK+s7Z/f7DjJI5VUH6s+8VZJzQFv499ePZG
X-Received: by 2002:a05:6808:50a6:b0:4f4:73a9:f838 with SMTP id
 5614622812f47-55c002962ccmr555005b6e.22.1792800615260; 
 Fri, 23 Oct 2026 17:10:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d2b5:d533:1cac:8248])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c04248804sm328636b6e.3.2026.10.23.17.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 17:10:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Oct 2026 19:09:09 -0500
Subject: [PATCH 3/7] spl: atf: optionally pass the bloblist to BL33
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-mtk-genio-720-spl-v1-3-f2c0ee094fd0@baylibre.com>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
In-Reply-To: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4243; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=peZIw+67VpSHbs+DWNKenbwhZ+dSBf9e554jZapsdKA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2/c7bzuFFf20DQIn1IGDqFLvhYZtGCvQCtlAm
 TLijFDURoGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatv3OxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ayj0IAJ1GwKQlRfxbvqJhsIoY8nUQQoREQqws1c4ZbpM
 J+4ZdNz0ZIwbWk/eNyE2vUm/zOtitryhcIJGGo53CWKRrEyEub1h3ix+rqZZ+sY5OuTD2NN+5xe
 1MeoGP80q0EmzsNfeR9liTXmQFHtnZJxLujnMDBdIdUaeZn045WPTw/GC+aKTxx2jLsMQdugjgA
 OKjvq2cZNROtPWj/aLpc9Bv6+uouWKg821ofpEzdnOvuts3ayNtbDeZcJV3+h8O/Qsakqibr1Su
 Qkor4QHonBabbgXayeIQF26RU6WthxGmUvZ8CgDUa7Ne+mrW8aDRNnV4U7vvUos3BkRLIGC41XF
 /50Y=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add SPL_ATF_BL33_BLOBLIST to pass the bloblist of SPL to BL33 with the
register convention of the Firmware Handoff specification, through the
BL33 entry point arguments that SPL gives to BL31. Without it, BL33
still gets the primary CPU MPID in x0.

U-Boot proper already looks for a bloblist in its boot registers, but
when SPL starts it through BL31, the only other way for it to find the
bloblist is a fixed address in memory. Memory at a fixed address can
still hold a bloblist from an earlier boot, for example after a warm
reset, when an earlier stage did not write a new one. Passing it in
registers ties it to the current boot.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/spl/Kconfig   | 13 +++++++++++++
 common/spl/spl_atf.c | 29 +++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index fb8bbbd2f5c..28ac80d697a 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1705,6 +1705,19 @@ config SPL_ATF_LOAD_IMAGE_V2
 	  If you want to load a bl31 image from the SPL and need the new
 	  method, say Y.
 
+config SPL_ATF_BL33_BLOBLIST
+	bool "Pass the bloblist to BL33"
+	depends on SPL_ATF && SPL_BLOBLIST
+	help
+	  Pass the bloblist to BL33, which is normally U-Boot proper, with the
+	  register convention of the Firmware Handoff specification instead of
+	  passing the primary CPU MPID in x0. BL33 then finds the bloblist
+	  without relying on a fixed address in memory.
+
+	  BL31 must pass the BL33 entry point arguments on unchanged. This
+	  only affects the default bl2_plat_get_bl31_params() and
+	  bl2_plat_get_bl31_params_v2() implementations.
+
 config SPL_ATF_NO_PLATFORM_PARAM
 	bool "Pass no platform parameter"
 	depends on SPL_ATF
diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
index cb0604ce034..8b65f466bbc 100644
--- a/common/spl/spl_atf.c
+++ b/common/spl/spl_atf.c
@@ -10,12 +10,16 @@
  */
 
 #include <atf_common.h>
+#include <bloblist.h>
 #include <cpu_func.h>
 #include <errno.h>
 #include <image.h>
 #include <log.h>
 #include <spl.h>
 #include <asm/cache.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 /* Holds all the structures we need for bl31 parameter passing */
 struct bl2_to_bl31_params_mem {
@@ -41,6 +45,25 @@ struct bl2_to_bl31_params_mem_v2 {
 	struct entry_point_info bl31_ep_info;
 };
 
+static void bl2_plat_set_bl33_args(struct entry_point_info *ep_info)
+{
+	/*
+	 * Pass the bloblist to BL33 with the register convention of the
+	 * Firmware Handoff specification.
+	 */
+	if (CONFIG_IS_ENABLED(ATF_BL33_BLOBLIST) && gd_bloblist()) {
+		ep_info->args.arg0 = (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+		ep_info->args.arg1 = BLOBLIST_MAGIC |
+			((u64)BLOBLIST_REGCONV_VER << BLOBLIST_REGCONV_SHIFT_64);
+		ep_info->args.arg2 = 0;
+		ep_info->args.arg3 = bloblist_get_base();
+		return;
+	}
+
+	/* BL33 expects to receive the primary CPU MPID (through x0) */
+	ep_info->args.arg0 = 0xffff & read_mpidr();
+}
+
 struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
 						     ulong bl33_entry,
 						     ulong fdt_addr)
@@ -87,8 +110,7 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
 	SET_PARAM_HEAD(bl33_ep_info, ATF_PARAM_EP, ATF_VERSION_1,
 		       ATF_EP_NON_SECURE);
 
-	/* BL33 expects to receive the primary CPU MPID (through x0) */
-	bl33_ep_info->args.arg0 = 0xffff & read_mpidr();
+	bl2_plat_set_bl33_args(bl33_ep_info);
 	bl33_ep_info->pc = bl33_entry;
 	bl33_ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
 				     DISABLE_ALL_EXCEPTIONS);
@@ -162,8 +184,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2_default(ulong bl32_entry,
 	SET_PARAM_HEAD(bl_params_node->ep_info, ATF_PARAM_EP,
 		       ATF_VERSION_2, ATF_EP_NON_SECURE);
 
-	/* BL33 expects to receive the primary CPU MPID (through x0) */
-	bl_params_node->ep_info->args.arg0 = 0xffff & read_mpidr();
+	bl2_plat_set_bl33_args(bl_params_node->ep_info);
 	bl_params_node->ep_info->pc = bl33_entry;
 	bl_params_node->ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
 						DISABLE_ALL_EXCEPTIONS);

-- 
2.53.0

