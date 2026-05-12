Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D09CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D7D84683;
	Tue, 12 May 2026 21:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qlhqlD1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99D7584099; Tue, 12 May 2026 21:31:56 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB0C8465A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e36bb16a92so2300203a34.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778614313; x=1779219113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zYsg1wSX/eGCCMGYt/tMQCpmSmke8iP9WrZYt4eWnFg=;
 b=qlhqlD1Uwn4mTkGWe+2uB44QQIdkjKjKqyi9/pojQpYCOIW6R8wXCQBuOYfRSeXjPp
 Zxqxz4kXShZW3mkKqFbnWDEAhE3s1g0gwfnCdkSvcgqsQnSURxh0RFOGFxKM4oaXodkJ
 0Oic9WGeyzZLgB61yg8zZHcDPekXx1ZsI45Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614313; x=1779219113;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zYsg1wSX/eGCCMGYt/tMQCpmSmke8iP9WrZYt4eWnFg=;
 b=QCgOasf3it7777+W+KVJsK0BtFk+kDZD9fsxG6LrgDa3SyIgZ1vlsDvarDNFgQ8oV8
 bPJU2T1KxQq0f6g70QNtQh11GzpL+eyvVmh800JxKjrKqzZyPlYtqlXmms+KE00mjk1a
 A17yLBe2jAFLzXQqapEwpDq7ouGq9YXxenpwN5c6iP0Ru6t8TtdDABVqr9snicHXPS7g
 YKSe7jZpfbnckLRZCAa0WfaE/ZUtSRMQ2Za6fv8kQmxYHI7gU70RJX0MUr9RO2rOoLHs
 JSXAt8zmOxcjnu0+mVzXmBr3E427TNzSJ1L1EBxIzJ9lprEOVTDAh5/puKDK3ROJLxzE
 4h+g==
X-Gm-Message-State: AOJu0Yxprl1ymkBD8+6oIx++lhlpYBNlhZhNqIRET2h1gpm4McMRIzUc
 ulrG6ncKUvABYPYBqS4yaQZivpf43Ux267hJNiL4nxK1m9073BehXCsOAB86wHdvonwv+f76e1r
 G0fR03ldAvRNw
X-Gm-Gg: Acq92OG9Phez0giaIXCJmjlC9GiJTndWaiHBr15ZuZRQ8A2DqTQiaD6u/q64PnKZR4B
 iXzd/gloX6nyQEM+0LvohsTQi/lbS2QexcBfwThg2wRiTTJ3w0kFnKu0tHLLvPHxFa8TEHE7kdL
 rjexr7Vhh3ouuHmFb1PTjQWmOXdlXIdG08mYzNWWOXOtfBFzkFWbDskNlKSgHZOseccWeSUrj+w
 pQA/a15MPxENonv3Tnit2+3oWmMxiJRzL5hoP8ApSteOzoE2Ksai+PqiWR1wzPLFnqLagq59kb3
 D9B5dCo0uGAPaHrOe4yNyVm61xIVUTppXgw1vYITIFxLgglLSzTGv8F+s8vY/rhnXOsTcyEexsT
 S9Mk5NESF6t+ARG6+b3E5N38qniPu2JU4voKo7y+j43cR1aDUoPNFce7Y22OEQW0l3AekiAgYCP
 76jnck083GYHfAv2Jz6b6ZAWeTmU4qGVyacsyESXkzPonsEQCiFppnH716l4NsO+kSrpzVazpn8
 +29JHeLuunjoHH1/hs1TmfwjGmqDup8lfHgSA2cb4rGUBtieA==
X-Received: by 2002:a05:6830:4984:b0:7dc:e30d:6498 with SMTP id
 46e09a7af769-7e3da040033mr53513a34.1.1778614313316; 
 Tue, 12 May 2026 12:31:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4f05csm10369170a34.17.2026.05.12.12.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:31:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
In-Reply-To: <20260512083949.3493010-1-christian.poetzsch@kernkonzept.com>
References: <20260512083949.3493010-1-christian.poetzsch@kernkonzept.com>
Subject: Re: [PATCH] virtio: fix return value check
Message-Id: <177861431275.3279584.4522787274568961298.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 13:31:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
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

On Tue, 12 May 2026 10:39:49 +0200, Christian Pötzsch wrote:

> The virtio_blk_do_single_req function returns ulong, which normally is
> the processed size, but in an error case can be the actual error. Use
> the special IS_ERR_VALUE macro to test for error.
> 
> 

Applied to u-boot/master, thanks!

[1/1] virtio: fix return value check
      commit: 36d4c653580824b16574560b21d4401614d8b68e
-- 
Tom


