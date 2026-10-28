Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A3606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oyvc5guK;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=R/H7bGnu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA0544087A;
	Wed, 28 Oct 2026 14:47:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nzQ7_j37kNcB; Wed, 28 Oct 2026 14:47:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 190DA40877
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198874;
	b=C/XRBR7jfE+tAVNe0ucGYxzXCH+ks5xUAKmi3ZNJeaJxG5V30sB3n83x++zk4hICCkU/
	 KIW2a7bOKfEKuIaSSdtOaNqje7R7rAztD8bSeCo8Vp30eQ1tn6wiX+MJnw28XmlZxz9/n
	 +Dre/LugWW9LtXVl0J01Bjz4ZJ8fFyuJw2Eqm/FJaKv6p62h0HuRxlaTII0lH1W0BJ7Tg
	 j1l3bihHVLamCGql+m375JIAhwQJF/Zq+Ttnvbe4xaElWRKQlWDmQApXBTtykByBvBZ0+
	 LH9dH+RZK9cV4eK+bufLPtP0KfouzOFUMYlEGnwY4OJVivXu71w98GH538ag7QF8HEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198874;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
	b=jquBlqcCPOAH23W3tL3f6ffkFD/0kboseIsRNXsiZ73f3+cUgTjkGlXkUIns6sVvbufG
	 JlbIY9dGan6e3B6s4UHqaQpTKWJZ7dDqhnfqOr6aMLdz1daOOVxIgApdT+ro4fjt7d5Ou
	 LyFSHSTYGOWya4iTxmwMKlxTrtO1cy1zl8xR2Ru6oYpjQ/YBQTSuUEyWUBFoISSvBURsS
	 o42mSEA2ji+SjczIm2EE7mmVDxZsGsqDBfCqbXj1f/ic/bKFlnt1gJGn3Q7F1CR1nTJgO
	 G3fleprbx8127yb2dV01bBsIzEUyQtgoGlBNhtPtw6zslDIiWJi2+EByxxrAB78rpXA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198874;
	bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oyvc5guKdLvRAIuBJncDDO7UhfTNQCxVXQBHnzXeu5jXsJtAQFqI+YuKV8CIuJ+20
	 lJpJHiFh4IP91QM9OTvTber9oJpusqR+pu8FHbAYha40tUseLhsbVrjN/Vi3MxYL6R
	 jTyHnLJnIDanW0mOzm3V7mM6U6iwUw2tKjqS5VakDgDuwPFFpr8L+zX7IPYxwVkyUm
	 iAMdhwTTyCr/oigZ5VTde3hMWLgyEPgXh1gmxF93x5GzLv06/kUq3WvH0dEKdzNhTQ
	 ISJkU7iSSSq+aSIS6wZGzrpY6AjDntzdYY3v/E8PQYhUWQBXW9dwat1Gki+ynXB6uD
	 nR4bQh2sk2XKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 190DA40877;
	Wed, 28 Oct 2026 14:47:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EFAB1529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E14F6605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SmiU2mdXAEvv for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 23B9D605CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196962;
 b=e4VxlxBN1xSW7Z8RpSl55A13iCoc1YfOuIDKcjZE9gD8S0xzpEi/BTahG718xhAqud8b
 djSd2njrdYyaciDrAKeZw4RSJYxZuXnB3MObwe/Sevf98/lCxZmclPBBcHjPlSBSA5pCI
 B4I2oMZ0g3Ra0f7WgtM8uXDF1JihKZRQZYUXxcJ6WcI2WlP3f2843WMv0WE7WsIOBHPdg
 zy35WvKTqew8efkFbBOoFuOn6sHaLf80GWNTGHiTJVwrmpx83BiNIXhkpaRSbbdpl0Cz3
 48XqvpCHUqxWsrtUslkoPwMfRB97/uYJVLNFPILdwwJsAOCLORa9Df0tXTaE7p3qyCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196962;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
 b=NoNJDIgqt+YfaacDCEtOLdflts/IiX8y9zduVInh7jmQyQJlXlDXjI7WOFtfqYDQX5ql
 /veLCZHJ2/PHHYtNnBvf/JrgTc7okdgL3zI5s7mATh/xDQ9c627SoQKsl4QiCjKRKKGWY
 Bf0iqMUGq09Y6JQLS4WlQaWJKVTtu1BVYp6BArjM7aeu28k3zu0DwVNDIk7/o+SepvV4X
 kxZMTjKksR2qL0NDzUzSTPbo5/IYBz++dIuSH9pXzwmVNJG2mEDiWicfLebV3HYhxjRaE
 0kO78yoPUiX2fOM1HM5YSrWJsW+0uIx6KVF6QJGYgxfCv/dr30RkrbbhQ3AinjIi6mQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="R/H7bGnu"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=R/H7bGnu
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 23B9D605CF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:01 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c407213696aso10464566b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196960; x=1793801760;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
 b=R/H7bGnuB100GazAYXA1ajQdgtb1jsqsiBXijOsTuhcurmnr2Vx1LuyaZsC1LfZjyQ
 ZJEooqeym61lifyHCumc940Qn84LQkf/qM86wukok/99DJ3KtcCDg+3pbUkfP6GVSvgn
 8/PH/y2G+icLogtvgzJAfHS8vHwV+n9D6Ssf4AthqbWVZG3bC03oCfU7ec60qHa6hbvc
 ElE9eH0TlGi+4GJO2TfurXPN8BfPdBkK0uUN2PHj9TaPQ8uSSCLUGmALmdZ1IFZ3qf9g
 0xeoQX9u8wdApVSagjlZ/SUQSiqOujo7d3EVGdu2mM80Q27cHqgjDsfoG7kGZsB7V23w
 mRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196960; x=1793801760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WP5pwwX8W0g0LY/Lq+YQ38anw+6i/EXfaaBvCMvlsx0=;
 b=F+BHAAKrjd//sBdx32lQFxE7G8g2UsLWrwFzFM28neRMg+klvwOCwUqZ+LenA7DXzl
 5u+3RShy28XlUN18eEotItRc8MSchaQqqhedNEGCXu2/5cChGIoMKtkZeNfRJ5XeHEae
 8OXe+JU6OI9ZZ3UPhY3N9KtLn2ri4ztFVHSsb9SEkpeYXCmlAFDpNrzbLSFrXN/2vAeD
 zu+y1/mv7AHO5Qs0RNhlWyasMhtEK82ID6ZYCj75+CtbMmlKvscxlT7Io28xc7VTMsl+
 SU+6y8VMw9Wo90pc29OaJaEYB5kVeHWBzh6wUeQsm8fUn/eRqQ6SCXoknl/3j8gqSJDK
 qbxA==
X-Gm-Message-State: AFq9FYJdKiYmGbCLXO1EHTpxD8ax1mm/i33gcyIohEL3FBqj0eXXt8Xq
 OfMA3fp/s39BfULVsDKdDBElN1kh8uTD+IWh0DoykPLsWczFhfogs3lqj0NG4/dhVpwbCsHVwfI
 Vnjiv
X-Gm-Gg: AYBFou02Yyct00u2MZlTCLa6yPA3bNj2rAL/0HpGNtgjHENwmL3M7Xg6HiaaPrCJn00
 yWr0yaLcjhqhzeeeoh2UzOpmNrVR+1iiE6rSzPWN5Ykn8Zt1M/rUkm1qRq2MT18iaRdaWnTP060
 R4Hhqxh94YT7h8VhC/9X8INB2A0GfNSv36WI0QsHzfI3QbBarIhfNAfMQDB5hKMZ3LWT9eoJObj
 w+IyKRiHt/QjpF5dw7DQS0C1U7qSm0BO6gxCiPGBFzgFOQT3GNd+GZNu2U7kriNsokKU+zu0qnb
 9YvYU7bAslvubpSB83tcYPIbTAIGbrS7pqY1wQUl7Oigvg/NhZlLQMEO0iAYmpLGhHTU1Q7JtT7
 N70CA/X/pBifUsQya+cLJl4AB1TDHn9ehKpoeFyoicAkHPQxJjDoHtZaW3aUpXysnKa/1Gr8uFV
 v6Q+64tNsuB6b3lXzn6a8uTpPTV2g5rg1KYsuLnsR/ljSgpQxUSnhEBrdg3Rr3hLrWHg5HVFE/0
 JV009EBooXha0uGCbJK0y8Wq+783jPtuPvybkztt+Z2uyLj1MbHguomj6yiy2ub7IJwesuwCDOy
 TBWaZAuTMs3NT5nQTrwAOamix66X8+tMy1PZ0xMEpZHN1OAAdGLLhj3Med6SAZcMam3/efSXAkD
 SshM/2Ic67w==
X-Received: by 2002:a17:907:2485:b0:c32:8cbb:fac with SMTP id
 a640c23a62f3a-c49bdebefe6mr221433566b.3.1793196960072; 
 Wed, 28 Oct 2026 07:16:00 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650890sm629859266b.51.2026.10.28.07.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:15:59 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 01/30] x86: asm: io.h: add rmb() and wmb()
Date: Wed, 28 Oct 2026 15:15:25 +0100
Message-ID: <20261028141554.3073545-2-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141554.3073545-1-anders.roxell@linaro.org>
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
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

x86 has dmb() and mb(), but no rmb() and no wmb(). Drivers that use them
do not build. drivers/usb/dwc3/gadget.c is one of them. It calls wmb()
around the trb setup.

x86 is total store order, so a compiler barrier is enough for normal
memory. The kernel uses lfence and sfence here, but those need SSE2 and
galileo is i586. dmb() is what __iormb() and __iowmb() already use, so
use that.

Reported-by: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/x86/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 1390193f09c7..bd6c3bbfd2f3 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -241,6 +241,8 @@ static inline void sync(void)
  */
 #define dmb()		__asm__ __volatile__ ("" : : : "memory")
 #define mb()		__asm__ __volatile__ ("mfence" : : : "memory")
+#define rmb()		dmb()
+#define wmb()		dmb()
 #define __iormb()	dmb()
 #define __iowmb()	dmb()
 
-- 
2.53.0

