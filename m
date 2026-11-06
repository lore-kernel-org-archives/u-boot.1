Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64E606A32F
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OPyM3EG7;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Ch48zCOs
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FCDC81330;
	Fri,  6 Nov 2026 17:52:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fs3l4CzqbiYH; Fri,  6 Nov 2026 17:52:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AFC3E8132B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793987577;
	b=puWOBWgP4lxYAMvXfw+5F9O1HzM2GCe7PLhl3A3zW7/Kwxki+/esHmK+UmIdEKQ2Doer
	 rADB/WFMNkoAj3bkuRz+COQz25LFvheMXBrqM+koR70XRRq+G4PwGPWYOQhCeN1kkLvie
	 6Xq8Kf7s0bRIljRtfUKifBtpdtO1NdAOKhA/H6bb8dfA2CX5yxxH9r+pGq3H8rcoaXL/N
	 gqzcn2XD93OIcl+iabW+ozjGPBMZ9GJyeY9YbwSZplc+Yc5CAExW/exwFBV9tjfouH5LV
	 7THiMhfBI+MpEBsCpfoPov81nYCajNT2D1qFtKlDSnVu215ILJc7FxoOUf3ue9nCZQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793987577;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1a2cnt/SLjGKEkm/YaplY1YcbtGsiLZ+z4mm0cgH0Qo=;
	b=ro0NO2tLLz5f1w0TqO4QpsF0tVZcPkGoq+JWyxedNpnDTh1Ksd5TWtIKup9qcGtOlSzx
	 y69IaymYlBS2IrzsXAmKfg1GmfbVz0HiUHs4UPgDYkMd4rJ/f+2LgGHAV5avkVu9Hekma
	 jkOkqP+v/N0UIH7+d3ZlzeaaTsSiyAAOgkGP//pQav4ENiZB/gbPKHYrf9WWeUuAeq0LS
	 0THaqbR2aszAPD+IxkZRjyKPbS//YFE23ZKKDxN22Tpd5MJZJdKlzYctBckcncrInaDeH
	 KIckEBt4BxYoY13jzUiyFBxJk69IrEsARZEGnKXluJSrv2rNHh7zYRC+cG1g9Mh6LbA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793987577;
	bh=1a2cnt/SLjGKEkm/YaplY1YcbtGsiLZ+z4mm0cgH0Qo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OPyM3EG7s7Y5PluF1C1pANVjnWPEy3gL7H/rjPljT6EsiI1TEsk5ySINoijZLkLk3
	 0smwWdk6P/yMlfPfv1aCLQxnuep8lRhKFxCxVFkzNolFIHVMSE55bRxdNtQvfKN6tv
	 sj2nIbqqUUftepMFJbXdCwX/GcVcSZiGhOp+4MLe67trXHYs1fWtzOTZiDITl87Epp
	 YdgUZ2WGip6lizv3zgZXKh7wkyveH7D+Ijck1CDFsISaVjLHYs6iUmoSHzlCKc+KOd
	 FQDHq281MhZnnkapm9Samxg2HsRfqBbvVBDBARWAGwj+lcgZ1aPjRaIyDzIt2CPIcU
	 hXiYhyN9L+7Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFC3E8132B;
	Fri,  6 Nov 2026 17:52:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7069734D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:52:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55D7740956
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:52:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pdj2Exho7Qb8 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 17:52:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D405A40944
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::735"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::735; helo=mail-qk1-x735.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Ch48zCOs
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D405A40944
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:52:54 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-93cb9e9405fso53826685a.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793987573; x=1794592373;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1a2cnt/SLjGKEkm/YaplY1YcbtGsiLZ+z4mm0cgH0Qo=;
 b=Ch48zCOsabgIIa3i5pe/moVnHezBvFwR0Uwc3CqkxybAq1SVVmsans86TN/VAAAFZD
 myERYW1ezdB9uwoO48ER4luCm+VY74VOgVWj0OWlE1YEuEpQp88JG1ggJom+achayn+Y
 7WDrVvQO6BKfzZVDuekKVUHgtNJh5ODG7/rZzMXv+wiCSX1lFZ7TYRBXbFlM5fjwV7EO
 4QSlz8hRfSXjYj+0r4iXTmsxcMTNudm+PtqWF2AJf8f2v9YlDTExxsBqW7tEoeWswCym
 gVWeLfClNtMYHqGohoVhmG8VSmRcJIMYsi6slCon/iFWOLR8hxOUM2eEPyRMnd9hzH6x
 ndSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793987573; x=1794592373;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1a2cnt/SLjGKEkm/YaplY1YcbtGsiLZ+z4mm0cgH0Qo=;
 b=FZJ2xI6kTE7wYf5mq0R5BfFSCy6X/sY2t2JMmJzGiMsdWjeHCzR3QayWfeHKr9zi+s
 j6Jy3w5+TCg2deH1OHW6gGrQ/xPGrJT0Si+QvFfbSRBuxgkHYornUNk+rQmlcK83G2vF
 Zf7lwbs7keUbDn1Ivb6UKwaL2Wg1qvsIXzjcSQ8kA+sdPfFqpqF5vHGhfOOC6HqBxfzH
 Y2rd4yPLsDuyGt29Ij4r+IBuY7HFLzc36mH8SttRVZOZH8jlBJdpEpgwBG+JqAXR9gjQ
 0G1MT4sSJDVyrbbnGKSNdxp/+9FB2lAb3V5abVR2RZmgyct/ago8ToYyhDhcdfT5c5fS
 TIcg==
X-Gm-Message-State: APuU4Z//yOtF4kchrvhi41gzTfLwKe56Wnmt0w9SoAgc8gmlYxnHiCHO
 8a43tK+3RghFmmo0B0vWAU+jGCrErXFCzC+kYDe2o+QIDbUyNJjvCKQruj0W/mPdrYE=
X-Gm-Gg: AYBFou0kt3Vn4+T4syiba4WRjRjqsMLxtEnNRJmpZ1dvb8gf4z6kPrr8nJuLKYW6Srj
 p4ffp4/oy32s55cx2BHcq2NfoG3p2wQJjCDKCxsu13z8ACJR5UQoaWvpRdHgcHHgDXX5bbSLd5k
 pj0REnA5nUlGlQ/04ZgBNemXqxhsQ80Ln9baAG15j/9EMbh4gqWtqUdx804COiFml/ziWOf9/PT
 xxFqNR40PT+7/b5BKCejEhqfPPEBaT6Twl+cBJCYWZ514dnPTg4a1rOKofdVDnZGIyWDmG+ZQxj
 W1v2dvdkA5VREycjpSuuzJsGtQx6HF8ioRC/LyN2MENpPnrrCA0RKuPIYY2Y5e2R5DNwSFUApCh
 SzHhlJLk1mY5MydTSmqHzQ9A+rxavGhXRABBvHxgwJiXAXSAnuraC3SL+XBTjfo/jJTz5DKtbQH
 2vsz7fhRJuYcC1LrJF2Bl+H2HKsY7n7dg8iKqg+ZizcMayBKSDm0KAPF5/hdM3JnYAP/WJ63wQO
 Ho/0viiKJVqxL29ftRO3jI4Pw1lgNBhzjP/HxNVxDdksc0ea/6o1lvcCjTm+LlsElye2jm7jggT
 NFy57isnSbpd75syoqAafFzor0p2VU+INPDNSF7FGGnPd9/n75tWl0y5pmLY8Id9/GABjO/H74z
 st1quTJYJD8I3pMF+76+KtIe4X2Libx38d8idfeNunFNPIy4QoCemL3tOn5WwgfB6p3PNw/oJgD
 UgJb74wA==
X-Received: by 2002:a05:620a:28cb:b0:93c:62c4:e2e2 with SMTP id
 af79cd13be357-945f32cfd3dmr473552485a.12.1793987573103; 
 Fri, 06 Nov 2026 09:52:53 -0800 (PST)
Received: from maple.netwinder.org ([204.244.107.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945f5be26f5sm195053685a.28.2026.11.06.09.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:52:52 -0800 (PST)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 06 Nov 2026 12:52:46 -0500
Subject: [PATCH v3] doc: develop/sending_patches: add tips for series
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-doc-sending-patches-v3-1-86fa7d158cc2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO0T7moC/32N0QrCIBhGX2V4naFu2NZV7xFdOP3d/ggduqQYe
 /d0XUQQXR74vnMWEiEgRHKsFhIgYUTvMtS7iuhRuQEomsxEMCE5Ey01XtMIzqAb6KRmPUKkpla
 NbCxY27UkP6cAFh+b9Xx5c7z3V9BzUZXFiHH24bllEy+7/4XEKadS9szyXhykgdMNnQp+78NAS
 iKJj4Sz5rdEZIlmqmPWSs2a7kuyrusLYhLBGA4BAAA=
X-Change-ID: 20261028-doc-sending-patches-d3a464feff98
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, E Shattow <e@freeshell.de>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1793987571; l=2659;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=CFiVeF4EAC44IRBtVyBdoGmaizoOoQQHbDQSKZeLV/0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOKAdo0j9+5f9TqfJwZNFe0mm/6E4jnWXyKKd8YSbOmoQRUmGgLhmpqljSqRu5kvNG83NbSwCYg
 y03oe91t0VQY=
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

Related patches can be grouped into a "patch series". Add some tips on
how to decide how much belongs into a "patch series".

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
Reviewed-by: E Shattow <e@freeshell.de>
--
Changes for v3:
- explicitly mention keeping bug fixes separate from other changes
- focus on "keep it small" rather than the exceptions to that rule
- Link to v2: https://patch.msgid.link/20261104-doc-sending-patches-v2-1-c0a90ff6c049@linaro.org

Changes for v2:
- small wording changes to help non-native English speakers
- add R-b

Link to v1:
https://patch.msgid.link/20261028-doc-sending-patches-v1-1-66b0f1b276de@linaro.org

---
 doc/develop/sending_patches.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
index 99581dc0ba0..b6096cd346f 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -184,6 +184,31 @@ General Patch Submission Rules
   cases, you did something wrong if your patch exceeds this limit. Think again
   if you should not split it into separate logical parts.
 
+Tips for creating patch series
+------------------------------
+
+A series of related patches can be sent as a "patch series", as described
+above. Individual patches should be small and self contained. Likewise,
+this also applies to each "patch series". Keep the following in mind:
+
+* large series are harder to review. Maintainers are busy and may postpone
+  large reviews, whereas smaller reviews are more easily accommodated.
+
+* bug fixes should not be part of a larger series, so that the fixes can
+  get reviewed and merged quickly.
+
+* tools like ``b4`` and ``patman`` send the entire patch series to all
+  reviewers, even though individual reviews may only care about some parts.
+  Filtering out the relevant parts takes time away from actual reviews.
+
+Therefore large series should be broken int smaller sub-series, for example by
+subsystem (clock, pinctrl, reset, etc.). This allows better targeting of only
+the relevant reviewers for each sub-series. Finding the right granularity can
+be difficult, but when in doubt, aim for smaller changes.
+
+Overall, the goal is to make changes easily understood by reviewers, as well
+as the next person who works on the code.
+
 Attributing Code, Copyrights, Signing
 -------------------------------------
 

---
base-commit: 709a97a05df66e394f40d249105d0baade46f107
change-id: 20261028-doc-sending-patches-d3a464feff98

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

