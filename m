Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD43606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NM+REEhz;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=z3wZsM9I
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0FE781948;
	Thu, 12 Nov 2026 21:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 41_8Ji37Jmqd; Thu, 12 Nov 2026 21:56:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2ED4781926
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794520571;
	b=EcrrdJoS6FNkp5OlEUOJp7bicdj6NzkYndoOKClsqFeFeH54PC184GtF2LmIV8WaXYuu
	 AaNmalFUghAUBzEwsRNae6Ao5Ja5cKhlfLBwNzzulSMrQvpu6h/NIzK0WvswZCg854R3/
	 XGq1jHtRSuTssm1Ud2RWSyOyvCMFs5r7PDFXNeBDR/73pHYvzZO6wNxrTc/j9X7+rJ9tp
	 4oi5VMZmJZvHn+WlOslT/e/LJvyAIm4g15TOBPVL9eI6v6qD+ChDd74cGcXBxYrpBVuNm
	 QatfW3Fyy5oAEhHagzar0/7qCRghW5R99+F4b3ZcFHBDsCPe3i2M8UcUB/vbvAZEtEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794520571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IqKKF4gC9p67s1OPe3FImY0pKyMdQhCOcn68Xar7v5Q=;
	b=rCXkd8DO6WvZX1jwreXMeYIdNdrqTWPH4CqfNydQbFCqpXmMC/tMtk55baeBrlwisH5N
	 F3C0I6BXD75oiRTBRkhtfUZJo5e3+ZKRvuvNSeakD8zFwVB6ZvOszO9BAmXQtpMDEqVw5
	 0d0K0pY9D/wW9o/n1P4031wcxbbHu8qLthMf43eGn26+LepBCCGhzi2UpLlpEVodb4nvk
	 ppbKSv9D9AWkxkqnPEdKisDAWBScZpsviG6pryTCiGOOyM1/sg6ucha+5xZXc5OGmPeeg
	 xYy3v51BPDOfgSxbynIVbojCAmzPKm0aSpidNqETw3FtceV1FNfPxaCWpbUel3IAHag==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794520571;
	bh=IqKKF4gC9p67s1OPe3FImY0pKyMdQhCOcn68Xar7v5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NM+REEhz+Do0wQ0ZUGcEYTJ9se++bVGe2iCadT4TQuKEYTh/lSN7ij/HGs2rR3KDL
	 nwYwjAoCfcXyhCFbOJA5psgNK4ErAnToZyc9K1J1VUH7y+CjxiJElVrSj/AqFkbLRI
	 pWWdU00e4hYBn5BMEdB76UMBFsM1fczwfQKIYVL6K2siLkVDZQI8NIIVFsVqTfvx+6
	 mbr9bc0/19+10uesf8qXuUGmGU5kFH3v22SjMvPw1eU1UpKilrE3r+Cw9M1/aEcQT2
	 0Cs9j1n5Vd904sp6buiGaMW/+dwyjdHgGJnXwmtDnRlrDcjzN0bWBWZnYZigocYL3n
	 NfZGtYGen2I4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ED4781926;
	Thu, 12 Nov 2026 21:56:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 755E6F46
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A92340735
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:56:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WtpS4yj4Goju for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:56:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 83FFD405AA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::833"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=z3wZsM9I
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83FFD405AA
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:56:05 +0000 (UTC)
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-5351d76e1baso5066021cf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794520564; x=1795125364;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IqKKF4gC9p67s1OPe3FImY0pKyMdQhCOcn68Xar7v5Q=;
 b=z3wZsM9If4Cv7Idze7jsbj1sTlosHDsfOE3+pRV6JECJzkMfCX1iyrMY3dKkohSXHY
 O6FK9PmJDVUMkfCZPMyEMNlpO48qfGcxYrU1iKsKwAeRhPHciGx+96qZk1a3ApcENUKp
 f/JkHs9YS54RtdUjAYQ6swJoVOeJZsfPRSwsAjFI3eGQlJ22GdAXtYx51iA3pXPBj5wm
 7wV2z/d4hxiMchctgw1Du/ApI9pqIRSvUauyAMJF1sh1Rw1KjkQgNkSkFHJRDrr0hijp
 Pn4cJSdH8NqPzFksrx+kGXr87mpNTm2wjCqPY+s7hByFVlw5GvYqfXJEMPl4SR0Yel2Y
 lLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794520564; x=1795125364;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IqKKF4gC9p67s1OPe3FImY0pKyMdQhCOcn68Xar7v5Q=;
 b=KtkgzBuVXismg73FQBVsYh2c6vv/CLKGnyhbud7aO7CoMbU1ajCub7DZyXMjW76xsc
 rd49Ktz2qAK6YiIbF0t5NH98YL+yYiNQmbT2hbXeochb9b7wM+sF5LToczolcMJZV+pv
 r4+Uy/qHDdeisvxgvjAVHjR1BOuYHRO0ndSvOJLCqQIFox9xXQ0m1ftZkvW2LBIegvmm
 em/MQnESH6bP0Z8mAcBHCTMeezHQkbMJqpqxAj89B/f7+u53u2ZUD8lPzKeXrV09h33M
 gbtmC2vK1XkF4R4KziG5rVYT6q2+7TFAwtCmhbtu4R01IYv+gZjf7ga4czS+hRgydo0M
 gt9w==
X-Gm-Message-State: APuU4Z8e/NXhFU+i48ObT5uMDJyLUYV/wAYxa4twE1EzvMlhKpUBWYxE
 76bdLj9t19Ivodx7XTKmaPnzfWzYC3iiPOsIdj1vWHAxCveKGAgkOko9d+1raf8th1thXQcUgGh
 SUs28qHo=
X-Gm-Gg: AYBFou3uTe6bhh1isjeaSus7Muu+fDmxCOGKNi8o/9i/IlksRsqd6tY/kF06UAGz4ku
 3Nqqx+k2DRpnitlc0/ArMUBtwNsFu6Oh11vexL7VUlSMn/xpkl+f7Nfkw25y6qSDLBpxq4b3n3s
 +pLNYK+HL2mvpM7UkQpQ29Y9QwYxU7F5fLNPsAqcUH7pE0T4Opnxa1zWK++xUoOYYAkXMi8G2uk
 8ZyBG4GY//u/zP4xKEDZMHWyUPe31kY9pJNr+vYTgHGRAqf+fE13bR7lw3X3r/TQghkLDcatisC
 +gugW5OdipplRgXelBvl/Mz1S7vYhawexy9qar2zyI4BCDy/Ht+yZFlL/c/hC4hW1GfyLZUDk1s
 X/DazfYdRoOjlo5C/Yau/Yx3ZW1pLf1eXhnMoqh4qpC9rd+0VsADQjlrWMFso/L8aYsVjo7DToF
 lU1I3YwuiPmPkkckhNUHgiZ0ZeFvDYomC1d6sGlcupzmMVXp0yUjQcYvDsax0RDUZWelura7b/8
 NXYn8sVOG3SRV9II5vhPFN66WsAvQtNTUCG8mhAlywto79QgNdueWNQIWYGbq61dSzMDWAU5nTS
 npEbYYtiYK3DQqk76PkD+V+Rjhtho0nPDzu5V8Tvi50IUuxp3ISbkN1L7E00eMiawmy18k2kTI3
 S3UKlSujaD1pdxVuoNGYbjyokK6TXUE1D8W6BVFV38cVEjof9J8zKHu6zghSO
X-Received: by 2002:a05:622a:1b86:b0:536:6fc4:41fe with SMTP id
 d75a77b69052e-55956e5d987mr68154061cf.29.1794520563750; 
 Thu, 12 Nov 2026 13:56:03 -0800 (PST)
Received: from maple.netwinder.org ([204.244.107.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23d70489sm5661676d6.21.2026.11.12.13.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:56:03 -0800 (PST)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Thu, 12 Nov 2026 16:55:47 -0500
Subject: [PATCH v4 2/2] doc: CONTRIBUTE: minor spelling and link
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-doc-sending-patches-v4-2-d6f4b7e3eeba@linaro.org>
References: <20261112-doc-sending-patches-v4-0-d6f4b7e3eeba@linaro.org>
In-Reply-To: <20261112-doc-sending-patches-v4-0-d6f4b7e3eeba@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1794520561; l=1247;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=EL5eh6dZfEB3w3JrP4TzOjH8mY2tkkiBOqTE056yvJc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFnTrUSsQM2VqM6fMmzPm3HB+isx8Ob9rd6FBHaA51l5Yb8ALfwGgFr+qzxgZWtgUHC+DJMkl9X
 0ax+P2Ne4YAk=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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

Two minor fixes:
- standardize the spelling of "self-contained" to include the dash.
- add a link to develop/sending_patches.rst

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 doc/CONTRIBUTE.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
index e38b1875a70..956cf546fec 100644
--- a/doc/CONTRIBUTE.rst
+++ b/doc/CONTRIBUTE.rst
@@ -59,7 +59,7 @@ Patch Series
 
 Patch series for a specific subject are welcome but they should be constrained
 to a single topic with a cover letter outlining the intention of the series.
-Each patch within the series should cover a single change, be self contained,
+Each patch within the series should cover a single change, be self-contained,
 not break the build or cause a regression.
 
 Generally bug fixes for existing bugs should be at the beginning of the
@@ -70,6 +70,8 @@ to review previous versions of the series and incorporate all the review
 feedback before sending a new version. A week between larger patch sets is
 considered as reasonable amount of time.
 
+Additional tips can be found in :doc:`develop/sending_patches`.
+
 Development Branches
 --------------------
 

-- 
2.55.0

