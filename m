Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF5EC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 20:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0451B40818;
	Mon, 21 Sep 2026 20:38:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UOsnSLSNx9ZB; Mon, 21 Sep 2026 20:38:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 43DF5406F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790023086;
	b=JmqImaH0NfHx+UvddN1P14Ol5yCOCXE4eQ6udjEhnyBx+J62v/t3KrJTHel3of+IjXV6
	 LT1FnUrGiEJhCkUaO8kC60DBea43VE9sqSPLsPsZpb8SH4Vjkr2brGc3hiQE8UGYobc7N
	 nfZW/EyrPz8QTYCX2ZH4qwt8fHcRtP9WFNsLTj07QT9gKSbZlU3Ia3y/dxZhztNN1iG/D
	 bqWyYdfTKavgQskT528ixbj4oquxBjyzz6yGVnv5l+bI0t15C0Dr7FHfyewEjbfDe+cbJ
	 4autvVv5g8+zrI4bT7vlpxtyWhon3mIKblAlOJHxna1UGYI707OzHdnn4lziiuKjGNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790023086;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NrE66mASEd8AgHyXlBkhFMLMCDtr+aOMN3SVjiSvIDo=;
	b=PerkHJ5JsQQ6XNq6y6xVHE9l+OFBzB8lDClGAIHWDeD/A+n++96RIuhixlT0tTPDD5Op
	 kvxVkuQ64F3+5oruVaQ0NraaFViwj9XqRBe1SKcT0gyE0zTzbNvsMvJltRhRd1IZGSINe
	 QG3rvI9d9wQLtqTiMNE2U6HZlet0OS4AEVbbUDSnX3QZqEEzk2JUdk9TzUkziEqo34p7p
	 MME/On7GkLn0tlZYJkJfqRKDUBlzcl9VppJMjkJa0sDTTkgLzfxy1Y3cixTtUI0NIcBPI
	 4mo+R5DtuZPvtoQocjZ5SNpZ5Z5u2vpp5diR90O51vj7TBvJNp+JSAVb2Ej7ddEQZ8Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790023086;
	bh=NrE66mASEd8AgHyXlBkhFMLMCDtr+aOMN3SVjiSvIDo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CpqrGEgHSCgG8/2cUlS5ZkZU80wzNQICNjyS3QUINa0iCj+p4crfaD71UqJN91Hq7
	 njJAx2F0jB8a60Px9f4g9lBpRdrvCD5HJCrrY/WGLA3+IojZDGEJYUAql2Mij4p+As
	 azrzflSw1ZVV2GqrgcdHUMeZD2MQP4qnhE8wrBWlrynlVE6fbLkuD+qQDgcPVCwCBp
	 GqvRnMb+o7PUniAA5CmZ0bsjwmIVc+8y4hBPmLMrAmtA0eemYe8yrQGw0wdd1DoXEM
	 qvxF7Bn47bn3q9vyTV25Zyr5+WR5az55hvpC9lecFQeW5fKuQSayG69ZEuX5kqE/4W
	 k3oQbELpOnx2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43DF5406F3;
	Mon, 21 Sep 2026 20:38:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B956D1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 11FD340177
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:38:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sw5rKJbnZip7 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 20:38:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6203E400F1
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790023084;
 b=Utw8oRj+1pKQ13+59luPSHXU7qmJnVHCw4f1nTzoVHqgKQt/ybLMh5c2pkKoial+9evs
 RvUqDYyYzv3DU+kDnw0BSUGq456G3RanPqe8iwur7YxOny4TFigQdn7z3j4xWcatAxqCQ
 JBhgV/nRzXkdyv6WF7XHo6IlUlaYJr++Ae3LiGmSECjlbx0xaBkK26kupeM3u4xgvrWdn
 NzZAnCnGd9LcQrO16yO8ROxIQCtEMunMDkW8MBuX3H+4783B207OpkEVxKiblxXq6w94V
 8K3qgucJXoeiD2bDDnNRFCX9b1LLm3l/2w4otWemd7IaK5Ndf5kZpgsD6jZHLJEV7Ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790023084;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=NrE66mASEd8AgHyXlBkhFMLMCDtr+aOMN3SVjiSvIDo=;
 b=VX0F+wxrb9VJPW23yBgXw42sJ2NgEvbXqF+KnKtYzKCU17RiTm4VKUpyVreipZen1Bnv
 lxIJz7uWVcllW5DzfqKZf9SFLm2jP1z3WIM5PLiuuQjOt+MIIQdUHaECp6JEIse8Jiuj7
 VegHeS+/VJAtPcqoFtoFBWFMFLRm2sQkBQcLxQQXRWG0O2unYWCRVy2v9rs4P5yLb6cO8
 sDoVplbTRoEcFj+2z+X1JbU9++QwGngjubk3Z/oZ2mKmMjlRP3Y5Dq6kb6IyvIpqCFf/F
 3uvBJDOR7EFYvXq0EPB+0TVYMy5Z6qa74vQXGW3uOQPR6JRs7kUcNAzuj6rnSm1JtSw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=PnKWQ08m; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=PnKWQ08m
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6203E400F1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:38:03 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4b37a36887bso1824103b6e.2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790023083; x=1790627883;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NrE66mASEd8AgHyXlBkhFMLMCDtr+aOMN3SVjiSvIDo=;
 b=PnKWQ08mphDuLTq/ATs8k88dy2d2W6Qi0+ZkoYKpfgDqb23WnBQzBmbowS3+43qcfH
 B20bf/D9a6j/Wrp6VjaGFDGkzw0FGK8ogdowai4fSTONbh6WZ4D23Bdwz3AWxZj9oMmp
 rAd91b17fQV9D4TQ3vwSlySJ6cjzNDBv7lkTjnWAEuVFtqGx+4YqSW3XRwI6wyYB2O7A
 i/Leba/cKCT3Hg8fJaB+VBsIPMcXYHnDiVFgUlGSMfyoZyjur/sUB6Bp+X5YaR/8OOO7
 L3e4wgAh9QERIgcv4VG1GWzJgi1smdyH6YYNFt4QRLhQ+oxQKmkrSUahk3Coikm8E0pj
 U6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790023083; x=1790627883;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NrE66mASEd8AgHyXlBkhFMLMCDtr+aOMN3SVjiSvIDo=;
 b=fd/D3mSc2FP5Et+hbcHv/X5+dUV5cMzknJfQYB+Fd132mNU9mwHHNy1PFSQgvt+iC3
 2/hRts7GY7ANyUzfx5TZAmzKzwjdZDxTvfdsPKj1USC/R13fYsfy1uieA4FRXB4HF7NE
 RbSR6ndhX3+3X89l1WIXj6/r/14gIx3zRIQhOlP0PWC9qkbwzmsthaJAVTU+X/pzU17g
 R0CSJ/vzqQlLdj++WR4BD0H02g9qe2MhaVlV7UAfr5k3QKnxflJliIlkkheqtR1FKx0t
 uc+jMVT7ApDEizl6+0bzXRaLjJK0knFrqlz6l1YHEXLNyLKGuhC/z4rOJR0m8QpVGaQm
 uguw==
X-Gm-Message-State: AFuF++mU5NVZeE2btVT1GLWFJMUUZ2kwdl5XGihygo8lZwiHFdX786Aa
 2Y7vYPTn3MatDOM1KrnCSGD8W6NxdrszvNIeLm4odOKLO7rl6ujU51F754dswe07es8=
X-Gm-Gg: AYBFou3gF+JSWX9EpvwJG/hry/Y5CuTDffK7x4BdTd0hJQuf+VO01wfca2nFVhfkzdg
 TtNOZSS0jj1R0g5Or5DoqaUHz+13oyi22jI0X54V4vPs1jBqRlVTBbpzhukeEcn6D+PSB/yv0qN
 r7s05++gvvgxS5VDveoxaDfCq2+ocYl72kq9e24coG9wiwvmJPnHumsO4vibe1P8GfmISdGDS8j
 Qp7mlX5vw6j8a6LEseX2SaalQhJ+URJ7Mp4LukX9cotRW+bclppSTxwnYXAKFVHCwol549LwMig
 MPnt4E2aRh1b6WSVE1BcY3FRSNa0+TxbgcIXNPTO52HzhNeATd5YUuuc4Lz+hUG6QE/CtOj0NLG
 yIA1wlR6r5dqTQWdJ4kcGDJCHA2uG/jIHbIhyV5tOe4YwEB7mw8RH3l0oBLFnfG1KnHP6g5JcQh
 Unj1T7nZyeC7lZKwapHuDzjsPcru6LInSo9UZoHgWwVYiZOPwfeufs22d8ia9gVSA5TG295G4X0
 uo=
X-Received: by 2002:a05:6808:4f66:b0:4b9:a8ac:47e with SMTP id
 5614622812f47-4ccf893ee4bmr14000478b6e.28.1790023082871; 
 Mon, 21 Sep 2026 13:38:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:48dc:2ff3:bb18:4337])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4d42350ea8fsm1356838b6e.9.2026.09.21.13.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 13:38:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, David Woodhouse <dwmw2@infradead.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
References: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
Subject: Re: [PATCH 0/6] power: domain: mtk: add support for MT8189
Message-Id: <179002307189.18666.4405198807669308949.b4-ty@b4>
Date: Mon, 21 Sep 2026 15:37:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=nd3+Vtdz2eZXdKQe/HD5Wk1RTXLMdQipEQXyksNfEKI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqsZWhPn5/RvUlZBs5go00aOQgeZrSIG8Io2uwV
 y5fpemEXuCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCarGVoRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Awa8H/30vdT3/6/q+oaIr7kvFP9M0Px4XNIWQtb9rTt0
 g5PZMi90zY76MCrYdXVSmYfWjPBGu3N/XPdOFZU5kKQHLvyu6iBVz0in87axdDj8jcQkZsZcZS7
 F5Hg2EV0232Aj4IxaNyzghq4K35oUUx4FRa+yYazx7eKYKuQMLzBNtVeC17mLCo6TeGvYflUW9R
 AsvKZzncoZMGWDnGkdHsq3r6S7R3XvfDw+D4paFgs1RLJqJQ+M9AAxlaZju+5/HLPYICol8Mru3
 XbgjOGLhLIfQKsUZeivI3d9Y2IsQ1Q+pNrkLKj91eWjSFbO6tc/y+N7CiorlxVvjuYZO7YGW1WV
 WU+E=
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

On Fri, 04 Sep 2026 09:46:27 -0500, David Lechner wrote:
> power: domain: mtk: add support for MT8189
> 
> Adding support for power domain on Genio 520/720. This will be needed
> for adding video support soon.
> 
> First, we make a cleanup to the Kconfig (similar to what we did for
> clocks and pinctrl) so that we don't have to keep adding new Kconfig
> entries for each new power domain.
> 
> [...]

Applied to mediatek-for-next, thanks!

[1/6] power: domain: mtk: simplify Kconfig
      commit: 9f2c5e387f56aa8d1316f42dc0db735355f9ab8e
[2/6] configs: mediatek: drop no longer needed POWER_DOMAIN options
      commit: 2e8167c87da135f0337eb8186b2ee4167f073a47
[3/6] power: domain: mtk: support two-phase bus protection
      commit: e05c75328534e785cc3f32f46522716a9ab48b0f
[4/6] power: domain: mtk: add MT8189 power domain
      commit: be4c451a4d2ab2d6338066b8e3c38fdeb788896c
[5/6] arm: dts: mediatek: mt8189: add the power controller
      commit: 5d98ca1e1058408fe6311b12867cf232bff6a5ad
[6/6] configs: mt8189: enable the power domain driver
      commit: ee5235b5ad9cb455a77483ed4f609e9aef0c417e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

