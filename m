Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBCFCD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:36:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F40F8485F;
	Tue, 19 May 2026 15:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jQgFrE0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF627846EC; Tue, 19 May 2026 15:35:18 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B068483C
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dcdd23fcdfso1842924a34.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779197715; x=1779802515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Q2ZnAt918sODsbofZThrOzwpJZv0CiU6CAP+Mykeoo=;
 b=jQgFrE0y0NicMrz3ee7SZ5PS3OeOTHLAtIAFZznYpK5fs9Ug+8qjHLmBhs2IZXGpYq
 BmwR35cvT1ah8TZmPuHdhGl7OG/5xSN1qEOqCEhrsC27DUkC0NW5TFBP5SarzrwrK5Y3
 G4Bb28yCqf2RvCy7P5PG/Tfgokd9urQhEEaFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197715; x=1779802515;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1Q2ZnAt918sODsbofZThrOzwpJZv0CiU6CAP+Mykeoo=;
 b=OXVbMAqvh+fQd5dyNfPRMsMgUMkWq7UvS7GpB0GkHoivQWXmEjf8L5prFFObxe+uy/
 hFmfCWAIxmKrww7pKXQMobFRIOsfDfhex9PEFFN7qLD789wK9PnvYiryCX4FA5JMJuuj
 YV6AeQHn0D+gp/eC0dZjx02IrwNAhDEmxEG1OaFhXy0dBuZVkYGs72QLTFuvP+QoXbbU
 ye7JClyLe1KxuCIV7Xb75PbFDWXZDdPvbv+p2cSGD99L24O8P5fku5d0AFXjOW48w1RE
 sxT0eJ3DUMh62/OBjurJY4X2lEACDg10qVs3F2CT+LRekylNzJjfY1BLG/9tHqVqxYML
 jMYg==
X-Gm-Message-State: AOJu0YwKxVunY+RtuVoM5VUy5wjk6jeOwF3QfatYsBumf+xq+GhLA0uP
 EaZVl7l+3Tmryyj+5EHW1i6qIv93bxvRuTULIC+ILMXBicxtR6DpfJVtGOcKoJUE0oITeCOhIkF
 tD8TYjHOwEWyO
X-Gm-Gg: Acq92OHY42RSbw+VaHHJ36fmyxRLHH+7gXpkXJaMgbbgcJyHeRpERWwATSmA7mXF549
 8moH9mhOsijoR1zBcO5708PuX2lIBZZ7ZwIXTjMoNsuQ67HRc/+CxkOjt/lzAEhgsjAqDN1i1Ix
 C4Fq2DYm8M2AspnkT5McW6yTYDM1nC1m1oJhGy8Y0WWwHtoolOMT8JUFnS2lLSJuRF9AcywZqHN
 lrPCMu0sc8CpRMj4V6BNhDLkYim55rAuaOjwhEbLkxKUz3f79xzO3SmyF3hw475+BQavpG5SSEi
 CFzIWh3clzX+6AkRip04ni2pajidPIk/Rg6uMkXTsqPZbhUKaYjTkp8H7/BgXIWZG5qzB0zKJaI
 cO86b+Ebnw6/hbe3yC7Sg+iZz3TNsAoHKzKcBSRnWHguqMJPuzEpVOPG3IV9TmXD5fpTvRbbczK
 GLeTF4TNlHCmqhT/I/isDhvulYBKrg9N6geAfUb9qqCouWiHZDn9nzyNIKjUKpIAE02UatQ/5aD
 ijb/maBHl9CGbCExWbke7/aQwdKRxAENR7HAnNbgt+XF7xFsGN5JUxeesa2
X-Received: by 2002:a05:6830:6a8f:b0:7e4:4998:aaea with SMTP id
 46e09a7af769-7e4ea03bb46mr12805632a34.2.1779197715481; 
 Tue, 19 May 2026 06:35:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cd6c0sm10826569a34.4.2026.05.19.06.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164248.59353-1-marek.vasut+renesas@mailbox.org>
References: <20260507164248.59353-1-marek.vasut+renesas@mailbox.org>
Subject: Re: (subset) [PATCH 1/2] block: ide: Staticize and constify driver ops
Message-Id: <177919771488.672258.16905438675378098103.b4-ty@konsulko.com>
Date: Tue, 19 May 2026 07:35:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Thu, 07 May 2026 18:42:39 +0200, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> 

Applied to u-boot/next, thanks!

[2/2] block: rockchip: Staticize and constify driver ops
      commit: 64abe3cfcc1e86f3f1957622ad6b6732daf59c01
-- 
Tom


