Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526A606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IdkNiWth;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cWj91MMn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 044B76071C;
	Thu, 12 Nov 2026 21:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SHWOSvVUHbV7; Thu, 12 Nov 2026 21:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0FC21606D4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794520569;
	b=Digbfji5yf7stbwoOzc0tqyTuCCpoHBQhz33kw263X3SVIMjAuxYm97RcgcMtr+hTBMl
	 2zC2wY6p/bG3rACW3Hqj4+gd9GJEStU6P8GrjYPdeReoIq+xN052cEF7P87PqXigvnZLP
	 0r54SSvFGExWpJNYtmwe4OB4hxdTyPYvEsfCKYAYDZ2x39v2My9EPN8GnyXDdL4yPv6lY
	 vpUPfb87gruIJVJHLMBvEAq2bXpwYo9uM0UC1TQhCmACnckN6127ooM7g7HNqDCzbfEca
	 AJc/esOQgV53CUaBGhO7dbAqisS7B6uvVjaYO62tziy7KvL4HM/TxQWnWZv2uKarpMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794520569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jT+tm5T8lAlfRAGw5YoNt2GUNggYVUgSXihEh0Qu+qc=;
	b=ja8+VYQGz952QfXAFM1MP92klVrnEIUW1EgDty7K2UoCZ+Oea7mtEbVGgduUQbC684ag
	 kwP9aUWUPFO0DaJlHAct0BjII2f7VleeulE35XODJJpPaIJQoFlbY6B5JuOY3F2Icwa7q
	 tlwm25lq3aTjMKtP7wzi9n9hVfWFWyRSyUVpmUqxJ9CEjyphEmWEg8dTjshlZj8GCP8Gr
	 4cT8JUbYf7aWGN/q8RoOIBacYMpZEtdqRJKGIVJK2Zd53zrgHneqS4ubecgsyTWdHGEYA
	 SvV/vtreDuuKGUtNl8bf7BS+effXF6EIqg3FJqVKbeXEXV7kbrRKPWhQIwr6cKBCLyQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=cWj91MMn;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794520569;
	bh=jT+tm5T8lAlfRAGw5YoNt2GUNggYVUgSXihEh0Qu+qc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IdkNiWthvg6BEknS1Nwnj15sPfEKeLySj/qL76yrjMthGTJ4qBdcKT6CdDtTN+Oy0
	 twTUH3etJ8fJEY+Ne/jsKXxWKU8cNu/yGwcE7hy9sYz02bYJPkQS07rAXy4yEKGewc
	 G4vd8rgppR8tSoUT/X4h4JQo7uFB09zp4TtCY02WI+NrcUsCUCyPO295qn0kDBEUqV
	 W7WAPDof8pK/Vufe0/DAx60Lr2o2wQmGwAwfsnt7Z7hU5GroIdouZMd+xIgk0smDrQ
	 3+i9nls5GrrRDw7gRbbVVFldVZRkQwBBOutq8J2LKg1FM1eRrVJca3GzQO64JETWDC
	 eQbZeqcQfoFvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FC21606D4;
	Thu, 12 Nov 2026 21:56:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FE6A1790
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 01110606D4
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:56:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R0Ra2WX-aiaV for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:56:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF2546066D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=cWj91MMn
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF2546066D
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:56:04 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-91f1324a134so3791876d6.0
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794520563; x=1795125363;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jT+tm5T8lAlfRAGw5YoNt2GUNggYVUgSXihEh0Qu+qc=;
 b=cWj91MMnSeM7v1DaupYsq1s5klEp0eYUzMqYCPozqISPDjr6JGzad5DsVnOirqZcYH
 AuOfb5Kc9wEse9bsgun6+S4SwC03v2dCSW0Pso3wDVTfBE4PJUTTITNWTzasWKj0BmCI
 QGABKhd23AqXjUdC+x9ZPnAqSXldc/nwIK+fYMBHaJwN2JGRcUWoJQwyn6Ld5WEuAqUv
 pOPRcECDfcpHcrNsvApvZ0tgpsC+tWd2WsAfIae2+6ySaJHQiLBcQFXt9VC1OyB8MFkh
 fTJhF9MEMkHsswTTw6T4qgrcHYvQ30R3j5UqSGPM1erhzSDdCamszslqMvbau9wbWdOA
 kGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794520563; x=1795125363;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jT+tm5T8lAlfRAGw5YoNt2GUNggYVUgSXihEh0Qu+qc=;
 b=FGfEMd1iFoxgTMtaNQPqO9/YdLVjxAKQfwJj4wGh2rcSyB/ouElLQJDSLOHP4Gl1Mg
 W8ETrB3WfE+lF2Tzd5GUh3TrLXAU+r7VNed0SMY6ua9aSGs44U4MgtsZJZMKexLqLPiA
 Drp+mVXakpcHY9TK5qA5c38LRwqoG4qpE71GrTXbwDdG31r3rMLgs7b2kyqJgj/d0MCu
 JqLqi+iwjA43njaYZp4hI680aakDfTv1p/X/mmb2qDUQrWbMbWOyQcYTSWcCKhI0Mgjm
 Tpa3EfkxElWsR6vpSU6r0a8iuW+aVIv24inVl7bIMSobO8kdZX8onHjF09T1zq7XK+fW
 m3xA==
X-Gm-Message-State: APuU4Z9DzzckCDp8G9800dUe8+Tn9OgBPBTTP8ZlRz+/n21RNAzzNNFn
 JD4Yv2MFbN59FCwgyksBwlcQiev4RQX9cYALEgTLuGusAssTf9YSb0I4msfCeGgAiSh0rdizXMU
 aeYpurUw=
X-Gm-Gg: AYBFou2rUJTLzIIeEbOkiuSGhLamTzDbxDg5N+Ih3PuitCGvev/IJya/zq7VCb8GYFR
 OrIxgK4gKPi2b56TOH5Hy0fJ+aqP9por2Zf7R3KixkdidohOC05+hqZFaRU1+BRlA+IyPJIkSiA
 25USvsd8qtMlBEjU8uYP4LWX/89+OZdDHjwHYvvSksH2s8b9fbzAcRQDSvojlHnG6qdCV6qzt1Q
 11VVcFBbX8w0CfnKSie4q9iwQJSREhD7bQvw/zYb5YDwMTQb9BQ9ez0HRRw38AWpudmyBzYue12
 6t+Hbzksd7731KFfpNvgR4/+rhUF4ifsL4uK9wVX4NVF6A+MxWr+5LTkl/4X/rgEmgEcmmVkqL+
 LsYwrDIa1QLhwjaaDBy1VbguTu2nOlrGEwZb9LEF6Kv8pSf71kJwT24EcWlamkRfR2C4yw8tOJX
 v5VA2LmkBUp3QrDk6i1BAxItumD/4TzfLiL72DvB9Fre/tpQnB8k9Qavo1UKKLzUYPzRlDJhPhR
 NDrfSExd80nxn8J4SIUrnA3mtPJLxCL/9qjM1i3o7gH2d6VDwuw+HeuU+RiVEg+wVXm05UTVdwr
 ciTIzfMLvdyoztT+iuBbv2lz2h82UxRxibRw8WMqUIsGanoC0EJdsVMedeY/Y3QZNqpV0IyeJIm
 k53mal+d3xzM8d9PPYfXdiejOZDpPVayr19klFJSXYBbzRPTMLB9N3pkMBrmUZUp2FN3UvyYaJX
 R0jnptugM=
X-Received: by 2002:a05:6214:598f:b0:91c:7c57:728d with SMTP id
 6a1803df08f44-91f24225cffmr12374516d6.37.1794520563002; 
 Thu, 12 Nov 2026 13:56:03 -0800 (PST)
Received: from maple.netwinder.org ([204.244.107.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23d70489sm5661676d6.21.2026.11.12.13.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:56:02 -0800 (PST)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Thu, 12 Nov 2026 16:55:46 -0500
Subject: [PATCH v4 1/2] doc: develop/sending_patches: add tips for series
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-doc-sending-patches-v4-1-d6f4b7e3eeba@linaro.org>
References: <20261112-doc-sending-patches-v4-0-d6f4b7e3eeba@linaro.org>
In-Reply-To: <20261112-doc-sending-patches-v4-0-d6f4b7e3eeba@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, E Shattow <e@freeshell.de>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1794520561; l=2694;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=+gvBJ2wB7PkmEhupykOQ5QhWV+joNV0lHW9RI+4NWj0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAgvpfRhazzy20QGkafW36vP8dnHch5pUvx6I87WKLkFojLmNYwjAC93zU6TERDmIk/dMLF1JAW
 YAWjxaGlMXwY=
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
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
--
Changes for v4:
- spelling fixes
- add R-b
- Line to v3: https://patch.msgid.link/20261106-doc-sending-patches-v3-1-86fa7d158cc2@linaro.org

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
index 99581dc0ba0..dd06d4a8968 100644
--- a/doc/develop/sending_patches.rst
+++ b/doc/develop/sending_patches.rst
@@ -184,6 +184,31 @@ General Patch Submission Rules
   cases, you did something wrong if your patch exceeds this limit. Think again
   if you should not split it into separate logical parts.
 
+Tips for creating patch series
+------------------------------
+
+A series of related patches can be sent as a "patch series", as described
+above. Individual patches should be small and self-contained. Likewise,
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
+Therefore large series should be broken into smaller sub-series, for example by
+subsystem (clock, pinctrl, reset, etc.). This allows better targeting of only
+the relevant reviewers for each sub-series. Finding the right granularity can
+be difficult, but when in doubt, aim for smaller changes.
+
+Overall, the goal is to make changes easily understood by reviewers, as well
+as the next person who works on the code.
+
 Attributing Code, Copyrights, Signing
 -------------------------------------
 

-- 
2.55.0

