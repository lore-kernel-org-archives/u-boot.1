Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70E2606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IAtVvJvA;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hq/m/UpM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84A4C409A1;
	Thu, 22 Oct 2026 13:31:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0XcMKvzN666w; Thu, 22 Oct 2026 13:31:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D894D40920
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792675918;
	b=o/4rPUsAEW/Y3GBVkZlwqyeL4tY/kIYxKAP3JYems2XkqvYUb6gME57DEmQbPVAZana9
	 +JyrGYmZppVcEaH074YRC3hdawtLIzdeSMu7Mj4WQ/pEzc58M5Hnkh2OnP+V2i6ibDOrm
	 7D1mvLf9G1Dagar+DsBgslv7TIXFSUauVVAhMy9upakE4fsWRsffKyJ3EjQ6siT1pAJFH
	 5YqPzWMJ7gdcN2or0Ib2SRs9o+IOSGLi04pFaM7GtNIibML3UncPFBdQHrk1huze6SVEY
	 d5nX1sBPBVdpb/EuWYTmuYIAjcFfzGxbzx7Y0cqXDDxKLCZjHXYQhSjKs7snNJCjzEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FX1O99ZCh0G2FL7iEeUYdNVyrHMqd/QhNyPdG0NJPls=;
	b=q0o5+GjS8GVMDq/Cv6i2W6HcSjo6ocuPYig1nZbsnKswGq6HDzgx9hkKroPLF/mD49Xh
	 HAxOxJAimDuI2ckHbFsEzbwxC8v5PzjT566eIkqVqfK5YsSi6jVDN5Mfpof4jMndyHy19
	 ae+VvaPAucQ3M3aLF9HWMcbk6gl0hEnaPywCNbENidlDnngRy2klbQeiLEdTaOzUV4Ook
	 lrAbx5YNYyc269gBDfUPs4BN9yPjVTpRYArk9BgC76ZmL99CL0bNFHqO36a+k2gdpgs3t
	 GpZKibFf9tLElwK8YbKmjz4y0DfJZMpI/U4G8/MRYHDfw8P894uWsFw1zLxTtx4IzJw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792675918;
	bh=FX1O99ZCh0G2FL7iEeUYdNVyrHMqd/QhNyPdG0NJPls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IAtVvJvA/rtb7Ei1KMvfkxDs7es03zxeDbUswoYUfsngwqvUYMT9/alHViEavBQnm
	 sqJGm2L4slJ/G+ZiuQr3jiZd+FkAFC6ZD9W2jAp2LBj7zySSJxAg/+vmxrmk95/yEc
	 RyPB4EVi6hSaCfoeqrTwOLnJbXvJbnHVrE+8+bFSeZdtbJiNUpvTrP9PqOONJjoaV8
	 DyuMXOKq1W/aZBX6ReeZbOQcpx35OzO++XGjlWZWzvR4d5Zrww6mLQ4y0ArKqz4LXh
	 fRKG33UuyFoH+q6BYwmBA/26Xk46qFQpTfU5eiKQZ7XcXXdeUfLXeThF7cvaJalAeE
	 4vaOyr4kR2uaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D894D40920;
	Thu, 22 Oct 2026 13:31:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A84C23AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 96C036087B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:31:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MQGpZk5w2hnz for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:31:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB2186070D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792675916;
 b=iB6oOb4RzxEG4rbc1at15Rq29cD4wTZ/y3evckNrnI2cILisl9ZGuHhCQthpbjr9/WYM
 y4fvdbQSTxFa5NqObs3rY1QWr7gzLZ1u1gS+Pvr4OE3E1uwbeEeIUiELJZzpHSL5M2dBe
 lHScYan0i7kLPzVmHN7kQKfKdYKCFsCKUFO/09xMvjlb0e5wTeVeU1/IriRcMRFQ4P+d5
 9lSIHJIVu4+Tm9pKyXuOZllihEsUsevNF+SMAxiOVahZhKEKsi2dO0XPwBUotTuz83G+D
 qX5laE203m8cpRXlDS+LGefIOItDEZzePFVue5e5jEQCTM3SfbnJaSSFNqHC2rYyiQw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675916;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=FX1O99ZCh0G2FL7iEeUYdNVyrHMqd/QhNyPdG0NJPls=;
 b=q6fz5YaGXmqcnplyXi4OTSjHSa3kJ3Jjn5Ia4xOhvf74lfqjcSSNXlkIrh4LDajsOzwN
 KW1GbjXSS4yCEdYlMJAT9kq21w6cXQLpSh0MSTcLnclSomql19Di3dkjbXwZ7NXHrn9Xu
 XTmpjBPNKJzyGRgOt6/3vAnfUZ7UUXr63erUqSLIUIDYXF4VCT0l8p4UD6nhZBAJ72Nrj
 981lsihkuWn8ePsv+m1Y7uHa9iDgIig+GYnILaSfY4ea5I/Gg4awR8yY3G31np4WE1VQN
 e5PgVbv0nLCaL19heIiCSV5opTOepx3u+Pdu2mye+MIsCv5shCDShxw3wzovBM8wteA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="hq/m/UpM"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hq/m/UpM
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB2186070D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:31:55 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1e34ecb02so12997585e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 06:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792675913; x=1793280713;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FX1O99ZCh0G2FL7iEeUYdNVyrHMqd/QhNyPdG0NJPls=;
 b=hq/m/UpMzVkamBxwzNIuTzeoKw6zjuTQdl30jUU6QUS9+eFHrirtMtkwvpqB8rWUOe
 5+ULkTDKafguJ98VvSm4eXzCzdFRmIZ7hd0mrgaYVGMYXQKHBpjdddkxcUn9XePEC1I7
 KeQWSFZOdMFa8wkp/BVIs6+E/Q+qdqK00FTkTgoCjENW2pvZdM9Gpj+qaEl0uQyW3dtJ
 CFdUt++l9HyDp4PbReCC7WmOTf39xIAVIv6B+3yTOVPN6GXZaGwNrtHpYlMS5on73vkB
 AF1EJ3qWKZ0HzoNnxTwxf1E3AZJZIZgtLELvZMptUDepWUNpIyaQQtsDXxkKCKQ+gq0L
 3qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675913; x=1793280713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FX1O99ZCh0G2FL7iEeUYdNVyrHMqd/QhNyPdG0NJPls=;
 b=wMIsMk5ibSkJKZpM8iMsnYx/nWxyiUO/gVWf8RAa8vjRoxQP9e+kdvgzu5yVaq1WVu
 uHBgZIV3+K8xlry1i5JqLeH+Yo5o3lcTIxjjdsCcNoH6R+r1V2x+r2nBHOr0MQDtJXFS
 6gUuta5aPmKkYtdseQYtVWbDKd75Oy9NbbsQgJTMaDaUdXuWTlfcSZXUVFl7ksgpBJd4
 skTlRBzC0wMaEsgd5rGpd0dNtASMxOoa9/+xsWVcmNM6lqbRwo/fbpKrs76bpL3C/3EU
 7ayrB4u9idgQuSxeJFXD/H2z7wJWm29vN26R/xXybseMw2LYyg12IwhCFw/xb7GNXFF6
 eOwA==
X-Forwarded-Encrypted: i=1;
 AKwUvByJTPqLiUqSBS9/WMaw25NNrrvuo70TAss8CUo9Iu/rslrGFo5IlGv0Mz4x9R55oOlV5siKyE8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYL29CebKUlrJ2jKEUQg88WsvnMwBuvOFu5Oxu3yoa3fdVyaIr4H
 ONRxDGDQw8Mh0233yg22eTMaNJM1abo6TgkzxIIO9IdQs/ZD0FGxohAF
X-Gm-Gg: AYBFou30fam3TbtgmA+qhm+bkZbicC/RvKBB+Np+nHi65ddr5Zf/MmfR0a5EZ9Ax/VN
 ovlML09VgAhynuwpFbKkClSQSxSoGJ2SJIZxbZdtWNx98G2zTQPjea+gM12bj9PD5obZoFJQ6u0
 KoIYgrfLy1l6GFzanIJ6D+JuC3hOdyKCOH81eDU4EdDaXB2TAjsHIiTw0uY6YhZ0ZLAddE13ayf
 LPZ6/1dc8PgZ+VL7sKLGT/+rVT8vbboL9CbE6ShFhWnGdB7wFhlrdCXfXvqXR103t6zhbcLWkrs
 +NC+6vQIvQ+0iCSpiXmGocgMK7KUys/dZiBLNfCjLKB4u28socC6/g84diNOkXFFMHpc11QSYT1
 vRGGJUufGlYqSj7sHIygM29GH5QtwMcD5amitbvpfbd2IgSAiqAotdd3AEZpP5O8HbiZX64MZWH
 tKRBVGgy1HaiMBuxEfyh2taitZYnB7JAhpYrevOLYIDj3qjbWGWf6t9n9ziIcmUgWhn88QwFFmi
 7AbybxayQ1HCdLXXadzi5wwtiXZ9JCsrOQzvA9aiiOMcX/4UIVRPN/NyXyFZg==
X-Received: by 2002:a05:600c:1086:b0:4a2:e0c:2b0e with SMTP id
 5b1f17b1804b1-4a20e0c2bbcmr4623495e9.22.1792675913278; 
 Thu, 22 Oct 2026 06:31:53 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2038ddb20sm65820705e9.0.2026.10.22.06.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:31:52 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Stefan Agner <stefan@agner.ch>, Francesco Dolcini <francesco@dolcini.it>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: Re: [PATCH v8 10/10] usb: ehci-vf: enable the vbus supply of the port
Date: Thu, 22 Oct 2026 15:31:51 +0200
Message-ID: <20261022133151.3578589-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e1629f68-5003-4549-aee9-cc22c1e51f7d@mailbox.org>
References: 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 2026-10-22, Marek Vasut wrote:
> dev goes before vbus_supply (sort)

Will do in v9, thanks.

Mehmet
