Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40737606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X3uaW5Fl;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YXUsGX1/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C2D28124B;
	Tue, 10 Nov 2026 12:24:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BgoUxpQSzCFi; Tue, 10 Nov 2026 12:24:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 56DB881291
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313469;
	b=Ba3uMPZlvd0N5cA+ePNNuGzLB8SegKSwMojKiwuck7a4iTsK4L9ipTJkQ4cKxKzXGlto
	 7MZO6l7vBXSDukcVvWglCMQzIZi8SUJHK/Wn5RRXKw9BIUJ1SmgqgpZJ3blc2aYBLgB/9
	 9JF3ltFsLv535mak5wuZi25xmNht1TLnWxcacjmSXOjZwfrKrRSW0t5QgXf5TtlXqc3/2
	 C+/w9Woxk61QGsszSmTMI9/6vdJzL9FS+1SlUr2sP61dN6Syn3cEEzoyGnddlCNzp5sBN
	 wFRwKknZ7lw3Kn7V0eUtMbDz790XxP1iG++k4KYn7/K+Nh8+ASRSescYtm7zeRd8o3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ZAPF/f3Mg4tg8mGzmxcMyl/xtjmA1AyMi8xLudZ43YU=;
	b=bKmuH2aBgcreZueedZyYaV8ZplEyzqhtRd8Fp6a42LUcbsdDsr/cx3avGhGbh7pRZYha
	 ikRXHqSBHRSdAwSIB49wu4R6jq2cf1m/Y7RlXiCYFOIe8/mB11DH80AmR0F1+4U6lK/TQ
	 MGPFnp4M6x3NSKW5tgfyWel/bvpFVW4zFhw5ft601dwu6ubKSfW+NhCtoYIp24asA1S/b
	 fE8gAL7uAyYpLXtpNI0McqdCIscRnERRSOZ8BSKt18CxnSprVvR8MpuDa9CoJKKbGUs+C
	 k+BE8ls/aqjovbxIBJdqMx/KFB+pNMNUijn+Iq7GxD0uv+cVbe4h83mrBM2CIMdrEhA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313469;
	bh=ZAPF/f3Mg4tg8mGzmxcMyl/xtjmA1AyMi8xLudZ43YU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X3uaW5FlrAQJvTMT5xdFLuTv/AgPKiZKtyhbgr/BMe0MzWwvxdl9Fv3VeisHlIo7i
	 tMr8U1FInZOH6DlLlonJgvz/na0upjLp9mWh5h3S3J+jDfd4W/PfSVaFOX9JlBv/yv
	 xjEVIDe2AiRneBtLSsCzHrFSJSRLM+p2BaYvwo0hvWRwKsam60J3TfQFkcFuOK185h
	 xWuxEHcU+NHWu/TEzX3Uqfy36eb4zQ1o71TTRqKxUt83w1iD8fMuBZPcN+tCZe8KUb
	 4GGKsIYLdpUOQDouqu3WVk8t+udhfe78DmhsIgiIi49mMdB8ODFz5Cj6KlvDX5YCjc
	 0KQOZ4EuPvncA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56DB881291;
	Tue, 10 Nov 2026 12:24:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 901C6731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 748854085D
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oO6sWe-xQJFz for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76E5D408E9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::b;
 helo=mail-wm2-x0b.google.com; envelope-from=andrew.goodbody@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=YXUsGX1/
Received: from mail-wm2-x0b.google.com (mail-wm2-x0b.google.com
 [IPv6:2a00:1450:4864:31::b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76E5D408E9
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:16 +0000 (UTC)
Received: by mail-wm2-x0b.google.com with SMTP id
 5b1f17b1804b1-49ff9833fedso5300595e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313454; x=1794918254;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZAPF/f3Mg4tg8mGzmxcMyl/xtjmA1AyMi8xLudZ43YU=;
 b=YXUsGX1/wzjeY5bC9Zc7QbVhijeeuvuVPy7wu+ko1sPCMKxFxlppPCUc9FM+Yx/kw0
 YzRBfrd2fB7wyWbFVwh2xSzzr6Az/qKFqXnBcDnpYNIwmVwlj10mjtjJD9Hb3czTChML
 k0kNOvARSBv/Y7ru90NhvfMQbemrfsyO4v8bkW/Te9kDVAu2FGdIGixiKaisoN1YBisd
 qToq5beY2aHqO/+RBhcjjFFAmGRJrMGoJUaHo3/3iRK9U7oiaNJYQ7GkWYla91q7VXqu
 YG7D9DA8OphO06kP23045YxEgj0shH/qetyVY1O/WTIu3taPnIuEDFdPOeQHjkI4CCig
 i27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313454; x=1794918254;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZAPF/f3Mg4tg8mGzmxcMyl/xtjmA1AyMi8xLudZ43YU=;
 b=mC+pU2BHYWYBkCUHMc668qU5S6B3vTTBwESj44bRk9FRauHTrK0q64QOQwkBr66904
 81ONG4QBKqvUfD9xV9jzj11+ph7StvJ78ET106cmtsiX6HDe/q0KefPZN3VJNb7pdWx1
 L5mgXFaHeqxh2UzkPSKVGqF8cfih437VJZudKmcmx7x3prsXnFgSwqrPnqxQ2yWBU7CA
 gP1vf5kc5SVJ/KO2f5S6HgaC59v5xRNIG4A2bOefzAcC44kZZnYO6LvI/Ye389D6cY9p
 27LMhXmAAwStzvh2v3+0Mo7wjgHQGt25M9Q6sWAYeP8bODj/rHlIFBaYEpGsLmy+VVtQ
 u9RA==
X-Gm-Message-State: APuU4Z9DxYkOTVFrJCcU4kWYHdkP7CEn+E8D+GlwlY545LwX7goMKrkS
 +EnblbnZCWu/S/7S1OjHeIxAx4LqbkIOG93POKRn+W6UmC+pVaydeyi/eW/3NeENyoM=
X-Gm-Gg: AYBFou1AMwDd5u6AVJxZrV7DrCqUZtvSTr2ns686OWExsUiR/GuaeaDa9flLXnLT8MO
 ZpLF59RODKMOH7FsMinuaJQgEghNnKoMu0EPeVZZ8xbXgQWV6oyozLxuTy3Qe16sLWQHVBrlCaA
 Rgsmk5zBC9xDT6c0991EIzWFyo12dRWoFpq2L/K2+aAD2AjN3ycTEXnDvIR7gTp38lHraB36T5L
 Dw3zofpo6Aykn2+5fTJRg6UT0nzCNuWn7pRnJy50/vT3hGOnOGVztjT5sSU1AYFsNkXLW0x1r7z
 Cl/R7+OttZlotBRv7MY9zH5YgZEcIc6TuSO2Vi2531KCxM6yQXirtNAW7dOfPzvQ/jHHaz37K+O
 J+b9ChUPz+gQ1sL9QFm4Kb4c+HmLq7z+qsyUwxOPK6xRUXvAEM/3QM4qdz1S1WyFhG5lho6cLgR
 0nZmVNvijwnOKZUUTxKlP7GshH7jQAXmlNrNQlv4wEIxjkw6UlYT3xHM/5QggokaLMQvsQhB7CM
 kX2XzWIGYYKZmiIFw6AQisiwl4J9mjRue6mXsIlVmjFuaiEC41ije0lUzacGuGeZpFp9L7GNiyu
 qFubTzWJrVPXUABJRKZWzBPRTiMh/uzlopxCyVy4ekH6Iw08
X-Received: by 2002:a05:600c:350c:b0:4a2:1612:6367 with SMTP id
 5b1f17b1804b1-4ba0233eafamr42341825e9.15.1794313454094; 
 Tue, 10 Nov 2026 04:24:14 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:13 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 10 Nov 2026 12:24:04 +0000
Subject: [PATCH v2 07/12] binman: bintool: Do not add empty argument
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-qcheck_fix-v2-7-1c76e0b68f29@linaro.org>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If lzma_alone is invoked with an empty argument it will emit a message
to stderr. When 'combined' is used to examine the output of this command
the content is not deterministic in that stdout and stderr may appear
out of order on occasions. To prevent this situation do not add an
argument list to the command when it is empty. In this situation no
error message is emitted only the usage and this is always sent to only
stdout or only to stderr depending on the version of lzma_alone.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 tools/binman/bintool.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
index 4cf8d5b165b..15e2df2fd80 100644
--- a/tools/binman/bintool.py
+++ b/tools/binman/bintool.py
@@ -290,7 +290,10 @@ class Bintool:
         if self.name in self.missing_list:
             return None
         name = os.path.expanduser(self.name)  # Expand paths containing ~
-        all_args = (name,) + args
+        if args[0] == '':
+            all_args = (name,)
+        else:
+            all_args = (name,) + args
         env = tools.get_env_with_path()
         tout.debug(f"bintool: {' '.join(all_args)}")
         result = command.run_pipe(

-- 
2.47.3

