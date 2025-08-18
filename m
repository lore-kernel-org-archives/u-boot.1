Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C9ACA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ACD1831BB;
	Mon, 18 Aug 2025 12:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tjeRK72y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E71B829E7; Mon, 18 Aug 2025 12:31:36 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FE04831C8
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45a1b00e4a1so25994455e9.0
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 03:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755513093; x=1756117893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/0i53R1iAXFuK7J5gcLyaKAuHtUjwizXbFgrWjnS88o=;
 b=tjeRK72yUwE566TNKXomyht9/xEpl7iQtftKC/lJ+LuIDMX933HVKLhUmAf5Eze+80
 N4TZU3N+OLNzZhXFrK3AOQTHKE2BoVNYLkZqror2oyYHUWHfuXrfuE2i+v2465aJapS8
 W3Gc60b0PgwnNaon3naWa/+c5kR0YdSkwK7X8W+sLHZr7do44Zjy4VLIxRsLzQkbd5LK
 +7tiNyyQNa4Mfrl2l/g80G3msWDMh+1psFuj6+8JyURxR2IzfE8QPSOs+NL4SRwL4T2Q
 4lftyGUlvP+6D6238ftvikaxJyBzXP1LpulgnUclLGYNCCl6ZW4Lth4CDHbCqIJC0Qsq
 mCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755513093; x=1756117893;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/0i53R1iAXFuK7J5gcLyaKAuHtUjwizXbFgrWjnS88o=;
 b=b8uXHk4IKQjNlCxA4xesoHBC9i6qLA1vme6Ng2tDG1F5RpiHyaaEzJNicxlHKSWQmW
 +jEX3ATmeZdDdY38PTyJrSik74JEPQynHs0i0+iX6wW+99Ju8lH6Yqt0aeLU+TQMawOS
 l1SNK5aH6MjAC03faMKs+GFGeyi+7vyi6bIp3gkckXV3m/xFRzS529/RTCBtbHsy9/XY
 m41i0ADN7L8pRP0K4imPPvJlPdqJ5qJCdJbBRSso6tmGM1iqsEgbPvGfqB1Kc4BDv9JH
 cgz8aVgwcTkkHEQmr9FhndglrI0lRZ8BiMj6SpaHtKA1MHawjbZeRI7PasnzQiNyEvuP
 WRHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWObQR/pZt64pqP0y7z2klLusquPP6f0w4hhVKjrtBF0Uk2HhvCTE3Q/R5bo7YaHva68aZhVtA=@lists.denx.de
X-Gm-Message-State: AOJu0Yyk83DbGiu2NhEJW2ZpcCzZuHMpvVlBnyBHdsp/xxaHNbRcdryc
 X8sfa8NqcmdXSZjImuvxD4m9tzKEHcc7g6N33iatilLdTHYIvPTS6jPbHb4WUPkPWoy7nQsPKuP
 iMUvj
X-Gm-Gg: ASbGncuP9LKxt6D3BTG4RyL9SDfH+OpYed0I9PSrOFGCn6+7cOrcfIHlzT/f2xxwXol
 /dhLvAvD151FNX0nplB5SbgttVOX8dCs3Blb98r++FIK22+1wFzBkevji0RQEZg7pgA2kOQpDgO
 tq5YvzDFPv8RvQ8IhQht7n0Jn60VD8HileMQNrSJfOlA/4V0+h88z2HAVGfGL6nlXb/0E/dyQRW
 262nt75AkSRuKDjiAfA4s5XpFqDMBjiIKbLZWbEv/yeNYw1I6DkTH98UMVydmRBzSpB8WFcLt36
 9HQNhzW/i9ARg5mT8MnxJcLS5k7Hkt3rlvNfAJGNf8KBhzduQCgMLe5aoru+6oBnTznwhNkP8c2
 l71CVy9WWgbMNPDTZWaEQWmzrpiGUS2ymtZ3odqK8Q1rMwj4pwpl2vyVdQG6IwsNb4jk=
X-Google-Smtp-Source: AGHT+IGHj5MxTwBW9YopnV0saIJ9O0euJC3syNJ7tu/Z1BemJxD81NUY6oKkorCQ0c+Xp44fM+xsPA==
X-Received: by 2002:a05:600c:1388:b0:459:dfa8:b881 with SMTP id
 5b1f17b1804b1-45b42081af0mr2902115e9.7.1755513093594; 
 Mon, 18 Aug 2025 03:31:33 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd6f.dip0.t-ipconnect.de.
 [79.195.221.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm172438035e9.21.2025.08.18.03.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 03:31:32 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250807-pinctrl_qcom-v1-0-42fac6707fd5@linaro.org>
References: <20250807-pinctrl_qcom-v1-0-42fac6707fd5@linaro.org>
Subject: Re: [PATCH 0/2] pinctrl: qcom: Address two Smatch reported issues
Message-Id: <175551309249.842888.11588905799815150397.b4-ty@linaro.org>
Date: Mon, 18 Aug 2025 12:31:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Thu, 07 Aug 2025 12:20:00 +0100, Andrew Goodbody wrote:
> Smatch reported issues with the limit checks in these two drivers that
> could lead to an index in an array going out of bounds.
> 
> 

Applied, thanks!

[1/2] pinctrl: qcom: sa8775: Limit check for array index not correct
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/be12b6e158a0
[2/2] pinctrl: qcom: sdm845: Limit check off by 1
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d9fbc1d70bc9

Best regards,
-- 
// Caleb (they/them)


