Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA98E6FE33
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 17:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 661BD8899C;
	Fri,  6 Sep 2024 19:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HlSkWcaE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC2FB88CE8; Fri,  6 Sep 2024 16:54:25 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBE0488D1C
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 16:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikael.pahmp@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a83597ce5beso347491366b.1
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725634463; x=1726239263; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zOUkQ4PZPlPtEBdVMYFb6LkDSg/HTKOPgISvpjV8l3M=;
 b=HlSkWcaEUNiE0bj7AYJj3OWZ/ArAB4uAoE/Op9aAoMvc5hj6wPNUGKI4UooBgNCuT/
 0SZYC00DJOesZlZi2Gho947TYnoIeHZp6p/vTRcuM3pRC0zal2HLrNdI6Wftv5d5Horm
 gObZB/u4deWBfRRu9y5xjB/gmYINazXTRFMrOaE76cY7+ROLTEgR8zzrQcUcxTy7yxho
 5wF5iPoTHlJFOtkASfYgErt2BkosFIZ3h69czz+6No/27C9/Im9h4RaBp74J3sodejre
 /zNaT7PsBXC8eitCCC0sOhceHpwvcBsOQDvQyVDOw/5dRPpnTE+SYkJUyOL9WT7pmfIz
 0okQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725634463; x=1726239263;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zOUkQ4PZPlPtEBdVMYFb6LkDSg/HTKOPgISvpjV8l3M=;
 b=J/gHSLVM3CAjjnRJHreJhz+tMmWA1lr/0QVvJLPAi35Ai4834l8nd/w06rnqkjGnhB
 NQCdnnptcwebuZFjhg+AJOwOjvD4jqfy/Z7iFIlds6SqhmMGmsuR96pK2f6YE2FddyMb
 eZnU+x/sv9adMvFTv49BRo3mfBKoeetT3TctaQLZXW2mAantnVrkEczNcKCV8smxNVPO
 QwB5pbX4ERmaB86ADaXDb2FOXcvIOHI1mJWjKItokbCbdgWuHGVvCApEBnzWGUxupLGK
 Mxi1NJNYfBkm46SIaYq9U2nCug3bWCOfjx2P6JgqzJMrEoSwQdLPcq5tRjIJcIwhXsTW
 u52Q==
X-Gm-Message-State: AOJu0Yxnpl3PS9YyIBrUGnMDHFl3BSK+4pom5aofHNtz1OXeW8UYtQ2t
 61HbC8eQJTj1DFF8zQIa6FN5z2zZE08D9SsloqslU5mIDgu4H6g71mqckWKZcPQmslnxSn8fvx/
 sm4yE5+QaKfZbUREn5rs45oSueQTemOLTUnw=
X-Google-Smtp-Source: AGHT+IGt4KOFW2yTp3Cs7u2WxXpoIKupLbgz8vXbMhpJilTESrPXSN+agvjxTzgP/hafmRiPcdI7LP62a0fHH72xm1w=
X-Received: by 2002:a17:906:c151:b0:a72:7ede:4d12 with SMTP id
 a640c23a62f3a-a8a85f2ee48mr309012766b.5.1725634462349; Fri, 06 Sep 2024
 07:54:22 -0700 (PDT)
MIME-Version: 1.0
From: Mikael Pahmp <mikael.pahmp@gmail.com>
Date: Fri, 6 Sep 2024 16:54:11 +0200
Message-ID: <CAHWDVAm=nKWzKEa4nTc--ZZ-CAQaqso3MK48pGeK7_BUMvuqhg@mail.gmail.com>
Subject: fit signing without access to private key
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 06 Sep 2024 19:06:02 +0200
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

Hi. We want to sign fitImages but our company policies does not allow
access to the private signing key from our build machines. Is there a way
using e.g. mkimage to

   1. Generate the hash of a fitImage configuration section?
   We will then request a signature for the hash from our enterprise PKI.
   2. Incorporate the signature in the fitImage?

BR / Mikael
