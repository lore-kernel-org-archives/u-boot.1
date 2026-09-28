Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347E8C9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 10:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C752A80BCD;
	Mon, 28 Sep 2026 10:03:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OkTVKjM1O1Xi; Mon, 28 Sep 2026 10:03:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 15B6980BE0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790589816;
	b=o6FypNxlDnbQv8m/PNHFGNhArYeQw6pboo7TguSzB1GbFzBXgYJl4TVFygoNWMcINMKo
	 aujkhNezZHSKz/Pe/jPvrP4wKICfR6KuDDKV9UPazyUmt8gRiuwjMQrEG26tDONuvVwc4
	 xRG8Z9h/bCryTGDExJLrTKpw+1i9h/cgP3wFjdEADHqIWjRx9D91bXhs79VYv2YoJWH0Z
	 JhDcKlzBjgOXik9k12cUL3UmN+wrT6uGgIkomU7b/XHy7JRc2dOBJdHyd1JE2N3h3Ij5I
	 hsblspU7VaH3Qv+WRrPLI+0CDozOzFXN4mWpFNKCBc2cwyNIZbaospLfkKtz+Xj1jrA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790589816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=mNrUSn5qNyRugCjkXD9ZHH9/jIntrNLAObfxtL1p7Bo=;
	b=ra20JnZLvhi8clwiqDPkvF0A9CH7s8DQSSFHVtCIyzlOv1xIML4J5CeACaKjOIEoEDam
	 IID7yNwu7e/KcT/efoc7AZa9RwiwJANcYOuMtKAYGNUPsTq9SSRNfe5WMG4WTMB6t4+H7
	 HG5NiK9qceBSPI2luD0A5ApVEWBAPn2gQ78FA9l7OTpCtNGc+TOoUNnEG8JjrAgzPqgKY
	 NqKdvtz5xMgwmff9dDBG44B3/fwUCJP688KwOranWgqBCNIuZEtapjLO396SK0sJmGC7A
	 ngphF+XLW84XiSIPegM2szjBFThs2LojDG4PO+jtz25MiN35yClzfXs+uE2Dt+TLikQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790589816;
	bh=mNrUSn5qNyRugCjkXD9ZHH9/jIntrNLAObfxtL1p7Bo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gci5Rxw0LJ6gMM47F8X7irt587YR0xiejXWftQfhkp95kWbvLqDVVOsiFU5JXufQ2
	 BDpMQIOHIxnQv1qqHLx2Ja6U52odY0qg/6x/gJgHvQk+bDZT/W+AhkyMv5XYPR4Q4X
	 L/ytUYWy0jKXcvgeo7Bmp021iqoPoo1/+ihaBzCNmCH3U9SqNjMFDusjbEfb+9Uk47
	 K/xqVXSU7O+eStArto6rKoY51T9eZ1EhareZpkM/8hY2lQo9SYbPHY+1jcmSWW4fEA
	 gT5L9+njWrdwwdQigtWOgTbHvKtLYKXolitqAO9CcEToR4Sk0yAFS14u8yhzQV+a6N
	 Eo9oRLmJAgzgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15B6980BE0;
	Mon, 28 Sep 2026 10:03:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F4603D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 704384019A
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:03:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YblslWLKaksx for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 10:03:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 39D3E40198
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790589814;
 b=gCAXyLTaupMcqRZJY2ulJE0SQlhZenoQsHQuLjHADuAw2w08AoN1r6w7+gs1JdJQpL1U
 EmnCgCg3YZzYJ7+BWwHwg1v4LzOoQ5E4d/8rIINTVNtHvKPZGtZAI4wMZnOZG8WJ8fFm1
 El8btsmSoiFgaTuSBlP8OO5aVMJ2MxC+vgbUpGOT2TSqglH159ITIXggphTSfEIp1mN9j
 Xi//Sqspdn5OqZWhOSUxEWCRRGmKt0enzag/8ChQXAp9vY1l7hNJwThzPMFNvk7yhx9dO
 4tWFnPKMRCTOUQuCU+DWgFfhYscmX2MdwFHC/m4saPcSNCDwseYxLr2e0IxYC7Bwr8Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790589814;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=mNrUSn5qNyRugCjkXD9ZHH9/jIntrNLAObfxtL1p7Bo=;
 b=A1qExSHhNjO3hmgzM8DEr7WUJgh/E1mZqxnD7QDlcVypGFiFAodvfJEud1Qa3K1KpDJ8
 D2t0/eHP2pErDBtGi9ysnNHXROf2zKGxzj9y1IxMnQbeq1PeexsSfBRrDFwiCX+B7lzVc
 z+f9U51OCS5inxsTjLPMUt2tnHigT0/3iQtrPgMP7cLZYmN6DmviTEAaJqMeGy0fsjCJ9
 B8WmtaC82aEGx6y79Kworxj5tpsA4K6wjCXDeFn1WSgYtJHBDa4ot059ivPzAMU8Fxvsd
 +xUiA+nUwEJpn+fbU1AeW+c6YmcBoVpuPeKSqTFcZplhjrufzit7NJA+q4gRCYvqtvg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sKUFvkeM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::e;
 helo=mail-yx2-x0e.google.com; envelope-from=ilias.apalodimas@linaro.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=sKUFvkeM
Received: from mail-yx2-x0e.google.com (mail-yx2-x0e.google.com
 [IPv6:2607:f8b0:4864:41::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39D3E40198
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:03:33 +0000 (UTC)
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-6729c4030f0so2445637d50.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 03:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790589812; cv=none;
 d=google.com; s=arc-20260327;
 b=I+gVmvIYXzDlG/En5tU9LYTIBmGTwCwc3EO3i3r9Qs1/X0xnbo3zXeuoMDKDNE7yKV
 Ed02czHO0xD66oHntqEa49RZ3UUAWgKAabM0rnVUA+q6mqJOtFkBZfD1eIVuL0P+N2Ho
 PrZ51e+k/hukdd2XvNp8EHEt0MbJQaUH29icIBemX6vUGGCdG2LGQ1XSyRH5u3uY4q7F
 VIL5y/l6R8nab9uOU2uTL52TnkLssbqJVnJpxhDaKTUGtoKdDPh5EHy5AW0VT7MlXMj9
 /9AZ6OmIV60t1H+BxdeyJQcVdznc3TEAMYpgGoW9/uKVGYYIDWSBIkAenJ+XvLSdOtyv
 peRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mNrUSn5qNyRugCjkXD9ZHH9/jIntrNLAObfxtL1p7Bo=;
 fh=cDrnOi7BKIdzF8XReJKU2Up1+8fWOoNycgTpp5PdjIU=;
 b=O+zYxrfs7bhtxoY27QEr4minayB62fxU5M7OiVWwB/bHA9d19LyAlF3AD8m9gcWKQg
 /J481bA1OV7RNgyLECZYzoQ7DhBhexUp4QzmBVXJk8eChkhlEIES3iwCrxu7y+qbonOC
 KJmjJpYQRcyKO7VyspNp0oxJE7ytxQlw+FMi/BnVOYZZ91SNnz+9ky7cRMenUnAfnOOe
 K7qxCBHVEWyHoubG3s8uol+3Ck04B9F6FkH0V7G2XUc1pDNcE6CA30gU9matU1YYopmj
 X5pTxbF0wmYv963ip5jSAABHwu8K827coKiOXQQLjkuu6BGYxWNyG4DTmCe8nTBxrmML
 uMGw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790589812; x=1791194612;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mNrUSn5qNyRugCjkXD9ZHH9/jIntrNLAObfxtL1p7Bo=;
 b=sKUFvkeMawMZsDK6N5iuPJrcnhy+szemKzQ5rm9fQJxE6e46kNKQYEyUQiuucLlJ1D
 xC6ecB8WrysdtgNGxpqB0vZWhDG8nlNO8vaP6xkZJ7+yjbqI+fmiO4xHqQErN2RTYX6o
 cvTYoheRIGjcBNBaFR/x33AkSxUIL/SQzCWvbVCe0eCN9NhchzY9dH+i0xhxAHYapmCj
 9aVvw/RIuBNWyeeL9XXrFAIElqwJ8TjheJmDr+5UzamPkzGkH4bq54Jpn+iN95P7Rslh
 /iAqucCQiJEesZe9L3jh4ueCbScbxrLR6nXdj0LhGMeTcknJAGIqOJlnq9uXYJpUw2uU
 /pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589812; x=1791194612;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mNrUSn5qNyRugCjkXD9ZHH9/jIntrNLAObfxtL1p7Bo=;
 b=m5fcWwsxCO5LeOsSOfQ0WzvalXe451ycwOj/GdHAoTH2/lQvrKWiZwvKmsIIqcdtiQ
 Qw2BM53YUY9hlXb+mC9WMed3o0Yda5zsvlQ+90Q/fHPhBTESt57ReAhKV+GU7Zyej4KA
 AIZ/YkyzBb2/yKhhwkID9MngH5s3+jAY53AjpYz7Woa34GN+LMNvjXe3qKjijFr3Z6RH
 078HrVPq0FTyR5NsvQeW+TTYrmm6McnXp6LGxTg/9ioQEghONd2DMgT1m/YU67vVnrs/
 Cq8Th+3MxSsTsR/BbP0eko57s+ofPaxvm8Q/i9Nsd7MI+tyN+mPRMUJEPFl+DXH2OQ6I
 6EIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzmSwwM3AO56THb2QwSpqrkV76Yj6SGmN0vxAJBFXsBbC+swJ4fwQDkeH2ADsXU3c/BibE6m4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJxmH90qvFSk5unAzdFMusnbLnFEs8dNSdbTVurnoq2Ig8H+ZLz
 +/zYMCi4FQMuqzyCVw6T42B30Cpw09mL9NA8Pv/HsbtKpDIKngasLqiqG+md79L2OomwkePDDtc
 TTcuzqn29QGYO46IFZp4AHUmphJD35vPRppZdwVgkPw==
X-Gm-Gg: AYBFou27XdmCrJnNDfExv2m3bOwZnckjujW7PQ8YU/6IcMU3W/wZ1/Xs11ZDvMvmG+Z
 aJJ6QubUdZdWTKVbIxM1B1X4s2vZCi9EzeRo2AjCkQSrnGEsIgU3ZXDgp2trQvA36MIh3ePmz9q
 kG651v0JL9PWD2jTHFJ3PmBkdnIkomYtYsHlm/5VTn93ANklq8dQADtCcQ1al/GcoAcTLPnI484
 z9FZ06RP7VAzuI8kVtE6al506w4HMIEVbiW8hiqEvR5GB1cJpcayZ6Np7OGJccmEuq1mn4JRZwZ
 YEwvPei20aUtL21W1MpUBTidurP4RnPwZelpFd8fB9la3GE/aTxAvwt5/NBqV32OdlUQ2n61Fza
 T5gEBLa5ld/7NYmKmNZOrs+sFCoCTfrZrIpHc48H3HDwDIK0fJiAoBxH09ff/TQvUA9zO3JnznK
 ZQcjCjTMtAk4nrVPQ04tMMyiSlkFowQhxJO9zs6f7d8jMadvqb71xwOBzIXKOfwdvCHRFvnVzj+
 LdTnGUUJ9+g/JmA9FC2HkXQyW0tJDGjbzOHBqj3ieOkkk/Gt8Nw9tSh2JIpsaD3huw067RcLzB+
 w6BqdlGXZBexznWUxKaD58sah3zIJuRq6Pd2yz370lrGpdn5GuiKY1u63s64sQPClTZgqJ+mD7Y
 fockgOZs33oEOckb6pKvnAOAXmlIM0zLWOxfL2qUOUV201YQETBRb1A==
X-Received: by 2002:a05:690e:b82:b0:672:a52c:db32 with SMTP id
 956f58d0204a3-672ed5626famr4598365d50.106.1790589812432; Mon, 28 Sep 2026
 03:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <aq2b2AspOcySKRvl@trex>
 <SEZPR03MB78102F7A1B91EBAA72743B2189812@SEZPR03MB7810.apcprd03.prod.outlook.com>
 <CAC_iWjJmZFsxBn_R4z6N5RVewjDL3GzBWY0t6MTiLk5tSCN7vg@mail.gmail.com>
 <argt3LwLjENr5vZF@trux> <arg0a8HqaRxVif9L@trux>
In-Reply-To: <arg0a8HqaRxVif9L@trux>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 28 Sep 2026 13:02:56 +0300
X-Gm-Features: AclHuK-5Xdfed-Y5W2EmOjF_B0dpW6bPU1tQUUtNpSU-mPt-lei0IIs64PFa7us
Message-ID: <CAC_iWj+qCgrP3V5o_ztyGy=gJPPgpxZPefMuw6OFbcLr84SHqw@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] ufs: rpmb: route OP-TEE RPMB secure storage over
 UFS
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>, 
 David Lechner <dlechner@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 "stanleyjhu@google.com" <stanleyjhu@google.com>, 
 "Beanhuo@micron.com" <Beanhuo@micron.com>,
 Zhaoxuan Zhai <zhai.zhaoxuan@canonical.com>, 
 Ethan Hsieh <ethan.hsieh@canonical.com>,
 Jian Hui Lee <jianhui.lee@canonical.com>, 
 "jens.wiklander@linaro.org" <jens.wiklander@linaro.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, 
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, 
 "tanmay.kathpalia@altera.com" <tanmay.kathpalia@altera.com>, 
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
 "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>,
 "n-francis@ti.com" <n-francis@ti.com>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>, 
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "jbx6244@gmail.com" <jbx6244@gmail.com>, 
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>, 
 =?UTF-8?B?SHQgTGluICjmnpfngJrlrpcp?= <Ht.Lin@mediatek.com>, 
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>, 
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>, 
 "sumit.garg@oss.qualcomm.com" <sumit.garg@oss.qualcomm.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jorge,


On Sun, 27 Sept 2026 at 00:09, Jorge Ramirez
<jorge.ramirez@oss.qualcomm.com> wrote:
>
> On 26/09/26 22:41:00, Jorge Ramirez wrote:
> > On 25/09/26 12:59:28, Ilias Apalodimas wrote:
> > > Thanks for the detailed analysis.
> > >
> > > I am pulling in Jens for OP-TEE and I'll have a closer look next week as well.
> >
> > the concernt I read - please correct me if I am wrong - is that this code affects
> > downstream projects.
> >
> > This is just not acceptable to me - downstream implementations should have been
> > posted to prevent exactly these kind issues.
> >
> > We spent  time and effort doing an implementation and sharing it with the
> > community - it wouldnt be fair to us to block this merge on the basis of
> > downstream projects being impacted.
> >
> >
>
> in summary and to be very clear
>
> 1- the upstream CID derivation is the u-boot/op-tee contract that
> matches mainline linux's ufshcd_create_device_id(). The contract is an
> OP-TEE-defined ABI, not a Global Platform spec.
>
> 2. Moreover CID-key is OP-TEE's own HUK-based derivation, not GP, not JEDEC.
>
> 3- Nothing here blocks anyone from overriding the static ufs_rpmb_build_cid()
> downstream.
>
> 3- if downstream scheme differs, that's the cost of having kept it out of tree,
> not a reason to hold this series for speculative plug-in infrastructure with a
> single backend.

+1. Macpaul is there anything else you can review apart from the
downstream breakage. TBH since you didn;t bother upstreaming that,
objecting to code that adds real support doesn't really stand as an
arguement.

Jorge, I did a quick pass and I don't see any big issues with the
series. I'll do another pass later this week and send a PR if the CI
agrees.

Cheers
/Ilias
