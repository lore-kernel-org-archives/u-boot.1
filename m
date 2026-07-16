Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7D2C4450A
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 23:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B2084E0A;
	Fri, 17 Jul 2026 01:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lPe/Pjgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F264084E02; Fri, 17 Jul 2026 01:25:19 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D352F84DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 01:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6a183eb9689so2235526eaf.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 16:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784244316; x=1784849116; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iXaup1XmoAzp/wpcG3Fr9mtXXKrp92zaRnIZn6KvgPs=;
 b=lPe/Pjgo+rC+wR4HK40bwY/sI9G7IVylnr9ef6tbUKnsyiiFGKqQ7HNUsS95mY0JI3
 Z7fGB0ROZRJ/NeHA7PTY4Sv4fqm8PzmpubyydVPw5sjZsSAKsNCMGujFnxt9ISALObHD
 DKSeMRYvrcxJGcGVoNM+Ge+4VIIm8KX908DjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784244316; x=1784849116;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iXaup1XmoAzp/wpcG3Fr9mtXXKrp92zaRnIZn6KvgPs=;
 b=Xng5Hyx83A+s1DUMbqO5eTewYJ6c0Qauz879GJ8lJQpjdRbIDBHUBQ4grvsxeXlQkE
 aJ3fDFsygKn7EjyI9aXXqOVbx1KmoLQa7xuuUKsM2ZJrTH+eaPdlqoOTSJDIpPIde4dh
 agig9RRCkwQxNKjqG9nSxxTYF6qsWsI7aJz6wj5JgCNi6IjQl4cm8dc2cr3voKud4C1q
 bL7LADG3pqYZCVlEJZ+4iIDv/luqDpzHX0EEXvm2qq146NeQYw3pbXXQreiDRRxSwwQ4
 sexw2Itf3yFTkSVF/cZeBILwriqD5SJfA68P3tSDn7u/qbHTYXXrSiTcfl008GTf6WFv
 443g==
X-Gm-Message-State: AOJu0YxK4gZcKB5OBfkvT2AUCaZF6IlT5zd+pmz7MyuE2JPG0ecHjo5b
 uwSbD0HHOL7d0xK3NmH2Z7IM8aKmX4JUIvffH6NMxFzAQhX85l7PYAd3AemyZMcj62c=
X-Gm-Gg: AfdE7cl1+oc+GeKPHXl8hXACPvDA5ny250wsCfnh9pltZs4SwT/YNuk5aCN5y5iB6ky
 66uJ3vWmWvHQK/IQV0DOsc1xjUNEnRfoOuybxMeo26eWxuAXYG2svBfq7vaMIzh8TQAuspBJ1xG
 3k4+I3WpJf3rXhTeIXscvkp6AZObrdvHMGGago7RHjcPqaxj/tOqA0aOfS1r2iScgdyqa9OW2gd
 +53ORbJmc7aLHnbKZPwfTfzvkAmbk9cLFw8Mfo68uH+q7o6CiMunz/zCqriKQy81cUagFkGAxQc
 sSpTrBGCEkj81sbDlkMzG3pyqUH6h1AA5aDz+hAPtJINnU5RrB1aEr34IQOn0uaHkXi1aJWb+/Y
 ikfvssrAeyS7+rkJo8Q+T9CmOtfK6vk8gC6o+coPzENszAgk6mU/WKO6VXoIxV6PtM2tEdPn2M9
 rNf60soA3adCvvIt9lVVlkQ7OmXxfAL685ihLHqZKOBdT0KcABKs+LO5+YKB/MOaEdyg3ZAmPPb
 ifbKWzphZwBVsdyDEiq3xz5gO/DXzw+ipB/
X-Received: by 2002:a05:6820:208d:b0:69e:df26:ad45 with SMTP id
 006d021491bc7-6a47b066c2amr837404eaf.43.1784244316604; 
 Thu, 16 Jul 2026 16:25:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568da4ab47sm27308fac.0.2026.07.16.16.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 16:25:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
In-Reply-To: <20260706-optimize_cyclic_run-v3-0-06ecbd74ef7c@foss.st.com>
References: <20260706-optimize_cyclic_run-v3-0-06ecbd74ef7c@foss.st.com>
Subject: Re: [PATCH v3 0/2] cyclic: update and optimization
Message-Id: <178424431526.1470194.15086845312642949417.b4-ty@konsulko.com>
Date: Thu, 16 Jul 2026 17:25:15 -0600
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

On Mon, 06 Jul 2026 18:06:07 +0200, Patrice Chotard wrote:

> First patch is replacing uint64_t by u64 as suggested by b4
> Second patch optimizes cyclic_run() to parse cyclic list only
> if a cyclic function's timestamp is elapsed.
> 
> To: u-boot@lists.denx.de
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] cyclic: replace uint64_t by u64 suggested by b4
      commit: 08af4faa0f0eac4622e52e699729bd157d6d806a
[2/2] cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()
      commit: 9c1b13b3fd271500cd8a61f86816d822e4852a90
-- 
Tom


