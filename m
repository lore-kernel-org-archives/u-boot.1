Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB015C79FAD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 10:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B8BA406B0;
	Wed,  9 Sep 2026 10:05:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Waszemw7p0U; Wed,  9 Sep 2026 10:05:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E32D1406DD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788948333;
	b=TqrkFSupV8GzUij/bbxQ8oW9DHqNtyOpWWN+BqqM1VAGloSO1GSC6Na3NjqF4KmXTNF3
	 nnX7XAGNXvWWh3pZjc/VuXaPXb5Mwi/ePbzA7esF3AgWEXHAL4XoVXafRjwJttb7vILpw
	 zB/rYS4Pnh2qk7TIUTfCsDAwE51+StWr2qNVjw71Ls7ixR0XmtlwaLLflH8VI+UzpVELg
	 Ui0N1FWRRaG7b/cMYx3K5t8EL4rrZGi+Jc3k+dDLz9Nil7TAFTZQoxLvb6s4fwRnkVplW
	 /ZrrykxLzJ1lTOfQIS0sHrbW1L3Wiq2MsiLEQImv9wAvofNxvatMD9P//CHXGr3lgcw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788948333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UhnVDqwJggVd0JLraRkcAa/oZu7/zT6SDtbpejEIB9g=;
	b=Mta+lLtW2tZHSaZzNrViwELy0tqPJVOJOS6Bm3AgogbJOA4efto9mh5myH4IGh31b5n2
	 8xgZxAh6o3VH9inQ76Dy0hf8LLNA61Ujl/W4kGuhzyaRTa9K98L3A9cCR2JqdqsbKWHtz
	 YBKf8H5a3JzGh7H2hdNkCPcDsxEBXKqgD+79PnlATlBUujTBMR9b/MO4e3lc9sCN0RR+8
	 I2SoSH8NseqTUfjADzogI0mTn32S5POeOGS070/c24GD/DiOO5m6EJz5KnBp54Wp6kB4K
	 Dteix7105WTy/PHv/Trbot8n3/SjCDQK8INAI2TH8qWt/5cVOLEpH56mcdbsN29nl4Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788948333;
	bh=UhnVDqwJggVd0JLraRkcAa/oZu7/zT6SDtbpejEIB9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Up5d0QzLON+lC+nrfOIRfb0g0Fr4uAM+nB3ClWNLE9ZnAMuz4bZ3/wvmNSl9b9LVD
	 wslM0QOu6zsBpOyD4ObYe9JgpPnvF5YQnvoouL0jh7IC+rcNsnbdYJc0zzRENIEMap
	 1O0zqdnfYdQAZAzdrmBQnRpgdT7WkSbFGIsPwV+hccROaPxlhIwOkLKbL2ck2JzTk2
	 Do9USV5FeGNhKzksjALJnOBnVkr+EQw0fJGOFDvy28pBKqH8OtJppmM09xz7pcJDVZ
	 yOEUd5/DeBFIBFDcy6X5MkUbDG+Jzti4vPmYi+t7s2zWa+3QjiRf+h2+iVGSN+z8UE
	 kcsk12qHyMYUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E32D1406DD;
	Wed,  9 Sep 2026 10:05:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D79483AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 10:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9176400C2
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 10:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6mefQzTv8ew for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 10:05:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D260D40026
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788948331;
 b=Q9DPAEuqAE2nJT1H3Ly48EAtWj+ADl0M+RM6RG91BltvtvSeWkNZStt8donVaZCd7d1t
 VKWTrAOswmg82nc66CqlPeoDlqxM6JUZ0jrD3hDbMnQLf9cRUZ6iZrq3mCMrDveGqyOxu
 6ZNc3yMl2PFznkDxipnaPFt/7Rit8EnNA1yS2lvzEIvoSL8Ys7oZI+4tcuefmeYeaKGfQ
 rBkTjt2960ZPn3C8RdxWEaN3qFc4FOPY5wL7NRwb9TsT7jLCCsrJRp9wfuZNcScwtm/vR
 aaKSafoFZNpfiaxichO7yR4d1Tdpu/zk+QEKoDYqm5lASX5AySfeDp6ipocsYlEabog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788948331;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=UhnVDqwJggVd0JLraRkcAa/oZu7/zT6SDtbpejEIB9g=;
 b=or9m82xMuT6iFV0ADhf6bZfnNzuQcXeOlpirAflcuiY4ZtCYDNhV22RAgenWuL9tfdF6
 queaM/7emqK2PjscknXtStlR+Z4X0uj3m9zuLMpZ45/DMvAlXHY1EPbWP/k8WxzCTZ7/A
 sXDo1huKDf/uzvGAbnc62yV7JLTTbi1XcOWKKkfwIfBtIzLhIzXTL+1zy7RInz9TpDTLh
 I23TLJpLmQ07hZTQRoI94fRute+vsjRY8SDbmDtYfZ5FT1ZqQwnKuQUCQ8UR0Y8mrZBzK
 r2/D9DdkvnU0UBn8mJz47JU9+WJF86inX+vYF7iHc291YvV4m4OTMut4mJDFlrh37ig==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nQoNgMuu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=nQoNgMuu
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D260D40026
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 10:05:30 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-871c8a36fe3so62490927b3.1
 for <u-boot@lists.u-boot-project.org>; Wed, 09 Sep 2026 03:05:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788948329; cv=none;
 d=google.com; s=arc-20260327;
 b=s44wszob1yyH4/EkjV83JGJrNioElZ1jtZriya+bysR++1Fbhv3Wx/We1kAR5QTg6H
 g46Z1B0gntpuh8slIBIRkYuTyvjbs24kTh93BKUShvd2OTLQpx5yP6p9jekBLXttlBdE
 cOobEybtED902lgqzwAbYSKdlR2R5QYWz8KBu21GxnPOQUO7pasCXLv26aFRcXfj+lAR
 n/JjzN/ogWRiNU9lwf7OG9iR7b58GpvWFBuTxgDVgfUNISfg6nvk/VdUM2LlezlyG3om
 GWGX/TGZILIDEnyPlE6xh1nCw6S4h8ohuzN8oRdxElNFE4tT6B4bunu9Gq/dPHA950Dk
 kanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UhnVDqwJggVd0JLraRkcAa/oZu7/zT6SDtbpejEIB9g=;
 fh=SgX3lzKXsL5uOHPUteg8m8HKJkb5mKF9KCqOub2vpgM=;
 b=ITAgiVdrBhDR4eSt0R8BCREQDYCOVf6WsUyHj4mAlO0jJHmBgZzRFu2fWUO9A1YcSL
 CdAypZuk8i0eI0GU58gcV+fx7x1IGRcvGNNEJohJzzw64y3wFRQoZuArYRMfbLwAIcl5
 YPQrm3i1ua9H9pORP8zhW89zTxTCqkuDdDmoAS1RTZko1tBvMUqst23JCjbuxV0JMpgm
 JC22jmgnPpzFcZRiuRaTh1q82Nty3dCMqfSwOIG/0x/Zk2TJ8/IRNqnkYkIaGS/TNGQL
 AOeH9MBf9ihDGYNuOyjJNpYbTSUauaNpJENs+UtSQT660zjeWCZ8QdCANeJ6TSH7/+WX
 OuPA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788948329; x=1789553129;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UhnVDqwJggVd0JLraRkcAa/oZu7/zT6SDtbpejEIB9g=;
 b=nQoNgMuu6j7Cl2vm+66FHCLUuEo7XDvfpUcfvurVGWvKDM/Hty2ONo/Cv71+ZLecUF
 nKdNlaBXf27oV4XAMBV+o7eCswzIF3IGY3PkfXbZ1RlNKNscBi476Prv0L0otz5eLpXg
 xx0kF0GXxkk2tZssd1mfRteYQkORnqcVaBVjGBDm7U/LSFsAVPaMUx1HLxluabgfImE8
 NxJOzKOtOr1jwY+6h6nblj4YHfEwrP46zNDxxKUmIKZ/CffZiPxfBwZ4WNOq3FLGc70s
 Q+0HsK/nIkEj52DLVA58JYVLO9ioz/fzsA569z9ySw2Ez/yG9QiKNwwT/3IUHqbk5UgP
 jbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788948329; x=1789553129;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UhnVDqwJggVd0JLraRkcAa/oZu7/zT6SDtbpejEIB9g=;
 b=E4lFwNL++GZOHEVJskmyJ22COMIVTgvLDAc9fNmoK2mhwOyITnTLFtrl0I7tyda/m9
 99bUhhRMGeNh3DxARHFS0BNB2K1rJGGHT1zHqiQ0Ye2JCP51GhhkIqQyYXhDMfm1x2GT
 VQfyBUala+VoWemuX+n5fYzOsivmq4+Pa4+EcYrfsJ+y1OZuB3xrYhpZ4GmNsAptb53o
 THkswscqoO3LKm35owCj3G0b9imtz6n/mAg8M0pi0vmEg7CzpVjTi0jDH7z5QR9XmTVc
 wT3NZ51xlp52xdoUd1GxiV55N5aUctmvA43HqS5vcq44+lSYP+fz3XoEPifT+2mt6yOx
 ESPg==
X-Gm-Message-State: AFuF++nOVuAJEkP0qdrXYUl5heZlYxxIkJOUz/sr2o9fHnQ2XhmHyoq6
 bUnF6pgU536xvUcCP9WWyyA6c6gI4kj+ESVVKCFCHrQm2CtIM1LiDRIcJsWI4ZgdWPP/rPlfkyK
 2zo/c28s9XKxgdw5+ow1Zzr1tGWfmPYZegUWTzsi92g==
X-Gm-Gg: AYBFou2wZbCU/ruF8ySE66N7bPPtaicQt6McT8NVsLUMOmZbS1POzGMm691LZDX82xB
 0nGO0uXCi9Uhe78LoddudkYbCR0VjMmgTLe6dy5DsXm2J+nvIW1hwSSlvPmJOd1jvNBbG6UD7w+
 ZX+yFHvsxTmvPpVa4VOTZh+uKvE5LE3MxpR3HDybABDoK7MG1UuoVn6/AtsKQf6gRlHdnGSpuVq
 rIjkIr+x7viNpbRCgFQuIut32JuJzMC4drr9I9s2k+7Ss2PNXpn06Ejf+nPk+bJ5l0JdkpTUCSx
 ZWMCfQs+6rS/4PJbkkbLrROVuVT6ZXDoMRly0lSotbD6FvBBtq0BEWCeWqDEZJN2AFMIig5iAle
 YN8O3Qi3/kP7EcVVw3THtcWIE5NM7fzIgTrAdnb8/KuKuJ4osXfdje6/4TUHLJVW2nvGT0O4u4/
 1wDZI+7Txw5T2YszeAV29ieG0RzOZt9xS8le7sXO6zLGMfajnpdmsVOVhWw2SFrGUeb3AAc3sYM
 SBQtaH7GXVjIOjFt50Wj3+l+dFCXyPZRFVlrOp/3TCzKXd+Yhkv+MIJqvUfQPu2r3Z74RhPwG3l
 WfJeB6hRcXtD2V5mgFfdthiwrC1r2m0e355oOsM26yxlEMqGbWkRIvKnZUTghI4aDniDJg6Stc3
 Thz7s39drqAVxdqDl1ssHeQfUdqTt+A5tbwgDspXdt+hU9msA66xGQA==
X-Received: by 2002:a05:690c:c507:b0:873:17c9:afca with SMTP id
 00721157ae682-87317c9eb9cmr103822037b3.29.1788948329147; Wed, 09 Sep 2026
 03:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1788879818.git.jan.kiszka@siemens.com>
 <598cd2523e3b2a8b7a613468747fe740b1f35fbd.1788879818.git.jan.kiszka@siemens.com>
 <CAC_iWjL9fOYDdyfHRh+LHAeAh_AjNA6tajAFsjb59V6PccLwPg@mail.gmail.com>
 <f78cecea-5651-44b8-a817-18c084001354@siemens.com>
In-Reply-To: <f78cecea-5651-44b8-a817-18c084001354@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 9 Sep 2026 13:04:52 +0300
X-Gm-Features: AcwNN1XgvnmIZQcbEuAy0ZfYqfeYNvrY0lWfBATJF9q2AJT3Rt7e4TT0FhX_gUk
Message-ID: <CAC_iWjKsyfFQA+ASq4WQvQf1t2uKqsa0CTCdLvXP7MuuRuTYrw@mail.gmail.com>
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

On Wed, 9 Sept 2026 at 12:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 09.09.26 09:50, Ilias Apalodimas wrote:
> > Hi Jan
> >
> > [...]
> >
> >> --- a/drivers/mmc/mmc.c
> >> +++ b/drivers/mmc/mmc.c
> >> @@ -27,6 +27,7 @@
> >>  #include <linux/list.h>
> >>  #include <linux/printk.h>
> >>  #include <div64.h>
> >> +#include <tee/optee.h>
> >>  #include "mmc_private.h"
> >>
> >>  #define DEFAULT_CMD6_TIMEOUT_MS  500
> >> @@ -3168,6 +3169,9 @@ int mmc_init(struct mmc *mmc)
> >>                                 mmc->cfg->name);
> >>         }
> >>
> >> +       if (CONFIG_IS_ENABLED(OPTEE) && mmc->capacity_rpmb > 0)
> >> +               optee_rpmb_available();
> >
> > With this we'll end up calling the optee bind methods again for
> > discovered devices calling bind_service_list(). I haven't tested this
> > locally yet, but is there any chance this ends up binding the devices
> > that depend on an RPMB twice?
>
> I don't think we will have an issue here: Either OP-TEE isn't ready yet,
> or RPMB wasn't yet when we called it first. So I do not see yet who
> actual successful listing could be done twice.

The question is what happens if OP-TEE & the RPMB is ready and you
issue an mmc rescan. That will force optee_rpmb_available() to re-run
and rediscover all the devices no?

Thanks
/Ilias
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
