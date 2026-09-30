Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF69CA5FBE
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 10:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6BA740A31;
	Wed, 30 Sep 2026 10:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tJISL358IS6I; Wed, 30 Sep 2026 10:10:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 13D4540A39
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790763000;
	b=G2NAChusfsnHUGmXRXwL2nFYU1IvDdR+Jq9nXgIkTMPp3PuEbP6/9bO4vdwAi95UfeVQ
	 sHUQQZ5nFm9NHLKrRQHC207R7TlbEANS8RL6mw+SrRAHYapy4rk6JQlYbfuwQEYXobXgq
	 /cKsFCIJddqZrAAuioaH+MMYcIWsJscRqha+qkKB4a3wVeEibbbMDNiB7WKjCqyYscxrm
	 xcNjWY9Pq5xD1Pro+gj4PoZGSJiE36btr9y6f1JMvvQhdnwhyEyomoveapKmlPRt4RWQo
	 2Ut14jQ6WPcllx1MkdlaiyRnTJbeRpe2+p+ygHwwokqs6n4yw/Hv/7K/64IdKftIuUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790763000;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VicqlqzW/xO50neh2ajPndsDdCk7uB7R19hmt3BiHOs=;
	b=eLq+j/WfTZaz5HG/7BgekccQiGZkIUSOc759xPix2FCPwwGBtMm6dG41+nvIUvlQ2VH4
	 Tyln+mI4aJHScLjcl6OnODQhttFzKw+K/a3BHNXBLboZepy7m8Wrp6ad7VIAbV8ve9s5i
	 WKDjeTQHP/Va9fD9yE+6vX6qTjXNKMLLjs9Mdhep/BUT7lycwT1XrzZaDxqL0MrI48wlW
	 T/K6NLORrTIDf4Hips+p4QjwuvRyRPdENF1P4WDD9qO/AjyTPENazzwmCTPIPNw3ZWjTp
	 WAq/1JB2ltuDzMattmeFwqcHXl7scaBRfDh0zsqHCVUs+gZfInXnfI0eyPAxBde5KdA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790763000;
	bh=VicqlqzW/xO50neh2ajPndsDdCk7uB7R19hmt3BiHOs=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tHODr45dPnb8LAaeIEogwX26SbLZ+d0m7GJWBdi7cFQFnIOQmEtYa+H0v13hAS4Q1
	 CglVPUx9A4gVZ/dxwuv9HE3nPs+Z2zLvNNPr5KiBNCAH0UM68Z3MjzMIBLUDDhFlOQ
	 2AnHHbly9XitFizC37+rqWJWATcwbGJ6RU3jxLFYTOot/wj1NOKF8hipxyrdXDMrnO
	 cJudSeqrnvbFRI+ZAsVS3D9H1k2spzi33b2YE66+VMeq8CMtWyLG6RrjSJDJEmN6ph
	 RAVt0ZxS/bGK+GsEF0bCcApdW0rfZ+7GB3EIsOL9fmqKWG5HfvZyc76dDwZhGfi1+m
	 D1MlTiG1o0fWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13D4540A39;
	Wed, 30 Sep 2026 10:10:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DD7334E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:09:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F64D40389
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:09:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6q38EzFsq_7m for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 10:09:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DCC2140122
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790762997;
 b=KSeeNdNowE5d3AnUzjL0rf2UtPz1qcsI8Z5JqpBeJcZr2YmjYUogwWXEb19GJ6s+iHpb
 bteodUagkEMILpB+Ra433XwhLmrxYx+ayDkdMR57HK/cYKnYu+/BmChnRdJX8kSz6BhQx
 uA3NNrvwBXhk4+Xe9GLDv7ZWlGorUa69ALA6SBhdoqSPbRe4O7aWtS2HISyL3/UiHh3Wu
 O7/fYsbquqMet7Q2HwqYfRteNIlLtlMQ6nDwS2wWLdhfv9g/WaWhRtP9bxD8DeWO3K0ah
 Xe3EDH389hlXBJrSUlyATJqnOWlfH3a/wug6mbn7ksa8ZfzoCSY0jUIoxKOYUEoZs+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790762997;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=VicqlqzW/xO50neh2ajPndsDdCk7uB7R19hmt3BiHOs=;
 b=RWsrPsisUa6lNitsdVxx6I24r8b7AEVbB6uPj+khmIaj9JAogSWQGQRlr46Sy6EmKcDZ
 WYOl5bigWDsTBDQdLSbfI0wvl302nxrrRnOyZup0f9jtI+mLibVIbf2BHVn/oCt94MrC8
 KIFcW54vKIHYME+JOkXgJkW1JULCD1FpKGQaZ2HWTYuO53fYWw7AHi4XQg/5ZqobPqgjg
 gbHc9LlBykD3GDJtvboX70jfwmSyk7BXlWFb/4WMrPFLnBCBe9RWLQlAHG20hszCRwUJN
 b7No6QoMR9qC//4fwpsaydq8HAqYt7KWrvTEHFKHHk/nveesMtwv71iXEYqA61Fu4gA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wOvgzhkX; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wOvgzhkX
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DCC2140122
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:09:56 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912df756so40106165e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790762994; x=1791367794;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VicqlqzW/xO50neh2ajPndsDdCk7uB7R19hmt3BiHOs=;
 b=wOvgzhkXk6tUPio+9FzYYx+flqZIu92Ce5Nr5V8SpOk2DycRf5h1zkMBgnM0i0MSzr
 NvZSd7kQgL/mjiFxJlUrAbSAB740Gk6AQQp/jT8y/zUzuDxk0ctV6Blk+yAB+0JZ6FeX
 yIRDpE5AcjrGg5ThgDh2qyQl1hAVajHrGiyKAuDW7yUv+GM9mNuLz98yS1tJ+hvPTyzL
 hX/pHx/7vzJta/AX2nAyBYZsY0vaPFQz3VcF27CDZ6P0fcUAx1n6BAyVwhxNYgzQnxBw
 dGEiamGUVKqHzDYfMXjWB7YGbezhi96T39fSCfs6bvccvGn1qDyYR8O5ImUi0I1Qzj36
 OEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790762994; x=1791367794;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VicqlqzW/xO50neh2ajPndsDdCk7uB7R19hmt3BiHOs=;
 b=kZjHiFK0hdP8HevM3j7HmERVy0oEeJvTHD0Gce5juqvWILkWKxXnnxXjcaZ9J7VvrH
 PJpiO/bwE+xOEr2Etsseqe3ugNFQjy7KLLR9O6mKsi5+9Y6C0lAbsTl89ChBPBoEwrvi
 auq+dmkKzZdImCfFuyh92Hmnoyi7AYEzXPp889ShqnOvW221rK5C38xhP5KBC1ZRStaq
 vk8oNyJtqGk9/jU3ESzH6Dqhs9nUq//VYEStGgSLGNu489yFIZ9NraDVzyc0DW9rWck+
 wbqvnVgYPIaz0d0W+xsjYEtorv0dEodWXH3zy7iewbAi7bk0po7ALdZOiYDNTalmEeb3
 GS0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6tM+KZNoRN+K1dc0Yp3tDr3jYkt+jrEBP5x3rMK2vRNjJxPhTsM0Z7Q4drAjmLexP8LN/u7k=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nORf/n3nqzlfAi2e8B2/STJKbcrvhasiSYCfNH8dFhPotO9W5I
 zdh3Rr00uFHnI5PoH86WGhXUdxRmWv1MsqHX38HsFWEBmqMdYH9klM5OEBZAaSwIDT4=
X-Gm-Gg: AYBFou1xR5bOFo+MzHaqGcmomj7ToA7jPrwnOp2NkdpDXcgRodR8h49Pag9+uYJCw0+
 QXB1/AwEQUYyLouo+zDYiOXEDDDIymI3SU5aInf+NmRZJAwiEI+VxWzpBW7dRFrjqRWNPjAu7lY
 4k6UvYZLGMTqNXwYmuzbr9f9j9cGmCKJDka53kKSk+qCvIpmyD4mdSQO2SghZ/5uZXqerfi9le7
 GkdEQepxztdrkX3TNDnZeUQEoZ0YDoNcjT8Ak+2YPpbd5uDCZDALWvBPJS4d3IUkYtwi74CcbwZ
 HhramP5A2w5+Ykx3+phXsiTHX/i23widtJZMfekuiw0lc67nNdiNwLwBDUKrb/CD2ureVNvKHdA
 yejPpikqQEXHlRsfJaRKG/brhO2h8xto6jeQV2KhPk5gQlXDnlTpujrnow+denzlezForKk2wM7
 Gp27zLY4K4COXMyu/mdfvLv20bsamDzE0LNKbns75opybDYYJjhYvr/MAC2VvYzFcFvZYSAEen2
 oDkwskHrbs=
X-Received: by 2002:a05:600c:4f45:b0:4a0:194e:5bcf with SMTP id
 5b1f17b1804b1-4a01b1306bamr16158675e9.30.1790762993860; 
 Wed, 30 Sep 2026 03:09:53 -0700 (PDT)
Received: from [172.18.183.38] ([185.104.138.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174d886dsm50172185e9.1.2026.09.30.03.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 03:09:53 -0700 (PDT)
Message-ID: <4ecf664a-9f7d-43c7-b368-955bb0496f17@linaro.org>
Date: Wed, 30 Sep 2026 12:09:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] mach-snapdragon: Kconfig: fix duplicate
 SYS_MALLOC_LEN regression
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, Michael.Srba@seznam.cz,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20260930083339.351584-1-sumit.dhami@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260930083339.351584-1-sumit.dhami@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Sumit,

On 9/30/26 10:33, Sumit Singh Dhami wrote:
> A previous commit fixes a duplicate SYS_MALLOC_LEN Kconfig entry in
> "arch/arm/mach-snapdragon/Kconfig" but keeps the smaller default (0x800000)
> instead of the larger one (0x10000000), and drops the larger value.
> This causes fastboot to fail on large image transfers with error:
> "Malloc failed for: CHUNK_TYPE_RAW"
> 
> This series reverts that commit to restore the 0x10000000 default, then
> reapplies the duplicate-removal fix by removing the 0x800000 entry instead.

just send 1 patch to fix the size and add a Fixes: tag please.

> 
> Sumit Singh Dhami (2):
>    Revert "mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN"
>    mach-snapdragon: Kconfig: fix duplicate SYS_MALLOC_LEN
> 
>   arch/arm/mach-snapdragon/Kconfig | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

