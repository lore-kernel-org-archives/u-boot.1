Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A41C624D3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE12480EC7;
	Wed,  2 Sep 2026 13:53:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L7qgVS5oKHWU; Wed,  2 Sep 2026 13:53:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788357194;
	bh=z9xW2nOIvbb531vdUN4IWVMDs7OZ3X6kHW155Xtuf3M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vKDzLx2a8KN0x8afGzRg8N0yymVst1o0M/n8VUG8HTaxk9aY7ZWGl/aJOXI3/B34P
	 0N59LhGmzsKgWT0rUR0+yaYfRwBFRcEEHOIPM3Z3Go4mdIByeUysiYTPbHTiOKVDCT
	 wbDHxi4exEuU5RRJkUG8lPn0bkrnOqlZVxIz02RWx7Rjq6qX9Vp06fXLAThYO/DG/q
	 /dxp/erGVnEqYCgcazr93hvn9ZvjxjYV70pDuWMznlF8PLB9Bn4HcdzBFJHev2aqrO
	 3UFSatYqxAs3XOOuF9spkatsaoRnkHo4Bihi+Qm9TFRUrWwQp8L+qULi93d9H8ywqT
	 vv5GnkiT+UTpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD6DB80E54;
	Wed,  2 Sep 2026 13:53:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D5D92363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC0D5606B4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:53:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z-nhScwJVFvj for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:53:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nL/5tDlI
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4CB5160642
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:53:10 +0000 (UTC)
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66bd7857841so1623842d50.3
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 06:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788357189; x=1788961989;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z9xW2nOIvbb531vdUN4IWVMDs7OZ3X6kHW155Xtuf3M=;
 b=nL/5tDlIRhx35W5wTorFqBUbdlspznO8T6zksH9YKnvaWN5VVmbs/5+aaREh5z3zBC
 36vsXuyYOGA9MbXt9sOxkTmXdK0GmElG10VkbxVcEa4XNXjsk9UXCc7fj3839YpubpyP
 7hdzEH2n1HanWE78bdvmAhwVvNekkRsvzEyNz4sSljmgai15kAYP/YJrPDzL2XUrUyt3
 vAUbZgUxVUVlK7rMqSnX59EyQqb1U5yng0U4KqmjkZ0dOnbZJYKSTRq4XwDM8ocb7SgK
 kolUEZBNfrwQ2cihMCsAxbVmJPdqiOuctIr/xtRd6K6kIpHuu0CAvS29s2/3QonkmhSP
 c9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788357189; x=1788961989;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z9xW2nOIvbb531vdUN4IWVMDs7OZ3X6kHW155Xtuf3M=;
 b=Se5ahI9/Zm59ax/XcHTgHXwlSolocVV3vfyq39umYpSz6R5OWQGcsUPymMdnB7KwlG
 nP0BkbzN6RYyL2jlA+78HHzKjFl0ptpsK+pICDsaruvcxp0LnWURXwvNKnWKA0d5V8pD
 wCGMInzkYd+T2z2RSEqLLp1p5Z43pKRQRHPLsKOJExpwSali87Ia0S8MxIMgTOOT0bap
 3DLID8uY3pptjD0MJr/SgbKqerOEEUf0c0yFvF1WTwuk1hZaiWGw0neXWocVOBTnhDhi
 naLY3IdDEzfzBsk8gU+Rj9QpDbm+oegtrtm12WMWH+Qg3yPCE8EbHVVMSVsq+MN6+yfU
 zcwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUTBnKPD0zTd29SjK101rfwTrWMN16XCLAodQSf/l1WqEd5CQsH61+PpY+1d4Ms5X2LTApNf8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lRoPMOBrEFsU6XVgSUKmNG/jPfQoCbWh/yK3a7rN14xAALc6yc
 NIblGRZ3xSzXqd7DM0bdmptSAW4ngLHemnVfP9pR7wXHRNgyj6URXiQ7cviy3Bs37n0=
X-Gm-Gg: AYBFou2p5QnnhaiRDVEyIh8NFDXGn/nZM0GEVVNsuozr9v2185WeiZ+aZb40pEYTNQJ
 pZSQ1HfRjqrWjGAipcfiMUH1FuB1AVfyHpCxWcBQSUkq0QMTDALXrFlN1yuJv9QQp+VoF8PxFSc
 2T5vUaYdYZOhfhMxth80RmXFfBZKm6X5C3B1GlPBcIcMV7+OiNEHta8+3moCsUanB65BGyITC4y
 DzNTpodtxk5VFlVG/rUGOFL3pBQU+7BSL6GpPlTlt5XZGMI2cDJ+AyN0rcGY7FAXVm/QQjLeuGb
 xsSOh/yKT0NF3Uw0ATx+fQg7cjf6YAuJjmVRqABKdtyyVeGgQtiQPHvNFHSxyriZ9GCLIEtQV/p
 32J+tkOyKT4d5ctm8yJsCYu+yZdqtGQETIKGjvU5EYz3lUUdwqCzuJp1nDsN2XVXiHPbvnzPAn1
 2lslNZ0F93rqXTs/b9oBFc5ycX0BkO3BeF3IFWXnsvDXR3ZObZq1NdxYceyhQXr+WPZQ==
X-Received: by 2002:a05:690e:d08:b0:66f:a1b4:73de with SMTP id
 956f58d0204a3-66fa1b476f8mr949325d50.18.1788357189234; 
 Wed, 02 Sep 2026 06:53:09 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:518a:9db8:615b:293f])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66f9867035dsm1918198d50.15.2026.09.02.06.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:53:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20260814-video-pwm-backlight-num-interpolated-steps-v1-1-140b06287868@baylibre.com>
References: <20260814-video-pwm-backlight-num-interpolated-steps-v1-1-140b06287868@baylibre.com>
Subject: Re: [PATCH] video: pwm_backlight: support num-interpolated-steps
Message-Id: <178835715571.2649860.11961318055290472994.b4-ty@b4>
Date: Wed, 02 Sep 2026 08:52:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=379; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=z1GCSTKORJFOorP6J/1Pd6yX7KKz3c0QZcvlzryo4AQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmCo7VvSFjwTVFd3Ww7LUWLgGzbH8mJvtS3EIW
 K+FOUSe5uCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapgqOxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ATEwIAJ44bUh75VJi2elFHeTl07mL1QOfSAFYuBAf6BG
 yRe7KmgdFS915QoZDuS4Kx942qrvqVYqUOouCpg+blWDhgAlW5IzT/hu43VN/4vTG3GHuhoJXXD
 UsEeeb0OdL3yyqFb1qQi7pXqTid0COjmoAruaGaTCqkf9lrVxXtwXcfVJW4TAVY/Ik87w97VyKO
 xiXyEYGvFLKktScBjb2YvuPdtalDbqbS+9jgKmhzKT4wZa2XP/QfFGIuu+6TKRnU+fHtCrwKMex
 WvjqjQc6HbDPd0b31uSN2aJFXPncKI7W7EZZ2o+HVM+xpWJpqYnJVLR3fi+wt5H/5TL1ROI4Hfz
 zPP8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, 14 Aug 2026 14:15:45 -0500, David Lechner wrote:
> video: pwm_backlight: support num-interpolated-steps

Added the limits.h include when applying.

Applied to mediatek-for-next, thanks!

[1/1] video: pwm_backlight: support num-interpolated-steps
      commit: 51595bbd52baaa236642b34954ac5aab1aea4687

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

