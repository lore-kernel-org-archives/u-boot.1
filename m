Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C4606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eisF49At;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=umcNzi8e
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBE996060E;
	Mon, 16 Nov 2026 07:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-v_-lSr4LAr; Mon, 16 Nov 2026 07:13:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 30A9D60632
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794813226;
	b=bmdYGv6PRw56DSOL7U/62QKBrEaqZwHnzMG+AM6F3LB2HOaFuY61j/I2qeGdavGrF/9x
	 Qas6iVlEgdgmlZhbnkgcfx0muN35a/Pyg5VVXlSY9nLmu7JyCY6IDwtAesm6/vCea02te
	 Z45uxzRHnzlQDem3oh1Wi0Q/LtnTyEBL67lF4Wnfws3H5KfaX5jXTniEWci+y2SwM4eYd
	 v8ya03vBdeZudiarQ+Tf1P8JC/PUgX0fhIIGW8hnDkrwUOEpFf5bp7kJbGM/iEJuWbTe5
	 r+9qpTY3DzZRbiaVG91PZ3diqg2d4mBHt+oOh9UU89F+52+Cy5F9ResqFZMFV5IA1LQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794813226;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=74IQCusy55sAyi9RKf+Mk0X1vm7nwnoAYGaglIe6noI=;
	b=XhnWq+5AQlx5sm45asfU+AhD+794ctb76WjwH8wDSF0HPo/wO+mL/Zks1oqpjJ3/wYnE
	 LDZHYYJTV3ofEyasT/2y7WlmIvssjih0v+gbPqci6Uoib7QGi3wBjuTUEQ/C1EG0sT9Xl
	 gt0yaoXCBb3yhaeNBphY+zWNbsMGWE0CUB4Y2EvXgDsXUUHZRuk/rfrnNinCMFG71d0Rw
	 F5XSoLJ9r6XpNLYY8kBWGwPSnSMCskFrKCoZ2dgYnE26V5U3316ObxLed7WvwZYIT8YIt
	 yR4ArKbPkOG4oWvEBaR6tRDm9/rN2jNCnHJMKQTz9fX093QHFUD3KY/SvuPZzxDlxnQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794813226;
	bh=74IQCusy55sAyi9RKf+Mk0X1vm7nwnoAYGaglIe6noI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eisF49AtzfB6zowyURioqRq0MQqAg7DtfdHHYM5tIHKrns8LfV2ErY1U0nK0BItPB
	 oaK2z+WepD4XGh44ksQ0kZ21HK9F3tHHwlNGmvY8xasijdCYXBWHAESEE2fceNJdGk
	 hmAxo1SxbX/O2MdIlhgnqGzdKzs3IVqm247hoaOGs0muZwGP9Z+xpetEAQ+ymBVZhl
	 qjHRQilDnkBx9wpt59/bdQbXhXz/knnAgG09eqKgSZM67qAV2dTxVc1m7VWcyaLyrI
	 5hLYo0Z6nR/dFJVu2QK8FySUHFFymI/kqmHB3fZ+0aO+o9Q2FGh3f08dFxTUjEBbFr
	 QTMq/g3+W3ofw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30A9D60632;
	Mon, 16 Nov 2026 07:13:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ECC81A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04AE84062C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:13:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WqAWR1qmy9Vk for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 07:13:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62BF340549
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=umcNzi8e
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62BF340549
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 07:13:43 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ea7190aea1so10471195ad.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 23:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794813222; x=1795418022;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=74IQCusy55sAyi9RKf+Mk0X1vm7nwnoAYGaglIe6noI=;
 b=umcNzi8erkv/GKjBnqOY6d7scds8AuTVJ5YnVZN780sSuNm2CW72DadpS7AFebd7R9
 bx1rd2aXLPy8wfRBYQnLsx2nV8kNBaFelCiog+BevtQ5RshkV2HpOIjnWcfCH7lOLjcG
 pZxliSmxGQenOl+upLpVXeuVpkzgpkY2sAbXulb+711xOCbmxoXLvzDOoHe54wdudRgl
 B9wNG0O5rar6ZQcs6ijU8dhyWjE9XgELWts+3oOsYWcSfzQxZCpRjtCyJzE4jnVLdPuS
 kxVj+XcNQjL0R2znx8VzQHpCiRZ77x3zLrB+xRLAKPUaIcaCwNm20Rks4tcZkiz4r/rh
 JETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794813222; x=1795418022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=74IQCusy55sAyi9RKf+Mk0X1vm7nwnoAYGaglIe6noI=;
 b=ZI3pEVVjesGVxb6K71YK9kc9HF5sPtAMORVeiXs0QyVFnMTHck9zbWQZI7RlBFpCsM
 ercfw63chVYjyqKgXjheuK6cPbibbiCMROXKFpSQxls+WBxEUTIc1kkf2nyillkmHwG0
 vwZQgkd1G9//VE22ZlQiEwSSCLgTs3qpJFHwp5fibjSA51RezWrQ0fefS+zp7oUc+Yuq
 LsnBLVtbA1DtMWPJHbSScZTpmnEhhM4hdk6F6dGY2s+jInB0c6Wcf5xseLNaiHuag+wK
 9aUqpJX1DKjtKCb2vWTX3g0ur2EhegGI876q/AacDjwMsND3m5IcDGJs4jQIuq8Ov2IP
 IxPQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEuU1QRWeVVjWsAbN65oVdItlyaAUqe71apzg9udspWCPJAPltcw4DMUQTOc8Qxjm5i6duRrHc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8mg6OmrqcJeLCoAR9Zq7sjRyISJ43kd3ZlluHQYdcoUute2gg5
 QbRxlPNyMs8ItzI+WISiPffuvD1lAdyLAErbmj/R3ou6cj5Z0JcBiMZV
X-Gm-Gg: AZFdTZfYikun9KfcbwQKr2QY9GujmPlth3HrK9a85DsiIq50ojmsP6jM0tJIVEWLp+z
 WRT2UHqIjaeLBzFdZWbEMtaQRbd9NEine/os5jZLvNFpPZHd6LoHmXzRO4xAg6kypuE3F/Sr484
 Lrf3oHyTtlel0+W0QlQGnN48C7OSaBuY6GLffw12HEoJhrhDuUMx9Yp2Ro0sV66ioUM+CXMqg31
 Ub0lX8oM5SR4oxo47u1a4nm3TKZ0T91Xl+zGMTgxbA5C+kGauUO44ivse94rXTyHNDIMFv3dptN
 jfLIMweUbE+9aqUSNUrtzHyVgYQLOBxA4ZG/9hCudwMGWa0tsLKU7yGw0fWPy8pRU4mRrmbmdMY
 C6xZEcpfOoOlisVS9JEFtbUQMzBk+Vu0STgdOOU0b6JlmyVB4NBS5MmeXAAlhSvs9ZTfTfvRwlp
 4x2M8lK0adKDICaLChLfkaVCG0cyWfNLaHznypPoQJ9IdSdL9jAARoJrCGr8prckAmdnr23ezZG
 iMtXpkBvzk35yf1T8/t8sSU7iIzmrqAJ+1h7eQncwwVRL5vUCJ+G605PfN5giHGMzt4OmVNFgRC
 zOWyVHuOEcLSeixM8G99fMOZnekHgt9aFkrDB/AIv7egvF4kZ0AyMov2GxVr9hN9YU2WV6mzRXf
 4Ufuo391v8Fk7y/a2uWzE6iaV9Q48K42qKDaeHCFJqiI+tqgIgk0RCHUfiLAuVqe1mfi3Ubp+wm
 EHO9nxRPeefw==
X-Received: by 2002:a17:903:2a8d:b0:2e9:58c5:8c68 with SMTP id
 d9443c01a7336-2ee0dc95826mr87606575ad.54.1794813222441; 
 Sun, 15 Nov 2026 23:13:42 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f85b957sm34348655ad.45.2026.11.15.23.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 23:13:42 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Yixun Lan <dlan@kernel.org>
Cc: Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>,
 Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: spacemit: k1: drop Huan Zhou
Date: Mon, 16 Nov 2026 15:13:38 +0800
Message-ID: <20261116071338.2637100-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111-01-maintainer-spacemit-k1-v1-1-2b3de5f34954@kernel.org>
References: <20261111-01-maintainer-spacemit-k1-v1-1-2b3de5f34954@kernel.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun,

On Wed, 11 Nov 2026 11:01:09 +0000, Yixun Lan wrote:
> Have talked to Huan Zhou offline, he was not active to review
> patches for K1 and wont contribute in the future, so adjust the
> entry to reflect the status.

Reviewed-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>

I have a Milk-V Jupiter on my desk and have been testing K1 patches on
it. If it helps, I am happy to be added as a reviewer (R:) for the
board.

Thanks,
Hung-Chun
