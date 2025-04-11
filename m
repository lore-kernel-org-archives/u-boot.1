Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38573C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 13:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDC5A84070;
	Fri, 11 Apr 2025 15:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cHp3T0Uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17CA84051; Fri, 11 Apr 2025 15:36:15 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0FCB84051
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 15:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso14819255e9.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744378572; x=1744983372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFa4AdoQdtx/Pv+1WZl2BVf3YrDjUEF9rxgFOnB+tbQ=;
 b=cHp3T0UcwUV4bXYfL8sKjAY0GrP2yB4+S231xiG9OD1r/DU+QHs+yvAvo6AurOYZ+o
 cqkH6y0ZH4iMPYQRd0LZi3g5g8c3H1FTyPPXIfHjAkEhIWZarnnGJVZtO02M9BpOWSEs
 Z/14xensfEnbNNcfyetJ9sYqJQUL2vfu19xyUCRJ0zd39Vw1U2DJhJljadyJl/5yba4y
 5O/WMaA1jDMX1gOkihjdukzN7FNPjFAYIsJWFww7dlQTr3DZLWXchAZoPOQrfi8Z0VTD
 wivU8jZ+sgmLjgV6FU9o1gl/nFyjygZB1pdgUhWhuZ9gogYYTAdTYk189ymlxkl0fmEk
 59Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744378572; x=1744983372;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NFa4AdoQdtx/Pv+1WZl2BVf3YrDjUEF9rxgFOnB+tbQ=;
 b=l3RXSIk7Qrj9XNbSxRpnNBJ5EHwlWlHA14N0HsbXtTVn/D/88Gt/nUKT0/nSPLvGvE
 mXAh/562p2C0OsfBHm5jD32AbcXfClywlm2o9a5Wg4VzUiRk/zGyK91etTA5rwBs71fS
 drwFvWeP7XIH2CdyaojwqqOgoPsHG46GmyOmdO8bypEDCkLELEDEZi5OjaXolVM32ghT
 bfHOPaNKD1LXOnNzIbRPh8nFinQ4Fjw5IrXgEvB/I3Nd9mY27g9dQqYtpiLq5gPjV5it
 JvbO6GxOBdJ26IckFnpCyolcEprHdoITaVozjZrDt/SJPpLWx71wHoFDRoDKzFUYG8xk
 94VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvWcqQXrrKyA8AR+3px/ryRcXJEAGfgPbDmFeThLC2F0Awun/E5I+LGtXw8vig37XpqGkHpOc=@lists.denx.de
X-Gm-Message-State: AOJu0YxIBpbMBn14Ww7fdQfTfO1+UBvp0zEz+5UbEyGQjbajT0V0hknG
 P4MysrEl5HaY35CQ8LtEVtmlOKBsbmSBs9KC0cz+qjxAFuHW/wdMeVZJwNayf+c=
X-Gm-Gg: ASbGnctCcSkVDkfwDiBaKf5kFyBwpI5UQC1WRmKwkjDLFzOKT1UgZXLGuDCenj73pEC
 ctb7iMz+inRR2wE/QbDGqKhvYIY4fOYp1c1p3JNapCAefjOwimk/JuqOVIRUz4fDw8AH5zRN7uY
 dCgQXBN8DN4iNQrBNsrZlUStWrSMd4qMDe5MviCIoj0hvf0Ba4STzhzLcKe9yyLu0avON7oBuU3
 8tPE7wGsT+46IEk41PwcdePHP6LmRz5vonjYM/3Ym9EFt30j71LGBpLLiTX+epYNkSPXE9V7FDc
 S/Ofqx4AaU4tp2Qb+pKCdZ84v5RO3L4qp/nT57ElStxu8Ftgaux66mqRlK65BQUIPtOBXlzvDda
 fKY37AVniot1kTB1AuA==
X-Google-Smtp-Source: AGHT+IEvGIT6yXEWx3lBnkK76aJOjdasvgCJ1YV54OyamndwWFOF4mXW7DDxz8V7QmRySUoAQpbcjg==
X-Received: by 2002:a05:600c:1e1c:b0:43c:f8fc:f687 with SMTP id
 5b1f17b1804b1-43f3a9adc61mr29538975e9.27.1744378572150; 
 Fri, 11 Apr 2025 06:36:12 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c8219sm83195365e9.21.2025.04.11.06.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 06:36:11 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250331104327.321339-1-caleb.connolly@linaro.org>
References: <20250331104327.321339-1-caleb.connolly@linaro.org>
Subject: Re: [PATCH] mach-snapdragon: of_fixup: fix condition check in
 ft_board_setup()
Message-Id: <174437857089.2613234.8476852529726797881.b4-ty@linaro.org>
Date: Fri, 11 Apr 2025 15:36:10 +0200
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


On Mon, 31 Mar 2025 12:43:18 +0200, Caleb Connolly wrote:
> The fdt_node_check_compatible() function returns 0 on success which is
> pretty confusing, and we were using it wrong!
> 
> Invert the condition check and refactor things to be more readable.
> 
> Additionally, add the check for the RB1 which needs the same fixup as
> the RB2.
> 
> [...]

Applied, thanks!

[1/1] mach-snapdragon: of_fixup: fix condition check in ft_board_setup()
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/602ceb0c9279

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

