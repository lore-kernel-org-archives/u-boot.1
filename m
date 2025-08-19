Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C97CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 19:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9FC82E37;
	Tue, 19 Aug 2025 21:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="easIdzS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4470A82E34; Tue, 19 Aug 2025 21:43:11 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34B19809A5
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 21:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7438175d42aso158839a34.1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755632588; x=1756237388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WIcL/EZvJEhIZKHK7xfvb8MufhO/8Ni3ICSMATpAC+c=;
 b=easIdzS1AUDppjUlqtw7HmBDw2hT1+uQN1PpdHK/tutocUrv+hWkEBFsg85kKoFrUK
 Mh8n60qeUGpdT0Qj/xZAxFWoxCFDBU4N3nj7V99HAJ79+M7XusvafX0utZFGoAfHLn18
 eoQBhTbTKfGcBYJQZzbr64Cd1L2Y63jt+95lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755632588; x=1756237388;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIcL/EZvJEhIZKHK7xfvb8MufhO/8Ni3ICSMATpAC+c=;
 b=OU8WKpMFdWYNNmZzfeXUI+JIKPvyHrUO7SnncZY6gwx7TBVF2XXwbL2vCCLn7+r1UG
 mcEzvxz6mCGIbicSI9/xVf/iOV7flInNX11vVRxtVbCUJr4NPUJmvm6pRtSVlvGj2928
 1zaPS479I8dIRFtPCcG4D2jntvTBHHQ3lak22ieyMWCOdFq6NMAt5bwTv8V6LSBhAU3g
 ex50W+9EYLQjbM2foPBLP/4B+gQjJnwxmyoM54WtjiqGJCiQaHex8JMqKmv7SpxwKxN1
 vYMHfwbXfenxWnYnwvOcv7gU64MSzltJyZlrMzOgwzxLx9UaqMfFkf6Zmo/e36tPR3eL
 l65g==
X-Gm-Message-State: AOJu0YzhdFy0LzYCKCjJ8HvfzgPeG2uGSEpxuwlNuutH2MpeYvH98SzI
 Q9ASCd6dP9hAIxtF23LEMLFLU5CnOF1CyTq+4PeRd8qCZUzrBpBCVXr0C/G3BT2snJ8zP7NAEcl
 4x3Epzts=
X-Gm-Gg: ASbGncscQEik9vzG6dnBnheEy06idAE8rsSNYdwrKMzT2AvWSVhBi7zWhXT6LSB7Y3g
 DPbkpaezSaqdpKKmTX6xKET40wk5uKjPgPEs8ay+RKeN9Z+129UK+R+SsKAIiQ6A6WH3uYA7UFa
 6p/IhAW7q6Apo12MX4rNWUYg8+2ypDiL/ZGxFE2A/ORoC5Eat521hm25V9/Iy95OmqhxWaAmxgS
 cswU6Eqz4b7H2CDGuY3ZuFrfkCazYIlCU4BuedqGueF3o7wjEB6bu3hQChfgcU9vDOCghwzHlAe
 IoIboH92bq9crBWZO8H3izVGJqb2q3oriyqxOMlTWGmiivB5ir+9rCOQeIW2xmhQ4wqJ+W12p61
 cN8F2Td6zQEjP8d+B9hBHU6a12O23tA0kZm5PFYLTZNw15E+DHHgyN/0=
X-Google-Smtp-Source: AGHT+IGSQJsFntpSg4JA4YLhlwoMuz+t+N8GmVMPvD9zTaP6/Fq5msWiueD/RL6ssMreiKrk6XKMUA==
X-Received: by 2002:a05:6830:1d77:b0:741:a8f0:db5f with SMTP id
 46e09a7af769-744e103c4e4mr1870819a34.7.1755632587814; 
 Tue, 19 Aug 2025 12:43:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439204e5easm2525109a34.38.2025.08.19.12.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 12:43:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Stefan Bosch <stefan_b@posteo.net>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250807-pinctrl_nexell-v1-1-6f49a0656510@linaro.org>
References: <20250807-pinctrl_nexell-v1-1-6f49a0656510@linaro.org>
Subject: Re: [PATCH] pinctrl: nexell: Cannot test unsigned to be negative
Message-Id: <175563258674.3359676.2318658706388471841.b4-ty@konsulko.com>
Date: Tue, 19 Aug 2025 13:43:06 -0600
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

On Thu, 07 Aug 2025 10:16:55 +0100, Andrew Goodbody wrote:

> In s5pxx18_pinctrl_set_state testing count to be negative will always
> fail as count is unsigned despite receiving the return value of a
> function that returns an int. Change count and idx to be of type int to
> allow the test to work as expected and remove the need for any implicit
> casts. Also change pin to be u32 which is what all called functions
> expect.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] pinctrl: nexell: Cannot test unsigned to be negative
      commit: e416d165723c56658b4a688e790cdcd968c6cfc9
-- 
Tom


