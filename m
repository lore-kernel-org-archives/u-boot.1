Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18DCC79FB6
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 16:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57702607C8;
	Wed,  9 Sep 2026 16:23:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ysyzwm5YJje; Wed,  9 Sep 2026 16:23:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4293F60626
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788971023;
	b=pJNVoOnqMtD2+rt928UwXuyTGZZ98tZnDH4odr1ihjNVu+6RmxW8xhVda9oxMV8d9Vye
	 Mxd+gnhUoqCSUQJKmUKzCEhIfUnYl6iA0PyxV3mV/CqJ16JPr2z0lFp3lIsC/0IUeXyt2
	 m8p5iD7r76vNJisZ+pBK6BalKBmpU4AWXFvXvnHVYSQzO/izIaWOD3KxMl9YJvXZtxR+0
	 SRJAtuGOXKDjam7JFtuiEvvPDVDKx308lXXlQojSSrP1RSO7og9mX05pqSJtNPtCee2Mk
	 yKJVhG5zqEFwPAKUOPLQdV9gUM5zpyIiOfjd1Y6jIZrfHimL4CWFqdb2aFyCYGqFPtg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788971023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=v4ryuKdYoQ3LF4ONcFh7R6jTvfIxi7kTwzuguNve4D8=;
	b=YZT6NnW/RU0edPLpKjJkZCkIIOkmq8jciebwyAu6CXlzJ5xjG+4ZoFNpp40GyocriHyx
	 0Fjq9+/dXMZTij075z1n9PJ7dAGzLvRsqbXlsNNh9usZv4IbvSXMuBme0aGu9jsZOc5mg
	 GRtqGiRnHvUnMf4UKxgRMkkHBjki1jeUlmC7DSpgeOYNpnr8p/rILjmbS8PZexkXn9v/Z
	 liMVq600GKpc2DaPl1kiMiiA0qBUOvpHpI48tzn2SUsYGJ+sntscjaMx+WqvXYI5w4g/y
	 j871pfYJCOlorVZUTqbEoXJ+zfIgtJGSCyrAh9tBbxSXyNM8O6H661L4hzQEFDwGAgw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788971023;
	bh=v4ryuKdYoQ3LF4ONcFh7R6jTvfIxi7kTwzuguNve4D8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bC3v3+05sBqYk2Sa4HJTtTUlk3bB+3eZ+tYCkT3SdL14iDqL0rQ2f7HFybBMBN4WB
	 HBid7kQIPtDxV9FuypNn5gg3bKkbVAm3GWcjjG4ZAKmG72i+WKqLMRbj+UCad8hIua
	 tQzO2Z1ZJNdydNLa4268QaMhLg3ZAHHqh5FWuwAlrDGOF/5WACNHXwnoVtH8pZm9Pv
	 /GRd2PwUweNKQ0q8z64uxyI59jsky1TMUeN9Ra4JGmT0Q4jiPMa4b09XrtyhgBa28Z
	 eB3UjT1X210n8rIwhvLfRwghYlz3GkZmfbuwfZrvQTIOil9HY8sMcnxGpRrPW+iEOm
	 Bz2imtNYLj33Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4293F60626;
	Wed,  9 Sep 2026 16:23:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B682D2FC
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9C657407A3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:23:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QkdzeQ-FWVlo for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 16:23:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 63DDC4079D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788971021;
 b=gnAOrdGa3zGZEgOwyXGCMfoQfkyMNuHfLxzuKzbBmzYvQ5Oil1SdhnY8BNUE+enoa/xL
 Lo1f7/Z+HoRuTUcfGcez9wMWWAkC5WR6LSJxt9IWTPdH7M2oCDsC9Ms0Bo07luOUfGPr0
 QxygfHTLZwIodoZaB0/sMeCW4pXGEBVr0XuC8sWRKB1dyh807zYqAKAQhowbkFJee750+
 ldjywvTxbZklZv+A/vbs6o9FadL38M9SCSxn8pA6GJ8oLn1iMXxwG8YVKh211GgMw7mB5
 UJ6L04YBnUGpuOAp8xPxHjGKewlY1PGbVVuZpuildxf1yeK3iYsId+ISJGXQGlexVSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788971021;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=v4ryuKdYoQ3LF4ONcFh7R6jTvfIxi7kTwzuguNve4D8=;
 b=gemdGh37oQ/cYkj5EVP+7NEYTWbmy5QL4yy5Dv4zTu03qT3vWgCLPSQGrdJTnUyYFJ6K
 T7AHAEVh1/tQMLBccn8o8XtNezCJOEtOvUKLrv8pRRyeNji8JEzDL4Thltf+EFpBXqnMa
 6hbP1C2+G0d90tNGXeUnEHCtcwcHR1wjie59zzMBimFjkWWN7Jobyf0d8xQf/zbZ08AR9
 UmJDO5soOxQBpFHpnn51NR5j+AzSx4+CdEyptS7NQeGyCfGL4dHINBl8dOzQInZ4b1ulx
 6TDNk7gCxv0WUGU4lpW+UIA+FVhKGRA0FJOiawD9TGZyJ0oMTmuB2fyojHz+nayYv6Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Q6C2sjqG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Q6C2sjqG
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 63DDC4079D
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 16:23:39 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8664769db58so42487877b3.3
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 09:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788971019; cv=none;
 d=google.com; s=arc-20260327;
 b=I6gVrKVkKuqR5c0n+/6xvRSIiG708SvOW1huwDsLMG2TEE4ifM/SPozVGQwUDxNBDT
 wQFcKFdB+6qYIEd1SM8Vv+Wpa/WahSxQU0h3dmo3IdpbpFEl91adYA7bJ/czZNzJNR55
 Uhl0Gwq3CxaNK1C5zoqPWR5TX5MQ6zBxZAM+pnTwfaxQh3K7Ljr4EDQ5TJ4LM8nZG/q4
 Ebi3UaGW7CdZjPXCuKOqJHO4W8FntwQIkvA730014+NtrTCeCPL/42ZjucoHSfK8mx6x
 r5hzBiHgvhqo7kbKpLWfMyDfr7TjKMV9V1qpqLvls0t0YZ5vjY3yndDvJpk3ZDS2W3qR
 qJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v4ryuKdYoQ3LF4ONcFh7R6jTvfIxi7kTwzuguNve4D8=;
 fh=SgX3lzKXsL5uOHPUteg8m8HKJkb5mKF9KCqOub2vpgM=;
 b=QuIpC43V7x/w1qgbluhvCILvNjHfnFyg/nayqj9tCdmY8n+mwghNDMnDiO368YXelt
 O3Gxh8mVdMny4feoAgVf31oLAILnbqG2iePfp+vOiPaN8Zuee4A2SSk97HjOraMigGaU
 d7OW/eulg5C+l0w36wEfiBj2Gl1p+Lz5mkFeMY4Nj8azXeA1MK/OFXOtsC2smS3HhVsc
 lfHJNYS83ZuEl7+edM+1SnwzDKtPrtT2CUlXzFAgIk6Ei2eU9rUC+4Ohrg3utnR6W9Jn
 azc4DBkdRSKCtjYZOFToLurqNPwhs1iqVyhdHsYPlw8GUQmSzHYJRoMo44FEJUtA5Zqg
 DYXA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788971019; x=1789575819;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v4ryuKdYoQ3LF4ONcFh7R6jTvfIxi7kTwzuguNve4D8=;
 b=Q6C2sjqG9JRc3DrYgeLLYgViLUvRzYX/+jWPaihcclMywRkXZ+X5QWZ2kelg2Efr2P
 s1GF0sEJJS2We9Z1ItOOULPkjsY0F8o2Ut97fdrz8V3vFZgQeci9BejglqupRpp1P0/s
 zFoWMEhIxjdyrgFkRkIR1gI5yzwkRJlhOGj9C+t0zBFzMyQjn/Fz9oe+bQVmQWqj6SzU
 ujvMprX8Sitjak0kivzEEzf3gJyPLXPu9wdxTKEDhbwhffdfBEfj3GPUb8Hmthnro83l
 2b/+KqQibIgqKTVh4g+cPDzI/3qAKFwauijDFqcBXR2YCarihq08JRsQc1bFnf7vdXYH
 Y0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788971019; x=1789575819;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=v4ryuKdYoQ3LF4ONcFh7R6jTvfIxi7kTwzuguNve4D8=;
 b=Y5lvP93HEvhu7wYI+ttpdUJEes4F9dtdKsH4DDdM+V5z6Pia91z7SOw3BwQaHwBsMo
 LTAAPPeLPxcse6ZXdAJIn41xnk9mhUIRDkQzwcvmoZhR6jnNBvjVzHlVDZk1563Fvx1E
 ehqm0VExpm5VMKzicjMF5DJ63Ap3VhZv416vZxYIuuOPJFoDFgkxdMY1Os8njqTgUanp
 bSgIM9QAYCVikaE5ozyq+42FZReAj157FNuqZs5T7nIz+SDPSq5EKz2AICBF9ZdYk/aT
 AGkwN/2mhhCwm3egbQ0hBSvdKnl0PRBuKvRTG2+N4Jp9d7gJCut3jkF2lLbj4xsNFSmz
 vdrw==
X-Gm-Message-State: AFuF++lcT2SMeqYQhwsKm7uvKnqvclJeaia39bEqqkfiyglX7Tv4FdUH
 YPBeNsyMpYDeBWoTqLHl+nL5Ldl4XnBW1zZMM0uKLehN6BvXChjsipfV8wDQDihtZNHn3Ivk8WY
 Ht+WIOH9Z5gCTF/lp6GH/6nMg8sdT+3rEGjR8+tbfP8y2vXgS7KBguFcUTg==
X-Gm-Gg: AYBFou1iRQ0cM0PPnxvHrtfymtD7EzbCCNJTWK3t7E1I7x6vMlq+soam7Tcopa5TNNP
 GVdS5AZa8Fpr3Az05MhpSfOeJTc0Z36u4+Tx9Ob+0xUYJuZHs6f9DFUL6i+PkbNCNoyxEJOBI9U
 50hs9v+fksKzOBKPjFB2i6YVP4UGxrU1wMuV6pDgiZzmn9It8k3OZ6LJOqbp3hSs/USaF7bSQf2
 vMt2wQNgRY7dbjo59AcFoy+JEhuvEfeRpeba7EX3m56K23n6PFZRombiplZlD5zreVXHVg5OrwY
 SNBYRjfIXB+IFw8IIdDNMHCkx+9oNX7ROnRaOXJ0Rrc6Rnnb/4x2bLHHVzkv+msVF4F8hN5Narm
 KbDZ3+6Y+xpP0pwEVMOMr7kSCyiiviltk81QWGoQN4F7xzF1fjKAbJLnVMAMHRQY/D+q+vVAhMY
 lTuJ3jdlp7tPZkV4tY9BLypHsnGhpWB5bfHaaAksnlJQwX2eeiHL9hvYI0zgA1+E/89kdD+g3gu
 Tk2aJiXGxneDk3p/nLCvRlYP7D2CdkjhlmbXFiNa3MTaYJ6vECV1HR1Fd4pJXOhnwXIfTyt/RuZ
 PfWShUpqNHusFYnoenRMjvp6bmVpjTY7DlTJ1fHFvfnkIZT0iI8H+8oUDN/7TQZ97B/xNLLahDq
 e6b/VBWUI8Ncga74xLU7brhWt+1rlk97LEpGOSLSxlyf7tSQWq2S+g8l2e66NhSBn
X-Received: by 2002:a05:690c:6906:b0:862:cd8e:78fb with SMTP id
 00721157ae682-871221a80a8mr148558647b3.2.1788971018499; Wed, 09 Sep 2026
 09:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788879818.git.jan.kiszka@siemens.com>
 <598cd2523e3b2a8b7a613468747fe740b1f35fbd.1788879818.git.jan.kiszka@siemens.com>
 <CAC_iWjL9fOYDdyfHRh+LHAeAh_AjNA6tajAFsjb59V6PccLwPg@mail.gmail.com>
 <f78cecea-5651-44b8-a817-18c084001354@siemens.com>
 <CAC_iWjKsyfFQA+ASq4WQvQf1t2uKqsa0CTCdLvXP7MuuRuTYrw@mail.gmail.com>
 <7eacb72e-e147-4ca6-a704-25a7753f02fa@siemens.com>
 <b8a8ee0b-17e0-4353-a3c0-3baab12e95af@siemens.com>
 <a7544672-3379-4fad-9e39-033ca7a93918@siemens.com>
In-Reply-To: <a7544672-3379-4fad-9e39-033ca7a93918@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Sep 2026 19:23:01 +0300
X-Gm-Features: AcwNN1UZ31C8uWK0crltEy-L2-TdUUFBdAxlNmnjFNrlmzp1xNuGSd9moWTuusQ
Message-ID: <CAC_iWjK24kQg1Oahs+JArjZuiPALVEjQfykRCT4ZTCmZnUK9ug@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mmc: Call back to optee after a successful mmc_init
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
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

On Wed, 9 Sept 2026 at 18:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 09.09.26 16:35, Jan Kiszka wrote:
> > On 09.09.26 13:46, Jan Kiszka wrote:
> >> On 09.09.26 12:04, Ilias Apalodimas wrote:
> >>> On Wed, 9 Sept 2026 at 12:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>>>
> >>>> On 09.09.26 09:50, Ilias Apalodimas wrote:
> >>>>> Hi Jan
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>> --- a/drivers/mmc/mmc.c
> >>>>>> +++ b/drivers/mmc/mmc.c
> >>>>>> @@ -27,6 +27,7 @@
> >>>>>>  #include <linux/list.h>
> >>>>>>  #include <linux/printk.h>
> >>>>>>  #include <div64.h>
> >>>>>> +#include <tee/optee.h>
> >>>>>>  #include "mmc_private.h"
> >>>>>>
> >>>>>>  #define DEFAULT_CMD6_TIMEOUT_MS  500
> >>>>>> @@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
> >>>>>>                                 mmc->cfg->name);
> >>>>>>         }
> >>>>>>
> >>>>>> +       if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
> >>>>>> +               optee_rpmb_available();
> >>>>>
> >>>>> With this we'll end up calling the optee bind methods again for
> >>>>> discovered devices calling bind_service_list(). I haven't tested this
> >>>>> locally yet, but is there any chance this ends up binding the devices
> >>>>> that depend on an RPMB twice?
> >>>>
> >>>> I don't think we will have an issue here: Either OP-TEE isn't ready yet,
> >>>> or RPMB wasn't yet when we called it first. So I do not see yet who
> >>>> actual successful listing could be done twice.
> >>>
> >>> The question is what happens if OP-TEE & the RPMB is ready and you
> >>> issue an mmc rescan. That will force optee_rpmb_available() to re-run
> >>> and rediscover all the devices no?
> >>
> >> Hmm, let me check...
> >>
> >
> > It's a problem. Is there a helper/service to check the binding state, or
> > should we track that via a static flag in optee_rpmb_available?
> >
>
> Didn't find anything, would go with something like this:


I am not sure if I am correct here but looking at the call path
optee_bind_services -> bind_service_list -> device_bind_driver_to_node
-> device_bind_with_driver_data.
The latter sets DM_FLAG_BOUND. I don't know the DM code too well
though to be 100% the flag is safe to use.
There's also DM_FLAG_ACTIVATED

Cheers
/Ilias
>
>
> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> index 7ae6045511b..bcad14a7251 100644
> --- a/drivers/tee/optee/rpmb.c
> +++ b/drivers/tee/optee/rpmb.c
> @@ -194,9 +194,14 @@ void optee_suppl_rpmb_release(struct udevice *dev)
>
>  void optee_rpmb_available(void)
>  {
> +       static bool rpmb_services_bound;
>         struct udevice *dev;
>         struct uclass *uc;
>         u32 tee_sess;
> +       int ret;
> +
> +       if (rpmb_services_bound)
> +               return;
>
>         uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
>                 if (strcmp(dev->driver->name, "optee") != 0 ||
> @@ -206,8 +211,13 @@ void optee_rpmb_available(void)
>                 if (optee_open_enum_session(dev, &tee_sess) != 0)
>                         continue;
>
> -               optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
> +               ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_RPMB);
>
>                 tee_close_session(dev, tee_sess);
> +
> +               if (!ret) {
> +                       rpmb_services_bound = true;
> +                       break;
> +               }
>         }
>  }
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
