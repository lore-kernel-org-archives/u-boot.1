Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E14CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AB0780A65;
	Mon, 12 Oct 2026 09:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I0w93inLPU1c; Mon, 12 Oct 2026 09:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B799D80CBC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791797201;
	b=I4svy4pqk6sfAAbx6OSsvDRUc9hWrYlNc8/3tS5RgyzSrV/XIQG5FOZgw4LBCg2cjBpE
	 5AEgtNCzRkKonhlPrYy2YvTHHlvA35kFE+eCZ14YKgMiO3vBxpQwey+1dFLT1ZW23WTYV
	 U8ZuxEM8IoKq6081KnY23Epe3WDdY9Zg+A8nUTNxhYxTeB6LVyZjuooZP8hKNhrCtlS7S
	 I7bWBiPaZYNgC9x37BVkNYRsA1+fw7uTpe0PESoqC8EK8+rBVxBYKTcEUiLHlfX/bHv+K
	 6YwHsfa+UYYGDrUF5uFPHPp9wuUMgOpcNJTuUCtufHlXCTvSsgIEYjFeY0mAKrT4JCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791797201;
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
	bh=TytmoRPgSgYyUN3xHu1aq3bIYln+LKrF7/e/YnQcJaI=;
	b=jAXvPzFJ6h58KqxRGwMIYJrsJu+0wbxsoqrGAroDRCNeFFZO6YBRmW8sKz6ELndS/xWB
	 WCAYoDsxEBFFlEABpjYVbrcfVARzEa4HIfGrLGrC93s0IEgb/c/WOK/6dHv++svXEOr4R
	 /zTfqd2/PAJCi/ykAArqm4PIo6+AU5LMqT6/JI7Pe43prZkHN2a0hEl9FaJ12KLbw8QCz
	 DEjmJUlMcyVRAhzjK80eZp6JXYw9Kiv9NuL1jEzSZbOkSTrPZ7EEkYppeoFmWgT568wP8
	 qu+uE2ZZPsD4i6P2BkXzuWALGViOJ2bMEpVZoigH3H+cUZPf4ee/qQgXugJ25gMMLpw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791797201;
	bh=TytmoRPgSgYyUN3xHu1aq3bIYln+LKrF7/e/YnQcJaI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bn8rO2faEMV2jYLdSekiwBysh1yP1RuxVCTmEcIG+VRr9UizdOFxuru6Q81R8N8fb
	 P5E5Quvf1CnZvQLxGIhrxl9pco0tL4unVP6oCcPArahxW66si8VHaTOpXuPmPQRRK4
	 N+PqVuir1A9D6ADUzvOMZGQ193mVZwc6uPsEF1P89HgF7wusry1dU7MeoGkhz0kFv8
	 /mSpfEByWT/8uDm4kjKtkYbmkaudYpBZ2UkoUnRDaTxRjPU4eqtXrB4lxph79602bW
	 RjrXG313ilknTJ8l8LOZXOihB0Xap3M1cD64kjn8k0TPG5TUv5RAGHoBbQU8Kvdpar
	 TPc8w0mqsT1yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B799D80CBC;
	Mon, 12 Oct 2026 09:26:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 624C6380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FB97605D7
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3RuRlJXAJKK6 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 09:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52218605F5
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791797199;
 b=FWVRgczEN0ajS9P09hf5rMgP8Wj+IyHNOTc6rBogWe1mUNCUzo7ynodOvhCegR0dbTfh
 jqNP06NXuqZM9xUFKg9ZiC9hNYZaofIBd1glCgSTWsP+qqsmwpoED8qTLLzkSAylO7go0
 Y4T/bVSTdGy+Y4q+Hs3u/r5Ki9NZLB1a/Gwx/1zbEupZI/Viv1gkQLUP7Xpxho6hYLDz7
 kjKRxWD1HToABINL08fY4MYSiH3Pf3xMPvWgdVAwnWgifeYaBXRIhiQUNc8c6N5zs+Xaw
 s9yQfDU9buUnrMsdeSxUbd0tb+w88+lV60NcPW3w5KvXgrTQtDLSH6mOXx5GEYshBOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791797199;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=TytmoRPgSgYyUN3xHu1aq3bIYln+LKrF7/e/YnQcJaI=;
 b=smDyx3OK9shCpHJGgI08dPKHRQbqS5QRmH7iyJpwUc21nhRuDGjeFqClrYN5L07fYj9J
 gRIObt9h8KeIbvQqB48GT1R3Hp4WjloX0Uzkvj0Ch+fzORxv0BvMYfqs3Wik2Lz9NhWAa
 yA4hGL2DWSVfGy0Rr2bPAiHOCsraWETgLmzyXeqHhd7WeAGwOjugG0ZkLAR4MUGxvvyqZ
 wEu3bZhTRoa08NY7/Z83RcySDPQA4UN0kH19teN6QtdrvSDsGApy6J307jL/bguPtqFVw
 czttCFYESMuJScpv1r/vXHPf4wgC9dPEH1VmykawNlmJN4n7REzJ9gx1e3SWhprfW7g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="UjkIA/c1"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UjkIA/c1
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52218605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:26:38 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48c02782159so958844f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 02:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791797197; x=1792401997;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TytmoRPgSgYyUN3xHu1aq3bIYln+LKrF7/e/YnQcJaI=;
 b=UjkIA/c1Sux+Pj1TWl0WO0rnkk0isKdWznpeBZRSMwHXr8B/PtsBRhYxfV8eizOdDQ
 FdMISVYBwbpjOWXN8kcRR+8cLJ+Pg4SiN6dXhf5+u1Jyzzrz0yciH/OH/osy+nxnrgg5
 CG4cDmMBpE9PDCHiAeZzMbFGNW21cvDbKY/RaIKGhtsKQF2VNcznX5ruuhUAr/k9nnI3
 x2ekhRdHgpmc6+4g8v/OkuVL24oHE+pIpwaMbZ08hSILLRqvJQ8kKVrqzATkUf8BpvNa
 WaIRur297572frJTA4KdNkQVrKsvaCKRef1dHMB2QhiZ+MYdrsRuL8ok68L4egHZP1/s
 e/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791797197; x=1792401997;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TytmoRPgSgYyUN3xHu1aq3bIYln+LKrF7/e/YnQcJaI=;
 b=GaH8mbdS+MCSZi+HzdiYm+e8MYkIOFexH0Y0eXe2iOYGuPVRVZmDJVX6rmL+Cot0cF
 1o8IuBGFWqrtnRsdER/eQh1bDoUOWASfuLAz6FA2olU/LbnlLp9pGbA+whXmcXHGgnUk
 SaoighBRDexQw8XwVw1smjrD3J7fZkrBue1y8jEzOdgrL6Chn7vNb7UfxGKQ70AE04m2
 /UJYbkXPq0zBn032Dv7QTRoHI/qNY19Sqyj1AIOIgGMvSZ427dbaB31SrJul+QAfH0Wx
 he30+gs12w5Vpf3pp8GbVR9iGFtd5jQNlJiTSgd3pOxF/jknzaXM5+Lmwsi7dHBoYZQ+
 sHZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYeaHIEjC+ZqC8kDAOrnqatTa0WzjlCwwO4E5SA6Lw9KATwats7CmD1+wjH97jC55aQHKf+ug=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKQSRPU69oL8v67A36QspF8ah2FbXx/nE3LVqBkz8+PgPcH7T9N
 hJlDTiuLHPXoIsgNtS6Zy0CdQlsjtHW8cDPBuWpHnA1xbl7i2/jhqRpdzzU74IP6Mt4=
X-Gm-Gg: AYBFou1mHxHdFXtgdSvi0UD8cXy6sxI/60opweQB8ejCb9BR77/1KO8veth47PNt2AP
 ZijZDAMAYm6vs+X0IkUev9hjJ6TV2jzMOt12pv4IRxanCfvdXpFCAiLQCL8nRIy5p3yiK63u8Rx
 tNC70hhdJwvPBlzT75xbUwZB9NGrSuwzAalrnovfIRlhp6Hef9SO6jGln9DOLCzVeUjK2/nPACH
 +niiwL3b2BdnBVDazNBQfwK2tfoSGpQSwHouZ8wqiwgWEtoedAVhl+TVLn01HCDRC5/RN0C4SAm
 776dp20M6QEMvrMY2CJBuzsJJljGJQtfQwqxM7QExfCAKeCYPDhMpBylTWPsT+0XMh4PSoTKOwl
 anclPoEnlhkgyR0N7yx3itj1IwIH1P1SbiDQz2g3Abt/vJa2U86onYsBeaYjNQWw5ZLngVRdcTs
 +yinyzx7S+z52AbV006iuAygEyLNfrZSf182Hz9kv9GDDRnlHVVa8MQelr3czl+MzjmmRSayu4s
 dSxbhGTZ/QWS1yLfPb4Nlb28GTOKCnmQ00FnNaqz8NreyDD2TiDa7qHuxRnlJ2ZXDAideQcSU4l
 HFR0SwBH15tFxFnmsVVmj11dt4sVyQIIT+Xj5U6dCGtmYzqb8zIsu4o=
X-Received: by 2002:a05:6000:2f82:b0:487:1662:cf4c with SMTP id
 ffacd0b85a97d-48dba78459bmr20109545f8f.7.1791797196789; 
 Mon, 12 Oct 2026 02:26:36 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-f269-609e-a542-3b36.rev.sfr.net.
 [2a02:8434:7c41:c701:f269:609e:a542:3b36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dc1abcaecsm14791664f8f.18.2026.10.12.02.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 02:26:36 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 0/4] arm: mediatek: Genio 360 EVK bringup
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>
In-Reply-To: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
References: <20261005-mtk-genio-360-bringup-v6-0-630f99bf3ce3@baylibre.com>
Date: Mon, 12 Oct 2026 11:26:53 +0200
Message-Id: <179179721374.53105.6248819603598169549.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1791797216; l=597;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=3ARvy3GSItYHwDtK/sIsUKdw+JHoHK3Nic/o6Swf/xg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNZey8ujIqLscLSElajz2eFVJK/Ie4njKcJli+OtsjCSS3akw1weVc90thaz+R6k82Axij62oRt
 Xyrb4Msdtcwg=
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

On Mon, 05 Oct 2026 17:07:46 -0500, David Lechner <dlechner@baylibre.com> wrote:
> arm: mediatek: Genio 360 EVK bringup
> 
> This series is doing a basic bringup of the MediaTek Genio 360
> Evaluation Kit board. This contains a new application processor
> (MT8366) that hasn't been seen in U-Boot yet, so basic support for
> that is added as well. Clock, pinctrl, net, phy, spi, power drivers
> to add support for any missing compatibles were sent as standalone
> patches.
> 
> [...]

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

-- 
Julien Stephan <jstephan@baylibre.com>
