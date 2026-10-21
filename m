Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841C606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=shlvvVBT;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DY+HbBb9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15E796083B;
	Wed, 21 Oct 2026 12:55:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SpqpelYzYM1E; Wed, 21 Oct 2026 12:55:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9FC1160892
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587341;
	b=WbcX6I1RCLc+sFEK2G8sjTOImyCY5s9qN8/mYWYiMHoJE7z8fCaDQLOagO+hSDq7dViz
	 yaZ3ZLutexvL/N/6Q66wyCChCHZs2CkPBwEP2rvLkOhqC7ZAzVAtbCYgTnIz91cRE05Bf
	 h/bKdrBOrCgqpIUk8pNG348Mu8sixvcOCmzoavACJPJadofrstNWpCoG1JSbJ9jHc5v7W
	 Cx8C6yBZXUK3sitYEGJX9hW4WpJ+wqir8rgkLlHNMc/YLb/LcW9McVLWzHk6CpqTjYcRb
	 bp2ntcJlHwyAGJQOubvKkPWSQ6PUFpr9b6ihzvLMqV9LtzGA95XsHeyJwCxuu4JMbAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587341;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=xZdT+Imj5e6qh+LQv9TshtKnyfscSAmXBPa8/B54Dl4=;
	b=Cu2OVWikWNnKPe9iPNJXLJQPuSxQZS8LGFnshV7hcYDIs5A14Fhma81T6YCZV55ZW0p9
	 8rRNEyEnkgdnLajj337BnLUJemDSyig2vZi0hjLtBkngvyoy7e3adU+vfTSIrxwdGqDtJ
	 Kqab7ihWWdwCjwWQ2LyDI8tQ8NkQ58RDB+henxMzbZjoKn8p/EO/Ix6gRr3R59VlO6EPj
	 yza0DuDjvo20MlODnZhzcEAj4+qc/v8ouv3OkTlteGavWWmAnAJMBYKTG4kP0ghPj0Mnb
	 xdtBGaZuu4qq73HFPKtPBXO+bJk72SiJxQw230bfYwJ0C8zxo7/D6tC367DP3syt1LA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=DY+HbBb9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587341;
	bh=xZdT+Imj5e6qh+LQv9TshtKnyfscSAmXBPa8/B54Dl4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=shlvvVBT1iBnL9IccAfaEBbnDnz9yf/d6np1i2pBZO7Ultum1Sw884lvnYkSERknV
	 qzniQ1OoHZkA/ipXhDHKHn+Ls+dEwFOjNYjV/7mYbLVQOFg0HrYl2aUoYa+ArvdYi/
	 WW7erIzXTIBD4KAGWdVrKnjLPMtH+7H2NidAWY5DLxZmtnKY8M+t1x/1kTZulZyNFE
	 vs3O0tr3A3zahrSQkkHwI+7O+WdZoRFtHQRhMfi2EuMBpmOrRx6Ru0H53KBKEAxx7k
	 d3tjftnVaajrRlbLSAdlZBjV+Zbz5xinxMIXDqKT1HQcZRvB+Y+eWvjfslkZUa6xvK
	 HBWMqcPhzFulw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FC1160892;
	Wed, 21 Oct 2026 12:55:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9151EE50
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7ED0560844
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PtHlrEQhdflj for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:55:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EFC1360892
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::933"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587329;
 b=sVXQjh2QVHLV5M7r6JQ5oQ1SZ5lpTqmvMgYWq0c+rLixV/ETWHfuPuLfELA1FkWKaNe1
 G5u45liwTGawoJAnY380gOqj4O+pXZt6hDbIcCoZOciVHd0yUwOXnjaHrdCyh3GQQPAfb
 iYA6uihrYd80M0/1I6NhHsDHNtePkxZRsABQnt2nM0Xg5srTGbOvkt+SCvMu1bBl6QGyJ
 tr95XTtkc1E0lcGrHgdifU48DtsCJv/P+ak/RF2mNE4sc5rpUdqL3VmoJfhtX2+No0QCF
 vzHB0bnOf5dc7CWz6BX94imOIim400bQtThOJvL1JshwlPMJFF+b3LdF8JgaxbwxArQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587329;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=xZdT+Imj5e6qh+LQv9TshtKnyfscSAmXBPa8/B54Dl4=;
 b=Phx2/+wiQX4OMyyFw+tS9vFwBillDpkmTuu5X3o9klBEvSMdPP5i4xpRVYkdmp5RG6Dt
 ZKDAEV9e72xks8lVnb5PGioNnnY2rmCJ2eSkq3dlJ4OCwZE9fpFdXSodR9pGyHYe6fsV0
 d4xFwBrSeGWKHGgWKWoGp2LcRXjPUR6SQ54xZu7c452c4gq4Tes+ZdU+uXlr6gtqAIFSp
 SHs4LqsE2esQYhNQt39otK4A1Xdc0R/G+BdGL8TnOp4hQKrWCtF/NBOBWdRLQt/jgF10C
 6BrcnP3HlO9mDJn1GFNuynOLz5aUTI/JF/r3fVlciRtnoPN0e8DrrPC4WVHDAoGKnUA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DY+HbBb9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::933"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::933; helo=mail-ua1-x933.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DY+HbBb9
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EFC1360892
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:27 +0000 (UTC)
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-97ccbba8e86so197429241.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792587326; x=1793192126;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xZdT+Imj5e6qh+LQv9TshtKnyfscSAmXBPa8/B54Dl4=;
 b=DY+HbBb9Yv8YLCFkx1V8DOZK7Ef+urr8DIcVR1gUJP2iTB19KiLS0YWmOmEjKAXPZY
 gE/AYbo7/WEsPMg8Fpi9WhGDph1NRVSdieoPHNbs1krXQ/iK4KAgXCFSIuiqdypkrUx8
 LBqjEtNq2oQE3gz+Nded8p9UDQ6bRLHgMtF4X+1BaFzkcY3/gZdvGIk5YlNA20QlmPaG
 bsIlDq8pU8iQI9wY225XWCq9GFApaOg72DjCPDTIbrOHgaqKGoGRWWliYMVjntCnH4v9
 OxVpn65Nvq1QeKpdBsD0RGX2Fv20RVwhondC3bP98AMeRgn7frgoSOQNVHI4bvYbAGnU
 4Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587326; x=1793192126;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xZdT+Imj5e6qh+LQv9TshtKnyfscSAmXBPa8/B54Dl4=;
 b=vnK1uDmGukJOeVcOIEDlA9MuuoKwbDZ3CmmNzBQXvxvolmk+7cgNSIptgPj6rROPya
 idZHz3aES+x/lNkGqIFKRQduvKbtkgwP++FjhbdLoZBxH1nhPSWyKHhKLjXicWmak1Bn
 t0QEW93Xve4aa4053QfDJs1ioNuykOR4elBSzX332gsfQ+NctfxnOAFeofbQ22AV1hkL
 CAnR+ZjJ+yh2h7XRQw3N+bjQqDTLl5nThmuWxBnH2b4Dkdlw+cDdL6oPRNFWwzgSo1IO
 sGkuD8E4jAwyo2iXtc7jSRF3sWGgaA9aDAzZPJEPoa5eilX+cFVBQpQKOqWEB+fsBFy2
 Wk0Q==
X-Gm-Message-State: AFq9FYJNtkBhSuQ3vR1a89p9XN9YLR4Mhs4r3qbXNAH2bA0dMCsGkDA/
 EPQm4z+o1iKS7aTLDpjTGrYwsbhBS9TEFpf3C2FVUC80RUMN7k9ZqGOWIulNfVgp6WM=
X-Gm-Gg: AYBFou2UQv14mypWGSWbL+03Y3RYaZhcnCJPY0VOblKMbv3cFXl86Ms2Pup3BetcgwZ
 nQazC4OVEAH+GgQrZ0Cd8xpKxPpo1Jt2M1u1qBswbc/Oun8H67pmCU66NJC8aIyj4L/BUYTJVRS
 CoyL383UuxDFRxfc+bN4zb2ocyJXjYV6WyvQPqpUmRWdxGlozcoQLXqTUpgyKGlqPq/zV+IiDqG
 dIo3j6aUcv+GP7RnTEyP+uCZg3Qspbd3GaW96AHl+/cl9pjfT4qqQ/kKJ6P8j/epSsXR0VBCX8K
 KSsBgha8fxxWWcTQiBhdY1WfsUSiDX/UPfBLYCamkqMGwudl18M9QUtJO8lk0q8j0LsY3PjEOsN
 yNLbv/+emWbJaf197aalz2yU+YYdMQst6g1myp1ZSemeIRPnUuG5LVBt/vhqCRlwSsMfOJoNNgp
 238MO5qlGQGREtg0ONtwR9QwW0V2AT3B1+r80u+XHBAAaRaI5ycS1UeXoxERUpuVzVuOY43ABYc
 BlodPGwowb9j9xok93B8nA603ndj9iKSjFf7Ata7HnAzN0f8vvQ75Gmvy/W48cmSzjuxcB+Gxic
 GtsVEbsn7ScpMSoAKso=
X-Received: by 2002:a05:6102:5cc5:b0:7cc:5c9d:7e07 with SMTP id
 ada2fe7eead31-7cc92650dc1mr556432137.11.1792587326414; 
 Wed, 21 Oct 2026 05:55:26 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::33ca])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990d0e0ba56sm3013863241.1.2026.10.21.05.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:55:25 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Wed, 21 Oct 2026 09:54:23 -0300
Subject: [PATCH 7/8] doc: board: sophgo: milkv_duo: update documentation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-milkv-duo-spl-v1-7-ee7618860237@baylibre.com>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
In-Reply-To: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 Udit Kumar <u-kumar1@ti.com>
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

List the drivers already supported in mainline, fix the grammar of the
sentence introducing them and add a blank line before the list to fix
its indentation on https://docs.u-boot-project.org.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 doc/board/sophgo/milkv_duo.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/board/sophgo/milkv_duo.rst b/doc/board/sophgo/milkv_duo.rst
index cb2ed1ad987..d99a945a61f 100644
--- a/doc/board/sophgo/milkv_duo.rst
+++ b/doc/board/sophgo/milkv_duo.rst
@@ -9,8 +9,11 @@ The CV1800B is a high-performance, low-power 1+1 64-bit RISC-V SoC from Sophgo.
 
 Mainline support
 ----------------
-The support for following drivers are already enabled:
+Support for the following drivers is already enabled:
+
 1. ns16550 UART Driver.
+2. Synopsys DesignWare MSHC Driver.
+3. Synopsys DesignWare Ethernet Controller.
 
 Building
 ~~~~~~~~

-- 
2.53.0

