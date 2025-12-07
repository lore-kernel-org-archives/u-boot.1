Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EFBD1CDC6
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 22:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A37D83AAD;
	Sun,  7 Dec 2025 23:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TomTW7wK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65FBA83A5B; Sun,  7 Dec 2025 23:19:48 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AEFF8399B
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 23:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c7660192b0so3149942a34.0
 for <u-boot@lists.denx.de>; Sun, 07 Dec 2025 14:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765145985; x=1765750785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/6KHGtZtzjBymZj1TTZ8UuvlwDAY0QyMsQdA/SeZCLw=;
 b=TomTW7wK0xSeuMknrH0mDG741GsJshuQ3xGYJlwjj+WOysn8ipmFA7oVAN951zK7i1
 6t5+eFrtlhf30xHYA+CVimEgKX2pNidfzRg1xLZw6xrJuIDAmtsOxIJQWfQ1i2N6dt+8
 nUMQq36t7E64n14VDQGpG9C0rYE64mQ7IiRS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765145985; x=1765750785;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/6KHGtZtzjBymZj1TTZ8UuvlwDAY0QyMsQdA/SeZCLw=;
 b=Zrj+Dh1M6gKhrVpMtwfyaWf0K168O7TZyHRouB7vjSh/lqanOvNAsq0XJ1ECv3UvWM
 Hr+Syz+xeOwAwRrBc232FyeS82hsv+eXWJYahal6qaGAeBLvygp2QaSAb5guX61PUQF7
 IiP6bgMQDwPmQ7hQA5O0Le7HZRT4c4NO7U5/5YA+Hi+MYWzQXINXyE8yeOrMDFxv15hQ
 02xFcm58uPbYqF/wcTGR2QuRRRY5yJxuuZ19yHnDrecVkm9mYI7KmlbGMCpZ4M895WaI
 XM6glv9KtPYEYKHsLKdd/ZWt2/YFMwrdoWd7NbQGLy8Vvi8abTqxqwWdihJuBSNQoiHT
 X/ZQ==
X-Gm-Message-State: AOJu0Yx+RXlZdOdi10s8EI9EbgP75DPYLflStLJOoVsVzEsd1y9/bBAQ
 FLSetTRYp3JvvdBMhVZ4s+jv9Vn6Rl9d6pijKYYnFtC2Qh5OZ6yJDTUCIx/25r2/HsIaaIXhLzL
 KMpjhgtw=
X-Gm-Gg: ASbGncsG3U6dyc//bpqMgujfu0vXuojUWLLk9Vt+IIVUPzqzo3Jz5C4aY7yNEz79iCG
 M4HWQ/iF+U9I+V74xOmuVXNDpTCxW6E/O9nl22Zb4QIJTXb190X0omRnuSk5N8+VuGc59EritsJ
 XuV6ohllxKMdGDQEPkBwKT5Z1vZY5U2/ImbSIw8zgThOl/13pIWqC78b9JQYEYkk5pk3xnxch8b
 1IAntVwcFofQDVEDlrqY0rvzShE7o+Ra/2SdaLqCP0VkIMzNFSCigR1q8/OvOW0rXfKWjNdlYek
 vyEphcXa4f1YHnIQi7Z3xpfRPK4ZKFzHyf4Q+v7XTgsjTEaGgZRg5PKRLJIozEd4XsKaUvgHSTL
 EougDp2dZtzz07zhDwM6a9ZU7BYsMhGZCbCC3NdALjFMyMreBzIHSc+wfSuOZnYdzJuOLMxAlI/
 ZIX2I5IwU4nQAu1HsxlFV716fMXZKUpHnaRdC7M1UTE+V+D0+v
X-Google-Smtp-Source: AGHT+IFFLW99i4N8cMau7M4PPJF+J2fmpQuiPeqWvXv24dxP4m9AsbGNirQ4iwgStst75PDgsWdiuw==
X-Received: by 2002:a05:6830:4391:b0:7c7:6063:8e02 with SMTP id
 46e09a7af769-7c97078c055mr2735250a34.6.1765145984974; 
 Sun, 07 Dec 2025 14:19:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acdb599sm8634803a34.28.2025.12.07.14.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 14:19:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251126234959.3909571-1-trini@konsulko.com>
References: <20251126234959.3909571-1-trini@konsulko.com>
Subject: Re: [for-next PATCH 1/2] Azure: Rework world build to directly use
 the container
Message-Id: <176514598416.2987146.14484578273077405008.b4-ty@konsulko.com>
Date: Sun, 07 Dec 2025 16:19:44 -0600
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

On Wed, 26 Nov 2025 17:49:58 -0600, Tom Rini wrote:

> While we had problems historically using buildman inside of a container
> when invoked directly via Azure, rather than calling docker in our
> script, that is no longer the case. We can make the job a bit easier to
> understand by running it more normally. The challenge here is that our
> container normally runs with an unprivileged user that we have populated
> tools for and Azure creates and uses a new unprivileged user. Copy what
> we need over to the new user.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] Azure: Rework world build to directly use the container
      commit: cf3d4da03f3a51615350f19094023947fd00d08a
[2/2] Azure: Rework binman testsuite job to directly use the container
      commit: 57753073c1965d907f1d0fdb22b4e9b55f3ceedf
-- 
Tom


