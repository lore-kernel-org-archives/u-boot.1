Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C313C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 11:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7299987BC9;
	Wed, 21 Feb 2024 12:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bqEbfJd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D268A87FDB; Tue, 20 Feb 2024 23:07:12 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E1FA87DA2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 23:07:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bob.wolff68@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3eafbcb1c5so273630666b.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 14:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708466829; x=1709071629; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jPDOowr79xX3wJ+YWvfq+0SrvKgTYJdhxTxPV3KiA20=;
 b=bqEbfJd+NOzanI7DHr5z+bJEoQi7ZzvCWul4zzrk4KZKi+9Ojg3ACE/GTmurBZ5EWp
 eGv8A3j+34aavuQqTe8d4cmRwUTLqyrXTjJIF5w3Cmejr1FcSbB+AR7F+987FRA2QNQb
 I5Oq5Mh/3FvX3d8k3R1TnI7v68eyvchCAaMrMkoqTX/QNdsYnWG9+75879uKkoMlRvr2
 jJCZEwoyRIVPc2bfrNk+xqsP8aDlkxoXZzgJcyi5kbEyZ4Az7bphAst4CeokOkNm9hJl
 /U00QnZDGrnRYS4sJErcFinkPTXtmFm/feNlk/rqXSlR+0vux8gz8/4or5xijHHrbc5A
 o9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708466829; x=1709071629;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jPDOowr79xX3wJ+YWvfq+0SrvKgTYJdhxTxPV3KiA20=;
 b=r0yaxUj7g4uUOrkfNV0byoDF4i0uo/+iANRvhcZO/daLK6x0zl5vDy5pFBvLOa11d5
 q27imeRyei1z08+R5FRcevvBB85IORTn4c+FH+RAvlGkhs7oLk0UzOaVMZANhOUkaKFV
 vnKFVPvZfykfHTgE1+9FKnGW/9rccrU3jwi8xY616iyqUFrBaFjGBuJ0GbGPdaEpAFyq
 8NbM0PjH8RFzk6iBWN8fZXXasY8j1JO0CJeXtJSaiw6cPcCEysSFQTcqGPpifdm9tgh7
 QzxBfBGc+1oXyCwxibU1w+mbXZlxjX/Hd1MgyBwitjB4J9KSkYTkBhRQ4sb7//HvrpEk
 3vxQ==
X-Gm-Message-State: AOJu0YzraklBaOO1a2zMAm02N3l744ubM3q/JWjKNvv1tYge1+QTJlxQ
 kdbadVIxAnzuThr97dXsgRqubhJKdcWTzpfIlxb4A33Vfbr2y5VIcdvPtlYYdhDh59Aqga6ba31
 1Fk+o9AXvGcssrewkPSnsXxlFBWiUrI4G
X-Google-Smtp-Source: AGHT+IFRJGQTrktpdvNRj2aFPluqvwvq0YiQwf53nWuWLNFerwFOF1YyXMmXYJBg9jqoaLRJ2EMbUlINM1a/3CGFmxU=
X-Received: by 2002:a17:906:154e:b0:a3f:2c1:9887 with SMTP id
 c14-20020a170906154e00b00a3f02c19887mr2241545ejd.21.1708466829429; Tue, 20
 Feb 2024 14:07:09 -0800 (PST)
MIME-Version: 1.0
From: Bob Wolff <bob.wolff68@gmail.com>
Date: Tue, 20 Feb 2024 14:06:57 -0800
Message-ID: <CAF1iuRr6q15aApGB8zPb8M7yWrUahT8H0BjDHnWRp1_Q__KDng@mail.gmail.com>
Subject: ECDSA related PRs
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 21 Feb 2024 12:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi there,
I have two separate but related pull requests I'd like to contribute. They
both have to do with ECDSA support.
- The simple one is a lack of null-pointer check that can cause a crash in
certain situations. Easy peasy.
- The less simple one (and hopefully not too controversial) adds an ecdsa
verify driver (UCLASS_ECDSA) which utilizes tinycrypt to do the crypto work.

Please advise on how best to proceed. Happy to work within the confines of
what works best for the larger group.

Thanks,
Bob Wolff
