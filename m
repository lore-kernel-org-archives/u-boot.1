Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE4EE92FE2
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 22:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A2283F0A;
	Mon, 29 Dec 2025 23:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l/1cyvnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08FF283F26; Mon, 29 Dec 2025 23:37:26 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B7183EC8
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 23:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c7533dbd87so7042240a34.2
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 14:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767047842; x=1767652642; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JED+bTPFGYwok9V8VC3/DTPyZhRQetWMapYgJSKsmEY=;
 b=l/1cyvnfxtgTJTwldC2w5uuZ185uYw6383cIvWM/xJ/dx+vTR3yfabIPlHS5i6YR6k
 fYeit8OeHpT7UkwI7ieA5GSIojcMnA9Izo/04Z/5lhp3EwwjVxC5/XpAITBY608JAVe9
 PSx0IDIGCYB8mU2bMvYQmaQc53/BHPOR6iVPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767047842; x=1767652642;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JED+bTPFGYwok9V8VC3/DTPyZhRQetWMapYgJSKsmEY=;
 b=ZGQCM9Ppd0LNmxSdT0gcD5hb9F5D4NDKa8izcA2dwQZDZNPQqFwEuE9JOuR6yrLvkF
 oS1hT4huu1Mnz/hJKM8kX1betUcGjWF8nKG7G+Z9STwJndTki66E5TqR9uUIO3Trpb3+
 5nMCbikmu6Xe2nvKATPFUq6qmycwxLuzPnOykfHAwq0m6iikkGiIGvvdKLDWD5jQgm1W
 86aVtlVBxrhlSggkqphQLj+k3uuIJRs6HzETq4ZuuaL9BwBJIYQCk2DoAHUowi56DjH8
 GiJQR2R2JpGghS6qhVmyUHggBCsG9QafI+pYgfPL0BDTiZc5oMIBQOa/bnHh/PtqNM7C
 olzQ==
X-Gm-Message-State: AOJu0YzxK9vtw1H2LxV+YLJim2BMNouCQyYSl+sNjZ3iIUIcMJEZD84S
 cFeluVagcNLWsX7gswFvLF/piy9PuX+OuFK5n8EEgVCs9Ew+r/Og42AErRjM1m8OKAY=
X-Gm-Gg: AY/fxX6ZKBizVjEd+82hVjolaZ5Aoxw4exRYQGxEudYBAxpZsNBMIQTc4YLIOtoiJf8
 MTLcqmKb5qP/elDfWrSq7MSgdyk/kWaaw3DsaruW3xqlb1vowh5U+V8RBVl7vXn+FXd0UVmU+07
 o2KW7QAYlR0z/YTb9ie4fLyLrdioi32fsxPezbdVtaIYJHOz4K3gv0YngPUnKHOfR8QdCehcBAt
 LQmJvbfyUf3xICqtQceVZ8dJhfT9UZLoozljjzmntLYGf90q3O9ymMGJPVQduaYtykYMpQflT/X
 P5/dGwTt+B66o4C5iBACfLd+wJD5WBijKxJNbcLnKsHPGSzevAhr5/SjDx91W76wFWXyTtFCim1
 BnDbY6SB8xIoF57+mN7eaCAkf79qIDJT7GkpfUxxsLEBgEPNeJ7pU+AMkBJjcq6ZM78dgeC/G3Q
 X4MS/77yA4VZlRYM+z9DNUjNx9hiVtUC9QdDGhSQpilROv6M80m99XtXfJYvyqgF0qRRSLnBZqs
 CgoD4X+RXo09kb66TdliZLgLo/GeWlmusEFew==
X-Google-Smtp-Source: AGHT+IH0kDbAomg0MPNiX6K/j4uzhhoaJkZSAB/r+L1rFrOn4hlZb3EglwmVIgXhmdYZT3X7grSn1Q==
X-Received: by 2002:a05:6830:264a:b0:7c5:3045:6c79 with SMTP id
 46e09a7af769-7cc668bdd63mr16823347a34.1.1767047842117; 
 Mon, 29 Dec 2025 14:37:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667284fdsm21623639a34.2.2025.12.29.14.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 14:37:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251229181523.3450679-1-festevam@gmail.com>
References: <20251229181523.3450679-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-next-20251229
Message-Id: <176704784133.3602672.17304390055851398654.b4-ty@konsulko.com>
Date: Mon, 29 Dec 2025 16:37:21 -0600
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

On Mon, 29 Dec 2025 15:15:23 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/next, thanks.
> 
> The following changes since commit f24a2124d26eb6b1aab3b20923359ede80105a8b:
> 
>   Merge tag 'efi-next-20251225' of https://source.denx.de/u-boot/custodians/u-boot-efi into next (2025-12-25 11:31:11 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


