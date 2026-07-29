Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E30AC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1407D810F0;
	Wed, 29 Jul 2026 13:41:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y5C6q-6pxpAu; Wed, 29 Jul 2026 13:41:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4143C81196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332462;
	bh=3WgG9S753jLL795/uEKNvVOUATaQbF9OnhlqYHwgSu0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GwPEcmdnOeX/ugG8QbV86vk2OKcSV2ocHhIPsPEA2Sz62I0dfnv/ZDB7+whBFq082
	 B7d8IkO7jjyk622sIyJlInh+qx8+CAuQ2ujfjnf15FTeHnRQTVsH7XnDtZ0unt6h4v
	 StCYx2DiWqC5hfOb2I8tZ+P3l0Hv3LGBcuOGaeYpj9WFv/ZWoHYU7RYqp5b7KHypm0
	 0hAuMHv/JxUXrv+t89N/xmlbg13RC6OTjexYSDddZlXaszdN/H2w2kUBblrzo898Lj
	 0HQPBlTPeds1Bzl5iDGjpOfghix5GCAiduVs2mX4yKrZWkzXmFAdO/UZXj0B5yVlL+
	 vuZpv/Eru7Z7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4143C81196;
	Wed, 29 Jul 2026 13:41:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC1962E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ADB8C81196
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L9a178vMmjde for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:40:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BD925810F0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD925810F0
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD925810F0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:40:57 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-699fbcd23ccso1447486a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332455; cv=none;
 d=google.com; s=arc-20260327;
 b=oLId4JLOD+eAnw3nI8gbWPBYs/vzr8k9CZ+OyAuvaMOhuxV+nj2vU6ekJBbdZZ0ewX
 wwoHrjrlhZ5hE9nz0fc/2DyqYrUCQySxvogarpmgq5tgWOow//QKwH8H6IVZm1GBceOc
 8Wh9zNFWo2dLxjNNpqBasOD2rD/kxgwAjvZY7VG+6CvzJqRZkcGslRlZyTx1TFzPpXzY
 sU0xlHeFEKBJfKDthOG5x+M7N7tYA/itRgrYzSSn5ttP7ptXV4617udi4v7nDOg72LC3
 xGY63O/iT2N5Th2NgcolYUxHtcrc/WoDQEjIBfZoU/MgzJnAoaHO5zR1a0CKQbflyYnE
 HUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3WgG9S753jLL795/uEKNvVOUATaQbF9OnhlqYHwgSu0=;
 fh=aF9keONFe++wN4rTgJ5d3AlEZnD6ttX56yh1RmutyWI=;
 b=Lak7LBuTWrMX8v+PhyY5aKLjc9twfm29I4fLbJ7uiMBPJW+PpC0KLKLpTE1KVYVAHv
 +0zU/95dCeFjI8S4K3iIpA2huPaT+xUgOaMJJyi032TYU79kKNrjOoi8F8cMQpuRZ/Tp
 qIX5CRui8U3aigeDHvuRTaoBRnriGaN3ZkdMa3oTWkl/Q+YvYeZ0zu/eHkl/E+oLfNDU
 GWm6eXMKYduomwxUbNHuAh3tepbayt5mPdCLBHaCx6LRjzzAd4gzlQikYaf9x93aIRn3
 APjNB/n9lQQoJ11WMgjSAsRqRgdt6pxa7UJggulvxZboBeTG9JJieRF6I/WkeSf+xYFB
 SIig==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332455; x=1785937255;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3WgG9S753jLL795/uEKNvVOUATaQbF9OnhlqYHwgSu0=;
 b=WFJaxe+reDeDzglA42q4yT85d3VLTPuDxd9SpQnBXGxYfzZm/Um0Qgf/bDD6gW9U7a
 kl80g05ZnjxE/A5OIl8obx/t8L++Bs4XY5CboCyPQv6KFDrG5el3mumKopzl/ESHCttZ
 yKkRUvOfq276hxYYLVlUvX5cNgw5uoaIrWdsadPxMfBAjbd/VhJAYTIxU0bGyzBvKenx
 6B+0WCZL1tdF5HM1v1TuAvQgwCEJt97TlrUfiFJX3iL3PM7kGgzWjgN/0/FIGi8IILwp
 WPB4Xom6s78Rx6Az/jkpzYCyiOMtpvMI0+W7jJaJ5PmqtL1FdRwTeSeelzSJi3lDA277
 b8iw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+EAJ/OITxrP6We7X/Fk//RdXGG/PFBDp1XIcbk85jZ8I5Dvm4uvmfz9XzbUZGUb7XM5aMjOw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxpbczL9uhjL39d/euQgMjtBeT2SNian3sED1Zx4WrEVtOzKxMo
 PRoX4FEo4FUDrVuSDr7+uYKLxFCD6EzJQlUgC4JSYHiN1nDDrcmtOqIna6/UnzM8BeXJUPMUt8J
 WUF4YMceGZhc4GS6yJYjFz6NijyTxcm0TyEI2UvldLaBsWtfbElg=
X-Gm-Gg: AR+sD13dsurgzKEHfFlwTSvdk87lortHRmZ7YDHv0o0MzvHBDJVMepWdBLINhSWE1wW
 OfNKqdpXEdMiCruP3ZwreVnyqy5xSfmds3XHcEAqjk1idk4rY08BQ+B1E/2Z9jXIY858/igHLxR
 +k8AvUDl+YQhhOh5Sq3L9Vh3xGIu4/6UrTYxtDmtazOPS/+CcgIEefxT0sWNaK4zRWagnOGsy6U
 MR780vZETRXQ054P1PNqI6rCb/EH5RPpUboHffERtng8NbOzma5/BGqsmYZZUl46/jjfmQuIowZ
 3Qg19AUCSZ81K5cgJAnngrujd0xvIg3xUWRT3F43Ehw=
X-Received: by 2002:a05:6402:44d5:b0:69a:9355:d1ca with SMTP id
 4fb4d7f45d1cf-6a034a71bffmr3009220a12.42.1785332455535; Wed, 29 Jul 2026
 06:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <81c6026e-d28a-4c92-8987-135a611d5f45@gmail.com>
In-Reply-To: <81c6026e-d28a-4c92-8987-135a611d5f45@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Jul 2026 07:40:40 -0600
X-Gm-Features: AUfX_mzKXv2yfwaaRRIg4w5nEMZUaSqUek6vTy8i7B_dT6NKfxyUUyUVudUktqo
Message-ID: <CAFLszTi20H3Y5Eh99Qtpdnc-CFYJmbzHsr2SJkCRG7RreD8++g@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] rockchip: doc: remove copyright lines
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785332455; x=1785937255;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3WgG9S753jLL795/uEKNvVOUATaQbF9OnhlqYHwgSu0=;
 b=cBOZEoWRXhThaXKxQvJo36T7SlQGc1RtIIg2SmugpvNLBkrcShcSMHN6cDYkBEU6Mf
 5KPMqgbLwMVo76XXrc4ujP/fZix+elRsH2AZZ9nfljERDfZVOw+SEOgbegakkmh4N8QA
 Ig+fcsQCoTc/W4Mhs2DG70jd3AJNVDwNY052E=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cBOZEoWR
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 2026-07-28T06:51:38, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: doc: remove copyright lines
>
> Don't add copyright lines to a constantly changing document
> with many authors unless you are making a significant
> intellectual contribution. Most changes are derived work
> or repeating steps.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> doc/board/rockchip/rockchip.rst | 5 -----
>  1 file changed, 5 deletions(-)

> @@ -1,5 +1,4 @@
>  .. SPDX-License-Identifier: GPL-2.0+
> -.. Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
>
>  ROCKCHIP
>  ========

Removing someone else's copyright notice is different from choosing
not to add one. Your commit message argues against adding new lines,
but that doesn't justify deleting Jagan's existing notice. Please get
an Ack from Jagan (Cc'd) before dropping this, or leave it in place.
The same applies to the attribution block at the bottom.

Regards,
Simon
