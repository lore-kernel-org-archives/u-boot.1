Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4DDCAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC05083693;
	Wed, 17 Sep 2025 17:08:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j690oQDs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E18C5835B3; Wed, 17 Sep 2025 17:08:21 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5D3D83631
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-746d754f656so4705068a34.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758121698; x=1758726498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUJJME2BpnLLjSPKJ92sGACZgzENXKC//ZGrTb4NPHg=;
 b=j690oQDsRyGanFjs5Fotl4P5jyHQz8xFz1GSEBWLvHVstijp8jR0/ENpX5PxYbfYrv
 Orz2ZJLeUQLjOuF+ABVcwXVQWt3ZuXx0bWXDCoBYJDBrfL2W3PrNUR4CwmCoPkO5YMsG
 EJNxpzslDKBZVTGJjKBsuO42T4RkbGj6LUhdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758121698; x=1758726498;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUJJME2BpnLLjSPKJ92sGACZgzENXKC//ZGrTb4NPHg=;
 b=oYuWNmrHEhU69902P8ArN6fQj2WgN07ZbcBeXAgyC+iJkq6keqqL1X1g1oCEvQ+63b
 9x7NDyGW5F3w0YKwiIc9QAFy98h4PLu3Nf1cp1F2w+cw3Y8B6dcPjYy9klVzYuMy+nFl
 ElYzShcYMLUhINBrP6LvvZR+DgdazbZkf057nLuAwOOTFZBeqHlQiIU28cduupt7Avsc
 BIAj6auTBT6s0shv695Fqp3yCL+mjDL/Kyqbji7geDnRzGUtijhOrgn9uA8+hZ7Ge3yI
 GDIHCM2DW50Rq/PX7Crkhb89LVxndZZ7oJLjK/mVX/+f+udfyJM0COfqSc8J/bDnJuOG
 3Ubg==
X-Gm-Message-State: AOJu0YyGq41dYOfpizcyxZvr28hno1FFaWgqTySx1kBMEYnA+EWt81I1
 Ib4BBBGQUorchg4jWfuVHx7tVYH/o/8puageTe/oR5KX0NNO3rmvltiXws9rMyxftNDljDARbk0
 nexNM0CI=
X-Gm-Gg: ASbGncvLOD8zRpd4GZxWNYt29xrO/acOkwPi9QHY4D1KZJX/vHmG5zS8foH4uGIxJga
 Day3duXkMir3XThMlPdb9EwFR/i/LdgMrOwGeUBl3dwO0ArD2H7RejUJoiPmQWj5suo241xyhvn
 +D1m3b4WHioyGh2gvSWcR2tbtVL6Id6XlBtj6aaNEx4ymxNi+ItCdL+RBWcGKDGHCPTiluJaL07
 97xtyW4kWbFJ4r9v8uC9jaTM3wkfymfdeH3VNGE+206xPJLlisX4pWsLcWppHlNProYPyqlh+F2
 C00eLwv2ONwpp4SSxt63K/BkHlFZFp1Cv5zrqL+IhBTAB7yW7L5AUyg7YCMzSuL3FQm32cOM483
 ush44P97A0Z9QtyUf1CWjt0eLYBfE4F1//D9gZCV4TqWOfkDUlYLRq7I=
X-Google-Smtp-Source: AGHT+IHk3TaGXZZsRZCo87hkonOFVPejZVv/sZrg4gS9aETVoZIHGbgfvBR8fbMxZrvEUS47L1sVLg==
X-Received: by 2002:a05:6830:3882:b0:746:d8f0:56b0 with SMTP id
 46e09a7af769-763114a1cb2mr1421937a34.11.1758121698479; 
 Wed, 17 Sep 2025 08:08:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-758b2883055sm2981354a34.45.2025.09.17.08.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 08:08:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20250907010103.667681-1-marek.vasut@mailbox.org>
References: <20250907010103.667681-1-marek.vasut@mailbox.org>
Subject: Re: [PATCH 1/2] board: dhelectronics: Check pointer before access
 in dh_get_value_from_eeprom_buffer()
Message-Id: <175812169755.761188.161017228976097865.b4-ty@konsulko.com>
Date: Wed, 17 Sep 2025 09:08:17 -0600
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

On Sun, 07 Sep 2025 03:00:46 +0200, Marek Vasut wrote:

> The eip pointer in dh_get_value_from_eeprom_buffer() might be NULL.
> The current NULL pointer check happens too late, after the eip was
> accessed in variable assignment. Reorder the two, so the NULL pointer
> check happens first, and any access second, otherwise the access may
> trigger a hang or other undefined behavior.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] board: dhelectronics: Check pointer before access in dh_get_value_from_eeprom_buffer()
      commit: 5634cf1afcf17fda0136693f02a843aa6b938b2b
[2/2] board: dhelectronics: Use isascii() before isprint() in dh_read_eeprom_id_page()
      commit: 7cd9d2db2627ce65d3c03e4422607b7a86093e8a
-- 
Tom


