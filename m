Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590A7606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QubXa1hx;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J/bv5y0c
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D2BB60801;
	Mon,  2 Nov 2026 09:58:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CpTc_MzAc7Mo; Mon,  2 Nov 2026 09:58:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 68E3F607FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613532;
	b=bLVOWKKox3CqJjY1BxydqNycI1/DziCc/9yBn4MBbWPn0x1xmSfcmS4aXid59puxG5rI
	 O2leV3USli/AvIRV3fCtHmSIfHuthP8Qjv0nyi43k9x6E8DWydVXxIMK+qhieaKG5Jegq
	 9Lw3uHUzqjwCkBqgeqTDTyiuh5JcEYYjE/cCnd85ztk/7HCXaUHv8Zzw51bVt9Nv6bf3J
	 ff7YLNEsuHPpIvm578BmKTowZ6d8r0b9NhL0n9+zf72Ypr2jfT1rtSotF7kTsKpeNFM1i
	 5ewN+KRafl6KojRokjAI7C28HiXqDxWbwvtu0RWRTcsKBLiwNxueChOeIiVCNZyeztg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613532;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nBxfeKNELQ1Yryy10sGpoiR8bMahKBQtWTjj72BgSi8=;
	b=Y2bVlxV7fapdp1JBN1p3QM/MIaki1S1nxglzxaRStb3MmOUz2K55nFLxa1D/Pn8IUXwm
	 jYAMYA/HQQfkRWNMT717RxFoCaFLB6TH/S1V3Bpz0iMlfwPsWg31m3da5FMxS/yIOodCR
	 cCfqbqjc3jRPR/cSViJTS0xnuNGWhythCcaYaSNFkcFGrjm9FFPDxuVvSP7Vw7wGXNqPZ
	 HJQ/pV+700yyZZHaQMQjz48YpfpdE4YM9R4z7tHXUUByY4iJHVofmbp1vZ83sEgTjzbjm
	 LheR2s4OwrNp3Bq3A1QKm3cwa3h6p3fLK9XUU5uAsjzWDtiIm/Rx197BdQqx0xuEDQw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793613532;
	bh=nBxfeKNELQ1Yryy10sGpoiR8bMahKBQtWTjj72BgSi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QubXa1hxd5YTkjwPi8OzW+qA3C2RZ5gm41IHVvt3dBmnCKaEkSgbNKL2bKX9JYb6V
	 Yu+ym9RsWXZ/a7vib3f3DHfNci5Swg/XJWWGey/faCmWqZKTR5x5IuboEz5sbgf1Qa
	 ihHOkNFr/hLwKKos/TS6oWVuR6W2gAW5WRyHOzL3EvipYDh4MK937DVesmdWjhhWST
	 LLwkeCIxMv9JWooWhqudPCTXJ6MhK8F34KJNyKP3X0sSBa+qxdRWK/qMBAFoVfPHie
	 b5ZJYj3cbTycOiQlyAtam3TxGoTxpzUzUOFN6iiEsM3MkNOPa88u5dF0z/xSnsIi73
	 cwzPeTtvT5CZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68E3F607FD;
	Mon,  2 Nov 2026 09:58:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0508AD3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E8D3940781
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8cQ9o08Mz-_9 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:58:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 18ED3405CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793613523;
 b=FfQXnm+lSHZD3wl//Fr3QAaiB+/bsVRQz27r9sN8MzzB1sp34mF23pPiXJfsBRJdnf1v
 QexlmTP9GxlVLS/icj17go5DuOuUTR2g+pX/AUMTcK/Ale3irDBp+u1dM9QSlTEs7qftf
 Y19LFP2jSSiagK3j0nhJUW9AW4CPRPC4T5+l00Ol09rHOv9sH65aYHbF+yPAWktta//Cl
 ohBUkrFpqHD+SNw65/TLT3cd/5lc2ShBgSB+ubjW17WgUs/shxPA9ENl0KQp2gAEA/6DR
 fXIXdVdab46ymF9o/kQKSOcSuBY4yoQjYB1Sx7lSYeOdZ4/dDaxvePietbdQvbn71qA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793613523;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=nBxfeKNELQ1Yryy10sGpoiR8bMahKBQtWTjj72BgSi8=;
 b=YATAXbPZEtFX/Dz00Rr2rze+1TPmW+T2/B1Or+a9LeRvi3Cb7esUGxnVDuxWuYDRFTjv
 5pigi2j/KXkuYG7F6urMjvd1K4JH4mHAI6nIk0owKm+tZrU0DZC23I2+eth/TYyumzTED
 STMSJMRrs577u4Qx8R5RlUItEtMGB3GeL91LdA4MSdt0+9gJZnXuGTnxv926+ilOob5sw
 rw3UDxk/Yo4QTQEzZSeqZzWyxUTXrh9TXKAMQ04vYqy1jSer5PeQ/A1wDgQxu44q1WJG5
 G+BSPU33GlnCzWcuBXI2anp3HZEgVMr6KFVCEaSc0zUkwsmKeT9kIUOsmsTjozVhcOw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="J/bv5y0c"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=J/bv5y0c
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 18ED3405CC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:58:42 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so25217505e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 01:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793613521; x=1794218321;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nBxfeKNELQ1Yryy10sGpoiR8bMahKBQtWTjj72BgSi8=;
 b=J/bv5y0cLLVtLAJeVnoU5HFokwBfsxqh2QF+fXfq22TU70JfRrgTC0rSYz80ii7i9S
 DIq0OGTmqIxBhA+l3w/rA6rOai95PfgYDVM5uU3lRdvUO6vl83Q27svwEaK4IEk+6PDG
 eyAcWVDiBi5REc3GJPnrxE2zyUbybjh4uVolhJ+v1sYXIpJ+wrCazDKqBBExLDlMabKC
 E3HiL0kmStQYb4B8Yu4lN/RZl5qY07qRCsdN5nG0MmuezVIs7zEgHAEyMpkFipo/tbKK
 K/fBAIw17V5wn4N1GWtvIxnHl/rjCe0irVoNAUjUATBrFh1qqRmIk4nKvQNxHvdS8f+8
 xyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613521; x=1794218321;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nBxfeKNELQ1Yryy10sGpoiR8bMahKBQtWTjj72BgSi8=;
 b=lxtOcDRHRJ0iMn5E75jJJobxoLYFH7Y9RpuVn2o+1GBws/ajYUWLNju7Eze7FDa8vm
 cUwior7txyNs/8tm3fS8UmpoGHvmHlaKZyz+q5aACoIZ+/vCEqh51UL5H+AXD+6hVlgg
 pWKLr1c6/Du9B0CNtWS1wdE+DL0Er6170PS5rssr9axcseC+2GfUpmvu76xOvbmZAR/0
 6+f++OMWUt+YQ5IBGYqBBg9D3u/cvTO2LiRgwKNZQtMdrLWkrtxeXKHu7s+I5+vOhHfv
 sOOdq4mUw4kRapduk6kGpdte0pmDs+8RmWJFnQD7MC9n5r/y9HfG7m0kHCA/yu75eWPE
 ckpg==
X-Gm-Message-State: AFq9FYKWkP2DsHhuCC2CKMMASU8nxLt8vVuelgDhy4J/w2Ablpl3qRrV
 lbhtlT5DBYFuJKSVMbrKK1veBP+En0IHSrXkrgHyMd+MVcV9J7xI/HzlzLspUw4Bo7c=
X-Gm-Gg: AYBFou3vsVuKzLKt7RYPP2CC/gvQZbTZEg5MfAnfXPSAK3EHkFLeyycTWPlTTBTRdmc
 UQEErgB3LKul86nFTi4FgXa1NIJvRIWFCjmcS/Nkvd/KqkMVHUDwdxjU0C0MDanZ6kMSvbzL5RY
 Zqk73mrjU031Def7idZ+JiPB20nIBkIfbOyiDeUfRmF9lcfDewJYWUB6Yk8WTVjNpaP/23V9FO8
 4qaOfA5IKFlAbGrKK8+I9f3jR/6lzEG7sA4p77J8pknswWXNxLQ3CSzBtnj4PZe/3FQUpjHnkst
 t8NIdbe/EL277vEu8ttAfJUIpgpgUiasmX0eM3lO7nZQxl+I8TIVK5dQ8Zd/diRGc+iDatXXdwA
 cYWwgKMc0Eqtoe8PpKFCAzoNVJCFSri7R7tAsSpMHn7ALmgiGsIHF0DHhdCC/iRCaxy4HqR1fBk
 GtKbZhIK1/3kBVnsrjo/hCwFBs+V+C1vNX6yXd+NOXdKRGhW3S9lxWobL3t6qmaaspMtIibwIU1
 /yCEi7JjI3N9mtb0FzDyFoshWtt4O4J1AvrCo7ToiezI0cA8LfcE4s8KWP6NT+74wHcSYpKoXNx
 CtyHjPmqt2ZMKEz7aWkGyWMDIjKD/Hy71xEnUSc2ymfrtBBA
X-Received: by 2002:a05:600c:3f06:b0:4a1:e672:5721 with SMTP id
 5b1f17b1804b1-4ac181e75c2mr223391575e9.13.1793613520899; 
 Mon, 02 Nov 2026 01:58:40 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:d3e0:4b17:611f:beac])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm20744682f8f.55.2026.11.02.01.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:58:40 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 02 Nov 2026 09:57:49 +0000
Subject: [PATCH 4/6] buildman: Cope with empty CROSS_COMPILE in tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-qcheck_fix-v1-4-f1f547c4a731@linaro.org>
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

When the buildman tests are run through the Makefile with eg 'make
qcheck' the Makefile will export an empty CROSS_COMPILE variable into
the environment. Add the code to the test that will accept this as OK.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/buildman/test.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index 7ee9496ffb3..e620a92126f 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -656,7 +656,7 @@ class TestBuild(unittest.TestCase):
 
         tc = self.toolchains.Select('sandbox')
         env = tc.MakeEnvironment(False)
-        self.assertTrue(b'CROSS_COMPILE' not in env)
+        self.assertTrue(b'CROSS_COMPILE' not in env or env[b'CROSS_COMPILE'] == b'')
 
         # Test config with ccache wrapper
         bsettings.setup(None)
@@ -668,7 +668,7 @@ class TestBuild(unittest.TestCase):
 
         tc = self.toolchains.Select('sandbox')
         env = tc.MakeEnvironment(False)
-        self.assertTrue(b'CROSS_COMPILE' not in env)
+        self.assertTrue(b'CROSS_COMPILE' not in env or env[b'CROSS_COMPILE'] == b'')
 
     def testPrepareOutputSpace(self):
         def _Touch(fname):

-- 
2.47.3

