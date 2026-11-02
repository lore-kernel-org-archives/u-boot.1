Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820EF606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BYhZtDmu;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BMn9BLSG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 165F060600;
	Mon,  2 Nov 2026 09:58:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h1pwyo05f8Pd; Mon,  2 Nov 2026 09:58:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 58D2F6076C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613524;
	b=MSJ27Gt0yOSWlbEsTOctA52rfUOubbc8dRVkXWX6p84caTiIdN+6hKeXxwRiIG32UnrA
	 96uoZxygtB4vT8J+43+hulO+Kv608Wu9Kv239gy0DSMPGFrQWdz0urqChV9Z1wo+R1Bzb
	 QdYRjabndxyg/r6XJB8hDbe3SqpxYskjD2mr8+zwa7Me77wHemX7RUFvzlm9SCK8iPRbS
	 OtjvExuuO7U8M2JqrSM4G3ctOFjLRbkfw3/yMTyfKvnK1c5zmKsoK0jCPxbd20E4su8AH
	 l3ph6ZrOrih9mmwiDcXjdAH7YUnRqOxm3oRGHgGcc05ffhOEsB5ZbF7kDDG9L5xPsiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nUiyuyzkWWK0lUtqjzr6STYu18sZ8QPgv0LgN0+CLGE=;
	b=Bc3sysuhUl5WqD+dFYGPTBTvp/nDqid8ARKT5KyMI+yALyFtMx4mzOQF5jYV/BAywLs/
	 hXWCbsL9zmd/dnDw1ovi8Y5+qLa58aq08DHugzH/y/F62UedA5M0Vdm9bX7VxvA/2a8pg
	 hPzJ314oeHB/WcquTTEWq7uWTEnABzPZJigG2CpJ8ThAKpi6YMyM3pHStOlZ2mPqyHUa5
	 woHgwsi4LifWN8FNIjZKU51MtBdB9528TIlw0w7NQscKGyurfybUJtNAzY43dvO0n8W2n
	 X7VVp2Rm7N0dr+eQ6F/wE3ZJzYfZo2EuqMJck4CsPBuisnTu+0zYH4pI/GB2dHg7aAg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793613524;
	bh=nUiyuyzkWWK0lUtqjzr6STYu18sZ8QPgv0LgN0+CLGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BYhZtDmucI96aPqo6+bkEK5Zvb6H8hRgo0AAwHInRS1ymKH/1VFUOGkDXzfKzk7j3
	 pI0q2RPoFLFWIaX9do3ZCfOgbL4W8d8IW8mDfTcN640mM08LZnKqIFCvJcEv6muodY
	 DH4Cqbbu4m1fBc7kFogIqXfunPDKMlu9zZnM9KlqtA0t7Wbp5/TyFO5x3D8lQKBib0
	 ic9DW0vcLadkIZSl4obP083seWt6rQZEQQfoO2xqjIzie3X07rJbc/cxFV/8YebjxD
	 mNlkwPlNvi5kH07pN76ON3KkQytkNt7FFtzayxmWftWo/6uHS31bwpGIWz3tXEUqng
	 4LaGliTV/Mn3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58D2F6076C;
	Mon,  2 Nov 2026 09:58:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 55C2B4BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C65F406DE
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5uN6yuTGfh0V for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 48D5E4066C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793613520;
 b=DyBzwW+UQBlD3WaKe8FhkAly1Edy5g76EXV+klDoJk4bZU6uGs6Eq6/1EIhJtkwJfLy2
 //VVw/fD048zQaT3GTdeJGdUyrn8ydGkeP6Sq6A/hHyFbbzTl5r2QnnXKSTDXzYn4xT90
 tnXc2oy4RdMebStPVajeafa+ojarxfBnKRmXbwimJz/GgweMryp9EblGLts/stkMiarlJ
 X2Z2Okvhok5SXm5AMEoLu7HQ5MehH7O0r0Ryu6o4gg5Z/v59cBlJHwvm7uefLWZ5jiE3p
 TYJuDLScZ3+sxkLTCvyQZE2XjgcQ6xSZlmZRdt0eH2SVwlclQqdeOXny06x6K35RDKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793613520;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=nUiyuyzkWWK0lUtqjzr6STYu18sZ8QPgv0LgN0+CLGE=;
 b=IjTC5eLX9OYZ0Gt7U4Ni7ui2bAJ4MmR9ow4yUi53mGWakMauw0USxbASMJ/C9r6fBAbt
 6x8b5z/6irtYVTIW2AylpdUpTEHEdAqAcpZrir8xxjJ+IXS7a99pwQGk+ok6PeEtKbn4m
 fvUOjNsN4/TmzvKSzHQ/OKx1Iomj/VpZRqKwbbK1avKTomvn9LtMik1h2ruXszUPCIh3J
 +M9jHeaseN6RGi3wWkMlbCHxCgYuoRhK8hn3aLtu3QtcuMV0ITyasb1FvOuukQ6pEHtUB
 ldtysy52I/R97EUYoraVtkezfPGdw3DrIDhyAfz2J8jsGuyRmENm1CdKeyA/xLcIQxA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=BMn9BLSG; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=BMn9BLSG
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48D5E4066C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:39 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so22604015e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 01:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793613518; x=1794218318;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nUiyuyzkWWK0lUtqjzr6STYu18sZ8QPgv0LgN0+CLGE=;
 b=BMn9BLSGeZDer/M3gcJoNTU+BWfzwYJNacUUEg6KnBkdyr5NTdJvLWeJiPTkert1J1
 hIeE8k/3WDOPuxAVgHH9ettOHVVg3hqedRnBoZkwJssucAKHlvepdUQWw8SxrSAoE2vq
 c5DRfFGTQDF2bS6fy2U9Lq2LRwD1zTRMja6rCKlKap/jdBs41YsCeV02WaRmcBtanqW7
 s6tleTQU0zrpveHM000jj7Ra+Cj4ZIPpSc9MQbThuzvPv/HODiJLyinAv+h+myCEWOuu
 jVqU3sy394K8zWY1e5AiniVmUuVeNHEnab7KQmA+9GZzsB1tjRWjWq34CRuXA1jkg4YL
 Q3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613518; x=1794218318;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nUiyuyzkWWK0lUtqjzr6STYu18sZ8QPgv0LgN0+CLGE=;
 b=srf/wmibascgxO2VXTIGOkOuJPOb09WN7TMlWvXHQH+IaptyynGZx3t5Pe32z1iGKP
 zFo9UnKHbmPn94YpXfXcCzde6q6Agr/kwVRSITlW+FRv/AoWP8ReJtDKEQQEAZJ2hu/c
 1DL6Yol0qlhR8vyrO22oHIfzepAj2HFdK7Z0yWHpmHl6wziQHAhhANQrfIOCeLnolMRF
 rH0Vns7O2ZLFaBzQtgStdpQmMWsoIcifagRhYHhfoBdOHEly/Hz3WR9KWJja50AGfvJo
 q7kUhpXGHI73xn3u0feCQPK0cVMVOMqUeEo6n53ZpAln6rEGrkzaNMGR+xex8eVqRTQf
 g8OA==
X-Gm-Message-State: AFq9FYIq+7Z+x4iAtA0ASz2lP9CEECiazHCY1B4DgwAK/f1goNLuXGg/
 bCespPMx087it/CxckU/CIDSfz/Jt6wvIT/gGKw1eUx+a89KiiqB0JwOUrnY9+SKDLw=
X-Gm-Gg: AYBFou0+gsKa2FKCkWx8begC7ftJt99VefnFxJstonsNphzlB5W65u9h4SfAntUjgvW
 qqBWdg9xKANJ7yBRgW8XYrqIjiO77TTe769Nb8Psmhnh/rL2Jb2fy9lS7WIdAOWYhx3mUo+PC6n
 4GNCljTFrN3F1hJJnno2v7hoX9haAwj3ojia29qLCEh9Mk/UF0ZMFO/wtTBIwER8dbxr8jQ2UQa
 EaiExpf/ofQs5aWrn24ibPpOgSA1qdDYNnPQ72yArQgUh6J6p4vCk4bQX7lWUDMxl4YWEZ2zLaE
 tkajDgXNINLT6gRhYi8/m0YeQSLZ+EXATuf0yHuJuYDcH4Qc1TRWaMmL3uU64Vwt0KwEBJF9oGs
 LKN4fYuFJGr34JsDWnZJwGr6DtXeTM+m4mLv0ehS3q/9IKvyQ5BCOEAIjnv/SSV1iESnebmtA9h
 vR8dwVpFtLiLWz+4LhrUaMB22wUeyyrzdbQkTPkbolVVQfmBGR7DNiwPfbThqVJt1Jw8nadSHdv
 RaboOc+EsDMtC5WoNJSlo2u7QIYWWPP0vtBtjvCYpn7qfuLrTuSq+74QxAbPo0BwJf0pN7ZNBy5
 wgCl+3RQRS9hoACXXoTzbsH2rENLF+G7KGKLpQ628L1q6u3AEuWz17F1EAipHlnoEjGSTA==
X-Received: by 2002:a05:600c:4e90:b0:4a2:526b:d410 with SMTP id
 5b1f17b1804b1-4ac17565fafmr226205385e9.13.1793613517804; 
 Mon, 02 Nov 2026 01:58:37 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:d3e0:4b17:611f:beac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm20744682f8f.55.2026.11.02.01.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:58:37 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 02 Nov 2026 09:57:46 +0000
Subject: [PATCH 1/6] binman: btool: lz4: Update version regex
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-qcheck_fix-v1-1-f1f547c4a731@linaro.org>
References: <20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org>
In-Reply-To: <20261102-qcheck_fix-v1-0-f1f547c4a731@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, Anshul Dalal <anshuld@ti.com>, 
 Francesco Valla <francesco@valla.it>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.16.0
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

With the update to lz4 v1.10.x the version string has changed format.
Previously the string looked like
"*** LZ4 command line interface 64-bits v1.9.2, by Yann Collet ***"
and now it is
"*** lz4 v1.10.0 64-bit multithread, by Yann Collet ***"
The ',' following the version number is no longer present so remove it
from the regex used to match the version number. The regex will now
match the version number in both of the forms so will continue to work
with older versions of lz4 as well as newer ones.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/binman/btool/lz4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/btool/lz4.py b/tools/binman/btool/lz4.py
index fd520d13a56..fcc0d91553e 100644
--- a/tools/binman/btool/lz4.py
+++ b/tools/binman/btool/lz4.py
@@ -76,7 +76,7 @@ class Bintoollz4(bintool.Bintool):
         man lz4
     """
     def __init__(self, name):
-        super().__init__(name, 'lz4 compression', r'.* (v[0-9.]*),.*')
+        super().__init__(name, 'lz4 compression', r'.* (v[0-9.]*).*')
 
     def compress(self, indata):
         """Compress data with lz4

-- 
2.47.3

