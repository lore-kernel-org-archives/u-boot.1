Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E358C9832A
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 15:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3343380EF6;
	Tue, 29 Sep 2026 15:15:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id irs7jwRwB0Od; Tue, 29 Sep 2026 15:15:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 74B1E80EEE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790694954;
	b=sJKoKOS1AKhN+CJbPjwxM/SxVfM9XbGOKLFjvQt0t0zWFbAs+NKT42YdDP9ClgoYSt7L
	 l1F/MPdMforzf9sPRZCXDWphQmq8eh1ZCtG/u4gAoVg62ptOcWwmBcCTUBSS8CGfSRR/K
	 lACInmhpZ5izZ2KdCKLLSIes0Bg21PbmyRiCYYXHSaqQO1OfkSTCuEmbDS8QNANoE9T7f
	 4AdI9CIQgePG1zsWB1EY+6RUiUth6JXrGAxo5LcqZKkrms9oQ0uJx7TDD8Fet7F3K2uFT
	 wTvB6x1VyQdAE1O6akWgsV+ALN5vRdgqcgMbQSuf8+q9bGWFxhtIu0LjeuGrS5zhRBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790694954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KlJgEp2lLNibgm8TrxFSC4D/7I3FbgC54Nfs05elfyU=;
	b=KK58H0Ca0ycTkm9+S+vHH1n+beET7tiGP3b1Z+Y1T5Z+ioLDOdYbOgnIhxrTNksZmw0M
	 DQxFsFu4+fBGLZ5MvOjbs2VorCjsgw3TvAQjsUttiSfkzlD3DueHiu771mlCqwJWetj8m
	 QkPOV9ajBOIQlRMLt3aZlQfSBeRRG6YcZj4nipovkf+6s9E/fzM+zPUvbNLXqxU5pYgjL
	 MEl3UEB1kfQ/iJI1mAlyeitP/B6oW1RkN7mwK5rhsfjrQ36P6T8fxO1ZCsut3ujofA1PJ
	 lOTtLpmtieJFuQWyrvdPZHGu0nVXYSQY48cm9kabuVDYQJAT7e6pGIsm3fOiF7Ldttw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790694954;
	bh=KlJgEp2lLNibgm8TrxFSC4D/7I3FbgC54Nfs05elfyU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TOwbADk2co0dtfLJcpE9s9TK10NVUar7ksEdubkVjidY4e7FrjZxzbFnxtT8N6we3
	 mtb7qnaU21zlJkium4NgG+4K4yUPxz9Z1UUpQ06O7JaJLEBVfEKGwYBOzpuW8tTVou
	 D+qS8Jp8YJKTxPL1lslkPXlCpGZL97HvJD+oRyVPRAQn6YPYJAyNKHL+SR9pbVLfWK
	 qYrn6bjo0avrCu13KqaflALrigU9ZTnFAk0Xa/RYBrkTguOmJ6DmjiFhUFTpDHM5YK
	 9CANSPO2GUabdyE3+bN+LGu+5ojUop+N+TLP2X1acLAsDPv6Ni0SKgXqp7FWuSQi/b
	 uxei+b7nxDNiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74B1E80EEE;
	Tue, 29 Sep 2026 15:15:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01A8432A
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:15:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DBE9240769
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:15:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VR3VUf8IH4r4 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 15:15:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0953940768
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790694952;
 b=rcVTCUpRnjIauLYm7S5TJeGIxEqwM1qdzku02CvXNk1jOZ95mgM0Vpqa/k2dvI1A+nrx
 FvPKRbXOHoE+e4VdD2ZU/RIDxKiegVYAy9OO6cmUjNNJyOrwxjM9DbQJEoamwZeAuor6v
 UdKT9pMJ7QKfBnEQmQpAQbp9yD0zQRTyCr/wjuUORp1hIIKJeMBF3sSdYMRd+V1O3Na7N
 xdrab4bsoFm04y1KZ2mHiiGp375JChlvATqMiilQ2FuA49ucCpk251IDXxlZZe76zyBp9
 66Y+K7dH5dLcK/7HM6k6E35yY8jlu0k2AM7aYpG38ZLznrpzUdRUGKSrmRPLs9yTCvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790694952;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=KlJgEp2lLNibgm8TrxFSC4D/7I3FbgC54Nfs05elfyU=;
 b=Rggu51yiAzDR/icgLim/gWUYrdkx0c2LRfz0HImttyAKhybba/lesQkWIifMCXnMYdj5
 GDEvCLnj5WxiZPKGH7oxfOYRhAFAjrzUsofydpLiOUWKUgy2AgtHUwzTG6lXhEDojk4yY
 nr15FD+ouTBkBxDn9jqr8/cBF8l0NXfGrPl9T6lH+k5DKplh3W4VBXQvFj7dAuJ0Uq2iD
 URDoh3DHPGmhZLr0WhCYSu7D1unCdj/TKrzhUDXvkTqJhLq9GoFBIAf6tZS8Q8SuoRIIn
 sO/346SjnakZ/i6vAud7xxc3dKbExDGSXr2/Qjw/FY0aPgxHmWlRxCFg/SW0LgRHzEA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=WdfejRuA; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=WdfejRuA
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0953940768
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 15:15:51 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso32888765e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 08:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790694949; x=1791299749;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KlJgEp2lLNibgm8TrxFSC4D/7I3FbgC54Nfs05elfyU=;
 b=WdfejRuAZVBwgsrrGFuAqzc/UJkvxRZ2EJ3wegMzJWVEaCH3bH7H5+v02mHl1bkQOH
 FTlixA3Ey0seK7V+fSIJ/IYgtpGRRLrdWulPjJ6J0zwguLtvOY6E27dyLaXZYjU/LyOk
 YC4LzRITyz9z94uz0GqrOgHVodsO4xGVCq8L7/ld9i3SYpRwiUQl3roSRudwaDRyOyHW
 /V0T5b8kiypTZHvywgNsZQDDJGTsAQgrQoxALfkCSId1h2ENghrKyjzMWZbgZ8GPIYYX
 ap0ihPn0cnasrmATZj5Y9MNKdtq95Z1NSfJwRluVPx+u7aclVg3AhnRcK5ec07hfw4mQ
 NfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790694949; x=1791299749;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KlJgEp2lLNibgm8TrxFSC4D/7I3FbgC54Nfs05elfyU=;
 b=1jAOoRG5tjPMAQAjdRauxyVWKz8Z0o0eRGhGUXsjtHPuhjQWB9ftUYpp8ePImdgEil
 cg8Cjf8USCRGv+lUiJWkw6rxc7s9hcc3oZ7h0huzsBWM2znw2Ht1TpRXKQ3ZJEDzrRee
 DMihRfTKxIZZT678WlLtqSbW4Zr+EslKVkSduGcvbqjrv/GYpdZRnnPZOXGhVK8ZEV6V
 8HKyy0uY9qqTapNp2HAa/HYhISais1XHK8fPxzxPWvCq/PxJZXXlMLUd74Xj2J3wVobr
 y3IMQ82huX4dJ4b5zwnO7wDQe/i7fOYgyphswcGKt36DTcFVZiZCMDJZ1fiepN05XLbi
 iAIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwu5g/G9zeEP+CYdpAhf4tbSjAALGfgCtlVNZ9Qy2xbG7ESXKRcyx9b9dGlGdi1Pjj1aQw1MsU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mjZeDDjlKD8o/gD3qTeGqyLuTmraWVmGC5WcEkxN5N8IJfUvLC
 55I6R6cam134P3+H89ZxSgUbYdiCjikV0Huf5cYzI5vIm5tCmAKC0mtS9epiP34loFE=
X-Gm-Gg: AYBFou2MDneMtVT6xWSexRjp4i0KH6y/U2vkVEnhUo8MkPRWbdgyg4CzXgEJDTDOg1H
 hxPySzTkJJdrO5D7zWfhQSUSD9IAGeFVCGjswkTOyhW36GIkHRk56ISxfwc6cW+3oZ+7rGoQ5+l
 KYMGC1NtfqmJ7vziwvdMWhYXckfEvlFmlHjgjg+CFnT6pOVyCglHst0LVAuU3dOzYyCeqUFvwHS
 8vAitZyHb/1xZHljSMReOEmQfytODjjhdrzJ8AQVMDCAh7gA4CrOvP6ekAfUBwrVcUJ0e5HBDNf
 HBpLBLauwNPm/t8CvVitoAe+uZ0q2HuJhz1VwF96iksdXX3N2P/y0EMmBak8hsbli35UJfBFmXH
 l7FwW1AaeL/bTY0GUK3uUS1lyGfOQu4EYqNobicpY4kRgmGlgsFdex/VAO/B7QuioJQ+d7Wrqx0
 /JywIzXwC9Rdad3owygx0QQG/pr4ixhaM8fJJBZXVlsLrPnD7wb+PqCdMmJSVnVruxwXf3BSDos
 c9YAX4jYDtRFuGCmUUpvLL/splGzdGmjI5E4JiKjaJAgGUHZrmmNWzTVsPRM2v/9Rw/svaiWf9C
 PGekB1hlpqlwApx87vzsBaKtutPdkoTSA0CeCtDeUydB3qIZhf98OnY=
X-Received: by 2002:a05:600c:1553:b0:49e:74b6:740f with SMTP id
 5b1f17b1804b1-49fe66f3ca9mr281845415e9.17.1790694949379; 
 Tue, 29 Sep 2026 08:15:49 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a013b8f6f5sm20981725e9.10.2026.09.29.08.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:15:48 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] clk: mediatek: fix some clock definitions
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Fabien Parent <fparent@baylibre.com>, 
 mingming lee <mingming.lee@mediatek.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20260923-clk-mediatek-gate-order-v1-0-085391165c36@baylibre.com>
References: <20260923-clk-mediatek-gate-order-v1-0-085391165c36@baylibre.com>
Date: Tue, 29 Sep 2026 17:17:56 +0200
Message-Id: <179069507654.1887049.12445110018220414433.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790695085; l=604;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=bmDMirGNhMdWG6/eCs6x3A1u0+b5w8samFP3eqBZDCY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKx3yw+7Ez49H4uU2hXYaeVBkLpGsnbMfTRYtqXA3Mx6VOrxvPbzL2vexZNeEUtnl4RYOvV+99e
 BbE1XUrGIbwc=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

On Wed, 23 Sep 2026 15:22:12 -0500, David Lechner <dlechner@baylibre.com> wrote:
> clk: mediatek: fix some clock definitions
> 
> While reviewing some adjacent code, we noticed that we had a few
> incorrect definitions in a couple of the mediatek clock trees. These
> trees consist of strictly ordered arrays where the index must match the
> ID exactly for lookup to work. So if anything in U-Boot tried to use
> one of these clocks, it would end up with the wrong clock or crash.
> 
> [...]

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

-- 
Julien Stephan <jstephan@baylibre.com>
