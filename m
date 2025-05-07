Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32681C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 23:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31095822D7;
	Thu,  8 May 2025 01:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rh9cCi2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1979182169; Thu,  8 May 2025 01:25:09 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE827820EB
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 01:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-40337dd3847so353583b6e.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746660305; x=1747265105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fmq3L0bBzxkCbFCU/pqVJPQjKdoZgd/FnFQgM3bLiQQ=;
 b=Rh9cCi2uDU2YK9Kle8mReXzlDcxH+XXEPIqriqlbh8dcanedlipxaaUopPp3gKKiTn
 I2p9BS4xA7IeTdrQNK0uibeev8ZPv8V2FPKFZQGUqjMiW7HvR3ck7Onsz3x2L0asKo9O
 DYPqCnMRwTXSeXhdQu5VQmSdqmdE7UnwVxd8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746660305; x=1747265105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fmq3L0bBzxkCbFCU/pqVJPQjKdoZgd/FnFQgM3bLiQQ=;
 b=RHTxQRLPftKllqw5dqlSDAPIl3h5gtpNWbKMLjr9mriv6dzxLASlMB38O5+aQbV3IN
 2PjC0O/7J/pqNxPIES+QIKTAbKfci+5kTqZE/CxYBuNQS6LQCiCIaYHkmhtn6SVXhElv
 HIAyMkjgpwbuoLfEScxPk4sELz4YelcezybbMTzl40eRBLCHul1hB4ABMVE0W92I4+1I
 tttVguhmyTusjI8aSCG0jczVFSFbn+GvCLRRIQgEjA+HaX2MuvdkUi2c7mTJbs/ysV7J
 bIM51OgbmHTklCzj/rqgHlXSRJwafzX+eAWsf+fwzDFfqm+PjxJF6msYXjpvWfocFkXQ
 c9hA==
X-Gm-Message-State: AOJu0Yzd09xhlP16JYdX+1nunIgHcVNmxtep/gvsjUCQ7K9n9PsVdMID
 ri+YM0lr7rd/iHwJpBughk760+u4kadiJmP6vi6vsBp/xEFX28S6NhrfMyRkZvAhOdXB1ps4ZiT
 U
X-Gm-Gg: ASbGnct30DAi446i5P/8is2V/tQFTEVZPvoLTxr6mtyOUxBzZqwYEi/8hz57Bz5pk5t
 oRv95ya5sP+kPCNJa2U3DORXifC+jntXnixKtlSfug3k68dQlU6EEE4mebey28f3HLfJy9788L3
 TKH+4XoylDXcyuwMj/51kQGGAzsO5o/ExaEAOKjx3PVxjbpQ947albEtdT7nbOQEkifsUJ0yKr6
 F0qQdTmcWbS9HrUPayfzt3mQ4ItEgqYl0SvQadFk2fuQmrEEsxpOkaSHMCwnRWsuNO3075FwquC
 RE1AgdT7Q/DtOlBDe2mDhFZwpQipw5IdJbZEg8b9eM4dCPynaIN7cJpUDJZ+o9c+S/JyjvYLUOp
 XHMWW
X-Google-Smtp-Source: AGHT+IGShh1JV3sDGVMFGazjd3tEga1+VBjCuHCEBafjw9ym7dmyL1NTOHSs3Y8ECYjzlIV3r5oOPQ==
X-Received: by 2002:a05:6808:10c2:b0:401:cae9:4dc3 with SMTP id
 5614622812f47-4036f06987fmr3651947b6e.8.1746660305672; 
 Wed, 07 May 2025 16:25:05 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4036f3af356sm831979b6e.46.2025.05.07.16.25.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:25:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 0/3] Document more pytests
Date: Wed,  7 May 2025 17:22:59 -0600
Message-ID: <20250507232500.527782-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507221112.518041-1-trini@konsulko.com>
References: <20250507221112.518041-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

As a follow-up to my previous series about adding pytests to the
documentation, this small series adds and updates the tests which I had
been enabling in my labs. Making the existing examples easier to find
will hopefully make it easier for other labs to enable them.

-- 
Tom

