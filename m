Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFB606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vWvyGEna;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Hgsq7sUH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BBE8811D0;
	Tue, 10 Nov 2026 12:24:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jyzhn0LMRjss; Tue, 10 Nov 2026 12:24:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 043978129E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313471;
	b=N6XinrJKO/nJpYja5Cal/YQrRhFY6ik4Do00Nu7Ms1dz4SmWI4Ew3hRtToJmyCwPBeMt
	 jt55X2EyP+GAluX0mN5A5dv3uv8VZTNwJqb6tc+QUAxtsI4y6Yh5UrOGBnVgvUcdtpbPr
	 I8ZEMhQhNcvj1LN3h+HcbpWezZxvqkp53SKxaVFU90ZTeqcW55gtDfFpIt6v1RupsKdz1
	 QVrVNBgGzP7+IvdDtog0SrQUIXQbcARamX9q6mZTeQP7QWKWCwXuFJqs2lVLYgXyvw85J
	 bZewpuwC9ungHc6VzWStEo/UnUKE4qGK5aS5+JiEGwUD/VE+KLS0bnpa9zFvUe8SyKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313471;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=zT1QgCj5Mg1UaZiJXoNhMBUzB/Mt5GN2IvEd6FhrObA=;
	b=G96/IxGN9/SFW4RVpYcyRyy6yCsguDOLUdnAAZ8h8AUaplCXA7uN2mqQnMRaOnciz+8d
	 5Pd9jddJRswnWVVwRf+GE1j/jbufZsVl+w0JDbmOEdOQ0MF6hQiEXtBB7139yAWGl982F
	 X4r1u9wP582a6PU0Y71rqq6sIG5Tbxcs+pXmROE0mnjQoYDiS3fqMAicZQJH6bOYbutpz
	 mRFbg1RVnuczNI1fsLVt22VL2uoJklMOdBQNXim+ZbVoowgFLuBBVqdO0uYfSjwnjA2E9
	 py3Gr0L6wjGhrZy6pQqfMBYFszZbeHIerKYQgfAaDiMB+qcI9AJ7FiooU5nrMK5612g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313471;
	bh=zT1QgCj5Mg1UaZiJXoNhMBUzB/Mt5GN2IvEd6FhrObA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vWvyGEnag8TWyxg08um33ViYJTHE7FxWYZyuS4bl9Jvmg63pTNh3QGB/97BIfDFyx
	 eGSBtzw98gSazTd+GLuMlhNjG77+1ATc3v7FQyzI8JaTcrepjo9EHdNphIbOzOOg9p
	 dj15oljwz8u21dP1wYf5YxqZv2Tk38B4uYP+yWlw/moMXl+33VeMvcPieGHgdQdK9A
	 sY7TQ/N6oCA/3/pnuaYj58QZyirPoKj+CFXrsYWm6ZliaXGxsZrWGafwlBwTF9WXdL
	 3Gx8QO168QaSey4M5YHAxSYgFuc8IRwOFsqa0fJ38kxa2XjDjs/rWxhYkk6+STGjS1
	 XyMmBtCRxmGXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 043978129E;
	Tue, 10 Nov 2026 12:24:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CA1A9731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA2A96085C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1OHEmD3jI4qB for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C4CC260768
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=Hgsq7sUH
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C4CC260768
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:18 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so26336435e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313456; x=1794918256;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zT1QgCj5Mg1UaZiJXoNhMBUzB/Mt5GN2IvEd6FhrObA=;
 b=Hgsq7sUHUApBIS79qqtP/+wGP8X5pClpD6gQzEl5DWHaYtz1PTzzZWk3hyArCe4gsk
 3vlGu/DUfX4KYM2Jnk+rpkDE+8NNHPffYrv5bNFAEk9oaQVjU5+HTqi3NoAJH6dTyINW
 Hb3fbbf9XS9oLC7htdY1BudJzhWI0e6OCOhVFYiPbfTzYwsyag94LypJ0+w+VG0bHdto
 wSjLwM5k6zqYM0xxTeUoUUhydYA71/8Nj/Jk30OsoG7jXOetityHsBd04gQdRMGjjwSZ
 h5lFk3bQDNEEsWfDVPIu7XlY+K56aBtydd0iBnjoNJ/M8olq3tYS+z6Isp6zxzI9FsAw
 1uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313456; x=1794918256;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zT1QgCj5Mg1UaZiJXoNhMBUzB/Mt5GN2IvEd6FhrObA=;
 b=xnv/6w550zJM0w2pp0Sm0fjZSsK7mF+Wz8/1uot4gTAnXF7KmJ0R4bPOdWMBXwXw5g
 e002pXgskHNjpHkxqvTxeyAhbgt6iqfZfvVkxgB2e9lKy+z6cUx54e7npqC5Vd7QD4NP
 DQe3abI6bdAWqMc8cc7+F1ggGnXBta1mDky4fK+36dd8Kz6BZbJ/agsVzXDubcI3zr7p
 TWxSwWuC7ZbOfi6t8KbUV1s5W625qEiLGXzBbDorvkJrK4leMdNZo/uLkv8VSb4Eewno
 N5YmQMDcrBD+0CvqrPbFu8f7rLHowRl9Ub1royEyvTy6gafEPklHTFNph1c4Ioy7zahc
 8HpQ==
X-Gm-Message-State: APuU4Z/KplnwfgWdxJ3D2OPKV+NEMMkbKvB65MgVCc0EmtxBYbxi4PuX
 Idhe4qGP7AYpMf13y6RQ8t51FGwTsG2bhJElm5uG11HBzJX211mwoKG/CdGfW8XfpGY=
X-Gm-Gg: AYBFou133geOL0W1Y/uqv0Hp4gvngrkbOh4EXfXq7h80d6YsKpFNhIXpx+CIqJls1Kv
 ujxo1/lEiGybN9JqF4CZB3ZXFllp/CIuITtC0sqs82+kWeruVMvfYFEqI2lkLJ8xbhZiCpfqY7K
 54/n+1fcZvXa+QLk/2dOIYWoBaSmtGNVb0ou/m9pEvM2OZS3P4F60FXJH7AOm2AwsrNUqo5j8lL
 t2Lh0v4VosbAspEEVQRojxCL7TPZL2QCklP1VFZ3Kmz4ob0krO7XR4Kav4TETqbvhQxfDkSTCp8
 RTiOAcRHO4DHp6IN3ifuZBwgxJuwMooZYYx/uAKHFyvDg+lNsgdGcQejdwKLEhzYQ7ZSBOLlXNH
 4y0V29P0NQXNapOI+NVjk00TdUYn1AR647FLGa1zYUEjD4tKXGhC4Ikn/+SSJ9eV9tIkFjqCYZr
 Tj/C0Q16ae1CihnqYwQCYsKfCUHZ+UeKNzMFVoLLPfK4n2W1gPzuf6zu7u95cP++LmU/vnxTaVF
 QNBG+VDufqnpKIzhmUmWBs+hS1kGEBX9M4HpTN+Bca/8VZ54oHQNLOsnzhBQ6hI75/FQsiVnn5b
 vn7gRoJ75eOWjF+tYe5azDMizRtxpNipqQ==
X-Received: by 2002:a05:600c:4452:b0:4b8:4af2:88b3 with SMTP id
 5b1f17b1804b1-4ba0234a935mr37211845e9.22.1794313456204; 
 Tue, 10 Nov 2026 04:24:16 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:15 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 10 Nov 2026 12:24:06 +0000
Subject: [PATCH v2 09/12] test: Pass location of built tools to binman code
 coverage test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-qcheck_fix-v2-9-1c76e0b68f29@linaro.org>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
In-Reply-To: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>, Alexey Charkov <alchark@flipper.net>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When running binman for code coverage tests and invoked by 'make tcheck'
some tests can fail if they use system installed versions of tools
instead of ones built from the tree under test. Ensure that only built
versions of tools are used by passing the location of these tools to the
binman test being run.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 test/run | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/run b/test/run
index d1654dffb5f..0857fc14c9d 100755
--- a/test/run
+++ b/test/run
@@ -93,7 +93,7 @@ run_test "dtoc" ./tools/dtoc/dtoc -t
 # Code-coverage tests cannot run in parallel, so skip them in that case
 if [ -z "${para}" ]; then
 	export PATH=$PATH:${TOOLS_DIR}
-	run_test "binman code coverage" ./tools/binman/binman test -T
+	run_test "binman code coverage" ./tools/binman/binman --toolpath ${TOOLS_DIR} test -T
 	run_test "dtoc code coverage" ./tools/dtoc/dtoc -T
 	run_test "fdt code coverage" ./tools/dtoc/test_fdt -T
 fi

-- 
2.47.3

