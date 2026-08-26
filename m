Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCA3C61DC6
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B48B405A3;
	Wed, 26 Aug 2026 16:03:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GCy7xnCiBZ37; Wed, 26 Aug 2026 16:03:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787760190;
	bh=/w5Hku1UNbzmtVieaHuFRUdTAtIj+WBqFf/NDlLUO6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IZNyTLZR32esukuloOV1HD2iT98NxfMsNS0FVlB2YsRKHfhX/EdBW82gSLoshvhJt
	 YyLO1xwfJVeNOSojQiNrcnBAvdP6thCbAhTGhqk0hZYVVRFe2JDGU7bJbSlOV65Lpj
	 XbVIVayUZkwuNp1mw8a91Y79ibi8yPxRppazW98ICToQN5t7WIsqBb20+WKkqafUO9
	 dh7P580ybREIVLQqREsulAhZ9r+//2kArSo39Fg6n/UFESn5Qo6S89w0EXi5ywFYWV
	 8RF5bxOYfqzlZCY4GnYFQy1fNv/oPz01tXKgla8lgnKRIxgZY030MknE+fGOX2E3A+
	 8dff2mDtgHFPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AF43340434;
	Wed, 26 Aug 2026 16:03:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC954323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE759400C1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:03:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NDktkUKeMlqq for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:03:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Gp1hqF6e
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68DE840208
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:03:06 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7ee4399c423so1017080a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787760186; x=1788364986;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/w5Hku1UNbzmtVieaHuFRUdTAtIj+WBqFf/NDlLUO6M=;
 b=Gp1hqF6eixR3iq6t6f+FpoN/fehVm7+3qQ5MrR/nOJ6x9z7i8IR6eO66R7yGLImvKy
 homSBJk2IpudnLrNPuAl2o7F/wEiJ6zU7glE2g9LLGTQLa5eTSJW0Q5d1LoBQNPKR/8g
 RjC7MUH2u/vLTcsLP0osgBmcnVEDPaI2VTm3aTWke4kQYPBKc+k8VvQktv+FwCQu00/B
 /cClO2pTVV4B1Euq3usTy+SozHYEi0n3ZSGTTA3f7LgOFqKLNxxJF2XyrO9x3XTi3o1K
 dw+6I7QYwqSvAUM2VjeCjbeMVyPuTag/k6egeUCheZBRWuk5WK5/u95DrYxBdJqvnKnk
 tfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787760186; x=1788364986;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/w5Hku1UNbzmtVieaHuFRUdTAtIj+WBqFf/NDlLUO6M=;
 b=ID8JFb0whheRrrtdYEeiOJ7aOisvp6kuXdCDafTaBFNSNy+rPqY2Mm+IheXHduKGOp
 Oq20drIyHgI2STa0YmdJf0R4siARVZAz9Y0AS369j2IVl75YrO4zEARyDAhUG2m+6dgI
 UXv9f2VNvvK3fhg2eG5+LS6avmgrSgrqf8Zq/EGvhjie3+r6bSuc5hNrjLD1jdNZhXvF
 wzFdBZI5xjc7XUAiqw2ZHbaQnF1eTJr6KyaW9iKqGAGIJx5TZppP9osAbFtBG0+pKSTc
 u0icCoq9+sGKo8euGTTy23Nq4t6HUv57Vzun+R4dIJ5ZluJTEaiEkMJKt9Cew2+c4214
 Dzxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsRF0uhGL3oBF6ZXs38luGLuZrJ8GZ52XRyKCirj5aM44rr0E1KT8fo3bLdIcfDKkqXg6xoIE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k0pT2ZpTxlPCq2VGSkTo7li74IC7TDQvH4Tg/S6M89iNamrSEH
 pXngXJt5CdPL3Bd0E+I+QpqcPpF5VFHOOJK3EY3VqLOyMXX4CoXHXPLsm8u4ntZmQI4=
X-Gm-Gg: AR+sD10Dct8YHEedph3ZY2Nk9E/GAoOBZhpBRxf6d+A8oFVqv0Dq/g7yufcWiKMzZOL
 Sa1/qGziSMfFIwIs3oTxZZ/fy+UoVIucxJXMNxFgiu/ANNpPgKrfR3OnQHawAB5DWvX1K/fbJfH
 Ls5r53jhQ3MgguY1f11LYY0+hmQT5HK/Fe4NKNQwly9OPsJckAAi1CoplV138fUo+z9UHe2ubuD
 PpH/KldDuh6cqktIQUZld56v59qPFVfCrvPI3zkd95vxjb9cFLMSAlhvwMvoIXkGQd/JJOy+BGh
 bhRkZzc/QWfeevoImkpGrckZroPP7ZHeG1aCA/WiuwlTbVh2WRrOAGPS+ss55/ihUyVFiBGrVpJ
 vUcpHYSRxic+Vp0q2Gdn7vmw93mphEcr3PvWPzc563GwYH/eQVgaKgvn9lbpBSgsEydkxW62w5s
 kD61+rXGkGinCv3tWexnQO8JEVN0yx7eO8cjEWje4GehE/O/0qukYNgyEvnw1Zj3P3sRjKypvVw
 3kNkR4o65nmjOojzbX20Vm+q5ssGQsP9rjpoEQ=
X-Received: by 2002:a05:6820:859c:10b0:6b0:ab1f:ec16 with SMTP id
 006d021491bc7-6b1a049a513mr5703284eaf.23.1787760185947; 
 Wed, 26 Aug 2026 09:03:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:162c:81fd:da88:2ea6?
 ([2600:8803:e7e4:500:162c:81fd:da88:2ea6])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465ade707ecsm2537828fac.5.2026.08.26.09.03.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 09:03:05 -0700 (PDT)
Message-ID: <f9ef2794-6647-4935-8744-f3211dfb47d8@baylibre.com>
Date: Wed, 26 Aug 2026 11:03:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] video: mediatek: add display pipeline component
 helpers
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass
 <sjg@chromium.org>, Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260826-add-genio-510-and-genio-700-hdmi-v2-0-68ebb1bf17df@baylibre.com>
 <20260826-add-genio-510-and-genio-700-hdmi-v2-1-68ebb1bf17df@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260826-add-genio-510-and-genio-700-hdmi-v2-1-68ebb1bf17df@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 8/26/26 8:09 AM, Julien Stephan wrote:
> Most of the simple display pipeline components share the same probe
> sequence: remap the register window and enable a bulk of clocks. Add

nit: clocks aren't enable in probe. this could be worded more accurately.

> the mtk_disp_comp helpers holding this boilerplate so each component
> driver only has to provide its own component-specific programming.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/video/mediatek/mtk_disp_comp.c | 68 ++++++++++++++++++++++++++++++++++
>  drivers/video/mediatek/mtk_disp_comp.h | 30 +++++++++++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/drivers/video/mediatek/mtk_disp_comp.c b/drivers/video/mediatek/mtk_disp_comp.c
> new file mode 100644
> index 00000000000..3e76eae7f02
> --- /dev/null
> +++ b/drivers/video/mediatek/mtk_disp_comp.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0

nit: GPL-2.0 is deprecated. prefer GPL-2.0-only or GPL-2.0-or-later

applies to other patches as well

