Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D13CA0FE7
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 16:31:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04713830F6;
	Tue, 26 Aug 2025 18:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K0SqbH24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DCC983102; Tue, 26 Aug 2025 18:31:54 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 752F7830E4
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 18:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7452b1964f3so1066062a34.1
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756225911; x=1756830711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qfIHaMFd3ipA+LnRUgWtObgr1G+2uSLSquazoy+LrVA=;
 b=K0SqbH243HXZTN8IuDW5XZTAfJkeg5ciTHANPXHds5cavNHbhM+oFa23DDE04au3BM
 IC93yj7LlAEkTugyGLH8DoA1uD68wMn3McJzX6WuKOr6UcC1URrjO8wAIgOZ+F1yzAVW
 M7mBzxlXICkebBNq0f5WPz/z2fX5kwOvP0mm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756225911; x=1756830711;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qfIHaMFd3ipA+LnRUgWtObgr1G+2uSLSquazoy+LrVA=;
 b=OHsBX7h0uNEHibcxf9GSUvfo8OGTDA0KaY70YNdIN+RUIqo+bmZKb4hQpktYJOeo6n
 YWzm/rxJ/HhXnED0Q6Qn17SKCH4ZRW6oTQCY/zW8meS6kb6IOvdlm06bj5Fl68urafWR
 f0FECSP1QPU8cmAUU3cFQKssdcPhi4Rak2EIO0iYV8Cch2hOvzRShRBcuM3cLsgp4TAh
 5GeFsrWSK5MIfw75szbGvP1Uko/npqGg0uHzOab8skmddodgB+9ibRbKwGjEE3tHceY1
 3iISmGc6VvHJqPGUUpDAEy6dJcuvYaK/drKHaG1lXayU922bP/v9eaoLlCOHPG8lGhbD
 9F3Q==
X-Gm-Message-State: AOJu0YzupTeMkeoc1Jv6jHhqRegfLz9mWvVd5aZh0l4E82j8hTRsnwKA
 F/da0gEaQxPuZBqQQMeTTxnZJjeBs6uiwItQq6S8wkGJqLFa9iaVyAm2LHjbu5SxlvHZ2142dpz
 nWIMO20A=
X-Gm-Gg: ASbGncsTme93qz1HkBmRpnxr10yUFYLgL9nxknMNfnDWCQHts96ATczJ01Y/ZaT4T2k
 kIfKuiUYb67g/UL7O9ceCV7G2L4SW+qXwoBx+jzEz2PgezKRIuwINBGcA/VEeC+4NKCtRI0y+3Y
 Kfognerg5DQWxkWFvRy9k3DClPn47dORpNFQ3kGFdk6jT406HCGes00EphPLbUUTMYOrL2ZmVxg
 jCqN5NBC/rbJKgYbjCABYtXo1jHYjV2yKskGVqzACCwJAyQfInoZJ061rax9FFRcX1dHFbiBc6C
 Vv9JA80jekEsPdMS9m1WOOZjr2LEqZcp/lmLkSMrfkz3BEpqjcEh8+N78dlSiPFSG8rubm9FtuB
 +w0zra0RsGs9XuMFGAmeiWmJDhOs9mq+g9WlwRrVtzQ4MIq2x87JJyLiITMlTNIm1kA==
X-Google-Smtp-Source: AGHT+IGOH4+WSb34fsnANS8S+snsJ5ZByW0SG8Baovk5VOO9uTTNk1bW4QDZ6Qn2mc95FIHmr6vSbg==
X-Received: by 2002:a05:6830:6587:b0:741:a0e9:58fd with SMTP id
 46e09a7af769-745008e60a3mr9106258a34.3.1756225910600; 
 Tue, 26 Aug 2025 09:31:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e28a027sm2436305a34.18.2025.08.26.09.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 09:31:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: open list <u-boot@lists.denx.de>
In-Reply-To: <c535ec44-81ad-4022-bb25-dd5f31fbe36b@linaro.org>
References: <c535ec44-81ad-4022-bb25-dd5f31fbe36b@linaro.org>
Subject: Re: [PULL] u-boot-at91-fixes-2025.10-a
Message-Id: <175622590981.235324.459723257377850665.b4-ty@konsulko.com>
Date: Tue, 26 Aug 2025 10:31:49 -0600
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

On Tue, 26 Aug 2025 13:24:28 +0300, Eugen Hristev wrote:

> Please pull tag u-boot-at91-fixes-2025.10-a , the first set of at91
> fixes for the 2025.10 cycle.
> 
> This set includes smatch fixes for clocks and mmc and one QSPI fix.
> 
> Thanks,
> Eugen
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


