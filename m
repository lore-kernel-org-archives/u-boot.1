Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDD2E95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A55FC86EB3;
	Sat,  7 Oct 2023 22:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jH4Z+XjK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A9286DCE; Sat,  7 Oct 2023 22:37:59 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C1D86DFA
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40572aeb73cso30048475e9.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711075; x=1697315875; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zQzZGxGZhbbHt6K1M9mIXSjXBoB3NHieuWq29SkZhJc=;
 b=jH4Z+XjK6vglHpXoQFeMhW+6ob/2CcfnhA7ZI/fbMltsi6QmJi5YXyhQrR9zQGA+ku
 IvTNDc8WzzgQldUPDzPoWZmOykNgp837Guf1vrov5OGqazs/BmjfMhNUYyqnLeFumuoF
 zC2IiBHCwPg7f4pHq/uQvaxiDBrhAQBxJYQnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711075; x=1697315875;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zQzZGxGZhbbHt6K1M9mIXSjXBoB3NHieuWq29SkZhJc=;
 b=RcjJGU4x9tnaRdl3Mkd7p+5b/16H0jPKQNzWw5X3nSq/DzFsY3U7U7tuYeNCvgDHzZ
 OSbNzvpY00+A87n0Q6+V9fjQdecldJO3294OXcnRIQvUKosv1ojMv6GvxklLLxGXOBr7
 /H3Q55xvKBQzStpPogEeE29NTbosbt9xu5tLhohds7PfwSWnKKCbDYZVCYTFMTsTu42o
 YRvrboPzpU3P+3DmZ0vO3bOdnDOGy732YfkM1Jxu0EQUUzLQAaIIDJcUQqN4AMdNO6Db
 jvR12uCJ2lYgTUE4DxtUFbUAsgPBPesQOrRuWMtQnxXe+RIYC3zeV+C4bJNDWqOjNZTG
 ZNOA==
X-Gm-Message-State: AOJu0YzmEpDel45KcNyK9RejBjzaOCWaDzpA/Q24z1oGufubR14olSqw
 0/GBtUSCtmUBqBg/UkypIbc+Qp0nQ2tEdnE94jS9RA==
X-Google-Smtp-Source: AGHT+IHFSdyMWHt9PaDDkbswlmVzLpwoBoxA5j6YDPjnKXKIRrEyiGdAPURfe6kQw5DLU15CXfmv9LCfr5CEahE7kjI=
X-Received: by 2002:a5d:5309:0:b0:31f:8276:5d04 with SMTP id
 e9-20020a5d5309000000b0031f82765d04mr10469918wrv.34.1696711074908; Sat, 07
 Oct 2023 13:37:54 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:53 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ3AXRPMJSWDFDXuERVrrRowGJgvjufQF21VjGB0zfohVA@mail.gmail.com>
References: <CAPnjgZ3AXRPMJSWDFDXuERVrrRowGJgvjufQF21VjGB0zfohVA@mail.gmail.com>
 <20230923194424.1739224-14-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:53 -0700
X-Google-Sender-Auth: KevHw_MRlrUpzWlORoErA8a2Aks
Message-ID: <CAPnjgZ0P6SErUrYB1fn699YWjr8ehW47a3pr=ome_RcjC+LrHA@mail.gmail.com>
Subject: Re: [PATCH v3 13/27] moveconfig: Correct use of members not declared
 in __init__()
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Fix these pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 4 ++++
 1 file changed, 4 insertions(+)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
