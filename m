Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2EBCA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 13:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 285B0809B3;
	Tue, 29 Sep 2026 13:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVQZHnzBGfpa; Tue, 29 Sep 2026 13:43:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 79DCA80994
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790689408;
	b=qylW539uC39jSd792EaJs+JmeyWV1LpuSIK8kTt55uL6KDTIu4TOpPMyErfU+vCljWmL
	 AziRHzKHNtpX1QvLbPaCDjIqqIm36ek0a/A7xURu7k3M6cRMhKdMVNM42vSn0PImLgwtZ
	 LY5HLFWUT2HRruxg8mL+roitNGBqYfyZvYPtABelRsG9SWOOspmQL56wFxvasf4pswYHa
	 xObm1iQMx36KCTTcgpIs+v3pdNx4tm+qKLpa/f38tYfkYXrja9D70CyzUa5dcMhxHuYxD
	 t3Q64WfxoYnqrPGyteAb8zKu1lALlZD8BlngDtM9WbkZUGusy1M3j6clOj0XGNN6FeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790689408;
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
	bh=ovnMtUcKMDlkzoAOw32A3rD/USsfeDMnHyafcMN0VRo=;
	b=plPO+tHPjtjEHKBVDPEyv6HoUeq5bZKuoWFYrCdFy6C52Hu0Aub8UWtmWAyCSekhSkG9
	 zD/YfWhCXB7SMo2CIovXfSFl+sOc7snqsIPjkpu/XXsFAPzYxTWyzRyf1MLuuji9CcFI4
	 4kABDEHU/chaAhCr69iG0qv3cUP6qurJu6rj1DJ1CJpKZXPYlYSFt+3ypVOCcq8mXnsnx
	 dfM/vCc0qwbsz1YNSaS0snNPDgEMGv84CfUu8EBvcwpO5Pe0I3c+KxFzxPQUvdhhxm08P
	 3gLw1aFPlEw1kIFV2dJA9vA3fkSFfsJw6isUmDhAS/gIik0+lh2jzKnAoaiL7jwtAhA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790689408;
	bh=ovnMtUcKMDlkzoAOw32A3rD/USsfeDMnHyafcMN0VRo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yVmXRu0+0JiObZAtFiErj6HrRD1mfVzlfqwUDWg4UBiykn4VMz4xEI5Zfot8vPTVZ
	 fnHVnhZeh+EFZb3RcRCyMX9zvk2R780BMwVEZYEUDiyd3jhpa4rNxR+PO08lfjKvnU
	 wZw3DpWTaKz9eGLVRYRawCCWOVgpTWkPP6EJqIp3i+FeWGp4eqB6tAcnpQ+BwMhFpv
	 nAeuGS4sBJW106Zf0rz9Ax0QMhGpoqzsbBJ58fq8uFQzTe3csWZlLZpQVdExxMqysE
	 rR18BOuKJKPLufm3570SHhbfRdJVBd/hHYDSi+d3eB/kStIWxdSYDSA+ELnI1j6ser
	 csjW7PyQ25JfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79DCA80994;
	Tue, 29 Sep 2026 13:43:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 499DF2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B4106071D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tj5bPuYjaAk8 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 13:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2A3E360729
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790689404;
 b=iSU+zelGa0Ab59+kLsFEZ2YkhrUovpvuxCi0khX7DuA4qxlQzBOnkuJjlVat8hXTPbRo
 ibf9pl1omp8a4i7Ehz85mFn9rqQnR7CO+/b8jePDMl+GINCM4RMcI6IXDbXp3F//Rz1ZY
 o00nxtB5osPgg2gYfZIjl5mjwTmTBsT4yT3EfCs+F6TmqNUGdqnp70KprjFeVKXxRAaZ2
 j80Mvpuy/9VuBYt54q6xmYtlIOD596Pou91P5AVxJbtGJJfHryOGcd1UvG9cD35xsuF1w
 OXuCnfil8kr2M44dtxX6Xws+sCrJZmkinc/ptd647gnQIA+2nlX2xmLQw+1K9bQ9RIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790689404;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=ovnMtUcKMDlkzoAOw32A3rD/USsfeDMnHyafcMN0VRo=;
 b=Puuk0cedXJSKvazJnE3pU8wfx+eORtvnUFLp1kJpudRGVA29JES2g1xPO0ucPs5v6L1p
 58ud9hvjAgDk1auGC1plu+rzW5zGwTURXwr6i58HGORSsef/YsZ8FhnAwhvZ8Ie58JNfm
 LEbG2a/ndF5IpzkETtd6kTXziWrWF7WOerjY9LwGPmP5x8s2uhmIIXwWQAGynv0Wprx9h
 5pM/3Pj7k2LbJkcbqn1YTZJ/OdDK8TuqdvDqABGGA11x4nWXLtEkj12aFp6i/avtbosI1
 zs47paveu2xcTzkekKNvUwK446XvsFlTR3Xc5JObvd0ez/tiI1tsJDJM/SnvxkF26Yg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=TCMk5fYc; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::e;
 helo=mail-wr2-x0e.google.com; envelope-from=jstephan@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=TCMk5fYc
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A3E360729
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:43:23 +0000 (UTC)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48aef5d66c1so643145f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790689401; x=1791294201;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ovnMtUcKMDlkzoAOw32A3rD/USsfeDMnHyafcMN0VRo=;
 b=TCMk5fYcjX2cILSpfZ0eXjMJXAiWjJwMkGw8Nk5Svz/ffpdRllT7JiLCJJGPCuaYFg
 yG3jHBfM/I3sKkY4Kl0L/ukJWrSyhVAG8YW9yHn79goFBNCkZ2RPTH01Q88tcMfNVQMV
 +hiVnym8+Zd51tQLD3fxm0it7cqY5jZRwsXkUMnPdr4EsbUF2V3C+ywcVIp0ELntN6mO
 /3NXbXb0Pfu5WtwMNzgEW9OthLS6qGkDa6jioEENBeoJ+I0IUqPROi4W4Tm7BHtwOqPS
 g9/DGjWXdDqY3vvnFSuSd/35c8HqR8d33o/Ya122+9RM131BAQFaBS7Fl02rMVi4pjE2
 6cCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790689401; x=1791294201;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ovnMtUcKMDlkzoAOw32A3rD/USsfeDMnHyafcMN0VRo=;
 b=V4LOl0+wfNdb1kt7WNWd6Ufjcqw6/R33RWOlNx8PkSCKRCRgPNnDRX/FiC7n1Me625
 j/+crzmZhYg0KY92MoL3QHpwUXw8FDFb2mcsi/H9T6712iv7SEyb4CkGtIzbs5/OsPgQ
 NeWGvJf21kbaX7xSiVSXq972J+QzHf/uboFts7/QdJ9BINgCrZxTiOBINgO+RndoHyrn
 QkUJL0JOGz/SH3L0pbYiuJAVjT3t5+YeoEzMIF3oX24oKLNefm6xOI5/zCz9+Mdq1P9T
 zcW8u0i9EVPrwagdDNomd+rQ328jrEdVcmck5kDKnO2bBYtS/4sDYV14M+LqZOejChJS
 YGIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwfxPqAgZZCZ/2I/HUNoMbRb8msNPTqCD7kx6/mX0290h++UNZfNrTelDE3AYfGLkpr67Ltbv8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLRGPKoRBDDEQuPG3QgVaXGHKXCBzsjF0etPjpj/K8lNp6tIEFv
 bjQyswzpEGg7nMmR5BCHd1LjMRtkQ16pGHYWbDkmx6uM3LJG30sMAVKj4SWFgqPqZWI=
X-Gm-Gg: AYBFou00P5qRIPOaNl7dzmNglCTeBpodTtYZUP1G8XBq+vJySRXHh43gLUOxHxTgcQ9
 nEEKyDItQM1QXgirdL1DftjL4hXZ4VyNojqqmmBAN46lP0sW6Nxowr8cWp+XQHRuOod8cREZ1c+
 qVslhP4CQPnkMXedJnuBHqhgsYpblS7Ti0ivj6QYOb5MISCWOqBXcz8Brv/I9A8yctvrKGnaZXT
 x5fCKyA8o4E4m/J+wOAYQfaaWGrspTNoS3mmlXLGwePXVlKzyiT5ME2t2odrxMbg1q7seWjU2+i
 dOEai9zS6ew2gwCQlAiMiOSABLoLKb+Ik+G/7lNNzMH+VdD5igiNjSO6Kv+k1HWk09Um6+WiMy6
 3UZTINywDiYpXPN5tjZBVQ+ffZzOnFx8f1PhJFQrS7l5NlswVP+E53w87kcCfRAxyj/nIPbJ43U
 lBwCJP2br8l/yNrut4Q8lG4q6xQLgNq64U+ocrBg9BKaPwJmBpO6bSoDxGxMQdmxk5PeOyKIxCy
 EDCQmf7u4+Cq4RyABrc4x7rc50+AcZ9tlAzD1ZTDF0opH1f8BwOgl9bC3BxC2aPamJYAQdhXGAn
 GjgqxJvgcJmL33cwea9d4ZtIkSGEJnzhkoRwwX4EEuPIUIwhnLs6hHQ=
X-Received: by 2002:a05:6000:3103:b0:488:80ef:7fe1 with SMTP id
 ffacd0b85a97d-48880ef813emr25335960f8f.26.1790689401505; 
 Tue, 29 Sep 2026 06:43:21 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af50513c7sm4216022f8f.16.2026.09.29.06.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:43:21 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] clk: mediatek: mt8189: match the mmsys compatible
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, u-boot@lists.u-boot-project.org
In-Reply-To: <20260924-mtk-clk-mt8189-mmsys-v1-1-cb4abe521454@baylibre.com>
References: <20260924-mtk-clk-mt8189-mmsys-v1-1-cb4abe521454@baylibre.com>
Date: Tue, 29 Sep 2026 15:45:32 +0200
Message-Id: <179068953204.1887049.849401395692613785.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790689535; l=808;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=oq0KfyFvPqDaEqwhjWPnDGYqfVcoBMOXyqM4dGWWHOY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKJMNsUfERuHJMijtIzpEFpvfm56VNmtO53TnWajSwAFRycwxGiNaAhf/V9MsXesmLFtROVzYK5
 9o5qt2K6hTQs=
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

On Thu, 24 Sep 2026 07:54:12 -0500, David Lechner <dlechner@baylibre.com> wrote:
> Change the compatible of the display clock controller from
> "mediatek,mt8189-dispsys" to "mediatek,mt8189-mmsys" and rename the node
> to syscon@14000000 with the mmsys label.
> 
> The display clock gates live in the mmsys register block at 0x14000000.
> The proposed Linux binding for MT8189 adds "mediatek,mt8189-mmsys" to
> mediatek,mmsys.yaml, which requires a "syscon@" node name, a "syscon"
> fallback and #clock-cells. This follows MT8188 and MT8195, where the
> vdosys0 mmsys node is also the display clock provider. The old
> "mediatek,mt8189-dispsys" name is not in any upstream binding.
> 
> [...]

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

-- 
Julien Stephan <jstephan@baylibre.com>
