Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF40D116EA
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 17:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 755F683C98;
	Fri, 28 Nov 2025 18:41:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CJQ1nrY3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D20F83B24; Fri, 28 Nov 2025 18:41:31 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E592A83AAC
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 18:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6d13986f8so1383170a34.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 09:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764351687; x=1764956487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5YWV9o0sXmFxa34N+wfuRWuKyJqUEzqA887yfpwYOg=;
 b=CJQ1nrY36fZVAQ7yBN3byFYPz2pOgh8Mv0i1FJVzhjrOaFksUqIs6kTxzXqJzkEPGy
 CmlsSFHL0TwHHKJ/A+6QTvb2hzBkNTHqaBXtUGXEShuGnf5m1BYgy9mQnhLM6+3aLLHO
 S7hkK4n8LD51VUbMQ98AG7awjv9/lEINOd1nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764351687; x=1764956487;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E5YWV9o0sXmFxa34N+wfuRWuKyJqUEzqA887yfpwYOg=;
 b=K6nYrSEiFi/AT698rJwTsJaRs0UqhYg8r2jke/EJ9w8mi5cF2dh3CmGbIwS16xkxQy
 PzFrtTYtKJ+qS4qDjQyeBgQuBiNLo5Op7TOEVGPpS+aNHQErhzWKYQ6UFI1bqy7Agqvg
 ifUB+X1cqlI4ijw8uwIpqhnJ9HTqwh7u3gOKjc45Qbl8OFbuziSLJYeHaCzeJ8Eb71Dy
 3Y3yujC4tts7GGjaow/78Nf8RPgwpiekyTxRdCEOR3C9Jz3x4Jfi/FMeU+OZDUtJi8DT
 NX+jBRC+uVrOl/ePX6AKZRKAuc5nJzUBmD7H6gtf3GFeKAs+kMMBo+OvvJNgeDgLz+Bw
 iN/A==
X-Gm-Message-State: AOJu0Yw+7rLVpe7rd8S2rB9wf0jnlCUOlluVFPcTDEpdDdL7otN5pNZW
 r89uWfdvujL3H7VrWLTLMqLT0PnQa/pgkiCdW8SVdwjkgfuv8j0Nu0Pndj28Mt+uqT8=
X-Gm-Gg: ASbGncsVVa+mciCba1MjDDYueceSzrGPoJCobofP73/Xo9ctSWiViyCoRXPJX29EAhQ
 gWKT8vglpa0GLRujAdo4eQDt3qk8iuA+I934VBHSmcuGHcHfTggDXGCPYdycnMwSpEaKcOIfsPZ
 ngwRg1vlBzuNWpKmT6Vxi3vYT0itkk3IR1v9RrvgqULpmExXQNeviMCBMaxPVv3j3ZUKf0SD82s
 CuORWRNf/fIsseryVimns4y6SVtCpRH81njxsnpPPxYrQrXcSDeGqwGE9ZNIdvTt5uKVtaDBZfh
 S0F6zO4lKcWuO3pki05X+dYIQy9JHLmCid8rn5NPegmMV1Yqv0rTwiXsPZ9zpt9FKTxLxzNSwU0
 PuZaCsUKlZCPDrWFE8Mzv1AYHdvF6CsIBBDsc/GnsoCWPn2j4/znw1bEfa+ILlIdfbmBRKv+rpB
 /M086nWNKWrmLJpEldbR3oFyiVupUTCMFcOqykrSACS5w+jggVdQGH4uV+pVI=
X-Google-Smtp-Source: AGHT+IG22sotz8TmzjKKkpA15d33ZifxDUcLKSV6vGTZsnCGYaWfjQDKUkVhShhz3DfNjW+a1LuoYg==
X-Received: by 2002:a9d:62c6:0:b0:7c7:ad8:68b3 with SMTP id
 46e09a7af769-7c78eb1601emr13146130a34.14.1764351687718; 
 Fri, 28 Nov 2025 09:41:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90fe0f650sm1771543a34.23.2025.11.28.09.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 09:41:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>
In-Reply-To: <20251116001934.675130-1-marek.vasut+renesas@mailbox.org>
References: <20251116001934.675130-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] xtensa: Fix big endian build
Message-Id: <176435168710.233357.4875955417884944243.b4-ty@konsulko.com>
Date: Fri, 28 Nov 2025 11:41:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sun, 16 Nov 2025 01:19:01 +0100, Marek Vasut wrote:

> Make sure the correct PLATFORM_...FLAGS are assigned in each
> case, consistently. Assign PLATFORM_ELFFLAGS for both LE and
> BE case. The previous PLATFORM_CPPFLAGS makes no sense for
> these particular parameters, which are passed to objcopy.
> 
> 

Applied to u-boot/next, thanks!

[1/1] xtensa: Fix big endian build
      commit: 534eaa4d4dec9efed662189fd68f78b3b7b1e636
-- 
Tom


