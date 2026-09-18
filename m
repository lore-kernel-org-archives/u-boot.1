Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43C4C88E75
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 07:38:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61F8E60BE9;
	Fri, 18 Sep 2026 07:38:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qwTxuX8FbBaV; Fri, 18 Sep 2026 07:38:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7EF4960BCD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789717094;
	b=lTMksIndsEawiDCyMaawAQ9vXm+NXbzsC+Wl/+hE8I7gfXYYD70LrnG+GnzT9NC4UEYZ
	 mKwmt0ON/KtVr/vS0mXJbSn4HEJzmd+rY4YyCzVe5yCnQpzMW6BTxR0vdHPJovYAN/eFV
	 L/OZlNO59Yv00I92GuDpgV5e0zTMcnfxPIuuRKqCAEib8Q76yW4/w37D0lkFJRrm9lH6G
	 IgzeUYPd5Kj9Ablaw+WwVJyp9U7olxQNLE9cXq6UmM0qSSX9hfpsU3vJqDq9VfzUcb4Mg
	 AIvkTszbE/b/TEP0Rhe4NmBTfT0t4FpHjmJbscFqpIiqucbMEXGBtmjnQc3SGn1HFIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789717094;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mOM9iNYKqJIKgtWldzqF4pNMoATjjkoyNsPrpJs5Kww=;
	b=JyClVHfcoH/3nkGj8F9x1221wrXPQ0arJzTCCrU2JD5dMpsWb+mR3uLfkbHZyvhOuIbG
	 z0dVh02w5iUUOOLK4+7S57dni4Y5s5q6krNhM3B5jh3ISHBfqkKtqbU1xPNqD2oj11ZUt
	 xznQa8xf8pRXhtPAEvgbWq92ZSsrTlanjc+OZKeyYBRc59u1OAmbkc2sxn1yIFhjxhIRT
	 CD2Si6vP59fO8jubXL3ob3PnNHk2exVI6j+YTR3fYJ1urZgtc2Bf/PVGQCaBcHEuWhET7
	 5yxcEvUmqbvgFm55OYRIJJldZgXmkk5ytkm4g+zpn2WzA/aCgHMUUld7YlD1a6v8xlg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VXoeqjtq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789717094;
	bh=mOM9iNYKqJIKgtWldzqF4pNMoATjjkoyNsPrpJs5Kww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dOJGLvOIQVUIXd35G2CwNd6ktiXL0NYoTNI9qX/Ifhu30ZoJWAeKcchgB5fVDmU27
	 N4CS/Q4aFIQe5ivS5e39okIbSmyF2PNpnZa+r+oYrXiQy7Cw0OmjKfutUh3knIenzk
	 h7+nX1pa3Jy/PeEq7i5RE7uwWJiVj+Edzf5L4hFwMosTxOTGfZ5W3dSRO7ZkjxPqhb
	 VeA38Z9tCnkiMBKjTGno4MLjB4MxSz8BeHmrUCptg/UAjPg2YrtN/IyFourH2xyRC3
	 4r67nLcEDdeNOvAwK70TM/hLCnCPRV59gCl9ahv6yXWVwVO66ffBEKmsucm4f7sSJp
	 UAKeLQCugQy/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EF4960BCD;
	Fri, 18 Sep 2026 07:38:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 51A1237A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 07:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4314960BCD
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 07:38:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCpQL7AFcmvB for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 07:38:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2AB726085C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::17"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789717092;
 b=RK2v2UgWH6cIi3Y8Y3E1MiNY1ro2IysBFmxW9WTv6zQ5wXRaScML7QlGjXciT9XpEabf
 bIsaxNFV111fcO6smdv44wSx/Q4E8yvggX1d+urGlFfL0s7ExfUjZ2jHr9gDZcRKf/lG9
 cFP8z3ezNnyAtLMZ6rYBzNipGYQlT6rhwbRk9BXC5V5Uav77mbeGhcjrwKb11VsAlvi1w
 8YDLtRp4DdmiPQDlbp0ZfRGrL0a+lWzHNgSFErm278suBXeHRIVeLPaEWyUXsmd23sahi
 /KiF3do6s2rkJHNUfTJ3etHlzOlDWCwHu9cD5eqj5iYhGIWtk+jabjivHUfPS6kAuww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789717092;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=mOM9iNYKqJIKgtWldzqF4pNMoATjjkoyNsPrpJs5Kww=;
 b=POIsN5P8Xkfs0SiTqkDDoVIPq+uFJD/58/+frFdbnU+q0GFFfXrFkPScGD1bvGZ6MNUl
 fkPrGkOxC4tZ06e8tAERf2GS9gppH8sDtiZVUDntauIsKgczuGTtWEhD2QLFvqfFE1SR7
 tr4TWdj+WtJd0xJQJIDzb9loOkIw5GsOFCOswV0SPJvd+t3r4oX0Aacwy0K8fUZjLee6D
 H0y+Aso5kNDP0rK+18ddpNyyn5vnRx9Zb8tuBnciu+4CPF2AD9GXc4ekP3g0MZSFS9Kn5
 mOQyvRKrL+gOJnfF1NftHGysmp+m1uWMno2cLq5ev2jVAUxSdA+EsuApXnhE1ffB9eg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=VXoeqjtq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::17"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::17; helo=mail-yx2-x17.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=VXoeqjtq
Received: from mail-yx2-x17.google.com (mail-yx2-x17.google.com
 [IPv6:2607:f8b0:4864:41::17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2AB726085C
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 07:38:11 +0000 (UTC)
Received: by mail-yx2-x17.google.com with SMTP id
 956f58d0204a3-66e4ab19125so479734d50.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 00:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789717090; cv=none;
 d=google.com; s=arc-20260327;
 b=FiXwksgewOGb1mjZohXVIg82Ed+vHP/INBjjpCAhRHc/6LP2gdJiw4SFpXkV8oADxL
 fGVpvDID9j1klpCd2EeLIIPkMu8DGfzXyjX6hXKfXb7ulLS34uv+gz8J8Qrb2lnybG+k
 tSNaFKtnJlLH+aC85BzA4Q7J0cd+lb3FL97GCdLFM4nCW8NvPeroj6A2ISlFp+uX1oc6
 TzhJqwHEwITctUSf7y7FNLgMZqKSuLgQVihdqmxm5Ygcz+fQ6Zr6uCmL0Gg07eVX21b/
 Je0THPdN4IciElff3XEpFbp7LNIgwVZ7yFjB1WOOnDvON8vU3HZnEJzTo5+4uHzApKR5
 XDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mOM9iNYKqJIKgtWldzqF4pNMoATjjkoyNsPrpJs5Kww=;
 fh=KQL5YwTgfV9/IOdqoloi6vT10SPe5NFEdpKL8HprDOE=;
 b=l/a5hZgXvXQCwkcILbM3eKL9jF7KhzUkjXHI7gpwqZJuw35yVtNbReD1iUBOg1FEIT
 MYDmbUHyzNjZsMtRl6LMiPMa3vnPgfncADR7C/0vo6auJ5LYNjNZ7CpkaS5bhSe8fY9V
 i+tO0t8ktFS3DSe7FpzY78T6pnwgmSpCgX3uI2Sj51h+2tkPr90b2l38C617n7ietZY6
 A9DOk45rh4ZwcL+5d1mR+IMzGiBiRUPaSgpbg1e949a5SmGr4zGj5cYH0yVe8k4YEbUV
 mdPLzK/WtGcZSVNCwIbMjHchLy/dyfsuiao4Yz31Uyrvc0/KTceyG9EUCuiklh2ubKAz
 aoOQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789717090; x=1790321890;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mOM9iNYKqJIKgtWldzqF4pNMoATjjkoyNsPrpJs5Kww=;
 b=VXoeqjtqxua/K9bqFBElSsAi75wmP2F9FvCXIvXPjzWMu+1h/5GBeN5MIBjY5VzOvN
 diakq//RXLgrEQsHP8ZTC8Sy7ZbtOgn2Evr04sMiETbK+v7XuOHQJ9eIfQxnCj5Ti/1v
 //36cDk3aESwL+6BqQjbQh4LhMHVs3XdN8xPu8mymzPVmu4nbaxIzyo2pjsiNSeLI67J
 VYMyBlL2CeoSTQovQc1Tg8OLcFkmW51Na2ID6uXHlWjyeDs381oZYnUsl/6uW1qucDE8
 ChbVEjemnDfPIDtiQ7baTxGLcME1bcGRiUihVczZgirtNZs74k+c3hF7Hfc6GH5fFuz9
 1+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789717090; x=1790321890;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mOM9iNYKqJIKgtWldzqF4pNMoATjjkoyNsPrpJs5Kww=;
 b=MTIXe+yL0g2aLEpkp9gY3XK9Z5L5hgzUIdts1QvDMHhP8NtCWNgV87MP7aXvL4ri27
 1QAVp8YUos5UG5KB7ojxIZDzGGRTcEjMlqG6eCcxEmkn74wjQNjyQYZvJbS491O1+lpZ
 jI/ylYzL6xdXOcyUSAl1yaW6alyYdBV5JtcvudKxEcdUy5OVlFe+mjMh9npVR8z2nqeg
 FqEUPjaBaYHTvxC740kcbMdNZNNdngJToC8uJIT0jboPlb9xpNZoUi+IOLsN/ZtdgF15
 54QvVy5SNHfatYlJiJtb/6onnG7WNmVOdaKurCcgtIHSK+YPHN8Op3WXeS5N1gY/z6Cv
 owQg==
X-Gm-Message-State: AFuF++ny3ks25Ajx2H0Iai3hMqMvt4L838IAtnkUCZ1RlQIsYauLWsXB
 /surRq3rsmiqpnydHFZJjJb9dZzc+kElba9toa0sS4xifokL+n5EsDn/w1BXrqNUzGQT6WImFIH
 hJwSnH5QiNzCQEerzrP8qfurko3fwW8rQfEGZV8KnhQ==
X-Gm-Gg: AYBFou2kW4+tnPiud7ItTFVnaLjOTlowC/fzBnQtaxZivIL66RzC7tI0HW7bs5ZGLtq
 JmK55metVqt1UE8fKW9c5V1JrWJ+MNOwOmprfZ/8uRpdGpW5/AY5RKo2DUASCeMUETnuFrMTOIL
 DSdTKeAbTYc47KZZJ5aVZmtOw/bstDDjrP/TZb+qOhhDsOMQXf7u1Wyv6NmXxipFdS6YpVNX9lq
 Gy3KoxqRzffyimjV6qwgor66dr1gZV3eKMiPoQoAeeausPuhWrnqlaAaiaKp3HY23tB4VY5YG9u
 0P4TN4BWPRruIXvnQZirzdHAmM/4DWBkeIzvnkQcXg67onl8dNt6ODbffdHageaRcTh+PlkgpjI
 U+tJVOI6N5wHzFMK6ncxB4CBPkPSq/aJlwUrrtOnU8IRRqMAMknykO6uhV6GczvdOCqsNPZcqKe
 okUalJVBwYftnLueAPpUxd/9y7rKpqPl5LHAA+boqs9jLG+Cab/c9D1FhawkIb6HJm6pFE9vYCL
 7795kda1w3K+9vCQYSJ4N/9J8BodqBD6Ky4UA0oVzpSn8OpAcx9oHe4AwttBQx8pPEeM9WzaPJp
 k//cYvhpB0nL/09HunOaWPYBh2qfbjN/4QMxchSvTJ/wD/x6hkudue8H+ciFeLcXY9J7+kBOjEl
 2TP44kKIeDjtwZlo1GuuUsoKjHu0nzSh/8bZUYBVLs8GkGgKr6XGy2Ic=
X-Received: by 2002:a05:690e:140a:b0:66f:a87e:2fdb with SMTP id
 956f58d0204a3-6717fc649f2mr447225d50.8.1789717090349; Fri, 18 Sep 2026
 00:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789023381.git.jan.kiszka@siemens.com>
 <05f13f7b9b886c7ea0b826fae352a59cf07b63eb.1789023381.git.jan.kiszka@siemens.com>
 <CAC_iWjJEy9mp5OutQdN=A+_ewnLXWzPAYwxN+ipoHPAK_eG8gw@mail.gmail.com>
 <597738c7-4912-4fdf-a86e-956b392059ca@siemens.com>
 <CAC_iWjLJB6U+=VXs=cYG0z9YutGbscoB9xhcTfts3MvxV9NEsQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLJB6U+=VXs=cYG0z9YutGbscoB9xhcTfts3MvxV9NEsQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 18 Sep 2026 10:37:34 +0300
X-Gm-Features: AcwNN1UNx0ydzDqs0bYU_53kM_7MU1FQc8Py4wam89QivV2YXOHMjM-PilIWyMM
Message-ID: <CAC_iWjKuaA1y3F6ooqzjBNEg=jYS3+6QeSPM96xkDUSuOrnP7w@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] mmc: Call back to optee after a successful mmc_init
To: Jan Kiszka <jan.kiszka@siemens.com>, Peng Fan <peng.fan@nxp.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
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

Peng,

Since the mmc changes are minimal do you want me to carry them over on my tree?

Cheers
/Ilias

On Thu, 17 Sept 2026 at 15:35, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hey Jan
>
> On Thu, 17 Sept 2026 at 13:32, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
> > On 17.09.26 12:24, Ilias Apalodimas wrote:
> > > On Thu, 10 Sept 2026 at 08:56, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > >>
> > >> From: Jan Kiszka <jan.kiszka@siemens.com>
> > >>
> > >> This is needed to that OP-TEE can re-enumerate services which need RPMB
> > >> access that may have become available now.
> > >>
> > >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > >> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> > >> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> > >> ---
> > >> CC: Peng Fan <peng.fan@nxp.com>
> > >> CC: Jaehoon Chung <jh80.chung@samsung.com>
> > >> ---
> > >>  drivers/mmc/mmc.c | 4 ++++
> > >>  1 file changed, 4 insertions(+)
> > >>
> > >> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> > >> index 670e92ee12b..2463e50cd3c 100644
> > >> --- a/drivers/mmc/mmc.c
> > >> +++ b/drivers/mmc/mmc.c
> > >> @@ -27,6 +27,7 @@
> > >>  #include <linux/list.h>
> > >>  #include <linux/printk.h>
> > >>  #include <div64.h>
> > >> +#include <tee/optee.h>
> > >>  #include "mmc_private.h"
> > >>
> > >>  #define DEFAULT_CMD6_TIMEOUT_MS  500
> > >> @@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
> > >>                                 mmc->cfg->name);
> > >>         }
> > >>
> > >> +       if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
> > >
> > > This is only used in used in U-Boot proper right? We don't have
> > > SPL/TPL symbols for RPMB support, so IS_ENABLED() is better
> > >
> >
> > Can change that. Can send a v5, unless this is something that could be
> > fixed up on merge.
>
> I am goign through patch #3. If that's ok I can fix this up during the merge.
>
> >
> > For my understanding: Would that be for clarity purposes, or is there a
> > practical advantage of limiting the check?
>
> Clarity, CONFIG_IS_ENABLED() checks for both TPL/SPL symbols as well,
> but we dont have any of these in SPL.
>
> Cheers
> /Ilias
> >
> > Thanks,
> > Jan
> >
> > --
> > Siemens AG, Foundational Technologies
> > Linux Expert Center
